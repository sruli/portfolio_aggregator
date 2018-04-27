# frozen_string_literal: true

describe PortfolioAggregator do
  let(:start_date) { PortfolioAggregator::DEFAULT_START_DATE }
  let(:end_date) { PortfolioAggregator::DEFAULT_END_DATE }
  let(:portfolio_type) { PortfolioAggregator::Portfolio::CURRENT }
  subject(:portfolio_aggregator) do
    PortfolioAggregator.new(
      interval: interval,
      start_date: start_date,
      end_date: end_date,
      portfolio_type: portfolio_type
    )
  end

  describe '#aggregate' do
    context 'current portfolio' do
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

        it 'aggregates daily data' do
          portfolio_aggregator.aggregate
        end
      end
    end

    context 'long term portfolio' do
      let(:portfolio_type) { PortfolioAggregator::Portfolio::LONG_TERM }

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

        context 'since 2005-01' do
          let(:start_date) { '2005-01' }

          it 'aggregates data' do
            portfolio_aggregator.aggregate
          end
        end

        context 'since 2008-04' do
          let(:start_date) { '2008-04' }

          it 'aggregates data' do
            portfolio_aggregator.aggregate
          end
        end
      end

      context 'weekly' do
        let(:interval) { PortfolioAggregator::WEEKLY }

        context 'since 2005-01' do
          let(:start_date) { '2005-01' }

          it 'aggregates data' do
            portfolio_aggregator.aggregate
          end
        end
      end

      context 'daily' do
        let(:interval) { PortfolioAggregator::DAILY }

        context 'since 2005-01' do
          let(:start_date) { '2005-01' }

          it 'aggregates data' do
            portfolio_aggregator.aggregate
          end
        end
      end
    end

    context '2005-01 until 2011-12' do
      context 'monthly long term' do
        let(:interval) { PortfolioAggregator::MONTHLY }
        let(:portfolio_type) { PortfolioAggregator::Portfolio::LONG_TERM }
        let(:start_date) { '2005-01' }
        let(:end_date) { '2011-12' }

        it 'aggregates data' do
          portfolio_aggregator.aggregate
        end
      end
    end
  end
end
