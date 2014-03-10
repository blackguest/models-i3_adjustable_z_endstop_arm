// models-i3_adjustable_z_endstop_arm
// 3D Printing Filament Spool Stand
// GNU GPL v3
// Ethan Sherman <ethan@blackguest.net>
//
// https://github.com/blackguest/models-i3_adjustable_z_endstop_arm.git


width=8.5;
length=42.0;
arm_thickness=5.5;
hole_width=31.0;

m3_r=3.6/2;
m3_head_r=2.95;
m3_head_h=2.7;

m4_r=4.3/2;
m4_nut_holder_w=18.0;
m4_nut_big_w=8.25;
m4_nut_h=3.2 * 1.5;  // multiply by 1.5 to also fit m4 locknuts
m4_nut_holder_h=m4_nut_h*1.5;

fudge=0.01;

module m4_mount(){
  bottom_m3_hole_x = (length - hole_width)/2;
  m3_hole_y = width/2;
  translate([bottom_m3_hole_x+m3_head_r,
             m3_hole_y,
             arm_thickness*2-fudge])
    rotate([30,0,0]) rotate([0,90,0])
      difference(){
        cylinder(r=m4_nut_holder_w/2, h=m4_nut_holder_h, $fn=6);
        // m4 hole
        translate([0,0,-m4_nut_holder_h*2])
          cylinder(r=m4_r, h=m4_nut_holder_h*4, $fn=20);
        translate([0,0,-m4_nut_h * 2])
          cylinder(r=m4_nut_big_w/2, h=m4_nut_h * 3, $fn=6);
      }
}

module mount_arm(){
  bottom_m3_hole_x = (length - hole_width)/2;
  top_m3_hole_x = bottom_m3_hole_x + hole_width;
  m3_hole_y = width/2;
  difference(){
    cube([length,width,arm_thickness]);
    // bottom m3 hole
    translate([bottom_m3_hole_x,
               m3_hole_y,
               -arm_thickness/2])
      cylinder(r=m3_r, h=arm_thickness*2, $fn=20);
    // bottom m3 head
    translate([bottom_m3_hole_x, m3_hole_y, arm_thickness - m3_head_h ])
      cylinder(r=m3_head_r, h=arm_thickness*2, $fn=20);
    // top m3 hole
    translate([top_m3_hole_x,
               m3_hole_y,
               -arm_thickness/2])
      cylinder(r=m3_r, h=arm_thickness*2, $fn=20);
    // bottom m3 head
    translate([top_m3_hole_x, m3_hole_y, arm_thickness - m3_head_h ])
      cylinder(r=m3_head_r, h=arm_thickness*2, $fn=20);
  }
}

union(){
  mount_arm();
  m4_mount();
}
