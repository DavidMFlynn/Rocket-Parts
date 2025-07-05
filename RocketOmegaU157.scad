// ***********************************
// Project: 3D Printed Rocket
// Filename: RocketOmegaU157.scad
// by David M. Flynn
// Created: 7/1/2025
// Revision: 0.9.3  7/5/2025
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
// Sustainer Upper Tube	482mm ULine 6" Mailing Tube
// Sustainer Lower Tube	670mm ULine 6" Mailing Tube
// Sustainer Motor Tube	645mm BT54Body
//
// Booster Body Tube 240mm 	ULine 6" Mailing Tube
// Booster Motor Tube	452mm BT54Body
//
//  ***** History *****
// 0.9.3  7/5/2025    Added Cineroc optional nosecone.
// 0.9.2  7/4/2025    Added fin art.
// 0.9.1  7/3/2025	  The Printing Begins! Little fixes.
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
// CenteringRing(OD=Body_ID, ID=EBayTube_OD+IDXtra, Thickness=4.8, nHoles=0, Offset=0, myfn=$preview? 90:720); // optional
// CenteringRing(OD=Body_ID, ID=MotorTube_OD, Thickness=4.8, nHoles=6, Offset=0, myfn=$preview? 90:720);
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
MainEB_HasCR=false;
CouplerLenXtra=MainEB_HasCR? 0:-20; // 0 for use w/ centering ring:servos extend into EBay
//
// rotate([180,0,0]) R157_BallRetainerTop(Body_OD=Body_OD*CF_Comp+Vinyl_t*2, Body_ID=Body_ID, EBayTube_OD=EBayTube_OD, Engagement_Len=Engagement_Len, nBolts=6, Xtra_r=STB_Xtra_r, CouplerLenXtra=CouplerLenXtra);
// rotate([180,0,0]) R157_BallRetainerTop(Body_OD=Body_OD*CF_Comp+Vinyl_t*2, Body_ID=Body_ID, EBayTube_OD=EBayTube_OD, Engagement_Len=Engagement_Len, nBolts=6, Xtra_r=STB_Xtra_r, CouplerLenXtra=-20);  // for Booster
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
// SustainerFinCan(LowerHalfOnly=false, UpperHalfOnly=true);
// rotate([180,0,0]) SustainerFinCan(LowerHalfOnly=true, UpperHalfOnly=false);
//
// RocketOmegaFin();
//
// BT54MotorRetainer(); // 2 Req.
//
//  *** Rail Guides ***
//
// rotate([90,0,0]) BoltOnRailGuide(Length = RailGuide_Len, BoltSpace=12.7, RoundEnds=true, ExtraBack=0);
// rotate([-90,0,0]) RailGuideSpacer(OD=Body_OD, H=RailGuide_h, Length = RailGuide_Len, BoltSpace=12.7);
//
// ================================
//  ***** Booster Only Parts *****
// ================================
//
//  *** Stager ***
//
// rotate([180,0,0]) Stager_Cup(Tube_OD=Body_OD*CF_Comp+Vinyl_t*2, nLocks=nLocks, BoltsOn=true, Collar_h=Stager_Collar_Len);
// rotate([-90,0,0]) Stager_LockRod(Adj=0.0);
//
// Stager_Saucer(Tube_OD=Body_OD*CF_Comp+Vinyl_t*2, nLocks=nLocks); // Bolts on
//
// Stager_LockRing(Tube_OD=Body_OD*CF_Comp+Vinyl_t*2, nLocks=nLocks); 
// Stager_Mech(Tube_OD=Body_OD*CF_Comp+Vinyl_t*2, nLocks=nLocks, Skirt_ID=Body_ID, Skirt_Len=Stager_Skirt_Len, nSkirtBolts=nEBayBolts, ShowLocked=true);
// Stager_BallSpacer(Tube_OD=Body_OD*CF_Comp+Vinyl_t*2); // print 2
//
// Stager_InnerRace(Tube_OD=Body_OD*CF_Comp+Vinyl_t*2);
// rotate([180,0,0]) Stager_Indexer(Tube_OD=Body_OD*CF_Comp+Vinyl_t*2, nLocks=nLocks); // Bolts to InnerRace
// Stager_ServoPlate(Tube_OD=Body_OD*CF_Comp+Vinyl_t*2, Skirt_ID=Body_ID, nLocks=nLocks, OverCenter=IDXtra+0.8); // Bottom Plate
// rotate([180,0,0]) Stager_ServoMount(UseLargeServo=true);
//
//  *** Fin Can ***
//
// BoosterFinCan(LowerHalfOnly=false, UpperHalfOnly=true);
// rotate([180,0,0]) BoosterFinCan(LowerHalfOnly=true, UpperHalfOnly=false);
//
// RocketOmegaBoosterFin();
//
// ================================
//  ***** Cineroc Only Parts *****
// ================================
//  Replaces main parachute bay and nosecone
//
// BluntConeNoseCone(ID=CNC_Body_ID, OD=CNC_Body_OD, L=CNC_NC_Len, Base_L=CBC_Base_L, nRivets=NC_nRivets, Tip_R=CNC_NC_Tip_r, Wall_T=CNC_NC_Wall_t);
// Cineroc_CameraMount();
// Cineroc_CameraTube();
// CinerocCoupler();
// CinerocTube(CNC_LowerTube_Len);
// Cineroc_Base();
//
// ===============
//  *** Tools ***
// ===============
//
// BodyDrillingJig(Tube_OD=Body_OD*CF_Comp+Vinyl_t*2, Tube_ID=Body_ID, nBolts=6, BoltInset=7.5);
// BodyDrillingJig(Tube_OD=Body_OD*CF_Comp+Vinyl_t*2, Tube_ID=Body_ID, nBolts=10, BoltInset=7.5);
//
// TubeTest(OD=Body_OD, ID=Body_ID, TestOD=false);
// TubeTest(OD=Body_OD+IDXtra*2, ID=Body_ID, TestOD=true);
//
// ***********************************
//  ***** for DXF output *****
//
//  ***** Fin Art *****
//  Save as dxf for LightBurn to cut on laser cutter.
//  Cut 4 of each, 32 pieces total.
//
// VinylSustainerFinBlack(); 
// VinylSustainerFinBlue();
// mirror([1,0,0]) VinylSustainerFinBlack(); 
// mirror([1,0,0]) VinylSustainerFinBlue();
//
// VinylBoosterFinBlack();
// VinylBoosterFinBlue();
// mirror([1,0,0]) VinylBoosterFinBlack();
// mirror([1,0,0]) VinylBoosterFinBlue();

