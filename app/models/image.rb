class Image < ApplicationRecord
  mount_uploader :images, ImagesUploader
  belongs_to :book
  validates :file, presence: true
  validates_format_of :file, {
    with: /\.(jpg|jpeg|gif|png|bmp)\Z/i,
    message: 'must be a URL for GIF, JPG, JPEG, BMP or PNG image.'
  }
  validates_format_of :file, with: URI.regexp
end
