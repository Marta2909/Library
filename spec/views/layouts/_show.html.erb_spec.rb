require 'rails_helper'

RSpec.describe 'layouts/show', type: :view do

  before(:each) do
    assign(:book, Book.create!(author: 'Author1', title: "Title1", publisher: "Publisher1", description: "Description1", year: 2017, count: 20, borrowed_count: 2))
  end
  
  it 'shows book info' do
    render 'layouts/show'
    expect(rendered).to match /Title1/
  end
end
