// ***********************************
// Project: 3D Printed Rocket
// Filename: Rocket10252D.scad
// by David M. Flynn
// Created: 12/27/2024
// Revision: 0.9.3  12/17/2025
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
// 0.9.3  12/17/2025 Added Stager.
// 0.9.2  11/15/2025 Customizing for a stubby 2 stage
// 0.9.1  11/14/2025 Copied from Rocket102UL
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
// SustainerNoseConeBaseTop();
// rotate([180,0,0]) SustainerNoseConeBase();
//
// LightSpringSlider(OD=Body_ID-BodyTubeAnnulus, Len=30);
// 
// *** Ball Lock ***
//
// STB_LockDisk(Body_ID=Body_ID, nLockBalls=nLockBalls, HasLargeInnerBearing=true, Xtra_r=0.2);
// rotate([180,0,0]) my_BallRetainerTop();
// STB_BallRetainerBottom(Body_ID=Body_ID, Body_OD=Body_ID, nLockBalls=nLockBalls, Engagement_Len=20, HasLargeInnerBearing=true, Lighten=false, Xtra_r=0.2);
// rotate([180,0,0]) STB_TubeEnd(Body_ID=Body_ID, nLockBalls=nLockBalls, Body_OD=Body_OD*CF_Comp, Engagement_Len=20);
//
// *** petal deployer ***
//
// PD_NC_PetalHub(OD=Body_ID-BodyTubeAnnulus, nPetals=nPetals, HasReplaceableSpringHolder=true, nRopes=nRopes, ShockCord_a=-1, HasThreadedCore=false, ST_DSpring_ID=SE_Spring_CS4323_ID(), ST_DSpring_OD=SE_Spring_CS4323_OD(), CouplerTube_ID=0);
// 
// rotate([-90,0,0]) PD_PetalSpringHolder();
// PD_HubSpringHolder();
// PD_Petals(OD=Body_ID-BodyTubeAnnulus, Len=ForwardPetalLen, nPetals=nPetals, Wall_t=1.8, AntiClimber_h=4);
// rotate([180,0,0]) PD_Petals(OD=Body_ID-BodyTubeAnnulus, Len=BoosterPetal_Len, nPetals=nPetals, Wall_t=1.8, AntiClimber_h=4, HasLocks=true, Lock_Span_a=30);
//
//  *** Spring Handling ***
//
// R102UL_SkirtRing(Coupler_OD=Body_ID-BodyTubeAnnulus, Coupler_ID=Body_ID-BodyTubeAnnulus-4.4, HasPD_Ring=true);
// rotate([180,0,0]) R102UL_PusherRing(OD=Body_ID*CF_Comp-BodyTubeAnnulus, ID=Body_ID-BodyTubeAnnulus-4.4, OA_Len=20, Engagemnet_Len=7, Wall_t=4);
//
// SE_SlidingSpringMiddle(OD=Body_ID-BodyTubeAnnulus, nRopes=nRopes, SliderLen=30, SpLen=40, SpringStop_Z=20); // for Main
//
//  *** Stager ***
//
// rotate([180,0,0]) Stager_Cup_Light(Collar_H=17);
// Stager_Saucer(Tube_OD=Body_OD*CF_Comp+Vinyl_d, nLocks=Default_nLocks);
// rotate([-90,0,0]) Stager_LockRod(Adj=0);
// rotate([-90,0,0]) Stager_LockRod(Adj=-0.5); // works but tight
// Stager_LockRing(Tube_OD=Body_OD*CF_Comp+Vinyl_d, nLocks=Default_nLocks);
// Stager_Mech(Tube_OD=Body_OD*CF_Comp+Vinyl_d, nLocks=Default_nLocks, Skirt_ID=Body_ID, Skirt_Len=2, nSkirtBolts=0, ShowLocked=true);
// Stager_OuterBearingCover(Tube_OD=Body_OD*CF_Comp+Vinyl_d, nLocks=Default_nLocks); // Secures Outer Race of Main Bearing
// rotate([180,0,0]) Stager_Indexer(Tube_OD=Body_OD*CF_Comp+Vinyl_d, nLocks=Default_nLocks); // Secures Inner Race of Main Bearing and has Lock Stops
// Custom_ServoPlate();
// rotate([180,0,0]) Stager_ServoMount(Servo_ID=DefaultServo);
// Stager_Mech_Mount(Len=28, HasSkirtHoles=false);
//
//  *** Spacer ***
//
// Tube(OD=Body_ID-BodyTubeAnnulus, ID=Body_ID-BodyTubeAnnulus-2.4, Len=60, myfn=$preview? 90:360);
//
//  *** Cable Release ***
//
// CRBBm_LockPinExtensionEnd(); // Presses onto 5/16" OD Aluminum tube.
// CRBBm_CenteringRingMount(OD=Body_ID-BodyTubeAnnulus, Thickness=8, Spring_OD=SE_Spring_CS4323_OD(), Spring_ID=SE_Spring_CS4323_ID(), HasOuterRing=false, HasShockCordEntry=false);
// CRBBm_ExtensionRod(LockPin_d=LockPin_d, Len=100, ID=0.190*25.4+IDXtra, Light=false);
// CRBBm_LockingPin(LockPin_d=LockPin_d, LockPin_Len=LockPin_Len, GuidePoint=false);
// rotate([180,0,0]) CRBBm_LockRing(LockPin_d=LockPin_d, Ball_d=CR_Ball_d, nBalls=nCR_Balls, GuidePoint=false, Light=true);
// rotate([180,0,0]) CRBBm_TopRetainer(LockPin_d=LockPin_d, nBalls=nCR_Balls, LockRing_d=CRBBm_LockRingDiameter(), Flange_t=4, OD=0, HasMountingBolts=true, GuidePoint=false, Light=true);
// CRBBm_OuterBearingRetainer(Light=true);
// rotate([180,0,0]) CRBBm_MagnetBracket();
// rotate([180,0,0]) CRBBm_TriggerPost();
// Custom_CRBBm_Activator();
//
// *** Fin Can ***
//
// rotate([180,0,0]) R102UL_MotorTubeTopper();
// FinCan(LowerHalfOnly=false, UpperHalfOnly=false);
// rotate([0,0,90]) RocketFin(HasSpiralVaseRibs=true);
// FinCanBase();
//
// *** Doors ***
//
// EBayDoor(OD=Body_OD*CF_Comp+Vinyl_d);
// EBayDoor2(OD=Body_OD*CF_Comp+Vinyl_d);
//
// BoosterPetalHub();
// rotate([180,0,0]) BoosterMotorTubeTopper();
// BoosterFinCan(LowerHalfOnly=false, UpperHalfOnly=false);
// rotate([0,0,90]) BoosterFin(HasSpiralVaseRibs=true);
//
// rotate([90,0,0]) BoltOnRailGuide(Length = R102_RailGuideLen, BoltSpace=12.7, RoundEnds=true);
// rotate([-90,0,0]) RailGuideSpacer(OD=Body_OD, H=RailGuide_h, Length = R102_RailGuideLen, BoltSpace=12.7);
//
//  *** Tools ***
//
// BodyDrillingJig(Tube_OD=Body_OD, Tube_ID=Body_ID, nBolts=5, BoltInset=7.5);
// BodyDrillingJig(Tube_OD=Body_OD*CF_Comp+Vinyl_d, Tube_ID=Body_ID, nBolts=6, BoltInset=10);
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
// ShowBooster(ShowInternals=false);
// ShowBooster(ShowInternals=true);
//
// ShowBooster(ShowInternals=false); translate([0,0,BCan_Len+BoosterBodyTubeLen]) ShowRocket(ShowInternals=false);
// ShowBooster(ShowInternals=true); translate([0,0,BCan_Len+BoosterBodyTubeLen]) ShowRocket(ShowInternals=true);
//
// ***********************************
include<TubesLib.scad>
use<R102ULLib.scad>			echo(R102ULLibRev());
use<FinCan2Lib.scad> 		echo(FinCan2LibRev());
use<AT_RMS_Lib.scad>		echo(AT_RMS_Lib_Rev());
use<RailGuide.scad>			echo(RailGuideRev());
use<Fins.scad>				echo(FinsRev());
use<NoseCone.scad>			echo(NoseConeRev());
use<SpringThingBooster.scad> echo(SpringThingBoosterRev());
use<PetalDeploymentLib.scad> echo(PetalDeploymentLibRev());
use<SpringEndsLib.scad>		echo(SpringEndsLibRev());
use<CableReleaseBBMini.scad> echo(CableReleaseBBMiniRev());
use<BatteryHolderLib.scad>	echo(BatteryHolderLibRev());
use<DoorLib.scad>			echo(DoorLibRev());
use<ThreadLib.scad>			echo(ThreadLibRev());
use<HD0411MGServoLib.scad>


