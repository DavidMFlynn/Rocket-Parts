// ***********************************
// Project: 3D Printed Rocket
// Filename: CableReleaseBBMicro.scad
// by David M. Flynn
// Created: 10/12/2025 
// Revision: 0.9.4  11/10/2025
// Units: mm
// ***********************************
//  ***** Notes *****
//
// A smaller lighter version of CableReleaseBB.
// Commonly used to keep springs compressed.
//
// This is a ball lock device. A pin is held in a housing by 5/16" Delrin balls.
// Rotation of over-center lock releases the pin.  The balls are held captive.
// Uses ball bearings for low force transfer.
//
//  ***** Hardware *****
//
//  #10-24 Eyebolt threaded rod or other attachment
//  5/16" Delrin Balls (3 Req.)
//  MR84-2RS Ball Bearing (3 Req.)
//  4mm Dia. x 16mm Undersize Dowel Pin (3 Req.)
//  #4-40 x 1/2" Button Head Cap Screw (3 Req.)
//  #4-40 x 1/4" Button Head Cap Screw (4 Req.)
//  #4-40 x 3/8" Socket Head Cap Screw (3 Req.)
//  6705-2RS Ball Bearing
//  MG90S Micro Servo
//  3/16" Dia. x 1/8" N42 Magnet (2 Req.)
//
//  ***** History *****
//
function CableReleaseBBMicroRev()="CableReleaseBBMicro Rev. 0.9.4";
echo(CableReleaseBBMicroRev());
// 0.9.4  11/10/2025  Smaller and smaller 6mm balls 6703 bearing
// 0.9.3  10/16/2025  First printing, Little fixes
// 0.9.2  10/12/2025  Copied from CableReleaseBBMini
// 0.9.1  9/21/2025   Seems to work, waiting for 6705-2RS for final testing
// 0.9.0  9/18/2025   Copied from CableReleaseBB 1.1.3
//
// ***********************************
//  ***** for STL output *****
//
// CRBBm_LockPinExtensionEnd();
// CRBBm_CenteringRingMount(OD=ULine38Body_ID,nRopes=3);
//
// CRBBm_ExtensionRod(LockPin_d=LockPin_d, Len=100, ID=0.190*25.4+IDXtra, Light=false);
// CRBBm_LockingPin(LockPin_d=LockPin_d, LockPin_Len=LockPin_Len, GuidePoint=false);
// rotate([180,0,0]) CRBBm_LockRing(LockPin_d=LockPin_d, Ball_d=Ball_d, nBalls=nBalls, GuidePoint=false);
// rotate([180,0,0]) CRBBm_TopRetainer(LockPin_d=LockPin_d, nBalls=nBalls, LockRing_d=CRBBm_LockRingDiameter(), Flange_t=4, OD=0, HasMountingBolts=true, GuidePoint=false, Light=true);
// CRBBm_OuterBearingRetainer(Light=true);
// rotate([180,0,0]) CRBBm_InnerBearingRetainer(HasServo=true);
// CRBBm_BlankInnerBearingRetainer(H=8, HasCenterHole=true, Light=true);
// rotate([180,0,0]) CRBBm_MagnetBracket();
// rotate([180,0,0]) CRBBm_TriggerPost();
//
// rotate([180,0,0]) CRBBm_SpringEnd(Coupler_OD=LOC65Coupler_OD);
//
// ***********************************
//  ***** Routines *****
//
// CRBBm_MountingBoltPattern(nTopBolts=nBalls, LockPin_d=LockPin_d) Bolt4Hole();
//
// function CRBBm_TopBoltCircle_d(LockRing_d=LockRing_d)=LockRing_d-Bolt4Inset*2;
// function CRBBm_LockRingDiameter()=LockRing_d;
//
// ***********************************
//  ***** for Viewing *****
//
// ShowCableReleaseBBMicro(GuidePoint=false);
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
Bolt4Inset=3;

LockPin_Len=18;
nBalls=3;

BearingMR84_ID=4;
BearingMR84_OD=8;
BearingMR84_H=3;

BearingMR63_ID=3;
BearingMR63_OD=6;
BearingMR63_H=2.5;

LockBearing_ID=BearingMR63_ID;
LockBearing_OD=BearingMR63_OD;
LockBearing_H=BearingMR63_H;

Bearing6703_ID=17;
Bearing6703_OD=23;
Bearing6703_H=4;

Bearing6704_ID=20;
Bearing6704_OD=27;
Bearing6704_H=4;

/*
// Smaller
Ball_d=5/16*25.4;
LockPin_d=12;
Bearing_ID=Bearing6704_ID;
Bearing_OD=Bearing6704_OD;
Bearing_H=Bearing6704_H;
StopOffset_a=0;
/**/
//*
// Smallest
Ball_d=6;
LockPin_d=12;
Bearing_ID=Bearing6703_ID;
Bearing_OD=Bearing6703_OD;
Bearing_H=Bearing6703_H;
StopOffset_a=-7;
/**/

GuidePoint_Len=LockPin_d/3;
GuidePoint_d=5;

LockRing_d=Bearing_OD+Bolt4Inset*4;
LockRing_h=20;

LockRingBoltCircle_d=Bearing_OD+Bolt4Inset*2;
nLockRingBolts=nBalls;

nBottomBolts=3;
BottomBoltCircle_d=Bearing_ID-Bolt4Inset*2;

Magnet_d=3/16*25.4;
Magnet_t=1/8*25.4;
Magnet_a=10;
Ret_OD=Bearing_ID+2;
Magnet_Y=-Ret_OD/2+Magnet_d/2+2;
Magnet_Z=-Magnet_d/2-2;

Dowel_d=LockBearing_ID;
Dowel_Len=16;

Lock_a=24;

function CRBBm_LockPinGrooveDepth(Ball_d=Ball_d)=Ball_d/4;
function CRBBm_BallCircle_d(LockPin_d=LockPin_d, Ball_d=Ball_d) = LockPin_d-CRBBm_LockPinGrooveDepth(Ball_d=Ball_d)*2+Ball_d;
function CRBBm_BearingCircle_d(LockPin_d=LockPin_d, Ball_d=Ball_d)=CRBBm_BallCircle_d(LockPin_d=LockPin_d, Ball_d=Ball_d)+Ball_d+LockBearing_OD+IDXtra;
function CRBBm_BottomBoltCircle_d()=BottomBoltCircle_d;
function CRBBm_TopBoltCircle_d(LockRing_d=LockRing_d)=LockRing_d-Bolt4Inset*2;
function CRBBm_LockRingDiameter()=LockRing_d;
function CRBBm_LockRingBoltCircle_d()=LockRingBoltCircle_d;

module ShowCableReleaseBBMicro(GuidePoint=false){
	Point_Len=GuidePoint? GuidePoint_Len:0;
	CT_Len=20;
	StopRing_Len=45;
	
