// ***********************************
// Project: 3D Printed Rocket
// Filename: Rocket98Dual.scad
// by David M. Flynn
// Created: 10/16/2022 
// Revision: 1.0.4  12/17/2022
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  Generic 98mm Body Dual Deploy bays and parts.
//  Assembly:
//   Glue E-Bay and Mech-Bay to 38mm body tube. 
//   Use a section of 38mm coupler tube w/ a 54mm centering ring on one end to align
//   the 54mm deployment tube and glue the 54mm tube to the bottom of the Mech-Bay. 
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
// 1.0.4  12/17/2022  Spring Thing fixes.
// 1.0.3  11/26/2022  Updated and changed to 38mm bay tube
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
// NoseLockRing(Fairing_OD=R98_Body_OD, Fairing_ID =Fairing_ID);
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
// R98_Electronics_Bay2(Tube_OD=R98_Body_OD, Tube_ID=R98_Body_ID, Fairing_ID=Fairing_ID, InnerTube_OD=R98_BayInnerTube_OD);
// FairingBaseBulkPlate(Tube_ID=R98_Body_ID, Fairing_ID=Fairing_ID, ShockCord_a=-1);
// AltDoor54(Tube_OD=R98_Body_OD, IsLoProfile=true, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y);
// rotate([0,180,0]) CP_Door(Tube_OD=R98_Body_OD, BoltBossInset=3, HasArmingSlot=true);
// Batt_Door(Tube_OD=R98_Body_OD, InnerTube_OD=R98_BayInnerTube_OD, HasSwitch=false);
// Batt_Door(Tube_OD=R98_Body_OD, InnerTube_OD=R98_BayInnerTube_OD, HasSwitch=true);
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
// ST_TubeEnd(Tube_OD=R98_DualDepInnerTube_OD, Tube_ID=R98_DualDepInnerTube_ID);
// ST_TubeLock(Tube_OD=R98_DualDepInnerTube_OD, Tube_ID=R98_DualDepInnerTube_ID, SkirtLen=15);
// ST_SpringMiddle(Tube_ID=R98_DualDepInnerTube_OD);
// ST_SpringGuide(InnerTube_ID=R98_DualDepInnerTube_OD);
// ST_Frame(Tube_OD=R98_Body_OD, Skirt_ID=R98_Body_ID, Collar_Len=26, Skirt_Len=34, HasStagerCableRaceway=true, HasWireRaceway=true);
// ST_CableRedirectTop(Tube_OD=R98_Body_OD, Skirt_ID=R98_Body_ID, InnerTube_OD=R98_DualDepTube_OD);
// ST_CableRedirect(Tube_OD=R98_Body_OD, Skirt_ID=R98_Body_ID, Tube_ID=R98_Coupler_ID, InnerTube_OD=R98_DualDepTube_OD, InnerTube2_OD=R98_DualDepTube_OD);
// ST_BallKeeper(InnerTube_OD=R98_DualDepTube_OD);
// ST_BallSpacer(Tube_OD=R98_Body_OD);
// rotate([180,0,0]) ST_LockBallRetainer(Tube_OD=R98_Body_OD);
// ST_LockRing(Tube_OD=R98_Body_OD, InnerTube_OD=R98_DualDepTube_OD);
// ST_DetentOnly(Tube_OD=R98_Body_OD);
// ST_CableEndAndStop(Tube_OD=R98_Body_OD);
// ST_UpperCenteringRing(Tube_OD=R98_Body_OD, Skirt_ID=R98_Body_ID, InnerTube_OD=R98_DualDepTube_OD);
//
// ST_MT_DrillingJig(Tube_OD=R98_Body_OD, Skirt_ID=R98_Body_ID, InnerTube_OD=R98_DualDepTube_OD, Skirt_Len=34);
//
//  *** Stager parts for dual deploy ***
// Stager_CableRedirect(Tube_OD=R98_Body_OD, Skirt_ID=R98_Body_ID, Tube_ID=R98_Coupler_ID, InnerTube_OD=R98_DualDepTube_OD, HasRaceway=true, Raceway_a=270);
// Stager_CableRedirectTop(Tube_OD=R98_Body_OD, Skirt_ID=R98_Body_ID, InnerTube_OD=R98_DualDepTube_OD, HasRaceway=true, Raceway_a=270);
// Stager_Detent(Tube_OD=R98_Body_OD);
// Stager_CableEndAndStop(Tube_OD=R98_Body_OD);
// rotate([0,180,0]) DrogueSep(); // aka Stager_Mech
// Stager_BallSpacer(Tube_OD=R98_Body_OD);
// Stager_InnerRace(Tube_OD=R98_Body_OD);
// Stager_LockRing(Tube_OD=R98_Body_OD, nLocks=2);
// Stager_SaucerEConnHolder(Tube_OD=R98_Body_OD);
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
R98_BayInnerTube_OD=BT38Body_OD;
R98_BayInnerTube_ID=BT38Body_ID;
//R98_Coupler_OD=BT98Coupler_OD;
R98_Coupler_ID=PML98Coupler_ID;
R98_DualDepTube_OD=BT54Body_OD;
R98_DualDepTube_ID=BT54Body_ID;
R98_DualDepInnerTube_OD=BT54Coupler_OD;
R98_DualDepInnerTube_ID=BT54Coupler_ID;

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
	SpringTube_Len=50;
	SpringTube_Z=SpringThing_Z+35;
	MechBay_Z=SpringTube_Z+SpringTube_Len;
	
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
		
		translate([0,0,-NC_Lock_H]) NoseLockRing(Fairing_OD=R98_Body_OD, Fairing_ID =Fairing_ID);
	}
	
	
	translate([0,0,Fairing_Z])
		F54_FairingHalf(IsLeftHalf=true, 
				Fairing_OD=Fairing_OD,
				Wall_T=FairingWall_T,
				Len=Fairing_Len);
	
	rotate([0,0,90]) translate([0,0,EBay_Z]) R98_Electronics_Bay2();
	translate([0,0,MechBay_Z]) DrogueMechBay();
	
	translate([0,0,SpringTube_Z]) color("Orange") Tube(OD=R98_Body_OD, ID=R98_Body_ID, Len=SpringTube_Len, myfn=$preview? 36:360);
	
	translate([0,0,SpringThing_Z]){
		//translate([0,0,19]) ST_CableRedirect();
		//rotate([0,180,0]) DrogueSpringThing();
		//translate([0,0,-17]) ST_UpperCenteringRing();
	}
	
	//translate([0,0,120]) color("Blue") Tube(OD=BT54Mtr_OD, ID=BT54Mtr_ID, Len=23.75*25.4, myfn=$preview? 36:360);
	
	
	translate([0,0,DrogueTube_Z]) color("Orange") Tube(OD=R98_Body_OD, ID=R98_Body_ID, Len=LowerTube_Len, myfn=$preview? 36:360);
	
	translate([0,0,60]){
		//translate([0,0,78]) Stager_CableRedirect();
		DrogueSep();
		rotate([0,180,0]) color("Blue") Stager_Saucer(Tube_OD=R98_Body_OD, nLocks=2, HasElectrical=true);
		
	}
	
	
	//translate([0,0,-350]) rotate([0,0,-90]) translate([0,40,0]) cylinder(d=6, h=100);

	//translate([0,0,-45]) ST_LockRing(); // Glued to top of spring.

	translate([0,0,60]) Drogue_Cup();

} // ShowUpperBays

