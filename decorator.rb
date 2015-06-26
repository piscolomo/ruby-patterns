# Attach additional responsibilities to an object dynamically. Decorators
# provide a flexible alternative to subclassing for extending functionality
class ItemDecorator
  def initialize(item)
    @item = item
  end
  # this needs to be delegated with other efective way
  def use
    @item.use
  end
end

class MagicItemDecorator < ItemDecorator
  def price
    @item.price * 3
  end

  def description
    @item.description + "Magic"
  end
end

class MasterpieceItemDecorator < ItemDecorator
  def price
    @item.price * 2
  end

  def description
    @item.description + "Masterpiece"
  end
end

class Item
  attr_reader :price, :description
  def initialize
    @price = 10
    @description = "Item "
  end

  def use
    "do something"
  end
end

# Usage
item = Item.new
magic_item = MagicItemDecorator.new(item)
puts magic_item.price
# => 30
puts magic_item.description
# => Item Magic

masterpiece_item = MasterpieceItemDecorator.new(item)
puts masterpiece_item.price
# => 20
puts masterpiece_item.description
# => Item Masterpiece

# all next lines puts "do something"
item.use
magic_item.use
masterpiece_item.use
