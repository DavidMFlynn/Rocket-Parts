// ***********************************
// Project: 3D Printed Rocket
// Filename: Rocket_Toad.scad
// by David M. Flynn
// Created: 8/23/2024
// Revision: 0.9.2  9/2/2024
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  Two Stage Rocket with 137mm Body.
//  J460T-P to J180W-P
//  As short as it can be.
//
//  ***** Tubes to Cut *****
// Sustainer Upper Tube		BT137_Body	 x 165
// Sustainer Motor Tube		BT54_Body	 x 342
//
// Booster Interstage		BT137_Body   x 150
// Booster Motor Tube		BT54_Body	 x 270
//
//  ***** History *****
//
// 0.9.2  9/2/2024    Lots of fixes, I'm printing it!
// 0.9.1  8/23/2024   Ready to print.
// 0.9.0  8/23/2024	  Copied from Rocket75D2
//
// ***********************************
//  ***** for STL output *****
//
// BluntOgiveNoseCone(ID=Coupler_OD, OD=Body_OD, L=NC_Len, Base_L=NC_Base_L, nRivets=nNoseconeRivets, Tip_R=NC_Tip_r, HasThreadedTip=true, Wall_T=NC_Wall_t, Cut_Z=0, LowerPortion=false);
// NC_ShockcordRingDual(Tube_OD=Body_OD, Tube_ID=Body_ID, NC_ID=Coupler_OD, NC_Base_L=NC_Base_L, nRivets=nNoseconeRivets, Flat=true);
//
// *** petal deployer ***
//
// PD_NC_PetalHub(OD=Coupler_OD, nPetals=nPetals, nRopes=6, ShockCord_a=-1, HasThreadedCore=false, ST_DSpring_ID=SE_Spring_CS11890_ID(), ST_DSpring_OD=SE_Spring_CS11890_OD(), CouplerTube_ID=0);
// rotate([-90,0,0]) PD_PetalSpringHolder();  // Print 6
// rotate([180,0,0]) PD_Petals(OD=Coupler_OD, Len=SustainerPetal_Len, nPetals=nPetals, Wall_t=2.2, AntiClimber_h=4, HasLocks=false);
// 
//  *** Ball Lock ***
//
// rotate([180,0,0]) R137_BallRetainerTop(Body_OD=Body_OD, Body_ID=Body_ID);
// STB_LockDisk(BallPerimeter_d=STB_BT137BallPerimeter_d(), nLockBalls=nLockBalls, HasLargeInnerBearing=true);
// R137_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID, HasPD_Ring=false);
// rotate([180,0,0]) STB_TubeEnd2(BallPerimeter_d=STB_BT137BallPerimeter_d(), nLockBalls=nLockBalls, Body_OD=Body_OD, Body_ID=Body_ID, Engagement_Len=STB_Engagement_Len);
//
// *** Single Deploy Electronics Bay w/ extra Altimeter for Sustainer Ignition ***
//
ToadBay=[[-72,0],[216,144],[72]]; // Alt and Batt for ignition; Alt, Batt and BattSW for deployment; rail guide.
/*
// 
rotate([180,0,0])
  EB_Electronics_BayUniversal(Tube_OD=Body_OD, Tube_ID=Body_ID, DoorAngles=ToadBay, Len=Sustainer_EBay_Len, 
								HasFwdIntegratedCoupler=false, HasFwdShockMount=false,
								HasAftIntegratedCoupler=false, HasAftShockMount=false,
								nBolts=6, BoltInset=7.5, ShowDoors=false, 
								HasRailGuide=true, RailGuideLen=RailGuideLen, 
								Bolted=true, TopOnly=true, BottomOnly=false);
/**/
// 
// SusEBayAlignmentRing();
// 
//
// *** Doors ***
//
// rotate([-90,0,0]) EB_AltDoor(Tube_OD=Body_OD); // Print 3
// rotate([-90,0,0]) EB_BattDoor(Tube_OD=Body_OD, HasSwitch=true, DoubleBatt=false); // Print 3
// rotate([-90,0,0]) EB_BattDoor(Tube_OD=Body_OD, HasSwitch=false, DoubleBatt=false); // Print 3
//
//  *** Fins & Fin Can ***
//
// rotate([180,0,0]) SustainerFinCan(LowerHalfOnly=false, UpperHalfOnly=false);
// RocketFin();
//
// *********************
//  ***** BOOSTER *****
//
//  *** 5.5 Inch Stager ***
//
// rotate([180,0,0]) Stager_Cup(Tube_OD=Body_OD, nLocks=nLocks, BoltsOn=true, Collar_h=16);
// rotate([-90,0,0]) Stager_LockRod(Adj=0.0);
// rotate([-90,0,0]) Stager_LockRod(Adj=-0.5); // Tighter
// rotate([-90,0,0]) Stager_LockRod(Adj=-1.0); // Tighter
//
// Stager_Saucer(Tube_OD=Body_OD, nLocks=nLocks); // Bolts on
//
// Stager_LockRing(Tube_OD=Body_OD, nLocks=nLocks, FlexComp_d=0.0); 
// Stager_InnerRace(Tube_OD=Body_OD);
// Stager_BallSpacer(Tube_OD=DefaultBody_OD);
// Stager_Indexer(Tube_OD=DefaultBody_OD); // Bolts to InnerRace and has mounting holes for Lock Stops
//
// Stager_Mech(Tube_OD=Body_OD, nLocks=nLocks, Skirt_ID=Body_ID, Skirt_Len=StagerSkirtLen, nSkirtBolts=nBoltsBooster, ShowLocked=true);
//
// Stager_ServoPlate(Tube_OD=Body_OD, Skirt_ID=Body_ID, OverCenter=1.0, HasAlTube=false);
//
//  * Booster E_Bay *
//
AltBattTwoBattSWBay=[[0],[90],[180,270]]; //Alt, Batt, BattSW, BattSW
/*
 //rotate([180,0,0]) 
 EB_Electronics_BayUniversal(Tube_OD=Body_OD, Tube_ID=Body_ID, DoorAngles=AltBattTwoBattSWBay, 
						Len=EBay_Len, nBolts=nBoltsBooster, BoltInset=7.5, ShowDoors=false, 
						HasFwdIntegratedCoupler=true, HasFwdShockMount=false,
						HasAftIntegratedCoupler=false, HasAftShockMount=false,
						HasRailGuide=false, RailGuideLen=RailGuideLen, 
						Bolted=true, ExtraBolts=[45], TopOnly=false, BottomOnly=false);
/**/
//
//  *** Ball Lock ***
//
// rotate([180,0,0]) R137_BallRetainerTop(Body_OD=Body_OD, Body_ID=Body_ID);
// STB_LockDisk(BallPerimeter_d=STB_BT137BallPerimeter_d(), nLockBalls=nLockBalls, HasLargeInnerBearing=true);
// R137_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID, HasPD_Ring=true);
// rotate([180,0,0]) STB_TubeEnd2(BallPerimeter_d=STB_BT137BallPerimeter_d(), nLockBalls=nLockBalls, Body_OD=Body_OD, Body_ID=Body_ID, Engagement_Len=STB_Engagement_Len);
//
//  *** Petal Deployer ***
//
// R137_PetalHub(Body_OD=Coupler_OD);
// rotate([180,0,0]) PD_Petals(OD=Coupler_OD, Len=BoosterPetalLen, nPetals=3, Wall_t=2.2, AntiClimber_h=4, HasLocks=false, Lock_Span_a=180);
// rotate([-90,0,0]) PD_PetalSpringHolder();
//
// SE_SpringEndTypeC(Coupler_OD=Coupler_OD, Coupler_ID=Coupler_ID, nRopes=5, UseSmallSpring=false);
// BoosterSpringBottom(); // Includes centering ring
//
// rotate([180,0,0]) BoosterFinCan(LowerHalfOnly=false, UpperHalfOnly=false);
// BoosterFin();
//
// rotate([90,0,0]) BoltOnRailGuide(Length = RailGuideLen, BoltSpace=12.7, RoundEnds=true, ExtraBack=0);
//
// ***********************************
//  ***** for Viewing *****
//
// ShowSustainer(ShowInternals=true);
// ShowSustainer(ShowInternals=false);
//
// ShowBooster(ShowInternals=true);
// ShowBooster(ShowInternals=false);
//
// ShowBooster(ShowInternals=false); ShowSustainer(ShowInternals=false);
//
// ***********************************
include<TubesLib.scad>
use<AT-RMS-Lib.scad>
use<R137Lib.scad>
use<Fins.scad>
use<PetalDeploymentLib.scad>
use<ElectronicsBayLib.scad>
include<Stager3Lib.scad>
use<FinCan2Lib.scad>
use<NoseCone.scad>
use<SpringEndsLib.scad>
use<SpringThingBooster.scad>
use<RailGuide.scad>