	//translate([0,0,15.5]) color("LightBlue") CRBBm_ExtensionRod(Len=50);
	 
	CRBBm_LockRing(GuidePoint=GuidePoint);
	CRBBm_LockingPin(GuidePoint=GuidePoint);
	color("Green") CRBBm_TopRetainer(GuidePoint=GuidePoint);
	translate([0,0,-19.5-Point_Len]) rotate([0,0,-120]) color("Gray") CRBBm_MagnetBracket();
	translate([0,0,-19.5-Point_Len]) rotate([0,0,-360/9]) color("Gray") CRBBm_TriggerPost();
	
	difference(){
		union(){
			translate([0,0,-19-0.2-Point_Len]) color("Tan") CRBBm_OuterBearingRetainer();
			//translate([0,0,-20.0-0.2-Point_Len]) CRBBm_InnerBearingRetainer();
			//translate([0,0,-22.0-0.2-Point_Len]) rotate([0,0,60]) CRBBm_BlankInnerBearingRetainer(H=8, HasCenterHole=true, Light=true);
		} // union
		
		rotate([0,0,20]) translate([0,-50,-50]) cube([50,50,100]);
	} // difference
	
	
} // ShowCableReleaseBBMicro

// ShowCableReleaseBBMicro();

module CRBBm_BallGroove(LockPin_d=LockPin_d, Ball_d=Ball_d){
	BallCircle_d=CRBBm_BallCircle_d(LockPin_d=LockPin_d, Ball_d=Ball_d);
	
	rotate_extrude() translate([BallCircle_d/2,0,0]) 
		hull(){ circle(d=Ball_d); translate([1,1,0]) circle(d=Ball_d); }
	
} // BallGroove

// CRBBm_BallGroove();

module CRBBm_ShowBalls(LockPin_d=LockPin_d, Ball_d=Ball_d, nBalls=nBalls){
	for (j=[0:nBalls-1]) rotate([0,0,360/nBalls*j]) translate([0,CRBBm_BallCircle_d(LockPin_d=LockPin_d, Ball_d=Ball_d)/2,0])
		sphere(d=Ball_d);
} // CRBBm_ShowBalls

// CRBBm_ShowBalls();

module CRBBm_ShowBearings(LockPin_d=LockPin_d, Ball_d=Ball_d, nBalls=nBalls){
	for (j=[0:nBalls-1]) rotate([0,0,360/nBalls*j]) translate([0,CRBBm_BearingCircle_d(LockPin_d=LockPin_d, Ball_d=Ball_d)/2,0]){
		color("Red") cylinder(d=LockBearing_OD, h=LockBearing_H, center=true);
		translate([0,0,1]) color("Gray") cylinder(d=Dowel_d, h=Dowel_Len, center=true);
	}
} // CRBBm_ShowBearings

// CRBBm_ShowBearings();

module CRBBm_ExtensionRod(LockPin_d=LockPin_d, Len=100, ID=0.190*25.4+IDXtra, Light=false){
	Wall_t=1.2;
	Taper_h=(LockPin_d-ID)/2;
	
	difference(){
		if (Light && Len>12){
			// Middle
			cylinder(d=ID+Wall_t*2, h=Len);
			
			// Ends
			cylinder(d=LockPin_d, h=2+Overlap);
			translate([0,0,Len-2-Overlap]) cylinder(d=LockPin_d, h=2+Overlap);
			
			// Taper
			translate([0,0,2]) cylinder(d1=LockPin_d, d2=ID+Wall_t*2, h=Taper_h);
			translate([0,0,Len-2]) mirror([0,0,1]) cylinder(d1=LockPin_d, d2=ID+Wall_t*2, h=Taper_h);
		}else{
			cylinder(d=LockPin_d, h=Len);
		} // if
		
		translate([0,0,-Overlap]) cylinder(d=ID, h=Len+Overlap*2);
		
		if (Len>30 && !Light){
		translate([0,0,5]) cylinder(d1=ID, d2=LockPin_d-Wall_t*2, h=10);
		translate([0,0,15-Overlap]) cylinder(d=LockPin_d-Wall_t*2, h=Len-30+Overlap*2);
		translate([0,0,Len-15-Overlap]) cylinder(d2=ID, d1=LockPin_d-Wall_t*2, h=10);
		}
		
		if ($preview) translate([0,0,-Overlap]) cube([20,20,Len+1]);
	} // difference
} // CRBBm_ExtensionRod

// CRBBm_ExtensionRod(Len=23, Light=true);

module CRBBm_LockingPin(nBalls=nBalls, LockPin_d=LockPin_d, LockPin_Len=LockPin_Len, GuidePoint=false, IsThreaded=true){
	Point_Len=GuidePoint? GuidePoint_Len:0;
	Point_d=GuidePoint_d;
	Thread1024_d=0.190*25.4;
	Thread_d=Thread1024_d;
	Thread_p=25.4/24;
	
	difference(){
		union(){
			translate([0,0,-Ball_d]) cylinder(d=LockPin_d, h=LockPin_Len);
			if (GuidePoint)
				translate([0,0,-Ball_d-Point_Len]) 
					cylinder(d1=Point_d, d2=LockPin_d, h=Point_Len+Overlap);
		} // union
		
		CRBBm_BallGroove(LockPin_d=LockPin_d, Ball_d=Ball_d);
		
		translate([0,0,-Ball_d-Point_Len-Overlap]) 
			if ($preview || !IsThreaded){ 
				cylinder(d=Thread_d, h=LockPin_Len+Point_Len+Overlap*2); }
			else { 
				ExternalThread(Pitch=Thread_p, Dia_Nominal=Thread_d+IDXtra*2, 
							Length=LockPin_Len+Point_Len+Overlap*2, 
							Step_a=2,TrimEnd=true,TrimRoot=true); }
	} // difference
	
	if ($preview) color("White") 
		CRBBm_ShowBalls(LockPin_d=LockPin_d, Ball_d=Ball_d, nBalls=nBalls);
} // CRBBm_LockingPin

// CRBBm_LockingPin(LockPin_Len=LockPin_Len, GuidePoint=false);

module CRBBm_LockRing(LockPin_d=LockPin_d, Ball_d=Ball_d, nBalls=nBalls, GuidePoint=false){
	Point_Len=GuidePoint? GuidePoint_Len:0;
	Bearing_Z=Bearing_H+6+Ball_d/2;
	ID=CRBBm_BallCircle_d(LockPin_d=LockPin_d, Ball_d=Ball_d)+Ball_d+IDXtra*3;
	ThinWall_t=1.2;
	
	module BallGroove(LockPin_d=LockPin_d, Ball_d=Ball_d){
		hull(){
			rotate_extrude() 
				translate([CRBBm_BallCircle_d(LockPin_d=LockPin_d, Ball_d=Ball_d)/2+CRBBm_LockPinGrooveDepth(Ball_d=Ball_d),0,0]) 
					circle(d=Ball_d+0.4);
					
			translate([0,0,-Ball_d/2-2]) cylinder(d=ID, h=Overlap);
		} // hull
	
	} // BallGroove

