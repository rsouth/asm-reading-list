# Build script?

#!/bin/sh

autorun=false
project=''

assembler=yasm
linker=ld

usage() {
	echo "Usage: $0 -f PROJECT [-r]"
	exit 1
}

options=':f:r'
while getopts $options option
do
	case "$option" in
		f ) project=$OPTARG;;
		r ) autorun=true;;
		: ) echo "Missing arg for -$OPTARG" >&2; exit 1;;
		* ) echo "Unimplemented option: -$OPTARG" >&2; exit 1;;
	esac
done

if [ $OPTIND -eq 1 ]; then
	echo "No options specified"
	usage;
fi

shift $(( OPTIND - 1 ))

echo "Building ${project} with:"
echo "\tProject: ${project} (${project}.asm)"
echo "\tAutorun: ${autorun}"
echo "\tAssembler: ${assembler}"
echo "\tLinker: ${linker}"

# check input file exists
if [ ! -f ${project}.asm ]; then
	echo "Could not find ${project}.asm"
	exit 1
fi

# assemble
echo "Running '${assembler} -f elf64 ${project}.asm'"
${assembler} -f elf64 ${project}.asm
s=$?

if [ ! ${s} -eq 0 ]; then
	echo "Aborting due to assembler error"
	exit ${s}
fi

# link
echo "Running '${linker} -s -o ${project} ${project}.o'"
${linker} -s -o ${project} ${project}.o

# show files...
ls -hnug| grep ${project}

if [ ${autorun} = true ]; then
	echo "Running ${project}"
	./${project}
fi



