// ***********************************
// Project: 3D Printed Rocket
// Filename: Rocket102UL.scad
// by David M. Flynn
// Created: 12/27/2024
// Revision: 1.0.5  1/3/2025
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
// 1.0.5  1/3/2025   Added body tube bolt holes to fin can.
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
BoosterPetal_Len=80;
// rotate([180,0,0]) PD_Petals(OD=Body_ID-BodyTubeAnnulus, Len=BoosterPetal_Len, nPetals=nPetals, Wall_t=1.8, AntiClimber_h=4, HasLocks=true, Lock_Span_a=30);
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
// Spacer
// Tube(OD=Body_ID-BodyTubeAnnulus, ID=Body_ID-BodyTubeAnnulus-2.4, Len=60, myfn=$preview? 90:360);
//
//  *** Cable Release ***
//
// CRBBm_CenteringRingMount(OD=Body_ID-BodyTubeAnnulus, Thickness=8, Spring_OD=SE_Spring_CS4323_OD(), Spring_ID=SE_Spring_CS4323_ID());
// CRBBm_ExtensionRod(LockPin_d=LockPin_d, Len=100, ID=0.190*25.4+IDXtra, Light=false);
// CRBBm_LockingPin(LockPin_d=LockPin_d, LockPin_Len=LockPin_Len, GuidePoint=false);
// rotate([180,0,0]) CRBBm_LockRing(LockPin_d=LockPin_d, Ball_d=CR_Ball_d, nBalls=nCR_Balls, GuidePoint=false, Light=true);
// rotate([180,0,0]) CRBBm_TopRetainer(LockPin_d=LockPin_d, nBalls=nCR_Balls, LockRing_d=CRBBm_LockRingDiameter(), Flange_t=4, OD=0, HasMountingBolts=true, GuidePoint=false, Light=true);
// CRBBm_OuterBearingRetainer(Light=true);
// rotate([180,0,0]) CRBBm_MagnetBracket();
// rotate([180,0,0]) CRBBm_TriggerPost();
// 
// CRBBm_LockPinExtensionEnd(); // Presses onto 5/16" OD Aluminum tube.
//
//
// *** Fin Can ***
//
// rotate([180,0,0]) R102UL_MotorTubeTopper();
// FinCan(LowerHalfOnly=false, UpperHalfOnly=true);
// rotate([180,0,0]) FinCan(LowerHalfOnly=true, UpperHalfOnly=false);
// MotorRetainer();
// RocketFin();
//
// BoosterPetalHub();
// BoosterFinCan(LowerHalfOnly=false, UpperHalfOnly=false);
// rotate([0,0,90]) BoosterFin();
//
// rotate([90,0,0]) BoltOnRailGuide(Length = R102_RailGuideLen, BoltSpace=12.7, RoundEnds=true);
// rotate([-90,0,0]) RailGuideSpacer(OD=Body_OD, H=RailGuide_h, Length = R102_RailGuideLen, BoltSpace=12.7);
//
//  *** Tools ***
//
// BodyDrillingJig(Tube_OD=Body_OD, Tube_ID=Body_ID, nBolts=5, BoltInset=7.5);
//
// PD_PetalHolderLockLever();
// PD_PetalHolder(Petal_OD=ULine102Body_ID-0.5, Is_Top=false); // bottom half
// PD_PetalHolder(Petal_OD=ULine102Body_ID-0.5, Is_Top=true); // top half
//
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
use<AT_RMS_Lib.scad>
use<RailGuide.scad>
use<Fins.scad>
use<NoseCone.scad>
use<ElectronicsBayLib.scad>
use<SpringThingBooster.scad> echo(SpringThingBoosterRev());
use<PetalDeploymentLib.scad>
use<SpringEndsLib.scad>
use<CableReleaseBBMini.scad>
use<BatteryHolderLib.scad>
use<DoorLib.scad>
use<ThreadLib.scad>

//also included
 //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

