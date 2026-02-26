class AddItems
  attr_reader :items

  def initialize
    @items = []
  end

  def add(x)
    @items << x

    items
  end
end

result = AddItems.new
p result.add(2)
p result.add(3)

a = AddItems.new
b = AddItems.new

p a.add(1)
p b.add(10)
p a.add(2)

class Item
  def add(x)
    items = []
    items << x
    items
  end
end

result = Item.new
p result.add(2)
p result.add(3)
