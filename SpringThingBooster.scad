// ***********************************
// Project: 3D Printed Rocket
// Filename: SpringThingBooster.scad
// by David M. Flynn
// Created: 2/26/2023
// Revision: 1.2.10   10/26/2023
// Units: mm
// ***********************************
//  ***** Notes *****
//
// A.K.A. Ball Lock
//
// Built to deploy a parachute from a booster with a spring.
// 80mm of 54mm tube is required. 
//
// Electronics:
//  Motor Topper PCB (Req. A23 12V Battery)
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
module SpringThingBoosterRev(){
	echo("SpringThingBooster Rev. 1.2.10");
} // SpringThingBoosterRev
SpringThingBoosterRev();
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
// STB_Cover(Body_OD=PML54Body_ID);
// STB_BallRetainerTop(BallPerimeter_d=PML54Body_ID, Body_OD=PML54Coupler_ID, nLockBalls=nLockBalls, HasIntegratedCouplerTube=false, Body_ID=PML54Body_ID, HasSecondServo=false, UsesBigServo=false, Engagement_Len=20);
// STB_LockDisk(BallPerimeter_d=PML54Body_ID, nLockBalls=3);
// STB_BallRetainerBottom(BallPerimeter_d=BT54Body_ID, Body_OD=PML54Coupler_ID, nLockBalls=nLockBalls, HasSpringGroove=true, Engagement_Len=20);
// STB_SpringSeat(Body_OD=PML54Coupler_ID, Base_H=14);
//
// STB_SpringCupTOMT(Tube_ID=PML75Body_ID); // Top Of Motor Tube Spring Holder
// STB_SpringEnd(Tube_ID=PML75Body_ID, CouplerTube_ID=BT75Coupler_ID, SleeveLen=0, nSprings=1, nRopeHoles=8, CenterHole_d=ST_DSpring_ID);
//
// ---------------------------
//  *** 75mm Lock version ***
//
// STB_LockDisk(BallPerimeter_d=PML75Body_OD, nLockBalls=5);
// rotate([180,0,0]) STB_BallRetainerTop(BallPerimeter_d=PML75Body_OD, Body_OD=PML75Body_ID, nLockBalls=5, HasIntegratedCouplerTube=true, Body_ID=PML75Body_ID, HasSecondServo=false, UsesBigServo=false, Engagement_Len=20);
// STB_BallRetainerBottom(BallPerimeter_d=PML75Body_OD, Body_OD=PML75Body_ID, nLockBalls=5, HasSpringGroove=false, Engagement_Len=20);
// rotate([180,0,0]) STB_TubeEnd(BallPerimeter_d=PML75Body_OD, nLockBalls=5, Body_OD=PML75Body_OD, Body_ID=PML75Body_ID, Skirt_Len=20);
// STB_SpringEnd(Tube_ID=PML75Body_ID, CouplerTube_ID=BT75Coupler_ID, SleeveLen=0);
//
// ----------------------------
//  *** 98mm Lock version ***
//
// STB_LockDisk(BallPerimeter_d=PML98Body_OD, nLockBalls=6);
// rotate([180,0,0]) STB_BallRetainerTop(BallPerimeter_d=PML98Body_OD, Body_OD=PML98Body_ID, nLockBalls=6, HasIntegratedCouplerTube=true, IntegratedCouplerLenXtra=17, Body_ID=PML98Body_ID, HasSecondServo=true, UsesBigServo=true, Engagement_Len=20);
// STB_BallRetainerBottom(BallPerimeter_d=PML98Body_OD, Body_OD=PML98Body_ID, nLockBalls=6, HasSpringGroove=false, Engagement_Len=20);
// rotate([180,0,0]) STB_TubeEnd(BallPerimeter_d=PML98Body_OD, nLockBalls=6, Body_OD=PML98Body_OD, Body_ID=PML98Body_ID, Skirt_Len=20);
// STB_SpringEnd(Tube_ID=PML98Body_ID, CouplerTube_ID=BT98Coupler_ID, SleeveLen=0);
//
// ----------------------------
//  *** 137mm Lock version ***
//
// LockBall_d=1/2 * 25.4;
// nBT137Balls=7;
// 
// STB_LockDisk(BallPerimeter_d=BT137BallPerimeter_d, nLockBalls=nBT137Balls);
// rotate([180,0,0]) STB_BallRetainerTop(BallPerimeter_d=BT137BallPerimeter_d, Body_OD=BT137Body_ID, nLockBalls=nBT137Balls, IntegratedCouplerLenXtra=-19, HasIntegratedCouplerTube=true, Body_ID=BT137Body_ID, HasSecondServo=true, UsesBigServo=true, Engagement_Len=25);
// STB_BallRetainerBottom(BallPerimeter_d=BT137BallPerimeter_d, Body_OD=BT137Body_ID, nLockBalls=nBT137Balls, HasSpringGroove=false, Engagement_Len=25);
// rotate([180,0,0]) STB_TubeEnd(BallPerimeter_d=BT137BallPerimeter_d, nLockBalls=nBT137Balls, Body_OD=BT137Body_OD, Body_ID=BT137Body_ID, Skirt_Len=25);
//
// STB_SpringEnd(Tube_ID=BT137Coupler_OD, CouplerTube_ID=BT137Coupler_ID, SleeveLen=0, nSprings=3, nRopeHoles=6);
// STB_SpringMiddle(Tube_ID=BT54Coupler_OD);
// STB_SpringPlate(OD=BT137Coupler_OD, nSprings=3, nRopeHoles=6);
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
// function STB_LockPinBC_d(BallPerimeter_d=PML54Body_ID)
// STB_CT_Section(CT_OD=PML54Coupler_OD, CT_ID=PML54Coupler_ID);
// STB_ShockCordHolePattern(BallPerimeter_d=PML54Body_ID, Body_OD=PML54Body_ID);
// STB_ManualDisArmingHole(BallPerimeter_d=PML54Coupler_OD, nLockBalls=nLockBalls);
// STB_ManualArmingHole(BallPerimeter_d=PML54Body_ID);
//
// ***********************************
//  ***** for Viewing *****
//
// STB_ShowExpandedBosterSpringThing(BallPerimeter_d=PML54Body_ID, Body_OD=PML54Coupler_ID);
// STB_ShowBosterSpringThing();
// 
/*
	STB_ShowBosterSpringThing(BallPerimeter_d=PML98Body_OD, 
		Body_OD=PML98Body_ID, 
		Body_ID=PML98Body_ID,
		HasIntegratedCouplerTube=true,
		nLockBalls=6, 
		HasCover=false,
	HasSpringGroove=false, InLockedPosition=true, UsesBigServo=true);
/**/
//
// STB_ShowLockBearings(BallPerimeter_d=PML54Body_ID);
// STB_ShowMyBalls(BallPerimeter_d=PML54Body_ID, nLockBalls=nLockBalls, InLockedPosition=true);
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


BT137BallPerimeter_d=BT137Body_OD+1;
Magnet_d=4.8;
Magnet_h=3.2;
Dowel_d=4;

// -----------------------

BearingMR84_OD=8;
BearingMR84_ID=4;
BearingMR84_W=3;

BearingR8_ID=12.7;
BearingR8_OD=1.125*25.4;
BearingR8_W=5/16*25.4;

Bearing6702_ID=15;
Bearing6702_OD=21;
Bearing6702_W=4;

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

function STB_LockBall_d(BallPerimeter_d=PML54Coupler_OD)=(BallPerimeter_d>110)? 1/2 * 25.4:3/8*25.4;

function STB_CalcChord_a(Dia=10, Dist=1)=Dist/(Dia*PI)*360;

function STB_LockPinBC_d(BallPerimeter_d=PML54Coupler_OD)=BallPerimeter_d-STB_LockBall_d(BallPerimeter_d=BallPerimeter_d)*2-BearingMR84_OD;

function STB_LockedPost_a(BallPerimeter_d=BT54Body_ID)=
			-STB_CalcChord_a(Dia=STB_LockPinBC_d(BallPerimeter_d), Dist=BearingMR84_OD/2+Dowel_d/2+0.4);
			
