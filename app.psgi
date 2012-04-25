#!/usr/bin/env perl
use strict;
use warnings;
use FindBin::libs;
use File::Basename;
use Cammy::Tatsumaki::Application;
use Cammy::Handler::Root;

my $app = Cammy::Tatsumaki::Application->new([
    '/'       => 'Cammy::Handler::Root',
]);

my $home_dir = dirname(__FILE__);
$app->static_path( sprintf('%s/static', $home_dir) );
$app->template_path([ sprintf('%s/view', $home_dir), sprintf('%s/view/include', $home_dir) ]);

return $app->psgi_app;
