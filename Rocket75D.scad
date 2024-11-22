// ***********************************
// Project: 3D Printed Rocket
// Filename: Rocket75D.scad
// by David M. Flynn
// Created: 8/6/2023 
// Revision: 1.3.7  11/17/2024 
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  Rocket with 75mm Body and 54mm motor. 
//  Recommended Motors: J275W, J180W, J415W, J135W, K185W
//		for 38mm version: I357T, I284W, J350W
//
//  Dual deploy:
//   Mission Control V3 / RocketServo x 2
//
//  ***** Parts *****
//
// BlueTube 2.0 3" Body Tube by 12 inches (Forward body)
// BlueTube 2.0 3" Body Tube by 18 to 24 inches (19.25" and 18.11" as built)
// Blue Tube 2.1" Body Tube by 18 inches (Motor Tube) Built w/ 16.5" 
// 45" Parachute
// 1/8" Paracord (3 feet)
// 1/2" Braided Nylon Shock Cord (20 feet)
//
//  ***** Hardware *****
//    Note: Qty for Single Deploy/Qty for Dual Deploy
// 5/32" x 1/8" Plastic Rivets (3 req) Nosecone
// #6-32 x 3/4" Button Head Cap Screw (4 req) Rail Guides
// #4-40 x 1/2" Socket Head Cap Screw (10 req) Ball Lock
// #4-40 x 3/8" Button Head Cap Screw (10 req) Doors
// #4-40 x 3/8" Socket Head Cap Screw (6 req) PetalHub
// #4-40 x 1/4" Button Head Cap Screw (12 req) Petals
// #4-40 x 1/4" Button Head Cap Screw (4 req) Altimeter
// #2-56 x 1/4" Socket Head Cap Screw (4 req) Servos
// MR84-2RS Bearing (14 req) Ball Lock
// 3/8" Delrin Ball (10 req) Ball Lock
// 4mm Dia. x 10mm Undersize Steel Dowel (10 req) Ball Lock
// 4mm Dia. x 16mm Undersize Steel Dowel (6 req) Ball Lock
// 3/16" Dia x 1/8" Disc Magnet N42 (4 req) Ball Lock
// MG90S Micro Servo (2 req) Ball Lock
// C&K Rotary Switch (2 req) Battery Door
// Mission Control V3 Altimeter PCBA
// Rocket Servo PCBA (2 req)
// FeatherWeight GPS
// #4-40 x 1/2" Nylon Pan Head (2 Req.) GPS
// CS4323 Spring (4 req)
// 5/16" Dia x 1-1/4" Spring (6 req) PetalHub
// 1/2" Dia x 0.035" Wall x 68mm Long Aluminum Tube (2 req) R75_BallRetainerTop
// 1/2" Dia x 0.035" Wall x 74mm Long Aluminum Tube NC_ShockcordRing75
//
//  ***** History *****
//
// 1.3.7  11/17/2024 Added R75_UpperRailGuideMount for sustainer.
// 1.3.6  10/29/2024 Added Vinyl_d to OD of printed parts. New fin shape. Fixed ShowRocket()
// 1.3.5  10/8/2024  Longer tail cone for 38mm motor.
// 1.3.4  10/4/2024  Worked on ULine 38mm motor version.
// 1.3.3  7/26/2024  Updated hardware list. Sorted params, added 3 fin fin data
// 1.3.2  7/23/2024  Removed double battery door, it didn't fit.
// 1.3.1  7/20/2024  ULine 3" Mailing tube version
// 1.3.0  7/18/2024  Copied from Rocket75C 1.2.3 No longer an upscale. Changed to 5 Lock Balls and Dual Deploy.
// 1.2.3  4/21/2024  Added screw holes to R75_BallRetainerTop()
// 1.2.2  4/18/2024  Standardized some parts
// 1.2.1  3/31/2024  Now uses ElectronicsBayLib.scad
// 1.2.0  12/3/2023  Updated ebay and deployment parts, removed obsolete parts
// 1.1.1  10/22/2023  Now uses PetalDeploymentLib.scad
// 1.1.0  8/9/2023   Got Dual Deploy?
// 1.0.1  8/8/2023   Fin can improvments
// 1.0.0  8/6/2023   Copied from Rocket65 Rev 1.0.8
//
// ***********************************
//  ***** for STL output *****
//
// *** Nosecode ***
//
// BluntOgiveNoseCone(ID=Body_ID, OD=Body_OD+Vinyl_d, L=NC_Len, Base_L=NC_Base_L, Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=0, LowerPortion=false);
//
// NC_ShockcordRing75(Body_OD=Body_OD+Vinyl_d, Body_ID=Body_ID, NC_Base_L=NC_Base_L);
//
// *** Single/Dual Deploy Electronics Bay ***
//
DualDeploy=true;
// rotate([180,0,0]) ElectronicsBay(IsDualDeploy=DualDeploy, ShowDoors=false, TopOnly=true, BottomOnly=false);
// ElectronicsBay(IsDualDeploy=DualDeploy, ShowDoors=false, TopOnly=false, BottomOnly=true);
// 
// *** Doors ***
//
// rotate([-90,0,0]) EB_AltDoor(Tube_OD=Body_OD+Vinyl_d);
// rotate([-90,0,0]) EB_BattDoor(Tube_OD=Body_OD+Vinyl_d, HasSwitch=true, DoubleBatt=false);
// rotate([-90,0,0]) EB_BattDoor(Tube_OD=Body_OD+Vinyl_d, HasSwitch=false, DoubleBatt=false);
//
// *** Ball Lock ***
//
// STB_LockDisk(Body_ID=Body_ID, nLockBalls=nLockBalls); // Print 2
// rotate([180,0,0]) R75_BallRetainerTop(Body_OD=Body_OD+Vinyl_d, Body_ID=Body_ID); // Print 2
// R75_BallRetainerBottom(Body_ID=Body_ID, HasPD_Ring=false); // Forward
// R75_BallRetainerBottom(Body_ID=Body_ID, HasPD_Ring=true); // Aft
// rotate([180,0,0]) STB_TubeEnd2(Body_ID=Body_ID, nLockBalls=nLockBalls, Body_OD=Body_OD, Engagement_Len=20); // Print 2
//
// *** petal deployer ***
//
// PD_NC_PetalHub(OD=Coupler_OD, nPetals=nPetals, nRopes=3); // for dual deploy only
// R75_PetalHub(Body_OD=Body_OD, Body_ID=Body_ID); // for bottom of ebay
// rotate([-90,0,0]) PD_PetalSpringHolder();  // Print 6
// rotate([180,0,0]) PD_Petals(OD=Coupler_OD, Len=ForwardPetal_Len, nPetals=nPetals, Wall_t=1.8, AntiClimber_h=4, HasLocks=false);
// rotate([180,0,0]) PD_Petals(OD=Coupler_OD, Len=AftPetal_Len, nPetals=nPetals, Wall_t=1.8, AntiClimber_h=4, HasLocks=false);
// rotate([180,0,0]) PD_Petals(OD=Coupler_OD, Len=75, nPetals=nPetals, Wall_t=1.8, AntiClimber_h=0, HasLocks=false);
//
// SE_SpringEndTop(OD=Coupler_OD, Tube_ID=Coupler_OD-4.4, nRopeHoles=3, CutOutCenter=true);
// SE_SlidingSpringMiddle(OD=Coupler_OD, nRopes=3);
//
// R75_MotorTubeTopper(Body_ID=Body_ID, MotorTube_OD=MotorTube_OD, MotorTube_ID=MotorTube_ID);
//
//  *** Alt part, scock cord will attach to top of motor, threaded forward closure is required ***
// rotate([180,0,0]) R75_UpperRailGuideMount(Body_ID=Body_ID, MotorTube_OD=MotorTube_OD, HasSpokes=true, Extended=20);
//
// SE_SpringEndBottom(OD=Coupler_OD, Tube_ID=Coupler_OD-3.6, Len=15, nRopeHoles=3, CutOutCenter=true);
// SE_SpringSpacer(OD=Coupler_OD, Tube_ID=Coupler_OD-2.4, Len=85); // only needed if body tube is longer than minimum, can also use coupler tube
// 
// rotate([180,0,0]) R75_UpperRailGuideMount(Body_ID=Body_ID, MotorTube_OD=MotorTube_OD, HasSpokes=true, Extended=15);
//
// rotate([180,0,0]) S_LowerElectronicsBay(IsDualDeploy=false, ShowDoors=false, TopOnly=true, BottomOnly=false);
// S_LowerElectronicsBay(IsDualDeploy=false, ShowDoors=false, TopOnly=false, BottomOnly=true);
//
// *** Fin Can ***
//
// rotate([180,0,0]) Rocket75D_Fincan(LowerHalfOnly=false, UpperHalfOnly=false);
// Rocket75D_MotorRetainer();
//
// Rocket75D_SFincan(LowerHalfOnly=false, UpperHalfOnly=false); // alt. Sustainer version for 2 stage
//
// RocketFin();
// RocketFin(HasSpiralVaseRibs=false); // PETG-CF test fin
//
// rotate([90,0,0]) BoltOnRailGuide(Length = RailGuideLen, BoltSpace=12.7, RoundEnds=true, ExtraBack=0);
// rotate([-90,0,0]) RailGuideSpacer(OD=Body_OD, H=RailGuide_h, Length = RailGuideLen, BoltSpace=12.7);
// 
// ***********************************
//  ***** Booster Parts *****
//
//  *** Stager ***
// rotate([180,0,0]) Stager_Sustainer_Cup(Tube_OD=Body_OD+Vinyl_d, nLocks=nLocks, MotorTube_OD=DefaultMotorTube_OD, Motor_Len=10, nFins=5, StagerCollarLen=18);
// rotate([-90,0,0]) Stager_LockRod(Adj=0.0);
// Stager_Saucer(Tube_OD=Body_OD+Vinyl_d, nLocks=nLocks);
// Stager_Mech(Tube_OD=Body_OD+Vinyl_d, nLocks=nLocks, Skirt_ID=Body_ID, Skirt_Len=Stager_SkirtLen, nSkirtBolts=4, ShowLocked=true);
// rotate([180,0,0]) Stager_OuterBearingCover(Tube_OD=Body_OD+Vinyl_d, nLocks=nLocks); // Secures Outer Race of Main Bearing
// Stager_LockRing(Tube_OD=Body_OD+Vinyl_d, nLocks=nLocks); 
// rotate([180,0,0]) Stager_Indexer(Tube_OD=Body_OD+Vinyl_d, nLocks=nLocks);
// Stager_ServoPlate(Tube_OD=Body_OD+Vinyl_d, Skirt_ID=Body_ID, nLocks=nLocks, OverCenter=IDXtra, Servo_ID=DefaultServo);
// rotate([180,0,0]) Stager_ServoMount(Servo_ID=DefaultServo);
//
//
// rotate([180,0,0]) B_ElectronicsBay(IsDualDeploy=false, ShowDoors=false, TopOnly=true, BottomOnly=false);
// B_ElectronicsBay(IsDualDeploy=false, ShowDoors=false, TopOnly=false, BottomOnly=true);
//
// rotate([180,0,0]) PD_Petals(OD=Coupler_OD, Len=B_Petal_Len, nPetals=nPetals, Wall_t=1.8, AntiClimber_h=4, HasLocks=false);
//
// rotate([180,0,0]) SE_SpringEndTypeA2(Coupler_OD=Coupler_OD, Coupler_ID=Coupler_ID, nRopes=6, Spring_OD=SE_Spring_CS11890_OD());
// SE_MtrTubeSpringEnd(Body_ID=Body_ID, MtrTubeOD=MotorTube_OD, Spring_OD=SE_Spring_CS11890_OD());
//
// B_Fincan(LowerHalfOnly=false, UpperHalfOnly=true);
// rotate([180,0,0]) B_Fincan(LowerHalfOnly=true, UpperHalfOnly=false);
// RocketBFin();
// Rocket75D_MotorRetainer();
//
// ***********************************
//  ***** Routines *****
//
//
// ***********************************
//  ***** for Viewing *****
//
// ShowRocket(IsDualDeploy=DualDeploy, ShowInternals=false, ShowDoors=true);
// translate([300,0,0]) ShowRocket(IsDualDeploy=DualDeploy, ShowInternals=true, ShowDoors=false);
//
// ***********************************
include<TubesLib.scad>
use<RailGuide.scad>
use<Fins.scad>
use<NoseCone.scad>
use<ElectronicsBayLib.scad>
use<FinCan2Lib.scad>
use<SpringThingBooster.scad>
use<PetalDeploymentLib.scad>
use<SpringEndsLib.scad>			echo(SpringEndsLibRev());
use<R75Lib.scad>
use<AT-RMS-Lib.scad>
include<Stager75BBLib.scad>

