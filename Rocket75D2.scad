// ***********************************
// Project: 3D Printed Rocket
// Filename: Rocket75D2.scad
// by David M. Flynn
// Created: 8/13/2024
// Revision: 0.9.2  8/21/2024
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  Two Stage Rocket with 75mm Body.
//  J460T-P to J135W-P
//
//  ***** Tubes to Cut *****
// Sustainer Upper Tube		BT75_Body	 x 300
// Sustainer Middle Tube	BT75_Body	 x 
// Sustainer Lower Tube		BT75_Body	 x 110
// Sustainer Motor Tube		BT54_Body	 x 472
//
// Booster Interstage		BT75_Body    x 390
// Booster Motor Tube		BT54_Body	 x 370
//
//  ***** History *****
// 0.9.2  8/21/2024	  Sustainer fincan updated
// 0.9.1  8/19/2024	  Mostly a booster and fincan for R75D
// 0.9.0  8/18/2024	  Copied from Omega75 which didn't look like an Omega, now just building a booster and sustainer fincan for R75D
//
// ***********************************
//  ***** for STL output *****
//
// Nosecone();
// NC_ShockcordRing75(Body_OD=Body_OD, Body_ID=Body_ID, NC_Base_L=NC_Base_L);
//
// *** Dual Deploy Electronics Bay ***
//
// EB_Electronics_Bay3(Tube_OD=Body_OD, Tube_ID=Body_ID, Len=EBay_Len, nBolts=3, BoltInset=NC_Base_L/2, DualDeploy=true, ShowDoors=false);
//
// *** Doors ***
//
// rotate([-90,0,0]) EB_AltDoor(Tube_OD=Body_OD);
// rotate([-90,0,0]) EB_BattDoor(Tube_OD=Body_OD, HasSwitch=true, DoubleBatt=false); // Print 2
//
// *** Ball Lock ***
//
// STB_LockDisk(BallPerimeter_d=Body_OD, nLockBalls=nLockBalls); // Print 2
// rotate([180,0,0]) R75_BallRetainerTop(Body_OD=Body_OD, Body_ID=Body_ID, nBolts=3); // Print 2
// R75_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID, HasPD_Ring=false); // Forward
// R75_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID, HasPD_Ring=true); // Aft
// rotate([180,0,0]) STB_TubeEnd2(BallPerimeter_d=Body_OD, nLockBalls=nLockBalls, Body_OD=Body_OD, Body_ID=Body_ID, Skirt_Len=20); // Print 2
//
// *** petal deployer ***
//
// PD_NC_PetalHub(OD=Coupler_OD, nPetals=nPetals, nRopes=3); // for dual deploy only
// R75_PetalHub(Body_OD=Body_OD, Body_ID=Body_ID); // for bottom of ebay
// rotate([-90,0,0]) PD_PetalSpringHolder();  // Print 6
// rotate([180,0,0]) PD_Petals(OD=Coupler_OD, Len=ForwardPetal_Len, nPetals=nPetals, Wall_t=1.8, AntiClimber_h=4, HasLocks=false);
// rotate([180,0,0]) PD_Petals(OD=Coupler_OD, Len=AftPetal_Len, nPetals=nPetals, Wall_t=1.8, AntiClimber_h=4, HasLocks=false);
//
// SE_SpringEndTop(OD=Coupler_OD, Tube_ID=Coupler_OD-4.4, nRopeHoles=3, CutOutCenter=true);
// SE_SlidingSpringMiddle(OD=Coupler_OD, nRopes=3);
//
//  *** Electronics Bays ***
//
// rotate([180,0,0]) EB_LowerElectronics_Bay(Tube_OD=BT75Body_OD, Tube_ID=BT75Body_ID, Len=162, nBolts=0, nFins=5, Bolted=true, TopOnly=true, BottomOnly=false,HasLowerIntegratedCoupler=true, HasRailGuide=true);
// EB_LowerElectronics_Bay(Tube_OD=BT75Body_OD, Tube_ID=BT75Body_ID, Len=162, nBolts=0, nFins=5, Bolted=true, TopOnly=false, BottomOnly=true,HasLowerIntegratedCoupler=true, HasRailGuide=true);
// 
// EB_Electronics_Bay(Tube_OD=Body_OD, Tube_ID=Body_ID, Len=EBay_Len, nBolts=4, BoltInset=7.5, ShowDoors=false, HasSecondBattDoor=false, HasFwdIntegratedCoupler=false, HasFwdShockMount=false);
//
//  *** Doors ***
// rotate([-90,0,0]) EB_AltDoor(Tube_OD=BT98Body_OD);
// rotate([-90,0,0]) EB_BattDoor(Tube_OD=BT98Body_OD, HasSwitch=false, DoubleBatt=false);
// rotate([-90,0,0]) EB_BattDoor(Tube_OD=BT98Body_OD, HasSwitch=true, DoubleBatt=false);
// 
//  *** Fins & Fin Cans ***
//
// rotate([180,0,0]) SustainerFinCan(LowerHalfOnly=true, UpperHalfOnly=false);
// SustainerFinCan(LowerHalfOnly=false, UpperHalfOnly=true);
// RocketFin();
//
// *********************
//  ***** BOOSTER *****
//
//  *** 3 Inch Stager ***
//
// rotate([180,0,0]) Stager_Cup(Tube_OD=Body_OD, ID=BT54Body_ID, nLocks=nLocks, BoltsOn=true, Collar_h=17.5, Offset_a=0); // a.k.a. Sustainer Motor Retainer
// rotate([-90,0,0]) Stager_LockRod(Adj=0.0);
//
// Stager_Saucer(Tube_OD=Body_OD, nLocks=nLocks); // Bolts on
//
// Stager_LockRing(Tube_OD=Body_OD, nLocks=nLocks, FlexComp_d=0.0); 
// Stager_LockStop(Tube_OD=Body_OD, HasMagnet=true);
// Stager_LockStop(Tube_OD=Body_OD, HasMagnet=false);
//
// Stager_Mech(Tube_OD=Body_OD, nLocks=nLocks, Skirt_ID=Body_ID, Skirt_Len=35, nSkirtBolts=nBoltsBooster, ShowLocked=true);
// Stager_OuterBearingCover(nLocks=nLocks); // Secures Outer Race of Main Bearing
//
// Stager_InnerRace(Tube_OD=Body_OD);
// Stager_ServoPlate(Tube_OD=Body_OD, Skirt_ID=Body_ID);
//
//  * Booster E_Bay *
//
// EB_Electronics_Bay(Tube_OD=Body_OD, Tube_ID=Body_ID, Len=EBay_Len, nBolts=nBoltsBooster, BoltInset=7.5, ShowDoors=false, HasSecondBattDoor=false, HasFwdIntegratedCoupler=true, HasFwdShockMount=false);
//
// *** Doors ***
//
// rotate([-90,0,0]) EB_AltDoor(Tube_OD=Body_OD);
// rotate([-90,0,0]) EB_BattDoor(Tube_OD=Body_OD, HasSwitch=false, DoubleBatt=false);
// rotate([-90,0,0]) EB_BattDoor(Tube_OD=Body_OD, HasSwitch=true, DoubleBatt=false);
//
//  *** Ball Lock ***
//
// R75_BallRetainerTop(Body_OD=Body_OD, Body_ID=Body_ID, nBolts=nBoltsBooster);
// STB_LockDisk(BallPerimeter_d=BallPerimeter_d, nLockBalls=nLockBalls, HasLargeInnerBearing=false);
// STB_BallRetainerBottom(BallPerimeter_d=BallPerimeter_d, Body_OD=Body_ID, nLockBalls=nLockBalls, HasSpringGroove=false, Engagement_Len=20, HasLargeInnerBearing=false);
// R75_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID, HasPD_Ring=true);
// STB_TubeEnd2(BallPerimeter_d=BallPerimeter_d, nLockBalls=nLockBalls, Body_OD=Body_OD, Body_ID=Body_ID, Skirt_Len=20);
//
//  *** Petal Deployer ***
//
// R75_PetalHub(Body_OD=Body_OD, Body_ID=Body_ID);
// rotate([180,0,0]) PD_Petals(OD=Coupler_OD, Len=BoosterPetalLen, nPetals=3, Wall_t=1.8, AntiClimber_h=4, HasLocks=false, Lock_Span_a=180);
// rotate([-90,0,0]) PD_PetalSpringHolder();
//
// SE_SpringEndTop(OD=Coupler_OD, Tube_ID=Coupler_OD-4.4, nRopeHoles=3, CutOutCenter=true);
// SE_SlidingSpringMiddle(OD=Coupler_OD, nRopes=3);
// SE_SpringEndBottom(OD=Coupler_OD, Tube_ID=Coupler_OD-2.4, Len=30, nRopeHoles=3, CutOutCenter=true);
//
// CenteringRing(OD=Body_ID, ID=MotorTube_OD, Thickness=7, nHoles=5, Offset=0, myfn=$preview? 36:90);
// rotate([180,0,0]) BoosterFinCan(LowerHalfOnly=true, UpperHalfOnly=false);
// BoosterFinCan(LowerHalfOnly=false, UpperHalfOnly=true);
// rotate([90,0,0]) BoltOnRailGuide(Length = RailGuideLen, BoltSpace=12.7, RoundEnds=true, ExtraBack=0);
// BoosterMotorRetainer();
// BoosterFin();
//
// ***********************************
//  ***** Routines *****
//
//
// ***********************************
//  ***** for Viewing *****
//
// ShowRocket(ShowInternals=true);
// ShowRocket(ShowInternals=false);
//
// ShowBooster(ShowInternals=true);
// ShowBooster(ShowInternals=false);
//
// ***********************************
include<TubesLib.scad>
use<AT-RMS-Lib.scad>
use<R75Lib.scad>
use<PetalDeploymentLib.scad>
use<ElectronicsBayLib.scad>
use<Stager75BBLib.scad>
use<FinCan2Lib.scad>
use<NoseCone.scad>
use<FinCan.scad>
use<BatteryHolderLib.scad>
use<SpringEndsLib.scad>
use<SpringThingBooster.scad>
use<RailGuide.scad>

