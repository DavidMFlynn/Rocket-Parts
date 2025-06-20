// ***********************************
// Project: 3D Printed Rocket
// Filename: CableReleaseBB.scad
// by David M. Flynn
// Created: 8/27/2022 
// Revision: 1.1.3  11/2/2024
// Units: mm
// ***********************************
//  ***** Notes *****
//
// This is a ball lock device. A pin is held in a housing by 5/16" Delrin balls.
// Rotation of over-center lock releases the pin.  The balls are held captive.
// Uses ball bearings for low force transfer.
// First used in Rocket98C to release deployment spring.
//
// I built one w/ the GuidePoint (12/28/2023) it works well.
//
//  ***** Hardware *****
//
//  1/4"-20 Eyebolt threaded rod or other attachment
//  5/16" Delrin Balls (nBalls Req.)
//  MR84-2RS Ball Bearing (nBalls Req.)
//  4mm Dia. x 16mm Undersize Dowel Pin (nBalls Req.)
//  #4-40 x 1/2" Button Head Cap Screw (nBalls Req.)
//  #4-40 x 1/4" Button Head Cap Screw (4 Req.)
//  #4-40 x 3/8" Socket Head Cap Screw (nBalls Req.)
//  6805-2RS Ball Bearing
//  MG90S Micro Servo
//  3/16" Dia. x 1/8" N42 Magnet (2 Req.)
//
//  ***** History *****
//
function CableReleaseBBRev()="CableReleaseBB Rev. 1.1.3";
echo(CableReleaseBBRev());
// 1.1.3  11/2/2024   Added HasOuterPost option to CRBB_TriggerPost()
// 1.1.2  5/2/2024    Worked on CRBB_TopRetainerEBayEnd
// 1.1.1  12/29/2023  Fixed dowel holes. Code cleanup. Added CRBB_ prefix
// 1.1.0  12/28/2023  Added optional GuidePoint for easier assemble.
// 1.0.2  12/27/2023  Added ExtensionRod()
// 1.0.1  9/12/2023   Added LockPin_Len parameter to LockingPin
// 1.0.0  8/29/2023   It works!
// 0.9.1  8/28/2023   First working version.
// 0.9.0  8/27/2023   First code. Clean start.
//
// ***********************************
//  ***** for STL output *****
//
// CRBB_ExtensionRod(Len=10);
// CRBB_LockingPin(LockPin_Len=LockPin_Len, GuidePoint=false);
// rotate([180,0,0]) CRBB_LockRing(GuidePoint=false);
// rotate([180,0,0]) CRBB_TopRetainer(LockRing_d=CRBB_LockRingDiameter(), OD=0, HasMountingBolts=true, GuidePoint=false);
// CRBB_OuterBearingRetainer();
// rotate([180,0,0]) CRBB_InnerBearingRetainer(HasServo=true);
// rotate([180,0,0]) CRBB_MagnetBracket();
// rotate([180,0,0]) CRBB_TriggerPost();
// rotate([180,0,0]) CRBB_TriggerPost(HasOuterPost=true);
//
// CRBB_CenteringRingMount(Tube_ID=BT54Body_ID, Thickness=5, Skirt_Len=12.5, nBolts=5, HasShockcodeAnchor=true, LockRing_d=CRBB_LockRingDiameter());
//
/*
rotate([180,0,0]) CRBB_TopRetainerEBayEnd(Body_OD=BT98Body_OD, Body_ID=BT98Body_ID, Coupler_OD=BT98Coupler_OD, 
			CT_Len=15, StopRing_Len=5, nBolts=4, nServos=2);
/**/
//
// CRBB_EBayEndCover();
// rotate([180,0,0]) CRBB_SpringEnd(Coupler_OD=BT98Coupler_OD);
// CRBB_LockingPin(LockPin_Len=40, GuidePoint=true);
//
// ***********************************
//  ***** Routines *****
//
// CRBB_MountingBoltPattern(nTopBolts=nBalls, LockRing_d=LockRing_d) Bolt4Hole();
//
// function CRBB_TopBoltCircle_d(LockRing_d=LockRing_d)=LockRing_d-Bolt4Inset*2;
// function CRBB_LockRingDiameter()=LockRing_d;
//
// ***********************************
//  ***** for Viewing *****
//
// ShowCableReleaseBB(GuidePoint=true);
//
// ***********************************
include<TubesLib.scad>
use<SG90ServoLib.scad> echo(SG90ServoLibRev());
use<ThreadLib.scad>
use<SpringEndsLib.scad>