//also included
 //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;
Bolt4Inset=4;

// Nosecone param's
NC_Len=212;
NC_Tip_r=4; // was 6
NC_Wall_t=1.8;
NC_Base_L=15;

EBay_Len=162;
S_LowerEBayLen=156;
IsDualDeploy=true;

nPetals=3;
nLockBalls=5;
RailGuideLen=35;

ForwardPetal_Len=200; // Main 'chute and lots of shock cord
AftPetal_Len=150; // Drogue
B_Petal_Len=120;

Vinyl_d=0.5; // added to fin can OD

// constants for 75mm stager
nLocks=3;
DefaultBody_OD=BT75Body_OD;
DefaultBody_ID=BT75Body_ID;
DefaultMotorTube_OD=BT38Body_OD;
DefaultServo=ServoMG90S_ID; //ServoMS75_ID;
MainBearing_OD=Bearing6807_OD;
MainBearing_ID=Bearing6807_ID;
MainBearing_T=Bearing6807_T;

Stager_SkirtLen=46;

//*
// Max The Red Fins
nFins=5;
Fin_Post_h=14;
Fin_Root_L=180;
Fin_Root_W=10;
Fin_Tip_W=3.0;
Fin_Tip_L=90;
Fin_Span=120;
Fin_TipOffset=110;
Fin_Chamfer_L=32;
FinInset_Len=5;
/**/

