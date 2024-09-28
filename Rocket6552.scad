// ***********************************
// Project: 3D Printed Rocket
// Filename: Rocket65.scad
// by David M. Flynn
// Created: 9/5/2024
// Revision: 0.9.3  9/19/2024
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
// 0.9.3  9/19/2024  Worked on dual deploy version.
// 0.9.2  9/18/2024  Booster spring ends.
// 0.9.1  9/12/2024  Stager works, Printing begins
// 0.9.0  9/5/2024	 Copied from Rocket65.scad 1.0.11
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
// rotate([180,0,0]) Electronics_Bay(TopOnly=true, BottomOnly=false, ShowDoors=false);
// Electronics_Bay(TopOnly=false, BottomOnly=true, ShowDoors=false);

// rotate([-90,0,0]) EB_AltDoor(Tube_OD=Body_OD); // print 3
// rotate([-90,0,0]) EB_BattDoor(Tube_OD=Body_OD, HasSwitch=true, DoubleBatt=false); print 2
// rotate([-90,0,0]) EB_BattDoor(Tube_OD=Body_OD, HasSwitch=false, DoubleBatt=false);
//
// *** Ball Lock ***
//
// STB_LockDisk(BallPerimeter_d=Body_OD, nLockBalls=nLockBalls);
// rotate([180,0,0]) R65_BallRetainerTop(Body_OD=Body_OD, Body_ID=Body_ID, nBolts=4);
// R65_BallRetainerBottom();
// rotate([180,0,0]) STB_TubeEnd2(BallPerimeter_d=Body_OD, nLockBalls=nLockBalls, Body_OD=Body_OD, Body_ID=Body_ID, Engagement_Len=20);
//
// *** petal deployer ***
//
// PD_PetalHub(OD=Coupler_OD, nPetals=3, ShockCord_a=PD_ShockCordAngle());
// rotate([-90,0,0]) PD_PetalSpringHolder();
// rotate([180,0,0]) PD_Petals(Coupler_OD=Coupler_OD, Len=110, nPetals=3);
//
// SpringEndTop(OD=Coupler_OD, Tube_ID=Coupler_OD-2.4, nRopeHoles=3);
// SpringEndBottom(OD=Coupler_OD, Tube_ID=Coupler_OD-2.4, nRopeHoles=3);
// SpringSpacer(OD=Coupler_OD, Tube_ID=Coupler_OD-2.4, Len=40);
//
// rotate([180,0,0]) LowerEBay(ShowDoors=false, TopOnly=true, BottomOnly=false);
// LowerEBay(ShowDoors=false, TopOnly=false, BottomOnly=true);
//
// CenteringRing(OD=Body_ID, ID=BT38Coupler_OD+IDXtra, Thickness=5, nHoles=0, Offset=0, myfn=$preview? 90:360); // Alignment tool, print 2
//
// *** Fin Can ***
// CenteringRing(OD=Body_ID, ID=MotorTube_OD+IDXtra*2, Thickness=5, nHoles=5, Offset=0, myfn=$preview? 90:360);
//
// FinCan(LowerHalfOnly=false, UpperHalfOnly=true);
// RocketFin();
// rotate([180,0,0]) FinCan(LowerHalfOnly=true, UpperHalfOnly=false);
// 
//
//  ***** Booster *****
//
// rotate([180,0,0]) Sustainer_Cup();
// rotate([-90,0,0]) Stager_LockRod(Adj=0.5); // Looser
// rotate([-90,0,0]) Stager_LockRod(Adj=0.0); // too loose
// rotate([-90,0,0]) Stager_LockRod(Adj=-0.75);
//
// Stager_Saucer(Tube_OD=Body_OD, nLocks=nLocks);
//
// Stager_LockRing(Tube_OD=Body_OD, nLocks=nLocks); 
//
// Stager_Mech(Tube_OD=Body_OD, nLocks=nLocks, Skirt_ID=Body_ID, Skirt_Len=Stager_SkirtLen, nSkirtBolts=4, ShowLocked=true);
// Stager_OuterBearingCover(Tube_OD=Body_OD, nLocks=nLocks); // Secures Outer Race of Main Bearing
// rotate([180,0,0]) Stager_Indexer(Tube_OD=Body_OD, nLocks=nLocks); // Secures Inner Race of Main Bearing and has Lock Stops
// Stager_ServoPlate(Tube_OD=Body_OD, Skirt_ID=Body_ID, nLocks=nLocks, OverCenter=IDXtra+0.4);
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
// rotate([180,0,0]) PD_Petals(OD=Coupler_OD, Len=BoosterPetal_Len, nPetals=3); echo(BoosterPetal_Len=BoosterPetal_Len);
//
// rotate([180,0,0]) SE_SpringEndTypeA(Coupler_OD=Coupler_OD, Coupler_ID=Coupler_ID, nRopes=3, Spring_OD=SE_Spring_CS4323_OD());
//  SE_SpringEndTop(OD=Coupler_OD, Tube_ID=Coupler_OD-2.4, nRopeHoles=3, CutOutCenter=true);
//  SE_SlidingSpringMiddle(OD=Coupler_OD, nRopes=3, SliderLen=30, SpLen=30, SpringStop_Z=15, UseSmallSpring=true);
// SE_SpringEndBottom(OD=Coupler_OD, Tube_ID=Coupler_OD-2.4, Len=20, nRopeHoles=3, CutOutCenter=true);
//
// CenteringRing(OD=Body_ID, ID=MotorTube_OD+IDXtra*2, Thickness=10, nHoles=5, Offset=0, myfn=$preview? 90:360);
//
// BoosterFinCan(LowerHalfOnly=false, UpperHalfOnly=true);
// BoosterFin();
// rotate([180,0,0]) BoosterFinCan(LowerHalfOnly=true, UpperHalfOnly=false);
// BoosterMotorRetainer();
//
// rotate([90,0,0]) BoltOnRailGuide(Length = RailGuide_Len, BoltSpace=12.7, RoundEnds=true, ExtraBack=0);
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
BoosterBodyTube_Len=BoosterPetal_Len+180;
BoosterMotorTube_Len=BoosterFinCan_Len+BoosterTailCone_Len-12+60;
Booster_Len=BoosterTailCone_Len+BoosterFinCan_Len+BoosterEBay_Len+BoosterBodyTube_Len+33+23+32.7+Stager_SkirtLen+6+3;
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

