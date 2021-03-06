# frozen_string_literal: true

class PortfolioAggregator
  class Stock
    # Vanguard developed markets etf
    class Vea < Stock
      STOCK_SYMBOL = 'vea'
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
