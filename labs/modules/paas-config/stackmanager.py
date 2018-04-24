import argparse
import json
import os
import sys
import requests
import pprint
import time

class StackManager():
    """ Class to do operations on Stackmanager """

    def __init__(self, username, password, domain_name, DEBUG, stackmanager_path):
        self.username = username
        self.password = password
        self.domain_name = domain_name
        self.DEBUG = DEBUG
        self.path = stackmanager_path
    
    def view_template(self):
        '''To view existing templates'''
        print ("I am here")

        url = "https://psm.us.oraclecloud.com/paas/api/v1.1/instancemgmt/"+ self.domain_name+"/templates/cst/instances"
        headers = {
            'X-ID-TENANT-NAME': '%s' %self.domain_name
            }
        if self.DEBUG:
            print ("Header : ")
            pprint.pprint(headers)
            print("--------------------------------------------------------------------------")
        request = requests.get(url, headers=headers, auth=(self.username, self.password))

        if self.DEBUG:
            print ("Response Header : ")
            pprint.pprint (request.headers)            
            print("--------------------------------------------------------------------------")               
            print ("Response Body : ")
            pprint.pprint (request.text)
            print("--------------------------------------------------------------------------")
            print ("Status Code is : " + str(request.status_code))
            print("--------------------------------------------------------------------------")

    def create_template(self, template_file):
        """To create template"""

        if self.DEBUG:
            print("**************************************************************************")
            print ("Inside create function for Template ")
            print("**************************************************************************")
        method = str('POST')
        files = {
            'template': (template_file, open(self.path+"/"+template_file, 'rb'))
            }
        ct = "multipart/form-data"
        url = "https://psm.us.oraclecloud.com/paas/api/v1.1/instancemgmt/"+self.domain_name+"/templates/cst/instances"
        if self.DEBUG:
            print ("URL is : " + url)
            print("--------------------------------------------------------------------------")
            print ("File")
            print(files)
        header = {
            # "Content-Type" : "%s" % ct,
            "X-ID-TENANT-NAME" : "%s" % self.domain_name
        }
        
        if self.DEBUG:
            print ("Header : ")
            pprint.pprint (header)
            print("--------------------------------------------------------------------------")
            
        request = requests.post(url, files = files, headers = header, auth=(self.username,self.password))
        if self.DEBUG:
            print ("Response Header : ")
            pprint.pprint (request.headers)            
            print("--------------------------------------------------------------------------")               
            print ("Response Body : ")
            pprint.pprint (request.text)
            print("--------------------------------------------------------------------------")
            print ("Status Code is : " + str(request.status_code))
            print("--------------------------------------------------------------------------")
        
        time.sleep(30)

    def create_stack(self,stack_name, template_name):
        """To create JCS Stack"""

        parameters = {}
        with open("jcs.json", 'r') as f:
            parameters = json.load(f)
            
        print("JCS Parameters are: ")
        print (parameters) 
        if self.DEBUG:
            print("**************************************************************************")
            print ("Inside create function for JCS Stack ")
            print("**************************************************************************")
        method = str('POST')
        files = {
            'name' : "%s" %stack_name,
            'template': "%s" % template_name,
            'parameterValues' : "{\"publicKeyText\":\""+parameters["publicKeyText"]+"\",\"commonPwd\":\""+parameters["commonPwd"]+"\",\"sRegion\":\""+parameters["sRegion"]+"\",\"availabilityDomain\":\""+parameters["availabilityDomain"]+"\",\"dbBackupStorageContainer\":\""+parameters["dbBackupStorageContainer"]+"\", \"backupStorageUser\":\""+parameters["backupStorageUser"]+"\", \"backupStoragePassword\": \""+parameters["backupStoragePassword"]+"\",\"subnet\":\""+parameters["subnet"]+"\",\"dbComputeShape\":\""+parameters["dbComputeShape"]+"\", \"wlComputeShape\":\""+parameters["wlComputeShape"]+"\"}"
            
            }
        ct = "multipart/form-data"
        url = "https://psm.us.oraclecloud.com/paas/api/v1.1/instancemgmt/"+self.domain_name+"/services/stack/instances"
        if self.DEBUG:
            print ("URL is : " + url)
            print("--------------------------------------------------------------------------")
            print ("File")
            print(files)
        header = {
            # "Content-Type" : "%s" % ct,
            "X-ID-TENANT-NAME" : "%s" % self.domain_name
        }
        
        if self.DEBUG:
            print ("Header : ")
            pprint.pprint (header)
            print("--------------------------------------------------------------------------")
            
        request = requests.post(url, files = files, headers = header, auth=(self.username,self.password))
        print ("Status Code is : " + str(request.status_code))
        if self.DEBUG:
            print ("Response Header : ")
            pprint.pprint (request.headers)            
            print("--------------------------------------------------------------------------")               
            print ("Response Body : ")
            pprint.pprint (request.text)
            print("--------------------------------------------------------------------------")
            print ("Status Code is : " + str(request.status_code))
            print("--------------------------------------------------------------------------")
        if request.status_code in (200, 202):
            json_response = json.loads(request.text)
            job_id = json_response["details"]["jobId"]
            time.sleep(30)
            status = self.check_status(job_id)
            while status=="INITIALIZING":
                time.sleep(30)
                status = self.check_status(job_id)
            while status=="RUNNING":
                time.sleep(30)
                status = self.check_status(job_id)

    def create_soa_stack(self,stack_name, template_name):
        """To create SOA Stack"""
        parameters = {}
        with open("soa.json", 'r') as f:
            parameters = json.load(f)
            
        print("SOA Parameters are: ")
        print (parameters) 
        
        if self.DEBUG:
            print("**************************************************************************")
            print ("Inside create function for SOA Stack ")
            print("**************************************************************************")
        files = {
            'name' : "%s" %stack_name,
            'template': "%s" % template_name,
            'parameterValues' : "{\"publicKeyText\":\""+parameters["publicKeyText"]+"\",\"commonPwd\":\""+parameters["commonPwd"]+"\",\"sRegion\":\""+parameters["sRegion"]+"\",\"availabilityDomain\":\""+parameters["availabilityDomain"]+"\",\"backupStorageContainer\":\""+parameters["backupStorageContainer"]+"\",\"dbBackupStorageContainer\":\""+parameters["dbBackupStorageContainer"]+"\", \"backupStorageUser\":\""+parameters["backupStorageUser"]+"\", \"backupStoragePassword\": \""+parameters["backupStoragePassword"]+"\",\"subnet\":\""+parameters["subnet"]+"\",\"dbComputeShape\":\""+parameters["dbComputeShape"]+"\", \"wlComputeShape\":\""+parameters["wlComputeShape"]+"\", \"wlComputeShape2\":\""+parameters["wlComputeShape2"]+"\"}"
        }  

        print (files)          
        ct = "multipart/form-data"
        url = "https://psm.us.oraclecloud.com/paas/api/v1.1/instancemgmt/"+self.domain_name+"/services/stack/instances"
        if self.DEBUG:
            print ("URL is : " + url)
            print("--------------------------------------------------------------------------")
            print ("File")
            print(files)
        header = {
            # "Content-Type" : "%s" % ct,
            "X-ID-TENANT-NAME" : "%s" % self.domain_name
        }
        
        if self.DEBUG:
            print ("Header : ")
            pprint.pprint (header)
            print("--------------------------------------------------------------------------")
            print ("Sender Body : ")
            pprint.pprint (files)
            print("--------------------------------------------------------------------------")
            
        request = requests.post(url, files = files, headers = header, auth=(self.username,self.password))
        print ("Status Code is : " + str(request.status_code))
        if self.DEBUG:
            print ("Response Header : ")
            pprint.pprint (request.headers)            
            print("--------------------------------------------------------------------------")               
            print ("Response Body : ")
            pprint.pprint (request.text)
            print("--------------------------------------------------------------------------")
            print ("Status Code is : " + str(request.status_code))
            print("--------------------------------------------------------------------------")
        if request.status_code in (200, 202):
            json_response = json.loads(request.text)
            job_id = json_response["details"]["jobId"]
            time.sleep(30)
            status = self.check_status(job_id)
            while status=="INITIALIZING":
                time.sleep(30)
                status = self.check_status(job_id)
            while status=="RUNNING":
                time.sleep(30)
                status = self.check_status(job_id)

    def view_stack(self):
        '''To view existing stacks'''
        print ("I am here inside view stack")
        url = "https://psm.us.oraclecloud.com/paas/api/v1.1/instancemgmt/"+ self.domain_name+"/services/stack/instances"
        headers = {
            'X-ID-TENANT-NAME': '%s' %self.domain_name
            }
        request = requests.get(url, headers=headers, auth=(self.username, self.password))

        if self.DEBUG:
            print ("Response Header : ")
            pprint.pprint (request.headers)            
            print("--------------------------------------------------------------------------")               
            print ("Response Body : ")
            pprint.pprint (request.text)
            print("--------------------------------------------------------------------------")
            print ("Status Code is : " + str(request.status_code))
            print("--------------------------------------------------------------------------")

    def view_stack(self, stack_name):
        '''To view existing stacks'''
        print ("I am here inside view stack")
        url = "https://psm.us.oraclecloud.com/paas/api/v1.1/instancemgmt/"+ self.domain_name+"/services/stack/instances/" + stack_name
        headers = {
            'X-ID-TENANT-NAME': '%s' %self.domain_name
            }
        request = requests.get(url, headers=headers, auth=(self.username, self.password))

        print ("Status Code is : " + str(request.status_code))

        if self.DEBUG:
            print ("Response Header : ")
            pprint.pprint (request.headers)            
            print("--------------------------------------------------------------------------")               
            print ("Response Body : ")
            pprint.pprint (request.text)
            print("--------------------------------------------------------------------------")
            print ("Status Code is : " + str(request.status_code))
            print("--------------------------------------------------------------------------")

    def start_stack(self, stack_name):
        ''' To Start Stack '''
        url = "https://psm.us.oraclecloud.com/paas/api/v1.1/instancemgmt/"+ self.domain_name+"/services/stack/instances/" + stack_name + "/start"
        headers = {
            'X-ID-TENANT-NAME': '%s' %self.domain_name
            }
        if self.DEBUG:
            print ("Header : ")
            pprint.pprint(headers)
            print("--------------------------------------------------------------------------")
            print ("URL is: ")
            print(url)
            print("--------------------------------------------------------------------------")

        request = requests.post(url, headers=headers, auth=(self.username, self.password))
        
        if self.DEBUG:
            print ("Response Header : ")
            pprint.pprint (request.headers)            
            print("--------------------------------------------------------------------------")               
            print ("Response Body : ")
            pprint.pprint (request.text)
            print("--------------------------------------------------------------------------")
            print ("Status Code is : " + str(request.status_code))
            print("--------------------------------------------------------------------------")
        
        if request.status_code in (400, 409):
            json_response = json.loads(request.text)
            status = json_response["service_details"]["state"]
            while status=="INITIALIZING":
                time.sleep(30)
            if self.DEBUG:
                print (status)

    def delete_stack(self, stack_name):
        ''' To delete Stack '''
        url = "https://psm.us.oraclecloud.com/paas/api/v1.1/instancemgmt/"+ self.domain_name+"/services/stack/instances/" + stack_name 
        headers = {
            'X-ID-TENANT-NAME': '%s' %self.domain_name
            }
        if self.DEBUG:
            print ("Header : ")
            pprint.pprint(headers)
            print("--------------------------------------------------------------------------")
            print ("URL is: ")
            print(url)
            print("--------------------------------------------------------------------------")

        request = requests.put(url, headers=headers, auth=(self.username, self.password))
        
        if self.DEBUG:
            print ("Response Header : ")
            pprint.pprint (request.headers)            
            print("--------------------------------------------------------------------------")               
            print ("Response Body : ")
            pprint.pprint (request.text)
            print("--------------------------------------------------------------------------")
            print ("Status Code is : " + str(request.status_code))
            print("--------------------------------------------------------------------------")
        
        if request.status_code in (200, 202):
            json_response = json.loads(request.text)
            job_id = json_response["details"]["jobId"]
            time.sleep(30)
            status = self.check_status(job_id)
            while status=="INITIALIZING":
                time.sleep(30)
                status = self.check_status(job_id)
            while status=="RUNNING":
                time.sleep(30)
                status = self.check_status(job_id)

    def check_status(self, job_id):
        """Checks the status as per JOB ID"""
        url = "https://psm.us.oraclecloud.com/paas/api/v1.1/activitylog/"+ self.domain_name+"/stack/job/"+job_id
        headers = {
            'X-ID-TENANT-NAME': '%s' %self.domain_name
            }
        if self.DEBUG:
            print ("Header : ")
            pprint.pprint(headers)
            print("--------------------------------------------------------------------------")
            print ("URL is: ")
            print(url)
            print("--------------------------------------------------------------------------")
        request = requests.get(url, headers=headers, auth=(self.username, self.password))
        
        if self.DEBUG:
            print ("Response Header : ")
            pprint.pprint (request.headers)            
            print("--------------------------------------------------------------------------")               
            print ("Response Body : ")
            pprint.pprint (request.text)
            print("--------------------------------------------------------------------------")
            print ("Status Code is : " + str(request.status_code))
            print("--------------------------------------------------------------------------")
        
        if request.status_code in (200, 202):
            json_response = json.loads(request.text)
            try:
                status = json_response["status"]
                print (status)
                return status
            except:
                print("JSON status not exists. Stack is not created.")

    def view_jcs(self, jcs_instance_name):
        """To view JCS  instances"""

        url = "https://jaas.oraclecloud.com/paas/api/v1.1/instancemgmt/"+self.domain_name+"/services/jaas/instances/"+jcs_instance_name
        if self.DEBUG:
            print("**************************************************************************")
            print ("Validating JCS ")
            print("**************************************************************************")
            print ("URL is : " + url)
        header = {
            "X-ID-TENANT-NAME": "%s" % self.domain_name
        }
        
        request = requests.get(url, headers=header, auth=(self.username, self.password))
        if self.DEBUG:
            print("----------------------------------------------------")
            print ("Response Status is : " + str(request.status_code))
            print("----------------------------------------------------")
            print ("Response body is: ")
            pprint.pprint(request.text)
            print("----------------------------------------------------")
            print ("Response header is: ")
            pprint.pprint(request.headers)
            print("----------------------------------------------------")
        if request.status_code in (200, 202):
            json_response = json.loads(request.text)
            try:
                weblogic_url = json_response["WLS_ROOT"]
                print ("weblogic_url")
                print (weblogic_url)
                return weblogic_url
            except:
                print("JSON status not exists. Stack is not created.")

    def view_jcs_access_rules(self):
        """To view JCS access rule"""

        url = "https://jaas.oraclecloud.com/paas/api/v1.1/instancemgmt/"+self.domain_name+"/services/jaas/instances/DevOpsStack1JCS/accessrules"
        if self.DEBUG:
            print("**************************************************************************")
            print ("Validating JCS ")
            print("**************************************************************************")
            print ("URL is : " + url)
        header = {
            "X-ID-TENANT-NAME": "%s" % self.domain_name
        }
        
        request = requests.get(url, headers=header, auth=(self.username, self.password))
        if self.DEBUG:
            print("----------------------------------------------------")
            print ("Response Status is : " + str(request.status_code))
            print("----------------------------------------------------")
            print ("Response body is: ")
            pprint.pprint(request.text)
            print("----------------------------------------------------")
            print ("Response header is: ")
            pprint.pprint(request.headers)
            print("----------------------------------------------------")
        # if request.status_code in (200, 202):
        #     json_response = json.loads(request.text)
        #     try:
        #         weblogic_url = json_response["WLS_ROOT"]
        #         if self.DEBUG:
        #             print ("weblogic_url")
        #             print (weblogic_url)
        #         return weblogic_url
        #     except:
        #         print("JSON status not exists. Stack is not created.")



