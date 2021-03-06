package pf::util::pfqueue;

=head1 NAME

pf::util::pfqueue - pfqueue

=cut

=head1 DESCRIPTION

=head1 WARNING

=cut

use strict;
use warnings;
use pf::file_paths;
use Config::IniFiles;

BEGIN {
    use Exporter ();
    our ( @ISA, @EXPORT, @EXPORT_OK );
    @ISA = qw(Exporter);
    @EXPORT = qw();
    @EXPORT_OK = qw(task_counter_id);
}

=head2 task_counter_id

=cut

sub task_counter_id {
    my ($queue, $type, $args) = @_;
    my $counter_id = "${queue}:${type}";
    if ($type eq 'api' && ref ($args) eq 'ARRAY') {
        $counter_id .= ":" . $args->[0];
    }
    return $counter_id;
}

=head2 load_config_hash

=cut

sub load_config_hash {
    my ($self) = @_;
    tie our %config ,'Config::IniFiles' => (-file => "$install_dir/conf/pfqueue.conf");
    return \%config;
}

=head1 SUBROUTINES

=head1 AUTHOR

Inverse inc. <info@inverse.ca>

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

1;
