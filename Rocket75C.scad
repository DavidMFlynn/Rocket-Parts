// ***********************************
// Project: 3D Printed Rocket
// Filename: Rocket75C.scad
// by David M. Flynn
// Created: 8/6/2023 
// Revision: 1.2.0  12/3/2023 
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

// BluntOgiveNoseCone(ID=Coupler_OD, OD=Body_OD, L=NC_Len, Base_L=13, Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=120, LowerPortion=false);

// BluntOgiveNoseCone(ID=Coupler_OD, OD=Body_OD, L=NC_Len, Base_L=13, Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=120, Transition_OD=BT75Body_OD-18, LowerPortion=true);
//
// NC_ShockcordRing75(Body_OD=Body_OD, Body_ID=Body_ID, NC_Base_L=NC_Base_L);
//
// *** Electronics Bay ***
//
// Electronics_Bay(Tube_OD=Body_OD, Tube_ID=Body_ID);
//
// *** Dual Deploy Electronics Bay ***
//
// Electronics_BayDual(Tube_OD=Body_OD, Tube_ID=Body_ID);
// 
// *** Doors ***
//
// rotate([-90,0,0]) AltDoor54(Tube_OD=Body_OD, IsLoProfile=false, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowAlt=true);
// 
// rotate([-90,0,0]) Batt_Door(Tube_OD=Body_OD, InnerTube_OD=0, HasSwitch=true);
//
// *** Ball Lock ***
//
// STB_LockDisk(BallPerimeter_d=Body_OD, nLockBalls=3);
// rotate([180,0,0]) R75_BallRetainerTop();
// R75_BallRetainerBottom();
// rotate([180,0,0]) STB_TubeEnd(BallPerimeter_d=Body_OD, nLockBalls=3, Body_OD=Body_OD, Body_ID=Body_ID, Skirt_Len=20);
//
// *** petal deployer ***
//
// PD_NC_PetalHub(OD=Coupler_OD, nPetals=3, nRopes=3); // for dual deploy only
// PD_PetalHub(OD=Coupler_OD, nPetals=3, ShockCord_a=PD_ShockCordAngle());
// rotate([-90,0,0]) PD_PetalSpringHolder(OD=Coupler_OD);
// rotate([180,0,0]) PD_Petals(OD=Coupler_OD, Len=150, nPetals=3, Wall_t=1.8, AntiClimber_h=3, HasLocks=false);
//
// SpringEndTop(OD=Coupler_OD-IDXtra, Tube_ID=Coupler_OD-IDXtra-3.6, nRopeHoles=3);
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
// translate([300,0,0]) ShowRocket(ShowInternals=true);
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
NC_Base_L=13;

BodyTubeLen=24*25.4;

Alt_DoorXtra_X=4;
Alt_DoorXtra_Y=2;

FinInset_Len=5*Scale;
Can_Len=Fin_Root_L+FinInset_Len*2;
Bolt4Inset=4;
ShockCord_a=25;// offset between PD_PetalHub and R65_BallRetainerBottom
CouplerLenXtra=-5;

module ShowRocket(ShowInternals=false){
	FinCan_Z=35;
	Fin_Z=FinCan_Z+Fin_Root_L/2+FinInset_Len;
	BodyTube_Z=FinCan_Z+Can_Len+Overlap*2;
	EBay_Z=BodyTube_Z+BodyTubeLen+33.5;
	NoseCone_Z=EBay_Z+EBay_Len-13+Overlap*2;
	
	//*
	translate([0,0,NoseCone_Z])
		BluntOgiveNoseCone(ID=Coupler_OD, OD=Body_OD, L=NC_Len, Base_L=13, 
							Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=0, LowerPortion=false);
	
	translate([0,0,EBay_Z]) Electronics_Bay();
	
	translate([0,0,BodyTube_Z+BodyTubeLen+10+Overlap*2])
		STB_BallRetainerTop(BallPerimeter_d=Body_OD, Body_OD=Body_ID, nLockBalls=3, 
			HasIntegratedCouplerTube=true, Body_ID=Body_ID, HasSecondServo=false, UsesBigServo=false);
	/**/
	
	if (ShowInternals){
		translate([0,0,BodyTube_Z+BodyTubeLen+10+Overlap*2-0.2]) R75_BallRetainerBottom();
		translate([0,0,BodyTube_Z+BodyTubeLen+10+Overlap*2-9.2]) rotate([0,0,200]) rotate([180,0,0]) 
			PD_PetalHub(OD=BT75Coupler_OD, nPetals=3, ShockCord_a=PD_ShockCordAngle());
		translate([0,0,BodyTube_Z+BodyTubeLen+10+Overlap*2-15]) 
			rotate([0,0,200]) rotate([180,0,0]) PD_Petals(OD=Coupler_OD, Len=150, nPetals=3);
	}
	
