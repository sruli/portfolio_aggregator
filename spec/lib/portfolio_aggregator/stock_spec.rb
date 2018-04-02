# frozen_string_literal: true

describe PortfolioAggregator::Stock do
  let(:stock_symbol) { PortfolioAggregator::Stock::Emerging::STOCK_SYMBOL }
  let(:percentage) { PortfolioAggregator::Stock::Emerging::PERCENTAGE }
  let(:interval) { PortfolioAggregator::MONTHLY }
  let(:date_str) { '2018-01' }

  subject(:stock) do
    PortfolioAggregator::Stock.new(
      stock_symbol: stock_symbol,
      percentage: percentage,
      interval: interval
    )
  end

  describe '#current_price' do
    it 'returns the current price' do
      VCR.use_cassette('portfolio_aggregator/stock/emerging/current_price') do
        expect(stock.current_price(date_str)).to be_a(Numeric)
      end
    end
  end

  describe '#total_invested' do
    it 'returns the stock\'s current invested value' do
      stock.current_number_of_shares = 5
      allow_any_instance_of(PortfolioAggregator::Stock).to receive(:current_price).and_return(5)
      expect(stock.total_invested(date_str)).to eq(25)
    end
  end

  describe '#above_threshold?' do
    let(:percentage) { 0.1 }
    let(:total_value) { 100 }
    let(:date_str) { 'STUBBED' }

    context 'when current invested value exceeds the predetermined percentage of the portfolio' do
      it 'returns true' do
        stock.current_number_of_shares = 5
        allow_any_instance_of(PortfolioAggregator::Stock).to receive(:current_price).and_return(3)
        expect(stock.above_threshold?(total_value, date_str)).to be true
      end
    end

    context 'when current invested value is below the predetermined percentage of the portfolio' do
      it 'returns false' do
        stock.current_number_of_shares = 5
        allow_any_instance_of(PortfolioAggregator::Stock).to receive(:current_price).and_return(1)
        expect(stock.above_threshold?(total_value, date_str)).to be false
      end
    end
  end

  describe '#buy!' do
    let(:percentage) { 0.1 }
    let(:total_value) { 100 }
    let(:cash) { 5 }
    let(:date_str) { 'STUBBED' }

    before(:each) do
      allow_any_instance_of(PortfolioAggregator::Stock).to receive(:current_price).and_return(1)
    end

    it 'buys more stock' do
      stock.current_number_of_shares = 5
      stock.buy!(total_value, cash, date_str)
      expect(stock.current_number_of_shares).to eq(10)
    end

    it 'returns the amount of cash currently available' do
      stock.current_number_of_shares = 8
      expect(stock.buy!(total_value, cash, date_str)).to eq(3)
    end

    context 'when there is not enough cash' do
      let(:cash) { 0 }

      it 'raises an error' do
        expect { stock.buy!(total_value, cash, date_str) }.to raise_error(RuntimeError)
      end
    end

    context 'when the current invested amount is already above the threshold' do
      it 'raises an error' do
        stock.current_number_of_shares = 20
        expect { stock.buy!(total_value, cash, date_str) }.to raise_error(RuntimeError)
      end
    end
  end

  describe '#sell!' do
    let(:percentage) { 0.1 }
    let(:total_value) { 100 }
    let(:cash) { 5 }
    let(:date_str) { 'STUBBED' }

    before(:each) do
      allow_any_instance_of(PortfolioAggregator::Stock).to receive(:current_price).and_return(1)
    end

    it 'sells stock' do
      stock.current_number_of_shares = 15
      stock.sell!(total_value, cash, date_str)
      expect(stock.current_number_of_shares).to eq(10)
    end

    it 'returns the amount of cash currently available' do
      stock.current_number_of_shares = 15
      expect(stock.sell!(total_value, cash, date_str)).to eq(10)
    end

    context 'when the current invested amount is below the threshold' do
      it 'raises an error' do
        stock.current_number_of_shares = 5
        expect { stock.sell!(total_value, cash, date_str) }.to raise_error(RuntimeError)
      end
    end
  end

  describe '#more_entries_after_date?' do
    context 'when date supplied is earlier than latest date' do
      it 'should return true' do
        VCR.use_cassette('portfolio_aggregator/stock/emerging/monthly') do
          expect(stock.more_entries_after_date?('1900-01')).to be true
        end
      end
    end

    context 'when date supplied is later than latest date' do
      it 'should return false' do
        VCR.use_cassette('portfolio_aggregator/stock/emerging/monthly') do
          expect(stock.more_entries_after_date?('2100-01')).to be false
        end
      end
    end
  end
end
