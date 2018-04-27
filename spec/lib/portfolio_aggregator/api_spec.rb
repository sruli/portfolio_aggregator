# frozen_string_literal: true

describe PortfolioAggregator::Api do
  let(:stock_symbol) { PortfolioAggregator::Stock::Vwo::STOCK_SYMBOL }
  subject(:api) { PortfolioAggregator::Api.new(stock_symbol: stock_symbol) }

  describe '#monthly' do
    it 'responds with monthly data' do
      VCR.use_cassette('portfolio_aggregator/api/emerging/monthly') do
        response = api.monthly
        expect(response).to have_key('Monthly Adjusted Time Series')
      end
    end
  end

  describe '#weekly' do
    it 'responds with weekly data' do
      VCR.use_cassette('portfolio_aggregator/api/emerging/weekly') do
        response = api.weekly
        expect(response).to have_key('Weekly Adjusted Time Series')
      end
    end
  end

  describe '#daily' do
    it 'responds with daily data' do
      VCR.use_cassette('portfolio_aggregator/api/emerging/daily') do
        response = api.daily
        expect(response).to have_key('Time Series (Daily)')
      end
    end
  end

#   describe 'saving the data in files' do
#     let(:stock_symbol) { 'vwo' }
#     it 'saves data in files' do
#       response = api.daily
#       pathname = File.join(
#         File.dirname(__FILE__),
#         "../../../fixtures/daily/#{stock_symbol}.json"
#       )
#       File.open(pathname, 'w') do |f|
#         f.puts JSON.pretty_generate(response)
#       end
#     end
#   end
end
