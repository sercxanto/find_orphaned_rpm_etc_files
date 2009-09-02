#
# We *must* use tabs in Makefiles:
# vi: nosmarttab tabstop=3
#

# Build the package / call rpm
rpm: 
	cp -f find_orphaned_rpm_etc_files ~/rpm/SOURCES
	cp -f gpl-2.0.txt README ~/rpm/BUILD
	rpmbuild -ba find_orphaned_rpm_etc_files.spec

# GPG sign the package
sign:
	rpm --addsign `ls ~/rpm/RPMS/noarch/find_orphaned_rpm_etc_files-*.noarch.rpm|tail -n 1`

# Copy files on public repository on internet server
public:
	chmod 644 `ls ~/rpm/RPMS/noarch/find_orphaned_rpm_etc_files-*.noarch.rpm|tail -n 1`
	scp -rp `ls ~/rpm/RPMS/noarch/find_orphaned_rpm_etc_files-*.noarch.rpm|tail -n 1` \
		roots:public_html/repos/centos/noarch
	ssh roots createrepo public_html/repos/centos

