if status --is-interactive
    # remove default greeting without affecting the variable
    function fish_greeting
    end

    # wrap outputs into a greeter
    function _greet_wrapper
	echo "𓆟  𓆝  𓆟  Fish interactive mode 𓆝  𓆛  𓆝 "
	echo "Fish config \""(status filename)"\" loaded"
	
	# prepend tab space onto piped-in lines
	while read --function --list input_str -d "\n"
	    printf '\t%s\n' $input_str
	end

	echo "𓆝  𓆟  𓆝  𓆛  𓆝  𓆛  𓆝  𓆛  𓆝  𓆛  𓆝  𓆛  𓆝 "
    end

    # apply mods
    function _mods
	echo -e "View a function definition using 'functions <function>'\n"

	## Aliases
	echo "Alias functions:"

	# nvcat (new)
	set nvcat_desc "View file contents using nvimpager instead of cat"
	echo -e "\t nvcat \t => nvimpager"
	function nvcat -d $nvcat_desc
	    command nvimpager $(string escape $argv)
	end

	# ls (replaces)
	set ls_opts "-QAXvF --color --group-directories-first"
	echo -e "\t ls \t => ls $ls_opts"
	function ls -V ls_opts -w ls
	    set cmd "command ls $ls_opts $(echo (string escape -- $argv))"
	    eval $cmd
	end


    end

    # exec mods and greet
    _mods | _greet_wrapper

    # unload function defs from global scope
    functions -e _mods _greet_wrapper
end

