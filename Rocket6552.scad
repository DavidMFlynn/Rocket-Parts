// ***********************************
// Project: 3D Printed Rocket
// Filename: Rocket65.scad
// by David M. Flynn
// Created: 9/5/2024
// Revision: 0.9.0  9/5/2024
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  A Two Stage Rocket with 65mm Body 38mm motors. 
//  Single deploy:
//   Mission Control V3 / RocketServo
//
//  ***** Parts *****
//
// BLue Tube 2.65" Body Tube by 18 inches
// Blue Tube 1.5" Body Tube by 12 inches
// 36" Parachute
// 1/8" Paracord (3 feet)
// 1/2" Braided Nylon Shock Cord (20 feet)
//
//  ***** Hardware *****
//
// #6-32 x 3/4" Button Head Cap Screw (2 req) Rail Buttons
// #4-40 x 1/2" Socket Head Cap Screw (3 req) Ball Lock
// #4-40 x 3/8" Button Head Cap Screw (6 req) Doors
// #4-40 x 3/8" Socket Head Cap Screw (3 req) PetalHub
// #4-40 x 1/4" Button Head Cap Screw (4 req) Altimeter
// #2-56 x 1/4" Socket Head Cap Screw (2 req) Servo
// MR84-2RS Bearing (5 req) Ball Lock
// 3/8" Delrin Ball (3 req) Ball Lock
// 4mm Dia. x 10mm Undersize Steel Dowel (3 req) Ball Lock
// 4mm Dia. x 16mm Undersize Steel Dowel (3 req) Ball Lock
// 3/16" Dia x 1/8" Disc Magnet N42 (2 req) Ball Lock
// SG90 or MG90S Micro Servo (1 req) Ball Lock
// C&K Rotary Switch (1 req) Battery Door
// Mission Control V3 Altimeter PCBA
// Rocket Servo PCBA
// 1/4" Rail Button (2 req)
// CS4323 Spring
// 5/16" Dia x 1-1/4" Spring (3 req) PetalHub
//
//  ***** History *****
//
// 0.9.0  9/5/2024	 Copied from Rocket65.scad
// 1.0.11 10/22/2023 Now uses PetalDeploymentLib.scad
// 1.0.10 9/10/2023  Increased Alt_DoorXtra_X fron 2 to 6
// 1.0.9  8/8/2023   Improved fin can
// 1.0.8  7/21/2023  Updated PetalHub()
// 1.0.7  7/10/2023  Set aft closure to 10mm for 29mm, working on a more robust petal.
// 1.0.6  6/30/2023  Fixed motor tube hole diameter
// 1.0.5  6/29/2023  Round shock cord in SpringEndTop(), added mount for petals to BallRetainerBottom
// 1.0.4  6/27/2023  Added hardware list and SpringSpacer()
// 1.0.3  6/22/2023  Adjusted size of ebay parts. Fixed batt door now has switch.
// 1.0.2  6/21/2023  38mm motor tube
// 1.0.1  6/19/2023  Nose cone.
// 1.0.0  10/4/2022  First code. Copy of Rocket 98.
//
// ***********************************
//  ***** for STL output *****
//
// *** Nosecode ***
//
// BluntOgiveNoseCone(ID=Body_ID, OD=Body_OD, L=NC_Len, Base_L=NC_Base_L, Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=0, LowerPortion=false);
// NC_ShockcordRing75(Body_OD=Body_OD, Body_ID=Body_ID, NC_Base_L=NC_Base_L);
//
// *** Electronics Bay ***
//
// Electronics_Bay(Tube_OD=Body_OD, Tube_ID=Body_ID);
// rotate([-90,0,0]) EB_AltDoor(Tube_OD=Body_OD);
// 
// rotate([-90,0,0]) EB_BattDoor(Tube_OD=Body_OD, HasSwitch=true, DoubleBatt=false);
//
// *** Ball Lock ***
//
// STB_LockDisk(BallPerimeter_d=Body_OD, nLockBalls=nLockBalls);
// rotate([180,0,0]) STB_BallRetainerTop(BallPerimeter_d=Body_OD, Body_OD=Body_ID, nLockBalls=nLockBalls, HasIntegratedCouplerTube=true, Body_ID=Body_ID-IDXtra, HasSecondServo=false, UsesBigServo=false);
// R65_BallRetainerBottom();
// rotate([180,0,0]) STB_TubeEnd2(BallPerimeter_d=Body_OD, nLockBalls=nLockBalls, Body_OD=Body_OD, Body_ID=Body_ID, Engagement_Len=20);
//
// *** optional petal deployer ***
//
// PD_PetalHub(OD=Coupler_OD, nPetals=3, ShockCord_a=PD_ShockCordAngle());
// rotate([-90,0,0]) PD_PetalSpringHolder();
// rotate([180,0,0]) PD_Petals(Coupler_OD=Coupler_OD, Len=110, nPetals=3);
//
// SpringEndTop(OD=Coupler_OD, Tube_ID=Coupler_OD-2.4, nRopeHoles=3);
// SpringEndBottom(OD=Coupler_OD, Tube_ID=Coupler_OD-2.4, nRopeHoles=3);
// SpringSpacer(OD=Coupler_OD, Tube_ID=Coupler_OD-2.4, Len=40);
//
// UpperRailBtnMount();
//
// *** Fin Can ***
//
// rotate([180,0,0]) FinCan(LowerHalfOnly=false, UpperHalfOnly=false);
// RocketFin();
// rotate([180,0,0]) FinCan(LowerHalfOnly=true, UpperHalfOnly=false);
// MotorRetainer();
//
//  ***** Booster *****
//
// rotate([180,0,0]) Sustainer_Cup();
// rotate([-90,0,0]) Stager_LockRod(Adj=0.5); // Looser
// rotate([-90,0,0]) Stager_LockRod(Adj=0.0); 
// rotate([-90,0,0]) Stager_LockRod(Adj=-1.4);
//
// Stager_Saucer(Tube_OD=Body_OD, nLocks=nLocks);
//
// Stager_LockRing(Tube_OD=Body_OD, nLocks=nLocks); 
//
// Stager_Mech(Tube_OD=Body_OD, nLocks=nLocks, Skirt_ID=Body_ID, Skirt_Len=Stager_SkirtLen, nSkirtBolts=4, ShowLocked=true);
// Stager_OuterBearingCover(Tube_OD=Body_OD, nLocks=nLocks); // Secures Outer Race of Main Bearing
// rotate([180,0,0]) Stager_Indexer(Tube_OD=Body_OD, nLocks=nLocks); // Secures Inner Race of Main Bearing and has Lock Stops
// Stager_ServoPlate(Tube_OD=Body_OD, Skirt_ID=Body_ID, nLocks=nLocks, OverCenter=IDXtra+0.8, HasAlTube=false);
// rotate([180,0,0]) Stager_ServoMount();
//
// EB_ExtensionRing(Tube_OD=Body_OD, Tube_ID=Body_ID, Len=8, nBolts=4, BoltInset=7.5);
// BoosterEBay();
//  *** Doors ***
// rotate([-90,0,0]) EB_AltDoor(Tube_OD=BT98Body_OD);
// rotate([-90,0,0]) EB_BattDoor(Tube_OD=BT98Body_OD, HasSwitch=true, DoubleBatt=false);
//
// *** Ball Lock ***
// STB_LockDisk(BallPerimeter_d=Body_OD, nLockBalls=nLockBalls);
// rotate([180,0,0]) STB_BallRetainerTop(BallPerimeter_d=Body_OD, Body_OD=Body_ID, nLockBalls=nLockBalls, HasIntegratedCouplerTube=true, nBolts=4, Body_ID=Body_ID-IDXtra, HasSecondServo=false, UsesBigServo=false);
// R65_BallRetainerBottom();
// rotate([180,0,0]) STB_TubeEnd2(BallPerimeter_d=Body_OD, nLockBalls=nLockBalls, Body_OD=Body_OD, Body_ID=Body_ID, Engagement_Len=20);
//
//  *** Petal Deployment ***
// PD_PetalHub(OD=Coupler_OD, nPetals=3, ShockCord_a=PD_ShockCordAngle());
// rotate([-90,0,0]) PD_PetalSpringHolder();
// rotate([180,0,0]) PD_Petals(OD=Coupler_OD, Len=BoosterPetal_Len, nPetals=3);
//
// SE_SpringEndTop(OD=Coupler_OD, Tube_ID=Coupler_OD-2.4, nRopeHoles=3, CutOutCenter=true);
// SE_SlidingSpringMiddle(OD=Coupler_OD, nRopes=3, SliderLen=30, SpLen=30, SpringStop_Z=15, UseSmallSpring=true);
// SE_SpringEndBottom(OD=Coupler_OD, Tube_ID=Coupler_OD-2.4, Len=20, nRopeHoles=3, CutOutCenter=true);
//
// CenteringRing(OD=Body_ID, ID=MotorTube_OD+IDXtra*2, Thickness=10, nHoles=5, Offset=0, myfn=$preview? 90:360);
//
// BoosterFin();
// BoosterFinCan(LowerHalfOnly=false, UpperHalfOnly=false);
// BoosterMotorRetainer();
//
// ***********************************
//  ***** Routines *****
//
//
// ***********************************
//  ***** for Viewing *****
//
// ShowBooster(ShowInternals=false);
// ShowBooster(ShowInternals=true);
//
// ShowRocket(ShowInternals=false);
// ShowRocket(ShowInternals=true);
//
// ShowBooster(ShowInternals=false); translate([0,0,Booster_Len]) ShowRocket(ShowInternals=false);
//
// ***********************************
include<TubesLib.scad>
use<RailGuide.scad>				echo(RailGuideRev());
use<Fins.scad>					echo(FinsRev());
use<FinCan2Lib.scad> 			echo(FinCan2LibRev());
use<NoseCone.scad>				echo(NoseConeRev());
use<SpringThingBooster.scad>	echo(SpringThingBoosterRev());
use<PetalDeploymentLib.scad>	echo(PetalDeploymentLibRev());
use<SpringEndsLib.scad>			echo(SpringEndsLibRev());
include<Stager75BBLib.scad>
use<ElectronicsBayLib.scad>		echo(ElectronicsBayLibRev());
use<AT-RMS-Lib.scad>