include<Stager75BBLib.scad>

Default_nLocks=3;
DefaultBody_OD=ULine102Body_OD;
DefaultBody_ID=ULine102Body_ID;
DefaultMotorTube_OD=BT54Body_OD;
DefaultServo=1;
MainBearing_OD=Bearing6809_OD;
MainBearing_ID=Bearing6809_ID;
MainBearing_T=Bearing6809_T;

//also included
 //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;
Bolt10Inset=5.5;

LockPin_d=16;
LockPin_Len=25;
CR_Ball_d=5/16*25.4;
nCR_Balls=3;

nFins=5;

Fin_Post_h=15;
Fin_Root_L=150;
Fin_Root_W=10;
Fin_Tip_W=2.0;
Fin_Tip_L=90;
Fin_Span=110;
Fin_TipOffset=20;
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
BodyTubeAnnulus=0.6; // for sliders
Coupler_OD=BT98Body_OD; // fits tight
Coupler_ID=BT98Body_ID;

// *** 54mm Motor Tube ***
MotorTube_OD=BT54Body_OD;
MotorTube_ID=BT54Body_ID;
MotorTubeLen=250;

BMotorTube_OD=BT54Body_OD;
BMotorTube_ID=BT54Body_ID;
BMotorTubeLen=250; //length of 54/852 case + a nut, was BCan_Len+50;

NC_Len=180;
NC_Base_L=6;
NC_Tip_r=8;
NC_Wall_t=1.8;
nNC_Bolts=6;

nEBayBolts=5;
EBayBoltInset=7.5;

ForwardPetalLen=200;
BoosterPetal_Len=80;

ForwardTubeLen=310;
BodyTubeLen=150;
BoosterBodyTubeLen=304; // 260 min

Bolt4Inset=4;
nLockBalls=6;
nPetals=3;
nRopes=6;
TailCone_Len=65;
RailGuide_h=Body_OD/2+2;
R102_RailGuideLen=30;

echo(ForwardTubeLen=ForwardTubeLen);
echo(BodyTubeLen=BodyTubeLen);
echo(MotorTubeLen=MotorTubeLen);

echo(BoosterBodyTubeLen=BoosterBodyTubeLen);
echo(BMotorTubeLen=BMotorTubeLen);

Thread1024_d=0.190*25.4; // 10-24 NC
Thread1024_p=25.4/24;
Thread25020_d=0.250*25.4; // 1/4-20 NC
Thread25020_p=25.4/20;
Thread31218_d=5/16*25.4; // 5/16-18 NC
Thread31218_p=25.4/18;

module ShowRocket(ShowInternals=false){
	FinCan_Z=0;
	Fin_Z=FinCan_Z+Fin_Root_L/2+FinInset_Len;
	BodyTube_Z=FinCan_Z+Can_Len+Overlap*2;
	//AftTubeEnd_Z=BodyTube_Z+BodyTubeLen+10;
	//AftBallLock_Z=BodyTube_Z+BodyTubeLen+9;
	//EBay_Z=AftBallLock_Z+24.5;
	FwdBallLock_Z=BodyTube_Z+BodyTubeLen+13;
	FwdTubeEnd_Z=FwdBallLock_Z+0.2;
	ForwardTube_Z=FwdTubeEnd_Z+10;
	NoseCone_Z=ForwardTube_Z+ForwardTubeLen+0.2;
	
	//*
	translate([0,0,NoseCone_Z]) {
		color("Orange") NoseCone();
		
		if (ShowInternals){
			translate([0,0,-3.1]) color("Tan") SustainerNoseConeBaseTop();
			translate([0,0,-3.1-15.1]) color("LightGreen") SustainerNoseConeBase();
			}
	}
								
	if (ShowInternals) translate([0,0,NoseCone_Z-60])
		LightSpringSlider(OD=Body_ID-BodyTubeAnnulus, Len=30);
	
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
		my_BallRetainerTop();
	/**/
	
	//*
	if (!ShowInternals) translate([0,0,ForwardTube_Z]) color("LightBlue") 
		Tube(OD=Body_OD, ID=Body_ID, 
			Len=ForwardTubeLen-Overlap*2, myfn=$preview? 90:360);
	/**/
	
	if (ShowInternals) translate([0,0,MotorTubeLen+12]) 
		color("Gray") //MotorTubeTopper(Body_ID=Body_ID, MotorTube_OD=MotorTube_OD, MotorTube_ID=MotorTube_ID, nRopes=0);
			BoosterMotorTubeTopper(Body_ID=Body_ID, MotorTube_OD=MotorTube_OD, MotorTube_ID=MotorTube_ID, HasCenterBoltHole=false, CR_t=3);
			
	if (!ShowInternals)
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
	
	if (ShowInternals) translate([0,0,12]) ATRMS_54_427_Motor(HasEyeBolt=false);
	
	translate([0,0,FinCan_Z-0.2]) color("Orange") rotate([180,0,0]) FinCanBase();
	
} // ShowRocket

//ShowRocket();
//ShowRocket(ShowInternals=true);