def main(args):
    """Main function to call the stackmanager"""
    stackmanager = StackManager(args.username, args.password, args.dname, args.debug, args.path)

    if args.action == "view":
        if args.service == "jcs":    
            stackmanager.view_stack(args.env+"JCSDBCSStack")
            print ("Inside view jcs")
            stackmanager.view_jcs(args.env+"JCSDBCSStackJCS")
            # stackmanager.view_jcs_access_rules()
        
        if args.service == "soa":
            print ("Inside view soa")
            # stackmanager.view_template()
            

    if args.action == "create":

        if args.service == "jcs":                
            stackmanager.create_template("Oracle-JCS-DBCS-Template.yaml")
            stackmanager.create_stack(args.env+"JCSDBCSStack", "JCS-DBCS-Template")
            
        if args.service == "soa":
            
            stackmanager.create_template("SOA-FROM-JCS-Final.yaml")
            stackmanager.create_soa_stack(args.env+"SOAStack", "SOA-Template")
            

    if args.action == "delete":    
        if args.service == "jcs":                
            stackmanager.delete_stack(args.env+"JCSDBCSStack")
        if args.service == "soa":
            stackmanager.delete_stack(args.env+"SOAStack")
    
    if args.action == "start":    
        stackmanager.start_stack("DevOpsStack1")
    if args.action == "status":    
        stackmanager.check_status(args.jid)
    
    # if args.action == "delete":  
    #     stackmanager.delete_jcs_template()

    # if args.action == "validate":  
    #     stackmanager.validate_jcs()