LowerBodyTube_Len=123;
BodyTubeLen=240; // Middle tube, Drogue bay
SustainerUpperTube_Len=250;
SustainerMotorTube_Len=288;
echo(str("Sustainer Middle Body Tube Len = ",BodyTubeLen));
echo(str("Sustainer Lower Body Tube Len = ",LowerBodyTube_Len));

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
			//translate([0,0,-10.2-9-BoosterPetal_Len-40]) 
			//	SE_SpringEndTop(OD=Coupler_OD, Tube_ID=Coupler_OD-2.4, nRopeHoles=3, CutOutCenter=true);
			translate([0,0,-10.2-9-BoosterPetal_Len-40-45]) {
				SE_SpringEndTypeA(Coupler_OD=Coupler_OD, Coupler_ID=Coupler_ID, nRopes=3, Spring_OD=SE_Spring_CS4323_OD());	
				translate([0,0,12.5]) color("LightBlue") Tube(OD=Coupler_OD, ID=Coupler_ID, Len=50, myfn=90);
				//SE_SlidingSpringMiddle(OD=Coupler_OD, nRopes=3, SliderLen=30, SpLen=30, SpringStop_Z=15, UseSmallSpring=true);
				}
			translate([0,0,-10.2-9-BoosterPetal_Len-40-35-20]) 	
				rotate([180,0,0]) SE_SpringEndBottom(OD=Coupler_OD, Tube_ID=Coupler_OD-2.4, Len=20, nRopeHoles=3, CutOutCenter=true);
		}
		
	}
	
	if (ShowInternals) translate([0,0,BodyTube_Z+45])
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
	LowerEBay_Z=LowerBodyTube_Z+LowerBodyTube_Len-15;
	BodyTube_Z=LowerEBay_Z+LowerEBay_Len-15+Overlap*2;
	EBay_Z=BodyTube_Z+BodyTubeLen+33.5;
	MainBallLock_Z=EBay_Z+EBay_Len+23.2;
	UpperTube_Z=MainBallLock_Z+10;
	
	NoseCone_Z=UpperTube_Z+SustainerUpperTube_Len+3;
	
	translate([0,0,NoseCone_Z]){
		BluntOgiveNoseCone(ID=Coupler_OD, OD=Body_OD, L=NC_Len, Base_L=13, 
							Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=0, LowerPortion=false);
		color("Tan") NC_ShockcordRing75(Body_OD=Body_OD, Body_ID=Body_ID, NC_Base_L=NC_Base_L);
	}
	
	if (!ShowInternals) translate([0,0,UpperTube_Z+0.2]) color("Orange") 
		Tube(OD=Body_OD, ID=Body_ID, Len=SustainerUpperTube_Len-0.2, myfn=90);
	
	translate([0,0,MainBallLock_Z]){
		rotate([180,0,0]) STB_BallRetainerTop(BallPerimeter_d=Body_OD, Body_OD=Body_ID, nLockBalls=nLockBalls, 
						HasIntegratedCouplerTube=true, Body_ID=Body_ID, HasSecondServo=false, UsesBigServo=false);
		
		if (!ShowInternals) translate([0,0,0.2]) rotate([180,0,0])
			STB_TubeEnd2(BallPerimeter_d=Body_OD, nLockBalls=nLockBalls, Body_OD=Body_OD, Body_ID=Body_ID, Engagement_Len=20);
	}
	
	translate([0,0,EBay_Z]) Electronics_Bay(TopOnly=false, BottomOnly=false, ShowDoors=(ShowInternals==false));
	
	translate([0,0,BodyTube_Z+BodyTubeLen+10+Overlap*2]){
		STB_BallRetainerTop(BallPerimeter_d=Body_OD, Body_OD=Body_ID, nLockBalls=nLockBalls, 
						HasIntegratedCouplerTube=true, Body_ID=Body_ID, HasSecondServo=false, UsesBigServo=false);
	
	if (!ShowInternals)
		STB_TubeEnd2(BallPerimeter_d=Body_OD, nLockBalls=nLockBalls, Body_OD=Body_OD, Body_ID=Body_ID, Engagement_Len=20);
	}
	
	if (!ShowInternals) translate([0,0,BodyTube_Z]) color("Orange") Tube(OD=Body_OD, ID=Body_ID, 
			Len=BodyTubeLen-Overlap*2, myfn=$preview? 90:360);
	
	translate([0,0,LowerEBay_Z]) LowerEBay(ShowDoors=(ShowInternals==false));
	
	if (!ShowInternals) translate([0,0,LowerBodyTube_Z+0.1])
		color("Orange") Tube(OD=Body_OD, ID=Body_ID, Len=LowerBodyTube_Len-0.2, myfn=90);
		
	translate([0,0,FinCan_Z]) color("White") FinCan(LowerHalfOnly=false, UpperHalfOnly=false);
	
	// I161W
	//if (ShowInternals) translate([0,0,FinCan_Z-3]) ATRMS_38_360_Motor(HasEyeBolt=true);
	// I211W
	if (ShowInternals) translate([0,0,FinCan_Z-3]) ATRMS_38_480_Motor(HasEyeBolt=true);
	// I284W
	//if (ShowInternals) translate([0,0,FinCan_Z-3]) ATRMS_38_600_Motor(HasEyeBolt=true);
	
	//*
	if (ShowInternals) translate([0,0,FinCan_Z-3])
		color("Blue") Tube(OD=MotorTube_OD, ID=MotorTube_ID, Len=SustainerMotorTube_Len, myfn=90);
		/**/
	
	
	//*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j+180/nFins])
		translate([0, Body_OD/2-Fin_Post_h, Fin_Z]) 
			rotate([-90,0,0]) color("Yellow") RocketFin();
	/**/
	
	translate([0,0,FinCan_Z-3-StagerCollarLen-3-0.2]) Sustainer_Cup();
} // ShowRocket

