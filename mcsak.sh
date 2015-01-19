#!/bin/bash
# Title: mcswak.sh
# Author: Ian Carey (carian94) (carian94@gmail.com)
#Version 1.12.2015
# Description: Multi functional Minecraft server Bash script
# Copyright (C) 2010-2015 Ian Carey
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

#----------------------------------#
#       User Configuration         #
#----------------------------------#

# Directory the server files are located in.
#Default is  "/srv/mcserver"
SRV_DIR="/srv/mcserver"

#User that will run the server process.
#Default is mcServer
USERNAME="mcServer"

#Directory where backups will be held.
#Default is "$SRV_DIR/backup"
BACKUP_DIR="$SRV_DIR/backup"

# Number of CPU cores to thread across if using multithreaded garbage collection.
#Default "1"
CPU_COUNT="1"

#Server RAM
#If using more than 4GB of RAM  enable Hugepages in the OS, and on the SRV_PARAMS;
#line by adding the -XX:+UseLargePages flag.
#Defaults "1024M"
INITRAM="1024M"
MAXRAM="1024M"

## WARNING!!!! DO NOT EDIT BELOW THIS LINE ##

#----------------------------------#
#       System Variables           #
#----------------------------------#

#Current User Variable
CUR_USR=$(whoami)

#Date and time string.
DATE=$(date +%d.%m.%y-%H.%M)

#END of Configuration Variables


#----------------------------------#
#     	 JAVA INSTALL FUNCTION     #
#----------------------------------#
function JavaMenu {
clear
for i in {77..76} {76..77} ; do echo -en "\e[38;5;${i}m################\e[0m" ; done ; echo
echo -e "\e[2;97m           Oracle Java Management Menu          "
for i in {77..76} {76..77} ; do echo -en "\e[38;5;${i}m################\e[0m" ; done ; echo
echo -e "\e[2;97m";
PS3='Choose an option. : '
options=("Install Oracle Java 7 JDK"
         "Install Oracle Java 8 JDK"
	 "Manage Active Java Version"
         "Check Java Version"
         "Exit To Main Menu")
select opt in "${options[@]}"
do
    case $opt in
        "Install Oracle Java 7 JDK")
    		echo -e "\e[2;1;31m This requires root access:"
			read -p "Press the [Enter] key to continue."
			echo -e "\e[2;97m"
                        echo -e "Installing Java 7 JDK.";
			#Install Dependencies
				sudo apt-get install -y python-software-properties
			#Install Repository
				sudo add-apt-repository ppa:webupd8team/java
			#Update Repositories
				sudo apt-get update

			#Start Java Install
				sudo apt-get install oracle-java7-installer
    		        echo -e "\e[2;1;31m";
                        read -p "Press the [Enter] key to continue.";
                        clear
                        echo -e "\e[2;1;32mFinished!\e[0m";
    		JavaMenu
	    ;;
        "Install Oracle Java 8 JDK")
    		echo -e "\e[2;1;31m This requires root access:"
                        read -p "Press the [Enter] key to continue.\e[0m"
                        echo -e "\e[2;97m"
                        echo -e "Installing Java 8 JDK.";
			#Install Dependencies
				sudo apt-get install -y python-software-properties
			#Install Repository
				sudo add-apt-repository ppa:webupd8team/java
			#Update Repositories
				sudo apt-get update
			#Start Java Install
				sudo apt-get install oracle-java8-installer
    		        echo -e "\e[2;1;31m";
                        read -p "Press the [Enter] key to continue.";
                        clear
                        echo -e "\e[2;1;32mFinished!\e[0m";
    		JavaMenu
            ;;
		"Manage Active Java Version")
                        echo -e "\e[2;1;31m This requires root access:"
                        read -p "Press the [Enter] key to continue."
                        echo -e "\e[2;97m"

			#Start Java Management Tool
			sudo update-alternatives --config java
                        clear
    		        echo -e "\e[2;1;32mFinished!\e[0m";
    		JavaMenu
	    ;;
                "Check Java Version")
                echo -e "\e[2;32mJava Version";
                echo -e "\e[2;97m";
		java -version
		echo -e "\e[2;32mJava Compiler Version";
		echo -e "\e[2;97m";
                javac -version
                echo -e "\e[2;32m"
                read -p "Press the [Enter] key to continue.";
                clear
                echo -e "\e[2;1;32mFinished!\e[0m";
                JavaMenu
            ;;
        "Exit To Main Menu")
		Main
            break
            ;;
        *)
            echo Exiting
            ;;
    esac