/*
// smaller for dual deploy
nFins=5;
Fin_Post_h=14;
Fin_Root_L=190;
Fin_Root_W=8;
Fin_Tip_W=3.0;
Fin_Tip_L=70;
Fin_Span=70;
Fin_TipOffset=30;
Fin_Chamfer_L=22;
FinInset_Len=5;
/**/

/*
// 5 smaller fins
nFins=5;
Fin_Post_h=10;
Fin_Root_L=190;
Fin_Root_W=8;
Fin_Tip_W=3.0;
Fin_Tip_L=83;
Fin_Span=83;
Fin_TipOffset=24;
Fin_Chamfer_L=22;
FinInset_Len=10;
/**/
/*
// 3 larger fins
nFins=3;
Fin_Post_h=10;
Fin_Root_L=220;
Fin_Root_W=12;
Fin_Tip_W=3;
Fin_Tip_L=80;
Fin_Span=140;
Fin_TipOffset=40;
Fin_Chamfer_L=30;
FinInset_Len=10;
/**/

// Booster fin
B_FinScale=1.40;
B_Fin_Post_h=14;
B_Fin_Root_L=190*B_FinScale;
B_Fin_Root_W=8*B_FinScale;
B_Fin_Tip_W=3.0;
B_Fin_Tip_L=70*B_FinScale;
B_Fin_Span=70*B_FinScale;
B_Fin_TipOffset=30*B_FinScale;
B_Fin_Chamfer_L=22*B_FinScale;
B_FinInset_Len=5;

