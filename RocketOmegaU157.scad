// ***********************************
// Project: 3D Printed Rocket
// Filename: RocketOmegaU157.scad
// by David M. Flynn
// Created: 7/1/2025
// Revision: 0.9.1  7/3/2025
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  This is a partial design, booster is just too long to look like an Omega
//  6" Upscale of Estes Astron Omega
//  Two Stage Rocket with ULine 6" Body.
//  K1100T-P to K550W-P
//
//  ***** Tubes to Cut *****
// Sustainer Upper Tube		
// Sustainer Lower Tube		
// Sustainer Coupler		
// Sustainer Motor Tube		
//
// Booster Interstage		
// Booster Coupler 			
// Booster Motor Tube		
//
//  ***** History *****
// 0.9.1  7/3/2025	  The Printing Begins!
// 0.9.0  7/1/2025	  Copied from Omega75
// 0.9.7  8/13/2024   Copied from Omega54 0.9.6
// 0.9.6  2/25/2023   Added Rail Guide to booster fin can.
// 0.9.5  2/24/2023   Ready for first printing and test assembly.
// 0.9.4  2/24/2023   Added SpringThing Parts
// 0.9.3  2/23/2023   Added Nosecone and Cable Release parts to STL list.
// 0.9.2  2/21/2023   Copied from RocketOmega.scad, Simple fin cans
// 0.9.1  11/14/2022  Worked on booster fin can. 
// 0.9.0  10/10/2022  First code.
//
// ***********************************
//  ***** for STL output *****
//
// OmegaNosecone(LowerPortion=false);
// OmegaNosecone(LowerPortion=true);
// NC_ShockcordRingDual(Tube_OD=Body_OD*CF_Comp+Vinyl_t*2, Tube_ID=Body_ID, NC_ID=0, NC_Base_L=NC_Base_L, nRivets=NC_nRivets, nBolts=NC_nRivets, Flat=true);
// 
//  *** Spring Management ***
//
// SE_SpringEndTypeC(Coupler_OD=Coupler_OD, Coupler_ID=Coupler_ID, Len=10, nRopes=6, UseSmallSpring=false);
// SE_SlidingBigSpringMiddle(OD=Coupler_OD, SliderLen=50, Extension=0);
// R157_PusherRing(OD=Coupler_OD, ID=Coupler_ID, OA_Len=50, Engagemnet_Len=7, Wall_t=4, PetalStop_h=0);
// R157_PusherRing(OD=Coupler_OD, ID=Coupler_ID, OA_Len=50, Engagemnet_Len=7, Wall_t=4, PetalStop_h=3);
// R157_SkirtRing(Coupler_OD=Coupler_OD, Coupler_ID=Coupler_ID, HasPD_Ring=false, Engagemnet_Len=7);
//
// R157_PusherRing(OD=Coupler_OD, ID=Coupler_ID, OA_Len=50, Engagemnet_Len=7, Wall_t=4, PetalStop_h=3);
// SE_SpringEndTypeC(Coupler_OD=Coupler_OD, Coupler_ID=Coupler_ID, nRopes=6, UseSmallSpring=false);
//
//  *** Electronics Bays ***
//
// rotate([180,0,0]) MainEBay(TopOnly=true, BottomOnly=false, ShowDoors=false);
// MainEBay(TopOnly=false, BottomOnly=true, ShowDoors=false);
//
// rotate([180,0,0]) LowerEBay(TopOnly=true, BottomOnly=false, ShowDoors=false);
// LowerEBay(TopOnly=false, BottomOnly=true, ShowDoors=false);
//
// rotate([180,0,0]) BoosterEBay(TopOnly=true, BottomOnly=false, ShowDoors=false);
// BoosterEBay(TopOnly=false, BottomOnly=true, ShowDoors=false);
//
//  *** Doors ***
// rotate([-90,0,0]) EB_AltDoor(Tube_OD=Body_OD*CF_Comp+Vinyl_t*2);
// rotate([-90,0,0]) EB_BattDoor(Tube_OD=Body_OD*CF_Comp+Vinyl_t*2, HasSwitch=false, DoubleBatt=false);
// rotate([-90,0,0]) EB_BattDoor(Tube_OD=Body_OD*CF_Comp+Vinyl_t*2, HasSwitch=true, DoubleBatt=false);
// 
//  *** Ball Locks 3Req. ***
//
STB_Xtra_r=0.3;
//
// rotate([180,0,0]) R157_BallRetainerTop(Body_OD=Body_OD, Body_ID=Body_ID, EBayTube_OD=BT54Body_OD, Engagement_Len=Engagement_Len, nBolts=6, Xtra_r=STB_Xtra_r);
// STB_LockDisk(Body_ID=Body_ID, nLockBalls=nLockBalls, HasLargeInnerBearing=true, Xtra_r=STB_Xtra_r);
// R157_BallRetainerBottom(Body_ID=Body_ID, Engagement_Len=Engagement_Len, Xtra_r=STB_Xtra_r);
// STB_TubeEnd(Body_ID=Body_ID, nLockBalls=nLockBalls, Body_OD=Body_OD*CF_Comp, Engagement_Len=Engagement_Len);
//
//  *** Petal Deployers ***
//
// R157_NC_PetalHub(OD=Coupler_OD, nPetals=3, nRopes=6, CouplerTube_ID=Coupler_ID);
// R157_PetalHub(OD=Coupler_OD, nPetals=3, nBolts=6); // 2 Req.
//
// PD_Petals2(OD=Coupler_OD, Len=MainPetal_Len, nPetals=3, Wall_t=1.8, AntiClimber_h=5, HasLocks=false, Lock_Span_a=180);
// PD_Petals2(OD=Coupler_OD, Len=DroguePetal_Len, nPetals=3, Wall_t=1.8, AntiClimber_h=5, HasLocks=false, Lock_Span_a=180);
// PD_Petals2(OD=Coupler_OD, Len=BoosterPetalLen, nPetals=3, Wall_t=1.8, AntiClimber_h=5, HasLocks=false, Lock_Span_a=180);
//
// rotate([-90,0,0]) PD_PetalSpringHolder2();
// PD_HubSpringHolder();
//
//  *** Fins & Fin Cans ***
//
// FinCan54();
// RocketOmegaFin();
//
//  ***** BOOSTER *****
//
//  *** Stager ***
//
// rotate([180,0,0]) Stager_Cup(Tube_OD=Body_OD, nLocks=nLocks, BoltsOn=true, Collar_h=Stager_Collar_Len);
// rotate([-90,0,0]) Stager_LockRod(Adj=0.0);
//
// Stager_Saucer(Tube_OD=Body_OD, nLocks=nLocks); // Bolts on
//
// Stager_LockRing(Tube_OD=Body_OD, nLocks=nLocks); 
// Stager_Mech(Tube_OD=Body_OD, nLocks=nLocks, Skirt_ID=Body_ID, Skirt_Len=Stager_Skirt_Len, nSkirtBolts=nEBayBolts, ShowLocked=true);
// Stager_BallSpacer(Tube_OD=Body_OD); // print 2
//
// Stager_InnerRace(Tube_OD=Body_OD);
// rotate([180,0,0]) Stager_Indexer(Tube_OD=Body_OD, nLocks=nLocks); // Bolts to InnerRace
// Stager_ServoPlate(Tube_OD=Body_OD, Skirt_ID=Body_ID, nLocks=nLocks, OverCenter=IDXtra+0.8); // Bottom Plate
// rotate([180,0,0]) Stager_ServoMount(UseLargeServo=true);
//
//  *** Fin Can ***
//
// rotate([180,0,0]) BoosterFinCan(LowerHalfOnly=true, UpperHalfOnly=false);
// BoosterFinCan(LowerHalfOnly=false, UpperHalfOnly=true);
//
// BoosterMotorRetainer();
// RocketOmegaBoosterFin();
//
//  *** Tools ***
//
// TubeTest(OD=Body_OD, ID=Body_ID, TestOD=false);
// TubeTest(OD=Body_OD+IDXtra*2, ID=Body_ID, TestOD=true);
//
// ***********************************
//  ***** Routines *****
//
//
// ***********************************
//  ***** for Viewing *****
//
// ShowCableRelease();
//
// ShowRocketOmega(ShowInternals=true);
// ShowRocketOmega(ShowInternals=false);
//
// ShowBooster(ShowInternals=true);
// ShowBooster(ShowInternals=false);
//
// ShowRocketOmega(ShowInternals=false); ShowBooster(ShowInternals=false);
//
// ***********************************
include<TubesLib.scad>
use<AT-RMS-Lib.scad>
use<PetalDeploymentLib.scad>
use<ElectronicsBayLib.scad>
include<Stager3Lib.scad>
use<Fins.scad>
use<FinCan2Lib.scad>
use<NoseCone.scad>
use<SpringEndsLib.scad>
use<SpringThingBooster.scad>
use<RailGuide.scad>
use<R157Lib.scad>

