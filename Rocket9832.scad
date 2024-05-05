// ***********************************
// Project: 3D Printed Rocket
// Filename: Rocket9832.scad
// by David M. Flynn
// Created: 10/16/2022 
// Revision: 0.9.7  5/3/2024
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  98mm Body 3 Fins 2 Stages
//  Two Stage Rocket.
//
//  Warning! This is a complex rocket, skill level 11!
//  The only pyrotecnics used in this rocket are the motors.
//  Maximum motors J800T-P and K185W-P. 
//  Threaded forward closures are required to connect the shock cord to. 
//
//  The Sustainer has a Mission Control V3 for detection of booster separation,
//  motor ignition if staged, apogee deployment and main deployment. Uses two 
//  cable pullers to activate a Stager for spring loaded
//  drogue deployment and a fairing for main deployment.
//
//  The Booster has a Mission Control V3 for stage separation and
//  apogee deployment using two cable pullers. Has a Stager and SpringThing.
//
//  ***** Where does it go? *****
//  From top down the orientation of the main parts. 
//
//  Nosecone 
//
//  Fairing, cable at 270°
//
//  Electronics Bay 
//   Altimeter Battery 0°
//   Altimeter 90°
//   Cable Puller Battery w/ Switch 180°
//   Cable Puller (Fairing) 270°
//   Wires exit 270°
//  Drogue Mechanical Bay
//	 Cable Puller (SpringThing, push out drogue) 0°
//   Cable Puller Battery w/ Switch 90°
//   Cable Puller (Stager for drogue separation) 180°
//   Cable Puller Battery w/ Switch 270°
//   Wires for sustainer ignition exit 270°
// SpringThing2 (push out drogue)
//   Cable from Drogue Mechanical Bay (SpringThing, push out drogue) 0°
//   Cable from Drogue Mechanical Bay (Stager for drogue separation) 180°
//   Wire passthrough 270°
// Stager (Drogue separation)
//   Cable from Drogue Mechanical Bay (Stager for drogue separation) 180°
//   Wire passthrough 270°
//
// Drogue Cup
//   Stager Posts 0° and 180°
//   Rail Guide 210°
//   Wire connection (Booster attached, Sustainer igniter) 270°
// Upper Fin Can
//   Wires (note: rotated 60°) 330°
//	 Fins 30°, 150•, 270°
// Lower Fin Can
//   Wires 330°
//   Rail Guide 210°
//   Fins 30°, 150•, 270°
//
// Stager
//  Stager Posts 0° and 180°
//  Cable 330°
// SpringThing2
//  Cable 210°
//  Stager Cable 330°
// Booster Upper Fin Can
//  Fins 30°, 150•, 270°
//  Altimeter 90°
//  Cable Puller (Spring thing) 210° 
//  Cable Puller (Stager) 330°
// Booster Lower Fin Can
//  Fins 30°, 150•, 270°
//  Rail Guide 210°
//  Altimeter Battery 210°
//  Cable Puller Battery w/ Switch 90°
//  Cable Puller Battery w/ Switch 330°
//
//  ***** History *****
// 0.9.8  5/4/2024	  Updated to current designs.
// 0.9.7  5/3/2024    Added Petal Deployment for booster.
// 0.9.6  11/13/2022  Added PhantomSustainer()
// 0.9.5  11/5/2022   Alt Door changed. Fixes to Drogue Springthing. 
// 0.9.4  10/28/2022  Notes
// 0.9.3  10/27/2022  Drogue bays
// 0.9.2  10/18/2022  BoosterLowerFinCan
// 0.9.1  10/17/2022  BoosterUpperFinCan
// 0.9.0  10/16/2022  First code.
//
// ***********************************
//  ***** for STL output *****
//
// BluntOgiveNoseCone(ID=Body_ID, OD=Body_OD, L=NC_Len, Base_L=NC_Base, nRivets=3, Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=0, Transition_OD=Body_OD, LowerPortion=false);