//also included
 //include<Fins.scad>
 //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

Body_OD=BT75Body_OD;
Body_ID=BT75Body_ID;
Coupler_OD=BT75Coupler_OD;
Coupler_ID=BT75Coupler_ID;
MotorTube_OD=BT54Body_OD;
MotorTube_ID=BT54Body_ID;
Stager_ID=MotorTube_OD;

nLocks=3; // Stager locks
nBoltsBooster=4;
nLockBalls=5; // Ball Lock (STB) units
BallPerimeter_d=Body_OD;

BoosterPetalLen=150;

// 5 smaller fins, from R75D
nFins=5;
R75D_Fin_Post_h=10;
R75D_Fin_Root_L=190;
R75D_Fin_Root_W=8;
R75D_Fin_Tip_W=3.0;
R75D_Fin_Tip_L=83;
R75D_Fin_Span=83;
R75D_Fin_TipOffset=24;
R75D_Fin_Chamfer_L=22;
R75D_FinInset_Len=10;

Sustainer_Fin_Post_h=R75D_Fin_Post_h;
Sustainer_Fin_Root_L=R75D_Fin_Root_L;
Sustainer_Fin_Root_W=R75D_Fin_Root_W;
Sustainer_Fin_Tip_W=R75D_Fin_Tip_W;
Sustainer_Fin_Tip_L=R75D_Fin_Tip_L;
Sustainer_Fin_Span=R75D_Fin_Span;
Sustainer_Fin_TipOffset=R75D_Fin_TipOffset;
Sustainer_Fin_Chamfer_L=R75D_Fin_Chamfer_L;

