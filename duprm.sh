# usare: ./duprm.sh (folder to check for duplicates) (folder to remove duplicates)

function clean(){
	rm .tmpdir1 .tmpdir2 .hashFolder1 .hashFolder2 .cmp .com 2> /dev/null
}

clean

echo Comparing directories
# folders can be manually set here.
folder1="$1"
folder2="$2"

find "$folder1" -type f > .tmpdir1
find "$folder2" -type f > .tmpdir2
while read i; do sha512sum "$i" >> .hashFolder1; done < .tmpdir1
while read i; do sha512sum "$i" >> .hashFolder2; done < .tmpdir2

while read i; do
	h=$(printf "$i"|cut -f 1 -d " ");
	f=$(printf "$i"|cut -d" " -f2-10000)
	if [[ $(grep $h .com) == "" ]]; then
		echo $h > .com
		grep "$h" .hashFolder2 > .cmp
		if [ -s .cmp ]; then
			echo "Duplicate found: $f. Remove the files:"
			cat .cmp |cut -d" " -f2-10000
			echo "y/n"
			read x </dev/tty
			[ "$x" = 'y' ] && while read y; do rm "$(echo $y|cut -d' ' -f2-10000)"; done < .cmp
		fi
		rm .cmp
	fi
done < .hashFolder1
clean
