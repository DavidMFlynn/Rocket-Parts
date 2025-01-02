// ***********************************
// Project: 3D Printed Rocket
// Filename: Rocket102UL.scad
// by David M. Flynn
// Created: 12/27/2024
// Revision: 1.0.4  1/1/2025
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  A ULine 4 inch mailing tube version of Rocket98
//  Rocket with 102mm Body and 54mm motor. 
//  Printing with TINMORRY PETG-CF Black for fins, fin can and nosecone.
//
//  Dual deploy:
//   Mission Control V3 / RocketServo
//
//  ***** Parts *****
//
// ULine 4" Body Tube by 310mm Forward Bay
// ULine 4" Body Tube by 850mm Lower Body
// Blue Tube 2.1" Body Tube by 19.5 inches minimum Motor Tube (Fits 54/1706 case)
// Drogue parachute
// 63" Parachute
// 1/2" Braided Nylon Shock Cord (40 feet)
//
//  ***** Hardware *****
//
// #6-32 x 3/4" Button Head Cap Screw (4 req) Rail Guides
// #4-40 x 1/2" Socket Head Cap Screw (12 req) Ball Lock
// #4-40 x 3/8" Button Head Cap Screw (14 req) Doors
// #4-40 x 3/8" Socket Head Cap Screw (6 req) PetalHub
// #4-40 x 1/4" Button Head Cap Screw (4 req) Altimeter
// #4-40 x 1/4" Button Head Cap Screw (24 req) Petals
// #4-40 x 3/8" Button Head Cap Screw (8 req) Servos
// 1/2" x 0.035" wall x 99mm long Aluminum tubing (3 req) Shock cord mounts
// MR84-2RS Bearing (12 req) Ball Lock
// 6806-2RS Bearing (2 req) Ball Lock
// 3/8" Delrin Ball (12 req) Ball Lock
// 4mm Dia. x 10mm Undersize Steel Dowel (12 req) Ball Lock
// 4mm Dia. x 16mm Undersize Steel Dowel (4 req) Ball Lock
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
// 1.0.4  1/1/2025   Added Pusher ring to top of ebay assy
// 1.0.3  12/30/2024 Fixes to lengths of Electronics bay and Ball Locks. Taller EBay. FC1
// 1.0.2  12/29/2024 Changed to large bearing for ball locks, updated hardware list.
// 1.0.1  12/28/2024 Cleaning up and printing 1st Art.
// 1.0.0  12/27/2024 Copied Rocket98C Rev: 1.2.3
//
// ***********************************
//  ***** for STL output *****
//
// *** Nosecode ***
//
// NoseCone();
// NC_ShockcordRingDual(Tube_OD=Body_OD*PETG_Comp, Tube_ID=Body_ID, NC_Base_L=NC_Base_L, nRivets=NC_nRivets, nBolts=nEBayBolts, Flat=false);
//
// rotate([180,0,0]) ElectronicsBay(TopOnly=true, BottomOnly=false);
// ElectronicsBay(TopOnly=false, BottomOnly=true);
// CenteringRing(OD=Body_ID, ID=ULine38Body_OD+IDXtra, Thickness=4, nHoles=5); // print 2
//
// *** Doors ***
//
// rotate([-90,0,0]) EB_AltDoor(Tube_OD=Body_OD);
// rotate([-90,0,0]) EB_BattDoor(Tube_OD=Body_OD, HasSwitch=true, DoubleBatt=false);
// rotate([-90,0,0]) EB_BattDoor(Tube_OD=Body_OD, HasSwitch=false, DoubleBatt=false);
//
// *** Ball Lock ***
//
// STB_LockDisk(Body_ID=Body_ID, nLockBalls=nLockBalls, HasLargeInnerBearing=true, Xtra_r=0.2);
// rotate([180,0,0]) R102UL_BallRetainerTop(nBolts=nEBayBolts, Xtra_r=0.2);
// R102UL_BallRetainerBottom(Xtra_r=0.2);
// rotate([180,0,0]) STB_TubeEnd(Body_ID=Body_ID, nLockBalls=nLockBalls, Body_OD=Body_OD, Engagement_Len=20);
//
// *** petal deployer ***
//
// PD_NC_PetalHub(OD=Body_ID-BodyTubeAnnulus, nPetals=nPetals, HasReplaceableSpringHolder=true, nRopes=nRopes, ShockCord_a=-1, HasThreadedCore=false, ST_DSpring_ID=SE_Spring_CS4323_ID(), ST_DSpring_OD=SE_Spring_CS4323_OD(), CouplerTube_ID=0);
// PD_PetalHub(OD=Body_ID-BodyTubeAnnulus, HasBolts=true, nBolts=6, nPetals=nPetals, HasReplaceableSpringHolder=true, ShockCord_a=-2);
// rotate([-90,0,0]) PD_PetalSpringHolder2();
// PD_HubSpringHolder();
// PD_Petals2(OD=Body_ID-BodyTubeAnnulus, Len=ForwardPetalLen, nPetals=nPetals, Wall_t=2.4, AntiClimber_h=4);
// PD_Petals2(OD=Body_ID-BodyTubeAnnulus, Len=AftPetalLen, nPetals=nPetals, Wall_t=2.4, AntiClimber_h=4);
//
//  *** Spring Handling ***
//
// R102UL_SkirtRing(Coupler_OD=Body_ID-BodyTubeAnnulus, Coupler_ID=Body_ID-BodyTubeAnnulus-4.4, HasPD_Ring=true);
// rotate([180,0,0]) R102UL_PusherRing(OD=Body_ID*CF_Comp-BodyTubeAnnulus, ID=Body_ID-BodyTubeAnnulus-4.4, OA_Len=20, Engagemnet_Len=7, Wall_t=4);
//
// SE_SlidingSpringMiddle(OD=Body_ID-BodyTubeAnnulus, nRopes=nRopes, SliderLen=30, SpLen=40, SpringStop_Z=20); // for Main
// SE_SlidingSpringMiddle(OD=Body_ID-BodyTubeAnnulus, nRopes=nRopes); // for Drogue
//
// rotate([180,0,0]) SE_SpringEndTypeA(Coupler_OD=Body_ID-BodyTubeAnnulus, Coupler_ID=Body_ID-BodyTubeAnnulus-4.4, nRopes=nRopes, Spring_OD=SE_Spring_CS4323_OD());
//
// rotate([180,0,0]) R102UL_PusherRing(OD=Body_ID*CF_Comp-BodyTubeAnnulus, ID=Body_ID-BodyTubeAnnulus-4.4, OA_Len=50, Engagemnet_Len=7, Wall_t=4);
//
// rotate([180,0,0]) R102UL_LowerSpringBottom();
//
// *** Fin Can ***
//
// rotate([180,0,0]) R102UL_MotorTubeTopper();
// FinCan(LowerHalfOnly=false, UpperHalfOnly=true);
// rotate([180,0,0]) FinCan(LowerHalfOnly=true, UpperHalfOnly=false);
// MotorRetainer();
// RocketFin();
//
// rotate([90,0,0]) BoltOnRailGuide(Length = R102_RailGuideLen, BoltSpace=12.7, RoundEnds=true);
// rotate([-90,0,0]) RailGuideSpacer(OD=Body_OD, H=RailGuide_h, Length = R102_RailGuideLen, BoltSpace=12.7);
//
//  *** Tools ***
//
// BodyDrillingJig();
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
use<R102ULLib.scad>
use<FinCan2Lib.scad> echo(FinCan2LibRev());
use<AT-RMS-Lib.scad>
use<RailGuide.scad>
use<Fins.scad>
use<NoseCone.scad>
use<ElectronicsBayLib.scad>
use<SpringThingBooster.scad> echo(SpringThingBoosterRev());
use<PetalDeploymentLib.scad>
use<SpringEndsLib.scad>