// NC_ShockcordRingDual(Tube_OD=Body_OD, Tube_ID=Body_ID, NC_Base_L=NC_Base, nRivets=3, nBolts=3);
//
// rotate([180,0,0]) PD_Petals(OD=Coupler_OD, Len=110, nPetals=3, Wall_t=1.8, AntiClimber_h=4, HasLocks=false, Lock_Span_a=0);
// rotate([-90,0,0]) PD_PetalSpringHolder(OD=Coupler_OD);
// PD_NC_PetalHub(OD=Coupler_OD, nPetals=3, nRopes=6, ShockCord_a=-1, HasThreadedCore=false);
//
// rotate([180,0,0]) STB_TubeEnd(BallPerimeter_d=Body_OD, nLockBalls=6, Body_OD=Body_OD, Body_ID=Body_ID, Skirt_Len=20);
//
// STB_BallRetainerBottom(BallPerimeter_d=Body_OD, Body_OD=Body_ID, nLockBalls=6, HasSpringGroove=false, Engagement_Len=20, HasLargeInnerBearing=false);
// STB_LockDisk(BallPerimeter_d=Body_OD, nLockBalls=6, HasLargeInnerBearing=false);
// rotate([180,0,0]) STB_BallRetainerTop(BallPerimeter_d=Body_OD, Body_OD=Body_ID, nLockBalls=6, HasIntegratedCouplerTube=true, IntegratedCouplerLenXtra=-20, Body_ID=Body_ID, HasSecondServo=true, UsesBigServo=true, Engagement_Len=20, HasLargeInnerBearing=false);
//
//
// *** Electronics Bay ***
//
// R98_Electronics_Bay2();
// FairingBaseBulkPlate(Tube_ID=Body_ID, Fairing_ID=Fairing_ID, ShockCord_a=-1);
// AltDoor54(Tube_OD=Body_OD, IsLoProfile=true, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y);
// AltDoor54(Tube_OD=Body_OD, IsLoProfile=true, DoorXtra_X=0, DoorXtra_Y=0); // old
// CP_Door(Tube_OD=Body_OD, BoltBossInset=2, HasArmingSlot=true);
// BoltInServoMount();
// Batt_Door(Tube_OD=Body_OD, HasSwitch=false);
// Batt_Door(Tube_OD=Body_OD, InnerTube_OD=R9832_DualDepTube_OD, HasSwitch=true);
//
// ------------
// *** Cable Puller, 5 Req. ***
// ThroughOut();
// rotate([0,90,0]) SpringBody();
// CableRetainer();
// StopAdjuster();
// CageBottom();
// AddServo(); // CageTop w/ servo mount
/*
	translate([0,0,CP_SpringBody_YZ/2+2.5]) rotate([180,0,0]){ 
		CageTop();
		BellCrankTriggerBearingHolder();}
/**/
// rotate([180,0,0]) TriggerBellCrank();
// ------------
//
// DrogueMechBay();
//
//  *** SpringThing parts for dual deploy ***
// ST_TubeEnd(Tube_OD=R9832_DualDepTube_OD, Tube_ID=R9832_DualDepTube_ID);
// ST_TubeLock(Tube_OD=R9832_DualDepTube_OD, Tube_ID=R9832_DualDepTube_ID);
// ST_SpringMiddle(Tube_ID=R9832_DualDepTube_ID);
// ST_SpringGuide(Tube_ID=R9832_DualDepTube_ID);
// DrogueSpringThing();
// rotate([0,180,0]) Drogue_ST_CableRedirect();
// ST_BallKeeper(Tube_OD=R9832_DualDepTube_OD);
// ST_BallSpacer(Tube_OD=Body_OD, InnerTube_OD=R9832_DualDepTube_OD);
// mirror([0,0,1]) ST_LockBallRetainer(Tube_OD=Body_OD, HasDetent=false);
// rotate([180,0,0]) mirror([0,0,1]) ST_LockRing(InnerTube_OD=R9832_MtrTube_OD);
// ST_DetentOnly(InnerTube_OD=R9832_MtrTube_OD);
// mirror([0,1,0]) ST_CableEndAndStop(Tube_OD=Body_OD, InnerTube_OD=R9832_DualDepTube_OD);
// Drogue_ST_LowerCenteringRing();
//
//  *** Stager parts for dual deploy ***
// BallDetentStopper();
// rotate([0,180,0]) DrogueSep_CableRedirect();
// Stager_Detent();
// CableEndAndStop(Tube_OD=Body_OD);
// rotate([0,180,0]) DrogueSep();
// Stager_BallSpacer(Tube_OD=Body_OD);
// Stager_InnerRace(Tube_OD=Body_OD);
// LockRing(nLocks=2);
// SaucerEConnHolder(Tube_OD=Body_OD);
// Stager_Saucer(Tube_OD=Body_OD, nLocks=2, HasElectrical=true);
//
// ------------
//
// rotate([-90,0,0]) Stager_LockRod(Adj=-0.5);
// Drogue_Cup();
//
// UpperFinCan();
// Rocket9832Fin();
// rotate([180,0,0]) LowerFinCan();
//
// *** Booster Parts ***
//
// --------------
//  ** Stager Parts, top of booster **
// rotate([180,0,0]) Stager_Cup(Tube_OD=Body_OD, ID=78, nLocks=2, BoltsOn=true, Collar_h=18+15);
// rotate([-90,0,0]) Stager_LockRod(Adj=-0.5); // print 4
//
// Stager_Saucer(Tube_OD=Body_OD, nLocks=2); // Bolts on
//
// Stager_Mech(Tube_OD=Body_OD, nLocks=2, Skirt_ID=Body_ID, Skirt_Len=30, KeyOffset_a=-30, HasRaceway=false, Raceway_a=270);
// LockRing(nLocks=2);
// Stager_InnerRace(Tube_OD=Body_OD, nLocks=2);
// Stager_BallSpacer(Tube_OD=Body_OD); // print 2
// CableRedirect(Tube_OD=Body_OD, Skirt_ID=Body_ID, Tube_ID=PML98Coupler_ID, InnerTube_OD=R9832_BoosterMtrTube_OD);
// mirror([0,1,0]) CableEndAndStop(Tube_OD=Body_OD);
// Stager_Detent();
// BallDetentStopper();
// -------------
//
// rotate([180,0,0]) PD_Petals(OD=BT54Coupler_OD, Len=180, nPetals=2, Wall_t=1.8, AntiClimber_h=0, HasLocks=false, Lock_Span_a=0);
// rotate([-90,0,0]) PD_PetalSpringHolder(OD=BT54Coupler_OD);
// BoosterPetalHub();
//
// 
// ST_SpringMiddle(Tube_ID=BT54Coupler_OD); // optional double spring slider
// ST_SpringGuide(InnerTube_ID=BT54Coupler_OD); // Sits on top of motor, glued to bottom of spring. 
//
// -------------
//
// BoosterUpperFinCan();
// Rocket9832BoosterFin();
// rotate([180,0,0]) BoosterLowerFinCan();
// Batt_Door(Tube_OD=Body_OD, HasSwitch=false);
// Batt_Door(Tube_OD=Body_OD, HasSwitch=true);
//
// *** The Rail Guides ***
// rotate([90,0,0]) BoltOnRailGuide(Length = 35, BoltSpace=12.7, RoundEnds=true); // Drogue Cup
// rotate([90,0,0]) BoltOnRailGuide(Length = 40, BoltSpace=12.7, RoundEnds=true); // lower fin can
// rotate([90,0,0]) BoltOnRailGuide(Length = 30, BoltSpace=12.7, RoundEnds=true); // booster lower fin can
//
// ***********************************
//  ***** Routines *****
//
//
// ***********************************
//  ***** for Viewing *****
//
// ShowBooster9832();
// ShowRocket9832();
// translate([0,0,1500]) ShowUpperBays();
//
// ***********************************
use<NoseCone.scad>
use<FinCan.scad>
use<Stager2Lib.scad>
use<SpringThingBooster.scad>
include<AltBay.scad>
use<CablePuller.scad>
use<BatteryHolderLib.scad>
use<SpringThing2.scad>
use<PetalDeploymentLib.scad>
use<RacewayLib.scad>

