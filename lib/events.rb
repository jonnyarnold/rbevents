# Mixin for event-driven programming.
#
# The mixin adds the following:
# - <tt>event [sym]</tt>: Creates an +Event+ with the given name
# - <tt>singleton_event [sym]</tt>: Creates a +SingleSubscriberEvent+ with the given name
# Note that the command <tt>event :abc</tt> adds an alias, <tt>on_abc</tt>, for adding event callbacks
#
# == Example
# See README
#
# == License
# If you use this, let me know? jonny.arnold89@gmail.com. Thanks.
module Events

    # Version number
    # Uses Semantic Versioning: http://semver.org/
    VERSION = '0.1.0'

    # An event that can be subscribed to,
    # and runs any subscribed callback when
    # it is fired.
    class Event 
        # Gets the collection of callbacks subscribed to this event.
        attr_accessor :callbacks

        # Class initializer
        def initialize
            @callbacks = []
        end
        
        # Called when the event occurs
        # [*arguments] The arguments to pass to each callback
        # Returns any values returned by any subscribed callback
        def fire(*arguments)
            return_values = []

            @callbacks.each do |proc| 
                return_values << proc.call(*arguments) 
            end

            return_values
        end
        
        # Adds a callback to the event
        # [proc] The block to execute
        def add_callback(&proc)
            @callbacks << proc
        end

        # Removes the given block from the event
        # [proc] The block to remove
        def remove_callback(&proc)
            @callbacks.delete proc
        end
    end

    # An event with a single subscriber
    class SingleSubscriberEvent < Event

        # Override of Event.add_callback
        def add_callback(&proc)
            if callbacks.length == 1
                raise EventSubscriptionError, "Cannot add more than one callback to SingleSubscriberEvent"
            end

            super
        end

        # Override of Event.fire
        def fire(*args)
            packed_result = super
            if packed_result.length == 0
                return nil
            else
                return packed_result.first
            end
        end
    end

    # Denotes an error with event subscription
    class EventSubscriptionError < StandardError
    end

    # :nodoc:
    def self.append_features(cls)
        # Create an event
        # [sym] The name to assign to the event
        # Retrieve via .sym
        def cls.event(sym)
            variable_name = "@#{sym}"

            define_method(sym.to_s) do
                if not instance_variable_defined? variable_name then
                    instance_variable_set variable_name, Event.new
                end
                instance_variable_get variable_name
            end

            firealias = "on_#{sym}"
            define_method(firealias) do |&proc|
                if not instance_variable_defined? variable_name then
                    instance_variable_set variable_name, Event.new
                end
                event_obj = instance_variable_get variable_name
                event_obj.add_callback &proc
            end
        end

        def cls.singleton_event(sym)
            define_method(sym.to_s) do
                variable_name = "@#{sym}"
                if not instance_variable_defined? variable_name then
                    instance_variable_set variable_name, SingleSubscriberEvent.new
                end
                instance_variable_get variable_name
            end
        end
    end
end