//
// ***********************************
//  ***** Routines *****
//
//
// ***********************************
//  ***** for Viewing *****
//
// ShowCineroc(ShowInternals=false);
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
use<GoProCamLib.scad>

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
EBayTube_OD=ULine38Body_OD;


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
MainEBay_Len=MainEB_HasCR? 170:EBay_Len;

ScaleBooster_Body_Len=5*25.4*Scale;
echo(ScaleBooster_Body_Len=ScaleBooster_Body_Len);

PBay_Len=5*25.4*Scale;
LowerTube_Len=670;
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

STB_Len=MainEB_HasCR? 39+Engagement_Len:19+Engagement_Len;
Body_Len=19+SusFinCan_Len+EBay_Len+LowerTube_Len+MainEBay_Len+STB_Len*2+PBay_Len;
echo(Body_Len=Body_Len);

BoosterMotorTubeLen=BoostFinCan_Len+100;

// Body & Motor Tube Lengths
echo("Upper Body Tube = ",PBay_Len);
echo("Lower Body Tube = ",LowerTube_Len);
echo("Sustainer Motor Tube = ",SustainerMotorTube_Len);
echo("Booster Body = ",InterstageTube_Len);
echo("Booster Motor Tube = ",BoosterMotorTubeLen);

NC_Base_L=15;
NC_Len=170*Scale-NC_Base_L;
NC_Tip_r=5*Scale;
NC_Wall_t=2.2;
NC_nRivets=5;

RailGuide_h=Body_OD/2+2;
RailGuide_Len=40;
TailConeLen=40;

// ******************************
//  ***** Cineroc Nosecone *****

CNC_NC_Tip_r=0.375*25.4*Scale;
CNC_NC_Len=3.3*25.4*Scale;
CBC_Base_L=15;
CNC_NC_Wall_t=2.2;

CNC_Body_Wall_t=1.8;
CNC_Body_OD=1.8*25.4*Scale;
CNC_Body_ID=CNC_Body_OD-4.4;
CNC_Body_Len=(4.375+0.125*2)*25.4*Scale-30;
CNC_ParachuteTube_Len=300;
CNC_LowerTube_Len=CNC_ParachuteTube_Len-100;
CNC_UpperTube_Len=CNC_Body_Len-CNC_LowerTube_Len-3;

CNC_BaseTaper_Len=(1.0-0.125)*25.4*Scale;
CNC_Base_Len=CNC_BaseTaper_Len+15; // tapered portion plus shoulder
CNC_TubeEnd_OD=162.3;


module ShowCineroc(ShowInternals=false){
	Base_Z=0;
	ParachuteTube_Z=Base_Z+Engagement_Len/2;
	Body_Z=Base_Z+CNC_Base_Len;
	UpperBody_Z=Body_Z+CNC_LowerTube_Len+3;
	Nosecone_Z=Body_Z+CNC_Body_Len;
	
	echo(CBC_Base_L=CBC_Base_L);
	echo(CNC_NC_Len=CNC_NC_Len);
	translate([0,0,Nosecone_Z]) 
		BluntConeNoseCone(ID=CNC_Body_ID, OD=CNC_Body_OD, L=CNC_NC_Len, Base_L=CBC_Base_L, nRivets=NC_nRivets, 
					Tip_R=CNC_NC_Tip_r, Wall_T=CNC_NC_Wall_t);
					
		
	// Parachute Tube
	if (ShowInternals)
		translate([0,0,ParachuteTube_Z+0.1]) color("Tan")
			Tube(OD=Body_OD, ID=Body_ID, Len=CNC_ParachuteTube_Len-0.2, myfn=$preview? 90:360);
	
	//if (ShowInternals)
		translate([0,0,ParachuteTube_Z+CNC_ParachuteTube_Len-10]){
			rotate([0,0,180])
				NC_ShockcordRingDual(Tube_OD=Body_OD*CF_Comp+Vinyl_t*2, Tube_ID=Body_ID, 
					NC_ID=0, NC_Base_L=NC_Base_L, nRivets=NC_nRivets, nBolts=NC_nRivets, Flat=true);
					
			translate([0,0,13]) Cineroc_CameraMount();
		}
				
	// Upper tube
	if (!ShowInternals)
	translate([0,0,UpperBody_Z+0.1]) color("Gray") Cineroc_CameraTube();
	//echo(UpperBody_Z=UpperBody_Z);
	
	translate([0,0,Body_Z+CNC_LowerTube_Len]) CinerocCoupler();
	
	// Lower tube
	if (!ShowInternals)
	translate([0,0,Body_Z+0.1]) color("Gray") CinerocTube(CNC_LowerTube_Len);
	
