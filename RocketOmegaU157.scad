// ***********************************
// Project: 3D Printed Rocket
// Filename: RocketOmegaU157.scad
// by David M. Flynn
// Created: 7/1/2025
// Revision: 0.9.7  7/15/2025
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  This is a partial design, booster is just too long to look like an Omega
//  6" Upscale of Estes Astron Omega
//  Two Stage Rocket with ULine 6" Body.
//  K1100T or K1800ST to K550W or K480W
//
//  ***** Tubes to Cut *****
// Sustainer Upper Tube	482mm ULine 6" Mailing Tube
// Sustainer Lower Tube	670mm ULine 6" Mailing Tube
// Sustainer Motor Tube	645mm BT54Body
//
// Booster Body Tube 240mm 	ULine 6" Mailing Tube
// Booster Motor Tube	452mm BT54Body or BT75Body
//
//  ***** History *****
// 0.9.7  7/15/2025   Petal wall thickness and pusher rings.
// 0.9.6  7/13/2025   Still printing and fixing problems.
// 0.9.5  7/11/2025   Moved Cineroc stuff to its own file.
// 0.9.4  7/10/2025   Fixed small issues.
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
//  ***** Options *****
//
MainEB_HasCR=false;	// Use centering rings in sustainer's main electronics bay?
CouplerLenXtra=MainEB_HasCR? 0:-20; // 0 for use w/ centering ring:servos extend into EBay
BoosterHas75mmMotor=true; // Selects 75mm motor size for the booster. false = 54mm
nPetals=6; // 3? or 6?
PetalWall_t=2.6; // minimum to get 4 layers when sliced
STB_Xtra_r=0.3; // Makes the lock tighter
//
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
// SE_SpringEndTypeC(Coupler_OD=Coupler_OD*CF_Comp, Coupler_ID=CouplerThinWall_ID*CF_Comp, Len=10, nRopes=6, UseSmallSpring=false);
// SE_SlidingBigSpringMiddle(OD=Coupler_OD*CF_Comp, SliderLen=50, Extension=0);
//
//  for Sustainer Main Petal Hub
// rotate([180,0,0]) R157_PusherRing(OD=Coupler_OD*CF_Comp, ID=CouplerThinWall_ID*CF_Comp, OA_Len=50, Engagemnet_Len=7, Wall_t=4, PetalStop_h=0); 
// R157_SkirtPHRing(Coupler_OD=Coupler_OD*CF_Comp, Coupler_ID=CouplerThinWall_ID*CF_Comp, Engagemnet_Len=7); // for Sustainer Main
//
//  for top of Main EBay
// R157_PusherRing(OD=Coupler_OD*CF_Comp, ID=CouplerThinWall_ID*CF_Comp, OA_Len=50, Engagemnet_Len=7, Wall_t=PetalWall_t+2, PetalStop_h=3, PetalWall_t=PetalWall_t, nBolts=6); 
// R157_SkirtRing(Coupler_OD=Coupler_OD*CF_Comp, Coupler_ID=CouplerThinWall_ID*CF_Comp, HasPD_Ring=false, Engagemnet_Len=7);
// 
// rotate([180,0,0]) R157_MotorTubeTopper(OD=Body_ID*CF_Comp, MotorTube_OD=BT54Body_OD+IDXtra, MotorTube_ID=BT54Body_ID, Len=35); // for Sustainer
// EbayAlignmentCR(OD=Body_ID*CF_Comp); // for Sustainer, top of lower EBay
//
//  for Booster
// rotate([180,0,0]) R157_PusherRing(OD=Coupler_OD*CF_Comp, ID=CouplerThinWall_ID*CF_Comp, OA_Len=50, Engagemnet_Len=7, Wall_t=PetalWall_t+2, PetalStop_h=3, PetalWall_t=PetalWall_t, nBolts=0);
// SE_SpringEndTypeC(Coupler_OD=Coupler_OD*CF_Comp, Coupler_ID=CouplerThinWall_ID*CF_Comp, Len=20, nRopes=6, UseSmallSpring=false); // for Booster
//
//
//  *** Electronics Bays ***
//
// rotate([180,0,0]) MainEBay(TopOnly=true, BottomOnly=false, ShowDoors=false);
// MainEBay(TopOnly=false, BottomOnly=true, ShowDoors=false);
// CenteringRing(OD=Body_ID, ID=EBayTube_OD+IDXtra, Thickness=4.8, nHoles=0, Offset=0, myfn=$preview? 90:720); // optional
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
// rotate([180,0,0]) R157_BallRetainerTop(Body_OD=Body_OD*CF_Comp+Vinyl_t*2, Body_ID=Body_ID, EBayTube_OD=EBayTube_OD, Engagement_Len=Engagement_Len, nBolts=6, Xtra_r=STB_Xtra_r, CouplerLenXtra=CouplerLenXtra);
// rotate([180,0,0]) R157_BallRetainerTop(Body_OD=Body_OD*CF_Comp+Vinyl_t*2, Body_ID=Body_ID, EBayTube_OD=EBayTube_OD, Engagement_Len=Engagement_Len, nBolts=6, Xtra_r=STB_Xtra_r, CouplerLenXtra=-20);  // for Booster
// STB_LockDisk(Body_ID=Body_ID, nLockBalls=nLockBalls, HasLargeInnerBearing=true, Xtra_r=STB_Xtra_r);
// R157_BallRetainerBottom(Body_ID=Body_ID, Engagement_Len=Engagement_Len, Xtra_r=STB_Xtra_r);
// STB_TubeEnd(Body_ID=Body_ID, nLockBalls=nLockBalls, Body_OD=Body_OD*CF_Comp, Engagement_Len=Engagement_Len);
//
//  *** Petal Deployers ***
//
// R157_PetalHub(OD=Coupler_OD*CF_Comp, nPetals=nPetals, nBolts=6); // 2 Req.
// R157_PetalHub(OD=Coupler_OD*CF_Comp, nPetals=nPetals, nBolts=6, nRopes=6); // for Sustainer Main
//
// PD_Petals2(OD=Coupler_OD*CF_Comp, Len=MainPetal_Len, nPetals=nPetals, Wall_t=PetalWall_t, AntiClimber_h=5, HasLocks=false, Lock_Span_a=180);
// PD_Petals2(OD=Coupler_OD*CF_Comp, Len=DroguePetal_Len, nPetals=nPetals, Wall_t=PetalWall_t, AntiClimber_h=5, HasLocks=false, Lock_Span_a=180);
// PD_Petals2(OD=Coupler_OD*CF_Comp, Len=BoosterPetalLen, nPetals=nPetals, Wall_t=PetalWall_t, AntiClimber_h=5, HasLocks=false, Lock_Span_a=180);
//
// rotate([-90,0,0]) PD_PetalSpringHolder2();
// PD_HubSpringHolder();
//
//  *** Fins & Fin Cans ***
//
// SustainerFinCan(LowerHalfOnly=false, UpperHalfOnly=true);
// SustainerFinCan(LowerHalfOnly=true, UpperHalfOnly=false);
//
// RocketOmegaFin();
//
// BT54MotorRetainer();
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
// rotate([-90,0,0]) Stager_LockRod(Adj=-0.5);  // 0.0 was too loose
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
//  75mm motor only
// rotate([180,0,0]) R157_MotorTubeTopper(OD=Body_ID*CF_Comp, MotorTube_OD=BoosterMotorTube_OD+IDXtra, MotorTube_ID=BoosterMotorTube_ID, Len=35);
// SE_SpringEndTypeB(Coupler_OD=ULine157Coupler_OD, MotorCoupler_OD=BT75Coupler_OD, nRopes=6, UseSmallSpring=false);
//
// BoosterFinCan(LowerHalfOnly=false, UpperHalfOnly=true);
// rotate([180,0,0]) BoosterFinCan(LowerHalfOnly=true, UpperHalfOnly=false);
//
// RocketOmegaBoosterFin();
// BT54MotorRetainer(); // 54mm motor
// BT75MotorRetainer(); // 75mm motor
//
// ===============
//  *** Tools ***
// ===============
//
//  Holds petal while assmbling the rocket for flight.
// PD_PetalHolder(Petal_OD=ULine157Coupler_OD*CF_Comp, Is_Top=false); // bottom half
// PD_PetalHolder(Petal_OD=ULine157Coupler_OD*CF_Comp, Is_Top=true); // top half
//
// FinCanAlignmetTool(D=24.9); // for sustainer
// FinCanAlignmetTool(D=19.5); // for booster
//
// FC2_FinFixture(Fin_Root_W=Sustainer_Fin_Root_W, Fin_Root_L=Sustainer_Fin_Root_L, Fin_Post_h=Sustainer_Fin_Post_h, Fin_Chamfer_L=Sustainer_Fin_Chamfer_L);
// FC2_FinFixture(Fin_Root_W=Booster_Fin_Root_W, Fin_Root_L=Booster_Fin_Root_L, Fin_Post_h=Booster_Fin_Post_h, Fin_Chamfer_L=Booster_Fin_Chamfer_L);
//
// BodyDrillingJig(Tube_OD=Body_OD*CF_Comp+Vinyl_t*2, Tube_ID=Body_ID, nBolts=NC_nRivets, BoltInset=7.5);
// BodyDrillingJig(Tube_OD=Body_OD*CF_Comp+Vinyl_t*2, Tube_ID=Body_ID, nBolts=nEBayBolts, BoltInset=7.5);
// BodyDrillingJig(Tube_OD=Body_OD*CF_Comp+Vinyl_t*2, Tube_ID=Body_ID, nBolts=nFins*2, BoltInset=7.5);
//
// TubeTest(OD=Body_OD, ID=Body_ID, TestOD=false);
// TubeTest(OD=Body_OD+IDXtra*2, ID=Body_ID, TestOD=true);
//
// ***********************************
//  ***** for DXF output *****
//
//  ***** Fin Art *****
//  Save as dxf for LightBurn to cut on laser cutter.
//  Best to cut a template and use a knife to cut the vinyl.
//  Cut 4 of each, 32 pieces total.
//
// VinylFinWhite(Border=-1, Fin_Root_L=Sustainer_Fin_Root_L, Fin_Tip_L=Sustainer_Fin_Tip_L, Fin_Span=Sustainer_Fin_Span); // first side
// VinylFinWhite(Border=6, Fin_Root_L=Sustainer_Fin_Root_L, Fin_Tip_L=Sustainer_Fin_Tip_L, Fin_Span=Sustainer_Fin_Span); // second side
// VinylSustainerFinBlack(); 
// VinylSustainerFinBlue();
// mirror([1,0,0]) VinylSustainerFinBlack(); 
// mirror([1,0,0]) VinylSustainerFinBlue();
//
// VinylFinWhite(Border=-1, Fin_Root_L=Booster_Fin_Root_L, Fin_Tip_L=Booster_Fin_Tip_L, Fin_Span=Booster_Fin_Span); // first side
// VinylFinWhite(Border=6, Fin_Root_L=Booster_Fin_Root_L, Fin_Tip_L=Booster_Fin_Tip_L, Fin_Span=Booster_Fin_Span); // second side
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
use<AT_RMS_Lib.scad>			echo(AT_RMS_Lib_Rev());
use<PetalDeploymentLib.scad>	echo(PetalDeploymentLibRev());
use<ElectronicsBayLib.scad>		echo(ElectronicsBayLibRev());
include<Stager3Lib.scad>
use<Fins.scad>					echo(FinsRev());
use<FinCan2Lib.scad>			echo(FinCan2LibRev());
use<NoseCone.scad>				echo(NoseConeRev());
use<SpringEndsLib.scad>			echo(SpringEndsLibRev());
use<SpringThingBooster.scad>	echo(SpringThingBoosterRev());
use<RailGuide.scad>				echo(RailGuideRev());
use<R157Lib.scad>  				echo(R157Lib_Rev());

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
CouplerThinWall_ID=ULine157ThinWallCoupler_ID;
MotorTube_OD=BT54Body_OD;
MotorTube_ID=BT54Body_ID;
BoosterMotorTube_OD=BoosterHas75mmMotor? BT75Body_OD:BT54Body_OD;
BoosterMotorTube_ID=BoosterHas75mmMotor? BT75Body_ID:BT54Body_ID;
EBayTube_OD=ULine38Body_OD; // This tube keeps the shock cord out of the electronics.