LockPin_d=16;
LockPin_Len=25;
CR_Ball_d=5/16*25.4;
nCR_Balls=3;

nFins=5;

Fin_Post_h=15;
Fin_Root_L=280;
Fin_Root_W=10;
Fin_Tip_W=2.0;
Fin_Tip_L=90;
Fin_Span=130;
Fin_TipOffset=60;
Fin_Chamfer_L=40;
FinInset_Len=5;
Can_Len=Fin_Root_L+FinInset_Len*2;

BFin_Post_h=15;
BFin_Root_L=150;
BFin_Root_W=10;
BFin_Tip_W=2.0;
BFin_Tip_L=120;
BFin_Span=130;
BFin_TipOffset=0;
BFin_Chamfer_L=40;
BFinInset_Len=5;
BCan_Len=BFin_Root_L+BFinInset_Len*2;

Body_OD=ULine102Body_OD;
Body_ID=ULine102Body_ID;
BodyTubeAnnulus=1.2; // for sliders
Coupler_OD=BT98Body_OD; // fits tight
Coupler_ID=BT98Body_ID;

// *** 54mm Motor Tube ***
MotorTube_OD=BT54Body_OD;
MotorTube_ID=BT54Body_ID;

BMotorTube_OD=BT54Body_OD;
BMotorTube_ID=BT54Body_ID;


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

BMotorTubeLen=BCan_Len+15;


Bolt4Inset=4;
nLockBalls=6;
nPetals=3;
nRopes=6;
TailCone_Len=65;
RailGuide_h=Body_OD/2+2;
R102_RailGuideLen=30;

Thread1024_d=0.190*25.4; // 10-24 NC
Thread1024_p=25.4/24;
Thread25020_d=0.250*25.4; // 1/4-20 NC
Thread25020_p=25.4/20;
Thread31218_d=5/16*25.4; // 5/16-18 NC
Thread31218_p=25.4/18;

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

BoosterBodyTubeLen=120;

module ShowBooster(ShowInternals=false){
	MotorTube_Z=0;
	FinCan_Z=0;
	Fin_Z=FinCan_Z+BFin_Root_L/2+BFinInset_Len;
	BodyTube_Z=FinCan_Z+BCan_Len+Overlap*2;
	
	
	
	if (ShowInternals==false)
		translate([0,0,BodyTube_Z]) color("LightBlue") Tube(OD=Body_OD, ID=Body_ID, 
			Len=BoosterBodyTubeLen-Overlap*2, myfn=$preview? 90:360);

	
	translate([0,0,FinCan_Z]) color("White") BoosterFinCan();
	
	//*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j+180/nFins])
		translate([0,Body_OD/2-BFin_Post_h, Fin_Z]) 
			rotate([-90,0,0]) color("Orange") BoosterFin();
	/**/
	
	if (ShowInternals) translate([0,0,MotorTube_Z]) color("Blue") 
		Tube(OD=BMotorTube_OD, ID=BMotorTube_ID, Len=BMotorTubeLen, myfn=90);
		
	if (ShowInternals) translate([0,0,MotorTube_Z]) ATRMS_54_427_Motor(HasEyeBolt=false);
} // ShowBooster

// ShowBooster(ShowInternals=true);
// ShowBooster(ShowInternals=false);

module StubbyNoseCone(){
	// for booster test
	NC_Len=180;
	NC_Base_L=6;
	NC_Tip_r=8;
	NC_Wall_t=1.8;
	nBolts=6;
	Shoulder_OD=Coupler_OD;
	
	BluntOgiveNoseCone(ID=Shoulder_OD, OD=Body_OD*CF_Comp+Vinyl_d, L=NC_Len, Base_L=NC_Base_L, Tip_R=NC_Tip_r, Wall_T=NC_Wall_t,
		Cut_d=0, LowerPortion=false, nRivets=0, FillTip=true);
		
