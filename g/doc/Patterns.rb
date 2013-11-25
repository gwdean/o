# Patterns.rb
# An interpretation of Olsen's Design Patterns in Ruby (2008)
# gwdean

# Fourteen Patterns

# Template
# Strategy
# Observer
class Employee
  attr_reader :name
  attr_accessor :title :salary

  def initialize( name, title, salary )
    @name = name
    @title = title
    @salary = salary
  end
end

jim = Employee.new("Jim Smith", "Programmer", 100.0)

# Give Jim a raise.

jim.salary=200.0
# Composite

class Task
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def get_time_required
    0.0
  end
end

class AddDryIngredients < Task
end

class MixTask < Task
end

class MakeBatterTask < Task
end

class CompositeTask < Task
  def initialize(name)
    super(name)
    @sub_tasks = []
  end

  def add_sub_task(task)
    @sub_tasks << task
  end

  def remove_sub_task(task)
    @sub_tasks.delete(task)
  end

  def get_time_required
    time=0.0
    @sub_tasks.each {|task| time += task.get_time_required)
    time
  end
end

class MakeBatterTask < CompositeTask
end

class MakeCakeTask < CompositeTask
  def initialize
    super('Make cake')
    add_sub_task( MakeBatterTask.new )
    add_sub_task( FillPanTask.new )
    add_sub_task( BakeTask.new )
    add_sub_task( FrostTask.new )
    add_sub_task( LickSpoonTask.new )
  end
end

# Iterator
# Command
# Adapter
# Proxy
# Decorator
# Singleton
# Factory
# Abstract Factory
# Builder
# Interpreter
