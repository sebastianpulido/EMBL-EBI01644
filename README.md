# EMBL-EBI01644

    Sebastian Pulido Mojica
    sebastian-mojica@outlook.com

Dependecies
    
    Ensembl PERL API
    #!/usr/bin/env perl

How to run:

    Usage: connect2ensemble.pl [OPTIONS]

Options:
  
    chromosome            Chromosome, default = 10
    seq_region_start      Sequence region start, default = 25000
    seq_region_end        Sequence region end, default = 30000
    help                  Print this message

If no arguments are passed in, default values will be used.

    example:
    
    ./connect2ensemble.pl --chromosome 10 --seq_region_start 20000 --seq_region_end 35000
    
    ./connect2ensemble.pl

Output:
    
    GRCh38 coordinate system

    $VAR1 = bless( {
                     'adaptor' => 'Bio::EnsEMBL::DBSQL::CoordSystemAdaptor=HASH(0x7fffea738168)',
                     'sequence_level' => 0,
                     'rank' => 1,
                     'version' => 'GRCh38',
                     'name' => 'chromosome',
                     'default' => 1,
                     'dbID' => 4,
                     'top_level' => 0
                   }, 'Bio::EnsEMBL::CoordSystem' );


    GRCh37 coordinate system

    $VAR1 = bless( {
                     'start' => 75000,
                     'name' => 'HG905_PATCH',
                     'id' => 1000622688,
                     'coord_system' => 'Bio::EnsEMBL::CoordSystem=HASH(0x7fffea751648)',
                     'rank' => 0,
                     'end' => 80000,
                     'strand' => 1
                   }, 'Bio::EnsEMBL::Mapper::Coordinate' );
    $VAR1 = bless( {
                     'name' => '10',
                     'id' => 292319,
                     'coord_system' => 'Bio::EnsEMBL::CoordSystem=HASH(0x7fffea751648)',
                     'end' => 71781,
                     'rank' => 0,
                     'strand' => 1,
                     'start' => 70936
                   }, 'Bio::EnsEMBL::Mapper::Coordinate' );
    $VAR1 = bless( {
                     'rank' => 0,
                     'end' => 72184,
                     'strand' => 1,
                     'name' => '10',
                     'id' => 292319,
                     'coord_system' => 'Bio::EnsEMBL::CoordSystem=HASH(0x7fffea751648)',
                     'start' => 71784
                   }, 'Bio::EnsEMBL::Mapper::Coordinate' );
    $VAR1 = bless( {
                     'rank' => 0,
                     'end' => 26248,
                     'start' => 26247
                   }, 'Bio::EnsEMBL::Mapper::Gap' );
    $VAR1 = bless( {
                     'start' => 72185,
                     'strand' => 1,
                     'rank' => 0,
                     'end' => 73544,
                     'name' => '10',
                     'id' => 292319,
                     'coord_system' => 'Bio::EnsEMBL::CoordSystem=HASH(0x7fffea751648)'
                   }, 'Bio::EnsEMBL::Mapper::Coordinate' );
    $VAR1 = bless( {
                     'start' => 73546,
                     'name' => '10',
                     'id' => 292319,
                     'coord_system' => 'Bio::EnsEMBL::CoordSystem=HASH(0x7fffea751648)',
                     'rank' => 0,
                     'end' => 75937,
                     'strand' => 1
                   }, 'Bio::EnsEMBL::Mapper::Coordinate' );
