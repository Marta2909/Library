class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  scope :not_returned_user_books, -> { where("is_returned = ?", false) }
end
