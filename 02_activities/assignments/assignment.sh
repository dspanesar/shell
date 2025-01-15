#!/bin/bash
set -x

############################################
# DSI CONSULTING INC. Project setup script #
############################################
# This script creates standard analysis and output directories
# for a new project. It also creates a README file with the
# project name and a brief description of the project.
# Then it unzips the raw data provided by the client.

mkdir analysis output
touch README.md
echo "# Project Name: DSI Consulting Inc." > README.md
touch analysis/main.py

# download client data
curl -Lo rawdata.zip https://github.com/UofT-DSI/shell/raw/refs/heads/main/02_activities/assignments/rawdata.zip
unzip rawdata.zip

###########################################
# Complete assignment here

# 1. Create a directory named data

#this should make the data directory in the current working directory (should you wish to navigate to a different dir specific the path or cd to that dir)
mkdir data

# 2. Move the ./rawdata directory to ./data/raw

#this will move the dir rawdata/ to data/raw note: the sub folder raw does not yet exist in the data dir therefore this code should also create that dir
#note this will only work if the working directory is where the rawdata folder and data folder exist otherwise the path for each will need to be specified

mv rawdata/ data/raw 

# 3. List the contents of the ./data/raw directory

#in my case my working dir contains the data folder however given the raw folder is a sub dir i list it here - otherwise i can also just [cd data/raw] then [ls] to get results
#note this will only work if the working directory is where the rawdata folder and data folder exist otherwise the path for each will need to be specified

ls data/raw/

# 4. In ./data/processed, create the following directories: server_logs, user_logs, and event_logs

#there are a few ways of doing this, you can either do what I did from my current working directory by specifying the path
#or you can do that by first changing the working directory [cd data], then create processed [mkdir processed], then make all three new directories with mkdir
#alternatively you could first [mkdir data/processed] which makes the processed dir then make each within processed by changing the current working dir first to data/processed
#then you could [mkdir server_logs user_logs event_logs]

mkdir data/processed/ data/processed/server_logs data/processed/user_logs data/processed/event_logs

# 5. Copy all server log files (files with "server" in the name AND a .log extension) from ./data/raw to ./data/processed/server_logs

#note this code will copy from the data/raw dir with 2 wild card placeholders -> anything that has the text server but also needs to have .log to the data/processed/server_logs dir
#note this works if we are currently in the working directory where the "data" directory is present

cp data/raw/*server*.log data/processed/server_logs

# 6. Repeat the above step for user logs and event logs

#for user logs
cp data/raw/*user*.log data/processed/user_logs

#for event logs
cp data/raw/*event*.log data/processed/event_logs


# 7. For user privacy, remove all files containing IP addresses (files with "ipaddr" in the filename) from ./data/raw and ./data/processed/user_logs
rf -rf ./data

#removes files in both folders (provided we are in the working dir with the data dir in it) that have "ipaddr" anywhere (hence the wildcard before and after) in the name
#We can add the  -i option as as a check this can be run without it for both
#We can add the  -v option to display result after the removal

rm data/raw/*ipaddr*

rm data/processed/user_logs/*ipaddr*


# 8. Create a file named ./data/inventory.txt that lists all the files in the subfolders of ./data/processed

#again this must be done in the working dir with "data" dir
#the touch command creates the text file called "inventory.txt" in the "data" dir
#ls lists contexts of each of the 4 dir 
#you can also start by listing all the directories in processed to help specify them for the ls code above beforehand by [ls data/processed]

touch data/inventory.txt
ls data/processed/ data/processed/event_logs/ data/processed/server_logs/ data/processed/user_logs/ >> data/inventory.txt

#OR WE CAN ALSO JUST RUN THE BELOW CODE AS A 1 LINE ALTERNATIVE:
#ls data/processed/ data/processed/event_logs/ data/processed/server_logs/ data/processed/user_logs/* > data/inventory.txt

###########################################

echo "Project setup is complete!"
