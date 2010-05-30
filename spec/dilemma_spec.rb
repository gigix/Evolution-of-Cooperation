require File.dirname(__FILE__) + "/spec_helper"

describe Dilemma do
  it "has 2 prisoners" do
    p1 = Prisoner.new
    p2 = Prisoner.new
    dilemma = Dilemma.new(p1, p2)
  end
end