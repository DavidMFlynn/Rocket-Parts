// ***********************************
// Project: 3D Printed Rocket
// Filename: RocketStubby.scad
// by David M. Flynn
// Created: 4/18/2025 
// Revision: 0.9.0  4/18/2025 
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  Built from a scrap of 8.5" CF over Concrete Tube
//  Rocket with 75mm motor. 
//
//  ***** Parts *****
//
//
//  ***** Hardware *****
//
// #6-32 x 3/4" Button Head Cap Screw (4 req) Rail Guides
// #4-40 x 1/2" Socket Head Cap Screw (12 req) Ball Lock
// #4-40 x 3/8" Button Head Cap Screw (14 req) Doors
// #4-40 x 3/8" Socket Head Cap Screw (3 req) PetalHub
// #4-40 x 1/4" Button Head Cap Screw (4 req) Altimeter
// #4-40 x 1/4" Button Head Cap Screw (12 req) Petals
// #4-40 x 3/8" Button Socket Head Cap Screw (8 req) Servos
// 1/2" x 0.035" wall Aluminum tubing 2ea 92mm, 2ea 80mm Shock cord mounts
// MR84-2RS Bearing (16 req) Ball Lock
// 3/8" Delrin Ball (12 req) Ball Lock
// 4mm Dia. x 10mm Undersize Steel Dowel (12 req) Ball Lock
// 4mm Dia. x 16mm Undersize Steel Dowel (6 req) Ball Lock
// 3/16" Dia x 1/8" Disc Magnet N42 (4 req) Ball Lock
// HX5010 or Eqiv. Standard Servo (2 req) Ball Lock
// C&K Rotary Switch (2 req) Battery Door
// Mission Control V3 Altimeter PCBA
// Rocket Servo PCBA (2 req)
// 1/4" Rail Guides (30mm long) (2 req)
// Spring 0.3" Dia x 1.25" PN:CS3715 (6 Req) Petals
// Spring 1.4" Dia x 8" PN:CS4323 (4 Req) Deployment
//
//  ***** History *****
//
// 0.9.0  4/18/2025  First code
//
// ***********************************
//  ***** for STL output *****
//
// *** Nosecode ***
//
// BluntOgiveNoseCone(ID=Coupler_OD, OD=Body_OD, L=NC_Len, Base_L=NC_Base_L, nRivets=6, Tip_R=NC_Tip_r, HasThreadedTip=false, Wall_T=NC_Wall_t, Cut_d=0, LowerPortion=false, FillTip=true);
// 
// NC_ShockcordRingDual(Tube_OD=Body_OD, Tube_ID=Body_ID, NC_Base_L=NC_Base_L, nRivets=6);
// 
// SE_SlidingSpringMiddle(OD=Coupler_OD, nRopes=6, SliderLen=30, SpLen=40, SpringStop_Z=20);
//
// PD_NC_PetalHub(OD=Coupler_OD, nPetals=nPetals, nRopes=6);
// rotate([-90,0,0]) PD_PetalSpringHolder();
// rotate([180,0,0]) PD_Petals(OD=Coupler_OD, Len=ForwardPetalLen, nPetals=nPetals, AntiClimber_h=4);
//
// *** Doors ***
//
// rotate([-90,0,0]) EB_AltDoor(Tube_OD=Body_OD);
// 
// rotate([-90,0,0]) EB_BattDoor(Tube_OD=Body_OD, HasSwitch=true, DoubleBatt=false);
// rotate([-90,0,0]) EB_BattDoor(Tube_OD=Body_OD, HasSwitch=false, DoubleBatt=false);
//
// *** Ball Lock ***
//
// STB_LockDisk(Body_ID=Body_ID, nLockBalls=nLockBalls, HasLargeInnerBearing=false);
// rotate([180,0,0]) R98C_BallRetainerTop();
// R98_BallRetainerBottom();
// rotate([180,0,0]) STB_TubeEnd2(Body_ID=Body_ID, nLockBalls=nLockBalls, Body_OD=Body_OD, Engagement_Len=20);
//
// *** petal deployer ***
//
// PD_PetalHub(OD=Coupler_OD, nPetals=nPetals, ShockCord_a=PD_ShockCordAngle());
// rotate([-90,0,0]) PD_PetalSpringHolder();
// rotate([180,0,0]) PD_Petals(OD=Coupler_OD, Len=AftPetalLen, nPetals=nPetals, AntiClimber_h=3);
//
// rotate([180,0,0]) SpringTop();
//
//
// *** Fin Can ***
//
// rotate([180,0,0]) FinCan(LowerHalfOnly=false, UpperHalfOnly=false);
// RocketFin();
//
/*
FC2_MotorRetainer(Body_OD=Body_OD, 
					MotorTube_OD=MotorTube_OD, MotorTube_ID=MotorTube_ID,
					Cone_Len=TailCone_Len);
/**/
// **************************************
//
// CRBB_ExtensionRod(Len=100);
// rotate([180,0,0]) CRBB_LockingPin(LockPin_Len=40, GuidePoint=true);
// rotate([180,0,0]) CRBB_LockRing(GuidePoint=true);
// rotate([180,0,0]) CRBB_TopRetainer(LockRing_d=CRBB_LockRingDiameter(), GuidePoint=true);
// CRBB_OuterBearingRetainer();
// rotate([180,0,0]) CRBB_InnerBearingRetainer();
// rotate([180,0,0]) CRBB_MagnetBracket();
// rotate([180,0,0]) CRBB_TriggerPost();

