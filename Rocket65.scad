// ***********************************
// Project: 3D Printed Rocket
// Filename: Rocket65.scad
// by David M. Flynn
// Created: 6/16/2023 
// Revision: 1.0.11  10/22/2023 
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  Rocket with 65mm Body and 29mm or 38mm motor. 
//  "Little Orange One"
//  "Mr. Green"
//  "Miss Scarlett"
//  "Prof. Plumb"
//  "Ghost"
//  Single deploy:
//   Mission Control V3 / RocketServo
//
//  ***** Parts *****
//
// LOC 2.65" Body Tube by 18 inches
// Blue Tube 1.5" Body Tube by 12 inches
// 36" Parachute
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
// 1.0.11 10/22/2023 Now uses PetalDeploymentLib.scad
// 1.0.10 9/10/2023  Increased Alt_DoorXtra_X fron 2 to 6
// 1.0.9  8/8/2023   Improved fin can
// 1.0.8  7/21/2023  Updated PetalHub()
// 1.0.7  7/10/2023  Set aft closure to 10mm for 29mm, working on a more robust petal.
// 1.0.6  6/30/2023  Fixed motor tube hole diameter
// 1.0.5  6/29/2023  Round shock cord in SpringEndTop(), added mount for petals to BallRetainerBottom
// 1.0.4  6/27/2023  Added hardware list and SpringSpacer()
// 1.0.3  6/22/2023  Adjusted size of ebay parts. Fixed batt door now has switch.
// 1.0.2  6/21/2023  38mm motor tube
// 1.0.1  6/19/2023  Nose cone.
// 1.0.0  10/4/2022  First code. Copy of Rocket 98.
//
// ***********************************
//  ***** for STL output *****
//
// *** Nosecode ***
//
// BluntOgiveNoseCone(ID=Coupler_OD, OD=Body_OD, L=NC_Len, Base_L=13, Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=0, LowerPortion=false);
//
// ShockCordPlate();
// FeatherWeightBracket(); // Replaces ShockCordPlate
// EggFinderBracket(); // Replaces ShockCordPlate
//
// *** Electronics Bay ***
//
// Electronics_Bay(Tube_OD=Body_OD, Tube_ID=Body_ID);
// rotate([-90,0,0]) AltDoor54(Tube_OD=Body_OD, IsLoProfile=false, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowAlt=true);
// 
// rotate([-90,0,0]) Batt_Door(Tube_OD=Body_OD, InnerTube_OD=0, HasSwitch=true);
//
// *** Ball Lock ***
//
// STB_LockDisk(BallPerimeter_d=Body_OD, nLockBalls=3);
// rotate([180,0,0]) STB_BallRetainerTop(BallPerimeter_d=Body_OD, Body_OD=Body_ID, nLockBalls=3, HasIntegratedCouplerTube=true, Body_ID=Body_ID-IDXtra, HasSecondServo=false, UsesBigServo=false);
// R65_BallRetainerBottom();
// rotate([180,0,0]) STB_TubeEnd(BallPerimeter_d=Body_OD, nLockBalls=3, Body_OD=Body_OD, Body_ID=Body_ID, Skirt_Len=20);
//
// *** optional petal deployer ***
//
// PD_PetalHub(Coupler_OD=Coupler_OD, nPetals=3, ShockCord_a=PD_ShockCordAngle());
// rotate([-90,0,0]) PD_PetalSpringHolder(Coupler_OD=Coupler_OD);
// rotate([180,0,0]) PD_Petals(Coupler_OD=Coupler_OD, Len=110, nPetals=3);
//
// SpringEndTop(OD=Coupler_OD, Tube_ID=Coupler_OD-2.4, nRopeHoles=3);
// SpringEndBottom(OD=Coupler_OD, Tube_ID=Coupler_OD-2.4, nRopeHoles=3);
// SpringSpacer(OD=Coupler_OD, Tube_ID=Coupler_OD-2.4, Len=40);
//
// UpperRailBtnMount();
//
// *** Fin Can ***
//
// rotate([180,0,0]) FinCan(LowerHalfOnly=false, UpperHalfOnly=false);
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
use<PetalDeploymentLib.scad>
use<ThreadLib.scad>

