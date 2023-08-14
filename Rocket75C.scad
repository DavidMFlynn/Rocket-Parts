// ***********************************
// Project: 3D Printed Rocket
// Filename: Rocket75C.scad
// by David M. Flynn
// Created: 8/6/2023 
// Revision: 1.1.0  8/9/2023 
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  Upscale of Rocket65
//  Rocket with 75mm Body and 54mm motor. 
//
//  Single deploy:
//   Mission Control V3 / RocketServo
//
//  ***** Parts *****
//
// BlueTube 2.0 3" Body Tube by 24 inches
// Blue Tube 2.1" Body Tube by 12 inches
// 45" Parachute
// 1/8" Paracord (3 feet)
// 1/2" Braided Nylon Shock Cord (20 feet)
//
//  ***** Hardware *****
//
// #6-32 x 3/4" Button Head Cap Screw (2 req) Rail Buttons
// #4-40 x 1/2" Socket Head Cap Screw (3 req) Ball Lock
// #4-40 x 3/8" Button Head Cap Screw (6 req) Doors
// #4-40 x 3/8" Socket Head Cap Screw (3 req) PetalHub
// #4-40 x 1/4" Button Head Cap Screw (4 req) Altimeter
// #2-56 x 1/4" Socket Head Cap Screw (2 req) Servo
// MR84-2RS Bearing (5 req) Ball Lock
// 3/8" Delrin Ball (3 req) Ball Lock
// 4mm Dia. x 10mm Undersize Steel Dowel (3 req) Ball Lock
// 4mm Dia. x 16mm Undersize Steel Dowel (3 req) Ball Lock
// 3/16" Dia x 1/8" Disc Magnet N42 (2 req) Ball Lock
// SG90 or MG90S Micro Servo (1 req) Ball Lock
// C&K Rotary Switch (1 req) Battery Door
// Mission Control V3 Altimeter PCBA
// Rocket Servo PCBA
// 1/4" Rail Button (2 req)
// CS4323 Spring
// 5/16" Dia x 1-1/4" Spring (3 req) PetalHub
//
//  ***** History *****
//
// 1.1.0  8/9/2023   Got Dual Deploy?
// 1.0.1  8/8/2023   Fin can improvments
// 1.0.0  8/6/2023   Copied from Rocket65 Rev 1.0.8
//
// ***********************************
//  ***** for STL output *****
//
// *** Nosecode ***
//
// BluntOgiveNoseCone(ID=Coupler_OD, OD=Body_OD, L=NC_Len, Base_L=13, Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=120, LowerPortion=false);

// BluntOgiveNoseCone(ID=Coupler_OD, OD=Body_OD, L=NC_Len, Base_L=13, Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=120, Transition_OD=BT75Body_OD-18, LowerPortion=true);
//
// *** Electronics Bay ***
//
// NC_ShockcordRing();
// Electronics_Bay(Tube_OD=Body_OD, Tube_ID=Body_ID);
// CouplerLenXtra=-10;
//
// *** Dual Deploy Electronics Bay ***
//
// NC_ShockcordRingDual();
// EBay_ShockcordRingDual();
// Electronics_BayDual(Tube_OD=Body_OD, Tube_ID=Body_ID);
// 
CouplerLenXtra=3;
// *** Doors ***
//
// rotate([-90,0,0]) AltDoor54(Tube_OD=Body_OD, IsLoProfile=false, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowAlt=true);
// 
// rotate([-90,0,0]) Batt_Door(Tube_OD=Body_OD, InnerTube_OD=0, HasSwitch=true);
//
// *** Ball Lock ***
//
// STB_LockDisk(BallPerimeter_d=Body_OD, nLockBalls=3);
// rotate([180,0,0]) STB_BallRetainerTop(BallPerimeter_d=Body_OD, Body_OD=Body_ID, nLockBalls=3, HasIntegratedCouplerTube=true, IntegratedCouplerLenXtra=CouplerLenXtra, Body_ID=Body_ID-IDXtra, HasSecondServo=false, UsesBigServo=false);
// R75_BallRetainerBottom();
// rotate([180,0,0]) STB_TubeEnd(BallPerimeter_d=Body_OD, nLockBalls=3, Body_OD=Body_OD, Body_ID=Body_ID, Skirt_Len=20);
//
// *** optional petal deployer ***
//
// PetalHub();
// rotate([-90,0,0]) PetalSpringHolder();
// rotate([180,0,0]) Petals(Len=150, nPetals=3);
//
// rotate([180,0,0]) SpringTop();
//
// SpringEndTop(OD=Coupler_OD, Tube_ID=Coupler_OD-2.4, nRopeHoles=3);
// SpringEndBottom(OD=Coupler_OD, Tube_ID=Coupler_OD-2.4, nRopeHoles=3);
// SpringSpacer(OD=Coupler_OD, Tube_ID=Coupler_OD-2.4, Len=40); // optional
//
// UpperRailBtnMount();
//
// *** Fin Can ***
//
// FinCan(LowerHalfOnly=false, UpperHalfOnly=true);
// RocketFin();
// rotate([180,0,0]) FinCan(LowerHalfOnly=true, UpperHalfOnly=false);
// MotorRetainer();
//
// RailButton(); // (4 req) print many
//
// ***********************************
//  ***** Routines *****
//
//
// ***********************************
//  ***** for Viewing *****
//
// ShowRocket();
//
// ***********************************
include<TubesLib.scad>
use<RailGuide.scad>
use<Fins.scad>
use<NoseCone.scad>
use<AltBay.scad>
use<BatteryHolderLib.scad>
use<SpringThingBooster.scad>
use<ThreadLib.scad>

