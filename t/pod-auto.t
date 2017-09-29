#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More;
use POD::Auto;

plan tests => 8;

note('Testing argument parsing');

my @empty = POD::Auto::process_arguments();

is( $empty[0], undef, 'empty long opt detected' );
is( $empty[1], undef, 'empty short opt detected' );

my @complete = POD::Auto::process_arguments('help|h');

is( $complete[0], 'help', 'long opt detected' );
is( $complete[1], 'h', 'short opt detected' );

my (@bad, $err);
eval {
    @bad = POD::Auto::process_arguments('help|h|help')
} or $err = $@;

isnt( @bad, 3, 'correct abortion of bad argument' );
like( $err, qr/too many/, 'dies with proper message' );

eval {
    @bad = POD::Auto::process_arguments('h|h');
} or $err = $@;

like( $err, qr/only one/, 'aborts two short flags');

eval {
    @bad = POD::Auto::process_arguments('help|help');
} or $err = $@;

like( $err, qr/only one/, 'aborts two long flags');
