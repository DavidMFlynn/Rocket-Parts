// ***********************************
// Project: 3D Printed Rocket
// Filename: Rocket9852.scad
// by David M. Flynn
// Created: 5/13/2023 
// Revision: 0.9.9  5/21/2023
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  98mm Body 5 Fins 2 Stages
//  Two Stage Rocket.
//
//  Warning! This is a complex rocket, skill level 11!
//  The only pyrotecnics used in this rocket are the motors.
//  Motors J460T/J275W and J180T/J90W-P/I115W-P. 
//  Threaded forward closures are required to connect the shock cord to. 
//
//  The Sustainer has a Mission Control V3 for detection of booster separation,
//  motor ignition if staged. A second MCv3 for apogee deployment and main deployment. Uses
//  cable puller for fairing main deployment, uses SpringThingBooster and spring loaded
//  drogue deployment.
//
//  The Booster has a Mission Control V3 for stage separation and
//  apogee deployment using cable puller. Has a Stager and SpringThingBooster for Main only deployment.
//
//  ***** Where does it go? *****
//  From top down the orientation of the main parts. 
//
//  Nosecone 
//
//  Fairing, cable at 180°
//
//  Upper Electronics Bay 
//
//  SpringThingBooster (Ball Lock, Drogue Deployment)
//
//  Lower Electronics Bay
//
// Upper Fin Can
// Lower Fin Can
//
// Stager
//
// Booster Electronics Bay
//
// SpringThingBooster
//
// Booster Upper Fin Can
// Booster Lower Fin Can
//
//  ***** History *****
// 0.9.9  5/21/2023   Stubby nosecone.
// 0.9.8  5/17/2023   Sustainer electronic bays.
// 0.9.7  5/13/2023   Copied from Rocket9852.scad
//
// ***********************************
//  ***** for STL output *****
//
/*
// Stubby nosecone
FairingConeOGive(Fairing_OD=R9852_Body_OD, 
					FairingWall_T=FairingWall_T,
					NC_Base=NC_Base, 
					NC_Len=205, 
					NC_Wall_t=NC_Wall_t,
					NC_Tip_r=12,
					Cut_Z=0, LowerPortion=true);
/**/
/*
// Long two piece nosecone
FairingConeOGive(Fairing_OD=R9852_Body_OD, 
					FairingWall_T=FairingWall_T,
					NC_Base=NC_Base, 
					NC_Len=NC_Len, 
					NC_Wall_t=NC_Wall_t,
					NC_Tip_r=NC_Tip_r,
					Cut_Z=180, LowerPortion=true);
/**/
/*
FairingConeOGive(Fairing_OD=R9852_Body_OD, 
					FairingWall_T=FairingWall_T,
					NC_Base=NC_Base, 
					NC_Len=NC_Len, 
					NC_Wall_t=NC_Wall_t,
					NC_Tip_r=NC_Tip_r,
					Cut_Z=180, LowerPortion=false);
/**/
//
//rotate([180,0,0]) NoseLockRing(Fairing_OD=Fairing_OD, Fairing_ID =Fairing_ID);
//
// -------------------------
//  *** Fairing ***

