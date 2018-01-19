=head1 LICENSE

Copyright [1999-2015] Wellcome Trust Sanger Institute and the EMBL-European Bioinformatics Institute 
Copyright [2016-2017] EMBL-European Bioinformatics Institute

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

=head1 SYNOPSIS

Sample of a plugable controller

=head1 DESCRIPTION



=cut

package EnsEMBL::REST::Controller::Variation::VEP;

use Moose;
use namespace::autoclean;
require EnsEMBL::REST;

BEGIN { extends 'EnsEMBL::REST::Base::Controller' }

# Use the Catalyst::Controller::REST RFC 7231 compliance
# mode to correctly handle the response content type.
# Send JSON by default but allow YAML and 'moo' content
# types via the Accept header.

__PACKAGE__->config(
  compliance_mode => 1,

  'default' => 'application/json',
  'map' => {
    'application/json' => 'JSON',
    'text/html'        => 'YAML',
    'moo/type'      => 'JSON',
  },
);

#
# Do any initialization here, such as pre-loading caches.
# As well load any configuration files, any returned value
# will be placed in (EnsEMBL::REST->config()->{"Controller::Variation::VEP"}
#
sub initialize_controller {
  my ($self) = @_;

  $self->_load_config();

  return $self->{config} if $self->{config};
}


sub endpoint_documentation {
  my ($self) = @_;

  my $endpoints = {
      'VEP' => {
	  'vep_foo' => {
	      'method'      => 'GET',
	      'uri'         => 'variation/vep/:id',
	      'description' => 'Do VEPy stuff',
	  }
      }
  };
  
  return $endpoints;
}

sub endpoints {
  my ($self) = @_;

  my $endpoints = {
      'vep_foo' => {
	  'method'      => 'GET',
	  'endpoint'    => 'variation/vep/:id',
	  'section'     => 'VEP',
      }
  };
  
  return $endpoints;
}

# Silly little endpoint to demonstrate plugable controllers

sub foo : Path('/vepy') {
  my ($self, $c, $id) = @_;

  my $purpose = 'We have no purpose';

  my $vep_config = EnsEMBL::REST->config->{'Controller::Variation::VEP'};
  if($vep_config) {
      $purpose = $vep_config->{'purpose'};
  }

  $self->status_ok(
      $c,
      entity => { foo => 'vep-a-dee-doo-dah',
                  bar => 'vep-a-dee-ay',
		  purpose => $purpose });

}

__PACKAGE__->meta->make_immutable;

1;
