input=$1
shopt -s nocasematch
shopt -s globstar nullglob
if [ -d "$input" ]
then
	cd .*/$input
	echo -n -e "\e[87m\e[1mEnter a word to search :  \033[0m"
	read word
	for file in ./*.*
	do
		echo -n -e "\e[31m\e[1mNumber of words counted in $file : \033[0m \e[87m\e[1m" 
		grep -o $word $file | wc -w
		echo -e "\033[0m "
	done
elif [ -f "$input" ]
then 
	echo -n -e "\e[87m\e[1mEnter a word to search :  \033[0m"
	read word
	echo -n -e "\e[31m\e[1mOccurence of this word in the file is \033[0m \e[87m\e[1m"
	grep -o $word $input | wc -w
	echo -e "\033[0m "
else
	echo -e "\e[31m\e[1mNo such directory or file !!! \033[0m"
	echo -n -e "\e[31m\e[1mEnter target file:\033[0m"
	read input
fi
