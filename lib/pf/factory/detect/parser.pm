package pf::factory::detect::parser;

=head1 NAME

pf::factory::detect::parser

=cut

=head1 DESCRIPTION

pf::factory::detect::parser

Create a pfdetect parser by it's configuration ID

=cut

use strict;
use warnings;
use Module::Pluggable search_path => 'pf::detect::parser', sub_name => 'modules' , require => 1;
use List::MoreUtils qw(any);
use pf::detect::parser;

our @MODULES = __PACKAGE__->modules;

sub factory_for { 'pf::detect::parser' }

sub new {
    my ($class,$name) = @_;
    my $subclass = $class->getModuleName($name);
    return $subclass->new;
}

sub getModuleName {
    my ($class,$name,$data) = @_;
    my $mainClass = $class->factory_for;
    my $subclass = "${mainClass}::${name}";
    die "$name is not a valid type" unless any { $_ eq $subclass  } @MODULES;
    $subclass;
}

=head1 AUTHOR

Inverse inc. <info@inverse.ca>

=head1 COPYRIGHT

Copyright (C) 2005-2015 Inverse inc.

=head1 LICENSE

This program is free software; you can redistribute it and::or
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