//also included
 //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;
Scale=1.1808;
echo("Scale on Rocket65 = ",Scale);
nFins=5;
Fin_Post_h=10;
Fin_Root_L=160*Scale;
Fin_Root_W=6*Scale;
Fin_Tip_W=3.0;
Fin_Tip_L=70*Scale;
Fin_Span=70*Scale;
Fin_TipOffset=20*Scale;
Fin_Chamfer_L=18*Scale;

Body_OD=BT75Body_OD;
Body_ID=BT75Body_ID;
Coupler_OD=BT75Coupler_OD;
Coupler_ID=BT75Coupler_ID;

// *** 38mm Motor Tube ***
MotorTube_OD=BT54Body_OD;
MotorTube_ID=BT54Body_ID;
MotorCoupler_OD=BT54Coupler_OD;

MotorTubeHole_d=MotorTube_OD+IDXtra*3;

EBay_Len=152;

NC_Len=180*Scale;
NC_Tip_r=5*Scale;
NC_Wall_t=1.8;

BodyTubeLen=24*25.4;

Alt_DoorXtra_X=4;
Alt_DoorXtra_Y=2;

FinInset_Len=5*Scale;
Can_Len=Fin_Root_L+FinInset_Len*2;
Bolt4Inset=4;
PetalWidth=Coupler_OD/5;


module ShowRocket(){
	FinCan_Z=35;
	Fin_Z=FinCan_Z+Fin_Root_L/2+FinInset_Len;
	BodyTube_Z=FinCan_Z+Can_Len+Overlap*2;
	EBay_Z=BodyTube_Z+BodyTubeLen+33.5;
	NoseCone_Z=EBay_Z+EBay_Len-13+Overlap*2;
	
	translate([0,0,NoseCone_Z])
		BluntOgiveNoseCone(ID=Coupler_OD, OD=Body_OD, L=NC_Len, Base_L=13, 
							Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=0, LowerPortion=false);
	
	translate([0,0,EBay_Z]) Electronics_Bay();
	
	translate([0,0,BodyTube_Z+BodyTubeLen+10+Overlap*2])
	STB_BallRetainerTop(BallPerimeter_d=Body_OD, Body_OD=Body_ID, nLockBalls=3, HasIntegratedCouplerTube=true, Body_ID=Body_ID, HasSecondServo=false, UsesBigServo=false);
	
	translate([0,0,BodyTube_Z+BodyTubeLen+10])
	STB_TubeEnd(BallPerimeter_d=Body_OD, nLockBalls=3, Body_OD=Body_OD, Body_ID=Body_ID, Skirt_Len=20);
	
	translate([0,0,BodyTube_Z]) color("LightBlue") Tube(OD=Body_OD, ID=Body_ID, 
			Len=BodyTubeLen-Overlap*2, myfn=$preview? 90:360);
	
	translate([0,0,FinCan_Z]) color("White") FinCan(LowerHalfOnly=false, UpperHalfOnly=false);
	
	//*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j])
		translate([Body_OD/2-Fin_Post_h, 0, Fin_Z]) 
			rotate([0,90,0]) color("Yellow") RocketFin();
	/**/
	
	translate([0,0,FinCan_Z-0.2]) MotorRetainer();
} // ShowRocket

//ShowRocket();

module R75_BallRetainerBottom(){
	difference(){
		STB_BallRetainerBottom(BallPerimeter_d=Body_OD, Body_OD=Body_ID, nLockBalls=3, HasSpringGroove=false);
		
		for (j=[0:2]) rotate([0,0,120*(j+0.5)]) translate([0,Body_OD/2-5,0]) Bolt4Hole();
	} // difference
} // R75_BallRetainerBottom

// translate([0,0,-8]) rotate([180,0,0]) R75_BallRetainerBottom();

module Petals(Len=25, nPetals=3){
	Bolt1_Z=11.75;
	Thickness=3;
	BaseOffset=11.2;
	
