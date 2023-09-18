// ***********************************
// Project: 3D Printed Rocket
// Filename: R75StrapOn.scad
// by David M. Flynn
// Created: 9/11/2023 
// Revision: 0.9.4  9/16/2023 
// Units: mm
// ***********************************
//  ***** Notes *****
//
//   Strap-On Booster
//   78mm diameter, 800mm Long
//   380mm BoosterButton spacing
//   Mission Control V3 / RocketServo
//   54mm motor, 54/852 case J460T?
//
//  ***** Parts *****
//
// Blue Tube 2.1" Body Tube: 454mm (Motor Tube)
// Blue Tube 3.0" Body Tube: 190mm (Upper Body), 404mm (Lower Body)
// 36" Parachute
// 1/8" Paracord (3 feet)
// 1/2" Braided Nylon Shock Cord (20 feet)
//
//  ***** Hardware *****
// **** needs updated, ball lock parts are incomplete, ++
// #4-40 x 1/2" Socket Head Cap Screw (5 req) Ball Lock
// #4-40 x 3/8" Button Head Cap Screw (6 req) Doors
// #4-40 x 3/8" Socket Head Cap Screw (3 req) PetalHub
// #4-40 x 1/4" Button Head Cap Screw (4 req) Altimeter
// #2-56 x 1/4" Socket Head Cap Screw (2 req) Servo
// MR84-2RS Bearing (5 req) Ball Lock
// 3/8" Delrin Ball (5 req) Ball Lock
// 4mm Dia. x 16mm Undersize Steel Dowel (5 req) Ball Lock
// 3/16" Dia x 1/8" Disc Magnet N42 (2 req) Ball Lock
// SG90 or MG90S Micro Servo (1 req) Ball Lock
// C&K Rotary Switch (1 req) Battery Door
// Mission Control V3 Altimeter PCBA
// Rocket Servo PCBA
// 1/4"-20 x 1" Flat head (2 req) (BoosterButton)
// 1/4"-20 Thin Nut (4 req) (BoosterButton)
// 1/4"-20 x 3/4" Button head (SpringEndTop)
// CS4323 Spring
// 5/16" Dia x 1-1/4" Spring (4 req) PetalHub
//
//  ***** History *****
//
// 0.9.4  9/16/2023  Ready to test print all
// 0.9.2  9/15/2023  Embedded nuts, removed unused stuff
// 0.9.1  9/14/2023  Reconfigured E-Bay
// 0.9.0  9/11/2023  Copied from Rocket65 V=Rev 1.0.10
//
// ***********************************
//  ***** for STL output *****
//
// *** Nosecode ***
//
// BluntOgiveNoseCone(ID=Coupler_OD, OD=Body_OD, L=NC_Len, Base_L=NC_Base, Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=0, LowerPortion=false);
//
// PetalHub();
// rotate([-90,0,0]) PetalSpringHolder();
// rotate([180,0,0]) Petals(Len=110, nPetals=4);
//
// SpringEndTop(OD=Coupler_OD, Tube_ID=Coupler_OD-2.4, nRopeHoles=3);
//
// *** CableReleaseBB ***
//
// R75SRB_LockingPin();
// rotate([180,0,0]) LockRing();
// rotate([180,0,0]) R75SRB_TopRetainer();
// OuterBearingRetainer();
// rotate([180,0,0]) InnerBearingRetainer();
// rotate([180,0,0]) MagnetBracket();
// rotate([180,0,0]) TriggerPost();
//
// *** Electronics Bay ***
//
// Electronics_Bay(Tube_OD=Body_OD, Tube_ID=Body_ID);
// rotate([-90,0,0]) AltDoor54(Tube_OD=Body_OD, IsLoProfile=false, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowAlt=true);
// 
// rotate([-90,0,0]) Batt_Door(Tube_OD=Body_OD, InnerTube_OD=0, HasSwitch=true);
//
// rotate([180,0,0]) TailCone(Threaded=true, Cone_Len=TailConeLen, Interface_OD=Body_ID);
// MotorRetainer();
//
// BoosterButton(XtraLen=0.3);
//
// ***********************************
//  ***** Routines *****
//
//
// ***********************************
//  ***** for Viewing *****
//
// 
ShowRocketStrapOn(ShowInternals=true);
// ShowRocketStrapOn(ShowInternals=false);
//
// ***********************************
use<AT-RMS-Lib.scad>
include<TubesLib.scad>
use<BoosterDropperLib.scad>
use<RailGuide.scad>
use<Fins.scad>
use<NoseCone.scad>
use<AltBay.scad>
use<BatteryHolderLib.scad>
use<SpringThingBooster.scad>
use<CableReleaseBB.scad>
use<ThreadLib.scad>

