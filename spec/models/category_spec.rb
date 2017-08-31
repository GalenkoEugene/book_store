# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  it { expect(subject).to validate_presence_of :type_of }
  it { expect(subject).to validate_uniqueness_of :type_of }

  describe 'scopes' do
    describe '#with_counted_books' do
      let(:mobile) { FactoryGirl.create(:category, type: :mobile) }
      let(:web) { FactoryGirl.create(:category, type: :web) }

      before do
        FactoryGirl.create_list(:book, 8, category: web)
        FactoryGirl.create_list(:book, 15, category: mobile)
      end

      it { expect(Category.with_counted_books.length).to eq 2 }

      it 'fetch categories with amount of books in them' do
        expect(Category.find_by(type_of: :web).books.count).to eq 8
      end

      it 'fetch categories with amount of books in them' do
        expect(Category.find_by(type_of: :mobile).books.count).to eq 15
      end
    end
  end
end
