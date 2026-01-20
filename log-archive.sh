#!/bin/bash
input_function()
{
read -r -p "$1 [$2]:" input
echo "${input:-$2}"
}
while true;
do
     echo "1.Specify the log directory"
     echo "2.Specify the number of days to keep the log file"
     echo "3.Specify the number of days to keep backup Archives"
     echo "4.Run log Archive Process"
     echo "5.Exit"
     echo ""
     read -r -p "Choose an option [1-5]" choice
     
     case $choice in
     1)
      log_dir=$(input_function "Enter the directory" "/var/log")
      if [ ! -d "$log_dir" ]
      then
          echo "The directory does not exist"
          log_dir=""
      else
          echo "log directory set to  $log_dir"
      fi
      ;;
     2)
       days_to_keep_logs=$(input_function "How many days of log do you want to keep?" "7")
      echo "Back up archives older than $days_to_keep_logs days will be deleted."
      ;;
     3)days_to_keep_backups=$(input_function "How many days of backup archives do you want to keep?" "30")
            echo "Backup archives older than $days_to_keep_backups days will be deleted."
     ;;
     4) if [ -z "$log_dir" ];
       then
           echo " Error: Log directory is not set. Please set it first "
       else
           archive_dir="$log_dir/archive"
           mkdir -p "$archive_dir"
           timestamp=$(date +"%Y%m%d_%H%M%S")
           archive_file="$archive_dir/logs_archive_$timestamp.tar.gz"
           find "$log_dir" -type f -mtime +$days_to_keep_logs -print0 | tar -czvf "$archive_file" --null -T -
           echo "Logs archived in $archive_file on $(date)" >> "$archive_dir/archive_log.txt"
           find "$log_dir" -type f -mtime +$days_to_keep_logs -exec rm -f {} \;
           echo "Archiving completed: $archive_file"
           find "$archive_dir" -type f -name "*.tar.gz" -mtime +$days_to_keep_backups -exec rm -f {} \;
                echo "Backup archives older than $days_to_keep_backups days have been deleted."
        fi
     ;;
     5)
            echo " Exiting..."
            break
     ;;
     *)
            echo "Invalid option. Please choose a number between 1 and 5."
            ;;
     esac
done   
