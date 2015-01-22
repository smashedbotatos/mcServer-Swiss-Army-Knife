#!/bin/bash
# Title: mcswak.sh
# Author: Ian Carey (carian94) (carian94@gmail.com)
#Version 1.20.2015
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
         "Install Spigot Minecraft Server"
         "Exit To Main Menu")
select opt in "${options[@]}"
do
    case $opt in
         "Install Vanilla Minecraft Server")
            _repeat="Y"

            while [ $_repeat = "Y" ]
            do
                    # Do whatever your tasks are
                    echo -e "\e[1;32mEnter the name of the user you want to own the server process. Example -  mcServer"
                    echo -e "\e[2;97m";
                    read NEWUSERNAME
                    [ -n "$NEWUSERNAME" ] && USERNAME=$NEWUSERNAME
                    echo -e "\e[1;32mEnter the name of the server. Example - mcServer_Creative"
                    echo -e "\e[2;97m";
                    read NEWSRVNAME
                    [ -n "$NEWSRVNAME" ] && SRVNAME=$NEWSRVNAME
                    echo -e "\e[1;32mEnter the path of the directory where the server should reside. Example - /srv/minecraft_server"
                    echo -e "\e[2;97m";
                    read NEWSRV_DIR
                    [ -n "$NEWSRV_DIR" ] && SRV_DIR=$NEWSRV_DIR
                    echo -e "\e[1;32mEnter the path for the directory where backups will be stored. Example - /home/mcServer/mcbackups"
                    echo -e "\e[2;97m";
                    read NEWBACKUP_DIR
                    [ -n "$NEWBACKUP_DIR" ] && BACKUP_DIR=$NEWBACKUP_DIR
                    # Prompt for repeat
                    echo -e "\e[1;34mYou Entered:\nUser: $USERNAME\nServer Name: $SRVNAME\nServer Directory: $SRV_DIR\nBackup Directory: $BACKUP_DIR"
                    echo -e "\e[2;97m";
                    echo -e "\e[1;33m";
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
                    echo -e "\e[1;32mEnter the number of CPU cores you have. Example - 2"
                    echo -e "\e[2;97m";
                    read NEWCPU_COUNT
                    [ -n "$NEWCPU_COUNT" ] && CPU_COUNT=$NEWCPU_COUNT
                    echo -e "\e[1;32mEnter the initial RAM amount to dedicate to the server in Megabytes or Gigabytes."
                    echo -e "Please specify with a M or G after the size."
                    echo -e "Example - 1024M or 1G"
                    echo -e "\e[2;97m";
                    read NEWINITRAM
                    [ -n "$NEWINITRAM" ] && INITRAM=$NEWINITRAM
                    echo -e "\e[1;32mEnter the maximum RAM amount to dedicate to the server in Megabytes or Gigabytes."
                    echo -e "Please specify with a M or G."
                    echo -e "Example - 4096M or 4G"
                    echo -e "\e[2;97m";
                    read NEWMAXRAM
                    [ -n "$NEWMAXRAM" ] && MAXRAM=$NEWMAXRAM
                    # Prompt for repeat
                    echo -e "\e[1;32mYou Entered:\nCPU Count: $CPU_COUNT\nMinimum RAM: $INITRAM\nMaximum RAM: $MAXRAM"
                    echo -e "\e[1;33m";
                    echo -n "Is this correct? (Y/N)"
                    read -n1 Input
                    echo # Completes the line
                    case $Input in
                            [Yy]):
                            _repeat="N"
                            ;;
                    esac
            done

