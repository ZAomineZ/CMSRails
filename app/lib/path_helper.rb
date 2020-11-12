class PathHelper < ApplicationController

  def self.path_dir_public(entity, id)
    PathHelper.path_dir(entity, id, Rails.public_path)
  end

  def self.path_dir_spec(entity, id)
    PathHelper.path_dir(entity, id, 'tmp/')
  end

  private

  def self.path_dir(entity, id, dirname)
    File.join(dirname, 'images', entity, id.to_s)
  end

end