# POD::Auto - Automatic launch of manual pages

The `POD::Auto` Perl module looks for the correct flag in the program
arguments and (if found) opens the embed [POD][pod]. Searches for any
given flag (short, long or both) or `--help` by default.

After installing, check `perldoc POD::Auto` for a complete description
of the available functionality.

## Installation

Install with [cpanm][cpm]:

    $ cpanm git://github.com/tessarin/p5-POD-Auto.git

## Examples

Simply `use`'ing the module in a program will make it detect `--help`
and show the embed *POD*:

    use POD::Auto;
    # code and POD

    $ prg	    # execute normally
    $ prg --help    # call perldoc, opening man page

### Custom flags

    use POD::Auto "h";	    # search for `-h`
    use POD::Auto "h|help"; # search for `-h` or `--help`

 [pod]: https://perldoc.perl.org/perlpod.html
 [cpm]: https://github.com/miyagawa/cpanminus
