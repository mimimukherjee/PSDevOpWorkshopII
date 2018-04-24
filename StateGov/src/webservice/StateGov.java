package webservice;

//import com.rsa.cryptoj.c.ip;

import java.io.BufferedReader;
import java.io.BufferedWriter;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

import java.sql.SQLException;

import java.util.ArrayList;

import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebService;

@WebService(serviceName = "State")
public class StateGov {
    
    
    public StateGov() throws FileNotFoundException, IOException {
    }
    
    @WebMethod(operationName = "submit")
    public void submit(@WebParam(name = "arg0") String s0, @WebParam(name = "arg1") String s1, 
                           @WebParam(name = "arg2") String s2, @WebParam(name = "arg3") String s3) throws IOException,
                                                                                                      SQLException {
        System.out.println("calling submit");

        SOAPRequest sr = new SOAPRequest();
        sr.sendRequest("http://soastacksoacs/StateInsuranceProj/StateInsurancePLProxyService?wsdl", "submit", s0, s1, s2, s3);
    }
    
    @WebMethod(operationName = "getFromDB")
    public ArrayList getDB() throws SQLException{
        return null;
    }
    
    @WebMethod(operationName = "testMethod")
    public String testMethod() {
        return "Hello World!";
    }
}
