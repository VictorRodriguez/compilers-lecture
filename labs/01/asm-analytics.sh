echo Hi, this is the output of the analysis:

echo You have the following kind of instructions:

awk -F '[[:space:]][[:space:]]+' '$2 !~ /%/ && $2 !~/x86/ {print $2}' $1 | awk NF | sort | uniq -c | awk '{print $2 " : Executed " $1 " times"}'

echo You have the following functions:

awk ' /<[a-zA-Z]+>:/ {print $0}' $1 | tr -d "<>:" | awk ' { print $2 " : Located at address " $1  } '
