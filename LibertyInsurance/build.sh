export PATH=/app/jdk/bin:$PATH

cd src
javac -d ../WebServiceApp/WEB-INF/classes webserviceapp/*.java
cd ../WebServiceApp/
#cd WebServiceApp
jar -cvf ../../labs/modules/app-config/LibertyInsurance-WebServiceApp-context-root.war .

echo "Liberty app build completed"

