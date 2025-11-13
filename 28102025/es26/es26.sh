mkdir BUTTAMI
cd BUTTAMI
# touch \*
# touch \*\*
# touch \*\*\*
# touch \;\;
#
# touch '*'
# touch '**'
# touch '***'
# touch ';;'
#
touch "*"
touch "**"
touch "***"
touch ";;"

# touch "*.txt"
# touch "**.txt"
# touch "***.txt"
# touch ";;.txt"

for FILE in ./*; do
    touch "${FILE}.txt"
    # touch "$FILE.txt"
done

# quel ${} sostituisce il nome della var col suo contenuto

ls -la

cp -r /usr/include/ .

find . -type d

cd ..
rm -rf ./BUTTAMI
