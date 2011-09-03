#!/usr/bin/env perl

use strict;
use warnings;

use Test::More tests => 2;

use lib 't/lib';

use TestEnv;

use Article;

TestEnv->setup;

my %columns = (category_id => 1);
Article->new->set_columns(%columns)->create;
Article->new->set_columns(%columns)->create;

my @r =
  Article->new->find(columns => 'category_id', group_by => 'category_id');

is scalar @r, 1, 'one record';
is $r[0]->category_id, 1, 'category_id is right';
