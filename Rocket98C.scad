// ***********************************
// Project: 3D Printed Rocket
// Filename: Rocket98C.scad
// by David M. Flynn
// Created: 10/23/2023 
// Revision: 1.2.0  12/28/2023 
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  Upscale of Rocket65
//  Rocket with 98mm Body and 54mm motor. 
//
//  Dual deploy:
//   Mission Control V3 / RocketServo
//
//  ***** Parts *****
//
// BlueTube 2.0 4" Body Tube by 10.5 inches Forward Bay
// BlueTube 2.0 4" Body Tube by 19 inches minimum Lower Body
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
// 1.2.0  12/28/2023 Added CableReleaseBB w/ Guide Point for night launch version
// 1.1.1  12/24/2023 Moved FinCan() into FinCan2Lib.scad
// 1.1.0  12/22/2023 Night Launch version parts added
// 1.0.2  10/30/2023 Ready for first printing.
// 1.0.1  10/29/2023 Added MotorTubeTopper(), removed obsolete routines
// 1.0.0  10/23/2023 Copied from Rocket75C Rev 1.1.1
//
// ***********************************
//  ***** for STL output *****
//
// *** Nosecode ***
//
// BluntOgiveNoseCone(ID=Coupler_OD, OD=Body_OD, L=NC_Len, Base_L=NC_Base_L, Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=0, LowerPortion=false);

// BluntOgiveNoseCone(ID=Coupler_OD, OD=Body_OD, L=NC_Len, Base_L=NC_Base_L, Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=120, LowerPortion=false);

// BluntOgiveNoseCone(ID=Coupler_OD, OD=Body_OD, L=NC_Len, Base_L=NC_Base_L, Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=120, Transition_OD=BT75Body_OD-18, LowerPortion=true);
//
CouplerLenXtra=-10;
//
// *** Dual Deploy Electronics Bay ***
//
// NC_ShockcordRingDual(Tube_OD=Body_OD, Tube_ID=Body_ID, NC_Base_L=NC_Base_L, nRivets=3);
// 
// ST_SpringMiddle(Tube_ID=BT54Coupler_OD);
//
// PD_NC_PetalHub(OD=Coupler_OD, nPetals=nPetals, nRopes=6);
// rotate([-90,0,0]) PD_PetalSpringHolder(Coupler_OD=Coupler_OD);
// rotate([180,0,0]) PD_Petals(Coupler_OD=Coupler_OD, Len=ForwardPetalLen, nPetals=nPetals, AntiClimber_h=3);
//
// EB_Electronics_Bay(Tube_OD=Body_OD, Tube_ID=Body_ID, Len=EBay_Len, nBolts=3, BoltInset=7.5, ShowDoors=false, HasSecondBattDoor=true);
//
// *** Doors ***
//
// rotate([-90,0,0]) AltDoor54(Tube_OD=Body_OD, IsLoProfile=true, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowAlt=true);
// 
// rotate([-90,0,0]) Batt_Door(Tube_OD=Body_OD, InnerTube_OD=0, HasSwitch=true);
// rotate([-90,0,0]) Batt_Door(Tube_OD=Body_OD, InnerTube_OD=0, HasSwitch=false);
//
// *** Ball Lock ***
//
// STB_LockDisk(BallPerimeter_d=Body_OD, nLockBalls=nLockBalls);
// rotate([180,0,0]) R98C_BallRetainerTop();
// R98_BallRetainerBottom();
// rotate([180,0,0]) STB_TubeEnd(BallPerimeter_d=Body_OD, nLockBalls=nLockBalls, Body_OD=Body_OD, Body_ID=Body_ID, Skirt_Len=20);
//
// *** petal deployer ***
//
// PD_PetalHub(OD=Coupler_OD, nPetals=nPetals, ShockCord_a=PD_ShockCordAngle());
// rotate([-90,0,0]) PD_PetalSpringHolder(Coupler_OD=Coupler_OD);
// rotate([180,0,0]) PD_Petals(Coupler_OD=Coupler_OD, Len=AftPetalLen, nPetals=nPetals, AntiClimber_h=3);
//
// rotate([180,0,0]) SpringTop();
// ST_SpringMiddle(Tube_ID=BT54Coupler_OD);
// MotorTubeTopper();
//
// *** Fin Can ***
/*
rotate([180,0,0]) FC2_FinCan(Body_OD=Body_OD, Body_ID=Body_ID, Can_Len=Can_Len, 
						MotorTube_OD=MotorTube_OD, RailGuide_h=RailGuide_h,
						nFins=nFins,
						Fin_Root_W=Fin_Root_W, Fin_Root_L=Fin_Root_L, 
						Fin_Post_h=Fin_Post_h, Fin_Chamfer_L=Fin_Chamfer_L,
						Cone_Len=TailCone_Len, 
						LowerHalfOnly=false, UpperHalfOnly=false, HasWireHoles=false);
/**/
// RocketFin();
/*
FC2_MotorRetainer(Body_OD=Body_OD, 
					MotorTube_OD=MotorTube_OD, MotorTube_ID=MotorTube_ID,
					Cone_Len=TailCone_Len);
/**/
// **************************************
// *** Night Flight Version Parts ***
// CRBB_ExtensionRod(Len=90);
// rotate([180,0,0]) CRBB_LockingPin(LockPin_Len=40, GuidePoint=true);
// rotate([180,0,0]) CRBB_LockRing(GuidePoint=true);
// rotate([180,0,0]) CRBB_TopRetainer(LockRing_d=LockRingDiameter(), GuidePoint=true);
// CRBB_OuterBearingRetainer();
// rotate([180,0,0]) CRBB_InnerBearingRetainer();
// rotate([180,0,0]) CRBB_MagnetBracket();
// rotate([180,0,0]) CRBB_TriggerPost();

