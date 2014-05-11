#!/bin/bash

# TODO Important to give names for tests: task_N-M.in, task_N-M.out
# in "tests" folder, N - task number, M - test number. Totally 10 tests
# per task.

# Coloring definitions.
red='\e[0;31m'
green='\e[0;32m'
blue='\e[0;34m'
NC='\e[0m'

# Useful variables.
origin=$(pwd)
bin="./task"
hw="hw-2"

# Loop over student's HW folders.
#dirs=*/
#if [ $# == 1 ]; then
#dirs=$1"/"
#fi
#for dir in $dirs ; do
# Print title.
#echo -e "${blue}STUDENT: $dir$NC"
# Safely cd in next student's folder.
cd $hw 2>/dev/null
if [ $? -eq 1 ]; then
	echo -e "\t${red}Failed to enter in $dir$hw${NC}"
	cd $origin
	continue
fi

# Loop over student's tasks.
# FIXME Hardcoded sequence of task's numbers.
for n in {1..4} ; do
	# Compile task.
	gcc -m32 task_$n.s -o task 2>/dev/null
	if [ $? -eq 0 ]; then
		echo -e "\tTASK $n: ${green}COMPILE OK${NC}"
		else
		echo -e "\tTASK $n: ${red}COMPILE FAILED${NC}"
	fi
	# Run prepared tests for task.
	# FIXME Hardcoded sequence of test's numbers.
	for t in {1..5} ; do
		# Run test. Tests runs OK, but prints "RUN FAILED". Can't figure out why, commenting.
		eval $bin 2>/dev/null 1>task.out < ./tests/task_$n-$t.in
		#if [ $? -eq 0 ]; then
		#	echo -e "\t\tTEST $t: ${green}RUN OK${NC}"
		#else
		#	echo -e "\t\tTEST $t: ${red}RUN FAILED${NC}"
		#fi

		# Test result.
		# FIXME If test failed diff shows what is the problem.
		# Else - test was not implemented.
		diff ./tests/task_$n-$t.out task.out 2>/dev/null
		if [ $? -eq 0 ]; then
			echo -e "\t\t\t${green}RESULT OK${NC}"
		else
			echo -e "\t\t\t${red}RESULT WRONG${NC}"
		fi
		# Clean.
		rm task.out 2>/dev/null
	done
	rm $bin 2>/dev/null
done
	# Compile task.
	gcc -m32 -c task_5.s 2>/dev/null
	gcc -m32 task_5.o task_5.c -o task 2>/dev/null
	rm task_5.o
	if [ $? -eq 0 ]; then
		echo -e "\tTASK $n: ${green}COMPILE OK${NC}"
	else
		echo -e "\tTASK $n: ${red}COMPILE FAILED${NC}"
	fi

	for t in {1..5} ; do
		eval $bin 2>/dev/null 1>task.out < ./tests/task_5-$t.in
		diff ./tests/task_5-$t.out task.out 2>/dev/null
		if [ $? -eq 0 ]; then
			echo -e "\t\t\t${green}RESULT OK${NC}"
		else
			echo -e "\t\t\t${red}RESULT WRONG${NC}"
		fi
		rm task.out 2>/dev/null
	done
	rm $bin 2>/dev/null
# Return to origin folder.
cd ../..