B_FinCan_Len=B_Fin_Root_L+B_FinInset_Len*2; // Calculated fin can length
FinCan_Len=Fin_Root_L+FinInset_Len*2; // Calculated fin can length

/*
// BlueTube 2.0 version
Body_OD=BT75Body_OD;
Body_ID=BT75Body_ID;
Coupler_OD=BT75Coupler_OD;
Coupler_ID=BT75Coupler_ID;
// *** 54mm Motor Tube ***
MotorTube_OD=BT54Body_OD;
MotorTube_ID=BT54Body_ID;
MotorCoupler_OD=BT54Coupler_OD;
TailCone_Len=35;
TailConeExtra_OD=1;
/**/

//*
// U-Line 3" Mailing Tube version
Body_OD=ULine75Body_OD;
Body_ID=ULine75Body_ID;
Coupler_OD=BT75Coupler_OD;
Coupler_ID=BT75Coupler_ID;
// *** 38mm Motor Tube ***
MotorTube_OD=ULine38Body_OD;
MotorTube_ID=ULine38Body_ID;
MotorCoupler_OD=BT38Coupler_OD;
TailCone_Len=50;
TailConeExtra_OD=0;
/**/

MotorTubeHole_d=MotorTube_OD+IDXtra*3;

RailGuide_h=Body_OD/2+2;

// For display only, not used by parts
MainBay_Len=12*25.4;
BodyTubeLen=16*25.4; //18.11*25.4; // 19.25*25.4;
MotorTubeLen=(BodyTubeLen-1.7*25.4);// 317; //16.5*25.4; //18*25.4;

B_BodyLen=303;
B_MotorTubeLen=B_FinCan_Len+100;

echo(MainBay_Len=MainBay_Len);
echo(BodyTubeLen=BodyTubeLen);
echo(MotorTubeLen=MotorTubeLen);

echo(B_MotorTubeLen=B_MotorTubeLen);

module ShowRocket(IsDualDeploy=true, ShowInternals=false, ShowDoors=false){
	FinCan_Z=35;
	Fin_Z=FinCan_Z+Fin_Root_L/2+FinInset_Len;
	MotorTube_Z=FinCan_Z-23;
	BodyTube_Z=FinCan_Z+FinCan_Len+Overlap*2;
	EBay_Z=BodyTube_Z+BodyTubeLen+33.5;
	UpperBallLock_Z=EBay_Z+EBay_Len+26.5;
	NoseCone_Z=IsDualDeploy? UpperBallLock_Z+MainBay_Len+12+Overlap*2:EBay_Z+EBay_Len+3;
	
	echo(str("Overall Length = ",(NoseCone_Z+NC_Len)/25.4));

	translate([0,0,NoseCone_Z]){
		rotate([0,0,90]) BluntOgiveNoseCone(ID=Coupler_OD, OD=Body_OD, L=NC_Len, Base_L=13, 
							Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=0, LowerPortion=false);
		rotate([0,0,-30]) color("LightGreen")
			NC_ShockcordRing75(Body_OD=Body_OD, Body_ID=Body_ID, NC_Base_L=NC_Base_L);}
	
	
	
	if (!ShowInternals && IsDualDeploy)
		translate([0,0,UpperBallLock_Z+10]) color("LightBlue") 
			Tube(OD=Body_OD, ID=Body_ID, Len=MainBay_Len-Overlap*2, myfn=$preview? 90:360);
				
