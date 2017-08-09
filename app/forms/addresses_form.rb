class AddressesForm
  attr_reader :params

  include ActiveModel::Model
  include Virtus.model

  def self.submit(*args)
    new(*args).save
  end

  def initialize(params, user_id)
    @params = params
    @params[:billing][:user_id] = user_id
    @params[:shipping][:user_id] = user_id
  end

  attribute :id, Integer
  attribute :first_name, String
  attribute :last_name, String
  attribute :address, String
  attribute :city, String
  attribute :zip, Integer
  attribute :country, String
  attribute :phone, String

  validates :first_name, :last_name, :address, :city, :zip, :country, :phone, presence: true
  validates_length_of :first_name, :last_name, :address, :city, :country, maximum: 50
  validates :first_name, :last_name, :city, format: { with: /[A-Za-z]/ }
  validates_length_of :phone, maximum: 15
  validates_length_of :zip, maximum: 10

  def persisted?
    false
  end

  def save
    return false unless valid?
    persist!
    true
  end

private

  def persist!
    Billing.new(billing_params).save
    Shipping.new(shipping_params).save
  end

  def shipping_params
    params.require(:shipping).permit(permited)
  end

  def billing_params
    params.require(:billing).permit(permited)
  end

  def permited
    [
      :first_name,
      :last_name,
      :address,
      :city,
      :zip,
      :country,
      :phone,
      :user_id
    ]
  end
end