//also included
 //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

nLocks=5; // Stager locks
Stager_Collar_Len=16;
Stager_Skirt_Len=16;


// for Stager 157
Stager_LockRod_X=12;
Stager_LockRod_Y=6;
Stager_LockRod_Z=38;
Stager_LockRod_R=1;
LockBall_d=1/2 * 25.4; // 1/2" Delrin balls
Default_nLocks=5;
CupBoltsPerLock=3;
DefaultBody_OD=ULine157Body_OD;
DefaultBody_ID=ULine157Body_ID;

Scale=ULine157Body_OD/41.58; // Body tube diameters
echo(Scale=Scale);
CF_Comp=1.0031; // PETG-CF comp value
Vinyl_t=0.12;
Body_OD=ULine157Body_OD;
Body_ID=ULine157Body_ID;
Coupler_OD=ULine157Coupler_OD;
Coupler_ID=ULine157Coupler_ID;
MotorTube_OD=BT54Body_OD;
MotorTube_ID=BT54Body_ID;


nLockBalls=6; // Ball Lock (STB) units
nEBayBolts=6;

MainPetal_Len=100;
DroguePetal_Len=80;

BoosterPetalLen=80;

// Sustainer Fin, Omega style
nFins=4;
Sustainer_Fin_Post_h=15;
Sustainer_Fin_Root_L=72*Scale;
Sustainer_Fin_Root_W=5*Scale;
//echo(Sustainer_Fin_Root_W=Sustainer_Fin_Root_W);
Sustainer_Fin_Tip_W=2*Scale;
Sustainer_Fin_Tip_L=Sustainer_Fin_Root_L*0.75;
Sustainer_Fin_Span=Sustainer_Fin_Root_L*0.75;
Sustainer_Fin_TipOffset=0;
Sustainer_Fin_Chamfer_L=Sustainer_Fin_Root_W*3;

