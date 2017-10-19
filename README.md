# How to generate the source code documentation for OXID eShop 6 #

As from OXID eShop 6 on the source code is completely unencoded, you'll be able to generate the source code documentation by yourself - even for your entire project. This article describes how to build this documentation.

## Preparation ##

First we need to install Doxygen (http://doxygen.org) the tool which generates the documentation.

```
	
    // Install needed packages to build doxygen
    sudo apt-get update
	sudo apt-get install flex bison make cmake graphviz build-essential
    
	// Get the doxygen sources
    git clone https://github.com/doxygen/doxygen.git

	// Build doxygen
	mkdir doxygen/build
	cd doxygen/build
	sudo cmake -G "Unix Makefiles" ..
	sudo make
	sudo make install

```

After the installation you're ready to generate the source code documentaion.


## Generation of documentation ##

To generate the documentation you need an installed OXID eShop 6 or bigger and two files, a configuration file and a bash file (./generateSourceCodeDocumentation.sh).
 
Configutation file: *doxy.conf.template*

Bash file: *generateSourceCodeDocumentation.sh*

Once you have stored them in the same folder you can **execute** the bash file.

```
	
	This script must be run with four parameters.

	Usage:
	script -e <edition> -v <version> -i <input> -o <output>

 	 -e <edition>: Contains the OXID eShop edition CE or PE or EE for which you want to generate the documentation
 	 -v <version>: Contains the OXID eShop version for which you want to generate the documentation (e.g. 6.0.0)
	 -i <input>: Contains the source code folder (e.g. /var/www/oxideshop/vendor/oxid-esales/oxideshop-ce/)
	 -o <output>: Contains the html output folder (e.g. /var/www/oxideshop/sourcecodedocumentation/ce/)

```

**Examples**

Gererate source code documentation for OXID eShop CE

```
	
	./generateSourceCodeDocumentation.sh -e CE -v 6.0.0 -o /var/www/oxideshop/sourcecodedocumentation/ce/ -i /var/www/oxideshop/vendor/oxid-esales/oxideshop-ce/
```

Gererate source code documentation for OXID eShop PE

```
	
	./generateSourceCodeDocumentation.sh -e PE -v 6.0.0 -o /var/www/oxideshop/sourcecodedocumentation/pe/ -i /var/www/oxideshop/vendor/oxid-esales/oxideshop-pe/
```

Gererate source code documentation for OXID eShop EE

```
	
	./generateSourceCodeDocumentation.sh -e EE -v 6.0.0 -o /var/www/oxideshop/sourcecodedocumentation/ee/ -i /var/www/oxideshop/vendor/oxid-esales/oxideshop-ee/
```


## Output ##

In the folder given for the output you will find the HTML source code documentation.
