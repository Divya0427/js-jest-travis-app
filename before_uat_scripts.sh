echo $TRAVIS_PULL_REQUEST_BRANCH
echo $RELEASE_VERSION
echo $PROD_URL
echo $UAT_URL
echo 'test string'
if [ ${TRAVIS_PULL_REQUEST_BRANCH} == "test-branch" ]; then
    cat test.txt
    perl -pi -e 's/UAT/Prod/g' test.txt
    cat test.txt
fi
if [ ${TRAVIS_BRANCH} == "develop" ]; then
    sed -i 's/Prod/UAT/${RELEASE_VERSION}' test.txt
else
    echo 'NOT DEVELOP'
fi
if [ ${TRAVIS_BRANCH} == "master" ]; then
    sed -i 's/UAT/Prod/${RELEASE_VERSION}' test.txt
else
    echo 'NOT MASTER'
fi
set |grep TRAVIS
npm run test --coverage
npm run build