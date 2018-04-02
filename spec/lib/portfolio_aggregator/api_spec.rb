# frozen_string_literal: true

describe PortfolioAggregator::Api do
  let(:stock_symbol) { PortfolioAggregator::Stock::Emerging::STOCK_SYMBOL }
  subject(:api) { PortfolioAggregator::Api.new(stock_symbol: stock_symbol) }

  describe '#monthly' do
    it 'responds with monthly data' do
      VCR.use_cassette('portfolio_aggregator/api/emerging/monthly') do
        response = PortfolioAggregator::Api.new(stock_symbol: 'voo').monthly
        expect(response).to have_key('Monthly Time Series')
      end
    end
  end
end