//also included
 //include<BearingLib.scad>
 //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

Body_OD=BT137Body_OD;
Body_ID=BT137Body_ID;
Coupler_OD=BT137Coupler_OD;
Coupler_ID=BT137Coupler_ID;
MotorTube_OD=BT54Body_OD;
MotorTube_ID=BT54Body_ID;

nLocks=5; // Stager locks
StagerSkirtLen=35;
nBoltsBooster=6;
nLockBalls=7; // Ball Lock (STB) units
BallPerimeter_d=Body_OD;
STB_Engagement_Len=25;

nPetals=3;
BoosterPetalLen=100;
SustainerPetal_Len=150;

// Stager constants
Stager_LockRod_X=12;
Stager_LockRod_Y=6;
Stager_LockRod_Z=38;
Stager_LockRod_R=1;
LockBall_d=1/2 * 25.4; // 1/2" Delrin balls
Default_nLocks=5;
CupBoltsPerLock=3;
DefaultBody_OD=BT137Body_OD;
DefaultBody_ID=BT137Body_ID;

nFins=5;
Toad_Fin_Post_h=14;
Toad_Fin_Root_L=190;
Toad_Fin_Root_W=12;
Toad_Fin_Tip_W=5.0;
Toad_Fin_Tip_L=100;
Toad_Fin_Span=100;
Toad_Fin_TipOffset=70;
Toad_Fin_Chamfer_L=32;

