// *******************************************************
// Project: 3D Printed Rocket
// Filename: Rocket20351D.scad
// by David M. Flynn
// Created: 12/13/2024
// Revision: 0.9.2  12/20/2024
// Units: mm
// *******************************************************
//  ***** Notes *****
//
// A big fat mailing tube rocket. Level 3 in 7000 feet AGL.
// Five Fins, Single Stage, Dual Deploy, Redundant Electronics, Non-Pyro Deployment
// Mailing tube 203mm inside diameter.
// PETG+CF fins and nosecone
//
//  ***** History *****
//
// 0.9.2  12/20/2024   Flat nosecone base (no support)
// 0.9.1  12/17/2024   3 part fin can
// 0.9.0  12/13/2024   First code
//
//  ***** Hardware *****
//
// #4-40 x 1/4" BHCS 			(28ea, Petal spring holders)
// #4-40 x 1/2" SHCS			(28ea, Ball Locks)
// #6-32 x 3/4" BHCS			(4ea, Rail Guides)
//
// 1/2" Delrin Ball				(14ea, Ball Locks)
// 4mm x 10mm Dowel				(14ea, Ball Locks)
// 4mm x 20mm Dowel				(4ea, Ball Locks)
// MR84 Ball Bearing			(14ea, Ball Locks)
// 6808 Ball Bearing			(2ea, Ball Locks)
// CS3715 Spring				(14ea, Petal Springs)
// CS11890 Spring				(4ea, Deployment Springs)
//
// *******************************************************
//  ***** for STL output *****
//
// BluntOgiveNoseCone(ID=Body_ID, OD=Body_OD, L=Nosecone_Len, Base_L=NoseconeBase_Len, nRivets=nNoseconeRivets, Tip_R=NoseconeTip_R, HasThreadedTip=false, Wall_T=NoseconeWall_t, Cut_d=0, LowerPortion=false); // one piece

