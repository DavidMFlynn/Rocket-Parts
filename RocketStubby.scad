// ***********************************
// Project: 3D Printed Rocket
// Filename: RocketStubby.scad
// by David M. Flynn
// Created: 4/18/2025 
// Revision: 0.9.1  4/21/2025 
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
// 0.9.1  4/21/2025  Printing....
// 0.9.0  4/18/2025  First code
//
// ***********************************
//  ***** for STL output *****
//
// *** Nosecode ***
//
// BluntOgiveNoseCone(ID=Body_ID, OD=Body_OD, L=NC_Len, Base_L=NC_Base_L, nRivets=6, Tip_R=NC_Tip_r, HasThreadedTip=false, Wall_T=NC_Wall_t, Cut_d=0, LowerPortion=false, FillTip=true);
// 
// NC_ShockcordRingDual(Tube_OD=Body_OD, Tube_ID=Body_ID, NC_ID=0, NC_Base_L=NC_Base_L, nRivets=6, nBolts=6, Flat=true, UseHardSpring=true);
// 
// SkirtPlateSpringHolder();
// SkirtPlate(Coupler_OD=Coupler_OD, Coupler_ID=Coupler_ID, Engagemnet_Len=7);
// rotate([180,0,0]) PusherRing(OD=Coupler_OD, ID=Coupler_ID, OA_Len=UpperPusherRingLen, Engagemnet_Len=7, Wall_t=4, nBolts=0);
// rotate([180,0,0]) PusherRing(OD=Coupler_OD, ID=Coupler_ID, OA_Len=LowerPusherRingLen, Engagemnet_Len=7, Wall_t=4, nBolts=nLockBalls);
// SkirtRing(Coupler_OD=Coupler_OD, Coupler_ID=Coupler_ID, Engagemnet_Len=7);
//
// *** EBay ***
//
// rotate([180,0,0]) EBay(TopOnly=true, BottomOnly=false, ShowDoors=false);
// EBay(TopOnly=false, BottomOnly=true, ShowDoors=false);
//
// CenteringRing(OD=Body_ID, ID=MotorTube_OD+IDXtra*2, Thickness=EBayCR_t, nHoles=8); // Print 2
//
// *** Doors ***
//
// rotate([-90,0,0]) EB_AltDoor(Tube_OD=Body_OD, BlankDoor=false);
// 
// rotate([-90,0,0]) EB_BattDoor(Tube_OD=Body_OD, HasSwitch=true, DoubleBatt=false, BlankDoor=false);
// rotate([-90,0,0]) EB_BattDoor(Tube_OD=Body_OD, HasSwitch=false, DoubleBatt=false, BlankDoor=false);
//
// rotate([-90,0,0]) EB_AltDoor(Tube_OD=Body_OD, BlankDoor=true);
// 
// rotate([-90,0,0]) EB_BattDoor(Tube_OD=Body_OD, HasSwitch=true, DoubleBatt=false, BlankDoor=true);
// rotate([-90,0,0]) EB_BattDoor(Tube_OD=Body_OD, HasSwitch=false, DoubleBatt=false, BlankDoor=true);
//
// *** Ball Lock ***
//
// BallRetainerBottom();
// STB_BallRetainerTop(Outer_OD=Body_OD, Body_OD=Body_ID, nLockBalls=nLockBalls, HasIntegratedCouplerTube=true, nBolts=nEBay_Bolts, Body_ID=Body_ID, HasSecondServo=true, UsesBigServo=true, Engagement_Len=Engagement_Len, HasLargeInnerBearing=true, Xtra_r=0.2);
// STB_LockDisk(Body_ID=Body_ID, nLockBalls=nLockBalls, HasLargeInnerBearing=true);
// rotate([180,0,0]) STB_TubeEnd(Body_ID=Body_ID, nLockBalls=nLockBalls, Body_OD=Body_OD, Engagement_Len=Engagement_Len);
//
//
// *** Fin Can ***
//
// FinCan(LowerHalfOnly=false, UpperHalfOnly=true);
// rotate([180,0,0]) FinCan(LowerHalfOnly=true, UpperHalfOnly=false);
// RocketFin();
// MotorRetainer();
//
// **************************************
//
// rotate([90,0,0]) BoltOnRailGuide(Length = 30, BoltSpace=12.7, RoundEnds=true);
// rotate([-90,0,0]) RailGuideSpacer(OD=Body_OD, H=RailGuide_h, Length = 30, BoltSpace=12.7);
//
// **************************************
//  *** Tools ***
//
// TubeTest(OD=Body_OD, ID=Body_ID, TestOD=false);
// TubeTest(OD=Body_OD, ID=Body_ID, TestOD=true);
// BodyDrillingJig(Tube_OD=Body_OD, Tube_ID=Body_ID, nBolts=6, BoltInset=7.5);
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
use<SpringEndsLib.scad>


