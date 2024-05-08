// ***********************************
// Project: 3D Printed Rocket
// Filename: Rocket98IceProbe.scad
// by David M. Flynn
// Created: 4/6/2024 
// Revision: 0.9.1  5/5/2024 
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  Rocket with 98mm Body and 54mm motor. 
//
//   Mission Control V3 / RocketServo
//
//
//  ***** Parts *****
//
// BlueTube 2.0 4" Body Tube
// Blue Tube 2.1" Body Tube
// 63" Parachute
// 1/2" Braided Nylon Shock Cord (30 feet)
//
//  ***** Hardware *****
//
// #6-32 x 3/4" Button Head Cap Screw (4 req) Rail Guides
// #4-40 x 1/2" Socket Head Cap Screw (6 req) Ball Lock
// #4-40 x 3/8" Button Head Cap Screw (10 req) Doors
// #4-40 x 3/8" Socket Head Cap Screw (3 req) PetalHub
// #4-40 x 1/4" Button Head Cap Screw (4 req) Altimeter
// #4-40 x 1/4" Button Head Cap Screw (12 req) Petals,EBay
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
// 0.9.1  5/5/2024  Moved common R98_ to R98Lib.scad
// 0.9.0  4/6/2024  First code
//
// ***********************************
//  ***** for STL output *****
//
// DrillHead(OD=Body_OD, Tube_ID=Body_ID, InnerID=0, Base_L=NC_Base_L, Len=NC_Len);
// NC_ShockcordRingDual(Tube_OD=Body_OD, Tube_ID=Body_ID, NC_Base_L=NC_Base_L, nRivets=3, nBolts=3);
//
// EB_Electronics_Bay(Tube_OD=Body_OD, Tube_ID=Body_ID, Len=162, nBolts=3, BoltInset=NC_Base_L/2, ShowDoors=false, HasSecondBattDoor=false);
// rotate([-90,0,0]) Batt_Door(Tube_OD=Body_OD, Door_X=BattDoorX(), InnerTube_OD=0, HasSwitch=false, DoubleBatt=false);
// rotate([-90,0,0]) Batt_Door(Tube_OD=Body_OD, Door_X=BattDoorX(), InnerTube_OD=0, HasSwitch=true, DoubleBatt=false);
// rotate([-90,0,0]) AltDoor54(Tube_OD=Body_OD, IsLoProfile=false, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowAlt=true);
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
// rotate([180,0,0]) SE_SpringTop(OD=Coupler_OD, Piston_Len=50, nRopes=6);
// SE_SlidingSpringMiddle(OD=Coupler_OD-IDXtra, nRopes=6, SliderLen=40, SpLen=35, SpringStop_Z=20);
// SE_SpringEndBottom(OD=Coupler_OD, Tube_ID=Coupler_OD-2.4, nRopeHoles=6, CutOutCenter=true);
//
//  *** Pod ***
// DrillHead(OD=PodBody_OD, Tube_ID=PodBody_ID, InnerID=0, Base_L=DrillHeadBase_L, Len=DrillHeadLen);
// PodRadiator(OD=PodBody_OD, ID=PodBody_ID, InnerID=BT38Body_OD, Len=PodRadiator2Len, nFins=11, HasCoupler=true);
// PodFwdFinCan();
// PodRadiator(OD=PodBody_OD, ID=PodBody_ID, InnerID=BT38Body_OD, Len=PodRadiator1Len, nFins=11, HasCoupler=false);
// PodAftFinCan();
// rotate([180,0,0]) PodBase(OD=PodBody_OD, ID=PodBody_ID);
//
// PodRadiator(OD=Body_OD, ID=Body_ID, InnerID=MotorTube_OD, Len=100, nFins=15, HasCoupler=true);
// FinCan2();
// PodRadiator(OD=Body_OD, ID=Body_ID, InnerID=MotorTube_OD, Len=100, nFins=15, HasCoupler=false);
// rotate([180,0,0]) FinCan1();
// MotorRetainer();
// PodAftOuterFin();
//
// PodFwdFin();
// PodAftFin();
//
// CenteringRing(OD=Body_ID, ID=MotorTube_OD+IDXtra*2, Thickness=5, nHoles=5, Offset=0);
//
// rotate([90,0,0]) BoltOnRailGuide(Length = RailGuideLen, BoltSpace=12.7, RoundEnds=true, ExtraBack=0);
//
// ***********************************
//  ***** Routines *****
//
//
// ***********************************
//  ***** for Viewing *****
//
// ShowPod(); // pod only
// ShowRocket();
// ShowRocket(ShowInternals=true);
//
// ***********************************
include<TubesLib.scad>
use<R98Lib.scad>
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
use<SpringEndsLib.scad>


