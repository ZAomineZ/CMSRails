CarrierWave.configure do |config|
  config.permissions = 0666
  config.directory_permissions = 0777
  config.storage = :file
end

if Rails.env.test?
  CarrierWave.configure do |config|
    config.permissions = 0666
    config.directory_permissions = 0777
    config.storage = :file
    config.root = "#{Rails.root}/tmp"
    config.cache_dir = "#{Rails.root}/tmp/images"
    config.enable_processing = false
  end
end