//also included
 //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

nFins=5;

Fin_Post_h=20;
Fin_Root_L=350;
Fin_Root_W=18;
Fin_Tip_W=3.0;
Fin_Tip_L=120;
Fin_Span=170;
Fin_TipOffset=80;
Fin_Chamfer_L=70;
FinInset_Len=15;

Body_OD=222.1;
Body_ID=215.9;
Coupler_OD=Body_ID-1;
Coupler_ID=Coupler_OD-4.4;

// *** 54mm Motor Tube ***
MotorTube_OD=ULine75Body_OD;
MotorTube_ID=ULine75Body_ID;

NC_Len=320;
NC_Tip_r=25;
NC_Wall_t=2.2;
NC_Base_L=15;

Engagement_Len=25;
RailGuideLen=40;

LowerPusherRingLen=50;
UpperPusherRingLen=125;

	
EBayBoltInset=7.5;
EBayCR_t=3;
EBay_Len=166;
nEBay_Bolts=10;

MotorTubeLen=640;
BodyTubeLen=510;


Can_Len=Fin_Root_L+FinInset_Len*2;
Bolt4Inset=4;
nLockBalls=7;
nPetals=5;
ShockCord_a=17;// offset between PD_PetalHub and R65_BallRetainerBottom
TailCone_Len=80;
RailGuide_h=Body_OD/2+2;

module ShowRocket(ShowInternals=false){
	FinCan_Z=35;
	MotorTube_Z=-TailCone_Len+42;
	Fin_Z=FinCan_Z+Fin_Root_L/2+FinInset_Len;
	EBay_Z=FinCan_Z+Can_Len+0.2;
	AftBallLock_Z=EBay_Z+EBay_Len+0.2+50-12.5;
	AftTubeEnd_Z=AftBallLock_Z+0.2;
	
	SkirtRing_Z=AftBallLock_Z+Engagement_Len/2+0.4;
	PusherRing_Z=SkirtRing_Z+4.2;
	UpperPusherRing_Z=PusherRing_Z+LowerPusherRingLen;
	
	BodyTube_Z=AftTubeEnd_Z+28-15;
	NoseCone_Z=BodyTube_Z+BodyTubeLen+3.4;
	
	//*
	translate([0,0,NoseCone_Z]) color("Orange")
		BluntOgiveNoseCone(ID=Coupler_OD, OD=Body_OD, L=NC_Len, Base_L=NC_Base_L, nRivets=6, Tip_R=NC_Tip_r, HasThreadedTip=false, Wall_T=NC_Wall_t, Cut_d=0, LowerPortion=false, FillTip=true);
							
	translate([0,0,NoseCone_Z-13-0.2]) rotate([0,0,90]) 
		NC_ShockcordRingDual(Tube_OD=Body_OD, Tube_ID=Body_ID, NC_ID=0, NC_Base_L=NC_Base_L, nRivets=6, nBolts=6, Flat=true, UseHardSpring=true);
								
	/**/
	
	translate([0,0,EBay_Z]) EBay(TopOnly=false, BottomOnly=false, ShowDoors=!ShowInternals);
	
	if (!ShowInternals) translate([0,0,AftTubeEnd_Z]) color("Orange")
		rotate([180,0,0]) STB_TubeEnd(Body_ID=Body_ID, nLockBalls=nLockBalls, Body_OD=Body_OD, Engagement_Len=Engagement_Len);
	
	if (!ShowInternals)
	translate([0,0,BodyTube_Z]) color("LightBlue") 
		Tube(OD=Body_OD, ID=Body_ID, Len=BodyTubeLen-Overlap*2, myfn=$preview? 90:360);
	
	if (ShowInternals) translate([0,0,UpperPusherRing_Z+UpperPusherRingLen+4.4]) color("Tan") 
		SkirtPlateSpringHolder();
	
	if (ShowInternals) translate([0,0,UpperPusherRing_Z+UpperPusherRingLen+4.4]) color("Green") rotate([180,0,0])
		SkirtPlate(Coupler_OD=Coupler_OD, Coupler_ID=Coupler_ID, Engagemnet_Len=7);
		
