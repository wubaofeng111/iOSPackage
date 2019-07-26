SFrameWrokPath = /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/System/Library/Frameworks
SDKPath        = /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS12.2.sdk 

MainMos = main.o


Archive:ZipLoad
	mv Payload.zip Payload.ipa

DestApp:VideoApp
	lipo -create VideoApp64 VideoAppV7 -output VideoApp


VideoApp:$(MainMos)
	clang arm64/main.o -o arm64/VideoApp64 -iframework $(SFrameWrokPath) -framework UIKit -arch arm64  -isysroot $(SDKPath) -framework Foundation
	clang armv7/main.o -o armv7/VideoAppV7 -iframework $(SFrameWrokPath) -framework UIKit -arch armv7  -isysroot $(SDKPath) -framework Foundation
main.o:main.m
	clang  -c main.m -o arm64/main.o -iframework $(SFrameWrokPath) -framework UIKit -F$(SFrameWrokPath) -arch arm64 -fmacro-backtrace-limit=0 -std=gnu99  -isysroot $(SDKPath)
	clang  -c main.m -o armv7/main.o -iframework $(SFrameWrokPath) -framework UIKit -F$(SFrameWrokPath) -arch armv7 -fmacro-backtrace-limit=0 -std=gnu99  -isysroot $(SDKPath)



findCer:
	security find-identity -v -p codesigning

otoolTx:
	otool -l VideoApp.app/VideoApp | grep crypt


	



ZipLoad:Move
	zip -r Payload.zip Payload 

Move:sign
	cp -rf VideoApp.app Payload



sign:pack
	codesign -fs "iPhone Distribution: Shanghai Hudun Information Technology Co., Ltd. (8G7DRCTZEQ)" --no-strict --entitlements pfs.plist VideoApp.app
	mkdir -p Payload
signPrint:
	codesign -vv -d VideoApp.app

pack:CreateDir
	cp VideoApp Info.plist VideoApp.app
	cp upload.mobileprovision VideoApp.app/embedded.mobileprovision



CreateDir:DestApp
	mkdir -p VideoApp.app

clean:
	rm -rf VideoApp* Payload*