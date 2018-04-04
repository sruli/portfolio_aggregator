# frozen_string_literal: true

require 'faraday'
require 'faraday_middleware'
require_relative 'portfolio_aggregator/stock'
require_relative 'portfolio_aggregator'
require_relative 'portfolio_aggregator/api'
require_relative 'portfolio_aggregator/date_manager'
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
    WEEKLY = :weekly,
    DAILY = :daily
  ].freeze

  def initialize(interval: MONTHLY) # rubocop:disable MethodLength
    @portfolio = [
      PortfolioAggregator::Stock::Sp.new(interval: interval),
      PortfolioAggregator::Stock::Developed.new(interval: interval),
      PortfolioAggregator::Stock::Emerging.new(interval: interval),
      PortfolioAggregator::Stock::Reits.new(interval: interval),
      PortfolioAggregator::Stock::Treasury.new(interval: interval),
      PortfolioAggregator::Stock::Vtip.new(interval: interval)
    ]
    @date_manager = PortfolioAggregator::DateManager.new(
      start_date: DEFAULT_START_DATE,
      interval: interval
    )
  end

  def aggregate # rubocop:disable MethodLength
    @date_manager.setup!
    date_str = @date_manager.fetch_next_date_str!
    invested = 0
    cash = DEFAULT_START_AMOUNT

    loop do
      # TODO: @portfolio.map { |stock| stock.set_current_price!(date_str) }
      invested = @portfolio.map { |stock| stock.total_invested(date_str) }.sum
      total_value = invested + cash
      sellers, buyers = @portfolio.partition do |stock|
        stock.above_threshold?(total_value, date_str)
      end

      sellers.each { |stock| cash = stock.sell!(total_value, cash, date_str) }
      buyers.each { |stock| cash = stock.buy!(total_value, cash, date_str) }

      next_date_str = @date_manager.fetch_next_date_str!
      break if next_date_str.nil?

      date_str = next_date_str
    end

    invested = @portfolio.map { |stock| stock.total_invested(date_str) }.sum
    puts "Current account value is #{invested + cash}"
  end
end