####################################
###CRONJOBS TO ADD DURING INSTALL###
####################################
CRONCMD_BACKUP="$SRV_DIR/bin/script.servermgmt.sh minecraft backup"
CRONJOB_BACKUP="0  *  *  *  * $CRONCMD_BACKUP"
CRONCMD_BACKUPROTATE="$SRV_DIR/bin/rotate-backups.py > /dev/null"
CRONJOB_BACKUPROTATE="30  *  *  *  * $CRONCMD_BACKUPROTATE"
CRONCMD_LOGROLL="$SRV_DIR/bin/script.servermgmt.sh log-roll"
CRONJOB_LOGROLL="55  04  *  *  * $CRONCMD_LOGROLL"
CRONCMD_TODISK="$SRV_DIR/bin/script.servermgmt to-disk"
CRONJOB_TODISK="*/15  *  *  *  * $CRONCMD_TODISK"
CRONCMD_WARN="$SRV_DIR/bin/script.servermgmt.sh say SERVER RESTART IN 5 MINUTES"
CRONJOB_WARN="0  05  *  *  * $CRONCMD_WARN"
CRONCMD_RESTART="$SRV_DIR/bin/script.servermgmt.sh restart"
CRONJOB_RESTART="5  05  *  *  * $CRONCMD_RESTART"
#Moved here to read variable from user input
############################################

            echo -e "\e[1;31mThis requires root access:";
	    echo -e "\e[1;32mInstalling dependencies; screen, tar, and rsync.";
            echo -e "\e[2;97m";
            sudo apt-get update
            sudo apt-get install screen tar rsync
            echo -e "\e[1;32mAdding Minecraft Server User $USERNAME";
            echo -e "\e[1;36mPlease enter a strong password when prompted."
            echo -e "\e[2;97m";
            sleep 1
            sudo adduser $USERNAME --force-badname
            echo -e "\e[1;32mCreating Minecraft Server Directory in $SRV_DIR";
            echo -e "\e[2;97m";
            sudo mkdir -p $SRV_DIR/bin
            sudo mkdir -p $SRV_DIR/world_storage
            sleep 1
            echo -e "\e[1;32mCreating Minecraft Server Backup Directory in $BACKUP_DIR";
            echo -e "\e[2;97m";
            sudo mkdir -p $BACKUP_DIR
            sudo mkdir -p $BACKUP_DIR/logs
            sudo mkdir -p $BACKUP_DIR/server
            sudo mkdir -p $BACKUP_DIR/latest
            sudo mkdir -p $BACKUP_DIR/archives
            sleep 1
            echo -e "\e[1;32mSetting Permissions for $SRV_DIR for first server run";
            echo -e "\e[1;97m";
            sudo chmod 777 -R $SRV_DIR
            sudo chmod 777 -R $BACKUP_DIR
            sleep 1.5
            echo -e "\e[1;32mDownloading Vanilla Minecraft Server .jar to $SRV_DIR"
            echo -e "\e[1;97m";
            wget https://s3.amazonaws.com/Minecraft.Download/versions/1.8.1/minecraft_server.1.8.1.jar -O $SRV_DIR/minecraft_server.jar
            echo -e "\e[1;33mMojang EULA can be read at (https://account.mojang.com/documents/minecraft_eula)."
            echo -e "\e[1;36m";
            read -p "Press the [Enter] key to accept the EULA.";
            echo eula=true >> $SRV_DIR/eula.txt
            sleep 2
            clear
            echo -e "\e[1;32mStarting the server for the first time."
            for i in {77..76} {76..77} ; do echo -en "\e[38;5;${i}m################\e[0m" ; done ; echo
            echo -e "\e[1;31mWhen the server finishes starting up type STOP and the script will continue.\n Ignore the errors!!"
            read -p "Press the [Enter] key when you have read the instructions.";
            echo -e "\e[1;97m";
            cd $SRV_DIR
            java -Xmx512M -Xms512M -jar minecraft_server.jar nogui
            echo -e "\e[1;32mFetching the scripts for Minecraft Server."
            echo -e "\e[2;97m";
            wget http://www.icarey.net/minecraft/mcscripts.tar.gz -O $SRV_DIR/bin/mcscripts.tar.gz
            cd $SRV_DIR/bin
            tar -xvzf mcscripts.tar.gz
            rm mcscripts.tar.gz
            sleep .5
            echo -e "\e[1;32mGenerating Server Management config for Vanilla Minecraft Server."
            echo -e "\e[2;97m";
            sleep 2
            echo '#!/bin/bash
