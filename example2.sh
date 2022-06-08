#stage 1: function for printing usage, displays usage of script
function print_usage {
    echo "Usage: myuseradd.sh -a <login> <passwd> <shell> - add a user account"
    echo "myuseradd.sh -d <login> - remove a user account"
    echo "myuseradd.sh -h          - display this usage message"
}

#stage 2: function for deleting user
function delete_user {
    #check if user exists
    if id "$1" &>/dev/null; then
        #delete user and print message
        `userdel $1`
        echo "$1 is deleted"
    else
        #print error
        echo "ERROR: $1 does not exist"
    fi
}

#stage 3: function for adding new user
function add_user {
    #check if user exist
    if id "$1" &>/dev/null; then
        #print error that user exists
        echo "ERROR: $1 exists"  
    else
        #add new user and print message
        `useradd $1 -d /home/$1 -s $3 -p $(echo $2 | openssl passwd -1 -stdin)`
        echo "$1 ($2) with $3 is added"
    fi   
}

#stage 1: function for parsing commandline arguments
function parse_command_options () {
    #invoke neccessary function when commandline argument is -h, -d, or -a
    #else print error and display usage
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
        echo "ERROR: Invalid option: $1"
        print_usage
    fi
}

#call parse_command_options to start script
parse_command_options $1 $2 $3 $4