nLockBalls=6; // Ball Lock (STB) units
nEBayBolts=6;

MainPetal_Len=180;
DroguePetal_Len=100;

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
//echo(Booster_Fin_Root_W=Booster_Fin_Root_W);
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
echo(str("Scale Booster Body Length = ",ScaleBooster_Body_Len));

PBay_Len=5*25.4*Scale;
LowerTube_Len=670;
SustainerFinInset=5;
SusFinCan_Len=Sustainer_Fin_Root_L+SustainerFinInset*2;

BoosterFinInset=5;
BoostFinCan_Len=Booster_Fin_Root_L+BoosterFinInset*2;
InterstageTube_Len=240;
Booster_Body_Len=BoostFinCan_Len+InterstageTube_Len+EBay_Len+Engagement_Len+28;
SustainerMotorTube_Len=617; //SusFinCan_Len+EBay_Len+200;
echo(str("Booster Body Length = ",Booster_Body_Len));

ScaleBody_Len=(14.5+5)*25.4*Scale;
echo(str("Scale Body Length = ",ScaleBody_Len));
echo(str(" Including scale payload bay len = ",PBay_Len));

STB_Len=MainEB_HasCR? 39+Engagement_Len:19+Engagement_Len;
Body_Len=19+SusFinCan_Len+EBay_Len+LowerTube_Len+MainEBay_Len+STB_Len*2+PBay_Len;
echo(str("Total Body Length = ",Body_Len));

