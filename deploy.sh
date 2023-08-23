#!/bin/bash

flutter build apk --release --no-tree-shake-icons
# flutter build apk --bundle-sksl-path flutter_01.sksl.json
datenow=$(date +'%Y%m%d')
releasetype='stag'
version=$(flutter pub run cider version)
mv build/app/outputs/flutter-apk/app-release.apk "build/app/outputs/flutter-apk/ipayment-${releasetype}-${version}.apk"
echo "APK Generated build/app/outputs/flutter-apk/ipayment-${releasetype}-${version}.apk"
# adb -s K3VDU19118004696 install "build/app/outputs/flutter-apk/ipayment-${releasetype}-${version}.apk"