	difference(){
		union(){
			difference(){
				translate([0,0,-Bearing_Z-Point_Len]) cylinder(d=Bearing_OD+IDXtra+ThinWall_t*2, h=LockRing_h+Point_Len);
				cylinder(d=Bearing_OD+IDXtra+ThinWall_t*2+Overlap, h=LockBearing_H+1, center=true);
			} // difference
			
			// Release Bearings
			for (j=[0:nBalls-1]) rotate([0,0,360/nBalls*j]) 
				translate([0,CRBBm_BearingCircle_d(LockPin_d=LockPin_d, Ball_d=Ball_d)/2,-7])
					hull(){
						cylinder(d=LockBearing_OD, h=13+Overlap/2);
						translate([0,-Dowel_d/2,0]) cylinder(d=LockBearing_OD+1, h=13+Overlap/2);
					} // hull
			
			// Bolts
			for (j=[0:nLockRingBolts-1]) rotate([0,0,360/nLockRingBolts*(j+0.5)])
				translate([0,LockRingBoltCircle_d/2,-Bearing_Z-Point_Len]) 
					hull(){
						cylinder(d=Bolt4Inset*2,h=Bearing_Z+Point_Len);
						translate([0,-Bolt4Inset,0]) scale([1,0.3,1]) cylinder(d=Bolt4Inset*2+1, h=LockRing_h+Point_Len);
					} // hull
		} // union
		
		// Bolt holes
		for (j=[0:nLockRingBolts-1]) rotate([0,0,360/nLockRingBolts*(j+0.5)])
			translate([0,LockRingBoltCircle_d/2,-Bearing_Z-Point_Len]) 
				rotate([180,0,0]) Bolt4Hole(depth=9);
		
		// Main Bearing
		translate([0,0,-Bearing_Z-Point_Len-Overlap]) 
			cylinder(d=Bearing_OD+IDXtra, h=Bearing_H+0.5);
			
		// ID
		translate([0,0,-Bearing_Z-Point_Len]) 
			cylinder(d=ID, h=LockRing_h+Point_Len+Overlap);
		
		BallGroove(LockPin_d=LockPin_d, Ball_d=Ball_d);
		
		// Bearings and pins
		for (j=[0:nBalls-1]) rotate([0,0,360/nBalls*j]) translate([0,CRBBm_BearingCircle_d(LockPin_d=LockPin_d, Ball_d=Ball_d)/2,0]){
			hull(){
				translate([0,Ball_d/2,0]) 
					cylinder(d=LockBearing_OD+2, h=LockBearing_H+1, center=true);
				translate([0,-Ball_d/2,0]) 
					cylinder(d=LockBearing_OD+2, h=LockBearing_H+1, center=true);
			} // hull
			
			// 4mm x 16mm dowel pin
			translate([0,0,2]) cylinder(d=Dowel_d+IDXtra, h=Dowel_Len, center=true);
			// stop support from going here
			translate([0,0,-8]) cylinder(d1=0.2, d2=Dowel_d+IDXtra, h=2+Overlap);
			
		}
		
		if ($preview) translate([0,-50,-30]) cube([50,50,100]);
			
	} // difference
	
	if ($preview) CRBBm_ShowBearings(nBalls=nBalls);
} // CRBBm_LockRing

// rotate([180,0,0]) CRBBm_LockRing(LockPin_d=LockPin_d, Ball_d=Ball_d, nBalls=nBalls, GuidePoint=false);
// CRBBm_LockRing(nBalls=nBalls, GuidePoint=true);

module CRBBm_OuterBearingRetainer(Light=true){
	H=5.1; // 17 layers
	BearingP=0.6; // 2 layers
	
	difference(){
		if (Light){
			cylinder(d=Bearing_OD, h=H+BearingP);
			cylinder(d=Bearing_OD+2, h=H);
			
			for (j=[1:nLockRingBolts*3-2]) rotate([0,0,360/(nLockRingBolts*3)*(j+0.5)])
				translate([0,LockRingBoltCircle_d/2,0]) hull(){
					cylinder(d=Bolt4Inset*2, h=H);
					translate([0,-Bolt4Inset,0]) scale([1,0.2,1]) cylinder(d=Bolt4Inset*2+1, h=H);
				} // hull
		}else{
			cylinder(d=LockRing_d, h=H);
			cylinder(d=Bearing_OD, h=H+BearingP);
		} // if
		
		// center hole
		translate([0,0,-Overlap]) cylinder(d=Bearing_OD-3, h=H+BearingP+Overlap*2);
		
		// Bolt holes
		for (j=[0:nLockRingBolts-1]) rotate([0,0,360/nLockRingBolts*(j+0.5)])
			translate([0,LockRingBoltCircle_d/2,0]) rotate([180,0,0]) Bolt4ButtonHeadHole();
			
		// accessory bolt holes
		for (j=[0:nLockRingBolts*3-1]) rotate([0,0,360/(nLockRingBolts*3)*(j+0.5)])
			translate([0,LockRingBoltCircle_d/2,H]) Bolt4Hole();
	} // difference
} // CRBBm_OuterBearingRetainer

// CRBBm_OuterBearingRetainer(Light=true);

module CRBBm_MagnetBracket(){
	MagnetExtraOffset=0.1; // <<< over center amount
	Magnet_Z=Magnet_d/2+5.5;
	H=5.1;
	Post_Y=LockRingBoltCircle_d/2;
	Magnet_a=StopOffset_a;
	
	difference(){
		union(){
			for (j=[0:360/(nLockRingBolts*3)-1]) hull(){
				rotate([0,0,360/(nLockRingBolts*3)*(9+0.5)-j])
					translate([0,Post_Y,-3]) cylinder(d=Bolt4Inset*2, h=3);
				rotate([0,0,360/(nLockRingBolts*3)*(9+0.5)-j-1])
					translate([0,Post_Y,-3]) cylinder(d=Bolt4Inset*2, h=3);
			}
			
			// magnet holder
			rotate([0,0,Magnet_a])
			translate([-Magnet_t/2-MagnetExtraOffset, Post_Y, -Magnet_Z-3.5]) hull(){
					translate([0,-3,0]) cylinder(d=Magnet_t, h=Magnet_Z+3.5);
					translate([0,3,0]) cylinder(d=Magnet_t, h=Magnet_Z+3.5);
			} // hull
		} // union
		
		// Bolt holes
		rotate([0,0,360/(nLockRingBolts*3)*(9+0.5)])
					translate([0,Post_Y,-3.5]) rotate([180,0,0]) Bolt4ButtonHeadHole(depth=8,lHead=6);
		rotate([0,0,360/(nLockRingBolts*3)*(8+0.5)])
					translate([0,Post_Y,-3.5]) rotate([180,0,0]) Bolt4ButtonHeadHole(depth=8,lHead=6);
					
		// Magnet
		rotate([0,0,Magnet_a])
		translate([-Magnet_t/2-MagnetExtraOffset, Post_Y, -Magnet_Z]) 
			rotate([0,90,0]) cylinder(d=Magnet_d, h=Magnet_t+2, center=true);
	} // difference
} // CRBBm_MagnetBracket