// Booster Fin, Omega style
Booster_Fin_Post_h=15;
Booster_Fin_Root_L=90*Scale;
Booster_Fin_Root_W=5.7*Scale;
Booster_Fin_Tip_W=2*Scale;
Booster_Fin_Tip_L=Booster_Fin_Root_L*0.75;
Booster_Fin_Span=Booster_Fin_Root_L*0.75;
Booster_Fin_TipOffset=0;
Booster_Fin_Chamfer_L=Booster_Fin_Root_W*3;
//echo(Booster_Fin_Root_L=Booster_Fin_Root_L);
//echo(Booster_Fin_Span=Booster_Fin_Span);

Engagement_Len=30;
EBay_Len=162;
Sus_IgnitionWireOffset=MotorTube_OD/2+12;

	EBayBoltInset=7.5;
	EBayCR_t=5;
	MainEBay_Len=170;

ScaleBooster_Body_Len=5*25.4*Scale;
echo(ScaleBooster_Body_Len=ScaleBooster_Body_Len);

PBay_Len=5*25.4*Scale;
LowerTube_Len=625;
SustainerFinInset=5;
SusFinCan_Len=Sustainer_Fin_Root_L+SustainerFinInset*2;
BoosterFinInset=5;
BoostFinCan_Len=Booster_Fin_Root_L+BoosterFinInset*2;
InterstageTube_Len=240;
Booster_Body_Len=BoostFinCan_Len+InterstageTube_Len+EBay_Len+Engagement_Len+28;
SustainerMotorTube_Len=SusFinCan_Len+EBay_Len+200;
echo(Booster_Body_Len=Booster_Body_Len);

ScaleBody_Len=(14.5+5)*25.4*Scale;
echo(ScaleBody_Len=ScaleBody_Len);
echo(" Including scale payload bay len =",PBay_Len);

STB_Len=39+Engagement_Len;
Body_Len=19+SusFinCan_Len+EBay_Len+LowerTube_Len+MainEBay_Len+STB_Len*2+PBay_Len;
echo(Body_Len=Body_Len);

BoosterMotorTubeLen=BoostFinCan_Len+100;

// Phenolic Body and Coupler Tube Lengths
echo("Lower Body Tube = ",LowerTube_Len);
echo("Sustainer Motor Tube = ",SustainerMotorTube_Len);
echo("Booster Body = ",InterstageTube_Len);
echo("Booster Coupler = ",InterstageTube_Len-10);
echo("Booster Motor Tube = ",BoosterMotorTubeLen);

NC_Base_L=15;
NC_Len=170*Scale-NC_Base_L;
NC_Tip_r=5*Scale;
NC_Wall_t=2.2;
NC_nRivets=5;


RailGuide_h=Body_OD/2+2;
TailConeLen=40;



module ShowBooster(ShowInternals=true){
	MotorTube_Z=-TailConeLen+5;
	FinCan_Z=0;
	Fin_Z=FinCan_Z+Booster_Fin_Root_L/2+BoosterFinInset;
	Body_Z=FinCan_Z+BoostFinCan_Len+0.1;
	SpringEnd_Z=Body_Z+InterstageTube_Len-157;
	STB_Z=Body_Z+InterstageTube_Len+10;
	Ebay_Z=STB_Z+39.2;
	Stager_Z=Ebay_Z+EBay_Len+54.4;
	Saucer_Z=Stager_Z+0.1;

