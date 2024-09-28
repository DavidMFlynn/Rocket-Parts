// ***********************************
// Project: 3D Printed Rocket
// Filename: Rocket9852.scad
// by David M. Flynn
// Created: 5/13/2023 
// Revision: 0.9.18  9/25/2024
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
//  Flew to 4200' on J615ST >> J275W
//  Threaded forward closures are required to connect the shock cord to the motor. 
//
//  The Sustainer has a Mission Control V3 for detection of booster separation,
//  motor ignition if staged. A second MCv3 for apogee deployment and main deployment. Uses
//  cable puller for fairing main deployment, uses SpringThingBooster and spring loaded
//  drogue deployment.
//
//  The Booster has a Mission Control V3 for stage separation and
//  apogee deployment using SpringThingBooster. Has a Stager and SpringThingBooster for Main only deployment.
//
//  ***** Where does it go? *****
//  From top down the orientation of the main parts. 
//
//  Nosecone 
//
//  Fairing
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
// 0.9.18  9/25/2024  Added Bolted Booster E-Bay and extention ring.
// 0.9.17  9/17/2024  Changed to ball bearing version of stager.
// 0.9.16  8/31/2024  Updated to current standards and practices.
// 0.9.15  5/5/2024   Updated booster for J800T, 8.5" tube, petal deployment, dome and more
// 0.9.14  8/26/2023  Added 2mm to alt door X, Added big spring ends
// 0.9.13  5/31/2023  Added shock cord mount to Booster_Stager_CableRedirect().
// 0.9.12  5/28/2023  New dual deploy using 2 ball locks.
// 0.9.11  5/27/2023  Converted to Blue Tube
// 0.9.10  5/25/2023  Got upper rail guide?
// 0.9.9  5/21/2023   Stubby nosecone.
// 0.9.8  5/17/2023   Sustainer electronic bays.
// 0.9.7  5/13/2023   Copied from Rocket9852.scad
//
// ***********************************
//  ***** for STL output *****
//
// BluntOgiveNoseCone(ID=Body_ID, OD=Body_OD, L=NC_Len, Base_L=NC_Base, Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=0, LowerPortion=false);
// NC_ShockcordRingDual(Tube_OD=Body_OD, Tube_ID=Body_ID, NC_Base_L=NC_Base, nRivets=3);
// SE_SlidingSpringMiddle(OD=Coupler_OD, nRopes=6, SliderLen=25, SpLen=40, SpringStop_Z=20);
// -------------------------
//
// PD_NC_PetalHub(OD=Coupler_OD, nPetals=nPetals, nRopes=6, ShockCord_a=-1, HasThreadedCore=false);
// rotate([-90,0,0]) PD_PetalSpringHolder(OD=Coupler_OD);
// rotate([180,0,0]) PD_Petals(OD=Coupler_OD, Len=110, nPetals=nPetals, Wall_t=1.8, AntiClimber_h=4, HasLocks=false, Lock_Span_a=0);
//
// SE_SpringSpacer(OD=Coupler_OD, Tube_ID=Coupler_OD-2.4, Len=150);
//
// rotate([0,-90,0]) TubeBoltedRailGuide(TubeOD=Body_OD, Length = 35, Offset = 5);
//
// -----------------------------
//  *** Electronics Bay ***
//
/* 
	rotate([180,0,0]) EB_Electronics_BayUniversal(Tube_OD=Body_OD, Tube_ID=Body_ID, DoorAngles=AltBattTwoBattSWBay, Len=EBay_Len, 
									nBolts=4, BoltInset=7.5, ShowDoors=false,
									HasFwdIntegratedCoupler=false, HasFwdShockMount=false,
									HasAftIntegratedCoupler=false, HasAftShockMount=false,
									HasRailGuide=false, RailGuideLen=35,
									Bolted=false, TopOnly=false, BottomOnly=false); 
/**/
//
// R98C_BallRetainerTop(Body_OD=Body_OD, Body_ID=Body_ID);
//
// ------------
// *** Body Tube: PML 3.9" QT, 455mm Long ***
// *** Motor Tube: Blue Tube 2.0, 54mm Body Tube, 235mm Long ***
// ------------
//
// rotate([180,0,0]) Lower_Electronics_Bay();
//
// UpperFinCan();
// Fin();
// rotate([180,0,0]) LowerFinCan();
//
// _________________________________________________________
//  **** Booster Parts ****
//
// --------------
//  ** Stager Parts, top of booster **
// rotate([180,0,0]) Stager_Sustainer_Cup(Tube_OD=Body_OD, nLocks=nLocks, MotorTube_OD=MtrTube_OD, Motor_Len=10, nFins=5, StagerCollarLen=16);
// rotate([180,0,0]) 


