#!/bin/bash

# Verify input
display_usage() { 
	echo "This script generates the OXID eShop sourcecode documentation and must be run with four parameters." 
	echo -e "\nUsage:\nscript -e <edition> -v <version> -i <input> -o <output> \n"
        echo -e " -e <edition>: Contains the OXID eShop edition CE or PE or EE for which you want to generate the documentation\n"
        echo -e " -v <version>: Contains the OXID eShop version (e.g. 6.0.0) for which you want to generate the documentation\n"
        echo -e " -i <input>: Contains the source code folder (e.g. /var/www/oxideshop/vendor/oxid-esales/oxideshop-ce/)\n"
        echo -e " -o <output>: Contains the html output folder (e.g. /var/www/oxideshop/sourcecodedocumentation/ce/)\n" 
	}

# if less than two arguments supplied, display usage 
if [  $# -le 4 ] 
then 
	display_usage
	exit 1
fi 

# check whether user had supplied -h or --help . If yes display usage 
if [[ ( $# == "--help") ||  $# == "-h" ]] 
then 
	display_usage
	exit 0
fi 


while [ "$1" != "" ]; do
case $1 in
        -e )           shift
                       EDITION=$1
                       ;;
        -v )           shift
                       VERSION=$1
                       ;;
        -i )           shift
                       INPUT=$1
                       ;;
        -o )           shift
                       OUTPUT=$1
    esac
    shift
done

if [ "$EDITION" = "" ]
then
    display_usage
fi
if [ "$VERSION" = "" ]
then
    display_usage
fi
if [ "$INPUT" = "" ]
then
    display_usage
fi
if [ "$OUTPUT" = "" ]
then
    display_usage
fi


if [[ ! -e $OUTPUT ]]; then
    mkdir -p $OUTPUT
fi

SOURCE=$(dirname "$0")"/doxy.conf.template"
DOXCFG="doxy.conf"

# Prepare configuration
cp -f $SOURCE $DOXCFG
sed -i -e "s@#EDITION#@$EDITION@g" "$DOXCFG"
sed -i -e "s@#INPUT#@$INPUT@g" "$DOXCFG"
sed -i -e "s@#OUTPUT#@$OUTPUT@g" "$DOXCFG"
sed -i -e "s@#VERSION#@$VERSION@g" "$DOXCFG"

# remove old content
read -p "The old version ($OUTPUT) will be removed. Continue(y/N) : " VAR
VAR="$VAR" | tr '[:upper:]' '[:lower:]'

if [ "$VAR" = "y" ]
then
    rm -rf $OUTPUT
else
   exit 0
fi





# Build source code documentation

doxygen "$DOXCFG"

DEST=$OUTPUT"/html/*"

mv $DEST $OUTPUT

rm $DOXCFG