Sustainer_Fin_Post_h=Toad_Fin_Post_h;
Sustainer_Fin_Root_L=Toad_Fin_Root_L;
Sustainer_Fin_Root_W=Toad_Fin_Root_W;
Sustainer_Fin_Tip_W=Toad_Fin_Tip_W;
Sustainer_Fin_Tip_L=Toad_Fin_Tip_L;
Sustainer_Fin_Span=Toad_Fin_Span;
Sustainer_Fin_TipOffset=Toad_Fin_TipOffset;
Sustainer_Fin_Chamfer_L=Toad_Fin_Chamfer_L;

FinScale=1.40;

Booster_Fin_Post_h=Toad_Fin_Post_h;
Booster_Fin_Root_L=Sustainer_Fin_Root_L*FinScale;
Booster_Fin_Root_W=Sustainer_Fin_Root_W*FinScale;
Booster_Fin_Tip_W=Sustainer_Fin_Tip_W*FinScale;
Booster_Fin_Tip_L=Sustainer_Fin_Tip_L*FinScale;
Booster_Fin_Span=Sustainer_Fin_Span*FinScale;
Booster_Fin_TipOffset=Sustainer_Fin_TipOffset*FinScale;
Booster_Fin_Chamfer_L=Sustainer_Fin_Chamfer_L*FinScale;

Sustainer_EBay_Len=170; // room at top for centering ring
EBay_Len=162;
RailGuide_h=Body_OD/2+2;
RailGuideLen=40;
TailConeLen=0;

UpperTube_Len=250;
SustainerFinInset=5;
SusFinCan_Len=Sustainer_Fin_Root_L+SustainerFinInset*2;
BoosterFinInset=5;
BoostFinCan_Len=Booster_Fin_Root_L+BoosterFinInset*2;

SustainerMotorTube_Len=SusFinCan_Len+EBay_Len-20;
Body_Len=UpperTube_Len+EBay_Len+SusFinCan_Len;
echo(Body_Len=Body_Len);

