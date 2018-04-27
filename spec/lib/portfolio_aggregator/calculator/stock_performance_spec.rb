# frozen_string_literal: true

describe PortfolioAggregator::Calculator::StockPerformance do
  let(:stock) { PortfolioAggregator::Stock::Spy.new(interval: PortfolioAggregator::MONTHLY) }
  let(:from_date_str) { '2010-01' }
  let(:until_date_str) { '2015-01' }
  subject(:calculator) do
    PortfolioAggregator::Calculator::StockPerformance.new(
      stock: stock,
      from_date_str: from_date_str,
      until_date_str: until_date_str
    )
  end

  describe '#calculate' do
    it 'calculates the current value of the investment' do
      expect(calculator.calculate).to eq(211_847.79)
    end
  end
end
