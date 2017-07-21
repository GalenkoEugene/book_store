# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Home page', type: :feature do
  before :each { visit root_path }

  describe 'User visit home page' do
    it { have_text 'Home' }
  end
end
