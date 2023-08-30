// ***********************************
// Project: 3D Printed Rocket
// Filename: CableReleaseBB.scad
// by David M. Flynn
// Created: 8/27/2022 
// Revision: 1.0.0  8/29/2023
// Units: mm
// ***********************************
//  ***** Notes *****
//
// This is a ball lock device. A pin is held in a housing by 5/16" Delrin balls.
// Rotation of over-center lock releases the pin.  The balls are held captive.
//
//  ***** Hardware *****
//
//  1/4"-20 Eyebolt threaded rod or other attachment
//  5/16" Delrin Balls (nBalls Req.)
//  MR84-2RS Ball Bearing (nBalls Req.)
//  4mm Dia. x 16mm Undersize Dowel Pin (nBalls Req.)
//  #4-40 x 1/2" Button Head Cap Screw (nBalls Req.)
//  #4-40 x 1/4" Button Head Cap Screw (2 Req.)
//  #4-40 x 3/8" Socket Head Cap Screw (nBalls+2 Req.)
//  6805-2RS Ball Bearing
//  MG90S Micro Servo
//  3/16" Dia. x 1/8" N42 Magnet (2 Req.)
//
//  ***** History *****
//
// 1.0.0  8/29/2023   It works!
// 0.9.1  8/28/2023   First working version.
// 0.9.0  8/27/2023   First code. Clean start.
//
// ***********************************
//  ***** for STL output *****
//
// LockingPin();
// rotate([180,0,0]) LockRing();
// rotate([180,0,0]) TopRetainer(OD_Xtra=0);
// OuterBearingRetainer();
// rotate([180,0,0]) InnerBearingRetainer();
// rotate([180,0,0]) MagnetBracket();
// rotate([180,0,0]) TriggerPost();
//
// ***********************************
//  ***** Routines *****
//
// MountingBoltPattern(nTopBolts=nBalls, OD_Xtra=0) Bolt4Hole();
//
// ***********************************
//  ***** for Viewing *****
//
// ShowCableReleaseBB();
//
// ***********************************

use<SG90ServoLib.scad>
use<ThreadLib.scad>
include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2; // Add to ID for tight fit, x2 for loose fit
$fn=$preview? 24:90;

LockPin_d=20;
LockPin_Len=23;
LockPinGrooveDepth=2;
Ball_d=5/16*25.4;

BallCircle_d=LockPin_d-LockPinGrooveDepth*2+Ball_d;
nBalls=5;

BearingMR84_ID=4;
BearingMR84_OD=8;
BearingMR84_H=3;

BearingCircle_d=BallCircle_d+Ball_d+BearingMR84_OD+IDXtra;

Bearing6805_ID=25;
Bearing6805_OD=37;
Bearing6805_H=7;

Bolt4Inset=4;
LockRing_d=Bearing6805_OD+Bolt4Inset*4;
LockRing_h=22;

LockRingBoltCircle_d=Bearing6805_OD+Bolt4Inset*2;
nLockRingBolts=nBalls;

nBottomBolts=5;
BottomBoltCircle_d=Bearing6805_ID-Bolt4Inset*2;

Magnet_d=3/16*25.4;
Magnet_t=1/8*25.4;

module ShowCableReleaseBB(){
	//color("LightBlue") 
	LockRing();
	LockingPin();
	color("Green") TopRetainer();
	translate([0,0,-19.5]) color("Gray") MagnetBracket();
	translate([0,0,-19.5]) color("Gray") TriggerPost();
	
	difference(){
		union(){
			translate([0,0,-19-0.2]) color("Tan") OuterBearingRetainer();
			translate([0,0,-20.0-0.2]) InnerBearingRetainer();
		} // union
		
		rotate([0,0,20]) translate([0,-50,-50]) cube([50,50,100]);
	} // difference
} // ShowCableReleaseBB

// ShowCableReleaseBB();

module BallGroove(BallCircle_d=BallCircle_d, Ball_d=Ball_d){
	rotate_extrude() translate([BallCircle_d/2,0,0]) circle(d=Ball_d);
} // BallGroove

// BallGroove();

module ShowBalls(BallCircle_d=BallCircle_d, nBalls=nBalls){
	for (j=[0:nBalls-1]) rotate([0,0,360/nBalls*j]) translate([0,BallCircle_d/2,0])
		sphere(d=Ball_d);
} // ShowBalls

//ShowBalls();