// rotate([-90,0,0]) Stager_LockRod(Adj=-0.5); // too tight
// rotate([-90,0,0]) Stager_LockRod(Adj=0.0);
// rotate([-90,0,0]) Stager_LockRod(Adj=1.0); // print 4
//
// Stager_Saucer(Tube_OD=Body_OD, nLocks=nLocks);
//
// Stager_LockRing(Tube_OD=Body_OD, nLocks=nLocks); 
// Stager_Mech(Tube_OD=Body_OD, nLocks=nLocks, Skirt_ID=Body_ID, Skirt_Len=Booster_Stager_Skirt_Len, nSkirtBolts=4, ShowLocked=true);
// Stager_OuterBearingCover(Tube_OD=Body_OD, nLocks=nLocks); // Secures Outer Race of Main Bearing
//
// rotate([180,0,0]) Stager_Indexer(Tube_OD=Body_OD, nLocks=nLocks); // Secures Inner Race of Main Bearing and has Lock Stops
// Stager_ServoPlate(Tube_OD=Body_OD, Skirt_ID=Body_ID, nLocks=nLocks, OverCenter=IDXtra+0.2, Servo_ID=ServoMS75_ID);
// rotate([180,0,0]) Stager_ServoMount(Servo_ID=ServoMS75_ID);
//
// -------------
//  ** Booster Electronics Bay **
//
// EB_ExtensionRing(Tube_OD=Body_OD, Tube_ID=Body_ID, Len=10, nBolts=4, BoltInset=7.5);
// 
// rotate([180,0,0]) Electronics_Bay_Booster(TopOnly=true, BottomOnly=false);
// Electronics_Bay_Booster(TopOnly=false, BottomOnly=true);
//
//  *** Doors ***
// rotate([-90,0,0]) EB_AltDoor(Tube_OD=BT98Body_OD);
// rotate([-90,0,0]) EB_BattDoor(Tube_OD=BT98Body_OD, HasSwitch=false, DoubleBatt=false);
// rotate([-90,0,0]) EB_BattDoor(Tube_OD=BT98Body_OD, HasSwitch=true, DoubleBatt=false);
//
// -------------
//  ** Ball Lock Parts for Booster Parachute Deployment **
//
// STB_LockDisk(BallPerimeter_d=Body_OD, nLockBalls=nLockBalls);

// rotate([180,0,0]) STB_BallRetainerTop(BallPerimeter_d=Body_OD, Body_OD=Body_ID, nLockBalls=nLockBalls, HasIntegratedCouplerTube=true, IntegratedCouplerLenXtra=-15, Body_ID=Body_ID, HasSecondServo=true, UsesBigServo=true, Engagement_Len=20);
// R98C_BallRetainerBottom();
// STB_BallRetainerBottom(BallPerimeter_d=Body_OD, Body_OD=Body_ID, nLockBalls=nLockBalls, HasSpringGroove=false, Engagement_Len=20);
// rotate([180,0,0]) STB_TubeEnd(BallPerimeter_d=PML98Body_OD, nLockBalls=nLockBalls, Body_OD=PML98Body_OD, Body_ID=PML98Body_ID, Skirt_Len=20);
//
// -------------
/*
//translate([0,0,-10]) rotate([0,180,28])
PD_PetalHub(OD=Coupler_OD, 
					nPetals=nPetals, 
					HasBolts=true,
					ShockCord_a=PD_ShockCordAngle(),
					HasNCSkirt=false, 
						Body_OD=BT75Body_OD,
						Body_ID=BT75Body_ID,
						NC_Base=NC_Base, 
						SkirtLen=10);
/**/
// -------------
// rotate([180,0,0]) SE_SpringCupTOMT(Tube_ID=BT98Coupler_OD, nRopeHoles=6);
// rotate([180,0,0]) SE_SpringCupTOMT(OD=Coupler_OD); // Top Of Motor Tube Spring Holder
// -------------
// *** Motor Tube: Blue Tube 2.0, 54mm Body Tube, 272-274mm Long ***
// *** Body Tube: PML 3.9" QT, 140mm Long ***
// -------------
// BoosterUpperFinCan();
// BoosterFin();
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
// ShowBooster();
// ShowRocket();
//
// ***********************************
include<TubesLib.scad>
use<NoseCone.scad>
use<R98Lib.scad>
use<SpringEndsLib.scad>
use<PetalDeploymentLib.scad>
use<RailGuide.scad>
use<FinCan2Lib.scad>
use<Fins.scad>
include<Stager75BBLib.scad>
use<SpringThingBooster.scad>
use<ElectronicsBayLib.scad>