//also included
 //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

PETG_Comp=1.003; // shrinkage compensation for PETG parts to fit CF parts
CF_Comp=0.995; // CF parts print oversized OD

nFins=5;

Fin_Post_h=15;
Fin_Root_L=280;
Fin_Root_W=10;
Fin_Tip_W=3.0;
Fin_Tip_L=90;
Fin_Span=130;
Fin_TipOffset=60;
Fin_Chamfer_L=40;

Body_OD=ULine102Body_OD;
Body_ID=ULine102Body_ID;
BodyTubeAnnulus=1.2; // for sliders
Coupler_OD=BT98Body_OD; // fits tight
Coupler_ID=BT98Body_ID;

// *** 54mm Motor Tube ***
MotorTube_OD=BT54Body_OD;
MotorTube_ID=BT54Body_ID;

NC_Len=300;
NC_Tip_r=6;
NC_Wall_t=1.8;
NC_Base_L=15;
NC_nRivets=5;

nEBayBolts=5;
EBayBoltInset=7.5;

ForwardPetalLen=200;
ForwardTubeLen=310;
EBay_Len=166;
AftPetalLen=150;
MotorTubeLen=24*25.4;
BodyTubeLen=850;

FinInset_Len=10;
Can_Len=Fin_Root_L+FinInset_Len*2;
Bolt4Inset=4;
nLockBalls=6;
nPetals=3;
nRopes=6;
TailCone_Len=65;
RailGuide_h=Body_OD/2+2;
R102_RailGuideLen=30;

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
	translate([0,0,NoseCone_Z]) color("Orange") NoseCone();
							
	translate([0,0,NoseCone_Z-0.2]) rotate([0,0,90]) 
		NC_ShockcordRingDual(Tube_OD=Body_OD, Tube_ID=Body_ID, NC_Base_L=NC_Base_L, nRivets=3);
	
	if (ShowInternals) translate([0,0,NoseCone_Z-60])
		SE_SlidingSpringMiddle(OD=Body_ID-BodyTubeAnnulus, nRopes=nRopes, SliderLen=30, SpLen=40, SpringStop_Z=20);
	
	if (ShowInternals) translate([0,0,FwdTubeEnd_Z+ForwardPetalLen+30]) rotate([180,0,0]) 
		PD_NC_PetalHub(OD=Body_ID-BodyTubeAnnulus, nPetals=nPetals, HasReplaceableSpringHolder=true, nRopes=nRopes, ShockCord_a=-1, 
					HasThreadedCore=false, ST_DSpring_ID=SE_Spring_CS4323_ID(), ST_DSpring_OD=SE_Spring_CS4323_OD(), CouplerTube_ID=0);
	
	if (ShowInternals) translate([0,0,FwdTubeEnd_Z+ForwardPetalLen+20]) rotate([180,0,0])
		PD_Petals(OD=Body_ID-BodyTubeAnnulus, Len=ForwardPetalLen, nPetals=nPetals, AntiClimber_h=4);
							
	/**/
	
	//*
	if (ShowInternals==false) translate([0,0,FwdTubeEnd_Z]) rotate([180,0,0]) color("Orange")
		STB_TubeEnd(Body_ID=Body_ID, nLockBalls=nLockBalls, Body_OD=Body_OD, Engagement_Len=20);
	if (ShowInternals) translate([0,0,FwdBallLock_Z+0.2]) rotate([180,0,0]) 
		R102UL_BallRetainerBottom();
	translate([0,0,FwdBallLock_Z]) rotate([180,0,0]) color("White") 
		R102UL_BallRetainerTop();
	translate([0,0,EBay_Z]) color("White") 
		ElectronicsBay(ShowDoors=!ShowInternals);
	translate([0,0,AftBallLock_Z]) color("White") 
		R102UL_BallRetainerTop();
	if (ShowInternals) translate([0,0,AftBallLock_Z-0.2]) 
		R102UL_BallRetainerBottom();
	/**/
	
	//*
	if (ShowInternals==false) translate([0,0,ForwardTube_Z]) color("LightBlue") 
		Tube(OD=Body_OD, ID=Body_ID, 
			Len=ForwardTubeLen-Overlap*2, myfn=$preview? 90:360);
	/**/
	
	//*
	if (ShowInternals) translate([0,0,AftBallLock_Z-8.8]) rotate([0,0,200]) rotate([180,0,0]) 
			PD_PetalHub(OD=Body_ID-BodyTubeAnnulus, HasBolts=true, nBolts=6, nPetals=nPetals, HasReplaceableSpringHolder=true, ShockCord_a=-2);
			
	if (ShowInternals) translate([0,0,AftBallLock_Z-17]) rotate([0,0,200]) rotate([180,0,0]) 
		PD_Petals(OD=Body_ID-BodyTubeAnnulus, Len=AftPetalLen, nPetals=nPetals, AntiClimber_h=4);	
	
	if (ShowInternals) translate([0,0,AftBallLock_Z-AftPetalLen-150]){
		translate([0,0,50]){
			translate([0,0,13]) color("LightGray")
				R102UL_PusherRing(OD=Body_ID-BodyTubeAnnulus, ID=Body_ID-BodyTubeAnnulus-4.4, OA_Len=50, Engagemnet_Len=7, Wall_t=4);
			SE_SpringEndTypeA(Coupler_OD=Body_ID-BodyTubeAnnulus, Coupler_ID=Body_ID-BodyTubeAnnulus-4.4, 
								nRopes=nRopes, Spring_OD=SE_Spring_CS4323_OD());
		}
		SE_SlidingSpringMiddle(OD=Body_ID-BodyTubeAnnulus, nRopes=nRopes);
		translate([0,0,-20]) R102UL_LowerSpringBottom();
	}
	
	if (ShowInternals) translate([0,0,MotorTubeLen+12]) rotate([0,0,180]) 
		color("Gray") R102UL_MotorTubeTopper();
	/**/
	
	if (ShowInternals==false) translate([0,0,AftTubeEnd_Z]) color("Orange")
		STB_TubeEnd(Body_ID=Body_ID, nLockBalls=nLockBalls, Body_OD=Body_OD, Engagement_Len=20);
	
	if (ShowInternals==false)
	translate([0,0,BodyTube_Z]) color("LightBlue") Tube(OD=Body_OD, ID=Body_ID, 
			Len=BodyTubeLen-Overlap*2, myfn=$preview? 90:360);
	
	translate([0,0,FinCan_Z]) color("White") FinCan();
	
	//*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j+180/nFins])
		translate([0,Body_OD/2-Fin_Post_h, Fin_Z]) 
			rotate([-90,0,0]) color("Orange") RocketFin();
	/**/
	
	if (ShowInternals) translate([0,0,12]) color("Blue") 
		Tube(OD=MotorTube_OD, ID=MotorTube_ID, Len=MotorTubeLen, myfn=90);
	
	if (ShowInternals) translate([0,0,12]) ATRMS_54_1706_Motor(Extended=true, HasEyeBolt=true);
	
	translate([0,0,FinCan_Z-0.2]) color("Orange") MotorRetainer();
	
} // ShowRocket

