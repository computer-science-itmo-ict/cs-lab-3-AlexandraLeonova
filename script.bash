#!/bin/bash
export LANG=en_US.UTF-8
if ["$1" = ""]
  then
  dir=$PWD
  parameter="." 
  else
  dir="$1"
  parameter=$1
fi

echo "$parameter"

files_count=0
dirs_count=0




search() {
    local dirf=$1
	local parent=$2
	
	local list=($dirf/*)
	
	local len_list="${#list[@]}"
	

	
	
	for each in "${!list[@]}"
	do
		
		local parent_add=$'\u2502\u00A0\u00A0\u0020'
		local child=$'\u251c\u2500\u2500\u0020'
		
		local name=${list[$each]}
		name=${name##*/}
			
		if [ $each -eq $((len_list-1)) ]
		then
			child=$'\u2514\u2500\u2500\u0020'
			parent_add=$'\u0020\u0020\u0020\u0020'
		fi
		
		echo "$parent$child$name"
		
		if [ -d "$dirf/$name" ]
		then 
			dirs_count=$((dirs_count+1))
			search "$dirf/$name" "$parent$parent_add"
		else
			files_count=$((files_count+1))
		fi
	done
}
search "${dir}" ""
echo
f="file"
ff="files"
d="directory"
dd="directories"

if [[ $dirs_count -eq 1 ]]
then te=$d
else te=$dd
fi
if [[ $files_count -eq 1 ]]
then xt=$f
else xt=$ff
fi
echo "$dirs_count $te, $files_count $xt"


