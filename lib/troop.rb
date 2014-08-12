class Troop < ActiveRecord::Base

  belongs_to :divisions
  has_and_belongs_to_many :quests

end
