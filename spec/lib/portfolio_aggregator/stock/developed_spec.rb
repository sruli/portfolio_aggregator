# frozen_string_literal: true

describe PortfolioAggregator::Stock::Developed do
  let(:interval) { PortfolioAggregator::MONTHLY }
  subject(:stock) { PortfolioAggregator::Stock::Developed.new(interval: interval) }

  it 'inherits from PortfolioAggregator::Stock' do
    expect(stock.class).to be < PortfolioAggregator::Stock
  end
end
