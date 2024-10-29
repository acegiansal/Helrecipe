
package require Tk


# console show
# wm title . "Plaground"

# # Default Grid
# grid [frame .rt -background khaki -padx 100 -pady 100]

# # set choices {foo bar baz qux "None of the above"}
# # label .rt.menuLabel -text "Make a selection: "
# # # "choice" is a global variable
# # tk_optionMenu .rt.menu choice {*}$choices

# # label .rt.displayLabel -text "You chose: "
# # label .rt.display -textvariable choice

# # grid .rt.menuLabel .rt.menu
# # grid .rt.displayLabel .rt.display

# ## Start event loop
# vwait forever

# ttk::notebook .rt.n  -width 100 -height 100
# frame .rt.n.f1
# frame .rt.n.f2 -background red
# .rt.n add .rt.n.f1 -text "TabOne"
# .rt.n add .rt.n.f2 -text "TabTwo"

# label .rt.n.f1.f2 -background red -foreground white -text "TabOne"
# label .rt.n.f2.f2 -background red -foreground white -text "TabTwo"
# pack .rt.n.f1.f2
# pack .rt.n.f2.f2
# pack .rt.n

# ttk::notebook .rt.n -width 100 -height 100
# frame .rt.n.p1
# frame .rt.n.p2
# label .rt.n.p1.t -text "label1"
# label .rt.n.p2.t -text "label2"

# .rt.n add .rt.n.p1 -text "Test1"
# .rt.n add .rt.n.p2 -text "Test2"

# pack .rt.n.p1.t

# pack .rt.n.p2.t
# grid .rt.n


# grid [tk::listbox .l -yscrollcommand ".s set" -height 5] -column 0 -row 0 -sticky nwes
grid [tk::listbox .l -height 5] -column 0 -row 0 -sticky nwes
# grid [ttk::scrollbar .s -command ".l yview" -orient vertical] -column 1 -row 0 -sticky ns
grid [ttk::label .stat -text "Status message here" -anchor w] -column 0 -columnspan 2 -row 1 -sticky we
grid columnconfigure . 0 -weight 1; grid rowconfigure . 0 -weight 1
for {set i 0} {$i<100} {incr i} {
   .l insert end "Line $i of 100"
}