function STB_Unlocked_a(BallPerimeter_d=PML54Body_ID)=STB_CalcChord_a(Dia=STB_LockPinBC_d(BallPerimeter_d), Dist=BearingMR84_OD/2+Dowel_d/2);

function STB_UnlockedPost_a(BallPerimeter_d=BT54Body_ID, nLockBalls=nLockBalls)=
			STB_Unlocked_a(BallPerimeter_d)+360/nLockBalls+
				STB_CalcChord_a(Dia=STB_LockPinBC_d(BallPerimeter_d), Dist=BearingMR84_OD/2+Dowel_d/2+IDXtra*2);
				
function STB_MagnetPost_a(BallPerimeter_d=PML54Coupler_ID, nLockBalls=nLockBalls)=
			STB_UnlockedPost_a(BallPerimeter_d, nLockBalls)+
			STB_CalcChord_a(Dia=STB_LockPinBC_d(BallPerimeter_d), Dist=Dowel_d/2+Magnet_h);
//echo(STB_Unlocked_a());

function STB_SpringOffset(N=3, D=PML54Body_OD)=lookup(N,[[1, 0],[2,D/2],[3,D*tan(30)]]);

function STB_SCord_T(p=BT54Body_ID)=lookup(p,[ 
		[PML54Body_ID,3],
		[PML75Body_OD,3],
		[PML98Body_OD,3],
		[BT137Body_OD,5]
		]);

module STB_LockedStopPosition(BallPerimeter_d=BallPerimeter_d){
	translate([BearingMR84_OD/2+Dowel_d/2+IDXtra, BallPerimeter_d/2-STB_LockBall_d(BallPerimeter_d=BallPerimeter_d)-BearingMR84_OD/2,0])
		children();
} // STB_LockedStopPosition
	
module STB_UnlockedStopPosition(BallPerimeter_d=PML54Coupler_ID, nLockBalls=nLockBalls){
	rotate([0,0,STB_Unlocked_a(BallPerimeter_d)+360/nLockBalls])
	translate([-BearingMR84_OD/2-Dowel_d/2-IDXtra, BallPerimeter_d/2-STB_LockBall_d(BallPerimeter_d=BallPerimeter_d)-BearingMR84_OD/2,0])
		children();
} // STB_UnlockedStopPosition

module STB_ShowExpandedBosterSpringThing(BallPerimeter_d=PML54Body_ID, Body_OD=PML54Coupler_ID, nLockBalls=nLockBalls){

	translate([0,0,110]) STB_Cover(Body_OD=Body_OD);
	
	translate([0,0,40]) STB_BallRetainerTop(BallPerimeter_d=BallPerimeter_d, Body_OD=Body_OD);
	
	translate([0,0,20])
	//rotate([0,0,Unlocked_a]) // unlocked
	{ STB_LockDisk(BallPerimeter_d=BallPerimeter_d, nLockBalls=nLockBalls); 
		STB_ShowLockBearings(BallPerimeter_d=BallPerimeter_d, nLockBalls=nLockBalls); }
	
	STB_BallRetainerBottom(BallPerimeter_d=BallPerimeter_d, Body_OD=Body_OD, nLockBalls=nLockBalls);
	
	translate([0,0,-40]) STB_SpringSeat(Body_OD=PML54Coupler_ID, Base_H=14);
} // STB_ShowExpandedBosterSpringThing

//STB_ShowExpandedBosterSpringThing();
//STB_ShowExpandedBosterSpringThing(BallPerimeter_d=PML75Body_ID, Body_OD=PML75Body_ID, nLockBalls=4);

module STB_ShowBosterSpringThing(BallPerimeter_d=PML54Body_ID, 
			Body_OD=PML54Coupler_ID, Body_ID=PML54Body_ID,
			nLockBalls=nLockBalls,
			HasCover=false,
			HasIntegratedCouplerTube=false,
			HasSpringGroove=false,
			InLockedPosition=true,
			HasSecondServo=false,
			UsesBigServo=false){

	Lock_a=InLockedPosition? 0:STB_Unlocked_a(BallPerimeter_d);
	
	difference(){
		union(){
			if (HasCover)
			translate([0,0,52.5]) color("Orange") STB_Cover(Body_OD=Body_OD);
			
			if (HasCover)
			STB_BallRetainerTopExtras(BallPerimeter_d=BallPerimeter_d, 
									Body_OD=Body_OD, nLockBalls=nLockBalls);
									
			translate([0,0,0.1]) color("LightBlue") 
				STB_BallRetainerTop(BallPerimeter_d=BallPerimeter_d, Body_OD=Body_OD, nLockBalls=nLockBalls,
					HasIntegratedCouplerTube=HasIntegratedCouplerTube,
					Body_ID=Body_ID,
					HasSecondServo=HasSecondServo,
					UsesBigServo=UsesBigServo);
			
			
			
			//translate([0,0,-33]) color("Gray") STB_SpringSeat(Body_OD=PML54Coupler_ID, Base_H=14);
		} // union
		
		translate([-100,-50,-50]) cube([100,50,150]);
	} // difference
	
	rotate([0,0,Lock_a])
		{ STB_LockDisk(BallPerimeter_d=BallPerimeter_d, nLockBalls=nLockBalls); 
			STB_ShowLockBearings(BallPerimeter_d=BallPerimeter_d, nLockBalls=nLockBalls); }
		
	color("White")
	STB_ShowMyBalls(BallPerimeter_d=BallPerimeter_d, nLockBalls=nLockBalls, 
			InLockedPosition=InLockedPosition);
	
	color("Green") 
		STB_BallRetainerBottom(BallPerimeter_d=BallPerimeter_d, 
							Body_OD=Body_OD, nLockBalls=nLockBalls, 
								HasSpringGroove=HasSpringGroove);
			
	
} // STB_ShowBosterSpringThing

/*
STB_ShowBosterSpringThing(BallPerimeter_d=PML54Body_ID, 
	Body_OD=PML54Coupler_ID, Body_ID=PML54Body_ID, 
	nLockBalls=3,
	HasCover=true,
	HasSpringGroove=true);
/**/
	
/*
STB_ShowBosterSpringThing(BallPerimeter_d=PML98Body_OD, 
	Body_OD=PML98Body_ID, 
	Body_ID=PML98Body_ID,
	HasIntegratedCouplerTube=true,
	nLockBalls=6, 
	HasCover=false,
	HasSpringGroove=false, InLockedPosition=true, HasSecondServo=true, UsesBigServo=true);
/**/



//echo("STB_SpringOffset()=",STB_SpringOffset());

module STB_SpringPlate(OD=128, nSprings=1, nRopeHoles=8){
// made to fit 137mm nosecone
	InnerTube_ID=BT54Body_ID;
	Spring_Y=(nSprings>1)? STB_SpringOffset(N=nSprings, D=PML54Body_OD):0;
	
	Tail_Len=6;
	MotorTopDepth=Tail_Len-7;
	
	Lashing_Y=(nSprings>1)? 4:10;
	
	difference(){
		translate([0,0,-Tail_Len]) cylinder(d=OD, h=Tail_Len);
		
		for (j=[0:nSprings-1]) rotate([0,0,360/nSprings*j]) translate([0,Spring_Y,0]){
			translate([0,0,-Tail_Len-Overlap]) cylinder(d=ST_DSpring_ID-1, h=Tail_Len+Overlap*2);
			translate([0,0,-2])
			Tube(OD=PML54Body_OD+IDXtra*2, ID=PML54Body_ID, Len=6, myfn=$preview? 36:360);
		}
		for (j=[0:nRopeHoles-1]) rotate([0,0,360/nRopeHoles*j+30])
			translate([0,Spring_Y+ST_DSpring_OD/2+Lashing_Y,-Tail_Len-Overlap])
				cylinder(d=5, h=Tail_Len+Overlap*2);
	} // difference
	
