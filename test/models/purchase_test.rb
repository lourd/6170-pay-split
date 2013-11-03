require 'test_helper'

class PurchaseTest < ActiveSupport::TestCase
  test "saves with correct parameters" do
  	event = events(:FirstEvent)
  	user = users(:A)
 	purchase = Purchase.new(:amount => 3, :description => "test",
  		:event_id => event.id, :user_id => user.id)

 	assert_equal true, purchase.valid?
  end

  test "does not save if event 0 selected (no event)" do
  	event = events(:FirstEvent)
  	user = users(:A)
 	purchase = Purchase.create(:amount => 3, :description => "test",
  		:event_id => 0, :user_id => user.id)

 	assert_equal false, purchase.valid?
  end

  test "does not save if event not specified" do
  	event = events(:FirstEvent)
  	user = users(:A)
 	purchase = Purchase.new(:amount => 3, :description => "test",
  		:user_id => user.id)

 	assert_equal false, purchase.valid?
  end
  
  test "does not save if event id does not exist" do
  	event = events(:FirstEvent)
  	user = users(:A)
 	purchase = Purchase.new(:amount => 3, :description => "test",
  		:event_id => -1, :user_id => user.id)

 	assert_equal false, purchase.valid?
  end

  test "does not save with negative amount" do
  	event = events(:FirstEvent)
  	user = users(:A)
  	event.update_attribute(:closed, true)
 	purchase = Purchase.new(:amount => 4, :description => "test",
  		:event_id => event.id, :user_id => user.id)

 	assert_equal false, purchase.valid?
  end

  test "does not save if event is closed" do
  	event = events(:FirstEvent)
  	user = users(:A)
 	purchase = Purchase.new(:amount => -4.3, :description => "test",
  		:event_id => event.id, :user_id => user.id)

 	assert_equal false, purchase.valid?
  end
end