	if (ShowInternals) translate([0,0,UpperPusherRing_Z+UpperPusherRingLen+0.2]) color("Gray") rotate([180,0,0])
		PusherRing(OD=Coupler_OD, ID=Coupler_ID, OA_Len=UpperPusherRingLen, Engagemnet_Len=7, Wall_t=4, nBolts=0);
		
	if (ShowInternals) translate([0,0,PusherRing_Z]) color("Tan")
		PusherRing(OD=Coupler_OD, ID=Coupler_ID, OA_Len=LowerPusherRingLen, Engagemnet_Len=7, Wall_t=4, nBolts=nLockBalls);
// 
	if (ShowInternals) translate([0,0,AftBallLock_Z+Engagement_Len/2+0.2]) color("Green")
		SkirtRing(Coupler_OD=Coupler_OD, Coupler_ID=Coupler_ID, Engagemnet_Len=7);


	if (ShowInternals) translate([0,0,AftBallLock_Z+0.2]) rotate([180,0,0]) BallRetainerBottom();
	
	translate([0,0,AftBallLock_Z]) rotate([180,0,0])
		STB_BallRetainerTop(Outer_OD=Body_OD, Body_OD=Body_ID, nLockBalls=nLockBalls, HasIntegratedCouplerTube=true, nBolts=nEBay_Bolts, Body_ID=Body_ID, HasSecondServo=true, UsesBigServo=true, Engagement_Len=Engagement_Len, HasLargeInnerBearing=true, Xtra_r=0.2);
	
	translate([0,0,FinCan_Z]) color("White") 
		FinCan(LowerHalfOnly=false, UpperHalfOnly=false);

	
	//*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j+180/nFins])
		translate([0,Body_OD/2-Fin_Post_h, Fin_Z]) 
			rotate([-90,0,0]) color("Orange") RocketFin();
	/**/
	
	if (ShowInternals) translate([0,0,MotorTube_Z]) color("Blue") 
		Tube(OD=MotorTube_OD, ID=MotorTube_ID, Len=MotorTubeLen, myfn=90);
	
	translate([0,0,MotorTube_Z-18]) color("Gray") MotorRetainer();
	
	if (ShowInternals) translate([0,0,MotorTube_Z]) 
	//translate([0,0,-20]) ATRMS_54_1706_Motor(Extended=true, HasEyeBolt=true);
	//translate([0,0,-20]) ATRMS_75_2560_Motor(Extended=false, HasEyeBolt=true);
	ATRMS_75_3840_Motor(Extended=false, HasEyeBolt=true);
	
} // ShowRocket

//ShowRocket();
//ShowRocket(ShowInternals=true);

module SkirtRing(Coupler_OD=Coupler_OD, Coupler_ID=Coupler_ID, Engagemnet_Len=7){
	Plate_t=4;
	ID=Coupler_ID-16;
	
	difference(){
		union(){
			cylinder(d=Coupler_ID, h=Plate_t+Engagemnet_Len, $fn=$preview? 90:360);
			cylinder(d=Coupler_OD, h=Plate_t, $fn=$preview? 90:360);
		} // union
		
		// Remove Center
		translate([0,0,-Overlap]) cylinder(d=ID, h=Plate_t+Engagemnet_Len+Overlap*2, $fn=$preview? 90:360);
		translate([0,0,Plate_t]) cylinder(d1=ID, d2=Coupler_ID-4.4, h=Engagemnet_Len+Overlap, $fn=$preview? 90:360);
		
		translate([0,0,7])
			PusherBoltPattern() Bolt4HeadHole(depth=8,lHead=20);
	} // difference
} // SkirtRing

// SkirtRing();

module SkirtPlateBoltPattern(){
	nBolts=6;
	BC_d=SE_Spring_CS11890_OD()+16;

	for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) translate([0,BC_d/2,0]) children();
} // SkirtPlateBoltPattern

module SkirtPlate(Coupler_OD=Coupler_OD, Coupler_ID=Coupler_ID, Engagemnet_Len=7){
	Plate_t=4;
	ID=SE_Spring_CS11890_ID();
	nHoles=12;
	Hole_d=Coupler_ID/2-8-(SE_Spring_CS11890_OD()+32)/2-12;
	BC_d=Coupler_ID-12-Hole_d;
	nRopes=6;
	Rope_d=4;
	