// CRBBm_MagnetBracket();

module CRBBm_TriggerPost(){
	H=5.1;
	MountingHole=3;
	Post_H=8;
	Post_Y=LockRingBoltCircle_d/2;
	Post_a=StopOffset_a;
	
	difference(){
		union(){
			// Base
			for (j=[0:360/(nLockRingBolts*3)-1]) hull(){
				rotate([0,0,360/(nLockRingBolts*3)*(MountingHole+0.5)+j])
					translate([0,Post_Y,-3]) cylinder(d=Bolt4Inset*2, h=3);
				rotate([0,0,360/(nLockRingBolts*3)*(MountingHole+0.5)+j+1])
					translate([0,Post_Y,-3]) cylinder(d=Bolt4Inset*2, h=3);
			}
			
			// trigger post
			rotate([0,0,Post_a])
			rotate([0,0,360/(nLockRingBolts*3)*(MountingHole+1)]) translate([-1.5, Post_Y, -Post_H/2]) hull(){
				translate([0,-3,0]) cylinder(d=3, h=Post_H, center=true);
				translate([0,3,0]) cylinder(d=3, h=Post_H, center=true);
					
			}
		} // union
		
		// Bolt holes
		rotate([0,0,360/(nLockRingBolts*3)*(MountingHole+0.5)])
					translate([0,Post_Y,-3.5]) rotate([180,0,0]) Bolt4ButtonHeadHole();
		rotate([0,0,360/(nLockRingBolts*3)*(MountingHole+1+0.5)])
					translate([0,Post_Y,-3.5]) rotate([180,0,0]) Bolt4ButtonHeadHole();
			
	} // difference
} // CRBBm_TriggerPost

// CRBBm_TriggerPost();

module CRBBm_MountingBoltPattern(nTopBolts=nBalls, LockPin_d=LockPin_d){
	for (j=[0:nTopBolts-1]) rotate([0,0,360/nTopBolts*(j+0.5)+Lock_a/2])
			translate([0,LockPin_d/2+Bolt4Inset*2,0]) children();
} // CRBBm_MountingBoltPattern

// CRBBm_MountingBoltPattern(nTopBolts=nBalls) Bolt4Hole();


module CRBBm_TopRetainer(LockPin_d=LockPin_d, nBalls=nBalls, Ball_d=Ball_d, LockRing_d=CRBBm_LockRingDiameter(), Flange_t=4, OD=0, HasMountingBolts=true, GuidePoint=false, Light=true){

	Point_Len=GuidePoint? GuidePoint_Len:0;
	Bearing_Z=Bearing_H+6+Ball_d/2;
	TopRetainer_Len=20.5+Flange_t;
	LockStart_a=-0.5;
	Flange_OD=(OD>0)? OD:LockRing_d;
	
	difference(){
		union(){
			if (Light){
				translate([0,0,-Bearing_Z+LockRing_h+0.5]) 
					cylinder(d=CRBBm_BallCircle_d(LockPin_d=LockPin_d, Ball_d=Ball_d)+Ball_d, h=Flange_t);
				
				if (HasMountingBolts)
					translate([0,0,-Bearing_Z+LockRing_h+0.5]) 
						CRBBm_MountingBoltPattern(nTopBolts=nBalls, LockPin_d=LockPin_d) hull(){
							cylinder(d=Bolt4Inset*2, h=Flange_t);
							translate([0,-8,0]) cylinder(d=Bolt4Inset*2+2, h=Flange_t);
						} // hull
						
				// Rotation limit slots
				for (j=[0:nBalls-1])
					for (k=[-8:Lock_a+7]) translate([0,0,-Bearing_Z+LockRing_h+0.5]) hull(){
						rotate([0,0,360/nBalls*j+k+LockStart_a]) 
							translate([0,CRBBm_BearingCircle_d(LockPin_d=LockPin_d, Ball_d=Ball_d)/2,0]){ 
								translate([0,-1.5,0]) cylinder(d=3, h=Flange_t);
								translate([0,-8,0]) cylinder(d=6, h=Flange_t);
							}
						rotate([0,0,360/nBalls*j+k+1+LockStart_a]) 
							translate([0,CRBBm_BearingCircle_d(LockPin_d=LockPin_d, Ball_d=Ball_d)/2,0]){
								translate([0,-1.5,0]) cylinder(d=3, h=Flange_t);
								translate([0,-8,0]) cylinder(d=6, h=Flange_t);
							}
			}
			}else{
				
				// Flange
				translate([0,0,-Bearing_Z+LockRing_h+0.5]) cylinder(d=Flange_OD, h=Flange_t);
			} // if
			
			// Bearing, one layer less than Bearing_H
			translate([0,0,-Bearing_Z-Point_Len+0.3]) cylinder(d=Bearing_ID, h=Bearing_H+Overlap);
			
			// Body
			translate([0,0,-Bearing_Z-Point_Len+Bearing_H]) 
				cylinder(d=CRBBm_BallCircle_d(LockPin_d=LockPin_d, Ball_d=Ball_d)+Ball_d, h=TopRetainer_Len+Point_Len-Bearing_H);
			
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
				CRBBm_MountingBoltPattern(nTopBolts=nBalls, LockPin_d=LockPin_d) Bolt4Hole();
		
		// Bottom Bolt holes
		for (j=[0:nBottomBolts-1]) rotate([0,0,360/nBottomBolts*j+180/nBottomBolts])
			translate([0,BottomBoltCircle_d/2,-Bearing_Z-Point_Len]) 
				rotate([180,0,0]) Bolt4Hole(depth=8+Point_Len);
		
		// Center hole
		translate([0,0,-Bearing_Z-Point_Len-Overlap]) 
			cylinder(d=BottomBoltCircle_d-Bolt4Inset*2, h=Bearing_Z+Point_Len);
		
		// Lock ball holes
		for (j=[0:nBalls-1]) rotate([0,0,360/nBalls*j]) translate([0,CRBBm_BallCircle_d(LockPin_d=LockPin_d, Ball_d=Ball_d)/2,0]) hull(){
			sphere(d=Ball_d+IDXtra*2);
			translate([0,3,0]) sphere(d=Ball_d+IDXtra*2);
			translate([0,3,-0.375]) scale([1,1,1.05]) sphere(d=Ball_d+IDXtra*2); // helps print cleaner
		}
		
		// Rotation limit slots
		for (j=[0:nBalls-1])
			for (k=[0:Lock_a-1]) hull(){
				rotate([0,0,360/nBalls*j+k+LockStart_a]) 
					translate([0,CRBBm_BearingCircle_d(LockPin_d=LockPin_d, Ball_d=Ball_d)/2,-Bearing_Z+LockRing_h+0.5-Overlap]) 
						cylinder(d=LockBearing_ID+IDXtra*3, h=5);
				rotate([0,0,360/nBalls*j+k+1+LockStart_a]) 
					translate([0,CRBBm_BearingCircle_d(LockPin_d=LockPin_d, Ball_d=Ball_d)/2,-Bearing_Z+LockRing_h+0.5-Overlap]) 
						cylinder(d=LockBearing_ID+IDXtra*3, h=5);
			}
			
		if ($preview)
			translate([0,-50,-30]) cube([50,50,100]);
	} // difference
	
} // CRBBm_TopRetainer

// CRBBm_TopRetainer(LockPin_d=16, nBalls=nBalls, LockRing_d=CRBBm_LockRingDiameter(), Flange_t=4, OD=0, HasMountingBolts=true, GuidePoint=false, Light=true);
// CRBBm_LockingPin();
// CRBBm_TopRetainer(LockRing_d=CRBBm_LockRingDiameter(), HasMountingBolts=true, GuidePoint=false);

module CRBBm_InnerBearingRetainer(HasServo=true, HasCenterHole=false){
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
				
