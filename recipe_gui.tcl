package require Tk


#### GLOBAL VARIABLES
variable num_reps

dict create recFrameVals


##### Create Recipe Frame
::oo::class create RecipeFrame {
    variable frameName
    variable totIngFrames

    constructor { parentFrame frameNum } {
        variable frameName
        variable totIngFrames

        set frameName "$parentFrame.recFrame$frameNum"
        set totIngFrames 0

        my createRecFrame
    }

    method createRecFrame {} {
        variable frameName

        # Method that points to actual creation method
        proc tunnelCreateIngFrame { parent } {
            createIngFrame $parent
        }


        puts "Found frameName: $frameName"
        # Create the default grid
        frame $frameName -padx 10 -pady 10
        frame $frameName.topFrame -background blue -borderwidth 10 -relief ridge -height 200 -width 200 -pady 10
        ttk::separator $frameName.sep
        frame $frameName.bottomFrame -background red -borderwidth 10 -relief ridge -height 200 -width 200 -pady 10
        button $frameName.topFrame.addButton -text "+" -command "createIngFrame $frameName.topFrame totIngFrames $totIngFrames"

        # Add the items to the actual grid
        grid $frameName.topFrame
        grid $frameName.topFrame.addButton
        grid propagate $frameName.topFrame 0 ;# Prevent the grid from resizing the frame from set size
        grid $frameName.sep -sticky ew -pady 20
        grid $frameName.bottomFrame

        # Add the actual frame itself
        grid $frameName
        puts "Finished Creating recipe Frame"
    }

    method getIngFrames {} {
        return $totIngFrames
    }

}


## Create Ingredient Frame
proc createIngFrame {parent ingFramesVar numIngFrames} {
    # Set totIngFrames
    upvar ${ingFramesVar} ingFrames
    set ingFrames [expr $numIngFrames + 1]
    puts "Value is now: $ingFrames"
    set ingFrameName $parent.ingFrame$ingFrames

    puts "Made ingFrame with name: $ingFrameName"

    frame $ingFrameName -background LightPink -width 100 -height 100

    grid $ingFrameName

}


##### Base Frame
proc createBaseFrame {} {
    variable num_reps

    set num_reps 0
    wm title . "Recipe Gui"

    # Default Grid
    grid [frame .contentPane -background green -padx 100 -pady 100]


    # Test create recipe frame
    set testFrame [RecipeFrame new .contentPane $num_reps]
    # vwait forever
}


########## MAIN ##########
console show
createBaseFrame
puts $num_reps