module ShowBooster(ShowInternals=false){
	MotorTube_Z=0;
	MTubeToper_Z=MotorTube_Z+BMotorTubeLen;
	CR_Z=MTubeToper_Z+44.2+6;
	FinCan_Z=0;
	Fin_Z=FinCan_Z+BFin_Root_L/2+BFinInset_Len;
	BodyTube_Z=FinCan_Z+BCan_Len+Overlap*2;
	
	PetalHub_Z=BodyTube_Z+BoosterBodyTubeLen-30;
	
	if (!ShowInternals)
		translate([0,0,BodyTube_Z]) color("LightBlue") 
			Tube(OD=Body_OD, ID=Body_ID, Len=BoosterBodyTubeLen-Overlap*2, myfn=$preview? 90:360);

	if (ShowInternals)
		translate([0,0,PetalHub_Z]){
			rotate([180,0,0]) BoosterPetalHub();
			
			translate([0,0,-10]) rotate([180,0,0]) 
				PD_Petals(OD=Body_ID-BodyTubeAnnulus, Len=BoosterPetal_Len, nPetals=nPetals, Wall_t=1.8, 
							AntiClimber_h=4, HasLocks=true, Lock_Span_a=30);
				
			translate([0,0,-10-BoosterPetal_Len-2.6]) rotate([180,0,0]) 
				R102_FwdSpringEnd(OD=Body_ID-1, ID=Body_ID-3.6, LockPin_d=16, nRopes=6, Skirt_h=35, HasServoConnector=false);
		}
	
	if (ShowInternals) translate([0,0,CR_Z]) ShowCableRelease();
	
	if (ShowInternals) translate([0,0,MTubeToper_Z])
		BoosterMotorTubeTopper(MotorTube_OD=MotorTube_OD, MotorTube_ID=MotorTube_ID);
	
	translate([0,0,FinCan_Z]) color("White") BoosterFinCan();
	
	//*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j+180/nFins])
		translate([0,Body_OD/2-BFin_Post_h, Fin_Z]) 
			rotate([-90,0,0]) color("Orange") BoosterFin();
	/**/
	
	if (ShowInternals) translate([0,0,MotorTube_Z]) color("Blue") 
		Tube(OD=BMotorTube_OD, ID=BMotorTube_ID, Len=BMotorTubeLen, myfn=90);
		
	//if (ShowInternals) translate([0,0,MotorTube_Z]) ATRMS_54_427_Motor(HasEyeBolt=false);
	if (ShowInternals) translate([0,0,MotorTube_Z]) ATRMS_54_852_Motor(HasEyeBolt=false);
	
	//translate([0,Body_OD/2,BodyTube_Z]) cylinder(d=2,h=34);
} // ShowBooster

// ShowBooster(ShowInternals=true);

// ShowBooster(ShowInternals=false);
// translate([0,0,BCan_Len+BoosterBodyTubeLen]) ShowRocket(ShowInternals=true);


module ShowCableRelease(){
	CRBBm_LockPinExtensionEnd(); // Presses onto 5/16" OD Aluminum tube.
	
	CRBBm_CenteringRingMount(OD=Body_ID-BodyTubeAnnulus, Thickness=8, Spring_OD=SE_Spring_CS4323_OD(), Spring_ID=SE_Spring_CS4323_ID());
	
	translate([0,0,-LockPin_Len+12]) {
		CRBBm_LockingPin(LockPin_d=LockPin_d, LockPin_Len=LockPin_Len, GuidePoint=false);

		CRBBm_LockRing(LockPin_d=LockPin_d, Ball_d=CR_Ball_d, nBalls=nCR_Balls, GuidePoint=false, Light=true);
		CRBBm_TopRetainer(LockPin_d=LockPin_d, nBalls=nCR_Balls, LockRing_d=CRBBm_LockRingDiameter(), 
			Flange_t=4, OD=0, HasMountingBolts=true, GuidePoint=false, Light=true);
		translate([0,0,-19.2]) rotate([0,0,120]) CRBBm_OuterBearingRetainer(Light=true);
		
		translate([0,0,-22]) rotate([0,0,60]) Custom_CRBBm_ActivatorPS();
		
		translate([0,0,-19]) rotate([0,0,-120]) CRBBm_MagnetBracket();
		translate([0,0,-19]) rotate([0,0,-160]) CRBBm_TriggerPost();
	}

} // ShowCableRelease

// ShowCableRelease();

module NoseCone(){
	Shoulder_OD=Coupler_OD;
	
	BluntOgiveNoseCone(ID=Shoulder_OD, OD=Body_OD*CF_Comp+Vinyl_d, L=NC_Len, Base_L=NC_Base_L, Tip_R=NC_Tip_r, Wall_T=NC_Wall_t,
		Cut_d=0, LowerPortion=false, nRivets=0, FillTip=true);
		
	difference(){
		PD_PetalHubBoltPattern(OD=Shoulder_OD, nBolts=nNC_Bolts) hull(){
			cylinder(d=7, h=NC_Base_L);
			translate([0,4.5,0]) scale([1,0.2,1]) cylinder(d=9, h=NC_Base_L);
		}
		
		PD_PetalHubBoltPattern(OD=Shoulder_OD, nBolts=nNC_Bolts) rotate([180,0,0]) Bolt4Hole();					
	} // difference
} // StubbyNoseCone

// NoseCone();

module SustainerNoseConeBaseTop(){
	Spring_OD=SE_Spring_CS4323_OD();
	Spring_ID=SE_Spring_CS4323_ID();
	OD=Body_ID;
	CR_t=3;
	nBolts=6;
	myfn=floor(OD)*2;
	Al_Tube_d=12.7;
	Al_Tube_Len=70;
	Al_Tube_H=10;
	nRopes=6;
	Rope_d=3;
	
	module FW_GPS_Mount(){
		Boss_d=10;
		
		module Boss(){
			difference(){
				rotate([-90,0,0]) cylinder(d1=7,d2=Boss_d,h=6);
					
				rotate([90,0,0]) Bolt4Hole();
			} // difference
		} // Boss
		
		// Backing plate
		
		Boss_Y=2;
		Boss_Z=13.5;
		difference(){
			union(){
				hull(){
					translate([-4,6,-8]) cube([20.4+8,3,42+12]);
					translate([-4,6,-8]) cube([20.4+8,10,1]);
				} // hull
				
				translate([4,Boss_Y,Boss_Z])Boss();
				translate([4,Boss_Y,Boss_Z])translate([12.7,0,25.4]) Boss();
			} // union
			
			translate([4,Boss_Y,Boss_Z]) rotate([90,0,0]) Bolt4Hole(depth=20);
			translate([4,Boss_Y,Boss_Z]) translate([12.7,0,25.4]) rotate([90,0,0]) Bolt4Hole();
		} // difference
		
	} // FW_GPS_Mount
	
	
	rotate([0,0,30]) translate([28,-28,11]) rotate([0,0,60]) rotate([-10,0,0])  FW_GPS_Mount();

	module FW_GPS_Batt_Mount(){
		Batt_X=25;
		Batt_Y=5;
		Batt_Z=37;
		Wall_t=2.4;
		
