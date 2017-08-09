# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  validates_uniqueness_of :uid, unless: Proc.new { provider.nil? }, scope: :provider
  has_many :reviews
  has_many :addresses
  has_one :billing
  has_one :shipping

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      full_name = auth.info.name.split(' ')
      user.email = auth.info.email
      user.first_name = full_name[0]
      user.last_name = full_name[1]
      user.image = auth.info.image
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def self.new_with_session(params, session)
    session_fb_data = session['devise.facebook_data']
    super.tap do |user|
      if data = session_fb_data && session_fb_data['extra']['raw_info']
        user.email = data['email'] if user.email.blank?
      end
    end
  end
end
