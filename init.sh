#! /bin/bash

MY_DIRECTORY=~/Documents/HW/course_2/caos/  # your directory
HOMEWORK_NAME=$1
PROBLEM_NAME=$2

FOLDER=$MY_DIRECTORY/$HOMEWORK_NAME

mkdir $FOLDER 2> /dev/null
rm -rf $FOLDER/prob_$PROBLEM_NAME
cp -r $MY_DIRECTORY/prob $FOLDER/prob_$PROBLEM_NAME


