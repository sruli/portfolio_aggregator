# frozen_string_literal: true

class PortfolioAggregator
  module Calculator
    # Calculates the performance of a single stock. Based on an investment
    #   of $100_000 on the :from_date_str, the stock performance calculator
    #   will indicate how much the inveestment is worth on the :until_date_str.
    class StockPerformance
      def initialize(stock:, from_date_str:, until_date_str:)
        @stock = stock
        @date_manager = PortfolioAggregator::DateManager.new(
          start_date: from_date_str,
          end_date: until_date_str
        )
      end

      def calculate
        @date_manager.setup!
        initial_value = @stock.current_price(@date_manager.dates.first)
        current_value = @stock.current_price(@date_manager.dates.last)
        number_of_shares = (100_000 / initial_value).round
        (current_value * number_of_shares).to_f
      end
    end
  end
end
