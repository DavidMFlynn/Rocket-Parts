// ***********************************
// Project: 3D Printed Rocket
// Filename: Rocket98.scad
// by David M. Flynn
// Created: 10/4/2022 
// Revision: 1.2.0  6/23/2023
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  Rocket with 98mm Body and 54mm motor. 
//  A.K.A. The Red One
//  This file includes a collection of electronics bays
//
//  ***** History *****
// 1.2.0  6/23/2023  Added R98_Electronics_Bay5()
// 1.1.1  5/7/2023   Updated.
// 1.1.0  4/27/2023  Added Ball Lock for dual deploy option.
// 1.0.2  12/15/2022 Updated electronics bay
// 1.0.1  10/11/2022 Added Rail Guides
// 1.0.0  10/4/2022  First code.
//
// ***********************************
//  ***** for STL output *****
//
// *** Nosecode ***
/*
FairingConeOGive(Fairing_OD=R98_Body_OD, 
					FairingWall_T=FairingWall_T,
					NC_Base=NC_Base, 
					NC_Len=NC_Len, 
					NC_Wall_t=NC_Wall_t,
					NC_Tip_r=NC_Tip_r,
					Cut_Z=180, LowerPortion=false);
/**/
// rotate([180,0,0]) NoseLockRing(Fairing_OD=Fairing_OD, Fairing_ID =Fairing_ID);

// BluntOgiveWeight(OD=R98_Body_OD, L=NC_Len, Tip_R=NC_Tip_r, Wall_T=NC_Wall_t);

// *** L3 Nosecone, No Fairing ***
// BluntOgiveNoseCone(ID=Coupler_OD, OD=R98_Body_OD, L=200, Base_L=13, Tip_R=12, Wall_T=3, Cut_Z=0, LowerPortion=false);
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
//F54_SpringEndCap();
//FairingBaseLockRing(Tube_OD=R98_Body_OD, Tube_ID=R98_Body_ID-1, Fairing_ID=Fairing_ID, Interface=-IDXtra, BlendToTube=false); // repair part
//
// *** Electronics Bay ***
// R98_Electronics_Bay2(Tube_OD=R98_Body_OD, Tube_ID=R98_Body_ID, Fairing_ID=Fairing_ID, InnerTube_OD=R98_BayInnerTube_OD);
// FairingBaseBulkPlate(Tube_ID=R98_Body_ID, Fairing_ID=Fairing_ID, ShockCord_a=-100);
// rotate([-90,0,0]) CP_Door(Tube_OD=R98_Body_OD, BoltBossInset=3, HasArmingSlot=true);
// rotate([-90,0,0]) AltDoor54(Tube_OD=R98_Body_OD, IsLoProfile=false, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowAlt=true);
// 
// rotate([-90,0,0]) Batt_Door(Tube_OD=R98_Body_OD, InnerTube_OD=0, HasSwitch=true);
// DoubleBatteryHolder(Tube_ID=PML98Body_ID, HasBoltHoles=true); // oops!
//
// ----------------------
//  *** Petal Deployment ***
//
//rotate([180,0,0]) PD_Petals(Coupler_OD=Coupler_OD, Len=110, nPetals=nLockBalls);
//rotate([-90,0,0]) PD_PetalSpringHolder(Coupler_OD=Coupler_OD);
/*
	PD_PetalHub(Coupler_OD=Coupler_OD, 
					nPetals=nLockBalls, 
					ShockCord_a=ShockCord_a);
/**/
//
// ----------------------
//  *** Cable Puller ***
// ThroughOut();
// rotate([0,90,0]) SpringBody();
// CableRetainer();
// StopAdjuster();
// CageBottom();
// AddServo(); // CageTop w/ servo mount
//
// -------------------------------------------------------------------------------------------
//  *** Optional: Ball Lock for base of electronics bay to make this a dual deploy rocket ***
// STB_LockDisk(BallPerimeter_d=R98_Body_OD, nLockBalls=nLockBalls);
// rotate([180,0,0]) STB_BallRetainerTop(BallPerimeter_d=R98_Body_OD, Body_OD=R98_Body_ID, nLockBalls=nLockBalls, HasIntegratedCouplerTube=true, Body_ID=R98_Body_ID, HasSecondServo=true, UsesBigServo=true);
// STB_BallRetainerBottom(BallPerimeter_d=R98_Body_OD, Body_OD=R98_Body_ID, nLockBalls=nLockBalls, HasSpringGroove=false);
// rotate([180,0,0]) TubeEnd(BallPerimeter_d=R98_Body_OD, nLockBalls=nLockBalls, Body_OD=R98_Body_OD, Body_ID=R98_Body_ID, Skirt_Len=20);
// STB_SpringEnd(Tube_ID=R98_Body_ID, CouplerTube_ID=BT98Coupler_ID);
//
//
// *** Fin Can ***
// UpperFinCan();
// Rocket98Fin();
// rotate([180,0,0]) LowerFinCan();
// rotate([90,0,0]) BoltOnRailGuide(Length = 40, BoltSpace=12.7, RoundEnds=true);
// rotate([0,-90,0]) TubeBoltedRailGuide(TubeOD=R98_Body_OD, Length = 25, Offset = 5.5);
//
// ***********************************
//  ***** Routines *****
//
//
// ***********************************
//  ***** for Viewing *****
//
// ShowRocket98();
//
// ***********************************
include<TubesLib.scad>
use<RailGuide.scad>
use<Fairing54.scad>
use<FinCan.scad>
use<NoseCone.scad>
use<AltBay.scad>
use<CablePuller.scad>
use<BatteryHolderLib.scad>
use<SpringThingBooster.scad>
use<PetalDeploymentLib.scad>

