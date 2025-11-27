// **************************************************
// SG90 Servo Library
// David M. Flynn
// Filename: HD0411MGServoLib.scad
// Created: 11/18/2025
// Rev: 1.0.0 11/18/2025
// Units: millimeters
// **************************************************
// History:
	function HD0411MGServoLibRev()="HD0411MGServoLib 1.0.0";
	echo(HD0411MGServoLibRev());
//
// 1.0.0 11/18/2025 Coppied from SG90ServoLib 1.1.3
// **************************************************
// Notes:
//
//  Mounting of R/C micro servo HD0411MG.
//
// **************************************************
// Routines
//  ServoHD0411MGTopBlock(Xtra_Len=4, Xtra_Width=4, Xtra_Height=0);
//  ServoHD0411MG(TopMount=false); // default
//  ServoHD0411MG(TopMount=true);
//  HD0411MGServoWheelBoltPattern() Bolt2Hole();
//	HD0411MGServoWheelR();
//	HD0411MGServoWheelX();
// **************************************************

include<CommonStuffSAEmm.scad>

IDXtra=0.2;
$fn=$preview? 24:90;
Overlap=0.05;

	kDeck_x=32.4;
	kDeck_z=2.3;	// Deck thickness
	kWheel_z=14.2;	// from top of deck
	kWheelBC_d=14;
	kWheel_d=19;
	kWheelOffset=5.8; // body CL to wheel CL
	kBoltCl=28.0;
	kWidth=12.4;
	kTopCase_z=11.5;	// bottom of deck to top of bearing boss
	
	kBody_h=17; 	// bottom of servo to bottom of deck
	kBody_l=24;
	
	kTopBox_h=6.0; // bottom of deck to top of body
	
	

	
module ServoHD0411MGTopBlock(Xtra_Len=4, Xtra_Width=4, Xtra_Height=0){
	difference(){
		translate([kWheelOffset-kDeck_x/2-Xtra_Len/2, -kWidth/2-Xtra_Width/2, kDeck_z]) 
			cube([kDeck_x+Xtra_Len, kWidth+Xtra_Width, kDeck_z+Xtra_Height]);
			
		// top rectangle
		translate([kWheelOffset-kBody_l/2, -kWidth/2, kDeck_z-Overlap]) #cube([kBody_l,kWidth,kTopBox_h+1]);
		
		translate([kWheelOffset-kBoltCl/2,0,0]) rotate([180,0,0]) Bolt2Hole(depth=16);
		translate([kWheelOffset+kBoltCl/2,0,0]) rotate([180,0,0]) Bolt2Hole(depth=16);
		
		cylinder(d=kWidth, h=kWheel_z);
		
		hull(){
			cylinder(d=6.5,h=kTopCase_z);
			translate([7,0,0])cylinder(d=6.5,h=kTopCase_z);
		}
	} // difference
} // ServoSG90TopBlock

//ServoHD0411MGTopBlock(Xtra_Height=0);
// ServoHD0411MGTopBlock(Xtra_Len=4, Xtra_Width=7, Xtra_Height=2);

module ServoHD0411MG(TopMount=false, HasGear=true){
	
	translate([kWheelOffset,0,0]){
		// deck
		translate([-kDeck_x/2,-kWidth/2,0]) cube([kDeck_x,kWidth,kDeck_z+Overlap]);
		// top rectangle
		translate([-kBody_l/2,-kWidth/2,0]) cube([kBody_l,kWidth,kTopBox_h]);
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
		cylinder(d=6.5,h=kTopCase_z);
		translate([7,0,0])cylinder(d=6.5,h=kTopCase_z);
	}
	
	//Gear
	if (HasGear) translate([0,0,kWheel_z]) cylinder(d=24,h=5);
} // ServoHD0411MG

//ServoHD0411MG(TopMount=false, HasGear=false); // default
//ServoHD0411MG(TopMount=true);

module HD0411MGServoWheelBoltPattern(){
	for (J=[0:3]) rotate([0,0,90*J]) translate([kWheelBC_d/2,0,0]) children();
} // HD0411MGServoWheelBoltPattern

//HD0411MGServoWheelBoltPattern() Bolt2Hole();

module HD0411MGServoWheelR(){
	translate([0,0,-Overlap]) cylinder(d=kWheel_d,h=2.2);
} // HD0411MGServoWheelR

// HD0411MGServoWheelR();

module HD0411MGServoWheelX(){
	Spoke_w=5;
	Thickness=2;
	Spoke1_Len=26;
	Spoke2_Len=29;
	

	hull(){
		translate([-Spoke1_Len/2+Spoke_w/2,0,-Overlap]) cylinder(d=Spoke_w,h=Thickness);
		translate([Spoke1_Len/2-Spoke_w/2,0,-Overlap]) cylinder(d=Spoke_w,h=Thickness);
	} // hull
	
	hull(){
		translate([0,-Spoke2_Len/2+Spoke_w/2,-Overlap]) cylinder(d=Spoke_w,h=Thickness);
		translate([0,Spoke2_Len/2-Spoke_w/2,-Overlap]) cylinder(d=Spoke_w,h=Thickness);
	} // hull
} // HD0411MGServoWheelX

//HD0411MGServoWheelX();


