# Provide a surrogate or placeholder for another object to control
# access to it
class Hero
  attr_accessor :keywords

  def initialize
    @keywords = []
  end
end

class ComputerProxy
  # Forwardable allows objects to run methods on behalf
  # of it's members, in this case the Computer object
  extend Forwardable

  # We delegate the ComputerProxy's use of 
  # the Computer object's add method
  def_delegators :real_object, :add

  def initialize(hero)
    @hero = hero
  end

  def execute
    check_access
    real_object.execute
  end

  def check_access
    unless @hero.keywords.include?(:computer)
      raise "You have no access"
    end
  end

  def real_object
    @real_object ||= Computer.new
  end
end

class Computer
  def initialize
    @queue = []
  end
  
  def add(command)
    @queue << command
  end

  def execute
    "executing commands"
  end
end

# Usage
hero = Hero.new
proxy = ComputerProxy.new(hero)
proxy.add("some command")
proxy.execute
# => raise error
hero.keywords << :computer
proxy.execute
# => executing commands