done
}
## END JavaMenu

#----------------------------------#
#     	 SPIGOT FUNCTION           #
#----------------------------------#
function SpigotMenu {
clear
for i in {77..76} {76..77} ; do echo -en "\e[38;5;${i}m################\e[0m" ; done ; echo
echo -e "\e[2;97m           Spigot Management Menu          "
for i in {77..76} {76..77} ; do echo -en "\e[38;5;${i}m################\e[0m" ; done ; echo
echo -e "\e[2;97m";
PS3='What would you like to do?:'
options=("Compile Spigot 1.8"
         "Exit To Main Menu")
select opt in "${options[@]}"
do
    case $opt in
        "Compile Spigot 1.8")
    		        echo -e "\e[2;1;31m This requires root access:"
                        read -p "Press the [Enter] key to continue."
                        echo -e "\e[2;32mInstalling Dependencies";
                        echo -e "\e[2;97m";
                        sudo apt-get install -y git tar
                        echo -e "\e[2;32mCreating work directory";
                        echo -e "\e[2;97m";
			cd ~
			mkdir spigot
			cd spigot
			echo -e "\e[2;32mDownloading BuildTools.jar";
			echo -e "\e[2;97m"
			wget -O BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
			clear
                        echo -e "\e[2;32m Compiling Spigot this can take 10-15 minutes!"
			echo -e "\e[2;1;97m"
                        java -jar BuildTools.jar
                        echo -e "\e[2;1;32mFinished!\e[0m";
                        echo -e "\e[2;1;97m"
                        read -p "Press the [Enter] key to continue.";
                        echo -e "\e[0m"


    		SpigotMenu
	    ;;
        "Exit To Main Menu")
		Main
            break
            ;;
        *)
            echo Exiting
            ;;
    esac
done
}
## END SPIGOT MANAGEMENT

