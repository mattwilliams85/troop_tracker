require 'active_record'
require 'pry'

require './lib/troop'
require './lib/division'
require './lib/quest'
require './lib/adventure'
database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def header
  system 'clear'
  puts "
█▀▀█ 　 ▀▀█▀▀ █▀▀█ █▀▀█ █▀▀█ █▀▀█ 　 ▀▀█▀▀ █▀▀█ █▀▀█ █▀▀ █░█ █▀▀ █▀▀█ 　 █▀▀█
█  █ 　 ░▒█░░ █▄▄▀ █░░█ █░░█ █░░█ 　 ░▒█░░ █▄▄▀ █▄▄█ █░░ █▀▄ █▀▀ █▄▄▀ 　 █  █
█▄▄█ 　 ░▒█░░ ▀░▀▀ ▀▀▀▀ ▀▀▀▀ █▀▀▀ 　 ░▒█░░ ▀░▀▀ ▀░░▀ ▀▀▀ ▀░▀ ▀▀▀ ▀░▀▀ 　 █▄▄█
"

  puts "\n"
end

def line
  puts "-------------------------"
end

def invalid
  puts "Sorry that isn't a valid option!"
  sleep(0.7)
end


def main_menu
  input = nil
  until input == 'X'
    header
    puts "1 > Add trooper"
    puts "2 > List troopers"
    puts "3 > Delete troopers"
    puts "4 > Add division"
    puts "5 > List divisions"
    puts "6 > Delete divisions"
    puts "7 > Assign trooper to division"
    puts "8 > Add quest"
    puts "9 > List quests"
    puts "10 > Delete quests"
    puts "11 > Assign trooper to quest"
    puts "X > Exit"
    input = gets.chomp.upcase
    case input
    when '1'
      add('Troop')
    when '2'
      assignment_list
      puts "[hit enter to continue]"
      gets.chomp
    when '3'
      delete('Troop')
    when '4'
      add('Division')
    when '5'
      troop_list('Division')
      puts "[Hit enter to continue]"
      gets.chomp
    when '6'
      delete('Division')
    when '7'
      assign_to_division
    when '8'
      add('Quest')
    when '9'
      troop_list('Quest')
      puts "[Hit enter to continue]"
      gets.chomp
    when '10'
      delete('Quest')
    when '11'
      assign_to_quest
    when 'X'
      puts "You are dismissed private!"
      exit
    else
      invalid
    end
  end
end

def add(class_name)
  puts "Enter the name you would you like to add"
  input = gets.chomp
  new_class = Object.const_get(class_name).create({:name => input})
  puts "'#{input}' has been added!"
  sleep(0.7)
end

def assignment_list
  puts "Here is the current roster:"
  line
  Troop.all.each do |troop|
    puts "[==#{troop.name.capitalize}==]"
    division = Division.find_by(id: troop.division_id)
    if division != nil
      puts "  *DIVISION: " + division.name
    end
    adventures = Quests_Troops.where(troop_id: troop.id)
    if adventures != nil
      adventures.each do |adventure|
        quest = Quest.find_by(id: adventure.quest_id)
        puts "  *QUEST: " + quest.name
      end
    end
  end
  puts ""
end

def troop_list(class_name)
  puts "Here are the assigned troops:"
  assignments = Object.const_get(class_name).all
  assignments.each do |assignment|
    puts "[==#{assignment.name}==]"
    assignment.troops.each do |troop|
      puts "  *" + troop.name.capitalize
    end
  end
end

def list(class_name)
  puts "Here is the current roster:"
  line
  class_data = Object.const_get(class_name).all
  class_data.each { |data| puts data.name}
  line
end

def assign_to_division
  puts "Select a trooper:"
  list('Troop')
  trooper = Troop.find_by(name: check('Troop'))
  puts "Which division should #{trooper.name} be assigned to?"
  list('Division')
  assignment = Division.find_by(name: check('Division'))
  assignment.troops << trooper
  puts "#{trooper.name} added to #{assignment.name}!"
  sleep(0.7)
end

def assign_to_quest
  puts "Select a trooper:"
  list('Troop')
  trooper = Troop.find_by(name: check('Troop'))
  puts "Which quest should #{trooper.name} embark on?"
  list('Quest')
  assignment = Quest.find_by(name: check('Quest'))
  trooper.quests << assignment
  puts "#{trooper.name} added to #{assignment.name}!"
  sleep(0.7)
end

def delete(class_name)
  puts "Enter the name to delete it:"
  list(class_name)
  entity = Object.const_get(class_name).find_by(name: check(class_name))
  entity.destroy
  puts "#{entity.name} removed."
  sleep(0.7)
end

def check(class_name)
  input = gets.chomp
  result = Object.const_get(class_name).find_by(name: input)
  if result == nil
    invalid
    main_menu
  else
    input
  end
end

main_menu