// CRBB_TopRetainerEBayEnd(Body_OD=Body_OD, Body_ID=Body_ID);
//
// Electronics_BayDual(Tube_OD=Body_OD, Tube_ID=Body_ID, ShowDoors=false, HasSecondBattDoor=false);
//
// PD_NC_PetalHub(OD=Coupler_OD-IDXtra, nPetals=nPetals, nRopes=6, ShockCord_a=60, HasThreadedCore=true);
//
// rotate([180,0,0]) MotorTubeTopperNL();
// CenteringRing(OD=Coupler_ID, ID=MotorTube_OD+IDXtra*2, Thickness=5, nHoles=5, Offset=0);
//
/*
rotate([180,0,0]) 
FC2_FinCan(Body_OD=Body_OD, Body_ID=Body_ID, Can_Len=Can_Len, 
						MotorTube_OD=MotorTube_OD, RailGuide_h=RailGuide_h,
						nFins=nFins,
						Fin_Root_W=Fin_Root_W, Fin_Root_L=Fin_Root_L, 
						Fin_Post_h=Fin_Post_h, Fin_Chamfer_L=Fin_Chamfer_L,
						Cone_Len=TailCone_Len, 
						LowerHalfOnly=false, UpperHalfOnly=false, HasWireHoles=true);
/**/
// NightLaunchFin();
/*
FC2_MotorRetainer(Body_OD=Body_OD, 
					MotorTube_OD=MotorTube_OD, MotorTube_ID=MotorTube_ID,
					Cone_Len=TailCone_Len);
/**/
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
use<AltBay.scad>
use<BatteryHolderLib.scad>
use<SpringThingBooster.scad> SpringThingBoosterRev();
use<PetalDeploymentLib.scad>
use<SpringThing2.scad>
use<SpringEndsLib.scad>
use<CableReleaseBB.scad> echo(CableReleaseBBRev());


//also included
 //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

Scale=1.46726; //BT98Coupler_OD/LOC65Body_OD
echo("Scale on Rocket65 = ",Scale);

