#!/usr/bin/env perl
use strict;
use warnings;
use Bio::EnsEMBL::Registry;
use Data::Dumper;
use Getopt::Long;

# Connecting to the database for GRCh38
my $registry = 'Bio::EnsEMBL::Registry';
$registry -> load_registry_from_db(
    -host => 'ensembldb.ensembl.org',
    -user => 'anonymous'
);

# Define the query species and the coordinates of the Slice (default values)
my $query_species    = 'human';
my $seq_region       = '10';
my $seq_region_start = 25000; 
my $seq_region_end   = 30000; 

# Set the Dumper settings to show only one level and use indents on the hash
$Data::Dumper::Maxdepth = 1;
$Data::Dumper::Indent   = 3;

# Adaptors
my $slice_a = $registry -> get_adaptor("human", "core", "slice");
my $csa     = $registry -> get_adaptor("human", "core", "coordsystem");
my $asma    = $registry -> get_adaptor( "human", "core", "assemblymapper" );

# Objects
my $slice  = $slice_a -> fetch_by_region('chromosome', '10', 25000, 30000);
my $cs7    = $csa -> fetch_by_name('chromosome', 'GRCh37');
my $cs8    = $csa -> fetch_by_name('chromosome', 'GRCh38');
my $mapper = $asma->fetch_by_CoordSystems( $cs7, $cs8 );

debugging();

my $frm_seq_region = $slice -> seq_region_name;
my $start  = $slice -> start;
my $end    = $slice -> end;
my $strand = $slice -> strand;

my @coords = $mapper->map( $frm_seq_region, $start, $end, $strand, $cs8 );

# Output: From GRCh38 to GRCh37
print "\nGRCh38\n";
warn Dumper($slice -> coord_system);
print "\n";

print "\nGRCh37\n";
foreach my $c (@coords){
    warn Dumper($c);
}
print "\n";

# subs
sub usage {
    my $prog = `basename $0`; chomp($prog);
    print "Usage: $prog [OPTIONS]\n\n";
    print "Options:\n";
    print "  -chromosome            Chromosome, default = 1\n";
    print "  -seq_region_start      Sequence region start\n";
    print "  -seq_region_end        Sequence region end\n";
    print "  -help                  Print this message\n";
    print "\n\n";
    exit 1;
}

sub debugging {
    print "\nCOORDINATE SYSTEM 37\n";
    warn Dumper($cs7);
    print "\n";

    print "\nCOORDINATE SYSTEM 38\n";
    warn Dumper($cs8);
    print "\n";

    print "\nMAPPER\n";
    warn Dumper($mapper);
    print "\n";

    print "\nDUMP SLICE\n";
    warn Dumper($slice);
    print "\n";

    print "\nCOORD SYSTEM\n";
    my $coordsys8 = $slice->coord_system;
    print $coordsys8 . "\n";
    print $coordsys8 -> version;
    print "\n";
}