//also included
 //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

nLockBalls=3;

// constants for 65mm stager
Default_nLocks=2;
DefaultBody_OD=BT65Body_OD;
DefaultBody_ID=BT65Body_ID;
MainBearing_OD=Bearing6805_OD;
MainBearing_ID=Bearing6805_ID;
MainBearing_T=Bearing6805_T;
nLocks=2;
StagerCollarLen=17;
Stager_SkirtLen=16;


nFins=5;
Fin_Post_h=10;
Fin_Root_L=160;
Fin_Root_W=6;
Fin_Tip_W=3.0;
Fin_Tip_L=70;
Fin_Span=70;
Fin_TipOffset=20;
Fin_Chamfer_L=18;

Fin_Inset=5;
FinCan_Len=Fin_Root_L+Fin_Inset*2;

// Booster Fin
BoosterFinScale=1.4;
BoosterFin_Post_h=10;
BoosterFin_Root_L=160*BoosterFinScale;
BoosterFin_Root_W=6*BoosterFinScale;
BoosterFin_Tip_W=3.0*BoosterFinScale;
BoosterFin_Tip_L=70*BoosterFinScale;
BoosterFin_Span=70*BoosterFinScale;
BoosterFin_TipOffset=20*BoosterFinScale;
BoosterFin_Chamfer_L=18*BoosterFinScale;

