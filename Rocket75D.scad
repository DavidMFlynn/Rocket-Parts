// ***********************************
// Project: 3D Printed Rocket
// Filename: Rocket75D.scad
// by David M. Flynn
// Created: 8/6/2023 
// Revision: 1.3.0  7/18/2024 
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  Rocket with 75mm Body and 54mm motor. 
//  Recommended Motors: J275W, J180W, J415W, J135W, K185W
//
//  Dual deploy:
//   Mission Control V3 / RocketServo
//
//  ***** Parts *****
//
// BlueTube 2.0 3" Body Tube by 12 inches (Forward body)
// BlueTube 2.0 3" Body Tube by 18 to 24 inches (19.25" as built)
// Blue Tube 2.1" Body Tube by 16 inches
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
// 1/2" Dia x 0.035" Wall x 74mm Long Aluminum Tube (3 req)
//
//  ***** History *****
//
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
// BluntOgiveNoseCone(ID=Coupler_OD, OD=Body_OD, L=NC_Len, Base_L=NC_Base_L, Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=0, LowerPortion=false);
//
// NC_ShockcordRing75(Body_OD=Body_OD, Body_ID=Body_ID, NC_Base_L=NC_Base_L);
//
// *** Dual Deploy Electronics Bay ***
//
// EB_Electronics_Bay3(Tube_OD=Body_OD, Tube_ID=Body_ID, Len=EBay_Len, nBolts=3, BoltInset=NC_Base_L/2, DualDeploy=true, ShowDoors=false);
// 
// *** Doors ***
//
// rotate([-90,0,0]) EB_AltDoor(Tube_OD=Body_OD);
// rotate([-90,0,0]) EB_BattDoor(Tube_OD=Body_OD, HasSwitch=true, DoubleBatt=false);
// rotate([-90,0,0]) EB_BattDoor(Tube_OD=Body_OD, HasSwitch=true, DoubleBatt=true);
//
// *** Ball Lock ***
//
// STB_LockDisk(BallPerimeter_d=Body_OD, nLockBalls=nLockBalls);
// rotate([180,0,0]) R75_BallRetainerTop(Body_OD=Body_OD, Body_ID=Body_ID);
// R75_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID, HasPD_Ring=false); // Forward
// R75_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID, HasPD_Ring=true); // Aft
// rotate([180,0,0]) STB_TubeEnd(BallPerimeter_d=Body_OD, nLockBalls=nLockBalls, Body_OD=Body_OD, Body_ID=Body_ID, Skirt_Len=20);
//
// *** petal deployer ***
//
// PD_NC_PetalHub(OD=Coupler_OD, nPetals=nPetals, nRopes=3); // for dual deploy only
// R75_PetalHub(Body_OD=Body_OD, Body_ID=Body_ID); // for bottom of ebay
// rotate([-90,0,0]) PD_PetalSpringHolder();
// rotate([180,0,0]) PD_Petals(OD=Coupler_OD, Len=ForwardPetal_Len, nPetals=nPetals, Wall_t=1.8, AntiClimber_h=4, HasLocks=false);
// rotate([180,0,0]) PD_Petals(OD=Coupler_OD, Len=AftPetal_Len, nPetals=nPetals, Wall_t=1.8, AntiClimber_h=4, HasLocks=false);
//
// SE_SpringEndTop(OD=Coupler_OD, Tube_ID=Coupler_OD-4.4, nRopeHoles=3, CutOutCenter=true);
// SE_SlidingSpringMiddle(OD=Coupler_OD, nRopes=3);
//
// R75_MotorTubeTopper(Body_ID=Body_ID, MotorTube_OD=MotorTube_OD, MotorTube_ID=MotorTube_ID);
//
// *** Fin Can ***
//
/*
	rotate([180,0,0]) FC2_FinCan(Body_OD=Body_OD, Body_ID=Body_ID, Can_Len=Can_Len,
				MotorTube_OD=MotorTube_OD, RailGuide_h=RailGuide_h, RailGuideLen=RailGuideLen,
				nFins=nFins, HasIntegratedCoupler=true, HasMotorSleeve=true, HasAftIntegratedCoupler=false,
				Fin_Root_W=Fin_Root_W, Fin_Root_L=Fin_Root_L, Fin_Post_h=Fin_Post_h, Fin_Chamfer_L=Fin_Chamfer_L,
				Cone_Len=TailCone_Len, ThreadedTC=true, Extra_OD=TailConeExtra_OD,
				LowerHalfOnly=false, UpperHalfOnly=false, HasWireHoles=false);
/**/

// Alt: 2 piece fincan