// LargeFairing(IsLeftHalf=false, Fairing_OD=Fairing_OD, Wall_T=5, Len=Fairing_Len);
// LargeFairing(IsLeftHalf=true, Fairing_OD=Fairing_OD, Wall_T=5, Len=Fairing_Len);
// LargeBolt_On_PJ_Clip(Fairing_OD=Fairing_OD, FairingWall_t=FairingWall_T);
// LargeFairing_BoltOn_Tenon(Fairing_OD=Fairing_OD, FairingWall_t=FairingWall_T);
// FairingBaseLockRing(Tube_OD=Fairing_OD, Tube_ID=Fairing_ID, Fairing_ID=Fairing_ID, Interface=-IDXtra, BlendToTube=false);
// FairingBaseBulkPlate(Tube_ID=Fairing_ID, Fairing_ID=Fairing_ID, ShockCord_a=-1);
//
// F54_SpringEndCap();
//
// -----------------------------
//  *** Electronics Bay ***
//
// R98_Electronics_Bay4();
// FairingBaseBulkPlate(Tube_ID=R9852_Body_ID, Fairing_ID=Fairing_ID, ShockCord_a=-1);
// rotate([-90,0,0]) AltDoor54(Tube_OD=R9852_Body_OD, IsLoProfile=false, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y);
// rotate([-90,0,0]) CP_Door(Tube_OD=R9852_Body_OD, BoltBossInset=3, HasArmingSlot=true);
// BoltInServoMount();
// rotate([-90,0,0]) Batt_Door(Tube_OD=R9852_Body_OD, HasSwitch=false);
// rotate([-90,0,0]) Batt_Door(Tube_OD=R9852_Body_OD, InnerTube_OD=R9852_DualDepTube_OD, HasSwitch=true);
//
// rotate([180,0,0]) STB_BallRetainerTop(BallPerimeter_d=PML98Body_OD, Body_OD=PML98Body_ID, nLockBalls=6, HasIntegratedCouplerTube=true, IntegratedCouplerLenXtra=17, Body_ID=PML98Body_ID, HasSecondServo=true, UsesBigServo=true, Engagement_Len=20);
//
// ------------
// *** Cable Puller, 2 Req. ***
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
// rotate([180,0,0]) Lower_Electronics_Bay();
//
// UpperFinCan();
// Rocket9852Fin();
// rotate([180,0,0]) LowerFinCan();
//
// _________________________________________________________
//  **** Booster Parts ****
//
// --------------
//  ** Stager Parts, top of booster **
// rotate([180,0,0]) Stager_Cup(Tube_OD=R9852_Body_OD, ID=78, nLocks=2, BoltsOn=true, Collar_h=29);
// rotate([-90,0,0]) Stager_LockRod(Adj=-0.5); // print 4
//
// Stager_Saucer(Tube_OD=R9852_Body_OD, nLocks=2); // Bolts on
//
// Stager_Mech(Tube_OD=R9852_Body_OD, nLocks=2, Skirt_ID=R9852_Body_ID, Skirt_Len=Booster_Stager_Skirt_Len, KeyOffset_a=0, HasRaceway=false, Raceway_a=270);
// Stager_LockRing(Tube_OD=R9852_Body_OD, nLocks=2, FlexComp_d=0.8); 
// Stager_InnerRace(Tube_OD=R9852_Body_OD);
// Stager_BallSpacer(Tube_OD=R9852_Body_OD); // print 2
// Stager_CableRedirectTop(Tube_OD=R9852_Body_OD, Skirt_ID=R9852_Body_ID, InnerTube_OD=BT54Mtr_OD, HasRaceway=true, Raceway_a=270);
// Stager_CableBearing();
// Stager_CableRedirect(Tube_OD=R9852_Body_OD, Skirt_ID=R9852_Body_ID, Tube_ID=R9852_Coupler_ID, InnerTube_OD=BT54Body_OD, HasRaceway=true, Raceway_a=270);
// Stager_CableEndAndStop(Tube_OD=R9852_Body_OD);
// Stager_Detent();
//
// -------------
//  ** Booster Electronics Bay **
//
// rotate([180,0,0]) Electronics_Bay_Booster();
// rotate([-90,0,0]) AltDoor54(Tube_OD=R9852_Body_OD, IsLoProfile=false, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y);
// rotate([-90,0,0]) CP_Door(Tube_OD=R9852_Body_OD, BoltBossInset=3, HasArmingSlot=true);
// rotate([-90,0,0]) Batt_Door(Tube_OD=R9852_Body_OD, HasSwitch=true); // Print 2 Stager/Ball Lock
//
// -------------
//  ** Ball Lock Parts for Booster Parachute Deployment **
//
// STB_LockDisk(BallPerimeter_d=PML98Body_OD, nLockBalls=6);

// rotate([180,0,0]) STB_BallRetainerTop(BallPerimeter_d=PML98Body_OD, Body_OD=PML98Body_ID, nLockBalls=6, HasIntegratedCouplerTube=true, IntegratedCouplerLenXtra=-15, Body_ID=PML98Body_ID, HasSecondServo=true, UsesBigServo=true, Engagement_Len=20);
// STB_BallRetainerBottom(BallPerimeter_d=PML98Body_OD, Body_OD=PML98Body_ID, nLockBalls=6, HasSpringGroove=false, Engagement_Len=20);
// rotate([180,0,0]) STB_TubeEnd(BallPerimeter_d=PML98Body_OD, nLockBalls=6, Body_OD=PML98Body_OD, Body_ID=PML98Body_ID, Skirt_Len=20);
// STB_SpringEnd(Tube_ID=PML98Body_ID, CouplerTube_ID=BT98Coupler_ID);
//
// -------------
//
// BoosterUpperFinCan();
// Rocket9852BoosterFin();
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
//
// ***********************************
//  ***** for Viewing *****
//
// ShowBooster9852();
// ShowRocket9852();
//
// ***********************************
include<TubesLib.scad>
use<RailGuide.scad>
use<Fairing54.scad>
use<Fairing137.scad>
use<FinCan.scad>
use<Stager2Lib.scad>
use<AltBay.scad>
use<CablePuller.scad>
use<BatteryHolderLib.scad>
use<SpringThing2.scad>
use<RacewayLib.scad>
use<SpringThingBooster.scad>

