# frozen_string_literal: true

class PortfolioAggregator
  class Stock
    # iShares Emerging markets etf
    class Eem < Stock
      STOCK_SYMBOL = 'eem'
      PERCENTAGE = 0.1

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
