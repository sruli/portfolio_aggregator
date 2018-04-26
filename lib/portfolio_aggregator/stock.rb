# frozen_string_literal: true

class PortfolioAggregator
  # Object representing an individual stock
  class Stock
    IllegalTransactionError = Class.new(StandardError)
    OutOfRangeError = Class.new(StandardError)

    attr_accessor :current_number_of_shares

    def initialize(stock_symbol:, percentage:, interval:)
      @stock_symbol = stock_symbol
      @interval = interval
      @percentage = percentage
      @api = PortfolioAggregator::Api.new(stock_symbol: stock_symbol)
      @current_number_of_shares = 0
    end

    def total_invested(date_str)
      @current_number_of_shares * current_price(date_str)
    end

    def above_threshold?(total_value, date_str)
      price = current_price(date_str)
      present_value = calculate_present_value(price)
      intended_value = calculate_intended_value(total_value)
      present_value > intended_value
    end

    def buy!(total_value, cash, date_str) # rubocop:disable MethodLength
      price = current_price(date_str)
      present_value = calculate_present_value(price)
      intended_value = calculate_intended_value(total_value)

      unless present_value < intended_value
        message = "You cannot buy more unless present_value ($#{present_value}) is less than intended_value ($#{intended_value})" # rubocop:disable LineLength
        raise IllegalTransactionError, message
      end

      difference = intended_value - present_value
      number_of_shares_to_buy = (difference / price).floor
      cost = number_of_shares_to_buy * price

      unless cash >= cost
        raise IllegalTransactionError, "This transation costs $#{cost}. You only have $#{cash}." # rubocop:disable LineLength
      end

      @current_number_of_shares += number_of_shares_to_buy

      cash - cost
    end

    def sell!(total_value, cash, date_str) # rubocop:disable MethodLength
      price = current_price(date_str)
      present_value = calculate_present_value(price)
      intended_value = calculate_intended_value(total_value)

      unless present_value > intended_value
        message = "You cannot sell unless present_value ($#{present_value}) is greater than intended_value ($#{intended_value})" # rubocop:disable LineLength
        raise IllegalTransactionError, message
      end

      difference = present_value - intended_value
      number_of_shares_to_sell = (difference / price).ceil
      profit = number_of_shares_to_sell * price
      @current_number_of_shares -= number_of_shares_to_sell
      cash + profit
    end

    def current_price(date_str)
      historical_data[date_str]['4. close'].to_f
    rescue NoMethodError
      message = "Data is not available for #{@stock_symbol} on #{date_str}"
      raise OutOfRangeError, message
    end

    def historical_data
      @historical_data ||= begin
        pathname = File.join(
          File.dirname(__FILE__),
          "../../fixtures/#{@interval}/#{@stock_symbol}.json"
        )
        data = JSON.parse(File.read(pathname))
        case @interval
        when PortfolioAggregator::MONTHLY
          data['Monthly Time Series']
        when PortfolioAggregator::WEEKLY
          data['Weekly Time Series']
        when PortfolioAggregator::DAILY
          data['Time Series (Daily)']
        end
      end
    end

    def dates
      historical_data.keys.reverse
    end

    private

    def calculate_present_value(price)
      @current_number_of_shares * price
    end

    def calculate_intended_value(total_value)
      total_value * @percentage
    end
  end
end
