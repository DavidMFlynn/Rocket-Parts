// ***********************************
// Project: 3D Printed Rocket
// Filename: Rocket98IceProbe.scad
// by David M. Flynn
// Created: 4/6/2024 
// Revision: 0.9.0  4/6/2024 
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
// 0.9.0  4/6/2024  First code
//
// ***********************************
//  ***** for STL output *****
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


Body_OD=BT98Body_OD;
Body_ID=BT98Body_ID;
Coupler_OD=BT98Coupler_OD;
Coupler_ID=BT98Coupler_ID;

Alt_DoorXtra_X=6;
Alt_DoorXtra_Y=4;

nFins=3;
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

FinInset_Len=5;
Can_Len=Fin_Root_L+FinInset_Len*2;
Cone_Len=65;
Bolt4Inset=4;
nLockBalls=6;
nPetals=3;
ShockCord_a=17;// offset between PD_PetalHub and R65_BallRetainerBottom
RailGuide_h=Body_OD/2+2;

PodBody_OD=ULine75Body_OD;
PodBody_ID=ULine75Body_ID;

module ShowPod(){
	FinCan1_Z=0;
	AftRadiator_Z=FinCan1_Z+140;
	FinCan2_Z=AftRadiator_Z+100;
	FwrdRadiator_Z=FinCan2_Z+50;
	DrillHead_Z=FwrdRadiator_Z+50;
	
	translate([0,0,DrillHead_Z]) DrillHead();
	translate([0,0,FwrdRadiator_Z]) PodRadiator(Len=50);
	
	translate([0,0,AftRadiator_Z]) PodRadiator(Len=100);
	
	//PodBase();
} // ShowPod

ShowPod();

module DrillHead(OD=PodBody_OD, Tube_ID=PodBody_ID, Base_L=15, Len=120){
	Tip_fn=7;
	nRivets=3;
	
	module ConeShape(Thickness=0){
		translate([0,0,-Base_L]) cylinder(d=OD-Thickness*2, h=Base_L+Overlap, $fn=$preview? 36:360);
		hull(){
			rotate_extrude($fn=$preview? 90:360) translate([OD/2-7.5-Thickness,0,0]) circle(d=15);
		
			for (j=[0:Tip_fn-1]) rotate([0,0,360/Tip_fn*j]) translate([0,OD/6-Thickness,Len-OD/3]) cylinder(d=3, h=Overlap);
		
			translate([0,0,Len]) sphere(d=6-Thickness*2);
		} // hull
	} // ConeShape
	
	
	difference(){
		ConeShape();
		
		if (Base_L>12 && nRivets>0) translate([0,0,-Base_L/2])
			RivetPattern(BT_Dia=OD, nRivets=nRivets, Dia=5/32*25.4);
			
		translate([0,0,-Overlap]) ConeShape(Thickness=1.8);
		//if ($preview) translate([0,0,-Overlap]) cube([OD,OD,Len+10]);
	} // difference
	
} // DrillHead

//DrillHead(Len=120);

module PodRadiator(OD=PodBody_OD, ID=PodBody_ID, InnerID=BT38Body_OD, Len=50, nFins=11){
	Wall_t=1.8;
	Root_W=4;
	Tip_W=2;
	Span=OD/7;
	
	Tube(OD=OD, ID=ID, Len=Len, myfn=$preview? 36:360);
	difference(){
		Tube(OD=OD-IDXtra, ID=ID-IDXtra*2-4.4, Len=4, myfn=$preview? 36:360);
		
		translate([0,0,1]) cylinder(d1=ID-IDXtra*2-4.4, d2=ID, h=3+Overlap);
	} // difference
	
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

PodFin1_Root_L=100;
PodCan1_Len=PodFin1_Root_L+25;
PodMotorTube_OD=BT38Body_OD+IDXtra*3;
PodFin1_Root_W=14;
PodFin1_Post_h=10;
PodFin1_Chamfer_L=24;


 
  FC2_FinCan(Body_OD=PodBody_OD, Body_ID=PodBody_ID, Can_Len=PodCan1_Len,
				MotorTube_OD=PodMotorTube_OD, RailGuide_h=0,
				nFins=1,
				Fin_Root_W=PodFin1_Root_W, Fin_Root_L=PodFin1_Root_L, Fin_Post_h=PodFin1_Post_h,
				Fin_Chamfer_L=PodFin1_Chamfer_L,
				Cone_Len=0, LowerHalfOnly=false, UpperHalfOnly=false, HasWireHoles=false);


module PodBase(OD=PodBody_OD, ID=PodBody_ID){
	Wall_t=2.2;
	
	difference(){
		translate([0,0,-4]) Tube(OD=ID, ID=ID-4.4, Len=10+4, myfn=$preview? 36:360);
		translate([0,0,-4-Overlap]) cylinder(d1=ID, d2=ID-4.4, h=4+Overlap*2);
		//if ($preview) translate([0,0,-3-Overlap]) cube([OD/2+1,OD/2+1,20]);
	} // difference
	
	difference(){
		sphere(d=OD, $fn=$preview? 36:360);
		
		cylinder(d=OD+Overlap, h=OD/2+Overlap);
		sphere(d=OD-Wall_t*2, $fn=$preview? 36:360);
		//if ($preview) translate([0,0,-OD/2]) cube([OD/2+1,OD/2+1,OD]);
	} // difference
} // PodBase

//PodBase();














































