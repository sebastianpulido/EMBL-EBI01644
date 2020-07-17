#!/usr/bin/env perl
use strict;
use warnings;
use Bio::EnsEMBL::Registry;

my $registry = 'Bio::EnsEMBL::Registry';
$registry -> load_registry_from_db(
    -host => 'ensembldb.ensembl.org',
    -user => 'anonymous'
);

=for comment
my $registry_37 = 'Bio::EnsEMBL::Registry';
$registry_37 -> load_registry_from_db(
    -host => 'ensembldb.ensembl.org',
    -user => 'anonymous',
    -port => 3337
);
=cut

# Define the query species and the coordinates of the Slice
my $query_species = 'human';
my $seq_region = '10';
my $seq_region_start = 25000;
my $seq_region_end   = 30000;

=for comment
my @db_adaptors = @{ $registry -> get_all_DBAdaptors() };
foreach my $db_adaptor (@db_adaptors) {
    my $db_connection = $db_adaptor -> dbc();

    printf(
        "species/group\t%s/%s\ndatabase\t%s\nhost:port\t%s:%s\n\n",
        $db_adaptor->species(),   
        $db_adaptor->group(),
        $db_connection->dbname(), 
        $db_connection->host(),
        $db_connection->port()
    );
}
=cut

my $gene_adaptor = $registry -> get_adaptor("human", "core", "gene");
my $gene = $gene_adaptor -> fetch_by_dbID(10);
printf("geneByID", $gene);

my $slice_adaptor = $registry -> get_adaptor("human", "core", "slice");
my $slice = $slice_adaptor -> fetch_by_region('chromosome', '1', 1, 1000000);

my @genes = @{ $gene_adaptor -> fetch_all_by_Slice($slice) };
foreach my $g (@genes) {
    printf(
        $g,"\n"
    );
}