FinScale=1.25;

Booster_Fin_Post_h=R75D_Fin_Post_h;
Booster_Fin_Root_L=Sustainer_Fin_Root_L*FinScale;
Booster_Fin_Root_W=Sustainer_Fin_Root_W*FinScale;
Booster_Fin_Tip_W=Sustainer_Fin_Tip_W*FinScale;
Booster_Fin_Tip_L=Sustainer_Fin_Tip_L*FinScale;
Booster_Fin_Span=Sustainer_Fin_Span*FinScale;
Booster_Fin_TipOffset=Sustainer_Fin_TipOffset*FinScale;
Booster_Fin_Chamfer_L=Sustainer_Fin_Chamfer_L*FinScale;

EBay_Len=162;
RailGuide_h=Body_OD/2+2;
RailGuideLen=30;
TailConeLen=35;

UpperTube_Len=300;
MiddleTube_Len=310;
LowerTube_Len=110; // Can be adjusted to fit motor tube length
SustainerFinInset=5;
SusFinCan_Len=Sustainer_Fin_Root_L+SustainerFinInset*2;
BoosterFinInset=5;
BoostFinCan_Len=Booster_Fin_Root_L+BoosterFinInset*2;
InterstageTube_Len=390;
SustainerMotorTube_Len=SusFinCan_Len+LowerTube_Len+EBay_Len;
Body_Len=UpperTube_Len+EBay_Len+LowerTube_Len+SusFinCan_Len;
echo(Body_Len=Body_Len);
BoosterMotorTubeLen=370; // fits J800

