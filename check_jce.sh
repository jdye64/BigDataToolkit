#!/bin/sh -

set -o errexit
set -o nounset
set -o pipefail

# Checks for the availability of JCE
#
# source at https://github.com/jdye64/BigDataToolkit
#

# Make sure that a valid JDK is available
if type -p javac; then
    echo found javac executable in PATH
    _javac=javac
elif [[ -n "$JAVA_HOME" ]] && [[ -x "$JAVA_HOME/bin/javac" ]];  then
    echo found javac executable in JAVA_HOME     
    _javac="$JAVA_HOME/bin/javac"
else
    echo "Unable to locate valid JDK. Cannot compile test code without valid JDK"
    exit 1
fi

if [[ "$_javac" ]]; then
    version=$("javac" -version 2>&1 | awk -F '"' '/javac/ {print $1}')
    echo version "$version"
fi

# Finds the JRE executable for running the compiled JCETest
if type -p java; then
    echo found java executable in PATH
    _java=java
elif [[ -n "$JAVA_HOME" ]] && [[ -x "$JAVA_HOME/bin/java" ]];  then
    echo found java executable in JAVA_HOME     
    _java="$JAVA_HOME/bin/java"
else
    echo "no java"
fi

if [[ "$_java" ]]; then
    version=$("$_java" -version 2>&1 | awk -F '"' '/version/ {print $2}')
    echo version "$version"
    if [[ "$version" > "1.5" ]]; then
        echo version is more than 1.5
    else         
        echo version is less than 1.5
    fi
fi

# Compile and run the external Java JCETest.java file to detect JCE
$_javac src/java/JCETest.java
$_java -cp src/java JCETest