			cylinder(d=Ret_OD, h=H);
			
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
			translate([0,0,-Overlap*2]) cylinder(d=Ret_OD+Overlap, h=H+Overlap*2);
			translate([0,0,-Overlap*2+Overlap-6]) cylinder(d2=Ret_OD+Overlap, d1=Ret_OD+3+Overlap+6, h=6);
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
} // CRBBm_InnerBearingRetainer

//translate([0,0,-0.5]) CRBBm_InnerBearingRetainer(HasServo=true, HasCenterHole=true);

module CRBBm_BlankInnerBearingRetainer(H=8, HasCenterHole=true, IsThreaded=false, Light=false){
	Wall_t=1.8;
	Spoke_W=2.2;
	CenterHole_d=6;
	
	difference(){
		if (Light){
			difference(){
				cylinder(d=Ret_OD, h=H);
				translate([0,0,-Overlap]) cylinder(d=Ret_OD-Wall_t*2, h=H+Overlap*2);
			} // difference
			
			if (HasCenterHole)
				cylinder(d=CenterHole_d+Wall_t*2, h=H);
				
			// Bottom Bolt holes
			for (j=[0:nBottomBolts-1]) rotate([0,0,360/nBottomBolts*j]){
				translate([0,BottomBoltCircle_d/2,0]) cylinder(d=7, h=H);
				hull(){
					translate([0,BottomBoltCircle_d/2,0]) cylinder(d=Spoke_W, h=H);
					translate([0,Ret_OD/2-Wall_t,0]) cylinder(d=Spoke_W, h=H);
				} // hull
				if (HasCenterHole) hull(){
					translate([0,BottomBoltCircle_d/2,0]) cylinder(d=Spoke_W, h=H);
					cylinder(d=Spoke_W, h=H);
				} // hull
				}
		}else{
			cylinder(d=Ret_OD, h=H);
		}
		
		// Bottom Bolt holes
		for (j=[0:nBottomBolts-1]) rotate([0,0,360/nBottomBolts*j])
			translate([0,BottomBoltCircle_d/2,-0.5]) rotate([180,0,0]) Bolt4ClearHole();
			
			
		if (IsThreaded)	{
			// 1/4-20 for 29mm RMS
			Thread_d=0.250*25.4;
			Thread_p=25.4/20;
			translate([0,0,-Overlap])
				if ($preview){
					cylinder(d=Thread_d, h=H+Overlap*2); 
				}else{
					ExternalThread(Pitch=Thread_p, Dia_Nominal=Thread_d+IDXtra*2, 
							Length=H+Overlap*2, 
							Step_a=2,TrimEnd=true,TrimRoot=true);
				}
		}else{
			// Center Hole
			if (HasCenterHole) translate([0,0,-Overlap]) cylinder(d=CenterHole_d, h=H+Overlap*2); 
				
		}
		
	} // difference
} // CRBBm_BlankInnerBearingRetainer

// CRBBm_BlankInnerBearingRetainer(H=8, HasCenterHole=true, IsThreaded=true, Light=true);

module CRBBm_InnerBearingRetainerLP(HasServo=true, HasCenterHole=false){
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
				
			cylinder(d=Ret_OD, h=H);
			
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
} // CRBBm_InnerBearingRetainerLP

// CRBBm_InnerBearingRetainerLP(HasServo=false, HasCenterHole=true);

module CRBB_Activator_BoltBoss(D=8, H=5){
	OD=Coupler_OD;
	ID=Coupler_ID;
	BC_r=ID/2-3.0;
	
	difference(){
		hull(){
			translate([0,BC_r,0]) cylinder(d=D, h=H);
			translate([0,ID/2,0]) scale([1,0.1,1]) cylinder(d=D+2, h=H);
		} // hull
		translate([0,BC_r,H]) children();
	} // difference
	
} // CRBB_Activator_BoltBoss

CRBB_Activator_Bolt_a=[22.5,162,253,323];
/*
for (j=CRBB_Activator_Bolt_a) rotate([0,0,j]) {
translate([0,0,EBay_Len-5]) CRBB_Activator_BoltBoss(D=7, H=5) Bolt4Hole();
translate([0,0,EBay_Len]) CRBB_Activator_BoltBoss(D=7, H=4.5) Bolt4ClearHole();
}
/**/

module CRBBm_Activator(OD=LOC54Coupler_OD){
	// only works for 54mm tubes
	Plate_t=6;
	Plate_d=CRBBm_BottomBoltCircle_d()+Bolt4Inset*2+3;
	Plate_a=60;
	
	Magnet_d=3/16*25.4;
	Magnet_Z=-3-Magnet_d/2;
	Magnet_a=360/9*6+StopOffset_a;
	
	Servo_Z=-19;
	Servo_Y=12.5;
	ServoRot_a=-20;
	ServoPos_a=360/9*3-17+StopOffset_a;
	