	translate([0,0,Base_Z]) Cineroc_Base();
	
	translate([0,0,UpperBody_Z+30]) ShowCamera();
} // ShowCineroc

// ShowCineroc(ShowInternals=false);
// ShowCineroc(ShowInternals=true);
// ShowRocketOmega(ShowInternals=true, ShowCineroc=true);

CNC_CamCowl_W=0.375*25.4*Scale;
CNC_CamCowl_H=1.187*25.4*Scale; // height from center
CNC_CamCowl_Offset=(0.25+0.375/2)*25.4*Scale; // left of center
CNC_CanCowl_Z=3.075*25.4*Scale;

module Cineroc_CamCowl(){
	// too small for go-pro H11
	translate([-CNC_CamCowl_Offset, -CNC_CamCowl_H/2, 0]) RoundRect(X=CNC_CamCowl_W, Y=CNC_CamCowl_H, Z=0.2*25.4*Scale, R=1);
} // Cineroc_CamCowl

//translate([0,0,CNC_CanCowl_Z+50]) Cineroc_CamCowl();
	GPH11B_W=51;
	GPH11B_Y=26;
	GPH11B_H=40;
	GPH11B_r=7;
	Cowl_t=2.2;
	Camera_a=-10; // angle out
	Camera_Z=50; // from base of upper tube

module Cineroc_CameraTube(){
	difference(){
		CinerocTube(CNC_UpperTube_Len, HasCoupler=true);
		translate([0,0,Camera_Z-6]) GPH11B_Cowl_Hole();
	} // difference
	
	translate([0,0,Camera_Z-6]) GPH11B_Cowl();
} // Cineroc_CameraTube

//Cineroc_CameraTube();

module GPH11B_Cowl_Hole(){
	XtraSpace=2;
	
		hull(){
			translate([0, -CNC_Body_OD/2, -Overlap]) rotate([Camera_a,0,0])
				RoundRect(X=GPH11B_W+XtraSpace*2, Y=GPH11B_Y*2+XtraSpace*2, Z=GPH11B_H+Overlap*2, R=GPH11B_r);
			
			translate([0, -CNC_Body_OD/2+2,70])
				RoundRect(X=10, Y=1, Z=GPH11B_H, R=1);
		} // hull
} // GPH11B_Cowl_Hole

module GPH11B_Cowl(){
	XtraSpace=2;
	
	difference(){
		hull(){
			translate([0, -CNC_Body_OD/2, 0]) rotate([Camera_a,0,0])
				RoundRect(X=GPH11B_W+XtraSpace*2+Cowl_t*2, Y=GPH11B_Y*2+XtraSpace*2+Cowl_t*2, Z=GPH11B_H, R=GPH11B_r+Cowl_t);
				
			translate([0, -CNC_Body_OD/2+2, 80])
				RoundRect(X=10, Y=1, Z=GPH11B_H, R=1);
		} // hull
			
		GPH11B_Cowl_Hole();
		
		translate([0,0,-10]) cylinder(d=CNC_Body_ID+1, h=150);
		
	} // difference

} // GPH11B_Cowl

//translate([0,0,302.3+Camera_Z-6]) GPH11B_Cowl();

module Cineroc_CameraMount(){
	CameraPlate_t=5;
	Felt_t=3;
	CameraPlate_Z=34-CameraPlate_t-Felt_t; // place top of plate at bottom of cowl
	CameraPlate_W=GPH11B_W+10;
	CameraPlate_Len=110;
	Tube_Len=17;
	C_Block_H=10;
	C_Block_W=10;

	// Mount to NC_ShockcordRingDual like a nosecone
	difference(){
		Tube(OD=Body_OD*CF_Comp, ID=Body_ID+IDXtra*2, Len=Tube_Len, myfn=$preview? 90:360);
	
		// Rivets
		for (j=[0:NC_nRivets-1]) rotate([0,0,360/NC_nRivets*j]) translate([0,Body_OD/2+1,7.5])
			rotate([90,0,0]) cylinder(d=4, h=6);
	} // difference
	
	
	module CameraMountingHoles(){
		translate([0, -CNC_Body_OD/2, CameraPlate_Z+CameraPlate_t]) rotate([Camera_a,0,0]){
				translate([-GPH11B_W/2-C_Block_W/2,30,C_Block_H]) Bolt8Hole(depth=20);
				translate([GPH11B_W/2+C_Block_W/2,30,C_Block_H]) Bolt8Hole(depth=20);
				translate([0,46+C_Block_W/2,C_Block_H]) Bolt8Hole(depth=20);
			}
	}
	
	difference(){
		hull(){
			difference(){
				translate([0,0,Tube_Len-Overlap]) Tube(OD=Body_OD*CF_Comp, ID=Body_ID+IDXtra*2, Len=1, myfn=$preview? 90:360);
				translate([-Body_OD/2-5, -25, Tube_Len-Overlap*2]) cube([Body_OD+10,Body_OD,3]);
			} // difference
			
			difference(){
				intersection(){
					translate([0, -CNC_Body_OD/2, CameraPlate_Z]) rotate([Camera_a,0,0])
							RoundRect(X=CameraPlate_W, Y=CameraPlate_Len, Z=CameraPlate_t, R=3);
					cylinder(d=	CNC_Body_ID-1, h=100, $fn=$preview? 90:360);
				} // intersection
				
				translate([0, -CNC_Body_OD/2, CameraPlate_Z]) rotate([Camera_a,0,0])
					translate([0,0,5]) cube([GPH11B_W, 10, CameraPlate_t*2+Overlap*2], center=true);
				
			} // difference
		} // hull
		
		// Bolt Holes
		CameraMountingHoles();
	} // difference
	