	difference(){
		PD_PetalHubBoltPattern(OD=Shoulder_OD, nBolts=nBolts) hull(){
			cylinder(d=7, h=NC_Base_L);
			translate([0,4.5,0]) scale([1,0.2,1]) cylinder(d=9, h=NC_Base_L);
		}
		
		PD_PetalHubBoltPattern(OD=Shoulder_OD, nBolts=nBolts) rotate([180,0,0]) Bolt4Hole();					
	} // difference
} // StubbyNoseCone

// StubbyNoseCone();

module StubbyNoseConeBase(Len=20){
	nBolts=6;
	Shoulder_OD=Body_ID-0.6;
	myfn=floor(Shoulder_OD)*2;
	
	difference(){
		cylinder(d=Shoulder_OD, h=Len, $fn=myfn);
		
		// shock cord
		translate([0,Shoulder_OD/2-10,-Overlap]) cylinder(d=4,h=Len+Overlap*2);
		
		//translate([0,0,3]) cylinder(d=Shoulder_OD-Bolt4Inset*4, h=Len, $fn=myfn);
		
		translate([0,0,-Overlap]) cylinder(d=Coupler_ID+IDXtra*2, h=15, $fn=myfn);
		
		translate([0,0,Len-6]) PD_PetalHubBoltPattern(OD=Shoulder_OD, nBolts=nBolts) rotate([180,0,0]) Bolt4HeadHole(depth=8,lHead=Len);
	} // difference
} // StubbyNoseConeBase

// rotate([180,0,0]) StubbyNoseConeBase();


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
						Coupler_Len=15, nCouplerBolts=6,
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
	
	TrapFin3(Post_h=Fin_Post_h, Root_L=Fin_Root_L, Tip_L=Fin_Tip_L, Root_W=Fin_Root_W,
				Tip_W=Fin_Tip_W, Span=Fin_Span, Chamfer_L=Fin_Chamfer_L,
				TipOffset=Fin_TipOffset,
				Bisect=false, Bisect_X=0,
				HasSpar=false, Spar_d=8, Spar_L=100,
				PrinterBrim_H=0.8, HasSpiralVaseRibs=false);
				
	
} // RocketFin

//RocketFin();

// ***************************************
Vinyl_d=0.3;

module BoosterShockCord(){
	Thread_d=Thread31218_d; // 5/16-18 NC
	Thread_p=Thread31218_p;
	OD=Body_ID-0.4;
	myfn=floor(OD)*2;
	Len=20;
	Boss_d=Thread_d+6.6;
	nSpokes=6;
	Spoke_t=1.2;
	
	difference(){
		union(){
			Tube(OD=OD, ID=Body_ID-4.4, Len=Len, myfn=$preview? 90:180);
			cylinder(d=Boss_d, h=Len, $fn=myfn);
			
			for (j=[0:nSpokes-1]) rotate([0,0,360/nSpokes*j])
				hull(){
					cylinder(d=Spoke_t, h=Len);
					translate([0,OD/2-Spoke_t,0]) cylinder(d=Spoke_t, h=Len);
				} // hull
			
			hull(){
				translate([0,0,3]) rotate([-90,0,0]) cylinder(d=6, h=OD/2-1);
				translate([0,0,Len/2]) rotate([-90,0,0]) cylinder(d=Boss_d, h=OD/2-1);
				translate([0,0,Len-3]) rotate([-90,0,0]) cylinder(d=6, h=OD/2-1);
			} // hull
		} // union
		
		translate([0,0,-Overlap])
			if ($preview){
					cylinder(d=Thread_d, h=Len+Overlap*2); 
				}else{
					ExternalThread(Pitch=Thread_p, Dia_Nominal=Thread_d+IDXtra*2, 
							Length=Len+Overlap*2, 
							Step_a=2,TrimEnd=true,TrimRoot=true);
				}
		 
	} // difference
} // BoosterShockCord

// BoosterShockCord();

module NutStop(Len=18){
	Thread_d=Thread31218_d; // 5/16-18 NC
	Thread_p=Thread31218_p;
	OD=MotorTube_ID;
	myfn=floor(OD)*2;
	