//also included
 //include<NoseCone.scad>
 //include<ChargeHolder.scad>
 //include<CablePuller.scad>
 //include<FairingJointLib.scad>
 //include<Fins.scad>
 //include<BearingLib.scad>
 //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

nFins=5;

// Sustainer Fin
R9852_Fin_Post_h=12;
R9852_Fin_Root_L=180;
R9852_Fin_Root_W=10;
R9852_Fin_Tip_W=4;
R9852_Fin_Tip_L=80;
R9852_Fin_Span=110;
R9852_Fin_TipOffset=25;
R9852_Fin_Chamfer_L=22;

// Booster Fin
BoosterFinScale=1.2;
R9852Booster_Fin_Post_h=12;
R9852Booster_Fin_Root_L=R9852_Fin_Root_L*BoosterFinScale;
R9852Booster_Fin_Root_W=R9852_Fin_Root_W*BoosterFinScale;
R9852Booster_Fin_Tip_W=R9852_Fin_Tip_W*BoosterFinScale;
R9852Booster_Fin_Tip_L=R9852_Fin_Tip_L*BoosterFinScale;
R9852Booster_Fin_Span=R9852_Fin_Span*BoosterFinScale;
R9852Booster_Fin_TipOffset=R9852_Fin_TipOffset*BoosterFinScale;
R9852Booster_Fin_Chamfer_L=R9852_Fin_Chamfer_L*BoosterFinScale;

R9852_Body_OD=PML98Body_OD;
R9852_Body_ID=PML98Body_ID;
R9852_Coupler_ID=PML98Coupler_ID;
R9852_MtrTube_OD=PML54Body_OD;
R9852_MtrTube_ID=PML54Body_ID;
R9852_BoosterMtrTube_OD=BT54Mtr_OD;
R9852_DualDepTube_OD=BT54Body_OD;
R9852_DualDepTube_ID=BT54Body_ID;

EBay_Len=165;
//Booster_Body_Len=R9852Booster_Fin_Root_L+60+116.5; // minimum length J460T
Booster_Body_Len=R9852Booster_Fin_Root_L+60+116.5+90+170; // I229T
//echo(Booster_Body_Len=Booster_Body_Len);

// Fairing Overrides
Fairing_OD=PML98Body_OD;
FairingWall_T=2.2;
Fairing_ID=Fairing_OD-FairingWall_T*2;
Fairing_Len=160; // Body of the fairing.

NoseconeSep_Z=0; // This much of the nosecone becomes part of the fairing.
NC_Len=350;
NC_Tip_r=5;
NC_Base=5;
NC_Wall_t=2.2;
NC_Lock_H=5;

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

module ShowMotorI229T(){
	Casing_Len=150;
	
	color("Black") cylinder(d=57, h=10);
	translate([0,0,10]) color("Red") cylinder(d=54, h=Casing_Len);
	translate([0,0,10+Casing_Len]) color("Black"){
		cylinder(d=54, h=3);
		cylinder(d=39, h=23);
		cylinder(d=20, h=30);
	}
} // ShowMotorI229T

//ShowMotorI229T();

module ShowChuteTube(){
	Len=7*25.4;
	
	//difference(){
		cylinder(d=54, h=Len);
		
	//} // difference
} // ShowChuteTube

//ShowChuteTube();

module ShowBooster9852(){
	LowerFinCan_Z=0;
	UpperFinCan_Z=R9852Booster_Fin_Root_L+75;
	Fin_Z=R9852Booster_Fin_Root_L/2+55;
	BallLock_Z=R9852Booster_Fin_Root_L+75+48+32;
	EBay_Z=BallLock_Z+20;
	Stager_Z=EBay_Z+238;
	