// Phenolic Body and Coupler Tube Lengths
echo("Upper Body Tube = ",UpperTube_Len);
echo("Middle Body Tube = ",MiddleTube_Len);
echo("Lower Body Tube = ",LowerTube_Len);
echo("Sustainer Motor Tube = ",SustainerMotorTube_Len);
echo("Booster Body = ",InterstageTube_Len);
echo("Booster Motor Tube = ",BoosterMotorTubeLen);

NoseconeSep_Z=0; // This much of the nosecone becomes part of the fairing.
NC_Len=320; // was 324
NC_Tip_r=7; // was 9.5
NC_Base_L=15;
NC_Wall_t=1.8;



module ShowBooster(ShowInternals=true){
	FinCan_Z=0;
	Fin_Z=FinCan_Z+Booster_Fin_Root_L/2+BoosterFinInset;
	Body_Z=FinCan_Z+BoostFinCan_Len+0.1;
	STB_Z=Body_Z+InterstageTube_Len+10;
	Ebay_Z=STB_Z+23.5;
	Stager_Z=Ebay_Z+EBay_Len+0.1+15+57;
	Saucer_Z=Stager_Z+0.1;

	translate([0,0,Saucer_Z]) Stager_Saucer(Tube_OD=Body_OD, nLocks=nLocks);
	translate([0,0,Stager_Z]) 
		Stager_Mech(Tube_OD=Body_OD, nLocks=nLocks, Skirt_ID=Body_ID, Skirt_Len=35, nSkirtBolts=4, ShowLocked=true);
	
	//translate([0,0,Adaptor_Z]) EB_ExtensionRing(Tube_OD=BT75Body_OD, Tube_ID=BT75Body_ID, Len=21, nBolts=4, BoltInset=7.5);
	
	//*
	translate([0,0,Ebay_Z]) 
		EB_Electronics_Bay(Tube_OD=Body_OD, Tube_ID=Body_ID, Len=EBay_Len, nBolts=4, BoltInset=7.5, ShowDoors=false, HasSecondBattDoor=false, HasFwdIntegratedCoupler=true, HasFwdShockMount=false);
	/**/
	
	translate([0,0,STB_Z+0.1]) 
		STB_BallRetainerTop(BallPerimeter_d=BallPerimeter_d, Outer_OD=Body_OD, Body_OD=Body_ID, nLockBalls=nLockBalls, HasIntegratedCouplerTube=true, Body_ID=Body_ID, HasSecondServo=false, UsesBigServo=false, Engagement_Len=20, HasLargeInnerBearing=false);
	
	if (ShowInternals) translate([0,0,STB_Z]) {
		R75_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID, HasPD_Ring=true);
		translate([0,0,-19.1]) rotate([180,0,200]) R75_PetalHub(Body_OD=Body_OD, Body_ID=Body_ID);
		translate([0,0,-28]) rotate([180,0,200]) PD_Petals(OD=Coupler_OD, Len=BoosterPetalLen, nPetals=3, Wall_t=1.8, AntiClimber_h=4, HasLocks=false, Lock_Span_a=180);
		
		translate([0,0,-67-BoosterPetalLen]) 
			{ SE_SpringEndTop(OD=Coupler_OD, Tube_ID=Coupler_OD-4.4, nRopeHoles=3, CutOutCenter=true);
			translate([0,0,-42]) 
				{ SE_SlidingSpringMiddle(OD=Coupler_OD, nRopes=3);
				translate([0,0,-4]) rotate([180,0,0]) 
					
				SE_SpringEndBottom(OD=Coupler_OD, Tube_ID=Coupler_OD-2.4, Len=30, nRopeHoles=3, CutOutCenter=true);
				}
			}
	}
	
	if (ShowInternals==false) translate([0,0,STB_Z]) 
		STB_TubeEnd2(BallPerimeter_d=BallPerimeter_d, nLockBalls=nLockBalls, Body_OD=Body_OD, Body_ID=Body_ID, Skirt_Len=20);
	
	if (ShowInternals==false)
		translate([0,0,Body_Z]) color("White") 
			Tube(OD=Body_OD, ID=Body_ID, Len=InterstageTube_Len-0.2, myfn=$preview? 90:360);
	
	translate([0,0,FinCan_Z]) color("White") BoosterFinCan();
	translate([0,0,FinCan_Z]) color("White") BoosterMotorRetainer();
	
	if (ShowInternals) 
			translate([0,0,-23]) color("Tan") 
			Tube(OD=MotorTube_OD, ID=MotorTube_ID, Len=BoosterMotorTubeLen, myfn=$preview? 90:360);
									
	for (j=[0:nFins]) rotate([0,0,360/nFins*j+180/nFins])
		translate([0, Body_OD/2-Booster_Fin_Post_h, Fin_Z]) 
			rotate([-90,0,0]) color("Blue") BoosterFin();
			
	//if (ShowInternals) translate([0,0,-23]) ATRMS_54_852_Motor(Extended=false, HasEyeBolt=true); // J275W, J460T, J615ST
	if (ShowInternals) translate([0,0,-23]) ATRMS_54_1280_Motor(Extended=false, HasEyeBolt=true); // J800W
	
	
} // ShowBooster