	difference(){
		union(){
			translate([0,0,BaseOffset]) Tube(OD=Coupler_OD-IDXtra*2, ID=Coupler_OD-3.6, Len=Len, myfn=$preview? 90:360);
			
			for (j=[0:nPetals-1]) rotate([0,0,360/nPetals*j]) difference(){
				intersection(){
					cylinder(d=Coupler_OD-IDXtra*2, h=16+BaseOffset, $fn=$preview? 90:360);
						
					translate([-PetalWidth/2,Coupler_OD/2-Thickness,0]) 
						cube([PetalWidth, Coupler_OD, 16+BaseOffset]);
				} // intersection
				translate([0,0,16+BaseOffset-3])
					cylinder(d1=Coupler_OD-Thickness*2, d2=Coupler_OD-3.6+Overlap, h=3+Overlap, $fn=$preview? 90:360);
			}
		} // union
		
		// Bolt Holes
		for (j=[0:nPetals-1]) rotate([0,0,360/nPetals*j]){
			translate([0,Coupler_OD/2,Bolt1_Z]) rotate([-90,0,0]) Bolt4ButtonHeadHole();
			translate([0,Coupler_OD/2,Bolt1_Z+Bolt4Inset*2]) rotate([-90,0,0]) Bolt4ButtonHeadHole();
			}
		
		// Cut here
		for (j=[0:nPetals-1]) rotate([0,0,360/nPetals*(j+0.5)])
			translate([0,Coupler_OD/2,Len/2+BaseOffset]) cube([2,2,Len+Overlap*2], center=true);
	} // difference
} // Petals

//rotate([180,0,0]) Petals(Len=110, nPetals=3);

module PetalSpringHolder(Len=75){
	Width=11;
	Thickness=3;
	Spring_d=5/16*25.4;
	Axle_d=4;
	Axle_L=Width+7;
	AxleBoss_d=Axle_d+2.4;
	
	difference(){
		union(){
			translate([0,0,8]) hull(){
				translate([0,Coupler_OD/2-Thickness-Width/2,0]) cylinder(d=Width, h=10);
				translate([-Width/2,Coupler_OD/2-Thickness-1,0]) cube([Width,1,1]);
			
				translate([0,Coupler_OD/2-Thickness,Bolt4Inset*3]) rotate([90,0,0]) cylinder(d=Width,h=3);
			} // hull
			
			translate([0,Coupler_OD/2-Thickness-AxleBoss_d/2,0]) hull(){
				rotate([0,90,0]) cylinder(d=AxleBoss_d, h=PetalWidth, center=true);
				translate([0,0,8]) rotate([0,90,0]) cylinder(d=AxleBoss_d, h=Width, center=true);
			} // hull
			
			// Axle
			translate([0,Coupler_OD/2-Thickness-AxleBoss_d/2,0])
			rotate([0,90,0]) cylinder(d=Axle_d, h=Axle_L, center=true);
		} // union
		
		
		// Sping	
		translate([0,Coupler_OD/2-Thickness-Width/2,-AxleBoss_d/2-Overlap]) {
			cylinder(d=Spring_d+IDXtra, h=16+AxleBoss_d/2);
			cylinder(d=4, h=30);
		}
		
		translate([0,Coupler_OD/2,12]) rotate([-90,0,0]) Bolt4Hole(depth=6);
		translate([0,Coupler_OD/2,12+Bolt4Inset*2]) rotate([-90,0,0]) Bolt4Hole(depth=9.5);
	} // difference
} // PetalSpringHolder

//translate([0,-1,7]) PetalSpringHolder();
//rotate([-90,0,0]) PetalSpringHolder();

module PetalHub(){
	Width=PetalWidth+1;
	Thickness=3;
	nPetals=3;
	Spring_d=5/16*25.4;
	Shelf_Z=16;
	SpringEnd_Y=Coupler_OD/2-16;
	Axle_d=4+IDXtra*3;
	Axle_L=Width+7;
	AxleBoss_d=Axle_d+2.4;
	
