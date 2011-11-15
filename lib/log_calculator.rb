require "log_calculator/version"
require 'bigdecimal'

module LogCalculator
  class Calculator
    attr_reader :hours, :rates

    def initialize(&block)
      raise ArgumentError unless block_given?
      @rates = Rates.new
      @hours = Hours.new
    end

    def timezone
      'CDT'
    end
  end

  class Hours
    attr_reader :start, :finish

    def initialize(args={})
      start_time = args[:start]
      end_time = args[:finish]
      @start = Time.parse(start_time) unless start_time.nil?
      @finish = Time.parse(end_time) unless end_time.nil?
    end

    def total
      @start.nil? || @finish.nil? ?
        nil :
        labor_hours.length / 60 / 60.0
    end

    def regular_hours
      (business_hours & labor_hours).length / 60 / 60.0
    end

    def emergency_hours
      total - regular_hours
    end

    private
    def business_hours
      (business_day(@start.year, @start.month, @start.day, @start.gmt_offset) +
        business_day(@finish.year, @finish.month, @finish.day, @finish.gmt_offset)).uniq
    end

    def business_day(year, month, day, offset)
      beginning_of_day = Time.new(year, month, day, 8, 0, 0, offset).to_i
      end_of_day = Time.new(year, month, day, 17, 0, 0, offset).to_i
      (beginning_of_day..end_of_day).to_a
    end

    def labor_hours
      (@start.to_i..@finish.to_i).to_a
    end
  end

  class Rates
    attr_writer :first_hour, :second_hour,
      :first_emergency_hour, :second_emergency_hour

    def initialize
      @first_hour, @second_hour = "0.00", "0.00"
      @first_emergency_hour, @second_emergency_hour = "0.00", "0.00"
    end
    
    %w(first_hour second_hour first_emergency_hour second_emergency_hour).each do |method|
      define_method(method) do
        BigDecimal.new(instance_variable_get("@#{method}") || "")
      end
    end
  end
end
