#!/usr/bin/perl

use 5.010;

$operation = shift @ARGV;
$filename = shift @ARGV;
$lang = shift @ARGV;

template() if $operation eq '-e';
translate() if $operation eq '-et';
insert() if $operation eq '-i';

sub template {

    open $fh, '<', 'default.json' or die $!;
    open $fh1, '>', 'template.json' or die $!;

    say $fh1 '{';

    while(<$fh>) {
        chomp;
        next if $_ !~ m/(.*:\s").*(".*)/;
        say $fh1 $1 . $2;
    }

    say $fh1 '}';

    close $fh1 or die $!;
    close $fh or die $!;

}

sub translate {

    open $fh, '<', 'default.json' or die $!;
    open $fh1, '>', 'translate' or die $!;

    while(<$fh>) {
        chomp;
        next if $_ !~ m/.*:\s"(.*)".*/;
        say $fh1 $1;
    }

    close $fh1 or die $!;
    close $fh or die $!;

}

sub insert {

    open $fh, '<', 'template.json' or die $!;
    open $fh1, '<', $filename or die $!;
    open $fh2, '>', $lang . '.json' or die $!;

    @translate;

    while(<$fh1>) {
        chomp;
        $_ =~ s/^\s+|\s+$//g;
        push(@translate,$_);
    }

    say $fh2 '{';

    $i = 0;

    while(<$fh>) {

        chomp;
        next if $_ !~ m/(.*:\s").*(".*)/;
        say $fh2 $1 . $translate[$i] . $2;

        $i++;
    }

    say $fh2 '}';

    close $fh1 or die $!;
    close $fh2 or die $!;
    close $fh or die $!;

}
