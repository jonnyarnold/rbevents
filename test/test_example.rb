require "./lib/events"
require "test/unit"

# Test class in example
class EventsExample
  include Events
  event :activation

  def activate
    return_values = @activation.fire
    return_values
  end
end

# Test usage in example
class ExampleTests < Test::Unit::TestCase
  def test_example_executes_correctly
    example = EventsExample.new

    example.on_activation do
      "Hello"
    end

    example.on_activation do
      "World!"
    end

    assert example.activate == ["Hello", "World!"]
  end
end