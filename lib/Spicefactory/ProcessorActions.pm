package Spicefactory::ProcessorActions;
use v5.10;

our $SELF;
sub new { return $SELF }

sub do_default {
    my ( $self, @args ) = @_;
    print "args: @args";
}

sub do_tag {
	say "read tag";
}

sub do_content {
	say "read content";
}

1;