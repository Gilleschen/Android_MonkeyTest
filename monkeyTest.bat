echo off
cls
mkdir output
::install monkey recorder
::echo install monkey recorder
::cd monkey-recorder && ./gradlew -q installDebug && cd -

:: install monkey test
::echo install monkey test
::cd monkey-test && ./gradlew -q installDebug installDebugAndroidTest && cd -
::cd LaunchAPP && ./gradlew -q installDebug installDebugAndroidTest && cd -
::安裝recorder apk和啟動APP apk
install.sh

:: start recording
echo [info] start recording
adb shell am start -n com.kkbox.sqa.recorder/.MainActivity -a android.intent.action.RUN -d START

:: app precondition
echo [info] LaunchAPP#start
adb shell am instrument -w -e class com.tutk.monkeytest.launchapp.Launch com.tutk.monkeytest.launchapp.test/android.support.test.runner.AndroidJUnitRunner

:: run monkey
echo [info] run monkey
adb shell monkey -p com.tutk.kalayapp -v 8000 > output/monkey.log
::sleep 10
::timeout /t 1
ping 127.0.0.1 -n 5 -w 1000 > nul

:: stop recording
echo [info] stop recording
adb shell am start -n com.kkbox.sqa.recorder/.MainActivity -a android.intent.action.RUN -d STOP

::screenshot
echo [info] screenshot
adb shell screencap /sdcard/monkey.png

:: acquiring logs
echo [info] acquiring logs
adb bugreport > output/bugreport.log
adb pull /sdcard/monkey.png output/monkey.png
adb pull /sdcard/recorder.mp4 output/monkey.mp4

echo Down...
pause