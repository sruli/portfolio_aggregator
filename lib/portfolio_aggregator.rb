# frozen_string_literal: true

require 'faraday'
require 'faraday_middleware'
require_relative 'portfolio_aggregator/stock'
require_relative 'portfolio_aggregator'
require_relative 'portfolio_aggregator/api'
require_relative 'portfolio_aggregator/date_incrementor'
require_relative 'portfolio_aggregator/stock'
require_relative 'portfolio_aggregator/stock/developed'
require_relative 'portfolio_aggregator/stock/emerging'
require_relative 'portfolio_aggregator/stock/reits'
require_relative 'portfolio_aggregator/stock/sp'
require_relative 'portfolio_aggregator/stock/treasury'
require_relative 'portfolio_aggregator/stock/vtip'

# Main API for aggregating your portfolio.
#   Usage: Call PortfolioAggregator.new.aggregate to
#   receive the aggregate value of the portfolio
class PortfolioAggregator
  DEFAULT_START_DATE = '2017-03'
  DEFAULT_START_AMOUNT = 100_000
  INTERVALS = [
    MONTHLY = :monthly,
    DAILY = :daily
  ].freeze

  def initialize(interval: MONTHLY)
    @interval = interval
    @portfolio = [
      PortfolioAggregator::Stock::Sp.new(interval: interval),
      PortfolioAggregator::Stock::Developed.new(interval: interval),
      PortfolioAggregator::Stock::Emerging.new(interval: interval),
      PortfolioAggregator::Stock::Reits.new(interval: interval),
      PortfolioAggregator::Stock::Treasury.new(interval: interval),
      PortfolioAggregator::Stock::Vtip.new(interval: interval)
    ]
  end

  def aggregate # rubocop:disable Metrics/MethodLength
    date_str = DEFAULT_START_DATE
    incrementor = PortfolioAggregator::DateIncrementor.new(interval: @interval)
    invested = 0
    cash = DEFAULT_START_AMOUNT

    loop do
      invested = @portfolio.map { |stock| stock.total_invested(date_str) }.sum
      total_value = invested + cash
      sellers, buyers = @portfolio.partition do |stock|
        stock.above_threshold?(total_value, date_str)
      end

      sellers.each { |stock| cash = stock.sell!(total_value, cash, date_str) }
      buyers.each { |stock| cash = stock.buy!(total_value, cash, date_str) }

      next_date_str = incrementor.increment(date_str)
      break unless more_entries_after_date?(next_date_str)

      date_str = next_date_str
    end

    invested = @portfolio.map { |stock| stock.total_invested(date_str) }.sum
    puts "Current account value is #{invested + cash}"
  end

  private

  def more_entries_after_date?(date_str)
    @portfolio.all? { |stock| stock.more_entries_after_date?(date_str) }
  end
end