	// Main parachute compartment parts
	if (ShowInternals && IsDualDeploy){
		translate([0,0,NoseCone_Z-60]) SE_SlidingSpringMiddle(OD=Coupler_OD, nRopes=3);
		
		translate([0,0,UpperBallLock_Z+ForwardPetal_Len+20+9]) rotate([180,0,0]) 
			PD_NC_PetalHub(OD=Coupler_OD, nPetals=nPetals, nRopes=3);
			
		translate([0,0,UpperBallLock_Z+ForwardPetal_Len+20]) rotate([180,0,0]) 
			PD_Petals(OD=Coupler_OD, Len=ForwardPetal_Len, nPetals=nPetals, Wall_t=1.8, AntiClimber_h=4, HasLocks=false);
	
		translate([0,0,UpperBallLock_Z]) rotate([180,0,0]) 
			R75_BallRetainerBottom(Body_ID=Body_ID, HasPD_Ring=false);
	} // if (ShowInternals)
	
	//*
	if (!ShowInternals && IsDualDeploy)
		translate([0,0,UpperBallLock_Z]) rotate([180,0,0])
			STB_TubeEnd2(Body_ID=Body_ID, nLockBalls=nLockBalls, Body_OD=Body_OD, Engagement_Len=20);
	/**/
	if (IsDualDeploy)
		translate([0,0,UpperBallLock_Z]) rotate([180,0,0]) color("Tan") R75_BallRetainerTop(Body_OD=Body_OD+Vinyl_d, Body_ID=Body_ID);
	
	translate([0,0,EBay_Z]) 
			ElectronicsBay(IsDualDeploy=IsDualDeploy, ShowDoors=ShowDoors, TopOnly=false, BottomOnly=false);
	
	translate([0,0,BodyTube_Z+BodyTubeLen+15+Overlap*2])
		color("Tan") R75_BallRetainerTop(Body_OD=Body_OD+Vinyl_d, Body_ID=Body_ID);
	
	// Drogue compartment parts
	if (ShowInternals){
		translate([0,0,BodyTube_Z+BodyTubeLen+15+Overlap*2-0.2]) 
			R75_BallRetainerBottom(Body_ID=Body_ID, HasPD_Ring=true);
			
		translate([0,0,BodyTube_Z+BodyTubeLen+15+Overlap*2-19.5]) rotate([0,0,200]) rotate([180,0,0]) 
			R75_PetalHub(Body_OD=Body_OD, Body_ID=Body_ID);
			
		translate([0,0,BodyTube_Z+BodyTubeLen+15+Overlap*2-29]) 
			rotate([0,0,200]) rotate([180,0,0]) 
				PD_Petals(OD=Coupler_OD, Len=AftPetal_Len, nPetals=nPetals, Wall_t=1.8, AntiClimber_h=4, HasLocks=false);
			
		translate([0,0,MotorTube_Z+MotorTubeLen+17+45])
			SE_SpringEndTop(OD=Coupler_OD, Tube_ID=Coupler_OD-4.4, nRopeHoles=3, CutOutCenter=true);
			
		translate([0,0,MotorTube_Z+MotorTubeLen+17]) SE_SlidingSpringMiddle(OD=Coupler_OD, nRopes=3);
		translate([0,0,MotorTube_Z+MotorTubeLen])
			R75_MotorTubeTopper(Body_ID=Body_ID, MotorTube_OD=MotorTube_OD, MotorTube_ID=MotorTube_ID);
	} // if (ShowInternals)
	
	if (ShowInternals==false)
	translate([0,0,BodyTube_Z+BodyTubeLen+15])
		STB_TubeEnd2(Body_ID=Body_ID, nLockBalls=nLockBalls, Body_OD=Body_OD, Engagement_Len=20);
	
	if (ShowInternals==false)
	translate([0,0,BodyTube_Z]) color("LightBlue") 
		Tube(OD=Body_OD, ID=Body_ID, Len=BodyTubeLen-Overlap*2, myfn=$preview? 90:360);
	
	if (ShowInternals)
	translate([0,0,MotorTube_Z]) color("Blue") 
		Tube(OD=MotorTube_OD, ID=MotorTube_ID, Len=MotorTubeLen-Overlap*2, myfn=$preview? 90:360);
			
	translate([0,0,FinCan_Z]) color("White") Rocket75D_Fincan(LowerHalfOnly=false, UpperHalfOnly=false);
	
	for (j=[0:nFins]) rotate([0,0,360/nFins*j+180/nFins])
		translate([0, Body_OD/2-Fin_Post_h, Fin_Z]) 
			rotate([-90,0,0]) color("Yellow") RocketFin();
	
	translate([0,0,FinCan_Z-0.2]) Rocket75D_MotorRetainer();
	
	
} // ShowRocket