// include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2; // Add to ID for tight fit, x2 for loose fit
$fn=$preview? 24:90;

LockPin_d=20;
LockPin_Len=23;
LockPinGrooveDepth=2;
Ball_d=5/16*25.4;
GuidePoint_Len=LockPin_d/3;
GuidePoint_d=7.5;

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
Magnet_a=10;
Ret_OD=Bearing6805_ID+4;
Magnet_Y=-Ret_OD/2+Magnet_d/2+2;
Magnet_Z=-Magnet_d/2-2;


Dowel_d=BearingMR84_ID;
Dowel_Len=16;

Lock_a=24;
function CRBB_TopBoltCircle_d(LockRing_d=LockRing_d)=LockRing_d-Bolt4Inset*2;
function CRBB_LockRingDiameter()=LockRing_d;

module ShowCableReleaseBB(GuidePoint=false){
	Point_Len=GuidePoint? GuidePoint_Len:0;
	CT_Len=20;
	StopRing_Len=45;
	
	translate([0,0,15.5]) color("LightBlue") CRBB_ExtensionRod(Len=50);
	 
	CRBB_LockRing(GuidePoint=GuidePoint);
	CRBB_LockingPin(GuidePoint=GuidePoint);
	color("Green") CRBB_TopRetainer(GuidePoint=GuidePoint);
	translate([0,0,-19.5-Point_Len]) color("Gray") CRBB_MagnetBracket();
	translate([0,0,-19.5-Point_Len]) color("Gray") CRBB_TriggerPost();
	
	difference(){
		union(){
			translate([0,0,-19-0.2-Point_Len]) color("Tan") CRBB_OuterBearingRetainer();
			translate([0,0,-20.0-0.2-Point_Len]) CRBB_InnerBearingRetainer();
		} // union
		
		rotate([0,0,20]) translate([0,-50,-50]) cube([50,50,100]);
	} // difference
	
	translate([0,0,-CT_Len-StopRing_Len+5]) color("Orange") 
		CRBB_TopRetainerEBayEnd(Coupler_OD=BT98Coupler_OD, HasSpring=false, CT_Len=CT_Len, StopRing_Len=StopRing_Len, nBolts=3);
} // ShowCableReleaseBB

// ShowCableReleaseBB();

module CRBB_BallGroove(BallCircle_d=BallCircle_d, Ball_d=Ball_d){
	rotate_extrude() translate([BallCircle_d/2,0,0]) circle(d=Ball_d);
} // BallGroove

// CRBB_BallGroove();

module CRBB_ShowBalls(BallCircle_d=BallCircle_d, nBalls=nBalls){
	for (j=[0:nBalls-1]) rotate([0,0,360/nBalls*j]) translate([0,BallCircle_d/2,0])
		sphere(d=Ball_d);
} // CRBB_ShowBalls

// CRBB_ShowBalls();

module CRBB_ShowBearings(){
	for (j=[0:nBalls-1]) rotate([0,0,360/nBalls*j]) translate([0,BearingCircle_d/2,0]){
		color("Red") cylinder(d=BearingMR84_OD, h=BearingMR84_H, center=true);
		translate([0,0,3]) color("Gray") cylinder(d=Dowel_d, h=Dowel_Len, center=true);
		}
} // CRBB_ShowBearings

// CRBB_ShowBearings();

module CRBB_ExtensionRod(Len=100){
	ID=1/4*25.4+IDXtra;
	Wall_t=1.2;
	