//also included
 //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 36:90;

NC_Base_L=15;
NC_Len=175;
PetalLen=180;

Body_OD=BT98Body_OD;
Body_ID=BT98Body_ID;
Coupler_OD=BT98Coupler_OD;
Coupler_ID=BT98Coupler_ID;
MotorTube_OD=BT54Body_OD;
MotorTube_ID=BT54Body_ID;

Alt_DoorXtra_X=6;
Alt_DoorXtra_Y=4;

nFins=3;

/*
// Standard
Fin_Post_h=18;
Fin_Root_L=180;
Fin_Root_W=14;
Fin_Tip_W=5;
Fin_Tip_L=90;
Fin_TipInset=0;
Fin_Span=125+Fin_TipInset;
Fin_TipOffset=30;
Fin_Chamfer_L=26;
Fin_HasBluntTip=false;
/**/

CouplerLenXtra=-10;
FinInset_Len=5;
Cone_Len=65;
Bolt4Inset=4;
nLockBalls=6;
nPetals=3;
ShockCord_a=17;// offset between PD_PetalHub and R65_BallRetainerBottom
RailGuide_h=Body_OD/2+8;
RailGuideLen=35;

PodBody_OD=ULine75Body_OD;
PodBody_ID=ULine75Body_ID;

DrillHeadLen=110;
DrillHeadBase_L=11;
PodMotorTube_OD=BT38Body_OD+IDXtra*3;

PodFin1_Root_L=140;
PodCan1_Len=PodFin1_Root_L+FinInset_Len*2;
PodFin1_Root_W=16;
PodFin1_Post_h=19;
PodFin1_TipPost_h=17;
PodFin1_Chamfer_L=24;
PodFin1_Span=100;
PodFin1_TipOffset=30;
PodFin1_Tip_W=12;

PodRadiator1Len=100;

PodFin2_Root_L=100;
PodCan2_Len=PodFin2_Root_L+FinInset_Len*2;
PodFin2_Root_W=14;
PodFin2_Post_h=19;
PodFin2_TipPost_h=17;
PodFin2_Chamfer_L=24;
PodFin2_Span=100;
PodFin2_TipOffset=30;
PodFin2_Tip_W=12;

PodRadiator2Len=50;

Can1_Len=PodFin1_Root_L+FinInset_Len*2;
Can2_Len=PodFin2_Root_L+FinInset_Len*2;

module CradleTool(){
	H=3;
	
	translate([0,0,10]) cube([ULine75Body_OD,5,20],center=true);
	
	difference(){
		hull(){
			translate([0,0,H/2]) cube([ULine75Body_OD/2,Overlap,H],center=true);
			translate([0,75+ULine75Body_OD/2,0]) cylinder(d=ULine75Body_OD/2, h=H);
		} // hull
		
		translate([0,75+ULine75Body_OD/2,-Overlap]) cylinder(d=ULine75Body_OD, h=H+Overlap*2);
	} // difference
	
	translate([0,75+ULine75Body_OD/2,0])
	difference(){
		cylinder(d=ULine75Body_OD+10, h=H);
		
		translate([0,0,-Overlap]){
			cylinder(d=ULine75Body_OD, h=H+Overlap*2);
			translate([-(ULine75Body_OD+11)/2,0,0]) cube([ULine75Body_OD+11,ULine75Body_OD,H+Overlap*2]);
		}
	} // difference
} // CradleTool

// CradleTool();


module ShowPod(){
	FinCan1_Z=0;
	AftRadiator_Z=FinCan1_Z+PodCan1_Len;
	FinCan2_Z=AftRadiator_Z+PodRadiator1Len;
	FwrdRadiator_Z=FinCan2_Z+PodCan2_Len;
	DrillHead_Z=FwrdRadiator_Z+PodRadiator2Len+DrillHeadBase_L;
	
	translate([0,0,DrillHead_Z]) DrillHead();
	translate([0,0,FwrdRadiator_Z+PodRadiator2Len]) rotate([180,0,0])
		PodRadiator(OD=PodBody_OD, ID=PodBody_ID, InnerID=BT38Body_OD, Len=PodRadiator2Len, nFins=11, HasCoupler=true);
	
	translate([0,0,FinCan2_Z]) PodFwdFinCan();
	
