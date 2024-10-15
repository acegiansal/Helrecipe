
package require Tk


console show
wm title . "Plaground"

# Default Grid
grid [frame .rt -background khaki -padx 100 -pady 100]

set choices {foo bar baz qux "None of the above"}
label .rt.menuLabel -text "Make a selection: "
# "choice" is a global variable
tk_optionMenu .rt.menu choice {*}$choices

label .rt.displayLabel -text "You chose: "
label .rt.display -textvariable choice

grid .rt.menuLabel .rt.menu
grid .rt.displayLabel .rt.display

## Start event loop
vwait forever