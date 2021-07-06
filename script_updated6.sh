#!/bin/bash
start=`date +%s`
today=`date +%Y-%m-%d.%H:%M:%S`

#SCRIPT=$(readlink -f "$0")

#LOC=$(dirname "$SCRIPT")
#echo $LOC
LOC=`pwd`
cd $LOC

#current=`pwd`
#echo $current
currentuser=`who am i | awk -F pts '{print $1}'`

 
email_alert()
{
	echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` Control inside email_alert() function">>$LOC/log/log_file_$today 
	A1=`echo "($db1)" "&" "($tab1)"` 
	A2=`hive -S -e "select count(*) from  $db1.$tab1 ;"| grep -v "^WARN" | tail -1` 
	A3=`echo "($db2)" "&" "($tab2)"`
	A4=`hive -S -e "select count(*) from  $db2.$tab2 ;" | grep -v "^WARN" | tail -1` 
	A5=`echo "($rslt_db)" "&" "($rslt_tab)"` 
	A6=`echo "($key1)"` 
	A7=`hive -S -e "select count(*) from  $rslt_db.$rslt_tab ;"| grep -v "^WARN" | tail -1` 
	cnt=`echo  "$key1" | awk -F\+ '{print NF-1}'`
	echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` value of cnt : $cnt ">>$LOC/log/log_file_$today
	
if [[ "$cnt" -eq 0 ]]
    then
		hive -S -e "SELECT a.$key11 FROM   $db1.$tab1 a LEFT JOIN $db2.$tab2 b ON a.$key11 = b.$key21  WHERE b.$key21 IS NULL ;" > $LOC/results/missing_from-$tab1 

		#Added code for warning message 
		#grep -v "^WARN" $LOC/results/missing_from-$tab1 >$LOC/results/missing_from_1-$tab1
		#cp $LOC/results/missing_from_1-$tab1 $LOC/results/missing_from-$tab1
		#rm $LOC/results/missing_from_1-$tab1

		sed -i '/(WARN)/d' $LOC/results/missing_from_1-$tab1

		A8=`wc -l $LOC/results/missing_from-$tab1 | awk '{print $1}'`
		
	    hive -S -e "SELECT a.$key21 FROM   $db2.$tab2 a LEFT JOIN $db1.$tab1 b ON a.$key21 = b.$key11  WHERE b.$key11 IS NULL ;" > $LOC/results/missing_from-$tab2
		
		#Added code for warning message 
		#grep -v "^WARN" $LOC/results/missing_from-$tab2 >$LOC/results/missing_from_2-$tab2
		#cp $LOC/results/missing_from_2-$tab2 $LOC/results/missing_from-$tab2
		#rm $LOC/results/missing_from_2-$tab2
		
		sed -i '/(WARN)/d' $LOC/results/missing_from_1-$tab2
		
		A9=`wc -l $LOC/results/missing_from-$tab2 | awk '{print $1}'`
		elif [[ "$cnt" -eq 1 ]] 
		then 
			hive -S -e "SELECT a.$key11,a.$key12 FROM   $db1.$tab1 a LEFT JOIN $db2.$tab2 b ON a.$key11 = b.$key21 and a.$key12 = b.$key22 WHERE b.$key21 IS NULL and b.$key22 is NULL ;" > $LOC/results/missing_from-$tab1
			
			#Added code for warning message 
			#grep -v "^WARN" $LOC/results/missing_from-$tab1 >$LOC/results/missing_from_1-$tab1
			#cp $LOC/results/missing_from_1-$tab1 $LOC/results/missing_from-$tab1
			#rm $LOC/results/missing_from_1-$tab1
			
			sed -i '/(WARN)/d' $LOC/results/missing_from_1-$tab2
			A8=`wc -l $LOC/results/missing_from-$tab1 | awk '{print $1}'`
			
			hive -S -e "SELECT a.$key21,a.$key22 FROM  $db2.$tab2 a LEFT JOIN $db1.$tab1 b ON a.$key21 = b.$key11 and a.$key22 = b.$key12 WHERE b.$key11 IS NULL and b.$key12 is NULL ;" > $LOC/results/missing_from-$tab2
			
			#Added code for warning message 
			#grep -v "^WARN" $LOC/results/missing_from-$tab2 >$LOC/results/missing_from_2-$tab2
			#cp $LOC/results/missing_from_2-$tab2 $LOC/results/missing_from-$tab2
			#rm $LOC/results/missing_from_2-$tab2

			sed -i '/(WARN)/d' $LOC/results/missing_from_1-$tab2
			A9=`wc -l $LOC/results/missing_from-$tab2 | awk '{print $1}'`
		elif [[ "$cnt" -eq 2 ]]
		then
			
            hive -S -e "SELECT a.$key11,a.$key12,a.$key13 FROM   $db1.$tab1 a LEFT JOIN $db2.$tab2 b ON a.$key11 = b.$key21 and a.$key12 = b.$key22 and a.$key13 = b.$key23 WHERE b.$key21 IS NULL and b.$key22 is NULL and b.$key23 is NULL ;" > $LOC/results/missing_from-$tab1

			#Added code for warning message 
			#grep -v "^WARN" $LOC/results/missing_from-$tab1 >$LOC/results/missing_from_1-$tab1
			#cp $LOC/results/missing_from_1-$tab1 $LOC/results/missing_from-$tab1
			#rm $LOC/results/missing_from_1-$tab1
			
			sed -i '/(WARN)/d' $LOC/results/missing_from_1-$tab1
			A8=`wc -l $LOC/results/missing_from-$tab1 | awk '{print $1}'`
			
			hive -S -e "SELECT a.$key21,a.$key22,a.$key23 FROM   $db2.$tab2 a LEFT JOIN $db1.$tab1 b ON a.$key21 = b.$key11 and a.$key22 = b.$key12 and a.$key23 = b.$key13 WHERE b.$key11 IS NULL and b.$key12 is NULL and b.$key13 is NULL ;" > $LOC/results/missing_from-$tab2
		    
			#Added code for warning message 
			#grep -v "^WARN" $LOC/results/missing_from-$tab2 >$LOC/results/missing_from_2-$tab2
			#cp $LOC/results/missing_from_2-$tab2 $LOC/results/missing_from-$tab2
			#rm $LOC/results/missing_from_2-$tab2
			sed -i '/(WARN)/d' $LOC/results/missing_from_1-$tab2
			A9=`wc -l $LOC/results/missing_from-$tab2 | awk '{print $1}'`
			 
		elif [[ "$cnt" -eq 3 ]]
		then
			
			hive -S -e "SELECT a.$key11,a.$key12,a.$key13,a.$key14 FROM   $db1.$tab1 a LEFT JOIN $db2.$tab2 b ON a.$key11 = b.$key21 and a.$key12 = b.$key22 and a.$key13 = b.$key23 and a.$key14 = b.$key24 WHERE b.$key21 IS NULL and b.$key22 is NULL and b.$key23 is NULL and b.$key24 is NULL;" > $LOC/results/missing_from-$tab1

			#Added code for warning message 
			#grep -v "^WARN" $LOC/results/missing_from-$tab1 >$LOC/results/missing_from_1-$tab1
			#cp $LOC/results/missing_from_1-$tab1 $LOC/results/missing_from-$tab1
			#rm $LOC/results/missing_from_1-$tab1

			sed -i '/(WARN)/d' $LOC/results/missing_from_1-$tab1
		    A8=`wc -l $LOC/results/missing_from-$tab1 | awk '{print $1}'`
			
			hive -S -e "SELECT a.$key21,a.$key22,a.$key23,a.$key24 FROM   $db2.$tab2 a LEFT JOIN $db1.$tab1 b ON a.$key21 = b.$key11 and a.$key22 = b.$key12 and a.$key23 = b.$key13 and a.$key24 = b.$key14 WHERE b.$key11 IS NULL and b.$key12 is NULL and b.$key13 is NULL and b.$key14 is NULL;" > $LOC/results/missing_from-$tab2

			#Added code for warning message 
			#grep -v "^WARN" $LOC/results/missing_from-$tab2 >$LOC/results/missing_from_2-$tab2
			#cp $LOC/results/missing_from_2-$tab2 $LOC/results/missing_from-$tab2
			#rm $LOC/results/missing_from_2-$tab2
			
			sed -i '/(WARN)/d' $LOC/results/missing_from_1-$tab2
			A9=`wc -l $LOC/results/missing_from-$tab2 | awk '{print $1}'`

		elif [[ "$cnt" -eq 4 ]]
		then
			hive -S -e "SELECT a.$key11,a.$key12,a.$key13,a.$key14,a.$key15 FROM   $db1.$tab1 a LEFT JOIN $db2.$tab2 b ON a.$key11 = b.$key21 and a.$key12 = b.$key22 and a.$key13 = b.$key23 and a.$key14 = b.$key24 and a.$key15 = b.$key25 WHERE b.$key21 IS NULL and b.$key22 is NULL and b.$key23 is NULL and b.$key24 is NULL and b.$key25 is NULL;" > $LOC/results/missing_from-$tab1

			#Added code for warning message 
			#grep -v "^WARN" $LOC/results/missing_from-$tab1 >$LOC/results/missing_from_1-$tab1
			#cp $LOC/results/missing_from_1-$tab1 $LOC/results/missing_from-$tab1
			#rm $LOC/results/missing_from_1-$tab1

			sed -i '/(WARN)/d' $LOC/results/missing_from_1-$tab1
			A8=`wc -l $LOC/results/missing_from-$tab1 | awk '{print $1}'`
			
			hive -S -e "SELECT a.$key21,a.$key22,a.$key23,a.$key24,a.$key25 FROM   $db2.$tab2 a LEFT JOIN $db1.$tab1 b ON a.$key21 = b.$key11 and a.$key22 = b.$key12 and a.$key23 = b.$key13 and a.$key24 = b.$key14 and a.$key25 = b.$key15 WHERE b.$key11 IS NULL and b.$key12 is NULL and b.$key13 is NULL and b.$key14 is NULL and b.$key15 is NULL;" > $LOC/results/missing_from-$tab2

			#Added code for warning message 
			#grep -v "^WARN" $LOC/results/missing_from-$tab2 >$LOC/results/missing_from_2-$tab2
			#cp $LOC/results/missing_from_2-$tab2 $LOC/results/missing_from-$tab2
			#rm $LOC/results/missing_from_2-$tab2
			
			sed -i '/(WARN)/d' $LOC/results/missing_from_1-$tab2
			A9=`wc -l $LOC/results/missing_from-$tab2 | awk '{print $1}'`
fi

	echo "#,   Parameters,   Counts/Value" > $LOC/results/stat_file.csv
	echo "1,   1st db & table name,   $A1" >> $LOC/results/stat_file.csv
	echo "2,   no of rec. in 1st table,   $A2" >> $LOC/results/stat_file.csv
	echo "3,   2nd db & table name,   $A3" >> $LOC/results/stat_file.csv
	echo "4,   no of rec. in 2nd table,   $A4" >> $LOC/results/stat_file.csv
	echo "5,   db and table for Mismatch result,   $A5" >> $LOC/results/stat_file.csv
	echo "6,   key used for comparison,   $A6" >> $LOC/results/stat_file.csv
	echo "7,   total no. of mismatches,   $A7" >> $LOC/results/stat_file.csv
	echo "8,   no of rec. Present in ($tab1) but not in ($tab2)  ,   $A8" >> $LOC/results/stat_file.csv
	echo "9,   no of rec. Present in ($tab2) but not in ($tab1)  ,   $A9" >> $LOC/results/stat_file.csv
	end=`date +%s`
	#runtime=$((end-start));
	runtime=`date -u -d @$((end-start)) +"%T"`
	mis_col_list=`cat $LOC/results/mismatch_col_list`
	#mis_col_list=`sed -n 'p' $LOC/results/mismatch_col_list`
	echo "10,  List of column having atleast one mismatch, $mis_col_list  " >> $LOC/results/stat_file.csv
        null_col_list=`cat $LOC/results/null_col_list`
	echo "11,  List of column having atleast one NULL value, $null_col_list  " >> $LOC/results/stat_file.csv
	echo "12,  Column list with distinct value is present at , $LOC/results/distinct_col_list  " >> $LOC/results/stat_file.csv
	echo "13,  Start Time for the test ,  $today  " >> $LOC/results/stat_file.csv
	echo "14,  Total Time taken for the process to complete,  $runtime  " >> $LOC/results/stat_file.csv
	echo "15,  User trigger test,  $currentuser ">>$LOC/results/stat_file.csv
	RUN_DT=`date +%Y-%m-%d`
	mail_list=`grep mail_list $LOC/Config/config| cut -d'=' -f2`
	FROM=Comparision_Run_Statistics@Auto.com
	TO=$mail_list
	#SUBJECT="Don't reply !!! Automation Data compare statistics !!! "
	SUBJECT=`grep subject $LOC/Config/config | cut -d'=' -f2`
	FILE="$LOC/results/stat_file.csv"
(
	echo "From: $FROM"
	echo "To: $TO"
	echo "Subject: $SUBJECT"
	echo "Content-type: text/html"
	echo ""
	echo "<html>"
	echo "<style>"
	echo "table.metric { background-color: #885159; }"
	echo "body { font-family: Arial, Helvetica, sans-serif; background-color: #FFFFFF; }"
	echo "p { font-family: Arial, Helvetica, sans-serif; font-size: 12px;font-weight: bold;color: #2F4F4F }"
	#echo "q { font-family: Arial, Helvetica, sans-serif; font-size: 10px;color: #38389e }"
	echo "th { font-family: "Times New Roman", Georgia, Serif; font-size: 12px;font-weight: bold;color: #483D8B }"
	echo "th.metric { background-color: #003366; color: #FFFFFF; padding: 4px 8px; }"
	echo "td { font-family: "Times New Roman", Georgia, Serif; font-size: 14px; color: #483D8B }"
	echo "td.metric { background-color: #E5E8EF; }"
	echo "</style>"
	echo "<body>"
	echo "<p>Find Below the Comparison stats for the tables '"$db1.$tab1"' & '"$db2.$tab2"' on $RUN_DT </p>"
	#echo "<q> Find Below the Comparison stats for the table '"$tab1"' & '"$tab2"' on $RUN_DT </q>"
	echo "<table>"

	# convert a CSV file to table format, first line is the header
	head -1 $FILE | sed -e 's/,/<\/th><th class="metric">/g' -e 's/^/<tr><th class="metric">/' -e 's/$/<\/th><\/tr>/'
	cat $FILE | sed -e 1d -e 's/,/<\/td><td class="metric">/g' -e 's/^/<tr><td class="metric">/' -e 's/$/<\/td><\/tr>/'

	echo "</table>"
	echo "</body>"
	echo "</html>"
) | sendmail $TO
	echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` Control out from email_alert() function">>$LOC/log/log_file_$today 
}

stat1()
{

#grep -v "^WARN" $LOC/results/compare.csv >$LOC/results/compare_1.csv
#cp $LOC/results/compare_1.csv $LOC/results/compare.csv
#rm $LOC/results/compare_1.csv

sed -i '/WARN/d' $LOC/results/compare.csv

perl -p -i -e 's/	/,/g' $LOC/results/compare.csv
	echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` Control inside stat1() function">>$LOC/log/log_file_$today 
	echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` Comparison Completed">>$LOC/log/log_file_$today
	echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` Mismatch file created @ $LOC/compare.csv">>$LOC/log/log_file_$today
	echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` Mismatch hive tables created @ $rslt_db.$rslt_tab">>$LOC/log/log_file_$today
	echo "**************************************************************************"
	echo "Comparison Completed & Result hive table created @ $rslt_db.$rslt_tab	    "
	echo "																		    "
	echo "1.	Mismatch file created @ $LOC/compare.csv					    "
	echo "2.	Mismatch hive tables created @ $rslt_db.$rslt_tab				    " 
	echo "**************************************************************************" 
	echo "																		    "	
if [ $null_col_list == Y ] ;then
        null_col_lst
fi

if [ $mismatch_col_list == Y ] ;then 
	missmatch_col
fi

if [ $distinct_col_list == Y ] ;then
        distinct_col_lst
fi

				if [ $mail_service == Y ] ; then
					echo -e "\nStats collection for alert is in progress ..."
					echo -e "\nPlease wait till the process completes , it may take some time ...		"
					email_alert
					echo "																		    "
					echo "Process Completed ,Please check your Inbox for the email alert 			"
			else 
					echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` User has set mail_service=N in config file">>$LOC/log/log_file_$today
					echo -e "\nNo Alert Set by User"
					echo "                                                                                    "
					end=`date +%s`
		#runtime=$((end-start))
					runtime=`date -u -d @$((end-start)) +"%T"`
			fi
	echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` Control out from stat1() function">>$LOC/log/log_file_$today 
}
stat2()
{ 
	#grep -v "^WARN" $LOC/results/compare.csv >$LOC/results/compare_1.csv
	#cp $LOC/results/compare_1.csv $LOC/results/compare.csv
	#rm $LOC/results/compare_1.csv
	
	sed -i '/WARN/d' $LOC/results/compare.csv
	
	
	echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` Control inside stat2() function">>$LOC/log/log_file_$today
	echo "[Error]:`date +%Y-%m-%d.%H:%M:%S` found some issue with comparison">>$LOC/log/log_file_$today
	echo "[Error]:`date +%Y-%m-%d.%H:%M:%S` Please revisit the config @ $LOC/Config/config">>$LOC/log/log_file_$today
	echo "[Error]:`date +%Y-%m-%d.%H:%M:%S` Please revisit the comp_col @ $LOC/Config/comp_col">>$LOC/log/log_file_$today
	echo "[Error]:`date +%Y-%m-%d.%H:%M:%S` Please revisit the tables $tab1 ,$tab2">>$LOC/log/log_file_$today
	echo "***********************************************************************************"
	echo "		SORRY !!! There found some issue with comparison  							 "
	echo "																		   			 "
	echo "1. Please revisit the config @ $LOC/Config/config                                   "
	echo "2. Please revisit the comp_col @ $LOC/Config/comp_col                              "
	echo "3. Please revisit the tables $tab1 ,$tab2                                          "
	echo "																		   			 "
	echo "          Please fix the issues & Run Again                                        "
	echo "***********************************************************************************" 
	
		end=`date +%s`
		#runtime=$((end-start))
		runtime=`date -u -d @$((end-start)) +"%T"`
	echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` Control out from stat2() function">>$LOC/log/log_file_$today 
}
echo "***********************************************************************"
echo " 		Comparison Automation process Initiated ..                       "
echo "***********************************************************************"
echo "																		"

rm -rf log/log_file_*
rm -rf hql/comp_query.hql

## Reading parameters from config files ##
echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` Start reading parameters from config files" >> $LOC/log/log_file_$today

db1=`grep db1 $LOC/Config/config | cut -d'=' -f2`
db2=`grep db2 $LOC/Config/config | cut -d'=' -f2`
tab1=`grep tab1 $LOC/Config/config | cut -d'=' -f2`
tab2=`grep tab2 $LOC/Config/config | cut -d'=' -f2`
src_typ=`grep src_typ $LOC/Config/config | cut -d'=' -f2`
tgt_typ=`grep tgt_typ $LOC/Config/config | cut -d'=' -f2`
key1=`grep key1 $LOC/Config/config | cut -d'=' -f2`
key11=`echo $key1 | cut -d'+' -f1`
key12=`echo $key1 | cut -d'+' -f2`
key13=`echo $key1 | cut -d'+' -f3`
key14=`echo $key1 | cut -d'+' -f4`
key15=`echo $key1 | cut -d'+' -f5`
key2=`grep key2 $LOC/Config/config | cut -d'=' -f2`
key21=`echo $key2 | cut -d'+' -f1`
key22=`echo $key2 | cut -d'+' -f2`
key23=`echo $key2 | cut -d'+' -f3`
key24=`echo $key2 | cut -d'+' -f4`
key25=`echo $key2 | cut -d'+' -f5`
rslt_db=`grep rslt_db $LOC/Config/config| cut -d'=' -f2`
rslt_tab=`grep rslt_tab $LOC/Config/config| cut -d'=' -f2`
mail_list=`grep mail_list $LOC/Config/config| cut -d'=' -f2`
mail_service=`grep mail_service $LOC/Config/config| cut -d'=' -f2`
All_col_2_comp=`grep All_col_2_comp $LOC/Config/config| cut -d'=' -f2`
diff_rslt_csv=`grep diff_rslt_csv $LOC/Config/config| cut -d'=' -f2`
data_typ_comp=`grep data_typ_comp $LOC/Config/config| cut -d'=' -f2`
mismatch_col_list=`grep mismatch_col_list $LOC/Config/config| cut -d'=' -f2`
null_col_list=`grep null_col_list $LOC/Config/config | cut -d'=' -f2`
distinct_col_list=`grep distinct_col_list $LOC/Config/config| cut -d'=' -f2`
cnt=`echo  "$key1" | awk -F\+ '{print NF-1}'`
echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` Config file has been read successfully" >> $LOC/log/log_file_$today

##data type compare of two tables ##

if [ $data_typ_comp == Y ] ; 
	then 
		echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` Starting Data type comparison of $tab1 & $tab2" >> $LOC/log/log_file_$today
		echo -e "\ndatatypes of  $tab1 & $tab2 need to be compared , comparision is in progress..."	 
		echo -e "tab1_colname \t\tdatatype                                   | tab2_colname \t\tdatatype" > $LOC/results/datatyp_mismatch
		echo "========================================================================================================" >> $LOC/results/datatyp_mismatch
		echo "desc $db1.$tab1;" > $LOC/q1
		hive -S -f  $LOC/q1  > $LOC/q11
		echo "desc $db2.$tab2;" > $LOC/q2
		hive -S -f  $LOC/q2  > $LOC/q12
		
		echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` Verification of data type mismatch started of $tab1 table">> $LOC/log/log_file_$today
		while read colA
				do 
					c11=`echo $colA | awk  '{print $1}'` 
					a1=`grep -w $c11 $LOC/q11`
					a2=`grep -w $c11 $LOC/q12`
					if [ "$a1" != "$a2" ] 	
						then  echo "$a1| $a2" >> $LOC/results/datatyp_mismatch			 
					fi  		 
				done < $LOC/q11
		echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` Verification of data type mismatch completed of $tab1 table">> $LOC/log/log_file_$today	
		echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` Verification of data type mismatch started of $tab2 table">> $LOC/log/log_file_$today
			while read colB
				do 
					c21=`echo $colB | awk  '{print $1}'` 
					b1=`grep -w $c21 $LOC/q12`
					b2=`grep -w $c21 $LOC/q11`
										
					#if [ ! -z "$b1" ] && [ -z "$b2" ]
					if [ -z "$b2" ]
					 	then  echo -e "\t\t\t\t\t\t\t\t| $b1" >> $LOC/results/datatyp_mismatch			 
					fi  		 
				done < $LOC/q12	
		echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` Verification of data type mismatch completed of $tab2 table">> $LOC/log/log_file_$today

			z1=`wc -l  $LOC/results/datatyp_mismatch | awk  '{print $1}'`
				if [ "$z1" -gt 2 ]
					then 
                        echo "                ">> $LOC/log/log_file_$today		
						echo "Please check the datatype mismatch details @ $LOC/results/datatyp_mismatch"
						echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` Data type mismatch file created @ $LOC/results/datatyp_mismatch">> $LOC/log/log_file_$today
					else
					    echo "               "
						echo "There is no datatype mismatch between $tab1 & $tab2 , It will go ahead with the data comparison"	
						echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` There is no datatype mismatch between $tab1 & $tab2">> $LOC/log/log_file_$today
						rm $LOC/results/datatyp_mismatch					
				fi				      		
	rm -f q1 q11 q2 q12 
fi

##If datatype mismatch then terminate the job##

if [ $data_typ_comp == Y ] && [ $All_col_2_comp == Y ] && [ "$z1" -gt 2 ]
then 
	echo "[Error]:`date +%Y-%m-%d.%H:%M:%S` Job terminated due to data type mismatch found between $tab1 and $tab2 tables">>$LOC/log/log_file_$today
    echo "Data types of $tab1 and $tab2 are not in sync , data comparision cant proceed further "
	echo "              "
	echo "Please check the datatype mismatchs @ $LOC/results/datatyp_mismatch and take necessary action"
	echo "                                                                    "
	echo "Terminating the job execution .."
	exit 1
fi	

### case when we need to compare all the columns of two tables ###

if echo "$All_col_2_comp" | grep -w -q "Y"
  then
	 echo "[Warning]:`date +%Y-%m-%d.%H:%M:%S` User has set All_col_2_comp variable as Y in confif file">>$LOC/log/log_file_$today	
     echo "				"
     echo "ALL columns of tables $tab1 & $tab2 need to be compared , dynamic comp_col file creation is in progress..."	 
	 echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` ALL columns of tables $tab1 & $tab2 need to be compared , dynamic comp_col file creation is in progress...">>$LOC/log/log_file_$today
     echo "desc $db1.$tab1;" > $LOC/q1
	 hive -S -f  q1 | awk '{print $1}' | awk '{print ":"$0}' > $LOC/q11_t 
	 awk '{print $0"   & "}' $LOC/q11_t > $LOC/q11
	 #cp $LOC/q11  $LOC/q12
	 #echo "desc $db2.$tab2;" > $LOC/q2
	 #hive -S -f  q2 | awk '{print $1}' | awk '{print ":"$0}' > $LOC/q12
	 paste q11 q11_t > $LOC/Config/comp_col
	 cd $LOC/
	 rm -f q1 q11 q11_t
	 echo "													"
	 echo "'comp_col' file created  as $LOC/Config/comp_col 	"
	 echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` 'comp_col' file created  as $LOC/Config/comp_co">>$LOC/log/log_file_$today
fi

### collecting the column list where in we have atleast one mismatch  ###

null_col_lst(){
echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` Control inside null_col_lst() function">>$LOC/log/log_file_$today
rm -rf $LOC/trans_data_files/null_col_list_1
rm -rf $LOC/results/null_col_list
cat $LOC/Config/comp_col | awk '{print $1}' |sed 's/^.//' > $LOC/trans_data_files/col_list
echo "SET hive.cli.print.header=true;select" > $LOC/hql/null_hql
while read col
	do 
		#echo "case when size(collect_set(${col}_1)) > 1 then 'ISSUE' ELSE 'NO-ISSUE' END as $col," >>$LOC/hql/miss_hql
		echo "COUNT(*)-COUNT($col) As $col,">>$LOC/hql/null_hql
		echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` inside while loop of null_col_lst() function ">>$LOC/log/log_file_$today
	done < $LOC/trans_data_files/col_list
sed -i '$ s/.$//' $LOC/hql/null_hql
echo "FROM ${db1}.${tab1} ;" >> $LOC/hql/null_hql

hive -S -f $LOC/hql/null_hql > $LOC/trans_data_files/null_col

if [ "$?" -eq 0 ]; then
	cols=`head -n 1 $LOC/trans_data_files/null_col | wc -w`
	for (( i=1; i <= $cols; i++))
		do cut -f $i $LOC/trans_data_files/null_col | tr $'\n' $'\t' | sed -e "s/\t$/\n/g" | grep -v "0" | cut -f1 >> $LOC/trans_data_files/null_col_list_1
		echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` inside for loop of null_col_lst() function, value of i - $i  ">>$LOC/log/log_file_$today
		done
		tr '\n' ';' < $LOC/trans_data_files/null_col_list_1 >> $LOC/results/null_col_list
		echo -e "\nPlease verify for the column list having atleast one mismatch @ $LOC/results/null_col_list \n"
else 
	echo -e "\nError in null column collection , please verify the result table \n"
fi

echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` Control out from null_col_lst() function">>$LOC/log/log_file_$today
#sed -i '===========================================================' $LOC/trans_data_files/null_col_list_1
#sed -i '/===========================================================/i NULL value column list' $LOC/trans_data_files/null_col_list_1
sed -i '1i===========================================================\' $LOC/trans_data_files/null_col_list_1
sed -i '/===========================================================/i NULL value column list' $LOC/trans_data_files/null_col_list_1

}

missmatch_col(){
echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` Control inside missmatch_col() function">>$LOC/log/log_file_$today
rm -rf $LOC/results/mismatch_col_list
rm -rf $LOC/trans_data_files/mismatch_col_list_1

cat $LOC/Config/comp_col | awk '{print $1}' |sed 's/^.//' > $LOC/trans_data_files/col_list
echo "SET hive.cli.print.header=true;select" > $LOC/hql/miss_hql
while read col
	do 
		echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` inside while loop of mismatch_col() function ">>$LOC/log/log_file_$today
		echo "case when size(collect_set(${col}_1)) > 1 then 'ISSUE' ELSE 'NO-ISSUE' END as $col," >>$LOC/hql/miss_hql
	done < $LOC/trans_data_files/col_list

sed -i '$ s/.$//' $LOC/hql/miss_hql
echo "FROM ${rslt_db}.${rslt_tab} ;" >> $LOC/hql/miss_hql

hive -S -f $LOC/hql/miss_hql > $LOC/trans_data_files/miss_col

if [ "$?" -eq 0 ]; then
	cols=`head -n 1 $LOC/trans_data_files/miss_col | wc -w`
	for (( i=1; i <= $cols; i++))
		do cut -f $i $LOC/trans_data_files/miss_col |tr $'\n' $'\t'|sed -e "s/\t$/,/g" | grep -v "NO-ISSUE" | cut -f1 >> $LOC/trans_data_files/mismatch_col_list_1 
 
		echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` inside for loop of mismatch_col() function, value of i - $i  ">>$LOC/log/log_file_$today
		done
		tr '\n' ';' < $LOC/trans_data_files/mismatch_col_list_1 >> $LOC/results/mismatch_col_list
		echo -e "\nPlease verify for the column list having atleast one mismatch @ $LOC/results/mismatch_col_list \n"
else 
	echo -e "\nError in mismatch column collection , please verify the result table \n"
fi

#sed -i '===========================================================' $LOC/trans_data_files/mismatch_col_list_1
#sed -i '/===========================================================/i Mismatch value column list' $LOC/trans_data_files/mismatch_col_list_1
sed -i '1i===========================================================\' $LOC/trans_data_files/mismatch_col_list_1
sed -i '/===========================================================/i Mismatch column list' $LOC/trans_data_files/mismatch_col_list_1

#Added Code for Mismatch records list based on column value feature 
tail -n +3 $LOC/trans_data_files/mismatch_col_list_1 > $LOC/trans_data_files/mismatch_col_list_final_1

key=`grep key1 $LOC/Config/config | cut -d'=' -f2 | sed 's/+/,/g'`

while read colB
	do 
		hive -S -e "set hive.cli.print.header=true;select $key,"$colB"_1,"$colB"_2 from $rslt_db.$rslt_tab where "$colB"_1 !='=' or "$colB"_2 !='=';" > $LOC/results/mismatch_col_records/$colB
		  		 
	done < $LOC/trans_data_files/mismatch_col_list_final_1


echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` Control out from missmatch_col() function">>$LOC/log/log_file_$today
}

distinct_col_lst(){
echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` Control inside distinct_col_lst() function">>$LOC/log/log_file_$today
rm -rf $LOC/results/distinct_col_list
cat $LOC/Config/comp_col | awk '{print $1}' |sed 's/^.//' > $LOC/trans_data_files/col_list
echo "SET hive.cli.print.header=true;select" > $LOC/hql/distinct_hql
while read col
	do 
		echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` inside while loop of distinct_col_lst() function ">>$LOC/log/log_file_$today
		echo "concat_ws(',',collect_set(cast($col as string))) as $col," >>$LOC/hql/distinct_hql
				
	done < $LOC/trans_data_files/col_list
sed -i '$ s/.$//' $LOC/hql/distinct_hql
echo "FROM ${db1}.${tab1} ;" >> $LOC/hql/distinct_hql

hive -S -f $LOC/hql/distinct_hql > $LOC/trans_data_files/distinct_col

sed -i '/(WARN)/d' distinct_col

echo -e "Distinct value column list\t " > $LOC/results/distinct_col_list
sed -i '/(WARN)/d' distinct_col_list
echo "========================================================================" >> $LOC/results/distinct_col_list

if [ "$?" -eq 0 ]; then
	cols=`head -n 1 $LOC/trans_data_files/distinct_col | wc -w`
	for (( i=1; i <= $cols; i++))
		do cut -f $i $LOC/trans_data_files/distinct_col| sed -e "s/\t$/\n/g" >> $LOC/results/distinct_col_list
		echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` inside for loop of distinct_col_lst() function, value of i - $i ">>$LOC/log/log_file_$today
		done
		echo -e "\nPlease verify for the column list having atleast one distinct @ $LOC/results/distinct_col_list \n"
else 
	echo -e "\nError in distinct column collection , please verify the result table \n"
fi
echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` Control out from distinct_col_lst() function">>$LOC/log/log_file_$today
}

COMP()
{
echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` Control inside COMP() function">>$LOC/log/log_file_$today
echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` Dynamic Compare query generation started">>$LOC/log/log_file_$today
echo "													"
echo "Dynamic Compare query generation in progress ...                     "
echo "																		"
while read line
	do 
        c_col1=`echo $line | awk -F'&' '{print $1}'`
		c_col2=`echo $line | awk -F'&' '{print $2}'`
  		c11=`echo $c_col1 | awk -F':' '{print $1}'` 
		c12=`echo $c_col1 | awk -F':' '{print $2}'`
		c13=`echo $c_col2 | awk -F':' '{print $1}'`
		c14=`echo $c_col2 | awk -F':' '{print $2}'`
		col_1=`echo $c12 | cut -f1 -d","`
		col_2=`echo $c14 | cut -f1 -d","`
		col1=`echo ${col_1}_1`
		col2=`echo ${col_2}_2`
			
		echo "IF ($c11(a.$c12) != $c13(b.$c14), $c11(a.$c12), '=') $col1 , IF ($c11(a.$c12 )!= $c13(b.$c14),$c13(b.$c14), '=') $col2 ," >> $LOC/temp_2
		perl -00pe 's/,(?!.*,)//s' temp_2 > $LOC/temp2
		echo " $c11(a.$c12) <> $c13(b.$c14) OR " >> $LOC/temp4

	done < $LOC/Config/comp_col
echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` temp4 file has been created successfully">>$LOC/log/log_file_$today
	
if [[ "$cnt" -eq 0 ]]
	then
		echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` No of key is 1">>$LOC/log/log_file_$today
		echo "DROP TABLE IF EXISTS $rslt_db.$rslt_tab;CREATE  TABLE $rslt_db.$rslt_tab as SELECT a.$key11, " > $LOC/temp1
		echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` temp1 file created">>$LOC/log/log_file_$today
		echo "FROM $db1.$tab1 a JOIN $db2.$tab2 b on a.$key11 = b.$key21 WHERE " > $LOC/temp3
		echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` temp3 file created">>$LOC/log/log_file_$today
	elif [[ "$cnt" -eq 1 ]] 
	  then
		echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` No of key is 2">>$LOC/log/log_file_$today
		echo "DROP TABLE IF EXISTS $rslt_db.$rslt_tab;CREATE  TABLE $rslt_db.$rslt_tab as SELECT a.$key11 ,a.$key12, " > $LOC/temp1
		echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` temp1 file created">>$LOC/log/log_file_$today
		echo "FROM $db1.$tab1 a JOIN $db2.$tab2 b on a.$key11 = b.$key21 and a.$key12 = b.$key22 WHERE  " > $LOC/temp3
		echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` temp3 file created">>$LOC/log/log_file_$today
	elif [[ "$cnt" -eq 2 ]]
	   then
	    echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` No of key is 3">>$LOC/log/log_file_$today
	    echo "DROP TABLE IF EXISTS $rslt_db.$rslt_tab;CREATE  TABLE $rslt_db.$rslt_tab as SELECT a.$key11 ,a.$key12,a.$key13, " > $LOC/temp1
		echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` temp1 file created">>$LOC/log/log_file_$today
		echo "FROM $db1.$tab1 a JOIN $db2.$tab2 b on a.$key11 = b.$key21 and a.$key12 = b.$key22 and a.$key13 = b.$key23 WHERE  " > $LOC/temp3
		echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` temp3 file created">>$LOC/log/log_file_$today
    elif [[ "$cnt" -eq 3 ]]
	  then
	    echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` No of key is 4">>$LOC/log/log_file_$today
	    echo "DROP TABLE IF EXISTS $rslt_db.$rslt_tab;CREATE  TABLE $rslt_db.$rslt_tab as SELECT a.$key11 ,a.$key12,a.$key13,a.$key14, " > $LOC/temp1
		echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` temp1 file created">>$LOC/log/log_file_$today
		echo "FROM $db1.$tab1 a JOIN $db2.$tab2 b on a.$key11 = b.$key21 and a.$key12 = b.$key22 and a.$key13 = b.$key23 and a.$key14 = b.$key24 WHERE  " > $LOC/temp3
		echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` temp3 file created">>$LOC/log/log_file_$today
    elif [[ "$cnt" -eq 4 ]]	
	  then 
	    echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` No of key is 5">>$LOC/log/log_file_$today
       	echo "DROP TABLE IF EXISTS $rslt_db.$rslt_tab;CREATE  TABLE $rslt_db.$rslt_tab as SELECT a.$key11 ,a.$key12,a.$key13,a.$key14,a.$key15, " > $LOC/temp1
		echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` temp1 file created">>$LOC/log/log_file_$today
		echo "FROM $db1.$tab1 a JOIN $db2.$tab2 b on a.$key11 = b.$key21 and a.$key12 = b.$key22 and a.$key13 = b.$key23 and a.$key14 = b.$key24 and a.$key15 = b.$key25 WHERE  " > $LOC/temp3
		echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` temp3 file created">>$LOC/log/log_file_$today
fi
	
cd $LOC/

cat temp1  temp2 temp3 temp4 > $LOC/temp5
echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` temp5 file has been created by merging temp1,temp2,temp3 and temp4">>$LOC/log/log_file_$today
perl -00pe 's/OR(?!.*OR)//s' temp5 > $LOC/temp6
echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` temp6 file has been created.">>$LOC/log/log_file_$today

if echo "$diff_rslt_csv" | grep -w -q "Y"
	then
		echo "[Warning]:`date +%Y-%m-%d.%H:%M:%S` User has set 'diff_rslt_csv' variable as Y in Config file">>$LOC/log/log_file_$today
		echo "; SET hive.cli.print.header=true;select * from $rslt_db.$rslt_tab;" >> $LOC/temp6
		echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` compare.csv file has been created successfully">>$LOC/log/log_file_$today
			else
		echo ";" >> $LOC/temp6
fi	


cat $LOC/temp6 >> $LOC/hql/comp_query.hql
rm -rf $LOC/temp*
echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` Dynamic Compare query generation completed">>$LOC/log/log_file_$today
echo "Dynamic Compare query generation completed                      	"
echo "																	"
echo "Comparison of two hive tables will starts now ...                 "
echo "																	"
echo "Please Wait till the process completes ,it may take a while  based on the data volume  ..."
echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` Control out from COMP() function">>$LOC/log/log_file_$today 
}
	
if [ "$src_typ" == "file" ] && [ "$tgt_typ" == "file" ]
	then 
		echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` user has set 'src_typ' and 'tgt_typ' variables as 'file' in config file">>$LOC/log/log_file_$today
		cd $LOC/
		COMP
		cat  $LOC/Config/src_crt_tbl $LOC/Config/tgt_crt_tbl $LOC/hql/comp_query.hql > $LOC/temp8.hql
		echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` temp8 file has been created"$LOC/log/log_file_$today
		mv $LOC/temp8.hql  $LOC/hql/comp_query.hql
		echo "[Info]:`date +%Y-%m-%d.%H:%M:%S` temp8 file has been moved to comp_query successfully"$LOC/log/log_file_$today
		hive -S -f $LOC/hql/comp_query.hql > $LOC/results/compare.csv
		
			if [ "$?" -eq 0 ]; then
				stat1
			else 
				stat2
			fi
		
		elif [ "$src_typ" != "file" ] && [ "$tgt_typ" == "file" ]
			then 
				cd $LOC/
				COMP
				cat $LOC/Config/src_crt_tbl $LOC/Config/tgt_crt_tbl > $LOC/temp8.hql
				mv $LOC/temp8.hql  $LOC/hql/comp_query.hql
				
				hive -S -f $LOC/hql/comp_query.hql > $LOC/results/compare.csv
				
					if [ "$?" -eq 0 ]; then
						stat1
					else 
						stat2
					fi
				
		elif [ "$src_typ" == "file" ] && [ "$tgt_typ" != "file" ]
			then 
				cd $LOC/
				COMP
				cat $LOC/Config/src_crt_tbl $LOC/Config/tgt_crt_tbl > $LOC/temp8.hql
				mv $LOC/temp8.hql  $LOC/hql/comp_query.hql
				
				hive -S -f $LOC/hql/comp_query.hql > $LOC/results/compare.csv
					if [ "$?" -eq 0 ]; then
						stat1
					else 
						stat2
					fi
							
		else
		cd $LOC/
		COMP 
		hive -S -f $LOC/hql/comp_query.hql > $LOC/results/compare.csv
			if [ "$?" -eq 0 ]; then
				stat1
			else 
				stat2
			fi
fi 

cd $LOC
echo "			"
echo -e "\nProcess Completed ,Total time taken = $runtime \n"

