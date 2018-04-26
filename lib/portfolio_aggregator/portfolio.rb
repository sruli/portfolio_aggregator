# frozen_string_literal: true

class PortfolioAggregator
  # Represents different portfolios that the aggregator can aggregate
  #   Current possibilities:
  #   :current
  #     - represents current portfolio
  #   :long_term
  #     - adjustments to current portfolio, switching current etfs that
  #       do not have historical data far enough back
  class Portfolio
    module Types
      CURRENT = :current
      LONG_TERM = :long_term
    end

    PORTFOLIOS = {
      Types::CURRENT => [
        PortfolioAggregator::Stock::Voo,
        PortfolioAggregator::Stock::Vea,
        PortfolioAggregator::Stock::Vwo,
        PortfolioAggregator::Stock::Vnq,
        PortfolioAggregator::Stock::Ief,
        PortfolioAggregator::Stock::Vtip
      ],
      Types::LONG_TERM => [
        PortfolioAggregator::Stock::Spy,
        PortfolioAggregator::Stock::Efa,
        PortfolioAggregator::Stock::Eem,
        PortfolioAggregator::Stock::Iyr,
        PortfolioAggregator::Stock::Ief,
        PortfolioAggregator::Stock::Tip
      ]
    }.freeze

    def initialize(portfolio_type:, interval:)
      @portfolio_type = portfolio_type
      @interval = interval
    end

    def stocks
      @stocks ||= PORTFOLIOS[@portfolio_type].map do |portfolio|
        portfolio.new(interval: @interval)
      end
    end
  end
end
