class CreateAdventures < ActiveRecord::Migration
  def change
    create_table :adventures do |t|
      t.column :quest_id, :integer
      t.column :troop_id, :integer
      t.column :deeds, :string

      t.timestamps
    end
  end
end
