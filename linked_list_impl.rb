# frozen_string_literal: true

class Node
  attr_accessor :value, :next_node

  def initialize(value = nil)
    @value = value
    @next_node = nil
  end
end

class LinkedList
  attr_accessor :head, :tail, :size

  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def append(value)
    new_node = Node.new(value)
    if @head.nil?
      @head = new_node
    else
      @tail.next_node = new_node
    end
    @tail = new_node
    @size += 1
  end

  def prepend(value)
    new_node = Node.new(value)
    if @head.nil?
      @head = new_node
      @tail = new_node
    else
      new_node.next_node = @head
      @head = new_node
    end
    @size += 1
  end

  attr_reader :size, :tail

  def at(index)
    return nil if index.negative? || index >= @size

    current = @head
    index.times { current = current.next_node }
    current
  end

  def pop
    return nil if @head.nil?

    if @head == @tail
      @head = nil
      @tail = nil
    else
      current = @head
      current = current.next_node while current.next_node != @tail
      current.next_node = nil
      @tail = current
    end
    @size -= 1
  end

  def contains?(value)
    current = @head
    while current
      return true if current.value == value

      current = current.next_node
    end
    false
  end

  def find(value)
    current = @head
    index = 0
    while current
      return index if current.value == value

      current = current.next_node
      index += 1
    end
    nil
  end

  # Represent the LinkedList objects as strings
  def to_s
    current = @head
    result = ''
    while current
      result += "( #{current.value} ) -> "
      current = current.next_node
    end
    "#{result}nil"
  end

  # Extra credit: Insert a new node with the provided value at the given index
  def insert_at(value, index)
    return if index.negative? || index > @size

    if index.zero?
      prepend(value)
    elsif index == @size
      append(value)
    else
      new_node = Node.new(value)
      current = at(index - 1)
      new_node.next_node = current.next_node
      current.next_node = new_node
      @size += 1
    end
  end

  # Extra credit: Remove the node at the given index
  def remove_at(index)
    return if index.negative? || index >= @size

    if index.zero?
      @head = @head.next_node
      @head = nil if @head.nil? # If the list becomes empty
    else
      current = at(index - 1)
      current.next_node = current.next_node.next_node if current.next_node
      @tail = current if current.next_node.nil? # Update tail if needed
    end
    @size -= 1
  end
end

# Example usage
list = LinkedList.new

list.prepend(1)
list.append('dog')
list.append('cat')
list.append('parrot')
list.pop
list.append('hamster')
list.append('snake')
list.prepend('2')
list.append('turtle')
puts list.at(list.size-1).value
puts list.size
puts list.contains?('cat')
puts list.find('snake')
list.insert_at('insert', 5)
list.remove_at(list.size-1)

puts list
