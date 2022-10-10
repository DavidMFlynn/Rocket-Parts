// ***********************************
// Project: 3D Printed Rocket
// Filename: StagerLib.scad
// by David M. Flynn
// Created: 10/10/2022 
// Revision: 0.9.0  10/10/2022
// Units: mm
// ***********************************
//  ***** Notes *****
//
// A work-in-progress. 
//
// Bearing MR84-2RS
// Undersize 4mm x 10mm steel dowel, 2ea
// Undersize 4mm x 12mm steel dowel
//
//  ***** History *****
//
echo("StagerLib 0.9.0");
// 0.9.0  10/10/2022   First code.
//
// ***********************************
//  ***** for STL output *****
// 
// BearingBlock();
// rotate([-90,0,0]) BC_LockRod();
//
// ***********************************
//  ***** Routines *****
//
// BC_Cup(Tube_OD=102.21, ID=78, nLocks=2);
// BC_Saucer(Tube_OD=102.21, ID=74, nLocks=2);
//
// ***********************************
//  ***** for Viewing *****
//
//
// ***********************************

include<CablePuller.scad>
//include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2; // Add to ID for tight fit, x2 for loose fit
$fn=$preview? 24:90;

// Heavy spring
Stager_Spring_OD=5/16*25.4;
Stager_Spring_FL=1.25*25.4;
Stager_Spring_CBL=0.7*25.4;


// ***********************************************************************************
//  ***** Booster Clamp *****

module BearingBlock(){
	Arm_Len=10;
	
	difference(){
		hull(){
			cylinder(d=CP_Bearing_OD-1, h=CP_Bearing_H+5, center=true);
			translate([-Arm_Len,0,0]) cylinder(d=CP_Bearing_OD-1, h=CP_Bearing_H+5, center=true);
		} // hull
		
		cylinder(d=CP_Bearing_ID+IDXtra, h=CP_Bearing_H+6, center=true);
		translate([-Arm_Len,0,0]) cylinder(d=CP_Bearing_ID+IDXtra, h=CP_Bearing_H+6, center=true);
	
		
		cylinder(d=CP_Bearing_OD+1.6, h=CP_Bearing_H+1, center=true);
		translate([-Arm_Len,0,0]) cylinder(d=CP_Bearing_OD+1.6, h=CP_Bearing_H+1, center=true);
	} // difference
	
	
} // BearingBlock

//BearingBlock();

module BC_LockRod(){
	LR_X=10;
	LR_Y=5;
	LR_Z=36;
	
	difference(){
		RoundRect(X=LR_X, Y=LR_Y, Z=LR_Z, R=1);
		
		translate([0,-LR_Y/2,LR_Z-5]) rotate([90,0,0]) Bolt6ButtonHeadHole();
		translate([0,-LR_Y/2,LR_Z-5-8]) rotate([90,0,0]) Bolt6ButtonHeadHole();
		
		translate([-CP_Bearing_OD/2-LR_X/2+2, 0, CP_Bearing_OD/2+2])
			rotate([90,0,0]) cylinder(d=CP_Bearing_OD, h=LR_Y+Overlap*2, center=true);
		translate([CP_Bearing_OD/2+LR_X/2-2, 0, CP_Bearing_OD/2+2])
			rotate([90,0,0]) cylinder(d=CP_Bearing_OD, h=LR_Y+Overlap*2, center=true);
	} // difference
	
} // BC_LockRod

//BC_LockRod();

module BC_Cup(Tube_OD=102.21, ID=78, nLocks=2){
	Len=3;
	LR_X=10;
	LR_Y=5;
	LR_Z=30;
	
	
	difference(){
		union(){
			cylinder(d=Tube_OD, h=Len, $fn=$preview? 90:360);
			translate([0,0,-2]) cylinder(d1=Tube_OD-8, d2=Tube_OD-4, h=2+Overlap, $fn=$preview? 90:360);
		} // union
		
		// center hole
		translate([0,0,-2-Overlap]) cylinder(d=ID, h=Len+2+Overlap*2, $fn=$preview? 90:360);
		
		for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]) translate([0,Tube_OD/2-LR_Y/2-6.5,-2-Overlap])
			RoundRect(X=LR_X+IDXtra*2, Y=LR_Y+IDXtra*2, Z=LR_Z, R=1);
	} // difference
	
	if ($preview)
		for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]) translate([0, Tube_OD/2-LR_Y/2-6.5,-16])
				color("Orange") BC_LockRod();
} // BC_Cup

//translate([0,0,Overlap]) BC_Cup();

module BC_Saucer(Tube_OD=102.21, ID=74, nLocks=2){
	Len=6;
	
