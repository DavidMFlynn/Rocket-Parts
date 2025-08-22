// ***********************************
// Project: 3D Printed Rocket
// Filename: SCR_Beta.scad
//  ***** Small Cable Release *****
// by David M. Flynn
// Created: 8/12/2025
// Revision: 0.9.2  8/20/2025
// Units: mm
// ***********************************
//  ***** Notes *****
//
// Non-pyro deployment in 38mm airframe.
// Currently 38mm only, will add parameters to make a 54mm SCR 
//
//  ***** History *****
//
function SCR_BetaRev()="SCR_Beta Rev. 0.9.2";
echo(SCR_BetaRev());
//
// 0.9.2  8/20/2025     Changed servo angle so SG90 power on glitch is in the safe direction.
// 0.9.1  8/14/2025     First working version, still making refinements.
// 0.9.0  8/12/2025		Created this file, pull only version
//
// ****************************
//  ***** for STL output *****
//
//						SCR_AlTubeConnector();
// rotate([180,0,0]) 	SCR_LockPin(Len=13.3);
// rotate([180,0,0]) 	SCR_Housing(ShowCut=false);
// 						SCR_BallCup(ShowLocked=true, ShowCut=false);
// 						SCR_EndStop(ShowCut=false);
//						SCR_CableEnd();
//						SCR_CableGuide();
//						CablePullerMountingRing(IsTopRing=true);
// rotate([180,0,0]) 	SCR_ServoMount();
//
// ****************************
include<TubesLib.scad>
use<SpringEndsLib.scad>			echo(SpringEndsLibRev());

//also included
 //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;
Bolt4Inset=4;


SCR_Ball_d=5/16*25.4;
SCR_Lock_d=12.7;
SCR_nBalls=3;
SCR_LooseFit=IDXtra*3;
SCR_Body_OD=BT38Coupler_OD;

SCR_ShockCord_a=-30;


module SCR_Show_All(ShowLocked=true){
	CableEnd_Z=ShowLocked? -25:-30;
	rotate([0,0,60-120]) SCR_BallCup(ShowLocked=ShowLocked, ShowCut=true);
	SCR_LockPin();
	SCR_ShowMyBalls(ShowLocked=ShowLocked);
	SCR_Housing(ShowCut=true);
	SCR_EndStop(ShowCut=true);
	translate([0,0,CableEnd_Z]) rotate([0,0,60]) SCR_CableEnd();
	
	translate([0,0,-30.2]) rotate([180,0,-60]) SCR_CableGuide();
	
	translate([0,0,-30.2-15.1]) rotate([0,0,90]) rotate([180,0,0]) CablePullerMountingRing(IsTopRing=true);
	
	translate([0,0,-30.2-15.1-59-49]) rotate([0,0,-15]) SCR_ServoMount();
} // SCR_Show_All

// SCR_Show_All(ShowLocked=true);
// SCR_Show_All(ShowLocked=false);

module SCR_TriggerSlide(){

	Len=16;
	
	Slide_X=7.2;
	Slide_Y=9.0;
	
	// CP body
	Block_Y=16.5+IDXtra*2;
	Block_X=18.5+IDXtra*2;
	BlockOffset_X=0.7;

	
	difference(){
		cylinder(d=SCR_Body_OD, h=Len);
		
		translate([-SCR_Body_OD/2-11,-SCR_Body_OD/2-Overlap,-Overlap]) cube([SCR_Body_OD,SCR_Body_OD+Overlap*2, Len+Overlap*2]);
		
		
		translate([0,(Block_Y+4)/2, -Overlap]) cube([SCR_Body_OD, Block_Y+4, Len+Overlap*2]);
		translate([0,-Block_Y-4-(Block_Y+4)/2, -Overlap]) cube([SCR_Body_OD, Block_Y+4, Len+Overlap*2]);
		
			
		translate([-Block_X/2+BlockOffset_X, -Block_Y/2, -Overlap]) cube([Block_X, Block_Y, Len+Overlap*2]);
		
		translate([SCR_Body_OD/2-9,-Slide_Y/2,-Overlap]) cube([Slide_X,Slide_Y,Len+Overlap*2]);
				
		translate([0,0,13])	rotate([0,90,0]) cylinder(d=12, h=10+4);
	} // difference
} // SCR_TriggerSlide

// SCR_TriggerSlide();

module SCR_ServoMount(){
	// Mount for SG90 (MS18)
	
	
	Len=32.8; // was 36
	Wall_t=2.2;
	
	Servo_w=12.7;
	Servo_l=23;
	ServoOffset=5.25;
	ServoEar_l=33;
	ServoEar_z=13.5; // top of ears
	
