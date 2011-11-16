require 'spec_helper'
require 'time'

describe LogCalculator::Hours do
  describe ".new" do
    context "with no arguments" do
      subject { LogCalculator::Hours.new }

      its(:start)   { should be_nil }
      its(:finish)  { should be_nil }
      its(:total)   { should be_nil }
    end

    context "with a start time" do
      subject { LogCalculator::Hours.new(start: "2011-09-20 08:00:00 -0500") }

      its(:start)   { should == Time.parse("2011-09-20 08:00:00 -0500") }
      its(:finish)  { should be_nil }
      its(:total)   { should be_nil }
    end

    context "with a start and end time" do
      subject { LogCalculator::Hours.new(start: "2011-09-20 08:00:00 -0500",
                                         finish: "2011-09-20 17:00:00 -0500")
      }

      its(:start)  { should == Time.parse("2011-09-20 08:00:00 -0500") }
      its(:finish) { should == Time.parse("2011-09-20 17:00:00 -0500") }
      its(:total)  { should == 9 }
      its(:regular_hours)   { should == 9 }
      its(:emergency_hours) { should == 0 }
    end

    context "with a start time before 8AM" do
      subject { LogCalculator::Hours.new(start: "2011-09-20 07:30:00 -0500",
                                         finish: "2011-09-20 12:00:00 -0500")
      }

      its(:total) { should == 4.5 }
      its(:regular_hours) { should == 4 }
      its(:emergency_hours) { should == 0.5 }
    end

    context "with a end time after 5PM" do
      subject { LogCalculator::Hours.new(start: "2011-09-20 12:00:00 -0500",
                                         finish: "2011-09-20 18:15:00 -0500")
      }

      its(:total) { should == 6.25 }
      its(:regular_hours) { should == 5 }
      its(:emergency_hours) { should == 1.25 }
    end

    context "with no regular hours" do
      subject { LogCalculator::Hours.new(start: "2011-09-20 17:00:00 -0500",
                                         finish: "2011-09-20 18:45:00 -0500")
      }

      its(:total) { should == 1.75 }
      its(:regular_hours) { should == 0 }
      its(:emergency_hours) { should == 1.75 }
    end

    context "with no regular hours spanning two different days" do
      subject { LogCalculator::Hours.new(start: "2011-09-20 23:00:00 -0500",
                                         finish: "2011-09-21 01:00:00 -0500")
      }

      its(:total) { should == 2.00 }
      its(:regular_hours) { should == 0 }
      its(:emergency_hours) { should == 2.00 }
    end

    context "with regular hours spanning two different days" do
      subject { LogCalculator::Hours.new(start: "2011-09-20 16:00:00 -0500",
                                         finish: "2011-09-21 09:00:00 -0500")
      }

      its(:total) { should == 17.00 }
      its(:regular_hours) { should == 2.00 }
      its(:emergency_hours) { should == 15.00 }
    end

    context "with start time before 8AM and end time after 5PM" do
      subject { LogCalculator::Hours.new(start: "2011-09-20 07:00:00 -0500",
                                         finish: "2011-09-20 18:00:00 -0500")
      }

      its(:total) { should == 11.00 }
      its(:regular_hours) { should == 9.00 }
      its(:emergency_hours) { should == 2.00 }
    end
  end
end
