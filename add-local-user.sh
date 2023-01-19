#!/bin/bash

#this script creates new user to the system.

# Make sure the script is being executed with superuser privileges
if [[ ${UID} -ne 0 ]]
then
    echo -e " $(whoami) do not have privileges to creat user. \n Please run as root. "
	exit 1
fi


# Get the username (login)

read -p 'Enter the user name: ' USER_NAME

# Get the real name (contents for the description field

read -p 'Enter the name of the account holder: ' COMMENT

# Get the password

read -p 'Select a password: ' PASSWORD

# Create the user with the password

useradd -c "${COMMENT}" -m ${USER_NAME}

# Check to see if the useradd command succeeded

if [[ "${?}" -eq 0 ]]
then
    echo "User Name created Successfully"
else
    echo "Not able to create new user "
	exit 1
fi
	

# Set the password

echo ${PASSWORD} | passwd --stdin ${USER_NAME}

# Check to see if the passwd command succeeded.
if [[ "${?}" -eq 0 ]]
then
    echo "Password set successfully"
else
    echo "Not able set password. Please try again"
	exit 1
fi


# Force password change on first login.

passwd -e ${USER_NAME}

# Display the username, password, and the host where the user was created.

echo
echo " User ID for ${COMMENT} : ${USER_NAME} "
echo
echo " Password : ${PASSWORD} "
echo
echo "host : ${HOSTNAME} "

exit 0