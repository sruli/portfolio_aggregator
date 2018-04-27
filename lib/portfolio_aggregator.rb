# frozen_string_literal: true

require 'faraday'
require 'faraday_middleware'
require_relative 'portfolio_aggregator'
require_relative 'portfolio_aggregator/api'
require_relative 'portfolio_aggregator/date_manager'
require_relative 'portfolio_aggregator/portfolio'
require_relative 'portfolio_aggregator/stock'
require_relative 'portfolio_aggregator/stock/eem'
require_relative 'portfolio_aggregator/stock/efa'
require_relative 'portfolio_aggregator/stock/ief'
require_relative 'portfolio_aggregator/stock/iyr'
require_relative 'portfolio_aggregator/stock/spy'
require_relative 'portfolio_aggregator/stock/tip'
require_relative 'portfolio_aggregator/stock/vea'
require_relative 'portfolio_aggregator/stock/vnq'
require_relative 'portfolio_aggregator/stock/voo'
require_relative 'portfolio_aggregator/stock/vtip'
require_relative 'portfolio_aggregator/stock/vwo'

# Main API for aggregating your portfolio.
#   Usage: Call PortfolioAggregator.new.aggregate to
#   receive the aggregate value of the portfolio
class PortfolioAggregator
  DEFAULT_START_DATE = '2017-03'
  DEFAULT_START_AMOUNT = 100_000
  DEFAULT_PORTFOLIO_TYPE = PortfolioAggregator::Portfolio::CURRENT
  INTERVALS = [
    MONTHLY = :monthly,
    WEEKLY = :weekly,
    DAILY = :daily
  ].freeze

  def initialize(
    interval: MONTHLY,
    portfolio_type: DEFAULT_PORTFOLIO_TYPE,
    start_date: DEFAULT_START_DATE
  )
    @interval = interval
    @portfolio = PortfolioAggregator::Portfolio.new(
      portfolio_type: portfolio_type,
      interval: interval
    )
    @date_manager = PortfolioAggregator::DateManager.new(
      start_date: start_date,
      interval: interval,
      portfolio: @portfolio
    )
  end

  def aggregate # rubocop:disable MethodLength
    @date_manager.setup!
    stocks = @portfolio.stocks
    date_str = @date_manager.fetch_next_date_str!
    invested = 0
    cash = DEFAULT_START_AMOUNT

    loop do
      invested = stocks.map { |stock| stock.total_invested(date_str) }.sum
      total_value = invested + cash
      sellers, buyers = stocks.partition do |stock|
        stock.above_threshold?(total_value, date_str)
      end

      sellers.each { |stock| cash = stock.sell!(total_value, cash, date_str) }
      buyers.each { |stock| cash = stock.buy!(total_value, cash, date_str) }

      next_date_str = @date_manager.fetch_next_date_str!
      if next_date_str && PortfolioAggregator::DateManager.string_to_time(date_str).year != PortfolioAggregator::DateManager.string_to_time(next_date_str).year
        p "#{date_str}: #{total_value}"
      end
      break if next_date_str.nil?

      date_str = next_date_str
    end

    invested = stocks.map { |stock| stock.total_invested(date_str) }.sum
    puts "Current #{@interval} account value is #{invested + cash}"
  end
end
