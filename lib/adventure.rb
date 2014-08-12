class Quests_Troops < ActiveRecord::Base
  def change
    belongs_to :quests
    belongs_to :troops
  end
end

