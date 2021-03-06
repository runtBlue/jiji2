# coding: utf-8

require 'oanda_api'
require 'jiji/model/securities/internal/virtual/ordering'
require 'jiji/model/securities/internal/virtual/rate_retriever'
require 'jiji/model/securities/internal/virtual/trading'

module Jiji::Model::Securities
  class VirtualSecurities

    include Jiji::Errors
    include Jiji::Model

    include Internal::Virtual::RateRetriever
    include Internal::Virtual::Ordering
    include Internal::Virtual::Trading

    def initialize(tick_repository, config)
      @tick_repository =  tick_repository
      @position_builder =
        Trading::Internal::PositionBuilder.new(config[:backtest])
      @order_validator = Internal::Virtual::OrderValidator.new

      init_rate_retriever_state(
        config[:start_time], config[:end_time], config[:pairs])
      init_ordering_state(config[:orders] || [])
      init_trading_state(config[:positions] || [])
    end

    def destroy
    end

    def retrieve_account
      unsupported
    end

    def retrieve_transactions(count = 500,
      pair_name = nil, min_id = nil, max_id = nil)
      unsupported
    end

  end
end