#
# Settings file for minecraft-init
# ================================
#
# Make a copy of this file named config
# and edit the variables to your needs.
#

# Name of vanilla server jar (no need to change if you are running craftbukkit and vice versa)
MC_JAR="minecraft_server.jar"

# Name of craftbukkit jar
CB_JAR="craftbukkit.jar"

# Name of the spigot jar
SP_JAR="spigot.jar"

# Define the release of CraftBukkit to use (stable or unstable)
CB_RELEASE="stable"

# Name of server.jar to use (either $MC_JAR or $CB_JAR)
SERVICE=$MC_JAR

# Name to use for the screen instance
SCREEN="'"$SRVNAME"'"

# User that should run the server
USERNAME="'"$USERNAME"'"

# Path to minecraft server directory
MCPATH="'"$SRV_DIR"'"

# Path to server log file ($MCPATH/server.log on older versions)
SERVERLOG="${MCPATH}/logs/latest.log"

# Where the worlds are located on the disk. Can not be the same as MCPATH.
# You need to move your worlds to this directory manually, the script
# will then handle the nessessay symlinks.
WORLDSTORAGE="${MCPATH}/world_storage"

# Number of CPUs/cores to use
CPU_COUNT='"$CPU_COUNT"'

# Initial memory usage
INITMEM="'"$INITRAM"'"

# Maximum amount of memory to use
# Remember: give the ramdisk enough space, subtract from the total amount
# of RAM available the size of your map and the RAM-consumption of your base system.
MAXMEM="'"$MAXRAM"'"

# Whether to output commands for the plugin ConsoleLikeChat ($1 is the command to run)
FORMAT='"'"'$1'"'"'

# Settings for backups
# ===============================

# Location for world backups
BACKUPPATH="'"$BACKUP_DIR"'/latest"

# Where the whole minecraft directory is copied when whole-backup is executed
# whole-backup is a complete uncompressed backup of the whole server folder.
WHOLEBACKUP="'"$BACKUP_DIR"'/server"

# Format for world backup (tar or zip).
BACKUPFORMAT="tar"

# Normally backups will be put in a subfolder to $BACKUPPATH with todays date
# and the backups themselves will have a timestamp.

# But if BACKUPSCRIPTCOMPATIBLE is set the world backups will be put directly
# in $BACKUPPATH without timestamp to be compatible with
# [backup rotation script](https://github.com/adamfeuer/rotate-backups)
#
BACKUPSCRIPTCOMPATIBLE=YES

# If WORLDEDITCOMPATIBLE is set the world backups will be created compatible to WorldEdit
# in $BACKUPPATH as WORLD_NAME/DATE.(tar.bz2|zip) with the requested directory structure
#
# WORLDEDITCOMPATIBLE=YES

# Compress the whole backup with bzip2?
# Note that this may not save a lot of disk space since there can be a lot of files
# in your server directory, that are already compressed, but it can slow down the
# backup a bit. This highly depends on the plugins you are using.
#
# For example: The png files generated by Dynmap are already compressed and still use
# a lot of space in your server directory, so the compression ratio of the compressed
# backup will not be very high.
COMPRESS_WHOLEBACKUP=YES


# Settings for log rolling
# ===============================

# Location for old logs
# Used by the log-roll command
LOGPATH="'"$BACKUP_DIR"'/logs"

# Whether or not to gzip logs (must be commented out for no - DO NOT CHANGE TO NO)
#
GZIPLOGS=YES

# What to append to the logfile name (Leave blank for nothing)
LOGFILEAPPEND="logfile_"


# Settings for overviewer command
# ===============================

