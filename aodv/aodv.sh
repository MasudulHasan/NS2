#!/bin/bash

number=0
for((number=0;number<5;number++)) do
    echo "Simulation no: $number"
    ns aodv.tcl
    awk -f aodv.awk aodv.tr>> aodv.data
   
done
xgraph aodv.data