	difference(){
		cylinder(d=OD, h=Len, $fn=myfn);
		
		translate([0,0,-Overlap])
			if ($preview){
					cylinder(d=Thread_d, h=Len+Overlap*2); 
				}else{
					ExternalThread(Pitch=Thread_p, Dia_Nominal=Thread_d+IDXtra*2, 
							Length=Len+Overlap*2, 
							Step_a=2,TrimEnd=true,TrimRoot=true);
				}
		 
	} // difference
} // NutStop

// NutStop();

module BoosterPetalHub(){
	difference(){
		PD_PetalHub(OD=Body_ID-BodyTubeAnnulus, 
					nPetals=3, 
					HasReplaceableSpringHolder=true,
					HasBolts=false,
					nBolts=0, // Same as nPetals
					ShockCord_a=-1,
					HasNCSkirt=false, 
						Body_OD=Coupler_OD,
						Body_ID=Coupler_ID,
						NC_Base=0, 
						SkirtLen=15, 
					CenterHole_d=0);
				
		// Shock cord hole
		rotate([0,0,60]){
			translate([0,Coupler_OD/2-8,-Overlap]) cylinder(d=8, h=6);
			translate([0,Coupler_OD/2-8,-Overlap]) cylinder(d=4, h=26);
		}
	} // difference
					
		translate([0,0,-15]) Tube(OD=Coupler_ID, ID=Coupler_ID-4.4, Len=15+Overlap, myfn=$preview? 90:360);
} // BoosterPetalHub

// BoosterPetalHub();

BoosterEBayDoor_X=41;
BoosterEBayDoor_Y=100;

module BoosterDrillJig(){
	nBolts=5;
	ID=Body_OD*CF_Comp+Vinyl_d+IDXtra*2;
	
	difference(){
		Tube(OD=ID+2.4, ID=ID, Len=15, myfn=$preview? 36:180);
		
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j])
			translate([0,ID/2-2,7.5]) rotate([-90,0,0]) cylinder(d=3, h=5);
	} // difference

} // BoosterDrillJig

// BoosterDrillJig();

module BoosterFinCan(LowerHalfOnly=false, UpperHalfOnly=false){			
	OD=Body_OD*CF_Comp+Vinyl_d;
	AltDoor_a=180+360/nFins*2;
	RocketServoDoor_a=180+360/nFins*3;
	Door_t=3.7;
				
	difference(){
		FC2_FinCan(Body_OD=OD, Body_ID=Body_ID, Can_Len=BCan_Len, 
						MotorTube_OD=BMotorTube_OD, RailGuide_h=RailGuide_h, RailGuide_z=0,
						nFins=nFins,
						HasIntegratedCoupler=true, HasFwdCenteringRing=false, HasMidCenteringRing=false, Coupler_Len=15, nCouplerBolts=5,
						HasMotorSleeve=false, HasAftIntegratedCoupler=false,
						
						Fin_Root_W=BFin_Root_W, Fin_Root_L=BFin_Root_L, 
						Fin_Post_h=BFin_Post_h, Fin_Chamfer_L=BFin_Chamfer_L,
						
						Cone_Len=0, ThreadedTC=false, Extra_OD=0, RailGuideLen=R102_RailGuideLen,
						LowerHalfOnly=LowerHalfOnly, UpperHalfOnly=UpperHalfOnly, HasWireHoles=false, 
						HollowTailcone=true, HollowFinRoots=true, Wall_t=1.2,
						UseTrapFin3=true, AftClosure_OD=0, AftClosure_Len=0);
		
		translate([0,0,BCan_Len/2]) rotate([0,0,AltDoor_a]) 
			DoorFrameHole(Door_X=BoosterEBayDoor_X, Door_Y=BoosterEBayDoor_Y, Door_t=Door_t, Tube_OD=OD);
		translate([0,0,BCan_Len/2]) rotate([0,0,RocketServoDoor_a]) 
			DoorFrameHole(Door_X=BoosterEBayDoor_X, Door_Y=BoosterEBayDoor_Y, Door_t=Door_t, Tube_OD=OD);
		
	} // difference
	