//ShowBooster(ShowInternals=true);
//ShowBooster(ShowInternals=false);

module ShowRocket(ShowInternals=true){
	MidTubeLen=MiddleTube_Len;
		SusFinCan_Z=BoostFinCan_Len+InterstageTube_Len+EBay_Len+128.4;
		
		LowerTube_Z=SusFinCan_Z+SusFinCan_Len;
	
		LowerEBay_Z=SusFinCan_Z+SusFinCan_Len+LowerTube_Len-15;
		
		MidTube_Z=LowerEBay_Z+EBay_Len-15;
		
		STB_Z=LowerEBay_Z+EBay_Len+MidTubeLen-10;
		
		EBay_Z=STB_Z+23.5;
		
		UpperTube_Z=EBay_Z+EBay_Len+50;
	
		NC_Z=UpperTube_Z+UpperTube_Len;

	
	//*
	translate([0,0,NC_Z]){
		color("Orange") Nosecone();
		
		translate([0,0,-0.1])
			color("Gray") NC_ShockcordRing75(Body_OD=Body_OD, Body_ID=Body_ID, NC_Base_L=NC_Base_L);
	}
	
	if (ShowInternals==false){
		translate([0,0,UpperTube_Z+0.1]) color("White") 
			Tube(OD=Body_OD, ID=Body_ID, Len=UpperTube_Len-0.2, myfn=$preview? 90:360);
	}
		
	if (ShowInternals==false){
		translate([0,0,MidTube_Z+0.1]) color("White") 
			Tube(OD=Body_OD, ID=Body_ID, Len=MidTubeLen-0.2, myfn=$preview? 90:360);
	}
	
	translate([0,0,EBay_Z]) {
		color("White") 
			EB_Electronics_Bay(Tube_OD=Body_OD, Tube_ID=Body_ID, Len=EBay_Len, nBolts=4, BoltInset=7.5, ShowDoors=(ShowInternals==false),
				HasSecondBattDoor=false, HasFwdIntegratedCoupler=false, HasFwdShockMount=false);
	}
	
	translate([0,0,STB_Z+0.1]) 
		STB_BallRetainerTop(BallPerimeter_d=BallPerimeter_d, Outer_OD=Body_OD, Body_OD=Body_ID, nLockBalls=nLockBalls, HasIntegratedCouplerTube=true, Body_ID=Body_ID, HasSecondServo=false, UsesBigServo=false, Engagement_Len=20, HasLargeInnerBearing=false);
	
	if (ShowInternals) translate([0,0,STB_Z]) {
		R75_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID, HasPD_Ring=true);
		translate([0,0,-19.1]) rotate([180,0,200]) R75_PetalHub(Body_OD=Body_OD, Body_ID=Body_ID);
		translate([0,0,-28]) rotate([180,0,200]) PD_Petals(OD=Coupler_OD, Len=BoosterPetalLen, nPetals=3, Wall_t=1.8, AntiClimber_h=4, HasLocks=false, Lock_Span_a=180);
		