module ShowBearings(){
	for (j=[0:nBalls-1]) rotate([0,0,360/nBalls*j]) translate([0,BearingCircle_d/2,0]){
		color("Red") cylinder(d=BearingMR84_OD, h=BearingMR84_H, center=true);
		color("Gray") cylinder(d=BearingMR84_ID, h=12, center=true);
		}
} // ShowBearings

//ShowBearings();

module LockingPin(){
	difference(){
		translate([0,0,-Ball_d]) cylinder(d=LockPin_d, h=LockPin_Len);
		
		BallGroove(BallCircle_d=BallCircle_d, Ball_d=Ball_d);
		translate([0,0,-Ball_d-Overlap]) 
			if ($preview){ cylinder(d=6.35, h=LockPin_Len+Overlap*2); }
			else { ExternalThread(Pitch=25.4/20, Dia_Nominal=6.35+IDXtra*2, Length=LockPin_Len+Overlap*2, Step_a=2,TrimEnd=true,TrimRoot=true); }
	} // difference
	
	if ($preview) color("White") 
		ShowBalls(BallCircle_d=BallCircle_d, nBalls=nBalls);
} // LockingPin

//LockingPin();

module LockRing(){
	
	Bearing_Z=Bearing6805_H+3+Ball_d/2;
	
	difference(){
		translate([0,0,-Bearing_Z]) cylinder(d=LockRing_d, h=LockRing_h);
		
		// Bolt holes
		for (j=[0:nLockRingBolts-1]) rotate([0,0,360/nLockRingBolts*(j+0.5)])
			translate([0,LockRingBoltCircle_d/2,-Bearing_Z]) rotate([180,0,0]) Bolt4Hole();
		
		// Main Bearing
		translate([0,0,-Bearing_Z-Overlap]) cylinder(d=Bearing6805_OD+IDXtra, h=Bearing6805_H+0.5);
			
		// ID
		translate([0,0,-Bearing_Z]) cylinder(d=BallCircle_d+Ball_d+IDXtra*3, h=LockRing_h+Overlap);
		
		BallGroove(BallCircle_d=BallCircle_d+LockPinGrooveDepth*2, Ball_d=Ball_d+1);
		
		for (j=[0:nBalls-1]) rotate([0,0,360/nBalls*j]) translate([0,BearingCircle_d/2,0]){
			hull(){
				translate([0,Ball_d/2,0]) cylinder(d=BearingMR84_OD+2, h=BearingMR84_H+1, center=true);
				translate([0,-Ball_d/2,0]) cylinder(d=BearingMR84_OD+2, h=BearingMR84_H+1, center=true);
			} // hull
			
			// 4mm x 12mm dowel pin
			translate([0,0,1]) cylinder(d=BearingMR84_ID+IDXtra, h=12+4, center=true);
			translate([0,0,-6]) cylinder(d=BearingMR84_ID-1, h=LockRing_h, center=true);
		}
		
		if ($preview)
			translate([0,-50,-30]) cube([50,50,100]);
			
	} // difference
	
	if ($preview) ShowBearings();
} // LockRing

//LockRing();

module OuterBearingRetainer(){
	H=5.1; // 17 layers
	BearingP=0.6; // 2 layers
	
	difference(){
		union(){
			cylinder(d=LockRing_d, h=H);
			cylinder(d=Bearing6805_OD, h=H+BearingP);
		} // union
		
		// center hole
		translate([0,0,-Overlap]) cylinder(d=Bearing6805_OD-4, h=H+BearingP+Overlap*2);
		
		// Bolt holes
		for (j=[0:nLockRingBolts-1]) rotate([0,0,360/nLockRingBolts*(j+0.5)])
			translate([0,LockRingBoltCircle_d/2,0]) rotate([180,0,0]) Bolt4ButtonHeadHole();
			
		// accessory bolt holes
		for (j=[0:nLockRingBolts*3-1]) rotate([0,0,360/(nLockRingBolts*3)*(j+0.5)])
			translate([0,LockRingBoltCircle_d/2,H]) Bolt4Hole();
	} // difference
} // OuterBearingRetainer

//OuterBearingRetainer();

Magnet_a=10;
Ret_OD=Bearing6805_ID+4;
Magnet_Y=-Ret_OD/2+Magnet_d/2+3;
Magnet_Z=-Magnet_d/2-2;

