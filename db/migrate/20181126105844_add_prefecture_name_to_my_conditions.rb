class AddPrefectureNameToMyConditions < ActiveRecord::Migration[5.0]
  def change
    add_column :my_conditions, :prefecture_name, :string
  end
end