	translate([0,0,AftRadiator_Z]) 
		PodRadiator(OD=PodBody_OD, ID=PodBody_ID, InnerID=BT38Body_OD, Len=PodRadiator1Len, nFins=11, HasCoupler=false);
	
	translate([0,0,FinCan1_Z]) PodAftFinCan();
	
	PodBase(OD=PodBody_OD, ID=PodBody_ID);
} // ShowPod

// ShowPod();


module ShowRocket(){
	FinCan1_Z=0;
	Fin1_Z=FinCan1_Z+PodCan1_Len/2;
	Spacer_Z=FinCan1_Z+Can1_Len;
	FinCan2_Z=Spacer_Z+PodRadiator1Len;
	Fin2_Z=FinCan2_Z+PodCan2_Len/2;
	
	for (j=[0:nFins-1]) rotate([0,0,360/nFins*j]) {
		translate([Body_OD/2+PodFin1_Span+PodBody_OD/2,0,-PodFin1_TipOffset]) rotate([0,0,180]) ShowPod();
		translate([Body_OD/2-PodFin1_Post_h,0,Fin1_Z]) rotate([0,90,0]) PodAftFin();
		translate([Body_OD/2+PodFin1_Span+PodBody_OD-PodFin1_TipPost_h,0,Fin1_Z-PodFin1_TipOffset]) rotate([0,90,0]) PodAftOuterFin();
		translate([Body_OD/2-PodFin1_Post_h,0,Fin2_Z]) rotate([0,90,0]) PodFwdFin();
	}
	
	translate([0,0,FinCan1_Z]){
		FinCan1();
		MotorRetainer();}
		
	translate([0,0,FinCan1_Z+Can1_Len]) rotate([0,0,-90/15]) 
		PodRadiator(OD=Body_OD, ID=Body_ID, InnerID=MotorTube_OD, Len=100, nFins=15, HasCoupler=false);
		
	translate([0,0,FinCan2_Z+Can2_Len]) rotate([180,0,0]) FinCan2();
	translate([0,0,FinCan2_Z+Can2_Len+100]) rotate([0,0,90/15]) rotate([180,0,0])
		PodRadiator(OD=Body_OD, ID=Body_ID, InnerID=MotorTube_OD, Len=100, nFins=15, HasCoupler=true);
} // ShowRocket

//ShowRocket();


module PodFwdFin(){
	TrapFin2(Post_h=PodFin2_Post_h, Root_L=PodFin2_Root_L, Tip_L=PodFin2_Root_L, 
				Root_W=PodFin2_Root_W, Tip_W=PodFin2_Tip_W, Span=PodFin2_Span, Chamfer_L=PodFin2_Chamfer_L,
				TipOffset=PodFin2_TipOffset, TipInset=0, HasBluntTip=true, TipPost_h=PodFin2_TipPost_h,
				Bisect=false, Bisect_X=0,
				HasSpar=false, Spar_d=8, Spar_L=100);
				
	if ($preview==false){
	translate([PodFin2_Root_L/2-5,0,0]) cylinder(d=15, h=0.9);
	translate([-PodFin2_Root_L/2+5,0,0]) cylinder(d=15, h=0.9);}
} // PodFwdFin

// PodFwdFin();

module PodAftFin(){
	TrapFin2(Post_h=PodFin1_Post_h, Root_L=PodFin1_Root_L, Tip_L=PodFin1_Root_L, 
				Root_W=PodFin1_Root_W, Tip_W=PodFin1_Tip_W, Span=PodFin1_Span, Chamfer_L=PodFin1_Chamfer_L,
				TipOffset=PodFin1_TipOffset, TipInset=0, HasBluntTip=true, TipPost_h=PodFin1_TipPost_h,
				Bisect=false, Bisect_X=0,
				HasSpar=false, Spar_d=8, Spar_L=100);
				
	if ($preview==false){
	translate([PodFin1_Root_L/2-5,0,0]) cylinder(d=15, h=0.9);
	translate([-PodFin1_Root_L/2+5,0,0]) cylinder(d=15, h=0.9);}
} // PodAftFin
		
// PodAftFin();

module PodAftOuterFin(){
	TrapFin2(Post_h=PodFin1_TipPost_h, Root_L=PodFin1_Root_L, Tip_L=PodFin1_Root_L/2, 
				Root_W=PodFin1_Tip_W, Tip_W=5, Span=PodFin1_Root_L/2, Chamfer_L=PodFin1_Chamfer_L,
				TipOffset=0, TipInset=0, HasBluntTip=false, TipPost_h=0,
				Bisect=false, Bisect_X=0,
				HasSpar=false, Spar_d=8, Spar_L=100);
				