//also included
 //include<FairingJointLib.scad>
 //include<Fins.scad>
 //include<TubesLib.scad>
 //include<BearingLib.scad>
 //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

nFins=5;
R98_Fin_Post_h=10;
R98_Fin_Root_L=200;
R98_Fin_Root_W=14;
R98_Fin_Tip_W=5;
R98_Fin_Tip_L=80;
R98_Fin_Span=180;
R98_Fin_TipOffset=120;
R98_Fin_Chamfer_L=32;

R98_Body_OD=PML98Body_OD;
R98_Body_ID=PML98Body_ID;
Coupler_OD=BT98Coupler_OD;
R98_Coupler_ID=BT98Coupler_ID;
R98_MtrTube_OD=PML54Body_OD;
R98_MtrTube_ID=PML54Body_ID;
R98_BayInnerTube_OD=BT38Body_OD;
R98_BayInnerTube_ID=BT38Body_ID;

EBay_Len=162;

// Fairing Overrides
Fairing_OD=PML98Body_OD;
FairingWall_T=2.2;
Fairing_ID=Fairing_OD-FairingWall_T*2;


NoseconeSep_Z=0; // This much of the nosecone becomes part of the fairing.
NC_Len=350;
NC_Tip_r=5;
NC_Base=5;
NC_Lock_H=5;
NC_Wall_t=2.2;

Fairing_Len=180; // Body of the fairing.

BodyTubeLen=36*25.4;

Alt_DoorXtra_X=2;
Alt_DoorXtra_Y=2;

Bolt4Inset=4;
nLockBalls=6;
ShockCord_a=22.5;


module ShowRocket98(){
	UpperFinCan_Z=R98_Fin_Root_L+75+Overlap;
	BodyTube_Z=UpperFinCan_Z+Overlap*2;
	EBay_Z=BodyTube_Z+BodyTubeLen;
	Fairing_Z=EBay_Z+EBay_Len+Overlap*2;
	NoseCone_Z=Fairing_Z+Fairing_Len+Overlap*2;
	
