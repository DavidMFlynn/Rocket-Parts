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

Stager_LockRod_X=10;
Stager_LockRod_Y=5;
Stager_LockRod_Z=36;
Stager_LockRod_R=1;

LooseFit=0.8;
StagerLockInset_Y=12.5;
StagerLockArmLen=10;

// ***********************************************************************************
//  ***** Booster Clamp *****

module BearingBlock(){
	Arm_Len=StagerLockArmLen;
	
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

module Stager_LockRod(){
	LR_X=Stager_LockRod_X;
	LR_Y=Stager_LockRod_Y;
	LR_Z=Stager_LockRod_Z;
	
	difference(){
		RoundRect(X=LR_X, Y=LR_Y, Z=LR_Z, R=Stager_LockRod_R);
		
		translate([0,-LR_Y/2,LR_Z-5]) rotate([90,0,0]) Bolt6ButtonHeadHole();
		translate([0,-LR_Y/2,LR_Z-5-8]) rotate([90,0,0]) Bolt6ButtonHeadHole();
		
		translate([-CP_Bearing_OD/2-LR_X/2+2, 0, CP_Bearing_OD/2+2])
			rotate([90,0,0]) cylinder(d=CP_Bearing_OD, h=LR_Y+Overlap*2, center=true);
		translate([CP_Bearing_OD/2+LR_X/2-2, 0, CP_Bearing_OD/2+2])
			rotate([90,0,0]) cylinder(d=CP_Bearing_OD, h=LR_Y+Overlap*2, center=true);
	} // difference
	
} // Stager_LockRod

//Stager_LockRod();

module BC_Cup(Tube_OD=102.21, ID=78, nLocks=2){
	Len=3;
	LR_X=Stager_LockRod_X;
	LR_Y=Stager_LockRod_Y;
	LR_Z=Stager_LockRod_Z;
	
	
	difference(){
		union(){
			cylinder(d=Tube_OD, h=Len, $fn=$preview? 90:360);
			translate([0,0,-2]) cylinder(d1=Tube_OD-8, d2=Tube_OD-4, h=2+Overlap, $fn=$preview? 90:360);
		} // union
		
		// center hole
		translate([0,0,-2-Overlap]) cylinder(d=ID, h=Len+2+Overlap*2, $fn=$preview? 90:360);
		
		Stager_LockRod_Holes(Tube_OD=Tube_OD, nLocks=nLocks);
		
		//for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]) translate([0,Tube_OD/2-LR_Y/2-6.5,-2-Overlap])
		//	RoundRect(X=LR_X+LooseFit, Y=LR_Y+LooseFit, Z=LR_Z, R=Stager_LockRod_R+LooseFit/2);
	} // difference
	
	if ($preview)
		for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]) translate([0, Tube_OD/2-StagerLockInset_Y,-16])
				color("Orange") Stager_LockRod();
} // BC_Cup

//translate([0,0,Overlap]) BC_Cup();

module Stager_Bearing(){
	// for viewing only
		rotate([90,0,0]) color("Red") cylinder(d=CP_Bearing_OD, h=CP_Bearing_H, center=true);
	} // Stager_Bearing
	
module Stager_SaucerBoltPattern(Tube_OD=102.21, ID=70, nLocks=2){
	Inset_Y=7.5;
	Bolt_a=37.5;
	
	for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]) {
		rotate([0,0,Bolt_a]) translate([0,Tube_OD/2-Inset_Y,0]) children();
		rotate([0,0,-Bolt_a]) translate([0,Tube_OD/2-Inset_Y,0]) children();
	}
} // Stager_SaucerBoltPattern

//Stager_SaucerBoltPattern() Bolt4ButtonHeadHole();

module Stager_LockRod_Holes(Tube_OD=102.21, nLocks=2){
	LR_X=Stager_LockRod_X;
	LR_Y=Stager_LockRod_Y;
	LR_Z=Stager_LockRod_Z;
	
	Saucer_H=6;
	
	for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]) 
		translate([0,Tube_OD/2-StagerLockInset_Y, -Saucer_H-12-Overlap]){
		
			// BC_LockRod
			RoundRect(X=LR_X+LooseFit, Y=LR_Y+LooseFit, Z=LR_Z+12, R=1+LooseFit/2);
		
			// Spring
			translate([0,0,-Stager_Spring_CBL]) cylinder(d=Stager_Spring_OD+LooseFit, h=Stager_Spring_FL);
	}
} // Stager_LockRod_Holes
	