BoosterFin_Inset=5*BoosterFinScale;
BoosterFinCan_Len=BoosterFin_Root_L+BoosterFin_Inset*2;

BoosterTailCone_Len=35;

BoosterEBay_Len=162;
BoosterPetal_Len=110;
BoosterBodyTube_Len=BoosterPetal_Len+160;
BoosterMotorTube_Len=BoosterFinCan_Len+BoosterTailCone_Len-12+60;
Booster_Len=BoosterTailCone_Len+BoosterFinCan_Len+BoosterEBay_Len+BoosterBodyTube_Len+33+23+32.7+Stager_SkirtLen+6;
echo(BoosterMotorTube_Len=BoosterMotorTube_Len);
echo(BoosterBodyTube_Len=BoosterBodyTube_Len);
echo(Booster_Len=Booster_Len);

Body_OD=BT65Body_OD;
Body_ID=BT65Body_ID;
Coupler_OD=BT65Coupler_OD;
Coupler_ID=BT65Coupler_ID;

// *** 38mm Motor Tube ***
MotorTube_OD=BT38Body_OD;
MotorTube_ID=BT38Body_ID;

MotorTubeHole_d=MotorTube_OD+IDXtra*3;

EBay_Len=162;
LowerEBay_Len=162;

NC_Len=180;
NC_Tip_r=5;
NC_Base=5;
NC_Wall_t=1.8;
NC_Base_L=13;

