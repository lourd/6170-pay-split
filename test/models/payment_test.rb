require 'test_helper'

class PaymentTest < ActiveSupport::TestCase
  test "saves with correct parameters" do
  	event = events(:FirstEvent)
  	user = users(:A)
  	event.user_event_balances.find_by_user_id(user.id).update_attribute(:debt, 5)
 	  payment = Payment.new(:amount => 3, :description => "test",
  		:event_id => event.id, :user_id => user.id)

   	assert_equal true, payment.valid?
  end

  test "does not save without description" do
  	event = events(:FirstEvent)
  	user = users(:A)
  	event.user_event_balances.find_by_user_id(user.id).update_attribute(:debt, 5)
 	  payment = Payment.new(:amount => 3, :description => "",
  		:event_id => event.id, :user_id => user.id)

   	assert_equal false, payment.valid?
  end

  test "does not save if event 0 selected (no event)" do
  	event = events(:FirstEvent)
  	user = users(:A)
  	event.user_event_balances.find_by_user_id(user.id).update_attribute(:debt, 5)
 	  payment = Payment.create(:amount => 3, :description => "test",
  		:event_id => 0, :user_id => user.id)

   	assert_equal false, payment.valid?
  end

  test "does not save if event not specified" do
  	event = events(:FirstEvent)
  	user = users(:A)
  	event.user_event_balances.find_by_user_id(user.id).update_attribute(:debt, 5)
 	  payment = Payment.create(:amount => 3, :description => "test",
  		:user_id => user.id)

  	assert_equal false, payment.valid?
  end
  
  test "does not save if event id does not exist" do
  	event = events(:FirstEvent)
  	user = users(:A)
  	event.user_event_balances.find_by_user_id(user.id).update_attribute(:debt, 5)
 	  payment = Payment.create(:amount => 3, :description => "test",
  		:event_id => -1, :user_id => user.id)

  	assert_equal false, payment.valid?
  end

  test "does not save with negative amount" do
  	event = events(:FirstEvent)
  	user = users(:A)
  	event.update_attribute(:closed, true)
  	event.user_event_balances.find_by_user_id(user.id).update_attribute(:debt, 5)
 	  payment = Payment.new(:amount => 4, :description => "test",
  		:event_id => event.id, :user_id => user.id)

  	assert_equal false, payment.valid?
  end

  test "does not save if event is closed" do
  	event = events(:FirstEvent)
  	user = users(:A)
  	event.user_event_balances.find_by_user_id(user.id).update_attribute(:debt, 5)
 	  payment = Payment.new(:amount => -4.3, :description => "test",
  		:event_id => event.id, :user_id => user.id)

  	assert_equal false, payment.valid?
  end

  test "does not save if paying more than amount owed" do
  	event = events(:FirstEvent)
  	user = users(:A)
  	event.user_event_balances.find_by_user_id(user.id).update_attribute(:debt, 5)
 	  payment = Payment.new(:amount => 10, :description => "test",
  		:event_id => event.id, :user_id => user.id)

 	  assert_equal false, payment.valid?
  end
end