nFins=5;
//*
// Standard
Fin_Post_h=12;
Fin_Root_L=160*Scale;
Fin_Root_W=6*Scale;
Fin_Tip_W=3.0;
Fin_Tip_L=70*Scale;
Fin_Span=70*Scale;
Fin_TipOffset=20*Scale;
Fin_Chamfer_L=18*Scale;
/**/
/*
// fatter for night flight
Fin_Post_h=12;
Fin_Root_L=160*Scale;
Fin_Root_W=12; //6*Scale;
Fin_Tip_W=3.0;
Fin_Tip_L=70*Scale;
Fin_Span=70*Scale;
Fin_TipOffset=20*Scale;
Fin_Chamfer_L=18*Scale;
/**/

Body_OD=BT98Body_OD;
Body_ID=BT98Body_ID;
Coupler_OD=BT98Coupler_OD;
Coupler_ID=BT98Coupler_ID;

// *** 54mm Motor Tube ***
MotorTube_OD=BT54Body_OD;
MotorTube_ID=BT54Body_ID;
MotorCoupler_OD=BT54Coupler_OD;


NC_Len=180*Scale;
NC_Tip_r=5*Scale;
NC_Wall_t=1.8;
NC_Base_L=15;

ForwardPetalLen=180;
ForwardTubeLen=10.5*25.4;
EBay_Len=162;
AftPetalLen=150;
MotorTubeLen=19.5*25.4;
BodyTubeLen=19*25.4; // Range 19-22

Alt_DoorXtra_X=6;
Alt_DoorXtra_Y=4;

FinInset_Len=5*Scale;
Can_Len=Fin_Root_L+FinInset_Len*2;
Bolt4Inset=4;
nLockBalls=6;
nPetals=3;
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
	
	if (ShowInternals) translate([0,0,NoseCone_Z-20]) ST_SpringMiddle(Tube_ID=BT54Coupler_OD);
	if (ShowInternals) translate([0,0,NoseCone_Z-54.2]) rotate([180,0,0]) NC_PetalHub();
	
	if (ShowInternals) translate([0,0,NoseCone_Z-60.2]) rotate([180,0,0])
		PD_Petals(Coupler_OD=Coupler_OD, Len=180, nPetals=nPetals, AntiClimber_h=3);
							
	/**/
	
	//*
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

module FinLightBattHolder(){
	
	Len=40;
	Batt_t=16.5+IDXtra;
	Batt_w=26+IDXtra;
	Batt_Y=Coupler_OD/2-10.9;
	
	Batt_a=47;
	
	module Pocket(){
		RoundRect(X=Batt_w+2.4, Y=Batt_t+2.4, Z=Len, R=2+1.2);
	}
	
	difference(){
		union(){
			translate([-Coupler_OD/2+1,0,0]) cube([(Coupler_OD-MotorTube_OD)/2-2,4,Len]);
			mirror([1,0,0])
			translate([-Coupler_OD/2+1,0,0]) cube([(Coupler_OD-MotorTube_OD)/2-2,4,Len]);
			for (j=[0:1]) rotate([0,0,Batt_a*j]) translate([0,Batt_Y,0]) Pocket();
			Tube(OD=Coupler_OD, ID=Coupler_ID, Len=Len, myfn=$preview? 36:360);
			Tube(OD=MotorTube_OD+IDXtra*3+2.4, ID=MotorTube_OD+IDXtra*3, Len=Len, myfn=$preview? 36:360);
		} // union
	
		translate([-Coupler_OD/2-1,IDXtra*2,-Overlap]) mirror([0,1,0]) cube([Coupler_OD+2,Coupler_OD/2+1,Len+Overlap*2]);
		
		translate([-Coupler_OD/2+10,0,12]) rotate([90,0,0]) Bolt4Hole();
		translate([-Coupler_OD/2+10,0,Len-12]) rotate([90,0,0]) Bolt4Hole();
		translate([Coupler_OD/2-10,7,12]) rotate([-90,0,0]) Bolt4HeadHole(lHead=30);
		translate([Coupler_OD/2-10,7,Len-12]) rotate([-90,0,0]) Bolt4HeadHole(lHead=30);
		
		for (j=[0:1]) rotate([0,0,Batt_a*j]){
			translate([0,Batt_Y,-Overlap]) cylinder(d=10,h=3);
			translate([0,Batt_Y,2]) RoundRect(X=Batt_w, Y=Batt_t, Z=Len, R=2);
		}
	} // difference
} // FinLightBattHolder