	// Camera locating bolcks
	difference(){
		translate([0, -CNC_Body_OD/2, CameraPlate_Z+CameraPlate_t]) rotate([Camera_a,0,0]){
			translate([-GPH11B_W/2-C_Block_W/2,30,-1]) 
				RoundRect(X=C_Block_W, Y=20, Z=C_Block_H, R=2);
			
			translate([GPH11B_W/2+C_Block_W/2,30,-1])
				RoundRect(X=C_Block_W, Y=20, Z=C_Block_H, R=2);
			
			translate([0,46+C_Block_W/2,-1])
				RoundRect(X=20, Y=C_Block_W, Z=C_Block_H, R=2);
			
		}
		CameraMountingHoles();
	} // difference
} // Cineroc_CameraMount

//translate([0,0,302.3+16]) Cineroc_CameraMount();

module ShowCamera(){
	translate([0,-CNC_Body_OD/2,Camera_Z])
		rotate([Camera_a,0,0]) translate([0,15,0]) rotate([180,0,-90]) 
			color("LightGray") GPC_GoProHero11Black(Xtra=0, Xtra_Z=0, IncludeVP=false, BackAccess=false, HasMountingEars=false);
} // ShowCamera

//translate([0,0,302.3+29]) ShowCamera();

module Cineroc_Base(){

	difference(){
		union(){
			cylinder(d1=Body_OD*CF_Comp+Vinyl_t*2, d2=CNC_Body_OD*CF_Comp, h=CNC_BaseTaper_Len, $fn=$preview? 90:360);
			
			translate([0,0,CNC_BaseTaper_Len-Overlap])
				Tube(OD=CNC_Body_OD*CF_Comp, ID=CNC_Body_ID, Len=15+Overlap, myfn=$preview? 90:360);
				
			translate([0,0,CNC_BaseTaper_Len+15])
				Tube(OD=CNC_Body_ID, ID=CNC_Body_ID-CNC_Body_Wall_t*2, Len=15, myfn=$preview? 90:360);
				
			// connector
			translate([0,0,CNC_BaseTaper_Len+10])
			difference(){
				Tube(OD=CNC_Body_ID+1, ID=CNC_Body_ID-CNC_Body_Wall_t*2, Len=5, myfn=$preview? 90:360);
					
				translate([0,0,-Overlap]) cylinder(d1=CNC_Body_ID-Overlap, d2=CNC_Body_ID-CNC_Body_Wall_t*2-Overlap, h=5, $fn=$preview? 90:360);
			} // difference
		} // union
		
		translate([0,0,-Overlap])
			cylinder(d1=Body_ID, d2=CNC_Body_ID, h=CNC_BaseTaper_Len+Overlap*2, $fn=$preview? 90:360);
			
		translate([0,0,-Overlap]) cylinder(d=Body_OD+1, h=40, $fn=$preview? 90:360);
			
		// Bolts
		for (j=[0:NC_nRivets-1]) rotate([0,0,360/NC_nRivets*j]) translate([0,CNC_Body_OD/2+1,CNC_BaseTaper_Len+15+7.5])
			rotate([-90,0,0]) Bolt4Hole();
		
	} // difference
	
	//translate([0,0,-Engagement_Len/2]) 
	rotate([180,0,0]) 
		STB_TubeEnd(Body_ID=Body_ID, nLockBalls=nLockBalls, Body_OD=Body_OD*CF_Comp, Engagement_Len=Engagement_Len);
} // Cineroc_Base

// Cineroc_Base();

module CinerocTube(Len=CNC_Body_Len/2, HasCoupler=false){
	UpperBolt_Z=HasCoupler? Len+7.5:Len-7.5;
	difference(){
		union(){
			Tube(OD=CNC_Body_OD*CF_Comp, ID=CNC_Body_ID, Len=Len, myfn=$preview? 90:360);
			
			if (HasCoupler){
				translate([0,0,Len-Overlap]) Tube(OD=CNC_Body_ID, ID=CNC_Body_ID-4.4, Len=15, myfn=$preview? 90:360);
				translate([0,0,Len-5]) Tube(OD=CNC_Body_ID+1, ID=CNC_Body_ID-4.4, Len=5, myfn=$preview? 90:360);
			}
		} // union
		
		if (HasCoupler){
			translate([0,0,Len-5-Overlap]) cylinder(d1=CNC_Body_ID, d2=CNC_Body_ID-4.4, h=5, $fn=$preview? 90:360);
		}
		
		for (j=[0:NC_nRivets]) rotate([0, 0, 360/NC_nRivets*j]){
			translate([0, CNC_Body_OD/2+1, UpperBolt_Z]) rotate([-90,0,0]) Bolt4Hole();
			translate([0, CNC_Body_OD/2+1, 7.5]) rotate([-90,0,0]) Bolt4Hole();
		}
	} // difference
} // CinerocTube

// CinerocTube();
// CinerocTube(CNC_UpperTube_Len,HasCoupler=true);

module CinerocCoupler(){
	Coulper_ID=CNC_Body_ID-4.4;
	Len=33;
	
