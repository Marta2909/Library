require 'rails_helper'

RSpec.describe 'admin perspective', type: :feature do

   before(:each) do
     @book = Book.create!(author: 'Author1', title: "Title1", publisher: "Publisher1", description: "Description1", year: 2017, count: 20, borrowed_count: 2)
     basic = ActionController::HttpAuthentication::Basic
     credentials = basic.encode_credentials('admin', 'admin')
     page.driver.header('Authorization', credentials)
     visit '/admin/books'
   end

  scenario 'admin logs in' do
    expect(page).to have_text 'Admin Panel'
    expect(page).to have_link 'Add book'
    expect(page).to have_link 'See users statistics'
  end

  scenario 'admin adds a book' do
    click_link 'Add book'
    expect(page).not_to have_selector("input[value='Publisher1']")
    expect(page).to have_button 'Add book'
    expect(page).to have_link 'Back'
    fill_in 'book[author]', with: 'Author2'
    fill_in 'book[title]', with: 'Title2'
    fill_in 'book[publisher]', with: 'Publisher2'
    fill_in 'book[description]', with: 'Description2'
    fill_in 'book[year]', with: 2018
    fill_in 'book[count]', with: 10
    click_button 'Add book'
    expect(page).to have_text 'Author2'
  end

  scenario 'admin checks users statistics' do
    click_link 'See users statistics'
    expect(page).to have_text 'Not returned books'
    expect(page).to have_link 'Back'
  end

  scenario 'admin sees book details' do
    click_link 'See details'
    expect(page).to have_text 'Publisher'
    expect(page).to have_link 'Back'
  end

  scenario 'admin edits a book' do
    click_link 'Edit'
    expect(page).to have_selector("input[value='Publisher1']")
    expect(page).to have_button 'Edit book'
    expect(page).to have_link 'Back'
    fill_in 'book[title]', with: 'new_title'
    click_button 'Edit book'
    expect(page).to have_text 'new_title'
  end

end