//also included
 //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

Body_OD=BT75Body_OD;
Body_ID=BT75Body_ID;
Coupler_OD=BT75Coupler_OD;
Coupler_ID=BT75Coupler_ID;

// *** 54mm Motor Tube ***
MotorTube_OD=BT54Body_OD;
MotorTube_ID=BT54Body_ID;

MotorTubeHole_d=MotorTube_OD+IDXtra*3;
TailConeLen=40;
Tail_OD=MotorTube_OD+6;
TC_Thread_d=MotorTube_OD+7;

EBay_Len=146; // extra short, was 152

NC_Len=120;
NC_Tip_r=12;
NC_Base=15;
NC_Lock_H=5;
NC_Wall_t=1.8;

AftClosure_h=10;
Retainer_h=2;
Nut_Len=Retainer_h+AftClosure_h+10;
	
BoosterDropperCL=550; // for 54/2560 case in sustainer
//BoosterDropperCL=480; // for 54/852 case, minimum for sustainer


UpperTubeLen=190;
BodyTubeLen=BoosterDropperCL-EBay_Len; //-BD_ThrustRing_h();
//MotorTubeLen=BoosterDropperCL+BD_ThrustRing_h()+TailConeLen-Nut_Len+10+3; // to top of ebay
MotorTubeLen=BoosterDropperCL-EBay_Len+BD_ThrustRing_h()+TailConeLen-Nut_Len+10+3; // to bottom of ebay

echo(UpperTubeLen=UpperTubeLen);
echo(BodyTubeLen=BodyTubeLen);
echo(MotorTubeLen=MotorTubeLen);

Alt_DoorXtra_X=6;
Alt_DoorXtra_Y=4;

Bolt4Inset=4;
PetalWidth=Coupler_OD/5;


module ShowRocketStrapOn(ShowInternals=true){
	FinCan_Z=35;
	MotorTube_Z=7;
	
	BodyTube_Z=FinCan_Z+19+Overlap*2;
	EBay_Z=BodyTube_Z+BodyTubeLen;
	UpperTube_Z=EBay_Z+EBay_Len+Overlap;
	R75SRB_TopRetainer_Z=EBay_Z+EBay_Len;
	SpringEnd_Z=R75SRB_TopRetainer_Z+20;
	
	NoseCone_Z=UpperTube_Z+UpperTubeLen+Overlap*2;
	
	//*
	translate([0,0,NoseCone_Z]){
		BluntOgiveNoseCone(ID=Coupler_OD, OD=Body_OD, L=NC_Len, Base_L=NC_Base, 
							Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=0, LowerPortion=false);
	
		if (ShowInternals) {
			rotate([180,0,0]) PetalHub();
			translate([0,0,-8]) rotate([180,0,0]) Petals(Len=110, nPetals=4);
			}
	}
	/**/
	
	//*
	if (ShowInternals) translate([0,0,SpringEnd_Z]) 
		SpringEndTop(OD=Coupler_OD, Tube_ID=Coupler_OD-2.4, nRopeHoles=3);
	/**/
	