	for (j=[0:nSprings-1]) rotate([0,0,360/nSprings*j]) translate([0,Spring_Y,0]){
		//Tube(OD=PML54Body_OD, ID=PML54Body_ID, Len=20, myfn=$preview? 36:360);
	difference(){
		union(){
			cylinder(d=ST_DSpring_ID-1, h=ST_DSpring_CBL-6); // -6 to mate with ST_SpringMiddle
			translate([0,0,-Tail_Len+Overlap]) cylinder(d=InnerTube_ID-IDXtra, h=Tail_Len);
		} // union
		
		translate([0,0,-Tail_Len]) cylinder(d=39, h=MotorTopDepth);
		translate([0,0,-Tail_Len]) cylinder(d=35, h=Tail_Len+ST_DSpring_CBL+Overlap*2);
	} // difference
	}
	
} // STB_SpringPlate

//STB_SpringPlate(OD=128, nSprings=3, nRopeHoles=6);

module STB_SpringEnd(Tube_ID=PML75Body_ID, CouplerTube_ID=BT75Coupler_ID, SleeveLen=0, nSprings=1, nRopeHoles=8, CenterHole_d=ST_DSpring_ID){

	Slider_h=16;
	
	Spring_Y=(nSprings>1)? STB_SpringOffset(N=nSprings, D=PML54Body_OD):0;
	Lashing_Y=(nSprings>1)? 4:10;
	
	difference(){
		cylinder(d=Tube_ID-IDXtra*2, h=Slider_h);
		
		// Slider tube glues here
		if (SleeveLen==0)
			translate([0,0,5]) Tube(OD=Tube_ID, ID=CouplerTube_ID-IDXtra, Len=20, myfn=$preview? 36:360);
		
		// Tube face
		translate([0,0,6]) cylinder(d1=ST_DSpring_ID, d2=Tube_ID-4.4+Overlap, h=10+Overlap);
		
		// Spring holes
		for (j=[0:nSprings-1]) rotate([0,0,360/nSprings*j]) translate([0,Spring_Y,0]){
			translate([0,0,-Overlap]) cylinder(d=CenterHole_d, h=Slider_h+Overlap*2);
			translate([0,0,-Overlap]) cylinder(d=ST_DSpring_OD, h=3);
			}
		
		if (nRopeHoles>1)
		for (j=[0:nRopeHoles-1]) rotate([0,0,360/nRopeHoles*j+30])
			translate([0,Spring_Y+ST_DSpring_OD/2+Lashing_Y,-Overlap])
				cylinder(d=5, h=Slider_h+Overlap*2);
	} // difference
	
	if (SleeveLen>0)
		Tube(OD=Tube_ID-IDXtra*2, ID=CouplerTube_ID-IDXtra-Overlap, Len=SleeveLen, myfn=$preview? 90:360);
} // STB_SpringEnd

//STB_SpringEnd(Tube_ID=BT75Body_ID, CouplerTube_ID=BT75Coupler_ID, SleeveLen=0, nSprings=1, nRopeHoles=8, CenterHole_d=ST_DSpring_ID);

// STB_SpringEnd(Tube_ID=PML98Body_ID, CouplerTube_ID=BT98Coupler_ID, SleeveLen=0);

//STB_SpringEnd(Tube_ID=LOC65Body_ID, CouplerTube_ID=LOC65Coupler_ID, SleeveLen=30, nSprings=1, nRopeHoles=0, CenterHole_d=10);

//STB_SpringEnd(Tube_ID=BT137Coupler_OD, CouplerTube_ID=BT137Coupler_ID, SleeveLen=0, nSprings=3, nRopeHoles=6);

// Custom for Rainbow One
//STB_SpringEnd(Tube_ID=98.5, CouplerTube_ID=BT98Coupler_ID, SleeveLen=60);

module STB_SpringCupTOMT(Tube_ID=PML75Body_ID){
   // Top Of Motor Tube Spring Holder
	Slider_h=6;
	nRopeHoles=8;
	
	difference(){
		union(){
			cylinder(d=Tube_ID-IDXtra*2, h=Slider_h);
			translate([0,0,-ST_DSpring_CBL+3]) 
				Tube(OD=ST_DSpring_OD+1+4.4, ID=ST_DSpring_OD+1, Len=20, myfn=$preview? 36:360);
		} // union
		
		//translate([0,0,5]) Tube(OD=Tube_ID, ID=CouplerTube_ID-IDXtra, Len=20, myfn=$preview? 36:360);
		
		for (j=[0:nRopeHoles-1]) rotate([0,0,360/nRopeHoles*j])
			translate([0,ST_DSpring_OD/2+10,-Overlap]) cylinder(d=5, h=Slider_h+Overlap*2);
		
		//translate([0,0,6]) cylinder(d1=ST_DSpring_ID, d2=Tube_ID-4.4+Overlap, h=10+Overlap);
		translate([0,0,-Overlap]) cylinder(d=ST_DSpring_ID, h=Slider_h+Overlap*2);
		translate([0,0,-Overlap]) cylinder(d=ST_DSpring_OD, h=3);
	} // difference
} // STB_SpringCupTOMT

// Custom for Rainbow One
// rotate([180,0,0]) STB_SpringCupTOMT(Tube_ID=98.5);
//STB_SpringCupTOMT(Tube_ID=78.5);

module STB_SpringMiddle(Tube_ID=BT54Coupler_OD){
		
	difference(){
		translate([0,0,-ST_DSpring_CBL-2]) cylinder(d=Tube_ID-LooseFit, h=ST_DSpring_CBL*2+4);
		
		// center hole
		translate([0,0,-ST_DSpring_CBL-2-Overlap]) cylinder(d=Tube_ID-4.4, h=ST_DSpring_CBL*2+4+Overlap*2);
	} // difference
	
	difference(){
		union(){
			translate([0,0,-6]) cylinder(d=ST_DSpring_ID-1, h=ST_DSpring_CBL+6);
			translate([0,0,-2]) cylinder(d=Tube_ID-LooseFit, h=2);
		} // union
		
		// center hole
		translate([0,0,-ST_DSpring_CBL-Overlap]) cylinder(d=35, h=ST_DSpring_CBL*2+Overlap*2);
		
	} // difference
} // STB_SpringMiddle

//STB_SpringMiddle();

module STB_SpringGuide(InnerTube_ID=BT54Body_ID){
	// Sits on top of Aerotech 54mm motor w/ plugged threaded forward closure and eye bolt
	Tail_Len=22;
	MotorTopDepth=Tail_Len-7;
	
	difference(){
		union(){
			cylinder(d=ST_DSpring_ID-1, h=ST_DSpring_CBL-6); // -6 to mate with ST_SpringMiddle
			translate([0,0,-Tail_Len+Overlap]) cylinder(d=InnerTube_ID-LooseFit, h=Tail_Len);
		} // union
		
		translate([0,0,-Tail_Len]) cylinder(d=39, h=MotorTopDepth);
		translate([0,0,-Tail_Len]) cylinder(d=35, h=Tail_Len+ST_DSpring_CBL+Overlap*2);
	} // difference
} // STB_SpringGuide

// STB_SpringGuide(InnerTube_ID=BT54Body_ID);

module STB_SpringSeat(Body_OD=PML54Coupler_ID, Base_H=14){
	
	echo("Spring Seat = ",Base_H+ST_DSpring_CBL);
	
	difference(){
		union(){
			translate([0,0,-Overlap]) cylinder(d=ST_DSpring_ID, h=ST_DSpring_CBL);
			translate([0,0,-Base_H]) cylinder(d=Body_OD, h=Base_H);
		} // union
		
		translate([0,0,-Base_H-Overlap]) cylinder(d=ST_DSpring_ID-4.4, h=Base_H+ST_DSpring_CBL+Overlap*2);
	} // difference
} // STB_SpringSeat

//STB_SpringSeat();
//STB_SpringSeat(Body_OD=PML75Coupler_ID, Base_H=14);

module STB_CT_Section(CT_OD=PML54Coupler_OD, CT_ID=PML54Coupler_ID){
	difference(){
		translate([0,0,-25]) Tube(OD=CT_OD, ID=CT_ID, Len=40, myfn=$preview? 36:360);
		
		for (j=[0:nLockBalls-1]) rotate([0,0,360/nLockBalls*j]) 
			translate([0,CT_OD/2+1,0]) rotate([90,0,0]) cylinder(d=STB_LockBall_d(BallPerimeter_d=BallPerimeter_d), h=10);
	} // difference
} // STB_CT_Section

