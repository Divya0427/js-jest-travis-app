- echo $TRAVIS_PULL_REQUEST_BRANCH
- echo $RELEASE_VERSION
- echo 'test string'
- 'if [ ${TRAVIS_PULL_REQUEST_BRANCH} = "test-branch" ]; then
    echo "IFBLOCK"
  fi'
- set |grep TRAVIS
- npm run test --coverage
- npm run build