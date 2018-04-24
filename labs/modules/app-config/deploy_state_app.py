import re
 
appName = 'stategovapplication'
jcsCluster = sys.argv[3]
warPath = sys.argv[4]

weblogicUrl = sys.argv[1]
userName = 'weblogic'
password = sys.argv[2]

connect(userName, password, weblogicUrl)
 
appList = re.findall(appName, ls('/AppDeployments'))
if len(appList) >= 1:
    print 'undeploying application'
    undeploy(appName)
 
deploy(appName, path = warPath, targets=jcsCluster, retireTimeout = -1, upload = 'True')
exit()