//also included
 //include<CablePuller.scad>
 //include<FairingJointLib.scad>
 //include<RailGuide.scad>
 //include<Fins.scad>
 //include<TubesLib.scad>
 //include<BearingLib.scad>
 //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

nFins=3;

// Sustainer Fin
ExtraForward=0;
R9832_Fin_Post_h=10;
R9832_Fin_Root_L=200+ExtraForward;
R9832_Fin_Root_W=12;
R9832_Fin_Tip_W=5;
R9832_Fin_Tip_L=(R9832_Fin_Root_L-ExtraForward)*0.75;
R9832_Fin_Span=(R9832_Fin_Root_L-ExtraForward)*0.75;
R9832_Fin_TipOffset=ExtraForward/2;
R9832_Fin_Chamfer_L=R9832_Fin_Root_W*2.5;

// Booster Fin
R9832Booster_Fin_Post_h=10;
R9832Booster_Fin_Root_L=240;
R9832Booster_Fin_Root_W=14;
R9832Booster_Fin_Tip_W=5;
R9832Booster_Fin_Tip_L=R9832Booster_Fin_Root_L*0.75;
R9832Booster_Fin_Span=R9832Booster_Fin_Root_L*0.75;
R9832Booster_Fin_TipOffset=0;
R9832Booster_Fin_Chamfer_L=R9832Booster_Fin_Root_W*2.5;

Body_OD=PML98Body_OD;
Body_ID=PML98Body_ID;
Coupler_OD=BT98Coupler_OD;
Coupler_ID=BT98Coupler_ID;
R9832_MtrTube_OD=PML54Body_OD;
R9832_MtrTube_ID=PML54Body_ID;
R9832_BoosterMtrTube_OD=BT54Mtr_OD;
R9832_DualDepTube_OD=BT54Body_OD;
R9832_DualDepTube_ID=BT54Body_ID;

EBay_Len=130;
//Booster_Body_Len=R9832Booster_Fin_Root_L+60+116.5; // minimum length J460T
Booster_Body_Len=R9832Booster_Fin_Root_L+60+116.5+90; // J800T
//echo(Booster_Body_Len=Booster_Body_Len);

// Fairing Overrides
Fairing_OD=PML98Body_OD;
FairingWall_T=2.2;
Fairing_ID=Fairing_OD-FairingWall_T*2;
Fairing_Len=180; // Body of the fairing.

NC_Len=350;
NC_Tip_r=5;
NC_Base=15;
NC_Wall_t=2.2;

Alt_DoorXtra_X=2;
Alt_DoorXtra_Y=2;
	

//BodyTubeLen=36*25.4;
module ShowMotorK185W(){
	Casing_Len=296+84.5;
	
	color("Black") cylinder(d=57, h=10);
	translate([0,0,10]) color("Red") cylinder(d=54, h=Casing_Len);
	translate([0,0,10+Casing_Len]) color("Black"){
		cylinder(d=54, h=3);
		cylinder(d=39, h=23);
		cylinder(d=20, h=30);
	}
} // ShowMotorK185W

// ShowMotorK185W();

module ShowMotorJ800T(){
	Casing_Len=296;
	
	color("Black") cylinder(d=57, h=10);
	translate([0,0,10]) color("Red") cylinder(d=54, h=Casing_Len);
	translate([0,0,10+Casing_Len]) color("Black"){
		cylinder(d=54, h=3);
		cylinder(d=39, h=23);
		cylinder(d=20, h=30);
	}
} // ShowMotorJ800T

// ShowMotorJ800T();

module ShowMotorJ460T(){
	Casing_Len=211;
	
	color("Black") cylinder(d=57, h=10);
	translate([0,0,10]) color("Red") cylinder(d=54, h=Casing_Len);
	translate([0,0,10+Casing_Len]) color("Black"){
		cylinder(d=54, h=3);
		cylinder(d=39, h=23);
		cylinder(d=20, h=30);
	}
} // ShowMotorJ460T

//ShowMotorJ460T();

module ShowChuteTube(){
	Len=7*25.4;
	
	//difference(){
		cylinder(d=54, h=Len);
		
	//} // difference
} // ShowChuteTube

//ShowChuteTube();

module ShowBooster9832(){
	UpperFinCan_Z=R9832Booster_Fin_Root_L+45;
	
	translate([0,0,Booster_Body_Len-35]) color("Blue") Stager_Saucer(Tube_OD=Body_OD, nLocks=2);
	translate([0,0,Booster_Body_Len-35]) Stager_Mech(Tube_OD=Body_OD, nLocks=2, Skirt_ID=Body_ID, Skirt_Len=20);
	
	translate([0,0,290]) ShowChuteTube();
	
	translate([0,0,320]) rotate([0,0,60]) DrogueSpringThing();
	
	translate([0,0,UpperFinCan_Z]) BoosterUpperFinCan();
	
	//*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j])
		translate([Body_OD/2-R9832_Fin_Post_h, 0, R9832Booster_Fin_Root_L/2+15]) 
			rotate([0,90,0]) color("Orange") Rocket9832BoosterFin();
	/**/
	
	translate([0,0,-40]) color("Green") BoosterLowerFinCan();
	
	//translate([0,0,-40]) ShowMotorJ460T();
	translate([0,0,-40]) ShowMotorJ800T();
} // ShowBooster9832

//ShowBooster9832();

FinCanExTube_Len=105;

module ShowRocket9832(){
	TopOfFinCan_Z=Booster_Body_Len-40+R9832_Fin_Root_L+100+150;
	
