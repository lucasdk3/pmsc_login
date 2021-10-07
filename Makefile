.DEFAULT_GOAL := package
.PHONY: 

PACKAGE_FOLDER := package/
OS := $(shell uname -s)

lutter-rebuild:
	@rm -f pubspec.lock; rm -f example/pubspeck.lock; rm -rf ../../../../.pub-cache; flutter clean; flutter packages get;

coverage-run:
	@flutter test --coverage && genhtml -o coverage coverage/lcov.info && open coverage/index.html

coverage-run-windows:
	@flutter test --coverage && perl.exe C:\ProgramData\chocolatey\lib\lcov\tools\bin\genhtml -o coverage coverage\lcov.info && start coverage/index.html