		difference(){
			union(){
				cube([Batt_X+Wall_t*2, Batt_Y+Wall_t*2, Batt_Z+Wall_t*2], center=true);
				//*
				hull(){
					translate([0,Batt_Y/2+Wall_t,Batt_Z/2+Wall_t/2]) 
						cube([10,Overlap,Wall_t],center=true);
					translate([0,Batt_Y/2+Wall_t+6,-Batt_Z/2-Wall_t]) 
						cube([10,12,Overlap],center=true);
				} // hull
				/**/
			} // union
			
			cube([Batt_X, Batt_Y, Batt_Z], center=true);
			
			// Wire Path
			hull(){
				cylinder(d=Batt_Y, h=Batt_Z);
				translate([0,-5,0]) cylinder(d=Batt_Y, h=Batt_Z);
			} // hull
			
			//ty-wrap
			translate([0,Batt_Y/2+Wall_t+2,0]) 
				rotate([0,90,0]) cylinder(d=4, h=Batt_X+Wall_t*2+Overlap, center=true);
			translate([0,-Batt_Y/2-2.4,0]) 
				rotate([0,90,0]) cylinder(d=4, h=Batt_X+Wall_t*2+Overlap, center=true);
			
			translate([0, -5, 5]) cube([Batt_X, Batt_Y, Batt_Z], center=true);
			translate([0, -3, 5]) cube([Batt_X, Batt_Y+1, Batt_Z-10], center=true);
			translate([0, -3, 0]) cube([Batt_X, Batt_Y, Batt_Z-10], center=true);
		} // difference
		
	} // FW_GPS_Batt_Mount

	
	difference(){
		union(){
			cylinder(d=OD, h=CR_t, $fn=myfn);
			
			hull(){
				translate([0,0,Al_Tube_H]) rotate([90,0,0]) cylinder(d=Al_Tube_d+6, h=Al_Tube_Len, center=true);
				translate([0,0,CR_t]) cube([Al_Tube_d+8, Al_Tube_Len, 1], center=true);
			} // hull
			
			rotate([0,0,145]) translate([23,17,22]) rotate([0,0,125]) FW_GPS_Batt_Mount();

		} // union
		
		for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j])
			translate([0,OD/2-10,-Overlap]) cylinder(d=Rope_d, h=CR_t+Overlap*2);
		
		translate([0,0,Al_Tube_H]) rotate([90,0,0]) cylinder(d=Al_Tube_d+IDXtra, h=Al_Tube_Len+Overlap*2, center=true);
		
		translate([0,0,-Overlap]) cylinder(d=Spring_OD, h=40);
		
		// nosecone bolt holes
		PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=nBolts) rotate([180,0,0]) Bolt4ClearHole(depth=8);
	} // difference
} // SustainerNoseConeBaseTop

// SustainerNoseConeBaseTop();

module SustainerNoseConeBase(Len=15){
	Spring_OD=SE_Spring_CS4323_OD();
	Spring_ID=SE_Spring_CS4323_ID();
	SpringStop_Z=10;
	nBolts=6;
	nTubeBolts=6;
	OD=Body_ID-IDXtra;
	myfn=floor(OD)*2;
	Wall_t=2.2;
	CR_t=6;
	nSpokes=6;
	Spoke_t=1.2;
	NC_Bolt_a=0;
	
	
	// Spokes
	for (j=[0:nSpokes-1]) rotate([0,0,360/nSpokes*j-15]) 
		hull(){
			translate([0,OD/2-Spoke_t/2,0]) cylinder(d=Spoke_t, h=Len);
			translate([0,Spring_OD/2+2,0]) cylinder(d=Spoke_t, h=Len);
		} // hull
	
	
		difference(){
			union(){
				// Outer ring
				Tube(OD=OD, ID=OD-Wall_t*2, Len=Len, myfn=$preview? 90:180);
				
				cylinder(d=Spring_OD+4, h=Len);
				
				
				translate([0,0,Len-CR_t]) rotate([0,0,NC_Bolt_a])
					PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=nBolts)
						hull(){
							cylinder(d=8, h=CR_t);
							translate([0,3,0]) scale([1,0.1,1]) cylinder(d=9, h=CR_t);
						} // hull
			} // union
			
			// tube bolt holes
			for (j=[0:nTubeBolts-1]) rotate([0,0,360/nTubeBolts*j+15])
				translate([0,OD/2+1,Len-7.5]) rotate([-90,0,0]) Bolt4Hole();
			
			// center hole
			translate([0,0,-Overlap]) cylinder(d=Spring_ID, h=Len+Overlap*2);
			
			// Spring
			translate([0,0,-Overlap]) cylinder(d1=Spring_OD+1, d2=Spring_OD, h=SpringStop_Z-3);
			cylinder(d=Spring_OD, h=SpringStop_Z);
			translate([0,0,SpringStop_Z+1]) cylinder(d1=Spring_ID, d2=Spring_OD+2, h=Len-SpringStop_Z-1+Overlap);
			
			// nosecone bolt holes
			translate([0,0,Len-CR_t]) rotate([0,0,NC_Bolt_a])
				PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=nBolts) rotate([180,0,0]) Bolt4HeadHole(depth=8);
		} // difference
} // SustainerNoseConeBase

// rotate([180,0,0]) SustainerNoseConeBase();

module TubeDrillingTemplate(Tube_OD=Body_OD*CF_Comp+Vinyl_d, nBolts=5, RailGuide_Z=74.5){
	Wall_t=1.2;
	H=(RailGuide_Z==0)? 15:RailGuide_Z+12.7+5;
	
	difference(){
		Tube(OD=Tube_OD+IDXtra+Wall_t*2, ID=Tube_OD+IDXtra, Len=H, myfn=$preview? 90:180);
		
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) translate([0,Tube_OD/2,7.5])
			rotate([-90,0,0]) cylinder(d=3, h=10);
			
		if (RailGuide_Z!=0) rotate([0,0,180/nBolts]){
			translate([0,Tube_OD/2,RailGuide_Z]) rotate([-90,0,0]) cylinder(d=3, h=10);
			translate([0,Tube_OD/2,RailGuide_Z+12.7]) rotate([-90,0,0]) cylinder(d=3, h=10);
		}
	} // difference
} // TubeDrillingTemplate

// TubeDrillingTemplate();

module StubbyNoseConeBase(Len=20){
	// for booster test
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

module LightSpringSlider(OD=Body_ID-BodyTubeAnnulus, Len=30){
	Wall_t=1.2;
	Spring_OD=SE_Spring_CS4323_OD();
	Spring_ID=SE_Spring_CS4323_ID();
	ID=Spring_OD+IDXtra*2;
	SpringInset=8;
	nSpokes=6;
	Spoke_t=Wall_t;
	
	module SpringStop(){
		difference(){
			Tube(OD=ID+Wall_t*2, ID=Spring_ID, Len=8, myfn=90);
			translate([0,0,3]) cylinder(d1=Spring_ID-Overlap, d2=ID+Overlap, h=5+Overlap);
		} // difference
	} // SpringStop
	