# Where the Map is generated
OUTPUTMAP="/home/'"${USERNAME}"'/mc-overviewer/render"

# Path to Minecraft-Overviewer
OVPATH="/home/'"${USERNAME}"'/mc-overviewer/Minecraft-Overviewer"

# Path for the config file of Overviewer
OVCONFIGPATH="/home/'"${USERNAME}"'/mc-overviewer"

# Name of Overviewer config file
OVCONFIGNAME="config.py"

# Path for backup worlds
OVBACKUP="/home/'"${USERNAME}"'/mc-overviewer/overviewerbackups"

# Things to leave alone ;)
# =====================

INVOCATION="java -Xmx$MAXMEM -Xms$INITMEM -XX:+UseConcMarkSweepGC -XX:+CMSIncrementalMode -XX:+AggressiveOpts -jar $SERVICE nogui"

# Path to the the mounted ramdisk (the default will work in most senarios).
RAMDISK="/dev/shm"' | tee $SRV_DIR/bin/config
                echo '[Settings]
backups_dir = '"$BACKUP_DIR"'/latest/
archives_dir = '"$BACKUP_DIR"'/archives/
hourly_backup_hour = 23
weekly_backup_day = 6
max_weekly_backups = 52
backup_extensions = "tar.gz",".tar.bz2",".jar"
log_level = ERROR' | sudo -u $USERNAME tee /home/$USERNAME/.rotate-backupsrc
                echo "alias $SRVNAME=$SRV_DIR/bin/script.servermgmt.sh" | sudo -u $USERNAME tee /home/$USERNAME/.bash_aliases
                clear
                echo -e "\e[1;32mInstalling Default Cronjobs in Crontab.";
                echo -e "\e[1;97m"
                sleep 1
               echo '( crontab -l | grep -v "'"$CRONCMD_BACKUP"'" ; echo "'"$CRONJOB_BACKUP"'" ) | crontab -
