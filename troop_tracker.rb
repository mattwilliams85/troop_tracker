require 'active_record'
require './lib/troop'
require './lib/division'

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

def invalid
  puts "Sorry that isn't a valid option!"
  sleep(0.7)
end

def main_menu
  input = nil
  until input == '6'
    header
    puts "1 > Add trooper"
    puts "2 > List troopers"
    puts "3 > Add division"
    puts "4 > List divisions"
    puts "5 > Assign trooper to division"
    puts "6 > Exit"
    input = gets.chomp
    case input
    when '1'
      add('Troop')
    when '2'
      list('Troop')
    when '3'
      add('Division')
    when '4'
      list('Division')
    when '5'
      assign_division
    when '6'
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
  new_class = Object.const_get(class_name).new({:name => input})
  new_class.save
  puts "'#{input}' has been added!"
  sleep(0.7)
end

def list(class_name)
  puts "Here is the current roster:"
  class_data = Object.const_get(class_name).all
  class_data.each { |data| puts data.name}
  puts "[Hit enter to continue]"
  gets.chomp
end

main_menu