//also included
 //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

nFins=5;
Fin_Post_h=10;
Fin_Root_L=160;
Fin_Root_W=6;
Fin_Tip_W=3.0;
Fin_Tip_L=70;
Fin_Span=70;
Fin_TipOffset=20;
Fin_Chamfer_L=18;

Body_OD=LOC65Body_OD;
Body_ID=LOC65Body_ID;
Coupler_OD=LOC65Coupler_OD;
Coupler_ID=LOC65Coupler_ID;
/*
// *** 29mm Motor Tube ***
MotorTube_OD=PML29Body_OD;
MotorTube_ID=PML29Body_ID;
/**/
//*
// *** 38mm Motor Tube ***
MotorTube_OD=BT38Body_OD;
MotorTube_ID=BT38Body_ID;
/**/
MotorTubeHole_d=MotorTube_OD+IDXtra*3;

EBay_Len=152;

NC_Len=180;
NC_Tip_r=5;
NC_Base=5;
NC_Lock_H=5;
NC_Wall_t=1.8;

BodyTubeLen=18*25.4;

Alt_DoorXtra_X=6;
Alt_DoorXtra_Y=2;

FinInset_Len=5;
Can_Len=Fin_Root_L+FinInset_Len*2;
Bolt4Inset=4;
ShockCord_a=33; // offset between PD_PetalHub and R65_BallRetainerBottom


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

module R65_BallRetainerBottom(){
	difference(){
		STB_BallRetainerBottom(BallPerimeter_d=Body_OD, Body_OD=Body_ID, nLockBalls=3, HasSpringGroove=false);
		
		rotate([0,0,PD_ShockCordAngle()-ShockCord_a]) 
			PD_PetalHubBoltPattern(Coupler_OD=Coupler_OD, nPetals=3) Bolt4Hole();
	} // difference
} // R65_BallRetainerBottom

// translate([0,0,-8]) rotate([180,0,192]) R65_BallRetainerBottom();

module EggFinderBracket(){
	Battery_X=14;
	NC_Base_L=13;
	Plate_t=4;
	
	translate([Battery_X,0,NC_Base_L+1]) rotate([0,0,90]) SingleBatteryPocket(ShowBattery=false);
	difference(){
		translate([0,0,NC_Base_L]) ShockCordPlate(Offset_X=-5);
		translate([Battery_X,0,NC_Base_L-Overlap]) cylinder(d=12.0, h=Plate_t+1);
	} // difference
	
	translate([-18,0,NC_Base_L+Plate_t-1]) rotate([0,6,0]) 
		difference(){
			translate([0,-6,0]) cube([Plate_t,12,82]);
			translate([0,0,3.5]) rotate([0,-90,0]) Bolt4Hole();
			translate([0,0,3.5+75]) rotate([0,-90,0]) Bolt4Hole();
		} // difference
	
	difference(){
		Splice_BONC(OD=Body_OD, H=30, L=NC_Len, Base_L=NC_Base_L, Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=30);
		
		translate([-18,0,NC_Base_L+Plate_t-1]) rotate([0,6,0]) translate([0,0,3.5]) 
			rotate([0,-90,0]) translate([0,0,1]) cylinder(d=8, h=20);
	} // difference
} // EggFinderBracket

//EggFinderBracket();

module FeatherWeightBracket(){
	NC_Base_L=13;

	module FW_GPS_SW_Hole(a=0){
		translate([-4,-1.6-1,-1]) 
			rotate([0,-90+a,0]) cylinder(d=1.7, h=100);
	} // FW_GPS_SW_Hole

	module FW_GPS_Mount(){
		Boss_d=10;
		
		module Boss(){
			difference(){
				rotate([-90,0,0]) cylinder(d1=7,d2=Boss_d,h=6);
					
				rotate([90,0,0]) Bolt4Hole();
			} // difference
		} // Boss
		
		// Backing plate
		