//also included
 //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

nFins=5;
nLocks=3;

// constants for 98mm stager
Default_nLocks=3;
DefaultBody_OD=BT98Body_OD;
DefaultBody_ID=BT98Body_ID;
DefaultMotorTube_OD=BT54Body_OD;
DefaultServo=ServoMS75_ID;
MainBearing_OD=Bearing6809_OD;
MainBearing_ID=Bearing6809_ID;
MainBearing_T=Bearing6809_T;

// Sustainer Fin
Fin_Post_h=12;
Fin_Root_L=180;
Fin_Root_W=10;
Fin_Tip_W=4;
Fin_Tip_L=80;
Fin_Span=110;
Fin_TipOffset=25;
Fin_Chamfer_L=22;

// Booster Fin
BoosterFinScale=1.2;
Booster_Fin_Post_h=12;
Booster_Fin_Root_L=Fin_Root_L*BoosterFinScale;
Booster_Fin_Root_W=Fin_Root_W*BoosterFinScale;
Booster_Fin_Tip_W=Fin_Tip_W*BoosterFinScale;
Booster_Fin_Tip_L=Fin_Tip_L*BoosterFinScale;
Booster_Fin_Span=Fin_Span*BoosterFinScale;
Booster_Fin_TipOffset=Fin_TipOffset*BoosterFinScale;
Booster_Fin_Chamfer_L=Fin_Chamfer_L*BoosterFinScale;
BoosterFinInset=5;
BoosterFinCan_Len=Booster_Fin_Root_L+BoosterFinInset*2;

Body_OD=BT98Body_OD;
Body_ID=BT98Body_ID;
Coupler_OD=BT98Coupler_OD;
Coupler_ID=BT98Coupler_ID;
MtrTube_OD=BT54Body_OD;
MtrTube_ID=BT54Body_ID;
BoosterMtrTube_OD=BT54Mtr_OD;
DualDepTube_OD=BT54Body_OD;
DualDepTube_ID=BT54Body_ID;

EBay_Len=165;
//Booster_Body_Len=Booster_Fin_Root_L+60+116.5; // minimum length J460T
Booster_Body_Len=Booster_Fin_Root_L+60+116.5+90+170; // I229T
//echo(Booster_Body_Len=Booster_Body_Len);

FinCanExTube_Len=105;
Booster_Stager_Skirt_Len=16;
RailGuide_h=Body_OD/2+2;
TailCone_Len=65;
RailGuideLen=35;


/*
// Long nosecone
NC_Len=350;
NC_Tip_r=5;
NC_Base=15;
NC_Wall_t=2.2;
NC_Lock_H=5;
/**/
//*
NC_Len=210;
NC_Tip_r=10;
NC_Base=15;
NC_Wall_t=2.2;
NC_Lock_H=5;
/**/
nLockBalls=6;
ShockCord_a=17;// offset between PD_PetalHub and R98_BallRetainerBottom
nPetals=3;	

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


module ShowBooster(){
	FinCan_Z=0;
	Fin_Z=FinCan_Z+Booster_Fin_Root_L/2+BoosterFinInset;
	BallLock_Z=Booster_Fin_Root_L+75+48+32;
	EBay_Z=BallLock_Z+20;
	Stager_Z=EBay_Z+238;
	
	translate([0,0,Stager_Z]) color("Blue") Stager_Saucer(Tube_OD=Body_OD, nLocks=2);
	translate([0,0,Stager_Z]) Stager_Mech(Tube_OD=Body_OD, nLocks=2, Skirt_ID=Body_ID, Skirt_Len=16+15);
	
	
	translate([0,0,EBay_Z]) Electronics_Bay_Booster();
	
