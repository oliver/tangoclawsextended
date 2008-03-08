
dist: claws-mail-theme_TangoClawsExt-0.3.tar.gz

claws-mail-theme_TangoClawsExt-0.3.tar.gz: TangoClawsExt-0.3
	rm -f claws-mail-theme_TangoClawsExt-0.3.tar.gz
	tar czf claws-mail-theme_TangoClawsExt-0.3.tar.gz TangoClawsExt-0.3


TangoClawsExt-0.3: TangoClaws-0.3 tango_icons_for_thunderbird-0.7.0-tb
	rm -rf TangoClawsExt-0.3
	mkdir TangoClawsExt-0.3
	perl add_tango_icons.pl TangoClawsExt-0.3


TangoClaws-0.3: claws-mail-theme_TangoClaws-0.3.tar.gz
	rm -rf TangoClaws-0.3
	tar xzf claws-mail-theme_TangoClaws-0.3.tar.gz
	touch --no-create -m TangoClaws-0.3


tango_icons_for_thunderbird-0.7.0-tb: tango_icons_for_thunderbird-0.7.0-tb.jar
	mkdir -p tango_icons_for_thunderbird-0.7.0-tb
	unzip -d tango_icons_for_thunderbird-0.7.0-tb tango_icons_for_thunderbird-0.7.0-tb.jar


clean:
	rm -rf TangoClawsExt-0.3
	rm -rf claws-mail-theme_TangoClawsExt-0.3.tar.gz
	rm -rf TangoClaws-0.3
	rm -rf tango_icons_for_thunderbird-0.7.0-tb
