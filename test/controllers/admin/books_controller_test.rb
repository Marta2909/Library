require 'test_helper'

class Admin::BooksControllerTest < ActionDispatch::IntegrationTest

  def http_login
    user = 'admin'
    pw = 'admin'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
  end

  test "GET index" do
    http_login
    get admin_books_path
    assert_response :success
    assert_not_nil assigns(:books)
  end

  test "GET new" do
    http_login
    get new_admin_book_path
    assert_response :success
  end

  test "should create a book" do
    http_login
    get new_admin_book_path
    assert :success
    book_before = Book.count
    Book.create(title: "A", author:"b", description:"abc", publisher: "aaa", year: 2017, count: 10)
    book_after = Book.count
    assert_equal 1, book_after - book_before
    assert_redirected_to admin_books_path
    assert_equal flash[:notice], "Książka dodana"
  end

  test "should not create a book with empty attributes" do
    http_login
    get new_admin_book_path
    assert :success
    book_before = Book.count
    Book.create(title: nil, author:"b", description:"abc", publisher: "aaa", year: 2017, count: 10)
    book_after = Book.count
    assert_equal 0, book_after - book_before
    assert_redirected_to new_admin_book_path
    assert_equal flash[:notice], "Spróbuj jeszcze raz"
  end

  test "should edit a book" do
    get edit_admin_book_path(Book.first)
    assert :success
    book = Book.first
    book.title = "C"
    book.save
    assert_equal "C", Book.first.title
    assert_redirected_to admin_books_path
    assert_equal flash[:notice], "Zaktualizowano dane o książce"
  end

  test "should not edit a book with empty attributes" do
    get edit_admin_book_path(Book.first)
    assert :success
    book = Book.first
    book.title = nil
    book.save
    assert_not_equal nil, Book.first.title
    assert_redirected_to new_admin_book_path
    assert_equal flash[:notice], "Spróbuj jeszcze raz"
  end

  test "should show the book details" do
    get admin_book_path
    assert :success
    assert_not_nil assigns(:book)
  end

  test "should destroy a book" do
    Book.create(title: "A", author:"b", description:"abc", publisher: "aaa", year: 2017, count: 10, borrowed_count: 0)
    if Book.first.present?
      book_before = Book.count
      Book.first.destroy
      book_after = Book.count
      assert_equal -1, book_after - book_before
      assert_redirected_to admin_books_path
      assert_equal flash[:notice], "Książka usunięta z biblioteczki. Nie można już wypożyczyć żadnej sztuki"
    end
  end
end
