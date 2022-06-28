#!/bin/bash



#var

url="https://www.google.com/search?q="
extension="pdf"
start=1
country_file="domain_extension/country_domain.txt"
generic_file="domain_extension/generic_domain.txt"


##Functions

function syntax_error {

	echo "Error : verify the syntax"

}

function help {

	echo "help"

}

#If domain list file exist, check on these list if args have one of them
function checking_site_extension {


	if [ -f "domain_extension/generic_domain.txt" ] && [ -f "domain_extension/country_domain.txt" ]
	then
		extension_exist=0

		while read country_file_line
		do
			if [ 
		done < $country_file




	fi
}



##Script

if [[ $1 = "-h" ]];then

	echo "help"

elif [[ -n $1 ]];then

	checking_site_extension

else
	syntax_error
	exit 0 
fi



