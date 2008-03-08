
dist: claws-mail-theme_TangoClawsExt-0.3.tar.gz

claws-mail-theme_TangoClawsExt-0.3.tar.gz: TangoClawsExt-0.3
	rm -f claws-mail-theme_TangoClawsExt-0.3.tar.gz
	tar czf claws-mail-theme_TangoClawsExt-0.3.tar.gz TangoClawsExt-0.3


TangoClawsExt-0.3:
	rm -rf TangoClawsExt-0.3
	mkdir TangoClawsExt-0.3
	perl add_tango_icons.pl TangoClawsExt-0.3

clean:
	rm -rf TangoClawsExt-0.3
	rm -rf claws-mail-theme_TangoClawsExt-0.3.tar.gz