// translate([0,0,0.2]) BluntOgiveNoseCone(ID=Body_ID, OD=Body_OD, L=Nosecone_Len, Base_L=NoseconeBase_Len, nRivets=nNoseconeRivets, Tip_R=NoseconeTip_R, HasThreadedTip=false, Wall_T=NoseconeWall_t, Cut_d=Body_OD-40, LowerPortion=false, FillTip=true); // tip
//
// BluntOgiveNoseCone(ID=Body_ID, OD=Body_OD, L=Nosecone_Len, Base_L=NoseconeBase_Len, nRivets=nNoseconeRivets, Tip_R=NoseconeTip_R, HasThreadedTip=false, Wall_T=NoseconeWall_t, Cut_d=Body_OD-40, LowerPortion=true); // base
//
/*
  NC_ShockcordRingDual(Tube_OD=Body_OD, Tube_ID=Body_ID, NC_ID=0, NC_Base_L=NoseconeBase_Len, 
						nRivets=nNoseconeRivets, nBolts=nEBay_Bolts, Flat=true);
/**/
//
// R203_SkirtRing(Coupler_OD=Body_ID-BodyTubeAnnulus, Coupler_ID=Coupler_ID, HasPD_Ring=false);
// rotate([180,0,0]) R203_PusherRing(OD=Body_ID*CF_Comp-BodyTubeAnnulus, ID=Coupler_ID, OA_Len=50, Engagemnet_Len=10, Wall_t=4, nBolts=7);
//  *** for NC Petal Hub ***
// rotate([180,0,0]) R203_PusherRing(OD=Body_ID*CF_Comp-BodyTubeAnnulus, ID=Body_ID-BodyTubeAnnulus-4.6, OA_Len=50, Engagemnet_Len=10, Wall_t=4);
// SE_SlidingBigSpringMiddle(OD=Body_ID-BodyTubeAnnulus, SliderLen=80, Extension=0); // print 2
// rotate([180,0,0]) SE_SpringEndTypeA(Coupler_OD=Body_ID-BodyTubeAnnulus, Coupler_ID=Coupler_ID, nRopes=6, Spring_OD=SE_Spring_CS11890_OD());
//  *** for Drogue ***
// rotate([180,0,0]) R203_PusherRing(OD=Body_ID*CF_Comp-BodyTubeAnnulus, ID=Coupler_ID, OA_Len=75, Engagemnet_Len=7, Wall_t=4, nBolts=0);
// SE_SpringEndTypeC(Coupler_OD=Body_ID-BodyTubeAnnulus, Coupler_ID=Coupler_ID, nRopes=6, UseSmallSpring=false);
// CenteringRing(OD=Body_ID, ID=MotorTube_OD, Thickness=10, nHoles=6, Offset=0, myfn=$preview? 90:360);
// rotate([180,0,0]) R203_MotorTubeTopper();
//
//  *** Coupler Tubes ***
// Tube(OD=Coupler_OD, ID=Coupler_ID, Len=50, myfn=$preview? 90:720);
// Tube(OD=Coupler_OD, ID=Coupler_ID, Len=75, myfn=$preview? 90:720);
//	
//  *** Electronics Bay ***
// rotate([180,0,0]) EBay(TopOnly=true, BottomOnly=false, ShowDoors=false);
// EBay(TopOnly=false, BottomOnly=true, ShowDoors=false);
// CenteringRing(OD=Body_ID, ID=EBayTube_OD, Thickness=EBayCR_t, nHoles=8, Offset=0, myfn=$preview? 90:360);
// CenteringRing(OD=Body_ID, ID=EBayTube_OD, Thickness=4.5, nHoles=8, Offset=0, myfn=$preview? 90:360); // fix
//  *** Doors ***
// rotate([-90,0,0]) EB_AltDoor(Tube_OD=Body_OD);
// rotate([-90,0,0]) EB_BattDoor(Tube_OD=Body_OD, HasSwitch=false, DoubleBatt=false);
// rotate([-90,0,0]) EB_BattDoor(Tube_OD=Body_OD, HasSwitch=true, DoubleBatt=false);
//
//  *** Ball Lock Unit ***
// rotate([180,0,0]) STB_TubeEnd(Body_ID=Body_ID, nLockBalls=nLockBalls, Body_OD=Body_OD, Engagement_Len=Engagement_Len);
// rotate([180,0,0]) R203_BallRetainerTop(Body_OD=Body_OD+1.2, Body_ID=Body_ID, EBayTube_OD=EBayTube_OD, Engagement_Len=Engagement_Len, nBolts=nEBay_Bolts, Xtra_r=0.3); // fix for Body_OD too small
// STB_LockDisk(Body_ID=Body_ID, nLockBalls=nLockBalls, HasLargeInnerBearing=true, Xtra_r=0.3);
// R203_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID, Engagement_Len=Engagement_Len, HasPD_Ring=false, Xtra_r=0.3);
//
//  *** Petal Deployer ***
// R203_PetalHub(OD=Body_ID-BodyTubeAnnulus);
// R203_NC_PetalHub(OD=Body_ID-BodyTubeAnnulus, nPetals=nPetals, CouplerTube_ID=Coupler_ID); // upper
// PD_Petals2(OD=Body_ID-BodyTubeAnnulus, Len=DroguePetal_Len, nPetals=nPetals, Wall_t=2.4, AntiClimber_h=5.0, HasLocks=false, Lock_Span_a=0);
// PD_Petals2(OD=Body_ID-BodyTubeAnnulus, Len=MainPetal_Len, nPetals=nPetals, Wall_t=2.4, AntiClimber_h=5.0, HasLocks=false, Lock_Span_a=0);
// rotate([-90,0,0]) PD_PetalSpringHolder2(); // print 15
// PD_HubSpringHolder();
//
// *** for fin can, NOT CF+PETG ***
// rotate([180,0,0]) R203_PusherRing(OD=Body_ID-BodyTubeAnnulus, ID=Coupler_ID, OA_Len=165, Engagemnet_Len=5, Wall_t=4, nBolts=0);
//
// 
// FinCan(LowerHalfOnly=false, UpperHalfOnly=true, TailConeOnly=false);
// FinCan(LowerHalfOnly=true, UpperHalfOnly=false, TailConeOnly=false);
// rotate([180,0,0]) FinCan(LowerHalfOnly=false, UpperHalfOnly=false, TailConeOnly=true);
// Rocket_Fin();
//
// rotate([90,0,0]) BoltOnRailGuide(Length = 40, BoltSpace=12.7, RoundEnds=true, ExtraBack=0);
// rotate([-90,0,0]) RailGuideSpacer(OD=Body_OD, H=Body_OD/2+2, Length = 40, BoltSpace=12.7);
//
// TubeTest(OD=Body_OD, ID=Body_ID);
// FinCanAlignmentTool();
// BodyDrillingJig(Tube_OD=Body_OD, Tube_ID=Body_ID, nBolts=nEBay_Bolts, BoltInset=7.5);
// BodyDrillingJig(Tube_OD=Body_OD, Tube_ID=Body_ID, nBolts=nFins*2, BoltInset=EBayBoltInset);
//
// *******************************************************
//  ***** for Viewing *****
//
// ShowRocket(ShowInternals=false);
//
// *******************************************************
include<TubesLib.scad>
use<AT-RMS-Lib.scad>
use<RailGuide.scad>
use<NoseCone.scad>
use<Fins.scad>
use<FinCan2Lib.scad>
use<SpringThingBooster.scad>
use<SpringEndsLib.scad>
use<ElectronicsBayLib.scad>
use<PetalDeploymentLib.scad>
use<R203Lib.scad>

