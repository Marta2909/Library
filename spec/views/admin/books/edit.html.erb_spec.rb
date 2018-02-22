require 'rails_helper'

RSpec.describe "admin/books/edit", type: :view do

  before(:each) do
    assign(:book, Book.create!(author: 'Author1', title: "Title1", publisher: "Publisher1", description: "Description1", year: 2017, count: 20))
    render
  end

  it 'renders a partial' do
    expect(rendered).to match /Publisher1/
    expect(rendered).to match /Copies count/
    expect(rendered).to match /Edit book/
  end

  it 'renders a back button' do
    expect(rendered).to match /Back/
  end

end
