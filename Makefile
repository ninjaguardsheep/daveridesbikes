BUILDCMD := cobalt
MINCMD := minify
BUILDDIR := _site
WEBSVR := srv-03
WEBDEST := /var/www/www.daveridesbikes.xyz/

.PHONY: build
build: clean
	${BUILDCMD} build
	ln -s "feed.xml" ${BUILDDIR}/rss.xml
	minify --verbose --output ${BUILDDIR}/ --recursive ${BUILDDIR}/

.PHONY: upload
upload:
	sftp -r ${WEBSVR} << EOF
	cd ${WEBDEST}
	mput ${BUILDDIR}/*
	bye
	EOF

.PHONY: clean
clean:
	rm -rf ${BUILDDIR}

.PHONY: push
push: build upload clean