	difference(){
		cylinder(d=LockPin_d, h=Len);
		
		translate([0,0,-Overlap]) cylinder(d=ID, h=Len+Overlap*2);
		
		if (Len>30){
		translate([0,0,5]) cylinder(d1=ID, d2=LockPin_d-Wall_t*2, h=10);
		translate([0,0,15-Overlap]) cylinder(d=LockPin_d-Wall_t*2, h=Len-30+Overlap*2);
		translate([0,0,Len-15-Overlap]) cylinder(d2=ID, d1=LockPin_d-Wall_t*2, h=10);
		}
		
		//cube([20,20,100]);
	} // difference
} // CRBB_ExtensionRod

//CRBB_ExtensionRod(Len=90);

module CRBB_LockingPin(LockPin_Len=LockPin_Len, GuidePoint=false, IsThreaded=true){
	Point_Len=GuidePoint? GuidePoint_Len:0;
	Point_d=GuidePoint_d;
	
	difference(){
		union(){
			translate([0,0,-Ball_d]) cylinder(d=LockPin_d, h=LockPin_Len);
			if (GuidePoint)
				translate([0,0,-Ball_d-Point_Len]) 
					cylinder(d1=Point_d, d2=LockPin_d, h=Point_Len+Overlap);
		} // union
		
		CRBB_BallGroove(BallCircle_d=BallCircle_d, Ball_d=Ball_d);
		translate([0,0,-Ball_d-Point_Len-Overlap]) 
			if ($preview || !IsThreaded){ 
				cylinder(d=6.35, h=LockPin_Len+Point_Len+Overlap*2); }
			else { 
				ExternalThread(Pitch=25.4/20, Dia_Nominal=6.35+IDXtra*2, 
							Length=LockPin_Len+Point_Len+Overlap*2, 
							Step_a=2,TrimEnd=true,TrimRoot=true); }
	} // difference
	
	if ($preview) color("White") 
		CRBB_ShowBalls(BallCircle_d=BallCircle_d, nBalls=nBalls);
} // CRBB_LockingPin

// CRBB_LockingPin(LockPin_Len=LockPin_Len, GuidePoint=true);

module CRBB_LockRing(GuidePoint=false){
	Point_Len=GuidePoint? GuidePoint_Len:0;
	Bearing_Z=Bearing6805_H+3+Ball_d/2;
	
	difference(){
		translate([0,0,-Bearing_Z-Point_Len]) cylinder(d=LockRing_d, h=LockRing_h+Point_Len);
		
		// Bolt holes
		for (j=[0:nLockRingBolts-1]) rotate([0,0,360/nLockRingBolts*(j+0.5)])
			translate([0,LockRingBoltCircle_d/2,-Bearing_Z-Point_Len]) 
				rotate([180,0,0]) Bolt4Hole();
		
		// Main Bearing
		translate([0,0,-Bearing_Z-Point_Len-Overlap]) 
			cylinder(d=Bearing6805_OD+IDXtra, h=Bearing6805_H+0.5);
			
		// ID
		translate([0,0,-Bearing_Z-Point_Len]) 
			cylinder(d=BallCircle_d+Ball_d+IDXtra*3, h=LockRing_h+Point_Len+Overlap);
		
		CRBB_BallGroove(BallCircle_d=BallCircle_d+LockPinGrooveDepth*2, Ball_d=Ball_d+1);
		
		// Bearings and pins
		for (j=[0:nBalls-1]) rotate([0,0,360/nBalls*j]) translate([0,BearingCircle_d/2,0]){
			hull(){
				translate([0,Ball_d/2,0]) 
					cylinder(d=BearingMR84_OD+2, h=BearingMR84_H+1, center=true);
				translate([0,-Ball_d/2,0]) 
					cylinder(d=BearingMR84_OD+2, h=BearingMR84_H+1, center=true);
			} // hull
			
			// 4mm x 16mm dowel pin
			translate([0,0,2]) cylinder(d=Dowel_d+IDXtra, h=Dowel_Len, center=true);
			// stop support from going here
			translate([0,0,-8]) cylinder(d1=0.2, d2=Dowel_d+IDXtra, h=2+Overlap);
			
		}
		
		if ($preview)
			translate([0,-50,-30]) cube([50,50,100]);
			
	} // difference
	
	if ($preview) CRBB_ShowBearings();
} // CRBB_LockRing

// CRBB_LockRing(GuidePoint=true);

module CRBB_OuterBearingRetainer(){
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
} // CRBB_OuterBearingRetainer

