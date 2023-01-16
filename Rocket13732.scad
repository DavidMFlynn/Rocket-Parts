// ***********************************
// Project: 3D Printed Rocket
// Filename: Rocket13732.scad
// by David M. Flynn
// Created: 10/20/2022
// Revision: 0.9.1  1/1/2023
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  137mm (5.5 inch) Body 3 Fins 2 Stages
//  Two Stage Rocket.
//
//  Warning! This is a complex rocket, skill level 11!
//  The only pyrotecnics used in this rocket are the motors.
//  Maximum motors J800T-P + 3x I284W
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
//   Stager Posts 0°, 120° and 240°
//   Rail Guide 330°
//   Wire connection (Booster attached, Sustainer igniter) 60°
// Upper Fin Can
//   Wires (note: rotated 60°) 60°
//	 Fins 30°, 150•, 270°
// Lower Fin Can
//   Wires 60°
//   Rail Guide 330°
//   Fins 30°, 150•, 270°
//
// Stager
//  Stager Posts 0°, 120° and 240°
//  Cable 350°
// SpringThing2
//  Cable 180°
//  Stager Cable 0°
// Booster Electronics Bay
//  Cable Puller (Stager) 0°
//  Cable Puller (Spring thing) 180°
//  Altimeter 120°
//  Altimeter Battery 242°
//  Cable Puller Battery w/ Switch 60°
//  Cable Puller Battery w/ Switch 120°
// Booster Upper Fin Can
//  Fins 30°, 150•, 270°
// Booster Lower Fin Can
//  Fins 30°, 150•, 270°
//  Rail Guide 330°
//
//  ***** History *****
//
// 0.9.1  1/1/2023    Fix booster e-bay, worked on sustainer
// 0.9.0  11/20/2022  First code. Copied from Rocket9832
//
// ***********************************
//  ***** for STL output *****
//
/*
FairingConeOGive(Fairing_OD=Body_OD,
					FairingWall_T=FairingWall_T,
					NC_Base=NC_Base,
					NC_Len=NC_Len,
					NC_Wall_t=NC_Wall_t,
					NC_Tip_r=NC_Tip_r,
					Cut_Z=190, LowerPortion=true);
/**/
// rotate([0,180,0]) NoseLockRing(Fairing_OD=Body_OD, Fairing_ID =Fairing_ID); // Brim+Support
//
//
// *** Fairing ***
/*
LargeFairing(IsLeftHalf=true, 
				Fairing_OD=Fairing_OD,
				Wall_T=7,
				Len=80); // test Fairing_Len
/**/
//
/*
LargeFairing(IsLeftHalf=false, 
				Fairing_OD=Fairing_OD,
				Wall_T=7,
				Len=80); // test Fairing_Len
/**/
//
/*
// old style
F54_FairingHalf(IsLeftHalf=true,
				Fairing_OD=Fairing_OD,
				Wall_T=FairingWall_T,
				Len=Fairing_Len);
/**/
/*
F54_FairingHalf(IsLeftHalf=false,
				Fairing_OD=Fairing_OD,
				Wall_T=FairingWall_T,
				Len=Fairing_Len);
/**/
//
// F54_SpringEndCap();
//
// *** Electronics Bay ***
// R137_Electronics_Bay();
// FairingBaseBulkPlate(Tube_ID=Body_ID, Fairing_ID=Fairing_ID, ShockCord_a=-1);
// rotate([0,180,0]) AltDoor54(Tube_OD=Body_OD, IsLoProfile=true, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y);
// rotate([0,180,0]) AltDoor54(Tube_OD=Body_OD, IsLoProfile=true, DoorXtra_X=0, DoorXtra_Y=0); // old
// rotate([0,180,0]) CP_Door(Tube_OD=Body_OD);
// Batt_Door(Tube_OD=Body_OD, HasSwitch=false);
// Batt_Door6xAAA(Tube_OD=BT137Body_OD, InnerTube_OD=BT54Body_OD, HasSwitch=true);
//
// ------------
// *** Cable Puller, 5 Req. ***
// rotate([0,180,0]) CP_Door(Tube_OD=Body_OD, HasArmingSlot=true);
// ThroughOut();
// rotate([0,90,0]) SpringBody();
// CableRetainer();
// StopAdjuster();
// CageBottom();
/*
	translate([0,0,CP_SpringBody_YZ/2+2.5]) rotate([180,0,0]){
		CageTop();
		BellCrankTriggerBearingHolder();}
/**/
// rotate([180,0,0]) TriggerBellCrank();
// ------------
//
//
//  *** SpringThing parts for dual deploy ***
// ST_TubeEnd(Tube_OD=DualDepCouplerTube_OD, Tube_ID=DualDepCouplerTube_ID);
// ST_SpringGuide(InnerTube_ID=EBayTube_ID);
// ST_SpringMiddle(Tube_ID=EBayTube_ID);
// ST_TubeLock(Tube_OD=DualDepCouplerTube_OD, Tube_ID=DualDepCouplerTube_ID-2, SkirtLen=30);
// ST_Frame(Tube_OD=Body_OD, Skirt_ID=Body_ID, Collar_Len=26, Skirt_Len=34, HasStagerCableRaceway=true, HasWireRaceway=true);
// ST_CableRedirectTop(Tube_OD=Body_OD, Skirt_ID=Body_ID, InnerTube_OD=DualDepTube_OD);
// ST_CableRedirect(Tube_OD=Body_OD, Skirt_ID=Body_ID, Tube_ID=Coupler_ID, InnerTube_OD=EBayTube_OD, InnerTube2_OD=DualDepTube_OD);
// ST_BallKeeper(InnerTube_OD=DualDepTube_OD);
// ST_BallSpacer(Tube_OD=Body_OD);
// rotate([180,0,0]) ST_LockBallRetainer(Tube_OD=Body_OD, InnerTube_OD=DualDepTube_OD);
// ST_LockRing(Tube_OD=Body_OD, InnerTube_OD=DualDepTube_OD);
// ST_DetentOnly(Tube_OD=Body_OD);
// ST_CableEndAndStop(Tube_OD=Body_OD);
// ST_UpperCenteringRing(Tube_OD=Body_OD, Skirt_ID=Body_ID, InnerTube_OD=DualDepTube_OD);
//
// ST_MT_DrillingJig(Tube_OD=Body_OD, Skirt_ID=Body_ID, InnerTube_OD=DualDepTube_OD, Skirt_Len=34);
//
//  *** Stager parts for dual deploy ***
//
// Stager_CableRedirectTop(Tube_OD=Body_OD, Skirt_ID=Body_ID, InnerTube_OD=DualDepTube_OD, HasRaceway=true, Raceway_a=300);
// Stager_CableRedirect(Tube_OD=Body_OD, Skirt_ID=Body_ID, Tube_ID=Body_ID, InnerTube_OD=DualDepTube_OD, HasRaceway=true, Raceway_a=300);

