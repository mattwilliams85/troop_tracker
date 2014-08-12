class CreateDivisions < ActiveRecord::Migration
  def change
    create_table :divisions do |t|
      t.column :name, :string

      t.timestamps
    end

    add_column :troops, :division_id, :integer
  end
end
