class ChangeDataCaptionToBooks < ActiveRecord::Migration[5.0]
  def change
    change_column :books, :caption, :text
  end
end