	translate([0,0,BCan_Len/2]) rotate([0,0,AltDoor_a]) 
		DoorFrame(Door_X=BoosterEBayDoor_X, Door_Y=BoosterEBayDoor_Y, Door_t=Door_t, Tube_OD=OD, HasSixBolts=true, HasBoltBosses=true);
	translate([0,0,BCan_Len/2]) rotate([0,0,RocketServoDoor_a]) 
		DoorFrame(Door_X=BoosterEBayDoor_X, Door_Y=BoosterEBayDoor_Y, Door_t=Door_t, Tube_OD=OD, HasSixBolts=true, HasBoltBosses=true);
						
	CenteringRing(OD=Body_OD-1, ID=BMotorTube_OD+1, Thickness=5, nHoles=0, Offset=0, myfn=$preview? 90:360);
} // BoosterFinCan

// BoosterFinCan(LowerHalfOnly=false, UpperHalfOnly=false);


module BoosterFin(){
	
	TrapFin3(Post_h=BFin_Post_h, Root_L=BFin_Root_L, Tip_L=BFin_Tip_L, Root_W=BFin_Root_W,
				Tip_W=BFin_Tip_W, Span=BFin_Span, Chamfer_L=BFin_Chamfer_L,
				TipOffset=BFin_TipOffset,
				Bisect=false, Bisect_X=0,
				HasSpar=false, Spar_d=8, Spar_L=100,
				PrinterBrim_H=0.8, HasSpiralVaseRibs=false);
	
} // BoosterFin

// BoosterFin();



module EBayDoor(OD=Body_OD*CF_Comp+Vinyl_d){
		// Battery size
	Batt_X=20;
	Batt_Y=12.2;
	Batt_Z=40; // was 43
	Door_t=3.0;

	module BattHole(Xtra_X=0,Xtra_Y=0, Xtra_Z=0){
		cube([Batt_X+Xtra_X, Batt_Y+Xtra_Y, Batt_Z+Xtra_Z], center=true);
	} // BattHole
	
	module BattPocket(){
		Wall_t=1.2;
		
		difference(){
			BattHole(Xtra_X=Wall_t*2,Xtra_Y=Wall_t*2, Xtra_Z=Wall_t*2);
			
			translate([0,0,2]) BattHole(Xtra_X=0, Xtra_Y=0, Xtra_Z=4);
			
			// wires
			translate([0,0,Batt_Z/2+2]) rotate([0,90,0]) cylinder(d=7, h=20);
			
			// push-up
			translate([0,0,-Batt_Z/2-Wall_t-Overlap]) cylinder(d=5,h=5);
			
			// Lighter		
			hull(){
				rotate([90,0,0]) cylinder(d=14, h=Batt_Y+Wall_t*2+Overlap, center=true);
				translate([0,0,Batt_Z/3]) rotate([90,0,0]) cylinder(d=3, h=Batt_Y+Wall_t*2+Overlap, center=true);
				translate([0,0,-Batt_Z/3]) rotate([90,0,0]) cylinder(d=3, h=Batt_Y+Wall_t*2+Overlap, center=true);
			} // hull
			
			hull(){
				rotate([0,90,0]) cylinder(d=10, h=Batt_X+Wall_t*2+Overlap, center=true);
				translate([0,0,Batt_Z/3]) rotate([0,90,0]) cylinder(d=3, h=Batt_X+Wall_t*2+Overlap, center=true);
				translate([0,0,-Batt_Z/3]) rotate([0,90,0]) cylinder(d=3, h=Batt_X+Wall_t*2+Overlap, center=true);
			} // hull
			
		} // difference
	} // BattPocket
	DoorFace_Y=OD/2;
	BattPocket_Y=-0.2;
	MagSw_Y=-3;
	BlueRaven_Y=8;
	