	if (ShowInternals==false)
	translate([0,0,BodyTube_Z+BodyTubeLen+10])
		STB_TubeEnd(BallPerimeter_d=Body_OD, nLockBalls=3, Body_OD=Body_OD, Body_ID=Body_ID, Skirt_Len=20);
	
	if (ShowInternals==false)
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
//ShowRocket(ShowInternals=true);

module R75_BallRetainerBottom(){
	difference(){
		STB_BallRetainerBottom(BallPerimeter_d=Body_OD, Body_OD=Body_ID, nLockBalls=3, HasSpringGroove=false);
		
		rotate([0,0,PD_ShockCordAngle()-ShockCord_a]) PD_PetalHubBoltPattern(OD=Coupler_OD, nPetals=3) Bolt4Hole();

	} // difference
} // R75_BallRetainerBottom

// translate([0,0,-8]) rotate([180,0,0]) R75_BallRetainerBottom();
module R75_BallRetainerTop(){
	// combined with NC_ShockcordRingDual(){
	
	Tube_d=12.7;
	Tube_a=-40;
	Tube_Z=25;
	CR_z=8;
	Wall_t=3;
	
	difference(){
		union(){
			STB_BallRetainerTop(BallPerimeter_d=Body_OD, Body_OD=Body_ID, 
						nLockBalls=3, 
						HasIntegratedCouplerTube=true, 
							IntegratedCouplerLenXtra=CouplerLenXtra, 
							Body_ID=Body_ID-IDXtra, HasSecondServo=false, UsesBigServo=false);
			
			translate([0,0,Tube_Z]) 
				Tube(OD=Body_ID-IDXtra, ID=Body_ID-IDXtra-Wall_t*2, 
						Len=Tube_d/2+Wall_t, myfn=$preview? 90:360);
				
			// Tube holder
			rotate([0,0,Tube_a]) difference(){
				hull(){
					translate([0,0,Tube_Z])
						rotate([0,90,0]) cylinder(d=Tube_d+Wall_t*2, h=Body_ID-3, center=true);
					translate([0,0,CR_z]) cube([Body_ID-4,Tube_d,Overlap],center=true);
				} // hull
				
				// center hole
				translate([0,0,Tube_Z]) cube([Body_ID-25,Tube_d+10,55],center=true);
			} // difference
		} // union
		
		// Center hole
		//translate([0,0,-6]) cylinder(d=ST_DSpring_OD-6, h=30);
		
		
		// Tube hole
		translate([0,0,Tube_Z]) rotate([0,0,Tube_a]) 
			rotate([0,90,0]) cylinder(d=Tube_d, h=Body_OD, center=true);
		
		//cube([50,50,50]);
	} // difference
	
} // R75_BallRetainerTop

//R75_BallRetainerTop();

module Electronics_Bay(Tube_OD=Body_OD, Tube_ID=Body_ID){
	// One Battery Door w/ Switch and One Altimeter
	Len=EBay_Len;
	Altimeter_Z=Len/2;
	BattSwDoor_Z=Len/2;

	Alt_a=180;
	Batt1_a=0;
	
	difference(){
		
		Tube(OD=Tube_OD, ID=Tube_ID, Len=Len, myfn=$preview? 36:360);
				
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

module Electronics_BayDual(Tube_OD=Body_OD, Tube_ID=Body_ID){
	// Two Battery Doors w/ Switch and One Altimeter
	
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
	
	//echo(OD=OD);
	
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
			
			// Spring
			translate([0,0,8]) Tube(OD=ST_DSpring_OD+10, ID=ST_DSpring_OD, Len=12, myfn=$preview? 36:360);
		} // union
		
		// Rope Holes
		nRopes=3;
		Rope_d=4;
		for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j]) translate([0,ST_DSpring_OD/2+Rope_d/2+6,0])
			cylinder(d=Rope_d, h=Len);
		
		// Top dish
		translate([0,0,Len-Piston_h+3+Plate_t]) 
			cylinder(d1=Tube_ID-20, d2=Tube_ID-2, h=Piston_h-3-Plate_t+Overlap);
	
		// Spring
		cylinder(d=ST_DSpring_OD, h=Len-Piston_h+3);
		cylinder(d1=ST_DSpring_OD+5, d2=ST_DSpring_OD, h=Len-Piston_h);
		
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
	FinBox_W=Fin_Root_W+Wall_t*2;
	
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
			
			// Rail button bolt boss
			translate([-Body_OD/2,0,10]) rotate([0,90,0]) cylinder(d=10, h=(Body_OD-MotorTubeHole_d)/2);
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

//rotate([180,0,0]) FinCan(LowerHalfOnly=false, UpperHalfOnly=false);
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






































