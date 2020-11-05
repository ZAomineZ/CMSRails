class Category < ApplicationRecord
  self.per_page = 10

  validates :name, presence: true, :length => {minimum: 3, maximum: 60}
  validates :resume, presence: true, :length => {minimum: 10}

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
end
