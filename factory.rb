# Define an interface for creating an object, but let subclasses decide which
# class to instantiate
class Party
  attr_reader :members
  def initialize(factory)
    @members = []
    @factory = factory
  end

  def add_warriors(n)
    n.times{ @members << @factory.create_warrior }
  end

  def add_mages(n)
    n.times{ @members << @factory.create_mage }
  end
end

class HeroFactory
  def create_warrior
    Warrior.new
  end

  def create_mage
    Mage.new
  end
end

class Hero
  def initialize
  end
end

class Warrior < Hero
end

class Mage < Hero
end

# Usage
party = Party.new(HeroFactory.new)
party.add_warriors(3)
party.add_mages(2)
puts party.members.size
# => 5
puts party.members.count{ |member| member.class == "Mage" }
# => 2