// Stager_Detent(Tube_OD=Body_OD);
// Stager_CableEndAndStop(Tube_OD=Body_OD);
// rotate([0,180,0]) DrogueSep();
// Stager_BallSpacer(Tube_OD=Body_OD);
// Stager_InnerRace(Tube_OD=Body_OD);
// Stager_LockRing(Tube_OD=Body_OD, nLocks=3, FlexComp_d=0.8);
// Stager_SaucerEConnHolder(Tube_OD=Body_OD);
// Stager_Saucer(Tube_OD=Body_OD, nLocks=3, HasElectrical=true);
//
// ------------
//
// rotate([-90,0,0]) Stager_LockRod(Adj=-0.5); // Print 6
// Drogue_Cup();
//
// UpperFinCan();
// Rocket_Fin();
// rotate([180,0,0]) LowerFinCan();
// rotate([180,0,0]) Stager_Cup(Tube_OD=Body_OD, ID=Body_OD-28, nLocks=3, BoltsOn=true);
//
// ================================================================================================
//  ***** Booster Parts *****
//
// --------------
//  ** Stager Parts, top of booster **
//
// Stager_Saucer(Tube_OD=Body_OD, nLocks=3, HasElectrical=false);
// Stager_SaucerEConnHolder(Tube_OD=Body_OD);
//
// Stager_Mech(Tube_OD=Body_OD, nLocks=3, Skirt_ID=Body_ID, Skirt_Len=30, KeyOffset_a=0, HasRaceway=false, Raceway_a=300);
// Stager_LockRing(Tube_OD=Body_OD, nLocks=3, FlexComp_d=0.8);
// Stager_InnerRace(Tube_OD=Body_OD);
// Stager_BallSpacer(Tube_OD=Body_OD); // print 2
// Stager_CableRedirectTop(Tube_OD=Body_OD, Skirt_ID=Body_ID, InnerTube_OD=DualDepTube_OD, HasRaceway=false, Raceway_a=300);
// Stager_CableRedirect(Tube_OD=Body_OD, Skirt_ID=Body_ID, Tube_ID=Body_ID, InnerTube_OD=DualDepTube_OD, HasRaceway=false, Raceway_a=300);
// Stager_CableEndAndStop(Tube_OD=Body_OD);
// Stager_Detent(Tube_OD=Body_OD);
//
// -------------
//
//  ** Spring Thing Parts **
//  ** See above for common parts:
//  ** ST_TubeEnd, ST_TubeLock, ST_BallSpacer, ST_BallKeeper, ST_LockRing, ST_DetentOnly,
//  ** ST_CableEndAndStop, ST_LockBallRetainer, ST_UpperCenteringRing, ST_MT_DrillingJig,
//  ** ST_CableRedirectTop, ST_Frame
//
// ST_SpringGuide(InnerTube_ID=BoosterMtrTube_ID); // Sits on top of motor, glued to bottom of spring.
// ST_SpringMiddle(Tube_ID=BoosterMtrTube_ID); // optional double spring slider
// ST_CableRedirect(Tube_OD=Body_OD, Skirt_ID=Body_ID, Tube_ID=Coupler_ID, InnerTube_OD=BoosterMtrTube_OD, InnerTube2_OD=DualDepTube_OD);
// ST_Frame(Tube_OD=Body_OD, Skirt_ID=Body_ID, Collar_Len=26, Skirt_Len=34, HasStagerCableRaceway=true, HasWireRaceway=false);
//
// -------------
//
// Booster_Electronics_Bay(ShowDoors=false);
// rotate([0,180,0]) Batt_Door(Tube_OD=Body_OD, HasSwitch=false);
// rotate([0,180,0]) Batt_Door(Tube_OD=Body_OD, HasSwitch=true);
// rotate([0,180,0]) AltDoor54(Tube_OD=Body_OD, IsLoProfile=false, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y);
// rotate([0,180,0]) CP_Door(Tube_OD=Body_OD, BoltBossInset=3, HasArmingSlot=true);
//
// BoosterUpperFinCan();
// Rocket_BoosterFin();
// rotate([180,0,0]) BoosterLowerFinCan();
//
// *** The Rail Guides ***
// rotate([90,0,0]) BoltOnRailGuide(Length = 35, BoltSpace=12.7, RoundEnds=true); // Drogue Cup
// rotate([90,0,0]) BoltOnRailGuide(Length = 40, BoltSpace=12.7, RoundEnds=true); // lower fin can
// rotate([90,0,0]) BoltOnRailGuide(Length = 30, BoltSpace=12.7, RoundEnds=true); // booster lower fin can
//
// ***********************************
//  ***** Routines *****
//
// RocketStand(); // Adaptor to use 1-1/2" PVC pipe and a 2.5kg spool as a stand.
//
// ***********************************
//  ***** for Viewing *****
//
// ShowBooster();
// ShowRocket();
// ShowUpperBays();
//
// ***********************************
use<Fairing54.scad>
use<FinCan.scad>
use<Stager2Lib.scad>
include<AltBay.scad>
use<CablePuller.scad>
use<BatteryHolderLib.scad>
use<SpringThing2.scad>
use<RacewayLib.scad>

//also included
 //include<NoseCone.scad>
 //include<ChargeHolder.scad>
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

nFins=3; // can be 3, 4 or 5

