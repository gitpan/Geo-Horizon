# -*- perl -*-

=head1 Test Examples

base.t - Good examples concerning how to use this module

=cut

use Test::More tests => 291;

BEGIN { use_ok( 'Geo::Horizon' ); }

my $gh = Geo::Horizon->new();
isa_ok($gh, "Geo::Horizon");
isa_ok($gh->ellipsoid, "Geo::Ellipsoids");
is($gh->ellipsoid->shortname, "WGS84", "ellipsoid->shortname=WGS84");

foreach(0 .. 90) {
  is($gh->distance(0,$_), 0, "distance(0=>$_)=0");
  is($gh->distance_great_circle(0,$_), 0, "distance_great_circle(0=>$_)=0");
}

my $r=1000;
$gh = Geo::Horizon->new({a=>$r});
isa_ok($gh, "Geo::Horizon");
isa_ok($gh->ellipsoid, "Geo::Ellipsoids");
is($gh->ellipsoid->a, $r, "ellipsoid->a=$r");
is($gh->ellipsoid->b, $r, "ellipsoid->b=$r");

foreach(0 .. 100) {
  my $h=$_;
  my $r=$gh->ellipsoid->a;
  my $b=$r;
  my $c=$r + $h;
  my $a=sqrt($c ** 2 - $b **2);
  is($gh->distance($h), $a, "distance($h)=$a");
}
