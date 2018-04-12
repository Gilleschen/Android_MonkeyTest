## install monkey recorder
echo install monkey recorder
cd monkey-recorder && ./gradlew -q installDebug && cd -

## install monkey test
echo install LaunchAPP test
cd LaunchAPP && ./gradlew -q installDebug installDebugAndroidTest && cd -