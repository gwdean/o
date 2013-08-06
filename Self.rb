# notes on http://yehudakatz.com/2009/11/15

class Person
  def self.species
    "Homo Sapiens"
  end
end

class Person
  class << self
    def species
      "Homo Sapiens"
    end
  end
end

class << Person
  def species
    "Homo Sapiens"
  end
end

Person.instance_eval do
  def species
    "Homo Sapiens"
  end
end

def Person.species
  "Homo Sapiens"
end

class Person
  def name
    "Matz"
  end
end

Person.class_eval do
  def name
    "Matz"
  end
end

class Person
end

Person.class #=> Class

class Class
  def loud_name
    "#{name.upcase}!"
  end
end

Person.loud_name  #=> "PERSON!"

matz = Object.new
def matz.speak
  "Place your burden on machine's shoulders"
end

matz.class #=> Object

metaclass = class << matz; self; end
metaclass.instance_methods.grep(/speak/) #=> ["speak"]

# What is the meaning of "class << matz" ???

# All of these rules collapse into a single concept:
# control over the self in a given part of the code.

class Person
  def name
    "Matz"
  end

  self.name #=> "Person"
end

Person.class_eval do
  def name
    "Matz"
  end

  self.name #=> "Person"
end

def Person.species
  "Homo Sapiens"
end

Person.name #=> "Person"

class Person
  def self.species
    "Homo Sapiens"
  end

  self.name #=> "Person"
end

class << Person
  def species
    "Homo Sapiens"
  end

  self.name #=> nil
end

class Person
  class << self
    def species
      "Homo Sapiens"
    end

    self.name #=> nil
  end
end

Person.instance_eval do
  def species
    "Homo Sapiens"
  end

  self.name #=> "Person"
end
