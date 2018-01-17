Ensembl REST TNG plugable controllers
=====================================

A demonstration of a plugable controller for the Ensembl REST TNG catalyst framework.

To enable the controller ensure that ./lib/ is in the PERL5LIB. On startup the REST controller will call the initialization functions, this controller will search and find the configuration file in this repo. And one endpoint, /vepy, will be enabled.
