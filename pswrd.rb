#!/usr/bin/env ruby

require 'sqlite3'

$stdout.sync = true

$db = SQLite3::Database.new 'pswrd.db'

PROMPT="> "

def add
  entry = Array.new
  puts "Enter Website/Program name"
  print PROMPT
  entry.push gets.chomp
  puts "Enter E-mail/User name"
  print PROMPT
  entry.push gets.chomp
  puts "Enter password"
  print PROMPT
  entry.push gets.chomp
  puts "Confirm password"
  print PROMPT
  pswrdConf = gets.chomp
  while entry[2] != pswrdConf
    puts "Passwords do not match. Re-enter password"
    print PROMPT
    entry[2] = gets.chomp
    puts "Confirm password"
    print PROMPT
    pswrdConf = gets.chomp
  end
  $db.execute 'INSERT INTO passwords VALUES(NULL,?,?,?)', entry
end

def get
  puts "Enter app name"
  print PROMPT
  name = gets.chomp
  results = $db.execute 'SELECT password FROM passwords WHERE name = ?', name
  results.each do |r|
    puts r
  end
end

def all
  puts "Printing All"
  results = $db.execute 'SELECT * FROM passwords' 
  puts results
end


def main
  puts "Welcome to Password Manager"
  puts "Enter Command"
  print PROMPT
  while cmd = gets.chomp
    if cmd == "add"
      add
    elsif cmd == "get"
      get
    elsif cmd == "all"
      all
    elsif cmd == "q"
      puts "Quitting"
      return
    else 
      puts "Invalid Command"
    end
    puts "Enter Command"
    print PROMPT
  end
end
main