	if (ShowInternals==false) translate([0,0,UpperTube_Z]) 
		color("LightBlue") Tube(OD=Body_OD, ID=Body_ID, Len=UpperTubeLen, myfn=$preview? 90:360);
		
	//*
	if (ShowInternals) translate([0,0,R75SRB_TopRetainer_Z]) R75SRB_TopRetainer();
	/**/
	
	translate([0,0,EBay_Z]) Electronics_Bay(ShowDoors=!ShowInternals);
	
	
	translate([0,0,FinCan_Z]) TailCone(Threaded=true, Cone_Len=TailConeLen, Interface_OD=Body_ID);
	
	if (ShowInternals==false) translate([0,0,BodyTube_Z]) 
		color("LightBlue") Tube(OD=Body_OD, ID=Body_ID, Len=BodyTubeLen, myfn=$preview? 90:360);
	
	/*
	// Motor tube
	translate([0,0,MotorTube_Z]) 
		color("LightBlue") 
			Tube(OD=MotorTube_OD, ID=MotorTube_ID, Len=MotorTubeLen-Overlap*2, myfn=$preview? 90:360);
	/**/
	
	//if (ShowInternals) translate([0,0,MotorTube_Z]) ATRMS_54_427_Motor(HasEyeBolt=true);
	if (ShowInternals) translate([0,0,MotorTube_Z]) ATRMS_54_852_Motor(HasEyeBolt=true);
	
	/*
	translate([(BT75Body_OD+BT137Body_OD)/2,0,MotorTube_Z]) 
		ATRMS_54_1706_Motor(Extended=true, HasEyeBolt=true); // K185W
		//ATRMS_54_2560_Motor(Extended=true, HasEyeBolt=true); // K275W
	/**/
	
	translate([0,0,FinCan_Z-0.2]) MotorRetainer();
	
	translate([Body_OD/2+13,0,FinCan_Z+BD_ThrustRing_h()/2]){
		rotate([0,-90,0]) BoosterButton(XtraLen=0.3);
		translate([0,0,BoosterDropperCL]) rotate([0,-90,0]) BoosterButton(XtraLen=0.3);
		}
} // ShowRocketStrapOn

//ShowRocketStrapOn();


module Petals(Len=25, nPetals=3){
	Bolt1_Z=11.75;
	Thickness=3;
	BaseOffset=11.2;
	
	difference(){
		union(){
			translate([0,0,BaseOffset]) 
				Tube(OD=Coupler_OD-IDXtra*2, ID=Coupler_OD-IDXtra*2-4.4, Len=Len, myfn=$preview? 90:360);
			
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

//rotate([180,0,0]) Petals(Len=110, nPetals=4);

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

module PetalHub(HasNCSkirt=true, nPetals=4){
	Width=PetalWidth+1;
	Thickness=3;

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
				
			if (HasNCSkirt) translate([0,0,-NC_Base]) // Fit to nosecone
				Tube(OD=Coupler_OD-IDXtra*2, ID=Coupler_OD-IDXtra*2-4.4, Len=NC_Base+Overlap, myfn=$preview? 36:360);
				
			//if (HasNCSkirt) translate([0,0,-0.5]) 
			//	cylinder(d1=Coupler_OD-IDXtra*2, d2=Coupler_OD-IDXtra*2, h=0.5, $fn=$preview? 36:360);
		} // union
		
		if (HasNCSkirt){
			translate([0,0,-NC_Base/2]) RivetPattern(BT_Dia=Body_ID, nRivets=3, Dia=5/32*25.4);
		}else{
			// Bolt to BallRetainerBottom
			for (j=[0:nPetals-1]) rotate([0,0,360/nPetals*(j+0.35)]) 
				translate([0,Body_OD/2-5,5]) Bolt4HeadHole(lHead=20);
		} // if
		
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
		translate([0,0,-Overlap]) rotate([0,0,180/nPetals]) hull(){
			translate([0,-Coupler_OD/2+6,0]) cylinder(d=4, h=15);
			translate([0,-Coupler_OD/2+16.5,0]) cylinder(d=4, h=15);
		}
		
		
	} // difference
	
} // PetalHub

// PetalHub();

module SpringEndTop(OD=Coupler_OD, Tube_ID=Coupler_OD-2.4, nRopeHoles=3){
	ST_DSpring_OD=44.30;
	Piston_h=15;
	Len=30;
	Plate_t=3;
	
