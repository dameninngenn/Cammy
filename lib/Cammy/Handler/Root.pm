package Cammy::Handler::Root;
use strict;
use warnings;
use parent 'Tatsumaki::Handler';
__PACKAGE__->asynchronous(1);
use Tatsumaki::HTTPClient;
use XML::Simple;

sub get {
    my ($self) = @_;
    my $client = Tatsumaki::HTTPClient->new;

    $client->get(
        'http://live.nicovideo.jp/recent/rss?tab=live&sort=start&p=2',
        $self->async_cb( sub { $self->on_response(@_) } )
    );
}

sub on_response {
    my ( $self, $res ) = @_;
    if ( $res->is_error ) {
        Tatsumaki::Error::HTTP->throw(500);
    }
    my $rss = XMLin( $res->content );
    $self->render( 'index.tx', { items => $rss->{channel}->{item} } );
}

1;
