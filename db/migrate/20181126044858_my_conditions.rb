class MyConditions < ActiveRecord::Migration[5.0]
  def change
    remove_column :my_conditions, :libid_for_calil, :string
    remove_column :my_conditions, :libname_for_calil, :string
    add_column :my_conditions, :systemname_for_calil, :string
    
    add_index :my_conditions, [:user_id, :systemid_for_calil], unique: true
  end
end