	Tube(OD=OD, ID=OD-Wall_t*2, Len=Len, myfn=$preview? 90:180);
	Tube(OD=ID+Wall_t*2, ID=ID, Len=Len, myfn=90);
	for (j=[0:nSpokes-1]) rotate([0,0,360/nSpokes*j]) 
		hull(){
			translate([0,OD/2-Spoke_t/2,0]) cylinder(d=Spoke_t, h=Len);
			translate([0,ID/2+Spoke_t/2,0]) cylinder(d=Spoke_t, h=Len);
		} // hull
	translate([0,0,SpringInset]) SpringStop();
	translate([0,0,Len-SpringInset]) rotate([180,0,0]) SpringStop();
} // LightSpringSlider

// LightSpringSlider();

module my_BallRetainerTop(){

 STB_BallRetainerTop(Body_ID=Body_ID, Outer_OD=Body_OD*CF_Comp+Vinyl_d, Engagement_d=Body_ID, nLockBalls=nLockBalls,
			HasIntegratedCouplerTube=true, nBolts=5,
			IntegratedCouplerLenXtra=-20,
				
			HasSecondServo=true,
			UsesBigServo=true,
			Engagement_Len=20, HasLargeInnerBearing=true, Xtra_r=0.2);
} // my_BallRetainerTop

module MotorTubeTopper(Body_ID=Body_ID, MotorTube_OD=MotorTube_OD, MotorTube_ID=MotorTube_ID, nRopes=6){
// Z zero is top of motor tube
// Sits on top of motor tube
// Has Rail Guide bolt holes
// Has centering ring
	
	Rope_d=4;
	RopeHoleBC_r=(MotorTube_OD+8)/2+Rope_d/2+1;
	
	Bottom=21;
	OuterWall_t=1.6;
	myfn=floor(Body_ID)*2;
	mySmallfn=floor(MotorTube_OD)*2;
	
	nSpokes=6;
	Spoke_t=1.2;
	CR_t=5;
	
	difference(){
		union(){
			translate([0,0,-Bottom]) 
				Tube(OD=MotorTube_OD+IDXtra*2+OuterWall_t*2, ID=MotorTube_OD+IDXtra*2, Len=Bottom+1, myfn=$preview? 36:mySmallfn);
			translate([0,0,-Bottom]) 
				Tube(OD=Body_ID, ID=Body_ID-OuterWall_t*2, Len=Bottom+1, myfn=$preview? 36:myfn);
			
			CenteringRing(OD=Body_ID, ID=MotorTube_ID, Thickness=CR_t, nHoles=0, Offset=0, myfn=$preview? 90:myfn);
							
			hull(){
				translate([0,Body_ID/2-1,0]) rotate([90,0,0]) cylinder(d=10, h=20);
				translate([0,Body_ID/2-1,-Bottom+5]) rotate([90,0,0]) cylinder(d=10, h=20);
			}
			
			translate([0,0,-Bottom]) for (j=[1:nSpokes-1]) rotate([0,0,360/nSpokes*j])
				hull(){
					translate([0,MotorTube_OD/2+IDXtra+Spoke_t,0]) cylinder(d=Spoke_t, h=Bottom+1);
					translate([0,Body_ID/2-Spoke_t,0]) cylinder(d=Spoke_t, h=Bottom+1);
				} // hull
		} // union
	
		translate([0,0,-Bottom-Overlap]) cylinder(d=MotorTube_OD+IDXtra*3, h=Bottom, $fn=$preview? 36:mySmallfn);
		translate([0,0,-Bottom-Overlap]) cylinder(d=MotorTube_ID, h=Bottom+5+Overlap*2, $fn=$preview? 36:mySmallfn);
				
		translate([0, Body_OD/2, -Bottom+5+6.35]) {
			translate([0,0,6.35]) rotate([-90,0,0]) Bolt6Hole(depth=Body_OD/2);
			translate([0,0,-6.35]) rotate([-90,0,0]) Bolt6Hole(depth=Body_OD/2);
		}
		
		// Rope holes
		if (nRopes>0)
			for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j]) // +180/nRopes
				translate([0,RopeHoleBC_r,-Overlap]) cylinder(d=Rope_d, h=5+Overlap*2);
		
	} // difference

} // MotorTubeTopper

// rotate([180,0,0]) MotorTubeTopper(Body_ID=Body_ID, MotorTube_OD=MotorTube_OD, MotorTube_ID=MotorTube_ID, nRopes=0);

module BoosterMotorTubeTopper(Body_ID=Body_ID, MotorTube_OD=MotorTube_OD, MotorTube_ID=MotorTube_ID, HasCenterBoltHole=true, CR_t=5){
// Z zero is top of motor tube
// Sits on top of motor tube
// Has Rail Guide bolt holes
// Has centering ring
	
	Rope_d=4;
	RopeHoleBC_r=(MotorTube_OD+8)/2+Rope_d/2+1;
	
	Bottom=21;
	OuterWall_t=1.6;
	myfn=floor(Body_ID)*2;
	mySmallfn=floor(MotorTube_OD)*2;
	SpokeEnd_Y=HasCenterBoltHole? 0:MotorTube_OD/2;
	
	nSpokes=8;
	Spoke_t=1.2;
	

	difference(){
		union(){
			translate([0,0,-Bottom]) 
				Tube(OD=MotorTube_OD+IDXtra*2+OuterWall_t*2, ID=MotorTube_OD+IDXtra*2, Len=Bottom+CR_t, myfn=$preview? 36:mySmallfn);
			translate([0,0,-Bottom]) 
				Tube(OD=Body_ID, ID=Body_ID-OuterWall_t*2, Len=Bottom+CR_t, myfn=$preview? 36:myfn);
				
			if (!HasCenterBoltHole)
				Tube(OD=MotorTube_OD+1, ID=MotorTube_ID, Len=CR_t, myfn=$preview? 36:myfn);
				
			// Rail guide boss
			hull(){
				translate([0,Body_ID/2-1, CR_t-5]) rotate([90,0,0]) cylinder(d=10, h=20);
				translate([0,Body_ID/2-1,-Bottom+5]) rotate([90,0,0]) cylinder(d=10, h=20);
			}
			
			if (HasCenterBoltHole) cylinder(d=18, h=CR_t);
			
			// Spokes
			translate([0,0,-Bottom]) for (j=[0:nSpokes-1]) rotate([0,0,360/nSpokes*j])
				hull(){
					translate([0,SpokeEnd_Y,0]) cylinder(d=Spoke_t, h=Bottom+CR_t);
					translate([0,Body_ID/2-Spoke_t,0]) cylinder(d=Spoke_t, h=Bottom+CR_t);
				} // hull
		} // union
	
		translate([0,0,-Bottom-Overlap]) cylinder(d=MotorTube_OD+IDXtra*2, h=Bottom+Overlap, $fn=$preview? 36:mySmallfn);
		translate([0,0,-Bottom-Overlap]) cylinder(d=5/16*25.4+IDXtra*2, h=Bottom+CR_t+Overlap*2, $fn=$preview? 36:mySmallfn);
			
		// Rail guide bolt holes
		translate([0, Body_OD/2, -Bottom+5+6.35]) {
			translate([0,0,6.35]) rotate([-90,0,0]) Bolt6Hole(depth=Body_OD/2);
			translate([0,0,-6.35]) rotate([-90,0,0]) Bolt6Hole(depth=Body_OD/2);
		}
		
	} // difference

} // BoosterMotorTubeTopper

