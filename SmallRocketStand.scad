// ************************************
// Project: 3D Printed Rocket
// Filename: SmallRocketStand.scad
// by David M. Flynn
// Created: 6/15/2023 
// Revision: 1.1  8/27/2023
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  Rocket Stand originally part of Rocket_Loc_Graduator.scad
//
// Hardware:
// #8-32 x 1/4" Button Head Cap Screw (6 Req.)
// 1/2" Aluminum Tubing x 10 to 12 inches
//
//  ***** History *****
// 1.1    8/27/2023  Copied SpoolBushing() to here.
// 1.0.1  6/29/2023  38mm bushing
// 1.0.0  6/15/2023  First code.
//
// ***********************************
//  ***** for STL output *****
//
// SpoolBushing(H=75, Pipe_OD=Pipe15_OD); // Adaptor to use 1-1/2" PVC pipe and a 2.5kg spool as a stand.
// SpoolBushing(H=45, Pipe_OD=Pipe10_OD); // Adaptor to use 1" PVC pipe and a 2.5kg spool as a stand.
//
// RocketStandLeg(); // print 3
// RocketStandBase(); // print 2
// RocketStandBushing(OD=28.5); // print 2 to 4 as needed
// RocketStandBushing(OD=37); // for 38mm motor tube
//
// ***********************************
//  ***** for Viewing *****
//
// ShowRocketStand();
//
// ***********************************

use<SpringThingBooster.scad>
include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

// Rocket Stand parameters
LegRoot_h=40;
nLegs=3;
Base_d=100;
Leg_W=20;
LegLen=150;
Base_t=6;

module ShowRocketStand(){
	for (j=[0:3]) translate([0,0,LegRoot_h+40+25*j]) RocketStand29mmBushing();
	RocketStandBase();
	translate([0,0,LegRoot_h+Base_t*2-4]) rotate([0,180,0]) RocketStandBase();
	for (j=[0:nLegs-1]) rotate([0,0,360/nLegs*j]) translate([-Leg_W/2,Base_d/2,-LegLen-1])
		rotate([0,0,90]) rotate([90,0,0]) RocketStandLeg();
		
	color("Silver") cylinder(d=12, h=165);
} // ShowRocketStand

//ShowRocketStand();

Pipe15_OD=48.3;
Pipe10_OD=33.3;

module SpoolBushing(H=75, Pipe_OD=Pipe15_OD){
	// Adaptor to use 1-1/2" PVC pipe and a 2.5kg spool as a stand.
	Spool_ID=52.8;
	Spool_OD=58;

	difference(){
		union(){
			cylinder(d=Spool_OD, h=3);
			cylinder(d1=Spool_ID, d2=Spool_ID-0.5, h=H+3);
		} // union

		translate([0,0,-Overlap]) cylinder(d=Pipe_OD+IDXtra*3, h=H+Overlap*2);
		translate([0,0,H]) cylinder(d1=Pipe_OD+IDXtra*2, d2=Pipe_OD-2, h=3+Overlap);
	} // difference

} // SpoolBushing

// SpoolBushing(H=75, Pipe_OD=Pipe15_OD);
// SpoolBushing(H=45, Pipe_OD=Pipe10_OD);

module RocketStandBushing(OD=28.5){
	ID=12.7;
	
	Wall_t=1.2;
	Trim=7;
	Stretch=4;
	
	difference(){
		hull(){
			translate([0,0,-Stretch/2]) sphere(d=OD);
			translate([0,0,Stretch/2]) sphere(d=OD);
		} // hull
		
		hull(){
			translate([0,0,-Stretch/2]) sphere(d=OD-Wall_t*2);
			translate([0,0,Stretch/2]) sphere(d=OD-Wall_t*2);
		} // hull
		
		translate([0,0,OD/2+Stretch/2-Trim]) cylinder(d=OD+1, h=Trim+1);
		translate([0,0,-OD/2-Stretch/2-1]) cylinder(d=OD+1, h=Trim+1);
	} // difference
	
	difference(){
		union(){
			translate([0,0,-OD/2-Stretch/2+Trim]) cylinder(d=ID+Wall_t*2, h=OD+Stretch-Trim*2);
			
			hull(){
				translate([0,0,-Stretch/2]) rotate([90,0,0]) cylinder(d=OD-1, h=Wall_t, center=true);
				translate([0,0,Stretch/2]) rotate([90,0,0]) cylinder(d=OD-1, h=Wall_t, center=true);
			} // hull
			hull(){
				translate([0,0,-Stretch/2]) rotate([0,90,0]) cylinder(d=OD-1, h=Wall_t, center=true);
				translate([0,0,Stretch/2]) rotate([0,90,0]) cylinder(d=OD-1, h=Wall_t, center=true);
			} // hull
		} // union
		
		translate([0,0,OD/2+Stretch/2-Trim]) cylinder(d=OD+1, h=Trim+1);
		translate([0,0,-OD/2-Stretch/2-1]) cylinder(d=OD+1, h=Trim+1);
		translate([0,0,-OD/2-Stretch/2+Trim-Overlap]) cylinder(d=ID, h=OD+Stretch-Trim*2+Overlap*2);
	} // difference
} // RocketStandBushing

