# Log Archive Interactive Script

This is a Bash script that provides an **interactive menu** to manage and archive log files. It allows you to specify log directories, configure retention periods for logs and backup archives, and automatically archive and clean up old logs.

---

## Features

- **Specify the log directory**: Choose which directory contains the log files you want to manage.  
- **Set retention period for logs**: Define how many days to keep log files before archiving them.  
- **Set retention period for backup archives**: Define how long backup archives should be kept.  
- **Run the archiving process**:
  - Compresses log files older than the specified number of days into a timestamped `.tar.gz` archive.
  - Saves the archive in an `archive` subdirectory within the log directory.
  - Logs the archiving actions in `archive_log.txt`.
  - Deletes old log files and backup archives according to your retention settings.
- **Interactive menu**: Easy-to-use menu to set options and execute tasks without modifying the script.

---

## How to Use

Run the script directly (it will automatically ask for permissions if needed):

```bash
chmod +x log-archive.sh && ./log-archive.sh

Then follow the interactive menu:
1. Specify the log directory
2. Specify the number of days to keep the log file
3. Specify the number of days to keep backup archives
4. Run log archive process
5. Exit