	difference(){
		union(){
			STB_SpringEnd(Tube_ID=Coupler_OD, CouplerTube_ID=Coupler_OD-3.6, SleeveLen=16, nRopeHoles=0);
			
			// Close bottom
			//translate([0,0,3]) 
			cylinder(d=Coupler_OD-1, h=6);
			
			// Spring holders
			for (j=[0:nPetals-1]) rotate([0,0,360/nPetals*j]) 
				hull(){
					translate([0,SpringEnd_Y,Shelf_Z-10+Spring_d/2]) 
						rotate([90,0,0]) cylinder(d=Spring_d+3, h=11);
					translate([-(Spring_d+5)/2,SpringEnd_Y-11,Shelf_Z-12]) 
						cube([Spring_d+5,11,1]);
				} // hull
		} // union
		
		// Bolt to BallRetainerBottom
		for (j=[0:2]) rotate([0,0,120*(j+0.5)]) translate([0,Body_OD/2-5,5]) Bolt4HeadHole(lHead=20);
		
		// Petal ledge and Spring slot
		for (j=[0:nPetals-1]) rotate([0,0,360/nPetals*j]){
			translate([-Width/2,5,Shelf_Z]) cube([Width,Coupler_OD/2,20]);
			
			// Axle 
			translate([0,Coupler_OD/2-Thickness-AxleBoss_d/2-0.5,7]){
			
				// Petal pivot socket
				hull(){
					rotate([0,90,0]) cylinder(d=Axle_d, h=Axle_L, center=true);
					translate([0,-6,5])
						rotate([0,90,0]) cylinder(d=Axle_d, h=Axle_L, center=true);
				} // hull
				
				// Petal clearance
				hull(){
					rotate([0,90,0]) cylinder(d=AxleBoss_d+5, h=Width, center=true);
					translate([0,10,0]) rotate([0,90,0]) cylinder(d=AxleBoss_d+5, h=Width, center=true);
					translate([0,0,10]) rotate([0,90,0]) cylinder(d=AxleBoss_d+4, h=Width, center=true);
					}}
				
			// Spring clearance
			hull(){
				translate([0,Coupler_OD/2-16,Shelf_Z-10+Spring_d/2]) 
					rotate([-90,0,0]) cylinder(d=Spring_d+1, h=20);
				translate([0,Coupler_OD/2-16,Shelf_Z+Spring_d/2]) 
					rotate([-90,0,0]) cylinder(d=Spring_d+1, h=20);
			} // hull
		}
		
		// Spring holders
		for (j=[0:nPetals-1]) rotate([0,0,360/nPetals*j]) 
			translate([0,SpringEnd_Y+Overlap,Shelf_Z-10+Spring_d/2]) {
				rotate([90,0,0]) cylinder(d=Spring_d, h=8);
				rotate([90,0,0]) cylinder(d=4, h=12);
		}
				
		// Shock cord hole
		translate([0,0,-Overlap]) rotate([0,0,-60+33]) hull(){
			translate([0,-Coupler_OD/2+6,0]) cylinder(d=4, h=15);
			translate([0,-Coupler_OD/2+16.5,0]) cylinder(d=4, h=15);
		}
		
		
	} // difference
	
} // PetalHub

//PetalHub();

module ShockCordPlate(){
	Plate_t=4;
	
	module SCH(){
		hull(){
			translate([-6,0,-Overlap]) cylinder(d=3, h=Plate_t+Overlap*2);
			translate([6,0,-Overlap]) cylinder(d=3, h=Plate_t+Overlap*2);
		} // hull
	} // SCH
	
	difference(){
		cylinder(d1=Body_OD-NC_Wall_t*2-IDXtra*2, d2=Body_OD-NC_Wall_t*2-IDXtra*4, h=Plate_t);
		
		SCH();
		translate([0,10,0]) SCH();
		translate([0,-10,0]) SCH();
	} // difference
} // ShockCordPlate

//ShockCordPlate();

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

module Electronics_Bay(Tube_OD=Body_OD, Tube_ID=Body_ID){
	// made NC coupler IDXtra smaller 6/22/23

	Len=EBay_Len;
	Altimeter_Z=Len-75;
	BattSwDoor_Z=Len-75;
	TopSkirt_Len=13;
	BottomSkirt_Len=15;

	Alt_a=180;
	Batt1_a=0;
	
	difference(){
		union(){
			Tube(OD=Tube_OD, ID=Tube_ID, Len=Len-TopSkirt_Len, myfn=$preview? 36:360);
			translate([0,0,Len-TopSkirt_Len])
				Tube(OD=Tube_ID-IDXtra, ID=Tube_ID-IDXtra-4.4, Len=TopSkirt_Len, myfn=$preview? 36:360);
				
			difference(){
				translate([0,0,Len-TopSkirt_Len-3]) cylinder(d=Tube_OD-1, h=3+Overlap);
				translate([0,0,Len-TopSkirt_Len-3-Overlap])
					cylinder(d1=Tube_ID, d2=Tube_ID-4.4, h=3+Overlap*3);
			} // difference
		} // union
		
		// Altimeter
		translate([0,0,Altimeter_Z]) rotate([0,0,Alt_a]) 
			Alt_BayFrameHole(Tube_OD=Tube_OD, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y);
		
		// Battery and Switch door holes
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
			Batt_BayFrameHole(Tube_OD=Tube_OD, HasSwitch=true);
		
	} // difference
	
	// Altimeter
	translate([0,0,Altimeter_Z]) rotate([0,0,Alt_a])
		Alt_BayDoorFrame(Tube_OD=Tube_OD, Tube_ID=Tube_ID, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowDoor=false);
	
