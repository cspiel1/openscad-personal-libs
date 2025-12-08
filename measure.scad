
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

//  translate(end) sphere(thickn2*2);
//  d = end - start;
//  al = d[2] ? atan(d[1]/d[2]) : 90;
//  be = d[1] ? atan(d[1]/d[0]): 90;
//  translate(end) rotate([be,al,]) linear_extrude(0.2) circle(thickn1*5);
}

module measure(a=[0,0,0],b=[0,0,100], midx=0, zr=0, xr=90, size=20,
               peaklen=20, peakthick=4) {
  d=b-a;
  l=round(norm(d)*10)/10;
  o=peaklen*((b-a)/l);
  m=(b+a)/2;
  m2=(b*4+a)/5;

    if (l >= (peaklen*4)) {
      color("orange") line(a, b);
      color("green") peak(a+o, a, peakthick);
      color("green") peak(b-o, b, peakthick);
    }
    else {
      color("orange") line(a-o*2, b+o*2);
      color("green") peak(a-o, a, peakthick);
      color("green") peak(b+o, b, peakthick);
    }

    color("orange") 
    translate(m) rotate(zr, [0,0,1]) rotate(xr, [1,0,0])
      linear_extrude(size/5)
      text(str(l), size=size, halign="center", valign="center");
    if (midx > 0) {
      translate(m2) rotate(zr, [0,0,1]) rotate(xr-90, [1,0,0])
      text(str(midx), size=size/2, halign="center", valign="center");
    }

}

