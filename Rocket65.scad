// ***********************************
// Project: 3D Printed Rocket
// Filename: Rocket65.scad
// by David M. Flynn
// Created: 6/16/2023 
// Revision: 1.1.0  1/17/2025
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  Rocket with 65mm Body and 38mm motor. 
//  "Too Blue"
//  "Little Orange One"
//  "Mr. Green"
//  "Miss Scarlett"
//  "Prof. Plumb"
//  "Ghost"
//  Single deploy:
//   Mission Control V3 / RocketServo
//
//  ***** Parts *****
//
// LOC 2.65" Body Tube by 18 inches
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
// 1.1.0  1/17/2025  Updated to current libs, removed 29mm
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
// BluntOgiveNoseCone(ID=Coupler_OD, OD=Body_OD, L=NC_Len, Base_L=13, Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_d=0, LowerPortion=false, FillTip=true);
// NC_ShockcordRing75(Body_OD=Body_OD, Body_ID=Body_ID, NC_Base_L=13);
//
// *** Electronics Bay ***
//
// rotate([180,0,0]) Electronics_Bay(Tube_OD=Body_OD, Tube_ID=Body_ID, TopOnly=true, BottomOnly=false);
// Electronics_Bay(Tube_OD=Body_OD, Tube_ID=Body_ID, TopOnly=false, BottomOnly=true);
//
// rotate([-90,0,0]) EB_AltDoor(Tube_OD=Body_OD);
// rotate([-90,0,0]) EB_BattDoor(Tube_OD=Body_OD, HasSwitch=true, DoubleBatt=false);
//
// *** Ball Lock ***
//
// STB_LockDisk(Body_ID=Body_ID, nLockBalls=nLockBalls, HasLargeInnerBearing=false, Xtra_r=0.2);
// rotate([180,0,0]) STB_BallRetainerTop(Outer_OD=Body_OD, Body_OD=Body_ID, nLockBalls=nLockBalls, HasIntegratedCouplerTube=true, nBolts=3, Body_ID=Body_ID, HasSecondServo=false, UsesBigServo=false, Engagement_Len=20, HasLargeInnerBearing=false, Xtra_r=0.2);
// R65_BallRetainerBottom();
// rotate([180,0,0]) STB_TubeEnd(Body_ID=Body_ID, nLockBalls=nLockBalls, Body_OD=Body_OD, Engagement_Len=20);
//
// *** petal deployer ***
//
// rotate([0,0,193]) translate([0,0,-10]) rotate([180,0,0]) // test view
// PD_PetalHub(OD=Coupler_OD-IDXtra, nPetals=3, ShockCord_a=PD_ShockCordAngle());
// rotate([-90,0,0]) PD_PetalSpringHolder2();
// PD_Petals2(OD=Coupler_OD, Len=110, nPetals=3, Wall_t=2.2, AntiClimber_h=4, HasLocks=false, Lock_Span_a=0);
//
// SE_SpringTop(OD=Coupler_OD, Piston_Len=50, nRopes=3);
// SE_SpringEndBottom(OD=Coupler_OD, Tube_ID=Coupler_OD-2.4, Len=30, nRopeHoles=3, CutOutCenter=true);
//
// SpringSpacer(OD=Coupler_OD, Tube_ID=Coupler_OD-2.4, Len=30);
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
// RailButton(); // (4 req) print many
//
// ***********************************
//  ***** Routines *****
//
//
// ***********************************
//  ***** for Viewing *****
//
// ShowRocket();
//
// ***********************************
include<TubesLib.scad>
use<RailGuide.scad>
use<FinCan2Lib.scad>
use<Fins.scad>
use<NoseCone.scad>
use<ElectronicsBayLib.scad>
use<SpringThingBooster.scad>
use<SpringEndsLib.scad>
use<PetalDeploymentLib.scad>
use<ThreadLib.scad>

//also included
 //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

nFins=5;
Fin_Post_h=10;
Fin_Root_L=160;
Fin_Root_W=6;
Fin_Tip_W=3.0;
Fin_Tip_L=70;
Fin_Span=70;
Fin_TipOffset=20;
Fin_Chamfer_L=18;
FinInset_Len=5;