/*
	FC2_FinCan(Body_OD=Body_OD, Body_ID=Body_ID, Can_Len=Can_Len,
				MotorTube_OD=MotorTube_OD, RailGuide_h=RailGuide_h, RailGuideLen=RailGuideLen,
				nFins=nFins, HasIntegratedCoupler=true, HasMotorSleeve=true, HasAftIntegratedCoupler=false,
				Fin_Root_W=Fin_Root_W, Fin_Root_L=Fin_Root_L, Fin_Post_h=Fin_Post_h, Fin_Chamfer_L=Fin_Chamfer_L,
				Cone_Len=TailCone_Len, ThreadedTC=true, Extra_OD=TailConeExtra_OD,
				LowerHalfOnly=false, UpperHalfOnly=true, HasWireHoles=false);
/**/
/*
	rotate([180,0,0]) FC2_FinCan(Body_OD=Body_OD, Body_ID=Body_ID, Can_Len=Can_Len,
				MotorTube_OD=MotorTube_OD, RailGuide_h=RailGuide_h, RailGuideLen=RailGuideLen,
				nFins=nFins, HasIntegratedCoupler=true, HasMotorSleeve=true, HasAftIntegratedCoupler=false,
				Fin_Root_W=Fin_Root_W, Fin_Root_L=Fin_Root_L, Fin_Post_h=Fin_Post_h, Fin_Chamfer_L=Fin_Chamfer_L,
				Cone_Len=TailCone_Len, ThreadedTC=true, Extra_OD=TailConeExtra_OD,
				LowerHalfOnly=true, UpperHalfOnly=false, HasWireHoles=false);
/**/
/*
  FC2_MotorRetainer(Body_OD=Body_OD,
						MotorTube_OD=MotorTube_OD, MotorTube_ID=MotorTube_ID,
						HasWrenchCuts=false, Cone_Len=TailCone_Len, ExtraLen=0, Extra_OD=TailConeExtra_OD);
/**/
//
// RocketFin();
//
// rotate([90,0,0]) BoltOnRailGuide(Length = RailGuideLen, BoltSpace=12.7, RoundEnds=true, ExtraBack=0);
// rotate([-90,0,0]) RailGuideSpacer(OD=Body_OD, H=RailGuide_h, Length = RailGuideLen, BoltSpace=12.7);
//
// ***********************************
//  ***** Routines *****
//
//
// ***********************************
//  ***** for Viewing *****
//
// ShowRocket();
// translate([300,0,0]) ShowRocket(ShowInternals=true);
//
// ***********************************
include<TubesLib.scad>
use<RailGuide.scad>
use<Fins.scad>
use<NoseCone.scad>
use<ElectronicsBayLib.scad>
use<FinCan2Lib.scad>
use<AltBay.scad>
use<BatteryHolderLib.scad>
use<SpringThingBooster.scad>
use<PetalDeploymentLib.scad>
use<ThreadLib.scad>
use<SpringEndsLib.scad>
use<R75Lib.scad>

//also included
 //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

nPetals=3;
nLockBalls=5;
RailGuideLen=35;

nFins=5;
Fin_Post_h=10;
Fin_Root_L=190;
Fin_Root_W=8;
Fin_Tip_W=3.0;
Fin_Tip_L=83;
Fin_Span=83;
Fin_TipOffset=24;
Fin_Chamfer_L=22;

ForwardPetal_Len=200; // Main 'chute and lots of shock cord
AftPetal_Len=150; // Drogue

Body_OD=BT75Body_OD;
Body_ID=BT75Body_ID;
Coupler_OD=BT75Coupler_OD;
Coupler_ID=BT75Coupler_ID;

// *** 38mm Motor Tube ***
MotorTube_OD=BT54Body_OD;
MotorTube_ID=BT54Body_ID;
MotorCoupler_OD=BT54Coupler_OD;

MotorTubeHole_d=MotorTube_OD+IDXtra*3;

NC_Len=212;
NC_Tip_r=6;
NC_Wall_t=1.8;
NC_Base_L=15;

MainBay_Len=8.5*25.4;
EBay_Len=162;
BodyTubeLen=16*25.4;
MotorTubeLen=16*25.4;

FinInset_Len=10;
Can_Len=Fin_Root_L+FinInset_Len*2;
TailCone_Len=35;
TailConeExtra_OD=1;
Bolt4Inset=4;
RailGuide_h=Body_OD/2+2;