// ShowRocket(IsDualDeploy=false, ShowDoors=true);
// ShowRocket(IsDualDeploy=true, ShowDoors=true);
// ShowRocket(IsDualDeploy=false, ShowInternals=true);

module ShowBooster(ShowInternals=false, ShowDoors=false){
	FinCan_Z=35;
	Fin_Z=FinCan_Z+B_Fin_Root_L/2+B_FinInset_Len;
	MotorTube_Z=FinCan_Z-38;
	MTCR_Z=MotorTube_Z+B_MotorTubeLen-10;
	BodyTube_Z=FinCan_Z+B_FinCan_Len;
	BallLock_Z=BodyTube_Z+B_BodyLen+10;
	EBay_Z=BallLock_Z+18.5;
	Stager_Z=EBay_Z+EBay_Len+Stager_SkirtLen+33;
	
	translate([0,0,Stager_Z]) {
		Stager_Sustainer_Cup(Tube_OD=Body_OD+Vinyl_d, nLocks=nLocks, MotorTube_OD=DefaultMotorTube_OD, Motor_Len=10, nFins=5, StagerCollarLen=18);
		color("Blue") Stager_Saucer(Tube_OD=Body_OD+Vinyl_d, nLocks=nLocks);
		Stager_Mech(Tube_OD=Body_OD+Vinyl_d, nLocks=nLocks, Skirt_ID=Body_ID, Skirt_Len=Stager_SkirtLen, nSkirtBolts=3, ShowLocked=true);
	}
	
	translate([0,0,EBay_Z]) 
			B_ElectronicsBay(IsDualDeploy=false, ShowDoors=ShowDoors, TopOnly=false, BottomOnly=false);
			
	translate([0,0,BallLock_Z])
		color("Tan") R75_BallRetainerTop(Body_OD=Body_OD+Vinyl_d, Body_ID=Body_ID);
		
	if (!ShowInternals)
		translate([0,0,BallLock_Z]) //rotate([180,0,0])
			STB_TubeEnd2(Body_ID=Body_ID, nLockBalls=nLockBalls, Body_OD=Body_OD+Vinyl_d, Engagement_Len=20);
			
	if (ShowInternals){
		translate([0,0,BallLock_Z]) 
			R75_BallRetainerBottom(Body_ID=Body_ID, HasPD_Ring=true);
			
		translate([0,0,BallLock_Z-19.5]) rotate([0,0,200]) rotate([180,0,0]) 
			R75_PetalHub(Body_OD=Body_OD, Body_ID=Body_ID);
			
		translate([0,0,BallLock_Z-29]) 
			rotate([0,0,200]) rotate([180,0,0]) 
				PD_Petals(OD=Coupler_OD, Len=B_Petal_Len, nPetals=nPetals, Wall_t=1.8, AntiClimber_h=4, HasLocks=false);
	} // if (ShowInternals)
	
	if (!ShowInternals)
		translate([0,0,BodyTube_Z-Overlap]) color("LightGreen")
			Tube(OD=Body_OD+Vinyl_d, ID=Body_ID, Len=B_BodyLen-Overlap*2, myfn=$preview? 90:360);
	
	if (ShowInternals){
		translate([0,0,MotorTube_Z+B_MotorTubeLen+12.2]) color("LightBlue") 
			Tube(OD=Coupler_OD, ID=Coupler_ID, Len=50, myfn=$preview? 90:360);
		translate([0,0,MotorTube_Z+B_MotorTubeLen]) color("Tan") 
			SE_SpringEndTypeA2(Coupler_OD=Coupler_OD, Coupler_ID=Coupler_ID, nRopes=6, Spring_OD=SE_Spring_CS11890_OD());
		translate([0,0,MotorTube_Z+B_MotorTubeLen-10]) color("Tan") 
			SE_MtrTubeSpringEnd(Body_ID=Body_ID, MtrTubeOD=MotorTube_OD, Spring_OD=SE_Spring_CS11890_OD());
	}
	
	if (ShowInternals)
	translate([0,0,MotorTube_Z]) color("Blue") 
		Tube(OD=MotorTube_OD, ID=MotorTube_ID, Len=B_MotorTubeLen-Overlap*2, myfn=$preview? 90:360);
		
	translate([0,0,FinCan_Z]) color("White") B_Fincan(LowerHalfOnly=false, UpperHalfOnly=false);
	
	for (j=[0:nFins]) rotate([0,0,360/nFins*j+180/nFins])
		translate([0, Body_OD/2-B_Fin_Post_h, Fin_Z]) 
			rotate([-90,0,0]) color("Yellow") RocketBFin();
			
	translate([0,0,FinCan_Z-0.2]) Rocket75D_MotorRetainer();
	translate([0,0,-3]) ATRMS_38_720_Motor(HasEyeBolt=true);
} // ShowBooster