//include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 36:90;

CF_Comp=0.995; // CF parts print oversized OD

/*
// a short nose cone
Nosecone_Len=400;
NoseconeBase_Len=15;
NoseconeTip_R=15;
NoseconeWall_t=2.2;
/**/

Nosecone_Len=700;
NoseconeBase_Len=15;
NoseconeTip_R=15;
NoseconeWall_t=2.4;

nNoseconeRivets=7;
nEBay_Bolts=7;
EBayBoltInset=8;

nLockBalls=7;
Engagement_Len=30;
nPetals=7;
DroguePetal_Len=150;
MainPetal_Len=200;

nFins=5;
Fin_Post_h=20;
Fin_Root_L=420;
Fin_Root_W=18;
Fin_Tip_W=5;
Fin_Tip_L=140;
Fin_Span=180;
Fin_TipOffset=80;
Fin_Chamfer_L=60;
Fin_Inset=10;

Body_OD=ULine203Body_OD;
Body_ID=ULine203Body_ID;
BodyTubeAnnulus=1.30; // for sliders
Coupler_OD=ULine203Body_ID-1.10;
Coupler_ID=Coupler_OD-4.4;
EBayTube_OD=BT75Body_OD;

MotorTube_OD=BT75Body_OD;
MotorTube_ID=BT75Body_ID;

UpperBody_Len=400;
EBay_Len=176;
EBayCR_t=6;
LowerBody_Len=48*25.4;
FinCan_Len=Fin_Root_L+Fin_Inset*2;
MotorTube_Len=48*25.4;
Cone_Len=140;
OgiveBoatTail=false;

MotorRetainer_OD=84.2;
MotorRetainer_Len=35;

echo(UpperBody_Len=UpperBody_Len);
echo(EBay_Len=EBay_Len);
echo(LowerBody_Len=LowerBody_Len);
echo(FinCan_Len=FinCan_Len);

module ShowRocket(ShowInternals=false){
	FinCan_Z=0;
	Fin_Z=FinCan_Z+FinCan_Len/2;
	MotorTube_Z=OgiveBoatTail? FinCan_Z-163-15:FinCan_Z-Cone_Len+15;
	LowerBody_Z=FinCan_Z+FinCan_Len;
	LowerBallLock_Z=LowerBody_Z+LowerBody_Len;
	EBay_Z=LowerBallLock_Z+49.05;
	UpperBallLock_Z=EBay_Z+EBay_Len+49.05;
	UpperBody_Z=UpperBallLock_Z;
	NoseCone_Z=UpperBody_Z+UpperBody_Len+3;
	
	translate([0,0,NoseCone_Z]){
		BluntOgiveNoseCone(ID=Body_ID, OD=Body_OD, L=Nosecone_Len, Base_L=NoseconeBase_Len, 
				nRivets=nNoseconeRivets, Tip_R=NoseconeTip_R, Wall_T=NoseconeWall_t, 
				Cut_d=0, LowerPortion=false);
		
		color("Tan") rotate([0,0,90]) 
			NC_ShockcordRingDual(Tube_OD=Body_OD, Tube_ID=Body_ID, NC_ID=0, NC_Base_L=NoseconeBase_Len, 
				nRivets=nNoseconeRivets, nBolts=0);
	}
	
	if (ShowInternals) translate([0,0,NoseCone_Z-120])
		SE_SlidingBigSpringMiddle(OD=Coupler_OD, SliderLen=80, Extension=0);
		
	if (ShowInternals) translate([0,0,NoseCone_Z-120-50]){
		rotate([180,0,0]) color("Tan")
			PD_NC_PetalHub(OD=Coupler_OD, nPetals=nPetals, nRopes=nPetals, ShockCord_a=-1, 
				HasThreadedCore=false, ST_DSpring_ID=SE_Spring_CS11890_ID(), 
				ST_DSpring_OD=SE_Spring_CS11890_OD(), CouplerTube_ID=Coupler_ID);
			
		translate([0,0,-10]) rotate([180,0,0]) PD_Petals(OD=Coupler_OD, Len=MainPetal_Len, nPetals=nPetals, Wall_t=1.8, 
			AntiClimber_h=5.0, HasLocks=false, Lock_Span_a=0);
	}
	
