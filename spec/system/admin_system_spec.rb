require 'rails_helper'

RSpec.describe 'admin perspective', type: :system do

  before do
    driven_by(:rack_test)
  end

   before(:each) do
     @book = Book.create!(author: 'Author1', title: "Title1", publisher: "Publisher1", description: "Description1", year: 2017, count: 20, borrowed_count: 2)
     basic = ActionController::HttpAuthentication::Basic
     credentials = basic.encode_credentials('admin', 'admin')
     page.driver.header('Authorization', credentials)
     visit '/admin/books'
   end

  it 'enables to see admin view' do
    expect(page).to have_text 'Admin Panel'
    expect(page).to have_link 'Add book'
    expect(page).to have_link 'See users statistics'
  end

  it 'enables to add a book' do
    click_link 'Add book'
    expect(page).not_to have_selector("input[value='Publisher1']")
    expect(page).to have_button 'Add book'
    expect(page).to have_link 'Back'
  end

  it 'enables to see users statiscics' do
    click_link 'See users statistics'
    expect(page).to have_text 'Not returned books'
    expect(page).to have_link 'Back'
  end

  it 'enables to see book details' do
    click_link 'See details'
    expect(page).to have_text 'Publisher'
    expect(page).to have_link 'Back'
  end

  it 'enables to edit a book' do
    click_link 'Edit'
    expect(page).to have_selector("input[value='Publisher1']")
    expect(page).to have_button 'Edit book'
    expect(page).to have_link 'Back'
  end

end