//ShowBooster(ShowInternals=true);
//ShowBooster(ShowInternals=false);
			
module ElectronicsBay(IsDualDeploy=true, ShowDoors=false, TopOnly=false, BottomOnly=false){
	DoorAngles=IsDualDeploy? [[0],[],[120,240]]:[[0],[120],[240]];
	
	EB_Electronics_BayUniversal(Tube_OD=Body_OD+Vinyl_d, Tube_ID=Body_ID, DoorAngles=DoorAngles, Len=EBay_Len, 
									nBolts=3, BoltInset=7.5, ShowDoors=ShowDoors,
									HasFwdIntegratedCoupler=false, HasFwdShockMount=false,
									HasAftIntegratedCoupler=false, HasAftShockMount=false,
									HasRailGuide=false, RailGuideLen=35,
									HasFwdCenteringRing=false, HasAftCenteringRing=false, InnerTube_OD=BT38Body_OD,
									Bolted=true, ExtraBolts=[], TopOnly=TopOnly, BottomOnly=BottomOnly); 
} // ElectronicsBay

// ElectronicsBay(IsDualDeploy=true, ShowDoors=false, TopOnly=false, BottomOnly=false);


module S_LowerElectronicsBay(IsDualDeploy=false, ShowDoors=false, TopOnly=false, BottomOnly=false){
	DoorAngles=[[90],[270],[]];
	
	EB_Electronics_BayUniversal(Tube_OD=Body_OD+Vinyl_d, Tube_ID=Body_ID, DoorAngles=DoorAngles, Len=S_LowerEBayLen, 
									nBolts=0, BoltInset=7.5, ShowDoors=ShowDoors,
									HasFwdIntegratedCoupler=true, HasFwdShockMount=false,
									HasAftIntegratedCoupler=true, HasAftShockMount=false,
									HasRailGuide=false, RailGuideLen=35,
									HasFwdCenteringRing=true, HasAftCenteringRing=true, InnerTube_OD=MotorTube_OD,
									Bolted=true, ExtraBolts=[90], TopOnly=TopOnly, BottomOnly=BottomOnly); 
} // S_LowerElectronicsBay

// S_LowerElectronicsBay(IsDualDeploy=false, ShowDoors=false, TopOnly=false, BottomOnly=false);

module Rocket75D_Fincan(LowerHalfOnly=false, UpperHalfOnly=false){
	// for single stage version
	FC2_FinCan(Body_OD=Body_OD+Vinyl_d, Body_ID=Body_ID, Can_Len=FinCan_Len,
				MotorTube_OD=MotorTube_OD, RailGuide_h=RailGuide_h, RailGuideLen=RailGuideLen,
				nFins=nFins, HasIntegratedCoupler=true, HasMotorSleeve=true, HasAftIntegratedCoupler=false,
				Fin_Root_W=Fin_Root_W, Fin_Root_L=Fin_Root_L, Fin_Post_h=Fin_Post_h, Fin_Chamfer_L=Fin_Chamfer_L,
				Cone_Len=TailCone_Len, ThreadedTC=true, Extra_OD=TailConeExtra_OD,
				LowerHalfOnly=LowerHalfOnly, UpperHalfOnly=UpperHalfOnly, HasWireHoles=false, HollowTailcone=true, 
				HollowFinRoots=true, Wall_t=1.2);
} // Rocket75D_Fincan

// Rocket75D_Fincan(LowerHalfOnly=false, UpperHalfOnly=false);

module Rocket75D_SFincan(LowerHalfOnly=false, UpperHalfOnly=false){
	// for 2 stage version
	
	TailPlate_t=7;
	WireTube_d=5/16*25.4+IDXtra*2;

	difference(){
		union(){

			FC2_FinCan(Body_OD=Body_OD+Vinyl_d, Body_ID=Body_ID, Can_Len=FinCan_Len,
				MotorTube_OD=MotorTube_OD, RailGuide_h=RailGuide_h, RailGuideLen=RailGuideLen,
				nFins=nFins, HasIntegratedCoupler=true, HasMotorSleeve=true, HasAftIntegratedCoupler=false,
				Fin_Root_W=Fin_Root_W, Fin_Root_L=Fin_Root_L, Fin_Post_h=Fin_Post_h, Fin_Chamfer_L=Fin_Chamfer_L,
				Cone_Len=0, ThreadedTC=false, Extra_OD=TailConeExtra_OD,
				LowerHalfOnly=LowerHalfOnly, UpperHalfOnly=UpperHalfOnly, HasWireHoles=false, HollowTailcone=true, 
				HollowFinRoots=true, Wall_t=1.2);
				
		
			if (UpperHalfOnly==false) translate([0,0,FinInset_Len-1-TailPlate_t])
				CenteringRing(OD=Body_OD+Vinyl_d, ID=MotorTube_OD+IDXtra*3, Thickness=TailPlate_t, nHoles=0, Offset=0, myfn=$preview? 90:360);
		} // union
				
		// Wire Path
		rotate([0,0,360/nFins]) translate([0, MotorTube_OD/2+6, FinInset_Len-1-TailPlate_t-Overlap]) 
			cylinder(d=WireTube_d, h=FinCan_Len+10+TailPlate_t);
		
		// Stager Bolt Holes
		if (UpperHalfOnly==false) translate([0,0,FinInset_Len-1-TailPlate_t])
			Stager_CupBoltHoles(Tube_OD=Body_OD, nLocks=nLocks) Bolt4Hole(depth=TailPlate_t);
		
	} // difference
				
} // Rocket75D_SFincan

