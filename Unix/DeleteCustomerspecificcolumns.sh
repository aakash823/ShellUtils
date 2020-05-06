#!/bin/bash

#find . -name "*CUSTDATA*" > listoff.txt

while read line
do

awk '
NR == 1 {
  for (i = 1; i <= NF; ++i) {
    if (match(tolower($i),/name/)) { name = i }
    if (match(tolower($i),/phone/)) { phone = i }
    if (match(tolower($i),/mail/)) { mail = i }
  }
}
{
  $name = "";
  $mail = "";
  $phone = "";
  print $0
}' $line > newf.txt

cat newf.txt
mv newf.txt $line


done < listoff.txt



