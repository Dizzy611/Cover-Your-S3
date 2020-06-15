Cover-Your-S3 is an automated backup solution for Windows leveraging s3cmd to do backups of your personal files to any S3-compatible object storage provider, such as Amazon S3 or Linode Object Storage.
Cover-Your-S3 should, when complete, allow you to create a task to back up files, folders, or an entire drive to an S3 bucket periodically from a friendly GUI.
To do this, it uses s3cmd sync (sources currently from s3cmd-2.1.0) and Windows Task Scheduler.
The plan for each actual Task Scheduler task is to use a template to create CMD scripts that run the required s3cmd sync calls and output to a readable log file.


Essentially, this is a way to turn a hacky, hardcoded automated backup solution I came up with to utilize Linode Object Storage as a backup system for myself, into something usable by others with a friendly GUI.
Hopefully I have not bitten off more than I can chew :)


 
