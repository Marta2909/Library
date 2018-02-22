require 'rails_helper'

RSpec.describe 'admin/books/index', type: :view do

  it 'renders add book and user statistics links' do
    assign(:books, Book.all)
    render
    expect(rendered).to match /Add book/
    expect(rendered).to match /See users statistics/
  end

  it 'renders books list' do
    b1 = Book.create!(author: 'Author1', title: "Title1", publisher: "Publisher1", description: "Description1", year: 2017, count: 20)
    b1.borrowed_count = 1
    b1.save
    b2 = Book.create!(author: 'Author2', title: "Title2", publisher: "Publisher2", description: "Description2", year: 2017, count: 20)
    b2.borrowed_count = 9
    b2.save
    assign(:books, [b1, b2])
    render
    expect(rendered).to match /Author1/
    expect(rendered).to match /Title2/
  end
end