	translate([0,0,TopOfFinCan_Z]) rotate([180,0,0]) Drogue_Cup();
	translate([0,0,TopOfFinCan_Z-60]) rotate([180,0,0]) 
		color("LightBlue") Tube(OD=Body_OD, ID=Body_ID, Len=FinCanExTube_Len, myfn=$preview? 36:360);
	
	translate([0,0,Booster_Body_Len-40+R9832_Fin_Root_L+100]) UpperFinCan();
	//*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j])
		translate([Body_OD/2-R9832_Fin_Post_h, 0, Booster_Body_Len+R9832_Fin_Root_L/2+10]) 
			rotate([0,90,0]) color("Orange") Rocket9832Fin();
	/**/
	
	//*
	translate([0,0,Booster_Body_Len-40]) {
		color("Tan") LowerFinCan();
		translate([0,0,5]) Stager_Cup(Tube_OD=Body_OD, ID=78, nLocks=2);
	}
	/**/
	
	translate([0,0,Booster_Body_Len-40]) ShowMotorK185W();
	
	ShowBooster9832();
	
} // ShowRocket9832

//ShowRocket9832();


module R98_Electronics_Bay(){
	
	Electronics_Bay(Tube_OD=PML98Body_OD, Tube_ID=PML98Body_ID, Fairing_ID=Fairing_ID, 
				EBay_Len=EBay_Len, HasCablePuller=true);
	
	TubeStop(InnerTubeID=Coupler_ID, OuterTubeOD=PML98Body_OD, myfn=$preview? 36:360);
	
	translate([0,0,30]) DoubleBatteryHolder(Tube_ID=PML98Body_ID, HasBoltHoles=false);
	
} // R98_Electronics_Bay

//R98_Electronics_Bay();


module R98_Electronics_Bay2(){
	Len=162;
	CablePuller_Z=81;
	BattSwDoor_Z=70;
	TopSkirt_Len=15;
	BottomSkirt_Len=15;
	CP1_a=0;
	Alt_a=180;
	Batt1_a=90; // Altimeter Battery
	Batt2_a=270; // Cable puller battery and switch
	
	// The Fairing clamps onto this. 
	translate([0,0,Len]) FairingBaseLockRing(Tube_OD=Body_OD, Tube_ID=Body_ID, Fairing_ID=Fairing_ID, Interface=Overlap, BlendToTube=true);
	
	difference(){
		union(){
			Tube(OD=Body_OD, ID=Body_ID, Len=Len, myfn=$preview? 36:360);
			translate([0,0,BottomSkirt_Len])
				CenteringRing(OD=Body_OD-1, ID=BT54Mtr_OD+IDXtra, Thickness=5, nHoles=4);
			translate([0,0,Len-5-TopSkirt_Len])
				CenteringRing(OD=Body_OD-1, ID=BT54Mtr_OD+IDXtra, Thickness=5, nHoles=4);
	} // union
		
		// Altimeter
		translate([0,0,CablePuller_Z]) rotate([0,0,Alt_a]) 
			Alt_BayFrameHole(Tube_OD=Body_OD, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y);
	
		// Cable Puller door hole
		translate([0,0,CablePuller_Z]) rotate([0,0,CP1_a])
			CP_BayFrameHole(Tube_OD=Body_OD);
		
		// Battery and Switch door holes
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
			Batt_BayFrameHole(Tube_OD=Body_OD, HasSwitch=false);
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt2_a]) 
			Batt_BayFrameHole(Tube_OD=Body_OD, HasSwitch=true);
		
	} // difference
	
	// Altimeter
	translate([0,0,CablePuller_Z]) rotate([0,0,Alt_a])
		Alt_BayDoorFrame(Tube_OD=Body_OD, Tube_ID=Body_ID, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowDoor=false);
	
	// Cable Pullers
	translate([0,0,CablePuller_Z]) rotate([0,0,CP1_a])
		CP_BayDoorFrame(Tube_OD=Body_OD, ShowDoor=false);
	
	// Battery and Switch door2
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
		Batt_BayDoorFrame(Tube_OD=PML98Body_OD, HasSwitch=false, ShowDoor=false);
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt2_a]) 
		Batt_BayDoorFrame(Tube_OD=PML98Body_OD, HasSwitch=true, ShowDoor=false);
	
} // R98_Electronics_Bay2

//translate([0,0,162]) R98_Electronics_Bay2();

module DrogueMechBay(){
	Len=162;
	CablePuller_Z=81;
	BattSwDoor_Z=70;
	TopSkirt_Len=15;
	BottomSkirt_Len=15;
	CP1_a=0;
	CP2_a=180;
	Batt1_a=90;
	Batt2_a=270;
	
	
	difference(){
		union(){
			Tube(OD=Body_OD, ID=Body_ID, Len=Len, myfn=$preview? 36:360);
			translate([0,0,BottomSkirt_Len])
				CenteringRing(OD=Body_OD-1, ID=BT54Mtr_OD+IDXtra, Thickness=5, nHoles=4);
			translate([0,0,Len-5-TopSkirt_Len])
				CenteringRing(OD=Body_OD-1, ID=BT54Mtr_OD+IDXtra, Thickness=5, nHoles=4);
		} // union
		
		// Cable Puller door holes
		translate([0,0,CablePuller_Z]) rotate([0,0,CP1_a])
			rotate([0,180,0]) CP_BayFrameHole(Tube_OD=Body_OD);
		translate([0,0,CablePuller_Z]) rotate([0,0,CP2_a]) 
			rotate([0,180,0]) CP_BayFrameHole(Tube_OD=Body_OD);
		
		// Battery and Switch door holes
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
			Batt_BayFrameHole(Tube_OD=Body_OD, HasSwitch=true);
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt2_a]) 
			Batt_BayFrameHole(Tube_OD=Body_OD, HasSwitch=true);
		
	} // difference
	
	// Cable Pullers
	translate([0,0,CablePuller_Z]) rotate([0,0,CP1_a])
		rotate([0,180,0]) CP_BayDoorFrame(Tube_OD=Body_OD, ShowDoor=false);
	translate([0,0,CablePuller_Z]) rotate([0,0,CP2_a]) 
		rotate([0,180,0]) CP_BayDoorFrame(Tube_OD=Body_OD, ShowDoor=false);
	
	// Battery and Switch door2
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
		Batt_BayDoorFrame(Tube_OD=Body_OD, HasSwitch=true, ShowDoor=false);
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt2_a]) 
		Batt_BayDoorFrame(Tube_OD=Body_OD, HasSwitch=true, ShowDoor=false);
	
} // DrogueMechBay

