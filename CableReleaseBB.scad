// ***********************************
// Project: 3D Printed Rocket
// Filename: CableReleaseBB.scad
// by David M. Flynn
// Created: 8/27/2022 
// Revision: 1.1.0  12/28/2023
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
function CableReleaseBBRev()="CableReleaseBB Rev. 1.1.0";
echo(CableReleaseBBRev());
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
// ExtensionRod(Len=100);
// LockingPin(LockPin_Len=LockPin_Len, GuidePoint=false);
// rotate([180,0,0]) LockRing(GuidePoint=false);
// rotate([180,0,0]) TopRetainer(LockRing_d=LockRing_d, GuidePoint=false);
// OuterBearingRetainer();
// rotate([180,0,0]) InnerBearingRetainer();
// rotate([180,0,0]) MagnetBracket();
// rotate([180,0,0]) TriggerPost();
//
// TopRetainerEBayEnd(Body_OD=BT98Body_OD, Body_ID=BT98Body_ID);
// LockingPin(LockPin_Len=40);
//
// ***********************************
//  ***** Routines *****
//
// MountingBoltPattern(nTopBolts=nBalls, LockRing_d=LockRing_d) Bolt4Hole();
//
// ***********************************
//  ***** for Viewing *****
//
// 
ShowCableReleaseBB(GuidePoint=true);
//
// ***********************************
include<TubesLib.scad>
use<SG90ServoLib.scad>
use<ThreadLib.scad>
use<SpringEndsLib.scad>
include<CommonStuffSAEmm.scad>

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

function LockRingDiameter()=LockRing_d;

module ShowCableReleaseBB(GuidePoint=false){
	Point_Len=GuidePoint? GuidePoint_Len:0;
	
	//color("LightBlue") 
	LockRing(GuidePoint=GuidePoint);
	LockingPin(GuidePoint=GuidePoint);
	color("Green") TopRetainer(GuidePoint=GuidePoint);
	translate([0,0,-19.5-Point_Len]) color("Gray") MagnetBracket();
	translate([0,0,-19.5-Point_Len]) color("Gray") TriggerPost();
	
