require 'fileutils'

class Post < ApplicationRecord

  mount_uploader :img_original, PostFileUploader

  validates :name, presence: true, :length => {minimum: 5, maximum: 60}
  validates :descr, presence: true, :length => {minimum: 10}

  scope :search, -> (q) { where("name LIKE ?", "%#{q}%") }
  scope :find_by_name, -> (name) { where('name' => name) }
  scope :desc, -> () { order('id DESC') }

  def slug=(new_slug)
    unless new_slug.empty?
      write_attribute(:slug, new_slug.parameterize)
    else
      write_attribute(:slug, name.parameterize)
    end
  end

  private

  def self.unlink_image(record)
    directory = PathHelper.path_dir_public(record.class.name.downcase, record.id)
    FileUtils.rm_rf(directory) if Dir.exist?(directory)
  end
end