// CRBB_TopRetainerEBayEnd(Body_OD=Body_OD, Body_ID=Body_ID);
//
// PD_NC_PetalHub(OD=Coupler_OD-IDXtra, nPetals=nPetals, nRopes=6, ShockCord_a=60, HasThreadedCore=true);
//
// CenteringRing(OD=Coupler_ID, ID=MotorTube_OD+IDXtra*2, Thickness=5, nHoles=5, Offset=0);
//
//
// **************************************
//
// rotate([90,0,0]) BoltOnRailGuide(Length = 30, BoltSpace=12.7, RoundEnds=true);
// rotate([-90,0,0]) RailGuideSpacer(OD=Body_OD, H=RailGuide_h, Length = 30, BoltSpace=12.7);
//
// ***********************************
//  ***** Routines *****
//
//
// ***********************************
//  ***** for Viewing *****
//
// ShowRocket();
// ShowRocket(ShowInternals=true);
//
// ***********************************
include<TubesLib.scad>
use<FinCan2Lib.scad> echo(FinCan2LibRev());
use<AT-RMS-Lib.scad>
use<RailGuide.scad>
use<Fins.scad>
use<NoseCone.scad>
use<ElectronicsBayLib.scad>
use<SpringThingBooster.scad> echo(SpringThingBoosterRev());
use<PetalDeploymentLib.scad>
use<SpringThing2.scad>
use<SpringEndsLib.scad>
use<CableReleaseBB.scad> echo(CableReleaseBBRev());


//also included
 //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

nFins=5;

Fin_Post_h=20;
Fin_Root_L=300;
Fin_Root_W=18;
Fin_Tip_W=3.0;
Fin_Tip_L=120;
Fin_Span=170;
Fin_TipOffset=80;
Fin_Chamfer_L=40;


Body_OD=221.5;
Body_ID=215.5;
Coupler_OD=Body_ID-1;
Coupler_ID=Coupler_OD-4.4;

// *** 54mm Motor Tube ***
MotorTube_OD=ULine75Body_OD;
MotorTube_ID=ULine75Body_ID;

NC_Len=320;
NC_Tip_r=25;
NC_Wall_t=2.2;
NC_Base_L=15;

ForwardPetalLen=160; // 180 is 12mm too much
MotorTubeLen=19.5*25.4;
BodyTubeLen=510;

