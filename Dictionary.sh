word=$1
shopt -s nocasematch

if [ ! -f wordHistory.txt ]
then 
	echo -e "\e[87m\e[1mWord base created.  \033[0m"
	touch wordHistory.txt
	chmod 777 wordHistory.txt
fi

	if [[ `wget -S --spider "http://birsozluk.com/1/$word/"  2>&1 | grep 'HTTP/1.1 200 OK'` ]] 
	# To change the offline mod --> "http://birsozluk.com/1/$word/" to "http://xbirsozluk.com/1/$word/" or like
	then 
		wget -q "http://birsozluk.com/1/$word/" -O website.txt
		echo -e "\e[87m\e[1mConnected.  \033[0m"
		
		boldredOFF=$'\033[0m'
		boldredON=$'\e[31m\e[1m'
		
		\(hgadrsfhds\)
		
		
		deff=$(grep '</b><br>.*:' website.txt | sed "s/.*<\/b><br>//g" | sed "s/:<BR>.*//g" | sed "s/<br><hr>/\n/g" |\
		 sed "s/<I>.*<\/I>//g" | sed "s/<b>\"//g" | sed "s/\"<\/b>/ /g" | sed "s/<br>/ /g" | sed "s/<hr>.*//g" |\
		  sed "s/Sayı.*<\/iframe>/${boldredON} Invalid Input!${boldredOFF}/g" | sed "s/.*<\/iframe>/${boldredON} Meaning Not Found !!!${boldredOFF}/g")

		echo -e "\e[31m\e[1mWord :\033[0m \e[87m\e[1m $word \033[0m" > definition.txt
		echo -e "\e[31m\e[1mDefinition :\033[0m " >> definition.txt
		echo -e  "\e[87m\e[1m$deff \033[0m" >> definition.txt
		echo "<end>" >> definition.txt
		echo "----------------------------" >> definition.txt
	
		if [[ "$deff" == *"Meaning Not Found !!!"* ]]
		then
			echo ""
		else
			if grep -q "Word : $word" wordHistory.txt
			then
				echo ""
			else
				echo "Word : $word" >> wordHistory.txt
				echo "Definition : " >> wordHistory.txt
				echo "$deff " >> wordHistory.txt
				echo "<end>" >> wordHistory.txt
				echo "----------------------------" >> wordHistory.txt
			fi
		fi
		
		file=$(less definition.txt | sed "s/<end>.*//g")
		echo "$file"
		rm website.txt
		
	else
		echo -e "\e[31m\e[1mWebsite connection failed!!!  \033[0m"
		echo -e "\e[31m\e[1mChecking word offline : \033[0m"
		
		if grep -q "Word : $word" wordHistory.txt
		then
			deff=$(cat wordHistory.txt)
			deff2=$(echo $deff | sed "s/.*Word : $word/Word : $word \n/g")
			deff=$(echo $deff2 | sed "s/<end>.*//g")
			echo -e "\e[87m\e[1m$deff  \033[0m"
		else
			echo -e "\e[31m\e[1m$word not found in wordHistory.txt !!! \033[0m"
	fi	
fi
