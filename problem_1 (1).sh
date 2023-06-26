#!/bin/bash

read -p "Please input the name of the directory: " dirName

#checking to see if the directory is found
if [ -d "$dirName" ]; then
    cd "$dirName"
pwd
else
    echo "The directory does not exist."
    exit 1
fi

#
echo "File names: "
fileList=( * )
#create useful menu to choose file
select chosenFile in "${fileList[@]}"; do
    if [ -f "$chosenFile" ]; then
        break
    else
        echo "Invalid choice please try again."
    fi
done


continueReading="yes"
pageCounter=1


totalLines=$(wc -l < "$chosenFile")

while [ "$continueReading" = "yes" ]; do


#then parsing through 10 lines at a time

    lineChunk=$((10 * $pageCounter))
     
    tail -n "$lineChunk"  "$chosenFile" | head -n10
    
    remainingLines=$(($totalLines - $lineChunk))
    
    if [ $remainingLines -gt 1 ]; then
        echo "Do you want to read more? (yes/no)"
        read continueReading
        ((pageCounter++))
    else 
        exit 0
    fi
done

