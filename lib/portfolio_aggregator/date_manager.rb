# frozen_string_literal: true

class PortfolioAggregator
  # TODO: class comment
  class DateManager
    attr_reader :dates

    def self.string_to_time(time_str)
      Time.new(*time_str.split('-').map(&:to_i))
    end

    def initialize(start_date:, interval:)
      @start_date = self.class.string_to_time(start_date)
      @interval = interval
      @dates = []
    end

    # Takes a random stock in order to get it's date entries and
    #   assumes that all stocks will have the same date entries
    def setup!
      stock = PortfolioAggregator::Stock::Sp.new(interval: @interval)
      @dates += stock.historical_data.keys.reverse
      @dates.delete_if { |date| self.class.string_to_time(date) < @start_date }
    end

    def fetch_next_date_str!
      @dates.shift
    end
  end
end
