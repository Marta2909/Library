require 'rails_helper'

RSpec.describe 'books/_booklist', type: :view do

  context 'current_user is nil' do

    helper do
      def current_user
      end
    end

    it 'displays a book list' do
      render 'books/booklist', b: [Book.create!(author: 'Author1', title: "Title1", publisher: "Publisher1", description: "Description1", year: 2017, count: 20, borrowed_count: 2)]
      expect(rendered).to match /Show details/
      expect(rendered).not_to match /Borrow/
    end
  end

  context 'current_user isn\'t nil' do

    helper do
      def current_user
        'Jon'
      end
    end

    it 'displays a book list' do
      render 'books/booklist', b: [Book.create!(author: 'Author1', title: "Title1", publisher: "Publisher1", description: "Description1", year: 2017, count: 20, borrowed_count: 2)]
      expect(rendered).to match /Show details/
      expect(rendered).to match /Borrow/
    end
  end

end
