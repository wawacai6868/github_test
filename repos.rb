require 'git'
require 'grit'
require 'rugged'
require 'colored'

IGNORE = /^\.git\/?|\.{1,2}$/

def print_git
  puts "System git: \n".yellow
  system('git status')
end

def print_git_gem
  puts "git gem: \n".yellow

  git_repo = Git.open('.')

  puts "changed\n\n"
  puts git_repo.status.changed.keys

  puts "\n"

  puts "untracked\n\n"
  puts git_repo.status.untracked.keys
end

def print_grit
  puts "grit gem: \n".yellow

  puts "untracked\n\n"

  grit_repo = Grit::Repo.new('.')
  puts grit_repo.status.untracked.keys.join("\n")
end

def print_rugged
  puts "rugged gem: \n".yellow

  puts "untracked\n\n"

  rugged_repo = Rugged::Repository.new('.')
  index       = rugged_repo.index

  index_files = index.map { |i| i[:path] }
  file_system = Dir.glob('**/*', File::FNM_DOTMATCH).reject! { |f| f =~ IGNORE }

  puts file_system - index_files
end

def hr
  puts "\n" + '=' * 50 + "\n\n"
end

# ==================================================

print_git

hr

print_git_gem

hr

print_grit

hr

print_rugged
