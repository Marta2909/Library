require 'rails_helper'

RSpec.describe 'user perspective', type: :system do
  before(:each) do
    driven_by(:rack_test)
    @book = Book.create!(author: 'Author1', title: "Title1", publisher: "Publisher1", description: "Description1", year: 2017, count: 20, borrowed_count: 2)
    visit '/'
    click_link 'Log in'
  end

  it 'enables to log in' do
    expect(page).to have_text 'Hello username'
    expect(page).to have_link 'Borrow'
    expect(page).to have_link 'Borrow history'
    expect(page).to have_link 'Log out'
    expect(page).to have_button 'Search'
  end

  it 'enables to borrow a book' do
    expect(page).to have_text '18'
    click_link 'Borrow'
    expect(page).to have_text 'Your orders history'
    expect(page).to have_text 'Status'
    click_link 'Back'
    expect(page).to have_text '17'
  end

  it 'enables to return a book' do
    expect(page).to have_text '18'
    click_link 'Borrow'
    click_link 'Return book'
    expect(page).to have_text '18'
    click_link 'Borrow history'
    expect(page).to have_text 'Book returned'
  end

  it 'enables to see borrow history' do
    click_link 'Borrow'
    click_link 'Borrow history'
    expect(page).to have_text 'Your orders history'
  end

  it 'enables to log out' do
    click_link 'Log out'
    expect(page).to have_link 'Log in'
    expect(page).to have_link 'Log in as Admin'
  end
end
