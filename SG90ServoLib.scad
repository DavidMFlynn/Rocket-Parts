// **************************************************
// SG90 Servo Library
// David M. Flynn
// Filename: SG90ServoLib.scad
// Created: 4/28/2018
// Rev: 1.1.2 4/27/2023
// Units: millimeters
// **************************************************
// History:
	echo("SG90ServoLib 1.1.2");
// 1.1.2 4/27/2023 Extended Bolt2Hole depth to 16mm
// 1.1.1 2/27/2023 Added ServoSG90TopBlock()
// 1.1.0 8/17/2018 Added SG90ServoWheelBoltPattern and TopMount=false
// 1.0.1 5/1/2018 Adjusted SG90ServoWheel for better fit.
// 1.0 4/28/2018 Coppied from LightArmJoint 
// **************************************************
// Notes:
//  Mounting of R/C micro servo SG90.
//  ToDo: Servo wheel needs adjusting.
// **************************************************
// Routines
//  ServoSG90TopBlock(Xtra_Len=4, Xtra_Width=4, Xtra_Height=0);
//  ServoSG90(TopMount=false); // default
//  ServoSG90(TopMount=true);
//  SG90ServoWheelBoltPattern() Bolt2Hole();
//	SG90ServoWheel();
// **************************************************

include<CommonStuffSAEmm.scad>

IDXtra=0.2;
$fn=$preview? 24:90;
Overlap=0.05;

	kDeck_x=32.4;
	kDeck_z=2.5;
	kWheel_z=14.2;
	kWheelOffset=5; // body CL to wheel CL
	kBoltCl=28.2;
	kWidth=12.4;
	
	kBody_h=16;
	kBody_l=23;
	
	kTopBox_h=4.5;

	
module ServoSG90TopBlock(Xtra_Len=4, Xtra_Width=4, Xtra_Height=0){
	difference(){
		translate([kWheelOffset-kDeck_x/2-Xtra_Len/2, -kWidth/2-Xtra_Width/2, kDeck_z]) 
			cube([kDeck_x+Xtra_Len, kWidth+Xtra_Width, kDeck_z+Xtra_Height]);
			
		// top rectangle
		translate([kWheelOffset-kBody_l/2, -kWidth/2, kDeck_z-Overlap]) cube([kBody_l,kWidth,kTopBox_h+1]);
		
		translate([kWheelOffset-kBoltCl/2,0,0]) rotate([180,0,0]) Bolt2Hole(depth=16);
		translate([kWheelOffset+kBoltCl/2,0,0]) rotate([180,0,0]) Bolt2Hole(depth=16);
		
		cylinder(d=kWidth, h=kWheel_z);
		
		hull(){
			cylinder(d=6.35,h=11.5);
			translate([7,0,0])cylinder(d=6.35,h=11.5);
		}
	} // difference
} // ServoSG90TopBlock

//ServoSG90TopBlock(Xtra_Height=6);

module ServoSG90(TopMount=false, HasGear=true){
	
	translate([kWheelOffset,0,0]){
		// deck
		translate([-kDeck_x/2,-kWidth/2,0]) cube([kDeck_x,kWidth,kDeck_z+Overlap]);
		// top rectangle
		translate([-kBody_l/2,-kWidth/2,kDeck_z]) cube([kBody_l,kWidth,kTopBox_h]);
		// body
		translate([-kBody_l/2,-kWidth/2,-kBody_h]) cube([kBody_l,kWidth,kBody_h+Overlap]);
		
		translate([-kBoltCl/2,0,0]) Bolt2Hole(depth=16);
		translate([kBoltCl/2,0,0]) Bolt2Hole(depth=16);
		translate([-kBoltCl/2,0,0]) rotate([180,0,0])Bolt2Hole(depth=16);
		translate([kBoltCl/2,0,0]) rotate([180,0,0])Bolt2Hole(depth=16);
		
		if (TopMount==true){
			translate([-kDeck_x/2-0.5,-kWidth/2-0.5,-kBody_h]) cube([kDeck_x+1,kWidth+1,kBody_h+Overlap]);
		}
		
	}
	cylinder(d=kWidth+IDXtra*3, h=kWheel_z);
	hull(){
		cylinder(d=6.35,h=11.5);
		translate([7,0,0])cylinder(d=6.35,h=11.5);
	}
	
	//Gear
	if (HasGear) translate([0,0,kWheel_z]) cylinder(d=24,h=5);
} // ServoSG90

//ServoSG90(TopMount=false, HasGear=false); // default
//ServoSG90(TopMount=true);

module SG90ServoWheelBoltPattern(){
	for (J=[0:3]) rotate([0,0,90*J]) translate([(4.2+6.8)/2,0,0]) children();
} // SG90ServoWheelBoltPattern

//SG90ServoWheelBoltPattern() Bolt2Hole();

module SG90ServoWheel(){
	hull(){
			translate([0,0,-Overlap]) cylinder(d=7.2,h=1.6);
			translate([0,16.15,-Overlap]) cylinder(d=4.2,h=1.6);
		} // hull
		
		hull(){
			translate([0,0,-Overlap]) cylinder(d=7.2,h=1.6);
			translate([0,-14.35,-Overlap]) cylinder(d=4.2,h=1.6);
		} // hull
		
		hull(){
			translate([-7.05,0,-Overlap]) cylinder(d=4.0,h=1.6);
			translate([7.05,0,-Overlap]) cylinder(d=4.0,h=1.6);
		} // hull
} // SG90ServoWheel

//SG90ServoWheel();


