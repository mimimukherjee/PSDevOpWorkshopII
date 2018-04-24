export PATH=/app/jdk/bin:$PATH

cd src/
javac -d ../WebService/WEB-INF/classes webservice/*.java
cd ../WebService/
#cd WebService/
jar -cvf ../../labs/modules/app-config/StateGov-WebService-context-root.war .

echo "StateGov app build completed"
