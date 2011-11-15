require 'spec_helper'

describe LogCalculator::Rates do
  let(:rates) { LogCalculator::Rates.new }
  describe ".new" do
    context "with no arguments" do
      subject { rates }
      its(:first_hour) { should == BigDecimal.new('0.00') }
      its(:second_hour) { should == BigDecimal.new('0.00') }
      its(:first_emergency_hour) { should == BigDecimal.new('0.00') }
      its(:second_emergency_hour) { should == BigDecimal.new('0.00') }
    end
  end

  it "should support reading and writing of first hour rate" do
    rates.first_hour = '80.00'
    rates.first_hour.should == BigDecimal.new('80.00')
  end

  it "should support reading and writing of second hour rate" do
    rates.second_hour = '50.00'
    rates.second_hour.should == BigDecimal.new('50.00')
  end

  it "should support reading and writing of first emergency rate" do
    rates.first_emergency_hour = '120.00'
    rates.first_emergency_hour.should == BigDecimal.new('120.00')
  end

  it "should support reading and writing of second emergency rate" do
    rates.second_emergency_hour = '95.25'
    rates.second_emergency_hour.should == BigDecimal.new('95.25')
  end
end
