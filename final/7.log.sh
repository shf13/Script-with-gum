#!/bin/bash

currentdate=$(date +%Y-%h-%d.%H)

echo "#############################" >> install_log_${currentdate}.log
echo "CLI choices $CHOICES_CLI" >> install_log_${currentdate}.log
echo "#############################" >> install_log_${currentdate}.log
echo "Aliases choices $CHOICES_Aliases" >> install_log_${currentdate}.log
echo "#############################" >> install_log_${currentdate}.log
echo "Services choices $CHOICES_services" >> install_log_${currentdate}.log
echo "#############################" >> install_log_${currentdate}.log
echo "TUI choices $CHOICES_TUIs" >> install_log_${currentdate}.log
echo "#############################" >> install_log_${currentdate}.log
echo "git name $git_USER_NAME git email $git_USER_EMAIL" >> install_log_${currentdate}.log
echo "git key $git_ssh_key"
echo "#############################" >> install_log_${currentdate}.log
echo "Languages choices $CHOICES_lan" >> install_log_${currentdate}.log
echo "#############################" >> install_log_${currentdate}.log
