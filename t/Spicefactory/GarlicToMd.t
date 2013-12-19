use Test::Most;
use v5.10;
use Carp;
use Try::Tiny;
use Data::Dump qw(dump);

use FindBin::libs;
use FindBin qw ($Bin);

BEGIN {
	use_ok('Spicefactory::GarlicToMd');
}

SKIP:
{
	my $test = 'SETUP';
	skip "Debugging", 1, if 0;	
	try {
		say "Running $test";

	} catch {
		carp($_);
		fail("Exception in test: $test");
	}	
}


SKIP:
{
	my $test = 'Open and convert intro';
	skip "Debugging", 1, if 0;	
	try {
		say "Running $test";


		my $input_file = $Bin . "/../../src/parsley/01_overview/00_intro.grl";
		ok(-e $input_file, "Input file $input_file exists");

		my $gtm = Spicefactory::GarlicToMd->new(garlic_file => $input_file);
		isa_ok($gtm, 'Spicefactory::GarlicToMd');

		$gtm->convert();

	} catch {
		carp($_);
		fail("Exception in test: $test");
	}	
}

SKIP:
{
	my $test = 'TEARDOWN';
	skip "Debugging", 1, if 0;	
	try {
		say "Running $test";

	} catch {
		carp($_);
		fail("Exception in test: $test");
	}	
}

done_testing();