#!/bin/bash
export LANG=en_US.UFT-8
if [ "$1" = "" ]
	then
	current_dir=$PWD
	parameter="."
	else
	current_dir="$1"
	paremeter=$1
fi
echo "$parameter"

files_count=0
dirs_count=0

search() {
  local dir=$1
    local parent=$2
    local list=($dir/*)
    local len_list="${#list[@]}"
		
	for each in "${!list[@]}"
	do
			local parent_add=$'\u2502\u00A0\u00A0\u00A0'
			local child=$'\u251c\u2500\u2500\u0020'
			local name=${list[$each]}
			name=${name##*/}
			
			if [ $each -eq $((len_list-1)) ]
			then 
				child=$'\u2514\u2500\u2500\u0020'
				parent_add=$'\u0020\u0020\u0020\u0020'
			fi
			
			echo "$parent$child$name"
			
			if [ -d "$dir/$name" ]
			then
				dirs_count=$((dirs_count+1))
				search "$dir/$name" "$parent$parent_add"
			else
				files_count=$((files_count+1))
			fi
		done
}
search "${current_dir}" ""
echo
f="file"
f2="files"
d="directory"
d2="directories"
if [[ $dirs_count -eq 1 ]]
then vivo=$d
else vivo=$d2
fi
if [[ $files_count -eq 1 ]]
then vivod=$f
else vivod=$f2
fi
echo "$dirs_count $vivo , $files_count $vivod"
