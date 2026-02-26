class EventBuffer
  attr_reader :buffer

  def initialize
    @buffer = []
  end

  def push(value)
    @buffer << value
  end

  def all
    buffer
  end
end

a = EventBuffer.new
b = EventBuffer.new
a.push('a1')
b.push('b1')
a.push('a2')

p a.all
p b.all