BoosterBody_Len=210;
BoosterMotorTubeLen=325; // fits J460T

// Phenolic Body and Coupler Tube Lengths
echo("Upper Body Tube = ",UpperTube_Len);
echo("Sustainer Motor Tube = ",SustainerMotorTube_Len);
echo("Booster Body = ",BoosterBody_Len);
echo("Booster Motor Tube = ",BoosterMotorTubeLen);

NC_Len=200; 
NC_Tip_r=24; 
NC_Base_L=15;
NC_Wall_t=2.2;
nNoseconeRivets=6;


module ShowBooster(ShowInternals=true){
	FinCan_Z=0;
	Fin_Z=FinCan_Z+Booster_Fin_Root_L/2+BoosterFinInset;
	Body_Z=FinCan_Z+BoostFinCan_Len+0.1;
	STB_Z=Body_Z+BoosterBody_Len+10;
	Ebay_Z=STB_Z+25;
	Stager_Z=Ebay_Z+EBay_Len-15+0.1+69.2+19;
	Saucer_Z=Stager_Z+0.1;

	translate([0,0,Saucer_Z]) color("Green") Stager_Cup(Tube_OD=Body_OD, nLocks=nLocks, BoltsOn=true, Collar_h=16);
	translate([0,0,Saucer_Z]) color("Black") Stager_Saucer(Tube_OD=Body_OD, nLocks=nLocks);
	translate([0,0,Stager_Z]) color("Green")
		Stager_Mech(Tube_OD=Body_OD, nLocks=nLocks, Skirt_ID=Body_ID, Skirt_Len=StagerSkirtLen, nSkirtBolts=nBoltsBooster, ShowLocked=true);
		
	//*
	rotate([0,0,60]) translate([0,0,Ebay_Z]) color("White")
		EB_Electronics_Bay(Tube_OD=Body_OD, Tube_ID=Body_ID, Len=EBay_Len, nBolts=nBoltsBooster, BoltInset=7.5, 
			ShowDoors=(ShowInternals==false), HasSecondBattDoor=true, HasFwdIntegratedCoupler=true, HasFwdShockMount=false);
	/**/
	
	translate([0,0,STB_Z+0.1]) color("White")
		R137_BallRetainerTop(Body_OD=Body_OD, Body_ID=Body_ID);
	
	//*
	if (ShowInternals) translate([0,0,STB_Z]) {
		R137_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID, HasPD_Ring=true);
		translate([0,0,-19.1]) rotate([180,0,200]) R137_PetalHub(Body_OD=Coupler_OD);
		translate([0,0,-28]) rotate([180,0,200]) PD_Petals(OD=Coupler_OD, Len=BoosterPetalLen, nPetals=3, Wall_t=1.8, AntiClimber_h=4, HasLocks=false, Lock_Span_a=180);
		
		translate([0,0,-67-BoosterPetalLen]) 
			 SE_SpringEndTypeC(Coupler_OD=Coupler_OD, Coupler_ID=Coupler_ID, nRopes=5, UseSmallSpring=false);
			
	}
	
	if (ShowInternals) translate([0,0,Body_Z+40])
		CenteringRing(OD=Body_ID, ID=MotorTube_OD+IDXtra*2, Thickness=5, nHoles=5, Offset=0, myfn=$preview? 90:360);

	/**/
	if (ShowInternals==false) translate([0,0,STB_Z+2.3]) color("Black")
		STB_TubeEnd2(BallPerimeter_d=BallPerimeter_d, nLockBalls=nLockBalls, Body_OD=Body_OD, Body_ID=Body_ID, Engagement_Len=STB_Engagement_Len);
	
	if (ShowInternals==false)
		translate([0,0,Body_Z]) color("White") 
			Tube(OD=Body_OD, ID=Body_ID, Len=BoosterBody_Len-0.2, myfn=$preview? 90:360);
	
	translate([0,0,FinCan_Z]) color("White") BoosterFinCan();
	
	if (ShowInternals) 
			color("Tan") 
			Tube(OD=MotorTube_OD, ID=MotorTube_ID, Len=BoosterMotorTubeLen, myfn=$preview? 90:360);
									
	for (j=[0:nFins]) rotate([0,0,360/nFins*j+180/nFins])
		translate([0, Body_OD/2-Booster_Fin_Post_h, Fin_Z]) 
			rotate([-90,0,0]) color("Green") BoosterFin();
			
	//if (ShowInternals) translate([0,0,-3]) ATRMS_54_852_Motor(Extended=false, HasEyeBolt=true); // J460T, J615ST
	if (ShowInternals) translate([0,0,-3]) ATRMS_54_1280_Motor(Extended=false, HasEyeBolt=true); // J800W
	
	
} // ShowBooster

