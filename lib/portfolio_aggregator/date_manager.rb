# frozen_string_literal: true

class PortfolioAggregator
  # Handles returning the next date that contains results
  class DateManager
    attr_reader :dates

    def self.string_to_time(time_str)
      Time.new(*time_str.split('-').map(&:to_i))
    end

    def initialize(
      start_date:,
      end_date:,
      interval: PortfolioAggregator::MONTHLY
    )
      @start_date = self.class.string_to_time(start_date)
      @end_date = self.class.string_to_time(end_date)
      # retrieve dates from Spy since it has the most dates
      @dates = PortfolioAggregator::Stock::Spy.new(interval: interval).dates
    end

    def setup!
      @dates.delete_if do |date|
        time = self.class.string_to_time(date)
        time < @start_date || time > @end_date
      end
    end

    def fetch_next_date_str!
      @dates.shift
    end
  end
end