		Boss_Y=2;
		Boss_Z=13.5;
		difference(){
			union(){
				hull(){
					translate([-4,6,-8]) cube([20.4+8,3,42+12]);
					translate([-4,6,-8]) cube([20.4+8,10,1]);
				} // hull
				
				translate([4,Boss_Y,Boss_Z])Boss();
				translate([4,Boss_Y,Boss_Z])translate([12.7,0,25.4]) Boss();
			} // union
			
			translate([4,Boss_Y,Boss_Z]) rotate([90,0,0]) Bolt4Hole(depth=20);
			translate([4,Boss_Y,Boss_Z]) translate([12.7,0,25.4]) rotate([90,0,0]) Bolt4Hole();
		} // difference
		
	
			
	} // FW_GPS_Mount
		
	//FW_GPS_Mount();

	module FW_GPS_Batt_Mount(){
		Batt_X=25;
		Batt_Y=5;
		Batt_Z=37;
		Wall_t=2.4;
		
		difference(){
			union(){
				cube([Batt_X+Wall_t*2, Batt_Y+Wall_t*2, Batt_Z+Wall_t*2], center=true);
				hull(){
					translate([0,Batt_Y/2+Wall_t,Batt_Z/2+Wall_t/2]) 
						cube([10,Overlap,Wall_t],center=true);
					translate([0,Batt_Y/2+Wall_t+10,-Batt_Z/2-Wall_t]) 
						cube([10,20,Overlap],center=true);
				} // hull
			} // union
			
			cube([Batt_X, Batt_Y, Batt_Z], center=true);
			
			// Wire Path
			hull(){
				cylinder(d=Batt_Y, h=Batt_Z);
				translate([0,-5,0]) cylinder(d=Batt_Y, h=Batt_Z);
			} // hull
			
			//ty-wrap
			translate([0,Batt_Y/2+Wall_t+2,0]) 
				rotate([0,90,0]) cylinder(d=4, h=Batt_X+Wall_t*2+Overlap, center=true);
			translate([0,-Batt_Y/2-2.4,0]) 
				rotate([0,90,0]) cylinder(d=4, h=Batt_X+Wall_t*2+Overlap, center=true);
			
			translate([0, -5, 5]) cube([Batt_X, Batt_Y, Batt_Z], center=true);
			translate([0, -3, 5]) cube([Batt_X, Batt_Y+1, Batt_Z-10], center=true);
			translate([0, -3, 0]) cube([Batt_X, Batt_Y, Batt_Z-10], center=true);
		} // difference
		
	} // FW_GPS_Batt_Mount

	//FW_GPS_Batt_Mount();
	
	// GPS mount 
	translate([-2,0,0]){
	rotate([0,0,90]) translate([-10,-23,NC_Base_L+11]) rotate([-10,0,0]) FW_GPS_Mount();
	rotate([0,0,270]) translate([1,-13,NC_Base_L+23]) FW_GPS_Batt_Mount();
	}
			
	Plate_t=4;
	
	module SCH(){
		hull(){
			translate([-6,0,-Overlap]) cylinder(d=3, h=Plate_t+Overlap*2);
			translate([6,0,-Overlap]) cylinder(d=3, h=Plate_t+Overlap*2);
		} // hull
	} // SCH
	
	translate([0,0,NC_Base_L]) difference(){
		cylinder(d1=Body_OD-NC_Wall_t*2-IDXtra*2, d2=Body_OD-NC_Wall_t*2-IDXtra*4, h=Plate_t);
		
		//translate([0,0,-Overlap]) cylinder(d=25, h=Plate_t+Overlap*2);
		translate([-2,16,0]) {
			SCH();
			translate([0,10,0]) SCH();
			translate([0,-10,0]) SCH();
		}
	}
		
	difference(){
		Splice_BONC(OD=Body_OD, H=30, L=NC_Len, Base_L=NC_Base_L, 
			Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=30);
			
		translate([0,-6,NC_Base_L+26]) rotate([0,90,0]) cylinder(d=6,h=40);
		
		

	} // difference
		
		
} // FeatherWeightBracket

//FeatherWeightBracket();

module ShockCordPlate(Offset_X=0){
	Plate_t=4;
	
	module SCH(){
		hull(){
			translate([-6,0,-Overlap]) cylinder(d=3, h=Plate_t+Overlap*2);
			translate([6,0,-Overlap]) cylinder(d=3, h=Plate_t+Overlap*2);
		} // hull
	} // SCH
	