// Sustainer Fin
S_Fin_Post_h=12;
S_Fin_Root_L=300;
S_Fin_Root_W=12;
S_Fin_Tip_W=5;
S_Fin_Tip_L=100;
S_Fin_Span=180;
S_Fin_TipOffset=50;
S_Fin_Chamfer_L=30;

// Booster Fin
Booster_Fin_Post_h=14;
Booster_Fin_Root_L=400;
Booster_Fin_Root_W=18;
Booster_Fin_Tip_W=5;
Booster_Fin_Tip_L=140;
Booster_Fin_Span=240;
Booster_Fin_TipOffset=75;
Booster_Fin_Chamfer_L=42;

Body_OD=BT137Body_OD;
Body_ID=BT137Body_ID;
Coupler_ID=BT137Coupler_ID;
MtrTube_OD=BT54Body_OD;
MtrTube_ID=BT54Body_ID;
EBayTube_OD=BT54Body_OD;
EBayTube_ID=BT54Body_ID;
BoosterMtrTube_OD=BT54Body_OD;
BoosterMtrTube_ID=BT54Body_ID;
BoosterClusterMtrTube_OD=PML38Body_OD;
DualDepTube_OD=BT75Body_OD;
DualDepTube_ID=BT75Body_ID;
DualDepCouplerTube_OD=BT75Coupler_OD;
DualDepCouplerTube_ID=BT75Coupler_ID;

EBay_Len=162;
TailCone_Len=60;
BoosterFinCanLength=Booster_Fin_Root_L/2+10+TailCone_Len;
SustainerFinCanLength=S_Fin_Root_L/2+10+TailCone_Len;
Motor_Gap=10;
Cant_a=1.80;
Booster_Body_Len=BoosterFinCanLength*2+EBay_Len+67+300;
//echo(Booster_Body_Len=Booster_Body_Len);

// Fairing Overrides
Fairing_OD=BT137Body_OD;
FairingWall_T=2.2; // << needs more, truss wall?
Fairing_ID=Fairing_OD-FairingWall_T*2;
Fairing_Len=180; // Body of the fairing.

NoseconeSep_Z=0; // This much of the nosecone becomes part of the fairing.
NC_Len=380;//500;
NC_Tip_r=8;
NC_Wall_t=3;
NC_Base=5;
NC_Lock_H=5;

Alt_DoorXtra_X=2;
Alt_DoorXtra_Y=2;
RailGuide_H=88;
RailGuide_a=90-360/nFins;
Wire_a=60;

module RocketStand(){
	// Adaptor to use 1-1/2" PVC pipe and a 2.5kg spool as a stand.
	Spool_ID=52.7;
	H=75;
	Pipe_OD=48.3;

	difference(){
		union(){
			cylinder(d=Spool_ID+8, h=3);
			cylinder(d1=Spool_ID, d2=Spool_ID-0.5, h=H+3);
		} // union

		translate([0,0,-Overlap]) cylinder(d=Pipe_OD+IDXtra*3, h=H+Overlap*2);
		translate([0,0,H]) cylinder(d1=Pipe_OD+IDXtra*2, d2=Pipe_OD-2, h=3+Overlap);
	} // difference

} // RocketStand

//RocketStand();

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

module ShowBooster(){

	//*
	translate([0,0,Booster_Body_Len]){
		color("Blue") Stager_Saucer(Tube_OD=Body_OD, nLocks=3);
		Stager_Mech(Tube_OD=Body_OD, nLocks=3, Skirt_ID=Body_ID, Skirt_Len=30, KeyOffset_a=0, HasRaceway=false, Raceway_a=300);
	}

	translate([0,0,BoosterFinCanLength*2+EBay_Len+70])
	color("Orange") Tube(OD=Body_OD, ID=Body_ID,
			Len=210, myfn=$preview? 36:360);

	translate([0,0,BoosterFinCanLength*2+EBay_Len])
	color("LightBlue") Tube(OD=DualDepTube_OD, ID=DualDepTube_ID,
			Len=330, myfn=$preview? 36:360);

	color("LightBlue") Tube(OD=BoosterMtrTube_OD, ID=BoosterMtrTube_ID,
			Len=BoosterFinCanLength*2+EBay_Len, myfn=$preview? 36:360);


	translate([0,0,BoosterFinCanLength*2+EBay_Len+34]) rotate([0,0,180])
		ST_Frame(Tube_OD=Body_OD, Skirt_ID=Body_ID, Collar_Len=26, Skirt_Len=34, HasStagerCableRaceway=true, HasWireRaceway=false);
		

	translate([0,0,BoosterFinCanLength*2]) color("Green") Booster_Electronics_Bay(ShowDoors=true);
	/**/
	translate([0,0,BoosterFinCanLength]) BoosterUpperFinCan();


	//*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j])
		translate([Body_OD/2-S_Fin_Post_h, 0, BoosterFinCanLength])
			rotate([0,90,0]) color("Orange") Rocket_BoosterFin();
	/**/

	BoosterLowerFinCan();

	//translate([0,0,-40]) ShowMotorJ460T();
	translate([0,0,-20]) ShowMotorJ800T();
} // ShowBooster

//ShowBooster();

FinCanExTube_Len=150;
FC_Inset=-14;
TopOfFinCan_Z=Booster_Body_Len+FC_Inset+SustainerFinCanLength*2+FinCanExTube_Len+70;

module ShowSustainerFinCan(){
	
	translate([0,0,TopOfFinCan_Z]) Drogue_Cup(); // 70mm
	translate([0,0,TopOfFinCan_Z-70]) rotate([180,0,0])
		color("LightBlue") Tube(OD=Body_OD, ID=Body_ID, Len=FinCanExTube_Len, myfn=$preview? 36:90);

	translate([0,0,Booster_Body_Len+FC_Inset])
	color("Blue") Tube(OD=MtrTube_OD, ID=MtrTube_ID, Len=24*25.4, myfn=$preview? 36:90);
	
	translate([0,0,Booster_Body_Len+SustainerFinCanLength+FC_Inset]) color("Tan") UpperFinCan();
	
	//*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j])
		translate([Body_OD/2-S_Fin_Post_h, 0, Booster_Body_Len+SustainerFinCanLength+FC_Inset])
			rotate([0,90,0]) color("Orange") Rocket_Fin();
	/**/

