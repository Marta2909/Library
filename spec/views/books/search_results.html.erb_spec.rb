require 'rails_helper'

RSpec.describe 'books/search_results', type: :view do

  context 'search results found' do
    helper do
      def current_user
      end
    end

    it 'displays search_results' do
      b1 = Book.create!(author: 'Author1', title: "Title1", publisher: "Publisher1", description: "Description1", year: 2017, count: 20)
      b1.borrowed_count = 2
      b1.save
      assign(:search_results, [b1])

      render
      expect(rendered).to match /Search results/
      expect(rendered).to match /Author1/
      expect(rendered).to match /Title1/
      expect(rendered).to match /18/
      expect(rendered).to match /Show details/
      expect(rendered).not_to match /Borrow/
    end

  end

  context 'there is no search results' do
    it 'displays not found message' do
      render
      expect(rendered).to match /Search results/
      expect(rendered).to match /Not found/
    end
  end
end