//CRBB_OuterBearingRetainer();

module CRBB_MagnetBracket(){
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
} // CRBB_MagnetBracket

//translate([0,0,-19.5]) CRBB_MagnetBracket();

//CRBB_TopRetainer();
//translate([0,0,-19.5]) CRBB_OuterBearingRetainer();
//translate([0,0,-19.5]) CRBB_InnerBearingRetainer();

module CRBB_TriggerPost(HasOuterPost=false){
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
				
				if (HasOuterPost) translate([0,5,0]) cylinder(d=4, h=Post_H, center=true);
					
			}
		} // union
		
		// Bolt holes
		rotate([0,0,360/(nLockRingBolts*3)*(MountingHole+0.5)])
					translate([0,LockRingBoltCircle_d/2,-3.5]) rotate([180,0,0]) Bolt4ButtonHeadHole();
		rotate([0,0,360/(nLockRingBolts*3)*(MountingHole+1+0.5)])
					translate([0,LockRingBoltCircle_d/2,-3.5]) rotate([180,0,0]) Bolt4ButtonHeadHole();
			
	} // difference
} // CRBB_TriggerPost

//translate([0,0,-19.5]) CRBB_TriggerPost(HasOuterPost=true);


module CRBB_MountingBoltPattern(nTopBolts=nBalls, LockRing_d=CRBB_LockRingDiameter()){
	for (j=[0:nTopBolts-1]) rotate([0,0,360/nTopBolts*(j+0.5)+Lock_a/2])
			translate([0,CRBB_TopBoltCircle_d(LockRing_d)/2,0]) children();
} // CRBB_MountingBoltPattern

// CRBB_MountingBoltPattern(nTopBolts=nBalls) Bolt4Hole();

module CRBB_TopRetainer(LockRing_d=CRBB_LockRingDiameter(), OD=0, HasMountingBolts=true, GuidePoint=false){
	Point_Len=GuidePoint? GuidePoint_Len:0;
	Bearing_Z=Bearing6805_H+3+Ball_d/2;
	TopRetainer_Len=28.5;
	
	LockStart_a=-0.5;
	Flange_OD=(OD>0)? OD:LockRing_d;
	