//DrogueMechBay();

module DrogueSpringThing(){
	// 70mm long
	//   Cable from Drogue Mechanical Bay (SpringThing, push out drogue) 0°
	//   Cable from Drogue Mechanical Bay (Stager for drogue separation) 180°
	//   Wire passthrough 270°

	Raceway_Len=36;
	Raceway_Z=-1;
	
	module RacewayHole(){
		translate([0,0,Raceway_Z+Raceway_Len/2]) 
			Raceway_Exit(Tube_OD=Body_OD, Race_ID=6, Wall_t=4, Top_Len=10, Bottom_Len=10);
		translate([0,0,Raceway_Z-Raceway_Len/2]) rotate([180,0,0]) 
			Raceway_Exit(Tube_OD=Body_OD, Race_ID=6, Wall_t=4, Top_Len=10, Bottom_Len=10);
	} // RacewayHole
	
	module RacewayOuter(){
		translate([0,0,Raceway_Z+Raceway_Len/2]) 
			Raceway_End(Tube_OD=Body_OD, Race_ID=6, Wall_t=4, Len=Raceway_Len/2); //External cover end
		translate([0,0,Raceway_Z-Raceway_Len/2]) rotate([180,0,0]) 
			Raceway_End(Tube_OD=Body_OD, Race_ID=6, Wall_t=4, Len=Raceway_Len/2); //External cover end
	} // RacewayOuter
	
	//*
	difference(){
		rotate([0,180,0]) ST_Frame(Tube_OD=Body_OD, Skirt_ID=Body_ID, Collar_Len=26, Skirt_Len=34);

		// Sustainer wires 270°
		RacewayHole();
		
		// Stager Cable 180°
		rotate([0,0,-90]) RacewayHole();
	} // difference
	/**/
	// Sustainer wires
	RacewayOuter();
	
	// Stager Cable 180°
	rotate([0,0,-90]) RacewayOuter();
	
} // DrogueSpringThing

//translate([0,0,-40-Overlap]) DrogueSpringThing();

module Drogue_ST_CableRedirect(){
	
	module WireCut(){
		translate([0,0,-6]) hull(){
			translate([Body_OD/2,0,0]) cylinder(d=6, h=40);
			translate([Body_OD/2-6,0,0]) cylinder(d=6, h=40);
		} // hull
	} // WireCut
	
	difference(){
		rotate([0,180,0]) ST_CableRedirect(Tube_OD=Body_OD, Skirt_ID=Body_ID, 
							Tube_ID=Coupler_ID, 
							InnerTube_OD=R9832_DualDepTube_OD);
		
		// cut out for wires
		WireCut();
		
		// cut out for stager cable
		rotate([0,0,-90]) WireCut();
		
	} // difference
} // Drogue_ST_CableRedirect

//rotate([0,180,0]) Drogue_ST_CableRedirect();

//ST_DetentOnly();
//mirror([0,0,1]) ST_LockRing();

//translate([0,0,-13]) rotate([0,0,0]) 
//mirror([0,0,1]) ST_LockBallRetainer(Tube_OD=PML98Body_OD,HasDetent=false);

module Drogue_ST_LowerCenteringRing(){
	
	module WireCut(){
		translate([0,0,-6]) hull(){
			translate([Body_OD/2,0,0]) cylinder(d=6, h=40);
			translate([Body_OD/2-6,0,0]) cylinder(d=6, h=40);
		} // hull
	} // WireCut
	
	difference(){
		rotate([0,180,0]) ST_UpperCenteringRing(Tube_OD=Body_OD, 
					Skirt_ID=Body_ID, InnerTube_OD=R9832_DualDepTube_OD);
		
		// cut out for wires
		WireCut();
		
		// cut out for stager cable
		rotate([0,0,-90]) WireCut();
	} // difference
} // Drogue_ST_LowerCenteringRing

//Drogue_ST_LowerCenteringRing();

module ShowUpperBays(){
	rotate([0,0,90]) translate([0,0,162]) R98_Electronics_Bay2();
	DrogueMechBay();
	
	//*
	translate([0,0,-34-Overlap]){
		translate([0,0,19]) Drogue_ST_CableRedirect();
		DrogueSpringThing();
		translate([0,0,-17]) Drogue_ST_LowerCenteringRing();
	}
	//*
	translate([0,0,-295]) color("Blue") Tube(OD=BT54Mtr_OD, ID=BT54Mtr_ID, Len=23.75*25.4, myfn=$preview? 36:360);
	translate([90,0,-300]) color("Blue") Tube(OD=BT54Mtr_OD, ID=BT54Mtr_ID, Len=240, myfn=$preview? 36:360);
	//*
	translate([0,0,-34-70-126]) color("Orange") Tube(OD=Body_OD, ID=Body_ID, Len=159.5, myfn=$preview? 36:360);
	//*
	translate([0,0,-317.2]){
		translate([0,0,78]) DrogueSep_CableRedirect();
		DrogueSep();
		
	}
	
	// wires
	//*
	translate([0,0,-350]) rotate([0,0,-90]) translate([0,40,0]) cylinder(d=6, h=100);
	//*
	translate([0,0,-45]) ST_LockRing(); // Glued to top of spring.


