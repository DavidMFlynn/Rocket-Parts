// ***********************************
// Project: 3D Printed Rocket
// Filename: Rocket98Dual.scad
// by David M. Flynn
// Created: 10/16/2022 
// Revision: 1.0.2  11/18/2022
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  Generic 98mm Body Dual Deploy bays and parts.
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
//
//  ***** History *****
// 1.0.2  11/18/2022  Moved FairingBaseLockRing in R98_Electronics_Bay2 up 0.5mm, was too tight
// 1.0.1  11/15/2022  Added parameters to R98_Electronics_Bay2
// 1.0.0  11/9/2022   Extracted from Rocket9832.scad
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
/*
FairingConeOGive(Fairing_OD=R98_Body_OD, 
					FairingWall_T=FairingWall_T,
					NC_Base=NC_Base, 
					NC_Len=NC_Len, 
					NC_Wall_t=NC_Wall_t,
					NC_Tip_r=NC_Tip_r,
					Cut_Z=180, LowerPortion=true);
/**/
// NoseLockRing(Fairing_ID =Fairing_ID);
//
//
// *** Fairing ***
/*
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
// R98_Electronics_Bay2(Tube_OD=R98_Body_OD, Tube_ID=R98_Body_ID, Fairing_ID=Fairing_ID, InnerTube_OD=BT54Mtr_OD);
// FairingBaseBulkPlate(Tube_ID=R98_Body_ID, Fairing_ID=Fairing_ID, ShockCord_a=-1);
// rotate([0,180,0]) AltDoor54(Tube_OD=R98_Body_OD, IsLoProfile=true, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y);
// rotate([0,180,0]) AltDoor54(Tube_OD=R98_Body_OD, IsLoProfile=true, DoorXtra_X=0, DoorXtra_Y=0); // old
// rotate([0,180,0]) CP_Door(Tube_OD=R98_Body_OD);
// Batt_Door(Tube_OD=R98_Body_OD, HasSwitch=false);
// Batt_Door(Tube_OD=R98_Body_OD, HasSwitch=true);
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
// ST_TubeEnd(Tube_OD=R98_DualDepTube_OD, Tube_ID=R98_DualDepTube_ID);
// ST_TubeLock(Tube_OD=R98_DualDepTube_OD, Tube_ID=R98_DualDepTube_ID);
// ST_SpringMiddle(Tube_ID=R98_DualDepTube_ID);
// ST_SpringGuide(Tube_ID=R98_DualDepTube_ID);
// DrogueSpringThing();
// rotate([0,180,0]) Drogue_ST_CableRedirect();
// ST_BallKeeper(Tube_OD=R98_DualDepTube_OD);
// ST_BallSpacer(Tube_OD=R98_Body_OD, InnerTube_OD=R98_DualDepTube_OD);
// mirror([0,0,1]) ST_LockBallRetainer(Tube_OD=R98_Body_OD, HasDetent=false);
// rotate([180,0,0]) mirror([0,0,1]) ST_LockRing(InnerTube_OD=R98_MtrTube_OD);
// ST_DetentOnly(InnerTube_OD=R98_MtrTube_OD);
// mirror([0,1,0]) ST_CableEndAndStop(Tube_OD=R98_Body_OD, InnerTube_OD=R98_DualDepTube_OD);
// Drogue_ST_LowerCenteringRing();
//
//  *** Stager parts for dual deploy ***
// BallDetentStopper();
// rotate([0,180,0]) DrogueSep_CableRedirect();
// Stager_Detent();
// CableEndAndStop(Tube_OD=R98_Body_OD);
// rotate([0,180,0]) DrogueSep();
// Stager_BallSpacer(Tube_OD=R98_Body_OD);
// Stager_InnerRace(Tube_OD=R98_Body_OD);
// LockRing(nLocks=2);
// SaucerEConnHolder(Tube_OD=R98_Body_OD);
// Stager_Saucer(Tube_OD=R98_Body_OD, nLocks=2, HasElectrical=true);
//
// ------------
//
// rotate([-90,0,0]) Stager_LockRod(Adj=-0.5);
// Drogue_Cup();
//
// ***********************************
//  ***** Routines *****
//
//
// ***********************************
//  ***** for Viewing *****
//
// ShowUpperBays();
//
// ***********************************
use<Fairing54.scad>
use<Stager2Lib.scad>
include<AltBay.scad>
use<CablePuller.scad>
use<BatteryHolderLib.scad>
use<SpringThing2.scad>
use<RacewayLib.scad>
use<RailGuide.scad>

//also included
 //include<NoseCone.scad>
 //include<ChargeHolder.scad>
 //include<FairingJointLib.scad>
 //include<RailGuide.scad>
 //include<TubesLib.scad>
 //include<BearingLib.scad>
 //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

R98_Body_OD=PML98Body_OD;
R98_Body_ID=PML98Body_ID;
R98_Coupler_ID=PML98Coupler_ID;
R98_MtrTube_OD=PML54Body_OD;
R98_MtrTube_ID=PML54Body_ID;
R98_BoosterMtrTube_OD=BT54Mtr_OD;
R98_DualDepTube_OD=BT54Body_OD;
R98_DualDepTube_ID=BT54Body_ID;

// Fairing Overrides
Fairing_OD=PML98Body_OD;
FairingWall_T=2.2;
Fairing_ID=Fairing_OD-FairingWall_T*2;
Fairing_Len=180; // Body of the fairing.

NoseconeSep_Z=0; // This much of the nosecone becomes part of the fairing.
NC_Len=350;
NC_Tip_r=5;
NC_Base=5;
NC_Lock_H=5;
NC_Wall_t=2.2;

Alt_DoorXtra_X=2;
Alt_DoorXtra_Y=2;

nFins=3;

module ShowUpperBays(){
	LowerTube_Len=159.5;
	DrogueTube_Z=67+80;
	SpringThing_Z=DrogueTube_Z+LowerTube_Len+36;
	MechBay_Z=SpringThing_Z+35;
	EBay_Z=MechBay_Z+162.5;
	Fairing_Z=EBay_Z+162.2;
	Nosecone_Z=Fairing_Z+Fairing_Len;
	
	translate([0,0,Nosecone_Z]){
		FairingConeOGive(Fairing_OD=R98_Body_OD, 
						FairingWall_T=FairingWall_T,
						NC_Base=NC_Base, 
						NC_Len=NC_Len, 
						NC_Wall_t=NC_Wall_t,
						NC_Tip_r=NC_Tip_r);
		
		translate([0,0,-NC_Lock_H]) NoseLockRing(Fairing_ID =Fairing_ID);
	}
	
	
	translate([0,0,Fairing_Z])
		F54_FairingHalf(IsLeftHalf=true, 
				Fairing_OD=Fairing_OD,
				Wall_T=FairingWall_T,
				Len=Fairing_Len);
	
	rotate([0,0,90]) translate([0,0,EBay_Z]) R98_Electronics_Bay2();
	translate([0,0,MechBay_Z]) DrogueMechBay();
	
	
	translate([0,0,SpringThing_Z]){
		translate([0,0,19]) Drogue_ST_CableRedirect();
		DrogueSpringThing();
		translate([0,0,-17]) Drogue_ST_LowerCenteringRing();
	}
	
	//translate([0,0,120]) color("Blue") Tube(OD=BT54Mtr_OD, ID=BT54Mtr_ID, Len=23.75*25.4, myfn=$preview? 36:360);
	
	
	translate([0,0,DrogueTube_Z]) color("Orange") Tube(OD=R98_Body_OD, ID=R98_Body_ID, Len=LowerTube_Len, myfn=$preview? 36:360);
	
	translate([0,0,60]){
		translate([0,0,78]) DrogueSep_CableRedirect();
		DrogueSep();
		rotate([0,180,0]) color("Blue") Stager_Saucer(Tube_OD=R98_Body_OD, nLocks=2, HasElectrical=true);
		
	}
	
	
	//translate([0,0,-350]) rotate([0,0,-90]) translate([0,40,0]) cylinder(d=6, h=100);

	//translate([0,0,-45]) ST_LockRing(); // Glued to top of spring.

	translate([0,0,60]) Drogue_Cup();

} // ShowUpperBays

//ShowUpperBays();

module R98_Electronics_Bay2(Tube_OD=R98_Body_OD, Tube_ID=R98_Body_ID, 
					Fairing_ID=Fairing_ID, InnerTube_OD=BT54Mtr_OD){
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
	translate([0,0,Len]) FairingBaseLockRing(Tube_OD=Tube_OD, Tube_ID=Tube_ID, Fairing_ID=Fairing_ID, Interface=Overlap, BlendToTube=true);
	
	difference(){
		union(){
			Tube(OD=Tube_OD, ID=Tube_ID, Len=Len, myfn=$preview? 36:360);
			translate([0,0,BottomSkirt_Len])
				CenteringRing(OD=Tube_OD-1, ID=InnerTube_OD+IDXtra, Thickness=5, nHoles=4);
			translate([0,0,Len-5-TopSkirt_Len])
				CenteringRing(OD=Tube_OD-1, ID=InnerTube_OD+IDXtra, Thickness=5, nHoles=4);
	} // union
		
		// Altimeter
		translate([0,0,CablePuller_Z]) rotate([0,0,Alt_a]) 
			Alt_BayFrameHole(Tube_OD=Tube_OD, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y);
	
		// Cable Puller door hole
		translate([0,0,CablePuller_Z]) rotate([0,0,CP1_a])
			CP_BayFrameHole(Tube_OD=Tube_OD);
		
		// Battery and Switch door holes
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
			Batt_BayFrameHole(Tube_OD=Tube_OD, HasSwitch=false);
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt2_a]) 
			Batt_BayFrameHole(Tube_OD=Tube_OD, HasSwitch=true);
		
	} // difference
	
	// Altimeter
	translate([0,0,CablePuller_Z]) rotate([0,0,Alt_a])
		Alt_BayDoorFrame(Tube_OD=Tube_OD, Tube_ID=Tube_ID, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowDoor=false);
	
	// Cable Pullers
	translate([0,0,CablePuller_Z]) rotate([0,0,CP1_a])
		CP_BayDoorFrame(Tube_OD=Tube_OD, Tube_ID=Tube_ID, ShowDoor=false);
	
	// Battery and Switch door2
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
		Batt_BayDoorFrame(Tube_OD=Tube_OD, Tube_ID=Tube_ID, HasSwitch=false, ShowDoor=false);
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt2_a]) 
		Batt_BayDoorFrame(Tube_OD=Tube_OD, Tube_ID=Tube_ID, HasSwitch=true, ShowDoor=false);
	
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
			Tube(OD=R98_Body_OD, ID=R98_Body_ID, Len=Len, myfn=$preview? 36:360);
			translate([0,0,BottomSkirt_Len])
				CenteringRing(OD=R98_Body_OD-1, ID=BT54Mtr_OD+IDXtra, Thickness=5, nHoles=4);
			translate([0,0,Len-5-TopSkirt_Len])
				CenteringRing(OD=R98_Body_OD-1, ID=BT54Mtr_OD+IDXtra, Thickness=5, nHoles=4);
		} // union
		
		// Cable Puller door holes
		translate([0,0,CablePuller_Z]) rotate([0,0,CP1_a])
			rotate([0,180,0]) CP_BayFrameHole(Tube_OD=R98_Body_OD);
		translate([0,0,CablePuller_Z]) rotate([0,0,CP2_a]) 
			rotate([0,180,0]) CP_BayFrameHole(Tube_OD=R98_Body_OD);
		
		// Battery and Switch door holes
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
			Batt_BayFrameHole(Tube_OD=R98_Body_OD, HasSwitch=true);
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt2_a]) 
			Batt_BayFrameHole(Tube_OD=R98_Body_OD, HasSwitch=true);
		
	} // difference
	
	// Cable Pullers
	translate([0,0,CablePuller_Z]) rotate([0,0,CP1_a])
		rotate([0,180,0]) CP_BayDoorFrame(Tube_OD=R98_Body_OD, Tube_ID=R98_Body_ID, ShowDoor=false);
	translate([0,0,CablePuller_Z]) rotate([0,0,CP2_a]) 
		rotate([0,180,0]) CP_BayDoorFrame(Tube_OD=R98_Body_OD, Tube_ID=R98_Body_ID, ShowDoor=false);
	
	// Battery and Switch door2
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
		Batt_BayDoorFrame(Tube_OD=R98_Body_OD, Tube_ID=R98_Body_ID, HasSwitch=true, ShowDoor=false);
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt2_a]) 
		Batt_BayDoorFrame(Tube_OD=R98_Body_OD, Tube_ID=R98_Body_ID, HasSwitch=true, ShowDoor=false);
	
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
			Raceway_Exit(Tube_OD=R98_Body_OD, Race_ID=6, Wall_t=4, Top_Len=10, Bottom_Len=10);
		translate([0,0,Raceway_Z-Raceway_Len/2]) rotate([180,0,0]) 
			Raceway_Exit(Tube_OD=R98_Body_OD, Race_ID=6, Wall_t=4, Top_Len=10, Bottom_Len=10);
	} // RacewayHole
	
	module RacewayOuter(){
		translate([0,0,Raceway_Z+Raceway_Len/2]) 
			Raceway_End(Tube_OD=R98_Body_OD, Race_ID=6, Wall_t=4, Len=Raceway_Len/2); //External cover end
		translate([0,0,Raceway_Z-Raceway_Len/2]) rotate([180,0,0]) 
			Raceway_End(Tube_OD=R98_Body_OD, Race_ID=6, Wall_t=4, Len=Raceway_Len/2); //External cover end
	} // RacewayOuter
	
	//*
	difference(){
		rotate([0,180,0]) ST_Frame(Tube_OD=R98_Body_OD, Skirt_ID=R98_Body_ID, Collar_Len=26, Skirt_Len=34);

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
			translate([R98_Body_OD/2,0,0]) cylinder(d=6, h=40);
			translate([R98_Body_OD/2-6,0,0]) cylinder(d=6, h=40);
		} // hull
	} // WireCut
	
	difference(){
		rotate([0,180,0]) ST_CableRedirect(Tube_OD=R98_Body_OD, Skirt_ID=R98_Body_ID, 
							Tube_ID=R98_Coupler_ID, 
							InnerTube_OD=R98_DualDepTube_OD);
		
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
			translate([R98_Body_OD/2,0,0]) cylinder(d=6, h=40);
			translate([R98_Body_OD/2-6,0,0]) cylinder(d=6, h=40);
		} // hull
	} // WireCut
	
	difference(){
		rotate([0,180,0]) ST_UpperCenteringRing(Tube_OD=R98_Body_OD, Tube_ID=PML98Coupler_ID, 
					Skirt_ID=R98_Body_ID, InnerTube_OD=R98_DualDepTube_OD);
		
		// cut out for wires
		WireCut();
		
		// cut out for stager cable
		rotate([0,0,-90]) WireCut();
	} // difference
} // Drogue_ST_LowerCenteringRing

//Drogue_ST_LowerCenteringRing();

module DrogueSep_CableRedirect(){
	rotate([180,0,180]) CableRedirect(Tube_OD=R98_Body_OD, Skirt_ID=R98_Body_ID, Tube_ID=R98_Coupler_ID, InnerTube_OD=BT54Mtr_OD, HasRaceway=true,
							Raceway_a=270);
} // DrogueSep_CableRedirect

//translate([0,0,78]) DrogueSep_CableRedirect();

module DrogueSep(){

	rotate([180,0,0]) 
		Stager_Mech(Tube_OD=R98_Body_OD, nLocks=2, Skirt_ID=R98_Body_ID, 
			Skirt_Len=30, KeyOffset_a=0, HasRaceway=true, Raceway_a=270);
		
} // DrogueSep

//DrogueSep();

//translate([0,0,-170]) rotate([180,0,180])
//CableRedirect(Tube_OD=R98_Body_OD, Skirt_ID=R98_Body_ID, Tube_ID=PML98Coupler_ID, InnerTube_OD=BT54Mtr_OD);

//
//translate([0,0,-320]) color("Orange") DrogueSep();

module Drogue_Cup(){
	WireHole_d=5.5;
	RailGuide_Z=-32;
	RG_Len=35;
	Rivet_Z=-40;
	
	difference(){
		rotate([180,0,0]) Stager_Cup(Tube_OD=R98_Body_OD, ID=76, nLocks=2, BoltsOn=false, HasElectrical=true);
	
		/* replace by Molex connector
		//Sustainer Ignition Wire
		rotate([0,0,-90]) translate([0,R98_Coupler_ID/2-WireHole_d/2-3,-22]) 
			cylinder(d=WireHole_d, h=25);
		/**/
		
		// Rail guide bolts
		translate([0,0,RailGuide_Z]) rotate([0,0,-90-180/nFins]) 
			translate([0,R98_Body_OD/2+2,0]) RailGuideBoltPattern(BoltSpace=12.7) Bolt6Hole();
	} // difference
	
	difference(){
		// Skirt
		translate([0,0,-60]) Tube(OD=R98_Body_OD, ID=R98_Body_ID, Len=60, myfn=$preview? 36:360);
	
		// Rail guide bolts
		translate([0,0,RailGuide_Z]) rotate([0,0,-90-180/nFins]) 
			translate([0,R98_Body_OD/2+2,0]) RailGuideBoltPattern(BoltSpace=12.7) Bolt6Hole();
		
		// Rivet holes
		for (j=[0:2]) rotate([0,0,120*j]) translate([0,R98_Body_OD/2+1,Rivet_Z])
			rotate([90,0,0]) cylinder(d=4, h=5);
	} // difference
	
	//*
	difference(){
		// Rail Guide
		translate([0,0,RailGuide_Z]) rotate([0,0,-90-180/nFins]) 
			//RailButtonPost(OD=R98_Body_OD, MtrTube_OD=R98_MtrTube_OD, H=R98_Body_OD/2+5, Len=30);
			RailGuidePost(OD=R98_Body_OD, MtrTube_OD=R98_MtrTube_OD+IDXtra*2, H=R98_Body_OD/2+2, 
				TubeLen=RG_Len+10, Length = RG_Len, BoltSpace=12.7);
		
		translate([0,0,-80]) cylinder(d=R98_Body_OD-1, h=80);
		
		// Rivet holes
		for (j=[0:2]) rotate([0,0,120*j]) translate([0,R98_Body_OD/2+1,Rivet_Z])
			rotate([90,0,0]) cylinder(d=4, h=5);
	} // difference
		
	/**/
	if ($preview) rotate([0,0,-90-180/nFins])  translate([0,R98_Body_OD/2+2,RailGuide_Z]) 
		BoltOnRailGuide(Length = RG_Len, BoltSpace=12.7, RoundEnds=true);
} // Drogue_Cup

//Drogue_Cup();

































