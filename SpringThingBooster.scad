// ***********************************
// Project: 3D Printed Rocket
// Filename: SpringThingBooster.scad
// by David M. Flynn
// Created: 2/26/2023
// Revision: 1.4.8   1/15/2025
// Units: mm
// ***********************************
//  ***** Notes *****
//
// A.K.A. Ball Lock
//
// Built to deploy a parachute from a booster with a spring.
//
// Electronics:
//  Rocket Servo PCB (Req. 9V Battery)
//  SG90 or Eqiv. 9g Micro Servo MG90S is better
//  On larger rockets HX5010 servo is used
//
// Hardware(original SpringThingBooster 54mm 3 Ball):
//  #4-40 x 1/2" Socket Head Cap Screw (5 Req.)
//  #2-56 x 1/4" Socket Head Cap Screw (2 Req.)
//  3/16" Dia. x 1/8" Thick Magnet (2 Req.)
//  3/8" Delrin Ball (3 Req.)
//  MR84 Bearing 8mm OD x 4mm ID x 3mm Thick (5 Req.)
//  Steel Dowel Pin 4mm (Undersized) x 10mm (3 Req.)
//  Steel Dowel Pin 4mm (Undersized) x 16mm (3 Req.)
//
// Hardware(75mm 5 Ball):
//  #4-40 x 1/2" Socket Head Cap Screw (5 Req.)
//  #2-56 x 1/4" Socket Head Cap Screw (2 Req.)
//  3/16" Dia. x 1/8" Thick Magnet (2 Req.)
//  3/8" Delrin Ball (5 Req.)
//  MR84 Bearing 8mm OD x 4mm ID x 3mm Thick (7 Req.)
//  Steel Dowel Pin 4mm (Undersized) x 10mm (5 Req.)
//  Steel Dowel Pin 4mm (Undersized) x 16mm (3 Req.)
//
//  ***** History *****
function SpringThingBoosterRev()="SpringThingBooster Rev. 1.4.8";
echo(SpringThingBoosterRev());
//
// 1.4.8   1/15/2025  Fixed second servo depth.
// 1.4.7   12/30/2024 Added Xtra_r parameter
// 1.4.6   12/29/2024 Fixed a booboo
// 1.4.5   12/28/2024 Added Bearing6806 as large bearing for ULine102Body_ID
// 1.4.4   12/21/2024 Fixes to STB_BallRetainerTop: thicker floor 5mm, Gap filler calc changed
// 1.4.3   12/19/2024 Fixed arming hole depth.
// 1.4.2   12/14/2024 Removed STB_TubeEnd and renamed STB_TubeEnd2
// 1.4.1   10/5/2024  Tighter ball path. No extra extension.
// 1.4.0   10/4/2024  BallPerimeter_d is now calculated from the body tube ID.
// 1.3.7   8/6/2024   Changed calculation for STB_Unlocked_a()
// 1.3.6   8/2/2024   Added STB_TubeEnd2() new smoother version
// 1.3.5   8/1/2024   Removed old unused stuff.
// 1.3.4   8/1/2024   Fixed: large bearing issue
// 1.3.3   7/23/2024  Changed: tube interface in STB_TubeEnd() from Body_OD+IDXtra*2 to Body_OD+IDXtra
// 1.3.2   5/14/2024  Added Outer_OD parameter to STB_BallRetainerTop() to stop using BallPerimeter_d as OD.
// 1.3.1   5/7/2024   Moved to "SE_" STB_SpringEnd, STB_SpringSeat, STB_SpringMiddle, SE_SpringCupTOMT, SE_SpringGuide,
//						Deleted STB_SpringPlate
// 1.3.0   1/25/2024  Hole in one version added.
// 1.2.10  10/26/2023 Filled small gap below integrated coupler
// 1.2.9   6/23/2023  Added CenterHole_d to STB_SpringEnd
// 1.2.8   6/11/2023  Changed small servo arm length to 4mm.
// 1.2.7   6/5/2023   Removed overrides.
// 1.2.6   6/3/2023   Larger shock cord for 137 size.
// 1.2.5   5/22/2023  Renamed:STB_TubeEnd, Added rope holes to STB_TubeEnd.
// 1.2.4   5/4/2023   Added Stiffener to STB_LockDisk for BT137 version
// 1.2.3   5/1/2023   improved STB_ShowBosterSpringThing
// 1.2.2   4/28/2023  Fixed Big Servo position
// 1.2.1   4/27/2023  Added UsesBigServo parameter to STB_BallRetainerTop for >=98mm tubes
// 1.2.0   4/26/2023  Added second servo for Level 3 backup electronics.
// 1.1.2   4/26/2023  Fixes to the mess I made of the 54mm version.
// 1.1.1   4/21/2023  Working on 75mm 5 balls
// 1.1.0   4/16/2023  Added 75mm quad lock for body tube. It's all different now.
// 1.0.0   3/16/2023  Fixed STB_DrillingJig, it works.
// 0.9.5   3/10/2023  Fixes to STB_Cover
// 0.9.4   3/2/2023   Added notes, Code clean-up, FC need to print and test one.
// 0.9.3   3/1/2023   Added STB_Cover(), Added Manuan Arm/Disarm holes, fixed OD
// 0.9.2   2/28/2023  Many fixes, added SpringSeat(), DrillingJig()
// 0.9.1   2/27/2023  Three parts ready for first printing.
// 0.9.0   2/26/2023  First code.
//
// ***********************************
//  ***** for STL output *****
//
// STB_BallRetainerBottom(Body_ID=BT75Body_ID, Body_OD=BT75Body_ID, nLockBalls=nLockBalls, HasSpringGroove=true, Engagement_Len=20, HasLargeInnerBearing=false, Xtra_r=0.0);
// STB_BallRetainerTop(Outer_OD=PML75Body_OD, Body_OD=BT75Body_ID, nLockBalls=nLockBalls, HasIntegratedCouplerTube=false, nBolts=0, Body_ID=BT75Body_ID, HasSecondServo=false, UsesBigServo=false, Engagement_Len=20, HasLargeInnerBearing=false, Xtra_r=0.0);
// STB_LockDisk(Body_ID=BT75Body_ID, nLockBalls=nLockBalls, HasLargeInnerBearing=false, Xtra_r=0.0);
// STB_TubeEnd(Body_ID=BT75Body_ID, nLockBalls=nLockBalls, Body_OD=BT75Body_OD, Engagement_Len=20);
//
// ---------------
//  *** Tools ***
//
//  ** Drill the end of the coupler tube before gluing on the body tube. **
// STB_DrillingJig(BallPerimeter_d=PML54Body_ID, Body_OD=BT54Coupler_OD); 
//
// ***********************************
//  ***** Routines *****
//
// function STB_LockPinBC_d(BallPerimeter_d=BT75Body_OD)
// STB_ShockCordHolePattern(BallPerimeter_d=BT75Body_OD, Body_OD=BT75Body_ID);
// STB_ManualDisArmingHole(BallPerimeter_d=BT75Body_OD, nLockBalls=nLockBalls);
// STB_ManualArmingHole(BallPerimeter_d=BT75Body_OD);
//
// ***********************************
//  ***** for Viewing *****
//
// STB_ShowLockBearings(BallPerimeter_d=BT75Body_OD, nLockBalls=nLockBalls);
// STB_ShowMyBalls(BallPerimeter_d=BT75Body_OD, nLockBalls=nLockBalls, InLockedPosition=true);
//
// ***********************************