	/**/
} // ShowUpperBays

//ShowUpperBays();

module DrogueSep_CableRedirect(){
	rotate([180,0,180]) Stager_CableRedirect(Tube_OD=Body_OD, Skirt_ID=Body_ID, Tube_ID=Coupler_ID, InnerTube_OD=BT54Mtr_OD, HasRaceway=true,
							Raceway_a=270);
} // DrogueSep_CableRedirect

//translate([0,0,78]) DrogueSep_CableRedirect();

module DrogueSep(){

	rotate([180,0,0]) 
		Stager_Mech(Tube_OD=Body_OD, nLocks=2, Skirt_ID=Body_ID, 
			Skirt_Len=30, KeyOffset_a=0, HasRaceway=true, Raceway_a=270);
		
} // DrogueSep

//DrogueSep();

//translate([0,0,-170]) rotate([180,0,180])
//CableRedirect(Tube_OD=Body_OD, Skirt_ID=Body_ID, Tube_ID=PML98Coupler_ID, InnerTube_OD=BT54Mtr_OD);

//
//translate([0,0,-320]) color("Orange") DrogueSep();

module Drogue_Cup(){
	WireHole_d=5.5;
	RailGuide_Z=-32;
	RG_Len=35;
	Rivet_Z=-40;
	
	difference(){
		rotate([180,0,0]) Stager_Cup(Tube_OD=Body_OD, ID=76, nLocks=2, BoltsOn=false, HasElectrical=true);
	
		/* replace by Molex connector
		//Sustainer Ignition Wire
		rotate([0,0,-90]) translate([0,Coupler_ID/2-WireHole_d/2-3,-22]) 
			cylinder(d=WireHole_d, h=25);
		/**/
		
		// Rail guide bolts
		translate([0,0,RailGuide_Z]) rotate([0,0,-90-180/nFins]) 
			translate([0,Body_OD/2+2,0]) RailGuideBoltPattern(BoltSpace=12.7) Bolt6Hole();
	} // difference
	
	difference(){
		// Skirt
		translate([0,0,-60]) Tube(OD=Body_OD, ID=Body_ID, Len=60, myfn=$preview? 36:360);
	
		// Rail guide bolts
		translate([0,0,RailGuide_Z]) rotate([0,0,-90-180/nFins]) 
			translate([0,Body_OD/2+2,0]) RailGuideBoltPattern(BoltSpace=12.7) Bolt6Hole();
		
		// Rivet holes
		for (j=[0:2]) rotate([0,0,120*j]) translate([0,Body_OD/2+1,Rivet_Z])
			rotate([90,0,0]) cylinder(d=4, h=5);
	} // difference
	
	//*
	difference(){
		// Rail Guide
		translate([0,0,RailGuide_Z]) rotate([0,0,-90-180/nFins]) 
			//RailButtonPost(OD=R98_Body_OD, MtrTube_OD=R98_MtrTube_OD, H=R98_Body_OD/2+5, Len=30);
			RailGuidePost(OD=Body_OD, MtrTube_OD=R9832_MtrTube_OD+IDXtra*2, H=Body_OD/2+2, 
				TubeLen=RG_Len+10, Length = RG_Len, BoltSpace=12.7);
		
		translate([0,0,-80]) cylinder(d=Body_OD-1, h=80);
		
		// Rivet holes
		for (j=[0:2]) rotate([0,0,120*j]) translate([0,Body_OD/2+1,Rivet_Z])
			rotate([90,0,0]) cylinder(d=4, h=5);
	} // difference
		
	/**/
	if ($preview) rotate([0,0,-90-180/nFins])  translate([0,Body_OD/2+2,RailGuide_Z]) 
		BoltOnRailGuide(Length = RG_Len, BoltSpace=12.7, RoundEnds=true);
} // Drogue_Cup

//Drogue_Cup();

module PhantomSustainer(){
	// Combine with a Drogue_Cup to launch w/o the sustainer
	Rivet_Z=35;
	
	Stager_Cup(Tube_OD=Body_OD, ID=78, nLocks=2, BoltsOn=false, Collar_h=16, HasElectrical=true);
	
	difference(){
		// Skirt
		Tube(OD=Body_OD, ID=Body_ID, Len=50, myfn=$preview? 36:360);
	
		// Rail guide bolts
		//translate([0,0,RailGuide_Z]) rotate([0,0,-90-180/nFins]) 
		//	translate([0,Body_OD/2+2,0]) RailGuideBoltPattern(BoltSpace=12.7) Bolt6Hole();
		
		// Rivet holes
		for (j=[0:2]) rotate([0,0,120*j]) translate([0,Body_OD/2+1,Rivet_Z])
			rotate([90,0,0]) cylinder(d=4, h=5);
	} // difference
} // PhantomSustainer

//rotate([180,0,0]) PhantomSustainer();

module UpperFinCan(){
	// Upper Half of Fin Can
	
	
		rotate([180,0,0]) 
			FinCan(Tube_OD=Body_OD, Tube_ID=Body_ID, 
				MtrTube_OD=R9832_MtrTube_OD+IDXtra*2, nFins=nFins,
				Post_h=R9832_Fin_Post_h, Root_L=R9832_Fin_Root_L, 
				Root_W=R9832_Fin_Root_W, 
				Chamfer_L=R9832_Fin_Chamfer_L, HasTailCone=false); 
		
	
	
} // UpperFinCan

//UpperFinCan();

module LowerFinCan(){
	RailGuide_Z=110;
	
