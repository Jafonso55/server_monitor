# João Afonso - [LinkedIn](https://www.linkedin.com/in/joao-afonso55)

# Exercise resolution

1. **What is the type/format of the 2 provided files?**

.sh files - similar to batch file in Windows OS<br/>
.json files - JavaScript Object Notation, it's used to make machines parse information that is writen by human language. It is a standarized way to interchange data objects.

2. **In the "check-servers.sh", what does line number 1?**

Executes the script using the Bash shell, letting us create scripts in Unix.

3. **In the "check-servers.sh", what does line number 3?**

This jq line will query the whole server-list.json file line by line (or if the line is not empty) and it will filter all objects of the servers array and return the objects ip parameter with checkit set as true.

4. **In the "check-servers.sh", what does line number 5?**

* This line will create PING_AVG variable that will store the following:

* First it will run a ping on each ip that comes from the line that comes from the while cycle in line 3 , if the line is empty it will print the 'ping-failed min/avg/max/stddev = -1/-1/-1/-1 ms'

* With this ping result  'with tail -1' will result on the last line of the ping command , for example "rtt min/avg/max/mdev = 36.338/36.608/37.122/0.363 ms"

* After this the "awk '{print $4}'", it will filter the previous result on the 4th argument, which is 36.338/36.608/37.122/0.363

* Since we are looking for the average time of a ping to the destination in miliseconds from the string above doing a " cut -d '/' -f 2 " will delimit the string when a / is found, letting us choose the field 2 which is the average value of the corresponding ping, which is 36.608.

* Last but not least, to remove the decimal part of the value, "cut -d. -f1" will leave us with the number 36 as the final value for the PING_AVG variable.

5. **In the "check-servers.sh", what does line number 6?**

This line will iniciate the if statement if and it will go on to the next step if $PING_AVG is not null. If it's null it will send a print "[ERROR] PING AVG value not valid!"

6. **In the "check-servers.sh", what does line number 9?**

If the result of the If statement on line 7 is True, it will print the Warning message and on line 9 it will send a message to the remove server "https://pruu.herokuapp.com/dump/", with the message "warning", the ip of the line that is going through the cycle at this point and the average ping value stored on PING_AVG variable done on line 5. Also it will append on /dev/null

7. **Describe globally what happends when we execute the "check-servers.sh" file.**

Based on the previous questions, the bash script will test the connection to the servers that are on the json file.It will get the IP of each object listed as true and run a ping on each line and get the average time that this ping takes in miliseconds.
In case of this value is null the process stops and sends the ERROR message and the while cycle will continue to the next line in queu. 

In case of the value is not null it will go onto the second validation which is check if this PING_AVG is equal to -1 or if it's greater than MAX_AVG_ALLOWED ( variable set on line 2 ).
If this is true a WARNING message is printed and generates a report to an external remote server, in order to store this information.

If it's false the message will be printed as INFO with the corresponding IP of the line  and with the average value of the ping request.


In sum, this bash script will verify the connectivity to the machines listed on the JSON file ( which looks like DNS list ), it will make the process of checking the health of the connectivity by running this script.




