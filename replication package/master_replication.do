clear all
set more off

*** CHANGE THE DIRECTORY HERE: ***
global dir "C:\Users\_WBL analysis\"
global dat  "$dir\Data"

cd "$dir"

do setup.do
do prepare_data.do
do program.do
