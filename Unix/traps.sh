#!/bin/bash

trap " echo exit condition is entered" 2

n=1
while [ $n -lt 10 ]
do

sleep 1
echo $n
(($n++))

done 
