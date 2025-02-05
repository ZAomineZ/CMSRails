class CategoryFileUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "images/" + model.date_cat.strftime("%Y") + "/" + model.date_cat.strftime("%m") + "/" + model.date_cat.strftime("%d") + "/"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url(*args)
  end

  # Process files as they are uploaded:
  process resize_to_fit: [150, 150]

  # Create different versions of your uploaded files:
  version :icon do
    process :resize_to_fit => [50, 50]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    if file != nil
      name = "#{mounted_as}"
      parts = original_filename.split('.')
      path = parts[1]
      (name + "_" + model.slug + '.' + path) if original_filename
    end
  end
end