	translate([0,0,BallLock_Z])
		STB_BallRetainerTop(BallPerimeter_d=PML98Body_OD, Body_OD=PML98Body_ID, nLockBalls=nLockBalls, HasIntegratedCouplerTube=true, IntegratedCouplerLenXtra=-15, Body_ID=PML98Body_ID, HasSecondServo=true, UsesBigServo=true, Engagement_Len=20);

	
	//*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j+180/nFins])
		translate([0, Body_OD/2-Fin_Post_h, Fin_Z]) 
			rotate([-90,0,0]) color("Orange") BoosterFin();
	/**/
	
	translate([0,0,FinCan_Z]) color("Green") BoosterFinCan();
	
	translate([0,0,FinCan_Z-TailCone_Len]) ShowMotorI229T();
} // ShowBooster

//ShowBooster();

module ShowRocket(){
	LowerFinCan_Z=Booster_Body_Len-27;
	Fin_Z=LowerFinCan_Z+Fin_Root_L/2+55;
	UpperFinCan_Z=LowerFinCan_Z+Fin_Root_L+75;
	LowerEBay_Z=UpperFinCan_Z-14.8;
	DrogueTube_Z=LowerEBay_Z+140.2;
	STB_Droge_Z=DrogueTube_Z+FinCanExTube_Len+10;
	STB_Body_Z=STB_Droge_Z+10;
	UpperEBay_Z=STB_Body_Z+50;
	Fairing_Z=UpperEBay_Z+165+2.2;
	NoseCone_Z=Fairing_Z+Fairing_Len+2.2;
	
	TopOfFinCan_Z=Booster_Body_Len-40+Fin_Root_L+100+150;
	
	translate([0,0,NoseCone_Z]) 
	FairingConeOGive(Fairing_OD=Body_OD, 
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
	
	translate([0,0,STB_Droge_Z]) STB_TubeEnd(BallPerimeter_d=PML98Body_OD, nLockBalls=nLockBalls, Body_OD=PML98Body_OD, Body_ID=PML98Body_ID, Skirt_Len=20);
	
	translate([0,0,DrogueTube_Z])
		color("LightBlue") Tube(OD=Body_OD, ID=Body_ID, Len=FinCanExTube_Len, myfn=$preview? 36:360);
	
	translate([0,0,LowerEBay_Z]) color("LightGreen") Lower_Electronics_Bay();
	
	translate([0,0,UpperFinCan_Z]) UpperFinCan();
	//*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j])
		translate([Body_OD/2-Fin_Post_h, 0, Fin_Z]) 
			rotate([0,90,0]) color("Orange") Fin();
	/**/
	
	//*
	translate([0,0,LowerFinCan_Z]) {
		color("Tan") LowerFinCan();
		translate([0,0,5]) Stager_Cup(Tube_OD=Body_OD, ID=78, nLocks=2);
	}
	/**/
	
	//translate([0,0,Booster_Body_Len-40]) ShowMotorI229T();
	
	// 
	ShowBooster();
	
} // ShowRocket

//ShowRocket();

module Sustainer_Cup(){
	nBolts=8;
	BoltHoles=[0,1,3,4,6,7];
	Bolt_a=180/nBolts;
	BoltCircle_r=43.5;
	Collar_H=29;
	
	difference(){
		union(){
			difference(){
				Stager_Cup(Tube_OD=Body_OD, nLocks=nLocks, BoltsOn=false, Collar_h=Collar_H);
				translate([0,0,-2-Overlap]) cylinder(d=90, h=Collar_H-2);
			} // difference
			
			for (j=BoltHoles) rotate([0,0,360/nBolts*j+Bolt_a]) translate([0,BoltCircle_r,Collar_H-4])
				cylinder(d=8, h=7);
		} // union
		
		for (j=BoltHoles) rotate([0,0,360/nBolts*j+Bolt_a]) translate([0,BoltCircle_r,Collar_H-4])
			rotate([180,0,0]) Bolt4HeadHole(depth=8,lHead=Collar_H+3);
	} // difference
	
} // Sustainer_Cup

// rotate([180,0,0]) Sustainer_Cup();

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

BigSpring_OD=59;
BigSpring_ID=53;

module BigSpringTop(Tube_ID=Body_ID){
	Len=75;
	Wall_t=1.8;
	Hole_d=5;
	nHoles=6;

