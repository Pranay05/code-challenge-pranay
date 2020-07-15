# == Schema Information
#
# Table name: companies
#
#  id       :bigint           not null, primary key
#  name     :string
#  zip_code :string
#  phone    :string
#  email    :string
#  city     :string
#  state    :string
#
class Company < ApplicationRecord
  has_rich_text :description
  validates_presence_of :name
  validates_presence_of :zip_code
  validates :zip_code,
            length: {
              minimum: 5
            }
  VALID_EMAIL_REGEX =  /\A([^@\s]+)@getmainstreet.com\Z/i
  validates :email,:allow_blank => true, :format => { :with =>  VALID_EMAIL_REGEX}

  before_save :city_and_state_based_on_pincode

  def city_and_state_based_on_pincode
    if zip_code.present? && zip_code_changed?
      location = fetch_location
      raise StandardError.new('not valid zipcode') if location.nil?
      self.city = location[:city]
      self.state = location[:state_name]
    end
  end

  def fetch_location
    ZipCodes.identify(zip_code)
  end
end
