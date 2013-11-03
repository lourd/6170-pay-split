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

  test "correctly computes total payments for a user" do 
    event = events(:FirstEvent)
    user = users(:C)
    event.user_event_balances.find_by_user_id(user.id).update_attribute(:debt, 100)

    before = event.find_total_payments_made_by_user(user.id)

    Payment.create(:amount => 1, :description => "pay to First Event",
      :event_id => event.id, :user_id => user.id)
    Payment.create(:amount => 2, :description => "pay to First Event",
      :event_id => event.id, :user_id => user.id)

    after = event.find_total_payments_made_by_user(user.id)

    assert(3 == after - before, "payments done must match")
  end
end