	difference(){
		union(){
			translate([0,0,-15]) Tube(OD=CNC_Body_ID, ID=Coulper_ID, Len=33, myfn=$preview? 90:360);
			// outer flange
			Tube(OD=CNC_Body_OD*CF_Comp, ID=Coulper_ID, Len=3, myfn=$preview? 90:360);
			// centering ring
			translate([0,0,-15]) Tube(OD=CNC_Body_ID-1, ID=Body_OD*CF_Comp+IDXtra*2, Len=3, myfn=$preview? 90:360);
		} // union
		
		for (j=[0:NC_nRivets]) rotate([0, 0, 360/NC_nRivets*j]){
			translate([0, CNC_Body_OD/2+1, 3+7.5]) rotate([-90,0,0]) Bolt4Hole();
			translate([0, CNC_Body_OD/2+1, -7.5]) rotate([-90,0,0]) Bolt4Hole();
			// must slide past bolts in parachute tube
			rotate([0,0,180/NC_nRivets]) translate([0, Body_OD/2, -15-Overlap]) scale([1.5,1,1]) cylinder(d=6, h=4);
		}
	} // difference
} // CinerocCoupler

// CinerocCoupler();

module ShowBooster(ShowInternals=true){
	MotorTube_Z=-TailConeLen+5;
	FinCan_Z=0;
	Fin_Z=FinCan_Z+Booster_Fin_Root_L/2+BoosterFinInset;
	Body_Z=FinCan_Z+BoostFinCan_Len+0.1;
	SpringEnd_Z=Body_Z+InterstageTube_Len-157;
	STB_Z=Body_Z+InterstageTube_Len+10;
	Ebay_Z=STB_Z+19.2;
	Stager_Z=Ebay_Z+EBay_Len+54.4;
	Saucer_Z=Stager_Z+0.1;

	translate([0,0,Saucer_Z]) color("Gray") Stager_Saucer(Tube_OD=Body_OD, nLocks=nLocks);
	translate([0,0,Stager_Z]) rotate([0,0,180/nEBayBolts]){
		color("White")
		Stager_Mech(Tube_OD=Body_OD, nLocks=nLocks, Skirt_ID=Body_ID, Skirt_Len=Stager_Skirt_Len, nSkirtBolts=nEBayBolts, ShowLocked=true);
		if (ShowInternals) ShowStagerAssy(Tube_OD=Body_OD, Tube_ID=Body_ID, nLocks=nLocks, ShowLocked=true);
	}
	
	
	//*
	translate([0,0,Ebay_Z]) color("White") 
		BoosterEBay(TopOnly=false, BottomOnly=false, ShowDoors=!ShowInternals);
	/**/
	
	translate([0,0,STB_Z+0.1]) color("White")
		R157_BallRetainerTop(Body_OD=Body_OD*CF_Comp+Vinyl_t*2, Body_ID=Body_ID, EBayTube_OD=BT54Body_OD, Engagement_Len=Engagement_Len, nBolts=6, Xtra_r=STB_Xtra_r, CouplerLenXtra=-20);
	
