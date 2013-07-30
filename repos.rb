require 'grit'
require 'rugged'
require 'colored'

IGNORE = /^\.git\/?|\.{1,2}$/

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
  puts "Files not index by rugged: (manually calculated) \n".yellow

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

print_grit

hr

print_rugged
