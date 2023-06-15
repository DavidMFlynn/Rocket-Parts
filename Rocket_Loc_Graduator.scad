// ************************************
// Project: 3D Printed Rocket
// Filename: Rocket_Loc_Graduator.scad
// by David M. Flynn
// Created: 6/11/2023 
// Revision: 0.9.1  6/12/2023
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  Parts to add to Loc Graduator Kit
//
// Hardware:
// #8-32 x 3/4" Button Head Cap Screw (2 Req.) Rail Buttons
// #4-40 x 1/4" Button Head Cap Screw (4 Req.) Altimeter
// #4-40 x 1/2" Socket Head Cap Screw (3 Req.) STB
// 4mm x 16mm under size Dowel (3 Req.)
// 4mm x 10mm under size Dowel (3 Req.)
// MR84-2RS Bearings (5 Req.)
// MG90S Servo
// #2-56 x 1/4" Socket Head Cap Screw (2 Req.) Servo
// Rocket Servo PCB (https://github.com/DavidMFlynn/Rocket-Servo)
// Mission Control V3 Altimeter
// C&K Rotary Switch
// 36" Parachute
//
//  ***** History *****
// 
// 0.9.1  6/12/2023  Done for now. Rocket is together ready for paint.
// 0.9.0  6/11/2023  First code.
//
// ***********************************
//  ***** for STL output *****
//
// SlideIn_ElectronicsBay();
// UpperRailBtnMount();
// rotate([0,180,0]) TailCone();
//
//
// STB_LockDisk(BallPerimeter_d=Body_OD, nLockBalls=3);
// rotate([180,0,0]) STB_BallRetainerTop(BallPerimeter_d=Body_OD, Body_OD=Body_ID, nLockBalls=3, HasIntegratedCouplerTube=true, IntegratedCouplerLenXtra=-10, Body_ID=Body_ID, HasSecondServo=false, UsesBigServo=false, Engagement_Len=20);
// STB_BallRetainerBottom(BallPerimeter_d=Body_OD, Body_OD=Body_ID, nLockBalls=3, HasSpringGroove=false, Engagement_Len=20);
// rotate([180,0,0]) STB_TubeEnd(BallPerimeter_d=Body_OD, nLockBalls=3, Body_OD=Body_OD, Body_ID=Body_ID, Skirt_Len=20);
// STB_SpringEnd(Tube_ID=Body_ID, CouplerTube_ID=Coupler_ID, SleeveLen=30, nRopeHoles=0); // Print 2
//
// Tube(OD=Body_ID, ID=Body_ID-2.4, Len=40, myfn=$preview? 36:360); // Oops Fix:Spacer
//	
//
//  *** Tools ***
// EBayDrillingJig();
//
// ***********************************

include<TubesLib.scad>
use<SpringThingBooster.scad>
use<AltBay.scad>
use<BatteryHolderLib.scad>
include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;


Body_OD=67.2;
Body_ID=65;
Coupler_OD=64.8;
Coupler_ID=63.3;
MotorTube_OD=30.9;
MotorTube_ID=29;
Fin_t=3.1;
nFins=3;
EBay_Len=105.6;
Alt_DoorXtra_X=2;
Alt_DoorXtra_Y=2;

Bolt4Inset=4;
PetalWidth=Coupler_OD/5;

module Petal(Len=75){
	Width=PetalWidth;
	Thickness=3;
	Spring_d=5/16*25.4;
	
	difference(){
			intersection(){
				cylinder(d=Coupler_OD, h=Len);
				translate([-Width/2,Coupler_OD/2-Thickness,0]) cube([Width, Coupler_OD, Len]);
			} // intersection
		
		translate([0,Coupler_OD/2,Bolt4Inset]) rotate([-90,0,0]) Bolt4ButtonHeadHole();
		translate([0,Coupler_OD/2,Bolt4Inset*3]) rotate([-90,0,0]) Bolt4ButtonHeadHole();
	} // difference
} // Petal

//rotate([90,0,0]) 
//Petal();

module PetalSpringHolder(Len=75){
	Width=11;
	Thickness=3;
	Spring_d=5/16*25.4;
	
	difference(){
		hull(){
			
			translate([0,Coupler_OD/2-Thickness-Width/2,0]) cylinder(d=Width, h=10);
			translate([-Width/2,Coupler_OD/2-Thickness-1,0]) cube([Width,1,1]);
			
			translate([0,Coupler_OD/2-Thickness,Bolt4Inset*3]) rotate([90,0,0]) cylinder(d=Width,h=3);
		} // union
		
		translate([0,Coupler_OD/2-Thickness-Width/2,-Overlap]) cylinder(d=Spring_d+IDXtra, h=8);
		
		translate([0,Coupler_OD/2,Bolt4Inset]) rotate([-90,0,0]) Bolt4Hole();
		translate([0,Coupler_OD/2,Bolt4Inset*3]) rotate([-90,0,0]) Bolt4Hole();
	} // difference
} // PetalSpringHolder