	difference(){
		union(){
			translate([0,0,-19-0.2-Point_Len]) color("Tan") OuterBearingRetainer();
			translate([0,0,-20.0-0.2-Point_Len]) InnerBearingRetainer();
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


module ExtensionRod(Len=100){
	ID=1/4*25.4+IDXtra;
	Wall_t=1.2;
	
	difference(){
		cylinder(d=LockPin_d, h=Len);
		
		translate([0,0,-Overlap]) cylinder(d=ID, h=Len+Overlap*2);
		
		translate([0,0,5]) cylinder(d1=ID, d2=LockPin_d-Wall_t*2, h=10);
		translate([0,0,15-Overlap]) cylinder(d=LockPin_d-Wall_t*2, h=Len-30+Overlap*2);
		translate([0,0,Len-15-Overlap]) cylinder(d2=ID, d1=LockPin_d-Wall_t*2, h=10);
		
		//cube([20,20,100]);
	} // difference
} // ExtensionRod

//ExtensionRod(Len=90);

module LockingPin(LockPin_Len=LockPin_Len, GuidePoint=false){
	Point_Len=GuidePoint? GuidePoint_Len:0;
	Point_d=GuidePoint_d;
	
	difference(){
		union(){
			translate([0,0,-Ball_d]) cylinder(d=LockPin_d, h=LockPin_Len);
			if (GuidePoint)
				translate([0,0,-Ball_d-Point_Len]) 
					cylinder(d1=Point_d, d2=LockPin_d, h=Point_Len+Overlap);
		} // union
		
		BallGroove(BallCircle_d=BallCircle_d, Ball_d=Ball_d);
		translate([0,0,-Ball_d-Point_Len-Overlap]) 
			if ($preview){ 
				cylinder(d=6.35, h=LockPin_Len+Point_Len+Overlap*2); }
			else { 
				ExternalThread(Pitch=25.4/20, Dia_Nominal=6.35+IDXtra*2, 
							Length=LockPin_Len+Point_Len+Overlap*2, 
							Step_a=2,TrimEnd=true,TrimRoot=true); }
	} // difference
	
	if ($preview) color("White") 
		ShowBalls(BallCircle_d=BallCircle_d, nBalls=nBalls);
} // LockingPin

// LockingPin(LockPin_Len=LockPin_Len, GuidePoint=true);

module LockRing(GuidePoint=false){
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
		
		BallGroove(BallCircle_d=BallCircle_d+LockPinGrooveDepth*2, Ball_d=Ball_d+1);
		
		// Bearings and pins
		for (j=[0:nBalls-1]) rotate([0,0,360/nBalls*j]) translate([0,BearingCircle_d/2,0]){
			hull(){
				translate([0,Ball_d/2,0]) 
					cylinder(d=BearingMR84_OD+2, h=BearingMR84_H+1, center=true);
				translate([0,-Ball_d/2,0]) 
					cylinder(d=BearingMR84_OD+2, h=BearingMR84_H+1, center=true);
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

//LockRing(GuidePoint=true);

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
function TopBoltCircle_d(LockRing_d=LockRing_d)=LockRing_d-Bolt4Inset*2;

module MountingBoltPattern(nTopBolts=nBalls, LockRing_d=LockRing_d){
	for (j=[0:nTopBolts-1]) rotate([0,0,360/nTopBolts*(j+0.5)+Lock_a/2])
			translate([0,TopBoltCircle_d(LockRing_d)/2,0]) children();
} // MountingBoltPattern

// MountingBoltPattern(nTopBolts=nBalls) Bolt4Hole();

module TopRetainer(LockRing_d=LockRing_d, HasMountingBolts=true, GuidePoint=false){
	Point_Len=GuidePoint? GuidePoint_Len:0;
	Bearing_Z=Bearing6805_H+3+Ball_d/2;
	TopRetainer_Len=28.5;
	
	LockStart_a=-0.5;
	
	difference(){
		union(){
			// Bearing
			translate([0,0,-Bearing_Z-Point_Len]) cylinder(d=Bearing6805_ID, h=Bearing6805_H+Overlap);
			
			// Body
			translate([0,0,-Bearing_Z-Point_Len+Bearing6805_H]) 
				cylinder(d=BallCircle_d+Ball_d, h=TopRetainer_Len+Point_Len-Bearing6805_H);
			
			// Flange
			translate([0,0,-Bearing_Z+LockRing_h+0.5]) cylinder(d=LockRing_d, h=6);
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
				MountingBoltPattern(nTopBolts=nBalls, LockRing_d=LockRing_d) Bolt4Hole();
		
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
	
} // TopRetainer

// TopRetainer(HasMountingBolts=false, GuidePoint=true);
// LockingPin();

module TopRetainerEBayEnd(Body_OD=BT98Body_OD, Body_ID=BT98Body_ID){
	CT_Len=50;
	ET_Len=15;
	OAL=ET_Len+5+CT_Len;
	Plate_t=5;
	TROffset_Z=OAL-Plate_t-15;
	
	nRopes=6;
	Rope_d=4;
	
	//translate([0,0,TROffset_Z]) ShowCableReleaseBB();
		//TopRetainer(HasMountingBolts=true);
		
	// Body
	Tube(OD=BT98Body_ID-IDXtra, ID=Body_ID-IDXtra-6, Len=OAL, myfn=$preview? 90:360);
	// Stop ring
	translate([0,0,ET_Len]) Tube(OD=Body_OD, ID=Body_ID-IDXtra-6, Len=5, myfn=$preview? 90:360);
	// Shield
	Tube(OD=LockRing_d+10, ID=LockRing_d+5, Len=OAL, myfn=$preview? 90:360);
	
	
	
	translate([0,0,OAL-Plate_t])
	difference(){
		translate([0,0,Plate_t+10]) rotate([180,0,0])
			SE_SpringEndTypeA(Coupler_OD=Body_ID-1, Coupler_ID=Body_ID-4, 
				MotorCoupler_OD=BT54Coupler_OD+4, nRopes=6);
		//cylinder(d=Body_ID-1, h=Plate_t);
		
		//translate([0,0,-Overlap]) cylinder(d=22, h=Plate_t+Overlap*2);
		
		translate([0,0,Plate_t-1.4]) MountingBoltPattern() Bolt4ButtonHeadHole();
		
		// shock cord path
		translate([0,-Body_ID/2+6,-5]) hull(){
			translate([6,0,0]) cylinder(d=4, h=Plate_t*2+1);
			translate([-6,0,0]) cylinder(d=4, h=Plate_t*2+1);
		}
		
		// rope holes
	//	for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*(j+0.5)])
	//		translate([0,Body_ID/2-10,-Overlap]) cylinder(d=4, h=Plate_t+Overlap*2);
		
		//if ($preview) translate([0,0,-10]) cube([100,100,100]);
	} // difference
	
} // TopRetainerEBayEnd

//TopRetainerEBayEnd();

module InnerBearingRetainer(){
	// Changed screw depth by -0.5

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
			translate([0,BottomBoltCircle_d/2,-0.5]) rotate([180,0,0]) Bolt4HeadHole();
	} // difference
} // InnerBearingRetainer

//translate([0,0,-0.5]) InnerBearingRetainer();
























