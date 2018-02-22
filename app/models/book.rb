class Book < ActiveRecord::Base
  has_many :orders
  validates :title, :author, :description, :year, :publisher, presence: true
end