	difference(){
		union(){
			cylinder(d=Coupler_ID, h=Plate_t+Engagemnet_Len, $fn=$preview? 90:360);
			cylinder(d=Coupler_OD, h=Plate_t, $fn=$preview? 90:360);
		} // union
		
		// Lightening holes
		for (j=[0:nHoles-1]) rotate([0,0,360/nHoles*j]) translate([0,BC_d/2,-Overlap])
			hull(){
				cylinder(d=Hole_d, h=Plate_t+Engagemnet_Len+Overlap*2);
				translate([0,-Hole_d/2,0]) cylinder(d=Hole_d/1.5, h=Plate_t+Engagemnet_Len+Overlap*2);
			} // hull
		
		// Center hole
		translate([0,0,-Overlap]) cylinder(d=ID, h=Plate_t+Engagemnet_Len+Overlap*2);
		
		// Rope holes
		for (j=[0:nRopes]) rotate([0,0,180/nHoles+360/nRopes*j]) translate([0,Coupler_ID/2-4-Rope_d/2,-Overlap])
			cylinder(d=Rope_d, h=Plate_t+Engagemnet_Len+Overlap*2);
		
		// Bolt holes
		SkirtPlateBoltPattern() rotate([180,0,0]) Bolt4Hole(depth=Plate_t+Engagemnet_Len+1);
	} // difference
	
} // SkirtPlate

// SkirtPlate(Coupler_OD=Coupler_OD, Coupler_ID=Coupler_ID, Engagemnet_Len=7);

module SkirtPlateSpringHolder(){
	Spring_OD=SE_Spring_CS11890_OD();
	Tube_OD=Spring_OD+8;
	Plate_OD=Spring_OD+24;
	Plate_t=8;
	OAL=100;
	
	
	difference(){
		union(){
			cylinder(d=Plate_OD, h=Plate_t);
			cylinder(d=Tube_OD, h=OAL);
		} // union
		
		// center hole
		translate([0,0,-Overlap]) cylinder(d=Spring_OD, h=OAL+Overlap*2);
		translate([0,0,6]) cylinder(d1=Spring_OD, d2=Spring_OD+2, h=5);
		translate([0,0,11-Overlap]) cylinder(d=Spring_OD+2, h=OAL+Overlap*2);
		
		// Bolts
		translate([0,0,Plate_t]) SkirtPlateBoltPattern() Bolt4HeadHole();
	} // difference
} // SkirtPlateSpringHolder

// SkirtPlateSpringHolder();


module PusherRing(OD=Coupler_OD, ID=Coupler_ID, OA_Len=50, Engagemnet_Len=7, Wall_t=4, nBolts=0){
	
	translate([0,0,Engagemnet_Len]) difference(){
		union(){
			Tube(OD=OD, ID=OD-Wall_t*2, Len=OA_Len-Engagemnet_Len, myfn=$preview? 90:720);
			translate([0,0,-Engagemnet_Len]) Tube(OD=OD, ID=ID, Len=OA_Len, myfn=$preview? 90:720);
		} // union
		
		// Reduce mass by thinning inside
		A=OA_Len-Engagemnet_Len-18;
		if (A>0){
			translate([0,0,3]) cylinder(d1=OD-Wall_t*2-Overlap, d2=ID, h=6, $fn=$preview? 90:720);
			translate([0,0,9-Overlap]) cylinder(d=ID, h=A+Overlap*2, $fn=$preview? 90:720);
			translate([0,0,9+A]) cylinder(d2=OD-Wall_t*2-Overlap, d1=ID, h=6, $fn=$preview? 90:720);
		}
		
		if (nBolts>0)
			translate([0,0,-Engagemnet_Len])
					PusherBoltPattern() Bolt4HeadHole(lHead=15+Engagemnet_Len);
	} // difference
} // PusherRing

// rotate([180,0,0]) translate([0,0,4.2]) PusherRing(OD=Coupler_OD, ID=Coupler_ID, OA_Len=50, Engagemnet_Len=7, Wall_t=4, nBolts=nLockBalls);

module PusherBoltPattern(){
	for (j=[0:nLockBalls-1]) rotate([0,0,360/nLockBalls*(j+0.5)]) 
		translate([0,Body_ID/2-6,0]) children();
} // PusherBoltPattern

module BallRetainerBottom(){
	difference(){
		STB_BallRetainerBottom(Body_ID=Body_ID, Body_OD=Body_ID, nLockBalls=nLockBalls, Engagement_Len=Engagement_Len, HasLargeInnerBearing=true, Xtra_r=0.2);
		
		translate([0,0,-Engagement_Len/2]) PusherBoltPattern() rotate([180,0,0]) Bolt4Hole(depth=Engagement_Len/2+2);
			
	} // difference
} // BallRetainerBottom

