
# package require Tk


# console show
# wm title . "Plaground"

# # Default Grid
# grid [frame .rt -background khaki -padx 100 -pady 100]

# ttk::notebook .rt.test
# frame .rt.test.p1
# frame .rt.test.p2
# label .rt.test.p1.t -text "label1"
# label .rt.test.p2.t -text "label2"

# .rt.test add .rt.test.p1 -text "test"
# .rt.test add .rt.test.p2 -text "test"

# grid .rt.test
# grid .rt.test.p1.t
# grid .rt.test.p1
# grid .rt.test.p2
# grid .rt.test.p2.t

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

package require Tk
ttk::notebook .n  -width 100 -height 100
frame .n.f1;
frame .n.f2;
.n add .n.f1 -text "TabOne"
.n add .n.f2 -text "TabTwo"
pack [label .n.f1.f2 -background red -foreground white -text "TabOne"]
pack [label .n.f2.f2 -background red -foreground white -text "TabTwo"]
pack .n