//STB_CT_Section();
//STB_CT_Section(CT_OD=PML75Coupler_OD, CT_ID=PML75Coupler_ID);

module STB_ShowMyBalls(BallPerimeter_d=PML54Body_ID, nLockBalls=nLockBalls, InLockedPosition=true){
	BallInset=InLockedPosition? STB_LockBall_d(BallPerimeter_d=BallPerimeter_d)/2:STB_LockBall_d(BallPerimeter_d=BallPerimeter_d)/2+3;
	
	for (j=[0:nLockBalls-1]) rotate([0,0,360/nLockBalls*j]) 
			translate([0,BallPerimeter_d/2-BallInset,0]) 
				color("Red") sphere(d=STB_LockBall_d(BallPerimeter_d=BallPerimeter_d));

} // STB_ShowMyBalls

//STB_ShowMyBalls(BallPerimeter_d=PML54Body_ID, nLockBalls=nLockBalls, InLockedPosition=true);
//STB_ShowMyBalls(BallPerimeter_d=PML54Body_ID, nLockBalls=nLockBalls, InLockedPosition=false);

module STB_ShowLockBearings(BallPerimeter_d=PML54Body_ID, nLockBalls=nLockBalls){
	
	for (j=[0:nLockBalls-1]) rotate([0,0,360/nLockBalls*j]) 
		translate([0,STB_LockPinBC_d(BallPerimeter_d)/2,0]) {
			color("Red") cylinder(d=BearingMR84_ID, h=10+Overlap, center=true);
			color("Blue") cylinder(d=BearingMR84_OD, h=BearingMR84_W, center=true);
		} // for
} // ShowLockBearings

//STB_ShowLockBearings();
//STB_ShowLockBearings(BallPerimeter_d=PML75Body_OD, nLockBalls=4);

module STB_LockDisk(BallPerimeter_d=PML54Body_ID, nLockBalls=nLockBalls){
	Xtra_r=0.2; // a little tighter
	MagnetOvershoot_a=STB_CalcChord_a(Dia=BallPerimeter_d-STB_LockBall_d(BallPerimeter_d=BallPerimeter_d)*2, Dist=0.6);
	

	difference(){
		union(){
			// Hub
			cylinder(d=BearingMR84_OD+6, h=LockDisk_H, center=true);
			
			// Bearing holders
			for (j=[0:nLockBalls-1]) rotate([0,0,360/nLockBalls*j]) hull(){
				cylinder(d=BearingMR84_OD+2, h=LockDisk_H, center=true);
				translate([0,STB_LockPinBC_d(BallPerimeter_d)/2,0])
					cylinder(d=BearingMR84_OD, h=LockDisk_H, center=true);
				}
			
			// Add stiffeners
			if (BallPerimeter_d>105) for (j=[0:nLockBalls-1]) 
				hull(){
					rotate([0,0,360/nLockBalls*j]) 
						translate([0,STB_LockPinBC_d(BallPerimeter_d)/2-20,0])
							cylinder(d=3, h=LockDisk_H, center=true);
					rotate([0,0,360/nLockBalls*(j+1)]) 
						translate([0,STB_LockPinBC_d(BallPerimeter_d)/2-20,0])
							cylinder(d=3, h=LockDisk_H, center=true);
				} // hull
				
			// Magnetic latch
			rotate([0,0,STB_MagnetPost_a(BallPerimeter_d, nLockBalls)+MagnetOvershoot_a]) translate([-Magnet_h/2,0,0])
			hull(){
				cylinder(d=Magnet_h, h=LockDisk_H, center=true);
				translate([0,STB_LockPinBC_d(BallPerimeter_d)/2+2.5,0])
					cylinder(d=Magnet_h, h=LockDisk_H, center=true);
			}
		} // union
		
		// Magnet
		rotate([0,0,STB_MagnetPost_a(BallPerimeter_d, nLockBalls)+MagnetOvershoot_a]) 
			translate([-Magnet_h/2, STB_LockPinBC_d(BallPerimeter_d)/2,0])
				rotate([0,90,0]) cylinder(d=Magnet_d, h=Magnet_h+Overlap*2, center=true);
		
		// Center Bearings
		cylinder(d=BearingMR84_OD-1, h=LockDisk_H+Overlap*2, center=true);
		translate([0,0,-LockDisk_H/2-Overlap]) 
			cylinder(d=BearingMR84_OD+IDXtra*2, h=BearingMR84_W+Overlap);
		translate([0,0,LockDisk_H/2-BearingMR84_W]) 
			cylinder(d=BearingMR84_OD+IDXtra*2, h=BearingMR84_W+Overlap);
			
		// Lock axles and bearings
		for (j=[0:nLockBalls-1]) rotate([0,0,360/nLockBalls*j]) 
			translate([0,STB_LockPinBC_d(BallPerimeter_d)/2+Xtra_r,0]) {
				cylinder(d=BearingMR84_ID+IDXtra, h=LockDisk_H+Overlap*2, center=true);
				cylinder(d=BearingMR84_OD+2, h=BearingMR84_W+1, center=true);
				}
	} // difference
} // STB_LockDisk

//STB_LockDisk();
//STB_BallRetainerBottom(BallPerimeter_d=PML54Body_ID, nLockBalls=3);

//STB_LockDisk(BallPerimeter_d=PML75Body_OD, nLockBalls=5);

//rotate([0,0,Unlocked_a]) 
//{ STB_LockDisk(); STB_ShowLockBearings(); }


module STB_ShockCordHolePattern(BallPerimeter_d=PML54Body_ID, Body_OD=PML54Coupler_ID){
	Offset_a=STB_LockedPost_a(BallPerimeter_d=BallPerimeter_d)-
		STB_CalcChord_a(Dia=STB_LockPinBC_d(BallPerimeter_d=BallPerimeter_d), Dist=Dowel_d/2+STB_SCord_T(BallPerimeter_d));
	
	SCord_W=lookup(BallPerimeter_d,[ 
		[PML54Body_ID,9],
		[PML75Body_OD,12],
		[PML98Body_OD,12],
		[BT137Body_OD,19]
		]);
	
	echo(SCord_W=SCord_W);
	rotate([0,0,Offset_a]){
		translate([0,Body_OD/2-6,0]) children();
		translate([0,Body_OD/2-6-SCord_W,0]) children();
	}
} // STB_ShockCordHolePattern

//hull() STB_ShockCordHolePattern() cylinder(d=3, h=3);
//hull() STB_ShockCordHolePattern(BallPerimeter_d=BT137Body_OD+1, Body_OD=BT137Body_ID) cylinder(d=3, h=3);

module STB_BR_BoltPattern(BallPerimeter_d=PML54Body_ID, Body_OD=PML54Coupler_ID, nLockBalls=nLockBalls){
	// Body bolt pattern
	
	Offset_a=(Body_OD<=PML54Body_OD)? 180/nLockBalls-24:STB_CalcChord_a(Dia=Body_OD-STB_LockBall_d(BallPerimeter_d=BallPerimeter_d), Dist=STB_LockBall_d(BallPerimeter_d=BallPerimeter_d)/2+4);
	
	for (j=[0:nLockBalls-1]) 
		rotate([0,0,360/nLockBalls*j+Offset_a]) translate([0,Body_OD/2-Bolt4Inset,0]) children();
		
} // STB_BR_BoltPattern

// STB_BR_BoltPattern(Body_OD=PML54Coupler_ID) Bolt4Hole();

