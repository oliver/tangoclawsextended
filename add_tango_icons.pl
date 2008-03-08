#!/usr/bin/perl

use strict;
use warnings;

my $baseIconDir = './TangoClaws-0.3/';
my $tango = '/usr/share/icons/Tango/';
my $tbtango = './tango_icons_for_thunderbird-0.7.0-tb/';
my $custom = './customIcons/';
my $targetDir = './newIcons/';

my %mapping = (
'dir_close' => "$tango/16x16/places/folder.png",
'dir_close_mark' => "",
'dir_open' => "$tango/16x16/status/folder-open.png",
'dir_open_mark' => "",
'inbox_close' => "$tango/16x16/places/folder_home.png",
'inbox_open' => "$tango/16x16/places/folder_home.png",
'outbox_close' => "$tbtango/messenger/icons/folder-outbox.png",
'outbox_open' => "$tbtango/messenger/icons/folder-outbox.png",
'drafts_open' => "$tbtango/messenger/icons/folder-draft.png",
'drafts_close' => "$tbtango/messenger/icons/folder-draft.png",
'trash_open' => "$tango/16x16/places/emptytrash.png",
'trash_close' => "$tango/16x16/places/emptytrash.png",
'new' => "$tbtango/messenger/icons/message-mail-new.png",
'unread' => "$tbtango/messenger/icons/message-mail.png",
#'clip' => "$tbtango/messenger/icons/attachment-col.png",
#'clip' => "$tbtango/messenger/icons/attachment.png",
'quicksearch' => "$custom/quicksearch.png",
);


if (!$targetDir || (! -d $targetDir))
{
    die ("no valid target directory specified");
}

# clean up
`rm $targetDir/*`;


# add theme info
open(OUT, ">$targetDir/.claws_themeinfo") or die "$!";
print OUT 'TangoClawsExt
Frederik Elwert, Oliver Gerlich
';
close(OUT);
`cp $targetDir/.claws_themeinfo $targetDir/.sylpheed_themeinfo`;

# copy base images
`cp $baseIconDir/*.xpm $targetDir/`;

# add converted images
for (keys(%mapping))
{
    my $dstName = $_;
    my $dstPath = "$targetDir/$dstName.xpm";
    my $srcPath = $mapping{$_};

    if (!$srcPath)
    {
        # ignore
        next;
    }

    #print "icon '$dstName' will be taken from '$srcPath'\n";

    if (! -e $srcPath)
    {
        #die("source icon '$srcPath' not found");
        print "source icon '$srcPath' not found - ignoring\n";
        next;
    }

    #my $srcSize = `identify -format "%wx%h" $srcPath`;
    #my $cmd = "convert -size '$srcSize' xc:white '$srcPath' -composite '$dstPath'";
    my $cmd = "convert '$srcPath' '$dstPath'";
    print "cmd: '$cmd'\n";
    `$cmd`;
}

