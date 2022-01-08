#!/bin/sh
echo $NAME $EMAIL $REASON
gh issue create --title "Access request for $NAME" --body "Email: $EMAIL <br>$REASON" --assignee @me