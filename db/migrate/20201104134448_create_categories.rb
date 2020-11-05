class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :slug
      t.text :resume
      t.text :avat_cat
      t.text :icon_cat
      t.text :date_cat
    end
  end
end