include<TubesLib.scad>
use<SG90ServoLib.scad>
use<LD-20MGServoLib.scad>
use<BatteryHolderLib.scad>
include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2; // Add to ID for tight fit, x2 for loose fit
LooseFit=IDXtra*3;
$fn=$preview? 24:90;

// -----------------------
// Now a function
//LockBall_d=3/8*25.4;
//LockBall_d=1/2 * 25.4;


BT137BallPerimeter_d=BT137Body_OD+3;
Magnet_d=4.8;
Magnet_h=3.2;
Dowel_d=4;

// -----------------------

BearingMR84_OD=8;
BearingMR84_ID=4;
BearingMR84_W=3;

Bearing6808_ID=40;
Bearing6808_OD=52;
Bearing6808_W=7;

Bearing6806_ID=30;
Bearing6806_OD=42;
Bearing6806_W=7;


nLockBalls=3;
nBT137Balls=7;

Bolt4Inset=4;

// Deployment Spring big and light
ST_DSpring_OD=44.30;
ST_DSpring_ID=40.50;
ST_DSpring_CBL=22; // coil bound length
ST_DSpring_FL=200; // free length

LockDisk_H=10; // length of dowel pins
LockDiskHole_H=LockDisk_H+1;

function STB_BT137BallPerimeter_d()=BT137BallPerimeter_d;

function STB_LockBall_d(Body_ID=BT75Body_ID)=(Body_ID>110)? 1/2 * 25.4 : 3/8 * 25.4;

function STB_BallPerimeter_d(Body_ID=BT75Body_ID)=Body_ID-IDXtra*2+STB_LockBall_d(Body_ID=Body_ID)*0.4;

function STB_CalcChord_a(Dia=10, Dist=1)=Dist/(Dia*PI)*360;

function STB_LockPinBC_d(Body_ID=BT75Body_ID)=STB_BallPerimeter_d(Body_ID)-STB_LockBall_d(Body_ID=Body_ID)*2-BearingMR84_OD;

function STB_LockedPost_a(Body_ID=BT75Body_ID)=
			-STB_CalcChord_a(Dia=STB_LockPinBC_d(Body_ID), Dist=BearingMR84_OD/2+Dowel_d/2+0.4);
			
function STB_Unlocked_a(Body_ID=BT75Body_ID)=STB_CalcChord_a(Dia=STB_LockPinBC_d(Body_ID), 
						Dist=STB_LockBall_d(Body_ID)*0.35+BearingMR84_OD*0.35); // was BearingMR84_OD/2+Dowel_d/2);

function STB_UnlockedPost_a(Body_ID=BT75Body_ID, nLockBalls=nLockBalls)=
			STB_Unlocked_a(Body_ID)+360/nLockBalls+
				STB_CalcChord_a(Dia=STB_LockPinBC_d(Body_ID), Dist=BearingMR84_OD/2+Dowel_d/2+IDXtra*2);
				
function STB_MagnetPost_a(Body_ID=BT75Body_ID, nLockBalls=nLockBalls)=
			STB_UnlockedPost_a(Body_ID, nLockBalls)+
			STB_CalcChord_a(Dia=STB_LockPinBC_d(Body_ID), Dist=Dowel_d/2+Magnet_h);
//echo(STB_Unlocked_a());

function STB_SCord_T(p=BT54Body_ID)=lookup(p,[ 
		[PML54Body_ID,3],
		[PML75Body_OD,3],
		[PML98Body_OD,3],
		[BT137Body_OD,5]
		]);

module STB_LockedStopPosition(Body_ID=BT75Body_ID){
	BallPerimeter_d=STB_BallPerimeter_d(Body_ID);
	OverCenterValue=0.2;
	
	translate([BearingMR84_OD/2+Dowel_d/2+OverCenterValue, BallPerimeter_d/2-STB_LockBall_d(Body_ID)-BearingMR84_OD/2,0])
		children();
} // STB_LockedStopPosition
	
module STB_UnlockedStopPosition(Body_ID=BT75Body_ID, nLockBalls=nLockBalls){
	BallPerimeter_d=STB_BallPerimeter_d(Body_ID);
	
	rotate([0,0,STB_Unlocked_a(BallPerimeter_d)+360/nLockBalls])
	translate([-BearingMR84_OD/2-Dowel_d/2-IDXtra, BallPerimeter_d/2-STB_LockBall_d(Body_ID)-BearingMR84_OD/2,0])
		children();
} // STB_UnlockedStopPosition

module STB_ShowMyBalls(Body_ID=BT75Body_ID, nLockBalls=nLockBalls, InLockedPosition=true){
	BallPerimeter_d=STB_BallPerimeter_d(Body_ID);
	
	Ball_Y=InLockedPosition? BallPerimeter_d/2-STB_LockBall_d(Body_ID)/2 : Body_ID/2-STB_LockBall_d(Body_ID)/2;
	
	for (j=[0:nLockBalls-1]) rotate([0,0,360/nLockBalls*j]) 
			translate([0,Ball_Y,0]) 
				color("Red") sphere(d=STB_LockBall_d(Body_ID));

} // STB_ShowMyBalls

//STB_ShowMyBalls(Body_ID=BT75Body_ID, nLockBalls=nLockBalls, InLockedPosition=true);
//STB_ShowMyBalls(Body_ID=BT75Body_ID, nLockBalls=nLockBalls, InLockedPosition=false);

module STB_ShowLockBearings(Body_ID=BT75Body_ID, nLockBalls=nLockBalls){
	
	for (j=[0:nLockBalls-1]) rotate([0,0,360/nLockBalls*j]) 
		translate([0,STB_LockPinBC_d(Body_ID)/2,0]) {
			color("Red") cylinder(d=BearingMR84_ID, h=10+Overlap, center=true);
			color("Blue") cylinder(d=BearingMR84_OD, h=BearingMR84_W, center=true);
		} // for
} // ShowLockBearings

//STB_ShowLockBearings();
//STB_ShowLockBearings(Body_ID=PML75Body_ID, nLockBalls=4);