	Tube(OD=Tube_ID-1, ID=Tube_ID-1-Wall_t*2, Len=Len, myfn=$preview? 36:360);
	
	difference(){
		BigSpringBase(Base_OD=Tube_ID-1);
		
		for (j=[0:nHoles-1]) rotate([0,0,360/nHoles*j])
			translate([0,Tube_ID/2-Wall_t-Hole_d,-Overlap]) cylinder(d=Hole_d, h=30);
	} // difference
} // BigSpringTop

// BigSpringTop();

module BigSpringBase(Base_OD=Body_ID-9){
	// Sits on top of Lower_Electronics_Bay()
	// should be integrated into Lower_Electronics_Bay()
	
	Len=13;
	
	difference(){
		cylinder(d=Base_OD, h=Len);
		
		translate([0,0,-Overlap]) cylinder(d=BigSpring_ID, h=Len+Overlap*2);
		translate([0,0,4]) cylinder(d=BigSpring_OD, h=Len);
		translate([0,0,7]) cylinder(d=BigSpring_OD+1, h=Len);
	} // difference
} // BigSpringBase

// translate([0,0,142]) BigSpringBase();

module UpperFinCan(){
	// Upper Half of Fin Can
	
	rotate([180,0,0]) 
		FinCan(Tube_OD=Body_OD, Tube_ID=Body_ID, 
				MtrTube_OD=MtrTube_OD+IDXtra*2, nFins=nFins,
				Post_h=Fin_Post_h, Root_L=Fin_Root_L, 
				Root_W=Fin_Root_W, 
				Chamfer_L=Fin_Chamfer_L, HasTailCone=false,Xtra_Len=0,HasIntegratedCouplerTube=true); 
		
} // UpperFinCan

//translate([0,0,Fin_Root_L+75.2]) UpperFinCan();

module LowerFinCan(){
	RailGuide_Z=80;
	
	difference(){
		union(){
		//*
			FinCan(Tube_OD=Body_OD, Tube_ID=Body_ID, 
				MtrTube_OD=MtrTube_OD+IDXtra*2, nFins=nFins, 
				Post_h=Fin_Post_h, Root_L=Fin_Root_L, Root_W=Fin_Root_W, 
				Chamfer_L=Fin_Chamfer_L, 
				HasTailCone=true,
						MtrRetainer_OD=MtrTube_OD+5,
						MtrRetainer_L=20,
						MtrRetainer_Inset=7); // Lower Half of Fin Can
			
			/**/
			
			
			// Stager cup mounts here
			translate([0,0,25])
			difference(){
				cylinder(d=Body_OD, h=25, $fn=$preview? 90:360);
				translate([0,0,-Overlap]) cylinder(d=72, h=30+Overlap*2);
			} // difference
		} // union
		
		// Igniter wirs
			rotate([0,0,180/nFins]) translate([MtrTube_OD/2+8,0,0]) 
				cylinder(d=7, h=Fin_Root_L);
		
		translate([0,0,RailGuide_Z]) rotate([0,0,-90-180/nFins]) 
			translate([0,Body_OD/2+2,0]) RailGuideBoltPattern(BoltSpace=12.7) Bolt6Hole();
		
		// Booster attachment
		translate([0,0,8]) Stager_CupHoles(Tube_OD=Body_OD, nLocks=2);
		
		//if ($preview) cube([60,60,200]);
	} // difference
		

	//*
	// Rail Guide
	difference(){
		translate([0,0,RailGuide_Z]) rotate([0,0,-90-180/nFins]) 
			RailGuidePost(OD=Body_OD, MtrTube_OD=MtrTube_OD+IDXtra*2, 
				H=Body_OD/2+2, TubeLen=70, Length = 40, BoltSpace=12.7);
		
		translate([0,0,Fin_Root_L/2+55]) 
			TrapFin2Slots(Tube_OD=Body_OD, nFins=nFins, Post_h=Fin_Post_h, 
				Root_L=Fin_Root_L, Root_W=Fin_Root_W, Chamfer_L=Fin_Chamfer_L);
			
		//if ($preview) cube([60,60,200]);
	} // difference
	/**/
} // LowerFinCan

// translate([0,0,-40]) LowerFinCan();


module Fin(){
	TrapFin2(Post_h=Fin_Post_h, Root_L=Fin_Root_L, Tip_L=Fin_Tip_L, 
			Root_W=Fin_Root_W, Tip_W=Fin_Tip_W, 
			Span=Fin_Span, Chamfer_L=Fin_Chamfer_L,
					TipOffset=Fin_TipOffset);