	Body_H=21; // top of ear to bottom of case
	Servo_BC_d=28;
	ServoWheel_d=17;
	
	WireHole_d=4;
	Servo_a=30;
	
	module Servo(ExtraBody_h=0, WheelAccsess=0, ExtraWidth=0){
		
		translate([0,0,-7]) scale([1,0.8,1]) cylinder(d=ServoWheel_d, h=7+WheelAccsess);
		
		translate([-Servo_w/2-ExtraWidth/2, -Servo_l/2+ServoOffset, 0]) mirror([0,0,1]) cube([Servo_w+ExtraWidth,Servo_l,20]);
		
		// body and ear clearance
		translate([-Servo_w/2-ExtraWidth/2,-ServoEar_l/2+ServoOffset,-ServoEar_z]) mirror([0,0,1]) cube([Servo_w+ExtraWidth,ServoEar_l,Body_H+ExtraBody_h]);
		
		translate([0,-Servo_BC_d/2+ServoOffset,-ServoEar_z]) rotate([180,0,0]) Bolt2Hole();
		translate([0,Servo_BC_d/2+ServoOffset,-ServoEar_z]) rotate([180,0,0]) Bolt2Hole();
		
	} // Servo
	
	//Servo();
	
		difference(){
			cylinder(d=SCR_Body_OD, h=Len+3);
			
			translate([0,0,Len-Overlap]) cylinder(d=SCR_Body_OD-Wall_t*2, h=3+Overlap*2);
			
			// wire path
			rotate([0,0,15]) translate([0,-15,15]) cylinder(d=WireHole_d, h=43);
			
			Servo_Y=-15;
			rotate([0,0,Servo_a]) translate([0,Servo_Y,Len/2-ServoOffset]) rotate([90,0,0]) Servo(ExtraBody_h=3, WheelAccsess=10, ExtraWidth=2);
			
			difference(){
				translate([0,0,-Overlap]) cylinder(d=SCR_Body_OD-Wall_t*2, h=Len+Overlap*2);
				
				// Servo mount
				rotate([0,0,Servo_a]) translate([-Servo_w/2,-SCR_Body_OD/2,-Overlap*2]) cube([Servo_w, 17.5, Len+Overlap*4]);
			} // difference
			
			
		} // difference
	
	translate([0,0,Len+3-Overlap]) rotate([0,0,-75]) CablePullerMountingRing(IsTopRing=false);
} // SCR_ServoMount

// SCR_ServoMount();

module CablePullerMountingRing(IsTopRing=true){
	Len=10;
	OD=BT38Coupler_OD;
	
	BoltSpace=20;
	Block_Y=16.5+IDXtra*2;
	Block_X=28.5+IDXtra*2;
	ShockCord_a=IsTopRing?-45:45;
	ShockCord_d=3.2;
	
	nBolts=2;
	Bolt_a=17;
	
	difference(){
		cylinder(d=OD, h=Len);
		
		translate([-Block_X/2, -Block_Y/2, -Overlap]) cube([Block_X,Block_Y,Len+Overlap*2]);
		translate([-BoltSpace/2,10,Len/2]) rotate([-90,0,0]) Bolt4HeadHole();
		translate([-BoltSpace/2,-Block_Y/2,Len/2]) rotate([-90,0,0]) Bolt4Hole();
		translate([BoltSpace/2,10,Len/2]) rotate([-90,0,0]) Bolt4HeadHole();
		translate([BoltSpace/2,-Block_Y/2,Len/2]) rotate([-90,0,0]) Bolt4Hole();
		
		// Activation rod
		if (!IsTopRing)
		translate([Block_X/2,0,-Overlap]) hull(){ 
			cylinder(d=3, h=Len+Overlap*2);
			translate([1,0,0]) cylinder(d=3, h=Len+Overlap*2);
		} // hull
		
		// Bolt holes for cable release
		translate([0,Block_Y/2+4,6]) Bolt4HeadHole();
		translate([0,-Block_Y/2-4,6]) Bolt4HeadHole();
		
		// Shock Cord
		rotate([0,0,ShockCord_a]) translate([0,OD/2-4,-Overlap]) cylinder(d=ShockCord_d, h=Len+Overlap*2);
		
		// Airframe bolts
		if (IsTopRing)
			for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+Bolt_a]) translate([0,OD/2,Len/2]) rotate([-90,0,0]) Bolt4Hole(depth=6);
	} // difference
	
	
} // CablePullerMountingRing

// CablePullerMountingRing();

