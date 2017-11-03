require 'rails_helper'

RSpec.describe Book, :type => :model do
  context 'when Book has all data entered' do
    it 'should be saved to database' do
      b = Book.new(title: "title", author:"author", description: "abc", year: 2017, publisher: "B")
      expect(b.save).to be true
    end
  end
  
  context 'when Book has not all data entered' do
    it 'a book without title should not be saved to database' do
      b = Book.new(title: nil, author:"A", description: "abc", year: 2017, publisher: "B")
      expect(b.save).to be false
    end
    it 'a book without author should not be saved to database' do
      b = Book.new(title: "title", author: nil, description: "abc", year: 2017, publisher: "B")
      expect(b.save).to be false
    end
    it 'a book without description should not be saved to database' do
      b = Book.new(title: "title", author: "author", description: nil, year: 2017, publisher: "B")
      expect(b.save).to be false
    end
    it 'a book without publishing year should not be saved to database' do
      b = Book.new(title: "title", author: "author", description: "abc", year: nil, publisher: "B")
      expect(b.save).to be false
    end
    it 'a book without publisher should not be saved to database' do
      b = Book.new(title: "title", author: "author", description: "abc", year: 2017, publisher: nil)
      expect(b.save).to be false
    end
  end
end
