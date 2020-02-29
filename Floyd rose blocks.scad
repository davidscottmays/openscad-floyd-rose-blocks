//User-configurable tremolo blocking thingies
//2020 David Mays - davidscottmays@icloud.com

//These 3D bodies can be configured and printed to
//"Block off", or disable up and down motion in a
//floating floyd-rose style tremolo, effectively
//converting it into a fixed bridge guitar. Groovy!

//I recommend printing these at a decently solid infill.

//There are two main dimensions we care about:
//The distance from the tremolo block to the guitar
//wall on the butt end, and the distance from the
//tremolo block to the guitar wall on the opposite
//(Neck) end where the springs are. (All in mm!)
butt_end_distance = 15;
neck_end_distance = 15;

//If you need more adjustment, here are the other
//main configurable variables:

butt_end_angle = 45;     //Angle of wedge (deg)
butt_end_length = 20;    //Length of wedge (mm)
butt_end_width = 50;     //Width of wedge (mm)
butt_end_lip_thickness = 2; //Lip thickness (mm)
butt_end_lip_protrusion = 2; //How far off the block the lip protrudes (mm)

neck_end_angle = 45;     //Angle of wedge (deg)
neck_end_length = 20;    //Length of wedge (mm)
neck_end_width = 50;     //Width of wedge (mm)
neck_end_lip_thickness = 2; //Lip thickness (mm)
neck_end_lip_protrusion =2; //How far off the block the lip protrudes (mm)

wedge_separation = 50;  //Separation between neck and butt wedges (mm)

letter_size = ((butt_end_distance + neck_end_distance)/2)*.666; //Fit text within blocks based on distances
letter_height = 5;  //2x How far the letters are extruded (mm)
font = "Liberation Sans";

$fn=50;

module letter(l) {
  // Use linear_extrude() to make the letters 3D objects as they
  // are only 2D shapes when only using text()
  linear_extrude(height = letter_height) {
    text(l, size = letter_size, font = font, halign = "center", valign = "center", $fn = 16);
  }
}

//Butt end wedge
translate([((wedge_separation/2)*-1),0,0]){
    union(){
        minkowski(){    //Main body
            cube([butt_end_distance, butt_end_width, butt_end_length], center=true);
            cylinder(r=2,h=1);
        }
        translate([0, 0, (butt_end_length / 2 - letter_height / 2)]) rotate([0, 0, 90]) letter("Butt");
    }
}
translate([(((wedge_separation/2)-butt_end_lip_protrusion)*-1),0,(((butt_end_length/2) - (butt_end_lip_thickness/2)) * -1)]){
    minkowski(){    //Lip
        cube([(butt_end_distance + butt_end_lip_protrusion), butt_end_width, butt_end_lip_thickness], center=true);
        cylinder(r=2,h=1);
    }
}

//Neck end wedge
translate([((wedge_separation/2)),0,0]){
     union(){
        minkowski(){    //Main body
            cube([neck_end_distance, neck_end_width, neck_end_length], center=true);
            cylinder(r=2,h=1);
        }
        translate([0, 0, (butt_end_length / 2 - letter_height / 2)]) rotate([0, 0, 90]) letter("Neck");
    }
}
translate([((wedge_separation/2) - neck_end_lip_protrusion),0,(((neck_end_length/2) - (neck_end_lip_thickness/2)) * -1)]){
    minkowski(){    //Lip
        cube([(neck_end_distance + neck_end_lip_protrusion), neck_end_width, neck_end_lip_thickness], center=true);
        cylinder(r=2,h=1);
    }
}