( crontab -l | grep -v "'"$CRONCMD_LOGROLL"'" ; echo "'"$CRONJOB_LOGROLL"'" ) | crontab -
( crontab -l | grep -v "'"$CRONCMD_TODISK"'" ; echo "'"$CRONJOB_TODISK"'" ) | crontab -
( crontab -l | grep -v "'"$CRONCMD_BACKUPROTATE"'" ; echo "'"$CRONJOB_BACKUPROTATE"'" ) | crontab -
( crontab -l | grep -v "'"$CRONCMD_WARN"'" ; echo "'"$CRONJOB_WARN"'" ) | crontab -
( crontab -l | grep -v "'"$CRONCMD_RESTART"'" ; echo "'"$CRONJOB_RESTART"'" ) | crontab -' > $SRV_DIR/bin/cron.sh
                cd $SRV_DIR/bin
                sudo -u $USERNAME bash cron.sh
                rm cron.sh
                echo -e "\e[1;32mIf there is no Crontab, Crontab will append to a blank file"
                echo -e "\e[1;32mSetting permissions on $SRV_DIR and Init Script."
                echo -e "\e[2;1;97m"
                sleep 2
                cd $SRV_DIR
                mv world $SRV_DIR/world_storage/
                sudo chmod 755 -R $SRV_DIR
                sudo chmod 755 -R $BACKUP_DIR
                sudo chown $USERNAME:$USERNAME -R $SRV_DIR
                sudo chown $USERNAME:$USERNAME -R $BACKUP_DIR
                sudo chmod a+x -R $SRV_DIR/bin/script.*
                echo -e "\e[1;32mFinished!";
                echo -e "\e[1;33mLogin to the account $USERNAME via SSH or Terminal and run the command; $SRVNAME start"
                echo -e "For more help please run the command; $SRVNAME help"
                echo -e "\e[1;36m"
                read -p "Press the [Enter] key to return to menu.";
                echo -e "\e[0m"
             ServerMenu
            ;;
        "Install Spigot Minecraft Server")
           echo -e "\e[1;32m"
           read -p "Did you compile the spigot.jar?" -n 1 -r
		echo    # (optional) move to a new line
	   if [[ ! $REPLY =~ ^[Yy]$ ]]
               then
                  echo -e "\e[1;31m Please compile the Spigot 1.8 jar.\e[2;97m"
                  sleep 2
                  ServerMenu
           fi

            _repeat="Y"

            while [ $_repeat = "Y" ]
            do
                    # Do whatever your tasks are
                    echo -e "\e[1;32mEnter the name of the user you want to own the server process. Example - minecraft"
                    echo -e "\e[2;97m";
                    read NEWUSERNAME
                    [ -n "$NEWUSERNAME" ] && USERNAME=$NEWUSERNAME
                    echo -e "\e[1;32mEnter the name of the server. Example - minecraft_creative"
                    echo -e "\e[2;97m";
                    read NEWSRVNAME
                    [ -n "$NEWSRVNAME" ] && SRVNAME=$NEWSRVNAME
                    echo -e "\e[1;32mEnter the path of the directory where the server should reside. Example - /srv/minecraft_serverr"
                    echo -e "\e[2;97m";
                    read NEWSRV_DIR
                    [ -n "$NEWSRV_DIR" ] && SRV_DIR=$NEWSRV_DIR
                    echo -e "\e[1;32mEnter the path for the directory where backups will be stored. Example - /home/minecraft/mcbackups"
                    echo -e "\e[2;97m";
                    read NEWBACKUP_DIR
                    [ -n "$NEWBACKUP_DIR" ] && BACKUP_DIR=$NEWBACKUP_DIR
                    # Prompt for repeat
                    echo -e "\e[1;34mYou Entered:\nUser: $USERNAME\nServer Name: $SRVNAME\nServer Directory: $SRV_DIR\nBackup Directory: $BACKUP_DIR"
                    echo -e "\e[2;97m";
                    echo -e "\e[1;33m";
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
                    echo -e "\e[1;32mEnter the number of CPU cores you have. Example - 2"
                    echo -e "\e[2;97m";
                    read NEWCPU_COUNT
                    [ -n "$NEWCPU_COUNT" ] && CPU_COUNT=$NEWCPU_COUNT
                    echo -e "\e[1;32mEnter the initial RAM amount to dedicate to the server in Megabytes or Gigabytes."
                    echo -e "Please specify with a M or G after the size."
                    echo -e "Example - 1024M or 1G"
                    echo -e "\e[2;97m";
                    read NEWINITRAM
                    [ -n "$NEWINITRAM" ] && INITRAM=$NEWINITRAM
                    echo -e "\e[1;32mEnter the maximum RAM amount to dedicate to the server in Megabytes or Gigabytes."
                    echo -e "Please specify with a M or G."
                    echo -e "Example - 4096M or 4G"
                    echo -e "\e[2;97m";
                    read NEWMAXRAM
                    [ -n "$NEWMAXRAM" ] && MAXRAM=$NEWMAXRAM
                    # Prompt for repeat
                    echo -e "\e[1;32mYou Entered:\nCPU Count: $CPU_COUNT\nMinimum RAM: $INITRAM\nMaximum RAM: $MAXRAM"
                    echo -e "\e[1;33m";
                    echo -n "Is this correct? (Y/N)"
                    read -n1 Input
                    echo # Completes the line
                    case $Input in
                            [Yy]):
                            _repeat="N"
                            ;;
                    esac
            done

