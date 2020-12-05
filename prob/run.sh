#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
GRAY='\033[1;30m'
WHITE='\033[1;37m'
LIGHT_BLUE='\033[1;36m'
NC='\033[0m'

flag=$1
# checker=checker_ignore_spaces
# 
# if [ $3 == "double" ] 
# then
# 	checker=checker_double
# fi 
# 
# folder=~/Documents/contest
# checker=$folder/$checker

# dir="problem_$id"

write_info() {
	COLOR=$RED
	if [ $2 == "OK" ] 
	then
		COLOR=$GREEN
	elif [ "$2" == "??" ]
	then 
	 	COLOR=$WHITE
	fi
	echo -e "TEST $1: ${COLOR}$2${NC}, time: ${LIGHT_BLUE}$3${NC}"
}

write_input() {
	echo -ne "\ninput:\n"
	echo -e "${WHITE}$(cat $1)${NC}"
}

write_correct() {
	echo -ne "\ncorrect:\n"
	echo -e "${WHITE}$(cat -n $1)${NC}"
}

write_answer() {
	echo -ne "\noutput:\n"
	echo -e "${LIGHT_BLUE}$(cat -n $1)${NC}"
}

write_error() {
	echo -ne "\ndiff:\n"
	echo -e "${RED}$(cat $1)${NC}"
}

write_separator_line() {
	echo -e "────────────────────────────"
}

write_separator_line

for i in tests/*.dat
do
	test=$(basename $i .dat)
	input=tests/$test.dat
	answer=tests/$test.res

	START=$(python3 -c 'from time import time; print(int(round(time() * 1000)))')
	
	./main <$input >$answer 2>/dev/null 
	CODE=$(echo $?)

	END=$(python3 -c 'from time import time; print(int(round(time() * 1000)))')

	DIST=$(($END - $START))
	# echo $DIST
	TIME=$(bc -l <<< $DIST/1000)
	
	if [ "${TIME:0:1}" == "." ] 
	then
		TIME=0$TIME
	fi
	TIME=${TIME:0:8}

	correct=tests/$test.ans

	if [ "$CODE" != "0" ]
	then
		write_info $test RE $TIME
		write_input $dir/$test.in
		write_correct $correct
		write_separator_line

		if [ "$flag" == "1" ] 
		then 
			break
		fi 
	else 
		if [ "$flag" == "3" ] 
		then 
			write_info $test "??" $TIME
			write_input $input
			write_correct $correct
			write_answer $answer
			write_separator_line
		else
			error=tests/error
		    diff $answer $correct >$error 2>> /dev/null
			VERDICT=$?
			# echo $checker
			if [ "$VERDICT" != "0" ]
			then 
				write_info $test WA $TIME
				write_input $input
				write_correct $correct
				write_answer $answer
				write_error $error
				write_separator_line
				if [ "$flag" == "1" ] 
				then 
					break
				fi 
			else 
				write_info $test OK $TIME
				if [ "$flag" == "2" ] 
				then
					write_input $input
					write_correct $correct
				fi
				write_separator_line
			fi
		fi	
	fi
done

rm -rf answer
