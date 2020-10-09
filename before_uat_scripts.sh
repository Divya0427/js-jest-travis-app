# when the pull_request_branch is test-branch then replacing the content is test.txt file and also creating a folder UAT/<version>
# script:
#   - 'if [ "$TRAVIS_PULL_REQUEST" != "false" ]; then bash ./travis/run_on_pull_requests; fi'
#   - 'if [ "$TRAVIS_PULL_REQUEST" = "false" ]; then bash ./travis/run_on_non_pull_requests; fi'

echo $TRAVIS_PULL_REQUEST_BRANCH
echo $TRAVIS_BRANCH
echo $RELEASE_VERSION
echo $DEFAULT_LOCALHOST
echo $PROD_URL
echo $UAT_URL
echo 'BEFORE UAT SCRIPTS'
if [ ${TRAVIS_PULL_REQUEST_BRANCH} == "test-branch" ]; then
    sed "/Version/s/>[^<]*</>$RELEASE_VERSION</" test.xml
    cat test.txt
    sed -i.bak "s|$DEFAULT_LOCALHOST|$UAT_URL|g" test.txt
    cat test.txt
    # creating a folder UAT and then the nested folder with version number
    mkdir UAT && cd UAT && mkdir $RELEASE_VERSION
    cd ..
    mv * .* ./UAT/$RELEASE_VERSION
    cd UAT
    cd $RELEASE_VERSION
    ls -a
fi
if [[ ${TRAVIS_PULL_REQUEST_BRANCH} == "test-branch" && $TRAVIS_PULL_REQUEST == 1 ]]; then
    echo '&Its not merge'
fi
if [[ ${TRAVIS_PULL_REQUEST_BRANCH} == "test-branch" && $TRAVIS_PULL_REQUEST != 1 ]]; then
    echo '&Its a merge'
fi
if [ ${TRAVIS_BRANCH} == "develop" ]; then
    sed -i 's/Prod/UAT/${RELEASE_VERSION}' test.txt
else
    echo 'NOT DEVELOP'
fi
set |grep TRAVIS
npm run test --coverage