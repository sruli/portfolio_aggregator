# frozen_string_literal: true

class PortfolioAggregator
  class Stock
    # iShares REITS etf
    class Iyr < Stock
      STOCK_SYMBOL = 'iyr'
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