//Rocket75D_SFincan(LowerHalfOnly=false, UpperHalfOnly=false);

module Rocket75D_MotorRetainer(){
  FC2_MotorRetainer(Body_OD=Body_OD,
						MotorTube_OD=MotorTube_OD, MotorTube_ID=MotorTube_ID,
						HasWrenchCuts=false, Cone_Len=TailCone_Len, ExtraLen=0, Extra_OD=TailConeExtra_OD);
} // Rocket75D_MotorRetainer
	
module RocketFin(HasSpiralVaseRibs=true){
	
	TrapFin2(Post_h=Fin_Post_h, Root_L=Fin_Root_L, Tip_L=Fin_Tip_L, Root_W=Fin_Root_W,
				Tip_W=Fin_Tip_W, Span=Fin_Span, Chamfer_L=Fin_Chamfer_L,
				TipOffset=Fin_TipOffset,
				Bisect=false, Bisect_X=0,
				HasSpar=false, Spar_d=8, Spar_L=100, HasSpiralVaseRibs=HasSpiralVaseRibs);
				
	
} // RocketFin

//RocketFin();

//  **************************************************************************************************************
//   ***** Booster Parts *****
//  **************************************************************************************************************

module B_ElectronicsBay(IsDualDeploy=false, ShowDoors=false, TopOnly=false, BottomOnly=false){
	DoorAngles=IsDualDeploy? [[0],[],[120,240]]:[[0],[120],[240]];
	nBolts=TopOnly? 4:3;
	
	EB_Electronics_BayUniversal(Tube_OD=Body_OD+Vinyl_d, Tube_ID=Body_ID, DoorAngles=DoorAngles, Len=EBay_Len, 
									nBolts=nBolts, BoltInset=7.5, ShowDoors=ShowDoors,
									HasFwdIntegratedCoupler=true, HasFwdShockMount=true,
									HasAftIntegratedCoupler=false, HasAftShockMount=false,
									HasRailGuide=false, RailGuideLen=35,
									HasFwdCenteringRing=false, HasAftCenteringRing=false, InnerTube_OD=BT38Body_OD,
									Bolted=true, ExtraBolts=[], TopOnly=TopOnly, BottomOnly=BottomOnly); 
} // B_ElectronicsBay

// B_ElectronicsBay(IsDualDeploy=false, ShowDoors=false, TopOnly=false, BottomOnly=false);

module RocketBFin(){
	
	TrapFin2(Post_h=B_Fin_Post_h, Root_L=B_Fin_Root_L, Tip_L=B_Fin_Tip_L, Root_W=B_Fin_Root_W,
				Tip_W=B_Fin_Tip_W, Span=B_Fin_Span, Chamfer_L=B_Fin_Chamfer_L,
				TipOffset=B_Fin_TipOffset,
				Bisect=false, Bisect_X=0,
				HasSpar=false, Spar_d=8, Spar_L=100);
				
	
} // RocketBFin

//RocketBFin();

module B_Fincan(LowerHalfOnly=false, UpperHalfOnly=false){
	FC2_FinCan(Body_OD=Body_OD+Vinyl_d, Body_ID=Body_ID, Can_Len=B_FinCan_Len,
				MotorTube_OD=MotorTube_OD, RailGuide_h=RailGuide_h, RailGuideLen=RailGuideLen,
				nFins=nFins, HasIntegratedCoupler=true, HasMotorSleeve=true, HasAftIntegratedCoupler=false,
				Fin_Root_W=B_Fin_Root_W, Fin_Root_L=B_Fin_Root_L, Fin_Post_h=B_Fin_Post_h, Fin_Chamfer_L=B_Fin_Chamfer_L,
				Cone_Len=TailCone_Len, ThreadedTC=true, Extra_OD=TailConeExtra_OD,
				LowerHalfOnly=LowerHalfOnly, UpperHalfOnly=UpperHalfOnly, HasWireHoles=false, HollowTailcone=true, 
				HollowFinRoots=true, Wall_t=1.2);
} // B_Fincan

//B_Fincan();






























