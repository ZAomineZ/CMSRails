class Post < ApplicationRecord

  validates :name, presence: true, :length => {minimum: 5, maximum: 60}
  validates :descr, presence: true, :length => {minimum: 10}

  def slug=(new_slug)
    unless new_slug.empty?
      write_attribute(:slug, new_slug.parameterize)
    else
      write_attribute(:slug, name.parameterize)
    end
  end
end