	if ($preview==false){
		translate([0,-Fin_Root_L/2+10,0]) cylinder(d=Fin_Root_W*2.5, h=0.9); // Neg
		translate([0,Fin_Root_L/2-10,0]) cylinder(d=Fin_Root_W*2.5, h=0.9); // Pos
	}
} // Fin

// Fin();

module SustainerCup(Offset_a=7.5){
	
	difference(){
		Stager_Cup(Tube_OD=Body_OD, ID=78, nLocks=2, BoltsOn=true, Collar_h=29, Offset_a=Offset_a);
		
		ID=94;
		// Hollow out inside
		difference(){
			union(){
				cylinder(d1=78, d2=ID, h=10+Overlap);
				translate([0,0,10]) cylinder(d=ID, h=10);
				translate([0,0,20-Overlap]) cylinder(d2=78, d1=ID, h=10);
			} // union
			
			for (j=[0:1]) rotate([0,0,180*j+Offset_a]) translate([0,ID/2,15]) cube([9.5,20,40], center=true);
		} // difference
	} // difference
} // SustainerCup

//rotate([180,0,0]) SustainerCup();

//  ******************* BOOSTER PARTS *********************

module Electronics_Bay_Booster(TopOnly=false, BottomOnly=false){
	AltBattTwoBattSWBay=[[90],[0],[180,270]];

	EB_Electronics_BayUniversal(Tube_OD=Body_OD, Tube_ID=Body_ID, DoorAngles=AltBattTwoBattSWBay, Len=EBay_Len, 
									nBolts=4, BoltInset=7.5, ShowDoors=false,
									HasFwdIntegratedCoupler=false, HasFwdShockMount=false,
									HasAftIntegratedCoupler=false, HasAftShockMount=false,
									HasRailGuide=false, RailGuideLen=35,
									Bolted=true, TopOnly=TopOnly, BottomOnly=BottomOnly); 
} // Electronics_Bay_Booster

//Electronics_Bay_Booster();

module BoosterFin(){
	TrapFin2(Post_h=Booster_Fin_Post_h, Root_L=Booster_Fin_Root_L, Tip_L=Booster_Fin_Tip_L, 
			Root_W=Booster_Fin_Root_W, Tip_W=Booster_Fin_Tip_W, 
			Span=Booster_Fin_Span, Chamfer_L=Booster_Fin_Chamfer_L,
					TipOffset=Booster_Fin_TipOffset);

	if ($preview==false){
		translate([-Booster_Fin_Root_L/2+10,0,0]) 
			cylinder(d=Booster_Fin_Root_W*2.5, h=0.9); // Neg
		translate([Booster_Fin_Root_L/2-10,0,0]) 
			cylinder(d=Booster_Fin_Root_W*2.5, h=0.9); // Pos
	}
} // BoosterFin

// BoosterFin();

/*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j])
		translate([Body_OD/2-Fin_Post_h, 0, Booster_Fin_Root_L/2+55]) 
			rotate([0,90,0]) color("Orange") BoosterFin();
	/**/
	


module BoosterFinCan(LowerHalfOnly=false, UpperHalfOnly=false){

	FC2_FinCan(Body_OD=Body_OD, Body_ID=Body_ID, Can_Len=BoosterFinCan_Len,
				MotorTube_OD=BoosterMtrTube_OD, RailGuide_h=RailGuide_h,
				nFins=nFins, HasIntegratedCoupler=true, HasMotorSleeve=true, HasAftIntegratedCoupler=false,
				Fin_Root_W=Booster_Fin_Root_W, Fin_Root_L=Booster_Fin_Root_L, 
				Fin_Post_h=Booster_Fin_Post_h, Fin_Chamfer_L=Booster_Fin_Chamfer_L,
				Cone_Len=TailCone_Len, ThreadedTC=true, Extra_OD=2, RailGuideLen=RailGuideLen, 
				LowerHalfOnly=false, UpperHalfOnly=false, HasWireHoles=false);


} // BoosterFinCan

//BoosterFinCan();































