// ***********************************
// Project: 3D Printed Rocket
// Filename: Rocket98Goblin.scad
// by David M. Flynn
// Created: 3/19/2024 
// Revision: 1.3.2  3/21/2024 
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  Rocket with 98mm Body and 54mm motor. 
//
//   Mission Control V3 / RocketServo
//
//  ***** Parts *****
//
// BlueTube 2.0 4" Body Tube by 18 inches minimum Lower Body
// Blue Tube 2.1" Body Tube by 12 inches minimum Motor Tube (Fits 54/852 case)
// 45" Parachute
// 1/2" Braided Nylon Shock Cord (30 feet)
//
//  ***** Hardware *****
//
// #6-32 x 3/4" Button Head Cap Screw (4 req) Rail Guides
// #4-40 x 1/2" Socket Head Cap Screw (6 req) Ball Lock
// #4-40 x 3/8" Button Head Cap Screw (10 req) Doors
// #4-40 x 3/8" Socket Head Cap Screw (3 req) PetalHub
// #4-40 x 1/4" Button Head Cap Screw (4 req) Altimeter
// #4-40 x 1/4" Button Head Cap Screw (6 req) Petals
// #4-40 x 3/8" Button Socket Head Cap Screw (4 req) Servos
// 1/2" x 0.035" wall Aluminum tubing, 2ea 80mm Shock cord mounts
// MR84-2RS Bearing (8 req) Ball Lock
// 3/8" Delrin Ball (6 req) Ball Lock
// 4mm Dia. x 10mm Undersize Steel Dowel (6 req) Ball Lock
// 4mm Dia. x 16mm Undersize Steel Dowel (3 req) Ball Lock
// 3/16" Dia x 1/8" Disc Magnet N42 (2 req) Ball Lock
// HX5010 or Eqiv. Standard Servo (1 req) Ball Lock
// C&K Rotary Switch (1 req) Battery Door
// Mission Control V3 Altimeter PCBA
// Rocket Servo PCBA (1 req)
// 1/4" Rail Guides (30mm long) (2 req)
// Spring 0.3" Dia x 1.25" PN:CS3715 (3 Req) Petals
// Spring 1.4" Dia x 8" PN:CS4323 (2 Req) Deployment
//
//  ***** History *****
//
// 1.3.2  3/21/2024  Little fixes.
// 1.3.1  3/20/2024  Reworked ShowRocket(), updated parts list, removed unused parts.
// 1.3.0  3/19/2024  Copied from Rocket98C
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
//
CouplerLenXtra=-10;
//
// NC_ShockcordRingDual(Tube_OD=Body_OD, Tube_ID=Body_ID, NC_Base_L=NC_Base_L, nRivets=3);
//
// Electronics_BayDual(Tube_OD=Body_OD, Tube_ID=Body_ID, ShowDoors=false, HasSecondBattDoor=false);
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
// rotate([-90,0,0]) PD_PetalSpringHolder(OD=Coupler_OD);
// rotate([180,0,0]) PD_Petals(OD=Coupler_OD, Len=PetalLen, nPetals=nPetals, AntiClimber_h=3);
//
// rotate([180,0,0]) SpringTop();
// SpringMiddle();
// MotorTubeTopper();
//
// *** Fin Can ***
// FinCan(LowerHalfOnly=false, UpperHalfOnly=false);
//
// RocketFin();
//
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
$fn=$preview? 36:90;

nFins=4;
// Standard
Fin_Post_h=18;
Fin_Root_L=160;
Fin_Root_W=14;
Fin_Tip_W=5;
Fin_Tip_L=90;
Fin_TipInset=-50;
Fin_Span=178+Fin_TipInset;
Fin_TipOffset=45;
Fin_Chamfer_L=12;
Fin_HasBluntTip=false;


Body_OD=BT98Body_OD;
Body_ID=BT98Body_ID;
Coupler_OD=BT98Coupler_OD;
Coupler_ID=BT98Coupler_ID;

// *** 54mm Motor Tube ***
MotorTube_OD=BT54Body_OD;
MotorTube_ID=BT54Body_ID;
MotorCoupler_OD=BT54Coupler_OD;
MotorTubeHole_d=MotorTube_OD+IDXtra*3;

NC_Len=270;
NC_Tip_r=12;
NC_Wall_t=1.8;
NC_Base_L=15;

