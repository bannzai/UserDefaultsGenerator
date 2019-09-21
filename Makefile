PROJECT?=UserDefaultsGenerator
COMMANDNAME?=udg

build:
	swift build
xcodeproj: 
		swift package generate-xcodeproj

generate: build
	./.build/x86_64-apple-macosx/debug/udg generate 
generate-output: build
	./.build/x86_64-apple-macosx/debug/udg generate --output A.generated.swift 
generate-output-config: build
	./.build/x86_64-apple-macosx/debug/udg generate --output B.generated.swift --config udg.yml
generate-output-config-template: build
	./.build/x86_64-apple-macosx/debug/udg generate --output C.generated.swift --config udg.yml --template ./template.stencil

setup: build
	./.build/x86_64-apple-macosx/debug/udg setup

help: build
	./.build/x86_64-apple-macosx/debug/udg help

test: build xcodeproj
	xcodebuild clean build test -project UserDefaultsGenerator.xcodeproj \
		-scheme UserDefaultsGenerator \
		-destination platform="macOS" \
		-enableCodeCoverage YES \
		-derivedDataPath .build/derivedData \
		CODE_SIGN_IDENTITY="" \
		CODE_SIGNING_REQUIRED=NO \
		ONLY_ACTIVE_ARCH=NO
