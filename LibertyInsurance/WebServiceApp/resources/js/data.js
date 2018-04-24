function getInsuredDetails(insured) {
    return "<p>Name: "+insured.name+"<br> Address: "+insured.address+"<br> Phone: "+insured.phone+"<br> SSN: "+insured.ssn+"<\/p><hr>";
}
function showInsured(getInsuredDetails) {
    document.querySelector("#leftColumn").innerHTML += getInsuredDetails;

}

function soap() {
//    var data = JSON.parse(config);
    var xmlhttp = new XMLHttpRequest();  
    xmlhttp.open('POST', '/LibertyInsurance-WebServiceApp-context-root/HelloWorldAppPort?wsdl', true);

    // build SOAP request
    var sr =
        '<?xml version="1.0" encoding="UTF-8"?>'+
        '<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">'+
            '<soap:Header/>'+
            '<soap:Body>'+
                '<ns1:getFromDB xmlns:ns1="http://webserviceapp/"/>'+
            '<\/soap:Body>'+
        '<\/soap:Envelope>';
    
    // Send the POST request
    xmlhttp.setRequestHeader('Content-Type', 'text/xml');
    xmlhttp.setRequestHeader('SOAPAction', 'getFromDB');
    xmlhttp.send(sr);
    // send request
    
    xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState == XMLHttpRequest.DONE) {
            if (xmlhttp.status == 200) {
//                alert(xmlhttp.responseText)
                var xmlDoc = $.parseXML( xmlhttp.responseText ),
                $xml = $(xmlDoc),
                $value= $xml.find("return");
                var arr = [];
                for (var i = 0; i < $value.length; i++) {
                    arr.push($value[i].textContent);
                }
                var customers = '['+arr.join(', ')+']';
                console.log(customers);
                console.log(JSON.parse(customers));
                JSON.parse(customers).map(getInsuredDetails).forEach(showInsured);
            }
        }
    }
}