//FinLightBattHolder();

module LampClamp(){
	OD=54;
	ID=38.5;
	H=4;
	BC=47;
	nBolts=6;
	
	difference(){
		cylinder(d=OD, h=H);
		
		translate([0,0,-Overlap]) cylinder(d=ID, h=H+Overlap*2);
		
		for (j=[0:nBolts]) rotate([0,0,360/nBolts*j])
			translate([0,BC/2,H]) Bolt4ButtonHeadHole();
	} // difference
} // LampClamp

//translate([0,0,30.2]) LampClamp();

module LampHolder(){
	H=30;
	OD=54;
	BC=47;
	nBolts=6;
	
	difference(){
		cylinder(d=OD, h=H);
		
		translate([0,0,H-1]) cylinder(d=43.5, h=5);
		
		translate([0,0,-Overlap]) cylinder(d=24, h=H+Overlap*2);
		
		translate([0,0,-Overlap]) cylinder(d1=45, d2=24, h=20);
		
		for (j=[0:nBolts]) rotate([0,0,360/nBolts*j])
			translate([0,BC/2,H]) Bolt4Hole();
		
		// Keying notches
		rotate([0,0,30]) translate([0,OD/2-3,H])
			cube([8.5,10,2],center=true);
			
		rotate([0,0,135+30]) translate([0,OD/2-3,H])
			cube([7,10,2],center=true);
			
		rotate([0,0,-135+30]) translate([0,OD/2-3,H])
			cube([7,10,2],center=true);
		
		// Batteries
		for (j=[0:3]) rotate([0,0,90*j+45]) translate([0,0,-Overlap]) hull(){
			translate([-20,OD/2-2,0]) cube([40,10,15]);
			translate([-20,OD/2,20]) cube([40,10,1]);
		}
	} // difference
} // LampHolder

//LampHolder();

module R98_NightLaunchNC_Base(Tube_OD=Body_OD, Tube_ID=Body_ID, nRivets=3){


	// Big Spring
	Spring_CS4009_OD=2.328*25.4;
	Spring_CS4009_ID=2.094*25.4;
	Spring_CS4009_FL=18.5*25.4;
	Spring_CS4009_CL=1.64*25.4;
	// Small Spring
	Spring_CS4323_OD=44.30;
	Spring_CS4323_ID=40.50;
	Spring_CS4323_CBL=22; // coil bound length
	Spring_CS4323_FL=200; // free length

	Plate_t=4;
	nHoles=6;
	Rivet_d=4;
	Tube_d=12.7;
	Tube_Z=30;
	CR_z=-3;
	Spring_OD=(Tube_OD>110)? Spring_CS4009_OD:Spring_CS4323_OD;
	BodyTube_L=15;
	SpringEnd_Z=10;
	SpringSplice_OD=BT54Body_ID;
	Extension=20;
	nBatteries=4;

	module LightAndBatteries(){
		for (j=[0:nBatteries-1]) rotate([0,0,360/nBatteries*j+45])
			translate([0,Tube_ID/2-15,0]) SingleBatteryPocket(ShowBattery=false);
	} // LightAndBatteries
	
	module BattEjectHoles(){
		for (j=[0:nBatteries-1]) rotate([0,0,360/nBatteries*j+45]){
			translate([0,Tube_ID/2-15,-10]) cylinder(d=12, h=20);
			translate([0,Tube_ID/2-15,0]) RoundRect(X=28,Y=18,Z=50,R=3);
			}
	} // BattEjectHoles
	
	translate([0,0,38]) LampHolder();
	
