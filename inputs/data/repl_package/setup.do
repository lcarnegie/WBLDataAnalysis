
program main
	* *** Add required packages from SSC to this list ***
	local ssc_packages "lgraph" "xml_tab" "ds3"
	* *** Add required packages from SSC to this list ***
	if !missing("`ssc_packages'") {
	foreach pkg in "`ssc_packages'" {
	dis "Installing `pkg'"
	quietly ssc install `pkg', replace
	}
	}
	quietly cap net uninstall grc1leg
	quietly net install grc1leg, from(http://www.stata.com/users/vwiggins)
	cap net install dm89_2, from(http://www.stata-journal.com/software/sj15-4)
end
main