module STB_LockDisk(Body_ID=BT75Body_ID, nLockBalls=nLockBalls, HasLargeInnerBearing=false, Xtra_r=0.0){
	
	BallPerimeter_d=STB_BallPerimeter_d(Body_ID);
	
	MagnetOvershoot_a=STB_CalcChord_a(Dia=BallPerimeter_d-STB_LockBall_d(Body_ID)*2, Dist=0.6);
	
	BigBearing_OD=(Body_ID>120)? Bearing6808_OD:Bearing6806_OD;
	BigBearing_W=(Body_ID>120)? Bearing6808_W:Bearing6806_W;
	
	Bearing_OD=HasLargeInnerBearing? BigBearing_OD:BearingMR84_OD;
	Bearing_W=HasLargeInnerBearing? BigBearing_W:BearingMR84_W;
	
	difference(){
		union(){
			// Hub
			cylinder(d=Bearing_OD+6, h=LockDisk_H, center=true);
			
			// Bearing holders
			for (j=[0:nLockBalls-1]) rotate([0,0,360/nLockBalls*j]) hull(){
				cylinder(d=BearingMR84_OD+2, h=LockDisk_H, center=true);
				translate([0,STB_LockPinBC_d(Body_ID)/2+Xtra_r,0])
					cylinder(d=BearingMR84_OD, h=LockDisk_H, center=true);
				}
			
			// Add stiffeners
			if (BallPerimeter_d>105) for (j=[0:nLockBalls-1]) 
				hull(){
					rotate([0,0,360/nLockBalls*j]) 
						translate([0,STB_LockPinBC_d(Body_ID)/2-20,0])
							cylinder(d=3, h=LockDisk_H, center=true);
					rotate([0,0,360/nLockBalls*(j+1)]) 
						translate([0,STB_LockPinBC_d(Body_ID)/2-20,0])
							cylinder(d=3, h=LockDisk_H, center=true);
				} // hull
				
			// Magnetic latch
			rotate([0,0,STB_MagnetPost_a(Body_ID, nLockBalls)+MagnetOvershoot_a]) translate([-Magnet_h/2,0,0])
			hull(){
				cylinder(d=Magnet_h, h=LockDisk_H, center=true);
				translate([0,STB_LockPinBC_d(Body_ID)/2+2.5,0])
					cylinder(d=Magnet_h, h=LockDisk_H, center=true);
			}
		} // union
		
		// Magnet
		rotate([0,0,STB_MagnetPost_a(Body_ID, nLockBalls)+MagnetOvershoot_a]) 
			translate([-Magnet_h/2, STB_LockPinBC_d(Body_ID)/2,0])
				rotate([0,90,0]) cylinder(d=Magnet_d, h=Magnet_h+Overlap*2, center=true);
		
		// Center Bearings
		cylinder(d=Bearing_OD-1, h=LockDisk_H+Overlap*2, center=true);
		if(HasLargeInnerBearing){
			translate([0,0,-Bearing_W/2]) 
				cylinder(d=Bearing_OD+IDXtra, h=LockDisk_H); // 12/30/2024 was IDXtra*2
		}else{
			translate([0,0,-LockDisk_H/2-Overlap]) 
				cylinder(d=Bearing_OD+IDXtra*2, h=Bearing_W+Overlap);
			translate([0,0,LockDisk_H/2-Bearing_W]) 
				cylinder(d=Bearing_OD+IDXtra*2, h=Bearing_W+Overlap);
		}
				
		
			
		// Lock axles and bearings
		for (j=[0:nLockBalls-1]) rotate([0,0,360/nLockBalls*j]) 
			translate([0,STB_LockPinBC_d(Body_ID)/2+Xtra_r,0]) {
				cylinder(d=BearingMR84_ID+IDXtra, h=LockDisk_H+Overlap*2, center=true);
				cylinder(d=BearingMR84_OD+2, h=BearingMR84_W+1, center=true);
				}
	} // difference
} // STB_LockDisk

// STB_LockDisk(Body_ID=ULine102Body_ID, nLockBalls=6, HasLargeInnerBearing=true, Xtra_r=0.3);

//STB_LockDisk();
//STB_LockDisk(Body_ID=BT137Body_ID, nLockBalls=7, HasLargeInnerBearing=true);

//STB_BallRetainerBottom(Body_ID=BT75Body_ID, nLockBalls=3);

//STB_LockDisk(Body_ID=PML75Body_ID, nLockBalls=5);

//rotate([0,0,Unlocked_a]) 
//{ STB_LockDisk(); STB_ShowLockBearings(); }


module STB_ShockCordHolePattern(Body_ID=BT75Body_ID, Body_OD=PML54Coupler_ID){

	Offset_a=STB_LockedPost_a(Body_ID)-
		STB_CalcChord_a(Dia=STB_LockPinBC_d(Body_ID), Dist=Dowel_d/2+STB_SCord_T(Body_ID));
	
	SCord_W=lookup(Body_ID,[ 
		[PML54Body_ID,9],
		[PML75Body_OD,12],
		[PML98Body_OD,12],
		[BT137Body_OD,19]
		]);
	
	//echo(SCord_W=SCord_W);
	rotate([0,0,Offset_a]){
		translate([0,Body_OD/2-6,0]) children();
		translate([0,Body_OD/2-6-SCord_W,0]) children();
	}
} // STB_ShockCordHolePattern

//hull() STB_ShockCordHolePattern() cylinder(d=3, h=3);
//hull() STB_ShockCordHolePattern(Body_ID=BT137Body_ID, Body_OD=BT137Body_ID) cylinder(d=3, h=3);

module STB_BR_BoltPattern(Body_ID=BT75Body_ID, Body_OD=BT75Body_ID, nLockBalls=nLockBalls){
	// Body bolt pattern
	
	Offset_a=(Body_OD<=PML54Body_OD)? 180/nLockBalls-24:
		STB_CalcChord_a(Dia=Body_OD-STB_LockBall_d(Body_ID), Dist=STB_LockBall_d(Body_ID)/2+Bolt4Inset);
	
	for (j=[0:nLockBalls-1]) 
		rotate([0,0,360/nLockBalls*j+Offset_a]) translate([0,Body_OD/2-Bolt4Inset,0]) children();
		
	if (Body_ID>120)
		for (j=[0:nLockBalls-1]) 
			rotate([0,0,360/nLockBalls*j-Offset_a]) translate([0,Body_OD/2-Bolt4Inset,0]) children();
		
} // STB_BR_BoltPattern

// STB_BR_BoltPattern(Body_OD=PML54Coupler_ID) Bolt4Hole();

