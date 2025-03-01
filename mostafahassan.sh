#!/bin/bash

while true; do
    echo "-----------------------------------"
    echo "       User & Group Management     "
    echo "-----------------------------------"
    echo "1) Manage Users"
    echo "2) Manage Groups"
    echo "3) Exit"
    echo "-----------------------------------"
    read -p "Choose an option: " choice

    case $choice in
        1)
            while true; do
                echo "---- User Management ----"
                echo "1) Add User"
                echo "2) Delete User"
                echo "3) Modify User (Change Password)"
                echo "4) Back to Main Menu"
                read -p "Choose an option: " user_choice

                case $user_choice in
                    1)
                        read -p "Enter username to add: " username
                        sudo useradd "$username" && echo "User $username added successfully!"
                        ;;
                    2)
                        read -p "Enter username to delete: " username
                        sudo userdel "$username" && echo "User $username deleted successfully!"
                        ;;
                    3)
                        read -p "Enter username to change password: " username
                        sudo passwd "$username"
                        ;;
                    4)
                        break
                        ;;
                    *)
                        echo "Invalid choice! Please try again."
                        ;;
                esac
            done
            ;;
        2)
            while true; do
                echo "---- Group Management ----"
                echo "1) Add Group"
                echo "2) Delete Group"
                echo "3) Modify Group (Add/Remove Users)"
                echo "4) Back to Main Menu"
                read -p "Choose an option: " group_choice

                case $group_choice in
                    1)
                        read -p "Enter group name to add: " groupname
                        sudo groupadd "$groupname" && echo "Group $groupname added successfully!"
                        ;;
                    2)
                        read -p "Enter group name to delete: " groupname
                        sudo groupdel "$groupname" && echo "Group $groupname deleted successfully!"
                        ;;
                    3)
                        read -p "Enter group name: " groupname
                        read -p "Enter username to add/remove: " username
                        read -p "Add or Remove user from group? (add/remove): " action
                        if [[ "$action" == "add" ]]; then
                            sudo usermod -aG "$groupname" "$username" && echo "User $username added to $groupname!"
                        elif [[ "$action" == "remove" ]]; then
                            sudo gpasswd -d "$username" "$groupname" && echo "User $username removed from $groupname!"
                        else
                            echo "Invalid action!"
                        fi
                        ;;
                    4)
                        break
                        ;;
                    *)
                        echo "Invalid choice! Please try again."
                        ;;
                esac
            done
            ;;
        3)
            echo "Exiting... Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid option! Please try again."
            ;;
    esac
done
