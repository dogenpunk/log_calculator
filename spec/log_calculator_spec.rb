require 'spec_helper'

describe LogCalculator::Calculator do
  describe ".new" do
    context "without arguments" do
      it "should raise an error" do
        expect {
          LogCalculator::Calculator.new
        }.to raise_error(ArgumentError)
      end
    end

    context "with a block" do
      it "should not raise an error" do
        expect {
          LogCalculator::Calculator.new { }
        }.to_not raise_error(ArgumentError)
      end
    end
  end

  describe "with hours, timezone and rate" do
    subject {
      LogCalculator::Calculator.new do |calc|
        calc.hours = ["2011-09-20 08:00:00 -0500", "2011-09-20 17:00:00 -0500"]
        calc.timezone = "CDT"
        calc.rates = {first: "80.00",
                     second: "50.00",
                     first_emergency: "120.00",
                     second_emergency: "97.50"}
      end
    }
    its(:hours) { should be_a(LogCalculator::Hours) }
    its(:rates) { should be_a(LogCalculator::Rates) }
    its(:timezone) { should == "CDT" }
  end
end