	difference(){
		union(){
			// Bearing
			translate([0,0,-Bearing_Z-Point_Len]) cylinder(d=Bearing6805_ID, h=Bearing6805_H+Overlap);
			
			// Body
			translate([0,0,-Bearing_Z-Point_Len+Bearing6805_H]) 
				cylinder(d=BallCircle_d+Ball_d, h=TopRetainer_Len+Point_Len-Bearing6805_H);
			
			// Flange
			translate([0,0,-Bearing_Z+LockRing_h+0.5]) cylinder(d=Flange_OD, h=6);
		} // union
		
		if (GuidePoint) translate([0,0,-Bearing_Z+LockRing_h+0.5+1]) 
			cylinder(d1=LockPin_d, d2=LockPin_d+6, h=5+Overlap);
		
		// Locking pin
		translate([0,0,-Bearing_Z+5.5]) cylinder(d=LockPin_d+IDXtra*3, h=TopRetainer_Len+Overlap*2);
		if (GuidePoint) translate([0,0,-Bearing_Z-Point_Len+5.5])
			cylinder(d1=GuidePoint_d+IDXtra*3, d2=LockPin_d+IDXtra*3, h=Point_Len+Overlap);
		
		// Top Bolt holes
		if (HasMountingBolts)
			translate([0,0,-Bearing_Z+TopRetainer_Len]) 
				CRBB_MountingBoltPattern(nTopBolts=nBalls, LockRing_d=LockRing_d) Bolt4Hole();
		
		// Bottom Bolt holes
		for (j=[0:nBottomBolts-1]) rotate([0,0,360/nBottomBolts*j])
			translate([0,BottomBoltCircle_d/2,-Bearing_Z-Point_Len]) 
				rotate([180,0,0]) Bolt4Hole(depth=8+Point_Len);
		
		// Center hole
		translate([0,0,-Bearing_Z-Point_Len-Overlap]) 
			cylinder(d=BottomBoltCircle_d-Bolt4Inset*2, h=Bearing_Z+Point_Len);
		
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
	
} // CRBB_TopRetainer

// CRBB_TopRetainer(LockRing_d=LockRing_d, HasMountingBolts=false, GuidePoint=true);
// CRBB_LockingPin();
// CRBB_TopRetainer(LockRing_d=CRBB_LockRingDiameter(), HasMountingBolts=true, GuidePoint=false);

module CRBB_CenteringRingMount(Tube_ID=BT54Body_ID, Thickness=5, Skirt_Len=0, nBolts=5, 
							HasShockcodeAnchor=false, LockRing_d=CRBB_LockRingDiameter()){
	
	nAnchors=2;
	PinCenter_Z=2.5;
	
	module AnchorPinAccess(){
		translate([0,0,PinCenter_Z]) rotate([-90,0,0]) cylinder(d=4, h=Tube_ID);
		// Shockcord path
			translate([0,0,PinCenter_Z]) rotate([-90,0,0]) cylinder(d=8, h=3, center=true);
	} // AnchorPinAccess
	
	module Anchor(){
		
		difference(){
			hull(){
				translate([0,0,PinCenter_Z]) rotate([-90,0,0]) cylinder(d=10, h=20, center=true);
				cube([11,20,Overlap],center=true);
			} // hull
			
			// Shockcord path
			translate([0,0,PinCenter_Z]) rotate([-90,0,0]) cylinder(d=14, h=3, center=true);
			
			// Pin
			translate([0,0,PinCenter_Z]) rotate([-90,0,0]) cylinder(d=4, h=21, center=true);
		} // difference
	} // Anchor
	
	difference(){
		union(){
			CenteringRing(OD=Tube_ID, ID=21, Thickness=Thickness, nHoles=0, Offset=0, myfn=$preview? 36:90);
			
			if (Skirt_Len>Thickness)
				Tube(OD=Tube_ID, ID=Tube_ID-4.4, Len=Skirt_Len, myfn=$preview? 36:360);
				
			if (HasShockcodeAnchor)
				for (j=[0:nAnchors-1]) rotate([0,0,360/nAnchors*j]) translate([14,0,Thickness])
					Anchor();
		} // union
		
		if (HasShockcodeAnchor)
				for (j=[0:nAnchors-1]) rotate([0,0,360/nAnchors*j]) translate([14,0,Thickness])
					AnchorPinAccess();
		
		// center hole
		translate([0,0,-Overlap]) cylinder(d=21, h=30);
		
		// Spring
		translate([0,0,Thickness-2]) Tube(OD=SE_Spring_CS4323_OD(), ID=SE_Spring_CS4323_ID()-1, Len=Thickness+10, myfn=$preview? 36:360);
		
		// Bolts to CRBB_TopRetainer
		translate([0,0,4]) rotate([0,0,6])
			CRBB_MountingBoltPattern(nTopBolts=nBolts, LockRing_d=LockRing_d) Bolt4ButtonHeadHole();
	} // difference
	
	
	
} // CRBB_CenteringRingMount

//CRBB_CenteringRingMount(Tube_ID=BT54Body_ID, Thickness=5, Skirt_Len=12.5, nBolts=5, HasShockcodeAnchor=true, LockRing_d=CRBB_LockRingDiameter());

module CRBB_EBayEndCover(){
	Cover_OD=LockRing_d+14;
	
