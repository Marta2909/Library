require 'rails_helper'

RSpec.describe Order do

  it "should belongs to user" do
    should belong_to(:user)
  end
  
  it 'should be saved if has user_id and book_id' do
    u = User.create(provider: "google")
    b = Book.create(title: "title", author:"author", description: "abc", year: 2017, publisher: "B")
    order = Order.new(user_id: u.id)
    expect(order.save).to be true
  end

end