module SCR_EndStop(ShowCut=false){
	Base_Z=-30.1;
	H=9;
	nBolts=3;
	Bolt_Y=(SCR_Body_OD-4.4)/2-4;
	nLocks=5;
	ShockCord_a=SCR_ShockCord_a;
	ShockCord_d=3.2;
	
	difference(){
		union(){
			translate([0,0,Base_Z]) cylinder(d=SCR_Body_OD, h=2);
			translate([0,0,Base_Z]) cylinder(d=SCR_Body_OD-4.4, h=H);
			
			// Twist lock
			translate([0,0,Base_Z+2]) 
				TwistLockMale(OD=SCR_Body_OD-4.4, nLocks=nLocks, Inset=3, LockSize=2);
			
		} // union
		
		translate([0,0,Base_Z-Overlap]) cylinder(d=SCR_Body_OD-8.8, h=H+Overlap*2);
	} // difference
	
	
	difference(){
		intersection(){
			union(){
				// bolt bosses
				for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) translate([0,Bolt_Y,Base_Z]) hull(){
					cylinder(d=8, h=H);
					translate([0,2,0]) cylinder(d=10, h=H);
				} // hull
				
				// shock cord guide
				rotate([0,0,ShockCord_a]) translate([0,Bolt_Y,Base_Z]) hull(){
					cylinder(d=6, h=H);
					translate([0,2,0]) cylinder(d=7, h=H);
				} // hull
			} // union
			
			translate([0,0,Base_Z]) cylinder(d=SCR_Body_OD-4.4, h=H);
		} // intersection
	
		// Shock cord hole
		rotate([0,0,ShockCord_a]) translate([0,Bolt_Y,Base_Z-Overlap]) cylinder(d=ShockCord_d, h=H+Overlap*2);
		
		// Bolt holes
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) translate([0,Bolt_Y,Base_Z+H]) Bolt4Hole();
		
		translate([0,0,Base_Z-Overlap]) cylinder(d=20, h=H+Overlap*2);
	} // difference

} // SCR_EndStop

// SCR_EndStop();

module SCR_CableGuide(){
	Len=15;
	Wall_t=1.2;
	nBolts=3;
	Bolt_Y=(SCR_Body_OD-4.4)/2-4;
	Spring_d=7.65+IDXtra*2;
	Cable_Y=Spring_d/2+2;
	Plate_t=2;

	Block_Y=16.5+IDXtra*2;
	//Block_X=28.5+IDXtra*2;
	CP_a=30;
	ShockCord_a=150;

	difference(){
		cylinder(d=SCR_Body_OD, h=Len);
		
		translate([0,0,Plate_t]) cylinder(d=SCR_Body_OD-Wall_t*2, h=Len);
		
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) translate([0,Bolt_Y,Plate_t+Bolt4_BtnHead_h]) Bolt4ButtonHeadHole(depth=8,lHead=Len);
		
		rotate([0,0,60]) translate([0,Cable_Y,-Overlap]) cylinder(d=3.6, h=Plate_t+Overlap*2);
		
		// shock cord
		rotate([0,0,ShockCord_a]) translate([0,13,-Overlap]) cylinder(d=3, h=Len+Overlap*2);
	} // difference
	
	difference(){
		union(){
			rotate([0,0,CP_a]){ translate([0,Block_Y/2+4,0]) cylinder(d=8, h=Len);
			translate([0,-Block_Y/2-4,0]) cylinder(d=8, h=Len);}
		} // union
		
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) translate([0,Bolt_Y,Plate_t+Bolt4_BtnHead_h]) Bolt4ButtonHeadHole(depth=8,lHead=Len);
		
		// Bolt holes for cable puller
		rotate([0,0,CP_a]){ translate([0,Block_Y/2+4,Len]) Bolt4Hole();
		 translate([0,-Block_Y/2-4,Len]) Bolt4Hole();}
	} // difference

} // SCR_CableGuide

// rotate([180,0,-60]) SCR_CableGuide();


module SCR_Housing(ShowCut=false){
	nLocks=5;
	Locked_ID=SCR_Lock_d+SCR_Ball_d*0.6+SCR_Ball_d+IDXtra;
	ShockCord_d=1.5;
	
	module ShockCordHole(){
		ShockCord_a=SCR_ShockCord_a;
			rotate([0,0,ShockCord_a-12]) translate([0,Locked_ID/2-2,-25]) cylinder(d=2.2, h=50);
		
	} // ShockCordSlot
	
	// Stop Ring
	difference(){
		translate([0,0,SCR_Ball_d/2+0.2]) cylinder(d=SCR_Body_OD, h=5);
		
		translate([0,0,SCR_Ball_d/2+0.2-Overlap]) cylinder(d=SCR_Lock_d+SCR_LooseFit, h=5+Overlap*2);
		
		ShockCordHole();
		
		if (ShowCut) translate([0,0,-25]) cube([50,50,50]);
	} // difference
	