	difference(){
		union(){
			FinCan(Tube_OD=Body_OD, Tube_ID=Body_ID, 
				MtrTube_OD=R9832_MtrTube_OD+IDXtra*2, nFins=nFins, 
				Post_h=R9832_Fin_Post_h, Root_L=R9832_Fin_Root_L, Root_W=R9832_Fin_Root_W, 
				Chamfer_L=R9832_Fin_Chamfer_L, 
				HasTailCone=true,
						MtrRetainer_OD=R9832_MtrTube_OD+5,
						MtrRetainer_L=20,
						MtrRetainer_Inset=7); // Lower Half of Fin Can
			
			
			
			
			// Stager cup mounts here
			translate([0,0,15])
			difference(){
				cylinder(d=Body_OD, h=30, $fn=$preview? 90:360);
				translate([0,0,-Overlap]) cylinder(d=72, h=30+Overlap*2);
			} // difference
		} // union
		
		// Igniter wirs
			rotate([0,0,180/nFins]) translate([R9832_MtrTube_OD/2+8,0,0]) 
				cylinder(d=7, h=R9832_Fin_Root_L);
		
		translate([0,0,RailGuide_Z]) rotate([0,0,-90-180/nFins]) 
			translate([0,Body_OD/2+2,0]) RailGuideBoltPattern(BoltSpace=12.7) Bolt6Hole();
		
		// Booster attachment
		translate([0,0,8]) Stager_CupHoles(Tube_OD=Body_OD, ID=78, nLocks=2);
	} // difference
		

	//*
	// Rail Guide
	difference(){
		translate([0,0,RailGuide_Z]) rotate([0,0,-90-180/nFins]) 
			//RailButtonPost(OD=R98_Body_OD, MtrTube_OD=R98_MtrTube_OD, H=R98_Body_OD/2+5, Len=30);
			RailGuidePost(OD=Body_OD, MtrTube_OD=R9832_MtrTube_OD+IDXtra*2, H=Body_OD/2+2, TubeLen=70, Length = 40, BoltSpace=12.7);
		
		translate([0,0,RailGuide_Z]) TrapFin2Slots(Tube_OD=Body_OD, nFins=nFins, 	
			Post_h=R9832_Fin_Post_h, Root_L=R9832_Fin_Root_L, Root_W=R9832_Fin_Root_W, Chamfer_L=R9832_Fin_Chamfer_L);
	} // difference
	/**/
} // LowerFinCan

// translate([0,0,-40]) LowerFinCan();


module Rocket9832Fin(){
	TrapFin2(Post_h=R9832_Fin_Post_h, Root_L=R9832_Fin_Root_L, Tip_L=R9832_Fin_Tip_L, 
			Root_W=R9832_Fin_Root_W, Tip_W=R9832_Fin_Tip_W, 
			Span=R9832_Fin_Span, Chamfer_L=R9832_Fin_Chamfer_L,
					TipOffset=R9832_Fin_TipOffset);

	if ($preview==false){
		translate([-R9832_Fin_Root_L/2+10,0,0]) cylinder(d=R9832_Fin_Root_W*2.5, h=0.9); // Neg
		translate([R9832_Fin_Root_L/2-10,0,0]) cylinder(d=R9832_Fin_Root_W*2.5, h=0.9); // Pos
	}
} // Rocket9832Fin

// Rocket9832Fin();

// Spring thing
/*
translate([0,0,-10]){
translate([0,0,-10]) rotate([180,0,0]) ST_CableRedirect(Tube_OD=Body_OD, Skirt_ID=Body_ID, 
							Tube_ID=PML98Coupler_ID, 
							InnerTube_OD=BT54Mtr_OD, StageCable_a=180);
translate([0,0,-30]) rotate([180,0,50]) ST_Frame(Tube_OD=PML98Body_OD, Skirt_ID=PML98Body_ID, Collar_Len=20, Skirt_Len=30); // 60mm long

translate([0,0,-45])
rotate([180,0,0])
ST_UpperCenteringRing(Tube_OD=PML98Body_OD, Skirt_ID=PML98Body_ID, InnerTube_OD=BT54Mtr_OD, StageCable_a=180);
} /**/


module BoosterPetalHub(){
	difference(){
		PD_PetalHub(OD=BT54Coupler_OD, 
					nPetals=2, 
					HasBolts=false,
					ShockCord_a=90,
					HasNCSkirt=false, 
						Body_OD=BT54Body_OD,
						Body_ID=BT54Body_ID,
						NC_Base=NC_Base, 
						SkirtLen=10);
						
		// Vent hole
		translate([14,0,-Overlap]) cylinder(d=12,h=30);
	} // difference
	
	translate([0,0,-15]) 
	difference(){
		ST_TubeLock(Tube_OD=BT54Coupler_OD, Skirt_ID=BT54Coupler_ID-2, SkirtLen=15); // Glued to top of spring.
		
		translate([0,0,15+Overlap]) cylinder(d=BT54Coupler_OD+1, h=20);
	} // difference
} // BoosterPetalHub

// BoosterPetalHub();

module BoosterUpperFinCan(){
	// Upper Half of Fin Can
	
	CablePuller_Z=-R9832Booster_Fin_Root_L/2+37;
	
	difference(){
		rotate([180,0,0]) 
			FinCan(Tube_OD=Body_OD, Tube_ID=Body_ID, 
				MtrTube_OD=R9832_BoosterMtrTube_OD+IDXtra*2, nFins=nFins,
				Post_h=R9832Booster_Fin_Post_h, Root_L=R9832Booster_Fin_Root_L, 
				Root_W=R9832Booster_Fin_Root_W, 
				Chamfer_L=R9832Booster_Fin_Chamfer_L, HasTailCone=false,
				Xtra_Len=11); 
		
		// Cable Pullers
		translate([0,0,CablePuller_Z]) rotate([0,0,90-180/nFins]) 
			CP_BayFrameHole(Tube_OD=Body_OD);
		translate([0,0,CablePuller_Z]) rotate([0,0,90-180/nFins+360/nFins]) 
			CP_BayFrameHole(Tube_OD=Body_OD);
		
		// Altimeter
		translate([0,0,CablePuller_Z]) rotate([0,0,90-180/nFins+360/nFins*2]) 
		  Alt_BayFrameHole(Tube_OD=Body_OD);

	} // difference
	