// BallRetainerBottom();

module EBay(TopOnly=false, BottomOnly=false, ShowDoors=false){
	TubeStop_Z=EBayBoltInset*2+EBayCR_t+1.9;
	echo(TubeStop_Z=TubeStop_Z);
	
	DoorAngles=$preview? [[],[45],[-45]]:[[0,180],[45,180+45],[-45,-90,180-45,180-90]]; // Altimeters, Alt_Batts, SW_Bats
	//DoorAngles=$preview? [[],[45],[-45]]:[[0],[45],[-45]]; // Altimeters, Alt_Batts, SW_Bats
	ExtraBolts=[];
	
	EB_Electronics_BayUniversal(Tube_OD=Body_OD, Tube_ID=Body_ID, DoorAngles=DoorAngles, Len=EBay_Len, 
									nBolts=nEBay_Bolts, BoltInset=EBayBoltInset, ShowDoors=ShowDoors,
									HasFwdIntegratedCoupler=false, HasFwdShockMount=false,
									HasAftIntegratedCoupler=false, HasAftShockMount=false,
									HasRailGuide=false, RailGuideLen=35,
									HasFwdCenteringRing=false, HasAftCenteringRing=false, InnerTube_OD=BT54Body_OD,
									Bolted=true, ExtraBolts=ExtraBolts, TopOnly=TopOnly, BottomOnly=BottomOnly);
									
	// Bottom centering ring stop
	if (!TopOnly) translate([0,0,TubeStop_Z]) 
		TubeStop(InnerTubeID=Coupler_ID, OuterTubeOD=Body_OD, myfn=$preview? 36:360);
		
	// Top centering ring stop
	if (!BottomOnly) translate([0,0,EBay_Len-TubeStop_Z]) rotate([180,0,0])
		TubeStop(InnerTubeID=Coupler_ID, OuterTubeOD=Body_OD, myfn=$preview? 36:360);
} // EBay

// EBay();

module RocketFin(){
			
	TrapFin3(Post_h=Fin_Post_h, Root_L=Fin_Root_L, Tip_L=Fin_Tip_L, Root_W=Fin_Root_W, Tip_W=Fin_Tip_W, Span=Fin_Span, Chamfer_L=Fin_Chamfer_L,
				TipOffset=Fin_TipOffset, TipInset=0, HasBluntTip=false, TipPost_h=0,
				Bisect=false, Bisect_X=0,
				HasSpar=false, Spar_d=8, Spar_L=100, PrinterBrim_H=0.8, HasSpiralVaseRibs=false);
		
} // RocketFin

//RocketFin();


module FinCan(LowerHalfOnly=false, UpperHalfOnly=false, HasIntegratedEBay=false, ShowDoors=false){
	Wall_t=1.4;
	nBolts=6;
	FwdTubeLen=20;
	AltimeterDoor_Z=Can_Len-Can_Len/4;
	BatteryDoor_Z=AltimeterDoor_Z;
	
	DoorAngles=[[180/nFins+360/nFins*4],[180/nFins+360/nFins*3],[180/nFins+360/nFins*5]];
	
	AltDoorAngles=DoorAngles[0];
	BattDoorAngles=DoorAngles[1];
	BattSWDoorAngles=DoorAngles[2];

