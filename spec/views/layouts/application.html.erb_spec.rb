require 'rails_helper'

RSpec.describe 'layouts/application', type: :view do

  context 'when there is no current_user' do
    helper do
      def current_user
      end
    end

    it 'shows the main header' do
      render
      expect(rendered).to match /Book Library/
      expect(rendered).to match /Log in/
      expect(rendered).not_to match /Search/
    end
  end

  context 'when there is current_user' do
    helper do
      def current_user
        User.create!(name: 'Jon')
      end
    end

    it 'shows the main header with hello user' do
      render
      expect(rendered).to match /Book Library/
      expect(rendered).to match /Hello Jon/
      expect(rendered).to match /Log out/
      expect(rendered).not_to match /Search/
    end
  end

  context 'when there is index or search_results action' do
    helper do
      def current_user
      end
    end

    it 'shows the search form in index action' do
      params[:controller] = 'books'
      params[:action] = 'index'
      render
      expect(rendered).to match /Search/
    end

    it 'shows the search form in search_results action' do
      params[:controller] = 'books'
      params[:action] = 'search_results'
      render
      expect(rendered).to match /Search/
    end
  end

end
