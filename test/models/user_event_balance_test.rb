require 'test_helper'

class UserEventBalanceTest < ActiveSupport::TestCase
  test "compute total user event purchases correctly" do
  	event = events(:FirstEvent)
  	user = users(:C)

  	ueb = event.find_user_event_balance(user.id)

  	before = ueb.total_user_event_purchases

  	Purchase.create(:amount => 1, :description => "test",
  		:event_id => event.id, :user_id => user.id)
  	Purchase.create(:amount => 2.0, :description => "test",
  		:event_id => event.id, :user_id => user.id)

  	after = ueb.total_user_event_purchases

  	assert_equal 3, after - before
  end

  test "compute total user event payments correctly" do
  	event = events(:FirstEvent)
  	user = users(:C)

  	ueb = event.find_user_event_balance(user.id)

  	before = ueb.total_user_event_payments

  	# Set limit so that payments are created no matter what the debt was before.
  	event.user_event_balances.find_by_user_id(user.id).update_attribute(:debt, 10)
  	Payment.create(:amount => 1, :description => "test",
  		:event_id => event.id, :user_id => user.id)
  	Payment.create(:amount => 2.0, :description => "test",
  		:event_id => event.id, :user_id => user.id)

  	after = ueb.total_user_event_payments

  	assert_equal 3, after - before
  end

  test "compute total event purchase share correctly" do
	event = events(:FirstEvent)

  	ueb = event.find_user_event_balance(users(:C).id)

  	before = ueb.total_event_purchases_share

  	Purchase.create(:amount => 1, :description => "test",
  		:event_id => event.id, :user_id => users(:C).id)
  	Purchase.create(:amount => 2.0, :description => "test",
  		:event_id => event.id, :user_id => users(:A).id)

  	after = ueb.total_event_purchases_share	

  	assert_equal 1, after - before
  end

  test "determine new debt correctly after my purchases" do
  	event = events(:FirstEvent)
  	user = users(:C)

  	ueb = event.find_user_event_balance(user.id)

  	before = ueb.determine_new_debt

  	Purchase.create(:amount => 3, :description => "test",
  		:event_id => event.id, :user_id => user.id)

  	after = ueb.determine_new_debt

  	assert_equal -2, after - before
  end

  test "determine new debt correctly after someone else purchases" do
  	event = events(:FirstEvent)
  	user = users(:C)

  	ueb = event.find_user_event_balance(user.id)

  	before = ueb.determine_new_debt

  	Purchase.create(:amount => 6, :description => "test",
  		:event_id => event.id, :user_id => users(:A).id)

  	after = ueb.determine_new_debt

  	assert_equal 2, after - before
  end

  test "determine new debt correctly after I pay" do
  	event = events(:FirstEvent)
  	user = users(:C)

  	ueb = event.find_user_event_balance(user.id)

  	before = ueb.determine_new_debt

  	# Set limit so that payment is created no matter what the debt was before.
  	event.user_event_balances.find_by_user_id(user.id).update_attribute(:debt, 10)
  	Payment.create(:amount => 2, :description => "test",
  		:event_id => event.id, :user_id => user.id)

  	after = ueb.determine_new_debt

  	assert_equal -2, after - before
  end

  test "determine new credit correctly after I purchase" do
  	event = events(:FirstEvent)
  	user = users(:A)

  	ueb = event.find_user_event_balance(user.id)

  	before = ueb.determine_new_credit

  	Purchase.create(:amount => 3, :description => "test",
  		:event_id => event.id, :user_id => user.id)

  	after = ueb.determine_new_credit

  	assert_equal 2, after - before
  end

  test "determine new credit correctly after someone else purchases" do
  	event = events(:FirstEvent)
  	user = users(:A)

  	ueb = event.find_user_event_balance(user.id)

  	before = ueb.determine_new_credit

  	Purchase.create(:amount => 6, :description => "test",
  		:event_id => event.id, :user_id => users(:C).id)

  	after = ueb.determine_new_credit

  	assert_equal -2, after - before
  end

  test "determine update payment works and credit correctly changes" do
  	event = events(:FirstEvent)
  	user = users(:A)

  	ueb = event.find_user_event_balance(user.id)

  	before = ueb.determine_new_credit

  	ueb.update_payment_received(2)

  	after = ueb.determine_new_credit

  	assert_equal -2, after - before
  end

  test "update debt" do
  	event = events(:FirstEvent)
  	user = users(:C)
  	event.user_event_balances.each do |ueb|
	  	ueb.update_debt()

	  	assert_equal ueb.debt, ueb.determine_new_debt
	end
  end

  test "update credit" do
  	event = events(:FirstEvent)
  	event.user_event_balances.each do |ueb|
	  	ueb.update_credit()

	  	assert_equal ueb.credit, ueb.determine_new_credit
	end
  end

  test "update payments received" do
  	event = events(:FirstEvent)
  	event.user_event_balances.each do |ueb|
  		before = ueb.payment_received
	  	ueb.update_payment_received(10)

	  	assert_equal ueb.payment_received - before, 10
	end
  end
end
