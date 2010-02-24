(*http://www.macosxtips.co.uk/index_files/run-applescripts-with-keyboard-shortcuts.html*)
tell application "Safari"
	set bigURL to the URL in document 1
end tell
set tinyURL to (do shell script "curl --url \"http://metamark.net/api/rest/simple?long_url=" & bigURL & "\" ")
set the clipboard to tinyURL