	if ($preview==false){
	translate([PodFin1_Root_L/2-5,0,0]) cylinder(d=15, h=0.9);
	translate([-PodFin1_Root_L/2+5,0,0]) cylinder(d=15, h=0.9);}
} // PodAftOuterFin
		
// PodAftOuterFin();
		
module DrillHead(OD=PodBody_OD, Tube_ID=PodBody_ID, InnerID=0, Base_L=DrillHeadBase_L, Len=DrillHeadLen){
	Tip_fn=7;
	Tip_d=(OD>80)? 8:6;
	nRivets=3;
	Wall_t=(OD>80)? 2.2:1.8;
	
	module ConeShape(Thickness=0){
		translate([0,0,-Base_L]) cylinder(d=OD-Thickness*2, h=Base_L+Overlap, $fn=$preview? 36:360);
		hull(){
			difference(){
				rotate_extrude($fn=$preview? 90:360) translate([OD/2-7.5,0,0]) circle(d=15-Thickness*2, $fn=90);
				translate([0,0,-7.5-Overlap]) cylinder(d=OD+1, h=7.5);
			}
		
			for (j=[0:Tip_fn-1]) rotate([0,0,360/Tip_fn*j]) 
				translate([0,OD/3-Thickness,Len-OD/1.4]) cylinder(d=Tip_d, h=Overlap);
		
			// Tip
			translate([0,0,Len]) sphere(d=Tip_d-Thickness*2);
		} // hull
	} // ConeShape
	
	if (InnerID>0){
		translate([0,0,-Base_L-10]) {
			CenteringRing(OD=Tube_ID-1, ID=InnerID+IDXtra*2, Thickness=4, nHoles=0);
			Tube(OD=Tube_ID-IDXtra*2, ID=Tube_ID-IDXtra*2-4.4, Len=11, myfn=$preview? 36:360);
			}
			
		translate([0,0,-Base_L])
		difference(){
			Tube(OD=OD-IDXtra, ID=Tube_ID-IDXtra*2-4.4, Len=4, myfn=$preview? 36:360);
			
			translate([0,0,1]) cylinder(d1=Tube_ID-IDXtra*2-4.4, d2=Tube_ID, h=3+Overlap);
		} // difference
		}
	
	difference(){
		ConeShape();
		
		// Rivet holes
		if (Base_L>12 && nRivets>0) translate([0,0,-Base_L/2])
			RivetPattern(BT_Dia=OD, nRivets=nRivets, Dia=5/32*25.4);
			
		// Make hollow
		translate([0,0,-Overlap]) ConeShape(Thickness=Wall_t);
		
		translate([0,0,-Base_L-Overlap]) cylinder(d=Tube_ID, h=Base_L+Overlap*2, $fn=$preview? 90:360);
		cylinder(d1=Tube_ID, d2=Tube_ID-3, h=3, $fn=$preview? 90:360);
		//if ($preview) translate([0,0,-Overlap]) cube([OD,OD,Len+10]);
	} // difference
	
} // DrillHead

//DrillHead(Len=DrillHeadLen);

module PodRadiator(OD=PodBody_OD, ID=PodBody_ID, InnerID=BT38Body_OD, Len=50, nFins=11, HasCoupler=false){
	Wall_t=1.8;
	Root_W=4;
	Tip_W=2;
	Span=OD/7;
	
	Tube(OD=OD, ID=ID, Len=Len, myfn=$preview? 36:360);
	
	if (HasCoupler)
	difference(){
		Tube(OD=OD-IDXtra, ID=ID-IDXtra*2-4.4, Len=4, myfn=$preview? 36:360);
		
		translate([0,0,1]) cylinder(d1=ID-IDXtra*2-4.4, d2=ID, h=3+Overlap);
	} // difference
	
	if (HasCoupler)
	translate([0,0,-10]) {
		CenteringRing(OD=ID-1, ID=InnerID+IDXtra*2, Thickness=4, nHoles=0);
		Tube(OD=ID-IDXtra*2, ID=ID-IDXtra*2-4.4, Len=11, myfn=$preview? 36:360);
		}
	