module STB_DrillingJig(BallPerimeter_d=BT54Body_ID, nLockBalls=nLockBalls, Body_OD=BT54Coupler_OD, Skirt_Len=20){
	// This is a tool for drilling holes in a coupler tube.
	difference(){
		union(){
			translate([0,0,Skirt_Len/2]) Tube(OD=Body_OD+6, ID=Body_OD-6, Len=4, myfn=$preview? 90:360);
			translate([0,0,-Skirt_Len/2]) Tube(OD=Body_OD+6, ID=Body_OD+IDXtra*3, Len=Skirt_Len+4, myfn=$preview? 90:360);
		} // union
	
		for (j=[0:nLockBalls-1]) rotate([0,0,360/nLockBalls*j]) 
			rotate([-90,0,0]) cylinder(d=STB_LockBall_d(BallPerimeter_d=BallPerimeter_d)-2, h=Body_OD);
			
		STB_ManualDisArmingHole(BallPerimeter_d=BallPerimeter_d, nLockBalls=nLockBalls);
		STB_ManualArmingHole(BallPerimeter_d=BallPerimeter_d);
	} // difference
	
	
} // STB_DrillingJig

// STB_DrillingJig();
// STB_DrillingJig(BallPerimeter_d=PML75Body_OD, Body_OD=PML75Body_OD, Skirt_Len=20);

module STB_TubeEnd(BallPerimeter_d=PML75Body_OD, nLockBalls=nLockBalls, 
			Body_OD=PML75Body_OD, Body_ID=PML75Body_ID, Skirt_Len=20){

	ChamferLen=4;
	Ring_OD=BallPerimeter_d+4.4;
	RingLen=Skirt_Len+10-ChamferLen;
	
	difference(){
		union(){
			translate([0,0,-Skirt_Len/2-10]) 
				Tube(OD=Ring_OD, ID=Body_ID+IDXtra*3, Len=RingLen+Overlap, myfn=$preview? 90:360);
			
			translate([0,0,Skirt_Len/2-ChamferLen])
			difference(){
				cylinder(d1=Ring_OD, d2=Body_OD, h=ChamferLen, $fn=$preview? 90:360);
				
				translate([0,0,-Overlap])
					cylinder(d=Body_ID+IDXtra*3, h=ChamferLen+Overlap*2, $fn=$preview? 90:360);
			} // difference
			
			translate([0,0,-Skirt_Len/2-10-ChamferLen+1])
			difference(){
				cylinder(d2=Ring_OD, d1=Body_OD+IDXtra*2+1.2, h=ChamferLen-1, $fn=$preview? 90:360);
				translate([0,0,-Overlap]) cylinder(d=Body_OD+IDXtra*2, h=ChamferLen+Overlap*2, $fn=$preview? 90:360);
			} // difference
		} // union
		
		translate([0,0,-Skirt_Len/2-10-Overlap]) cylinder(d=Body_OD+IDXtra*2, h=10, $fn=$preview? 90:360);
		
		//Ball Grooves
		Steps=90/nLockBalls;
		DispPerStep=1.5/Steps;
		Offset=-0.5; // -1.0 was too tight on 3", Move groove down (tighter)
		Slot_Width=STB_LockBall_d(BallPerimeter_d=BallPerimeter_d)*0.86; //changed 7/18/2023 was 1.0, 0.707 min
		
		for (j=[0:nLockBalls-1]) for (k=[0:Steps])
			hull(){
				rotate([0,0,360/nLockBalls*j+k]) 
					translate([0,BallPerimeter_d/2+1,-DispPerStep*k+Offset])
						rotate([90,0,0]) cylinder(d=Slot_Width, h=5);
				rotate([0,0,360/nLockBalls*j+k+1]) 
					translate([0,BallPerimeter_d/2+1,-DispPerStep*(k+1)+Offset])
						rotate([90,0,0]) cylinder(d=Slot_Width, h=5);
			} // hull
			
		STB_ManualDisArmingHole(BallPerimeter_d=BallPerimeter_d, nLockBalls=nLockBalls);
		STB_ManualArmingHole(BallPerimeter_d=BallPerimeter_d);
	} // difference
	
	//echo("STB_LockBall_d=",STB_LockBall_d(BallPerimeter_d=BallPerimeter_d));
} // STB_TubeEnd

//STB_TubeEnd(BallPerimeter_d=PML75Body_OD, Body_OD=PML75Body_OD, Body_ID=PML75Body_ID, Skirt_Len=20, nLockBalls=5);

//STB_TubeEnd(BallPerimeter_d=BT137BallPerimeter_d, nLockBalls=nBT137Balls, Body_OD=BT137Body_OD, Body_ID=BT137Body_ID, Skirt_Len=25);

module STB_CoverBoltPattern(Body_OD=PML54Body_ID){
	for (j=[0:1]) rotate([0,0,180*j-53]) translate([0,Body_OD/2-6,0]) children();
} // STB_CoverBoltPattern

// STB_CoverBoltPattern() Bolt4Hole();

module STB_Cover(BallPerimeter_d=PML54Body_ID, Body_OD=PML54Body_ID){
	Plate_T=3;
	Cover_h=21;
	BH_Depth=13;
	Lip_h=3;
	
	
	Tube(OD=Body_OD-IDXtra*2, ID=Body_OD-IDXtra*2-4.4, Len=Cover_h+Plate_T, myfn=$preview? 90:360);
	
	// Top
	difference(){
		union(){
			translate([0,0,Cover_h]) cylinder(d=Body_OD-1, h=Plate_T);
			
			STB_CoverBoltPattern(Body_OD=Body_OD) hull(){
				cylinder(d=8, h=Cover_h+Overlap);
				translate([-4.5,4,0]) cube([9,1,Cover_h+Overlap]);
				}
		} // union
		
		// Shock Cord
		rotate([0,0,10])translate([0,0,Cover_h-Overlap]) 
			hull() STB_ShockCordHolePattern(BallPerimeter_d=BallPerimeter_d, Body_OD=Body_OD) 
				cylinder(d=STB_SCord_T(BallPerimeter_d), h=Plate_T+Overlap*2);
			
		// Bolts
		translate([0,0,3]) STB_CoverBoltPattern(Body_OD=Body_OD) Bolt4HeadHole(depth=8,lHead=Cover_h+Plate_T);
	} // difference
	
	
	// Skirt, Overlaps into top
	difference(){
		intersection(){
			difference(){
				union(){
					Tube(OD=Body_OD-IDXtra*2-4.4+Overlap, ID=Body_OD-IDXtra*2-4.4-4.4, 
								Len=7, myfn=$preview? 90:360);
					
					translate([0,0,-Lip_h]) 
						Tube(OD=Body_OD-IDXtra*2-4.4-IDXtra, ID=Body_OD-IDXtra*2-4.4-4.4, 
								Len=Lip_h+Overlap, myfn=$preview? 90:360);
					
					
					// Bolt Bosses
					translate([0,0,-Lip_h]) STB_CoverBoltPattern(Body_OD=Body_OD) hull(){
						cylinder(d=8, h=10+Overlap);
						translate([-4.5,4,0]) cube([9,1,10+Overlap]);
						}
				}
			
				translate([0,0,-Lip_h-Overlap])
					Tube(OD=Body_OD, ID=Body_OD-IDXtra*2-4.4, Len=10+Overlap*2, myfn=$preview? 90:360);
				translate([0,0,3]) 
					cylinder(d1=Body_OD-IDXtra*2-4.4-4.4, d2=Body_OD-IDXtra*2-4.4+Overlap, h=4+Overlap);
			} // difference
			
			union(){
				translate([0,0,-Lip_h]) STB_CoverBoltPattern(Body_OD=Body_OD) hull(){
					cylinder(d=8, h=10+Overlap);
					translate([-4.5,4,0]) cube([9,1,10+Overlap]);
					}
					
				translate([-10,0,-Lip_h]) cube([20,Body_OD/2,10]);
				
				rotate([0,0,-68]) translate([-4,0,-Lip_h]) cube([8,Body_OD/2,10]);
				rotate([0,0,-180]) translate([-4,0,-Lip_h]) cube([8,Body_OD/2,10]);
				rotate([0,0,147]) translate([-12,0,-Lip_h]) cube([24,Body_OD/2,10]);
				rotate([0,0,57]) translate([-3,0,-Lip_h]) cube([6,Body_OD/2,10]);
			} // union
		} // intersection
		
		// Bolt holes
		translate([0,0,3]) STB_CoverBoltPattern(Body_OD=Body_OD) Bolt4HeadHole(depth=20);
	} // difference
		
