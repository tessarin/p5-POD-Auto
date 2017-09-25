package POD::Auto;

use 5.006;
use strict;
use warnings;

our $VERSION = '1.0';

sub import {
    my $arg = $_[1] // 'help';
    search_for($arg);
}

sub search_for {
    my $arg = shift;
    foreach (@ARGV) {
	show_docs() if $_ eq "--$arg";
    }
}

sub show_docs {
    @ARGV = ('-F', $0);
    exit Pod::Perldoc->run();
}

1;
