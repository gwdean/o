class RSpecGreeter
  def greet
    "Yo RSpec!"
  end
end

describe "RSpec Greeter" do
  it "should say 'Yo RSpec!' when it receives the greet() message" do
    greeter = RSpecGreeter.new
    greeting =  greeter.greet
    greeting.should == "Yo RSpec!"
  end
end
