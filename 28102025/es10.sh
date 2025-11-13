# for DIR in $(ls .); do
#     echo $DIR
# done

# $() fa l'espansione del comando dentro
# con ls e' come:
#
# for DIR in file1.txt file2.c file3.bob etc.bbb; do
#     echo $DIR
# done
#

for FILE in *; do
    echo "file is $FILE"
    # file $FILE
    ls -ld $FILE
done

# es 11

# for FILE in *; do echo "file is $FILE" ; ls -ld $FILE ; done

# es 12

for