	translate([0,0,Saucer_Z]) color("Gray") Stager_Saucer(Tube_OD=Body_OD, nLocks=nLocks);
	translate([0,0,Stager_Z]) rotate([0,0,180/nEBayBolts]) color("White")
		Stager_Mech(Tube_OD=Body_OD, nLocks=nLocks, Skirt_ID=Body_ID, Skirt_Len=Stager_Skirt_Len, nSkirtBolts=nEBayBolts, ShowLocked=true);
	
	
	//*
	translate([0,0,Ebay_Z]) color("White") 
		BoosterEBay(TopOnly=false, BottomOnly=false, ShowDoors=!ShowInternals);
	/**/
	
	translate([0,0,STB_Z+0.1]) color("White")
		R157_BallRetainerTop(Body_OD=Body_OD, Body_ID=Body_ID, EBayTube_OD=BT54Body_OD, Engagement_Len=Engagement_Len, nBolts=6, Xtra_r=STB_Xtra_r);
	
	if (ShowInternals) translate([0,0,STB_Z]) {
		R157_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID, Engagement_Len=Engagement_Len, Xtra_r=0.0);
		translate([0,0,-15.1]) rotate([180,0,200]) 
			R157_PetalHub(OD=Coupler_OD, nPetals=3, nBolts=6);
		translate([0,0,-25]) rotate([180,0,200]) 
			PD_Petals2(OD=Coupler_OD, Len=BoosterPetalLen, nPetals=3, Wall_t=1.8, AntiClimber_h=4, HasLocks=false, Lock_Span_a=180);
	}
	
	if (!ShowInternals) translate([0,0,STB_Z]) color("Gray")
		STB_TubeEnd(Body_ID=Body_ID, nLockBalls=nLockBalls, Body_OD=Body_OD, Engagement_Len=Engagement_Len);
	
	if (ShowInternals) translate([0,0,SpringEnd_Z]){
		SE_SpringEndTypeC(Coupler_OD=Coupler_OD, Coupler_ID=Coupler_ID, nRopes=6, UseSmallSpring=false);
		translate([0,0,3.2]) color("Gray") R157_PusherRing(OD=Coupler_OD, ID=Coupler_ID, OA_Len=50, Engagemnet_Len=7, Wall_t=4, PetalStop_h=3);
		}
	
	if (!ShowInternals)
		translate([0,0,Body_Z]) color("White") 
			Tube(OD=Body_OD, ID=Body_ID, Len=InterstageTube_Len-0.2, myfn=$preview? 90:360);
	
	translate([0,0,FinCan_Z]) color("White") BoosterFinCan();
	translate([0,0,FinCan_Z-TailConeLen-13]) color("Gray") BoosterMotorRetainer();
	
	if (ShowInternals) {
		translate([0,0,MotorTube_Z]) color("Tan") 
			Tube(OD=MotorTube_OD, ID=MotorTube_ID, Len=BoosterMotorTubeLen, myfn=$preview? 90:360);
		translate([0,0,MotorTube_Z+BoosterMotorTubeLen-10]) R157_BoosterSpringBottom(OD=Body_ID, MotorTube_OD=MotorTube_OD);
	}
			
									
	for (j=[0:nFins]) rotate([0,0,360/nFins*j+180/nFins])
		translate([0,Body_OD/2-Booster_Fin_Post_h, Fin_Z]) 
			rotate([-90,0,0]) color("Blue") RocketOmegaBoosterFin();
			
	if (ShowInternals) translate([0,0,MotorTube_Z-3]) ATRMS_54_1706_Motor(Extended=false, HasEyeBolt=true); // K1100T
	
	
} // ShowBooster

// ShowBooster(ShowInternals=true);
// ShowBooster(ShowInternals=false);


module ShowRocketOmega(ShowInternals=true){
	
	
	InterstageCoupler_Len=InterstageTube_Len;
	
	SusFinCan_Z=BoostFinCan_Len+InterstageCoupler_Len+286;
	MotorTube_Z=SusFinCan_Z-5;
		
	LowerEBay_Z=SusFinCan_Z+SusFinCan_Len;
		
	LowerTube_Z=LowerEBay_Z+EBay_Len-15;
	
	DrogueSTB_Z=LowerTube_Z+LowerTube_Len;
	EBay_Z=DrogueSTB_Z+39.2;
	MainSTB_Z=EBay_Z+MainEBay_Len+39.2;
		
	
	PBay_Z=MainSTB_Z+Engagement_Len/2;
	
	MainPetalHub_Z=PBay_Z+50+MainPetal_Len+24;
	NC_Z=PBay_Z+PBay_Len+3;
	