//ShowBooster(ShowInternals=true);
//ShowBooster(ShowInternals=false);

module ShowSustainer(ShowInternals=true){
		SusFinCan_Z=BoostFinCan_Len+BoosterBody_Len+EBay_Len+133.4;
		EBay_Z=SusFinCan_Z+SusFinCan_Len;
		
		STB_Z=EBay_Z+EBay_Len+25;
		
		UpperTube_Z=EBay_Z+EBay_Len+33;
		NC_Z=UpperTube_Z+UpperTube_Len+3;

	
	//*
	translate([0,0,NC_Z]){
		color("Green") BluntOgiveNoseCone(ID=Coupler_OD, OD=Body_OD, L=NC_Len, 
			Base_L=NC_Base_L, nRivets=nNoseconeRivets, Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=0, LowerPortion=false);
		
		translate([0,0,-0.1])
			color("Green") NC_ShockcordRingDual(Tube_OD=Body_OD, Tube_ID=Body_ID, NC_Base_L=NC_Base_L, nRivets=nNoseconeRivets);
			
		if (ShowInternals) 
			translate([0,0,-40]) rotate([180,0,0])
				PD_NC_PetalHub(OD=Coupler_OD, nPetals=nPetals, nRopes=6, ShockCord_a=-1, HasThreadedCore=false, 
						ST_DSpring_ID=SE_Spring_CS11890_ID(), ST_DSpring_OD=SE_Spring_CS11890_OD(), CouplerTube_ID=0);
						
			
		if (ShowInternals) 
			translate([0,0,-40-10]) rotate([180,0,0]) 
				PD_Petals(OD=Coupler_OD, Len=SustainerPetal_Len, nPetals=3, Wall_t=2.2, AntiClimber_h=4, HasLocks=false, Lock_Span_a=180);
	}
	
	if (ShowInternals==false)
		translate([0,0,UpperTube_Z+0.1]) color("White") 
			Tube(OD=Body_OD, ID=Body_ID, Len=UpperTube_Len-0.2, myfn=$preview? 90:360);
		
	//*
	translate([0,0,EBay_Z]) color("White") 
		EB_Electronics_BayUniversal(Tube_OD=Body_OD, Tube_ID=Body_ID, DoorAngles=ToadBay, 
									Len=Sustainer_EBay_Len, nBolts=6, BoltInset=7.5, 
									ShowDoors=(ShowInternals==false), HasRailGuide=true, RailGuideLen=RailGuideLen, 
									Bolted=false, TopOnly=false, BottomOnly=false);
			
	/**/
	if (ShowInternals) translate([0,0,STB_Z]) 
		rotate([180,0,0]) R137_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID, HasPD_Ring=false);

	translate([0,0,STB_Z+0.1]) color("White")
		rotate([180,0,0]) R137_BallRetainerTop(Body_OD=Body_OD, Body_ID=Body_ID);
	
	if (ShowInternals==false) translate([0,0,STB_Z-2]) rotate([180,0,0]) color("Black")
		STB_TubeEnd2(BallPerimeter_d=BallPerimeter_d, nLockBalls=nLockBalls, Body_OD=Body_OD, Body_ID=Body_ID, Engagement_Len=STB_Engagement_Len);
	
	
	//*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j+180/nFins])
		translate([0, Body_OD/2-Sustainer_Fin_Post_h, SusFinCan_Z+Sustainer_Fin_Root_L/2+SustainerFinInset]) 
			rotate([-90,0,0]) color("Green") RocketFin();
	/**/
	
	translate([0,0,SusFinCan_Z]) {
		
		color("White") SustainerFinCan();
		
		if (ShowInternals) translate([0,0,-2]) ATRMS_54_852_Motor(Extended=false, HasEyeBolt=true);
		
		if (ShowInternals) 
			color("Tan") translate([0,0,1]) Tube(OD=MotorTube_OD, ID=MotorTube_ID, 
									Len=SustainerMotorTube_Len, myfn=$preview? 90:360);
		}
	
} // ShowSustainer

