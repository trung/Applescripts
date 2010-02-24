(*
Author: Nguyen Kien Trung
This script is to create an empty file at the selected folder.
Works on Leopard
*)


prop parent : app "Finder"

activate application "Finder"

try
	tell application "Finder"
		set selectedItem to get selection
		set selectedMacPath to (selectedItem as text)
		set selectedPath to POSIX path of selectedMacPath
		if exists folder selectedMacPath then
			set the_result to display dialog (POSIX path of (selectedMacPath as text)) ¬
				default answer "untitled.txt" ¬ 
				with title "New Empty File" ¬
				with icon caution ¬
				buttons {"Cancel", "OK"} ¬
				default button "OK"
			set button_pressed to button returned of the_result
			set thefilename to text returned of the_result
			if button_pressed is "OK" then
				set thefullpath to POSIX path of (selectedMacPath as text) & thefilename
				do shell script "touch \"" & thefullpath & "\""
			else
				-- action for cancel button goes here
			end if
		end if
	end tell
on error error_message
	beep
	display dialog error_message with title "Error" buttons {"OK"} default button 1
end try