	//*
	translate([0,0,NC_Z]){
		color("Black"){ OmegaNosecone(LowerPortion=false); OmegaNosecone(LowerPortion=true);}
		translate([0,0,-13])
		NC_ShockcordRingDual(Tube_OD=Body_OD, Tube_ID=Body_ID, NC_ID=0, NC_Base_L=NC_Base_L, nRivets=NC_nRivets, nBolts=NC_nRivets, Flat=true);
	}
		
	if (ShowInternals) translate([0,0,MainPetalHub_Z]){
		translate([0,0,120]) SE_SpringEndTypeC(Coupler_OD=ULine157Coupler_OD, Coupler_ID=ULine157Coupler_ID, Len=10, nRopes=6, UseSmallSpring=false);
		translate([0,0,55]) SE_SlidingBigSpringMiddle(OD=ULine157Coupler_OD, SliderLen=50, Extension=0);
		translate([0,0,0.1]) color("Gray") 
			R157_PusherRing(OD=Coupler_OD, ID=Coupler_ID, OA_Len=50, Engagemnet_Len=7, Wall_t=4, PetalStop_h=0);
		rotate([180,0,0]) R157_NC_PetalHub(OD=Coupler_OD, nPetals=3, nRopes=6, CouplerTube_ID=Coupler_ID);
		translate([0,0,-10]) rotate([180,0,0]) 
			PD_Petals2(OD=Coupler_OD, Len=MainPetal_Len, nPetals=3, Wall_t=1.8, AntiClimber_h=4, HasLocks=false, Lock_Span_a=180);
		translate([0,0,-10-MainPetal_Len-58]) color("Gray") 
			R157_PusherRing(OD=Coupler_OD, ID=Coupler_ID, OA_Len=50, Engagemnet_Len=7, Wall_t=4, PetalStop_h=3);
	}
	
	if (!ShowInternals)
		translate([0,0,PBay_Z+0.1]) color("Silver") 
			Tube(OD=Body_OD, ID=Body_ID, Len=PBay_Len-0.2, myfn=$preview? 90:360);
	
	
	if (!ShowInternals) translate([0,0,MainSTB_Z]) color("Gray") rotate([180,0,0])
		STB_TubeEnd(Body_ID=Body_ID, nLockBalls=nLockBalls, Body_OD=Body_OD, Engagement_Len=Engagement_Len);

	if (ShowInternals) translate([0,0,MainSTB_Z]){
		rotate([180,0,0]) color("Tan")
			R157_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID, Engagement_Len=Engagement_Len, Xtra_r=0.0);
		translate([0,0,Engagement_Len/2]) R157_SkirtRing(Coupler_OD=Coupler_OD, Coupler_ID=Coupler_ID, HasPD_Ring=false, Engagemnet_Len=7);
	}
	translate([0,0,MainSTB_Z]) color("White") rotate([180,0,0])
		R157_BallRetainerTop(Body_OD=Body_OD, Body_ID=Body_ID, EBayTube_OD=BT54Body_OD, Engagement_Len=Engagement_Len, nBolts=6, Xtra_r=STB_Xtra_r);

	translate([0,0,EBay_Z]) 
		rotate([0,0,180-180/nFins]) color("White") 
			MainEBay(TopOnly=false, BottomOnly=false, ShowDoors=!ShowInternals);
	
	translate([0,0,DrogueSTB_Z]) color("White")
		R157_BallRetainerTop(Body_OD=Body_OD, Body_ID=Body_ID, EBayTube_OD=BT54Body_OD, Engagement_Len=Engagement_Len, nBolts=6, Xtra_r=STB_Xtra_r);

	if (ShowInternals) translate([0,0,DrogueSTB_Z]){
		color("Tan") R157_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID, Engagement_Len=Engagement_Len, Xtra_r=0.0);
		translate([0,0,-15.1]) rotate([180,0,200]) 
			R157_PetalHub(OD=Coupler_OD, nPetals=3, nBolts=6);
		translate([0,0,-25]) {rotate([180,0,200]) 
			PD_Petals2(OD=Coupler_OD, Len=DroguePetal_Len, nPetals=3, Wall_t=1.8, AntiClimber_h=4, HasLocks=false, Lock_Span_a=180);
		translate([0,0,-8-DroguePetal_Len-50]) { color("Gray") 
			R157_PusherRing(OD=Coupler_OD, ID=Coupler_ID, OA_Len=50, Engagemnet_Len=7, Wall_t=4, PetalStop_h=3);
		translate([0,0,-3.2]) 
			SE_SpringEndTypeC(Coupler_OD=Coupler_OD, Coupler_ID=Coupler_ID, nRopes=6, UseSmallSpring=false);
			
		translate([0,0,-30]) R157_BoosterSpringBottom(OD=Body_ID, MotorTube_OD=MotorTube_OD);
		}}
	}
	
	
	
		
	if (!ShowInternals) translate([0,0,DrogueSTB_Z]) color("Gray")
		STB_TubeEnd(Body_ID=Body_ID, nLockBalls=nLockBalls, Body_OD=Body_OD, Engagement_Len=Engagement_Len);

	if (!ShowInternals)
		translate([0,0,LowerTube_Z+0.1]) color("White") 
			Tube(OD=Body_OD, ID=Body_ID, Len=LowerTube_Len-0.2, myfn=$preview? 90:360);

	translate([0,0,LowerEBay_Z]) color("White") LowerEBay(TopOnly=false, BottomOnly=false, ShowDoors=!ShowInternals);
	
	//*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j+180/nFins])
		translate([0, Body_OD/2-Sustainer_Fin_Post_h, SusFinCan_Z+Sustainer_Fin_Root_L/2+SustainerFinInset]) 
			rotate([-90,0,0]) color("Blue") RocketOmegaFin();
	/**/
	
	translate([0,0,SusFinCan_Z]) {
		
		color("White") SustainerFinCan();
				
		if (ShowInternals) {
			color("Tan") Tube(OD=MotorTube_OD, ID=MotorTube_ID, Len=SustainerMotorTube_Len, myfn=$preview? 90:360);
			translate([0,0,SustainerMotorTube_Len]) rotate([0,0,90]) R157_MotorTubeTopper();
		}
	}
		
	translate([0,0,SusFinCan_Z-21]) color("Blue") Stager_Cup(Tube_OD=Body_OD, nLocks=nLocks, BoltsOn=true, Collar_h=Stager_Collar_Len);
	
	if (ShowInternals) 
		translate([0,0,MotorTube_Z]) color("LightBlue") 
			Tube(OD=MotorTube_OD, ID=MotorTube_ID, Len=SustainerMotorTube_Len, myfn=$preview? 90:360);
			
	translate([0,0,MotorTube_Z-18]) color("Gray") BoosterMotorRetainer();
	
	if (ShowInternals) translate([0,0,MotorTube_Z-3]) ATRMS_54_2560_Motor(Extended=false, HasEyeBolt=true); // K1100T

		
	//ShowBooster(ShowInternals=ShowInternals);
} // ShowRocketOmega