LowerBodyTube_Len=140;
BodyTubeLen=200; // Middle tube, Drogue bay

Bolt4Inset=4;
ShockCord_a=33; // offset between PD_PetalHub and R65_BallRetainerBottom


RailGuide_Len=30;

module ShowBooster(ShowInternals=false){
	FinCan_Z=BoosterTailCone_Len;
	Fin_Z=FinCan_Z+BoosterFin_Inset+BoosterFin_Root_L/2;
	BodyTube_Z=FinCan_Z+BoosterFinCan_Len+Overlap;
	STB_Z=BodyTube_Z+BoosterBodyTube_Len+10;
	EBay_Z=STB_Z+23+0.2;
	Ex_Ring_Z=EBay_Z+BoosterEBay_Len+0.2;
	Stager_Z=Ex_Ring_Z+23.2+32.7;
	
	translate([0,0,Stager_Z+Stager_SkirtLen]) rotate([0,0,45]){
		color("Gray") Stager_Saucer(Tube_OD=Body_OD, nLocks=nLocks);
		color("LightGreen") Stager_Mech(Tube_OD=Body_OD, nLocks=nLocks, Skirt_ID=Body_ID, Skirt_Len=Stager_SkirtLen, nSkirtBolts=4, ShowLocked=true);
	}
	
	translate([0,0,Ex_Ring_Z]) color("Orange") EB_ExtensionRing(Tube_OD=Body_OD, Tube_ID=Body_ID, Len=8, nBolts=4, BoltInset=7.5);
	
	translate([0,0,EBay_Z]) BoosterEBay(ShowDoors=(ShowInternals==false));
	
	translate([0,0,STB_Z]){
		if (ShowInternals==false) color("Gray") 
			STB_TubeEnd2(BallPerimeter_d=Body_OD, nLockBalls=nLockBalls, Body_OD=Body_OD, Body_ID=Body_ID, Engagement_Len=20);
			
		color("Tan") STB_BallRetainerTop(BallPerimeter_d=Body_OD, Body_OD=Body_ID, nLockBalls=nLockBalls, 
						HasIntegratedCouplerTube=true, nBolts=4, Body_ID=Body_ID-IDXtra, HasSecondServo=false, UsesBigServo=false);
						
		if (ShowInternals){
			R65_BallRetainerBottom();
			translate([0,0,-10.2]) rotate([180,0,0]) PD_PetalHub(OD=Coupler_OD, nPetals=3, ShockCord_a=PD_ShockCordAngle());
			translate([0,0,-10.2-9]) rotate([180,0,0]) PD_Petals(OD=Coupler_OD, Len=BoosterPetal_Len, nPetals=3);
			translate([0,0,-10.2-9-BoosterPetal_Len-40]) 
				SE_SpringEndTop(OD=Coupler_OD, Tube_ID=Coupler_OD-2.4, nRopeHoles=3, CutOutCenter=true);
			translate([0,0,-10.2-9-BoosterPetal_Len-40-35]) 	
				SE_SlidingSpringMiddle(OD=Coupler_OD, nRopes=3, SliderLen=30, SpLen=30, SpringStop_Z=15, UseSmallSpring=true);
			translate([0,0,-10.2-9-BoosterPetal_Len-40-35-25]) 	
				SE_SpringEndBottom(OD=Coupler_OD, Tube_ID=Coupler_OD-2.4, Len=20, nRopeHoles=3, CutOutCenter=true);
		}
		
	}
	
	if (ShowInternals) translate([0,0,BodyTube_Z+40])
		CenteringRing(OD=Body_ID, ID=MotorTube_OD+IDXtra*2, Thickness=10, nHoles=5, Offset=0, myfn=$preview? 90:360);
	
