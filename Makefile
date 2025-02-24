all: install

install:
	go install -v

test:
	${MAKE} check_ginkgo || ${MAKE} install_ginkgo
	GO111MODULE=on ginkgo -mod vendor -r -keepGoing -p -trace -randomizeAllSpecs -progress --race

check_ginkgo:
	ginkgo version

install_ginkgo:
	go install github.com/onsi/ginkgo/ginkgo@latest

fmt:
	go fmt ./...

fly:
	fly -t persi execute -c scripts/ci/run_unit.build.yml -i smbbroker=$$PWD