####################################
###CRONJOBS TO ADD DURING INSTALL###
####################################
CRONCMD_BACKUP="$SRV_DIR/bin/script.servermgmt.sh minecraft backup"
CRONJOB_BACKUP="0  *  *  *  * $CRONCMD_BACKUP"
CRONCMD_BACKUPROTATE="$SRV_DIR/bin/rotate-backups.py > /dev/null"
CRONJOB_BACKUPROTATE="30  *  *  *  * $CRONCMD_BACKUPROTATE"
CRONCMD_LOGROLL="$SRV_DIR/bin/script.servermgmt.sh log-roll"
CRONJOB_LOGROLL="55  04  *  *  * $CRONCMD_LOGROLL"
CRONCMD_TODISK="$SRV_DIR/bin/script.servermgmt.sh to-disk"
CRONJOB_TODISK="*/15  *  *  *  * $CRONCMD_TODISK"
CRONCMD_WARN="$SRV_DIR/bin/script.servermgmt.sh say SERVER RESTART IN 5 MINUTES"
CRONJOB_WARN="0  05  *  *  * $CRONCMD_WARN"
CRONCMD_RESTART="$SRV_DIR/bin/script.servermgmt.sh restart"
CRONJOB_RESTART="5  05  *  *  * $CRONCMD_RESTART"
#Moved here to read variable from user input
############################################

            echo -e "\e[1;31mThis requires root access:";
	    echo -e "\e[1;32mInstalling dependencies; screen, tar, and rsync.";
            echo -e "\e[2;97m";
            sudo apt-get update
            sudo apt-get install screen tar rsync
            echo -e "\e[1;32mAdding Minecraft Server User $USERNAME";
            echo -e "\e[1;36mPlease enter a strong password when prompted."
            echo -e "\e[2;97m";
            sleep .5
            sudo adduser $USERNAME --force-badname
            echo -e "\e[1;32mCreating Minecraft Server Directory in $SRV_DIR";
            echo -e "\e[2;97m";
            sudo mkdir -p $SRV_DIR/bin
            sudo mkdir -p $SRV_DIR/world_storage
            sleep .5
            echo -e "\e[1;32mCreating Minecraft Server Backup Directory in $BACKUP_DIR";
            echo -e "\e[2;97m";
            sudo mkdir -p $BACKUP_DIR
            sudo mkdir -p $BACKUP_DIR/logs
            sudo mkdir -p $BACKUP_DIR/server
            sudo mkdir -p $BACKUP_DIR/latest
            sudo mkdir -p $BACKUP_DIR/archives
            sleep .5
            echo -e "\e[1;32mSetting Permissions for $SRV_DIR for first server run";
            echo -e "\e[1;97m";
            sudo chmod 777 -R $SRV_DIR
            sudo chmod 777 -R $BACKUP_DIR
            sleep 1
            echo -e "\e[1;32mCopying Spigot Minecraft Server .jar to $SRV_DIR"
            echo -e "\e[1;97m";
            cp /home/$CUR_USR/spigot/spigot-1.8.jar $SRV_DIR/spigot.jar
            echo -e "\e[1;33mMojang EULA can be read at (https://account.mojang.com/documents/minecraft_eula)."
            echo -e "\e[1;36m";
            read -p "Press the [Enter] key to accept the EULA.";
            echo eula=true >> $SRV_DIR/eula.txt
            sleep 3
            clear
            echo -e "\e[1;32mStarting the server for the first time."
            for i in {77..76} {76..77} ; do echo -en "\e[38;5;${i}m################\e[0m" ; done ; echo
            echo -e "\e[1;31mWhen the server finishes starting up type STOP and the script will continue.\n Ignore the errors!!"
            read -p "Press the [Enter] key when you have read the instructions.";
            echo -e "\e[1;97m";
            cd $SRV_DIR
            java -Xmx512M -Xms512M -jar spigot.jar nogui
            echo -e "\e[1;32mFetching the scripts for Minecraft Server."
            echo -e "\e[2;97m";
            wget http://www.icarey.net/minecraft/mcscripts.tar.gz -O $SRV_DIR/bin/mcscripts.tar.gz
            cd $SRV_DIR/bin
            tar -xvzf mcscripts.tar.gz
            rm mcscripts.tar.gz
            sleep .5
            echo -e "\e[1;32mGenerating Server Management Script config for Spigot Server"
            echo -e "\e[2;97m";
            sleep 2
            echo '#!/bin/bash
