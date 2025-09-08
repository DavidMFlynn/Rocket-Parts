// **************************************************
// Project: Mid-Sized Launch Pad
// Filename: LaunchPad.scad
// Revision: 0.9.0   9/1/2025
// Created: 9/1/2025
// Units: mm
// **************************************************
//  ***** Notes *****
//
//
//  ***** History *****
// 0.9.0   9/1/2025   First Code.
//
// **************************************************
//  ***** for STL output *****
//
// Foot(Len=30, Angle=Leg_a);
// TriPod(nLegs=3, Len=80, Angle=Leg_a);
// rotate([90,0,0]) TiltBack(Post_h=70, HasNutHole=true, HasSetScrew=true);
// rotate([180,0,0]) BlastDeflectorMount();
//
// **************************************************
include<CommonStuffSAEmm.scad>

Overlap=0.05;
$fn=$preview? 36:90;
IDXtra=0.2;

Rail_XY=20;
Leg_a=45;

module RailSleeve(Wall_t=4, Len=30){
	difference(){
		RoundRect(X=Rail_XY+IDXtra*3+Wall_t*2, Y=Rail_XY+IDXtra*2+Wall_t*2, Z=Len, R=0.2+Wall_t);
		
		translate([0,0,-Overlap]) RoundRect(X=Rail_XY+IDXtra*3, Y=Rail_XY+IDXtra*2, Z=Len+Overlap*2, R=0.2);
	} // difference
} // RailSleeve

// RailSleeve(Wall_t=4, Len=30);

module Foot(Len=30, Angle=Leg_a){
	Base_Z=-8;
	BaseOffset_X=8;
	BaseSize_X=50;
	
	rotate([0,-Angle,0]) translate([Base_Z,0,0]) rotate([0,Angle,0]) 
	translate([BaseOffset_X,0,0]) RoundRect(X=BaseSize_X, Y=40, Z=5, R=5);
	//cube([50,40,5]);
	
	difference(){
		rotate([0,-Angle,0]) translate([0,0,Len+10]) rotate([180,0,0]) difference(){
			RailSleeve(Wall_t=4, Len=Len*2);
			translate([15,0,Len/2]) rotate([0,90,0]) Bolt10ClearHole();
		}
		
		rotate([0,-Angle,0]) translate([Base_Z,20,0]) rotate([0,Angle,0]) translate([-BaseSize_X/2+10,0,5]) rotate([180,0,0]) cube([100,40,50]);
	} // difference
	
} // Foot

// Foot(Len=30, Angle=Leg_a);

module TriPod(nLegs=3, Len=60, Angle=Leg_a){
	Rod_d=9.5;
	TiltBack_Len=74;
		
	/*
	// gussets
	for (j=[0:nLegs-1]) hull(){
		rotate([0,0,360/nLegs*j]) rotate([0,-Angle,0]) translate([11,12,0]) rotate([180,0,0]) cylinder(d=3, h=Len);
		rotate([0,0,360/nLegs*(j+1)]) rotate([0,-Angle,0]) translate([11,-12,0]) rotate([180,0,0]) cylinder(d=3, h=Len);
		}
	/**/
	
	difference(){
		union(){
			//translate([0,0,-40]) rotate([0,0,30]) cylinder(d=40, h=65, $fn=6);
			
			translate([0,0,-TiltBack_Len+11]) rotate([0,0,30]) TiltBack(Post_h=TiltBack_Len, HasNutHole=false, HasSetScrew=false);
			
			// leg sockets
			for (j=[0:nLegs-1]) rotate([0,0,360/nLegs*j])
				rotate([0,-Angle,0]) rotate([180,0,0]) RailSleeve(Wall_t=4, Len=Len);
			
			// gussets
			for (j=[0:nLegs-1]) rotate([0,0,360/nLegs*j]) 
				hull(){
					rotate([0,-Angle,0]) translate([-13,0,-Len]) cylinder(d=3, h=Len/2);
					translate([11,0,-Len]) cylinder(d=3, h=Len/2);
					}
		} // union
		
		// flatted base
		translate([0,0,-TiltBack_Len+11]) rotate([180,0,0]) cylinder(d=200, h=100);
		//translate([0,0,-40-Overlap]) cylinder(d=Rod_d+IDXtra, h=Len+20+Overlap*2);
		
		// Set Screw
		//translate([0,0,15]) rotate([0,90,0]) Bolt10Hole(depth=30);
	} // difference
} // TriPod