	// ball retainer
	difference(){
		union(){
			translate([0,0,-SCR_Ball_d/2-2]) cylinder(d=SCR_Lock_d+SCR_LooseFit+3, h=SCR_Ball_d*1.5);
			
			intersection(){
				translate([0,0,-SCR_Ball_d/2-2]) cylinder(d=Locked_ID-1, h=SCR_Ball_d*1.5);
			
				// ball walls
				translate([0,0,-SCR_Ball_d/2+1]) for (j=[0:SCR_nBalls-1]) rotate([0,0,360/SCR_nBalls*j]) {
					translate([SCR_Ball_d/2+0.5,5,0]) cube([1.2,10,SCR_Ball_d*1.5]);
					translate([-SCR_Ball_d/2-0.5-1.2,5,0]) cube([1.2,10,SCR_Ball_d*1.5]);
					}
					
			} // intersection
		} // union
		
		translate([0,0,-SCR_Ball_d-Overlap]) cylinder(d=SCR_Lock_d+SCR_LooseFit, h=SCR_Ball_d*2+Overlap*2);
		
		Ball_Offset=SCR_Ball_d*0.3;
	
		for (j=[0:SCR_nBalls-1]) rotate([0,0,360/SCR_nBalls*j]) 
			translate([0,SCR_Lock_d/2+Ball_Offset,0]) hull(){
				translate([0,0,0.5]) sphere(d=SCR_Ball_d+IDXtra);
				translate([0,0,-0.5]) sphere(d=SCR_Ball_d+IDXtra);
			}
		
		// Shock cord
		ShockCordHole();
		
		
		if (ShowCut) translate([0,0,-25]) cube([50,50,50]);
	} // difference
	
	// top
	difference(){
		cylinder(d=SCR_Body_OD, h=SCR_Ball_d+5);
		
		translate([0,0,-Overlap]) cylinder(d=SCR_Body_OD-4.4, h=9);
		translate([0,0,-Overlap]) cylinder(d=SCR_Lock_d+SCR_LooseFit, h=SCR_Ball_d+5+Overlap*2);
		
		ShockCordHole();
		
		if (ShowCut) translate([0,0,-25]) cube([50,50,50]);
	} // difference
	
	Skirt_Len=28;
	// skirt
	difference(){
		translate([0,0,-Skirt_Len]) cylinder(d=SCR_Body_OD, h=Skirt_Len+Overlap);
		
		translate([0,0,-Skirt_Len-Overlap]) cylinder(d=SCR_Body_OD-4.4, h=Skirt_Len+Overlap*3);
		
		// Twist lock
		translate([0,0,-Skirt_Len]) rotate([0,0,15])
			TwistLockFemale(OD=SCR_Body_OD-4.4, nLocks=5, Inset=3, LockSize=2);
			
		ShockCordHole();
		
		if (ShowCut) translate([0,0,-25]) cube([50,50,50]);
	} // difference
	
} // SCR_Housing

// SCR_Housing(ShowCut=true);

module SCR_BallCup(ShowLocked=true, ShowCut=false){
	Locked_ID=SCR_Lock_d+SCR_Ball_d*0.6+SCR_Ball_d+IDXtra;
	UnLocked_ID=SCR_Lock_d+SCR_Ball_d*2+1;
	Wall_t=4;
	Position_Z=ShowLocked? 0:-5;
	nBolts=3;
	Len=4+SCR_Ball_d*1.5; // below center
	Spring_d=7.65+IDXtra*2;
	
	translate([0,0,Position_Z])
	difference(){
		union(){
			cylinder(d=Locked_ID+Wall_t*2, h=SCR_Ball_d, center=true);
			
			translate([0,0,-Len]) cylinder(d=Locked_ID+Wall_t*2, h=Len+Overlap);
		} // union
		
		cylinder(d=Locked_ID, h=SCR_Ball_d*2+Overlap, center=true);
		
		// Lower chamfer
		//translate([0,0,-4]) cylinder(d2=Locked_ID, d1=UnLocked_ID, h=3);
		// Upper chamfer
		translate([0,0,1]) cylinder(d1=Locked_ID, d2=UnLocked_ID, h=3+Overlap);
		
		//translate([0,0,-8]) cylinder(d=UnLocked_ID, h=4+Overlap);
		//translate([0,0,-SCR_Ball_d-2]) cylinder(d=Locked_ID, h=4);
		
		// Spring
		translate([0,0,-Len-Overlap]) cylinder(d=Spring_d, h=3.5);
		
		//translate([0,0,-SCR_Ball_d*2-1]) cylinder(d=SCR_Lock_d+SCR_LooseFit, h=SCR_Ball_d*2);
		
		// cut out for ball retainer
		//translate([0,0,-SCR_Ball_d*1.6]) cylinder(d=SCR_Lock_d+4.4, h=6);
		
		translate([0,0,-SCR_Ball_d-2.5]) cylinder(d1=SCR_Lock_d/2, d2=SCR_Lock_d, h=SCR_Ball_d/2+Overlap);
		
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) translate([0,Locked_ID/2-2,-Len])
			rotate([180,0,0]) Bolt4Hole(depth=9);
			