	module TopMountingBolts(){
		nBolts=3;
		
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+Plate_a])
			translate([0,CRBBm_BottomBoltCircle_d()/2,1.6])
				rotate([180,0,0]) Bolt4ClearHole(depth=Plate_t+8);
	} // TopMountingBolts
	
	module MagnetHole(){
		translate([0,0,Magnet_Z]) rotate([0,90,0]) cylinder(d=Magnet_d, h=8, center=true);
	} // MagnetHole
	
	module MagnetPost(){
		H=-Servo_Z-2;
		W=3.5;
		
		rotate([0,0,Magnet_a])
		difference(){
			hull(){
				translate([W-1.5,CRBBm_LockRingBoltCircle_d()/2-3,-2-H+8]) cylinder(d=W, h=H-8);
				translate([W-1.5,CRBBm_LockRingBoltCircle_d()/2+4,-2-H+3]) cylinder(d=W, h=H-3);
				translate([W-1.5,OD/2-W/2-0.1,-2-H]) cylinder(d=W, h=6);
			} // hull
			
			translate([W,CRBBm_LockRingBoltCircle_d()/2,0]) MagnetHole();
		} // difference
	} // MagnetPost
	
	MagnetPost();
	
	module Spoke(){
		hull(){
			translate([0,Plate_d/2-1.2,-Plate_t]) cylinder(d=1.2, h=Plate_t);
			translate([0,OD/2-0.6,Servo_Z]) cylinder(d=1.2, h=6.5);
		} // hull
	} // Spoke
	
	module ServoBrace(Len=8.5){
		hull(){
			translate([0,OD/2-0.6,Servo_Z+2.5]) cylinder(d=1.2, h=4.5);
			translate([0,OD/2-Len,Servo_Z+2.5]) cylinder(d=1.2, h=4.5);
		} // hull
	} // ServoBrace
	
	// Spokes
	rotate([0,0,67+ServoPos_a]) Spoke();
	rotate([0,0,100+ServoPos_a]) Spoke();
	//rotate([0,0,135+ServoPos_a]) Spoke();
	rotate([0,0,180+ServoPos_a]) Spoke();
	rotate([0,0,247+ServoPos_a]) Spoke();
	rotate([0,0,296+ServoPos_a]) Spoke();
	difference(){
		rotate([0,0,Magnet_a-4]) Spoke();
		rotate([0,0,Magnet_a])
			translate([3.5,CRBBm_LockRingBoltCircle_d()/2,0]) MagnetHole();
	} // difference
	
	rotate([0,0,14+ServoPos_a]) ServoBrace(Len=6.5);
	rotate([0,0,25+ServoPos_a]) ServoBrace(Len=6.5);
	rotate([0,0,50+ServoPos_a]) ServoBrace(Len=9.5);
	rotate([0,0,270+ServoPos_a]) ServoBrace(Len=8);
	rotate([0,0,290+ServoPos_a]) ServoBrace(Len=6);
	rotate([0,0,303+ServoPos_a]) ServoBrace(Len=6);
	
	difference(){
		union(){
			translate([0,0,-Plate_t]) rotate([0,0,Plate_a]) 
				CRBBm_BlankInnerBearingRetainer(H=Plate_t+8, HasCenterHole=true, IsThreaded=false, Light=true);
			
			intersection(){
				rotate([0,0,ServoPos_a]) translate([0,Servo_Y,Servo_Z])
					rotate([0,0,ServoRot_a]) ServoSG90TopBlock(Xtra_Len=4, Xtra_Width=-Overlap, Xtra_Height=2, HasWireNotch=false);
					
				translate([0,0,Servo_Z]) cylinder(d=OD, h=10);
			} // intersection

		} // union
		
		for (j=[0:2]) rotate([0,0,120*j+60]) translate([0,BottomBoltCircle_d/2,1.5]) rotate([180,0,0]) Bolt4HeadHole();
		
		
		translate([0,0,-Plate_t-Overlap]) cylinder(d=16, h=10.5);
		
		rotate([0,0,ServoPos_a]) translate([0,Servo_Y,Servo_Z+10])
			hull(){
				cylinder(d=10, h=8);
				translate([0,3,0]) cylinder(d=12, h=8);
			} // hull
		
		TopMountingBolts();
		
	} // difference
		
	translate([0,0,Servo_Z]) rotate([0,0,ServoPos_a+77]) EBay_TopPlate(OD=OD);
	
	if ($preview){
	rotate([0,0,ServoPos_a]) translate([0,Servo_Y,Servo_Z]) color("Red") rotate([0,0,ServoRot_a]) ServoSG90(TopMount=false, HasGear=false);
	//translate([0,0,Servo_Z+3]) cylinder(d=Body_ID, h=1);
	}
	
} // CRBBm_Activator

//translate([0,0,81.7]) rotate([0,0,125]) 
// CRBBm_Activator();
//translate([0,0,22]) ShowCableReleaseBBMicro();

module EBay_TopPlate(OD=LOC54Coupler_OD, MotorTube_OD=LOC29Body_OD){
	nOuterBolts=2;
	Outer_BC_d=MotorTube_OD+(OD-MotorTube_OD)/2;
	Boss_t=8;
	Thread1024_d=0.190*25.4;
	Activator_a=178;
	
	difference(){
		Tube(OD=OD, ID=OD-4, Len=Boss_t, myfn=$preview? 90:360);
		// Rivet hole
		rotate([0,0,90]) translate([0,OD/2,Boss_t/2]) rotate([90,0,0]) cylinder(d=4, h=10, center=true);
	} // difference
	
	ShockCord_a=160;
	//for (j=CRBB_Activator_Bolt_a) rotate([0,0,j+Activator_a]) 
	//	CRBB_Activator_BoltBoss(D=7, H=Boss_t) Bolt4Hole();

	module BoltBoss(H=Boss_t){
		translate([0,Outer_BC_d/2,0]) 
			hull(){
				cylinder(d=Thread1024_d+4.4, h=H);
				translate([0,5,0]) scale([1,0.1,1]) cylinder(d=Thread1024_d+6.4, h=H);
			} // hull
	} // BoltBoss
	
	difference(){
		union(){
			if (nOuterBolts>0)
				for (j=[0:nOuterBolts-1]) rotate([0,0,360/nOuterBolts*j])
					BoltBoss(H=Boss_t);
				
			// Shock cord guide
			rotate([0,0,ShockCord_a]) BoltBoss(H=3);
		} // union
				
		
		rotate([0,0,ShockCord_a]) translate([0,Outer_BC_d/2,-Overlap]) cylinder(d=5, h=Boss_t+Overlap*2); 
		
		if (nOuterBolts>0)
		for (j=[0:nOuterBolts-1]) rotate([0,0,360/nOuterBolts*j])
			translate([0,Outer_BC_d/2,-Overlap]) {
				Thread_d=Thread1024_d;
				Thread_p=25.4/24;
		
				//translate([0,0,-Overlap])
				//	cylinder(d1=Thread_d+2, d2=Thread_d, h=2);
				
				if ($preview){
					cylinder(d=Thread_d, h=Boss_t+Overlap*2); 
				}else{
					ExternalThread(Pitch=Thread_p, Dia_Nominal=Thread_d+IDXtra*2, 
							Length=Boss_t+Overlap*2, 
							Step_a=2,TrimEnd=true,TrimRoot=true);
				}}
	} // difference
} // EBay_TopPlate

// translate([0,0,EBay_Len-8]) EBay_TopPlate();


module CRBBm_Activator38(OD=ULine38Body_ID-IDXtra){
	// only works for 38mm tubes
	Plate_t=6;
	Plate_d=CRBBm_BottomBoltCircle_d()+Bolt4Inset*2+3;
	Plate_a=60;
	
