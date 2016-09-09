#!perl

use 5.010001;
use strict;
use warnings;
use Test::Exception;
use Test::More 0.98;

use Archive::Any::ExtractedSize qw(calc_archive_extracted_size);
use File::ShareDir qw(dist_dir);

my $share_dir = do {
    my $dir;
    {
        $dir = "share";
        if (-d $dir) {
            last;
        }
        $dir = dist_dir("Archive-Any-ExtractedSize");
    }
    $dir;
};

is(calc_archive_extracted_size(filename => "$share_dir/archive.tar.gz"), 1000);
is(calc_archive_extracted_size(filename => "$share_dir/archive.tar.gz", block_size=>1024), 1000);

is(calc_archive_extracted_size(filename => "$share_dir/archive.zip"), 1000);

dies_ok { calc_archive_extracted_size(filename => "$dir/notfound") };
dies_ok { calc_archive_extracted_size(filename => "$dir/dir") };
dies_ok { calc_archive_extracted_size(filename => "$dir/archive.foo") };