module Stager_Saucer(Tube_OD=102.21, nLocks=2){
	Len=6;
	ID=Tube_OD-StagerLockInset_Y*2-Stager_LockRod_Y-4;
	LR_X=Stager_LockRod_X;
	LR_Y=Stager_LockRod_Y;
	LR_Z=Stager_LockRod_Z;
	
	
	// The Cup
	difference(){
		translate([0,0,-Len]) cylinder(d=Tube_OD, h=Len, $fn=$preview? 90:360);
		
		translate([0,0,-2]) cylinder(d1=Tube_OD-8-IDXtra, d2=Tube_OD-4-IDXtra, h=2+Overlap, $fn=$preview? 90:360);
		
		translate([0,0,-Len-Overlap]) cylinder(d=ID, h=Len, $fn=$preview? 90:360);
		
		translate([0,0,-2]) Stager_SaucerBoltPattern() Bolt4ButtonHeadHole();
		
		Stager_LockRod_Holes(Tube_OD=Tube_OD, nLocks=nLocks);
	} // difference
	
	
	
} // Stager_Saucer

//Stager_Saucer();

module Stager_Mech(Tube_OD=102.21, nLocks=2){
	Len=6;
	ID=Tube_OD-StagerLockInset_Y*2-Stager_LockRod_Y-4;
	LR_X=Stager_LockRod_X;
	LR_Y=Stager_LockRod_Y;
	LR_Z=Stager_LockRod_Z;
	
	Arm_Len=StagerLockArmLen;
	Disengage_a=25;

	
	module ShowBearing(){
		rotate([90,0,0]) color("Red") cylinder(d=CP_Bearing_OD, h=CP_Bearing_H, center=true);
	} // ShowBearing
	
	module BackStop(){
		Block_W=18;
		hull(){
			translate([0,-5,0]) cube([10,Block_W,CP_Bearing_OD/2+1]);
			translate([-2, -5, -2-Overlap]) cube([10, Block_W, Overlap]);
		} // hull
		
		translate([-2, -5, -2-CP_Bearing_OD-Overlap]) cube([10, Block_W, CP_Bearing_OD+Overlap]);
		translate([-2, -5, -2-CP_Bearing_OD-3-Overlap]) cube([20+CP_Bearing_OD, Block_W, 5+Overlap]);
			
		//*
		hull(){
			translate([22, -5, -2-CP_Bearing_OD-3-Overlap]) cube([CP_Bearing_OD/2+LR_X, Block_W, 5+4+Overlap]);
			translate([15, -5, -2-CP_Bearing_OD-3-Overlap]) cube([CP_Bearing_OD+LR_X, Block_W, 5+Overlap]);
		}
		/**/
		
		// Back Plate
		translate([5,10.5,-15]) cube([30,6,20]);
		
		// Base
		translate([-2, -5, -15]) cube([36, Block_W, 5+Overlap]);
	} // BackStop
	
	
	// The Tube
	//*
	difference(){
		translate([0,0,-Len-20]) cylinder(d=Tube_OD, h=20, $fn=$preview? 90:360);
		translate([0,0,-Len-20-Overlap]) cylinder(d=Tube_OD-4.0, h=20+Overlap*2, $fn=$preview? 90:360);
	}
	/**/
	
	difference(){
		for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]) {
			translate([LR_X/2-2+CP_Bearing_OD+10+Arm_Len, Tube_OD/2-StagerLockInset_Y-6, -Len-CP_Bearing_OD/2-1]) 
				mirror([1,0,0]) BackStop();
			
			translate([-LR_X/2+2-CP_Bearing_OD-Arm_Len-10, Tube_OD/2-StagerLockInset_Y-6, -Len-CP_Bearing_OD/2-1])
			  BackStop();
		} // for
		
		translate([0,0,-Len]) Stager_SaucerBoltPattern() Bolt4Hole();
		
		Stager_LockRod_Holes(Tube_OD=Tube_OD, nLocks=nLocks);
		
		// center hole
		translate([0,0,-Len-20-Overlap]) cylinder(d=ID, h=Len+20+Overlap*2, $fn=$preview? 90:360);
		
		difference(){
			translate([0,0,-50]) cylinder(d=Tube_OD+40, h=50);
			translate([0,0,-50-Overlap]) cylinder(d=Tube_OD, h=50+Overlap*2);
		} // difference
	} // difference
	
	if ($preview)
		for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]) 
			translate([0,Tube_OD/2-StagerLockInset_Y,-Len-CP_Bearing_OD/2]){
			
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
} // Stager_Mech

//Stager_Mech();