	// Motor Topper Hold Down
	intersection(){
		hull(){
			translate([-4,Body_OD/2-12,4]) cube([8,12,1]);
			translate([-4,Body_OD/2-1,18]) cube([8,1,1]);
		} // hull
		cylinder(d=Body_OD-1, h=20);
	} // intersection
	
	// Battery Hold Down
	intersection(){
		rotate([0,0,57]) translate([0, -Body_OD/2+14.0, 0])
			difference(){
				union(){
					translate([0,0,-10]) SingleBatteryPocket(ShowBattery=false);
					translate([-10,-15,0]) cube([20,5,46]);
					translate([0,0,BH_Depth]) RoundRect(X=30, Y=20, Z=2, R=2);
				} // union
			
				translate([10,10,-Overlap]) cylinder(d1=25, d2=20, h=5);
				translate([10,-5,-Overlap]) cube([10,10,BH_Depth+Overlap]);
			} // difference
			
		cylinder(d=Body_OD-1, h=BH_Depth+2);
	} // intersection
} // STB_Cover

//translate([0,0,40+12.1]) STB_Cover();
ArmingHole_d=2.5;

module STB_ManualArmingHole(BallPerimeter_d=PML54Body_ID){

		rotate([0,0,STB_Unlocked_a(BallPerimeter_d)]) 
			translate([0,STB_LockPinBC_d(BallPerimeter_d)/2,LockDiskHole_H/2-2])
				rotate([0,-90,0]) cylinder(d=ArmingHole_d, h=50);
	} // STB_ManualArmingHole
	
//STB_ManualArmingHole();

module STB_BallRetainerTopExtras(BallPerimeter_d=PML54Body_ID, Body_OD=PML54Coupler_ID, nLockBalls=nLockBalls){

// Used for 54mm original booster version.

	Plate_T=3;
	Top_H=LockDiskHole_H/2+Plate_T;
	Skirt_H=40;
	CT_Len=12;
	
	// Bolt bosses to attach cover
	translate([0,0,CT_Len+Skirt_H-5])difference(){
		union(){
			translate([0,0,-8-Overlap]) 
				STB_CoverBoltPattern(Body_OD=Body_OD) hull(){
					cylinder(d=8, h=8);
					translate([-4.5,4,0]) cube([9,1,8]);
				}
			
			STB_CoverBoltPattern(Body_OD=Body_OD) hull(){
				translate([0,0,-8-Overlap])  cylinder(d=8, h=Overlap);
				translate([-4.5,4,-8-Overlap]) cube([9,1,Overlap]);
				translate([0,5,-20])  cylinder(d=1, h=Overlap);
			}
		}
		
		STB_CoverBoltPattern(Body_OD=Body_OD) Bolt4Hole(depth=9);
	}
	
	// Rocket Servo PCB Rails
	RS_PCB_X=15.4;
	translate([0,0,LockDisk_H/2+Plate_T-Overlap])
	intersection(){
		rotate([0,0,90]) translate([0, Body_OD/2-4.5, Skirt_H/2])
			difference(){
				hull(){
					cube([RS_PCB_X+2.4,1,Skirt_H],center=true);
					translate([0,5,0]) cube([RS_PCB_X+7,1,Skirt_H],center=true);
				} // hull
				
				cube([RS_PCB_X-2,8,Skirt_H+Overlap],center=true);
				translate([0,2,0]) cube([RS_PCB_X,3,Skirt_H+Overlap],center=true);
			} // difference
		
		union(){	
			translate([0,0,3-Overlap]) cylinder(d=Body_OD+1, h=Skirt_H);
			cylinder(d=Body_OD-1, h=3);
		}
	} // intersection
	
	// Motor Topper PCB Rails
	MT_PCB_X=26.5;
	MT_PCB_Back_Y=3.5;
	difference(){
		translate([0.5,0,LockDisk_H/2+Plate_T-Overlap])
			intersection(){
				translate([-2, Body_OD/2-7-MT_PCB_Back_Y, Skirt_H/2])
					difference(){
						hull(){
							cube([MT_PCB_X+2.4,1,Skirt_H],center=true);
							translate([0,5,0]) cube([MT_PCB_X+7,2+MT_PCB_Back_Y,Skirt_H],center=true);
						} // hull
						
						translate([0,5,0]) cube([MT_PCB_X-2, 14, Skirt_H+Overlap],center=true);
						translate([0,1.5,0]) cube([MT_PCB_X,2,Skirt_H+Overlap],center=true);
						
						translate([1,5,10]) cube([MT_PCB_X-2, MT_PCB_Back_Y+2, Skirt_H+Overlap],center=true);
					} // difference
		
				union(){	
					translate([0,0,3-Overlap]) cylinder(d=Body_OD+1, h=Skirt_H);
					cylinder(d=Body_OD-1, h=3);
				} // union
			} // intersection
			
		// Shock Cord
		hull() STB_ShockCordHolePattern(BallPerimeter_d=BallPerimeter_d, Body_OD=Body_OD) 
			cylinder(d=STB_SCord_T(BallPerimeter_d), h=Top_H+5);
			
		// Bolt holes
		translate([0,0,STB_LockBall_d(BallPerimeter_d=BallPerimeter_d)/2+Plate_T]) 
			STB_BR_BoltPattern(BallPerimeter_d=BallPerimeter_d, Body_OD=Body_OD, nLockBalls=nLockBalls) Bolt4HeadHole();
	} // difference
	
	// Battery mount
	intersection(){
		rotate([0,0,57]) translate([0, -Body_OD/2+12.3, 5])
			difference(){
				union(){
					SingleBatteryPocket(ShowBattery=false);
					translate([-10,-15,0]) cube([20,5,46]);
				} // union
				translate([0,0,-Overlap]) cylinder(d=40, h=CT_Len);
				hull(){
					translate([-25,-15,5]) cube([50,30,1]);
					translate([-25,0,30]) cube([50,30,1]);
				} // hull
				translate([-25,0,0]) cube([50,50,50]);
			} // difference
				
			translate([0,0,LockDisk_H/2+Plate_T-Overlap])
				union(){	
					translate([0,0,3-Overlap]) cylinder(d=Body_OD+1, h=Skirt_H);
					cylinder(d=Body_OD-1, h=3);
				} // union
	} // intersection
	
	// Skirt
			translate([0,0,CT_Len-Overlap]) 
				Tube(OD=BallPerimeter_d-IDXtra*2, ID=BallPerimeter_d-IDXtra*2-4.4, Len=Skirt_H+Overlap, myfn=$preview? 90:360);
} // STB_BallRetainerTopExtras

// STB_BallRetainerTopExtras();

/*
STB_BallRetainerTopExtras(BallPerimeter_d=PML54Body_ID, Body_OD=PML54Coupler_ID, nLockBalls=nLockBalls);
STB_BallRetainerTop(BallPerimeter_d=PML54Body_ID, Body_OD=PML54Coupler_ID, nLockBalls=nLockBalls,
			HasIntegratedCouplerTube=false,
			Body_ID=PML54Body_ID);
/**/

