package Spicefactory::GarlicToMd;
use v5.10;
use Moo;
use Method::Signatures;
use Marpa::R2;
use File::Slurp qw( read_file );

use FindBin::libs;
use Spicefactory::ProcessorActions;



has garlic_file => (is => 'ro', required => 1);		#	The file to be converted
has output_dir => (is => 'ro');						#	The converted file will be written to this folder


my $garlic_grammar = <<'END_OF_DSL';
:start ::= document
document ::= node
document ::= document newline node
node ::= tag space content space tag
tag action => do_tag
content ::= text action => do_content

:discard ~ whitespace
newline ~ [\n|\r]+
space ~ [\w]+
text ~ [.]+
tag ~ '#'[\w]+

END_OF_DSL

# my $garlic_grammar = <<'END_OF_DSL';
# :default ::= action => ::first
# :start ::= Expression
# Expression ::= Term
# Term ::=
#       Factor
#     | Term '+' Term action => do_add
# Factor ::=
#       Number
#     | Factor '*' Factor action => do_multiply
# Number ~ digits
# digits ~ [\d]+
# :discard ~ whitespace
# whitespace ~ [\s]+
# END_OF_DSL


method convert() {

	# my $garlic_text = read_file( $self->garlic_file ) or die "Couldn't read in Garlic source file";


	my $garlic_text = "#sc1 start #sc1";
	say $garlic_text;

	say "Grammar is: " . $garlic_grammar;

	 my $grammar = Marpa::R2::Scanless::G->new(
		{ action_object  => 'Spicefactory::ProcessorActions',
		  default_action => 'do_default',
		  source => \$garlic_grammar,
		}
      );


	 my $recce = Marpa::R2::Scanless::R->new({grammar => $grammar});

	 $recce->read(\$garlic_text);

}


1;