module MagnetBracket(){
	MagnetExtraOffset=0.1; // <<< over center amount
	Magnet_Z=Magnet_Z-0.5;
	H=5.1;
	
	difference(){
		union(){
			for (j=[0:(360/(nLockRingBolts*3)*1.4)-1]) hull(){
				rotate([0,0,360/(nLockRingBolts*3)*(9+0.5)-j])
					translate([0,LockRingBoltCircle_d/2,-3]) cylinder(d=Bolt4Inset*2, h=3);
				rotate([0,0,360/(nLockRingBolts*3)*(9+0.5)-j-1])
					translate([0,LockRingBoltCircle_d/2,-3]) cylinder(d=Bolt4Inset*2, h=3);
			}
			
			// magnet holder
			rotate([0,0,Magnet_a]) translate([Magnet_t/2+MagnetExtraOffset, Magnet_Y, Magnet_Z-0.25]) hull(){
				translate([0,-15,0]) cylinder(d=Magnet_t, h=Magnet_d+3.5, center=true);
				translate([0,Magnet_d/2+1,0]) cylinder(d=Magnet_t, h=Magnet_d+3.5, center=true);
			}
		} // union
		
		// Bolt holes
		rotate([0,0,360/(nLockRingBolts*3)*(9+0.5)])
					translate([0,LockRingBoltCircle_d/2,-6]) rotate([180,0,0]) Bolt4HeadHole();
		rotate([0,0,360/(nLockRingBolts*3)*(8+0.5)])
					translate([0,LockRingBoltCircle_d/2,-6]) rotate([180,0,0]) Bolt4HeadHole();
					
	// Magnet
		rotate([0,0,Magnet_a]) translate([Magnet_t/2+MagnetExtraOffset, Magnet_Y, Magnet_Z]) 
			rotate([0,90,0]) cylinder(d=Magnet_d, h=Magnet_t+2, center=true);
	} // difference
} // MagnetBracket

//translate([0,0,-19.5]) MagnetBracket();

//TopRetainer();
//translate([0,0,-19.5]) OuterBearingRetainer();
//translate([0,0,-19.5]) InnerBearingRetainer();

module TriggerPost(){
	H=5.1;
	MountingHole=2;
	Post_H=8;
	
	difference(){
		union(){
			// Base
			for (j=[0:(360/(nLockRingBolts*3)*1.4)-1]) hull(){
				rotate([0,0,360/(nLockRingBolts*3)*(MountingHole+0.5)+j])
					translate([0,LockRingBoltCircle_d/2,-3]) cylinder(d=Bolt4Inset*2, h=3);
				rotate([0,0,360/(nLockRingBolts*3)*(MountingHole+0.5)+j+1])
					translate([0,LockRingBoltCircle_d/2,-3]) cylinder(d=Bolt4Inset*2, h=3);
			}
			
			// trigger post
			rotate([0,0,Magnet_a+90]) translate([1, LockRingBoltCircle_d/2-1, -Post_H/2]) hull(){
				translate([0,-3,0]) cylinder(d=3, h=Post_H, center=true);
				translate([0,3,0]) cylinder(d=3, h=Post_H, center=true);
			}
		} // union
		
		// Bolt holes
		rotate([0,0,360/(nLockRingBolts*3)*(MountingHole+0.5)])
					translate([0,LockRingBoltCircle_d/2,-3.5]) rotate([180,0,0]) Bolt4ButtonHeadHole();
		rotate([0,0,360/(nLockRingBolts*3)*(MountingHole+1+0.5)])
					translate([0,LockRingBoltCircle_d/2,-3.5]) rotate([180,0,0]) Bolt4ButtonHeadHole();
			
	} // difference
} // TriggerPost

//translate([0,0,-19.5]) TriggerPost();

Lock_a=24;
TopBoltCircle_d=LockRing_d-Bolt4Inset*2;

module MountingBoltPattern(nTopBolts=nBalls, OD_Xtra=0){
	for (j=[0:nTopBolts-1]) rotate([0,0,360/nTopBolts*(j+0.5)+Lock_a/2])
			translate([0,TopBoltCircle_d/2+OD_Xtra/2,0]) children();
} // MountingBoltPattern

// MountingBoltPattern(nTopBolts=nBalls) Bolt4Hole();

module TopRetainer(OD_Xtra=0){
	Bearing_Z=Bearing6805_H+3+Ball_d/2;
	TopRetainer_Len=28.5;
	
	LockStart_a=-0.5;
	