	LR_X=10;
	LR_Y=5;
	LR_Z=30;
	
	Arm_Len=10;
	Disengage_a=25;
	
	module ShowBearing(){
		rotate([90,0,0]) color("Red") cylinder(d=CP_Bearing_OD, h=CP_Bearing_H, center=true);
	} // ShowBearing
	
	module BackStop(){
		Block_W=16;
		hull(){
				cube([10,Block_W,CP_Bearing_OD/2+1]);
				translate([-2, 0, -2-Overlap]) cube([10, Block_W, Overlap]);
			} // hull
			translate([-2, 0, -2-CP_Bearing_OD-Overlap]) cube([10, Block_W, CP_Bearing_OD+Overlap]);
			translate([-2, 0, -2-CP_Bearing_OD-3-Overlap]) cube([20+CP_Bearing_OD, Block_W, 5+Overlap]);
			//*
			hull(){
				translate([22, 0, -2-CP_Bearing_OD-3-Overlap]) cube([CP_Bearing_OD/2+LR_X, Block_W, 5+4+Overlap]);
				translate([15, 0, -2-CP_Bearing_OD-3-Overlap]) cube([CP_Bearing_OD+LR_X, Block_W, 5+Overlap]);
			}
			/**/
			// Base
			translate([-2, 0, -15]) cube([36, Block_W, 5+Overlap]);
	} // BackStop
	
	module BC_LockRod_Holes(){
		for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]) translate([0,Tube_OD/2-LR_Y/2-6.5, -Len-12-Overlap]){
			// BC_LockRod
			RoundRect(X=LR_X+IDXtra*2, Y=LR_Y+IDXtra*2, Z=LR_Z+12, R=1+IDXtra);
			
			// Spring
			translate([0,0,-Stager_Spring_CBL]) cylinder(d=Stager_Spring_OD+IDXtra*3, h=Stager_Spring_FL);
		}
	} // BC_LockRod_Holes
	
	// The Cup
	difference(){
		translate([0,0,-Len]) cylinder(d=Tube_OD, h=Len, $fn=$preview? 90:360);
		
		translate([0,0,-2]) cylinder(d1=Tube_OD-8-IDXtra, d2=Tube_OD-4-IDXtra, h=2+Overlap, $fn=$preview? 90:360);
		
		translate([0,0,-Len-Overlap]) cylinder(d=ID, h=Len, $fn=$preview? 90:360);
		
		BC_LockRod_Holes();
	} // difference
	
	// The Tube
	//*
	difference(){
		translate([0,0,-Len-20]) cylinder(d=Tube_OD, h=20, $fn=$preview? 90:360);
		translate([0,0,-Len-20-Overlap]) cylinder(d=Tube_OD-4.0, h=20+Overlap*2, $fn=$preview? 90:360);
	}
	/**/
	
	difference(){
		for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]) {
			translate([LR_X/2-2+CP_Bearing_OD+10+Arm_Len, Tube_OD/2-LR_Y/2-12, -Len-CP_Bearing_OD/2-1+Overlap]) 
				mirror([1,0,0]) BackStop();
			
			translate([-LR_X/2+2-CP_Bearing_OD-Arm_Len-10, Tube_OD/2-LR_Y/2-12, -Len-CP_Bearing_OD/2-1+Overlap])
			  BackStop();
		} // for
		
		
		BC_LockRod_Holes();
		
		// center hole
		translate([0,0,-Len-20-Overlap]) cylinder(d=ID, h=Len+20+Overlap*2, $fn=$preview? 90:360);
		
		difference(){
			translate([0,0,-50]) cylinder(d=Tube_OD+40, h=50);
			translate([0,0,-50-Overlap]) cylinder(d=Tube_OD, h=50+Overlap*2);
		} // difference
	} // difference
	
	if ($preview)
		for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]) translate([0,Tube_OD/2-LR_Y/2-6.5,-Len-CP_Bearing_OD/2]){
			
			translate([-LR_X/2-CP_Bearing_OD/2+2-Overlap,0,0]){ 
				ShowBearing();
				rotate([90,0,0]) color("Green") BearingBlock();
				translate([-Arm_Len,0,0]) ShowBearing();
				
			}
			translate([LR_X/2+CP_Bearing_OD/2+Overlap,0,0]) {
				ShowBearing();
				
				rotate([0,Disengage_a,0]) translate([Arm_Len,0,0]){
					ShowBearing();
					rotate([90,0,0]) color("Green") BearingBlock();}
			}
			
			
		}
} // BC_Saucer

//BC_Saucer();