	if (ShowInternals) translate([0,0,FinCan_Z-BoosterTailCone_Len+12])
		Tube(OD=MotorTube_OD, ID=MotorTube_ID, Len=BoosterMotorTube_Len, myfn=90);
	
	if (ShowInternals==false) translate([0,0,BodyTube_Z]) color("LightBlue") 
		Tube(OD=Body_OD, ID=Body_ID, Len=BoosterBodyTube_Len-Overlap*2, myfn=90);
			
	translate([0,0,FinCan_Z]) {
		color("White") BoosterFinCan(LowerHalfOnly=false, UpperHalfOnly=false);
		BoosterMotorRetainer();
		// I357T
		//if (ShowInternals) translate([0,0,-BoosterTailCone_Len+12]) ATRMS_38_360_Motor(HasEyeBolt=true);
		// I435T
		if (ShowInternals) translate([0,0,-BoosterTailCone_Len+12]) ATRMS_38_600_Motor(HasEyeBolt=true);
	}
	
	//*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j+180/nFins])
		translate([0, Body_OD/2-Fin_Post_h, Fin_Z]) 
			rotate([-90,0,0]) color("Yellow") BoosterFin();
	/**/

	
} // ShowBooster

//ShowBooster(ShowInternals=true);

module ShowRocket(ShowInternals=false){
	FinCan_Z=15;
	Fin_Z=FinCan_Z+Fin_Root_L/2+Fin_Inset;
	LowerBodyTube_Z= FinCan_Z+FinCan_Len;
	LowerEBay_Z=LowerBodyTube_Z+LowerBodyTube_Len;
	BodyTube_Z=LowerEBay_Z+LowerEBay_Len+Overlap*2;
	EBay_Z=BodyTube_Z+BodyTubeLen+33.5;
	NoseCone_Z=EBay_Z+EBay_Len-13+Overlap*2;
	
	translate([0,0,NoseCone_Z])
		BluntOgiveNoseCone(ID=Coupler_OD, OD=Body_OD, L=NC_Len, Base_L=13, 
							Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=0, LowerPortion=false);
	
	translate([0,0,EBay_Z]) Electronics_Bay(ShowDoors=(ShowInternals==false));
	
	translate([0,0,BodyTube_Z+BodyTubeLen+10+Overlap*2])
	STB_BallRetainerTop(BallPerimeter_d=Body_OD, Body_OD=Body_ID, nLockBalls=nLockBalls, HasIntegratedCouplerTube=true, Body_ID=Body_ID, HasSecondServo=false, UsesBigServo=false);
	
	translate([0,0,BodyTube_Z+BodyTubeLen+10])
		STB_TubeEnd2(BallPerimeter_d=Body_OD, nLockBalls=nLockBalls, Body_OD=Body_OD, Body_ID=Body_ID, Engagement_Len=20);
	
	//translate([0,0,BodyTube_Z]) color("LightBlue") Tube(OD=Body_OD, ID=Body_ID, 
	//		Len=BodyTubeLen-Overlap*2, myfn=$preview? 90:360);
	
	translate([0,0,LowerEBay_Z]) LowerEBay(ShowDoors=(ShowInternals==false));
	
	translate([0,0,FinCan_Z]) color("White") FinCan(LowerHalfOnly=false, UpperHalfOnly=false);
	
	// I161W
	//if (ShowInternals) translate([0,0,FinCan_Z]) ATRMS_38_360_Motor(HasEyeBolt=true);
	// I284W
	if (ShowInternals) translate([0,0,FinCan_Z]) ATRMS_38_600_Motor(HasEyeBolt=true);
	
	//*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j+180/nFins])
		translate([0, Body_OD/2-Fin_Post_h, Fin_Z]) 
			rotate([-90,0,0]) color("Yellow") RocketFin();
	/**/
	
	translate([0,0,FinCan_Z-StagerCollarLen-3-0.2]) Sustainer_Cup();
} // ShowRocket

//translate([0,0,Booster_Len]) ShowRocket(ShowInternals=true);

