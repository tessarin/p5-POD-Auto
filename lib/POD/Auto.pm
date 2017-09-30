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

__END__

=head1 NAME

POD::Auto - Automatically launch embed POD

=head1 SYNOPSIS

I<POD::Auto> analyses the program arguments and if a specific flag is
found, it will launch I<perldoc>. Opening the man page of a program with
embed POD can thus be made with little effort.

    use POD::Auto [flags];

=head1 DESCRIPTION

The argument passed at the C<use> statement must be a string containing
either a long opt, short, or both separated by a C<|> character. The
module will then search for these flags in C<@ARGV>, call I<perldoc> on
the program name and exit.

If no argument is passed, the module looks for the C<--help> flag by
default.

Short flags are searched according to usual argument conventions. If the
module has to search for the C<h> flag, for example, calling the program
with C<-vph> does result in a match.

=head1 EXAMPLES

The most basic scenario possible is to just C<use> the module:

    use POD::Auto;
    # program code and POD

And then, in your shell:

    $ program		# executes program normally
    $ program --help	# opens documentation,
			# similar to `perldoc -F $0`

=head2 Custom Flags

The string passed at the C<use> statement determines the search:

    use POD::Auto "h";		# searches for `-h`
    use POD::Auto "h|version";	# searches for `-h` or `--help`

=head1 AUTHOR

This module was written by Cesar Tessarin on Sep. 2017 as a test Perl
distribution using L<https://github.com>.

=cut