	Tube(OD=Cover_OD, ID=LockRing_d+10+IDXtra*2, Len=5, myfn=$preview? 90:360);
	cylinder(d=Cover_OD-1, h=1.2);
} // CRBB_EBayEndCover

// CRBB_EBayEndCover();

module CRBB_TopRetainerEBayEnd(Body_OD=BT98Body_OD, Body_ID=BT98Body_ID, Coupler_OD=BT98Coupler_OD, CT_Len=30, StopRing_Len=5,
	nBolts=3, 
	nServos=0, 			// 0,1 or 2
	GuidePoint=false){
	
	ET_Len=15; // EBay interface
	OAL=ET_Len+StopRing_Len+CT_Len;
	Plate_t=5;
	Shield_LenTemp=(nServos>0)? Plate_t+48:Plate_t+70;
	Shield_Len=GuidePoint? Shield_LenTemp+7:Shield_LenTemp;
	
	nRopes=6;
	Rope_d=4;	
	Rope_Inset=(Coupler_OD>70)? 3:1.5;
	
	
	Servo1Angle=24;
	ServoBase_Z=GuidePoint? 31:24; // Plate_Z to servo mount
	Servo2Angle=Servo1Angle+360/nLockRingBolts*2;
	Plate_Z=OAL-Plate_t;
	SevoBase_X=12;
	SevrvoBase_Y=35;
	
	
	SpringPlate_a=Servo1Angle-4;

	module ServoWirePath(){
		translate([0,24,13]){
		
			hull(){
				translate([0,0,-2.5]) rotate([90,0,0]) cylinder(d=6, h=10);
				translate([0,0,2.5]) rotate([90,0,0]) cylinder(d=6, h=10);
			} // hull
			
			hull(){
				translate([1.8,-7.7,0]) rotate([180,0,0]) cylinder(d=2.4, h=15);
				translate([-1.8,-7.7,0]) rotate([180,0,0]) cylinder(d=2.4, h=15);
			} // hull
		}
	} // ServoWirePath
	
	module ServoMountCuts(){
		translate([34,-4,Plate_Z-ServoBase_Z]){
			ServoWirePath();
					
			rotate([0,0,90]) 
				rotate([180,0,0]) ServoSG90(TopMount=false, HasGear=false);
						
			translate([-8.5,-11.6+5,0]) mirror([0,0,1]) cube([17,23.2,Shield_Len]);
					
			translate([-SevoBase_X/2,4-SevrvoBase_Y/2,0]) 
				mirror([0,0,1]) cube([SevoBase_X+2,SevrvoBase_Y+2,Shield_Len]);
		}
	} // ServoMountCuts
	
	difference(){
		union(){
			// EBay inferface
			Tube(OD=Body_ID, ID=Body_ID-4.4, Len=ET_Len+Overlap, myfn=$preview? 90:360);
			
			// Body
			translate([0,0,ET_Len]) Tube(OD=Coupler_OD, ID=Body_ID-4.4, Len=OAL-ET_Len, myfn=$preview? 90:360);
			
			// Stop ring
			translate([0,0,ET_Len]) 
				Tube(OD=Body_OD, ID=Body_ID-4.4, Len=StopRing_Len, myfn=$preview? 90:360);
				
			// Shield
			translate([0,0,OAL-Shield_Len]) Tube(OD=LockRing_d+10, ID=LockRing_d+5, Len=Shield_Len, myfn=$preview? 90:360);
			
			if (nServos>0)
				rotate([0,0,Servo1Angle]) translate([34-SevoBase_X/2,1-SevrvoBase_Y/2,Plate_Z+Overlap]) 
					mirror([0,0,1]) cube([SevoBase_X,SevrvoBase_Y,ServoBase_Z]);
			if (nServos>1)
				rotate([0,0,Servo2Angle]) translate([34-SevoBase_X/2,1-SevrvoBase_Y/2,Plate_Z+Overlap]) 
					mirror([0,0,1]) cube([SevoBase_X,SevrvoBase_Y,ServoBase_Z]);
			
		} // union
		
		// Cleanup inside
		translate([0,0,OAL-Shield_Len]) cylinder(d=LockRing_d+5, h=Shield_Len, $fn=$preview? 90:360);
		
		// Bolt holes (E_Bay)
		if (nBolts>0) for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j])
			translate([0,Body_OD/2,ET_Len-7.5]) rotate([-90,0,0]) Bolt4Hole(depth=4);
			
		if (nServos>0)
			rotate([0,0,Servo1Angle]) ServoMountCuts();
		