EBay_Len=162;
PetalLen=150;
MotorTubeLen=12*25.4;
BodyTubeLen=17*25.4;

Alt_DoorXtra_X=6;
Alt_DoorXtra_Y=4;

FinInset_Len=5;
Can_Len=Fin_Root_L+FinInset_Len*2;
Bolt4Inset=4;
nLockBalls=6;
nPetals=3;
ShockCord_a=17;// offset between PD_PetalHub and R65_BallRetainerBottom
RailGuide_h=Body_OD/2+2;

module ShowRocket(ShowInternals=false){
	FinCan_Z=0;
	Fin_Z=FinCan_Z+Fin_Root_L/2+FinInset_Len;
	BodyTube_Z=FinCan_Z+Can_Len+Overlap*2;
	AftTubeEnd_Z=BodyTube_Z+BodyTubeLen+10;
	AftBallLock_Z=BodyTube_Z+BodyTubeLen+9;
	EBay_Z=AftBallLock_Z+24.5;
	
	
	NoseCone_Z=EBay_Z+EBay_Len+3.4;
	

	translate([0,0,NoseCone_Z]) color("Gray")
		BluntOgiveNoseCone(ID=Coupler_OD, OD=Body_OD, L=NC_Len, Base_L=NC_Base_L, 
							Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=0, LowerPortion=false);
							
	translate([0,0,NoseCone_Z-0.2]) rotate([0,0,90]) color("Gray")
		NC_ShockcordRingDual(Tube_OD=Body_OD, Tube_ID=Body_ID, NC_Base_L=NC_Base_L, nRivets=3);
	
	
	//*
	translate([0,0,EBay_Z]) color("Yellow") 
		Electronics_BayDual(Tube_OD=Body_OD, Tube_ID=Body_ID, ShowDoors=(ShowInternals==false));
	translate([0,0,AftBallLock_Z]) color("Yellow") 
		R98C_BallRetainerTop();
	if (ShowInternals) translate([0,0,AftBallLock_Z-0.2]) 
		R98_BallRetainerBottom();
	/**/
	
	if (ShowInternals==false) translate([0,0,AftTubeEnd_Z]) color("Gray")
		STB_TubeEnd(BallPerimeter_d=Body_OD, nLockBalls=nLockBalls, Body_OD=Body_OD, Body_ID=Body_ID, Skirt_Len=20);

	
	//*
	if (ShowInternals) translate([0,0,AftBallLock_Z-8.8]) rotate([0,0,200]) rotate([180,0,0]) 
			PD_PetalHub(OD=Body_ID, nPetals=3, ShockCord_a=PD_ShockCordAngle());
			
	if (ShowInternals) translate([0,0,AftBallLock_Z-17]) rotate([0,0,200]) rotate([180,0,0]) 
		PD_Petals(OD=Coupler_OD, Len=150, nPetals=nPetals, AntiClimber_h=3);	
	
	if (ShowInternals) translate([0,0,MotorTubeLen+50]){
		translate([0,0,35]) SpringTop();
		translate([0,0,15]) rotate([180,0,0]) SpringMiddle();
		//ST_SpringMiddle(Tube_ID=BT54Coupler_OD);
	}
	if (ShowInternals) translate([0,0,MotorTubeLen+12]) rotate([0,0,180]) color("Gray") MotorTubeTopper();
	/**/
	
	
	if (ShowInternals==false)
	translate([0,0,BodyTube_Z]) color("Yellow") Tube(OD=Body_OD, ID=Body_ID, 
			Len=BodyTubeLen-Overlap*2, myfn=$preview? 90:360);
	
	translate([0,0,FinCan_Z]) color("Yellow") FinCan(LowerHalfOnly=false, UpperHalfOnly=false);

	//*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j])
		translate([Body_OD/2-Fin_Post_h, 0, Fin_Z]) 
			rotate([0,90,0]) color("Yellow") RocketFin();
	/**/
	
	if (ShowInternals) translate([0,0,12]) color("Blue") 
		Tube(OD=MotorTube_OD, ID=MotorTube_ID, Len=MotorTubeLen, myfn=90);
	
	if (ShowInternals) translate([0,0,10]) ATRMS_54_852_Motor(Extended=true, HasEyeBolt=true);
	
	
} // ShowRocket

