


include<CommonStuffSAEmm.scad>


$fn=$preview? 36:90;
IDXtra=0.2;
Overlap=0.05;



module Shock(ShowCompressed=false){
	Len=120;
	LenCompressed=80;
	End_Z=ShowCompressed? LenCompressed:Len;
	
	difference(){
		hull(){
			rotate([90,0,0]) cylinder(d=9, h=4, center=true);
			translate([0,0,-12]) rotate([90,0,0]) cylinder(d=9, h=4, center=true);
		} // hull
		
		rotate([90,0,0]) cylinder(d=3, h=4+Overlap*2, center=true);
	} // difference
	
	translate([0,0,-End_Z]) 
		difference(){
			hull(){
				rotate([90,0,0]) cylinder(d=9, h=3.5, center=true);
				translate([0,0,12]) rotate([90,0,0]) cylinder(d=9, h=3.5, center=true);
			} // hull
			
			rotate([90,0,0]) cylinder(d=3, h=3.5+Overlap*2, center=true);
		} // difference
			
			
	translate([0,0,-End_Z+12]) cylinder(d=18, h=End_Z-17);
} // Shock

// Shock(ShowCompressed=false);
// Shock(ShowCompressed=true);

module LegFrame(){
	ShockPivot_X=100;
	Root_w=50;
	Shock_w=6;
	Foot_w=6;
	Foot_X=135;
	
	difference(){
		union(){
			// root
			difference(){
				rotate([90,0,0]) cylinder(d=9, h=Root_w+6, center=true);
				rotate([90,0,0]) cylinder(d=9+Overlap, h=Root_w, center=true);
			} // difference
			
			// Shock
			translate([ShockPivot_X,0,0])
			difference(){
				rotate([90,0,0]) cylinder(d=9, h=Shock_w+6, center=true);
				rotate([90,0,0]) cylinder(d=9+Overlap, h=Shock_w, center=true);
			} // difference
			
			// Foot
			translate([Foot_X,0,0])
			difference(){
				rotate([90,0,0]) cylinder(d=9, h=Foot_w+6, center=true);
				rotate([90,0,0]) cylinder(d=9+Overlap, h=Foot_w, center=true);
			} // difference
			
			// connect shock to foot
			translate([ShockPivot_X,-Shock_w/2-3,-4.5]) cube([Foot_X-ShockPivot_X, 2, 6]);
			translate([ShockPivot_X,Shock_w/2+1,-4.5]) cube([Foot_X-ShockPivot_X, 2, 6]);
			translate([ShockPivot_X+6,-Shock_w/2-2,-4.5]) cube([Foot_X-ShockPivot_X-12,Shock_w+4,2]);
			
			// connect shock to root
			hull(){
				translate([0,-Root_w/2-3,-4.5]) cube([Overlap, 2, 6]);
				translate([ShockPivot_X+8,-Shock_w/2-3,-4.5]) cube([Overlap, 2, 6]);
			} // hull
			
			hull(){
				translate([0,Root_w/2+1,-4.5]) cube([Overlap, 2, 6]);
				translate([ShockPivot_X+8,Shock_w/2+1,-4.5]) cube([Overlap, 2, 6]);
			} // hull

		} // union
		
		// root Bolts
		rotate([90,0,0]) cylinder(d=3, h=Root_w+6+Overlap, center=true);
		
		// shock bolt
		translate([ShockPivot_X,0,0]) rotate([90,0,0]) cylinder(d=3, h=Shock_w+6+6, center=true);
		
		// foot bolt
		translate([Foot_X,0,0]) rotate([90,0,0]) cylinder(d=3, h=Foot_w+6+Overlap, center=true);
	} // difference

} // LegFrame

// LegFrame();

// work
/*
//rotate([0,-90,0])
//rotate([0,88,0]){
	rotate([0,-88,0]) LegFrame();
	translate([0,0,20]) rotate([0,-177.5,0]) color("Red") Shock(ShowCompressed=true);
//}
/**/

// Extended
/*
rotate([0,36,0]) LegFrame();
translate([0,0,30]) rotate([0,-42.5,0]) color("Red") Shock(ShowCompressed=false);

// Stowed
rotate([0,-88,0]) LegFrame();
translate([0,0,20]) rotate([0,-177.5,0]) color("Red") Shock(ShowCompressed=true);
/**/

module TestFrame(){
	Root_w=50;
	Shock_w=6;
	ShockLow_Z=20;
	ShockHigh_Z=30;
	
	difference(){
		union(){
			// root
			difference(){
				rotate([90,0,0]) cylinder(d=9, h=Root_w, center=true);
				
				rotate([90,0,0]) cylinder(d=9+Overlap, h=Root_w-10, center=true);
			} // difference

			// Base Plate
			translate([-18,0,-6]) RoundRect(X=50,Y=Root_w,Z=6,R=3);
			
			// back Plate
			translate([-10,0,-6]) RoundRect(X=10,Y=24,Z=40,R=2);
		} // union
		
		// Slide way
		translate([-4,0,20]){
			translate([-5,0,0]) cube([3.5,16.5,30], center=true);
			translate([0,0,0]) cube([10,12.5,30], center=true);
		}
		
		// Shock clearance
		translate([0,0,20]) cylinder(d=18,h=30);
		
		// root Bolts
		rotate([90,0,0]) cylinder(d=3, h=Root_w+6+Overlap, center=true);

	} // difference
	
} // TestFrame

// TestFrame();

module Slider(){
	translate([-5,-8,0]) cube([20,16,3]);
	translate([-5,-6,0]) cube([20,12,6]);
	
	difference(){
		hull(){
			translate([0,0,10]) rotate([90,0,0]) cylinder(d=9, h=12, center=true);
			translate([0,0,5]) cube([10,12,Overlap], center=true);
		} // hull
		
		hull(){
		translate([-5,0,10]) rotate([90,0,0]) cylinder(d=10, h=6, center=true);
		translate([5,0,10]) rotate([90,0,0]) cylinder(d=10, h=6, center=true);
		}
		translate([0,0,10]) rotate([90,0,0]) cylinder(d=3, h=12+Overlap*2, center=true);
	} // difference
} // Slider

// Slider();

module Foot(){
	Foot_h=4;
	
	difference(){
		union(){
			hull(){
				rotate([90,0,0]) cylinder(d=9, h=5, center=true);
				translate([0,0,-Foot_h-2]) cube([12,5,Overlap], center=true);
			} // hull
			
			difference(){
				hull(){
					translate([0,0,-Foot_h-2]) cube([30,15,2],center=true);
					translate([0,0,-Foot_h+1]) cube([36,21,1],center=true);
				} // hull
				
				translate([0,0,2])
				hull(){
					translate([0,0,-Foot_h-2]) cube([28,13,2],center=true);
					translate([0,0,-Foot_h+1]) cube([34,19,1],center=true);
				} // hull
			} // difference
		} // union
		
		rotate([90,0,0]) cylinder(d=3, h=6, center=true);
	} // difference

} // Foot

// Foot();

// rotate([0,36,0]) translate([135,0,0]) rotate([0,-36,0]) Foot();

