	translate([0,0,NoseCone_Z]){
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
	
	translate([0,0,EBay_Z]) rotate([0,0,30]) R98_Electronics_Bay2();
	
	translate([0,0,BodyTube_Z]) color("LightBlue") Tube(OD=R98_Body_OD, ID=R98_Body_ID, 
			Len=BodyTubeLen-Overlap*2, myfn=$preview? 90:360);
	
	translate([0,0,UpperFinCan_Z]) color("White") UpperFinCan();
	color("LightGreen") LowerFinCan();
	
	//*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j])
		translate([R98_Body_OD/2-R98_Fin_Post_h, 0, R98_Fin_Root_L/2+55]) 
			rotate([0,90,0]) color("Yellow") Rocket98Fin();
	/**/
} // ShowRocket98

//ShowRocket98();

// L3 test bay: 2x Altimeter Door, 2x Alt Battery, 2x Rocket Servo Battery Door

module R98_Electronics_Bay3(Tube_OD=R98_Body_OD, Tube_ID=R98_Body_ID, 
					Fairing_ID=Fairing_ID, InnerTube_OD=BT38Body_OD){
					
	// *** 2 Altimeters, 2 Battery Doors w/ Switches, Centering Rings Top and Bottom ***
	
	Len=150;
	Altimeter_Z=75;
	BattSwDoor_Z=70;
	TopSkirt_Len=15;
	BottomSkirt_Len=15;
	Alt1_a=0;
	Alt2_a=180;
	Batt1_a=90; // Rocket Servo 1 Battery & Switch
	Batt2_a=270; // Rocket Servo 2 Battery & Switch
	nCRHoles=4;
	
	/*
	// The Fairing clamps onto this. 
	translate([0,0,Len]) FairingBaseLockRing(Tube_OD=Tube_OD, Tube_ID=Tube_ID, Fairing_ID=Fairing_ID, Interface=Overlap, BlendToTube=true);
	/**/
	
	difference(){
		union(){
			Tube(OD=Tube_OD, ID=Tube_ID, Len=Len, myfn=$preview? 36:360);
			
			translate([0,0,BottomSkirt_Len]) rotate([0,0,45])
				CenteringRing(OD=Tube_OD-1, ID=InnerTube_OD+IDXtra*2, Thickness=5, nHoles=nCRHoles);
			translate([0,0,Len-5-TopSkirt_Len]) rotate([0,0,45])
				CenteringRing(OD=Tube_OD-1, ID=InnerTube_OD+IDXtra*2, Thickness=5, nHoles=nCRHoles);
	} // union
		
		// Altimeter 1
		translate([0,0,Altimeter_Z]) rotate([0,0,Alt1_a]) 
			Alt_BayFrameHole(Tube_OD=Tube_OD, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y);
			
		// Altimeter 2
		translate([0,0,Altimeter_Z]) rotate([0,0,Alt2_a]) 
			Alt_BayFrameHole(Tube_OD=Tube_OD, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y);
		
		// Battery and Switch door holes
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
			Batt_BayFrameHole(Tube_OD=Tube_OD, HasSwitch=true);
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt2_a]) 
			Batt_BayFrameHole(Tube_OD=Tube_OD, HasSwitch=true);
		
	} // difference
	
	// Altimeter 1
	translate([0,0,Altimeter_Z]) rotate([0,0,Alt1_a])
		Alt_BayDoorFrame(Tube_OD=Tube_OD, Tube_ID=Tube_ID, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowDoor=false);
	
	// Altimeter 2
	translate([0,0,Altimeter_Z]) rotate([0,0,Alt2_a])
		Alt_BayDoorFrame(Tube_OD=Tube_OD, Tube_ID=Tube_ID, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowDoor=false);
	
	// Battery and Switch door2
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
		Batt_BayDoorFrame(Tube_OD=Tube_OD, Tube_ID=Tube_ID, HasSwitch=true, ShowDoor=false);
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt2_a]) 
		Batt_BayDoorFrame(Tube_OD=Tube_OD, Tube_ID=Tube_ID, HasSwitch=true, ShowDoor=false);
	
} // R98_Electronics_Bay3

//R98_Electronics_Bay3();

module TubeHold(){
		Tube_OD=12.7;
		
		MountingPost_d=14.5;
		Socket_Len=MountingPost_d;
		Wall_t=2.2;
		PostOffset=2;
		
		difference(){
			union(){
				hull(){
					rotate([90,0,0]) cylinder(d=Tube_OD+Wall_t*2, h=Socket_Len, center=true);
					translate([0,0,-Tube_OD/2-Wall_t+0.5]) cube([Tube_OD+8, Socket_Len, 1], center=true);
				} // hull
				
					translate([0,PostOffset,-Tube_OD/2-Wall_t-5]) cylinder(d=MountingPost_d, h=6);
					
				hull(){
					translate([0,PostOffset,-Tube_OD/2-Wall_t]) cylinder(d=MountingPost_d, h=1);
					cylinder(d=Socket_Len, h=1);
				} // hull
			} // union
			
			translate([0,-2,0]) rotate([90,0,0]) cylinder(d=Tube_OD+IDXtra, h=Socket_Len, center=true);
		} // difference
	} // TubeHold
	
