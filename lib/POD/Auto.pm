package POD::Auto;

use 5.006;
use strict;
use warnings;

use Carp;
use Pod::Perldoc;

our $VERSION = '1.0';

sub import {
    my $arg = $_[1] // 'help';
    search_for($arg);
}

sub search_for {
    my $arg = shift;
    my ($long, $short) = process_arguments($arg);
    foreach (@ARGV) {
	if ( ( $long && $_ eq "--$long" ) ||
	     ( $short && /^-\w*$short/  ) ) {
	    show_docs();
	}
    }
}

sub process_arguments {
    return () unless $_[0];
    my $arg = shift;
    my @pieces = split /\|/, $arg;
    croak 'too many flags to detect' if @pieces > 2;

    my ($long, $short);
    foreach (@pieces) {
	if (length == 1) {
	    croak 'only one short flag allowed' if $short;
	    $short = $_;
	}
	if (length > 1) {
	    croak 'only one long flag allowed' if $long;
	    $long = $_;
	}
    }

    return ($long, $short);
}

sub show_docs {
    @ARGV = ('-F', $0);
    exit Pod::Perldoc->run();
}

1;
