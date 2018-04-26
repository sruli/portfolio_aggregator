# frozen_string_literal: true

describe PortfolioAggregator::Portfolio do
  let(:interval) { PortfolioAggregator::MONTHLY }
  subject(:portfolio) do
    PortfolioAggregator::Portfolio.new(portfolio_type: portfolio_type, interval: interval)
  end

  describe '#stocks' do
    describe 'current' do
      let(:portfolio_type) { PortfolioAggregator::Portfolio::Types::CURRENT }

      it 'returns six stocks' do
        expect(portfolio.stocks.size).to eq(6)
      end

      it 'returns instance of voo' do
        expect(portfolio.stocks).to include(instance_of(PortfolioAggregator::Stock::Voo))
      end

      it 'returns instance of  vea' do
        expect(portfolio.stocks).to include(instance_of(PortfolioAggregator::Stock::Vea))
      end

      it 'returns instance of vwo' do
        expect(portfolio.stocks).to include(instance_of(PortfolioAggregator::Stock::Vwo))
      end

      it 'returns instance of vnq' do
        expect(portfolio.stocks).to include(instance_of(PortfolioAggregator::Stock::Vnq))
      end

      it 'returns instance of ief' do
        expect(portfolio.stocks).to include(instance_of(PortfolioAggregator::Stock::Ief))
      end

      it 'returns instance of vtip' do
        expect(portfolio.stocks).to include(instance_of(PortfolioAggregator::Stock::Vtip))
      end
    end

    describe 'long_term' do
      let(:portfolio_type) { PortfolioAggregator::Portfolio::Types::LONG_TERM }

      it 'returns six stocks' do
        expect(portfolio.stocks.size).to eq(6)
      end

      it 'returns instance of spy' do
        expect(portfolio.stocks).to include(instance_of(PortfolioAggregator::Stock::Spy))
      end

      it 'returns instance of efa' do
        expect(portfolio.stocks).to include(instance_of(PortfolioAggregator::Stock::Efa))
      end

      it 'returns instance of eem' do
        expect(portfolio.stocks).to include(instance_of(PortfolioAggregator::Stock::Eem))
      end

      it 'returns instance of iyr' do
        expect(portfolio.stocks).to include(instance_of(PortfolioAggregator::Stock::Iyr))
      end

      it 'returns instance of ief' do
        expect(portfolio.stocks).to include(instance_of(PortfolioAggregator::Stock::Ief))
      end

      it 'returns instance of tip' do
        expect(portfolio.stocks).to include(instance_of(PortfolioAggregator::Stock::Tip))
      end
    end
  end
end