//ShowSustainer(ShowInternals=true);
//ShowSustainer(ShowInternals=false);

module BoosterSpringBottom(){
	// Integrated centering ring w/ spring bottom
	
	MT_Hole_d=MotorTube_OD+IDXtra*3;
	Spring_OD=SE_Spring_CS11890_OD();
	SpringSeat_h=10;
	Spring_Z=5;
	nRopes=5;
	Rope_d=4;
	
	difference(){
		union(){
			CenteringRing(OD=Body_ID, ID=MT_Hole_d, Thickness=5, nHoles=nRopes, Offset=0, myfn=$preview? 90:360);
			cylinder(d=Spring_OD+6, h=Spring_Z+SpringSeat_h, $fn=$preview? 90:360);
		} // union
		
		// Motor tube
		translate([0,0,-Overlap]) cylinder(d=MT_Hole_d, h=Spring_Z+Overlap*2, $fn=$preview? 90:360);
		
		// Spring
		translate([0,0,Spring_Z-Overlap]) cylinder(d=Spring_OD, h=SpringSeat_h+Overlap*2, $fn=$preview? 90:360);
		
		// Flare
		translate([0,0,Spring_Z+5]) cylinder(d1=Spring_OD, d2=Spring_OD+2, h=SpringSeat_h, $fn=$preview? 90:360);
		
		// Ropes
		for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j+90/nRopes]) translate([0,Spring_OD/2+10,-Overlap])
			cylinder(d=Rope_d, h=6);
		
	} // difference
	
	
} // BoosterSpringBottom

//BoosterSpringBottom();

module SusEBayAlignmentRing(){
	nHoles=5;
	
	// Outer 
	Tube(OD=Body_ID, ID=Body_ID-15, Len=5, myfn=$preview? 36:360);
	// Inner
	translate([0,0,7.5]) Tube(OD=MotorTube_OD+IDXtra*2+4.4, ID=MotorTube_OD+IDXtra*2, Len=15, myfn=$preview? 36:360);
	
	difference(){
		cylinder(d1=Body_ID-10, d2=Body_ID-15, h=12.5, $fn=$preview? 36:360);
		
		// MT
		cylinder(d=MotorTube_OD+1, h=13);
		
		translate([0,0,-Overlap]) cylinder(d1=Body_ID-15, d2=Body_ID-20, h=7.5, $fn=$preview? 36:360);
		
		for (j=[0:nHoles-1]) rotate([0,0,360/nHoles*j]) translate([0,MotorTube_OD/2+2.2+14,0])
			cylinder(d=26, h=13);
	} // difference
	
} // SusEBayAlignmentRing

// SusEBayAlignmentRing();

module BoosterShockMount(){
	IntegratedCoupler_OD=Body_ID-IDXtra*2;
	IntegratedCoupler_ID=Body_ID-IDXtra*2-6;
	
	Al_Tube_d=12.7;
	Al_Tube_Z=Al_Tube_d/2+1;
	Al_TubeOffset_Y=10; // clear servo
	
