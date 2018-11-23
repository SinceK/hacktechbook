class AddDetailsToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :price, :integer
    add_column :books, :author, :string
    add_column :books, :caption, :string
  end
end
