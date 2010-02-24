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
			set the_result to display dialog selectedPath ¬
				default answer "untitled.txt" ¬ 
				with title "New Empty File" ¬
				with icon caution ¬
				buttons {"Cancel", "OK"} ¬
				default button "OK"
			set button_pressed to button returned of the_result
			set thefilename to text returned of the_result
			if button_pressed is "OK" then
				set thefullpath to selectedPath & thefilename
				do shell script "touch \"" & thefullpath & "\""
			else
				return 0
			end if
		end if
	end tell
on error error_message number error_number
	if (error_number is equal to -128) then
		-- User cancelled.
		return 0
	else
		beep
		display dialog error_message with title "Error" buttons {"OK"} default button 1
	end if
end try

