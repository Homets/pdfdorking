#!/bin/bash


##Variable

url="https://www.google.com/search?q="
extension="pdf"
start="&start="
country_file="domain_extension/country_domain.txt"
generic_file="domain_extension/generic_domain.txt"
user_agent="User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.0.0 Safari/537.36 Edg/103.0.1264.37"

##Functions

function syntax_error {

	echo "Error : verify the syntax ! -h for help"

}

function help {

	echo "Pdfdork is a script using google advanced search engine for gathering all pdf of a specified website. "
	echo "usage : ./parsing.sh [ -h | website.com | -o output.file ]"
	echo "-o: choose the output file"
	echo "-h: display this command"

}


#If domain list file exist, check on these list if args have one of them and call scrapping func
function checking_site_extension {


	if [ -f "domain_extension/generic_domain.txt" ] && [ -f "domain_extension/country_domain.txt" ]
	then


		while read country_file_line
			do
			if [[ "$1" =~ .*"$country_file_line".* ]];then
				scrapping $1 $2 $3
			fi
		done < $country_file

		while read generic_file_line
		do
			if [[ "$1" =~ .*"$generic_file_line".* ]];then
				scrapping $1 $2 $3
			fi
		done < $generic_file


fi
}





#Function for gathering pdf link
function scrapping {

	page=1
	target=$1

	while [[ $page -ne 15 ]]
	do
		request=$(curl -s -H "$user_agent" "${url}site:%20{$target}+filetype:${extension}${start}${page}" | grep -oP "http.?://\S*.pdf" | grep -v "google" | sort -u)

		if [[ "$2" = "-o" ]] && [[ -n "$3" ]];then
			echo $request
			echo $request >> $3

		else

			echo $request

		fi

		page=$((page+1))
	done

	exit 0
}



## Start
	echo ""
        echo "################################"
        echo "            PDF DORK            "
        echo "################################"
        echo ""
        echo "Pdfdork is a script using google advanced search engine for gathering all pdf of a specified website. "
        echo ""

if [[ $1 = "-h" ]];then

	help

elif [[ $2 = "-o" ]] && [[ -n $3 ]];then


	if [[ -f $3 ]];then

		checking_site_extension $1 $2 $3
	else

		touch $3
		checking_site_extension $1 $2 $3

	fi
        checking_site_extension $1 $2 $3

elif [[ -n $1 ]];then

	checking_site_extension $1

else
	syntax_error
	exit 0
fi



