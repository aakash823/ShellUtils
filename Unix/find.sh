#find all the files modified previous to 3days and before 5th day ignoring all git sub folders

find . -mtime +3 -mtime -5 -type f -not -path '*git*/*'