//ShowUpperBays();

module R98_Electronics_Bay2(Tube_OD=R98_Body_OD, Tube_ID=R98_Body_ID, 
					Fairing_ID=Fairing_ID, InnerTube_OD=BT38Body_OD, HasFairingLockRing=true,
					ShowDoors=false){
	Len=162;
	CablePuller_Z=81;
	BattSwDoor_Z=70;
	TopSkirt_Len=15;
	BottomSkirt_Len=15;
	CR_Inset=12;
	
	
	/*
	//Standard
	CP1_a=0;
	Alt_a=180;
	Batt1_a=90; // Altimeter Battery
	Batt2_a=270; // Cable puller battery and switch
	TubeOffset=0;
	nCRHoles=4;
	CRHole_a=0;
	/**/
	//*
	//GoPro
	CP1_a=60;
	Alt_a=215;
	Batt1_a=140; // Altimeter Battery
	Batt2_a=290; // Cable puller battery and switch
	TubeOffset=10;
	nCRHoles=0;
	nHoles=6;
	/**/
	
	// The Fairing clamps onto this. 
	if (HasFairingLockRing)
	translate([0,0,Len]) FairingBaseLockRing(Tube_OD=Tube_OD, Tube_ID=Tube_ID, Fairing_ID=Fairing_ID, Interface=Overlap, BlendToTube=true);
	
	if ($preview&&ShowDoors) translate([0,TubeOffset,-1])
		color("Blue") Tube(OD=InnerTube_OD, ID=InnerTube_OD-2, Len=Len+2, myfn=$preview? 36:360);
	
	difference(){
		union(){
			Tube(OD=Tube_OD, ID=Tube_ID, Len=Len, myfn=$preview? 36:360);
			
			translate([0,0,BottomSkirt_Len])
				CenteringRing(OD=Tube_OD-1, ID=InnerTube_OD+IDXtra*2, 
								Thickness=5, nHoles=nCRHoles, Offset=TubeOffset);
			
			translate([0,0,Len-5-TopSkirt_Len])
				CenteringRing(OD=Tube_OD-1, ID=InnerTube_OD+IDXtra*2, 
							Thickness=5, nHoles=nCRHoles, Offset=TubeOffset);
		} // union
		
		//*
		if (nCRHoles==0)
		for (j=[1:nHoles-1]) rotate([0,0,360/nHoles*j])
			translate([0,InnerTube_OD/2+(Tube_ID/2-InnerTube_OD/2)/2,0])
				cylinder(d=(Tube_ID/2-InnerTube_OD/2)/2, h=Len);
			/**/
			
		// Altimeter
		translate([0,0,CablePuller_Z]) rotate([0,0,Alt_a+180]) 
			Alt_BayFrameHole(Tube_OD=Tube_OD, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y);
	
		// Cable Puller door hole
		translate([0,0,CablePuller_Z]) rotate([0,0,CP1_a+180])
			CP_BayFrameHole(Tube_OD=Tube_OD);
		
		// Battery and Switch door holes
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a+180]) 
			Batt_BayFrameHole(Tube_OD=Tube_OD, HasSwitch=false);
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt2_a+180]) 
			Batt_BayFrameHole(Tube_OD=Tube_OD, HasSwitch=true);
		
		// Cable Puller Cable hole
		rotate([0,0,CP1_a])
		translate([0,Tube_OD/2-CR_Inset/2-8,Len-5-TopSkirt_Len-Overlap]) cylinder(d=12, h=12);
	} // difference
	
	
	
	// Altimeter
	translate([0,0,CablePuller_Z]) rotate([0,0,Alt_a+180])
		Alt_BayDoorFrame(Tube_OD=Tube_OD, Tube_ID=Tube_ID, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowDoor=ShowDoors);
	
	// Cable Pullers
	translate([0,0,CablePuller_Z]) rotate([0,0,CP1_a+180])
		CP_BayDoorFrame(Tube_OD=Tube_OD, ShowDoor=ShowDoors);
	
	// Battery and Switch door2
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a+180]) 
		Batt_BayDoorFrame(Tube_OD=Tube_OD, HasSwitch=false, ShowDoor=ShowDoors);
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt2_a+180]) 
		Batt_BayDoorFrame(Tube_OD=Tube_OD, HasSwitch=true, ShowDoor=ShowDoors);
	
} // R98_Electronics_Bay2

