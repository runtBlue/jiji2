# coding: utf-8

require 'jiji/utils/abstract_historical_data_fetcher'

module Jiji::Model::Graphing::Internal

  class GraphDataSaver

    def initialize( graph_id, interval )
      @graph_id        = graph_id
      @interval        = interval
      @values          = nil
      @current         = nil
    end

    def save_data_if_required( values, time )
      recreate_graph_data(time) if !@current || time >= @next_recreate_point
      updata( values )
      save_data if time >= @next_save_point
    end

    private

    def recreate_graph_data(time)
      @current.save if @current

      time = @interval.calcurate_interval_start_time(time)
      @next_recreate_point = time + (@interval.ms / 1000)
      @next_save_point     = time + 60
      @current = Jiji::Model::Graphing::GraphData.create(
        @graph_id, [], @interval.id, time)
      @values  = []
    end

    def updata(values)
      values.each_with_index do |item, index|
        h = @values[index] \
        || (@values[index] = {count:0, sum:BigDecimal.new(0, 10)})
        unless values[index].nil?
          h[:sum]   += item
          h[:count] += 1
        end
      end
      @current.values = @values.map do |h|
        h && h[:count] > 0 ? (h[:sum] / h[:count]).to_f : 0
      end
    end

    def save_data
      @current.save
      @next_save_point += 60
    end

  end

end