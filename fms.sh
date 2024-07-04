#!/bin/bash

# Compile the project
gcc project.c -o proj

# Main loop
for (( i = 0; i < 100; i++ )); do
    # Execute the project
    ./proj

    # Prompt user for choice
    read -p "Enter your choice: " opt1

    # Handle user choices
    case $opt1 in
        1)
            # List all files and directories
            echo "List all files and directories here.."
            echo "Showing all files and directories...."
            sleep 3
            echo "Loading.."
            sleep 3
            echo "-------------------------------Output-------------------------------"
            ls
            echo " "
            ;;
        2)
            # Create new files
            echo "Create New Files here.."
            echo "Which type of file you want to create ?"
            echo "1- .c"
            echo "2- .sh"
            echo "3- .txt"
            read -p "Enter your choice from 1-3: " filechoice
            case $filechoice in
                1)
                    echo "Enter File Name without .c Extension"
                    read filename
                    touch "$filename.c"
                    echo "-------------------------------Output-------------------------------"
                    echo "File Created Successfully: $filename.c"
                    echo " "
                    ;;
                2)
                    echo "Enter File Name without .sh Extension"
                    read filename
                    touch "$filename.sh"
                    echo "-------------------------------Output-------------------------------"
                    echo "File Created Successfully: $filename.sh"
                    echo " "
                    ;;
                3)
                    echo "Enter File Name without .txt Extension"
                    read filename
                    touch "$filename.txt"
                    echo "-------------------------------Output-------------------------------"
                    echo "File Created Successfully: $filename.txt"
                    echo " "
                    ;;
                *)
                    echo "Invalid Input..Try Again."
                    echo " "
                    ;;
            esac
            ;;
        3)
            # Delete existing files
            echo "Delete existing files here.."
            read -p "Enter name of File you want to Delete (full name with extension): " delfile
            echo "-------------------------------Output-------------------------------"
            if [ -f "$delfile" ]; then
                rm "$delfile"
                echo "File '$delfile' successfully deleted."
                echo " "
            else
                echo "File '$delfile' does not exist."
                echo " "
            fi
            ;;
        4)
            # Rename files
            echo "Rename files here.."
            read -p "Enter Old Name of File with Extension: " old
            echo "Checking for file..."
            sleep 3
            if [ -f "$old" ]; then
                echo "Ok File Exist."
                read -p "Now Enter New Name for file with Extension: " new
                mv "$old" "$new"
                echo "-------------------------------Output-------------------------------"
                echo "Successfully renamed. Now Your File Exist with $new Name"
                echo " "
            else
                echo "$old does not exist..Try again with correct filename."
                echo " "
            fi
            ;;
        5)
            # Edit file content
            echo "Edit file content here.."
            read -p "Enter File Name with Extension: " edit
            echo "-------------------------------Output-------------------------------"
            echo "Checking for file.."
            sleep 3
            if [ -f "$edit" ]; then
                echo "Opening file with nano.."
                sleep 3
                nano "$edit"
                echo " "
            else
                echo "$edit File does not exist..Try again."
                echo " "
            fi
            ;;
        6)
            # Search files
            echo "Search files here.."
            read -p "Enter File Name with Extension to search: " f
            echo "-------------------------------Output-------------------------------"
            if [ -f "$f" ]; then
                echo "Searching for $f File"
                echo "File Found."
                find /home -name "$f"
                echo " "
            else
                echo "File Does not Exist..Try again."
                echo " "
            fi
            ;;
        7)
            # View file details
            echo "Detail of file here.."
            read -p "Enter File Name with Extension to see Detail: " detail
            echo "-------------------------------Output-------------------------------"
            echo "Checking for file.."
            sleep 4
            if [ -f "$detail" ]; then
                echo "Loading Properties.."
                stat "$detail"
            else
                echo "$detail File does not exist..Try again"
            fi
            echo " "
            ;;
        8)
            # View file content
            echo "View content of file here.."
            read -p "Enter File Name: " readfile
            echo "-------------------------------Output-------------------------------"
            if [ -f "$readfile" ]; then 
                echo "Showing file content.."
                sleep 3
                cat "$readfile"
            else
                echo "$readfile does not exist" 
            fi 
            echo " "
            ;;
        9)
            # Sort file content
            echo "Sort files content here.."
            read -p "Enter File Name with Extension to sort: " sortfile
            echo "-------------------------------Output-------------------------------"
            if [ -f "$sortfile" ]; then
                echo "Sorting File Content.."
                sleep 3
                sort "$sortfile"
            else
                echo "$sortfile File does not exist..Try again."
            fi
            echo " "
            ;;
        10)
            # List all directories
            echo "List of all Directories here.."
            echo "Showing all Directories..."
            echo "Loading.."
            sleep 3
            ls -d */
            echo " "
            ;;
        11)
            # List files with particular extensions
            echo "List of Files with Particular extensions here.."
            echo "Which type of file list you want to see?"
            echo "1- .c"
            echo "2- .sh"
            echo "3- .txt"
            read -p "Enter your choice from 1-3: " extopt
            echo "-------------------------------Output-------------------------------"
            case $extopt in
                1)
                    echo "List of .c Files shown below."
                    echo "Loading.."
                    sleep 3
                    ls *.c
                    ;;
                2)
                    echo "List of .sh Files shown below."
                    echo "Loading.."
                    sleep 3
                    ls *.sh
                    ;;
                3)
                    echo "List of .txt Files shown below."
                    echo "Loading.."
                    sleep 3
                    ls *.txt
                    ;;
                *)
                    echo "Invalid Input..Try again.."
                    ;;
            esac
            echo " "
            ;;
        12)
            # Total number of directories
            echo "Total number of Directories here.."
            echo "Loading all directories.."
            sleep 3
            echo "Counting.."
            sleep 3
            echo "Number of Directories are: "
            echo */ | wc -w
            echo " "
            ;;
        13)
            # Total number of files in current directory
            echo "Total Numbers of Files in Current Directory here.."
            echo "Loading all files.."
            sleep 3
            echo "Number of Files are: "
            ls -l | grep -v 'total' | grep -v '^d' | wc -l
            echo " " 
            ;;
        14)
            # Sort files
            echo "Sort Files here.."
            echo "Your Request of Sorting file is Generated." 
            echo "Sorting.." 
            sleep 3
            echo "-------------------------------Output-------------------------------"
            ls | sort
            echo " "
            ;;
        0)
            # Exit
            echo "Good Bye.."
            echo "Successfully Exit"
            exit 0
            ;;
        *)
            # Invalid input
            echo "Invalid Input..Try again...."
            ;;
    esac
done

