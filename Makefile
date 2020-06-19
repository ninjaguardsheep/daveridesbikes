BUILDDIR := _site
WEBSVR := srv-03
WEBDEST := /var/www/www.daveridesbikes.xyz/

.PHONY: build
build: clean
	cobalt build
	ln -s "feed.xml" ${BUILDDIR}/rss.xml
	minify --verbose --output ${BUILDDIR}/ --recursive ${BUILDDIR}/

.PHONY: upload
upload:
	printf "cd ${WEBDEST}\nmput ${BUILDDIR}/*\nbye" | sftp -r ${WEBSVR}

.PHONY: clean
clean:
	rm -vrf ${BUILDDIR}

.PHONY: push
push: build upload
