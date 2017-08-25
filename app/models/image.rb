class Image < ApplicationRecord
  mount_uploader :images, ImagesUploader
  belongs_to :book
  validates :file, presence: true
end