	//*
	translate([0,0,Booster_Body_Len]) {
		translate([0,0,FC_Inset]) LowerFinCan();
		color("Tan") 
			Stager_Cup(Tube_OD=Body_OD, ID=Body_OD-28, nLocks=3, BoltsOn=true);
	}
	/**/

	translate([0,0,Booster_Body_Len-15]) ShowMotorK185W();



} // ShowSustainerFinCan

// ShowSustainerFinCan();

module ShowMidSection(){
	DrogueBay_L=200;
	DrogueTube_Z=TopOfFinCan_Z+87;
	SpringThing_Z=DrogueTube_Z+DrogueBay_L+36;
	EBay_Z=SpringThing_Z+34;
	Fairing_Z=EBay_Z+EBay_Len;
	Nose_Z=Fairing_Z+Fairing_Len+2;
	
	translate([0,0,Nose_Z]) FairingConeOGive(Fairing_OD=Body_OD,
					FairingWall_T=FairingWall_T,
					NC_Base=NC_Base,
					NC_Len=NC_Len,
					NC_Wall_t=NC_Wall_t,
					NC_Tip_r=NC_Tip_r,
					Cut_Z=0, LowerPortion=true);
	
	translate([0,0,Fairing_Z]) color("LightGreen")
		F54_FairingHalf(IsLeftHalf=true,
				Fairing_OD=Fairing_OD,
				Wall_T=FairingWall_T,
				Len=Fairing_Len);
				
	translate([0,0,EBay_Z]) color("LightBlue") R98_Electronics_Bay2();
	
	translate([0,0,TopOfFinCan_Z]){
		rotate([0,180,0]) color("Blue") Stager_Saucer(Tube_OD=Body_OD, nLocks=3, HasElectrical=true);
		DrogueSep();
		}
	translate([0,0,DrogueTube_Z]) color("Orange")
		Tube(OD=Body_OD, ID=Body_ID, Len=DrogueBay_L, myfn=$preview? 36:90);
		
	translate([0,0,SpringThing_Z])
	rotate([180,0,0]) ST_Frame(Tube_OD=Body_OD, Skirt_ID=Body_ID, Collar_Len=26, Skirt_Len=34, HasStagerCableRaceway=true, HasWireRaceway=true);
} // ShowMidSection

//ShowMidSection();
	
module ShowRocket(){
	ShowMidSection();
	ShowSustainerFinCan();
	ShowBooster();
} // ShowRocket

//ShowRocket();


module R137_Electronics_Bay(){
	Len=EBay_Len;
	CablePuller_Z=81;
	CableInset_Y=15;
	BattSwDoor_Z=70;
	TopSkirt_Len=15;
	BottomSkirt_Len=15;
	CP1_a=0; // SpringThing
	CP2_a=180; // Stager
	CP3_a=60; // Fairing
	Alt_a=300;
	Batt1_a=240; // Altimeter Battery
	Batt2_a=120; // Cable puller battery and switch

	// The Fairing clamps onto this.
	translate([0,0,Len]) FairingBaseLockRing(Tube_OD=Body_OD, Tube_ID=Body_ID, Fairing_ID=Fairing_ID, Interface=Overlap, BlendToTube=true);

	difference(){
		union(){
			Tube(OD=Body_OD, ID=Body_ID, Len=Len, myfn=$preview? 36:360);

			translate([0,0,BottomSkirt_Len])
				CenteringRing(OD=Body_OD-1, ID=EBayTube_OD+IDXtra*2, Thickness=5, nHoles=4);

			translate([0,0,Len-5-TopSkirt_Len])
				CenteringRing(OD=Body_OD-1, ID=EBayTube_OD+IDXtra*2, Thickness=5, nHoles=4);
		} // union

		// Altimeter
		translate([0,0,CablePuller_Z]) rotate([0,0,180+Alt_a])
			Alt_BayFrameHole(Tube_OD=Body_OD, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y);

		// Cable Puller door hole
		translate([0,0,CablePuller_Z]) rotate([0,0,180+CP1_a])
			CP_BayFrameHole(Tube_OD=Body_OD);
		// Cable Puller door hole
		translate([0,0,CablePuller_Z]) rotate([0,0,180+CP2_a])
			CP_BayFrameHole(Tube_OD=Body_OD);
		// Cable Puller door hole
		translate([0,0,CablePuller_Z]) rotate([0,0,180+CP3_a])
			CP_BayFrameHole(Tube_OD=Body_OD);

		// Cable Puller cable holes
		rotate([0,0,CP1_a]) translate([0,Body_OD/2-CableInset_Y,0]) cylinder(d=6, h=50);
		rotate([0,0,CP2_a]) translate([0,Body_OD/2-CableInset_Y,0]) cylinder(d=6, h=50);
		rotate([0,0,CP3_a]) translate([0,Body_OD/2-CableInset_Y,Len-50]) cylinder(d=6, h=50);
		
		// Battery and Switch door holes
		translate([0,0,BattSwDoor_Z]) rotate([0,0,180+Batt1_a])
			Batt_BayFrameHole(Tube_OD=Body_OD, HasSwitch=false);
		translate([0,0,BattSwDoor_Z]) rotate([0,0,180+Batt2_a])
			Batt_BayFrameHole(Tube_OD=Body_OD, HasSwitch=true);

	} // difference

	// Altimeter
	translate([0,0,CablePuller_Z]) rotate([0,0,180+Alt_a])
		Alt_BayDoorFrame(Tube_OD=Body_OD, Tube_ID=Body_ID, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowDoor=false);

	// Cable Pullers
	translate([0,0,CablePuller_Z]) rotate([0,0,180+CP1_a])
		CP_BayDoorFrame(Tube_OD=Body_OD, Tube_ID=Body_ID, ShowDoor=false);
	translate([0,0,CablePuller_Z]) rotate([0,0,180+CP2_a])
		CP_BayDoorFrame(Tube_OD=Body_OD, Tube_ID=Body_ID, ShowDoor=false);
	translate([0,0,CablePuller_Z]) rotate([0,0,180+CP3_a])
		CP_BayDoorFrame(Tube_OD=Body_OD, Tube_ID=Body_ID, ShowDoor=false);