//translate([0,0,Booster_Len]) ShowRocket(ShowInternals=true);

//ShowRocket(ShowInternals=false);

CouplerLenXtra=-5;
Engagement_Len=20;

module R65_BallRetainerTop(Body_OD=Body_OD, Body_ID=Body_ID, nBolts=4){
	Tube_d=12.7;
	Tube_Z=25;
	Tube_a=30;
	TubeSlot_w=35;
	TubeOffset_X=4;
	
	Wall_t=3;
	BoltInset=7.5;
	Skirt_H=8;
	Bolt_a=(nBolts==3)? 0:-25; // 3 or 4 bolts
	
	difference(){
		union(){
			STB_BallRetainerTop(BallPerimeter_d=Body_OD, Body_OD=Body_ID, nLockBalls=nLockBalls,
								HasIntegratedCouplerTube=true, IntegratedCouplerLenXtra=CouplerLenXtra,
								Outer_OD=Body_OD,
								Body_ID=Body_ID-IDXtra, HasSecondServo=false, UsesBigServo=false, Engagement_Len=Engagement_Len);
			
			translate([0,0,Tube_Z]) 
				Tube(OD=Body_ID-IDXtra, ID=Body_ID-IDXtra-Wall_t*2, Len=Tube_d/2+Wall_t, myfn=$preview? 90:360);
			
			// Shock cord retention
			difference(){
				rotate([0,0,Tube_a]) translate([TubeOffset_X,0,Tube_Z])
				hull(){
					rotate([90,0,0]) cylinder(d=Tube_d+Wall_t*2, h=Body_ID-2, center=true);
					translate([0,0,-16.25]) 
						cube([Tube_d+6, Body_ID-2, 1], center=true);
				} // hull
				
				rotate([0,0,Tube_a]) translate([TubeOffset_X,0,Tube_Z-Overlap]) hull(){
					rotate([90,0,0]) cylinder(d=Tube_d+7, h=TubeSlot_w, center=true);
					translate([0,0,-17]) 
						cube([Tube_d+6+Overlap, TubeSlot_w,1], center=true);
					}
				// Trim outside
				Tube(OD=Body_OD+20, ID=Body_ID-1, Len=50, myfn=$preview? 90:360);
				
				
			} // difference
		} // union
	
		rotate([0,0,Tube_a]) translate([TubeOffset_X,0,Tube_Z]) rotate([90,0,0]) cylinder(d=Tube_d, h=Body_OD, center=true);
		
		//Bolt holes for ebay
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+Bolt_a])
			translate([0, -Body_OD/2-1, Engagement_Len/2+Skirt_H+7.5]) 
				rotate([90,0,0]) Bolt4Hole(depth=6);
		
		// Bolt access
		rotate([0,0,18]) translate([0,Body_ID/2-Bolt4Inset,10]) Bolt4HeadHole(depth=8,lHead=30);
	} // difference
} // R65_BallRetainerTop