module STB_DrillingJig(Body_ID=BT75Body_ID, nLockBalls=nLockBalls, Body_OD=BT75Body_ID, Engagement_Len=20){
	// This is a tool for drilling holes in a coupler tube.
	difference(){
		union(){
			translate([0,0,Engagement_Len/2]) Tube(OD=Body_OD+6, ID=Body_OD-6, Len=4, myfn=$preview? 90:360);
			translate([0,0,-Engagement_Len/2]) Tube(OD=Body_OD+6, ID=Body_OD+IDXtra*3, Len=Engagement_Len+4, myfn=$preview? 90:360);
		} // union
	
		for (j=[0:nLockBalls-1]) rotate([0,0,360/nLockBalls*j]) 
			rotate([-90,0,0]) cylinder(d=STB_LockBall_d(Body_ID)-2, h=Body_OD);
			
		STB_ManualDisArmingHole(Body_ID=Body_ID, nLockBalls=nLockBalls);
		STB_ManualArmingHole(Body_ID=Body_ID);
	} // difference
	
	
} // STB_DrillingJig

// STB_DrillingJig();
// STB_DrillingJig(Body_ID=PML75Body_ID, Body_OD=PML75Body_OD, Engagement_Len=20);

module STB_TubeEnd(Body_ID=BT75Body_ID, nLockBalls=nLockBalls, 
			Body_OD=BT75Body_OD, Engagement_Len=20){

	// Made for 5.5" rockets w/ tighter ball fit and more contact area.
	BallPerimeter_d=STB_BallPerimeter_d(Body_ID);
	Ball_d=STB_LockBall_d(Body_ID);
	StandardWall_t=2.0;
	ThinWall_t=1.8; // 2 perimeters at thinnest wall, was 2.2
	ChamferLen=6;
	
	Min_Ring_OD=Body_OD+StandardWall_t*2;
	BallCalcdRing_OD=BallPerimeter_d+ThinWall_t*2; // needed only for thin walled tubes
	Ring_OD=max(Min_Ring_OD,BallCalcdRing_OD);
	RingLen=Engagement_Len+10-ChamferLen;
	DepthExtra=0.5;
	
	difference(){
		union(){
			translate([0,0,-Engagement_Len/2-10]) 
				Tube(OD=Ring_OD, ID=Body_ID+IDXtra*3, Len=RingLen+Overlap, myfn=$preview? 90:360);
			
			// Engagement end
			translate([0,0,Engagement_Len/2-ChamferLen])
			difference(){
				cylinder(d1=Ring_OD, d2=Body_OD, h=ChamferLen, $fn=$preview? 90:360);
				
				translate([0,0,-Overlap])
					cylinder(d=Body_ID+IDXtra*3, h=ChamferLen+Overlap*2, $fn=$preview? 90:360);
			} // difference
			
			// Tube end
			translate([0,0,-Engagement_Len/2-10-ChamferLen+1])
			difference(){
				cylinder(d2=Ring_OD, d1=Body_OD+IDXtra*2+1.2, h=ChamferLen-1, $fn=$preview? 90:360);
				translate([0,0,-Overlap]) cylinder(d=Body_OD+IDXtra, h=ChamferLen+Overlap*2, $fn=$preview? 90:360);
			} // difference
		} // union
		
		translate([0,0,-Engagement_Len/2-10-Overlap]) cylinder(d=Body_OD+IDXtra, h=10, $fn=$preview? 90:360);
		
		//Ball Grooves
		Steps=90/nLockBalls;
		DispPerStep=1.5/Steps;
		Offset=-0.25; // was -0.5; 
		
		Slot_Width=Ball_d+IDXtra*3;
		myFn=$preview? 36:90;
		
		for (j=[0:nLockBalls-1]) for (k=[0:Steps])
			hull(){
				rotate([0, 0, 360/nLockBalls*j+k]) 
					translate([0, BallPerimeter_d/2-Ball_d/2+DepthExtra, -DispPerStep*k+Offset])
						sphere(d=Slot_Width, $fn=myFn);
				rotate([0, 0, 360/nLockBalls*j+k+1]) 
					translate([0, BallPerimeter_d/2-Ball_d/2+DepthExtra, -DispPerStep*(k+1)+Offset])
						sphere(d=Slot_Width, $fn=myFn);
			} // hull
			
		STB_ManualDisArmingHole(Body_ID=Body_ID, nLockBalls=nLockBalls);
		STB_ManualArmingHole(Body_ID=Body_ID);
	} // difference
	
	//echo("STB_LockBall_d=",STB_LockBall_d(Body_ID));
} // STB_TubeEnd

// rotate([180,0,0]) STB_TubeEnd(Body_ID=ULine102Body_ID, nLockBalls=6, Body_OD=ULine102Body_OD, Engagement_Len=20);
			
//rotate([180,0,0]) STB_TubeEnd(Body_ID=BT137Body_ID, nLockBalls=nBT137Balls, Body_OD=BT137Body_OD, Engagement_Len=20);
// STB_TubeEnd(Body_ID=ULine203Body_ID, nLockBalls=7, Body_OD=ULine203Body_OD, Engagement_Len=30);

module STB_TubeEndDrillingJig(Body_ID=ULine203Body_ID, nLockBalls=7, 
			Body_OD=ULine203Body_OD, Engagement_Len=30){
	// fixes an error, one time thing

	difference(){
		rotate([0,0,180/nLockBalls]) translate([-40,Body_OD/2-20,-Engagement_Len/2]) cube([80,30,40]);
		
		STB_TubeEnd(Body_ID=Body_ID, nLockBalls=nLockBalls, 
			Body_OD=Body_OD, Engagement_Len=Engagement_Len);
			
		STB_ManualDisArmingHole(Body_ID=Body_ID, nLockBalls=nLockBalls);
		STB_ManualArmingHole(Body_ID=Body_ID);
			
		translate([0,0,-Engagement_Len/2-Overlap]) difference(){
			cylinder(d=Body_OD, h=50, $fn=$preview? 90:360);
			cylinder(d=Body_OD-0.2, h=50, $fn=$preview? 90:360);
			}
			
		rotate([0,0,180/nLockBalls]){
			translate([-30,Body_OD/2+2,Engagement_Len/2+4]) rotate([-90,0,0]) Bolt4Hole(depth=30);
			translate([30,Body_OD/2+2,Engagement_Len/2+4]) rotate([-90,0,0]) Bolt4Hole(depth=30);
			translate([-30,Body_OD/2,Engagement_Len/2+4]) rotate([90,0,0]) Bolt4ClearHole(depth=30);
			translate([30,Body_OD/2,Engagement_Len/2+4]) rotate([90,0,0]) Bolt4ClearHole(depth=30);
			}
	} // difference

} // STB_TubeEndDrillingJig

//rotate([180,0,0]) STB_TubeEndDrillingJig();

ArmingHole_d=2.5;