	// Battery and Switch door2
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
		Batt_BayDoorFrame(Tube_OD=Tube_OD, HasSwitch=true, ShowDoor=false);
	
} // Electronics_Bay

// Electronics_Bay();

module SpringTop(){
	ST_DSpring_OD=44.30;
	
	difference(){
		union(){
			cylinder(d=MotorCoupler_OD, h=10+Overlap);
			
			translate([0,0,10]) cylinder(d=Coupler_OD, h=2+Overlap);
			translate([0,0,10]) cylinder(d=Coupler_ID-1, h=5+Overlap);
			//translate([0,0,10]) Tube(OD=Coupler_ID-1, ID=Coupler_ID-6, Len=10, myfn=$preview? 36:360);
		} // union
		
		translate([0,0,-Overlap]) cylinder(d1= MotorCoupler_OD-4.4, d2=ST_DSpring_OD, h=10);
		cylinder(d= ST_DSpring_OD, h=13);
		cylinder(d= ST_DSpring_OD-6, h=20);
	} // difference
} // SpringTop

//rotate([180,0,0]) SpringTop();

module SpringTopNC_Dual(){
	ST_DSpring_OD=44.30;
	nHoles=3;
	
	difference(){
		union(){
			cylinder(d=MotorCoupler_OD, h=10+Overlap);
			
			translate([0,0,10]) cylinder(d=Coupler_OD, h=2+Overlap);
			translate([0,0,10]) cylinder(d=Coupler_ID, h=7+Overlap);
			//translate([0,0,10]) Tube(OD=Coupler_ID-1, ID=Coupler_ID-6, Len=10, myfn=$preview? 36:360);
		} // union
		
		translate([0,0,-Overlap]) cylinder(d1= MotorCoupler_OD-4.4, d2=ST_DSpring_OD, h=10);
		cylinder(d= ST_DSpring_OD, h=13);
		cylinder(d= ST_DSpring_OD-6, h=20);
		
		// Retention cord
		for (j=[0:nHoles-1]) rotate([0,0,360/nHoles*j]) translate([Coupler_ID/2-5,0,0]) cylinder(d=4, h=30);
	} // difference
} // SpringTopNC_Dual

//rotate([180,0,0]) SpringTopNC_Dual();

module NC_ShockcordRingDual(){
	Plate_t=4;
	nHoles=3;
	Tube_d=12.7;
	CR_z=-3;
	ST_DSpring_OD=44.30;
	
	// Stop ring
	translate([0,0,13]) Tube(OD=Body_OD, ID=Body_ID-1, Len=2, myfn=$preview? 36:360);
	
	translate([0,0,15])
	difference(){
		union(){
			// Nosecone interface
			translate([0,0,-1]) Tube(OD=Body_ID-IDXtra*2, ID=Body_ID-4.4, Len=14, myfn=$preview? 36:360);
			// Body tube interface
			translate([0,0,-15]) Tube(OD=Body_ID, ID=Body_ID-4.4, Len=15, myfn=$preview? 36:360);
				
			// Stiffener
			translate([0,0,-5])
				cylinder(d=Body_ID-1, h=6);
				
			// Tube holder
			hull(){
				translate([0,0,CR_z+3+Tube_d/2]) 
					rotate([0,90,0]) cylinder(d=Tube_d+4.4, h=Body_ID-3, center=true);
				translate([0,0,CR_z+2]) cube([Body_ID-4,Tube_d+8,Overlap],center=true);
			} // hull
		} // union
		
		// Center hole
		translate([0,0,-6]) cylinder(d=ST_DSpring_OD-6, h=30);
		// Spring
		translate([0,0,-6]) cylinder(d=ST_DSpring_OD, h=3);
		
		// Tube hole
		translate([0,0,CR_z+3+Tube_d/2]) rotate([0,90,0]) cylinder(d=Tube_d, h=Body_OD, center=true);
		
		// Retention cord
		for (j=[0:nHoles-1]) rotate([0,0,360/nHoles*j]) translate([0,Coupler_ID/2-5,-10]) cylinder(d=4, h=30);
	} // difference
	
} // NC_ShockcordRingDual

//translate([0,0,-15]) color("Green") NC_ShockcordRingDual();

module EBay_ShockcordRingDual(){
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

module Electronics_BayDual(Tube_OD=Body_OD, Tube_ID=Body_ID){
	// made NC coupler IDXtra smaller 6/22/23

	Len=EBay_Len;
	Altimeter_Z=Len/2;
	BattSwDoor_Z=Len/2;
	TopSkirt_Len=13;
	BottomSkirt_Len=15;

	Alt_a=120;
	Batt1_a=0;
	Batt2_a=240;
	