// ShowRocketOmega(ShowInternals=true);
// ShowRocketOmega(ShowInternals=false);

module OmegaNosecone(LowerPortion=false){
	echo("Nosecone Len = ",NC_Len+NC_Base_L);
	
	BluntOgiveNoseCone(ID=Body_ID, OD=Body_OD*CF_Comp+Vinyl_t*2, L=NC_Len, 
						Base_L=NC_Base_L, nRivets=NC_nRivets, RivertInset=0, Tip_R=NC_Tip_r, HasThreadedTip=true, Wall_T=NC_Wall_t, 
						Cut_d=Body_OD-30, LowerPortion=LowerPortion, FillTip=true); // Cut_d=PML98Body_OD-20 is good


} // OmegaNosecone

//OmegaNosecone(LowerPortion=false); OmegaNosecone(LowerPortion=true);


module MainEBay(TopOnly=false, BottomOnly=false, ShowDoors=false){
	TubeStop_Z=EBayBoltInset*2+EBayCR_t+1.9;
	Doors_a=[[45],[135],[225,315]];

	EB_Electronics_BayUniversal(Tube_OD=Body_OD*CF_Comp+Vinyl_t*2, Tube_ID=Body_ID, DoorAngles=Doors_a, Len=MainEBay_Len, 
									nBolts=nEBayBolts, BoltInset=EBayBoltInset, ShowDoors=ShowDoors,
									HasFwdIntegratedCoupler=false, HasFwdShockMount=false,
									HasAftIntegratedCoupler=false, HasAftShockMount=false,
									HasRailGuide=false, RailGuideLen=40,
									HasFwdCenteringRing=false, HasAftCenteringRing=false, InnerTube_OD=ULine38Body_OD,
									Bolted=true, ExtraBolts=[45], TopOnly=TopOnly, BottomOnly=BottomOnly);
									
	// Bottom centering ring stop
	if (!TopOnly) translate([0,0,TubeStop_Z]) 
		TubeStop(InnerTubeID=Coupler_ID, OuterTubeOD=Body_OD, myfn=$preview? 36:360);
		
	// Top centering ring stop
	if (!BottomOnly) translate([0,0,MainEBay_Len-TubeStop_Z]) rotate([180,0,0])
		TubeStop(InnerTubeID=Coupler_ID, OuterTubeOD=Body_OD, myfn=$preview? 36:360);
									
} // MainEBay

// MainEBay();

module LowerEBay(TopOnly=false, BottomOnly=false, ShowDoors=false){
	Doors_a=[[45],[225],[]];