	difference(){
		union(){
			translate([0,0,-Bearing_Z]) cylinder(d=Bearing6805_ID, h=Bearing6805_H+Overlap);
			translate([0,0,-Bearing_Z+Bearing6805_H]) 
				cylinder(d=BallCircle_d+Ball_d, h=TopRetainer_Len-Bearing6805_H);
			
			translate([0,0,-Bearing_Z+LockRing_h+0.5]) cylinder(d=LockRing_d+OD_Xtra, h=6);
		} // union
		
		translate([0,0,-Bearing_Z+5.5]) cylinder(d=LockPin_d+IDXtra*3, h=TopRetainer_Len+Overlap*2);
		
		// Top Bolt holes
		translate([0,0,-Bearing_Z+TopRetainer_Len]) 
			MountingBoltPattern(nTopBolts=nBalls, OD_Xtra=OD_Xtra) Bolt4Hole();
		
		// Bottom Bolt holes
		for (j=[0:nBottomBolts-1]) rotate([0,0,360/nBottomBolts*j])
			translate([0,BottomBoltCircle_d/2,-Bearing_Z]) rotate([180,0,0]) Bolt4Hole();
		
		// Center hole
		translate([0,0,-Bearing_Z-Overlap]) cylinder(d=BottomBoltCircle_d-Bolt4Inset*2, h=Bearing_Z);
		
		for (j=[0:nBalls-1]) rotate([0,0,360/nBalls*j]) translate([0,BallCircle_d/2,0]) hull(){
			sphere(d=Ball_d+IDXtra*2);
			translate([0,3,0]) sphere(d=Ball_d+IDXtra*2);
			translate([0,3,-0.375]) scale([1,1,1.05]) sphere(d=Ball_d+IDXtra*2); // helps print cleaner
		}
		
		// Rotation limit slots
		for (j=[0:nBalls-1])
			for (k=[0:Lock_a-1]) hull(){
				rotate([0,0,360/nBalls*j+k+LockStart_a]) 
					translate([0,BearingCircle_d/2,-Bearing_Z+LockRing_h+0.5-Overlap]) 
						cylinder(d=BearingMR84_ID+IDXtra*3, h=4);
				rotate([0,0,360/nBalls*j+k+1+LockStart_a]) 
					translate([0,BearingCircle_d/2,-Bearing_Z+LockRing_h+0.5-Overlap]) 
						cylinder(d=BearingMR84_ID+IDXtra*3, h=4);
			}
			
		if ($preview)
			translate([0,-50,-30]) cube([50,50,100]);
	} // difference
	
} // TopRetainer

// TopRetainer(OD_Xtra=10);
// LockingPin();

module InnerBearingRetainer(){
	H=6;
	MagnetExtraOffset=0.4; // <<< over center amount
	
	
	
	difference(){
		union(){
			translate([0,5,-12]) rotate([0,90,180+10]) translate([0,0,-1]){
				ServoSG90TopBlock(Xtra_Len=4, Xtra_Width=7, Xtra_Height=2);
				//color("Tan") translate([0,0,6.2]) ServoSG90(TopMount=false, HasGear=false);
				}
				
			cylinder(d=Ret_OD+3, h=H);
			
			// magnet holder
			rotate([0,0,Magnet_a]) translate([-Magnet_t/2-MagnetExtraOffset,Magnet_Y,Magnet_Z]) hull(){
				translate([0,-Magnet_d/2-2,0]) cylinder(d=Magnet_t, h=-Magnet_Z*2+1, center=true);
				translate([0,Magnet_d/2+2,0]) cylinder(d=Magnet_t, h=-Magnet_Z*2+1, center=true);
			}
				//cube([Magnet_t, Magnet_d+6, Magnet_d+6], center=true);
		} // union
		
		// Magnet
		rotate([0,0,Magnet_a]) translate([-Magnet_t/2-MagnetExtraOffset, Magnet_Y, Magnet_Z]) 
			rotate([0,90,0]) cylinder(d=Magnet_d, h=Magnet_t+2, center=true);
		
		// Bottom Bolt holes
		for (j=[0:nBottomBolts-1]) rotate([0,0,360/nBottomBolts*j])
			translate([0,BottomBoltCircle_d/2,0]) rotate([180,0,0]) Bolt4HeadHole();
	} // difference
} // InnerBearingRetainer

//translate([0,0,-0.5]) InnerBearingRetainer();
