	difference(){
		union(){
			LightAndBatteries();
			
			//Skirt
			translate([0,0,CR_z]) Tube(OD=54, ID=45, Len=25+Extension, myfn=$preview? 90:360);
			
			// Stop ring
			translate([0,0,CR_z]) Tube(OD=Tube_OD, ID=Tube_ID-1, Len=3+Extension, myfn=$preview? 90:360);
	
			// Nosecone interface
			translate([0,0,-1+Extension]) Tube(OD=Tube_ID-IDXtra*2, 
									ID=Tube_ID-IDXtra*2-4.4, Len=NC_Base_L+1, myfn=$preview? 90:360);
			// Body tube interface
			translate([0,0,-BodyTube_L-3]) Tube(OD=Tube_ID, 
									ID=Tube_ID-4.4, Len=BodyTube_L+1, myfn=$preview? 90:360);
				
			// Stiffener Plate
			translate([0,0,-5])
				cylinder(d=Tube_ID-1, h=6);
				
			// Tube holder
			hull(){
				translate([0,0,Tube_Z]) 
					rotate([0,90,0]) cylinder(d=Tube_d+4.4, h=Tube_ID-4, center=true);
				translate([0,0,CR_z+5]) cube([Tube_ID-4, Tube_d+12, 10],center=true);
			} // hull
			
			// Spring Holder
			cylinder(d1=SpringSplice_OD+8, d2=Spring_OD+6, h=SpringEnd_Z+4);
		} // union
		
		//translate([-4,-34,4]) FW_GPS_SW_Hole(-9);
		
		// Nosecone rivets
		for (j=[0:nRivets-1]) rotate([0,0,360/nRivets*j]) translate([0,-Tube_ID/2-1,NC_Base_L/2+Extension])
			rotate([-90,0,0]){ cylinder(d=Rivet_d, h=10); 
			translate([0,0,3.2]) cylinder(d=Rivet_d*2, h=6);}
		
		// Center hole
		translate([0,0,-6]) cylinder(d=Spring_OD-6, h=Tube_Z+30);
		
		// Spring
		translate([0,0,SpringEnd_Z]) rotate([180,0,0]) {
			cylinder(d=Spring_OD, h=30);
			translate([0,0,4]) cylinder(d1=Spring_OD, d2=Spring_OD+4, h=8);
			translate([0,0,12-Overlap]) cylinder(d=Spring_OD+4, h=30);
			}
		
		// Tube hole
		translate([0,0,Tube_Z]) rotate([0,90,0]) cylinder(d=Tube_d, h=Tube_OD, center=true);
		
		// Retention cord
		for (j=[0:nHoles-1]) rotate([0,0,360/nHoles*j]) translate([0,Tube_ID/2-8,-10]) cylinder(d=4, h=30);
		
		BattEjectHoles();
		
		//if ($preview) cube([50,50,50]);
	} // difference
	
} // R98_NightLaunchNC_Base

//R98_NightLaunchNC_Base();

module R98_UpperSpringMiddle(){
// costom version of ST_SpringMiddle()

	ST_DSpring_OD=44.30;
	ST_DSpring_ID=40.50;
	Len=48;
	nRopes=6;
	OD=93;
	
	Tube(OD=ST_DSpring_OD+6, ID=ST_DSpring_OD+IDXtra*3, 
			Len=Len, myfn=$preview? 90:360);
			
	translate([0,0,Len*0.4]) Tube(OD=ST_DSpring_ID-0.5, ID=ST_DSpring_ID-6, 
			Len=Len*0.6, myfn=$preview? 90:360);
			
	translate([0,0,Len/2-1.5]) Tube(OD=ST_DSpring_OD+1, ID=ST_DSpring_ID-5, 
			Len=3, myfn=$preview? 90:360);
			
	Tube(OD=OD, ID=89, 
			Len=35, myfn=$preview? 90:360);
	difference(){
		cylinder(d1=92, d2=ST_DSpring_OD+1, h=35);
		
		translate([0,0,-3]) cylinder(d1=92, d2=ST_DSpring_OD+1, h=35);
		translate([0,0,-Overlap]) cylinder(d=ST_DSpring_OD+1, h=35+Overlap*2);
		for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j]) translate([0,OD/2-7,-Overlap])
			cylinder(d=10,h=Len);
	} // difference


} // R98_UpperSpringMiddle

//R98_UpperSpringMiddle();

module R98_LowerSpringMiddle(){
// costom version of ST_SpringMiddle()

