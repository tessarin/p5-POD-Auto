#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'POD::Auto' ) || print "Bail out!\n";
}

diag( "Testing POD::Auto $POD::Auto::VERSION, Perl $], $^X" );