	difference(){
		union(){
			translate([0,DoorFace_Y-10,-5]){
				translate([0,BlueRaven_Y,-18]) rotate([0,90,-90]) BlueRavenMount();
				translate([11,MagSw_Y,20]) rotate([90,0,90]) FW_MagSw_Mount(HasMountingEars=false);
				//translate([-11,-5,38.3]) rotate([-90,0,90]) RocketServoHolderRevC(IsDouble=false);
				translate([0,BattPocket_Y,26.7]) rotate([0,0,0]) BattPocket();
			}
			rotate([0,0,180]) Door(Door_X=BoosterEBayDoor_X, Door_Y=BoosterEBayDoor_Y, Door_t=Door_t, Tube_OD=OD, HasSixBolts=true, HasBoltHoles=true);
		} // union
		
		translate([0,DoorFace_Y-10,-5]) translate([13.5,MagSw_Y,20]) rotate([90,0,90]) FW_MagSw_BoltPattern() Bolt4Hole(depth=5);
	} // difference
	//Tube(OD=Body_OD, ID=Coupler_ID, Len=5, myfn=$preview? 90:360);
	//Tube(OD=MotorTube_OD, ID=MotorTube_ID, Len=5, myfn=$preview? 90:360);
} // EBayDoor

//translate([0,0,BCan_Len/2]) rotate([0,0,72*2]) translate([0,1,0]) color("Tan") rotate([90,0,0]) EBayDoor();
//BoosterFinCan(LowerHalfOnly=false, UpperHalfOnly=false);

// DoorHole(Door_X=30, Door_Y=50, Door_t=3, Tube_OD=PML98Body_OD);
// DoorFrameHole(Door_X=30, Door_Y=50, Door_t=3, Tube_OD=PML98Body_OD);
// DoorFrame(Door_X=30, Door_Y=50, Door_t=3, Tube_OD=PML98Body_OD, HasSixBolts=true, HasBoltBosses=true);
// DoorBoltPattern(Door_X=30, Door_Y=50, Tube_OD=PML98Body_OD, HasSixBolts=true) Bolt4Hole();
// Door(Door_X=30, Door_Y=50, Door_t=3, Tube_OD=PML98Body_OD, HasSixBolts=true, HasBoltHoles=true);



module EBayDoor2(OD=Body_OD*CF_Comp+Vinyl_d){
		// Battery size
	Batt_X=20;
	Batt_Y=12.2;
	Batt_Z=40; // was 43
	Door_t=3.0;

	module BattHole(Xtra_X=0,Xtra_Y=0, Xtra_Z=0){
		cube([Batt_X+Xtra_X, Batt_Y+Xtra_Y, Batt_Z+Xtra_Z], center=true);
	} // BattHole
	
	module BattPocket(){
		Wall_t=1.2;
		
		difference(){
			BattHole(Xtra_X=Wall_t*2,Xtra_Y=Wall_t*2, Xtra_Z=Wall_t*2);
			
			translate([0,0,2]) BattHole(Xtra_X=0, Xtra_Y=0, Xtra_Z=4);
			
			// wires
			translate([0,0,Batt_Z/2+2]) rotate([0,90,0]) cylinder(d=7, h=20);
			
			// push-up
			translate([0,0,-Batt_Z/2-Wall_t-Overlap]) cylinder(d=5,h=5);
			
			// Lighter		
			hull(){
				rotate([90,0,0]) cylinder(d=14, h=Batt_Y+Wall_t*2+Overlap, center=true);
				translate([0,0,Batt_Z/3]) rotate([90,0,0]) cylinder(d=3, h=Batt_Y+Wall_t*2+Overlap, center=true);
				translate([0,0,-Batt_Z/3]) rotate([90,0,0]) cylinder(d=3, h=Batt_Y+Wall_t*2+Overlap, center=true);
			} // hull
			
			hull(){
				rotate([0,90,0]) cylinder(d=10, h=Batt_X+Wall_t*2+Overlap, center=true);
				translate([0,0,Batt_Z/3]) rotate([0,90,0]) cylinder(d=3, h=Batt_X+Wall_t*2+Overlap, center=true);
				translate([0,0,-Batt_Z/3]) rotate([0,90,0]) cylinder(d=3, h=Batt_X+Wall_t*2+Overlap, center=true);
			} // hull
			
		} // difference
	} // BattPocket
	DoorFace_Y=OD/2;
	BattPocket_Y=-0.2;
	MagSw_Y=-3;
	BlueRaven_Y=8;
	