	SE_SlidingSpringMiddle(OD=Coupler_OD, nRopes=6);

} // R98_LowerSpringMiddle

//R98_LowerSpringMiddle();
// SE_SlidingSpringMiddle(OD=Coupler_OD-IDXtra, nRopes=6, SliderLen=40, SpLen=35, SpringStop_Z=20);

module R98_LowerSpringBottom(){
// costom version of ST_SpringMiddle()

	ST_DSpring_OD=44.30;
	ST_DSpring_ID=40.50;
	Len=12;
	nRopes=6;
	OD=Coupler_OD;
	
	//Tube(OD=ST_DSpring_OD+IDXtra*3+4.4, ID=ST_DSpring_OD+IDXtra*3, 
	//		Len=Len, myfn=$preview? 90:360);
			
	//Tube(OD=ST_DSpring_ID-0.5, ID=ST_DSpring_ID-0.5-4.4, 
	//		Len=Len, myfn=$preview? 90:360);
			
	//translate([0,0,Len/2-1.5]) Tube(OD=ST_DSpring_OD+1, ID=ST_DSpring_ID-5, 
	//		Len=3, myfn=$preview? 90:360);
			
	Tube(OD=OD, ID=OD-4.4, 
			Len=Len, myfn=$preview? 90:360);
			
	difference(){
		translate([0,0,Len-5]) cylinder(d=OD-1, h=5);
		
		translate([0,0,Len-3]) cylinder(d=ST_DSpring_OD, h=5);
		translate([0,0,-Overlap]) cylinder(d=ST_DSpring_ID-1, h=35+Overlap*2);
		for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j]) translate([0,OD/2-7,-Overlap])
			cylinder(d=4,h=Len+Overlap*2);
	} // difference


} // R98_LowerSpringBottom

//rotate([180,0,0]) R98_LowerSpringBottom();


module R98_BallRetainerBottom(){
	difference(){
		STB_BallRetainerBottom(BallPerimeter_d=Body_OD, Body_OD=Body_ID, 
				nLockBalls=nLockBalls, HasSpringGroove=false);
		
		rotate([0,0,PD_ShockCordAngle()-ShockCord_a]) 
			PD_PetalHubBoltPattern(Coupler_OD=Coupler_OD, nPetals=nPetals) Bolt4Hole();

	} // difference
} // R98_BallRetainerBottom

// translate([0,0,-9]) rotate([180,0,0]) R98_BallRetainerBottom();
//rotate([0,0,152]) PD_PetalHub(Coupler_OD=Coupler_OD, nPetals=nPetals, ShockCord_a=PD_ShockCordAngle());


module NC_ShockcordRing(){
	Plate_t=4;
	Tube_d=12.7;
	EBayCouplerID=Body_ID-IDXtra-4.4;
	
	Tube(OD=EBayCouplerID-IDXtra*2, ID=EBayCouplerID-10, Len=5, myfn=$preview? 36:360);
	difference(){
		union(){
			translate([0,0,4])
				cylinder(d1=Body_OD-NC_Wall_t*2-IDXtra*2, d2=Body_OD-NC_Wall_t*2-IDXtra*4, h=Plate_t);
				
			hull(){
				translate([0,0,7+Tube_d/2]) 
					rotate([0,90,0]) cylinder(d=Tube_d+4.4, h=EBayCouplerID-2, center=true);
					
				translate([0,0,6]) cube([EBayCouplerID-2,Tube_d+8,Overlap],center=true);
			} // hull
		} // union
		
		cylinder(d=	Body_OD-30, h=30);
		
		translate([0,0,7+Tube_d/2]) rotate([0,90,0]) cylinder(d=Tube_d, h=Body_OD, center=true);
	} // difference
	
} // NC_ShockcordRing

//NC_ShockcordRing();

module SpringTop(){
	ST_DSpring_OD=44.30;
	nRopes=6;
	Piston_Len=50;
	
