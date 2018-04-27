# frozen_string_literal: true

describe PortfolioAggregator::DateManager do
  let(:start_date) { PortfolioAggregator::DEFAULT_START_DATE }
  let(:end_date) { PortfolioAggregator::DEFAULT_END_DATE }
  let(:interval) { PortfolioAggregator::MONTHLY }
  subject(:date_manager) do
    PortfolioAggregator::DateManager.new(
      start_date: start_date,
      end_date: end_date,
      interval: interval
    )
  end

  describe '.string_to_time' do
    it 'converts a time string to a time object' do
      time_str = '2018-04-04'
      time_obj = PortfolioAggregator::DateManager.string_to_time(time_str)
      expect(time_obj.year).to eq(2018)
      expect(time_obj.month).to eq(4)
      expect(time_obj.day).to eq(4)
    end
  end

  describe '#setup!' do
    it 'sets up a collection of dates starting with the start date' do
      date_manager.setup!
      first_time = PortfolioAggregator::DateManager.string_to_time(date_manager.dates.first)
      start_time = PortfolioAggregator::DateManager.string_to_time(start_date)
      expect(first_time).to be >= start_time
    end

    context 'when an end date is specified' do
      let(:end_date) { '2018-01' }

      it 'sets up a collection of dates ending with the end date' do
        date_manager.setup!
        last_time = PortfolioAggregator::DateManager.string_to_time(date_manager.dates.last)
        end_time = PortfolioAggregator::DateManager.string_to_time(end_date)
        expect(last_time).to be <= end_time
      end
    end
  end

  describe '#fetch_next_date_str!' do
    before(:each) { date_manager.setup! }

    it 'returns the next date' do
      next_date = date_manager.fetch_next_date_str!
      expect(next_date).to start_with(start_date)
    end

    it 'removes the next date from the dates collection' do
      next_date = date_manager.fetch_next_date_str!
      expect(date_manager.dates.any? { |date| date.start_with?(next_date) }).to be false
    end
  end
end
