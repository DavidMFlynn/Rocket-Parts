// ***********************************
// Project: 3D Printed Rocket
// Filename: RacewayLib.scad
// by David M. Flynn
// Created: 10/26/2022 
// Revision: 0.9.0  10/26/2022
// Units: mm
// ***********************************
//  ***** Notes *****
//
// Used to create a wire path outside the airframe.
//
//  ***** History *****
// 0.9.0  10/26/2022 First code
//
// ***********************************
//  ***** for STL output *****
//
//
// ***********************************
//  ***** Routines *****
//
// Raceway_End(Tube_OD=102, Race_ID=6, Wall_t=2, Len=10); //External cover end
// Raceway_Exit(Tube_OD=102, Race_ID=6, Wall_t=2, Top_Len=10, Bottom_Len=20); // Hole thru wall
// Raceway_External(Tube_OD=102, Race_ID=6, Wall_t=2, Len=20); //External cover middle section
//
// ***********************************
//  ***** for Viewing *****
//
// ShowExternalRaceway();
//
// ***********************************

//include<TubesLib.scad>
//include<CableRelease.scad>
//include<BearingLib.scad>
//include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2; // Add to ID for tight fit, x2 for loose fit
$fn=$preview? 24:90;


module ShowExternalRaceway(){
	Raceway_End();
		

	translate([0,0,-20]) rotate([180,0,0])
	Raceway_End();
		
	rotate([0,0,20])
	difference(){
		translate([-2,0,0]) Raceway_Exit(Tube_OD=102, Race_ID=10, Wall_t=0, Top_Len=8, Bottom_Len=18);
		Raceway_Exit(Tube_OD=102, Race_ID=6, Wall_t=4, Top_Len=10, Bottom_Len=20);
	}
} // ShowExternalRaceway

// ShowExternalRaceway();

module Raceway_Exit(Tube_OD=102, Race_ID=6, Wall_t=2, Top_Len=10, Bottom_Len=20){
	ID=Race_ID;
	
	translate([Tube_OD/2-Wall_t/2,0,0]){
		// Top
		translate([-ID/2-Wall_t/2,0,(ID/2+Wall_t/2)*1.414-Overlap]) cylinder(d=ID, h=Top_Len);
		// Bottom
		translate([ID/2+Wall_t/2,0,-(ID/2+Wall_t/2)*1.414+Overlap]) 
			rotate([180,0,0]) cylinder(d=ID, h=Bottom_Len);
		
		translate([0,0,-(ID/2+Wall_t/2)*1.414]){
			
		// thru the wall
		translate([(ID/2+Wall_t/2)*0.707,0,(ID/2+Wall_t/2)*0.707])rotate([0,-45,0]) 
			translate([0,0,-Overlap]) cylinder(d=ID, h=ID+Wall_t+Overlap*2);
		
		// bottom/outside
		rotate([90,0,0])
		rotate_extrude(angle=45) translate([ID/2+Wall_t/2,0,0]) circle(d=ID);
		
		// top/inside
		rotate([90,0,0]) translate([0,(ID+Wall_t)*1.414,0]) rotate([180,180,0]) 
			rotate_extrude(angle=45) translate([ID/2+Wall_t/2,0,0]) circle(d=ID);
		}
	}
	
} // Raceway_Exit

//Raceway_Exit();

module Raceway_End(Tube_OD=102, Race_ID=6, Wall_t=2, Len=10){
	Race_Wall_t=1.2;
	ID=Race_ID;
	
	difference(){
		hull(){
			translate([Tube_OD/2-Wall_t/2,0,ID*1.4+Wall_t-Overlap]) cylinder(d=Wall_t, h=Overlap);
			
			translate([Tube_OD/2,0,-Len]) {
				translate([ID/2,0,0]) cylinder(d=ID+Race_Wall_t*2, h=Len);
				translate([-3,0,0]) cylinder(d=ID+Race_Wall_t*2+ID/2, h=Len);
			}
		} // hull
		
		translate([0,0,-Len-Overlap]) cylinder(d=Tube_OD-1, h=Len+ID*2+Wall_t+Overlap*2);
		Raceway_Exit(Tube_OD=Tube_OD, Race_ID=ID, Wall_t=Wall_t, Top_Len=10, Bottom_Len=Len);
	} // difference
	
} // Raceway_End

//Raceway_End();

module Raceway_External(Tube_OD=102, Race_ID=6, Wall_t=2, Len=20){
	Race_Wall_t=1.2;
	ID=Race_ID;
	
	difference(){
		hull(){
			translate([Tube_OD/2+Wall_t/2,0,-Len/2]) {
				translate([(ID+Wall_t)/2,0,0]) cylinder(d=ID+Race_Wall_t*2, h=Len);
				translate([-3,0,0]) cylinder(d=ID+Race_Wall_t*2+ID/2, h=Len);
			}
		} // hull
		
		translate([0,0,-Len/2-Overlap]) cylinder(d=Tube_OD-1,h=Len+ID*2+Wall_t+Overlap*2);
		translate([Tube_OD/2-Wall_t/2+ID/2+Wall_t/2,0,0]) cylinder(d=ID, h=Len+Overlap*2, center=true);
	} // difference
	
} // Raceway_External

//Raceway_External();




















