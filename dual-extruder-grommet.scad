/*
 * Copyright 2014 Kenny Root.
 * Licensed under the BSD license. See LICENSE for more information.
 *
 * Grommet for the central hole on the RigidBot dual extruder plate.
 */

// Adjustable features.
lip_height = 0.8;
lip_overhang = 1.2;
wall_thickness = 0.6;

// measurements of the opening
opening_width=9.5;
opening_length=27.5;
opening_height=3.2;

// render settings
$fs = 0.2;
$fa = 4;

/*
 * Creates a rounded rectangle where the ends are half-circles.
 */
module roundrect(width, length, height) {
	assign(cube_length = length - width) {
		union() {
			cube([width, cube_length, height]);
			translate([width/2, 0, 0]) cylinder(d=width, h=height);
			translate([width/2, cube_length, 0]) cylinder(d=width, h=height);
		}
	}
}

difference() {
	// The things that exist
	union() {
		roundrect(opening_width, opening_length, opening_height+2*lip_height);
		for (a=[0, opening_height+lip_height]) {
			translate([-lip_overhang, 0, a])
				assign(lip=lip_overhang*2)
					roundrect(opening_width+lip, opening_length+lip, lip_height);
		}
	}

	// Things subtracted out.
	union() {
		translate([wall_thickness,0,-0.1])
			assign(wall=2*wall_thickness, lip=2*lip_height)
				roundrect(opening_width-wall, opening_length-wall, opening_height+lip+0.2);

		// A little notch so it can be fit into the hole.
		translate([-2, 9, -1]) cube([5, 1, 10]);
	}
}