#----------------------------------#
#        SERVER FUNCTION           #
#----------------------------------#
function ServerMenu {
clear
for i in {77..76} {76..77} ; do echo -en "\e[38;5;${i}m################\e[0m" ; done ; echo
echo -e "        \e[2;97m Minecraft Server Install/Management Menu        "
for i in {77..76} {76..77} ; do echo -en "\e[38;5;${i}m################\e[0m" ; done ; echo
echo -e "\e[2;97m"
PS3='What would you like to do?:'
options=("Install Vanilla Minecraft Server"
         "Exit To Main Menu")
select opt in "${options[@]}"
do
    case $opt in
         "Install Vanilla Minecraft Server")
            _repeat="Y"

            while [ $_repeat = "Y" ]
            do
                    # Do whatever your tasks are
                    echo -e "Enter the name of the user you want to own the server process. Default is  $USERNAME"
                    read NEWUSERNAME
                    [ -n "$NEWUSERNAME" ] && USERNAME=$NEWUSERNAME
                    echo -e "Enter the path of the directory where the server should reside. Default is $SRV_DIR"
                    read NEWSRV_DIR
                    [ -n "$NEWSRV_DIR" ] && SRV_DIR=$NEWSRV_DIR
                    echo -e "Enter the path for the directory where backups will be stored. Default is  $BACKUP_DIR"
                    read NEWBACKUP_DIR
                    [ -n "$NEWBACKUP_DIR" ] && BACKUP_DIR=$NEWBACKUP_DIR
                    # Prompt for repeat
                    echo -e "You Entered:\nUser: $USERNAME\nServer Directory: $SRV_DIR\nBackup Directory: $BACKUP_DIR"
                    echo -n "Is this correct? (Y/N)"
                    read -n1 Input
                    echo # Completes the line
                    case $Input in
                            [Yy]):
                            _repeat="N"
                            ;;
                    esac
            done
           _repeat="Y"
            while [ $_repeat = "Y" ]
            do
                    # Do whatever your tasks are
                    echo -e "Enter the number of CPU cores you have. Default is  $CPU_COUNT"
                    read NEWCPU_COUNT
                    [ -n "$NEWCPU_COUNT" ] && CPU_COUNT=$NEWCPU_COUNT
                    echo -e "Enter the minimum RAM amount to dedicate to the server in MB. Default is $INITRAM"
                    read NEWINITRAM
                    [ -n "$NEWINITRAM" ] && INITRAM=$NEWINITRAM
                    echo -e "Enter the maximum RAM amount to dedicate to the server in MB. Default is  $MAXRAM"
                    read NEWMAXRAM
                    [ -n "$NEWMAXRAM" ] && MAXRAM=$NEWMAXRAM
                    # Prompt for repeat
                    echo -e "You Entered:\nCPU Count: $CPU_COUNT\nMinimum RAM: $INITRAM\nMaximum RAM: $MAXRAM"
                    echo -n "Is this correct? (Y/N)"
                    read -n1 Input
                    echo # Completes the line
                    case $Input in
                            [Yy]):
                            _repeat="N"
                            ;;
                    esac
            done

            echo -e "\e[2;1;31m This requires root access:";
	    echo -e "\e[2;32mInstalling dependencies; screen, tar, and rsync.";
            echo -e "\e[2;97m";
            sudo apt-get update
            sudo apt-get install screen tar rsync
            echo -e "\e[2;32mAdding Minecraft Server User $USERNAME";
            echo -e "\e[2;1;31mPlease enter a strong password when prompted."
            sudo adduser $USERNAME --force-badname
            echo -e "\e[2;32mCreating Minecraft Server Directory in $SRV_DIR";
            echo -e "\e[2;97m";
            sudo mkdir -p $SRV_DIR/bin
            echo -e "\e[2;32mSetting Permissions for $SRV_DIR for first server run";
            echo -e "\e[2;97m";
            sudo chmod 777 -R $SRV_DIR
            echo -e "\e[2;32mAdding User - $CUR_USR to $USERNAME group."
            sudo usermod -a -G $USERNAME $CUR_USR
            echo -e "\e[2;32mDownloading Vanilla Minecraft Server .jar to $SRV_DIR"
            echo -e "\e[2;97m";
            wget https://s3.amazonaws.com/Minecraft.Download/versions/1.8.1/minecraft_server.1.8.1.jar -O $SRV_DIR/minecraft_server.jar
            echo -e "Mojang EULA can be read at (https://account.mojang.com/documents/minecraft_eula)."
            read -p "Press the [Enter] key to accept the EULA.";
            echo eula=true >> $SRV_DIR/eula.txt
            echo -e "\e[2;32mStarting the server for the first time."
            for i in {77..76} {76..77} ; do echo -en "\e[38;5;${i}m################\e[0m" ; done ; echo
            echo -e "\e[2;97mWhen the server finishes starting type stop and the script will continue."
            read -p "Press the [Enter] key when you have read the instructions.";
            cd $SRV_DIR
            java -Xmx1024M -Xms1024M -jar minecraft_server.jar nogui
            echo -e "\e[2;32mFetching the init script for Vanilla Minecraft Server."
            echo -e "\e[2;97m";
            wget http://www.icarey.net/minecraft/init.mcserver -O $SRV_DIR/bin/init.mcserver
            echo -e "\e[2;32mGenerating init script config for Vanilla Minecraft Server."
            echo -e "\e[2;97m";
            echo '#!/bin/bash
#
# Configuration file for init.mcserver  ================================
#
#

# Name of vanilla server jar (no need to change if youre running craftbukkit and vice versa)
MC_JAR="minecraft_server.jar"

# Name of craftbukkit jar
CB_JAR="spigot.jar"

# Define the release of CraftBukkit to use (stable or unstable)
CB_RELEASE="stable"

# Name of server.jar to use (either $MC_JAR or $CB_JAR)
SERVICE=$CB_JAR

# Name to use for the screen instance
SCREEN="mcServer_screen"

# User that should run the server
USERNAME="'"$USERNAME"'"

# Path to minecraft server directory
MCPATH="'"$SRV_DIR"'"

# Path to server log file ($MCPATH/server.log on older versions)
SERVERLOG="${MCPATH}/logs/latest.log"

# Where the worlds are located on the disk. Can not be the same as MCPATH. You need to move your worlds to this directory manually, the script will then handle the nessessay symlinks.
WORLDSTORAGE="${MCPATH}/worlds"

# Number of CPUs/cores to use
CPU_COUNT='"$CPU_COUNT"'

# Initial memory usage
INITMEM="'"INITRAM"'"

# Maximum amount of memory to use Remember: give the ramdisk enough space, subtract from the total amount of RAM available the size of your map and the RAM-consumption of your base system.
MAXMEM="'"MAXRAM"'"

# Settings for backups =============================== Location for world backups
BACKUPPATH="'"$BACKUP_DIR"'/worlds"

# Where the whole minecraft directory is copied when whole-backup is executed whole-backup is a complete uncompressed backup of the whole server folder.
WHOLEBACKUP="'"$BACKUP_DIR"'/server"