// BoosterMotorTubeTopper();
// rotate([180,0,0]) BoosterMotorTubeTopper(Body_ID=Body_ID, MotorTube_OD=MotorTube_OD, MotorTube_ID=MotorTube_ID, HasCenterBoltHole=false, CR_t=3);

module FinCan(LowerHalfOnly=false, UpperHalfOnly=false){
	OD=Body_OD*CF_Comp+Vinyl_d;
	AltDoor_a=180+360/nFins*2;
	RocketServoDoor_a=180+360/nFins*3;
	Door_t=3.7;
	Door_Z=Can_Len/2;
	
	nBaseBolts=nFins*2;
				
	difference(){
		union(){
			FC2_FinCan(Body_OD=OD, Body_ID=Body_ID, Can_Len=Can_Len, 
						MotorTube_OD=MotorTube_OD, RailGuide_h=RailGuide_h, RailGuide_z=0,
						nFins=nFins,
						HasIntegratedCoupler=true, HasFwdCenteringRing=false, HasMidCenteringRing=false, Coupler_Len=15, nCouplerBolts=5,
						HasMotorSleeve=false, HasAftIntegratedCoupler=false,
						
						Fin_Root_W=Fin_Root_W, Fin_Root_L=Fin_Root_L, 
						Fin_Post_h=Fin_Post_h, Fin_Chamfer_L=Fin_Chamfer_L,
						
						Cone_Len=0, ThreadedTC=false, Extra_OD=0, RailGuideLen=R102_RailGuideLen,
						LowerHalfOnly=LowerHalfOnly, UpperHalfOnly=UpperHalfOnly, HasWireHoles=false, 
						HollowTailcone=false, HollowFinRoots=true, Wall_t=1.2,
						UseTrapFin3=true, AftClosure_OD=0, AftClosure_Len=0);
						
			CenteringRing(OD=Body_OD-1, ID=MotorTube_OD+1, Thickness=4, nHoles=0, Offset=0, myfn=$preview? 90:180);
						
		} // union
		
		//*
		translate([0,0,Door_Z]) rotate([0,0,AltDoor_a]) 
			DoorFrameHole(Door_X=BoosterEBayDoor_X, Door_Y=BoosterEBayDoor_Y, Door_t=Door_t, Tube_OD=OD);
		translate([0,0,Door_Z]) rotate([0,0,RocketServoDoor_a]) 
			DoorFrameHole(Door_X=BoosterEBayDoor_X, Door_Y=BoosterEBayDoor_Y, Door_t=Door_t, Tube_OD=OD);
		/**/
		
		// Base Bolt Holes
		for (j=[0:nBaseBolts-1]) rotate([0,0,360/nBaseBolts*j+180/nFins+180/nBaseBolts]) translate([0,OD/2-Bolt4Inset*2,0])
			rotate([180,0,0]) Bolt4Hole();
			
		 // Igniter wire hole
		 rotate([0,0,AltDoor_a+180]) translate([0, MotorTube_OD/2+10, -Overlap]) cylinder(d=8, h=20);
	} // difference
	
	if (!$preview)
		translate([0,0,Door_Z]) rotate([0,0,AltDoor_a]) 
			DoorFrame(Door_X=BoosterEBayDoor_X, Door_Y=BoosterEBayDoor_Y, Door_t=Door_t, Tube_OD=OD, 
					HasSixBolts=true, HasBoltBosses=true, BoltBoss_t=3.2);
					
	if (!$preview)
		translate([0,0,Door_Z]) rotate([0,0,RocketServoDoor_a]) 
			DoorFrame(Door_X=BoosterEBayDoor_X, Door_Y=BoosterEBayDoor_Y, Door_t=Door_t, Tube_OD=OD, 
					HasSixBolts=true, HasBoltBosses=true, BoltBoss_t=3.2);
						
} // FinCan

// FinCan(LowerHalfOnly=false, UpperHalfOnly=false);

module FinCanBase(){
	Len=12;
	OD=Body_OD*CF_Comp+Vinyl_d;
	nBaseBolts=nFins*2;
	
	difference(){
		union(){
			Tube(OD=Coupler_ID, ID=Coupler_ID-4.4, Len=Len, myfn=$preview? 90:180);
			
			difference(){
				cylinder(d=Body_ID-IDXtra, h=5, $fn=$preview? 90:180);
				translate([0,0,-Overlap]) cylinder(d=OD-Bolt4Inset*3, h=10, $fn=$preview? 90:180);
			} // difference
			
			// Base Bolt Bosses
			for (j=[0:nBaseBolts-1]) rotate([0,0,360/nBaseBolts*j+180/nFins+180/nBaseBolts]) translate([0,OD/2-Bolt4Inset*2,0])
			hull(){
				cylinder(d=8, h=6);
				translate([0,3,0]) scale([1,0.1,1]) cylinder(d=9, h=6);
			} // hull
			
		} // union
	
		
		
		// Base Bolt Holes
		for (j=[0:nBaseBolts-1]) rotate([0,0,360/nBaseBolts*j+180/nFins+180/nBaseBolts]) translate([0,OD/2-Bolt4Inset*2,7])
			Bolt4HeadHole();

	} // difference
	
} // FinCanBase

// FinCanBase();

module RocketFin(HasSpiralVaseRibs=false){
	
	TrapFin3(Post_h=Fin_Post_h, Root_L=Fin_Root_L, Tip_L=Fin_Tip_L, Root_W=Fin_Root_W,
				Tip_W=Fin_Tip_W, Span=Fin_Span, Chamfer_L=Fin_Chamfer_L,
				TipOffset=Fin_TipOffset,
				Bisect=false, Bisect_X=0,
				HasSpar=false, Spar_d=8, Spar_L=100,
				PrinterBrim_H=0.8, HasSpiralVaseRibs=HasSpiralVaseRibs);
				
	
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
					HasBolts=true,
					nBolts=6, // Same as nPetals
					ShockCord_a=-1,
					HasNCSkirt=false, 
						Body_OD=Coupler_OD,
						Body_ID=Coupler_ID,
						NC_Base=0, 
						SkirtLen=0, 
					CenterHole_d=0);
				
		// Shock cord hole
		rotate([0,0,60]){
			translate([0,Coupler_OD/2-8,-Overlap]) cylinder(d=8, h=6);
			translate([0,Coupler_OD/2-8,-Overlap]) cylinder(d=4, h=26);
		}
		
		// Servo wire
		translate([0,-Coupler_OD/2+8,-Overlap]) RoundRect(X=9, Y=3.5, Z=30, R=0.2);
	} // difference
					
	
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
		DoorFrame(Door_X=BoosterEBayDoor_X, Door_Y=BoosterEBayDoor_Y, 
					Door_t=Door_t, Tube_OD=OD, HasSixBolts=true, HasBoltBosses=true, BoltBoss_t=3.2);
	translate([0,0,BCan_Len/2]) rotate([0,0,RocketServoDoor_a]) 
		DoorFrame(Door_X=BoosterEBayDoor_X, Door_Y=BoosterEBayDoor_Y, 
					Door_t=Door_t, Tube_OD=OD, HasSixBolts=true, HasBoltBosses=true, BoltBoss_t=3.2);
						
	CenteringRing(OD=Body_OD-1, ID=BMotorTube_OD+1, Thickness=4, nHoles=0, Offset=0, myfn=$preview? 90:360);
} // BoosterFinCan

