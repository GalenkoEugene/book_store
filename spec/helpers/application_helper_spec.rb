# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#authors_to_list' do
    it 'returns authors in one line' do
      @book = FactoryGirl.create(:book) do |book|
        %w[Konan Doyle].each { |writer| book.authors.create(name: writer) }
      end
      expect(helper.authors_to_list(@book)).to eq('Konan, Doyle')
    end
  end

  describe '#shop_icon_quantity' do
    it 'wrap quantity in span' do
      expect(helper.shop_icon_quantity(1)).to eq("<span class='shop-quantity'>1</span>")
    end
  end
end