# Format for world backup (tar or zip).
BACKUPFORMAT="tar"

# Normally backups will be put in a subfolder to $BACKUPPATH with todays date and the backups themselves will have a timestamp. But if BACKUPSCRIPTCOMPATIBLE is set the world backups will be put directly in $BACKUPPATH without
# timestamp to be compatible with [backup rotation script](https://github.com/adamfeuer/rotate-backups)
#
BACKUPSCRIPTCOMPATIBLE=YES
# If WORLDEDITCOMPATIBLE is set the world backups will be created compatible to WorldEdit in $BACKUPPATH as WORLD_NAME/DATE.(tar.bz2|zip) with the requested directory structure
#
# WORLDEDITCOMPATIBLE=YES Compress the whole backup with bzip2? Note that this may not save a lot of disk space since there can be a lot of files in your server directory, that are already compressed, but it can slow down the
# backup a bit. This highly depends on the plugins you are using.
#
# For example: The png files generated by Dynmap are already compressed and still use a lot of space in your server directory, so the compression ratio of the compressed backup will not be very high.
COMPRESS_WHOLEBACKUP=YES


# Settings for log rolling ===============================

# Location for old logs Used by the log-roll command
LOGPATH="'"$BACKUP_DIR"'/logs"

# Whether or not to gzip logs (must be commented out for no - DO NOT CHANGE TO NO)
#
GZIPLOGS=YES

# What to append to the logfile name (Leave blank for nothing)
LOGFILEAPPEND="logfile_"

# Things to leave alone ;) =====================
INVOCATION="java -Xmx$MAXMEM -Xms$INITMEM -XX:+UseConcMarkSweepGC -XX:+CMSIncrementalPacing -XX:ParallelGCThreads=$CPU_COUNT -XX:+AggressiveOpts -jar $SERVICE nogui"

# Path to the the mounted ramdisk (the default will work in most senarios).
RAMDISK="/dev/shm"' | tee $SRV_DIR/bin/init.mcserver.config
                clear
                echo -e "Installing Server Init Script."
                sleep 2
                sudo ln -s $SRV_DIR/bin/init.mcserver /etc/init.d/mcserver
                sudo update-rc.d mcserver defaults
                echo -e "Setting permissions on $SRV_DIR and Init Script."
                sleep 2
                sudo chmod 770 -R $SRV_DIR
                sudo chown $USERNAME:$USERNAME -R $SRV_DIR
                sudo chmod +x -R $SRV_DIR/script.*
                echo -e "\e[2;1;32mFinished!\e[0m";
                echo -e "\e[2;1;97m"
                read -p "Press the [Enter] key to continue.";
                echo -e "\e[0m"

             ServerMenu
            ;;
        "Exit To Main Menu")
                Main
            break
            ;;
        *)
            echo Exiting
            ;;
    esac
done
}

#----------------------------------#
#         MAIN MENU FUNCTION       #
#----------------------------------#
function Main {
INPUT=0
while [ $INPUT != 1 ] && [ $INPUT != 2 ] && [ $INPUT != 3 ]
do
clear
echo -e "        \e[2;97m Minecraft Server Swiss Army Knife         "
for i in {77..76} {76..77} ; do echo -en "\e[38;5;${i}m################\e[0m" ; done ; echo
echo -e "        \e[2;97m1. Install/Manage Oracle Java"
echo -e "        2. Compile Spigot 1.8"
echo -e "        3. Install/Manage Minecraft Server"
echo -e "        4. Install and Configure Server Management Scripts"
echo -e "        5. Exit\e[0m"
for i in {77..76} {76..77} ; do echo -en "\e[38;5;${i}m################\e[0m" ; done ; echo
echo -e "\e[97mWhat would you like to do? (1-5) \e[0m";
read INPUT
if [ $INPUT -eq 1 ]
then
    JavaMenu
        Main
        return
else
if [ $INPUT -eq 2 ]
then
    SpigotMenu
	Main
else
if [ $INPUT -eq 3 ]
then
    ServerMenu
	Main
else
if [ $INPUT -eq 4 ]
then
        read -p "Coming Soon! Press [Enter] to return to main menu."
	Main
else
if [ $INPUT -eq 5 ]
then
        exit
else

        echo -e "        \e[2;31mInvalid Choice\e[0m"
        Main
fi
fi
fi
fi
fi

done
}


#----------------------------------#
#         CALL THE MAIN FUNCTION   #
#----------------------------------#

Main

# THE END