	module SCH(){
		hull(){
			translate([-6,0,-Overlap]) cylinder(d=3, h=Len);
			translate([6,0,-Overlap]) cylinder(d=3, h=Len);
		} // hull
	} // SCH
	
	difference(){
		union(){
			Tube(OD=OD, ID=Tube_ID, Len=Len, myfn=$preview? 36:360);
			
			translate([0,0,Len-Piston_h]) cylinder(d=OD-1, h=Piston_h);
		} // union
		
		// Rope Holes
		nRopes=5;
		Rope_d=4;
		for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*(j+0.5)]) translate([0,OD/2-Rope_d/2-2,0])
			cylinder(d=Rope_d, h=Len);
		
		// Top dish
		translate([0,0,Len-Piston_h+3+Plate_t]) 
			cylinder(d1=Tube_ID-20, d2=Tube_ID, h=Piston_h-3-Plate_t+Overlap);
	
		// Spring
		cylinder(d=ST_DSpring_OD, h=Len-Piston_h+3);
		
		// Bolt hole to LockingPin();
		translate([0,0,-Overlap]) cylinder(d=6.5, h=Len);
		
		rotate([0,0,10]) translate([0,Coupler_OD/2-7,0]) SCH();
		
		// Air Vents
		nVents=8;
		Vent_d=9;
		for (j=[0:nVents-1]) rotate([0,0,360/nVents*j]) translate([0,ST_DSpring_OD/2-Vent_d/2-2,0])
			cylinder(d=Vent_d, h=Len);
	} // difference
	

} // SpringEndTop

// SpringEndTop();

module R75SRB_LockingPin(){
	LockPin_Len=50;
	
	LockingPin(LockPin_Len=LockPin_Len);
	
} // R75SRB_LockingPin

// R75SRB_LockingPin();
// translate([0,0,24]) SpringEndTop();

module R75SRB_TopRetainer(){
	// Custom version of TopRetainer (part of CableReleaseBB)
	Plate_t=7;
	ST_DSpring_OD=44.30;
	ST_DSpring_ID=40.50;
	Len=30;
	OD=Coupler_OD;
	
	module SCH(){
		hull(){
			translate([-6,0,-Overlap]) cylinder(d=3, h=Plate_t+Overlap*2);
			translate([6,0,-Overlap]) cylinder(d=3, h=Plate_t+Overlap*2);
		} // hull
	} // SCH
	
	difference(){
		
		TopRetainer(LockRing_d=OD);
			
		//Bolt holes
		translate([0,0,15]) MountingBoltPattern(nTopBolts=5, LockRing_d=Coupler_OD) Bolt4HeadHole();
		
		// Spring
			translate([0,0,13]) 
				Tube(OD=ST_DSpring_OD+IDXtra, ID=ST_DSpring_ID-1, Len=3, myfn=$preview? 36:360);
			
		// Rope Holes
		nRopes=5;
		Rope_d=3.5;
		for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*(j+0.5)]) translate([0,OD/2-Rope_d/2-2,8]){
			cylinder(d=Rope_d, h=7);
			cylinder(d1=Rope_d*1.7, d2=Rope_d, h=4);
		}
			
		// Shock cord hole
		rotate([0,0,10]) translate([0,OD/2-7,8]) SCH();
	} // difference
} // R75SRB_TopRetainer

// R75SRB_TopRetainer();
 // MountingBoltPattern(nTopBolts=nBalls, OD_Xtra=0) Bolt4Hole();

module Electronics_Bay(Tube_OD=Body_OD, Tube_ID=Body_ID, ShowDoors=false){
	// made NC coupler IDXtra smaller 6/22/23