	difference(){
		union(){
			translate([0,0,-5])
				Tube(OD=IntegratedCoupler_ID-IDXtra*2, ID=IntegratedCoupler_ID-IDXtra*2-6, Len=5+7, myfn=$preview? 36:360);
			
			Tube(OD=IntegratedCoupler_OD, ID=IntegratedCoupler_ID-IDXtra*2-Overlap, Len=18, myfn=$preview? 36:360);
			
			//translate([0,0,Al_Tube_Z]) rotate([0,90,0]) cylinder(d=Al_Tube_d+6, h=IntegratedCoupler_ID-1, center=true);
			
			intersection(){
				union(){
					translate([0,0,-5]) cylinder(d=IntegratedCoupler_ID-1, h=5+7);
					cylinder(d=IntegratedCoupler_OD, h=18);
				}
				translate([0,Al_TubeOffset_Y,0])
				hull(){
					translate([0,0,Al_Tube_Z]) rotate([0,90,0]) cylinder(d=Al_Tube_d+6, h=IntegratedCoupler_ID, center=true);
					translate([-IntegratedCoupler_ID/2,-(Al_Tube_d+6)/2,-5]) cube([IntegratedCoupler_ID, Al_Tube_d+6, 5]);
				} // hull
			} // intersection
		} // union
		
		translate([0,Al_TubeOffset_Y,Al_Tube_Z]) rotate([0,90,0]) cylinder(d=40, h=40, center=true);
		
		translate([0,Al_TubeOffset_Y,Al_Tube_Z]) rotate([0,90,0]) cylinder(d=Al_Tube_d, h=IntegratedCoupler_OD+1, center=true);
	} // difference
} // BoosterShockMount

// BoosterShockMount();

module SustainerFinCan(LowerHalfOnly=false, UpperHalfOnly=false){
	
	Can_Len=SusFinCan_Len;
	echo(Can_Len=Can_Len);
	RailGuide_Z=50;
	WirePath_a=360/nFins*2;		
	MotorRetainer_d=63.5;
	MotorRetainer_H=33;
	
	difference(){
		union(){
		//*
			FC2_FinCan(Body_OD=Body_OD, Body_ID=Body_ID, Can_Len=Can_Len,
				MotorTube_OD=MotorTube_OD, RailGuide_h=RailGuide_h,
				nFins=nFins, HasIntegratedCoupler=true, HasMotorSleeve=true, HasAftIntegratedCoupler=false,
				Fin_Root_W=Sustainer_Fin_Root_W, Fin_Root_L=Sustainer_Fin_Root_L, 
				Fin_Post_h=Sustainer_Fin_Post_h, Fin_Chamfer_L=Sustainer_Fin_Chamfer_L,
				Cone_Len=0, ThreadedTC=false, Extra_OD=0, RailGuideLen=RailGuideLen, 
				LowerHalfOnly=LowerHalfOnly, UpperHalfOnly=UpperHalfOnly, HasWireHoles=false,
				HollowFinRoots=true, Wall_t=1.8);
				/**/		
				
				
			translate([0,0,-3]) 
				CenteringRing(OD=Body_OD, ID=MotorTube_OD-IDXtra*3, Thickness=7, nHoles=0, Offset=0, myfn=$preview? 36:90);
				
			difference(){
				cylinder(d1=MotorRetainer_d+25, d2=MotorTube_OD+5, h=MotorRetainer_H/2+15);
				
				translate([0,0,-Overlap]) cylinder(d=MotorTube_OD+IDXtra*3, h=MotorRetainer_H/2+15+Overlap*2);
			} // difference
		} // union
		
		translate([0,0,-MotorRetainer_H/2]) cylinder(d=MotorRetainer_d, h=MotorRetainer_H);
		
		// Igniter wirs
		rotate([0,0,WirePath_a]) 
		translate([0,Body_OD/2-6,-20]) 
			cylinder(d=7, h=Sustainer_Fin_Root_L+70);
			
		// Booster attachment
		translate([0,0,-22]) Stager_CupHoles(Tube_OD=Body_OD, nLocks=nLocks);
		
	} // difference
	
	if ($preview) translate([0,0,-MotorRetainer_H/2]) color("Silver") 
		Tube(OD=MotorRetainer_d, ID=MotorTube_OD+IDXtra*3, Len=MotorRetainer_H, myfn=90);

	
} // SustainerFinCan

//SustainerFinCan();
//SustainerFinCan(UpperHalfOnly=true);	
//rotate([180,0,0]) SustainerFinCan(LowerHalfOnly=true);	

//translate([0,0,-22.2]) rotate([0,0,24])  Stager_Cup(Tube_OD=Body_OD, nLocks=nLocks, BoltsOn=true, Collar_h=16);
	
