#!/bin/bash

echo "Please enter your name:"
read userName

mainDir="submission_reminder_${userName}"
mkdir -p "$mainDir"

cd "$mainDir" || exit

mkdir -p app modules assets config

cat > assets/submissions.txt <<EOL
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Shell Navigation, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Navigation, not submitted
Davy, Shell Navigation, submitted
George, Shell Navigation, not submitted
Mac, Shell Navigation, submitted
Samuel, Shell Navigation, not submitted
Kate, Shell Navigation, submitted
EOL

cat > config/config.env <<EOL
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOL

cat > app/reminder.sh <<EOL
#!/bin/bash

source ./config/config.env
source ./modules/functions.sh

submissions_file="./assets/submissions.txt"

echo "Assignment: \$ASSIGNMENT"
echo "Days remaining to submit: \$DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions \$submissions_file
EOL

cat > modules/functions.sh <<EOL
#!/bin/bash

function check_submissions {
    local submissions_file="./assets/submissions.txt"  

    echo "Checking submissions in \$submissions_file"

    while IFS=, read -r student assignment status; do

	student=\$(echo "\$student" | xargs)
        assignment=\$(echo "\$assignment" | xargs)
        status=\$(echo "\$status" | xargs)

	if [[ "\$assignment" == "\$ASSIGNMENT" && "\$status" == "not submitted" ]]; then
            echo "Reminder: \$student has not submitted the \$ASSIGNMENT assignment!"
        fi
    done < <(tail  "\$submissions_file")  
}
EOL

cat > startup.sh <<EOL
#!/bin/bash

echo "Starting the Submission Reminder App..."

bash app/reminder.sh
EOL

chmod +x app/reminder.sh modules/functions.sh startup.sh

echo "The environment for 'submission_reminder_${userName}' has been successfully created."
