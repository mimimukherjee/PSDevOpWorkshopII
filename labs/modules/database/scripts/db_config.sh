set -x

export ORACLE_SID=$3 
export ORAENV_ASK=NO  
. /usr/local/bin/oraenv

tnsname="$ORACLE_HOME/network/admin/tnsnames.ora"
echo " " >> $tnsname
echo "PDBNAME ="  >> $tnsname
echo "  (DESCRIPTION ="  >> $tnsname
echo "    (ADDRESS = (PROTOCOL = TCP)(HOST = $1.$2)(PORT = 1521)) "   >> $tnsname
echo "    (CONNECT_DATA ="  >> $tnsname
echo "      (SERVER = DEDICATED)"  >> $tnsname
echo "      (SERVICE_NAME = $4.$2)"  >> $tnsname
echo "    )"  >> $tnsname
echo "  )"  >> $tnsname

sqlplus / as sysdba @/tmp/StateInsurance.sql
