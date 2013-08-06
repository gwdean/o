# Some practice code. 
# Adapted from "Design Patterns in Ruby".

class BankAccount
  def initialize( account_owner )
    @owner = account_owner
    @balance = 0
  end

  def deposit( amount )
    @balance = @balance + amount
  end

  def withdraw( amount )
    @balance = @balance - amount
  end

  def balance
    @balance
  end

  def set_balance(new_balance)
    @balance = new_balance
  end
end

my_account = BankAccount.new('greg')
puts(my_account.balance)

class BankAccount
  def initialize( account_owner )
    @owner = account_owner
    @balance = 0
  end
  attr_accessor :balance
end

class SelfCentered
  def talk_about_me
    puts("Hello I am #{self}")
  end
end

conceited = SelfCenterered.new
conceited.talk_about_me

class InterestBearingAccount < BankAccount
  def initialize(owner, rate)
    @owner = owner
    @balance = 0
    @rate = rate
  end

  def deposit_interest
    @balance += @rate * @balance
  end
end

# Default values for an object
def create_car( model, convertible=false)
  # ...
end

create_car('sedan')
create_car('sports car', true)
create_car('minivan', false)

def add_students(*names)
  for student in names
    puts("adding student #{student}")
  end
end