	translate([0,0,Stager_Z]) color("Blue") Stager_Saucer(Tube_OD=R9852_Body_OD, nLocks=2);
	translate([0,0,Stager_Z]) Stager_Mech(Tube_OD=R9852_Body_OD, nLocks=2, Skirt_ID=R9852_Body_ID, Skirt_Len=16+15, KeyOffset_a=0, HasRaceway=false, Raceway_a=270);
	
	//translate([0,0,290]) ShowChuteTube();
	
	//translate([0,0,320]) rotate([0,0,60]) DrogueSpringThing();
	
	translate([0,0,EBay_Z]) Electronics_Bay_Booster();
	
	translate([0,0,BallLock_Z])
		STB_BallRetainerTop(BallPerimeter_d=PML98Body_OD, Body_OD=PML98Body_ID, nLockBalls=6, HasIntegratedCouplerTube=true, IntegratedCouplerLenXtra=-15, Body_ID=PML98Body_ID, HasSecondServo=true, UsesBigServo=true, Engagement_Len=20);

	translate([0,0,UpperFinCan_Z]) BoosterUpperFinCan();
	
	//*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j])
		translate([R9852_Body_OD/2-R9852_Fin_Post_h, 0, Fin_Z]) 
			rotate([0,90,0]) color("Orange") Rocket9852BoosterFin();
	/**/
	
	translate([0,0,LowerFinCan_Z]) color("Green") BoosterLowerFinCan();
	
	translate([0,0,LowerFinCan_Z]) ShowMotorI229T();
} // ShowBooster9852

//ShowBooster9852();

FinCanExTube_Len=105;

module ShowRocket9852(){
	LowerFinCan_Z=Booster_Body_Len-27;
	Fin_Z=LowerFinCan_Z+R9852_Fin_Root_L/2+55;
	UpperFinCan_Z=LowerFinCan_Z+R9852_Fin_Root_L+75;
	LowerEBay_Z=UpperFinCan_Z-14.8;
	DrogueTube_Z=LowerEBay_Z+140.2;
	STB_Droge_Z=DrogueTube_Z+FinCanExTube_Len+10;
	STB_Body_Z=STB_Droge_Z+10;
	UpperEBay_Z=STB_Body_Z+50;
	Fairing_Z=UpperEBay_Z+165+2.2;
	NoseCone_Z=Fairing_Z+Fairing_Len+2.2;
	
	TopOfFinCan_Z=Booster_Body_Len-40+R9852_Fin_Root_L+100+150;
	
	translate([0,0,NoseCone_Z]) 
	FairingConeOGive(Fairing_OD=R9852_Body_OD, 
					FairingWall_T=FairingWall_T,
					NC_Base=NC_Base, 
					NC_Len=NC_Len, 
					NC_Wall_t=NC_Wall_t,
					NC_Tip_r=NC_Tip_r,
					Cut_Z=0, LowerPortion=true);
					
	translate([0,0,Fairing_Z]) 
	F54_FairingHalf(IsLeftHalf=true, 
				Fairing_OD=Fairing_OD,
				Wall_T=FairingWall_T,
				Len=Fairing_Len);
				
	translate([0,0,UpperEBay_Z]) R98_Electronics_Bay4();
	
	translate([0,0,STB_Droge_Z]) STB_TubeEnd(BallPerimeter_d=PML98Body_OD, nLockBalls=6, Body_OD=PML98Body_OD, Body_ID=PML98Body_ID, Skirt_Len=20);
	
	translate([0,0,DrogueTube_Z])
		color("LightBlue") Tube(OD=R9852_Body_OD, ID=R9852_Body_ID, Len=FinCanExTube_Len, myfn=$preview? 36:360);
	
	translate([0,0,LowerEBay_Z]) color("LightGreen") Lower_Electronics_Bay();
	
	translate([0,0,UpperFinCan_Z]) UpperFinCan();
	//*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j])
		translate([R9852_Body_OD/2-R9852_Fin_Post_h, 0, Fin_Z]) 
			rotate([0,90,0]) color("Orange") Rocket9852Fin();
	/**/
	
	//*
	translate([0,0,LowerFinCan_Z]) {
		color("Tan") LowerFinCan();
		translate([0,0,5]) Stager_Cup(Tube_OD=R9852_Body_OD, ID=78, nLocks=2);
	}
	/**/
	