FinInset_Len=15;
Can_Len=Fin_Root_L+FinInset_Len*2;
Bolt4Inset=4;
nLockBalls=6;
nPetals=5;
ShockCord_a=17;// offset between PD_PetalHub and R65_BallRetainerBottom
TailCone_Len=50;
RailGuide_h=Body_OD/2+2;

module ShowRocket(ShowInternals=false){
	FinCan_Z=35;
	Fin_Z=FinCan_Z+Fin_Root_L/2+FinInset_Len;
	BodyTube_Z=FinCan_Z+Can_Len+Overlap*2;
	AftTubeEnd_Z=BodyTube_Z+BodyTubeLen+10;
	AftBallLock_Z=BodyTube_Z+BodyTubeLen+9;
	EBay_Z=AftBallLock_Z+24.5;
	FwdBallLock_Z=EBay_Z+EBay_Len+24.4;
	FwdTubeEnd_Z=FwdBallLock_Z+0.2;
	ForwardTube_Z=FwdTubeEnd_Z+10;
	NoseCone_Z=ForwardTube_Z+ForwardTubeLen+3.4;
	
	//*
	translate([0,0,NoseCone_Z]) color("Orange")
		BluntOgiveNoseCone(ID=Coupler_OD, OD=Body_OD, L=NC_Len, Base_L=NC_Base_L, 
							Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=0, LowerPortion=false);
							
	translate([0,0,NoseCone_Z-0.2]) rotate([0,0,90]) 
		NC_ShockcordRingDual(Tube_OD=Body_OD, Tube_ID=Body_ID, NC_Base_L=NC_Base_L, nRivets=3);
	
	//if (ShowInternals) translate([0,0,NoseCone_Z-20]) ST_SpringMiddle(Tube_ID=BT54Coupler_OD);
	//if (ShowInternals) translate([0,0,NoseCone_Z-54.2]) rotate([180,0,0]) NC_PetalHub();
	
	//if (ShowInternals) translate([0,0,NoseCone_Z-60.2]) rotate([180,0,0])
	//	PD_Petals(Coupler_OD=Coupler_OD, Len=180, nPetals=nPetals, AntiClimber_h=3);
							
	/**/
	
	/*
	if (ShowInternals==false) translate([0,0,FwdTubeEnd_Z]) rotate([180,0,0]) color("Orange")
		STB_TubeEnd(BallPerimeter_d=Body_OD, nLockBalls=nLockBalls, Body_OD=Body_OD, Body_ID=Body_ID, Skirt_Len=20);
	if (ShowInternals) translate([0,0,FwdBallLock_Z+0.2]) rotate([180,0,0]) 
		R98_BallRetainerBottom();
	translate([0,0,FwdBallLock_Z]) rotate([180,0,0]) color("White") 
		R98C_BallRetainerTop();
	translate([0,0,EBay_Z]) color("White") 
		EB_Electronics_Bay(Tube_OD=Body_OD, Tube_ID=Body_ID, Len=EBay_Len, nBolts=3, BoltInset=7.5, ShowDoors=false, HasSecondBattDoor=true);
	translate([0,0,AftBallLock_Z]) color("White") 
		R98C_BallRetainerTop();
	if (ShowInternals) translate([0,0,AftBallLock_Z-0.2]) 
		R98_BallRetainerBottom();
	/**/
	
	//*
	if (ShowInternals==false) translate([0,0,ForwardTube_Z]) color("LightBlue") 
		Tube(OD=Body_OD, ID=Body_ID, 
			Len=ForwardTubeLen-Overlap*2, myfn=$preview? 90:360);
	/**/
	
	//*
	if (ShowInternals) translate([0,0,AftBallLock_Z-8.8]) rotate([0,0,200]) rotate([180,0,0]) 
			PD_PetalHub(Coupler_OD=Body_ID, nPetals=3, ShockCord_a=PD_ShockCordAngle());
			
	if (ShowInternals) translate([0,0,AftBallLock_Z-17]) rotate([0,0,200]) rotate([180,0,0]) 
		PD_Petals(Coupler_OD=Coupler_OD, Len=150, nPetals=nPetals, AntiClimber_h=3);	
	
