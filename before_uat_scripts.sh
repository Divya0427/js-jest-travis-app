echo $TRAVIS_PULL_REQUEST_BRANCH
echo $RELEASE_VERSION
echo $PROD_URL
echo $UAT_URL
echo 'BEFORE UAT SCRIPTS'
if [ ${TRAVIS_PULL_REQUEST_BRANCH} == "test-branch" ]; then
    cat test.txt
    sed -i.bak 's|https://google.com|https://localhost:7777|g' test.txt
    sed -i.bak 's|${DEFAULT_LOCALHOST}|${UAT_URL}|g' test.txt
    cat test.txt
fi
if [ ${TRAVIS_BRANCH} == "develop" ]; then
    sed -i 's/Prod/UAT/${RELEASE_VERSION}' test.txt
else
    echo 'NOT DEVELOP'
fi
set |grep TRAVIS
npm run test --coverage