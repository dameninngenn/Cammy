package Cammy::Tatsumaki::View::Xslate;
use strict;
use Any::Moose;
use Text::Xslate;
extends 'Cammy::Tatsumaki::View';

# https://gist.github.com/607601
has tx => (is => 'rw', isa => 'Text::Xslate');
has rendered_string => (is => 'rw');
sub as_string { shift->rendered_string };

sub BUILD {
    my $self = shift;
    my $args = shift;

    my $tx = Text::Xslate->new(
        path => [ 'view', 'view/include' ],
        suffix => '.tx',
        cache => 1,
        cache_dir => '.xslate_cache',
        %$args
    );

    $self->tx($tx);
};

sub include_path {
    my $self = shift;
    if (@_) {
        # XXX copy from Text::Xslate#new
        my $path = shift;
        $self->tx->{path} = [
            map { ref($_) ? $_ : File::Spec->rel2abs($_) } @$path
        ];
    }
    $self->tx->{path};
}

sub render_file {
    my ( $self, $file, $args ) = @_;

    $self->rendered_string( $self->tx->render($file,$args) );

    # return self for as_string call in Tatsumaki::Handler#render
    return $self;
}

1;