	Len=EBay_Len;
	Altimeter_Z=62;
	BattSwDoor_Z=56;
	TopSkirt_Len=20;
	BottomSkirt_Len=15;

	Alt_a=180;
	Batt1_a=0;
	Flange_a=90;
	
	module SCH(){
		hull(){
			translate([-6,0,-Overlap]) cylinder(d=3, h=Len+Overlap*2);
			translate([6,0,-Overlap]) cylinder(d=3, h=Len+Overlap*2);
		} // hull
	} // SCH
	
	// Lower centering ring
	translate([0,0,-BottomSkirt_Len])
	CenteringRing(OD=Coupler_OD-1, ID=MotorTubeHole_d, Thickness=BottomSkirt_Len+3, nHoles=0, Offset=0);
	
	translate([0,0,Len-BD_ThrustRing_h()]) {
		BoosterMount();
		//rotate([0,0,90]) BoosterThrustRing(MtrTube_OD=MotorTube_OD, BodyTube_OD=Tube_OD);
		
		translate([0,0,-10+Overlap]) difference(){
			cylinder(d=Tube_OD-1, h=10);
			translate([0,0,-Overlap]) cylinder(d1=Tube_ID, d2=MotorTubeHole_d, h=10+Overlap*2);
		} // difference
	}
	
	difference(){
		union(){
			// Body
			Tube(OD=Tube_OD, ID=Tube_ID, Len=Len-BD_ThrustRing_h()+Overlap, myfn=$preview? 90:360);
			
			// Top integrated coupler
			translate([0,0,Len-Overlap])
				Tube(OD=Tube_ID-IDXtra, ID=Coupler_OD-4.4, Len=TopSkirt_Len+Overlap*2, myfn=$preview? 90:360);
				
				
			// Cable release mounting flange
			translate([0,0,Len+TopSkirt_Len-10]) difference(){
				Tube(OD=Coupler_OD, ID=Coupler_OD-16, Len=10, myfn=$preview? 90:360);
				translate([0,0,-Overlap]) cylinder(d1=Coupler_OD-4.4, d2=Coupler_OD-16, h=5);
			}
				
			translate([0,0,-BottomSkirt_Len])
				Tube(OD=Tube_ID-IDXtra, ID=Coupler_OD-4.4, Len=BottomSkirt_Len+3, myfn=$preview? 90:360);
		} // union
		
		// Shock cord hole
		rotate([0,0,Flange_a+10]) translate([0,Coupler_OD/2-7,Len+TopSkirt_Len-10]) SCH();
		
		// Altimeter
		translate([0,0,Altimeter_Z]) rotate([0,0,Alt_a]) 
			Alt_BayFrameHole(Tube_OD=Tube_OD, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y);
		
		// Battery and Switch door holes
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
			Batt_BayFrameHole(Tube_OD=Tube_OD, HasSwitch=true);
		
		rotate([0,0,Flange_a]) translate([0,0,Len+TopSkirt_Len]) 
			MountingBoltPattern(nTopBolts=5, LockRing_d=Coupler_OD) Bolt4Hole();
	} // difference
	
	// Altimeter
	translate([0,0,Altimeter_Z]) rotate([0,0,Alt_a])
		Alt_BayDoorFrame(Tube_OD=Tube_OD, Tube_ID=Tube_ID, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowDoor=ShowDoors);
	
	// Battery and Switch door2
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
		Batt_BayDoorFrame(Tube_OD=Tube_OD, HasSwitch=true, ShowDoor=ShowDoors);
	
} // Electronics_Bay

// Electronics_Bay();

module BoosterMount(){
	difference(){
		rotate([0,0,90]) BoosterThrustRing(MtrTube_OD=MotorTube_OD, BodyTube_OD=Body_OD);
		
		// Embed nuts
		translate([MotorTube_OD/2+4.5,0,BD_ThrustRing_h()/2]) rotate([0,-90,0]) Bolt250NutHole(depth=7);
		translate([Body_OD/2-4,0,BD_ThrustRing_h()/2]) rotate([0,90,0]) Bolt250NutHole(depth=5);
		
	} // difference
} // BoosterMount