//PetalSpringHolder();

module PetalHub(){
	Width=PetalWidth+1;
	nPetals=3;
	Spring_d=5/16*25.4;
	Shelf_Z=16;
	
	difference(){
		STB_SpringEnd(Tube_ID=Coupler_OD, CouplerTube_ID=Coupler_ID, SleeveLen=16, nRopeHoles=0);
		
		// Petal ledge and Spring slot
		for (j=[0:nPetals-1]) rotate([0,0,360/nPetals*j]){
			translate([-Width/2,5,Shelf_Z]) cube([Width,Coupler_OD/2,20]);
			//#translate([0,Coupler_OD/2-15,12-10+Spring_d/2]) 
			//	rotate([-90,0,0]) cylinder(d=Spring_d, h=11);
			hull(){
				translate([0,Coupler_OD/2-15,Shelf_Z-10+Spring_d/2]) 
					rotate([-90,0,0]) cylinder(d=Spring_d+1, h=20);
				translate([0,Coupler_OD/2-15,Shelf_Z+Spring_d/2]) 
					rotate([-90,0,0]) cylinder(d=Spring_d+1, h=20);
			} // hull
		}
		
		// Limit ropes
		for (j=[0:2]) rotate([0,0,360/nPetals*(j+0.5)]) 
			translate([0,Coupler_OD/2-5,-Overlap]) cylinder(d=4, h=20);
	} // difference
	
	// Spring holders
	for (j=[0:nPetals-1]) rotate([0,0,360/nPetals*j]) difference(){
		hull(){
			translate([0,Coupler_OD/2-12,Shelf_Z-10+Spring_d/2]) 
				rotate([90,0,0]) cylinder(d=Spring_d+3, h=11);
			translate([-(Spring_d+5)/2,Coupler_OD/2-12-11,Shelf_Z-12]) 
				cube([Spring_d+5,11,1]);
		}
			
		translate([0,Coupler_OD/2-12+Overlap,Shelf_Z-10+Spring_d/2]) 
			rotate([90,0,0]) cylinder(d=Spring_d, h=8);
	}
	
	translate([0,0,3])
	difference(){
		cylinder(d=50, h=2.6);
		translate([0,0,-Overlap]) cylinder(d=19.0, h=4);
	} // difference
	
} // PetalHub

// PetalHub();

module UpperRailBtnMount(){
	Len=15;
	
	difference(){
		cylinder(d=Body_ID, h=Len);
		
		// remove extra
		translate([0,0,3]) {
		 translate([10,-Body_ID/2,0]) cube([Body_ID,Body_ID,Len]);
		 mirror([1,0,0]) translate([10,-Body_ID/2,0]) cube([Body_ID,Body_ID,Len]);
		}
		
		// Motor tube
		translate([0,0,-Overlap]) cylinder(d=MotorTube_OD+IDXtra*2, h=Len+Overlap*2);
		
		// Rail button bolt hole
		translate([0,-Body_OD/2,Len/2]) rotate([90,0,0]) Bolt8Hole();
		
		// Shock cord
		translate([0,MotorTube_OD/2+5,-1]) rotate([20,0,0]) cylinder(d=5, h=Len+5);
	} // difference

} // UpperRailBtnMount

//UpperRailBtnMount();

module TubeAccessHoles(){
	AltArmingScrew_Y=19;
	AltLED_Y=35;
	AltOffset_Z=6.5;
	
	RS_ArmingScrew_Y=17.5;
	RS_LED_Y=31.5;
	RS_LED_a=18;
	RS_Offset_Z=0;
	
	translate([0,0,AltOffset_Z+AltArmingScrew_Y]) rotate([90,0,0]) cylinder(d=5, h=Body_OD/2+12);
	translate([0,0,AltOffset_Z+AltLED_Y]) rotate([90,0,0]) cylinder(d=5, h=Body_OD/2+12);
	
	translate([0,0,RS_Offset_Z+RS_ArmingScrew_Y]) rotate([-90,0,0]) cylinder(d=5, h=Body_OD/2+12);
	translate([0,0,RS_Offset_Z+RS_LED_Y]) rotate([-90,0,RS_LED_a]) cylinder(d=5, h=Body_OD/2+12);
} // TubeAccessHoles

//TubeAccessHoles();

module EBayDrillingJig(){
	difference(){
		Tube(OD=Body_OD+IDXtra*3+2.4, ID=Body_OD+IDXtra*3, Len=50, myfn=$preview? 36:360);
		
		TubeAccessHoles();
	} // difference
} // EBayDrillingJig