//ShowRocket();
//ShowRocket(ShowInternals=true);

module NoseCone(){
	BluntOgiveNoseCone(ID=Coupler_OD, OD=Body_OD, L=NC_Len, Base_L=NC_Base_L, Tip_R=NC_Tip_r, Wall_T=NC_Wall_t,
		Cut_d=0, LowerPortion=false, nRivets=NC_nRivets, FillTip=true);
} // NoseCone

// NoseCone();

module ElectronicsBay(TopOnly=false, BottomOnly=false, ShowDoors=false){
	Len=EBay_Len;
	CR_t=4;
	STB_h=16;
	TubeStop_Z=STB_h+CR_t+1;
	Doors=[[0],[90],[180,270]];

	EB_Electronics_BayUniversal(Tube_OD=Body_OD, Tube_ID=Body_ID, DoorAngles=Doors, Len=Len, 
									nBolts=nEBayBolts, BoltInset=EBayBoltInset, ShowDoors=ShowDoors,
									HasFwdIntegratedCoupler=false, HasFwdShockMount=false,
									HasAftIntegratedCoupler=false, HasAftShockMount=false,
									HasRailGuide=false, RailGuideLen=35,
									HasFwdCenteringRing=false, HasAftCenteringRing=false, InnerTube_OD=BT54Body_OD,
									Bolted=true, ExtraBolts=[], TopOnly=TopOnly, BottomOnly=BottomOnly); 
	if (!TopOnly)							
		translate([0,0,TubeStop_Z])
			TubeStop(InnerTubeID=Coupler_ID, OuterTubeOD=Body_OD, myfn=$preview? 36:360);
			