#
# Settings file for minecraft-init
# ================================
#
# Make a copy of this file named config
# and edit the variables to your needs.
#

# Name of vanilla server jar (no need to change if you are running craftbukkit and vice versa)
MC_JAR="minecraft_server.jar"

# Name of craftbukkit jar
CB_JAR="craftbukkit.jar"

# Name of the spigot jar
SP_JAR="spigot.jar"

# Define the release of CraftBukkit to use (stable or unstable)
CB_RELEASE="stable"

# Name of server.jar to use (either $MC_JAR or $CB_JAR)
SERVICE=$SP_JAR

# Name to use for the screen instance
SCREEN="'"$SRVNAME"'"

# User that should run the server
USERNAME="'"$USERNAME"'"

# Path to minecraft server directory
MCPATH="'"$SRV_DIR"'"

# Path to server log file ($MCPATH/server.log on older versions)
SERVERLOG="${MCPATH}/logs/latest.log"

# Where the worlds are located on the disk. Can not be the same as MCPATH.
# You need to move your worlds to this directory manually, the script
# will then handle the nessessay symlinks.
WORLDSTORAGE="${MCPATH}/world_storage"

# Number of CPUs/cores to use
CPU_COUNT='"$CPU_COUNT"'

# Initial memory usage
INITMEM="'"$INITRAM"'"

# Maximum amount of memory to use
# Remember: give the ramdisk enough space, subtract from the total amount
# of RAM available the size of your map and the RAM-consumption of your base system.
MAXMEM="'"$MAXRAM"'"

# Whether to output commands for the plugin ConsoleLikeChat ($1 is the command $
FORMAT='"'"'$1'"'"'

# Settings for backups
# ===============================

# Location for world backups
BACKUPPATH="'"$BACKUP_DIR"'/latest"

# Where the whole minecraft directory is copied when whole-backup is executed
# whole-backup is a complete uncompressed backup of the whole server folder.
WHOLEBACKUP="'"$BACKUP_DIR"'/server"

# Format for world backup (tar or zip).
BACKUPFORMAT="tar"

# Normally backups will be put in a subfolder to $BACKUPPATH with todays date
# and the backups themselves will have a timestamp.

# But if BACKUPSCRIPTCOMPATIBLE is set the world backups will be put directly
# in $BACKUPPATH without timestamp to be compatible with
# [backup rotation script](https://github.com/adamfeuer/rotate-backups)
#
BACKUPSCRIPTCOMPATIBLE=YES

# If WORLDEDITCOMPATIBLE is set the world backups will be created compatible to WorldEdit
# in $BACKUPPATH as WORLD_NAME/DATE.(tar.bz2|zip) with the requested directory structure
#
# WORLDEDITCOMPATIBLE=YES

# Compress the whole backup with bzip2?
# Note that this may not save a lot of disk space since there can be a lot of files
# in your server directory, that are already compressed, but it can slow down the
# backup a bit. This highly depends on the plugins you are using.
#
# For example: The png files generated by Dynmap are already compressed and still use
# a lot of space in your server directory, so the compression ratio of the compressed
# backup will not be very high.
COMPRESS_WHOLEBACKUP=YES


# Settings for log rolling
# ===============================

# Location for old logs
# Used by the log-roll command
LOGPATH="'"$BACKUP_DIR"'/logs"

# Whether or not to gzip logs (must be commented out for no - DO NOT CHANGE TO NO)
#
GZIPLOGS=YES

# What to append to the logfile name (Leave blank for nothing)
LOGFILEAPPEND="logfile_"


# Settings for overviewer command
# ===============================

