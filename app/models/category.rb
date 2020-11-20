require 'fileutils'

class Category < ApplicationRecord
  mount_uploader :avat_cat, CategoryFileUploader

  validates :name, presence: true, :length => {minimum: 3, maximum: 60}
  validates :resume, presence: true, :length => {minimum: 10}

  scope :find_by_slug, -> (slug) { where('slug' => slug) }
  scope :find_by_name, -> (name) { where('name' => name) }
  scope :search, -> (q) { where("name LIKE ?", "%#{q}%") }
  scope :desc, -> () { order('id DESC') }

  def getResume
    read_attribute(:resume)[0, 150] + "..."
  end

  def get_date_cat
    date_cat = read_attribute(:date_cat)
    DateTime.parse(date_cat).strftime("%m %B %Y")
  end

  def slug=(new_slug)
    unless new_slug.empty?
      write_attribute(:slug, new_slug.parameterize)
    else
      write_attribute(:slug, name.parameterize)
    end
  end

  def self.dontExist(categories)
    dont_exist = false

    unless categories === nil
      data = self.get_categories(categories)
      data.each do |category|
        slug = category.parameterize

        cat_data_slug = Category.find_by_slug(slug).to_a
        cat_data_name = Category.find_by_name(category).to_a
        if cat_data_slug.empty? && cat_data_name.empty?
          dont_exist = true
        end
      end
    end
    return dont_exist
  end

  def self.check_idem(categories)
    categories_uniq_data = self.get_categories(categories).uniq
    categories = self.get_categories(categories)
    return categories_uniq_data.length != categories.length
  end

  private

  def self.get_categories(categories)
    if categories.index(',') != nil
      categories = categories.split(',')
    else
      categories = [categories]
    end
    return categories
  end

  def self.unlink_image(record)
    directory = PathHelper.path_dir_public(record.class.name.downcase, record.id)
    FileUtils.rm_r(directory) if Dir.exist?(directory)
  end
end
