module A
  def hi
    p 'hi from A'
  end
end

module B
  include A

  def hi
    p 'hi from B'
    super
  end
end

class C
  include B
end

C.new.hi

class Game
  def initialize title, price
    @title, @price = title, price
  end

  def inspect
    "#{@title}: #{@price}"
  end
end

game1 = Game.new('game 1', 99)

module GameExt
  def on_sale
    'on_sale'
  end
end

# extend add instance method to target 
ObjectSpace.each_object(Game) do |object|
  object.extend(GameExt)
end

p game1.on_sale

#
p Game.new('game 2', 199).on_sale
