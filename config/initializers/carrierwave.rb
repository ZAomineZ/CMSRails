if Rails.env.test? or Rails.env.cucumber?
  CarrierWave.configure do |config|
    config.storage = :file
    config.root = "#{Rails.root}/tmp"
    config.cache_dir = "#{Rails.root}/tmp/images"
    config.enable_processing = false
  end
else
  CarrierWave.configure do |config|
    config.permissions = 0666
    config.directory_permissions = 0777
    config.storage = :file
  end
end