		translate([0,0,-67-BoosterPetalLen]) 
			{ SE_SpringEndTop(OD=Coupler_OD, Tube_ID=Coupler_OD-4.4, nRopeHoles=3, CutOutCenter=true);
			translate([0,0,-42]) 
				{ SE_SlidingSpringMiddle(OD=Coupler_OD, nRopes=3);
				translate([0,0,-4]) rotate([180,0,0]) 
					
				SE_SpringEndBottom(OD=Coupler_OD, Tube_ID=Coupler_OD-2.4, Len=30, nRopeHoles=3, CutOutCenter=true);
				}
			}
	}

	if (ShowInternals==false) translate([0,0,STB_Z]) 
		STB_TubeEnd2(BallPerimeter_d=BallPerimeter_d, nLockBalls=nLockBalls, Body_OD=Body_OD, Body_ID=Body_ID, Skirt_Len=20);

		
	translate([0,0,LowerEBay_Z]) rotate([0,0,-90])
		EB_LowerElectronics_Bay(Tube_OD=BT75Body_OD, Tube_ID=BT75Body_ID, Len=162, nBolts=0, Bolted=true, TopOnly=false, BottomOnly=false,HasLowerIntegratedCoupler=true, HasRailGuide=true);
		
	
	if (ShowInternals==false)
		translate([0,0,LowerTube_Z+0.1]) color("White") 
			Tube(OD=Body_OD, ID=Body_ID, Len=LowerTube_Len-0.2, myfn=$preview? 90:360);
	
	//*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j+180/nFins])
		translate([0, Body_OD/2-Sustainer_Fin_Post_h, SusFinCan_Z+Sustainer_Fin_Root_L/2+SustainerFinInset]) 
			rotate([-90,0,0]) color("Blue") RocketFin();
	/**/
	
	translate([0,0,SusFinCan_Z]) {
		
		color("White") SustainerFinCan();
		
		translate([0,0,-22.1]) Stager_Cup(Tube_OD=Body_OD, ID=BT54Body_ID, nLocks=nLocks, BoltsOn=true);
		if (ShowInternals) translate([0,0,-12]) ATRMS_54_1280_Motor(Extended=false, HasEyeBolt=true);
		
		
		if (ShowInternals) 
			color("Tan") translate([0,0,-12]) Tube(OD=MotorTube_OD, ID=MotorTube_ID, 
									Len=SustainerMotorTube_Len, myfn=$preview? 90:360);
		
		}
	
	//ShowBooster(ShowInternals=ShowInternals);
} // ShowRocket

//ShowRocket(ShowInternals=true);
//ShowRocket(ShowInternals=false);

module Nosecone(){
	BluntOgiveNoseCone(ID=Coupler_OD, OD=Body_OD, L=NC_Len, 
			Base_L=NC_Base_L, Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=0, LowerPortion=false);
	
} // Nosecone

//Nosecone();

module SustainerFinCan(LowerHalfOnly=false, UpperHalfOnly=false){
	
	Can_Len=Sustainer_Fin_Root_L+SustainerFinInset*2;
	echo(Can_Len=Can_Len);
	RailGuide_Z=50;
	WirePath_a=360/nFins*2;		
	
	difference(){
		union(){
		//*
			FC2_FinCan(Body_OD=Body_OD, Body_ID=Body_ID, Can_Len=Can_Len,
				MotorTube_OD=MotorTube_OD, RailGuide_h=RailGuide_h,
				nFins=nFins, HasIntegratedCoupler=true, HasMotorSleeve=true, HasAftIntegratedCoupler=false,
				Fin_Root_W=Sustainer_Fin_Root_W, Fin_Root_L=Sustainer_Fin_Root_L, 
				Fin_Post_h=Sustainer_Fin_Post_h, Fin_Chamfer_L=Sustainer_Fin_Chamfer_L,
				Cone_Len=0, ThreadedTC=false, Extra_OD=0, 
				LowerHalfOnly=LowerHalfOnly, UpperHalfOnly=UpperHalfOnly, HasWireHoles=false);
				/**/		
		//*
			// Stager cup mounts here
			if (!UpperHalfOnly==true) translate([0,0,-2])
				difference(){
					union(){
						cylinder(d=Body_OD, h=6, $fn=$preview? 90:360);
						translate([0,0,6-Overlap])
							cylinder(d1=Body_OD-1, d2=MotorTube_OD+2, h=10, $fn=$preview? 90:360);
					} // union
					
					translate([0,0,-Overlap]) cylinder(d=MotorTube_OD+IDXtra*3, h=30+Overlap*2, $fn=$preview? 90:360);
					
					// Fin Sockets
					translate([0,0,Sustainer_Fin_Root_L/2+SustainerFinInset])
						TrapFin2Slots(Tube_OD=Body_OD, nFins=nFins, Post_h=Sustainer_Fin_Post_h, 
								Root_L=Sustainer_Fin_Root_L, Root_W=Sustainer_Fin_Root_W, Chamfer_L=Sustainer_Fin_Chamfer_L);
					
				} // difference
		/**/
		} // union
		
		// Igniter wirs
		rotate([0,0,WirePath_a]) 
		translate([0,MotorTube_OD/2+5,-20]) 
			cylinder(d=6, h=Sustainer_Fin_Root_L+70);
			
		// Booster attachment
		translate([0,0,-20]) rotate([0,0,10]) Stager_CupHoles(Tube_OD=Body_OD, ID=Stager_ID, nLocks=3);
		
	} // difference
	
	
} // SustainerFinCan

