class CreateTurnovers < ActiveRecord::Migration[7.1]
  def change
    create_table :turnovers do |t|
      t.string :successful_turnover_date
      t.boolean :success

      t.timestamps
    end
    change_column_default :turnovers, :success, false
  end
end