module RocketFin(){
	//echo(Fin_Post_h=Fin_Post_h);
	
	TrapFin2(Post_h=Sustainer_Fin_Post_h, Root_L=Sustainer_Fin_Root_L, Tip_L=Sustainer_Fin_Tip_L, 
			Root_W=Sustainer_Fin_Root_W, Tip_W=Sustainer_Fin_Tip_W, 
			Span=Sustainer_Fin_Span, Chamfer_L=Sustainer_Fin_Chamfer_L,
					TipOffset=Sustainer_Fin_TipOffset);

	if ($preview==false){
		translate([0,-Sustainer_Fin_Root_L/2+Sustainer_Fin_Root_W/2,0]) cylinder(d=Sustainer_Fin_Root_W*2.5, h=0.9); // Neg
		translate([0,Sustainer_Fin_Root_L/2-Sustainer_Fin_Root_W/2,0]) cylinder(d=Sustainer_Fin_Root_W*2.5, h=0.9); // Pos
	}
} // RocketFin

// RocketFin();

module BoosterFinCan(LowerHalfOnly=false, UpperHalfOnly=false){

	MotorRetainer_d=63.5;
	MotorRetainer_H=33;
	
	Can_Len=BoostFinCan_Len;
	
	echo(Can_Len=Can_Len);
	RailGuide_Z=40;
	
	difference(){
		union(){
			FC2_FinCan(Body_OD=Body_OD, Body_ID=Body_ID, Can_Len=Can_Len,
				MotorTube_OD=MotorTube_OD, RailGuide_h=RailGuide_h,
				nFins=nFins, HasIntegratedCoupler=true, HasMotorSleeve=true, HasAftIntegratedCoupler=false,
				Fin_Root_W=Booster_Fin_Root_W, Fin_Root_L=Booster_Fin_Root_L, 
				Fin_Post_h=Booster_Fin_Post_h, Fin_Chamfer_L=Booster_Fin_Chamfer_L,
				Cone_Len=TailConeLen, ThreadedTC=false, Extra_OD=2, RailGuideLen=RailGuideLen,
				LowerHalfOnly=LowerHalfOnly, UpperHalfOnly=UpperHalfOnly, HasWireHoles=false,
				HollowFinRoots=true, Wall_t=1.8);
		
			translate([0,0,-3]) 
				CenteringRing(OD=Body_OD, ID=MotorTube_OD-IDXtra*3, Thickness=7, nHoles=0, Offset=0, myfn=$preview? 36:90);
				
			difference(){
				cylinder(d1=MotorRetainer_d+25, d2=MotorTube_OD+5, h=MotorRetainer_H/2+15);
				
				translate([0,0,-Overlap]) cylinder(d=MotorTube_OD+IDXtra*3, h=MotorRetainer_H/2+15+Overlap*2);
			} // difference
		} // union
		
		translate([0,0,-MotorRetainer_H/2]) cylinder(d=MotorRetainer_d, h=MotorRetainer_H);
	} // difference
	
	if ($preview) translate([0,0,-MotorRetainer_H/2]) color("Silver") 
		Tube(OD=MotorRetainer_d, ID=MotorTube_OD+IDXtra*3, Len=MotorRetainer_H, myfn=90);
	
} // BoosterFinCan

// BoosterFinCan();

module BoosterFin(){
	TrapFin2(Post_h=Booster_Fin_Post_h, Root_L=Booster_Fin_Root_L, Tip_L=Booster_Fin_Tip_L, 
			Root_W=Booster_Fin_Root_W, Tip_W=Booster_Fin_Tip_W, 
			Span=Booster_Fin_Span, Chamfer_L=Booster_Fin_Chamfer_L,
					TipOffset=Booster_Fin_TipOffset);

	if ($preview==false){
		translate([0,-Booster_Fin_Root_L/2+10,0]) cylinder(d=Booster_Fin_Root_W*2.5, h=0.9); // Neg
		translate([0,Booster_Fin_Root_L/2-10,0]) cylinder(d=Booster_Fin_Root_W*2.5, h=0.9); // Pos
	}
} // BoosterFin

// BoosterFin();




































