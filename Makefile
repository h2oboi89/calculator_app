SHELL := C:\Windows\System32\cmd.exe
PACKAGE_ROOT := $(shell echo $(USERPROFILE))\.nuget\packages

COVERAGE_REPORT_TOOL := $(PACKAGE_ROOT)\reportgenerator\5.0.0\tools\net47\ReportGenerator.exe

.PHONY: tdd
tdd:
	flutter test --coverage --branch-coverage
	$(COVERAGE_REPORT_TOOL) -reports:coverage\lcov.info -targetdir:coverage\report -reporttypes:Html