BoosterMotorTubeLen=BoostFinCan_Len+100;

// Body & Motor Tube Lengths
echo(str("Upper Body Tube = ",PBay_Len));
echo(str("Lower Body Tube = ",LowerTube_Len));
echo(str("Sustainer Motor Tube = ",SustainerMotorTube_Len));
echo(str("Booster Body = ",InterstageTube_Len));
echo(str("Booster Motor Tube = ",BoosterMotorTubeLen));

NC_Base_L=15;
NC_Len=170*Scale-NC_Base_L;
NC_Tip_r=5*Scale;
NC_Wall_t=2.2;
NC_nRivets=5;

RailGuide_h=Body_OD/2+2;
RailGuide_Len=40;
TailConeLen=40;

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
			
	if (ShowInternals) if (BoosterHas75mmMotor){
		translate([0,0,MotorTube_Z+BoosterMotorTubeLen]) rotate([0,0,90])
			R157_MotorTubeTopper(OD=Body_ID, MotorTube_OD=BoosterMotorTube_OD, MotorTube_ID=BoosterMotorTube_ID, Len=35);
		
		translate([0,0,MotorTube_Z+BoosterMotorTubeLen+13]) rotate([180,0,0]) 
			SE_SpringEndTypeB(Coupler_OD=ULine157Coupler_OD, MotorCoupler_OD=BT75Coupler_OD, nRopes=6, UseSmallSpring=false);
	}else{
		translate([0,0,MotorTube_Z+BoosterMotorTubeLen-10]) 
			R157_BoosterSpringBottom(OD=Body_ID, MotorTube_OD=BoosterMotorTube_OD);
	}
	
	translate([0,0,FinCan_Z]) color("White") BoosterFinCan();
	translate([0,0,FinCan_Z-TailConeLen-13]) color("Gray") 
		if (BoosterHas75mmMotor){
			BT75MotorRetainer();
		}else{
			BT54MotorRetainer();
		}
	
	if (ShowInternals) 
		translate([0,0,MotorTube_Z]) color("Tan") 
			Tube(OD=BoosterMotorTube_OD, ID=BoosterMotorTube_ID, Len=BoosterMotorTubeLen, myfn=$preview? 90:360);
	
			
									
	for (j=[0:nFins]) rotate([0,0,360/nFins*j+180/nFins])
		translate([0,Body_OD/2-Booster_Fin_Post_h, Fin_Z]) 
			rotate([-90,0,0]) color("Blue") RocketOmegaBoosterFin();
			
	if (ShowInternals) translate([0,0,MotorTube_Z-3]) 
		if (BoosterHas75mmMotor){
			ATRMS_75_2560_Motor(Extended=false, HasEyeBolt=true);
		}else{
			ATRMS_54_1706_Motor(Extended=false, HasEyeBolt=true); // K1100T
		}
	
	
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
		translate([0,0,126]) SE_SpringEndTypeC(Coupler_OD=ULine157Coupler_OD, Coupler_ID=ULine157Coupler_ID, Len=10, nRopes=6, UseSmallSpring=false);
		translate([0,0,61]) SE_SlidingBigSpringMiddle(OD=ULine157Coupler_OD, SliderLen=50, Extension=0);
		translate([0,0,6.2]) color("Gray") 
			R157_PusherRing(OD=Coupler_OD, ID=Coupler_ID, OA_Len=50, Engagemnet_Len=7, Wall_t=4, PetalStop_h=0);
			
		translate([0,0,0.1]) R157_SkirtPHRing(Coupler_OD=Coupler_OD*CF_Comp, Coupler_ID=CouplerThinWall_ID, Engagemnet_Len=7);
		rotate([180,0,0]) R157_PetalHub(OD=Coupler_OD*CF_Comp, nPetals=6, nBolts=6, nRopes=6);
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

	EB_Electronics_BayUniversal(Tube_OD=Body_OD*CF_Comp+Vinyl_t*2, Tube_ID=Body_ID*CF_Comp, DoorAngles=Doors_a, Len=MainEBay_Len, 
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

module EbayAlignmentCR(OD=Body_ID*CF_Comp){
	Thickness=4.8;
	
	CenteringRing(OD=OD, ID=MotorTube_OD+IDXtra, Thickness=Thickness, nHoles=6, Offset=0, myfn=$preview? 90:720);
	Tube(OD=OD-6-IDXtra*2, ID=OD-9, Len=Thickness+2, myfn=$preview? 90:360);
} // EbayAlignmentCR

// EbayAlignmentCR();

module LowerEBay(TopOnly=false, BottomOnly=false, ShowDoors=false){
	Doors_a=[[45],[225],[]];
	nBolts=BottomOnly? nFins*2:nEBayBolts;

	EB_Electronics_BayUniversal(Tube_OD=Body_OD*CF_Comp+Vinyl_t*2, Tube_ID=Body_ID*CF_Comp, DoorAngles=Doors_a, Len=EBay_Len, 
									nBolts=nBolts, BoltInset=7.5, ShowDoors=ShowDoors,
									HasFwdIntegratedCoupler=true, HasFwdShockMount=false,
									HasAftIntegratedCoupler=false, HasAftShockMount=false,
									HasRailGuide=false, RailGuideLen=RailGuide_Len,
									HasFwdCenteringRing=false, HasAftCenteringRing=false, InnerTube_OD=0,
									Bolted=true, ExtraBolts=[60,90,120], TopOnly=TopOnly, BottomOnly=BottomOnly);
									
} // LowerEBay

// LowerEBay();

module FinCanAlignmetTool(D=19.5){
	// print 4 of these rings to align the fincan halves
	
	difference(){
		union(){
			cylinder(d1=D-0.5, d2=D, h=3);
			translate([0,0,3-Overlap]) cylinder(d2=D-0.5, d1=D, h=3);
		} // union
		
		translate([0,0,-Overlap]) cylinder(d=D-6, h=6+Overlap*2);
	} // difference
} // FinCanAlignmetTool

// FinCanAlignmetTool();

module SustainerFinCan(LowerHalfOnly=false, UpperHalfOnly=false){
	
	Can_Len=Sustainer_Fin_Root_L+SustainerFinInset*2;
	echo(Can_Len=Can_Len);
	RailGuide_Z=35;
	Retainer_d=65;	
	Rocket_OD=Body_OD*CF_Comp+Vinyl_t*2;
	
	difference(){
		union(){
			FC2_FinCan(Body_OD=Rocket_OD, Body_ID=Body_ID*CF_Comp, Can_Len=Can_Len,
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
	nBolts=nEBayBolts; // connects to STB and Stager

	EB_Electronics_BayUniversal(Tube_OD=Body_OD*CF_Comp+Vinyl_t*2, Tube_ID=Body_ID*CF_Comp, DoorAngles=Doors_a, Len=EBay_Len, 
									nBolts=nBolts, BoltInset=7.5, ShowDoors=ShowDoors,
									HasFwdIntegratedCoupler=true, HasFwdShockMount=false,
									HasAftIntegratedCoupler=false, HasAftShockMount=false,
									HasRailGuide=false, RailGuideLen=RailGuide_Len,
									HasFwdCenteringRing=false, HasAftCenteringRing=false, InnerTube_OD=0,
									Bolted=true, ExtraBolts=[45], TopOnly=TopOnly, BottomOnly=BottomOnly);
									
} // BoosterEBay

// BoosterEBay();

module BoosterFinCan(LowerHalfOnly=false, UpperHalfOnly=false){
	Can_Len=Booster_Fin_Root_L+BoosterFinInset*2; //Booster_Body_Len;
	
	echo(Can_Len=Can_Len);
	
	Wall_t=2.2; // 3 perimeters, can be 1.2-1.8 for 2 perimeters
	RailGuide_Z=35;
	Retainer_d=BoosterHas75mmMotor? 90:65;
	Rocket_OD=Body_OD*CF_Comp+Vinyl_t*2;
	
	difference(){
		FC2_FinCan(Body_OD=Rocket_OD, Body_ID=Body_ID*CF_Comp, Coupler_ID=Coupler_ID, Can_Len=Can_Len,
				MotorTube_OD=BoosterMotorTube_OD, RailGuide_h=RailGuide_h, RailGuide_z=RailGuide_Z,
				nFins=nFins, HasIntegratedCoupler=true, Coupler_Len=15, nCouplerBolts=nFins*2,
				HasMotorSleeve=true, HasAftIntegratedCoupler=false,
				Fin_Root_W=Booster_Fin_Root_W, Fin_Root_L=Booster_Fin_Root_L, Fin_Post_h=Booster_Fin_Post_h, Fin_Chamfer_L=Booster_Fin_Chamfer_L,
				Cone_Len=TailConeLen, ThreadedTC=false, Extra_OD=2, RailGuideLen=RailGuide_Len,
				LowerHalfOnly=LowerHalfOnly, UpperHalfOnly=UpperHalfOnly, 
				HasWireHoles=false, HollowTailcone=false, 
				HollowFinRoots=true, Wall_t=Wall_t, OgiveTailCone=false, Ogive_Len=400, OgiveCut_d=BT54Body_OD+8,
				UseTrapFin3=true);
				
		// hole for motor retainer
		translate([0,0,-TailConeLen-Overlap]) cylinder(d=Retainer_d+IDXtra*3, h=20);
	} // difference
	
} // BoosterFinCan

// BoosterFinCan(LowerHalfOnly=false, UpperHalfOnly=false);
// BoosterFinCan(LowerHalfOnly=false, UpperHalfOnly=true);
// rotate([180,0,0]) BoosterFinCan(LowerHalfOnly=true, UpperHalfOnly=false);


module RocketOmegaBoosterFin(){
	//  *** Ogive leading and trailing edges ***
	TrapFin3(Post_h=Booster_Fin_Post_h, Root_L=Booster_Fin_Root_L, Tip_L=Booster_Fin_Tip_L, 
				Root_W=Booster_Fin_Root_W, Tip_W=Booster_Fin_Tip_W, Span=Booster_Fin_Span, Chamfer_L=Booster_Fin_Chamfer_L,
				TipOffset=Booster_Fin_TipOffset, TipInset=0, HasBluntTip=false, TipPost_h=0,
				Bisect=false, Bisect_X=0,
				HasSpar=false, Spar_d=8, Spar_L=100, PrinterBrim_H=0.8, HasSpiralVaseRibs=false);

} // RocketOmegaBoosterFin

// RocketOmegaBoosterFin();

// ===============================================================
//  ***** Vinyl Shapes *****
// ===============================================================


module VinylFinWhite(Border=6, Fin_Root_L=Sustainer_Fin_Root_L, Fin_Tip_L=Sustainer_Fin_Tip_L, Fin_Span=Sustainer_Fin_Span){
	hull(){
		translate([0,-Fin_Root_L/2-Border,0]) circle(d=1);
		translate([0,Root_L/2+Border,0]) circle(d=1);
		translate([Fin_Span+6,-Fin_Tip_L-Border,0]) circle(d=1);
		translate([Fin_Span+6,Fin_Tip_L+Border,0]) circle(d=1);
	} // hull
} // VinylFinWhite

// VinylFinWhite();

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
































