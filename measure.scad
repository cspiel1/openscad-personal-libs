
module line(start, end, thickness = 0.1) {
  hull() {
    translate(start) sphere(thickness);
    translate(end) sphere(thickness);
  }
}

module peak(start, end, thickn = 4) {
  hull() {
    translate(start) sphere(thickn);
    translate(end) sphere(thickn/40);
  }
}

function angle_between(a, b) =
  acos( (a*b) / (norm(a)*norm(b)) );

function rot_x(a, v) =
    [ v[0],
      v[1]*cos(a) - v[2]*sin(a),
      v[1]*sin(a) + v[2]*cos(a) ];

function rot_y(a, v) =
    [ v[0]*cos(a) + v[2]*sin(a),
      v[1],
     -v[0]*sin(a) + v[2]*cos(a) ];

function rot_z(a, v) =
    [ v[0]*cos(a) - v[1]*sin(a),
      v[0]*sin(a) + v[1]*cos(a),
      v[2] ];

function rotate_vpr(v) =
    let(
        r = $vpr * PI / 180
    )
    rot_z(r[2], rot_y(r[1], rot_x(r[0], v)));

function cross3(a, b) = cross(a, b) == 0 ? cross(a, [1,0,0]) : cross(a, b);
function cross2(a, b) = cross3(a, b) == 0 ? cross(a, [0,1,0]) : cross(a, b);

module measure(a=[0,0,0],b=[0,0,100], midx=0, size=20,
               peaklen=20, peakthick=4, mirror=false) {
  d=b-a;
  l=round(norm(d)*10)/10;
  o=peaklen*((b-a)/norm(d));
  m=(b+a)/2;
  m2=(b*4+a)/5;
  vp=rotate_vpr([0,0,-1]);
  vo=cross2(vp, d);
  von=vo/norm(vo)*size;
  a1=a+von;
  b1=b+von;
  color("blue") {
    line(a, a1);
    line(b, b1);
  }

  // color("green")
  if (l >= (peaklen*4)) {
    line(a1, b1);
    peak(a1+o, a1, peakthick);
    peak(b1-o, b1, peakthick);
  }
  else {
    line(a1-o*2, b1+o*2);
    peak(a1-o, a1, peakthick);
    peak(b1+o, b1, peakthick);
  }

  m3=(a1+b1)/2;
  echo ("angle_between:", angle_between([1,0,0], d));
  color("orange")
    translate(m3)
    rotate(a = (mirror ? 180 : 0 ) + angle_between([1,0,0], d),
           v = cross2([1,0,0], d))
    linear_extrude(size/5)
    text(str(l), size=size, halign="center", valign="center");
  if (midx > 0) {
    translate(m2) rotate($vpr)
      text(str(midx), size=size/2, halign="center", valign="center");
  }

}