	translate([0,0,-10]) Tube(OD=Coupler_OD, ID=Coupler_OD-4.4, Len=Piston_Len, myfn=$preview? 90:360);
	
	
	difference(){
		union(){
			cylinder(d=MotorCoupler_OD, h=10+Overlap);
			
			//translate([0,0,10]) cylinder(d=Coupler_OD, h=2+Overlap);
			translate([0,0,10]) cylinder(d=Coupler_OD, h=5+Overlap);
			//translate([0,0,10]) Tube(OD=Coupler_ID-1, ID=Coupler_ID-6, Len=10, myfn=$preview? 36:360);
		} // union
		
		translate([0,0,-Overlap]) cylinder(d1= MotorCoupler_OD-4.4, d2=ST_DSpring_OD, h=10);
		cylinder(d= ST_DSpring_OD, h=13);
		cylinder(d= ST_DSpring_OD-6, h=20);
		for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j]) translate([0,Coupler_OD/2-7,-Overlap])
			cylinder(d=4,h=Piston_Len+Overlap*2);
	} // difference
} // SpringTop

//rotate([180,0,0]) 
//translate([0,0,50]) 
//SpringTop();

module R98C_BallRetainerTop(){
	Tube_d=12.7;
	Tube_Z=31;
	Tube_a=-6;
	TubeSlot_w=35;
	TubeOffset_X=22;
	
	difference(){
		union(){
			STB_BallRetainerTop(BallPerimeter_d=Body_OD, Body_OD=Body_ID, nLockBalls=nLockBalls,
								HasIntegratedCouplerTube=true, IntegratedCouplerLenXtra=CouplerLenXtra,
								Body_ID=Body_ID-IDXtra, HasSecondServo=false, UsesBigServo=true);
				
			translate([0,0,35.5]) 
				Tube(OD=Body_ID-IDXtra, ID=Body_ID-IDXtra-6, Len=5, myfn=$preview? 90:360);
			
			// Shock cord retention
			difference(){
				union(){
					rotate([0,0,Tube_a]) translate([TubeOffset_X,0,Tube_Z]) 
						rotate([90,0,0]) cylinder(d=Tube_d+6, h=Body_ID-2, center=true);
					rotate([0,0,Tube_a]) translate([TubeOffset_X,0,Tube_Z-12.2])
						cube([Tube_d-3, Body_ID-2, 21], center=true);
				} // union
				
				rotate([0,0,Tube_a]) translate([TubeOffset_X,0,Tube_Z]) 
					rotate([90,0,0]) cylinder(d=Tube_d+7, h=TubeSlot_w, center=true);
				rotate([0,0,Tube_a]) translate([TubeOffset_X,0,Tube_Z-12.2])
					cube([Tube_d-1, TubeSlot_w,21.1], center=true);
					
				Tube(OD=Body_OD+20, ID=Body_ID-1, Len=50, myfn=$preview? 90:360);
			} // difference
		} // union
	
		translate([TubeOffset_X,0,Tube_Z]) rotate([90,0,Tube_a]) cylinder(d=Tube_d, h=Body_OD, center=true);
	} // difference
} // R98C_BallRetainerTop

// rotate([180,0,0]) R98C_BallRetainerTop();

module EBay_ShockcordRingDual(){
// obsolete part
	Plate_t=4;
	Tube_d=12.7;
	CR_z=-3;
	
	translate([0,0,-5]) Tube(OD=Body_OD, ID=Body_ID, Len=20, myfn=$preview? 36:360);
	translate([0,0,15])
	
	difference(){
		union(){
			 Tube(OD=Body_ID-IDXtra*2, ID=Body_ID-4.4, Len=15, myfn=$preview? 36:360);
			translate([0,0,-3])
				cylinder(d1=Body_ID, d2=Body_OD-NC_Wall_t*2-IDXtra*4, h=Plate_t);
				
			translate([0,0,-5])
				cylinder(d=Body_OD-1, h=5);
				
			hull(){
				translate([0,0,CR_z+3+Tube_d/2]) 
					rotate([0,90,0]) cylinder(d=Tube_d+4.4, h=Body_ID-3, center=true);
				translate([0,0,CR_z+2]) cube([Body_ID-4,Tube_d+8,Overlap],center=true);
			} // hull
		} // union
		
		translate([0,0,-6]) cylinder(d=Body_OD-30, h=30);
		
		translate([0,0,CR_z+3+Tube_d/2]) rotate([0,90,0]) cylinder(d=Tube_d, h=Body_OD, center=true);
	} // difference
	
} // EBay_ShockcordRingDual

