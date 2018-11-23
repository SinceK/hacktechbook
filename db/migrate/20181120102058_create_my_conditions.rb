class CreateMyConditions < ActiveRecord::Migration[5.0]
  def change
    create_table :my_conditions do |t|
      t.references :user, foreign_key: true
      t.string :systemid_for_calil
      t.string :libid_for_calil
      t.string :libname_for_calil

      t.timestamps
    end
  end
end