//rotate([0,0,45]) translate([0,-R98_Body_OD/2+16,165-6]) TubeHold();

			
module R98_Electronics_Bay4(Tube_OD=R98_Body_OD, Tube_ID=R98_Body_ID, 
					Fairing_ID=Fairing_ID, InnerTube_OD=BT38Body_OD){
					
	// Make Rainbow One dual deploy
	
	// *** Altimeter, Cable Puller, 2 Battery Doors w/ Switches, Centering Rings Top and Bottom ***
	
	
	Len=165;
	Altimeter_Z=78;
	CablePuller_Z=Len/2;
	BattSwDoor_Z=74;
	TopSkirt_Len=15;
	BottomSkirt_Len=15;
	Alt1_a=0;
	Alt2_a=180;
	CP1_a=180;
	Batt1_a=90; // Rocket Servo 1 Battery & Switch
	Batt2_a=270; // Rocket Servo 2 Battery & Switch
	nCRHoles=4;
	CRHole_a=0;
	
	/*
	// The Fairing clamps onto this. 
	translate([0,0,Len]) FairingBaseLockRing(Tube_OD=Tube_OD, Tube_ID=Tube_ID, Fairing_ID=Fairing_ID, Interface=Overlap, BlendToTube=true);
	/**/
	
	
	
	difference(){
		union(){
			Tube(OD=Tube_OD, ID=Tube_ID, Len=Len, myfn=$preview? 36:360);
			
			
			
			translate([0,0,BottomSkirt_Len]) rotate([0,0,CRHole_a])
				CenteringRing(OD=Tube_OD-1, ID=InnerTube_OD+IDXtra*2, Thickness=5, nHoles=nCRHoles);
			translate([0,0,Len-5-TopSkirt_Len]) rotate([0,0,CRHole_a])
				CenteringRing(OD=Tube_OD-1, ID=InnerTube_OD+IDXtra*2, Thickness=5, nHoles=nCRHoles);
		} // union
		
		// Altimeter 1
		translate([0,0,Altimeter_Z]) rotate([0,0,Alt1_a]) 
			Alt_BayFrameHole(Tube_OD=Tube_OD, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y);
			
		// Cable Puller door hole
		translate([0,0,CablePuller_Z]) rotate([0,0,CP1_a])
			CP_BayFrameHole(Tube_OD=Tube_OD);
			
		// Altimeter 2
		//translate([0,0,Altimeter_Z]) rotate([0,0,Alt2_a]) 
		//	Alt_BayFrameHole(Tube_OD=Tube_OD, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y);
		
		// Battery and Switch door holes
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
			Batt_BayFrameHole(Tube_OD=Tube_OD, HasSwitch=true);
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt2_a]) 
			Batt_BayFrameHole(Tube_OD=Tube_OD, HasSwitch=true);
		
	} // difference
	
	// Altimeter 1
	translate([0,0,Altimeter_Z]) rotate([0,0,Alt1_a])
		Alt_BayDoorFrame(Tube_OD=Tube_OD, Tube_ID=Tube_ID, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowDoor=false);
	
	// Cable Puller
	translate([0,0,CablePuller_Z]) rotate([0,0,CP1_a])
		CP_BayDoorFrame(Tube_OD=Tube_OD, ShowDoor=false);
		
	// Altimeter 2
	//translate([0,0,Altimeter_Z]) rotate([0,0,Alt2_a])
	//	Alt_BayDoorFrame(Tube_OD=Tube_OD, Tube_ID=Tube_ID, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowDoor=false);
	
	// Battery and Switch door2
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
		Batt_BayDoorFrame(Tube_OD=Tube_OD, Tube_ID=Tube_ID, HasSwitch=true, ShowDoor=false);
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt2_a]) 
		Batt_BayDoorFrame(Tube_OD=Tube_OD, Tube_ID=Tube_ID, HasSwitch=true, ShowDoor=false);
	
} // R98_Electronics_Bay4

// R98_Electronics_Bay4();
// translate([0,0,81]) rotate([0,0,180]) CP_Door(Tube_OD=R98_Body_OD, BoltBossInset=3, HasArmingSlot=true);
// translate([0,0,74]) rotate([0,0,90]) Batt_Door(Tube_OD=R98_Body_OD, InnerTube_OD=0, HasSwitch=true);
// FairingBaseLockRing(Tube_OD=R98_Body_OD, Tube_ID=R98_Body_ID, Fairing_ID=Fairing_ID, Interface=-IDXtra, BlendToTube=false);

