# frozen_string_literal: true

class PortfolioAggregator
  class Stock
    # iShares Developed markets etf
    class Efa < Stock
      STOCK_SYMBOL = 'efa'
      PERCENTAGE = 0.15

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