	difference(){
		Tube(OD=Tube_OD, ID=Tube_ID, Len=Len, myfn=$preview? 36:360);
		
		// Altimeter
		translate([0,0,Altimeter_Z]) rotate([0,0,Alt_a]) 
			Alt_BayFrameHole(Tube_OD=Tube_OD, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y);
		
		// Battery and Switch door holes
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
			Batt_BayFrameHole(Tube_OD=Tube_OD, HasSwitch=true);
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt2_a]) 
			Batt_BayFrameHole(Tube_OD=Tube_OD, HasSwitch=true);
		
	} // difference
	
	// Altimeter
	translate([0,0,Altimeter_Z]) rotate([0,0,Alt_a])
		Alt_BayDoorFrame(Tube_OD=Tube_OD, Tube_ID=Tube_ID, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowDoor=false);
	
	// Battery and Switch door2
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
		Batt_BayDoorFrame(Tube_OD=Tube_OD, HasSwitch=true, ShowDoor=false);
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt2_a]) 
		Batt_BayDoorFrame(Tube_OD=Tube_OD, HasSwitch=true, ShowDoor=false);
	
} // Electronics_BayDual

// Electronics_BayDual();

module SpringSpacer(OD=Coupler_OD, Tube_ID=Coupler_OD-2.4, Len=40){
	Tube(OD=OD, ID=Tube_ID, Len=Len, myfn=$preview? 36:360);
} // SpringSpacer

//SpringSpacer();

module SpringEndTop(OD=Coupler_OD, Tube_ID=Coupler_OD-2.4, nRopeHoles=3){
	ST_DSpring_OD=44.30;
	Piston_h=15;
	Len=30;
	Plate_t=3;
	
	module SCH(){
		hull(){
			translate([-6,0,-Overlap]) cylinder(d=3, h=Plate_t+Overlap*2);
			translate([6,0,-Overlap]) cylinder(d=3, h=Plate_t+Overlap*2);
		} // hull
	} // SCH
	
	difference(){
		union(){
			Tube(OD=OD, ID=Tube_ID, Len=Len, myfn=$preview? 36:360);
			
			translate([0,0,Len-Piston_h]) cylinder(d=OD-1, h=Piston_h);
		} // union
		
		// Rope Holes
		nRopes=3;
		Rope_d=4;
		for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j]) translate([0,ST_DSpring_OD/2+Rope_d/2+2,0])
			cylinder(d=Rope_d, h=Len);
		
		// Top dish
		translate([0,0,Len-Piston_h+3+Plate_t]) 
			cylinder(d1=Tube_ID-20, d2=Tube_ID, h=Piston_h-3-Plate_t+Overlap);
	
		// Spring
		cylinder(d=ST_DSpring_OD, h=Len-Piston_h+3);
		
		// Shock Cord
		translate([0,0,Len-Piston_h+3]) SCH();
		//translate([0,0,-Overlap]) cylinder(d=5, h=Len);
		
		// Air Vents
		nVents=8;
		Vent_d=9;
		for (j=[0:nVents-1]) rotate([0,0,360/nVents*j]) translate([0,ST_DSpring_OD/2-Vent_d/2-2,0])
			cylinder(d=Vent_d, h=Len);
	} // difference
	

} // SpringEndTop

//SpringEndTop();

module SpringEndBottom(OD=Coupler_OD, Tube_ID=Coupler_OD-2.4, nRopeHoles=3){
	ST_DSpring_OD=44.30;
	Piston_h=15;
	Len=30;
	Plate_t=3;
	
	module SCH(){
		hull(){
			translate([-6,0,-Overlap]) cylinder(d=3, h=Plate_t+4);
			translate([6,0,-Overlap]) cylinder(d=3, h=Plate_t+4);
		} // hull
	} // SCH
	
	difference(){
		union(){
			Tube(OD=OD, ID=Tube_ID, Len=Len, myfn=$preview? 36:360);
			
			cylinder(d=OD-1, h=Piston_h);
		} // union
		
		// Rope Holes
		nRopes=3;
		Rope_d=4;
		for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j]) translate([0,ST_DSpring_OD/2+Rope_d/2+2,-Overlap])
			cylinder(d=Rope_d, h=Len);
		
		// Top dish
		translate([0,0,3+Plate_t]) 
			cylinder(d1=Tube_ID-20, d2=Tube_ID, h=Piston_h-3-Plate_t+Overlap);
	
		// Spring
		translate([0,0,-Overlap]) cylinder(d=ST_DSpring_OD, h=3);
		
		// Shock Cord
		SCH();
		//translate([0,0,-Overlap]) cylinder(d=5, h=10);
		
		// Air Vents
		nVents=8;
		Vent_d=9;
		for (j=[0:nVents-1]) rotate([0,0,360/nVents*j]) translate([0,ST_DSpring_OD/2-Vent_d/2-2,0])
			cylinder(d=Vent_d, h=Len);
	} // difference
	
} // SpringEndBottom

//SpringEndBottom();

module UpperRailBtnMount(){
	Len=15;
	
