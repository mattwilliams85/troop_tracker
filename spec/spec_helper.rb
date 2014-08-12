require 'rspec'
require 'active_record'
require 'pry'

require 'troop'
require 'division'
require 'quest'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["test"])

RSpec.configure do |config|
  config.after(:each) do
    Troop.all.each { |troop| troop.destroy }
    Division.all.each { |division| division.destroy }
  end
end