// BoosterMount();

module TailCone(Threaded=true, Cone_Len=TailConeLen, Interface_OD=Body_ID){
	
	difference(){
		union(){
			translate([0,0,18])
				Tube(OD=Body_ID-IDXtra, ID=Coupler_OD-4.4, Len=20, myfn=$preview? 90:360);
				
			BoosterMount();
			//rotate([0,0,90]) BoosterThrustRing(MtrTube_OD=MotorTube_OD, BodyTube_OD=Body_OD);
			
			hull(){
				translate([0,0,-Cone_Len]) cylinder(d=Tail_OD, h=2, $fn=$preview? 90:360);
				
				difference(){
					rotate_extrude($fn=$preview? 90:360) translate([Body_OD/2-8,0,0]) circle(d=16);
					translate([0,0,Overlap]) cylinder(d=Body_OD+1,h=10);
				}
			} // hull
			
		} // union
		
		// Embed nuts
		//translate([MotorTube_OD/2+4.5,0,BD_ThrustRing_h()/2]) rotate([0,-90,0]) #Bolt250NutHole(depth=7);
		//translate([Body_OD/2-4,0,BD_ThrustRing_h()/2]) rotate([0,90,0]) #Bolt250NutHole(depth=5);
		
		// Motor tube
		translate([0,0,-Cone_Len-Overlap]) 
			cylinder(d=MotorTubeHole_d, h=Cone_Len+Overlap*3);
	
		if (Threaded) translate([0,0,-Cone_Len-Overlap]) cylinder(d=Body_OD, h=Nut_Len);
		
		if ($preview) translate([0,0,-Cone_Len-1]) cube([100,100,100]);
	} // difference
	
	if (Threaded) difference(){
		translate([0,0,-Cone_Len+Nut_Len-10]) 
			ExternalThread(Pitch=2.5, Dia_Nominal=TC_Thread_d, 
							Length=10+Overlap, Step_a=$preview? 10:2, TrimEnd=true, TrimRoot=false);
			
		// Motor tube
		translate([0,0,-Cone_Len-Overlap]) 
			cylinder(d=MotorTubeHole_d, h=Cone_Len+Overlap*2);
	}
} // TailCone

//rotate([180,0,0]) TailCone();

module MotorRetainer(HasWrenchCuts=false, Cone_Len=TailConeLen, ExtraLen=0){
	
	difference(){
		hull(){
			difference(){
				hull(){
					// Bottom
					translate([0,0,-Cone_Len]) cylinder(d=Tail_OD, h=2, $fn=$preview? 90:360);
						
					// Top
					rotate_extrude($fn=$preview? 90:360) translate([Body_OD/2-8,0,0]) circle(d=16);
				} // hull
				
				// Trim Top	
				translate([0,0,-Cone_Len+Nut_Len-Overlap]) cylinder(d=Body_OD+1, h=Cone_Len);
			} // difference
		
			translate([0,0,-Cone_Len-ExtraLen]) 
				cylinder(d=Tail_OD, h=2, $fn=$preview? 90:360);
		} // hull
			
		// Exit
		translate([0,0,-Cone_Len-ExtraLen-Overlap]) 
			cylinder(d=MotorTube_ID+IDXtra*2, h=Cone_Len);
			
		// Motor tube
		translate([0,0,-Cone_Len-ExtraLen+Retainer_h]) 
			cylinder(d=ATRMS_54_Aft_d()+IDXtra*3, h=Cone_Len);
	
		translate([0,0,-Cone_Len+Nut_Len-12+Overlap])
			ExternalThread(Pitch=2.5, Dia_Nominal=TC_Thread_d+IDXtra*4, 
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






