	difference(){
		union(){
			translate([0,DoorFace_Y-10,-5]){
				//translate([0,BlueRaven_Y,-18]) rotate([0,90,-90]) BlueRavenMount();
				//translate([11,MagSw_Y,20]) rotate([90,0,90]) FW_MagSw_Mount(HasMountingEars=false);
				translate([0,8,10]) rotate([-90,0,180]) RocketServoHolderRevC(IsDouble=false);
				//translate([0,BattPocket_Y,26.7]) rotate([0,0,0]) BattPocket();
			}
			rotate([0,0,180]) Door(Door_X=BoosterEBayDoor_X, Door_Y=BoosterEBayDoor_Y, Door_t=Door_t, Tube_OD=OD, HasSixBolts=true, HasBoltHoles=true);
		} // union
		
		// LED hole
		translate([0,0,-35]) rotate([-90,0,0]) cylinder(d=3,h=OD/2+1);
		
		// Rocket servo bolts
		translate([0,DoorFace_Y-10,-5]) translate([0,8,10]) rotate([-90,0,180]) 
			RocketServoRevCBoltPattern() Bolt4Hole();
		
		//translate([0,DoorFace_Y-10,-5]) translate([13.5,MagSw_Y,20]) rotate([90,0,90]) FW_MagSw_BoltPattern() Bolt4Hole(depth=5);
	} // difference
	//Tube(OD=Body_OD, ID=Coupler_ID, Len=5, myfn=$preview? 90:360);
	//Tube(OD=MotorTube_OD, ID=MotorTube_ID, Len=5, myfn=$preview? 90:360);
} // EBayDoor2

// rotate([90,0,0]) EBayDoor2();


module Custom_CRBBm_Activator(){
	nRivets=5;
	Rivert_d=4;
	nSpokes=nRivets*2;
	Spoke_t=1.2;
	Ring_Z=-16.5;
	Ring_h=8;
	Ring_t=1.8;
	
	CRBBm_Activator(OD=BT65Body_ID, Thread_d=5/16*25.4, Thread_p=25.4/18);

	
	difference(){
		union(){
			translate([0,0,Ring_Z]) Tube(OD=Body_ID-0.6, ID=Body_ID-0.6-Ring_t*2, Len=8, myfn=$preview? 90:180);
			for (j=[0:nSpokes-1]) rotate([0,0,360/nSpokes*j])
				hull(){
					translate([0,Body_ID/2-1,Ring_Z]) cylinder(d=Spoke_t, h=Ring_h);
					translate([0,BT65Body_ID/2-Spoke_t/2,Ring_Z]) cylinder(d=Spoke_t, h=Ring_h);
				} // hull
		} // union
			
		for (j=[0:nRivets-1]) rotate([0,0,360/nRivets*j+180/nSpokes])
			translate([0,Body_ID/2+1,Ring_Z+Ring_h/2]) rotate([90,0,0]) #cylinder(d=Rivert_d, h=10);
	} // difference
	
} // Custom_CRBBm_Activator

// Custom_CRBBm_Activator();



module R102_FwdSpringEnd(OD=Body_ID-1, ID=Body_ID-3.6, LockPin_d=16, nRopes=6, Skirt_h=35, HasServoConnector=false){
// This locks onto the bottom of the petals.
	CR_t=2;
	Rope_d=3;
	Spring_OD=SE_Spring_CS4323_OD();
	Spring_ID=SE_Spring_CS4323_ID();
	Spring_Z=(Skirt_h>15)? Skirt_h-15:0;