	if (!ShowInternals) translate([0,0,UpperBody_Z+0.2]) color("LightBlue") 
		Tube(OD=Body_OD, ID=Body_ID, Len=UpperBody_Len-0.4, myfn=90);
	//*	
	translate([0,0,UpperBallLock_Z-Engagement_Len/2]) rotate([180,0,0]) {
		if (!ShowInternals) color("Gray")
			STB_TubeEnd(Body_ID=Body_ID, nLockBalls=nLockBalls, Body_OD=Body_OD, Engagement_Len=Engagement_Len);
		
		color("Green") R203_BallRetainerTop(Body_OD=Body_OD, Body_ID=Body_ID);
		if (ShowInternals)
			color("Green") R203_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID, HasPD_Ring=false);
			
	}	
	/**/
	
	translate([0,0,EBay_Z]) rotate([0,0,10]) EBay(ShowDoors=!ShowInternals);
	
	//*	
	translate([0,0,LowerBallLock_Z+Engagement_Len/2]){
		if (!ShowInternals) color("Gray")
			STB_TubeEnd(Body_ID=Body_ID, nLockBalls=nLockBalls, Body_OD=Body_OD, Engagement_Len=Engagement_Len);
		
		color("Green") R203_BallRetainerTop(Body_OD=Body_OD, Body_ID=Body_ID);
		if (ShowInternals)
			color("Green") R203_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID, HasPD_Ring=false);
			
	}
	
	if (ShowInternals) translate([0,0,LowerBallLock_Z-0.2]){
		rotate([180,0,0]) R203_PetalHub();
		translate([0,0,-10]) rotate([180,0,0])
			PD_Petals(OD=Coupler_OD, Len=DroguePetal_Len, nPetals=nPetals, Wall_t=1.8,
									AntiClimber_h=5.0, HasLocks=false, Lock_Span_a=0);
									
		translate([0,0,-DroguePetal_Len-110]){
			SE_SpringEndTypeA(Coupler_OD=Coupler_OD, Coupler_ID=Coupler_ID, nRopes=6, 
								Spring_OD=SE_Spring_CS11890_OD());
			translate([0,0,12.5]) color("LightBlue") 
				Tube(OD=Coupler_OD, ID=Coupler_ID, Len=75, myfn=90);
		}
		translate([0,0,-DroguePetal_Len-210]){
			SE_SlidingBigSpringMiddle(OD=Coupler_OD, SliderLen=80, Extension=0);
			translate([0,0,-50]) rotate([180,0,0]) SE_SpringEndTypeC(Coupler_OD=Coupler_OD, Coupler_ID=Coupler_ID, nRopes=6, UseSmallSpring=false);
		}
	}
	
	if (ShowInternals) translate([0,0,MotorTube_Z+MotorTube_Len]) color("Orange")
		R203_MotorTubeTopper();
	
	if (ShowInternals) translate([0,0,LowerBody_Z+200]) color("Orange")
		CenteringRing(OD=Body_ID, ID=MotorTube_OD, Thickness=10, nHoles=6, Offset=0, myfn=$preview? 90:360);
		
	if (ShowInternals) translate([0,0,LowerBody_Z+400]) color("Orange")
		CenteringRing(OD=Body_ID, ID=MotorTube_OD, Thickness=10, nHoles=6, Offset=0, myfn=$preview? 90:360);
	
	if (!ShowInternals) translate([0,0,LowerBody_Z+0.2]) color("LightBlue") 
		Tube(OD=Body_OD, ID=Body_ID, Len=LowerBody_Len-0.4, myfn=90);
	/**/
	//*
	translate([0,0,FinCan_Z]) FinCan();
	
	translate([0,0,MotorTube_Z-MotorRetainer_Len+15]) color("Gray") 
		Tube(OD=MotorRetainer_OD, ID=MotorTube_OD, Len=MotorRetainer_Len, myfn=90);
		
	if (ShowInternals) translate([0,0,MotorTube_Z]) color("LightBlue")
		Tube(OD=MotorTube_OD, ID=MotorTube_ID, Len=MotorTube_Len, myfn=90);
	
	//*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j+180/nFins])
		translate([0, Body_OD/2-Fin_Post_h, Fin_Z]) 
			rotate([-90,0,0]) color("LightGreen") Rocket_Fin();
	/**/
} // ShowRocket

