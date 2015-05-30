# Define an unique instance of an object
class HeroFactory
  def self.new
    @@instance ||= super
  end

  def create_warrior
    Warrior.new
  end

  def create_mage
    Mage.new
  end
end

# Usage
factory = HeroFactory.new
another_factory = HeroFactory.new
puts factory == another_factory
# => true