//SustainerFinCan();
//SustainerFinCan(UpperHalfOnly=true);	
//rotate([180,0,0]) SustainerFinCan(LowerHalfOnly=true);	
	
module RocketFin(){
	//echo(Fin_Post_h=Fin_Post_h);
	
	TrapFin2(Post_h=Sustainer_Fin_Post_h, Root_L=Sustainer_Fin_Root_L, Tip_L=Sustainer_Fin_Tip_L, 
			Root_W=Sustainer_Fin_Root_W, Tip_W=Sustainer_Fin_Tip_W, 
			Span=Sustainer_Fin_Span, Chamfer_L=Sustainer_Fin_Chamfer_L,
					TipOffset=Sustainer_Fin_TipOffset);

	if ($preview==false){
		translate([-Sustainer_Fin_Root_L/2+Sustainer_Fin_Root_W/2,0,0]) cylinder(d=Sustainer_Fin_Root_W*2.5, h=0.9); // Neg
		translate([Sustainer_Fin_Root_L/2-Sustainer_Fin_Root_W/2,0,0]) cylinder(d=Sustainer_Fin_Root_W*2.5, h=0.9); // Pos
	}
} // RocketFin

// RocketFin();

module BoosterFinCan(LowerHalfOnly=false, UpperHalfOnly=false){
	Can_Len=Booster_Fin_Root_L+BoosterFinInset*2;
	
	echo(Can_Len=Can_Len);
	RailGuide_Z=40;
	
	
	FC2_FinCan(Body_OD=Body_OD, Body_ID=Body_ID, Can_Len=Can_Len,
				MotorTube_OD=MotorTube_OD, RailGuide_h=RailGuide_h,
				nFins=nFins, HasIntegratedCoupler=true, HasMotorSleeve=true, HasAftIntegratedCoupler=false,
				Fin_Root_W=Booster_Fin_Root_W, Fin_Root_L=Booster_Fin_Root_L, 
				Fin_Post_h=Booster_Fin_Post_h, Fin_Chamfer_L=Booster_Fin_Chamfer_L,
				Cone_Len=TailConeLen, ThreadedTC=true, Extra_OD=2, RailGuideLen=RailGuideLen,
				LowerHalfOnly=LowerHalfOnly, UpperHalfOnly=UpperHalfOnly, HasWireHoles=false);
	
} // BoosterFinCan

//BoosterFinCan();

module BoosterMotorRetainer(){
	FC2_MotorRetainer(Body_OD=Body_OD,
						MotorTube_OD=MotorTube_OD, MotorTube_ID=MotorTube_ID,
						HasWrenchCuts=false, Cone_Len=TailConeLen, ExtraLen=0, Extra_OD=2);
} // BoosterMotorRetainer

// BoosterMotorRetainer();

module BoosterFin(){
	TrapFin2(Post_h=Booster_Fin_Post_h, Root_L=Booster_Fin_Root_L, Tip_L=Booster_Fin_Tip_L, 
			Root_W=Booster_Fin_Root_W, Tip_W=Booster_Fin_Tip_W, 
			Span=Booster_Fin_Span, Chamfer_L=Booster_Fin_Chamfer_L,
					TipOffset=Booster_Fin_TipOffset);

	if ($preview==false){
		translate([-Booster_Fin_Root_L/2+10,0,0]) cylinder(d=Booster_Fin_Root_W*2.5, h=0.9); // Neg
		translate([Booster_Fin_Root_L/2-10,0,0]) cylinder(d=Booster_Fin_Root_W*2.5, h=0.9); // Pos
	}
} // BoosterFin

// BoosterFin();




































