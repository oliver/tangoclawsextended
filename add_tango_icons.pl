#!/usr/bin/perl

use strict;
use warnings;

my $baseIconDir = './TangoClaws-0.3/';
my $tango = '/usr/share/icons/Tango/';
my $tbtango = './tango_icons_for_thunderbird-0.7.0-tb/';
my $custom = './customIcons/';
my $targetDir = $ARGV[0];

my %mapping = (
'dir_close' => "$tango/16x16/places/folder.png",
'dir_close_mark' => ['overlay', "$tango/16x16/places/folder.png", "$custom/folder-mark-emblem.png"],
'dir_open' => "$tango/16x16/status/folder-open.png",
'dir_open_mark' => ['overlay', "$tango/16x16/status/folder-open.png", "$custom/folder-mark-emblem.png"],
'inbox_close' => "$tbtango/messenger/icons/folder-inbox.png",
'inbox_close_mark' => ['overlay', "$tbtango/messenger/icons/folder-inbox.png", "$custom/folder-mark-emblem.png"],
'inbox_open' => "$tbtango/messenger/icons/folder-inbox.png",
'inbox_open_mark' => ['overlay', "$tbtango/messenger/icons/folder-inbox.png", "$custom/folder-mark-emblem.png"],
'outbox_close' => "$tbtango/messenger/icons/folder-outbox.png",
'outbox_close_mark' => ['overlay', "$tbtango/messenger/icons/folder-outbox.png", "$custom/folder-mark-emblem.png"],
'outbox_open' => "$tbtango/messenger/icons/folder-outbox.png",
'outbox_open_mark' => ['overlay', "$tbtango/messenger/icons/folder-outbox.png", "$custom/folder-mark-emblem.png"],
'drafts_open' => "$tbtango/messenger/icons/folder-draft.png",
'drafts_open_mark' => ['overlay', "$tbtango/messenger/icons/folder-draft.png", "$custom/folder-mark-emblem.png"],
'drafts_close' => "$tbtango/messenger/icons/folder-draft.png",
'drafts_close_mark' => ['overlay', "$tbtango/messenger/icons/folder-draft.png", "$custom/folder-mark-emblem.png"],
'queue_close' => ['overlay', "$tango/16x16/places/folder.png", "$custom/queue-folder-emblem.png"],
'queue_open' => ['overlay', "$tango/16x16/status/folder-open.png", "$custom/queue-folder-emblem.png"],
'trash_open' => "$tango/16x16/places/emptytrash.png",
'trash_open_mark' => ['overlay', "$tango/16x16/places/emptytrash.png", "$custom/folder-mark-emblem.png"],
'trash_close' => "$tango/16x16/places/emptytrash.png",
'trash_close_mark' => ['overlay', "$tango/16x16/places/emptytrash.png", "$custom/folder-mark-emblem.png"],
'new' => "$tbtango/messenger/icons/message-mail-new.png",
'unread' => "$tbtango/messenger/icons/message-mail.png",
#'clip' => "$tbtango/messenger/icons/attachment-col.png",
#'clip' => "$tbtango/messenger/icons/attachment.png",
'quicksearch' => "$custom/quicksearch.png",
'mime_application' => "$tango/16x16/mimetypes/text-x-script.png",
'mime_audio' => "$tango/16x16/mimetypes/audio-x-generic.png",
'mime_calendar' => "$tango/16x16/mimetypes/vcalendar.png",
'mime_image' => "$tango/16x16/mimetypes/image-x-generic.png",
'mime_message' => "$custom/mime-email.png",
'mime_pdf' => "$tango/16x16/mimetypes/gnome-mime-application-pdf.png",
'mime_pgpsig' => "$tango/16x16/mimetypes/application-certificate.png",
'mime_ps' => "$tango/16x16/mimetypes/gnome-mime-application-postscript.png",
'mime_text_enriched' => "$tango/16x16/mimetypes/document.png",
'mime_text_html' => "$tango/16x16/mimetypes/text-html.png",
'mime_text_plain' => "$tango/16x16/mimetypes/text-x-generic.png",
'mime_unknown' => "$custom/mime-unknown.png",
'online' => "$tango/16x16/status/network-idle.png",
'offline' => "$tango/16x16/status/network-offline.png",
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
http://github.com/oliver/tangoclawsextended
';
close(OUT);
`cp $targetDir/.claws_themeinfo $targetDir/.sylpheed_themeinfo`;

# copy base images
`cp $baseIconDir/*.xpm $targetDir/`;

# copy README file
`cp README $targetDir/`;

# copy INSTALL file from TangoClaws
`cp $baseIconDir/INSTALL $targetDir/`;

# add converted images
for (keys(%mapping))
{
    my $dstName = $_;
    my $dstPath = "$targetDir/$dstName.xpm";

    my $action = 'convert';

    my $srcPath;
    if (ref($mapping{$_}) eq 'ARRAY')
    {
        $action = $mapping{$_}->[0];
        $srcPath = $mapping{$_}->[1];
    }
    else
    {
        $srcPath = $mapping{$_};
    }

    if (!$srcPath)
    {
        # ignore
        next;
    }

    #print "icon '$dstName' will be taken from '$srcPath'\n";

    if (! -e $srcPath)
    {
        die("source icon '$srcPath' not found");
    }

    if ($action eq 'convert')
    {
        #my $srcSize = `identify -format "%wx%h" $srcPath`;
        #my $cmd = "convert -size '$srcSize' xc:white '$srcPath' -composite '$dstPath'";
        my $cmd = "convert '$srcPath' '$dstPath'";
        print "cmd: '$cmd'\n";
        `$cmd`;
    }
    elsif ($action eq 'overlay')
    {
        my $srcPath2 = $mapping{$_}->[2];
        if (!$srcPath2 || (! -e $srcPath2))
        {
            die("invalid overlay icon '$srcPath2' specified");
        }

        my $cmd = "convert '$srcPath' '$srcPath2' -composite '$dstPath'";
        print "cmd: '$cmd'\n";
        `$cmd`;
    }
}