	// Battery and Switch door2
	translate([0,0,BattSwDoor_Z]) rotate([0,0,180+Batt1_a])
		Batt_BayDoorFrame(Tube_OD=Body_OD, Tube_ID=Body_ID, HasSwitch=false, ShowDoor=false);
	translate([0,0,BattSwDoor_Z]) rotate([0,0,180+Batt2_a])
		Batt_BayDoorFrame(Tube_OD=Body_OD, Tube_ID=Body_ID, HasSwitch=true, ShowDoor=false);

} // R137_Electronics_Bay

//translate([0,0,EBay_Len]) R137_Electronics_Bay();


module DrogueSep(){

	rotate([0,180,0])
		Stager_Mech(Tube_OD=Body_OD, nLocks=3, Skirt_ID=Body_ID,
			Skirt_Len=30, KeyOffset_a=0, HasRaceway=true, Raceway_a=300);

} // DrogueSep

//DrogueSep();

//translate([0,0,-170]) rotate([180,0,180])
//CableRedirect(Tube_OD=Body_OD, Skirt_ID=Body_ID, Tube_ID=PML98Coupler_ID, InnerTube_OD=BT54Mtr_OD);

//
//translate([0,0,-320]) color("Orange") DrogueSep();


module Drogue_Cup(){
	WireHole_d=5.5;
	RailGuide_Z=-40;
	RG_Len=35;
	Rivet_Z=-40;

	difference(){
		union(){
			rotate([0,180,0]) 
				Stager_Cup(Tube_OD=Body_OD, ID=Body_OD-28, nLocks=3, 
							BoltsOn=false, Collar_h=18, HasElectrical=true);
			// Skirt
			translate([0,0,-70]) Tube(OD=Body_OD, ID=Body_ID, Len=60, myfn=$preview? 36:360);
		} // union
			
		// Rivet holes
		for (j=[0:2]) rotate([0,0,120*j]) translate([0,Body_OD/2+1,Rivet_Z])
			rotate([90,0,0]) cylinder(d=4, h=5);
	} // difference

	
	//*
	difference(){
		// Rail Guide
		translate([0,0,RailGuide_Z]) rotate([0,0,RailGuide_a])
			RailGuidePost(OD=Body_OD, MtrTube_OD=MtrTube_OD+IDXtra*2, H=RailGuide_H,
				TubeLen=RG_Len+10, Length = RG_Len, BoltSpace=12.7);

		translate([0,0,-80]) cylinder(d=Body_OD-1, h=80);

		// Rivet holes
		for (j=[0:2]) rotate([0,0,120*j]) translate([0,Body_OD/2+1,Rivet_Z])
			rotate([90,0,0]) cylinder(d=4, h=5);
	} // difference

	/**/
	if ($preview) rotate([0,0,RailGuide_a])  translate([0,RailGuide_H,RailGuide_Z])
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
	CanLen=SustainerFinCanLength;

	difference(){
		union(){
			translate([0,0,CanLen-45]) rotate([0,0,180/nFins])
				CenteringRing(OD=Body_OD-1, ID=MtrTube_OD+IDXtra*2, Thickness=5, nHoles=3);

			rotate([0,0,180/nFins])
				CenteringRing(OD=Body_OD-1, ID=MtrTube_OD+IDXtra*2, Thickness=5, nHoles=3);

			Tube(OD=Body_OD, ID=Body_ID, Len=CanLen, myfn=$preview? 90:360);


			intersection(){
				cylinder(d=Body_ID+1, h=CanLen-44);

				for (j=[0:nFins]) hull(){
					cylinder(d=S_Fin_Root_W+4.4, h=CanLen-44);

					rotate([0,0,360/nFins*j]) translate([Body_OD/2,0,0])
						cylinder(d=S_Fin_Root_W+4.4, h=CanLen-44);
				} // hull
			} // intersection
		} // union

		// Center motor tube
		translate([0,0,-Overlap]) cylinder(d=BoosterMtrTube_OD+IDXtra*3, h=CanLen+Overlap*2);

		// Igniter wirs
		rotate([0,0,Wire_a]) translate([0,MtrTube_OD/2+8,-Overlap])
				cylinder(d=7, h=S_Fin_Root_L);
				
		TrapFin2Slots(Tube_OD=Body_OD, nFins=nFins,
				Post_h=S_Fin_Post_h, Root_L=S_Fin_Root_L,
				Root_W=S_Fin_Root_W, Chamfer_L=S_Fin_Chamfer_L);
	} // difference


} // UpperFinCan

//UpperFinCan();

module LowerFinCan(){
	RailGuide_Z=110;
	CanLen=SustainerFinCanLength;
	MtrRetainer_OD=MtrTube_OD+6;
	MtrRetainer_L=16;
	TailCone_Len=45;

	module MotorRetainer(OD=BoosterClusterMtrTube_OD+4, Len=33){
		difference(){
			cylinder(d=OD, h=Len);
			translate([0,0,-Overlap]) cylinder(d=OD-4, h=Len+Overlap*2);
		} // difference
	} // MotorRetainer

