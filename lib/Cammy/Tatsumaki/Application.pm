package Cammy::Tatsumaki::Application;
use Any::Moose;
extends 'Tatsumaki::Application';

has template => (is => 'rw', isa => 'Cammy::Tatsumaki::View', lazy_build => 1, handles => [ 'render_file' ]);

sub _build_template {
    my $self = shift;
    require Cammy::Tatsumaki::View::Xslate;
    Cammy::Tatsumaki::View::Xslate->new;
}
sub template_path {
    my $self = shift;
    if (@_) {
        my $path = ref $_[0] eq 'ARRAY' ? $_[0] : [ $_[0] ];
        $self->template->include_path($path);
    }
    $self->template->include_path;
}

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;