// BoosterFinCan(LowerHalfOnly=false, UpperHalfOnly=false);


module BoosterFin(HasSpiralVaseRibs=false){
	
	TrapFin3(Post_h=BFin_Post_h, Root_L=BFin_Root_L, Tip_L=BFin_Tip_L, Root_W=BFin_Root_W,
				Tip_W=BFin_Tip_W, Span=BFin_Span, Chamfer_L=BFin_Chamfer_L,
				TipOffset=BFin_TipOffset,
				Bisect=false, Bisect_X=0,
				HasSpar=false, Spar_d=8, Spar_L=100,
				PrinterBrim_H=0.8, HasSpiralVaseRibs=HasSpiralVaseRibs);
	
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

// translate([0,0,BCan_Len/2]) rotate([0,0,72*2]) translate([0,1,0]) color("Tan") rotate([90,0,0]) EBayDoor();
// BoosterFinCan(LowerHalfOnly=false, UpperHalfOnly=false);

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

module EBayDoor3(OD=Body_OD*CF_Comp+Vinyl_d){
	// Rocket Servo Rev C x2
	// WIP
	
	Door_t=3.0;
	DoorFace_Y=OD/2;
	BattPocket_Y=-0.2;
	MagSw_Y=-3;
	BlueRaven_Y=8;
	
	
	difference(){
		union(){
			translate([0,DoorFace_Y-10,-5])
				translate([-2,-2,10]) rotate([-90,0,110]) RocketServoHolderRevC(IsDouble=false, HasBackHoles=false);
				
			translate([0,DoorFace_Y-10,-5])
				translate([2,-2,10]) rotate([-90,0,250]) RocketServoHolderRevC(IsDouble=false, HasBackHoles=false);
			
			rotate([0,0,180]) Door(Door_X=BoosterEBayDoor_X, Door_Y=BoosterEBayDoor_Y, Door_t=Door_t, Tube_OD=OD, HasSixBolts=true, HasBoltHoles=true);
		} // union
		
		// LED hole
		translate([0,0,-35]) rotate([-90,0,0]) cylinder(d=3,h=OD/2+1);
		
		// Rocket servo bolts
		//translate([0,DoorFace_Y-10,-5]) translate([0,8,10]) rotate([-90,0,180]) 
		//	RocketServoRevCBoltPattern() Bolt4Hole();
		
		//translate([0,DoorFace_Y-10,-5]) translate([13.5,MagSw_Y,20]) rotate([90,0,90]) FW_MagSw_BoltPattern() Bolt4Hole(depth=5);
	} // difference
	//
	Tube(OD=Body_OD, ID=Coupler_ID, Len=5, myfn=$preview? 90:360);
	//
	Tube(OD=MotorTube_OD, ID=MotorTube_ID, Len=5, myfn=$preview? 90:360);
} // EBayDoor3

//EBayDoor3(OD=Body_OD*CF_Comp+Vinyl_d);

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


module Custom_CRBBm_ActivatorPS(OD=ULine102Body_ID-0.6, Thread_d=5/16*25.4, Thread_p=25.4/18){
// *** A shorter parallel servo version ***
	Plate_t=10;
	Plate_d=CRBBm_BottomBoltCircle_d()+Bolt4Inset*2+2;
	Ring_h=8;
	Ring_t=2;
	Wall_t=1.2;
	
	Magnet_d=3/16*25.4;
	Magnet_Z=-3-Magnet_d/2;
	Magnet_a=180;
	
	Servo_Z=10;
	Servo_X=-8;
	Servo_Y=CRBBm_LockRingBoltCircle_d()/2+10;
	ServoRot_a=200;
	ServoPos_a=-80;

	Ring_Z=-10;
	
	
	
	module TopMountingBolts(){
		nBolts=3;
		
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j])
			translate([0,CRBBm_BottomBoltCircle_d()/2,1.6])
				rotate([180,0,0]) Bolt4HeadHole(depth=Plate_t+8,lHead=Plate_t+12);
	} // TopMountingBolts
	
	module MagnetHole(){
		translate([-1.5,0,Magnet_Z]) rotate([0,90,0]) cylinder(d=Magnet_d, h=7, center=true);
	} // MagnetHole
	
	module MagnetPost(){
		H=-Magnet_Z+3;
		W=3.5;
		
		
		rotate([0,0,Magnet_a])
		translate([W,0,0])
		difference(){
			hull(){
				translate([-1.5,CRBBm_BottomBoltCircle_d()/2+5,Ring_Z]) cylinder(d=W, h=H);
				translate([-1.5,CRBBm_LockRingBoltCircle_d()/2+4,Ring_Z]) cylinder(d=W, h=H);
				translate([-1.5,OD/2-1.8,Ring_Z]) cylinder(d=W, h=6);
			} // hull
			
			translate([W-2,CRBBm_LockRingBoltCircle_d()/2,0]) MagnetHole();
		} // difference
	} // MagnetPost
	
	MagnetPost();
		
	module Spoke(Outer_a=0, Inner_a=0){
		hull(){
			rotate([0,0,Inner_a]) translate([0,Plate_d/2-1.2,Ring_Z]) cylinder(d=1.2, h=Ring_h);
			rotate([0,0,Outer_a]) translate([0,OD/2-Ring_t,Ring_Z]) cylinder(d=1.2, h=Ring_h);
		} // hull
	} // Spoke
	
	// Spokes
	Spoke_a=[0,45,90,135,225]; // 342+ServoPos_a
	for (j=Spoke_a) Spoke(Outer_a=j, Inner_a=j);
		
	// Servo mounts
	//275,283,290,329,337,345
	Spoke(Outer_a=359+ServoPos_a, Inner_a=315+ServoPos_a);
	Spoke(Outer_a=9+ServoPos_a, Inner_a=315+ServoPos_a);
	Spoke(Outer_a=41+ServoPos_a, Inner_a=80+ServoPos_a);
	Spoke(Outer_a=46+ServoPos_a, Inner_a=80+ServoPos_a);
	Spoke(Outer_a=52+ServoPos_a, Inner_a=80+ServoPos_a);
	

	difference(){
		union(){
			translate([0,0,-Plate_t]) CRBBm_BlankInnerBearingRetainer(H=Plate_t+8, HasCenterHole=true, Light=true);
			translate([0,0,-Plate_t]) cylinder(d=Thread_d+4.4, h=Plate_t+8);
			
			difference(){
				rotate([0,0,ServoPos_a]) translate([Servo_X,Servo_Y,Servo_Z])
					rotate([180,0,ServoRot_a]) ServoHD0411MGTopBlock(Xtra_Len=5, Xtra_Width=-Overlap, Xtra_Height=15.4);
					//ServoSG90TopBlock(Xtra_Len=4, Xtra_Width=-Overlap, Xtra_Height=20, HasWireNotch=false);
				
				rotate([0,0,ServoPos_a]) translate([Servo_X,Servo_Y,Ring_Z-Overlap]) rotate([0,0,ServoRot_a]) 
					translate([-12.5+6,-10,0]) cube([24.5,20,18]);
			} // difference
			
		} // union
		
		rotate([0,0,ServoPos_a]) translate([Servo_X,Servo_Y,Servo_Z]) translate([0,0,10])
			hull(){
				cylinder(d=9, h=8);
				translate([0,3,0]) cylinder(d=14, h=8);
			} // hull
		
		TopMountingBolts();
		
		// center hole
		translate([0,0,-Plate_t-Overlap]){

			translate([0,0,-Overlap])
					cylinder(d1=Thread_d+2, d2=Thread_d, h=2);
			if ($preview){
				cylinder(d=Thread_d, h=Plate_t+8+Overlap*2); 
			}else{
				ExternalThread(Pitch=Thread_p, Dia_Nominal=Thread_d+IDXtra*2, 
						Length=Plate_t+8+Overlap*2, 
						Step_a=2,TrimEnd=true,TrimRoot=true);
			}}
	} // difference
		
	translate([0,0,Ring_Z])
		Tube(OD=OD, ID=OD-4, Len=8, myfn=$preview? 90:180);
	
	/*
	if ($preview){
		rotate([0,0,ServoPos_a]) translate([Servo_X,Servo_Y,Servo_Z]) color("Red") {
			rotate([180,0,ServoRot_a]) ServoHD0411MG(TopMount=false, HasGear=false);
			cylinder(d=7, h=20);
			}
		//translate([0,0,Servo_Z+3]) cylinder(d=Body_ID, h=1);
	}
	/**/
} // Custom_CRBBm_ActivatorPS

