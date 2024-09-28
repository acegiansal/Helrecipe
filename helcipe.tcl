package require Tk


#### Global Variables

set num_reps 0

# Will be a dictionary where each frame name has its own set of values to use
# dictionary of arrays
# Name of initial key is the frame name then the array key is the name of the variable type
set recData [dict create]; # This line creates an empty dictionary
set recNameArr(-1) Debug


#### Frames


### Create Recipe Frame
proc createRecFrame { parent } {
    variable num_reps
    variable recData
    variable recNameArr
    # Initial setup for a recipe frame
    set num_reps [expr $num_reps + 1]
    set frameName $parent.recFrame$num_reps
    dict set recData "$frameName" num_ings 0

    frame $frameName -padx 10 -pady 10 -background RoyalBlue2

    frame $frameName.topFrame -borderwidth 10 -relief ridge -background blue
    entry $frameName.topFrame.recName -background red -foreground white -width 20 -justify left -textvariable recNameArr($frameName)
    button $frameName.topFrame.addIngButton -text "add ingredient" -command "createIngFrame $frameName.bottomFrame $frameName"

    ttk::separator $frameName.sep
    frame $frameName.bottomFrame -borderwidth 10 -relief ridge

    # Add all components to actual recipe frame
    grid $frameName.topFrame
    grid $frameName.topFrame.recName -sticky w
    grid $frameName.topFrame.addIngButton -column 1 -row 0 -sticky e -padx 5

    # grid propagate $frameName.topFrame 0 ;# Prevent the grid from resizing the frame from set size
    # NOTE: The above code will only work if the grids are given a sizes

    grid $frameName.sep -sticky ew -pady 20
    grid $frameName.bottomFrame

    # Add the actual recipe frame
    grid $frameName
    puts "added actual frame with name: $frameName"
}

## Create Ing Frame
proc createIngFrame { parent varName} {
    variable recData
    variable recNameArr
    dict set recData $varName num_ings [expr [dict get $recData $varName num_ings] + 1]
    puts [dict get $recData $varName num_ings]
    puts $recNameArr($varName)
}

#### File Handling (import and export)
proc sendToList {} {
}


########## Main ##########
console show
wm title . "Recipe Gui"

# Default Grid
grid [frame .rt -background green -padx 100 -pady 100]

## pack frames
createRecFrame .rt; # Create a rec frame for testing purposes

## Start event loop
vwait forever