//translate([0,0,162]) R98_Electronics_Bay2();
//R98_Electronics_Bay2(HasFairingLockRing=false, ShowDoors=true);

R54_Body_OD=PML54Body_OD;
R54_Body_ID=PML54Body_ID;

module R54_Electronics_Bay2(Tube_OD=R54_Body_OD, Tube_ID=R54_Body_ID, 
					Fairing_ID=R54_Body_OD-4.4, HasFairingLockRing=true,
					ShowDoors=false){
	Len=162;
	CablePuller_Z=81;
	BattSwDoor_Z=70;
	TopSkirt_Len=15;
	BottomSkirt_Len=15;
	CR_Inset=12;
	
	
	CP1_a=0;
	Alt_a=180;
	nCRHoles=4;
	
	// The Fairing clamps onto this. 
	if (HasFairingLockRing)
	translate([0,0,Len]) FairingBaseLockRing(Tube_OD=Tube_OD, Tube_ID=Tube_ID, Fairing_ID=Fairing_ID, Interface=Overlap, BlendToTube=true);
	
	
	difference(){
		union(){
			Tube(OD=Tube_OD, ID=Tube_ID, Len=Len, myfn=$preview? 36:360);
			
			//translate([0,0,BottomSkirt_Len])
		//		CenteringRing(OD=Tube_OD-1, ID=InnerTube_OD+IDXtra*2, 
			//					Thickness=5, nHoles=nCRHoles, Offset=TubeOffset);
			
			//translate([0,0,Len-5-TopSkirt_Len])
			//	CenteringRing(OD=Tube_OD-1, ID=InnerTube_OD+IDXtra*2, 
			//				Thickness=5, nHoles=nCRHoles, Offset=TubeOffset);
		} // union
		
		
			
		// Altimeter
		translate([0,0,CablePuller_Z]) rotate([0,0,Alt_a+180]) 
			Alt_BayFrameHole(Tube_OD=Tube_OD, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y);
	
		// Cable Puller door hole
		translate([0,0,CablePuller_Z]) rotate([0,0,CP1_a+180])
			CP_BayFrameHole(Tube_OD=Tube_OD);
		
		
		
		// Cable Puller Cable hole
		rotate([0,0,CP1_a])
		translate([0,Tube_OD/2-CR_Inset/2-8,Len-5-TopSkirt_Len-Overlap]) cylinder(d=12, h=12);
	} // difference
	
	
	
	// Altimeter
	translate([0,0,CablePuller_Z]) rotate([0,0,Alt_a+180])
		Alt_BayDoorFrame(Tube_OD=Tube_OD, Tube_ID=Tube_ID, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowDoor=ShowDoors);
	
	// Cable Pullers
	translate([0,0,CablePuller_Z]) rotate([0,0,CP1_a+180])
		CP_BayDoorFrame(Tube_OD=Tube_OD, Tube_ID=Tube_ID, ShowDoor=ShowDoors);
	
	
} // R54_Electronics_Bay2