// translate([0,0,-LockPin_Len+12-21.5]) Custom_CRBBm_ActivatorPS();
// rotate([0,0,-60]) ShowCableRelease();

module R102_FwdSpringEnd(OD=Body_ID-BodyTubeAnnulus, ID=Body_ID-3.6, LockPin_d=16, nRopes=6, Skirt_h=35, HasServoConnector=false, Spring_Z=5){
// This locks onto the bottom of the petals.
	CR_t=2;
	Rope_d=3;
	Spring_OD=SE_Spring_CS4323_OD();
	Spring_ID=SE_Spring_CS4323_ID();

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


module Stager_Cup_Light(Collar_H=17){
	OD=Body_OD*CF_Comp+Vinyl_d;
	nBaseBolts=nFins*2;
	BaseBolts=[36,72,108,144,180,216,252,288,324];
	Bolt_a=0;

	difference(){
		union(){
			Stager_Cup(Tube_OD=OD, nLocks=Default_nLocks, BoltsOn=false, Collar_h=Collar_H);
			
			// Base Bolt Bosses
			for (j=BaseBolts) rotate([0,0,j+Bolt_a]) translate([0,OD/2-Bolt4Inset*2,Collar_H-3])
				hull(){
					cylinder(d=8, h=6);
					translate([0,3,0]) scale([1,0.1,1]) cylinder(d=9, h=6);
				} // hull
				
		} // union

		translate([0,0,-4]) cylinder(d=Body_ID-10, h=10, $fn=180);
		translate([0,0,4]) cylinder(d1=Body_ID-10, d2=Body_ID-7, h=6, $fn=180);
		translate([0,0,10-Overlap]) cylinder(d=Body_ID-7, h=Collar_H-11, $fn=180);

		// Base Bolt Holes
		for (j=BaseBolts) rotate([0,0,j+Bolt_a]) translate([0,OD/2-Bolt4Inset*2,Collar_H-4])
			rotate([180,0,0]) Bolt4HeadHole(depth=8,lHead=Collar_H+5);
		
		//rotate([0,0,156+90]) translate([0,OD/2-8,0]) cylinder(d=5/16*25.4+IDXtra, h=30);
	} // difference
} // Stager_Cup_Light

// Stager_Cup_Light(Collar_H=17);

module Stager_Mech_Mount(Len=26, HasSkirtHoles=false){
	myfn=180;
	nBolts=4;
	OD=Coupler_OD*CF_Comp-0.4;
	Boss_h=4;
	Wall_t=1.2;
	TopBolt_a=50;
	
	module BoltBoss(){
		hull(){
			cylinder(d=7, h=Boss_h);
			translate([0,3.0,0]) scale([1,0.2,1]) cylinder(d=9, h=Boss_h);
		} // hull
	} // BoltBoss
	
	difference(){
		union(){
			Tube(OD=OD, ID=OD-Wall_t*2, Len=Len, myfn=$preview? 90:myfn);
			
			PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=nPetals*2) BoltBoss();
			translate([0,0,Len-Boss_h])
				ServoPlateBoltPattern(TopBolt_a) BoltBoss();
		} // union
		
		if (HasSkirtHoles)
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) translate([0,OD/2,Len-7.5])
			rotate([-90,0,0]) Bolt4Hole();
		
		PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=nPetals*2) rotate([180,0,0]) Bolt4Hole();

		translate([0,0,Len-Boss_h])
			ServoPlateBoltPattern(TopBolt_a) rotate([180,0,0]) Bolt4ClearHole();		
	
	} // difference
} // Stager_Mech_Mount

// translate([0,0,-26]) rotate([0,0,-30]) Stager_Mech_Mount();
// Stager_Mech_Mount(Len=28, HasSkirtHoles=false);

module ServoPlateBoltPattern(Angle=0){
	Hole_a=[0,60,120,175,260,300];
	Hole_Y=Coupler_OD*CF_Comp/2-Bolt4Inset;
	
	for (j=Hole_a) rotate([0,0,j+Angle]) translate([0,Hole_Y,0]) children();
} // ServoPlateBoltPattern

// ServoPlateBoltPattern() Bolt4Hole();

module Custom_ServoPlate(){
	Bolt_a=20;
	
	difference(){
		Stager_ServoPlate(Tube_OD=Body_OD*CF_Comp+Vinyl_d, Skirt_ID=Body_ID*CF_Comp, nLocks=Default_nLocks, OverCenter=IDXtra+0.8, Servo_ID=DefaultServo);
		
		// Bolt holes for coupler and petal hub
		translate([0,0,5])
			ServoPlateBoltPattern(Angle=Bolt_a) Bolt4Hole();
	} // difference
} // Custom_ServoPlate

// Custom_ServoPlate();






