# Where the Map is generated
OUTPUTMAP="/home/'"${USERNAME}"'/mc-overviewer/render"

# Path to Minecraft-Overviewer
OVPATH="/home/'"${USERNAME}"'/mc-overviewer/Minecraft-Overviewer"

# Path for the config file of Overviewer
OVCONFIGPATH="/home/'"${USERNAME}"'/mc-overviewer"

# Name of Overviewer config file
OVCONFIGNAME="config.py"

# Path for backup worlds
OVBACKUP="/home/'"${USERNAME}"'/mc-overviewer/overviewerbackups"

# Things to leave alone ;)
# =====================

INVOCATION="java -Xmx$MAXMEM -Xms$INITMEM -XX:+UseConcMarkSweepGC -XX:+CMSIncrementalMode -XX:+AggressiveOpts -jar $SERVICE nogui"

# Path to the the mounted ramdisk (the default will work in most senarios).
RAMDISK="/dev/shm"' | tee $SRV_DIR/bin/config
                echo '[Settings]
backups_dir = '"$BACKUP_DIR"'/latest/
archives_dir = '"$BACKUP_DIR"'/archives/
hourly_backup_hour = 23
weekly_backup_day = 6
max_weekly_backups = 52
backup_extensions = "tar.gz",".tar.bz2",".jar"
log_level = ERROR' | sudo -u $USERNAME tee /home/$USERNAME/.rotate-backupsrc
                echo "alias $SRVNAME=$SRV_DIR/bin/script.servermgmt.sh" | sudo -u $USERNAME tee /home/$USERNAME/.bash_aliases
                clear
                echo -e "\e[1;32mInstalling Default Cronjobs in Crontab.";
                echo -e "\e[1;97m"
                sleep 1
               echo '( crontab -l | grep -v "'"$CRONCMD_BACKUP"'" ; echo "'"$CRONJOB_BACKUP"'" ) | crontab -
( crontab -l | grep -v "'"$CRONCMD_LOGROLL"'" ; echo "'"$CRONJOB_LOGROLL"'" ) | crontab -
( crontab -l | grep -v "'"$CRONCMD_TODISK"'" ; echo "'"$CRONJOB_TODISK"'" ) | crontab -
( crontab -l | grep -v "'"$CRONCMD_BACKUPROTATE"'" ; echo "'"$CRONJOB_BACKUPROTATE"'" ) | crontab -
( crontab -l | grep -v "'"$CRONCMD_WARN"'" ; echo "'"$CRONJOB_WARN"'" ) | crontab -
( crontab -l | grep -v "'"$CRONCMD_RESTART"'" ; echo "'"$CRONJOB_RESTART"'" ) | crontab -' > $SRV_DIR/bin/cron.sh
                cd $SRV_DIR/bin
                sudo -u $USERNAME bash cron.sh
                rm cron.sh
                echo -e "\e[1;32mIf there is no Crontab, Crontab will append to a blank file"
                echo -e "\e[1;32mSetting permissions on $SRV_DIR and Management Scripts."
                echo -e "\e[2;1;97m"
                sleep 2
                cd $SRV_DIR
                mv world $SRV_DIR/world_storage/
                mv world_nether $SRV_DIR/world_storage/
                mv world_the_end $SRV_DIR/world_storage/
                sudo chmod 755 -R $SRV_DIR
                sudo chmod 755 -R $BACKUP_DIR
                sudo chown $USERNAME:$USERNAME -R $SRV_DIR
                sudo chown $USERNAME:$USERNAME -R $BACKUP_DIR
                sudo chmod a+x -R $SRV_DIR/bin/*
                echo -e "\e[1;32mFinished!";
                echo -e "\e[1;33mLogin to the account $USERNAME via SSH or terminal and run the command; $SRVNAME start"
                echo -e "For more help please run the command; $SRVNAME help"
                echo -e "\e[1;36m"
                read -p "Press the [Enter] key to return to menu.";
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
