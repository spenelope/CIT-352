function print_usage {
    echo "Usage: myuseradd.sh -a <login> <passwd> <shell> - add a user account"
    echo "myuseradd.sh -d <login> - remove a user account"
    echo "myuseradd.sh -h          - display this usage message"
}

function options () {
    if [[ $1 == '-h' ]] 
    then   
        print_usage
    elif [[ $1 == '-d' ]]
    then
        delete_user $2 $3
    elif [[ $1 == '-a' ]]
    then
        add_user $2 $3 $4
    else
        echo "ERROR"
        print_usage
    fi
}

options $1 $2 $3 $4
