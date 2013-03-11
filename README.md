rbevents
========

It's like Observable, but better.

Example
=======
	class EventsExample
		include Events
		event :activation

  		def activate
    		values = @activation.fire
    		p values
  		end
	end

	example = EventsExample.new
	example.on_activation do
  		"Hello!"
	end
	example.activate # => "Hello!"

Full documentation to follow!