// EBayDrillingJig();

module SlideIn_ElectronicsBay(){
	Altimeter_Z=EBay_Len/2;
	BattSwDoor_Z=48.8;
	Alt1_a=0;
	Batt1_a=180; // Rocket Servo 1 Battery & Switch
	Tube_OD=Body_ID-IDXtra;
	Tube_ID=Tube_OD-2.4;
	
	difference(){
		Tube(OD=Tube_OD, ID=Tube_ID, Len=EBay_Len, myfn=$preview? 36:360);
		
		// Altimeter
		translate([0,0,Altimeter_Z]) rotate([0,0,Alt1_a]) 
			Alt_BayFrameHole(Tube_OD=Tube_OD, DoorXtra_X=-2, DoorXtra_Y=-16);
			
		// Battery and Switch door holes
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
			Batt_BayFrameHole(Tube_OD=Tube_OD, Door_X=30, Door_Y=70, HasSwitch=true);
			
		// Altimeter access holes
		translate([0,0,Altimeter_Z]) rotate([-90,0,0]) AltHoles() cylinder(d=5, h=Tube_OD/2);
		translate([0,-Tube_OD/2+16.5,Altimeter_Z]) rotate([0,0,Alt1_a]) 
			rotate([90,0,0]) USB_Connector_Hole() RoundRect(X=10, Y=13, Z=20, R=1);
	} // difference
	
	translate([0,0,Altimeter_Z]) rotate([0,0,Alt1_a]) 
		AltDoor54(Tube_OD=Tube_OD, IsLoProfile=false, DoorXtra_X=0, DoorXtra_Y=0, ShowAlt=true);
		
	// Battery and Switch door
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
		Batt_Door(Tube_OD=Tube_OD, Door_X=42, InnerTube_OD=0, HasSwitch=true);
} // SlideIn_ElectronicsBay

// SlideIn_ElectronicsBay();

module ElectronicsBay(){
	Altimeter_Z=EBay_Len/2;
	BattSwDoor_Z=EBay_Len/2;
	Alt1_a=0;
	Batt1_a=180; // Rocket Servo 1 Battery & Switch
	Tube_OD=Body_OD;
	Tube_ID=Body_ID;
	
	difference(){
		Tube(OD=Tube_OD, ID=Tube_ID, Len=EBay_Len, myfn=$preview? 36:360);
		
		// Altimeter
		translate([0,0,Altimeter_Z]) rotate([0,0,Alt1_a]) 
			Alt_BayFrameHole(Tube_OD=Tube_OD, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y);
			
		// Battery and Switch door holes
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
			Batt_BayFrameHole(Tube_OD=Tube_OD, HasSwitch=true);
	} // difference
	
	// Altimeter
	translate([0,0,Altimeter_Z]) rotate([0,0,Alt1_a])
		Alt_BayDoorFrame(Tube_OD=Tube_OD, Tube_ID=Tube_ID, 
				DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowDoor=false);
				
	// Battery and Switch door
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
		Batt_BayDoorFrame(Tube_OD=Tube_OD, Tube_ID=Tube_ID, HasSwitch=true, ShowDoor=false);
} // ElectronicsBay

//ElectronicsBay();

module TailCone(){
	Cone_Len=35;
	FinInset_Len=14.8;
	FinAlignment_Len=10;
	
	difference(){
		union(){
			hull(){
				translate([0,0,-Cone_Len]) cylinder(d=MotorTube_OD+2.4+IDXtra*2, h=2, $fn=$preview? 90:360);
				//translate([0,0,-2]) cylinder(d=Body_OD, h=2, $fn=$preview? 90:360);
				difference(){
					rotate_extrude($fn=$preview? 90:360) translate([Body_OD/2-8,0,0]) circle(d=16);
					cylinder(d=Body_OD+1,h=10);
				}
			} // hull
			
			translate([0,0,-Overlap]) cylinder(d=Body_ID, h=FinInset_Len+FinAlignment_Len+Overlap, $fn=$preview? 90:360);
		} // union
		
		// Fin slots
		translate([0,0,FinInset_Len])
			for (j=[0:nFins-1]) rotate([0,0,360/nFins*j]) translate([-Fin_t/2-IDXtra,MotorTube_ID/2,0])
				cube([Fin_t+IDXtra*2, Body_OD/2, FinAlignment_Len+Overlap]);
		
		// Motor tube
		translate([0,0,-Cone_Len-Overlap]) 
			cylinder(d=MotorTube_OD+IDXtra*2, h=Cone_Len+FinInset_Len+FinAlignment_Len+Overlap*2);
	
		// Rail button bolt hole
		translate([0,-Body_OD/2,10]) rotate([90,0,0]) Bolt8Hole();
		
	} // difference
} // TailCone

//TailCone();



















