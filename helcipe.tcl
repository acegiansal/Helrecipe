package require Tk


#### Global Variables

# Constants for units use
set METRIC_UNITS [list kg g mg L ml]
set IMPERIAL_UNITS [list oz lb tbsp tsp in cp]
set UNIT_LIST [list {*}$METRIC_UNITS {*}$IMPERIAL_UNITS units]

# Constants for frame sizes
set SIZE_5 250

set num_reps 0

# Will be a dictionary where each frame name has its own set of values to use
# dictionary of arrays
# Name of initial key is the frame name then the array key is the name of the variable type
set recData [dict create]; # This line creates an empty dictionary

# Global arrays for data collection
set recNameArr(-1) "RecNameDebug"
set ingNameArr(-1) "IngNameDebug"
set amountArr(-1) "AmountDebug"
set unitsArr(-1) "UnitsDebug"

# These variables will be used for data collection since TCL/tk requires global variables
set path_to_recs ""
set path_to_ings ""

#### Frames


### Create Recipe Frame
proc createRecFrame { parent } {
    variable num_reps
    variable recData
    variable recNameArr
    variable path_to_recs
    variable SIZE_5
    # Initial setup for a recipe frame
    set num_reps [expr $num_reps + 1]

    if { $path_to_recs == "" } {
        set path_to_recs $parent.recFrame
    }

    set frameName $path_to_recs$num_reps
    dict set recData "$frameName" num_ings 0

    frame $frameName -padx 10 -pady 10 -background RoyalBlue2

    frame $frameName.tf -borderwidth 10 -relief ridge -background blue
    entry $frameName.tf.recName -background NavajoWhite2 -width 20 -justify left -textvariable recNameArr($frameName)
    button $frameName.tf.addIngButton -text "add ingredient" -command "createIngFrame $frameName.bf $frameName"
    button $frameName.tf.deleteRecButton -text "Delete" -background red2 -command "deleteRec $frameName" -padx 10

    ttk::separator $frameName.sep
    frame $frameName.bf -pady 3 -padx 3 -background PaleGreen4 -width $SIZE_5 -height 30

    # Add all components to actual recipe frame
    grid $frameName.tf -sticky n
    grid $frameName.tf.recName -sticky w
    grid $frameName.tf.addIngButton -column 1 -row 0 -sticky e -padx 5
    grid $frameName.tf.deleteRecButton -column 2 -row 0 -padx 2

    # grid propagate $frameName.tf 0 ;# Prevent the grid from resizing the frame from set size
    # NOTE: The above code will only work if the grids are given a sizes

    grid $frameName.sep -sticky ew -pady 20
    grid $frameName.bf -sticky s

    # Add the actual recipe frame
    grid $frameName
    puts "added actual frame with name: $frameName"
}

## Create Ing Frame
proc createIngFrame { parent varName} {
    # Variables declared globally (because TCL sucks)
    variable recData
    variable recNameArr
    variable UNIT_LIST
    variable path_to_ings
    variable ingNameArr
    variable unitsArr
    variable amountArr

    set ING_FR_NM ingFr

    # Increment ing frame counter to the dictionary
    dict set recData $varName num_ings [expr [dict get $recData $varName num_ings] + 1]
    set curNumIngs [dict get $recData $varName num_ings]

    # Set ing frame name
    if { $path_to_ings == ""} {
        # Get the last component of the parent then add the constant ING_FR_NM to it
        # as of Oct 18, 2024, this should return bf
        set path_to_ings [lindex [split $parent .] end].$ING_FR_NM
    }
    set ingFrName $parent.$ING_FR_NM$curNumIngs
    puts [format "Creating ing frame --%d-- for %s with name %s" [dict get $recData $varName num_ings] $varName $ingFrName]

    frame $ingFrName -padx 1 -pady 1 -background burlywood2 -borderwidth 2 -relief ridge
    spinbox $ingFrName.amount -from 0 -to 10000 -increment 1 -width 5 -textvariable amountArr($ingFrName)

    # Create the menu
    tk_optionMenu $ingFrName.units unitsArr($ingFrName) {*}$UNIT_LIST
    # tk_optionMenu $ingFrName.units [dict get $recData $varName] {*}$UNIT_LIST

    entry $ingFrName.ingName -background azure -width 15 -justify left -textvariable ingNameArr($ingFrName)

    button $ingFrName.delIng -width 5 -text Delete -command "deleteIng $ingFrName"

    # puts [format "Varname: %s" [dict get $recData $varName]]

    grid $ingFrName.amount -sticky w
    grid $ingFrName.units -column 1 -row 0 -padx 5
    grid $ingFrName.ingName -column 2 -row 0
    grid $ingFrName.delIng -column 3 -row 0 -padx 3
    grid $ingFrName

}

proc deleteIng { ingFrName } {
    variable ingNameArr
    variable amountArr
    variable unitsArr
    puts [format "Deleting ing Frame: %s" $ingFrName]
    # Remeber to delete all information from the array!!

    # Remove panel
    destroy $ingFrName

    # Delete all array information
    unset ingNameArr($ingFrName)
    unset amountArr($ingFrName)
    unset unitsArr($ingFrName)
}

proc deleteRec { recFrName } {
    variable recData
    variable path_to_ings
    variable ingNameArr
    variable recNameArr

    set ing_path $recFrName.$path_to_ings
    # Delete each ingredient
    for {set i 1} {$i <= [dict get $recData $recFrName num_ings]} {incr i} {
        set ing_to_check $ing_path$i
        if {[info exists ingNameArr($ing_to_check)] == 1} {
            deleteIng $ing_to_check
        }
    }

    # Delete the recipe
    destroy $recFrName

    # Delete recipe data
    set recData [dict remove $recData $recFrName]
    unset recNameArr($recFrName)

}


#### File Handling (import and export)
proc sendToList {} {
}


#### Debug methods
proc _printAllInfo {} {
    variable recData
    variable recNameArr
    variable ingNameArr
    variable amountArr
    variable unitsArr

    puts "\n------- recData -------"
    puts $recData

    puts "------- recNameArr -------"
    foreach  {key val} [array get recNameArr] {
        puts [format "%s: %s" $key $val]
    }

    puts "------- ingNameArr -------"
    foreach  {key val} [array get ingNameArr] {
        puts [format "%s: %s" $key $val]
    }

    puts "------- amountArr -------"
    foreach  {key val} [array get amountArr] {
        puts [format "%s: %s" $key $val]
    }

    puts "------- unitsArr -------"
    foreach  {key val} [array get unitsArr] {
        puts [format "%s: %s" $key $val]
    }

}

proc _testProc { varName } {
    variable UNIT_LIST
    set value [$varName.units curselection]
    puts [format "index %s has been selected with value: %s" $value [lindex $UNIT_LIST $value]]

}

########## Main ##########
console show
wm title . "Recipe Gui"

# Default Grid
grid [frame .rt -background pink2 -padx 100 -pady 100]

## pack frames
createRecFrame .rt; # Create a rec frame for testing purposes

button .rt.debugButton -text "See data" -command "_printAllInfo"

grid .rt.debugButton

## Start event loop
vwait forever