// ShowRocket(ShowInternals=false);
// ShowRocket(ShowInternals=true);

module FinCanAlignmentTool(){
	Tube(OD=32, ID=28, Len=6, myfn=360);
} // FinCanAlignmentTool

// FinCanAlignmentTool();

module EBay(TopOnly=false, BottomOnly=false, ShowDoors=false){
	TubeStop_Z=EBayBoltInset*2+EBayCR_t+1.9;
	echo(TubeStop_Z=TubeStop_Z);
	R20351D_Doors=$preview? [[],[45],[-45]]:[[0,180],[45,180+45],[-45,-90,180-45,180-90]]; // Altimeters, Alt_Batts, SW_Bats
	
	EB_Electronics_BayUniversal(Tube_OD=Body_OD, Tube_ID=Body_ID, DoorAngles=R20351D_Doors, Len=EBay_Len, 
									nBolts=nEBay_Bolts, BoltInset=EBayBoltInset, ShowDoors=ShowDoors,
									HasFwdIntegratedCoupler=false, HasFwdShockMount=false,
									HasAftIntegratedCoupler=false, HasAftShockMount=false,
									HasRailGuide=false, RailGuideLen=35,
									HasFwdCenteringRing=false, HasAftCenteringRing=false, InnerTube_OD=BT54Body_OD,
									Bolted=true, ExtraBolts=[], TopOnly=TopOnly, BottomOnly=BottomOnly);
									
	// Bottom centering ring stop
	if (!TopOnly) translate([0,0,TubeStop_Z]) 
		TubeStop(InnerTubeID=Coupler_ID, OuterTubeOD=Body_OD, myfn=$preview? 36:360);
		
	// Top centering ring stop
	if (!BottomOnly) translate([0,0,EBay_Len-TubeStop_Z]) rotate([180,0,0])
		TubeStop(InnerTubeID=Coupler_ID, OuterTubeOD=Body_OD, myfn=$preview? 36:360);
} // EBay

// EBay();

module FinCan(LowerHalfOnly=false, UpperHalfOnly=false, TailConeOnly=false){
	
	Cutout_d=60;
	Cutout_Depth=35;
	RailGuide_Z=40;
	Cut_Z=Cone_Len;
	
	difference(){
		FC2_FinCan(Body_OD=Body_OD, Body_ID=Body_ID, Can_Len=FinCan_Len,
				MotorTube_OD=MotorTube_OD, RailGuide_h=Body_OD/2+2, RailGuide_z=RailGuide_Z,
				nFins=nFins, HasIntegratedCoupler=true, Coupler_Len=EBayBoltInset*2, nCouplerBolts=nFins*2,
				HasMotorSleeve=true, HasAftIntegratedCoupler=false,
				Fin_Root_W=Fin_Root_W, Fin_Root_L=Fin_Root_L, Fin_Post_h=Fin_Post_h, Fin_Chamfer_L=Fin_Chamfer_L,
				Cone_Len=Cone_Len, ThreadedTC=false, Extra_OD=0, RailGuideLen=40,
				LowerHalfOnly=LowerHalfOnly, UpperHalfOnly=UpperHalfOnly, HasWireHoles=false, 
				HollowTailcone=true, 
				HollowFinRoots=true, Wall_t=2.2, OgiveTailCone=false, Ogive_Len=0, OgiveCut_d=0);
					
		// Motor Retainer
		translate([0,0,-Cut_Z-8]){
			cylinder(d=MotorRetainer_OD, h=MotorRetainer_Len);
			cylinder(d=MotorTube_OD+IDXtra*2, h=MotorRetainer_Len+8+Overlap);
		}

		if (TailConeOnly) cylinder(d=Body_OD+6, h=FinCan_Len+30);
		if (LowerHalfOnly) mirror([0,0,1]) cylinder(d=Body_OD+1, h=Cut_Z+1);
	} // difference
	
	
} // FinCan

// FinCan();

module Rocket_Fin(){
	TrapFin2(Post_h=Fin_Post_h, Root_L=Fin_Root_L, Tip_L=Fin_Tip_L,
			Root_W=Fin_Root_W, Tip_W=Fin_Tip_W,
			Span=Fin_Span, Chamfer_L=Fin_Chamfer_L,
					TipOffset=Fin_TipOffset, PrinterBrim_H=0.8, HasSpiralVaseRibs=false);

} // Rocket_Fin

// Rocket_Fin();

























