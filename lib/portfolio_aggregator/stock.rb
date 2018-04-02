# frozen_string_literal: true

class PortfolioAggregator
  # Object representing an individual stock
  class Stock
    attr_accessor :current_number_of_shares

    def initialize(stock_symbol:, percentage:, interval:)
      @interval = interval
      @percentage = percentage
      @api = PortfolioAggregator::Api.new(stock_symbol: stock_symbol)
      @current_number_of_shares = 0
    end

    def total_invested(date_str)
      @current_number_of_shares * current_price(date_str)
    end

    # TODO: refactor present_value/intended_value
    def above_threshold?(total_value, date_str)
      present_value = @current_number_of_shares * current_price(date_str)
      intended_value = total_value * @percentage
      present_value > intended_value
    end

    # TODO: refactor present_value/intended_value and use above_threshold?
    def buy!(total_value, cash, date_str)
      price = current_price(date_str)
      present_value = @current_number_of_shares * price
      intended_value = total_value * @percentage

      raise unless present_value < intended_value # TODO: create error class

      difference = intended_value - present_value
      number_of_shares_to_buy = (difference / price).floor
      cost = number_of_shares_to_buy * price
      raise unless cash >= cost # TODO: create error class
      @current_number_of_shares += number_of_shares_to_buy

      cash - cost
    end

    # TODO: refactor present_value/intended_value and use above_threshold?
    def sell!(total_value, cash, date_str)
      price = current_price(date_str)
      present_value = @current_number_of_shares * price
      intended_value = total_value * @percentage

      raise unless present_value > intended_value # TODO: create error class

      difference = present_value - intended_value
      number_of_shares_to_sell = (difference / price).ceil
      profit = number_of_shares_to_sell * price
      @current_number_of_shares -= number_of_shares_to_sell

      cash + profit
    end

    def more_entries_after_date?(date_str)
      formatter = ->(str) { str.split('-').map(&:to_i) }

      current_time = Time.new(*formatter.call(date_str))
      latest_timestamp = historical_data.keys.first
      latest_time = Time.new(*formatter.call(latest_timestamp))

      latest_time > current_time
    end

    def current_price(date_str)
      case @interval
      when PortfolioAggregator::MONTHLY
        timestamp = historical_data.keys.find { |k| k.start_with?(date_str) }
        historical_data[timestamp]['4. close'].to_f
      end
    end

    private

    def historical_data
      @historical_data ||= begin
        case @interval
        when PortfolioAggregator::MONTHLY
          @api.monthly['Monthly Time Series']
        end
      end
    end
  end
end