module R98_Electronics_Bay2(Tube_OD=R98_Body_OD, Tube_ID=R98_Body_ID, 
					Fairing_ID=Fairing_ID, InnerTube_OD=BT38Body_OD){
					
	// *** Altimeter, Cable Puller, 2 Battery Doors 1 w/ Switch, Centering Rings Top and Bottom ***
	// *** Integrated Fairing Locking Ring ***
	
	Len=EBay_Len;
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
				CenteringRing(OD=Tube_OD-1, ID=InnerTube_OD+IDXtra*2, Thickness=5, nHoles=4);
			translate([0,0,Len-5-TopSkirt_Len])
				CenteringRing(OD=Tube_OD-1, ID=InnerTube_OD+IDXtra*2, Thickness=5, nHoles=4);
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
		CP_BayDoorFrame(Tube_OD=Tube_OD, ShowDoor=false);
	
	// Battery and Switch door2
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
		Batt_BayDoorFrame(Tube_OD=Tube_OD, HasSwitch=false, ShowDoor=false);
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt2_a]) 
		Batt_BayDoorFrame(Tube_OD=Tube_OD, HasSwitch=true, ShowDoor=false);
	
} // R98_Electronics_Bay2

//translate([0,0,162]) R98_Electronics_Bay2();


module R98_Electronics_Bay5(Tube_OD=R98_Body_OD, Tube_ID=R98_Body_ID, 
					Fairing_ID=Fairing_ID, InnerTube_OD=BT38Body_OD){
					
	// *** Altimeter, Battery Door w/o Switch, 2 Battery Doors w/ Switches, Centering Rings Top and Bottom ***
	// *** For Dual Deployment w/ 2 Ball Lock Units ***
	
	Len=150;
	Altimeter_Z=75;
	BattSwDoor_Z=70;
	TopSkirt_Len=15;
	BottomSkirt_Len=15;
	Alt1_a=0;
	//Alt2_a=180;
	Batt3_a=90; // Altimeter Battery
	Batt1_a=180; // Rocket Servo 1 Battery & Switch
	Batt2_a=270; // Rocket Servo 2 Battery & Switch
	
	nCRHoles=4;
	
	/*
	// The Fairing clamps onto this. 
	translate([0,0,Len]) FairingBaseLockRing(Tube_OD=Tube_OD, Tube_ID=Tube_ID, Fairing_ID=Fairing_ID, Interface=Overlap, BlendToTube=true);
	/**/
	
	difference(){
		union(){
			Tube(OD=Tube_OD, ID=Tube_ID, Len=Len, myfn=$preview? 36:360);
			
			translate([0,0,BottomSkirt_Len]) rotate([0,0,45])
				CenteringRing(OD=Tube_OD-1, ID=InnerTube_OD+IDXtra*2, Thickness=5, nHoles=nCRHoles);
			translate([0,0,Len-5-TopSkirt_Len]) rotate([0,0,45])
				CenteringRing(OD=Tube_OD-1, ID=InnerTube_OD+IDXtra*2, Thickness=5, nHoles=nCRHoles);
	} // union
		
		// Altimeter 1
		translate([0,0,Altimeter_Z]) rotate([0,0,Alt1_a]) 
			Alt_BayFrameHole(Tube_OD=Tube_OD, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y);
			
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt3_a]) 
			Batt_BayFrameHole(Tube_OD=Tube_OD, HasSwitch=false);
			
		// Altimeter 2
		//translate([0,0,Altimeter_Z]) rotate([0,0,Alt2_a]) 
		//	Alt_BayFrameHole(Tube_OD=Tube_OD, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y);
		
		// Battery and Switch door holes
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
			Batt_BayFrameHole(Tube_OD=Tube_OD, HasSwitch=true);
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt2_a]) 
			Batt_BayFrameHole(Tube_OD=Tube_OD, HasSwitch=true);
		
	} // difference
	
	// Altimeter 1
	translate([0,0,Altimeter_Z]) rotate([0,0,Alt1_a])
		Alt_BayDoorFrame(Tube_OD=Tube_OD, Tube_ID=Tube_ID, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowDoor=false);
	
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt3_a]) 
		Batt_BayDoorFrame(Tube_OD=Tube_OD, HasSwitch=false, ShowDoor=false);
		
	// Altimeter 2
	//translate([0,0,Altimeter_Z]) rotate([0,0,Alt2_a])
	//	Alt_BayDoorFrame(Tube_OD=Tube_OD, Tube_ID=Tube_ID, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowDoor=false);
	
	// Battery and Switch door2
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
		Batt_BayDoorFrame(Tube_OD=Tube_OD, HasSwitch=true, ShowDoor=false);
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt2_a]) 
		Batt_BayDoorFrame(Tube_OD=Tube_OD, HasSwitch=true, ShowDoor=false);
	
} // R98_Electronics_Bay5

