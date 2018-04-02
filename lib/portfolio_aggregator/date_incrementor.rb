# frozen_string_literal: true

class PortfolioAggregator
  # Increments the date to be used in getting stock data for that date.
  #   Optional parameters are start_date and interval
  #   By default these default to March 2017 and monthly, respectively.
  class DateIncrementor
    def initialize(interval:)
      @interval = interval
    end

    # TODO: validate date format
    def increment(date_str)
      case @interval
      when PortfolioAggregator::MONTHLY
        increment_month(date_str)
      end
    end

    private

    def increment_month(date_str)
      year, month = date_str.split('-').map(&:to_i)
      month += 1
      if month == 13
        year += 1
        month = 1
      end
      "#{year}-#{month.to_s.rjust(2, '0')}"
    end
  end
end
