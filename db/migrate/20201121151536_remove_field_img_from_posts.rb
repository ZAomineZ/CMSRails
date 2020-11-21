class RemoveFieldImgFromPosts < ActiveRecord::Migration[6.0]
  def up
    remove_column :posts, :img_original
    remove_column :posts, :img_medium
    remove_column :posts, :img_mini
    remove_column :posts, :img_thumb
  end
end
