class RemovePrefectureCodeFromMyConditions < ActiveRecord::Migration[5.0]
  def change
    remove_column :my_conditions, :prefecture_code, :integer
  end
end
