#!/bin/bash

# Get disk usage percentage as an integer
percentage=$(df --output=pcent / | tail -1 | tr -d '% ')

# Define text, tooltip and class based on percentage
text="${percentage}%"
tooltip="Disk usage: ${percentage}% used at /"

# Set class based on usage thresholds
if [ "$percentage" -ge 90 ]; then
	class="critical"
elif [ "$percentage" -ge 75 ]; then
	class="warning"
else
	class="normal"
fi

# Output JSON that Waybar can parse
echo "{\"text\": \"$text\", \"tooltip\": \"$tooltip\", \"class\": \"$class\", \"percentage\": $percentage }"