//Body_OD=LOC65Body_OD;
Body_OD=Estes65Body_OD;
Body_ID=LOC65Body_ID;
Coupler_OD=LOC65Coupler_OD;
Coupler_ID=LOC65Coupler_ID;

// *** 38mm Motor Tube ***
MotorTube_OD=BT38Body_OD;
MotorTube_ID=BT38Body_ID;

MotorTubeHole_d=MotorTube_OD+IDXtra*3;
nLockBalls=3;
EBay_Len=162;

NC_Len=180;
NC_Tip_r=5;
NC_Base=5;
NC_Lock_H=5;
NC_Wall_t=1.8;

BodyTubeLen=18*25.4;


Can_Len=Fin_Root_L+FinInset_Len*2;
TailCone_Len=35;

Bolt4Inset=4;
ShockCord_a=32; // offset between PD_PetalHub and R65_BallRetainerBottom


module ShowRocket(){
	FinCan_Z=35;
	Fin_Z=FinCan_Z+Fin_Root_L/2+FinInset_Len;
	BodyTube_Z=FinCan_Z+Can_Len+Overlap*2;
	EBay_Z=BodyTube_Z+BodyTubeLen+33.5;
	NoseCone_Z=EBay_Z+EBay_Len-13+Overlap*2;
	
	translate([0,0,NoseCone_Z])
		BluntOgiveNoseCone(ID=Coupler_OD, OD=Body_OD, L=NC_Len, Base_L=13, 
							Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=0, LowerPortion=false);
	
	translate([0,0,EBay_Z]) Electronics_Bay();
	
	translate([0,0,BodyTube_Z+BodyTubeLen+10+Overlap*2])
	STB_BallRetainerTop(BallPerimeter_d=Body_OD, Body_OD=Body_ID, nLockBalls=3, HasIntegratedCouplerTube=true, Body_ID=Body_ID, HasSecondServo=false, UsesBigServo=false);
	
	translate([0,0,BodyTube_Z+BodyTubeLen+10])
	STB_TubeEnd(BallPerimeter_d=Body_OD, nLockBalls=3, Body_OD=Body_OD, Body_ID=Body_ID, Skirt_Len=20);
	
	translate([0,0,BodyTube_Z]) color("LightBlue") Tube(OD=Body_OD, ID=Body_ID, 
			Len=BodyTubeLen-Overlap*2, myfn=$preview? 90:360);
	
	translate([0,0,FinCan_Z]) color("White") FinCan(LowerHalfOnly=false, UpperHalfOnly=false);
	
	//*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j])
		translate([Body_OD/2-Fin_Post_h, 0, Fin_Z]) 
			rotate([0,90,0]) color("Yellow") RocketFin();
	/**/
	
	translate([0,0,FinCan_Z-0.2]) MotorRetainer();
} // ShowRocket

//ShowRocket();

module R65_BallRetainerBottom(){
	difference(){
		STB_BallRetainerBottom(Body_ID=Body_ID, Body_OD=Body_ID, nLockBalls=nLockBalls, HasSpringGroove=false, 
								Engagement_Len=20, HasLargeInnerBearing=false, Xtra_r=0.2);
		
		rotate([0,0,PD_ShockCordAngle()-ShockCord_a]) 
			PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=3) Bolt4Hole();
	} // difference
} // R65_BallRetainerBottom

// translate([0,0,-8]) rotate([180,0,192]) R65_BallRetainerBottom();


module Electronics_Bay(Tube_OD=Body_OD, Tube_ID=Body_ID, TopOnly=false, BottomOnly=false){
	// made NC coupler IDXtra smaller 6/22/23

	Doors_Angles=[[0],[],[180]];
	Len=EBay_Len;
	
	Skirt_Len=15;
	
	BoltInset=Skirt_Len/2;
	
	
	EB_Electronics_BayUniversal(Tube_OD=Tube_OD, Tube_ID=Tube_ID, DoorAngles=Doors_Angles, Len=Len, 
									nBolts=3, BoltInset=BoltInset, ShowDoors=false,
									HasFwdIntegratedCoupler=false, HasFwdShockMount=false,
									HasAftIntegratedCoupler=false, HasAftShockMount=false,
									HasRailGuide=false, RailGuideLen=35,
									HasFwdCenteringRing=false, HasAftCenteringRing=false, InnerTube_OD=0,
									Bolted=true, ExtraBolts=[90], TopOnly=TopOnly, BottomOnly=BottomOnly); 
									
	
} // Electronics_Bay