//ShowRocket();
//ShowRocket(ShowInternals=true);

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

module SpringMiddle(){

	SE_SlidingSpringMiddle(OD=Coupler_OD-IDXtra, nRopes=6, SliderLen=40, SpLen=35, SpringStop_Z=20);

} // SpringMiddle

//SpringMiddle();


module R98_BallRetainerBottom(){
	difference(){
		STB_BallRetainerBottom(BallPerimeter_d=Body_OD, Body_OD=Body_ID, 
				nLockBalls=nLockBalls, HasSpringGroove=false);
		
		rotate([0,0,PD_ShockCordAngle()-ShockCord_a]) 
			PD_PetalHubBoltPattern(OD=Coupler_OD, nPetals=nPetals) Bolt4Hole();

	} // difference
} // R98_BallRetainerBottom

// translate([0,0,-9]) rotate([180,0,0]) R98_BallRetainerBottom();
//rotate([0,0,152]) PD_PetalHub(Coupler_OD=Coupler_OD, nPetals=nPetals, ShockCord_a=PD_ShockCordAngle());

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

module Electronics_BayDual(Tube_OD=Body_OD, Tube_ID=Body_ID, ShowDoors=false, HasSecondBattDoor=true){
	// made NC coupler IDXtra smaller 6/22/23

	Len=EBay_Len;
	Altimeter_Z=Len/2;
	BattSwDoor_Z=Len/2;

	Alt_a=0;
	Batt1_a=HasSecondBattDoor? 90:120;
	Batt2_a=HasSecondBattDoor? 180:240;
	Batt3_a=270;
	
	difference(){
		Tube(OD=Tube_OD, ID=Tube_ID, Len=Len, myfn=$preview? 36:360);
		
		// Altimeter
		translate([0,0,Altimeter_Z]) rotate([0,0,Alt_a]) 
			Alt_BayFrameHole(Tube_OD=Tube_OD, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y);
			
		// Battery and Switch door holes
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
			Batt_BayFrameHole(Tube_OD=Tube_OD, HasSwitch=false);
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt2_a]) 
			Batt_BayFrameHole(Tube_OD=Tube_OD, HasSwitch=true);
			
		if (HasSecondBattDoor)
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt3_a]) 
			Batt_BayFrameHole(Tube_OD=Tube_OD, HasSwitch=true);
			
	} // difference
	
	// Altimeter
	translate([0,0,Altimeter_Z]) rotate([0,0,Alt_a])
		Alt_BayDoorFrame(Tube_OD=Tube_OD, Tube_ID=Tube_ID, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowDoor=ShowDoors);
	
	// Battery and Switch doors
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
		Batt_BayDoorFrame(Tube_OD=Tube_OD, HasSwitch=false, ShowDoor=ShowDoors);
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt2_a]) 
		Batt_BayDoorFrame(Tube_OD=Tube_OD, HasSwitch=true, ShowDoor=ShowDoors);
		
	if (HasSecondBattDoor)
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt3_a]) 
		Batt_BayDoorFrame(Tube_OD=Tube_OD, HasSwitch=true, ShowDoor=ShowDoors);
	
} // Electronics_BayDual

// Electronics_BayDual(ShowDoors=false, HasSecondBattDoor=false);

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
	
	nRopes=6;
	Rope_d=4;

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
		
		translate([0,0,-Overlap]) for (j=[0:nRopes]) rotate([0,0,360/nRopes*(j+0.5)])
			translate([0,(Body_ID-16)/2-Rope_d/2-2]) cylinder(d=Rope_d+IDXtra, h=5+Overlap*2);
			
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


module FinCan(LowerHalfOnly=false, UpperHalfOnly=false){
	Wall_t=1.2;
	FinBox_W=Fin_Root_W+Wall_t*2;
	RailGuide_a=180/nFins;
	RailGuide_Z=35;
	Retainer_d=63;
	Retainer_L=30;
	
	//echo(nFins=nFins);
	
