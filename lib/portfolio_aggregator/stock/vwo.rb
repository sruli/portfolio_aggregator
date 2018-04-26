# frozen_string_literal: true

class PortfolioAggregator
  class Stock
    # Vanguard emerging markets etf
    class Vwo < Stock
      STOCK_SYMBOL = 'vwo'
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