module STB_BallRetainerTop(BallPerimeter_d=PML54Body_ID, Body_OD=PML54Coupler_ID, nLockBalls=nLockBalls,
			HasIntegratedCouplerTube=false,
			IntegratedCouplerLenXtra=0,
			Body_ID=PML54Body_ID,
			HasSecondServo=false,
			UsesBigServo=false,
			Engagement_Len=20){
			
	Plate_T=3;
	LockDisk_d=STB_LockPinBC_d(BallPerimeter_d)+BearingMR84_OD;
	
	Top_H=LockDiskHole_H/2+Plate_T;
	Skirt_H=40;
	CT_Len=Engagement_Len/2+2;
	ServoArm_Len=UsesBigServo? 10:4; // was =10; 6/11/23
	Servo_Z=18;
	Servo_r=BallPerimeter_d/2-STB_LockBall_d(BallPerimeter_d=BallPerimeter_d)-BearingMR84_OD/2-ServoArm_Len;
	IntCouplerLen=UsesBigServo? IntegratedCouplerLenXtra+24:IntegratedCouplerLenXtra+13;
	
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
		
		Servo_a=360/nLockBalls-STB_CalcChord_a(Dia=Servo_r*2, Dist=BearingMR84_OD/2+6);
		
		rotate([0,0,Servo_a+SecondServo_a])
			translate([0, Servo_r-2, Servo_Z+9]) rotate([0,0,-135]) rotate([180,0,0]) children();
		
		//#translate([-10,4,4]) cylinder(d=10, h=3);
	} // BigServoPosition
	
	module ServoArm(){
		cylinder(d=7, h=2);
		hull(){
			cylinder(d=7, h=2);
			translate([0,10,0]) cylinder(d=4, h=2);
		}
	} // ServoArm
	
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
					translate([0,0,Engagement_Len/2]) cylinder(d=BallPerimeter_d-IDXtra*2, h=2, $fn=$preview? 90:360);
					
				} // union
				translate([0,0,Engagement_Len/2-Overlap]) 
					cylinder(d1=Body_OD-5.4, d2=BallPerimeter_d-4.4, h=2+Overlap*2, $fn=$preview? 90:360);
			} // difference
			
			if (HasIntegratedCouplerTube){
				translate([0,0,Engagement_Len/2]) 
					Tube(OD=Body_ID, ID=Body_ID-6, Len=IntCouplerLen+13, myfn=$preview? 90:360);
				// gap filler
				translate([0,0,Engagement_Len/2-5]) 
					Tube(OD=Body_ID-1, ID=Body_ID-6, Len=6, myfn=$preview? 90:360);
				translate([0,0,Engagement_Len/2]) 
					Tube(OD=BallPerimeter_d, ID=Body_ID-4.4, Len=IntCouplerLen, myfn=$preview? 90:360);
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
		
		STB_ManualArmingHole(BallPerimeter_d=BallPerimeter_d);
		
		// Balls go here
		for (j=[0:nLockBalls-1]) rotate([0,0,360/nLockBalls*j]) hull(){
			translate([0,BallPerimeter_d/2-STB_LockBall_d(BallPerimeter_d=BallPerimeter_d)/2,0]) sphere(d=STB_LockBall_d(BallPerimeter_d=BallPerimeter_d)+IDXtra*3);
			translate([0,Body_OD/2-STB_LockBall_d(BallPerimeter_d=BallPerimeter_d)/2-1,0]) sphere(d=STB_LockBall_d(BallPerimeter_d=BallPerimeter_d)+IDXtra*3);
			translate([0,BallPerimeter_d/2-STB_LockBall_d(BallPerimeter_d=BallPerimeter_d)/2,0.3]) sphere(d=STB_LockBall_d(BallPerimeter_d=BallPerimeter_d)+IDXtra*3);
			translate([0,Body_OD/2-STB_LockBall_d(BallPerimeter_d=BallPerimeter_d)/2-1,0.3]) sphere(d=STB_LockBall_d(BallPerimeter_d=BallPerimeter_d)+IDXtra*3);
		}
		
		// Bolt holes
		translate([0,0,Top_H]) STB_BR_BoltPattern(BallPerimeter_d=BallPerimeter_d, Body_OD=Body_OD, nLockBalls=nLockBalls) 
			Bolt4HeadHole(depth=8, lHead=20);
		
		// Shock Cord
		translate([0,0,-Overlap]) hull() 
			STB_ShockCordHolePattern(BallPerimeter_d=BallPerimeter_d, Body_OD=Body_OD)
				cylinder(d=STB_SCord_T(BallPerimeter_d), h=Top_H+Overlap*2);
			
		// Arming slot
		//translate([Body_OD/2-12, 0, LockDiskHole_H/2-Overlap]) 
		//	RoundRect(X=2.2, Y=8, Z=Plate_T+Overlap*2, R=1);
		
		// Lock Disk goes here
		cylinder(d=LockDisk_d+1, h=LockDiskHole_H, center=true);
		
		// Lock disk axle goes here
		cylinder(d=BearingMR84_ID+IDXtra, h=20, center=true);
		
		// Locked stop
		STB_LockedStopPosition(BallPerimeter_d=BallPerimeter_d)
			cylinder(d=Dowel_d, h=Top_H*2+Overlap*2,center=true);
			
		// Unlocked Stop
		STB_UnlockedStopPosition(BallPerimeter_d=BallPerimeter_d, nLockBalls=nLockBalls)
			cylinder(d=Dowel_d, h=Top_H*2+Overlap*2, center=true);
		
		// Servo
		if (UsesBigServo){
			BigServoPosition() translate([0,0,7.4])  rotate([0,0,180])
				Servo_HX5010(BottomMount=true,TopAccess=false, Xtra_w=1, Xtra_h=0);
				
			if (HasSecondServo)
				BigServoPosition(SecondServo=true) translate([0,0,7.4])  rotate([0,0,180])
					Servo_HX5010(BottomMount=true,TopAccess=false, Xtra_w=1, Xtra_h=0);
		}else{
			ServoPosition() ServoSG90(TopMount=false,HasGear=false); 
			if (HasSecondServo)
				ServoPosition(SecondServo=true) ServoSG90(TopMount=false,HasGear=false); 
		}
		
		//notch for magnet latch
		rotate([0,0,STB_MagnetPost_a(BallPerimeter_d, nLockBalls)]) translate([Magnet_h/2,0,0])
			hull(){
				translate([0,STB_LockPinBC_d(BallPerimeter_d)/2-4,0])
					cylinder(d=Magnet_h+IDXtra*4, h=LockDisk_H+4, center=true);
				translate([0,STB_LockPinBC_d(BallPerimeter_d)/2+5,0])
					cylinder(d=Magnet_h+IDXtra*4, h=LockDisk_H+4, center=true);
			}
			
		//if ($preview) translate([0,0,-1]) cube([Body_OD/2+10,Body_OD/2+10,50]);
	} // difference
	
	// Shock cord hole
	difference(){
		hull() 
			STB_ShockCordHolePattern(BallPerimeter_d=BallPerimeter_d, Body_OD=Body_OD) 
				cylinder(d=STB_SCord_T(BallPerimeter_d)+2.4, h=Top_H);
		
		translate([0,0,-Overlap]) hull() 
			STB_ShockCordHolePattern(BallPerimeter_d=BallPerimeter_d, Body_OD=Body_OD) 
				cylinder(d=STB_SCord_T(BallPerimeter_d), h=Top_H+Overlap*2);
	} // difference

} // STB_BallRetainerTop

/*
STB_BallRetainerTop(BallPerimeter_d=BT98Body_OD, Body_OD=BT98Body_ID, nLockBalls=6,
HasIntegratedCouplerTube=true,
			IntegratedCouplerLenXtra=10,
			Body_ID=BT98Body_ID,
			HasSecondServo=false,
			UsesBigServo=true,
			Engagement_Len=20);
/**/		
//STB_LockDisk(BallPerimeter_d=BT98Body_ID, nLockBalls=6);

/*
STB_BallRetainerTop(BallPerimeter_d=67.2, Body_OD=65, nLockBalls=3, HasIntegratedCouplerTube=true, IntegratedCouplerLenXtra=-10, Body_ID=65, HasSecondServo=false, UsesBigServo=false, Engagement_Len=20);
//rotate([0,0,STB_Unlocked_a(BallPerimeter_d=67.2)])
{
STB_LockDisk(BallPerimeter_d=67.2, nLockBalls=3);
STB_ShowLockBearings(BallPerimeter_d=67.2, nLockBalls=3);
}
/**/
/*
STB_BallRetainerTop(BallPerimeter_d=PML75Body_OD, Body_OD=PML75Body_ID, nLockBalls=5, HasIntegratedCouplerTube=true, Body_ID=PML75Body_ID);

//rotate([0,0,STB_Unlocked_a(BallPerimeter_d=PML75Body_OD)])
{
STB_LockDisk(BallPerimeter_d=PML75Body_OD, nLockBalls=5);
STB_ShowLockBearings(BallPerimeter_d=PML75Body_OD, nLockBalls=5);
}
/**/
/*
STB_BallRetainerTop(BallPerimeter_d=PML98Body_OD, Body_OD=PML98Body_ID, nLockBalls=6, HasIntegratedCouplerTube=true, Body_ID=PML98Body_ID, HasSecondServo=true, UsesBigServo=true);
//*
//rotate([0,0,STB_Unlocked_a(BallPerimeter_d=PML98Body_OD)])
{
STB_LockDisk(BallPerimeter_d=PML98Body_OD, nLockBalls=6);
STB_ShowLockBearings(BallPerimeter_d=PML98Body_OD, nLockBalls=6);
}
/**/