	difference(){
		union(){
			translate([0,0,CanLen-5]) rotate([0,0,180/nFins])
				CenteringRing(OD=Body_OD-1, ID=MtrTube_OD+IDXtra*2, Thickness=5, nHoles=3);


			translate([0,0,TailCone_Len]) rotate([0,0,180/nFins])
				CenteringRing(OD=Body_OD-1, ID=MtrTube_OD+IDXtra*2, Thickness=5, nHoles=3);

			translate([0,0,TailCone_Len])
				Tube(OD=Body_OD, ID=Body_ID, Len=CanLen-TailCone_Len, myfn=$preview? 90:360);

			// Fin Holders
			intersection(){
				cylinder(d=Body_ID+1, h=CanLen);

				for (j=[0:nFins]) hull() translate([0,0,CanLen-S_Fin_Root_L/2-10]) {
					cylinder(d=S_Fin_Root_W+4.4, h=S_Fin_Root_L/2+10);

					rotate([0,0,360/nFins*j]) translate([Body_OD/2,0,0])
						cylinder(d=S_Fin_Root_W+4.4, h=S_Fin_Root_L/2+10);
				} // hull
			} // intersection

			// Tailcone
			translate([0,0,TailCone_Len-10]) cylinder(d=Body_OD, h=10+Overlap, $fn=$preview? 90:360);
			//*
			hull(){
				cylinder(d=MtrRetainer_OD+4.4, h=Overlap);
				translate([0,0,TailCone_Len-32]) cylinder(d=Body_OD-44, h=32+Overlap);

			} // hull
			/**/
		} // union

		// Fin slots
		translate([0,0,CanLen])
			TrapFin2Slots(Tube_OD=Body_OD, nFins=nFins,
				Post_h=S_Fin_Post_h, Root_L=S_Fin_Root_L,
				Root_W=S_Fin_Root_W, Chamfer_L=S_Fin_Chamfer_L);

		// Center Motor Retainer
		translate([0,0,-Overlap]) cylinder(d=MtrRetainer_OD+IDXtra*2, h=MtrRetainer_L);

		// Motor tube
		translate([0,0,-Overlap]) cylinder(d=MtrTube_OD+IDXtra*2, h=CanLen+Overlap*2);

		// Igniter wirs
			rotate([0,0,Wire_a]) translate([0,MtrTube_OD/2+8,0])
				cylinder(d=7, h=S_Fin_Root_L);

		translate([0,0,RailGuide_Z]) rotate([0,0,RailGuide_a])
			translate([0,Body_OD/2+2,0]) RailGuideBoltPattern(BoltSpace=12.7) Bolt6Hole();

		// Booster attachment
		translate([0,0,TailCone_Len-28]) Stager_CupHoles(Tube_OD=Body_OD, ID=Body_OD-30, nLocks=3);
	} // difference


	//*
	// Rail Guide
	difference(){
		translate([0,0,RailGuide_Z]) rotate([0,0,RailGuide_a])
			//RailButtonPost(OD=R98_Body_OD, MtrTube_OD=R98_MtrTube_OD, H=R98_Body_OD/2+5, Len=30);
			RailGuidePost(OD=Body_OD, MtrTube_OD=MtrTube_OD+IDXtra*2, H=RailGuide_H, TubeLen=70, Length = 40, BoltSpace=12.7);

		translate([0,0,RailGuide_Z]) TrapFin2Slots(Tube_OD=Body_OD, nFins=nFins,
			Post_h=S_Fin_Post_h, Root_L=S_Fin_Root_L, Root_W=S_Fin_Root_W, Chamfer_L=S_Fin_Chamfer_L);
	} // difference
	/**/

	if ($preview)
		translate([0,0,-18]) color("Red") MotorRetainer(OD=MtrRetainer_OD, Len=33);
} // LowerFinCan

//LowerFinCan();


module Rocket_Fin(){
	TrapFin2(Post_h=S_Fin_Post_h, Root_L=S_Fin_Root_L, Tip_L=S_Fin_Tip_L,
			Root_W=S_Fin_Root_W, Tip_W=S_Fin_Tip_W,
			Span=S_Fin_Span, Chamfer_L=S_Fin_Chamfer_L,
					TipOffset=S_Fin_TipOffset);

	if ($preview==false){
		translate([-S_Fin_Root_L/2+10,0,0]) cylinder(d=S_Fin_Root_W*2.5, h=0.9); // Neg
		translate([S_Fin_Root_L/2-10,0,0]) cylinder(d=S_Fin_Root_W*2.5, h=0.9); // Pos
	}
} // Rocket_Fin

// Rocket_Fin();

// Spring thing
/*
translate([0,0,-10]){
translate([0,0,-10]) rotate([180,0,0]) ST_CableRedirect(Tube_OD=Body_OD, Skirt_ID=Body_ID,
							Tube_ID=PML98Coupler_ID,
							InnerTube_OD=BT54Mtr_OD, StageCable_a=180);
translate([0,0,-30]) rotate([180,0,50]) ST_Frame(Tube_OD=PML98Body_OD, Skirt_ID=PML98Body_ID, Collar_Len=20, Skirt_Len=30); // 60mm long

translate([0,0,-45])
rotate([180,0,0])
ST_UpperCenteringRing(Tube_OD=PML98Body_OD, Tube_ID=PML98Coupler_ID, Skirt_ID=PML98Body_ID, InnerTube_OD=BT54Mtr_OD, StageCable_a=180);
} /**/




module Booster_Electronics_Bay(ShowDoors=false){
	Len=EBay_Len;
	CablePuller_Z=81;
	BattSwDoor_Z=70;
	TopSkirt_Len=15;
	BottomSkirt_Len=15;
	CP1_a=0;
	CP2_a=180;
	Alt_a=120;
	Batt1_a=62; // Altimeter Battery
	Batt2_a=300; // Cable puller battery and switch
	Batt3_a=240;

	difference(){
		union(){
			Tube(OD=Body_OD, ID=Body_ID, Len=Len, myfn=$preview? 36:360);

			translate([0,0,BottomSkirt_Len])
				CenteringRing(OD=Body_OD-1, ID=BoosterMtrTube_OD+IDXtra*2, Thickness=5, nHoles=4);

			translate([0,0,Len-5-TopSkirt_Len])
				CenteringRing(OD=Body_OD-1, ID=BoosterMtrTube_OD+IDXtra*2, Thickness=5, nHoles=4);
		} // union

		// Altimeter
		translate([0,0,CablePuller_Z]) rotate([0,0,Alt_a])
			Alt_BayFrameHole(Tube_OD=Body_OD, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y);

		// Cable Puller door hole
		translate([0,0,CablePuller_Z]) rotate([0,0,CP1_a])
			CP_BayFrameHole(Tube_OD=Body_OD);
		translate([0,0,CablePuller_Z]) rotate([0,0,CP2_a])
			CP_BayFrameHole(Tube_OD=Body_OD);

		// Battery and Switch door holes
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a])
			Batt_BayFrameHole(Tube_OD=Body_OD, HasSwitch=false);
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt2_a])
			Batt_BayFrameHole(Tube_OD=Body_OD, HasSwitch=true);
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt3_a])
			Batt_BayFrameHole(Tube_OD=Body_OD, HasSwitch=true);

	} // difference

	//*
	// Altimeter
	translate([0,0,CablePuller_Z]) rotate([0,0,Alt_a])
		Alt_BayDoorFrame(Tube_OD=Body_OD, Tube_ID=Body_ID,
			DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowDoor=ShowDoors);
	/**/
	// Cable Pullers
	translate([0,0,CablePuller_Z]) rotate([0,0,CP1_a])
		CP_BayDoorFrame(Tube_OD=Body_OD, Tube_ID=Body_ID, ShowDoor=ShowDoors);
	translate([0,0,CablePuller_Z]) rotate([0,0,CP2_a])
		CP_BayDoorFrame(Tube_OD=Body_OD, Tube_ID=Body_ID, ShowDoor=ShowDoors);

	// Battery and Switch door2
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a])
		Batt_BayDoorFrame(Tube_OD=Body_OD, Tube_ID=Body_ID, HasSwitch=false, ShowDoor=ShowDoors);
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt2_a])
		Batt_BayDoorFrame(Tube_OD=Body_OD, Tube_ID=Body_ID, HasSwitch=true, ShowDoor=ShowDoors);
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt3_a])
		Batt_BayDoorFrame(Tube_OD=Body_OD, Tube_ID=Body_ID, HasSwitch=true, ShowDoor=ShowDoors);

} // Booster_Electronics_Bay

