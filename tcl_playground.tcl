# set test(1) hello
# set test(2) no


# # Delete item from array (not list)
# # unset test(1)

# # # Check if key exists in array (not list)
# # puts [info exists test(1)]


# # dict set testDict parent child

# # puts $testDict

# # set testDict [dict remove $testDict parent]
# # puts $testDict

# proc tester { t } {
#     # puts [format "got %s" $t]
#     again
#     return [expr $t == 1]
# }

# proc again {} {
#     puts "INSIDE"
# }

proc dictTest {d} {

    dict set d four 4

    return $d
}


set testa [dict create one 1 two 2 three 3]


set testa [dictTest $testa]

puts [dict exists $testa what g]

dict set testa what g 3

puts [dict exists $testa what g]
puts $testa

dict for {let info} $testa {
    puts [format "%s: %s" $let $info]
}

# Negation for if statement
# if {[expr ![string is double -strict 123.23]]} {
#     puts hello
# } else {
#     puts no
# }
# puts $test(2)

set dirname "./lists"

# if {[file exist $dirname]} {
#     # check that it's a directory
#     if {! [file isdirectory $dirname]} {
#         puts "$dirname exists, but it's a file"
#     } else {
#         puts "Is a directory!!"
#     }
# } else {
#     # file mkdir $dirname
#     puts "does not exist!"
# }