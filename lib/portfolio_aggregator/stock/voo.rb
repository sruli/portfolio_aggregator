# frozen_string_literal: true

class PortfolioAggregator
  class Stock
    # Vanguard S&P etf
    class Voo < Stock
      STOCK_SYMBOL = 'voo'
      PERCENTAGE = 0.3

      def initialize(interval:)
        super(
          stock_symbol: STOCK_SYMBOL,
          percentage: PERCENTAGE,
          interval: interval
        )
      end
    end
  end
end
