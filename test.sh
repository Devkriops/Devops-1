set -x

#export porxy
# export http_proxy=http://proxy.ebiz.verizon.com:80/
# export https_proxy=http://proxy.ebiz.verizon.com:80/
# export no_proxy=169.254.169.254,127.0.0.1,localhost,.verizon.com,.vzwcorp.com,.vzbi.com,.eks.amazonaws.c



echo "Exporting the proxy............................................................"

export http_proxy=$httpproxy
echo "$http_proxy"
export https_proxy=$httpsproxy
echo "$https_proxy"
export no_proxy=$noproxy
echo "$no_proxy"


DIRECTORY="data"

echo "Running ...."

cd /apps/

# verify volume test-data is attached
echo "looking for data volume ..."
if [ -d "$DIRECTORY" ]
then
 # Verify all necessary files are included (*.context, *.js, zap.config)
 printf "\t$DIRECTORY volume does exist \t \xE2\x9C\x94 \n"
else
 printf "\t$DIRECTORY does not exist\t \xE2\x9D\x8C"
 exit
fi

if [ -e data/*.context ];
then
 printf "\tcontext does exist \t \xE2\x9C\x94 \n"
else
 printf "\tcontext file missing\t \xE2\x9D\x8C"
 exit
fi

if [ -e data/*.js ];
then
 printf "\tWDIO does exist \t \xE2\x9C\x94 \n"
else
 printf "\tWDIO script missing\t \xE2\x9D\x8C"
exit
fi

if [ -e data/zap.config ];
then
  printf "\tzap.config does exist \t \xE2\x9C\x94 \n"
  printf "Starting Zap .... \t \xE2\x9C\x94 \n"

else
  printf "\tzap.config is missing\t \xE2\x9D\x8C"
  exit
fi

mkdir /apps/context

cd /apps/data/
contextfile=$(echo *.context)
echo $contextfile
cp /apps/data/$contextfile /apps/context/$contextfile

loginscript=$(echo *.js)
echo $loginscript
cp /apps/data/$loginscript /tmp/webdriverio-test/test/specs/$loginscript

cp /apps/data/zap.config /apps/zap.config

mkdir /tmp/zap
cd /apps/

mkdir /apps/results/

mkdir /apps/policies
cp /apps/DefaultVZ.policy /apps/policies/

mv /apps/ZAP_2.11.1 /apps/zap/

chmod -R 755 /apps/

#### START ZAP DAEMON
/apps/zap/zap.sh -daemon -host 0.0.0.0 -Xmx2G -addonuninstall openapi -silent -port 8000 -config api.addrs.addr.name=.* -config api.addrs.addr.regex=true -config api.key=12345 -config connection.timeoutInSecs=30 -dir /tmp/zap/ &
sleep 15


#npm install @wdio/cli@latest
# install our browser drivers for wdio
#npm i wdio-geckodriver-service --save-dev
#npm i geckodriver --save-dev
#npm i wdio-chromedriver-service --save-dev
#npm i chromedriver --save-dev
# Run the following as the node user.
cd /tmp/webdriverio-test

#npm config set https-proxy http://proxy.ebiz.verizon.com:80 && npm config set http-proxy http://proxy.ebegistry.npmjs.org/
#npm init -y

# Execute wdio.conf.js
npx wdio --bail 1 --loglevel warn /tmp/webdriverio-test/wdio.conf.js


cd /apps/
#### INITIALIZE AND ATTACK TARGET SITE
java -jar ./zapwrapper.jar initialize

# Keep Session Alive.
java -jar ./zapwrapper.jar session

## Spider the specified URL under zap.target.
java -jar ./zapwrapper.jar spider

# Attack site based on site map.
java -jar ./zapwrapper.jar attack

# Get list of alerts/vulnerabilites.
java -jar ./zapwrapper.jar alerts; alertSuccess=$?

sleep 5

echo "Moving Files To Results Directory ..."


cp /apps/zap_results.json /apps/results/zap_results.json.dast
mv /apps/zap_results.json /apps/results/zap_results.json
mv /apps/zap_crawled_urls.txt /apps/results/zap_crawled_urls.txt
mv /apps/all_zap_traffic.txt /apps/results/all_zap_traffic.txt
mv /apps/zap_results.html /apps/results/zap_results.html
mv /apps/zap_results.md /apps/results/zap_results.md
mv /apps/zap_results.xml /apps/results/zap_results.xml
cp /apps/results/* /apps/data/