	difference(){
		for (j=[0:nFins]) rotate([0,0,360/nFins*j]) translate([0,OD/2-Root_W/2,0]) hull(){
			cylinder(d=Root_W, h=Len);
			translate([0,Span,Span]) cylinder(d=Tip_W, h=Len-Span*2);
		} // for
		
		translate([0,0,-Overlap]) cylinder(d=ID+1, h=Len+Overlap*2);
	} // difference
} // PodRadiator

// PodRadiator();

module PodFwdFinCan(){
 
  FC2_FinCan(Body_OD=PodBody_OD, Body_ID=PodBody_ID, Can_Len=PodCan2_Len,
				MotorTube_OD=PodMotorTube_OD, RailGuide_h=0,
				nFins=1, HasIntegratedCoupler=true, HasMotorSleeve=true, HasAftIntegratedCoupler=true,
				Fin_Root_W=PodFin2_Tip_W, Fin_Root_L=PodFin2_Root_L, Fin_Post_h=PodFin2_TipPost_h,
				Fin_Chamfer_L=PodFin2_Chamfer_L,
				Cone_Len=0, LowerHalfOnly=false, UpperHalfOnly=false, HasWireHoles=false);

} // PodFwdFinCan

// PodFwdFinCan();

module PodAftFinCan(){
 
  FC2_FinCan(Body_OD=PodBody_OD, Body_ID=PodBody_ID, Can_Len=PodCan1_Len,
				MotorTube_OD=PodMotorTube_OD, RailGuide_h=0,
				nFins=2, HasIntegratedCoupler=true, HasMotorSleeve=true, HasAftIntegratedCoupler=true,
				Fin_Root_W=PodFin1_Tip_W, Fin_Root_L=PodFin1_Root_L, Fin_Post_h=PodFin1_TipPost_h,
				Fin_Chamfer_L=PodFin1_Chamfer_L,
				Cone_Len=0, LowerHalfOnly=false, UpperHalfOnly=false, HasWireHoles=false);

} // PodAftFinCan

// PodAftFinCan();

module PodBase(OD=PodBody_OD, ID=PodBody_ID){
	Wall_t=2.6;
	
	translate([0,0,-10-Overlap]) Tube(OD=OD, ID=ID, Len=10+Overlap, myfn=$preview? 36:360);
		
	translate([0,0,-10])
	difference(){
		sphere(d=OD, $fn=$preview? 36:360);
		
		cylinder(d=OD+Overlap, h=OD/2+Overlap);
		sphere(d=OD-Wall_t*2, $fn=$preview? 36:360);
		//if ($preview) translate([0,0,-OD/2]) cube([OD/2+1,OD/2+1,OD]);
	} // difference
} // PodBase

//PodBase();

module MotorRetainer(){
	FC2_MotorRetainer(Body_OD=Body_OD,
						MotorTube_OD=MotorTube_OD, MotorTube_ID=MotorTube_ID,
						HasWrenchCuts=false, Cone_Len=Cone_Len, ExtraLen=0);
} // MotorRetainer

//MotorRetainer();

module FinCan1(){
	FC2_FinCan(Body_OD=Body_OD, Body_ID=Body_ID, Can_Len=Can1_Len,
				MotorTube_OD=MotorTube_OD, RailGuide_h=RailGuide_h,
				nFins=nFins, HasIntegratedCoupler=true, HasMotorSleeve=true, HasAftIntegratedCoupler=false,
				Fin_Root_W=PodFin1_Root_W, Fin_Root_L=PodFin1_Root_L, Fin_Post_h=PodFin1_Post_h, Fin_Chamfer_L=PodFin1_Chamfer_L,
				Cone_Len=Cone_Len, RailGuideLen=RailGuideLen,
				LowerHalfOnly=false, UpperHalfOnly=false, HasWireHoles=false);
} // FinCan1

// FinCan1();

module FinCan2(){
	FC2_FinCan(Body_OD=Body_OD, Body_ID=Body_ID, Can_Len=Can2_Len,
				MotorTube_OD=MotorTube_OD, RailGuide_h=RailGuide_h,
				nFins=nFins, HasIntegratedCoupler=true, HasMotorSleeve=true, HasAftIntegratedCoupler=true,
				Fin_Root_W=PodFin2_Root_W, Fin_Root_L=PodFin2_Root_L, Fin_Post_h=PodFin2_Post_h, Fin_Chamfer_L=PodFin2_Chamfer_L,
				Cone_Len=0, RailGuideLen=RailGuideLen,
				LowerHalfOnly=false, UpperHalfOnly=false, HasWireHoles=false);
} // FinCan2

// FinCan2();







































