# require 'mini_magick'

# Photo uloader for Books
class ImagesUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :fog
  process resize_to_fit: [350, 350]

  def store_dir
    return 'dev' if Rails.env.development?
    'shop/images'
  end

  def cache_dir
    "#{Rails.root}/tmp/cache/images"
  end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  def extension_whitelist
    %w[jpg jpeg gif png bmp]
  end

  def filename
    "#{SecureRandom.uuid}.#{file.extension}" if original_filename.present?
  end
end