module STB_ManualDisArmingHole(Body_ID=BT75Body_ID, nLockBalls=nLockBalls){
	rotate([0,0,360/nLockBalls]) translate([0, STB_LockPinBC_d(Body_ID)/2, -LockDiskHole_H/2+2])
		rotate([0,90,0]) cylinder(d=ArmingHole_d, h=Body_ID/2);
} // STB_ManualDisArmingHole

// STB_ManualDisArmingHole();	

module STB_ManualArmingHole(Body_ID=BT75Body_ID){

	rotate([0,0,STB_Unlocked_a(Body_ID)]) 
		translate([0,STB_LockPinBC_d(Body_ID)/2,LockDiskHole_H/2-2])
			rotate([0,-90,0]) cylinder(d=ArmingHole_d, h=Body_ID/2);
} // STB_ManualArmingHole
	
//STB_ManualArmingHole();

module STB_BallRetainerTop(Body_ID=BT75Body_ID, Outer_OD=0, Body_OD=BT75Body_ID, nLockBalls=nLockBalls,
			HasIntegratedCouplerTube=false, nBolts=0,
			IntegratedCouplerLenXtra=0,
				
			HasSecondServo=false,
			UsesBigServo=false,
			Engagement_Len=20, HasLargeInnerBearing=false, Xtra_r=0.0){
			
	BallPerimeter_d=STB_BallPerimeter_d(Body_ID);
	Ball_d=STB_LockBall_d(Body_ID);
	Plate_T=(Body_ID>150)? 5:3;
	LockDisk_d=STB_LockPinBC_d(Body_ID)+BearingMR84_OD;
	
	Top_H=LockDiskHole_H/2+Plate_T;
	Skirt_H=40;
	CT_Len=Engagement_Len/2+2;
	ServoArm_Len=UsesBigServo? 10:4; // was =10; 6/11/23
	Servo_Z=18;
	Servo_r=BallPerimeter_d/2-STB_LockBall_d(Body_ID)-BearingMR84_OD/2-ServoArm_Len;
	IntCouplerLen=UsesBigServo? IntegratedCouplerLenXtra+24:IntegratedCouplerLenXtra+13;
	
	BigBearing_ID=(Body_ID>120)? Bearing6808_ID:Bearing6806_ID;
	BigBearing_OD=(Body_ID>120)? Bearing6808_OD:Bearing6806_OD;
	BigBearing_W=(Body_ID>120)? Bearing6808_W:Bearing6806_W;

	Bearing_ID=BigBearing_ID;
	OuterRing_OD=(Outer_OD==0)? BallPerimeter_d:Outer_OD;
	
	module ServoPosition(SecondServo=false){
		SecondServo_a=SecondServo? 360/nLockBalls*2:0;
		
		if (BallPerimeter_d<=PML54Body_OD){
			translate([-10,4,Servo_Z]) rotate([180,0,-90])  children();
		}else{
			Servo_a=360/nLockBalls-STB_CalcChord_a(Dia=Servo_r*2, Dist=BearingMR84_OD/2+5);
			//echo(Servo_r=Servo_r);
		    //echo(nLockBalls=nLockBalls);
			rotate([0,0,Servo_a+SecondServo_a])
				translate([0,Servo_r,Servo_Z]) rotate([0,0,-135]) rotate([180,0,0]) children();
		}
		//#translate([-10,4,4]) cylinder(d=10, h=3);
	} // ServoPosition
	
	module BigServoPosition(SecondServo=false){
		SecondServo_a=SecondServo? 360/nLockBalls*3:0;
		ServoRotation_a=HasLargeInnerBearing? -25:0;
		
		Servo_a=360/nLockBalls-STB_CalcChord_a(Dia=Servo_r*2, Dist=BearingMR84_OD/2+6);
		
		rotate([0,0,Servo_a+SecondServo_a])
			translate([0, Servo_r, Servo_Z+9]) rotate([0,0,-135+ServoRotation_a]) rotate([180,0,0]) children();
		
		//#translate([-10,4,4]) cylinder(d=10, h=3);
	} // BigServoPosition
	
	module ServoArm(){
		cylinder(d=7, h=2);
		hull(){
			cylinder(d=7, h=2);
			translate([0,10,0]) cylinder(d=4, h=2);
		}
	} // ServoArm
	
	// Show Servo Arm
	if ($preview) if (UsesBigServo){
		translate([0,0,-24]) BigServoPosition() rotate([0,0,20]) ServoArm();
		if (HasSecondServo)
				translate([0,0,-24]) BigServoPosition(SecondServo=true) rotate([0,0,20]) ServoArm();
	}else{
		translate([0,0,-14]) ServoPosition() rotate([0,0,20]) ServoArm();
		if (HasSecondServo)
				translate([0,0,-14]) ServoPosition(SecondServo=true) rotate([0,0,20]) ServoArm();
				}
	
	difference(){
		union(){
			cylinder(d=Body_OD-IDXtra*2, h=Top_H, $fn=$preview? 90:360);
			
			difference(){
				union(){
					Tube(OD=Body_OD-IDXtra*2, ID=Body_OD-IDXtra*2-4.4, Len=CT_Len, myfn=$preview? 90:360);
					translate([0,0,Engagement_Len/2]) 
						cylinder(d=OuterRing_OD-IDXtra*2, h=2, $fn=$preview? 90:360);
					
				} // union
				translate([0,0,Engagement_Len/2-Overlap]) 
					cylinder(d1=Body_OD-5.4, d2=BallPerimeter_d-4.4, h=2+Overlap*2, $fn=$preview? 90:360);
			} // difference
			
			if (HasIntegratedCouplerTube){
				translate([0,0,Engagement_Len/2]) 
					Tube(OD=Body_ID, ID=Body_ID-6, Len=IntCouplerLen+13, myfn=$preview? 90:360);
					
				// gap filler
				translate([0,0,Top_H-1]) 
					Tube(OD=Body_ID-1, ID=Body_ID-6, Len=10, myfn=$preview? 90:360);
					
				// Body Tube
				translate([0,0,Engagement_Len/2]) 
					Tube(OD=OuterRing_OD, ID=Body_ID-4.4, Len=IntCouplerLen, myfn=$preview? 90:360);
				}
				
			// Servo Mount
			if (UsesBigServo){
				BigServoPosition() ServoHX5010TopBlock(Xtra_Len=0, Xtra_Width=3.4, Xtra_Height=0);
			}else{
				ServoPosition()
					ServoSG90TopBlock(Xtra_Len=0, Xtra_Width=2.4, Xtra_Height=6);
			}
			
			if (HasSecondServo)
				if (UsesBigServo){
					BigServoPosition(SecondServo=true) 
						ServoHX5010TopBlock(Xtra_Len=0, Xtra_Width=3.4, Xtra_Height=0);
				}else{
					ServoPosition(SecondServo=true) 
						ServoSG90TopBlock(Xtra_Len=0, Xtra_Width=2.4, Xtra_Height=6);
				}
		} // union
		
		STB_ManualArmingHole(Body_ID);
		
		// Balls go here
		for (j=[0:nLockBalls-1]) rotate([0,0,360/nLockBalls*j]) hull(){
			translate([0,BallPerimeter_d/2-Ball_d/2,0]) sphere(d=Ball_d+IDXtra*3);
			translate([0,Body_OD/2-Ball_d/2,0]) sphere(d=Ball_d+IDXtra*3);
			translate([0,BallPerimeter_d/2-Ball_d/2,0.3]) sphere(d=Ball_d+IDXtra*3);
			translate([0,Body_OD/2-Ball_d/2,0.3]) sphere(d=Ball_d+IDXtra*3);
		}
		
		if (HasLargeInnerBearing)
			translate([0,0,-Overlap]) cylinder(d=Bearing_ID-6, h=Top_H+Overlap*2);
			
		// Integrated coupler bolt holes
		if (HasIntegratedCouplerTube && nBolts>0) translate([0,0,Engagement_Len/2+IntCouplerLen+7.5])
			for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+180/nBolts]) translate([0,Body_OD/2,0]) rotate([-90,0,0]) Bolt4Hole();
			
		
		// Bolt holes
		translate([0,0,Top_H]) 
			STB_BR_BoltPattern(Body_ID=Body_ID, Body_OD=Body_OD, nLockBalls=nLockBalls) 
				Bolt4HeadHole(depth=8, lHead=20);
		
		// Shock Cord
		if (!HasLargeInnerBearing)
			translate([0,0,-Overlap]) hull() 
				STB_ShockCordHolePattern(Body_ID=Body_ID, Body_OD=Body_OD)
					cylinder(d=STB_SCord_T(Body_ID), h=Top_H+Overlap*2);
			
		// Arming slot
		//translate([Body_OD/2-12, 0, LockDiskHole_H/2-Overlap]) 
		//	RoundRect(X=2.2, Y=8, Z=Plate_T+Overlap*2, R=1);
		
		// Lock Disk goes here
		cylinder(d=LockDisk_d+1+Xtra_r*2, h=LockDiskHole_H, center=true);
		
		// Lock disk axle goes here
		cylinder(d=BearingMR84_ID+IDXtra, h=20, center=true);
		
		// Locked stop
		STB_LockedStopPosition(Body_ID=Body_ID)
			cylinder(d=Dowel_d, h=Top_H*2+Overlap*2,center=true);
			
		// Unlocked Stop
		STB_UnlockedStopPosition(Body_ID=Body_ID, nLockBalls=nLockBalls)
			cylinder(d=Dowel_d, h=Top_H*2+Overlap*2, center=true);
		
		// Servo
		if (UsesBigServo){
			BigServoPosition() translate([0,0,7.4])  rotate([0,0,180])
				Servo_HX5010(BottomMount=true, TopAccess=false, Xtra_w=1, Xtra_h=0, XtraTop=-2);
				
			if (HasSecondServo)
				BigServoPosition(SecondServo=true) translate([0,0,7.4])  rotate([0,0,180])
					Servo_HX5010(BottomMount=true, TopAccess=false, Xtra_w=1, Xtra_h=0, XtraTop=-2);
		}else{
			ServoPosition() ServoSG90(TopMount=false,HasGear=false); 
			if (HasSecondServo)
				ServoPosition(SecondServo=true) ServoSG90(TopMount=false,HasGear=false); 
		}
		
		//notch for magnet latch
		rotate([0,0,STB_MagnetPost_a(Body_ID, nLockBalls)]) translate([Magnet_h/2,0,0])
			hull(){
				translate([0,STB_LockPinBC_d(Body_ID)/2-4,0])
					cylinder(d=Magnet_h+IDXtra*4, h=LockDisk_H+4, center=true);
				translate([0,STB_LockPinBC_d(Body_ID)/2+5,0])
					cylinder(d=Magnet_h+IDXtra*4, h=LockDisk_H+4, center=true);
			}
			
		//if ($preview) translate([0,0,-1]) cube([Body_OD/2+10,Body_OD/2+10,50]);
	} // difference
	
	// Shock cord hole
	if (HasLargeInnerBearing==false)
	difference(){
		hull() 
			STB_ShockCordHolePattern(Body_ID=Body_ID, Body_OD=Body_OD) 
				cylinder(d=STB_SCord_T(Body_ID)+2.4, h=Top_H);
		
		translate([0,0,-Overlap]) hull() 
			STB_ShockCordHolePattern(Body_ID=Body_ID, Body_OD=Body_OD) 
				cylinder(d=STB_SCord_T(Body_ID), h=Top_H+Overlap*2);
	} // difference
	
	// Large bearing holder
	if (HasLargeInnerBearing) 
		difference(){
			translate([0,0,Bearing6808_W/2+0.3]) 
					cylinder(d=Bearing_ID+4, h=LockDiskHole_H/2-Bearing6808_W/2);
			
			translate([0,0,-Overlap]) cylinder(d=Bearing_ID+IDXtra*2, h=LockDiskHole_H/2+0.3+Overlap*2);
		} // difference
			

} // STB_BallRetainerTop

