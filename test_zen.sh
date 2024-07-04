#!/bin/bash

# Function to get screen resolution
get_screen_resolution() {
    resolution=$(xdpyinfo | grep dimensions | awk '{print $2}')
    echo "$resolution"
}

# Function to launch Zenity fullscreen window
launch_fullscreen_zenity() {
    local resolution=$(get_screen_resolution)
    local width=$(echo "$resolution" | cut -d 'x' -f1)
    local height=$(echo "$resolution" | cut -d 'x' -f2)
    zenity --width="$width" --height="$height" --info --text="$1"
}

# Compile the project
gcc project.c -o proj

# Main loop
while true; do
    # Display the main menu using Zenity
    choice=$(zenity --list \
        --title="File Management Project" \
        --text="Select an action:" \
        --column="Option" --column="Description" \
        "List all Files and Directories" "List all files and directories" \
        "Create New Files" "Create new .c, .sh, or .txt files" \
        "Delete Existing Files" "Delete existing files" \
        "Rename Files" "Rename files" \
        "Edit File Content" "Edit file content" \
        "Search Files" "Search files" \
        "View File Details" "View file details" \
        "View File Content" "View file content" \
        "Sort File Content" "Sort file content" \
        "List Directories" "List only directories" \
        "List Files by Extension" "List files by extension" \
        "Count Directories" "Count number of directories" \
        "Count Files" "Count number of files" \
        "Sort Files in Directory" "Sort files in a directory" \
        "Exit" "Exit the program")

    # Handle user choices
    case $choice in
        "List all Files and Directories")
            # List all files and directories
            zenity --info --title="Files and Directories" --text="Files:\n$(ls -p | grep -v /)\n\nDirectories:\n$(ls -d */)"
            ;;
        "Create New Files")
            # Create new files
            file_type=$(zenity --list \
                --title="Create New File" \
                --text="Select the type of file you want to create:" \
                --column="Type" --column="Description" \
                "c" "C source file" \
                "sh" "Shell script file" \
                "txt" "Text file")
            
            if [ $? -eq 0 ]; then
                file_name=$(zenity --entry --title="Enter File Name" --text="Enter the name of the new file (without extension):")
                if [ $? -eq 0 ]; then
                    touch "$file_name.$file_type"
                    zenity --info --text="File created successfully: $file_name.$file_type"
                fi
            fi
            ;;
        "Delete Existing Files")
            # Delete existing files
            file=$(zenity --file-selection --title="Select File to Delete")
            if [ $? -eq 0 ]; then
                rm "$file"
                zenity --info --text="File '$file' deleted successfully"
            fi
            ;;
        "Rename Files")
            # Rename files
            old=$(zenity --entry --title="Rename File" --text="Enter the old file name (with extension):")
            if [ $? -eq 0 ]; then
                if [ -f "$old" ]; then
                    new=$(zenity --entry --title="Rename File" --text="Enter the new file name (with extension):")
                    if [ $? -eq 0 ]; then
                        mv "$old" "$new"
                        zenity --info --text="File successfully renamed to '$new'"
                    fi
                else
                    zenity --error --text="File '$old' does not exist"
                fi
            fi
            ;;
        "Edit File Content")
            # Edit file content
            file=$(zenity --file-selection --title="Select File to Edit")
            if [ $? -eq 0 ]; then
                nano "$file"
            fi
            ;;
        "Search Files")
            # Search files
            query=$(zenity --entry --title="Search File" --text="Enter file name or part of it:")
            if [ $? -eq 0 ]; then
                search_result=$(find /home -name "*$query*" 2>/dev/null)
                if [ -n "$search_result" ]; then
                    zenity --info --text="Search results:\n$search_result"
                else
                    zenity --info --text="No matching files found"
                fi
            fi
            ;;
        "View File Details")
            # View file details
            file=$(zenity --file-selection --title="Select File to View Details")
            if [ $? -eq 0 ]; then
                stat "$file" | zenity --text-info --title="File Details" --width=500 --height=300
            fi
            ;;
        "View File Content")
            # View file content
            file=$(zenity --file-selection --title="Select File to View Content")
            if [ $? -eq 0 ]; then
                cat "$file" | zenity --text-info --title="File Content" --width=500 --height=300
            fi
            ;;
        "Sort File Content")
            # Sort file content
            file=$(zenity --file-selection --title="Select File to Sort")
            if [ $? -eq 0 ]; then
                sorted=$(sort "$file")
                zenity --text-info --title="Sorted File Content" --width=500 --height=300 --text="$sorted"
            fi
            ;;
        "List Directories")
            # List directories
            zenity --info --title="Directories" --text="Directories:\n$(ls -d */)"
            ;;
        "List Files by Extension")
            # List files by extension
            extension=$(zenity --list \
                --title="List Files by Extension" \
                --text="Select the file extension:" \
                --column="Extension" --column="Description" \
                "c" "C source files" \
                "sh" "Shell script files" \
                "txt" "Text files")
            if [ $? -eq 0 ]; then
                files=$(ls *.$extension 2>/dev/null)
                if [ -n "$files" ]; then
                    zenity --info --title="Files with .$extension Extension" --text="Files:\n$files"
                else
                    zenity --info --title="Files with .$extension Extension" --text="No files found with .$extension extension"
                fi
            fi
            ;;
        "Count Directories")
            # Count directories
            count=$(ls -d */ | wc -l)
            zenity --info --title="Count Directories" --text="Total number of directories: $count"
            ;;
        "Count Files")
            # Count files
            count=$(ls -p | grep -v / | wc -l)
            zenity --info --title="Count Files" --text="Total number of files: $count"
            ;;
        "Sort Files in Directory")
            # Sort files in directory
            sorted=$(ls | sort)
            zenity --info --title="Sorted Files in Directory" --text="Sorted Files:\n$sorted"
            ;;
        "Exit")
            # Exit
            zenity --question --text="Are you sure you want to exit?" --ok-label="Yes" --cancel-label="No"
            if [ $? -eq 0 ]; then
                exit 0
            fi
            ;;
        *)
            # Invalid choice
            zenity --error --text="Invalid choice"
            ;;
    esac
done