	EB_Electronics_BayUniversal(Tube_OD=Body_OD*CF_Comp+Vinyl_t*2, Tube_ID=Body_ID, DoorAngles=Doors_a, Len=EBay_Len, 
									nBolts=nEBayBolts, BoltInset=7.5, ShowDoors=ShowDoors,
									HasFwdIntegratedCoupler=true, HasFwdShockMount=false,
									HasAftIntegratedCoupler=false, HasAftShockMount=false,
									HasRailGuide=false, RailGuideLen=40,
									HasFwdCenteringRing=false, HasAftCenteringRing=false, InnerTube_OD=0,
									Bolted=true, ExtraBolts=[60,90,120], TopOnly=TopOnly, BottomOnly=BottomOnly);
									
} // LowerEBay

// LowerEBay();

module SustainerFinCan(LowerHalfOnly=false, UpperHalfOnly=false){
	
	Can_Len=Sustainer_Fin_Root_L+SustainerFinInset*2;
	echo(Can_Len=Can_Len);
	RailGuide_Z=50;
	Retainer_d=65;	
	
	difference(){
		union(){
			FC2_FinCan(Body_OD=Body_OD*CF_Comp+Vinyl_t*2, Body_ID=Body_ID, Can_Len=Can_Len,
				MotorTube_OD=MotorTube_OD, RailGuide_h=RailGuide_h, RailGuide_z=RailGuide_Z,
				nFins=nFins, HasIntegratedCoupler=true, Coupler_Len=15, nCouplerBolts=nFins*2,
				HasMotorSleeve=true, HasAftIntegratedCoupler=false,
				Fin_Root_W=Sustainer_Fin_Root_W, Fin_Root_L=Sustainer_Fin_Root_L, 
				Fin_Post_h=Sustainer_Fin_Post_h, Fin_Chamfer_L=Sustainer_Fin_Chamfer_L,
				Cone_Len=0, ThreadedTC=false, Extra_OD=0, RailGuideLen=40,
				LowerHalfOnly=LowerHalfOnly, UpperHalfOnly=UpperHalfOnly, 
				HasWireHoles=false, HollowTailcone=true, 
				HollowFinRoots=true, Wall_t=1.2, OgiveTailCone=false, Ogive_Len=400, OgiveCut_d=BT54Body_OD+8,
				UseTrapFin3=true);
					
			// Motor Retainer Socket
			translate([0,0,-2]) cylinder(d=Retainer_d+5, h=25);
			translate([0,0,-2+25-Overlap]) cylinder(d1=Retainer_d+5, d2=MotorTube_OD+4, h=8);
		//*
			// Stager cup mounts here
			translate([0,0,-2])
			difference(){
				cylinder(d=Body_OD, h=6, $fn=$preview? 90:360);
				translate([0,0,-Overlap]) cylinder(d=MotorTube_OD+IDXtra*3, h=30+Overlap*2);
			} // difference
		/**/
		} // union
		
		// Igniter wirs
		rotate([0,0,180/nFins+180]) translate([Sus_IgnitionWireOffset,0,-20]) 
			cylinder(d=6.35, h=Sustainer_Fin_Root_L+70);
			
		// motor retainer
		translate([0,0,-2-Overlap]) cylinder(d=Retainer_d+IDXtra*3, h=20);
		cylinder(d=MotorTube_OD+IDXtra*3, h=40);
		
			
		// Booster attachment
		translate([0,0,-2]) rotate([0,0,10])
		  Stager_CupBoltHoles(Tube_OD=Body_OD, nLocks=nLocks) rotate([180,0,0]) Bolt4Hole();
		
	} // difference
	
	
} // SustainerFinCan

// SustainerFinCan();	
	
module RocketOmegaFin(){
	//echo(Fin_Post_h=Fin_Post_h);
	
	//  *** Ogive leading and trailing edges ***
	TrapFin3(Post_h=Sustainer_Fin_Post_h, Root_L=Sustainer_Fin_Root_L, Tip_L=Sustainer_Fin_Tip_L, 
				Root_W=Sustainer_Fin_Root_W, Tip_W=Sustainer_Fin_Tip_W, Span=Sustainer_Fin_Span, Chamfer_L=Sustainer_Fin_Chamfer_L,
				TipOffset=Sustainer_Fin_TipOffset, TipInset=0, HasBluntTip=false, TipPost_h=0,
				Bisect=false, Bisect_X=0,
				HasSpar=false, Spar_d=8, Spar_L=100, PrinterBrim_H=0.8, HasSpiralVaseRibs=false);

} // RocketOmegaFin

// RocketOmegaFin();

module BoosterEBay(TopOnly=false, BottomOnly=false, ShowDoors=false){
	Doors_a=[[45],[135],[225,315]];

