if status --is-login
	for p in /usr/bin /usr/local/bin ~/bin ~/.config/fish/bin 
		if test -d $p
			set PATH $p $PATH
		end
	end
end

set -x EDITOR "vim"

set fish_greeting ""
#set -x CLICOLOR 1

function parse_git_branch
	sh -c 'git branch --no-color 2> /dev/null' | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
end

function parse_svn_revision
	sh -c 'svn info 2> /dev/null' | sed -n '/^Revision/p' | sed -e 's/^Revision: \(.*\)/\1/'
end

function fish_prompt -d "Write out the prompt"
	#printf '%s%s' (set_color brown) (whoami) (set_color normal) 

	# Color writeable dirs green, read-only dirs red
	if test -w "."
		printf ' %s%s' (set_color green) (prompt_pwd)
	else
		printf ' %s%s' (set_color red) (prompt_pwd)
	end

	# Print subversion revision
	if test -d ".svn"
		printf ' %s%s@%s' (set_color normal) (set_color blue) (parse_svn_revision)
	end

	# Print git branch
	if test -d ".git"
		printf ' %s%s/%s' (set_color normal) (set_color blue) (parse_git_branch)
	end
	if test -d "../.git"
		printf ' %s%s/%s' (set_color normal) (set_color blue) (parse_git_branch)
	end
	printf '%s> ' (set_color normal)
end

set BROWSER open

# RAILS SHORTCUTS
function ss -d "Run the script/server"
  script/server $argv;
end

function sc -d "Run the Rails console"
  script/console $argv;
end

function td -d "Tail development.log"
  tail -n 100 -f log/development.log
end

# GIT SHORTCUTS
function gs -d "Git Status"
  git status
end

function gco -d "Git checkout"
  git checkout $argv;
end

function grepr -d "grep -r exclude log and vendor"
  grep -r --exclude-dir=log --exclude-dir=vendor $argv;
end
 
function fishc -d "vi config.fish"
  vi ~/.config/fish/config.fish
end


