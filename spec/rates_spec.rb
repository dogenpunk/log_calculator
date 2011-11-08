require 'spec_helper'

describe LogCalculator::Rates do
  describe ".new" do
    context "with no arguments" do
      subject { LogCalculator::Rates.new }
      its(:first_hour) { should be_nil }
      its(:additional_hours) { should be_nil }
    end
  end
end