	EB_Electronics_BayUniversal(Tube_OD=Body_OD*CF_Comp+Vinyl_t*2, Tube_ID=Body_ID, DoorAngles=Doors_a, Len=EBay_Len, 
									nBolts=nEBayBolts, BoltInset=7.5, ShowDoors=ShowDoors,
									HasFwdIntegratedCoupler=true, HasFwdShockMount=false,
									HasAftIntegratedCoupler=false, HasAftShockMount=false,
									HasRailGuide=true, RailGuideLen=40,
									HasFwdCenteringRing=false, HasAftCenteringRing=false, InnerTube_OD=0,
									Bolted=true, ExtraBolts=[45], TopOnly=TopOnly, BottomOnly=BottomOnly);
									
} // BoosterEBay

// BoosterEBay();



module BT54MotorRetainer(){
	MotorTubeHole_d=BT54Body_OD+IDXtra*3;
	MotorAftClosure_d=57.05;
	MotorAftClosure_h=10;
	Retainer_d=65;
	OAH=33;
	
	difference(){
		cylinder(d=Retainer_d, h=OAH, $fn=$preview? 90:360);
		
		// Aft closure
		translate([0,0,-Overlap]) cylinder(d=MotorAftClosure_d+IDXtra*4, h=15, $fn=$preview? 90:360);
		// motor body
		cylinder(d=BT54Body_ID+IDXtra, h=OAH, $fn=$preview? 90:360);
		// C-clip
		translate([0,0,3]) cylinder(d=MotorAftClosure_d+3, h=2, $fn=$preview? 90:360);
		translate([0,0,5]) cylinder(d1=MotorAftClosure_d+3, d2=MotorAftClosure_d+IDXtra*4, h=2, $fn=$preview? 90:360);
		// motor tube
		translate([0,0,18]) cylinder(d=MotorTubeHole_d, h=15+Overlap, $fn=$preview? 90:360);
		
		if ($preview) translate([0,0,-Overlap]) cube([50,50,50]);
	} // difference
	
} // BT54MotorRetainer

// BT54MotorRetainer();

module BoosterFinCan(LowerHalfOnly=false, UpperHalfOnly=false){
	Can_Len=Booster_Fin_Root_L+BoosterFinInset*2; //Booster_Body_Len;
	
	echo(Can_Len=Can_Len);
	RailGuide_Z=40;
	Retainer_d=65;
	
	difference(){
		FC2_FinCan(Body_OD=Body_OD, Body_ID=Body_ID, Can_Len=Can_Len,
				MotorTube_OD=MotorTube_OD, RailGuide_h=RailGuide_h, RailGuide_z=RailGuide_Z,
				nFins=nFins, HasIntegratedCoupler=true, Coupler_Len=15, nCouplerBolts=nFins*2,
				HasMotorSleeve=true, HasAftIntegratedCoupler=false,
				Fin_Root_W=Booster_Fin_Root_W, Fin_Root_L=Booster_Fin_Root_L, Fin_Post_h=Booster_Fin_Post_h, Fin_Chamfer_L=Booster_Fin_Chamfer_L,
				Cone_Len=TailConeLen, ThreadedTC=false, Extra_OD=2, RailGuideLen=40,
				LowerHalfOnly=LowerHalfOnly, UpperHalfOnly=UpperHalfOnly, 
				HasWireHoles=false, HollowTailcone=true, 
				HollowFinRoots=true, Wall_t=1.2, OgiveTailCone=false, Ogive_Len=400, OgiveCut_d=BT54Body_OD+8,
				UseTrapFin3=true);
				
		translate([0,0,-TailConeLen-Overlap]) cylinder(d=Retainer_d+IDXtra*3, h=20);
	} // difference
	
} // BoosterFinCan

// BoosterFinCan(LowerHalfOnly=false, UpperHalfOnly=false);

module BoosterMotorRetainer(){
	BT54MotorRetainer();
} // BoosterMotorRetainer

// BoosterMotorRetainer();

module RocketOmegaBoosterFin(){
	//  *** Ogive leading and trailing edges ***
	TrapFin3(Post_h=Booster_Fin_Post_h, Root_L=Booster_Fin_Root_L, Tip_L=Booster_Fin_Tip_L, 
				Root_W=Booster_Fin_Root_W, Tip_W=Booster_Fin_Tip_W, Span=Booster_Fin_Span, Chamfer_L=Booster_Fin_Chamfer_L,
				TipOffset=Booster_Fin_TipOffset, TipInset=0, HasBluntTip=false, TipPost_h=0,
				Bisect=false, Bisect_X=0,
				HasSpar=false, Spar_d=8, Spar_L=100, PrinterBrim_H=0.8, HasSpiralVaseRibs=false);

} // RocketOmegaBoosterFin

// RocketOmegaBoosterFin();




































