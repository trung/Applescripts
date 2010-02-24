(*
Author: Nguyen Kien Trung
This script is to delete files permanently without Trashing.
Interactive dialog is displayed for user to confirm the action.
Works on Leopard
*)

property parent : application "Finder"

set OK_MSG to "Sure, I am"
set CANCEL_MSG to "Sorry, I ain't"
set ABORT_MSG to "Abort, safety first"
set IGNORE_MSG to "Pass, try next one"

try
	tell application "Finder"
		activate
		set selectionList to get selection as list
		set selectionCount to count items in selectionList
		
		set asking_dialog to display dialog "There are " & selectionCount & Â
			" selected folders/files. 
Are you sure to delete permanently?" with title Â
			"Warning" with icon stop Â
			buttons {CANCEL_MSG, OK_MSG} Â
			default button CANCEL_MSG
		set button_pressed to button returned of result
		
		if button_pressed is OK_MSG then
			if selectionCount > 0 then
				repeat with i from 1 to number of items in selectionList
					set selectedItem to item i of the selectionList
					set selectedPath to POSIX path of (selectedItem as text)
					try
						do shell script "rm -rf \"" & selectedPath & "\""
					on error error_msg
						beep
						display dialog "Can't delete " & selectedPath & " due to: " & error_msg Â
							with icon 1 Â
							buttons {ABORT_MSG, IGNORE_MSG} Â
							default button IGNORE_MSG
						set button_pressed to button returned of result
						if button_pressed is ABORT_MSG then
							return 0
						else
							-- by pass
						end if
					end try
				end repeat
				return 0
			else
				return 0
			end if
		else
			return 0
		end if
	end tell
on error error_message
	beep
	display dialog error_message Â
		with title Â
		"Error" buttons {"OK"} default button 1
	set the clipboard to error_message
end try