	if (ShowInternals) translate([0,0,MotorTubeLen+50]){
		translate([0,0,35]) SpringTop();
		ST_SpringMiddle(Tube_ID=BT54Coupler_OD);
	}
	if (ShowInternals) translate([0,0,MotorTubeLen+12]) rotate([0,0,180]) color("Gray") MotorTubeTopper();
	/**/
	
	if (ShowInternals==false) translate([0,0,AftTubeEnd_Z]) color("Orange")
		STB_TubeEnd(BallPerimeter_d=Body_OD, nLockBalls=nLockBalls, Body_OD=Body_OD, Body_ID=Body_ID, Skirt_Len=20);
	
	if (ShowInternals==false)
	translate([0,0,BodyTube_Z]) color("LightBlue") Tube(OD=Body_OD, ID=Body_ID, 
			Len=BodyTubeLen-Overlap*2, myfn=$preview? 90:360);
	
	translate([0,0,FinCan_Z]) color("White") 
		FC2_FinCan(Body_OD=Body_OD, Body_ID=Body_ID, Can_Len=Can_Len, 
						MotorTube_OD=MotorTube_OD, RailGuide_h=RailGuide_h,
						nFins=nFins,
						Fin_Root_W=Fin_Root_W, Fin_Root_L=Fin_Root_L, 
						Fin_Post_h=Fin_Post_h, Fin_Chamfer_L=Fin_Chamfer_L,
						Cone_Len=TailCone_Len, 
						LowerHalfOnly=false, UpperHalfOnly=false, HasWireHoles=false);

	
	//*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j])
		translate([Body_OD/2-Fin_Post_h, 0, Fin_Z]) 
			rotate([0,90,0]) color("Orange") RocketFin();
	/**/
	
	if (ShowInternals) translate([0,0,12]) color("Blue") 
		Tube(OD=MotorTube_OD, ID=MotorTube_ID, Len=MotorTubeLen, myfn=90);
	
	if (ShowInternals) translate([0,0,12]) ATRMS_54_1706_Motor(Extended=true, HasEyeBolt=true);
	
	translate([0,0,FinCan_Z-0.2]) color("Orange") 
		FC2_MotorRetainer(Body_OD=Body_OD, 
					MotorTube_OD=MotorTube_OD, MotorTube_ID=MotorTube_ID,
					Cone_Len=TailCone_Len);
} // ShowRocket

//ShowRocket();
//ShowRocket(ShowInternals=true);


module RocketFin(){
			
	TrapFin3(Post_h=Fin_Post_h, Root_L=Fin_Root_L, Tip_L=Fin_Tip_L, Root_W=Fin_Root_W, Tip_W=Fin_Tip_W, Span=Fin_Span, Chamfer_L=Fin_Chamfer_L,
				TipOffset=Fin_TipOffset, TipInset=0, HasBluntTip=false, TipPost_h=0,
				Bisect=false, Bisect_X=0,
				HasSpar=false, Spar_d=8, Spar_L=100, PrinterBrim_H=0.6, HasSpiralVaseRibs=false);
		
} // RocketFin

//RocketFin();


module FinCan(LowerHalfOnly=false, UpperHalfOnly=false){

	FC2_FinCan(Body_OD=Body_OD, Body_ID=Body_ID, Can_Len=Can_Len, 
						MotorTube_OD=MotorTube_OD, RailGuide_h=RailGuide_h,
						nFins=nFins,
						Fin_Root_W=Fin_Root_W, Fin_Root_L=Fin_Root_L, 
						Fin_Post_h=Fin_Post_h, Fin_Chamfer_L=Fin_Chamfer_L,
						Cone_Len=TailCone_Len, 
						LowerHalfOnly=LowerHalfOnly, UpperHalfOnly=UpperHalfOnly, HasWireHoles=false);
						
} // FinCan

// FinCan();



