	if (ShowInternals) translate([0,0,STB_Z]) {
		R157_BallRetainerBottom(Body_ID=Body_ID, Engagement_Len=Engagement_Len, Xtra_r=0.0);
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
	translate([0,0,FinCan_Z-TailConeLen-13]) color("Gray") BT54MotorRetainer();
	
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


module ShowRocketOmega(ShowInternals=true, ShowCineroc=false){
	
	InterstageCoupler_Len=InterstageTube_Len;
	
	SusFinCan_Z=BoostFinCan_Len+InterstageCoupler_Len+266;
	MotorTube_Z=SusFinCan_Z-5;
		
	LowerEBay_Z=SusFinCan_Z+SusFinCan_Len;
		
	LowerTube_Z=LowerEBay_Z+EBay_Len-15;
	
	DrogueSTB_Z=LowerTube_Z+LowerTube_Len;
	EBay_Z=DrogueSTB_Z+39.2+CouplerLenXtra;
	MainSTB_Z=EBay_Z+MainEBay_Len+39.2+CouplerLenXtra;
		
	
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
		
	// Cineroc option
	if (ShowCineroc)
		translate([200,0,MainSTB_Z]) ShowCineroc(ShowInternals=ShowInternals);

	if (ShowInternals) translate([0,0,MainSTB_Z]){
		rotate([180,0,0]) color("Tan")
			R157_BallRetainerBottom(Body_ID=Body_ID, Engagement_Len=Engagement_Len, Xtra_r=0.0);
		translate([0,0,Engagement_Len/2]) R157_SkirtRing(Coupler_OD=Coupler_OD, Coupler_ID=Coupler_ID, HasPD_Ring=false, Engagemnet_Len=7);
	}
	translate([0,0,MainSTB_Z]) color("White") rotate([180,0,0])
		R157_BallRetainerTop(Body_OD=Body_OD*CF_Comp+Vinyl_t*2, Body_ID=Body_ID, EBayTube_OD=BT54Body_OD, Engagement_Len=Engagement_Len, 
							nBolts=6, Xtra_r=STB_Xtra_r,CouplerLenXtra=CouplerLenXtra);

	translate([0,0,EBay_Z]) 
		rotate([0,0,180-180/nFins]) color("White") 
			MainEBay(TopOnly=false, BottomOnly=false, ShowDoors=!ShowInternals);
	
	translate([0,0,DrogueSTB_Z]) color("White")
		R157_BallRetainerTop(Body_OD=Body_OD*CF_Comp+Vinyl_t*2, Body_ID=Body_ID, EBayTube_OD=BT54Body_OD, Engagement_Len=Engagement_Len, 
							nBolts=6, Xtra_r=STB_Xtra_r, CouplerLenXtra=CouplerLenXtra);

	if (ShowInternals) translate([0,0,DrogueSTB_Z]){
		color("Tan") R157_BallRetainerBottom(Body_ID=Body_ID, Engagement_Len=Engagement_Len, Xtra_r=0.0);
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

	if (ShowInternals) translate([0,0,LowerEBay_Z+EBay_Len]) color("Green")
		CenteringRing(OD=Body_ID, ID=MotorTube_OD, Thickness=4.8, nHoles=6, Offset=0, myfn=$preview? 90:720);
			
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
			
	translate([0,0,MotorTube_Z-18]) color("Gray") BT54MotorRetainer();
	
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
									HasRailGuide=false, RailGuideLen=RailGuide_Len,
									HasFwdCenteringRing=false, HasAftCenteringRing=false, InnerTube_OD=ULine38Body_OD,
									Bolted=true, ExtraBolts=[45], TopOnly=TopOnly, BottomOnly=BottomOnly);
									
	if (MainEB_HasCR){
		// Bottom centering ring stop
		if (!TopOnly) translate([0,0,TubeStop_Z]) 
			TubeStop(InnerTubeID=Coupler_ID, OuterTubeOD=Body_OD, myfn=$preview? 36:360);
			
		// Top centering ring stop
		if (!BottomOnly) translate([0,0,MainEBay_Len-TubeStop_Z]) rotate([180,0,0])
			TubeStop(InnerTubeID=Coupler_ID, OuterTubeOD=Body_OD, myfn=$preview? 36:360);
	}
									
} // MainEBay

// MainEBay();

module LowerEBay(TopOnly=false, BottomOnly=false, ShowDoors=false){
	Doors_a=[[45],[225],[]];
	nBolts=BottomOnly? nFins*2:nEBayBolts;

	EB_Electronics_BayUniversal(Tube_OD=Body_OD*CF_Comp+Vinyl_t*2, Tube_ID=Body_ID, DoorAngles=Doors_a, Len=EBay_Len, 
									nBolts=nBolts, BoltInset=7.5, ShowDoors=ShowDoors,
									HasFwdIntegratedCoupler=true, HasFwdShockMount=false,
									HasAftIntegratedCoupler=false, HasAftShockMount=false,
									HasRailGuide=false, RailGuideLen=RailGuide_Len,
									HasFwdCenteringRing=false, HasAftCenteringRing=false, InnerTube_OD=0,
									Bolted=true, ExtraBolts=[60,90,120], TopOnly=TopOnly, BottomOnly=BottomOnly);
									
} // LowerEBay

// LowerEBay();

module SustainerFinCan(LowerHalfOnly=false, UpperHalfOnly=false){
	
	Can_Len=Sustainer_Fin_Root_L+SustainerFinInset*2;
	echo(Can_Len=Can_Len);
	RailGuide_Z=35;
	Retainer_d=65;	
	Rocket_OD=Body_OD*CF_Comp+Vinyl_t*2;
	
	difference(){
		union(){
			FC2_FinCan(Body_OD=Rocket_OD, Body_ID=Body_ID, Can_Len=Can_Len,
				MotorTube_OD=MotorTube_OD, RailGuide_h=RailGuide_h, RailGuide_z=RailGuide_Z,
				nFins=nFins, HasIntegratedCoupler=true, Coupler_Len=15, nCouplerBolts=nFins*2,
				HasMotorSleeve=true, HasAftIntegratedCoupler=false,
				Fin_Root_W=Sustainer_Fin_Root_W, Fin_Root_L=Sustainer_Fin_Root_L, 
				Fin_Post_h=Sustainer_Fin_Post_h, Fin_Chamfer_L=Sustainer_Fin_Chamfer_L,
				Cone_Len=0, ThreadedTC=false, Extra_OD=0, RailGuideLen=RailGuide_Len,
				LowerHalfOnly=LowerHalfOnly, UpperHalfOnly=UpperHalfOnly, 
				HasWireHoles=false, HollowTailcone=true, 
				HollowFinRoots=true, Wall_t=1.2, OgiveTailCone=false, Ogive_Len=400, OgiveCut_d=BT54Body_OD+8,
				UseTrapFin3=true);
					
			if (!UpperHalfOnly){
				// Motor Retainer Socket
				translate([0,0,-2]) cylinder(d=Retainer_d+5, h=25);
				translate([0,0,-2+25-Overlap]) cylinder(d1=Retainer_d+5, d2=MotorTube_OD+4, h=8);
			}
		
			if (!UpperHalfOnly){
				// Stager cup mounts here
				translate([0,0,-2])
				difference(){
					cylinder(d=Rocket_OD, h=6, $fn=$preview? 90:360);
					translate([0,0,-Overlap]) cylinder(d=MotorTube_OD+IDXtra*3, h=30+Overlap*2);
				} // difference
			}
		} // union
		
		// Igniter wirs
		rotate([0,0,180/nFins+180]) translate([Sus_IgnitionWireOffset,0,-20]) 
			cylinder(d=6.35, h=Sustainer_Fin_Root_L+70);
			
		// motor retainer
		translate([0,0,-2-Overlap]) cylinder(d=Retainer_d+IDXtra*3, h=20);
		cylinder(d=MotorTube_OD+IDXtra*3, h=40);
		
		// Booster attachment
		translate([0,0,-2]) 
		  Stager_CupBoltHoles(Tube_OD=Rocket_OD, nLocks=nLocks) rotate([180,0,0]) Bolt4Hole();
		
	} // difference
} // SustainerFinCan

// SustainerFinCan();	
	
module VinylSustainerFinBlack(ShowIn3D=false){
	if (ShowIn3D){
		hull(){
			translate([0,-Sustainer_Fin_Root_L/2+6,Sustainer_Fin_Post_h+4]) 
				rotate([0,90,0]) cylinder(d=1, h=Sustainer_Fin_Root_W+1, center=true);
			translate([0,-Sustainer_Fin_Root_L/2+6,Sustainer_Fin_Post_h+4]) rotate([22.5,0,0]) 
				translate([0,Sustainer_Fin_Root_L-8,0]) rotate([0,90,0]) cylinder(d=1, h=Sustainer_Fin_Root_W+1, center=true);
			translate([0,Sustainer_Fin_Root_L/2-6,Sustainer_Fin_Post_h+4]) rotate([0,90,0]) cylinder(d=1, h=Sustainer_Fin_Root_W+1, center=true);
		} // hull
	}else{
	
		hull(){
			translate([0,-Sustainer_Fin_Root_L/2+6,0]) circle(d=1);
			translate([0,-Sustainer_Fin_Root_L/2+6,0]) rotate([0,0,22.5])
				translate([0,Sustainer_Fin_Root_L-8,0]) circle(d=1);
			translate([0,Sustainer_Fin_Root_L/2-6,0]) circle(d=1);
		} // hull
		
	} // if
} // VinylSustainerFinBlack

// color("Gray") VinylSustainerFinBlack(ShowIn3D=false);
// translate([Sustainer_Fin_Post_h+4,0,-Sustainer_Fin_Root_W/2-1.3]) rotate([0,-90,0]) color("Gray") VinylSustainerFinBlack(ShowIn3D=true);

module VinylSustainerFinBlue(ShowIn3D=false){
	if (ShowIn3D){
		hull(){
			translate([0,-Sustainer_Fin_Root_L/2+6,Sustainer_Fin_Post_h+5]) rotate([0,90,0]) cylinder(d=1, h=Sustainer_Fin_Root_W+1, center=true);
			
			translate([0,Sustainer_Fin_Tip_L/2-4,Sustainer_Fin_Post_h+5+Sustainer_Fin_Span-8]) 
				rotate([0,90,0]) cylinder(d=1, h=Sustainer_Fin_Root_W+1, center=true);
			
			translate([0,-Sustainer_Fin_Root_L/2+6,Sustainer_Fin_Post_h+5]) rotate([46,0,0]) 
				translate([0,Sustainer_Fin_Root_L,0]) rotate([0,90,0]) cylinder(d=1, h=Sustainer_Fin_Root_W+1, center=true);
				
			translate([0,-Sustainer_Fin_Root_L/2+6,Sustainer_Fin_Post_h+5]) rotate([23,0,0])
				translate([0,Sustainer_Fin_Root_L-8,0]) 
					rotate([0,90,0]) cylinder(d=1, h=Sustainer_Fin_Root_W+1, center=true);
					
		} // hull
	}else{
		hull(){
			translate([-1,-Sustainer_Fin_Root_L/2+6,0]) circle(d=1);
			
			translate([-1-Sustainer_Fin_Span+8,Sustainer_Fin_Tip_L/2-4,]) 
				circle(d=1);
			
			translate([-1,-Sustainer_Fin_Root_L/2+6,0]) rotate([0,0,46]) 
				translate([0,Sustainer_Fin_Root_L,0]) circle(d=1);
				
			translate([-1,-Sustainer_Fin_Root_L/2+6,0]) rotate([0,0,23])
				translate([0,Sustainer_Fin_Root_L-8,0]) 
					circle(d=1);
		
		}
	} // if

} // VinylSustainerFinBlue

// color("LightBlue") VinylSustainerFinBlue(ShowIn3D=false);
// translate([Sustainer_Fin_Post_h+4,0,-Sustainer_Fin_Root_W/2-1.3]) rotate([0,-90,0]) color("LightBlue") VinylSustainerFinBlue(ShowIn3D=true);

module RocketOmegaFin(){
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
									HasRailGuide=true, RailGuideLen=RailGuide_Len,
									HasFwdCenteringRing=false, HasAftCenteringRing=false, InnerTube_OD=0,
									Bolted=true, ExtraBolts=[45], TopOnly=TopOnly, BottomOnly=BottomOnly);
									
} // BoosterEBay

// BoosterEBay();

module BoosterFinCan(LowerHalfOnly=false, UpperHalfOnly=false){
	Can_Len=Booster_Fin_Root_L+BoosterFinInset*2; //Booster_Body_Len;
	