	difference(){
		cylinder(d1=Body_OD-NC_Wall_t*2-IDXtra*2, d2=Body_OD-NC_Wall_t*2-IDXtra*4, h=Plate_t);
		
		translate([Offset_X,0,0]){
			SCH();
			translate([0,10,0]) SCH();
			translate([0,-10,0]) SCH();
		}
	} // difference
} // ShockCordPlate

//ShockCordPlate();

module Electronics_Bay(Tube_OD=Body_OD, Tube_ID=Body_ID){
	// made NC coupler IDXtra smaller 6/22/23

	Len=EBay_Len;
	Altimeter_Z=Len/2;
	BattSwDoor_Z=Len/2;
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
		//translate([0,0,Len-Piston_h+3]) SCH();
		translate([0,0,-Overlap]) cylinder(d=5, h=Len);
		
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
			translate([-6,0,-Overlap]) cylinder(d=3, h=Plate_t+Overlap*2);
			translate([6,0,-Overlap]) cylinder(d=3, h=Plate_t+Overlap*2);
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
		translate([0,0,-Overlap]) cylinder(d=5, h=10);
		
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
			Tube(OD=Body_OD, ID=Body_OD-Wall_t*2, Len=Can_Len, myfn=$preview? 36:360);
			Tube(OD=MotorTubeHole_d+Wall_t*2, ID=MotorTubeHole_d, Len=Can_Len, myfn=$preview? 36:360);
			
			// integrated coupler
			translate([0,0,Can_Len-Overlap])
				Tube(OD=Body_ID-IDXtra, ID=Body_ID-4, Len=10, myfn=$preview? 36:360);
			difference(){
				translate([0,0,Can_Len-5])
					Tube(OD=Body_OD-1, ID=Body_ID-4, Len=5, myfn=$preview? 36:360);
				translate([0,0,Can_Len-5-Overlap]) cylinder(d1=Body_OD-Wall_t*2, d2=Body_ID-5, h=5);
			} // difference
			
			// upper centering ring
			//translate([0,0,Can_Len-3])
			//	CenteringRing(OD=Body_OD-1, ID=Body_ID-10, Thickness=3, nHoles=0, Offset=0);
				
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

//translate([0,0,-0.2]) MotorRetainer(ExtraLen=0);

/*
difference(){
	union(){
		TailCone(Cone_Len=35);
		translate([0,0,-Overlap]) rotate([0,0,-150]) MotorRetainer(Cone_Len=35,ExtraLen=4);
	} // union
	
	translate([0,0,-50]) cube([50,50,50]);
} // difference
/**/

module MotorRetainer29Fix(Cone_Len=35, ExtraLen=0){
	
	
	AftClosure_h=10;
	Retainer_h=2;
	Nut_Len=Retainer_h+AftClosure_h+10;
	MotorTube_OD=PML29Body_OD;
	MotorTube_ID=PML29Body_ID;
	
	difference(){
		hull(){
			difference(){
				hull(){
					// Bottom
					translate([0,0,-Cone_Len]) cylinder(d=MotorTube_OD+2.4+IDXtra*2, h=2, $fn=$preview? 90:360);
						
					// Top
					//rotate_extrude($fn=$preview? 90:360) translate([Body_OD/2-8,0,0]) circle(d=16);
					translate([0,0,-13-Overlap]) cylinder(d=54,h=Overlap, $fn=$preview? 90:360);
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
		
		
		if ($preview) translate([0,0,-Cone_Len-ExtraLen-1]) cube([50,50,100]);
	} // difference
} // MotorRetainer29Fix

//MotorRetainer29Fix();

module MotorAdptr3829(){
	difference(){
		union(){
			translate([0,0,10-Overlap])
				Tube(OD=MotorTube_ID, ID=PML29Body_ID, Len=10, myfn=$preview? 36:360);
			Tube(OD=MotorTube_OD, ID=PML29Body_ID, Len=10, myfn=$preview? 36:360);
		} // union
		
		translate([0,0,-Overlap]) cylinder(d=PML29Body_OD+IDXtra*3, h=6);
		
		if ($preview) translate([0,0,-Overlap]) cube([50,50,50]);
	} // difference
} // MotorAdptr3829

// translate([0,0,-32.8]) MotorAdptr3829();









































