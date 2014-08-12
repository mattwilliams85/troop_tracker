class RenameQuestTroops < ActiveRecord::Migration
  def change
     rename_table :quests_troops, :adventures
  end
end