class ParseValues(object):
    """Class to parse the values from command line"""
 
    def __init__(self):
        # print ("Inside init of parse values")
        parser = argparse.ArgumentParser(
            description="Add users information to do CRUD operation on StackManager",
            usage='''python stackmanager.py <create, delete, view> <enter an option>
                <jcs, soa> <Enter an option>
                <-u, --username> <enter username>
                <-p, --password> <Enter Password>
                <-dn, --dname> <Enter Domain Name>
                <-e, --env> <Enter env prefix>
                <-pa, --path> <Enter Stack Manager Path>''')
 
        acts = ['auth', 'create', 'delete', 'view', 'start', 'status']
        services = ['jcs', 'soa']
        parser.add_argument('action',
                            choices=acts,
                            help="Required Field")
        parser.add_argument('service',
                            choices=services,
                            help="Required Field")
        parser.add_argument("-u", "--username",
                           help="Enter the username",
                           default=None)
        parser.add_argument("-p", "--password",
                            help="Enter the password",
                            default=None)
        parser.add_argument("-dn", "--dname",
                            help="Enter the domain name",
                            default=None)
        parser.add_argument("-pa", "--path",
                            help="Enter the stack manager path",
                            default=".")
        parser.add_argument("-e", "--env",
                            help="Enter the env prefix",
                            default="")
        parser.add_argument("-j", "--jid",
                            help="Enter the job  ID",
                            default=None)
        parser.add_argument("--debug",
                            help="print debug messages to stderr",
                            action = 'store_true')
        args = parser.parse_args()
        main(args)
 
if __name__ == "__main__":
    ParseValues()
