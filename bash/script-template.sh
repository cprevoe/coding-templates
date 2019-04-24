#!/bin/bash
#
# Name       : sceipt-template.sh
# Author     : Christopher Prevoe <packages@prevoe.com>
# Description: 
#     See the print_usage() function.
# History:
#     - Written by Christopher Prevoe in 2012 and distributed under GPL
#     - Relicensed April 24, 2019 by Christopher Prevoe under MIT.
#     - Adding to my public coding templates here:
#       https://github.com/cprevoe/coding-templates  
#

# Set up a fd for our verbose output.
exec 3>/dev/null

# 
# This will print the usage of this script to stdout.
#
print_usage() {
    echo "Usage: $0 [options] <parameter1> <parameter2>"
    echo "Description:"
    echo "	This is a template script, written so that I have a quick"
    echo "	skeleton with which to create  scripts."
    echo "Parameters:"
    echo "	parameter1	Details about the first parameter. Don't"
    echo "               	forget to try to stay within 80 chars."
    echo "	parameter2	Also, proper grammer should be used"
    echo "               	everywhere. You hate gramatical mistakes."
    echo "               	Don't be a hippocrit."
    echo "Options:"
    echo "	-v	Enable verbose mode."
    echo "	-h	Print this help message and exit."
}

#
# This will take anything passed in STDIN and print it if and only if verbose
# mode is enabled.
#
vcat() {
    cat >&3
}

# 
# Created for convienience, this works like normal echo only it passes 
# everything through vcat
#
vecho() {
    echo $@ | vcat
}

# 
# Global Variables. These should all be upper case and set once.
# 
LOG_DIR="/var/log/somewhere"

#
# Parse the dashed options provided.
#
while getopts hv option
do
    case $option in
        h)
            print_usage >&2
            exit 0
        ;;
        v) 
            exec 3>&2
            vecho "Enabled verbose mode."
        ;;
    esac
done
shift $(($OPTIND - 1))

# The parse remaining arguments. Be sure to check for too many/too few.
if [ $# -ne 2 ]; then
    print_usage >&2
    exit 1
fi

# Validate the sanity of the input. Include file existance checks.
if [ ! -d "${LOG_DIR}" ]; then
    echo "Error: The directory \"${LOG_DIR}\" does not exist." >&2
    exit 1
fi

# Insert the rest of your script here.