	//translate([0,0,Booster_Body_Len-40]) ShowMotorI229T();
	
	// 
	ShowBooster9852();
	
} // ShowRocket9852

//ShowRocket9852();

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
		
module R98_Electronics_Bay4(Tube_OD=R9852_Body_OD, Tube_ID=R9852_Body_ID, 
					Fairing_ID=Fairing_ID, InnerTube_OD=BT38Body_OD){
					
	// Dual Deploy Upper Electronics Bay
	
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
	CR_Thickness=5;
	
	difference(){
		union(){
			Tube(OD=Tube_OD, ID=Tube_ID, Len=Len, myfn=$preview? 36:360);
			
			translate([0,0,BottomSkirt_Len]) rotate([0,0,CRHole_a])
				CenteringRing(OD=Tube_OD-1, ID=InnerTube_OD+IDXtra*2, Thickness=CR_Thickness, 
					nHoles=nCRHoles);
			translate([0,0,Len-CR_Thickness-TopSkirt_Len]) rotate([0,0,CRHole_a])
				CenteringRing(OD=Tube_OD-1, ID=InnerTube_OD+IDXtra*2, Thickness=CR_Thickness, 
					nHoles=nCRHoles);
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

module PhantomSustainer(){
	// Combine with a Drogue_Cup to launch w/o the sustainer
	Rivet_Z=35;
	
	Stager_Cup(Tube_OD=R9852_Body_OD, ID=78, nLocks=2, BoltsOn=false, Collar_h=16, HasElectrical=true);
	
	difference(){
		// Skirt
		Tube(OD=R9852_Body_OD, ID=R9852_Body_ID, Len=50, myfn=$preview? 36:360);
	
		// Rail guide bolts
		//translate([0,0,RailGuide_Z]) rotate([0,0,-90-180/nFins]) 
		//	translate([0,R9852_Body_OD/2+2,0]) RailGuideBoltPattern(BoltSpace=12.7) Bolt6Hole();
		
		// Rivet holes
		for (j=[0:2]) rotate([0,0,120*j]) translate([0,R9852_Body_OD/2+1,Rivet_Z])
			rotate([90,0,0]) cylinder(d=4, h=5);
	} // difference
} // PhantomSustainer

//rotate([180,0,0]) PhantomSustainer();

module Lower_Electronics_Bay(Tube_OD=R9852_Body_OD, Tube_ID=R9852_Body_ID, InnerTube_OD=BT54Body_OD){
	
	Len=140;
	
	TopSkirt_Len=0;
	BottomSkirt_Len=15;
	Altimeter_Z=Len-62;
	CablePuller_Z=67+BottomSkirt_Len;
	BattSwDoor_Z=Len-45;
	Alt1_a=0;
	//Alt2_a=180;
	//CP1_a=180;
	Batt1_a=180; // Alt 1 Battery
	Batt2_a=270; // Rocket Servo 2 Battery & Switch
	nCRHoles=4;
	CRHole_a=0;	
	
	difference(){
		union(){
			Tube(OD=Tube_OD, ID=Tube_ID, Len=Len, myfn=$preview? 36:360);
			
			translate([0,0,Len-Overlap])
			Tube(OD=Tube_ID, ID=Tube_ID-8, Len=15, myfn=$preview? 36:360);
			
			//translate([0,0,BottomSkirt_Len]) rotate([0,0,CRHole_a])
				//CenteringRing(OD=Tube_OD-1, ID=InnerTube_OD+IDXtra*2, Thickness=5, nHoles=nCRHoles);
			translate([0,0,Len-5-TopSkirt_Len]) rotate([0,0,CRHole_a])
				CenteringRing(OD=Tube_OD-1, ID=InnerTube_OD+IDXtra*2, Thickness=5, nHoles=nCRHoles);
		} // union
		
		// Altimeter 1
		translate([0,0,Altimeter_Z]) rotate([0,0,Alt1_a]) 
			Alt_BayFrameHole(Tube_OD=Tube_OD, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y);
			
		// Cable Puller door hole
		//translate([0,0,CablePuller_Z]) rotate([0,0,CP1_a])
		//	CP_BayFrameHole(Tube_OD=Tube_OD);
			
		// Altimeter 2
		//translate([0,0,Altimeter_Z]) rotate([0,0,Alt2_a]) 
		//	Alt_BayFrameHole(Tube_OD=Tube_OD, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y);
		
		// Battery and Switch door holes
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
			Batt_BayFrameHole(Tube_OD=Tube_OD, HasSwitch=false);
		//translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt2_a]) 
			//Batt_BayFrameHole(Tube_OD=Tube_OD, HasSwitch=true);
		
		//
		if ($preview) translate([0,0,-Overlap]) cube([60,60,200]);
	} // difference
	
	// Altimeter 1
	translate([0,0,Altimeter_Z]) rotate([0,0,Alt1_a])
		Alt_BayDoorFrame(Tube_OD=Tube_OD, Tube_ID=Tube_ID, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowDoor=false);
	
	// Cable Puller
	//translate([0,0,CablePuller_Z]) rotate([0,0,CP1_a])
		//CP_BayDoorFrame(Tube_OD=Tube_OD, ShowDoor=false);
		
	// Altimeter 2
	//translate([0,0,Altimeter_Z]) rotate([0,0,Alt2_a])
	//	Alt_BayDoorFrame(Tube_OD=Tube_OD, Tube_ID=Tube_ID, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowDoor=false);
	
	// Battery and Switch door2
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
		Batt_BayDoorFrame(Tube_OD=Tube_OD, Tube_ID=Tube_ID, HasSwitch=false, ShowDoor=false);
	//translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt2_a]) 
	//	Batt_BayDoorFrame(Tube_OD=Tube_OD, Tube_ID=Tube_ID, HasSwitch=true, ShowDoor=false);
	
} // Lower_Electronics_Bay

//translate([0,0,-14.8]) 
//rotate([180,0,0]) Lower_Electronics_Bay();
//UpperFinCan();

module UpperFinCan(){
	// Upper Half of Fin Can
	
	rotate([180,0,0]) 
		FinCan(Tube_OD=R9852_Body_OD, Tube_ID=R9852_Body_ID, 
				MtrTube_OD=R9852_MtrTube_OD+IDXtra*2, nFins=nFins,
				Post_h=R9852_Fin_Post_h, Root_L=R9852_Fin_Root_L, 
				Root_W=R9852_Fin_Root_W, 
				Chamfer_L=R9852_Fin_Chamfer_L, HasTailCone=false,Xtra_Len=0,HasIntegratedCouplerTube=true); 
		
} // UpperFinCan

//translate([0,0,R9852_Fin_Root_L+75.2]) UpperFinCan();

module LowerFinCan(){
	RailGuide_Z=80;
	
	difference(){
		union(){
		//*
			FinCan(Tube_OD=R9852_Body_OD, Tube_ID=R9852_Body_ID, 
				MtrTube_OD=R9852_MtrTube_OD+IDXtra*2, nFins=nFins, 
				Post_h=R9852_Fin_Post_h, Root_L=R9852_Fin_Root_L, Root_W=R9852_Fin_Root_W, 
				Chamfer_L=R9852_Fin_Chamfer_L, 
				HasTailCone=true,
						MtrRetainer_OD=R9852_MtrTube_OD+5,
						MtrRetainer_L=20,
						MtrRetainer_Inset=7); // Lower Half of Fin Can
			
			/**/
			
			
			// Stager cup mounts here
			translate([0,0,25])
			difference(){
				cylinder(d=R9852_Body_OD, h=25, $fn=$preview? 90:360);
				translate([0,0,-Overlap]) cylinder(d=72, h=30+Overlap*2);
			} // difference
		} // union
		
		// Igniter wirs
			rotate([0,0,180/nFins]) translate([R9852_MtrTube_OD/2+8,0,0]) 
				cylinder(d=7, h=R9852_Fin_Root_L);
		
		translate([0,0,RailGuide_Z]) rotate([0,0,-90-180/nFins]) 
			translate([0,R9852_Body_OD/2+2,0]) RailGuideBoltPattern(BoltSpace=12.7) Bolt6Hole();
		
		// Booster attachment
		translate([0,0,8]) Stager_CupHoles(Tube_OD=R9852_Body_OD, ID=78, nLocks=2);
		
		//if ($preview) cube([60,60,200]);
	} // difference
		

	//*
	// Rail Guide
	difference(){
		translate([0,0,RailGuide_Z]) rotate([0,0,-90-180/nFins]) 
			RailGuidePost(OD=R9852_Body_OD, MtrTube_OD=R9852_MtrTube_OD+IDXtra*2, 
				H=R9852_Body_OD/2+2, TubeLen=70, Length = 40, BoltSpace=12.7);
		
		translate([0,0,R9852_Fin_Root_L/2+55]) 
			TrapFin2Slots(Tube_OD=R9852_Body_OD, nFins=nFins, Post_h=R9852_Fin_Post_h, 
				Root_L=R9852_Fin_Root_L, Root_W=R9852_Fin_Root_W, Chamfer_L=R9852_Fin_Chamfer_L);
			
		//if ($preview) cube([60,60,200]);
	} // difference
	/**/
} // LowerFinCan

// translate([0,0,-40]) LowerFinCan();


module Rocket9852Fin(){
	TrapFin2(Post_h=R9852_Fin_Post_h, Root_L=R9852_Fin_Root_L, Tip_L=R9852_Fin_Tip_L, 
			Root_W=R9852_Fin_Root_W, Tip_W=R9852_Fin_Tip_W, 
			Span=R9852_Fin_Span, Chamfer_L=R9852_Fin_Chamfer_L,
					TipOffset=R9852_Fin_TipOffset);

	if ($preview==false){
		translate([-R9852_Fin_Root_L/2+10,0,0]) cylinder(d=R9852_Fin_Root_W*2.5, h=0.9); // Neg
		translate([R9852_Fin_Root_L/2-10,0,0]) cylinder(d=R9852_Fin_Root_W*2.5, h=0.9); // Pos
	}
} // Rocket9852Fin

// Rocket9852Fin();


//  ******************* BOOSTER PARTS *********************

Booster_Stager_Skirt_Len=17.4+15;
/*
translate([0,0,628-15])
Stager_Mech(Tube_OD=R9852_Body_OD, nLocks=2, Skirt_ID=R9852_Body_ID, Skirt_Len=Booster_Stager_Skirt_Len, KeyOffset_a=0, HasRaceway=false, Raceway_a=270);
/**/

module Booster_Stager_CableRedirect(){
	Height=14; // make it fit in the top of the EBay

	echo(R9852_Body_ID=R9852_Body_ID-8-IDXtra*3);
	
	difference(){
		Stager_CableRedirect(Tube_OD=R9852_Body_OD, Skirt_ID=R9852_Body_ID, 
			Tube_ID=R9852_Body_ID, InnerTube_OD=BT54Body_OD, HasRaceway=false, Raceway_a=270, Height=14);
			
		translate([0,0,-Height-Overlap])
		difference(){
			cylinder(d=R9852_Body_OD+1, h=Height+Overlap*2);
			
			translate([0,0,-Overlap]) cylinder(d=R9852_Body_ID-8-IDXtra*3, h=Height+Overlap*4);
		} // difference
	} // difference
} // Booster_Stager_CableRedirect

//Booster_Stager_CableRedirect();

module Electronics_Bay_Booster(Tube_OD=R9852_Body_OD, Tube_ID=R9852_Body_ID, InnerTube_OD=BT54Body_OD){
	
	Len=150;
	
	TopSkirt_Len=0;
	BottomSkirt_Len=15;
	Altimeter_Z=73+BottomSkirt_Len;
	CablePuller_Z=67+BottomSkirt_Len;
	BattSwDoor_Z=78+BottomSkirt_Len;
	Alt1_a=0;
	//Alt2_a=180;
	CP1_a=180;
	Batt1_a=90; // Rocket Servo 1 Battery & Switch
	Batt2_a=270; // Rocket Servo 2 Battery & Switch
	nCRHoles=4;
	CRHole_a=0;	
	
	difference(){
		union(){
			Tube(OD=Tube_OD, ID=Tube_ID, Len=Len, myfn=$preview? 36:360);
			
			translate([0,0,Len-Overlap])
			Tube(OD=Tube_ID, ID=Tube_ID-8, Len=15, myfn=$preview? 36:360);
			
			//translate([0,0,BottomSkirt_Len]) rotate([0,0,CRHole_a])
				//CenteringRing(OD=Tube_OD-1, ID=InnerTube_OD+IDXtra*2, Thickness=5, nHoles=nCRHoles);
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
	
} // Electronics_Bay_Booster

//translate([0,0,R9852Booster_Fin_Root_L+75+100]) Electronics_Bay_Booster();

/*
translate([0,0,R9852Booster_Fin_Root_L+75+48+32])
STB_BallRetainerTop(BallPerimeter_d=PML98Body_OD, Body_OD=PML98Body_ID, nLockBalls=6, HasIntegratedCouplerTube=true, IntegratedCouplerLenXtra=-15, Body_ID=PML98Body_ID, HasSecondServo=true, UsesBigServo=true, Engagement_Len=20);
/**/

module BoosterUpperFinCan(){
	// Upper Half of Fin Can
	
	rotate([180,0,0]) 
		FinCan(Tube_OD=R9852_Body_OD, Tube_ID=R9852_Body_ID, 
				MtrTube_OD=R9852_BoosterMtrTube_OD+IDXtra*2, nFins=nFins,
				Post_h=R9852Booster_Fin_Post_h, Root_L=R9852Booster_Fin_Root_L, 
				Root_W=R9852Booster_Fin_Root_W, 
				Chamfer_L=R9852Booster_Fin_Chamfer_L, HasTailCone=false,
				Xtra_Len=0,HasIntegratedCouplerTube=true); 
		
} // BoosterUpperFinCan

//translate([0,0,R9852Booster_Fin_Root_L+75.2]) BoosterUpperFinCan();


module Rocket9852BoosterFin(){
	TrapFin2(Post_h=R9852Booster_Fin_Post_h, Root_L=R9852Booster_Fin_Root_L, Tip_L=R9852Booster_Fin_Tip_L, 
			Root_W=R9852Booster_Fin_Root_W, Tip_W=R9852Booster_Fin_Tip_W, 
			Span=R9852Booster_Fin_Span, Chamfer_L=R9852Booster_Fin_Chamfer_L,
					TipOffset=R9852Booster_Fin_TipOffset);

	if ($preview==false){
		translate([-R9852Booster_Fin_Root_L/2+10,0,0]) 
			cylinder(d=R9852Booster_Fin_Root_W*2.5, h=0.9); // Neg
		translate([R9852Booster_Fin_Root_L/2-10,0,0]) 
			cylinder(d=R9852Booster_Fin_Root_W*2.5, h=0.9); // Pos
	}
} // Rocket9852BoosterFin

// Rocket9852BoosterFin();

/*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j])
		translate([R9852_Body_OD/2-R9852_Fin_Post_h, 0, R9852Booster_Fin_Root_L/2+55]) 
			rotate([0,90,0]) color("Orange") Rocket9852BoosterFin();
	/**/
	
module BoosterLowerFinCan(){
	// Lower Half of Fin Can
	
	RailGuide_Z=65;
	
	difference(){
		
		FinCan(Tube_OD=R9852_Body_OD, Tube_ID=R9852_Body_ID, 
			MtrTube_OD=R9852_BoosterMtrTube_OD+IDXtra*2, nFins=nFins,
			Post_h=R9852Booster_Fin_Post_h, Root_L=R9852Booster_Fin_Root_L, 
			Root_W=R9852Booster_Fin_Root_W, 
			Chamfer_L=R9852Booster_Fin_Chamfer_L, HasTailCone=true,
					MtrRetainer_OD=63,
					MtrRetainer_L=14,
					MtrRetainer_Inset=7); 
		
		translate([0,0,RailGuide_Z]) rotate([0,0,-90-180/nFins]) 
			translate([0,R9852_Body_OD/2+2,0]) RailGuideBoltPattern(BoltSpace=12.7) Bolt6Hole();
	} // difference
	
	// Rail Guide
	difference(){
		translate([0,0,RailGuide_Z]) rotate([0,0,-90-180/nFins]) 
			RailGuidePost(OD=R9852_Body_OD, MtrTube_OD=R9852_BoosterMtrTube_OD+IDXtra*2, 
				H=R9852_Body_OD/2+2, TubeLen=40, Length = 30, BoltSpace=12.7);
		
		translate([0,0,RailGuide_Z]) TrapFin2Slots(Tube_OD=R9852_Body_OD, nFins=nFins, 	
			Post_h=R9852Booster_Fin_Post_h, Root_L=R9852Booster_Fin_Root_L, 
			Root_W=R9852Booster_Fin_Root_W, Chamfer_L=R9852_Fin_Chamfer_L);
		
	} // difference
	/**/
} // BoosterUpperFinCan

//BoosterLowerFinCan();
//ShowMotorI229T();


































