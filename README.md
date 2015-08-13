# BigDataToolkit
Utilities and scripts that make living the Big Data lifestyle a little more manageable

# Scripts
run_command.sh - Runs a command on all of the nodes in a cluster. I use for configuring OS level settings before using Ambari for the actual Hadoop installation. Things like configuring NTPD, turn off Transparent Huge Pages, etc.

check_jce.sh - Checks for the maximum available key strength on the system. Anything greater than 128 for maximum keylength would indicate the availability of the JCE Unlimited Key Strength for the Java executable displayed by the script at run time.

check_java_version.sh - Simply checks the version of Java and Javac on the server