//RocketStandBushing(OD=37);

module RocketStandBase(){
	
	
	difference(){
		union(){
			//cylinder(d=Base_d+Leg_W,h=Base_t);
			hull() for (j=[0:nLegs-1]) rotate([0,0,360/nLegs*j]) translate([0,Base_d/2+Leg_W/4,0]){
				translate([-Leg_W/2,0,0]) cylinder(d=Leg_W/2, h=Base_t);
				translate([Leg_W/2,0,0]) cylinder(d=Leg_W/2, h=Base_t);
			}
			translate([0,0,Base_t-Overlap]) cylinder(d1=30, d2=20, h=10);
		} // union
		
		for (j=[0:nLegs-1]) rotate([0,0,360/nLegs*j]) translate([0,Base_d/2,Base_t-2]){
			Bolt8ClearHole();
			hull(){
				cylinder(d=Leg_W+IDXtra*2, h=3);
				translate([0,Leg_W,0]) cylinder(d=Leg_W+IDXtra*2, h=3);
			} // hull
		}
		translate([0,0,-Overlap]) cylinder(d=12.7, h=20);
	} // difference
} // RocketStandBase

//RocketStandBase();

module RocketStandLeg(){
	Leg_Lift=30;
	Wall_t=1.8; //2.4; too thick
	Multi=1.3;
	Multi_B=2.4;
	
	difference(){
		union(){
			intersection(){
				union(){
					difference(){
						cylinder(r=LegLen*Multi, h=Leg_W, $fn=$preview? 90:360);
						translate([0,0,-Overlap]) 
							cylinder(r=LegLen*Multi-Wall_t, h=Leg_W+Overlap*2, $fn=$preview? 90:360);
					} // difference
					
					translate([0,LegLen*Multi-LegLen*Multi_B-LegRoot_h,0])
					difference(){
						cylinder(r=LegLen*Multi_B+Wall_t, h=Leg_W, $fn=$preview? 90:360);
						translate([0,0,-Overlap]) 
							cylinder(r=LegLen*Multi_B, h=Leg_W+Overlap*2, $fn=$preview? 90:360);
					} // difference
					
					hull(){
						translate([0,LegLen*Multi-LegRoot_h,0]) cylinder(d=2.4, h=Leg_W);
						translate([50,LegLen*Multi-LegRoot_h+50,0]) cylinder(d=2.4, h=Leg_W);
					} // hull
					
					translate([80,-10,0])
					mirror([1,0,0])
					hull(){
						translate([0,LegLen*Multi-LegRoot_h,0]) cylinder(d=2.4, h=Leg_W);
						translate([50,LegLen*Multi-LegRoot_h+50,0]) cylinder(d=2.4, h=Leg_W);
					} // hull
					
					translate([80,-10,0])
					hull(){
						translate([0,LegLen*Multi-LegRoot_h,0]) cylinder(d=2.4, h=Leg_W);
						translate([50,LegLen*Multi-LegRoot_h+50,0]) cylinder(d=2.4, h=Leg_W);
					} // hull
					
				} // union
				
				difference(){
					cylinder(r=LegLen*Multi, h=Leg_W, $fn=$preview? 90:360);
					translate([0,LegLen*Multi-LegLen*Multi_B-LegRoot_h,-Overlap])
						cylinder(r=LegLen*Multi_B, h=Leg_W+Overlap*2, $fn=$preview? 90:360);
				} // difference
				
				translate([0,LegLen*Multi-LegRoot_h-Leg_Lift,0]) cube([LegLen,LegLen*Multi+1,Leg_W]);
			} // intersection
			
			hull(){
				translate([LegLen,LegLen*Multi-LegRoot_h-Leg_Lift,0]) cylinder(d=8, h=Leg_W);
				translate([LegLen-10,LegLen*Multi-LegRoot_h-Leg_Lift,0]) cylinder(d=8, h=Leg_W);
			} // hull
			
			translate([0,LegLen*Multi-LegRoot_h,Leg_W/2]) rotate([-90,0,0]) cylinder(d=Leg_W, h=LegRoot_h);
		} // union
		
		translate([0,LegLen*Multi,Leg_W/2]) rotate([-90,0,0]) Bolt8Hole(depth=LegRoot_h);
	} // difference
} // RocketStandLeg

//RocketStandLeg();