	echo(Can_Len=Can_Len);
	RailGuide_Z=35;
	Retainer_d=65;
	Rocket_OD=Body_OD*CF_Comp+Vinyl_t*2;
	
	difference(){
		FC2_FinCan(Body_OD=Rocket_OD, Body_ID=Body_ID, Can_Len=Can_Len,
				MotorTube_OD=MotorTube_OD, RailGuide_h=RailGuide_h, RailGuide_z=RailGuide_Z,
				nFins=nFins, HasIntegratedCoupler=true, Coupler_Len=15, nCouplerBolts=nFins*2,
				HasMotorSleeve=true, HasAftIntegratedCoupler=false,
				Fin_Root_W=Booster_Fin_Root_W, Fin_Root_L=Booster_Fin_Root_L, Fin_Post_h=Booster_Fin_Post_h, Fin_Chamfer_L=Booster_Fin_Chamfer_L,
				Cone_Len=TailConeLen, ThreadedTC=false, Extra_OD=2, RailGuideLen=RailGuide_Len,
				LowerHalfOnly=LowerHalfOnly, UpperHalfOnly=UpperHalfOnly, 
				HasWireHoles=false, HollowTailcone=true, 
				HollowFinRoots=true, Wall_t=1.2, OgiveTailCone=false, Ogive_Len=400, OgiveCut_d=BT54Body_OD+8,
				UseTrapFin3=true);
				
		translate([0,0,-TailConeLen-Overlap]) cylinder(d=Retainer_d+IDXtra*3, h=20);
	} // difference
	
} // BoosterFinCan

// BoosterFinCan(LowerHalfOnly=false, UpperHalfOnly=false);


module VinylBoosterFinBlack(ShowIn3D=false){
	EdgeInset=6;
	RootInset=4; // for 3D only
	MidPointAdj=-7;
	