		if (nServos>1)
			rotate([0,0,Servo2Angle]) ServoMountCuts();
		
			
		//if ($preview) rotate([0,0,-90]) translate([0,0,-30]) cube([100,100,OAL+50]);
	} // difference
	
	//*
	translate([0,0,Plate_Z])
	difference(){
	
		rotate([0,0,SpringPlate_a])
		difference(){
			cylinder(d=Coupler_OD-1, h=Plate_t);
			
			translate([0,0,-Overlap]) cylinder(d=36, h=Plate_t+Overlap*2);
				
			// Retention cord
			for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j]) 
				translate([Coupler_OD/2-Rope_d/2-Rope_Inset,0,-Overlap]) cylinder(d=Rope_d, h=10);
				
			// Bolt holes for CRBB_SpringEnd
			for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j+10]) 
				translate([Coupler_OD/2-Rope_d/2-Rope_Inset,0,Plate_t]) Bolt4Hole();
			
		} // difference
		
		translate([0,0,Plate_t]) CRBB_MountingBoltPattern() Bolt4ButtonHeadHole();
		
		// shock cord path
		rotate([0,0,SpringPlate_a])
		translate([0,-Body_ID/2+6,-5]) hull(){
			translate([6,0,0]) cylinder(d=4, h=Plate_t*2+3);
			translate([-6,0,0]) cylinder(d=4, h=Plate_t*2+3);
		}
		
		//if ($preview) rotate([0,0,-90]) translate([0,0,-10]) cube([100,100,100]);
	} // difference
	/**/
} // CRBB_TopRetainerEBayEnd

//translate([0,0,-20]) CRBB_TopRetainerEBayEnd(HasSpring=false, CT_Len=20);
//CRBB_TopRetainer(LockRing_d=LockRing_d, HasMountingBolts=true, GuidePoint=true);

//translate([0,0,-20]) 
//rotate([180,0,0]) CRBB_TopRetainerEBayEnd(Body_OD=BT98Body_OD, Body_ID=BT98Body_ID, Coupler_OD=BT98Coupler_OD, CT_Len=15, StopRing_Len=5, nBolts=4, nServos=2, GuidePoint=true);

//CRBB_TopRetainerEBayEnd(Body_OD=BT75Body_OD, Body_ID=BT75Body_ID, Coupler_OD=BT75Coupler_OD, CT_Len=15, StopRing_Len=5, nBolts=4, nServos=0, GuidePoint=true);

module CRBB_SpringEnd(Coupler_OD=BT98Coupler_OD){
	nRopes=6;
	Rope_d=4;	
	Rope_Inset=(Coupler_OD>70)? 3:1.5;
	
	OAH=13;

	difference(){
		SE_SpringEndTypeA(Coupler_OD=Coupler_OD, Coupler_ID=Coupler_OD, nRopes=6);
		
		for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j-10]) 
					translate([Coupler_OD/2-Rope_d/2-Rope_Inset,0,10]) rotate([180,0,0]) Bolt4ClearHole();
					
		translate([0,0,OAH]) cylinder(d=Coupler_OD+1, h=10);
	} // difference
} // CRBB_SpringEnd

//translate([0,0,48.2]) rotate([180,0,0]) CRBB_SpringEnd();

//translate([0,0,-27]) CRBB_OuterBearingRetainer();
//translate([0,0,-27]) CRBB_InnerBearingRetainer(HasServo=false);
/**/

module CRBB_InnerBearingRetainer(HasServo=true, HasCenterHole=false){
	// Changed screw depth by -0.5

	H=6;
	MagnetExtraOffset=0.4; // <<< over center amount
	CenterHole_d=3.5;
	Servo_X=-1.3; // was 0
	Servo_Y=6; // was 5
	
