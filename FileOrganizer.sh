directory=$1

if [ -d "$directory" ]
then
	cd .*/$directory
	shopt -s nocasematch
	shopt -s globstar nullglob

	echo -e "\e[87m\e[1m[1] Organize by date (DAY-MOUNTH-YEAR FORMAT)\033[0m"
	echo -e "\e[87m\e[1m[2] Organize by first letter\033[0m"
	echo -e "\e[87m\e[1m[3] Organize by extansion\033[0m"
	echo -n -e "\e[87m\e[1mselect menu option : \033[0m"
	read menuElement
	
	case $menuElement in
	1)
		for file in ./*.*
		do
				newDir="${file:5:2}-${file:8:4}"
				mkdir -p "$newDir"
				mv -- "$file" "$newDir/"
		done
			echo -e "\e[87m\e[1mFiles organized according to date.\033[0m"
      ;;
   2)
		letterArray=(A B C Ç D E F G Ğ H I İ J K L M N O Ö P R S Ş T U Ü V Y Z W Q 0 1 2 3 4 5 6 7 8 9)
		
		for file in *.*
		do
			for letter in "${letterArray[@]}"
			do
				if [[ $letter = ${file:0:1} ]]
				then
					mkdir -p "$letter"
					mv -- "$file" "$letter/"
					break
				fi
			done
		done
		echo -e "\e[87m\e[1mFiles organized according to extansion\033[0m"
      ;;
   3)
		for file in ./*.*
		do
			extansion=$(echo $file | awk -F . '{print $NF}')
			mkdir -p "$extansion"
			mv -- "$file" "$extansion/"
		done
		echo -e "\e[87m\e[1mFiles organized according to date\033[0m"
      ;;
   *)
      echo "No such menu option"
     ;;
	esac
else
	echo -e "\e[31m\e[1mNo such directory !!! \033[0m"
	echo -n -e "\e[31m\e[1mEnter target file:\033[0m"
	read directory
fi