// TriPod(nLegs=3, Len=80, Angle=Leg_a);

module TiltBack(Post_h=40, HasNutHole=false, HasSetScrew=false){
	Hex_d=40;
	Rod_d=9.5;
	
	Pivot_d=42;
	Pivot_X=-25;
	PivotLock_X=10;
	Pivot_Z=Post_h+0.2+Pivot_d/2;
	Pivot_t=50;

	difference(){
		union(){
			cylinder(d=Hex_d, h=Post_h, $fn=6);
			
			hull(){
				translate([0,0,Post_h+0.2-10]) difference(){
					cylinder(d=Hex_d, h=Overlap, $fn=6);
					translate([-Hex_d/2-Overlap,0,-Overlap]) cube([Hex_d+Overlap*2,Hex_d/2+Overlap,Overlap*3]);
				} // difference
				
				translate([Pivot_X,0,Pivot_Z]) rotate([90,0,0]) cylinder(d=Pivot_d, h=Pivot_t/2);
				translate([PivotLock_X,0,Pivot_Z]) rotate([90,0,0]) cylinder(d=Pivot_d, h=Pivot_t/2);
			} // hull
		} // union
	
		
		translate([Pivot_X,0,Pivot_Z]) rotate([90,0,0]) cylinder(d=Rod_d, h=Pivot_t+1, center=true);
		translate([PivotLock_X,0,Pivot_Z]) rotate([90,0,0]) cylinder(d=Rod_d, h=Pivot_t+1, center=true);
		translate([0,0,-Overlap]) cylinder(d=Rod_d, h=Post_h+Overlap*2);
		
		// Set Screw
		if (HasSetScrew)
		translate([0,0,15]) rotate([0,90,30]) Bolt10Hole(depth=Hex_d);
		
		if (HasNutHole)
		translate([Pivot_X,-Pivot_t/2+8,Pivot_Z]) rotate([90,0,0]) Bolt375NutHole(depth=9);
	} // difference
} // TiltBack

// TiltBack(Post_h=70, HasNutHole=true, HasSetScrew=true);

module BlastDeflectorMount(Post_h=40){
	Hex_d=40;
	Mount_d=Hex_d+10;
	Rod_d=9.5;
	
	module ScrewBoss(X=40,Y=50){
		translate([-Mount_d/2,0,Post_h+5])  
			difference(){
				union(){
					hull(){
						rotate([0,-45,0]) translate([-X,Y,-10]) cylinder(d=10, h=10);
						translate([10,0,-15]) cylinder(d=10, h=10);
					} // hull
					
					hull(){
						rotate([0,-45,0]) translate([-X,Y,-10]) cylinder(d=10, h=10);
						translate([10,0,-45]) cylinder(d=10, h=10);
					} // hull
				} // union
				
				rotate([0,-45,0]) translate([-X,Y,0]) Bolt6Hole();
			} // difference
	} // ScrewBoss
	
	
	difference(){
		union(){
			cylinder(d=Mount_d, h=Post_h+5, $fn=6);
			
			ScrewBoss(X=50,Y=50);
			ScrewBoss(X=50,Y=-50);
			ScrewBoss(X=8,Y=50);
			ScrewBoss(X=8,Y=-50);
			
		} // union
		
		translate([0,0,-20]) cylinder(d=Hex_d+IDXtra*4, h=Post_h+20, $fn=6);
		cylinder(d=Rod_d+IDXtra*2, h=Post_h+20);
	} // difference

	// Steel Plate
	if ($preview) translate([-100,0,-30]) rotate([0,-45,0]) color("Red") RoundRect(X=12*25.4, Y=8*25.4, Z=1.5, R=1);
} // BlastDeflectorMount

// BlastDeflectorMount();






