module ShowRocket(ShowInternals=false, DualDeploy=false, ShowDoors=false){
	FinCan_Z=35;
	Fin_Z=FinCan_Z+Fin_Root_L/2+FinInset_Len;
	BodyTube_Z=FinCan_Z+Can_Len+Overlap*2;
	EBay_Z=BodyTube_Z+BodyTubeLen+33.5;
	UpperBallLock_Z=EBay_Z+EBay_Len+18.5;
	NoseCone_Z=DualDeploy? MainBay_Len+29+EBay_Z+EBay_Len+2+Overlap*2:EBay_Z+EBay_Len+2+Overlap*2;

	
	//*
	translate([0,0,NoseCone_Z]){
		BluntOgiveNoseCone(ID=Coupler_OD, OD=Body_OD, L=NC_Len, Base_L=13, 
							Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=0, LowerPortion=false);
		rotate([0,0,-30]) color("LightGreen")
			NC_ShockcordRing75(Body_OD=Body_OD, Body_ID=Body_ID, NC_Base_L=NC_Base_L);}
	
	if (DualDeploy){
	
		if (ShowInternals==false)
			translate([0,0,UpperBallLock_Z+10]) color("LightBlue") Tube(OD=Body_OD, ID=Body_ID, 
				Len=MainBay_Len-Overlap*2, myfn=$preview? 90:360);
		//*
		if (ShowInternals==false)
			translate([0,0,UpperBallLock_Z]) rotate([180,0,0])
				STB_TubeEnd(BallPerimeter_d=Body_OD, nLockBalls=nLockBalls, Body_OD=Body_OD, 
								Body_ID=Body_ID, Skirt_Len=20);
		/**/
		translate([0,0,UpperBallLock_Z]) rotate([180,0,0]) color("Tan") R75_BallRetainerTop();
	
	}
	translate([0,0,EBay_Z]) Electronics_Bay(DualDeploy=DualDeploy, ShowDoors=ShowDoors);
	
	translate([0,0,BodyTube_Z+BodyTubeLen+15+Overlap*2])
		color("Tan") R75_BallRetainerTop();
	/**/
	
	if (ShowInternals){
		translate([0,0,BodyTube_Z+BodyTubeLen+15+Overlap*2-0.2]) R75_BallRetainerBottom();
		translate([0,0,BodyTube_Z+BodyTubeLen+15+Overlap*2-9.2]) rotate([0,0,200]) rotate([180,0,0]) 
			PD_PetalHub(OD=BT75Coupler_OD, nPetals=nPetals, ShockCord_a=ShockCord_a);
		translate([0,0,BodyTube_Z+BodyTubeLen+15+Overlap*2-15]) 
			rotate([0,0,200]) rotate([180,0,0]) PD_Petals(OD=Coupler_OD, Len=150, nPetals=nPetals);
	}
	
	if (ShowInternals==false)
	translate([0,0,BodyTube_Z+BodyTubeLen+15])
		STB_TubeEnd(BallPerimeter_d=Body_OD, nLockBalls=nLockBalls, Body_OD=Body_OD, Body_ID=Body_ID, Skirt_Len=20);
	
	if (ShowInternals==false)
	translate([0,0,BodyTube_Z]) color("LightBlue") Tube(OD=Body_OD, ID=Body_ID, 
			Len=BodyTubeLen-Overlap*2, myfn=$preview? 90:360);
	
	if (ShowInternals)
	translate([0,0,FinCan_Z-23]) color("Blue") Tube(OD=MotorTube_OD, ID=MotorTube_ID, 
			Len=MotorTubeLen-Overlap*2, myfn=$preview? 90:360);
			
	translate([0,0,FinCan_Z]) color("White") FinCan(LowerHalfOnly=false, UpperHalfOnly=false);
	
	//*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j])
		translate([Body_OD/2-Fin_Post_h, 0, Fin_Z]) 
			rotate([0,90,0]) color("Yellow") RocketFin();
	/**/
	
	translate([0,0,FinCan_Z-0.2]) MotorRetainer(ShowCut=false);
} // ShowRocket

//ShowRocket(DualDeploy=true, ShowDoors=true);
//ShowRocket(ShowInternals=true);
				
module RocketFin(){
	
	TrapFin2(Post_h=Fin_Post_h, Root_L=Fin_Root_L, Tip_L=Fin_Tip_L, Root_W=Fin_Root_W,
				Tip_W=Fin_Tip_W, Span=Fin_Span, Chamfer_L=Fin_Chamfer_L,
				TipOffset=Fin_TipOffset,
				Bisect=false, Bisect_X=0,
				HasSpar=false, Spar_d=8, Spar_L=100);
				
	if ($preview==false){
		translate([-Fin_Root_L/2+4,0,0]) 
			cylinder(d=12, h=0.9); // Neg
		translate([Fin_Root_L/2-4,0,0]) 
			cylinder(d=12, h=0.9); // Pos
	}
	
} // RocketFin

//RocketFin();




































