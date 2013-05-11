rbevents
========

It's like Observable, but better.

Example
=======
```ruby

# Let's define a class with subscribable events
class EventsExample
  include Events # Mix in the magic
  
  # Define an event
  event :activation
  
  # Here, we define a method that fires the event 
  def activate
    # Event.fire sets off the event and collects
    # any return values from subscribed events
    return_values = @activation.fire
    return_values
  end
end

# Let's build an object...
example = EventsExample.new

# ...and then add some subscribers
example.on_activation do
  "Hello"
end
example.on_activation do
  "World!"
end

# Finally, we call a method which alerts the subscribers
example.activate # => ["Hello", "World!"]
```
Full documentation to follow!
