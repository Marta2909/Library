class Book < ApplicationRecord
  validates :title, :author, :description, :year, :publisher, presence: true

end