	// Cable Pullers
	translate([0,0,CablePuller_Z]) rotate([0,0,90-180/nFins]) 
		CP_BayDoorFrame(Tube_OD=Body_OD, ShowDoor=false);
	translate([0,0,CablePuller_Z]) rotate([0,0,90-180/nFins+360/nFins]) 
		CP_BayDoorFrame(Tube_OD=Body_OD, ShowDoor=false);
	
	// Altimeter
	translate([0,0,CablePuller_Z]) rotate([0,0,90-180/nFins+360/nFins*2])
		Alt_BayDoorFrame(Tube_OD=Body_OD, Tube_ID=Body_ID, ShowDoor=false);
	
	// Battery holder for altimeter
	//SingleBatteryPocket();

} // BoosterUpperFinCan

//BoosterUpperFinCan();


module Rocket9832BoosterFin(){
	TrapFin2(Post_h=R9832Booster_Fin_Post_h, Root_L=R9832Booster_Fin_Root_L, Tip_L=R9832Booster_Fin_Tip_L, 
			Root_W=R9832Booster_Fin_Root_W, Tip_W=R9832Booster_Fin_Tip_W, 
			Span=R9832Booster_Fin_Span, Chamfer_L=R9832Booster_Fin_Chamfer_L,
					TipOffset=R9832Booster_Fin_TipOffset);

	if ($preview==false){
		translate([-R9832Booster_Fin_Root_L/2+10,0,0]) cylinder(d=R9832Booster_Fin_Root_W*2.5, h=0.9); // Neg
		translate([R9832Booster_Fin_Root_L/2-10,0,0]) cylinder(d=R9832Booster_Fin_Root_W*2.5, h=0.9); // Pos
	}
} // Rocket9832BoosterFin

// Rocket9832BoosterFin();


module BoosterLowerFinCan(){
	// Upper Half of Fin Can
	BattDoor_Z=128;
	BattSwDoor_Z=115;
	
	RailGuide_Z=65;
	
	difference(){
		
		FinCan(Tube_OD=Body_OD, Tube_ID=Body_ID, 
			MtrTube_OD=R9832_BoosterMtrTube_OD+IDXtra*2, nFins=nFins,
			Post_h=R9832Booster_Fin_Post_h, Root_L=R9832Booster_Fin_Root_L, 
			Root_W=R9832Booster_Fin_Root_W, 
			Chamfer_L=R9832Booster_Fin_Chamfer_L, HasTailCone=true,
					MtrRetainer_OD=63,
					MtrRetainer_L=14,
					MtrRetainer_Inset=7); 
		
		// Wire Paths
		for (j=[0:nFins-1]) rotate([0,0,360/nFins*j])
			translate([R9832_BoosterMtrTube_OD/2+5,0,R9832Booster_Fin_Root_L/2])
				rotate([90,0,0]) cylinder(d=7, h=22, center=true);
		
		translate([0,0,BattDoor_Z]) rotate([0,0,90-180/nFins]) 
			Batt_BayFrameHole(Tube_OD=Body_OD, HasSwitch=false);
		
		translate([0,0,BattSwDoor_Z]) rotate([0,0,90-180/nFins+360/nFins]) 
			Batt_BayFrameHole(Tube_OD=Body_OD, HasSwitch=true);
		translate([0,0,BattSwDoor_Z]) rotate([0,0,90-180/nFins+360/nFins*2]) 
			Batt_BayFrameHole(Tube_OD=Body_OD, HasSwitch=true);
		
		translate([0,0,RailGuide_Z]) rotate([0,0,-90-180/nFins]) 
			translate([0,Body_OD/2+2,0]) RailGuideBoltPattern(BoltSpace=12.7) Bolt6Hole();
	} // difference
	
	
	translate([0,0,BattDoor_Z]) rotate([0,0,90-180/nFins]) 
		Batt_BayDoorFrame(Tube_OD=PML98Body_OD, HasSwitch=false, ShowDoor=false);
	
	translate([0,0,BattSwDoor_Z]) rotate([0,0,90-180/nFins+360/nFins]) 
		Batt_BayDoorFrame(Tube_OD=PML98Body_OD, HasSwitch=true, ShowDoor=true);
	translate([0,0,BattSwDoor_Z]) rotate([0,0,90-180/nFins+360/nFins*2]) 
		Batt_BayDoorFrame(Tube_OD=PML98Body_OD, HasSwitch=true, ShowDoor=false);
	
	//*
	// Rail Guide
	difference(){
		translate([0,0,RailGuide_Z]) rotate([0,0,-90-180/nFins]) 
			RailGuidePost(OD=Body_OD, MtrTube_OD=R9832_BoosterMtrTube_OD+IDXtra*2, 
				H=Body_OD/2+2, TubeLen=40, Length = 30, BoltSpace=12.7);
		
		translate([0,0,RailGuide_Z]) TrapFin2Slots(Tube_OD=Body_OD, nFins=nFins, 	
			Post_h=R9832Booster_Fin_Post_h, Root_L=R9832Booster_Fin_Root_L, 
			Root_W=R9832Booster_Fin_Root_W, Chamfer_L=R9832_Fin_Chamfer_L);
		
		translate([0,0,BattSwDoor_Z]) rotate([0,0,90-180/nFins+360/nFins]) 
			Batt_BayFrameHole(Tube_OD=Body_OD, HasSwitch=true);
		translate([0,0,BattSwDoor_Z]) rotate([0,0,90-180/nFins+360/nFins*2]) 
			Batt_BayFrameHole(Tube_OD=Body_OD, HasSwitch=true);
	} // difference
	/**/
} // BoosterUpperFinCan

//BoosterLowerFinCan();

//Batt_Door(Tube_OD=PML98Body_OD, HasSwitch=false);


































