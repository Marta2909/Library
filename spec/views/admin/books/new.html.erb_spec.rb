require 'rails_helper'

RSpec.describe 'admin/books/new', type: :view do

  before(:each) do
    assign(:book, Book.new)
    render
  end

  it 'renders a partial' do
    expect(rendered).to match /Copies count/
    expect(rendered).to match /Add book/
  end

  it 'renders back button' do
    expect(rendered).to match /Back/
  end
end