	Petal_ID=OD-5.5; // should fit loose
	PetalLock_ID=OD-12; // Should not touch at all
	ShockCord_Y=Spring_ID/2-2.2-Rope_d/2-1;
	Boss_t=4;
	nVentHoles=6;
	VentHole_d=7;
	VentHole_Y=OD/2-10-VentHole_d/2;
	myFn=floor(OD)*2;
	
	difference(){
		union(){
			difference(){
				cylinder(d=OD, h=6, $fn=$preview? 90:myFn);
				
				translate([0,0,CR_t-Overlap]) cylinder(d1=ID-4, d2=ID, h=4+Overlap*2, $fn=$preview? 90:myFn);
			} // difference
			
			cylinder(d=LockPin_d, h=Boss_t);
			
			// Skirt
			Tube(OD=OD, ID=ID, Len=Skirt_h, myfn=$preview? 90:myFn);
			
			difference(){
				cylinder(d=OD, h=CR_t+5.5, $fn=$preview? 90:myFn);
				
				translate([0,0,CR_t]) cylinder(d=PetalLock_ID-2.8, h=4.5, $fn=$preview? 90:myFn);
				
				translate([0,0,CR_t+3.5]) cylinder(d1=PetalLock_ID-2.8, d2=ID, h=3.5+Overlap, $fn=$preview? 90:myFn);
			} // difference
			
			// Spring
			Tube(OD=Spring_ID, ID=Spring_ID-2.4, Len=CR_t+4+Spring_Z, myfn=$preview? 90:myFn);
			Tube(OD=Spring_OD, ID=Spring_ID-2.4, Len=CR_t+Spring_Z, myfn=$preview? 90:myFn);
			
		} // union
		
		// Servo connector
		if (HasServoConnector) rotate([0,0,30]) translate([0,OD/2-7,-Overlap]) RoundRect(X=11, Y=4, Z=10, R=0.2);
		
		// Center hole
		Thread_d=Thread1024_d;
		Thread_p=25.4/24;
		translate([0,0,-Overlap]) 
			if ($preview){
				cylinder(d=Thread_d, h=Boss_t+Overlap*2); 
			}else{
				ExternalThread(Pitch=Thread_p, Dia_Nominal=Thread_d+IDXtra*2, 
						Length=Boss_t+Overlap*2, 
						Step_a=2,TrimEnd=true,TrimRoot=true);
			}
		
		// Air Vent Holes
		for (j=[0:nVentHoles-1]) rotate([0,0,360/nVentHoles*j+180/nVentHoles]) 
			translate([0,VentHole_Y,-Overlap]) cylinder(d=VentHole_d, h=CR_t+Overlap*2);
		
		// Shock cord
		rotate([0,0,180/nVentHoles]) translate([0,ShockCord_Y,-Overlap]) cylinder(d=4, h=30);
		
		// Petal Locks
		difference(){
			translate([0,0,-Overlap]) cylinder(d=OD+1, h=5+Overlap*2, $fn=$preview? 90:myFn);
			
			// Puller ring
			translate([0,0,-Overlap*2]) cylinder(d=Petal_ID, h=2+Overlap*3, $fn=$preview? 90:myFn);
			// Petal lock
			translate([0,0,-Overlap*2]) cylinder(d=PetalLock_ID, h=5+Overlap*3, $fn=$preview? 90:myFn);
			
		} // difference
		
		// Rope holes
		if (nRopes>0) for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j]) 
			translate([0,Spring_OD/2+Rope_d/2+8,-Overlap]) cylinder(d=Rope_d, h=CR_t+Overlap*2);
			
		//if ($preview) translate([0,0,-Overlap]) cube([100,100,100]);
	} // difference
	
} // R102_FwdSpringEnd

// R102_FwdSpringEnd();























