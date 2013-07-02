require "./lib/events"
require "test/unit"

class ClassWithEvents
	include Events
	event :test_event
	singleton_event :test_singleton_event
end

class EventDrivenTest < Test::Unit::TestCase

	def setup
		@test_object = ClassWithEvents.new
	end

	def test_can_subscribe_to_event
		@test_object.test_event.add_callback { puts "Hello!" }

		assert @test_object.test_event.callbacks.length == 1
	end

	def test_event_can_return_values
		@test_object.test_event.add_callback { return 1 }

		results = @test_object.test_event.fire
		assert results == [1]
	end

	def test_single_subscriber_event_raises_error_on_second_callback
		assert_nothing_raised do 
			@test_object.test_singleton_event.add_callback { puts "Hello!" }
		end

		assert_raises(Events::EventSubscriptionError) do
			@test_object.test_singleton_event.add_callback { puts "Hello again!" }
		end
	end

	def test_event_fire_alias
		@test_object.on_test_event { puts "Hello" }
		assert @test_object.test_event.callbacks.length == 1
	end

	def test_event_can_be_given_arguments
		@test_object.on_test_event do |arg|
			arg
		end

		results = @test_object.test_event.fire("abc")
		assert results == ["abc"]
	end
end