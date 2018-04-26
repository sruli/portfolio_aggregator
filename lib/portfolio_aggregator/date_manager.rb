# frozen_string_literal: true

class PortfolioAggregator
  # Handles returning the next date that contains results
  class DateManager
    attr_reader :dates

    def self.string_to_time(time_str)
      Time.new(*time_str.split('-').map(&:to_i))
    end

    def initialize(start_date:, interval:, portfolio:)
      @start_date = self.class.string_to_time(start_date)
      @interval = interval
      @dates = portfolio.stocks.first.dates
    end

    def setup!
      @dates.delete_if { |date| self.class.string_to_time(date) < @start_date }
    end

    def fetch_next_date_str!
      @dates.shift
    end
  end
end
