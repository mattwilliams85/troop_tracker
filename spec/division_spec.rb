require 'spec_helper'

describe Division do
  it 'has many troops' do
    test_division = Division.create({:name => 'Calvary'})
    troop1 = Troop.create({:name => 'Bill', :division_id => test_division.id})
    troop2 = Troop.create({:name => 'Joe', :division_id => test_division.id})
    expect(test_division.troops).to eq [troop1,troop2]
  end

  it 'belongs to a list' do
    test_division = Division.create({:name => "Calvary"})
    test_troop = Troop.create({:name => "Joe", :division_id => test_division.id})
    expect(test_division.troops.first).to eq test_troop
  end
end
