#!/bin/bash

# find /usr/include -type d -executable

# -amin n
#   File was last accessed less than, more than or exactly n minutes ago.

# -cmin n
#   File's status was last changed less than, more than or exactly n minutes ago.

# -nmin n
#   File's data was last modified less than, more than or exactly n minutes ago.

# -executable
#   Matches files which are esecutable and directories which are searchable by the current user.

## OK no, lo vuole fatto con un for e if dentro

# Guarda lez.md del 28102025
for FILE in /usr/include/*; do
    if [[ (-d $FILE) && (-r $FILE) && ($FILE -nt /usr/include/stdio.h) ]]; then
        echo $FILE
    fi
done
