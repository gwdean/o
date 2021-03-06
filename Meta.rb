module Meta
# Meta.rb is an interpretation of Perrotta-2010

# Introspection
class Greeting 
  def initialize(text)
    @text = text
  end
  def welcome
    @text
  end
end
my_object = Greeting.new("Hello")

my_object.class
my_object.class.instance_methods(false)
my_object.instance_variables

class Entity
  attr_reader :table, :ident

  def initialize(table, ident)
    @table = table
    @ident = ident
    Database.sql "INSERT INTO #{@table} (id) VALUES (#{@ident})"
  end

  def set(col, val)
    Database.sql "UPDATE #{@table} SET #{@col}='#{val}' WHERE id=#{@ident}"
  end

  
end

class Movie < Entity
  def initialize(ident)
    super("movies", ident)
  end

  def title
    get("title")
  end

  def title=(value)
    set("title",value)
  end

  def director
    get("director")
  end

  def director=(value)
    set("director", value)
  end
end

module Notes
# Metaprogramming is code that writes code.
end 

end 

FanFiction.net

GreenBraStrap
MetaHuman
