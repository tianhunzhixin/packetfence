package pfappserver::Model::Pfqueue;

=head1 NAME

pfappserver::Model::Pfqueue - Catalyst Model

=head1 DESCRIPTION

Catalyst Model.

=cut

use Moose;
use namespace::autoclean;
use pf::util::pfqueue;
use pf::constants::pfqueue qw($PFQUEUE_COUNTER);
use Redis::Fast;

extends 'Catalyst::Model';

=head1 METHODS

=head2 counters

=cut

sub counters {
    my ($self) = @_;
    my $redis = $self->redis;
    my %counters = $redis->hgetall($PFQUEUE_COUNTER);
    my @counters = map { &_counter_map(\%counters, $_) } sort keys %counters;
    return \@counters;
}

sub _counter_map {
    my ($counters, $key) = @_;
    $key =~ /Queue:([^:]+):(.*)$/;
    my $queue = $1;
    my $name = $2;
    my %counter = (
        name => $name,
        queue => $queue,
        count => $counters->{$key},
    );
    return \%counter;
}


sub redis {
    my ($self) = @_;
    return Redis::Fast->new( %{$self->redis_options});
}

sub redis_options {
    my ($self) = @_;
    my $config = pf::util::pfqueue::load_config_hash;
    my $consumer_options = $config->{consumer};
    my %options;
    foreach my $key ( map {s/^redis_(.*)$//;$1} keys %$consumer_options ) {
        $options{$key} = $consumer_options->{"redis_$key"};
    }
    return \%options;
}


=head1 COPYRIGHT

Copyright (C) 2005-2015 Inverse inc.

=head1 LICENSE

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301,
USA.

=cut

__PACKAGE__->meta->make_immutable;

1;