//translate([0,0,-15]) color("Green") EBay_ShockcordRingDual();

module MotorTubeTopper(){
// Z zero is top of motor tube
// Sits on top of motor tube
// Has Rail Guide bolt holes
// Has centering ring
// Has shock cord attachment tube
// Has spring holder

	Al_Tube_d=12.7;
	Al_Tube_Z=-Al_Tube_d/2-5;
	
	ST_DSpring_OD=44.30;
	ST_DSpring_ID=40.5;

	difference(){
		union(){
			translate([0,0,-20]) 
				Tube(OD=MotorTube_ID, ID=MotorTube_ID-8, Len=21, myfn=$preview? 36:360);
			translate([0,0,-20]) 
				Tube(OD=MotorTube_OD+8, ID=MotorTube_OD+IDXtra*3, Len=21, myfn=$preview? 36:360);
			translate([0,0,-20]) 
				Tube(OD=Body_ID-IDXtra*2, ID=Body_ID-16, Len=21, myfn=$preview? 36:360);
			CenteringRing(OD=Body_ID, ID=ST_DSpring_ID, Thickness=5, nHoles=0, Offset=0);
			translate([0,0,4]) 
				Tube(OD=ST_DSpring_OD+8, ID=ST_DSpring_OD, Len=8, myfn=$preview? 36:360);
		} // union
	
		//translate([0,0,-20]) Tube(OD=MotorTube_ID, ID=MotorTube_ID-6, Len=21, myfn=$preview? 36:360);
		
		translate([0,0,3]) cylinder(d=ST_DSpring_OD, h=4+Overlap);
		translate([0,0,7]) cylinder(d1=ST_DSpring_OD, d2=ST_DSpring_OD+4, h=5+Overlap);
		
		translate([0,0,Al_Tube_Z]) rotate([90,0,0]) cylinder(d=Al_Tube_d+IDXtra, h=Body_OD, center=true);
		
		translate([Body_OD/2, 0, -9]) {
			translate([0,0,6.35]) rotate([0,90,0]) Bolt6Hole();
			translate([0,0,-6.35]) rotate([0,90,0]) Bolt6Hole();
		}
	} // difference

} // MotorTubeTopper

// MotorTubeTopper();


module MotorTubeTopperNL(){
// Z zero is top of motor tube
// Sits on top of motor tube
// Has centering ring
// Has shock cord attachment tube

	Al_Tube_d=12.7;
	Al_Tube_Z=-Al_Tube_d/2-5;
	
	difference(){
		union(){
			translate([0,0,-20]) 
				Tube(OD=MotorTube_ID, ID=MotorTube_ID-8, Len=21, myfn=$preview? 36:360);
			translate([0,0,-20]) 
				Tube(OD=MotorTube_OD+8, ID=MotorTube_OD+IDXtra*3, Len=21, myfn=$preview? 36:360);
			translate([0,0,-20]) 
				Tube(OD=Coupler_ID-IDXtra*2, ID=Coupler_ID-13, Len=21, myfn=$preview? 36:360);
			CenteringRing(OD=Coupler_ID, ID=MotorTube_ID-8, Thickness=5, nHoles=0, Offset=0);
			
		} // union
		
		translate([0,0,Al_Tube_Z]) rotate([90,0,0]) 
			cylinder(d=Al_Tube_d+IDXtra, h=Body_OD, center=true);
		
	} // difference

} // MotorTubeTopperNL

// MotorTubeTopperNL();


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

module NightLaunchFin(){
	PCB_X=80+5;
	PCB_Y=8+0.5;
	PCB_Z=3;
	
	
	RocketFin();
		
	translate([0,0,0.6+PCB_Z/2]) cube([PCB_X,PCB_Y,PCB_Z],center=true);
	
} // NightLaunchFin

// NightLaunchFin();













































