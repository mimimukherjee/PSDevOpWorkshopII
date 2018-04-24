package webserviceapp;

import java.io.BufferedReader;
import java.io.BufferedWriter;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

import java.io.InputStream;

import java.io.InputStreamReader;

import java.sql.SQLException;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Map;

import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebService;


@WebService(serviceName = "LibertyInsurance")
public class LibertyInsuranceBE {
    
    String dbIP = "LibertyInsuranceDB";
    String SID = "aTFdb";
    DBConnection conn;
    String fileName = "file.txt";
    
    public LibertyInsuranceBE() throws FileNotFoundException, IOException {
        this.conn = new DBConnection();    
    }
    
    @WebMethod(operationName = "submit")
    public void helloWorld(@WebParam(name = "arg0") String s0, @WebParam(name = "arg1") String s1, 
                           @WebParam(name = "arg2") String s2, @WebParam(name = "arg3") String s3) throws IOException, SQLException{
        
        conn.insertRecord(s0, s1, s2, s3);
        
        // write to file
        BufferedWriter writer = new BufferedWriter(new FileWriter(fileName));
        writer.write("Name: " + s0 + ", Address: " + s1 + ", Phone: " + s2 +", SSN: " + s3);
         
        writer.close();
    }
    
    @WebMethod(operationName = "getFromFile")
    public ArrayList getFile() throws IOException{
        // read contents of file and return what's inside
        BufferedReader reader = new BufferedReader(new FileReader(fileName));
        return new ArrayList<String>(Arrays.asList(reader.readLine().split(","))); 
    }
    
    @WebMethod(operationName = "getFromDB")
    public ArrayList getDB() throws SQLException{
        return conn.selectAll();
    }
    
    @WebMethod(operationName = "testMethod")
    public String testMethod() throws IOException{
        return "Hello World!"; 
    }
}
