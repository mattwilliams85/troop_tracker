require 'spec_helper'

describe Troop do
  describe "assign" do
    it "assings a quest to a trooper" do
      bob = Troop.create(name: 'Bob')
      pillage = Quest.create(name: 'Pillage')
      bob.quests << pillage
      expect(bob.quests.first).to eq pillage
    end
  end
end
