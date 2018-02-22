require 'rails_helper'

RSpec.describe 'books/show', type: :view do

  context 'when there is no current_user' do
    helper do
      def current_user
      end
    end

    before(:each) do
      b1 = Book.create!(author: 'Author1', title: "Title1", publisher: "Publisher1", description: "Description1", year: 2017, count: 20)
      b1.borrowed_count = 2
      b1.save
      assign(:book, b1)
      render
    end

    it 'renders book info' do
      expect(rendered).to match /Copies count borrowed at this moment/
    end

    it 'doesn\'t render info about borrow' do
      expect(rendered).not_to match /Borrow/
      expect(rendered).not_to match /All books borrowed/
    end

  end


  context 'when there is current_user' do
    helper do
      def current_user
        'Jon'
      end
    end
    it 'renders book info' do
      b1 = Book.create!(author: 'Author1', title: "Title1", publisher: "Publisher1", description: "Description1", year: 2017, count: 20)
      b1.borrowed_count = 2
      b1.save
      assign(:book, b1)
      render
      expect(rendered).to match /Copies count borrowed at this moment/
    end

    context 'when there are copies to borrow' do
      it 'renders the borrow option' do
        b1 = Book.create!(author: 'Author1', title: "Title1", publisher: "Publisher1", description: "Description1", year: 2017, count: 20)
        b1.borrowed_count = 2
        b1.save
        assign(:book, b1)
        render
        expect(rendered).to match /Borrow/
      end
    end

    context 'when there is no copies to borrow' do
      it 'informs the user' do
        b1 = Book.create!(author: 'Author1', title: "Title1", publisher: "Publisher1", description: "Description1", year: 2017, count: 20)
        b1.borrowed_count = 20
        b1.save
        assign(:book, b1)
        render
        expect(rendered).to match /All books borrowed/
      end
    end
  end
end