/*
STB_BallRetainerTop(Body_ID=ULine102Body_ID, Outer_OD=ULine102Body_OD, Body_OD=ULine102Body_ID, nLockBalls=6,
HasIntegratedCouplerTube=true,
			IntegratedCouplerLenXtra=-10,
			HasSecondServo=false,
			UsesBigServo=true,
			Engagement_Len=20, HasLargeInnerBearing=true);
			
STB_LockDisk(Body_ID=ULine102Body_ID, nLockBalls=6, HasLargeInnerBearing=true);	
	
/**/

/*
STB_BallRetainerTop(Body_ID=ULine203Body_ID, Outer_OD=ULine203Body_OD, Body_OD=ULine203Body_ID, nLockBalls=7,
HasIntegratedCouplerTube=true,
			IntegratedCouplerLenXtra=-10,
			HasSecondServo=true,
			UsesBigServo=true,
			Engagement_Len=30);
/**/

/*
STB_BallRetainerTop(Body_ID=BT98Body_ID, Outer_OD=BT98Body_OD, Body_OD=BT98Body_ID, nLockBalls=6,
HasIntegratedCouplerTube=true,
			IntegratedCouplerLenXtra=10,
			HasSecondServo=false,
			UsesBigServo=true,
			Engagement_Len=20);
/**/		