//  R65_BallRetainerTop(Body_OD=Body_OD, Body_ID=Body_ID);
// R65_BallRetainerTop(Body_OD=Body_OD, Body_ID=Body_ID, nBolts=4);

module R65_BallRetainerBottom(){
	difference(){
		STB_BallRetainerBottom(BallPerimeter_d=Body_OD, Body_OD=Body_ID, nLockBalls=nLockBalls, HasSpringGroove=false);
		
		rotate([0,0,PD_ShockCordAngle()-ShockCord_a]) 
			PD_PetalHubBoltPattern(OD=Coupler_OD) Bolt4Hole();
	} // difference
} // R65_BallRetainerBottom

// translate([0,0,-8]) rotate([180,0,192]) R65_BallRetainerBottom();

module Electronics_Bay(TopOnly=false, BottomOnly=false, ShowDoors=false){
	// Upper dual deploy EBay
	
	MainEBay=[[90],[],[270]];
	EB_Electronics_BayUniversal(Tube_OD=Body_OD+0.2, Tube_ID=Body_ID, DoorAngles=MainEBay, Len=EBay_Len, 
									nBolts=4, BoltInset=7.5, ShowDoors=ShowDoors,
									HasFwdIntegratedCoupler=false, HasFwdShockMount=false,
									HasAftIntegratedCoupler=false, HasAftShockMount=false,
									HasRailGuide=false, RailGuideLen=RailGuide_Len,
									Bolted=true, ExtraBolts=[90], TopOnly=TopOnly, BottomOnly=BottomOnly);
} // Electronics_Bay

