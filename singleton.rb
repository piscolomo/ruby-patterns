# Define an unique instance of an object
class HeroFactory
  @@instance = nil

  def self.instance
    @@instance ||= HeroFactory.send(:new)
  end

  def create_warrior
    Warrior.new
  end

  def create_mage
    Mage.new
  end

  private_class_method :new
end

# Usage
factory = HeroFactory.instance
another_factory = HeroFactory.instance
puts factory == another_factory
# => true
HeroFactory.new
# => Raise Exception