/*
STB_BallRetainerTop(Body_ID=PML75Body_ID, Body_OD=PML75Body_ID, nLockBalls=5, HasIntegratedCouplerTube=true, nBolts=4);

//
rotate([0,0,STB_Unlocked_a(Body_ID=PML75Body_ID)])
{
STB_LockDisk(Body_ID=PML75Body_ID, nLockBalls=5);
STB_ShowLockBearings(Body_ID=PML75Body_ID, nLockBalls=5);
}
/**/
/*
STB_BallRetainerTop(Body_ID=PML98Body_ID, Body_OD=PML98Body_ID, nLockBalls=6, HasIntegratedCouplerTube=true, Body_ID=PML98Body_ID, HasSecondServo=true, UsesBigServo=true);
//*
//rotate([0,0,STB_Unlocked_a(Body_ID=PML98Body_ID)])
{
STB_LockDisk(Body_ID=PML98Body_ID, nLockBalls=6);
STB_ShowLockBearings(Body_ID=PML98Body_ID, nLockBalls=6);
}
/**/

/*
STB_BallRetainerTop(Body_ID=BT137Body_ID, Outer_OD=BT137Body_OD, Body_OD=BT137Body_ID, nLockBalls=nBT137Balls,
			HasIntegratedCouplerTube=true,
			IntegratedCouplerLenXtra=0,
				
			HasSecondServo=true,
			UsesBigServo=true,
			Engagement_Len=25, HasLargeInnerBearing=true);
	/**/		

		
module STB_BallRetainerBottom(Body_ID=BT75Body_ID, Body_OD=BT75Body_ID, nLockBalls=nLockBalls, HasSpringGroove=true, Engagement_Len=20, HasLargeInnerBearing=false, Xtra_r=0.0){

	BallPerimeter_d=STB_BallPerimeter_d(Body_ID);
	Ball_d=STB_LockBall_d(Body_ID);
	Plate_T=Engagement_Len/2-LockDiskHole_H+4;
	SpringGroove_H=HasSpringGroove? 1.5:0;
	
	Bottom_H=Engagement_Len/2+SpringGroove_H;
	LockDisk_d=STB_LockPinBC_d(Body_ID)+BearingMR84_OD;
	
	//echo(Bottom_H=Bottom_H);
	
	BigBearing_ID=(Body_ID>120)? Bearing6808_ID:Bearing6806_ID;
	BigBearing_OD=(Body_ID>120)? Bearing6808_OD:Bearing6806_OD;
	BigBearing_W=(Body_ID>120)? Bearing6808_W:Bearing6806_W;

	Bearing_ID=BigBearing_ID;
		
	difference(){
		translate([0,0,-Bottom_H]) 
			cylinder(d=Body_OD-IDXtra*2, h=Bottom_H, $fn=$preview? 90:360);
		
		STB_ManualDisArmingHole(Body_ID=Body_ID, nLockBalls=nLockBalls);
		
		// Balls go here
		for (j=[0:nLockBalls-1]) rotate([0,0,360/nLockBalls*j]) hull(){
			translate([0,BallPerimeter_d/2-Ball_d/2,0]) sphere(d=Ball_d+IDXtra*3);
			translate([0,Body_OD/2-Ball_d/2,0]) sphere(d=Ball_d+IDXtra*3);
		}
		
		if (HasLargeInnerBearing)
			translate([0,0,-Bottom_H-Overlap]) cylinder(d=Bearing_ID-6, h=Bottom_H);
		
		// Bolt holes
		STB_BR_BoltPattern(Body_ID=Body_ID, Body_OD=Body_OD, nLockBalls=nLockBalls)
			Bolt4Hole(depth=Bottom_H);
		
		
		// Shock cord hole
		if (HasLargeInnerBearing==false)
		translate([0,0,-Bottom_H-Overlap]) 
			hull() STB_ShockCordHolePattern(Body_ID=Body_ID, Body_OD=Body_OD) 
				cylinder(d=STB_SCord_T(Body_ID), h=Bottom_H+Overlap*2);
			
		// Lock Disk goes here
		cylinder(d=LockDisk_d+1+Xtra_r*2, h=LockDiskHole_H, center=true);
		
		// Lock disk axle goes here
		cylinder(d=BearingMR84_ID+IDXtra, h=LockDiskHole_H*2+Overlap*2, center=true);
		
		
		// Locked stop
		STB_LockedStopPosition(Body_ID=Body_ID)
				cylinder(d=Dowel_d, h=Bottom_H*2+Overlap*2,center=true);
		
			
		// Unlocked Stop
		STB_UnlockedStopPosition(Body_ID=Body_ID, nLockBalls=nLockBalls)
				cylinder(d=Dowel_d, h=Bottom_H*2+Overlap*2, center=true);
				
		// Spring Groove
		if (HasSpringGroove)
		translate([0,0,-LockDiskHole_H/2-Plate_T-1]) rotate_extrude() hull(){
			translate([ST_DSpring_OD/2-1,0,0]) circle(d=2);
			translate([ST_DSpring_OD/2-1,-1,0]) circle(d=2);
		}
	} // difference
	
	// Large bearing holder
	if (HasLargeInnerBearing) 
		difference(){
			union(){
				translate([0,0,-LockDiskHole_H/2-Overlap]) cylinder(d=Bearing_ID, h=LockDiskHole_H);
				translate([0,0,-LockDiskHole_H/2-Overlap]) 
					cylinder(d=Bearing_ID+4, h=LockDiskHole_H/2-Bearing6808_W/2-0.3);
			} // union
			
			translate([0,0,-Bottom_H-Overlap]) cylinder(d=Bearing_ID-6, h=Plate_T+LockDiskHole_H+5);
		} // difference
			
	// Shock cord hole
	if (HasLargeInnerBearing==false)
	difference(){
		translate([0,0,-Bottom_H+SpringGroove_H]) 
			hull() STB_ShockCordHolePattern(Body_ID=Body_ID, Body_OD=Body_OD) 
				cylinder(d=STB_SCord_T(Body_ID)+2.4, h=Bottom_H-SpringGroove_H);
		translate([0,0,-Bottom_H-Overlap]) 
			hull() STB_ShockCordHolePattern(Body_ID=Body_ID, Body_OD=Body_OD) 
				cylinder(d=STB_SCord_T(Body_ID), h=Bottom_H+Overlap*2);
	} // difference
	
