require 'grit'
require 'rugged'
require 'colored'

def print_git
  puts "Untracked files according to git: \n".yellow
  system('git status')
end

def print_grit
  puts "Untracked files according to grit: \n".yellow

  grit_repo = Grit::Repo.new('.')
  puts grit_repo.status.untracked.keys.join("\n")
end

def print_rugged
  puts "Untracked files according to rugged: \n".yellow

  rugged_repo = Rugged::Repository.new('.')
  index = rugged_repo.index
end

def hr
  puts "\n" + '=' * 50 + "\n\n"
end

# ==================================================

print_git

hr

print_grit

hr

print_rugged
