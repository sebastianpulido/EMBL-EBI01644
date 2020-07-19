#!/usr/bin/env perl
use strict;
use warnings;
use Bio::EnsEMBL::Registry;
use Data::Dumper;
use Getopt::Long;

# default values
my $query_species    = 'human';
my $chromosome       = '10';
my $seq_region_start = 25000; 
my $seq_region_end   = 30000; 
my $help             = 0;

# Parse command-line arguments
my $options_ok = 
  GetOptions(
    'chromosome=s'        => \$chromosome,
    'seq_region_start=s'  => \$seq_region_start,
    'seq_region_end=s'    => \$seq_region_end,
    'help'              => \$help);
($help or !$options_ok) && usage();

# print arguments:
print "chromosome= " . $chromosome . "\n";
print "start= " . $seq_region_start . "\n";
print "end= " . $seq_region_end . "\n\n";

# Connecting to the database for GRCh38
my $registry = 'Bio::EnsEMBL::Registry';
$registry -> load_registry_from_db(
    -host => 'ensembldb.ensembl.org',
    -user => 'anonymous'
);

# Set the Dumper settings to show only one level and use indents on the hash
$Data::Dumper::Maxdepth = 1;
$Data::Dumper::Indent   = 3;

# Adaptors
my $slice_a = $registry -> get_adaptor($query_species, "core", "slice");
my $csa     = $registry -> get_adaptor($query_species, "core", "coordsystem");
my $asma    = $registry -> get_adaptor($query_species, "core", "assemblymapper");

# Objects
my $slice  = $slice_a -> fetch_by_region('chromosome', $chromosome, $seq_region_start, $seq_region_end);
my $cs7    = $csa -> fetch_by_name('chromosome', 'GRCh37');
my $cs8    = $csa -> fetch_by_name('chromosome', 'GRCh38');
my $mapper = $asma->fetch_by_CoordSystems( $cs7, $cs8 );

my $frm_seq_region = $slice -> seq_region_name;
my $start          = $slice -> start;
my $end            = $slice -> end;
my $strand         = $slice -> strand;

# Map
my @coords = $mapper->map( $frm_seq_region, $start, $end, $strand, $cs8 );

# Output: Coordinates converted from GRCh38 to GRCh37
print "\nGRCh38 coordinate system\n";
warn Dumper($slice -> coord_system);
print "\n";

print "\nGRCh37 coordinate system\n";
foreach my $c (@coords){
    warn Dumper($c);
}
print "\n";

# subs
sub usage {
    my $prog = `basename $0`; chomp($prog);
    print "Usage: $prog [OPTIONS]\n\n";
    print "Options:\n";
    print "  -chromosome            Chromosome, default = 10\n";
    print "  -seq_region_start      Sequence region start, default = 25000\n";
    print "  -seq_region_end        Sequence region end, default = 30000\n";
    print "  -help                  Print this message\n";
    print "\n\nIf not arguments are passed in, default values will be used.\n";
    print "example:\n";
    print "    ./connect2ensemble.pl --chromosome 10 --seq_region_start 20000 --seq_region_end 35000\n";
    print "    ./connect2ensemble.pl\n";
    print "\n\n";
    exit 1;
}