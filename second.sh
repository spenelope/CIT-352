#stage 1: display menu, and prompt options
function print_menu {
    echo "Usage: myuseradd.sh -a <login> <passwd> <shell> - add a user account"
    echo "myuseradd.sh -d <login>                         - remove a user account"
    echo "myuseradd.sh -h                                 - display this usage message"
}

#stage 2: delete user information
function delete_user {
    # try to find the user information
    if id "$1" &>/dev/null; 
    then
    # delete user and print message
        `userdel $1`
        echo "$1 is deleted"
    else
    # print error message
        echo "ERROR: $1 does not exist"
    fi
}

# loop
function options () {
    # verify the different options of the menu 
    if [[ $1 == '-h' ]] 
    then 
    # display menu options  
        print_menu
    elif [[ $1 == '-d' ]]
    then
    # delete user
        delete_user $2 $3
    elif [[ $1 == '-a' ]]
    then
    # create user
        add_user $2 $3 $4
    else
        echo "ERROR: Invalid option: $1"
        print_usage
    fi
}

# options
options $1 $2 $3 $4