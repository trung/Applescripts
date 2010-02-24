(*
Author: Nguyen Kien Trung
This script is to open terminal at the selected folder.
Works on Leopard
*)

prop parent : app "Finder"

try
	tell application "Finder"
		set selectedItem to get selection
		set selectedMacPath to (selectedItem as text)
		set selectedPath to POSIX path of selectedMacPath
		(*
		set backupMacPath to "\"" & (get text 1 thru (((length of selectedMacPath) - (offset of ":" in (reverse of text items of selectedMacPath as string)))) of selectedMacPath) & ":\""
		set backupPath to POSIX path of backupMacPath
		display dialog selectedMacPath & "\n" & backupMacPath
		if not (exists folder selectedMacPath) then
			if  exists folder backupMacPath then
				display dialog "hehe"
				set selectedMacPath to backupPath
			end if
		end i*)
		if exists folder selectedMacPath then
			activate application "Terminal"
			tell application "System Events"
			    keystroke "t" using {command down}
			end tell
			tell application "Terminal"
				activate
				repeat with win in windows
			        try
			            if get frontmost of win is true then
			                do script "cd \"" & selectedPath & "\"" in (selected tab of win)
			            end if
			        end try
			    end repeat
			end tell
		else
			return 1
		end if
	end tell
on error error_message
	beep
	display dialog error_message with title "Error" buttons {"OK"} default button 1
end try