	difference(){
		cylinder(d=Body_ID, h=Len);
		
		// remove extra
		translate([0,0,-Overlap]) {
		 translate([10,-Body_ID/2,0]) cube([Body_ID,Body_ID,Len+Overlap*2]);
		 mirror([1,0,0]) translate([10,-Body_ID/2,0]) cube([Body_ID,Body_ID,Len+Overlap*2]);
		}
		
		// Motor tube
		translate([0,0,-Overlap]) cylinder(d=MotorTubeHole_d, h=Len+Overlap*2);
		
		// Rail button bolt hole
		translate([0,-Body_OD/2,Len/2]) rotate([90,0,0]) Bolt8Hole();
		
		// Shock cord
		translate([0,MotorTube_OD/2+5,-1]) rotate([20,0,0]) cylinder(d=5, h=Len+5);
	} // difference

	difference(){
		rotate([0,0,90/5]) CenteringRing(OD=Body_ID, ID=MotorTubeHole_d, Thickness=3, nHoles=5, Offset=0);
		
		// Shock cord
		translate([0,MotorTube_OD/2+5,-1]) rotate([20,0,0]) cylinder(d=5, h=Len+5);
	} // difference	
	
} // UpperRailBtnMount

//UpperRailBtnMount();

module FinCan(LowerHalfOnly=false, UpperHalfOnly=false){
	Wall_t=1.2;
	FinBox_W=Fin_Root_W+4.4;
	
	difference(){
		union(){
			// Body Tube
			Tube(OD=Body_OD, ID=Body_OD-Wall_t*2, Len=Can_Len, myfn=$preview? 36:360);
			// Motor Tube Sleeve
			Tube(OD=MotorTubeHole_d+Wall_t*2, ID=MotorTubeHole_d, Len=Can_Len, myfn=$preview? 36:360);
			
			// integrated coupler
			translate([0,0,Can_Len-Overlap])
				Tube(OD=Body_ID-IDXtra, ID=Body_ID-4, Len=10, myfn=$preview? 36:360);
			difference(){
				translate([0,0,Can_Len-5])
					Tube(OD=Body_OD-1, ID=Body_ID-4, Len=5, myfn=$preview? 36:360);
				translate([0,0,Can_Len-5-Overlap]) cylinder(d1=Body_OD-Wall_t*2, d2=Body_ID-5, h=5);
			} // difference
			
			// Upper Centering Ring
			//translate([0,0,Can_Len-3])
			//	CenteringRing(OD=Body_OD-1, ID=Body_ID-10, Thickness=3, nHoles=0, Offset=0);
				
			// Middle Centering Rings
			translate([0,0,Can_Len/2-3])
				rotate([0,0,180/nFins])
					CenteringRing(OD=Body_OD-1, ID=MotorTubeHole_d, Thickness=6, nHoles=nFins, Offset=0);
			
			// Fin Boxes
			difference(){
				for (j=[0:nFins]) rotate([0,0,360/nFins*j]) 
					translate([0,-FinBox_W/2,0]) cube([Body_OD/2,FinBox_W,Can_Len]);
					
				difference(){
					translate([0,0,-Overlap]) cylinder(d=Body_OD+10, h=Can_Len+Overlap*2);
					translate([0,0,-Overlap*2]) cylinder(d=Body_OD-1, h=Can_Len+Overlap*4);
				} // difference
				
				translate([0,0,-Overlap]) cylinder(d=MotorTubeHole_d, h=Can_Len+Overlap*2);
			} // difference
			
			TailCone(Threaded=true, Cone_Len=35, Interface_OD=Body_OD-1);
		} // union
	
		// Fin Sockets
		translate([0,0,Fin_Root_L/2+FinInset_Len])
			TrapFin2Slots(Tube_OD=Body_OD, nFins=nFins, Post_h=Fin_Post_h, 
					Root_L=Fin_Root_L, Root_W=Fin_Root_W, Chamfer_L=Fin_Chamfer_L);
		
		// Rail button bolt hole
		translate([-Body_OD/2,0,10]) rotate([0,-90,0]) Bolt8Hole();
		
		if (LowerHalfOnly) translate([0,0,Can_Len/2]) cylinder(d=Body_OD+1, h=Can_Len/2+50);
		if (UpperHalfOnly) translate([0,0,Can_Len/2]) 
			rotate([180,0,0]) cylinder(d=Body_OD+1, h=Can_Len/2+50);
			
		if ($preview) cube([50,50,300]);
	} // difference
} // FinCan

//FinCan(LowerHalfOnly=false, UpperHalfOnly=false);
//TailCone();

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

module TailCone(Threaded=true, Cone_Len=35, Interface_OD=Body_ID){
	FinInset_Len=5;
	FinAlignment_Len=10;
	AftClosure_h=10;
	Retainer_h=2;
	Nut_Len=Retainer_h+AftClosure_h+10;
	
