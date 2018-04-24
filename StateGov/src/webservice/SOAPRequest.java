package webservice;

import javax.xml.soap.*;

public class SOAPRequest {

    // SAAJ - SOAP Client Testing
    public void sendRequest(String endPoint, String action, String v0, String v1, String v2, String v3) {
        /*
            The example below requests from the Web Service at:
             https://www.w3schools.com/xml/tempconvert.asmx?op=CelsiusToFahrenheit


            To call other WS, change the parameters below, which are:
             - the SOAP Endpoint URL (that is, where the service is responding from)
             - the SOAP Action

            Also change the contents of the method createSoapEnvelope() in this class. It constructs
             the inner part of the SOAP envelope that is actually sent.
         */
        String soapEndpointUrl = endPoint;
        String soapAction = action;

        callSoapWebService(soapEndpointUrl, soapAction, v0, v1, v2, v3);
        
    }

    private static void createSoapEnvelope(SOAPMessage soapMessage, String v0, String v1, String v2, String v3) throws SOAPException {
        SOAPPart soapPart = soapMessage.getSOAPPart();

        String myNamespace = "ns1";
        String namespaceURI = "http://webserviceapp/";

        // SOAP Envelope
        SOAPEnvelope envelope = soapPart.getEnvelope();
        envelope.addNamespaceDeclaration(myNamespace, namespaceURI);
        
            /*
            Constructed SOAP Request Message:
            <SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:myNamespace="https://www.w3schools.com/xml/">
                <SOAP-ENV:Header/>
                <SOAP-ENV:Body>
                    <myNamespace:CelsiusToFahrenheit>
                        <myNamespace:Celsius>100</myNamespace:Celsius>
                    </myNamespace:CelsiusToFahrenheit>
                </SOAP-ENV:Body>
            </SOAP-ENV:Envelope>

            <?xml version="1.0" encoding="UTF-8"?><soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
                <soap:Header/>
                <soap:Body>
                    <ns1:submit xmlns:ns1="http://webserviceapp/">
                        <arg0>StringValue</arg0>
                    </ns1:submit>
                </soap:Body>
            </soap:Envelope>
            */

        // SOAP Body
        SOAPBody soapBody = envelope.getBody();
        SOAPElement soapBodyElem = soapBody.addChildElement("submit", myNamespace);
        SOAPElement soapBodyElem1 = soapBodyElem.addChildElement("arg0");
        soapBodyElem1.addTextNode(v0);
        SOAPElement soapBodyElem2 = soapBodyElem.addChildElement("arg1");
        soapBodyElem2.addTextNode(v1);
        SOAPElement soapBodyElem3 = soapBodyElem.addChildElement("arg2");
        soapBodyElem3.addTextNode(v2);
        SOAPElement soapBodyElem4 = soapBodyElem.addChildElement("arg3");
        soapBodyElem4.addTextNode(v3);
    }

    private static void callSoapWebService(String soapEndpointUrl, String soapAction, String v0, String v1, String v2, String v3) {
        try {
            // Create SOAP Connection
            SOAPConnectionFactory soapConnectionFactory = SOAPConnectionFactory.newInstance();
            SOAPConnection soapConnection = soapConnectionFactory.createConnection();

            // Send SOAP Message to SOAP Server
            SOAPMessage soapResponse = soapConnection.call(createSOAPRequest(soapAction, v0, v1, v2, v3), soapEndpointUrl);

            // Print the SOAP Response
            System.out.println("Response SOAP Message:");
            soapResponse.writeTo(System.out);
            System.out.println();

            soapConnection.close();
        } catch (Exception e) {
            System.err.println("\nError occurred while sending SOAP Request to Server!\nMake sure you have the correct endpoint URL and SOAPAction!\n");
            e.printStackTrace();
        }
    }

    private static SOAPMessage createSOAPRequest(String soapAction, String v0, String v1, String v2, String v3) throws Exception {
        MessageFactory messageFactory = MessageFactory.newInstance();
        SOAPMessage soapMessage = messageFactory.createMessage();

        createSoapEnvelope(soapMessage, v0, v1, v2, v3);

        MimeHeaders headers = soapMessage.getMimeHeaders();
        headers.addHeader("SOAPAction", soapAction);

        soapMessage.saveChanges();

        /* Print the request message, just for debugging purposes */
        System.out.println("Request SOAP Message:");
        soapMessage.writeTo(System.out);
        System.out.println("\n");

        return soapMessage;
    }

}