	difference(){
		FC2_FinCan(Body_OD=Body_OD, Body_ID=Body_ID, Can_Len=Can_Len,
				MotorTube_OD=MotorTube_OD, RailGuide_h=RailGuide_h, RailGuide_z=0,
				nFins=nFins, HasIntegratedCoupler=!HasIntegratedEBay, Coupler_Len=15, nCouplerBolts=nEBay_Bolts,
				HasMotorSleeve=true, HasAftIntegratedCoupler=false,
				Fin_Root_W=Fin_Root_W, Fin_Root_L=Fin_Root_L, Fin_Post_h=Fin_Post_h, Fin_Chamfer_L=Fin_Chamfer_L,
				Cone_Len=TailCone_Len, ThreadedTC=false, Extra_OD=0, RailGuideLen=RailGuideLen,
				LowerHalfOnly=LowerHalfOnly, UpperHalfOnly=UpperHalfOnly, HasWireHoles=false, HollowTailcone=true, 
				HollowFinRoots=true, Wall_t=Wall_t, OgiveTailCone=true, Ogive_Len=TailCone_Len, OgiveCut_d=MotorTube_OD+30,
				UseTrapFin3=true);
				
		if (HasIntegratedEBay){
		// Wire holes
		for (j=[0:nFins-1]) rotate([0,0,180/nFins+360/nFins*j]) translate([0,MotorTube_OD/2+20,Can_Len-Can_Len/4]) hull(){
			rotate([0,90,0]) cylinder(d=10, h=Fin_Root_W+6, center=true);
			translate([0,0,10]) rotate([0,90,0]) cylinder(d=10, h=Fin_Root_W+6, center=true);
		} // hull
		
		// cut outs for door frames
		for (j=AltDoorAngles) rotate([0,0,j]) 
			translate([0,0,AltimeterDoor_Z]) EB_AltDoorFrameHole(Tube_OD=Body_OD);
			
		for (j=BattDoorAngles) rotate([0,0,j]) 
			translate([0,0,BatteryDoor_Z]) EB_BattDoorFrameHole(Tube_OD=Body_OD, HasSwitch=false);

		for (j=BattSWDoorAngles) rotate([0,0,j]) 
			translate([0,0,BatteryDoor_Z]) EB_BattDoorFrameHole(Tube_OD=Body_OD, HasSwitch=true);
		}
		
		// Motor Retainer
		translate([0,0,-TailCone_Len]) cylinder(d=90+IDXtra*3, h=25);
	} // difference
				
	if (HasIntegratedEBay){
	// Door frames
	// Altimeter
	for (j=AltDoorAngles)
		translate([0,0,AltimeterDoor_Z]) rotate([0,0,j]) EB_AltDoorFrame(Tube_OD=Body_OD, Tube_ID=Body_ID, ShowDoors=ShowDoors);
	
	// Battery and Switch doors
	for (j=BattDoorAngles)
		translate([0,0,BatteryDoor_Z]) rotate([0,0,j]) EB_BattDoorFrame(Tube_OD=Body_OD, HasSwitch=false, ShowDoors=ShowDoors);
	
	for (j=BattSWDoorAngles)
		translate([0,0,BatteryDoor_Z]) rotate([0,0,j]) EB_BattDoorFrame(Tube_OD=Body_OD, HasSwitch=true, ShowDoors=ShowDoors);
				
	// custom forward
	difference(){
		translate([0,0,Can_Len-5]) Tube(OD=Body_OD, ID=Body_ID+IDXtra, Len=FwdTubeLen+5, myfn=$preview? 90:360);
			
		// chamfer
		translate([0,0,Can_Len-5-Overlap]) cylinder(d1=Body_OD-Wall_t/2, d2=Body_ID, h=5, $fn=$preview? 90:360);
		
		// Bolt holes
		translate([0,0,Can_Len+FwdTubeLen-7.5]) for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j])
			translate([0,Body_OD/2,0]) rotate([-90,0,0]) Bolt4ClearHole();
	} // difference
	}
	
} // FinCan

// FinCan();

module MotorRetainer(){
	AftClosure_OD=79.5;
	AftClosure_Len=13;
	Motor_OD=75.5;
	MotorRetainer_OD=90;
	MotorStop_Len=4;
	MotorStop_Z=AftClosure_Len+4;
	OAL=AftClosure_Len+MotorStop_Len+15+4;
	SnapRing_w=2;
	
	
	difference(){
		cylinder(d=MotorRetainer_OD, h=OAL, $fn=$preview? 90:360);
		
	
		translate([0,0,MotorStop_Z+MotorStop_Len]) cylinder(d=MotorTube_OD+IDXtra*2, h=OAL, $fn=$preview? 90:360);
		translate([0,0,MotorStop_Z-Overlap]) cylinder(d=Motor_OD+IDXtra*3, h=OAL, $fn=$preview? 90:360);
		translate([0,0,-Overlap]) cylinder(d=AftClosure_OD+IDXtra*3, h=MotorStop_Z+Overlap, $fn=$preview? 90:360);
		
		// Snap ring
		translate([0,0,MotorStop_Z-AftClosure_Len]) cylinder(d1=AftClosure_OD+3, d2=AftClosure_OD+IDXtra*3, h=3, $fn=$preview? 90:360);
		translate([0,0,MotorStop_Z-AftClosure_Len-SnapRing_w]) cylinder(d=AftClosure_OD+3, h=SnapRing_w+Overlap, $fn=$preview? 90:360);
	} // difference
	
} // MotorRetainer

// translate([0,0,-TailCone_Len-11]) color("Gray") MotorRetainer();

