	difference(){
		union(){
			hull(){
				translate([0,0,-Cone_Len]) cylinder(d=MotorTubeHole_d+2.4, h=2, $fn=$preview? 90:360);
				
				difference(){
					rotate_extrude($fn=$preview? 90:360) translate([Body_OD/2-8,0,0]) circle(d=16);
					translate([0,0,Overlap]) cylinder(d=Body_OD+1,h=10);
				}
			} // hull
			
			translate([0,0,-Overlap]) 
				cylinder(d=Interface_OD, h=FinInset_Len+FinAlignment_Len+Overlap, $fn=$preview? 90:360);
		} // union
		
		// Fin slots
		translate([0,0,Fin_Root_L/2+FinInset_Len])
			TrapFin2Slots(Tube_OD=Body_OD, nFins=nFins, Post_h=Fin_Post_h, 
							Root_L=Fin_Root_L, Root_W=Fin_Root_W, Chamfer_L=Fin_Chamfer_L);
		
		
		// Motor tube
		translate([0,0,-Cone_Len-Overlap]) 
			cylinder(d=MotorTubeHole_d, h=Cone_Len+FinInset_Len+FinAlignment_Len+Overlap*2);
	
		// Rail button bolt hole
		translate([-Body_OD/2,0,10]) rotate([0,-90,0]) Bolt8Hole();
		
		if (Threaded) translate([0,0,-Cone_Len-Overlap]) cylinder(d=Body_OD, h=Nut_Len);
	} // difference
	
	if (Threaded) difference(){
		translate([0,0,-Cone_Len+Nut_Len-10]) 
			ExternalThread(Pitch=2.5, Dia_Nominal=MotorTube_OD+6, 
							Length=10+Overlap, Step_a=$preview? 10:2, TrimEnd=true, TrimRoot=false);
			
		// Motor tube
		translate([0,0,-Cone_Len-Overlap]) 
			cylinder(d=MotorTubeHole_d, h=Cone_Len+FinInset_Len+FinAlignment_Len+Overlap*2);
	}
} // TailCone

//rotate([180,0,0]) TailCone();

module MotorRetainer(HasWrenchCuts=false, Cone_Len=35, ExtraLen=0){
	
	
	AftClosure_h=10;
	Retainer_h=2;
	Nut_Len=Retainer_h+AftClosure_h+10;
	
	difference(){
		hull(){
			difference(){
				hull(){
					// Bottom
					translate([0,0,-Cone_Len]) cylinder(d=MotorTube_OD+2.4+IDXtra*2, h=2, $fn=$preview? 90:360);
						
					// Top
					rotate_extrude($fn=$preview? 90:360) translate([Body_OD/2-8,0,0]) circle(d=16);
				} // hull
				
				// Trim Top	
				translate([0,0,-Cone_Len+Nut_Len-Overlap]) cylinder(d=Body_OD+1, h=Cone_Len);
			} // difference
		
			translate([0,0,-Cone_Len-ExtraLen]) 
				cylinder(d=MotorTube_OD+2.4+IDXtra*2, h=2, $fn=$preview? 90:360);
		} // hull
			
		// Exit
		translate([0,0,-Cone_Len-ExtraLen-Overlap]) 
			cylinder(d=MotorTube_ID+IDXtra*2, h=Cone_Len);
			
		// Motor tube
		translate([0,0,-Cone_Len-ExtraLen+Retainer_h]) 
			cylinder(d=MotorTube_OD+IDXtra*3, h=Cone_Len);
	
		translate([0,0,-Cone_Len+Nut_Len-12+Overlap])
			ExternalThread(Pitch=2.5, Dia_Nominal=MotorTube_OD+6+IDXtra*4, 
							Length=15, Step_a=$preview? 10:2, TrimEnd=true, TrimRoot=false);
		
		// Spanner Wrench
		if (HasWrenchCuts){
			SW_Z=16;
			SW_W=Body_OD-22;
			translate([SW_W/2,-Body_OD/2,-Cone_Len]) cube([Body_OD,Body_OD,SW_Z]);
			mirror([1,0,0])
			translate([SW_W/2,-Body_OD/2,-Cone_Len]) cube([Body_OD,Body_OD,SW_Z]);
		} // if
		
		if ($preview) translate([0,0,-Cone_Len-ExtraLen-1]) cube([50,50,100]);
	} // difference
} // MotorRetainer

//translate([0,0,-0.2]) MotorRetainer(ExtraLen=4);

/*
difference(){
	union(){
		TailCone(Cone_Len=35);
		translate([0,0,-Overlap]) rotate([0,0,-150]) MotorRetainer(Cone_Len=35,ExtraLen=4);
	} // union
	
	translate([0,0,-50]) cube([50,50,50]);
} // difference
/**/











































