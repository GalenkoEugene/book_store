# frozen_string_literal: true

require 'rails_helper'
RSpec.describe HomeHelper, type: :helper do
  describe '#log_out_helper' do
    it 'returns log out html'
  end

  describe '#active' do
    it 'return string active for first index' do
      index = 0
      expect(helper.active(index)).to eq 'active'
    end

    (1..6).to_a.each do |index|
      it "return false or nil for all except first index e.g.#{index}" do
        expect(helper.active(index)).to be_falsey
      end
    end
  end
end
