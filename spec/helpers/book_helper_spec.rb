# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookHelper, type: :helper do
  describe '#authors' do
    it 'returns authors in one line' do
      @book = FactoryGirl.create(:book) do |book|
        %w[Konan Doyle].each { |writer| book.authors.create(name: writer) }
      end
      expect(helper.authors).to eq('Konan, Doyle')
    end
  end

  describe '#dimension' do
    it 'returns dimension of the book in right format' do
      @book = FactoryGirl.create(:book, height: 1.0, weight: 2.0, depth: 0.8)
      expect(helper.dimension).to eq('H:1.0" x W:2.0" x D:0.8", where ” - inches')
    end
  end
end
