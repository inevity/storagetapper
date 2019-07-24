NAME := storagetapper
GIT_REVISION := $(shell git rev-parse --short HEAD)

PKGS := $(shell find . -maxdepth 1 -type d -not -path '*/\.*' -not -path '.'|grep -v -e vendor -e doc -e debian -e scripts|sort -r)
SRCS := $(shell find . -name "*.go" -not -path './vendor')

$(NAME): $(SRCS) types/format_gen.go
	go build -ldflags "-X main.revision=$(GIT_REVISION)"


install: $(NAME)
	install -m 0755 -d $(DESTDIR)/usr/bin
	install -m 0550 -s $(NAME) $(DESTDIR)/usr/bin
	install -m 0750 -d $(DESTDIR)/etc/$(NAME)
	install -m 0600 config/base.yaml config/production.yaml $(DESTDIR)/etc/$(NAME)

types/format_gen.go: deps
	go generate ./types

	#sh scripts/run_tests.sh $(PKGS)
unittest: $(NAME)
	sh scripts/run_tests.sh ./changelog

	

lint: $(NAME)
	sh scripts/run_lints.sh $(PKGS)

bench: $(NAME)
	sh scripts/run_benchmarks.sh $(PKGS)

test: unittest lint

#	go build -v ./...
deps:
	go get github.com/tinylib/msgp

deb:
	dpkg-buildpackage -uc -us -b

clean:
	rm -f $(NAME)