//translate([0,0,EBay_Len]) Booster_Electronics_Bay(ShowDoors=false);


FinRootSocket_W=6; // added to Root_w

module BoosterUpperFinCan(){
	// Upper Half of Fin Can
	CanLen=BoosterFinCanLength;

	echo(CanLen=CanLen);

	module ClusterMotorShroud(Len=CanLen+10){
		difference(){
			cylinder(d=BoosterClusterMtrTube_OD+12, h=Len);
			translate([0,0,-Overlap]) cylinder(d=BoosterClusterMtrTube_OD+IDXtra*2, h=Len+Overlap*2);
		} // difference

	} // ClusterMotorShroud

	module ClusterMotorPositions(){
		for (j=[0:nFins-1]) rotate([0,0,360/nFins*j+180/nFins])
			translate([BoosterMtrTube_OD/2+BoosterClusterMtrTube_OD/2+Motor_Gap,0,-CanLen])
				rotate([0,-Cant_a,0]) translate([0,0,CanLen-5]) children();
	} // ClusterMotorPositions

	difference(){
		union(){
			rotate([0,0,-90+180/nFins])
				ClusterRing(OD=Body_ID+1, Thickness=5,
					CenterMotor_OD=BoosterMtrTube_OD+IDXtra*2, ClusterMotor_OD=BoosterClusterMtrTube_OD+IDXtra*2,
					nClusterMotors=nFins,
					Gap=Motor_Gap, Cant_a=Cant_a, Cant_Z=CanLen);

			translate([0,0,Booster_Fin_Root_L/2+5]) rotate([0,0,180/nFins])
				CenteringRing(OD=Body_ID+1, ID=BoosterMtrTube_OD+IDXtra*2, Thickness=5, nHoles=3);


			Tube(OD=Body_OD, ID=Body_ID, Len=CanLen, myfn=$preview? 90:360);

			// Cluster shrouds
			difference(){
				ClusterMotorPositions() ClusterMotorShroud(Len=CanLen+2);

				// trim base
				translate([0,0,-10]) cylinder(d=Body_OD+30, h=10);
				// trim top
				translate([0,0,Booster_Fin_Root_L/2+9]) cylinder(d=Body_OD-1, h=100);
			} // difference

			// Fin socket structure
			intersection(){
				cylinder(d=Body_ID+1, h=CanLen);

				for (j=[0:nFins]) hull(){
					cylinder(d=Booster_Fin_Root_W+FinRootSocket_W, h=Booster_Fin_Root_L/2+10);

					rotate([0,0,360/nFins*j]) translate([Body_OD/2,0,0])
						cylinder(d=Booster_Fin_Root_W+FinRootSocket_W, h=Booster_Fin_Root_L/2+10);
				} // hull
			} // intersection
		} // union

		// Center motor tube
		translate([0,0,-Overlap]) cylinder(d=BoosterMtrTube_OD+IDXtra*3, h=CanLen+Overlap*2);

		// Cluster motor tubes
		ClusterMotorPositions()
			 cylinder(d=BoosterClusterMtrTube_OD+IDXtra*3, h=CanLen*2+10-60);

		// Fin slots
		TrapFin2Slots(Tube_OD=Body_OD, nFins=nFins,
			Post_h=Booster_Fin_Post_h, Root_L=Booster_Fin_Root_L,
			Root_W=Booster_Fin_Root_W, Chamfer_L=Booster_Fin_Chamfer_L);
	} // difference

} // BoosterUpperFinCan

//translate([0,0,BoosterFinCanLength+Overlap]) BoosterUpperFinCan();


module Rocket_BoosterFin(){
	TrapFin2(Post_h=Booster_Fin_Post_h, Root_L=Booster_Fin_Root_L, Tip_L=Booster_Fin_Tip_L,
			Root_W=Booster_Fin_Root_W, Tip_W=Booster_Fin_Tip_W,
			Span=Booster_Fin_Span, Chamfer_L=Booster_Fin_Chamfer_L,
					TipOffset=Booster_Fin_TipOffset);

	if ($preview==false){
		translate([-Booster_Fin_Root_L/2+10,0,0]) cylinder(d=Booster_Fin_Root_W*2.5, h=0.9); // Neg
		translate([Booster_Fin_Root_L/2-10,0,0]) cylinder(d=Booster_Fin_Root_W*2.5, h=0.9); // Pos
	}
} // Rocket_BoosterFin

// Rocket_BoosterFin();
/*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j])
		translate([Body_OD/2-Booster_Fin_Post_h, 0, BoosterFinCanLength])
			rotate([0,90,0]) color("Orange") Rocket_BoosterFin();
/**/

module BoosterLowerFinCan(Doubles=false){
	// Upper Half of Fin Can

	RailGuide_Z=80;
	CanLen=BoosterFinCanLength;
	MtrRetainer_OD=63;
	MtrRetainer_L=16;
	MtrRetainer_Inset=5;
	echo(CanLen=CanLen);

