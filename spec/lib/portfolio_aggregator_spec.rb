# frozen_string_literal: true

describe PortfolioAggregator do
  subject(:portfolio_aggregator) { PortfolioAggregator.new(interval: interval) }

  describe '#aggregate' do
    context 'monthly' do
      let(:interval) { PortfolioAggregator::MONTHLY }

      it 'aggregates monthly data' do
        VCR.use_cassette('portfolio_aggregator/monthly') do
          portfolio_aggregator.aggregate
        end
      end
    end

    context 'weekly' do
      let(:interval) { PortfolioAggregator::WEEKLY }

      it 'aggregates weekly data' do
        VCR.use_cassette('portfolio_aggregator/weekly') do
          portfolio_aggregator.aggregate
        end
      end
    end

    context 'daily' do
      let(:interval) { PortfolioAggregator::DAILY }

      it 'aggregates weekly data' do
        VCR.use_cassette('portfolio_aggregator/daily') do
          portfolio_aggregator.aggregate
        end
      end
    end
  end
end