	// Magnetic latch
	difference(){
		rotate([0,0,STB_MagnetPost_a(Body_ID, nLockBalls)]) translate([Magnet_h/2,0,0])
			hull(){
				translate([0,STB_LockPinBC_d(Body_ID)/2-4,0])
					cylinder(d=Magnet_h, h=LockDisk_H+2, center=true);
				translate([0,STB_LockPinBC_d(Body_ID)/2+5,0])
					cylinder(d=Magnet_h, h=LockDisk_H+2, center=true);
			}
			
		// Magnet
		rotate([0,0,STB_MagnetPost_a(Body_ID, nLockBalls)]) translate([Magnet_h/2,STB_LockPinBC_d(Body_ID)/2,0])
			rotate([0,90,0]) cylinder(d=Magnet_d, h=Magnet_h+Overlap*2, center=true);
	} // difference
} // STB_BallRetainerBottom
/*
STB_BallRetainerBottom(Body_ID=ULine102Body_ID, Body_OD=ULine102Body_ID, nLockBalls=6, HasSpringGroove=false, Engagement_Len=20, HasLargeInnerBearing=true);
rotate([0,0,STB_Unlocked_a(ULine102Body_ID)]){
	STB_LockDisk(Body_ID=ULine102Body_ID, nLockBalls=6, HasLargeInnerBearing=true);
	STB_ShowLockBearings(Body_ID=ULine102Body_ID, nLockBalls=6);
	}
STB_ShowMyBalls(Body_ID=ULine102Body_ID, nLockBalls=6, InLockedPosition=false);
/**/
/*
STB_BallRetainerBottom(Body_ID=BT137Body_ID, Body_OD=BT137Body_ID, nLockBalls=nBT137Balls, HasSpringGroove=false, Engagement_Len=25, HasLargeInnerBearing=true);
rotate([0,0,STB_Unlocked_a(Body_ID)]){
	STB_LockDisk(Body_ID=BT137Body_ID, nLockBalls=nBT137Balls);
	STB_ShowLockBearings(Body_ID=BT137Body_ID, nLockBalls=nBT137Balls);
	}
STB_ShowMyBalls(Body_ID=BT137Body_ID, nLockBalls=nBT137Balls, InLockedPosition=false);
/**/
/*
STB_BallRetainerBottom(Body_ID=BT54Body_ID, Body_OD=PML54Coupler_ID, nLockBalls=nLockBalls, HasSpringGroove=true, Engagement_Len=20);
rotate([0,0,STB_Unlocked_a(Body_ID=PML54Body_ID)]){
	STB_LockDisk(Body_ID=PML54Body_ID, nLockBalls=3);
	STB_ShowLockBearings(Body_ID=PML54Body_ID, nLockBalls=nLockBalls);}
STB_ShowMyBalls(Body_ID=PML54Body_ID, nLockBalls=3, InLockedPosition=false);
/**/

/*
STB_BallRetainerBottom(Body_ID=PML75Body_ID, Body_OD=PML75Body_ID, nLockBalls=5, HasSpringGroove=false, Engagement_Len=20);

rotate([0,0,STB_Unlocked_a(Body_ID=PML75Body_ID)])
{
	STB_LockDisk(Body_ID=PML75Body_ID, nLockBalls=5);
	STB_ShowLockBearings(Body_ID=PML75Body_ID, nLockBalls=5);
}
STB_ShowMyBalls(Body_ID=PML75Body_ID, nLockBalls=5, InLockedPosition=false);
/**/

/*
STB_BallRetainerBottom(Body_ID=BT137Body_ID, Body_OD=BT137Body_ID, nLockBalls=7, HasSpringGroove=false, Engagement_Len=25);

//rotate([0,0,STB_Unlocked_a(Body_ID=BT137Body_ID)])
{
STB_LockDisk(Body_ID=BT137Body_ID, nLockBalls=7);
STB_ShowLockBearings(Body_ID=BT137Body_ID, nLockBalls=7);
}
/**/

//STB_BallRetainerBottom(Body_ID=BT137Body_ID, Body_OD=BT137Body_ID, nLockBalls=nBT137Balls, HasSpringGroove=false, Engagement_Len=25, HasLargeInnerBearing=true);


/* old version

module STB_TubeEnd(Body_ID=BT75Body_ID, nLockBalls=nLockBalls, 
			Body_OD=BT75Body_OD, Engagement_Len=20){

	BallPerimeter_d=STB_BallPerimeter_d(Body_ID);
	ChamferLen=4;
	Ring_OD=BallPerimeter_d+4.4;
	RingLen=Engagement_Len+10-ChamferLen;
	DepthExtra=0.5;
	
	difference(){
		union(){
			translate([0,0,-Engagement_Len/2-10]) 
				Tube(OD=Ring_OD, ID=Body_ID+IDXtra*3, Len=RingLen+Overlap, myfn=$preview? 90:360);
			
			translate([0,0,Engagement_Len/2-ChamferLen])
			difference(){
				cylinder(d1=Ring_OD, d2=Body_OD, h=ChamferLen, $fn=$preview? 90:360);
				
				translate([0,0,-Overlap])
					cylinder(d=Body_ID+IDXtra*3, h=ChamferLen+Overlap*2, $fn=$preview? 90:360);
			} // difference
			
			translate([0,0,-Engagement_Len/2-10-ChamferLen+1])
			difference(){
				cylinder(d2=Ring_OD, d1=Body_OD+IDXtra*2+1.2, h=ChamferLen-1, $fn=$preview? 90:360);
				translate([0,0,-Overlap]) cylinder(d=Body_OD+IDXtra, h=ChamferLen+Overlap*2, $fn=$preview? 90:360);
			} // difference
		} // union
		
		translate([0,0,-Engagement_Len/2-10-Overlap]) cylinder(d=Body_OD+IDXtra, h=10, $fn=$preview? 90:360);
		
		//Ball Grooves
		Steps=90/nLockBalls;
		DispPerStep=1.5/Steps;
		Offset=-0.5; // -1.0 was too tight on 3", Move groove down (tighter)
		Slot_Width=STB_LockBall_d(Body_ID)*0.86; //changed 7/18/2023 was 1.0, 0.707 min
		
		for (j=[0:nLockBalls-1]) for (k=[0:Steps])
			hull(){
				rotate([0, 0, 360/nLockBalls*j+k]) 
					translate([0, BallPerimeter_d/2+DepthExtra, -DispPerStep*k+Offset])
						rotate([90,0,0]) cylinder(d=Slot_Width, h=5);
				rotate([0, 0, 360/nLockBalls*j+k+1]) 
					translate([0, BallPerimeter_d/2+DepthExtra, -DispPerStep*(k+1)+Offset])
						rotate([90,0,0]) cylinder(d=Slot_Width, h=5);
			} // hull
			
		STB_ManualDisArmingHole(Body_ID=Body_ID, nLockBalls=nLockBalls);
		STB_ManualArmingHole(Body_ID=Body_ID);
	} // difference
	
	//echo("STB_LockBall_d=",STB_LockBall_d(Body_ID));
} // STB_TubeEnd

//STB_TubeEnd();
//STB_TubeEnd(Body_ID=PML75Body_ID, Body_OD=PML75Body_OD, Engagement_Len=20, nLockBalls=5);

//STB_TubeEnd(Body_ID=BT137Body_ID, nLockBalls=nBT137Balls, Body_OD=BT137Body_OD, Engagement_Len=25);
/**/





