	Magnet_d=3/16*25.4;
	Magnet_Z=-3-Magnet_d/2;
	Magnet_a=360/9*6+StopOffset_a;
	
	
	module TopMountingBolts(){
		nBolts=3;
		
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+Plate_a])
			translate([0,CRBBm_BottomBoltCircle_d()/2,1.6])
				rotate([180,0,0]) Bolt4ClearHole(depth=Plate_t+8);
	} // TopMountingBolts
	
	module MagnetHole(){
		translate([0,0,Magnet_Z]) rotate([0,90,0]) cylinder(d=Magnet_d, h=8, center=true);
	} // MagnetHole
	
	module MagnetPost(){
		H=-Ring_Z;
		W=3.5;
		
		intersection(){
		
			rotate([0,0,Magnet_a])
				difference(){
					hull(){
						#translate([W-1.5,CRBBm_LockRingBoltCircle_d()/2-4.5,-H+8]) cylinder(d=W, h=H-10);
						translate([W-1.5,CRBBm_LockRingBoltCircle_d()/2+4,-H+3]) cylinder(d=W, h=H-5);
						translate([W-1.5,OD/2-W/2-0.1,-H]) cylinder(d=W, h=4);
					} // hull
					
					translate([W,CRBBm_LockRingBoltCircle_d()/2,0]) MagnetHole();
				} // difference
				
			translate([0,0,-H-2]) cylinder(d=OD, h=18);
		} // intersection
		
	} // MagnetPost
	
	MagnetPost();
	
	module Spoke(){
		hull(){
			translate([0,Plate_d/2-1.2,-Plate_t]) cylinder(d=1.2, h=Plate_t);
			translate([0,OD/2-0.6,Ring_Z]) cylinder(d=1.2, h=6.5);
		} // hull
	} // Spoke
	
	module ServoBrace(Len=8.5){
		hull(){
			translate([0,OD/2-0.6,Ring_Z]) cylinder(d=1.2, h=8);
			translate([0,OD/2-Len,Ring_Z]) cylinder(d=1.2, h=8);
		} // hull
	} // ServoBrace
	
	// Spokes
	
	rotate([0,0,80]) Spoke();
	rotate([0,0,15]) Spoke();
	rotate([0,0,-15]) Spoke();
	rotate([0,0,195]) Spoke();
	rotate([0,0,165]) Spoke();
	//rotate([0,0,296+ServoPos_a]) Spoke();
	/*
	difference(){
		rotate([0,0,Magnet_a-5]) Spoke();
		rotate([0,0,Magnet_a])
			translate([3.5,CRBBm_LockRingBoltCircle_d()/2,0]) MagnetHole();
	} // difference
	/**/
	
			rotate([0,0,58]) ServoBrace(Len=9);
			rotate([0,0,45]) ServoBrace(Len=11);
			rotate([0,0,160]) ServoBrace(Len=9.5);
			rotate([0,0,165]) ServoBrace(Len=11);

	/*rotate([0,0,50+ServoPos_a]) ServoBrace(Len=9.5);
	rotate([0,0,270+ServoPos_a]) ServoBrace(Len=8);
	rotate([0,0,290+ServoPos_a]) ServoBrace(Len=6);
	rotate([0,0,303+ServoPos_a]) ServoBrace(Len=6);
	/**/
	
	Servo_Z=-12.5; // use -18 to include mounting bolt
	Servo_X=0;
	Servo_Y=0;
	ServoRot_a=180;
	ServoPos_a=18;
	Ring_Z=-18;

	difference(){
		union(){
			translate([0,0,-Plate_t]) rotate([0,0,Plate_a]) 
				CRBBm_BlankInnerBearingRetainer(H=Plate_t+8, HasCenterHole=true, IsThreaded=false, Light=true);
			
			
			intersection(){
				rotate([0,0,ServoPos_a]) translate([Servo_X,Servo_Y,Servo_Z])
				rotate([0,0,ServoRot_a]) 
					rotate([0,90,0]) ServoSG90TopBlock(Xtra_Len=4, Xtra_Width=5, Xtra_Height=2, HasWireNotch=false);
					
				translate([0,0,Ring_Z]) cylinder(d=OD, h=15);
			} // intersection
			

		} // union
		
		for (j=[0:2]) rotate([0,0,120*j+60]) translate([0,BottomBoltCircle_d/2,1.5]) 
			rotate([180,0,0]) Bolt4HeadHole();
		
		// remove inside of InnerBearingRetainer
		translate([0,0,-Plate_t-Overlap]) cylinder(d=16, h=10.5);
		
		TopMountingBolts();
		
	} // difference
		
	translate([0,0,Ring_Z]) EBay_TopPlate38(OD=OD);
	
	if ($preview){
		rotate([0,0,ServoPos_a]) translate([Servo_X,Servo_Y,Servo_Z]) color("Red") 
			rotate([0,0,ServoRot_a]) rotate([0,90,0]) ServoSG90(TopMount=false, HasGear=false);
	//translate([0,0,Servo_Z+3]) cylinder(d=Body_ID, h=1);
	}
	
} // CRBBm_Activator38

// CRBBm_Activator38();
// translate([0,0,22]) ShowCableReleaseBBMicro();

Bolt10Inset=5.5;

module EBay_TopPlate38(OD=ULine38Body_ID-IDXtra){
	nOuterBolts=2;
	Outer_BC_d=OD-Bolt10Inset*2;
	Boss_t=8;
	Thread1024_d=0.190*25.4;
	Activator_a=178;
	nRivets=3;
	Rivet_d=4;
	Rivet_a=-30;
	ShockCord_a=30;
	
	difference(){
		Tube(OD=OD, ID=OD-4, Len=Boss_t, myfn=$preview? 90:360);
		
		// Rivet holes
		for (j=[0:nRivets-1]) rotate([0,0,360/nRivets*j+Rivet_a])
			translate([0,OD/2,Boss_t/2]) rotate([90,0,0]) cylinder(d=4, h=10, center=true);
	} // difference
	
	//for (j=CRBB_Activator_Bolt_a) rotate([0,0,j+Activator_a]) 
	//	CRBB_Activator_BoltBoss(D=7, H=Boss_t) Bolt4Hole();

	module BoltBoss(H=Boss_t){
		 
			hull(){
				translate([0,Outer_BC_d/2,0]) cylinder(d=Thread1024_d+4.4, h=H);
				translate([0,OD/2-1,0]) scale([1,0.1,1]) cylinder(d=Thread1024_d+6.4, h=H);
			} // hull
	} // BoltBoss
	
