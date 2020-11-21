class RemoveFieldCategoryIdFromPosts < ActiveRecord::Migration[6.0]
  def up
    remove_column :posts, :category_id
  end
end
