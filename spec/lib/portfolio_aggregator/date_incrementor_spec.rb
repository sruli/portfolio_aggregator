# frozen_string_literal: true

describe PortfolioAggregator::DateIncrementor do
  context '#increment' do
    context 'monthly' do
      let(:interval) { PortfolioAggregator::MONTHLY }
      let(:date_str) { '2018-04' }
      subject(:date_incrementor) { PortfolioAggregator::DateIncrementor.new(interval: interval) }

      it 'increments by one month' do
        next_date_str = date_incrementor.increment(date_str)
        expect(next_date_str).to eq('2018-05')
      end

      context 'when current month is 12' do
        let(:date_str) { '2017-12' }

        it 'bumps up the year and set the month to 01' do
          next_date_str = date_incrementor.increment(date_str)
          expect(next_date_str).to eq('2018-01')
        end
      end
    end
  end
end
