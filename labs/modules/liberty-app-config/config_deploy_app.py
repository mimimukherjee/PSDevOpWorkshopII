import re
 
warPath = '/u01/oracle/LibertyInsurance-WebServiceApp-context-root.war'
appName = 'mytestapplication'

weblogicUrl = 't3://172.17.0.2:7001'
userName = 'weblogic'
password = 'welcome1'

connect(userName, password, weblogicUrl)
 
appList = re.findall(appName, ls('/AppDeployments'))
if len(appList) >= 1:
    print 'undeploying application'
    undeploy(appName)
 
deploy(appName, path = warPath, retireTimeout = -1, upload = 'True')
exit()