//R98_Electronics_Bay5();


module R98_BallRetainerBottom(){
	// Has bolt holes for PetalHub
	nLockBalls=6;
	
	difference(){
		STB_BallRetainerBottom(BallPerimeter_d=R98_Body_OD, Body_OD=R98_Body_ID,
					nLockBalls=nLockBalls, HasSpringGroove=false);
		
		rotate([0,0,5]) 
			PD_PetalHubBoltPattern(Coupler_OD=Coupler_OD, nPetals=nLockBalls) Bolt4Hole();
	} // difference
} // R98_BallRetainerBottom

// translate([0,0,-8]) rotate([180,0,185]) R98_BallRetainerBottom();

module UpperFinCan(){
	// Upper Half of Fin Can
	
	rotate([180,0,0]) 
		FinCan(Tube_OD=R98_Body_OD, Tube_ID=R98_Body_ID, MtrTube_OD=R98_MtrTube_OD+IDXtra*2, nFins=nFins,
			Post_h=R98_Fin_Post_h, Root_L=R98_Fin_Root_L, Root_W=R98_Fin_Root_W, 
			Chamfer_L=R98_Fin_Chamfer_L, HasTailCone=false); 

} // UpperFinCan

//UpperFinCan();

module LowerFinCan(){
	
	difference(){
		FinCan(Tube_OD=R98_Body_OD, Tube_ID=R98_Body_ID, MtrTube_OD=R98_MtrTube_OD+IDXtra*2, nFins=nFins, 
			Post_h=R98_Fin_Post_h, Root_L=R98_Fin_Root_L, Root_W=R98_Fin_Root_W, 
			Chamfer_L=R98_Fin_Chamfer_L, 
			HasTailCone=true,
					MtrRetainer_OD=R98_MtrTube_OD+5,
					MtrRetainer_L=20,
					MtrRetainer_Inset=7); // Lower Half of Fin Can
		
		translate([0,0,80]) rotate([0,0,-90-180/nFins]) 
			translate([0,R98_Body_OD/2+2,0]) RailGuideBoltPattern(BoltSpace=12.7) Bolt6Hole();
	} // difference
		


	difference(){
		translate([0,0,80]) rotate([0,0,-90-180/nFins]) 
			RailGuidePost(OD=R98_Body_OD, MtrTube_OD=R98_MtrTube_OD+IDXtra*2, H=R98_Body_OD/2+2, TubeLen=70, Length = 40, BoltSpace=12.7);
		translate([0,0,50]) TrapFin2Slots(Tube_OD=R98_Body_OD, nFins=nFins, 	
			Post_h=R98_Fin_Post_h, Root_L=R98_Fin_Root_L, Root_W=R98_Fin_Root_W, Chamfer_L=R98_Fin_Chamfer_L);
	} // difference

} // LowerFinCan

// LowerFinCan();

module Rocket98Fin(){
	TrapFin2(Post_h=R98_Fin_Post_h, Root_L=R98_Fin_Root_L, Tip_L=R98_Fin_Tip_L, 
			Root_W=R98_Fin_Root_W, Tip_W=R98_Fin_Tip_W, 
			Span=R98_Fin_Span, Chamfer_L=R98_Fin_Chamfer_L,
					TipOffset=R98_Fin_TipOffset);

	if ($preview==false){
		translate([-R98_Fin_Root_L/2+10,0,0]) cylinder(d=R98_Fin_Root_W*2.5, h=0.9); // Neg
		translate([R98_Fin_Root_L/2-10,0,0]) cylinder(d=R98_Fin_Root_W*2.5, h=0.9); // Pos
	}
} // Rocket98Fin

// Rocket98Fin();


































