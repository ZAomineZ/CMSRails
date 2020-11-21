class AddFileSwfToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :file_swf, :string
  end
end
