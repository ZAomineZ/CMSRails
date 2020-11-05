class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :name
      t.string :slug
      t.text :descr
      t.datetime :date_post
      t.text :img_original
      t.text :img_medium
      t.text :img_thumb
      t.text :img_mini
    end
  end
end