	if (ShowIn3D){
		hull(){
			translate([0, -Booster_Fin_Root_L/2+EdgeInset, Booster_Fin_Post_h+RootInset]) 
				rotate([0,90,0]) cylinder(d=1, h=Booster_Fin_Root_W+1, center=true);
				
			translate([0,-Booster_Fin_Root_L/2+EdgeInset,Booster_Fin_Post_h+RootInset]) rotate([22.5,0,0]) 
				translate([0,Booster_Fin_Root_L+MidPointAdj,0]) rotate([0,90,0]) cylinder(d=1, h=Booster_Fin_Root_W+1, center=true);
				
			translate([0,Booster_Fin_Root_L/2-EdgeInset,Booster_Fin_Post_h+RootInset]) 
				rotate([0,90,0]) cylinder(d=1, h=Booster_Fin_Root_W+1, center=true);
		} // hull
	}else{
	
		hull(){
			translate([0,-Booster_Fin_Root_L/2+EdgeInset,0]) circle(d=1);
			translate([0,-Booster_Fin_Root_L/2+EdgeInset,0]) rotate([0,0,22.5])
				translate([0,Booster_Fin_Root_L+MidPointAdj,0]) circle(d=1);
			translate([0,Booster_Fin_Root_L/2-EdgeInset,0]) circle(d=1);
		} // hull
		
	} // if
} // VinylBoosterFinBlack

// color("Gray") VinylBoosterFinBlack(ShowIn3D=false);
// translate([Booster_Fin_Post_h+4,0,-Booster_Fin_Root_W/2-1.3]) rotate([0,-90,0]) color("Gray") VinylBoosterFinBlack(ShowIn3D=true);

module VinylBoosterFinBlue(ShowIn3D=false){
	EdgeInset=6;
	RootInset=5; // for 3D only
	RootInset2D=-1; // move over from Black
	MidPointAdj=-6.5;
	TipAdj=2.4;
	
	if (ShowIn3D){
		hull(){
			translate([0,-Booster_Fin_Root_L/2+EdgeInset, Booster_Fin_Post_h+RootInset]) 
				rotate([0,90,0]) cylinder(d=1, h=Booster_Fin_Root_W+1, center=true);
			
			translate([0, Booster_Fin_Tip_L/2-4, Booster_Fin_Post_h+Booster_Fin_Span-4]) 
				rotate([0,90,0]) cylinder(d=1, h=Booster_Fin_Root_W+1, center=true);
			
			translate([0,-Booster_Fin_Root_L/2+EdgeInset,Booster_Fin_Post_h+RootInset]) rotate([46,0,0]) 
				translate([0,Booster_Fin_Root_L+TipAdj,0]) rotate([0,90,0]) cylinder(d=1, h=Booster_Fin_Root_W+1, center=true);
				
			translate([0,-Booster_Fin_Root_L/2+EdgeInset,Booster_Fin_Post_h+RootInset]) rotate([23,0,0])
				translate([0,Booster_Fin_Root_L+MidPointAdj,0]) 
					rotate([0,90,0]) cylinder(d=1, h=Booster_Fin_Root_W+1, center=true);
					
		} // hull
	}else{
		hull(){
			translate([RootInset2D, -Booster_Fin_Root_L/2+EdgeInset, 0]) circle(d=1);
			
			translate([RootInset2D-Booster_Fin_Span+9, Booster_Fin_Tip_L/2-4,0]) 
				circle(d=1);
			
			translate([RootInset2D, -Booster_Fin_Root_L/2+EdgeInset, 0]) rotate([0,0,46]) 
				translate([0,Booster_Fin_Root_L+TipAdj,0]) circle(d=1);
				
			translate([RootInset2D, -Booster_Fin_Root_L/2+EdgeInset, 0]) rotate([0,0,23])
				translate([0,Booster_Fin_Root_L+MidPointAdj,0]) 
					circle(d=1);
		
		}
	} // if

} // VinylBoosterFinBlue

// color("LightBlue") VinylBoosterFinBlue(ShowIn3D=false);
// translate([Booster_Fin_Post_h+4,0,-Booster_Fin_Root_W/2-1.3]) rotate([0,-90,0]) color("LightBlue") VinylBoosterFinBlue(ShowIn3D=true);

module RocketOmegaBoosterFin(){
	//  *** Ogive leading and trailing edges ***
	TrapFin3(Post_h=Booster_Fin_Post_h, Root_L=Booster_Fin_Root_L, Tip_L=Booster_Fin_Tip_L, 
				Root_W=Booster_Fin_Root_W, Tip_W=Booster_Fin_Tip_W, Span=Booster_Fin_Span, Chamfer_L=Booster_Fin_Chamfer_L,
				TipOffset=Booster_Fin_TipOffset, TipInset=0, HasBluntTip=false, TipPost_h=0,
				Bisect=false, Bisect_X=0,
				HasSpar=false, Spar_d=8, Spar_L=100, PrinterBrim_H=0.8, HasSpiralVaseRibs=false);

} // RocketOmegaBoosterFin

// RocketOmegaBoosterFin();




