module R65_BallRetainerBottom(){
	difference(){
		STB_BallRetainerBottom(BallPerimeter_d=Body_OD, Body_OD=Body_ID, nLockBalls=nLockBalls, HasSpringGroove=false);
		
		rotate([0,0,PD_ShockCordAngle()-ShockCord_a]) 
			PD_PetalHubBoltPattern(OD=Coupler_OD) Bolt4Hole();
	} // difference
} // R65_BallRetainerBottom

// translate([0,0,-8]) rotate([180,0,192]) R65_BallRetainerBottom();

module Electronics_Bay(ShowDoors=false){
	// Upper dual deploy EBay
	
	SimpleTwoBattSWBay=[[0],[],[120,240]];
	EB_Electronics_BayUniversal(Tube_OD=Body_OD, Tube_ID=Body_ID, DoorAngles=SimpleTwoBattSWBay, Len=EBay_Len, 
									nBolts=4, BoltInset=7.5, ShowDoors=ShowDoors,
									HasFwdIntegratedCoupler=false, HasFwdShockMount=false,
									HasAftIntegratedCoupler=false, HasAftShockMount=false,
									HasRailGuide=false, RailGuideLen=RailGuide_Len,
									Bolted=false, ExtraBolts=[], TopOnly=false, BottomOnly=false);
} // Electronics_Bay

// Electronics_Bay();

module LowerEBay(ShowDoors=false, TopOnly=false, BottomOnly=false){
	LowerEBayDoors=[[90],[270],[]];
	EB_Electronics_BayUniversal(Tube_OD=Body_OD, Tube_ID=Body_ID, DoorAngles=LowerEBayDoors, Len=EBay_Len, 
									nBolts=0, BoltInset=7.5, ShowDoors=ShowDoors,
									HasFwdIntegratedCoupler=true, HasFwdShockMount=false,
									HasAftIntegratedCoupler=true, HasAftShockMount=false,
									HasRailGuide=true, RailGuideLen=RailGuide_Len,
									Bolted=true, ExtraBolts=[90], TopOnly=false, BottomOnly=false);
} // LowerEBay

// LowerEBay();

module FinCan(LowerHalfOnly=false, UpperHalfOnly=false){
	
	FC2_FinCan(Body_OD=Body_OD, Body_ID=Body_ID, Can_Len=FinCan_Len,
				MotorTube_OD=MotorTube_OD, RailGuide_h=Body_OD/2+2,
				nFins=nFins, HasIntegratedCoupler=true, HasMotorSleeve=true, HasAftIntegratedCoupler=false,
				Fin_Root_W=Fin_Root_W, Fin_Root_L=Fin_Root_L, Fin_Post_h=Fin_Post_h, Fin_Chamfer_L=Fin_Chamfer_L,
				Cone_Len=0, ThreadedTC=false, Extra_OD=2, RailGuideLen=RailGuide_Len,
				LowerHalfOnly=LowerHalfOnly, UpperHalfOnly=UpperHalfOnly, HasWireHoles=false, HollowTailcone=false, 
				HollowFinRoots=false, Wall_t=1.2);
				
} // FinCan

//FinCan(LowerHalfOnly=false, UpperHalfOnly=false);


module RocketFin(){
	
	TrapFin2(Post_h=Fin_Post_h, Root_L=Fin_Root_L, Tip_L=Fin_Tip_L, Root_W=Fin_Root_W,
				Tip_W=Fin_Tip_W, Span=Fin_Span, Chamfer_L=Fin_Chamfer_L,
				TipOffset=Fin_TipOffset,
				Bisect=false, Bisect_X=0,
				HasSpar=false, Spar_d=8, Spar_L=100);
				
	
} // RocketFin

//RocketFin();

// ***********************************************************************************************************
//  ***** BOOSTER *****
// ***********************************************************************************************************

module Sustainer_Cup(){
	
	module Wires(){
		rotate([0,0,360/nFins]) translate([0,MotorTube_OD/2+5,-2]) scale([1.75,1,1]) cylinder(d=4, h=StagerCollarLen+3+2+Overlap);
	}
	
	difference(){
		Stager_Cup(Tube_OD=Body_OD, nLocks=nLocks, BoltsOn=true, Collar_h=StagerCollarLen);
		// wire path
		Wires();
	} // difference
	