//R54_Electronics_Bay2();

module EBayCouplerCR(){
	nHoles=6;
	InnerTube_OD=BT38Body_OD;
	Tube_ID=BT98Coupler_ID;
	
	difference(){
		CenteringRing(OD=Tube_ID, ID=InnerTube_OD+IDXtra*2, 
								Thickness=5, nHoles=0, Offset=10);
		
		translate([0,0,-Overlap])
		for (j=[1:nHoles-1]) rotate([0,0,360/nHoles*j])
			translate([0,InnerTube_OD/2+(Tube_ID/2-InnerTube_OD/2)/2,0])
				cylinder(d=(Tube_ID/2-InnerTube_OD/2)/2, h=5+Overlap*2);
	} // difference
} // EBayCouplerCR

//EBayCouplerCR();

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
				CenteringRing(OD=R98_Body_OD-1, ID=R98_BayInnerTube_OD+IDXtra*2, Thickness=5, nHoles=4);
			translate([0,0,Len-5-TopSkirt_Len])
				CenteringRing(OD=R98_Body_OD-1, ID=R98_BayInnerTube_OD+IDXtra*2, Thickness=5, nHoles=4);
			
			// Center deployment tube
			translate([0,0,BottomSkirt_Len-5+Overlap])
				CenteringRing(OD=R98_DualDepTube_ID, ID=R98_BayInnerTube_OD+IDXtra*2, Thickness=5, nHoles=0);
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
		rotate([0,180,0]) CP_BayDoorFrame(Tube_OD=R98_Body_OD, ShowDoor=false);
	translate([0,0,CablePuller_Z]) rotate([0,0,CP2_a]) 
		rotate([0,180,0]) CP_BayDoorFrame(Tube_OD=R98_Body_OD, ShowDoor=false);
	
	// Battery and Switch door2
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
		Batt_BayDoorFrame(Tube_OD=R98_Body_OD, HasSwitch=true, ShowDoor=false);
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt2_a]) 
		Batt_BayDoorFrame(Tube_OD=R98_Body_OD, HasSwitch=true, ShowDoor=false);
	
} // DrogueMechBay

//DrogueMechBay();


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
			//RailButtonPost(OD=R98_Body_OD, MtrTube_OD=R98_DualDepTube_OD, H=R98_Body_OD/2+5, Len=30);
			RailGuidePost(OD=R98_Body_OD, MtrTube_OD=R98_DualDepTube_OD+IDXtra*2, H=R98_Body_OD/2+2, 
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

































