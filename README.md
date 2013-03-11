rbevents
========

It's like Observable, but better.

Example
=======
```ruby
class EventsExample
  include Events
  event :activation
  def activate
    return_values = @activation.fire
    return_values
  end
end
example = EventsExample.new
example.on_activation do
  "Hello"
end
example.on_activation do
  "World!"
end
example.activate # => ["Hello", "World!"]
```
Full documentation to follow!