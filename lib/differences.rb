# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
# This was fun

def check_usage
  unless ARGV.length == 2
    puts "Usage: differences.rb new-inventory.txt old-inventory.txt"
    exit
  end
end


def boring?(line)
  contains?(line, 'temp') or
    contains?(line, 'recycler')
end

def contains?(line,check)
  line.split('/').include?(check)
end

def inventory_from(filename)
  inventory = File.open(filename)
  downcased = inventory.collect do |line|
    line.chomp.downcase
  end
  downcased.reject do |line|
    boring?(line)
  end
end

def compare_inventory_files(old_file, new_file)
  old_inventory = inventory_from(old_file)
  new_inventory = inventory_from(new_file)

  number_added = (new_inventory - old_inventory).length
  number_removed = (old_inventory - new_inventory).length
  number_unchanged = (new_inventory & old_inventory).length

  puts "The following files have been added:"
  puts new_inventory - old_inventory
  puts "Number of files added:"
  puts number_added

  puts ""
  puts "The following files have been deleted:"
  puts old_inventory - new_inventory
  puts "Number of files removed:"
  puts number_removed

  puts ""
  puts "Number of files unchanged:"
  puts number_unchanged
end

if $0 == __FILE__
  check_usage
  compare_inventory_files(ARGV[0], ARGV[1])
end