	difference(){
		union(){
			// Body Tube
			Tube(OD=Body_OD, ID=Body_OD-Wall_t*2, Len=Can_Len, myfn=$preview? 36:360);
			// Motor Tube Sleeve
			Tube(OD=MotorTubeHole_d+Wall_t*2, ID=MotorTubeHole_d, Len=Can_Len, myfn=$preview? 36:360);
			// Motor Retainer Sleeve
			Tube(OD=Retainer_d+Wall_t*2, ID=MotorTubeHole_d, Len=Retainer_L+10, myfn=$preview? 36:360);
			
			// integrated coupler
			translate([0,0,Can_Len-Overlap])
				Tube(OD=Body_ID-IDXtra, ID=Body_ID-4, Len=10, myfn=$preview? 36:360);
			difference(){
				translate([0,0,Can_Len-5])
					Tube(OD=Body_OD-1, ID=Body_ID-4, Len=5, myfn=$preview? 36:360);
				translate([0,0,Can_Len-5-Overlap]) cylinder(d1=Body_OD-Wall_t*2, d2=Body_ID-5, h=5);
			} // difference
			
				
			// Middle Centering Rings
			translate([0,0,Can_Len/2-3])
				rotate([0,0,180/nFins])
					CenteringRing(OD=Body_OD-1, ID=MotorTubeHole_d, Thickness=6, nHoles=nFins, Offset=0);
			
			// Base Centering Rings
			CenteringRing(OD=Body_OD-1, ID=MotorTubeHole_d, Thickness=6, nHoles=0, Offset=0);
			
			// Fin Boxes
			difference(){
			
				for (j=[0:nFins-1]) rotate([0,0,360/nFins*j]) 
					translate([0,-FinBox_W/2,0]) cube([Body_OD/2,FinBox_W,Can_Len]);
					
				difference(){
					translate([0,0,-Overlap]) cylinder(d=Body_OD+10, h=Can_Len+Overlap*2);
					translate([0,0,-Overlap*2]) cylinder(d=Body_OD-1, h=Can_Len+Overlap*4);
				} // difference
				
				translate([0,0,-Overlap]) cylinder(d=MotorTubeHole_d, h=Can_Len+Overlap*2);
			} // difference
			
			translate([0,0,RailGuide_Z]) rotate([0,0,RailGuide_a]) 
				RailGuidePost(OD=Body_OD, MtrTube_OD=MotorTubeHole_d, H=RailGuide_h, 
					TubeLen=50, Length = 30, BoltSpace=12.7);
		} // union
	
		// Fin Sockets
		translate([0,0,Fin_Root_L/2+FinInset_Len])
			TrapFin2Slots(Tube_OD=Body_OD, nFins=nFins, Post_h=Fin_Post_h, 
					Root_L=Fin_Root_L, Root_W=Fin_Root_W, Chamfer_L=Fin_Chamfer_L);
		
		// Rail guide bolt holes
		translate([0,0,RailGuide_Z]) rotate([0,0,RailGuide_a]) translate([0,Body_OD/2,0]) 
			RailGuideBoltPattern(BoltSpace=12.7) Bolt6Hole();
		
		// Motor Retainer hole
		translate([0,0,-Overlap]) cylinder(d=Retainer_d+IDXtra*2, h=Retainer_L);
		
		if (LowerHalfOnly) translate([0,0,Can_Len/2]) cylinder(d=Body_OD+1, h=Can_Len/2+50);
		if (UpperHalfOnly) translate([0,0,Can_Len/2]) 
			rotate([180,0,0]) cylinder(d=Body_OD+1, h=Can_Len/2+50);
			
		//if ($preview) translate([0,0,-1]) cube([Body_OD/2+10,Body_OD/2+10,Can_Len+50]);
	} // difference
} // FinCan

//FinCan(LowerHalfOnly=false, UpperHalfOnly=false);


module RocketFin(){
	
	TrapFin2(Post_h=Fin_Post_h, Root_L=Fin_Root_L, Tip_L=Fin_Tip_L, Root_W=Fin_Root_W, Tip_W=Fin_Tip_W, Span=Fin_Span, Chamfer_L=Fin_Chamfer_L, TipOffset=Fin_TipOffset, TipInset=Fin_TipInset, HasBluntTip=Fin_HasBluntTip);
				
	if ($preview==false){
		translate([-Fin_Root_L/2+4,0,0]) 
			cylinder(d=Fin_Root_W+6, h=0.9); // Neg
		translate([Fin_Root_L/2-4,0,0]) 
			cylinder(d=Fin_Root_W+6, h=0.9); // Pos
	}
	
} // RocketFin

//RocketFin();












































