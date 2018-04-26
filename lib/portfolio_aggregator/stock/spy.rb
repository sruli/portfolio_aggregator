# frozen_string_literal: true

class PortfolioAggregator
  class Stock
    # iShares S&P etf
    class Spy < Stock
      STOCK_SYMBOL = 'spy'
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
