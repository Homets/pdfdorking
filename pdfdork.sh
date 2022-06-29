	#!/bin/bash


#var

url="https://www.google.com/search?q="
extension="pdf"
start="&start="
country_file="domain_extension/country_domain.txt"
generic_file="domain_extension/generic_domain.txt"
user_agent="User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:101.0) Gecko/20100101 Firefox/101.0"

##Functions

function syntax_error {

	echo "Error : verify the syntax"

}

function help {

	echo "Pdfdork is a script using google advanced search engine for gathering all pdf of a specified website. "
	echo "usage : ./parsing.sh [ -h | website.com ]"

}


#If domain list file exist, check on these list if args have one of them and call scrapping func
function checking_site_extension {


	if [ -f "domain_extension/generic_domain.txt" ] && [ -f "domain_extension/country_domain.txt" ]
	then


		while read country_file_line
		do
			if [[ "$1" =~ .*"$country_file_line".* ]];then
				scrapping $1
			fi
		done < $country_file

		while read generic_file_line
		do
			if [[ "$1" =~ .*"$generic_file_line".* ]];then
				scrapping $1
			fi
		done < $generic_file


fi
}

function scrapping {

	page=1
	target=$1
	echo $target


	request=$(curl -H "$user_agent" "${url}site:%20{$target}+filetype:${extension}${start}${page}" | grep -oP "http.?://\S*.pdf" | sort -u)
	echo "$request"
}

##Script

if [[ $1 = "-h" ]];then

	echo "help"

elif [[ -n $1 ]];then

	echo "Pdfdork is a script using google advanced search engine for gathering all pdf of a specified website. "
	checking_site_extension $1

else
	syntax_error
	exit 0 
fi



