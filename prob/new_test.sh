
query=$1

if [ "$query" == "add" ]
then
    name=tests/$2
    rm -rf $name.dat $name.ans $name.res > /dev/null
    vim $name.dat
    vim $name.ans
elif [ "$query" == "remove" ]
then
    name=tests/$2
    rm -rf $name.dat $name.ans $name.res > /dev/null
elif [ "$query" == "edit" ]
then
    name=tests/$2
    vim $name.dat
    vim $name.ans
fi
