class RenameAdventures < ActiveRecord::Migration
  def change
    rename_table :adventures, :quests_troops
  end
end