// Electronics_Bay();

module SpringSpacer(OD=Coupler_OD, Tube_ID=Coupler_OD-2.4, Len=40){
	Tube(OD=OD, ID=Tube_ID, Len=Len, myfn=$preview? 36:360);
} // SpringSpacer

//SpringSpacer();

module UpperRailBtnMount(){
	Len=15;
	
	difference(){
		cylinder(d=Body_ID, h=Len);
		
		// remove extra
		translate([0,0,-Overlap]) {
		 translate([10,-Body_ID/2,0]) cube([Body_ID,Body_ID,Len+Overlap*2]);
		 mirror([1,0,0]) translate([10,-Body_ID/2,0]) cube([Body_ID,Body_ID,Len+Overlap*2]);
		}
		
		// Motor tube
		translate([0,0,-Overlap]) cylinder(d=MotorTubeHole_d, h=Len+Overlap*2);
		
		// Rail button bolt hole
		translate([0,-Body_OD/2,Len/2]) rotate([90,0,0]) Bolt8Hole();
		
		// Shock cord
		translate([0,MotorTube_OD/2+5,-1]) rotate([20,0,0]) cylinder(d=5, h=Len+5);
	} // difference

	difference(){
		rotate([0,0,90/5]) CenteringRing(OD=Body_ID, ID=MotorTubeHole_d, Thickness=3, nHoles=5, Offset=0);
		
		// Shock cord
		translate([0,MotorTube_OD/2+5,-1]) rotate([20,0,0]) cylinder(d=5, h=Len+5);
	} // difference	
	
} // UpperRailBtnMount

//UpperRailBtnMount();

module FinCan(LowerHalfOnly=false, UpperHalfOnly=false){
	//Wall_t=1.2; // Normal for LOC tube
	Wall_t=0.9; // thin for estes tube
	
	FC2_FinCan(Body_OD=Body_OD, Body_ID=Body_ID, Can_Len=Can_Len,
				MotorTube_OD=MotorTube_OD, RailGuide_h=1, RailGuide_z=0,
				nFins=nFins, HasIntegratedCoupler=true, Coupler_Len=10, nCouplerBolts=0,
				HasMotorSleeve=true, HasAftIntegratedCoupler=false,
				Fin_Root_W=Fin_Root_W, Fin_Root_L=Fin_Root_L, Fin_Post_h=Fin_Post_h, Fin_Chamfer_L=Fin_Chamfer_L,
				Cone_Len=TailCone_Len, ThreadedTC=true, Extra_OD=0, RailGuideLen=30,
				LowerHalfOnly=false, UpperHalfOnly=false, HasWireHoles=false, HollowTailcone=false, 
				HollowFinRoots=true, Wall_t=Wall_t, OgiveTailCone=false, Ogive_Len=400, OgiveCut_d=Body_OD+8);
				
} // FinCan

//FinCan(LowerHalfOnly=false, UpperHalfOnly=false);
//TailCone();

module RocketFin(){
	
	TrapFin2(Post_h=Fin_Post_h, Root_L=Fin_Root_L, Tip_L=Fin_Tip_L, Root_W=Fin_Root_W,
				Tip_W=Fin_Tip_W, Span=Fin_Span, Chamfer_L=Fin_Chamfer_L,
				TipOffset=Fin_TipOffset,
				Bisect=false, Bisect_X=0,
				HasSpar=false, Spar_d=8, Spar_L=100);
	
} // RocketFin

//RocketFin();

						
module MotorRetainer(HasWrenchCuts=false, Cone_Len=35, ExtraLen=0){
	
	FC2_MotorRetainer(Body_OD=Body_OD,
						MotorTube_OD=MotorTube_OD, MotorTube_ID=MotorTube_ID,
						HasWrenchCuts=false, Cone_Len=TailCone_Len, ExtraLen=ExtraLen, Extra_OD=0, Extra_ID=0, Ogive=false);
} // MotorRetainer

//translate([0,0,-0.2]) MotorRetainer(ExtraLen=0);









































