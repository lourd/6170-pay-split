require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test "event closes when closed" do 
  	event = events(:FirstEvent)
  	event.close_event

  	assert(event.closed == true, "event should be closed")
  end

  test "find proper user event balance" do
  	event = events(:FirstEvent)
  	userA = users(:A)

  	uvb = event.find_user_event_balance(userA.id)

  	assert(uvb.user_id == userA.id)
  	assert(uvb.event_id == event.id)
  end

  test "correctly updates total balance" do
  	event = events(:FirstEvent)

  	event.update_total_balance

  	assert(event.total_balance == event.purchases.sum('amount'))
  end

end
