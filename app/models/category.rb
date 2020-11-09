class Category < ApplicationRecord
  self.per_page = 10

  validates :name, presence: true, :length => {minimum: 3, maximum: 60}
  validates :resume, presence: true, :length => {minimum: 10}

  scope :find_by_slug, -> (slug) { where("slug" => slug) }
  scope :search, -> (q) { where("name LIKE ?", "%#{q}%") }

  def getResume
    read_attribute(:resume)[0, 150] + '...'
  end

  def date_cat
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
      if categories.index(',') != nil
        data = categories.split(',')
      else
        data = [categories]
      end

      data.each do |category|
        slug = category.parameterize
        cat = Category.find_by_slug(slug).to_a
        if cat.empty?
          dont_exist = true
        end
      end
    end
    return dont_exist
  end
end