// Electronics_Bay();

module LowerEBay(ShowDoors=false, TopOnly=false, BottomOnly=false){
	WireTube_d=5/16*25.4;
	
	LowerEBayDoors=[[90],[270],[]];
	
	difference(){
		EB_Electronics_BayUniversal(Tube_OD=Body_OD+0.2, Tube_ID=Body_ID, DoorAngles=LowerEBayDoors, Len=EBay_Len, 
									nBolts=0, BoltInset=7.5, ShowDoors=ShowDoors,
									HasFwdIntegratedCoupler=true, HasFwdShockMount=false,
									HasAftIntegratedCoupler=true, HasAftShockMount=false,
									HasRailGuide=true, RailGuideLen=RailGuide_Len,
									HasFwdCenteringRing=false, HasAftCenteringRing=true, InnerTube_OD=MotorTube_OD,
									Bolted=true, ExtraBolts=[90], TopOnly=TopOnly, BottomOnly=BottomOnly);
					
		// Wire Path
		rotate([0,0,360/nFins]) translate([0,MotorTube_OD/2+6,-Overlap]) 
			cylinder(d=WireTube_d, h=40);

	} // difference
} // LowerEBay

// LowerEBay();

module FinCan(LowerHalfOnly=false, UpperHalfOnly=false){
	
	TailPlate_t=7;
	WireTube_d=5/16*25.4;
	
	difference(){
		union(){
			FC2_FinCan(Body_OD=Body_OD, Body_ID=Body_ID, Can_Len=FinCan_Len,
						MotorTube_OD=MotorTube_OD, RailGuide_h=Body_OD/2+2,
						nFins=nFins, HasIntegratedCoupler=true, HasMotorSleeve=true, HasAftIntegratedCoupler=false,
						Fin_Root_W=Fin_Root_W, Fin_Root_L=Fin_Root_L, Fin_Post_h=Fin_Post_h, Fin_Chamfer_L=Fin_Chamfer_L,
						Cone_Len=0, ThreadedTC=false, Extra_OD=2, RailGuideLen=RailGuide_Len,
						LowerHalfOnly=LowerHalfOnly, UpperHalfOnly=UpperHalfOnly, HasWireHoles=false, HollowTailcone=false, 
						HollowFinRoots=false, Wall_t=1.2);
						
			if (UpperHalfOnly==false) translate([0,0,Fin_Inset-1-TailPlate_t])
				CenteringRing(OD=Body_OD, ID=MotorTube_OD+IDXtra*3, Thickness=TailPlate_t, nHoles=0, Offset=0, myfn=$preview? 90:360);
		} // union
				
		// Wire Path
		rotate([0,0,360/nFins]) translate([0,MotorTube_OD/2+6,Fin_Inset-1-TailPlate_t-Overlap]) 
			cylinder(d=WireTube_d, h=FinCan_Len+10+TailPlate_t);
		
		// Stager Bolt Holes
		if (UpperHalfOnly==false) translate([0,0,Fin_Inset-1-TailPlate_t])
			Stager_CupBoltHoles(Tube_OD=Body_OD, nLocks=nLocks) Bolt4Hole(depth=TailPlate_t);
		
	} // difference
				
} // FinCan

// FinCan(LowerHalfOnly=false, UpperHalfOnly=false);
//translate([0,0,-7-17.5]) Sustainer_Cup();


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

































