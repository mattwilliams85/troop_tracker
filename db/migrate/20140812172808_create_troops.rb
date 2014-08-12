class CreateTroops < ActiveRecord::Migration
  def change
    create_table :troops do |t|
      t.column :name, :string

      t.timestamps
    end
  end
end
