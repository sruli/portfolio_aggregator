# frozen_string_literal: true

class PortfolioAggregator
  class Stock
    class Reits < Stock
      STOCK_SYMBOL = 'vnq'
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
