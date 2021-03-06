package TestDB;

use strict;
use warnings;

use base 'ObjectDB';

use DBI;

our $DBH;

sub dbh {
    my $class = shift;

    return $DBH if $DBH;

    my @args = ();

    if ($ENV{TEST_MYSQL}) {
        my @options = split(',', $ENV{TEST_MYSQL});
        push @args, 'dbi:mysql:' . shift @options, @options;
    }
    else {
        push @args, 'dbi:SQLite:' . ':memory:';
    }

    my $dbh = DBI->connect(@args);
    die $DBI::errorstr unless $dbh;

    unless ($ENV{TEST_MYSQL}) {
        $dbh->do("PRAGMA default_synchronous = OFF");
        $dbh->do("PRAGMA temp_store = MEMORY");
    }

    $DBH = $dbh;
    return $dbh;
}

1;