	difference(){
		union(){
			if (HasServo)
				translate([Servo_X,Servo_Y,-12]) rotate([0,90,180+10]) translate([0,0,-1]){
					ServoSG90TopBlock(Xtra_Len=4, Xtra_Width=7, Xtra_Height=2, HasWireNotch=true);
				
				}
				
			cylinder(d=Ret_OD+3, h=H);
			
			// magnet holder
			rotate([0,0,Magnet_a]) translate([-Magnet_t/2-MagnetExtraOffset, Magnet_Y, Magnet_Z]) hull(){
				translate([0,-Magnet_d/2-2,0]) cylinder(d=Magnet_t, h=-Magnet_Z*2+1, center=true);
				translate([0,Magnet_d/2+2,0]) cylinder(d=Magnet_t, h=-Magnet_Z*2+1, center=true);
			}
				//cube([Magnet_t, Magnet_d+6, Magnet_d+6], center=true);
		} // union
		
		// Trim outside
		difference(){
			translate([0,0,-6-Overlap]) cylinder(d=Ret_OD+10, h=H+6);
			translate([0,0,-Overlap*2]) cylinder(d=Ret_OD+3+Overlap, h=H+Overlap*2);
			translate([0,0,-Overlap*2+Overlap-6]) cylinder(d2=Ret_OD+3+Overlap, d1=Ret_OD+3+Overlap+6, h=6);
		} // difference
		
		// Magnet
		rotate([0,0,Magnet_a]) translate([-Magnet_t/2-MagnetExtraOffset, Magnet_Y, Magnet_Z]) 
			rotate([0,90,0]) cylinder(d=Magnet_d, h=Magnet_t+2, center=true);
		
		// Bottom Bolt holes
		for (j=[0:nBottomBolts-1]) rotate([0,0,360/nBottomBolts*j])
			translate([0,BottomBoltCircle_d/2,-0.5]) rotate([180,0,0]) Bolt4HeadHole();
			
		// Center Hole
		if (HasCenterHole)
			hull(){
				translate([0,0,H]) cylinder(d=CenterHole_d, h=Overlap);
				translate([0,0,-4]) sphere(d=CenterHole_d);
			} // hull
			
	} // difference
} // CRBB_InnerBearingRetainer

//translate([0,0,-0.5]) CRBB_InnerBearingRetainer(HasServo=true, HasCenterHole=true);

module CRBB_InnerBearingRetainerLP(HasServo=true, HasCenterHole=false){
	// Low Profile version
	// Changed screw depth by -0.5

	H=6;
	MagnetExtraOffset=0.4; // <<< over center amount
	CenterHole_d=4.5;
	Servo_X=-1.3; // was 0
	Servo_Y=6; // was 5
	
	difference(){
		union(){
			if (HasServo)
				translate([Servo_X,Servo_Y,-12]) rotate([90,0,90]) translate([-3,1.5,-8]){
					ServoSG90TopBlock(Xtra_Len=4, Xtra_Width=8.7, Xtra_Height=2, HasWireNotch=false);
				
				}
				
			cylinder(d=Ret_OD+3, h=H);
			
			// magnet holder
			rotate([0,0,Magnet_a]) translate([-Magnet_t/2-MagnetExtraOffset, Magnet_Y, Magnet_Z]) hull(){
				translate([0,-Magnet_d/2-2,0]) cylinder(d=Magnet_t, h=-Magnet_Z*2+1, center=true);
				translate([0,Magnet_d/2+2,0]) cylinder(d=Magnet_t, h=-Magnet_Z*2+1, center=true);
			}
				//cube([Magnet_t, Magnet_d+6, Magnet_d+6], center=true);
		} // union
		
		// Trim outside
		translate([0,0,-30]) cylinder(d=60, h=14);
		
		translate([0,0,-30])
		difference(){
			cylinder(d=60, h=34);
			translate([0,0,-Overlap]) cylinder(d=53, h=34+Overlap*2);
		}
		
		// Magnet
		rotate([0,0,Magnet_a]) translate([-Magnet_t/2-MagnetExtraOffset, Magnet_Y, Magnet_Z]) 
			rotate([0,90,0]) cylinder(d=Magnet_d, h=Magnet_t+2, center=true);
		
		// Bottom Bolt holes
		for (j=[0:nBottomBolts-1]) rotate([0,0,360/nBottomBolts*j])
			translate([0,BottomBoltCircle_d/2,-0.5]) rotate([180,0,0]) Bolt4HeadHole(depth=8,lHead=11);
			
		// Center Hole
		if (HasCenterHole)
			hull(){
				translate([0,0,H]) cylinder(d=CenterHole_d, h=Overlap);
				translate([0,0,-4]) sphere(d=CenterHole_d);
			} // hull
			
	} // difference
} // CRBB_InnerBearingRetainerLP

// CRBB_InnerBearingRetainerLP(HasServo=true, HasCenterHole=true);




















