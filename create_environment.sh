#!/bin/bash

# Ask for the user's name
echo "Please enter your name:"
read userName

# Create the main directory for the app
mainDir="submission_reminder_${userName}"
mkdir -p "$mainDir"

# Change to the main directory
cd "$mainDir" || exit

# Create the necessary subdirectories
mkdir -p app modules assets config

# Create sample submission.txt file with some records in the 'assets' directory
cat > assets/submissions.txt <<EOL
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Davy, Emacs, submitted
George, vi, not submitted
Mac, Shell permissions, submitted
Samuel, Shell redirections, not submitted
Kate, Shell processes and signals, submitted
EOL

# Create config.env file in the 'config' directory
cat > config/config.env <<EOL
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOL

# Create reminder.sh file in the 'app' directory
cat > app/reminder.sh <<EOL
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: \$ASSIGNMENT"
echo "Days remaining to submit: \$DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions \$submissions_file
EOL

# Create functions.sh file in the 'modules' directory
cat > modules/functions.sh <<EOL
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file="./assets/submissions.txt"  # Correct path to access the file

    echo "Checking submissions in \$submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=\$(echo "\$student" | xargs)
        assignment=\$(echo "\$assignment" | xargs)
        status=\$(echo "\$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "\$assignment" == "\$ASSIGNMENT" && "\$status" == "not submitted" ]]; then
            echo "Reminder: \$student has not submitted the \$ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "\$submissions_file")  # Now it uses the correct relative path
}
EOL

# Create startup.sh file (this will start the app)
cat > startup.sh <<EOL
#!/bin/bash

# Startup script to launch the reminder app
echo "Starting the Submission Reminder App..."

# Source the reminder script
bash app/reminder.sh
EOL

# Make all the scripts executable
chmod +x app/reminder.sh modules/functions.sh startup.sh

# Inform the user that the environment has been created successfully
echo "The environment for 'submission_reminder_${userName}' has been successfully created."