	module MotorRetainer(OD=BoosterClusterMtrTube_OD+4, Len=33){
		difference(){
			cylinder(d=OD, h=Len);
			translate([0,0,-Overlap]) cylinder(d=OD-4, h=Len+Overlap*2);
		} // difference
	} // MotorRetainer

	module ClusterMotorShroud(){
		difference(){
			cylinder(d=BoosterClusterMtrTube_OD+12, h=300);
			translate([0,0,-Overlap]) cylinder(d=BoosterClusterMtrTube_OD+IDXtra*2, h=300+Overlap*2);
		} // difference
	} // ClusterMotorShroud

	module ClusterMotorPositions(Doubles=false){
		Cluster_r=BoosterMtrTube_OD/2+BoosterClusterMtrTube_OD/2+Motor_Gap;
		Doubles_a=asin(25/Cluster_r); // ±25mm at Cluster_r

		for (j=[0:nFins-1]) {
			if (Doubles==false){ rotate([0,0,360/nFins*j+180/nFins])
				translate([Cluster_r,0,0])
				rotate([0,-Cant_a,0]) children();
			}else{
				rotate([0,0,360/nFins*j+180/nFins+Doubles_a])
				translate([Cluster_r,0,0])
				rotate([0,-Cant_a,0]) children();
			}
			if (Doubles)
				rotate([0,0,360/nFins*j+180/nFins-Doubles_a])
				translate([Cluster_r,0,0])
				rotate([0,-Cant_a,0]) children();
		}
	} // ClusterMotorPositions


	difference(){
		union(){
			translate([0,0,TailCone_Len]) rotate([0,0,-90+180/nFins])
				ClusterRing(OD=Body_ID+1, Thickness=5,
					CenterMotor_OD=BoosterMtrTube_OD+IDXtra*2,
					ClusterMotor_OD=BoosterClusterMtrTube_OD+IDXtra*2,
					nClusterMotors=nFins,
					Gap=Motor_Gap, Cant_a=Cant_a, Cant_Z=TailCone_Len);

			translate([0,0,CanLen-5]) rotate([0,0,-90+180/nFins])
				ClusterRing(OD=Body_ID+1, Thickness=5,
					CenterMotor_OD=BoosterMtrTube_OD+IDXtra*2,
					ClusterMotor_OD=BoosterClusterMtrTube_OD+IDXtra*2,
					nClusterMotors=nFins,
					Gap=Motor_Gap, Cant_a=Cant_a, Cant_Z=CanLen-5);

			translate([0,0,TailCone_Len])
				Tube(OD=Body_OD, ID=Body_ID, Len=CanLen-TailCone_Len, myfn=$preview? 90:360);

			difference(){
				ClusterMotorPositions(Doubles=Doubles) ClusterMotorShroud();

				//translate([0,0,-10]) cylinder(d=Body_ID+1, h=CanLen+20);
				translate([0,0,CanLen]) cylinder(d=Body_OD+30, h=100);
			} // difference

			// Fin Holders

			intersection(){
				cylinder(d=Body_ID+1, h=CanLen);

				for (j=[0:nFins]) hull() translate([0,0,CanLen-Booster_Fin_Root_L/2-10]) {
					cylinder(d=Booster_Fin_Root_W+FinRootSocket_W, h=Booster_Fin_Root_L/2+10);

					rotate([0,0,360/nFins*j]) translate([Body_OD/2,0,0])
						cylinder(d=Booster_Fin_Root_W+FinRootSocket_W, h=Booster_Fin_Root_L/2+10);
				} // hull
			} // intersection

			// Tailcone
			hull(){
				cylinder(d=MtrRetainer_OD+4.4, h=Overlap);

				translate([0,0,TailCone_Len]) rotate_extrude()
					translate([Body_OD/2-7.5,0,0]) circle(d=15);
			} // hull
		} // union

		// Center Motor Retainer
		translate([0,0,-Overlap]) cylinder(d=MtrRetainer_OD+IDXtra*2, h=MtrRetainer_L);

		ClusterMotorPositions(Doubles=Doubles)
			translate([0,0,-10]){
				// motor tube
				cylinder(d=BoosterClusterMtrTube_OD+IDXtra*3, h=CanLen+11);
				// Retainer
				cylinder(d=BoosterClusterMtrTube_OD+6, h=26);
			}

		// Motor tube
		translate([0,0,-Overlap]) cylinder(d=BoosterMtrTube_OD+IDXtra*2, h=CanLen+Overlap*2);

		translate([0,0,CanLen])
		TrapFin2Slots(Tube_OD=Body_OD, nFins=nFins,
				Post_h=Booster_Fin_Post_h, Root_L=Booster_Fin_Root_L,
				Root_W=Booster_Fin_Root_W, Chamfer_L=Booster_Fin_Chamfer_L);

		// Rail guide bolts
		rotate([0,0,RailGuide_a]) translate([0,86,RailGuide_Z])
			RailGuideBoltPattern(BoltSpace=12.7) Bolt6Hole();


	} // difference


//*
	// Rail Guide
	rotate([0,0,RailGuide_a]) translate([0,RailGuide_H-32,RailGuide_Z])
	RailGuidePost(OD=BoosterClusterMtrTube_OD+10, MtrTube_OD=BoosterClusterMtrTube_OD+4, H=32, TubeLen=40, Length = 30, BoltSpace=12.7);
/**/

	if ($preview) {
		ClusterMotorPositions(Doubles=Doubles){
			translate([0,0,-18]) color("Red")
			MotorRetainer(OD=BoosterClusterMtrTube_OD+4, Len=33);
			// motor
			//translate([0,0,-15]) cylinder(d=38, h=285); // I284W-P
		}

		translate([0,0,-18]) color("Red") MotorRetainer(OD=MtrRetainer_OD, Len=33);
	}
} // BoosterUpperFinCan

//BoosterLowerFinCan();

module SplitInThirds(Third=1){
	translate([0,0,BoosterFinCanLength]) BoosterUpperFinCan();
	BoosterLowerFinCan();
} // SplitInThirds

//SplitInThirds(Third=1);


































