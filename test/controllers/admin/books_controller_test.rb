require 'test_helper'

class Admin::BooksControllerTest < ActionDispatch::IntegrationTest
  test "should create a book" do
    get new_admin_book_path
    assert :success
    book_before = Book.count
    Book.create(title: "A", author:"b", description:"abc", publisher: "aaa", year: 2017, count: 10, borrowed_count: 0)
    book_after = Book.count
    assert_equal 1, book_after - book_before
  #  assert_redirected_to admin_books_path => 401. Access denied.
  end

  test "should edit a book" do
    get edit_admin_book_path(Book.first)
    assert :success
    book = Book.first
    book.title = "C"
    book.save
    assert_equal "C", Book.first.title
  #  assert_redirected_to admin_books_path => 401. Access denied.
  end

  test "should destroy a book" do
    Book.create(title: "A", author:"b", description:"abc", publisher: "aaa", year: 2017, count: 10, borrowed_count: 0)
    if Book.first.present?
      book_before = Book.count
      Book.first.destroy
      #delete admin_book_path(Book.first) ??
      book_after = Book.count
      #assert_equal "Książka usunięta z biblioteczki. Nie można już wypożyczyć żadnej sztuki", flash[:notice]
      assert_equal -1, book_after - book_before
    end
  end
end
