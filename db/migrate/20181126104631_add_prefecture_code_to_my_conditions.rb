class AddPrefectureCodeToMyConditions < ActiveRecord::Migration[5.0]
  def change
    add_column :my_conditions, :prefecture_code, :string
  end
end