	difference(){
		translate([0,0,StagerCollarLen+3-13])
		union(){
			
			translate([0,0,0]) Tube(OD=Body_ID-17, ID=MotorTube_OD+1, Len=13, myfn=$preview? 90:360);
			translate([0,0,0]) Tube(OD=Body_ID-17, ID=MotorTube_ID, Len=3, myfn=$preview? 90:360);
		} // union
		
		// wire path
		Wires();
		
		Stager_LockRod_Holes(Tube_OD=Body_OD, nLocks=nLocks);
		translate([0,0,StagerCollarLen+3-8]) Stager_CupBoltHoles() Bolt4HeadHole(depth=8,lHead=StagerCollarLen);
		
		translate([0,Body_OD/2-10,-16.5]) Stager_LockRodBoltPattern() Bolt6ButtonHeadHole();
		rotate([0,0,180]) translate([0,Body_OD/2-10,-16.5]) Stager_LockRodBoltPattern() Bolt6ButtonHeadHole();
	} // difference
	
} // Sustainer_Cup

// Sustainer_Cup();

module BoosterEBay(ShowDoors=false){
	//SimpleTwoBattSWBay=[[0],[],[115,245]]; // no room for 2 rocket servo PCBAs
	
	BoosterEBayDoors=[[90],[],[270]];
	EB_Electronics_BayUniversal(Tube_OD=Body_OD, Tube_ID=Body_ID, DoorAngles=BoosterEBayDoors, Len=BoosterEBay_Len, 
									nBolts=4, BoltInset=7.5, ShowDoors=ShowDoors,
									HasFwdIntegratedCoupler=false, HasFwdShockMount=false,
									HasAftIntegratedCoupler=false, HasAftShockMount=false,
									HasRailGuide=false, RailGuideLen=RailGuide_Len,
									Bolted=false, ExtraBolts=[], TopOnly=false, BottomOnly=false);
} // BoosterEBay

// BoosterEBay(ShowDoors=true);

module BoosterFin(){
	TrapFin2(Post_h=BoosterFin_Post_h, Root_L=BoosterFin_Root_L, Tip_L=BoosterFin_Tip_L, Root_W=BoosterFin_Root_W,
				Tip_W=BoosterFin_Tip_W, Span=BoosterFin_Span, Chamfer_L=BoosterFin_Chamfer_L,
				TipOffset=BoosterFin_TipOffset, TipInset=0, HasBluntTip=false, TipPost_h=0,
				Bisect=false, Bisect_X=0,
				HasSpar=false, Spar_d=8, Spar_L=100, PrinterBrim_H=0.9);
} // BoosterFin

// BoosterFin();

module BoosterFinCan(LowerHalfOnly=false, UpperHalfOnly=false){
	FC2_FinCan(Body_OD=Body_OD, Body_ID=Body_ID, Can_Len=BoosterFinCan_Len,
				MotorTube_OD=MotorTube_OD, RailGuide_h=Body_OD/2+2,
				nFins=nFins, HasIntegratedCoupler=true, HasMotorSleeve=true, HasAftIntegratedCoupler=false,
				Fin_Root_W=BoosterFin_Root_W, Fin_Root_L=BoosterFin_Root_L, Fin_Post_h=BoosterFin_Post_h, Fin_Chamfer_L=BoosterFin_Chamfer_L,
				Cone_Len=BoosterTailCone_Len, ThreadedTC=true, Extra_OD=2, RailGuideLen=RailGuide_Len,
				LowerHalfOnly=LowerHalfOnly, UpperHalfOnly=UpperHalfOnly, HasWireHoles=false, HollowTailcone=false, 
				HollowFinRoots=false, Wall_t=1.2);
} // BoosterFinCan

// BoosterFinCan();

module BoosterMotorRetainer(){
	FC2_MotorRetainer(Body_OD=Body_OD,
						MotorTube_OD=MotorTube_OD, MotorTube_ID=MotorTube_ID,
						HasWrenchCuts=false, Cone_Len=BoosterTailCone_Len, ExtraLen=0, Extra_OD=2);
} // BoosterMotorRetainer

// BoosterMotorRetainer();

