//translate([0,0,4])
//STB_BallRetainerTop(BallPerimeter_d=BT137BallPerimeter_d, Body_OD=BT137Body_ID, nLockBalls=nBT137Balls, HasIntegratedCouplerTube=true, Body_ID=BT137Body_ID, HasSecondServo=true, UsesBigServo=true, Engagement_Len=25);

module STB_ManualDisArmingHole(BallPerimeter_d=BT54Body_ID, nLockBalls=nLockBalls){
	rotate([0,0,360/nLockBalls]) translate([0, STB_LockPinBC_d(BallPerimeter_d)/2, -LockDiskHole_H/2+2])
		rotate([0,90,0]) cylinder(d=ArmingHole_d, h=50);
} // STB_ManualDisArmingHole

// STB_ManualDisArmingHole();	
		
module STB_BallRetainerBottom(BallPerimeter_d=BT54Body_ID, Body_OD=PML54Coupler_ID, nLockBalls=nLockBalls, HasSpringGroove=true, Engagement_Len=20){

	Plate_T=Engagement_Len/2-LockDiskHole_H+4;
	SpringGroove_H=HasSpringGroove? 1.5:0;
	
	Bottom_H=LockDiskHole_H/2+Plate_T+SpringGroove_H;
	LockDisk_d=STB_LockPinBC_d(BallPerimeter_d)+BearingMR84_OD;
	
	echo(Bottom_H=Bottom_H);
	
	
		
	difference(){
		translate([0,0,-Bottom_H]) 
			cylinder(d=Body_OD-IDXtra*2, h=LockDiskHole_H/2+Plate_T+SpringGroove_H);
		
		STB_ManualDisArmingHole(BallPerimeter_d=BallPerimeter_d, nLockBalls=nLockBalls);
		
		// Balls go here
		for (j=[0:nLockBalls-1]) rotate([0,0,360/nLockBalls*j]) hull(){
			translate([0,BallPerimeter_d/2-STB_LockBall_d(BallPerimeter_d=BallPerimeter_d)/2,0]) sphere(d=STB_LockBall_d(BallPerimeter_d=BallPerimeter_d)+IDXtra*3);
			translate([0,Body_OD/2-STB_LockBall_d(BallPerimeter_d=BallPerimeter_d)/2-1,0]) sphere(d=STB_LockBall_d(BallPerimeter_d=BallPerimeter_d)+IDXtra*3);
		}
		
		// Bolt holes
		STB_BR_BoltPattern(BallPerimeter_d=BallPerimeter_d, Body_OD=Body_OD, nLockBalls=nLockBalls) Bolt4Hole();
		
		// Shock cord hole
		translate([0,0,-Bottom_H-Overlap]) 
			hull() STB_ShockCordHolePattern(BallPerimeter_d=BallPerimeter_d, Body_OD=Body_OD) 
				cylinder(d=STB_SCord_T(BallPerimeter_d), h=Bottom_H+Overlap*2);
			
		// Lock Disk goes here
		cylinder(d=LockDisk_d+1, h=LockDiskHole_H, center=true);
		
		// Lock disk axle goes here
		cylinder(d=BearingMR84_ID+IDXtra, h=LockDiskHole_H*2+Overlap*2, center=true);
		
		
		// Locked stop
		STB_LockedStopPosition(BallPerimeter_d=BallPerimeter_d)
				cylinder(d=Dowel_d, h=Bottom_H*2+Overlap*2,center=true);
		
			
		// Unlocked Stop
		STB_UnlockedStopPosition(BallPerimeter_d=BallPerimeter_d, nLockBalls=nLockBalls)
				cylinder(d=Dowel_d, h=Bottom_H*2+Overlap*2, center=true);
				
		// Spring Groove
		if (HasSpringGroove)
		translate([0,0,-LockDiskHole_H/2-Plate_T-1]) rotate_extrude() hull(){
			translate([ST_DSpring_OD/2-1,0,0]) circle(d=2);
			translate([ST_DSpring_OD/2-1,-1,0]) circle(d=2);
		}
	} // difference
	
	// Shock cord hole
	difference(){
		translate([0,0,-Bottom_H+SpringGroove_H]) 
			hull() STB_ShockCordHolePattern(BallPerimeter_d=BallPerimeter_d, Body_OD=Body_OD) 
				cylinder(d=STB_SCord_T(BallPerimeter_d)+2.4, h=Bottom_H-SpringGroove_H);
		translate([0,0,-Bottom_H-Overlap]) 
			hull() STB_ShockCordHolePattern(BallPerimeter_d=BallPerimeter_d, Body_OD=Body_OD) 
				cylinder(d=STB_SCord_T(BallPerimeter_d), h=Bottom_H+Overlap*2);
	} // difference
	
	// Magnetic latch
	difference(){
		rotate([0,0,STB_MagnetPost_a(BallPerimeter_d, nLockBalls)]) translate([Magnet_h/2,0,0])
			hull(){
				translate([0,STB_LockPinBC_d(BallPerimeter_d)/2-4,0])
					cylinder(d=Magnet_h, h=LockDisk_H+2, center=true);
				translate([0,STB_LockPinBC_d(BallPerimeter_d)/2+5,0])
					cylinder(d=Magnet_h, h=LockDisk_H+2, center=true);
			}
			
		// Magnet
		rotate([0,0,STB_MagnetPost_a(BallPerimeter_d, nLockBalls)]) translate([Magnet_h/2,STB_LockPinBC_d(BallPerimeter_d)/2,0])
			rotate([0,90,0]) cylinder(d=Magnet_d, h=Magnet_h+Overlap*2, center=true);
	} // difference
} // STB_BallRetainerBottom

/*
STB_BallRetainerBottom(BallPerimeter_d=BT54Body_ID, Body_OD=PML54Coupler_ID, nLockBalls=nLockBalls, HasSpringGroove=true, Engagement_Len=20);
rotate([0,0,STB_Unlocked_a(BallPerimeter_d=PML54Body_ID)])
{
STB_LockDisk(BallPerimeter_d=PML54Body_ID, nLockBalls=3);
STB_ShowLockBearings(BallPerimeter_d=PML54Body_ID, nLockBalls=nLockBalls);}
/**/
/*
STB_BallRetainerBottom(BallPerimeter_d=PML75Body_OD, Body_OD=PML75Body_ID, nLockBalls=5, HasSpringGroove=false, Engagement_Len=20);

//rotate([0,0,STB_Unlocked_a(BallPerimeter_d=PML75Body_OD)])
{
STB_LockDisk(BallPerimeter_d=PML75Body_OD, nLockBalls=5);
STB_ShowLockBearings(BallPerimeter_d=PML75Body_OD, nLockBalls=5);
}
/**/

/*
STB_BallRetainerBottom(BallPerimeter_d=BT137BallPerimeter_d, Body_OD=BT137Body_ID, nLockBalls=7, HasSpringGroove=false, Engagement_Len=25);

//rotate([0,0,STB_Unlocked_a(BallPerimeter_d=BT137BallPerimeter_d)])
{
STB_LockDisk(BallPerimeter_d=BT137BallPerimeter_d, nLockBalls=7);
STB_ShowLockBearings(BallPerimeter_d=BT137BallPerimeter_d, nLockBalls=7);
}
/**/

//STB_BallRetainerBottom(BallPerimeter_d=BT137BallPerimeter_d, Body_OD=BT137Body_ID, nLockBalls=nBT137Balls, HasSpringGroove=false, Engagement_Len=25);





























