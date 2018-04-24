import re
 
weblogicUrl = sys.argv[1]
userName = 'weblogic'
wlspassword = sys.argv[2]
dbpassword = sys.argv[3]
dbconn = sys.argv[5]

appName = 'mytestapplication'
warPath = sys.argv[4]

connect(userName, wlspassword, weblogicUrl)

edit()
startEdit()

cd('/')
cmo.createJDBCSystemResource('StateInsuranceDS')

cd('/JDBCSystemResources/StateInsuranceDS/JDBCResource/StateInsuranceDS')
cmo.setName('StateInsuranceDS')

cd('/JDBCSystemResources/StateInsuranceDS/JDBCResource/StateInsuranceDS/JDBCDataSourceParams/StateInsuranceDS')
set('JNDINames',jarray.array([String('jdbc/StateInsuranceDS')], String))

cd('/JDBCSystemResources/StateInsuranceDS/JDBCResource/StateInsuranceDS')
cmo.setDatasourceType('GENERIC')

cd('/JDBCSystemResources/StateInsuranceDS/JDBCResource/StateInsuranceDS/JDBCDriverParams/StateInsuranceDS')
cmo.setUrl(dbconn)
cmo.setDriverName('oracle.jdbc.OracleDriver')
set('Password', dbpassword)

cd('/JDBCSystemResources/StateInsuranceDS/JDBCResource/StateInsuranceDS/JDBCConnectionPoolParams/StateInsuranceDS')
cmo.setTestTableName('SQL ISVALID\r\n\r\n')

cd('/JDBCSystemResources/StateInsuranceDS/JDBCResource/StateInsuranceDS/JDBCDriverParams/StateInsuranceDS/Properties/StateInsuranceDS')
cmo.createProperty('user')

cd('/JDBCSystemResources/StateInsuranceDS/JDBCResource/StateInsuranceDS/JDBCDriverParams/StateInsuranceDS/Properties/StateInsuranceDS/Properties/user')
cmo.setValue('stateinsurance')

cd('/JDBCSystemResources/StateInsuranceDS/JDBCResource/StateInsuranceDS/JDBCDataSourceParams/StateInsuranceDS')
cmo.setGlobalTransactionsProtocol('OnePhaseCommit')

cd('/JDBCSystemResources/StateInsuranceDS')
set('Targets',jarray.array([ObjectName('com.bea:Name=' + 'WL_AdminServer' + ',Type=' + 'Server')], ObjectName))

save()
activate()

appList = re.findall(appName, ls('/AppDeployments'))
if len(appList) >= 1:
    print 'undeploying application'
    undeploy(appName)
 
deploy(appName, path = warPath, retireTimeout = -1, upload = 'True')
exit()
