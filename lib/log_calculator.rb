require "log_calculator/version"

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
      start_integer = Time.new(@start.year, @start.month, @start.day, 8, 0, 0, @start.gmt_offset).to_i
      finish_integer = Time.new(@start.year, @start.month, @start.day, 17, 0, 0, @start.gmt_offset).to_i
      (start_integer..finish_integer).to_a
    end

    def labor_hours
      (@start.to_i..@finish.to_i).to_a
    end
  end

  class Rates
    attr_reader :first_hour, :additional_hours
  end
end
