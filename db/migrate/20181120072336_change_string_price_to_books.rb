class ChangeStringPriceToBooks < ActiveRecord::Migration[5.0]
  def change
    change_column :books, :price, :string
  end
end
