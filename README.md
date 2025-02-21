The create-environment.sh script will be doing the following once it is run:
Ask for the user's name
Then create the main directory with the format ' submission-reminder {username}'
Create the subdirectories : app modules assets config
Move the file submissions.txt with the submission data to the assets directory
Copy config.env file in the 'config' directory
Copy reminder.sh file in the 'app' directory
Source the scripts of the environment
Make path to the submissions file
Print remaining time and run the reminder script
Copy functions.sh file in the 'modules' directory
Read submissions file and print students who have not submitted
Check if assignment matches and status is 'not submitted'
Create startup.sh file which starts the app
Startup script launches reminder script
Source the reminder script
Make all the scripts executable
Inform the user that the environment has been created successfully when everything is done.
