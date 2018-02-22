require "rails_helper"

RSpec.describe "Everybody persepctive", :type => :system do
  before do
    driven_by(:rack_test)
    @book = Book.create!(author: 'Author1', title: "Title1", publisher: "Publisher1", description: "Description1", year: 2017, count: 20, borrowed_count: 2)
  end

  it "enables to search the book through search form" do
    visit "/"

    fill_in "Search", :with => "Title1"
    click_button "Search"

    expect(page).to have_text('Author1')
    expect(page).to have_text('18')
  end

  it 'enables to see book details' do
    visit '/'
    click_link 'Show details'
    expect(page).to have_text('Total borrowed copies count')
    expect(page).to have_text('Publisher1')
    expect(page).to have_text('18')
    expect(page).to have_link('Back')
    expect(page).not_to have_button('Search')
    expect(page).not_to have_link('Borrow')
  end

  it 'enables to log in' do
    visit '/'
    expect(page).to have_link('Log in')
    expect(page).to have_link('Log in as Admin')
  end
end
