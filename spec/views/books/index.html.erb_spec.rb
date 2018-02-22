require 'rails_helper'

RSpec.describe 'books/index', type: :view do

  context 'current user is nil' do
    helper do
      def current_user
      end
    end

    it 'renders a partial' do
      b1 = Book.create!(author: 'Author1', title: "Title1", publisher: "Publisher1", description: "Description1", year: 2017, count: 20)
      b1.borrowed_count = 2
      b1.save
      assign(:books, [b1])
      render
      expect(rendered).to match /Author1/
      expect(rendered).to match /Title1/
      expect(rendered).to match /18/
      expect(rendered).to match /Show details/
      expect(rendered).not_to match /Borrow/
    end
  end

  context 'current user is not nil' do
    helper do
      def current_user
        'Jon'
      end
    end

    it 'renders a partial' do
      b1 = Book.create!(author: 'Author1', title: "Title1", publisher: "Publisher1", description: "Description1", year: 2017, count: 20)
      b1.borrowed_count = 2
      b1.save
      assign(:books, [b1])
      render
      expect(rendered).to match /Author1/
      expect(rendered).to match /Title1/
      expect(rendered).to match /18/
      expect(rendered).to match /Show details/
      expect(rendered).to match /Borrow/
    end
  end

end