		ShockCord_a=SCR_ShockCord_a;
		rotate([0,0,-ShockCord_a]) hull(){
			translate([0,(SCR_Body_OD-4.4)/2-4,-Len-Overlap]) cylinder(d=4, h=1);
			translate([0,(SCR_Body_OD-4.4)/2-6.5,-Len+12]) cylinder(d=4, h=1);
			} // hull
		
		if (ShowCut) translate([0,0,-25]) rotate([0,0,30]) cube([50,50,50]);
	} // difference
	
	// #cylinder(d=Body_ID, h=1);
} // SCR_BallCup

// SCR_BallCup(ShowLocked=true, ShowCut=true);
// SCR_BallCup(ShowLocked=false, ShowCut=true);

module SCR_CableEnd(){
	nBolts=3;
	Len=9;
	Spring_d=7.65+IDXtra*2;
	Locked_ID=SCR_Lock_d+SCR_Ball_d*0.6+SCR_Ball_d+IDXtra;
	Cable_Y=Spring_d/2+2;
	
	difference(){
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) hull(){
			cylinder(d=Spring_d+4.4, h=Len);
			translate([0,Locked_ID/2-2,0]) cylinder(d=7, h=Len);
		} // hull
		
		// Cable
		translate([0,Cable_Y,-Overlap]) cylinder(d=1.5, h=5);
		translate([0,Cable_Y,Len-7]) cylinder(d=3.7, h=Len);
		
		// Spring
		translate([0,0,-Overlap]) cylinder(d=Spring_d, h=Len+Overlap*2);
		
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) translate([0,Locked_ID/2-2,Len-6])
			rotate([180,0,0]) Bolt4HeadHole(depth=9);
			
	} // difference
} // SCR_CableEnd

// SCR_CableEnd();

module SCR_AlTubeConnector(){
	AlTube_d=7.94;
	
	difference(){
		union(){
			cylinder(d=SCR_Lock_d+3, h=1.5);
			translate([0,0,1.5-Overlap]) cylinder(d1=SCR_Lock_d+3, d2=AlTube_d+2.4, h=5);
		} // union
		
		translate([0,0,1.5+5]) Bolt10Hole();
		translate([0,0,1.5]) cylinder(d=AlTube_d+IDXtra, h=6);
	} // difference
	
} // SCR_AlTubeConnector

// SCR_AlTubeConnector();

module SCR_LockPin(Len=13.3){

	difference(){
		union(){
			translate([0,0,-SCR_Ball_d-2]) cylinder(d1=SCR_Lock_d/2, d2=SCR_Lock_d, h=SCR_Ball_d/2+Overlap);
			translate([0,0,-SCR_Ball_d/2-2]) cylinder(d=SCR_Lock_d, h=SCR_Ball_d+Len);
			translate([0,0,Len]) cylinder(d=SCR_Lock_d+3, h=2);
		} // union
		
		// ball groove
		rotate_extrude() translate([SCR_Lock_d/2+SCR_Ball_d*0.3,0,0]) circle(d=SCR_Ball_d+IDXtra);
		
		// bolt hole
		translate([0,0,SCR_Ball_d+Len]) Bolt10Hole(depth=SCR_Ball_d*3+Len+1);
	} // difference

} // SCR_LockPin

// SCR_LockPin();

module SCR_ShowMyBalls(ShowLocked=true){
	Ball_Offset=ShowLocked? SCR_Ball_d*0.3:SCR_Ball_d*0.55;
	
	for (j=[0:SCR_nBalls-1]) rotate([0,0,360/SCR_nBalls*j]) 
		translate([0,SCR_Lock_d/2+Ball_Offset,0]) color("White") sphere(d=SCR_Ball_d);
} // SCR_ShowMyBalls

// SCR_ShowMyBalls(ShowLocked=true);

// SCR_ShowMyBalls(ShowLocked=false);





