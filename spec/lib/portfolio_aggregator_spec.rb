# frozen_string_literal: true

describe PortfolioAggregator do
  let(:start_date) { PortfolioAggregator::DEFAULT_START_DATE }
  subject(:portfolio_aggregator) do
    PortfolioAggregator.new(interval: interval, start_date: start_date)
  end

  describe '#aggregate' do
    context 'monthly' do
      let(:interval) { PortfolioAggregator::MONTHLY }

      it 'aggregates monthly data' do
        portfolio_aggregator.aggregate
      end

      context 'since 2012-11' do
        let(:start_date) { '2012-11' }

        it 'aggregates data' do
          portfolio_aggregator.aggregate
        end
      end
    end

    context 'weekly' do
      let(:interval) { PortfolioAggregator::WEEKLY }

      it 'aggregates weekly data' do
        portfolio_aggregator.aggregate
      end
    end

    context 'daily' do
      let(:interval) { PortfolioAggregator::DAILY }

      it 'aggregates weekly data' do
        portfolio_aggregator.aggregate
      end
    end
  end
end
