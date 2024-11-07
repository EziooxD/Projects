#!/bin/bash

# File Permission Manager Script

# Function to display menu
display_menu() {
    echo "File Permission Manager"
    echo "------------------------"
    echo "1. Change File Permissions (chmod)"
    echo "2. Change File Ownership (chown)"
    echo "3. Check File Permissions"
    echo "4. Check Owner"
    echo "5. Create File"
    echo "6. Create Directory"
    echo "7. Remove File"
    echo "8. Remove Directory"
    echo "9. List Files and Directories"
    echo "10. Exit"
    echo ""
    echo -n "Choose an option: "
}

# Function to change file permissions
change_permissions() {
    echo -n "Enter the file/directory path: "
    read file_path
    echo -n "Enter the permission (e.g., 755 or u+rwx): "
    read permission
    sudo chmod $permission $file_path
    if [ $? -eq 0 ]; then
        echo "Permissions changed successfully!"
    else
        echo "Failed to change permissions."
    fi
}

# Function to change file ownership
change_ownership() {
    echo -n "Enter the file/directory path: "
    read file_path
    echo -n "Enter the new owner (username): "
    read owner
    echo -n "Enter the new group (optional, leave blank for none): "
    read group

    if [ -z "$group" ]; then
	sudo chown $owner $file_path
    else
       sudo chown $owner:$group $file_path
    fi

    if [ $? -eq 0 ]; then
        echo "Ownership changed successfully!"
    else
        echo "Failed to change ownership."
    fi
}

# Function to check file permissions
check_permissions() {
    echo -n "Enter the file/directory path: "
    read file_path
    ls -l $file_path
}

check_owner(){
	echo -n "Enter file/directory path: "
	read path
	getfacl $path
}

# Function to create a file
create_file() {
    echo -n "Enter the path for the new file: "
    read file_path
    touch $file_path
    if [ $? -eq 0 ]; then
        echo "File created successfully!"
    else
        echo "Failed to create file."
    fi
}

# Function to create a directory
create_directory() {
    echo -n "Enter the path for the new directory: "
    read dir_path
    mkdir -p $dir_path
    if [ $? -eq 0 ]; then
        echo "Directory created successfully!"
    else
        echo "Failed to create directory."
    fi
}

# Function to remove a file
remove_file() {
    echo -n "Enter the file path to remove: "
    read file_path
    rm -f $file_path
    if [ $? -eq 0 ]; then
        echo "File removed successfully!"
    else
        echo "Failed to remove file."
    fi
}

# Function to remove a directory
remove_directory() {
    echo -n "Enter the directory path to remove: "
    read dir_path
    rmdir $dir_path
    if [ $? -eq 0 ]; then
        echo "Directory removed successfully!"
    else
        echo "Failed to remove directory. Ensure it is empty."
    fi
}

# Function to list files and directories
list_files_and_directories() {
    echo -n "Enter the path to list files and directories (leave blank for current directory): "
    read path
    path=${path:-.}
    ls -l $path
}

# Main script loop
while true; do
    display_menu
    read option
    case $option in
        1)
            change_permissions
            ;;
        2)
            change_ownership
            ;;
        3)
            check_permissions
            ;;
        4)
            check_owner
            ;;
        5)
            create_file
            ;;
        6)
            create_directory
            ;;
        7)
            remove_file
            ;;
        8)
            remove_directory
            ;;
        9)
            list_files_and_directories
            ;;
        10)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid option. Please try again."
            ;;
    esac
    
    sleep 2
    
    echo ""
done