	difference(){
		union(){
			if (nOuterBolts>0)
				for (j=[0:nOuterBolts-1]) rotate([0,0,360/nOuterBolts*j])
					BoltBoss(H=Boss_t);
				
			// Shock cord guide
			rotate([0,0,ShockCord_a]) BoltBoss(H=3);
		} // union
				
		
		rotate([0,0,ShockCord_a]) translate([0,Outer_BC_d/2,-Overlap]) cylinder(d=5, h=Boss_t+Overlap*2); 
		
		if (nOuterBolts>0)
		for (j=[0:nOuterBolts-1]) rotate([0,0,360/nOuterBolts*j])
			translate([0,Outer_BC_d/2,-Overlap]) {
				Thread_d=Thread1024_d;
				Thread_p=25.4/24;
		
				//translate([0,0,-Overlap])
				//	cylinder(d1=Thread_d+2, d2=Thread_d, h=2);
				
				if ($preview){
					cylinder(d=Thread_d, h=Boss_t+Overlap*2); 
				}else{
					ExternalThread(Pitch=Thread_p, Dia_Nominal=Thread_d+IDXtra*2, 
							Length=Boss_t+Overlap*2, 
							Step_a=2,TrimEnd=true,TrimRoot=true);
				}}
	} // difference
} // EBay_TopPlate38

// translate([0,0,EBay_Len-8]) EBay_TopPlate38();


module CRBBm_ServoMount38(OD=ULine38Body_ID-IDXtra){	
	Servo_Z=-12.5; // use -18 to include mounting bolt
	Servo_X=0;
	Servo_Y=0;
	ServoRot_a=180;
	ServoPos_a=18;
	Ring_Z=-18-17.5;
	
	module ServoBrace(Len=8.5){
		hull(){
			translate([0,OD/2-0.6,Ring_Z]) cylinder(d=1.2, h=8);
			translate([0,OD/2-Len,Ring_Z]) cylinder(d=1.2, h=8);
		} // hull
	} // ServoBrace
	
	rotate([0,0,58]) ServoBrace(Len=9);
	rotate([0,0,45]) ServoBrace(Len=11);
	rotate([0,0,160]) ServoBrace(Len=9.5);
	rotate([0,0,165]) ServoBrace(Len=11);

	intersection(){
		rotate([0,0,ServoPos_a]) translate([Servo_X,Servo_Y,Servo_Z])
		rotate([0,0,ServoRot_a]) 
			rotate([0,90,0]) ServoSG90TopBlock(Xtra_Len=4, Xtra_Width=5, Xtra_Height=2, HasWireNotch=false);
			
		translate([0,0,Ring_Z]) cylinder(d=OD, h=15);
	} // intersection
				
	translate([0,0,Ring_Z]) EBay_TopPlate38(OD=OD);
	
	if ($preview)
		rotate([0,0,ServoPos_a]) translate([Servo_X,Servo_Y,Servo_Z]) color("Red") 
			rotate([0,0,ServoRot_a]) rotate([0,90,0]) ServoSG90(TopMount=false, HasGear=false);
	
} // CRBBm_ServoMount38

// CRBBm_ServoMount38();
// CRBBm_Activator38();
// translate([0,0,22]) ShowCableReleaseBBMicro();


module CRBBm_CenteringRingMount(OD=LOC54Coupler_OD,nRopes=6){
	Rope_d=3;
	
	
	Spring_Z=3.5;
	Thickness=6;
	Wall_t=1.2;
	nBolts=3;
	myFn=floor(OD)*3;
	CRBBm_Bolt_a=-12+30;
	Rope_Y=OD/2-Rope_d/2-Wall_t-0.5;
	Spring_OD=SE_Spring3670_OD();
	Spring_ID=SE_Spring3670_ID();
	Boss_t=2;
	
	difference(){
		union(){
			// Body centering
			Tube(OD=OD, ID=OD-Wall_t*2, Len=Thickness, myfn=$preview? 90:myFn);
			
			// Spring
			Tube(OD=Spring_OD+Wall_t*2, ID=Spring_OD, Len=Thickness, myfn=$preview? 90:myFn);
			Tube(OD=Spring_OD+Wall_t*2, ID=Spring_ID, Len=Spring_Z, myfn=$preview? 90:myFn);
			
			// Lock Pin Guide Hole
			Tube(OD=LockPin_d+1+Wall_t*2, ID=LockPin_d+1, Len=Spring_Z, myfn=$preview? 90:myFn);
			
			// Bolts to CRBB_TopRetainer
			rotate([0,0,CRBBm_Bolt_a]) CRBBm_MountingBoltPattern(nTopBolts=nBolts) 
				hull(){
					cylinder(d=Bolt4Inset*2, h=Boss_t);
					translate([0,-5.2,0]) scale([1,0.01,1]) cylinder(d=Bolt4Inset*2+2, h=Boss_t);
				} // hull
			
			// Ropes
			for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j]) translate([0,Rope_Y,0])
				cylinder(d=Rope_d+Wall_t*2, h=Thickness);
				
			// Spokes
			for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j]) hull(){
				translate([0,OD/2-Wall_t,0])
					cylinder(d=Wall_t, h=Thickness);
				translate([0,(LockPin_d+1)/2+Wall_t,0])
					cylinder(d=Wall_t, h=Thickness);
			} // hull
		}
	
		// Spring
		//difference(){
			translate([0,0,Spring_Z]) cylinder(d=Spring_OD, h=Thickness);
			translate([0,0,Boss_t]) cylinder(d=Spring_ID, h=Thickness);
		//} // difference
				
		// Bolts to CRBB_TopRetainer
		translate([0,0,3.68])
			rotate([0,0,CRBBm_Bolt_a]) CRBBm_MountingBoltPattern(nTopBolts=nBolts) Bolt4ButtonHeadHole();
			
		// Ropes
		for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j]) translate([0,Rope_Y,-Overlap])
			cylinder(d=Rope_d, h=Thickness+Overlap*2);

	
		
	} // difference
} // CRBBm_CenteringRingMount

// CRBBm_CenteringRingMount(OD=ULine38Body_ID,nRopes=3);
//translate([0,0,-10]) rotate([0,0,18]) CRBBm_TopRetainer();

module PhoMR63(){
	difference(){
		cylinder(d=LockBearing_OD, h=LockBearing_H);
		translate([0,0,-Overlap]) cylinder(d=LockBearing_ID+IDXtra, h=LockBearing_H+Overlap*2);
	}
} // PhoMR63

// PhoMR63();


module CRBBm_LockPinExtensionEnd(){
	Al_Tube_d=5/16*25.4;
	
	difference(){
		union(){
			cylinder(d=LockPin_d, h=2+Overlap);
			translate([0,0,2]) cylinder(d1=LockPin_d, d2=Al_Tube_d+IDXtra+2.4, h=6);
		
		} // union
		
		translate([0,0,2]) cylinder(d=Al_Tube_d+IDXtra, h=6+Overlap);
		translate([0,0,2+Overlap]) Bolt10ClearHole();
		
	} // difference
} // CRBBm_LockPinExtensionEnd

// CRBBm_LockPinExtensionEnd();






























