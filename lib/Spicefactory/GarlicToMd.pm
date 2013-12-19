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
document ::= newline document newline node
node ::= tag space content space close_tag
close_tag ::= '#'tag_marker
tag ::= '#'tag_marker action => do_tag
content ::= text action => do_content

newline ~ [\n|\r]*
space ~ [\s]+
text ~ [.]+
tag_marker ~ [\w]+
END_OF_DSL

method garlic_sample {

	my $garlic_sample = "
#sc1 overview_intro Overview #sc1

#par Parsley is an Application Framework for Flex and Flash Applications built upon an IOC Container and
Messaging Framework that can be used to create highly decoupled architectures. #par
";

	return $garlic_sample;
}


method convert() {

	# my $garlic_text = read_file($self->garlic_file);

	# my $garlic_text = garlic_sample();

	my $garlic_text = "#sc1 start #sc1";
	say $garlic_text;

	say "Grammar is:\n" . $garlic_grammar;

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