	if (!BottomOnly)							
		translate([0,0,Len-TubeStop_Z]) rotate([180,0,0])
			TubeStop(InnerTubeID=Coupler_ID, OuterTubeOD=Body_OD, myfn=$preview? 36:360);
} // ElectronicsBay

//ElectronicsBay();
//ElectronicsBay(TopOnly=false, BottomOnly=false);
//translate([0,0,16]) CenteringRing(OD=Body_ID, ID=ULine38Body_OD, Thickness=4, nHoles=5);

module FinCan(LowerHalfOnly=false, UpperHalfOnly=false){
	FC2_FinCan(Body_OD=Body_OD, Body_ID=Body_ID, Can_Len=Can_Len, 
						MotorTube_OD=MotorTube_OD, RailGuide_h=RailGuide_h,
						nFins=nFins,
						Fin_Root_W=Fin_Root_W, Fin_Root_L=Fin_Root_L, 
						Fin_Post_h=Fin_Post_h, Fin_Chamfer_L=Fin_Chamfer_L,
						Cone_Len=TailCone_Len, Extra_OD=2, RailGuideLen=R102_RailGuideLen,
						LowerHalfOnly=LowerHalfOnly, UpperHalfOnly=UpperHalfOnly, HasWireHoles=false, 
						HollowTailcone=true, HollowFinRoots=true, Wall_t=1.2);
} // FinCan

// FinCan(LowerHalfOnly=false, UpperHalfOnly=false);

module MotorRetainer(){
	
	// Extra_ID adjusted for 0.6mm nozzle and 0.4mm layers
	
	FC2_MotorRetainer(Body_OD=Body_OD, 
					MotorTube_OD=MotorTube_OD, MotorTube_ID=MotorTube_ID,
					Cone_Len=TailCone_Len, Extra_OD=2, Extra_ID=0.4);
	
} // MotorRetainer

// MotorRetainer();

module RocketFin(){
	
	TrapFin2(Post_h=Fin_Post_h, Root_L=Fin_Root_L, Tip_L=Fin_Tip_L, Root_W=Fin_Root_W,
				Tip_W=Fin_Tip_W, Span=Fin_Span, Chamfer_L=Fin_Chamfer_L,
				TipOffset=Fin_TipOffset,
				Bisect=false, Bisect_X=0,
				HasSpar=false, Spar_d=8, Spar_L=100,
				PrinterBrim_H=0.8, HasSpiralVaseRibs=false);
	
} // RocketFin

//RocketFin();





































