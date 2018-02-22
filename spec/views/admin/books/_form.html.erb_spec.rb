require 'rails_helper'

RSpec.describe "admin/books/_form", type: :view do

  it 'shows a form' do
    assign(:book, Book.new)
    render 'admin/books/form', button_name: 'Submit A'
    expect(rendered).to match /Copies count/
    expect(rendered).to match /Submit A/
  end

end
