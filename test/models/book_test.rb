require 'test_helper'

class BookTest < ActiveSupport::TestCase
  test "should not save a book without title" do
    book = Book.new(author:"A", publisher:"B", year:2017, description: "abc")
    assert_not book.save, "Saved the book without a title"
  end

  test "should not save a product without author" do
    book = Book.new(title:"A", publisher:"B", year:2017, description: "abc")
    assert_not book.save, "Saved the book without a author"
  end

  test "should not save a product without publisher" do
    book = Book.new(author:"A", title:"B", year:2017, description: "abc")
    assert_not book.save, "Saved the book without a publisher"
  end

  test "should not save a product without description" do
    book = Book.new(author:"A", title:"B", year:2017, publisher: "abc")
    assert_not book.save, "Saved the book without a description"
  end

  test "should not save a product without year" do
    book = Book.new(author:"A", title:"B", description: "abc", publisher: "abc")
    assert_not book.save, "Saved the book without a year"
  end
end
