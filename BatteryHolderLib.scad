// ***********************************
// Project: 3D Printed Rocket
// Filename: BatteryHolderLib.scad
// by David M. Flynn
// Created: 9/30/2022 
// Revision: 1.2.5  8/16/2024
// Units: mm
// ***********************************
//  ***** Notes *****
//
// A collection of battery holders. 
//
//  ***** History *****
//
function BatteryHolderLibRev()="BatteryHolderLib 1.2.5";
echo(BatteryHolderLibRev());
//
// 1.2.5  8/16/2024	  Added BlueRavenMount();
// 1.2.4  8/11/2024   Added RocketServoHolder()
// 1.2.3  1/3/2024    Added function BattDoorX()
// 1.2.2  12/6/2023   Added DoubleBatteryPocket, Batt_Door(DoubleBatt=false)
// 1.2.1  9/16/2023   Added DeepHole_t to Batt_BayFrameHole()
// 1.2.0  4/29/2023   Now using DoorLib.scad.
// 1.1.0  1/2/2023    Added Batt_Door6xAAA()
// 1.0.2  12/11/2022  Added LED hole. Thinned door by 0.7mm w/o changing frame or hole. 
// 1.0.1  11/28/2022  Standardized door thickness. 
// 1.0.0  11/22/2022  Code cleanup. 
// 0.9.3  11/21/2022  Fixed door bolt angle
// 0.9.2  10/18/2022  Added HasSwitch option to battery door.  
// 0.9.1  10/17/2022  Added Batt_Door and other parts. 
// 0.9.0  9/30/2022   First code. Moved stuff to this file. 
//
// ***********************************
//  ***** for STL output *****
//
//  Batt_Door(Tube_OD=PML98Body_OD, Door_X=BattDoorX(), InnerTube_OD=PML54Body_OD, HasSwitch=false, DoubleBatt=false, BlankDoor=false);
//  Batt_Door6xAAA(Tube_OD=BT137Body_OD, InnerTube_OD=BT54Body_OD, HasSwitch=true);
//  SingleBatteryPocket(ShowBattery=true);
//
//  rotate([180,0,0]) TubeEndStackedDoubleBatteryHolder(TubeOD=PML38Body_OD, TubeID=PML38Body_ID); // Fits 38mm motor tube
//  rotate([180,0,0]) TubeEndDoubleBatteryHolder(TubeID=PML54Body_ID, TubeOD=PML54Body_OD); // Fits 54mm motor tube
//
//  SingleBatteryHolder(Tube_ID=PML75Body_ID);
//  DoubleBatteryHolder(Tube_ID=PML75Body_ID);
//
// RocketServoHolderRevC(IsDouble=false);
// RocketServoHolderRevC(IsDouble=true);
//
// BlueRavenMount();
// FW_MagSw_Mount(HasMountingEars=false);
//
// ***********************************
//  ***** Routines *****
//
//	BattDoorHole(Tube_OD=PML98Body_OD, HasSwitch=false);
//  Batt_DoorBoltPattern(Tube_OD=PML98Body_OD, HasSwitch=false);
//  Batt_BayFrameHole(Tube_OD=PML98Body_OD, Door_X=BattDoorX(), HasSwitch=false, DeepHole_t=0);
//  Batt_BayDoorFrame(Tube_OD=PML98Body_OD, Door_X=BattDoorX(),  HasSwitch=false, ShowDoor=false);
//
//  SingleBatteryHolder(Tube_ID=PML75Body_ID);
//  DoubleBatteryHolder(Tube_ID=PML75Body_ID);
//
//  SingleBatteryPocket(ShowBattery=true);
//  DoubleBatteryPocket(ShowBattery=true);
//
//  FW_MagSw_BoltPattern() Bolt4Hole();
//
// ***********************************
//  ***** for Viewing *****
//
// 
// ***********************************

include<TubesLib.scad>
use<DoorLib.scad>
include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2; 
$fn=$preview? 24:90;

Bolt4Inset=4;
Batt_Door_Y=74;
Batt_Door_X=27+Bolt4Inset*4+10; //53

function BattDoorX()=Batt_Door_X;
Batt_DoorThickness=3.7;

// CK Rotary Switch
CK_RotSw_d=23.5;
CK_RotSw_Face_d=18;
CK_RotSw_Face_h=0.6;
CK_RotSw_Access_d=8;
CK_RotSw_AO_h=15;

module BlueRavenBoltPattern(){

	// copied from BlueRavenMount
	Edge=2;
	Base_T=2;
	PCB_X=1.77*25.4;
	PCB_Y=0.79*25.4;
	PCB_T=1.5;
	PCB_Back_Z=2.5;
	PCB_R=0.1*25.4;
	H1_X=1.63*25.4;
	H1_Y=0.65*25.4;
	H2_X=0.48*25.4;
	H2_Y=0.15*25.4;

		translate([PCB_X/2-H2_X, PCB_Y/2-H2_Y, Base_T+PCB_Back_Z]) children();
		translate([PCB_X/2-H1_X, PCB_Y/2-H1_Y, Base_T+PCB_Back_Z]) children();

} // BlueRavenBoltPattern

module BlueRavenMount(){
	Edge=2;
	Base_T=2;
	PCB_X=1.77*25.4;
	PCB_Y=0.79*25.4;
	PCB_T=1.5;
	PCB_Back_Z=2.5;
	PCB_R=0.1*25.4;
	H1_X=1.63*25.4;
	H1_Y=0.65*25.4;
	H2_X=0.48*25.4;
	H2_Y=0.15*25.4;
	
	difference(){
		union(){
			difference(){
				RoundRect(X=PCB_X+Edge*2, Y=PCB_Y+Edge*2, Z=Base_T+PCB_T+PCB_Back_Z, R=PCB_R+Edge);
				translate([0,0,Base_T]) RoundRect(X=PCB_X+IDXtra*2, Y=PCB_Y+IDXtra*2, Z=PCB_T+PCB_Back_Z+Overlap, R=PCB_R);
			} // difference
			
			translate([PCB_X/2-H2_X, PCB_Y/2-H2_Y, 0]) cylinder(d=6, h=Base_T+PCB_Back_Z);
			translate([PCB_X/2-H1_X, PCB_Y/2-H1_Y, 0]) cylinder(d=6, h=Base_T+PCB_Back_Z);
		} // union
		
		BlueRavenBoltPattern() Bolt4Hole();
		
		// USB 
		translate([-PCB_X/2+7.5,-(PCB_Y+Edge*2)/2-1,Base_T+PCB_T+PCB_Back_Z-1]) cube([10,10,3]);
	
	} // difference
	
} // BlueRavenMount

//BlueRavenMount();

FW_MagSw_BoltSpace_X=6.5;
FW_MagSw_BoltSpace_Y=11;
FW_MagSw_PCB_X=13.75;
FW_MagSw_PCB_Y=18.4;
FW_MagSw_PCB_Z=1.6;

module FW_MagSw_BoltPattern(){
	translate([FW_MagSw_BoltSpace_X/2, -FW_MagSw_BoltSpace_Y/2, 0]) children();
	translate([-FW_MagSw_BoltSpace_X/2, -FW_MagSw_BoltSpace_Y/2, 0]) children();
	translate([-FW_MagSw_BoltSpace_X/2, FW_MagSw_BoltSpace_Y/2, 0]) children();
} // FW_MagSw_BoltPattern

// FW_MagSw_BoltPattern() Bolt4Hole();

module FW_MagSw_Mount(HasMountingEars=false){
	Wall_t=1.6;
	OAH=4;
	Base_t=OAH-FW_MagSw_PCB_Z; // for #4-40x 3/16" screws
	
	module BoltBoss(){
		cylinder(d=6, h=Base_t);
	} // BoltBoss
	
	difference(){
		union(){
			difference(){
				RoundRect(X=FW_MagSw_PCB_X+Wall_t*2, Y=FW_MagSw_PCB_Y+Wall_t*2, Z=OAH, R=Wall_t);
				translate([0,0,Wall_t]) RoundRect(X=FW_MagSw_PCB_X+IDXtra, Y=FW_MagSw_PCB_Y+IDXtra, Z=OAH, R=0.1);
			} // difference
			FW_MagSw_BoltPattern() BoltBoss();
			
			if (HasMountingEars) hull(){
				translate([(FW_MagSw_PCB_X+Wall_t*2)/2+Bolt4Inset,0,0]) cylinder(d=8, h=Wall_t);
				translate([-(FW_MagSw_PCB_X+Wall_t*2)/2-Bolt4Inset,0,0]) cylinder(d=8, h=Wall_t);
			} // hull
		} // union
	
		translate([0,0,OAH]) FW_MagSw_BoltPattern() Bolt4Hole();
		
		if (HasMountingEars) {
				translate([(FW_MagSw_PCB_X+Wall_t*2)/2+Bolt4Inset,0,Wall_t]) Bolt4ClearHole();
				translate([-(FW_MagSw_PCB_X+Wall_t*2)/2-Bolt4Inset,0,Wall_t]) Bolt4ClearHole();
			} // if
	} // difference
} // FW_MagSw_Mount

// FW_MagSw_Mount(HasMountingEars=false);

module MiniBoosterEBay(OD=BT54Body_OD, Coupler_OD=BT54Body_ID, ID=BT54Coupler_ID){
	Base_t=3;
	Exposed_Len=35;
	LowerCoupler_Len=13.5;
	Coupler_Len=20;
	OAL=LowerCoupler_Len+Coupler_Len+Exposed_Len;
	Switch_Z=LowerCoupler_Len+Exposed_Len/2-5;
	
	Door_t=4.5;
	Batt_a=-130;
	
	difference(){
		union(){
			// Bottom plate
			cylinder(d=Coupler_OD, h=Base_t);
			
			// coupler
			Tube(OD=Coupler_OD, ID=ID, Len=OAL, myfn=$preview? 36:360);
			
			// visible middle part
			translate([0,0,LowerCoupler_Len])
				Tube(OD=OD, ID=ID, Len=Exposed_Len, myfn=$preview? 36:360);
				
			// Switch
			intersection(){
				translate([0, -OD/2+CK_RotSw_AO_h/2, Switch_Z])
							rotate([90,0,0]) cylinder(d=CK_RotSw_d+4, h=CK_RotSw_AO_h);
				cylinder(d=Coupler_OD-1, h=OAL);
			} // intersection
			
			// Battery
			intersection(){
				rotate([0,0,Batt_a]) translate([0,-13.6,2]) SingleBatteryPocket(Extra=0, ShowBattery=false);
				
				cylinder(d=Coupler_OD-1, h=OAL);
			} // intersection
		} // union
		
		// Battery
		rotate([0,0,Batt_a]) translate([0,-13.6,-Overlap]) cylinder(d=12, h=4);
		
		// motor bolt
		translate([0,0,6]) BoltM8ButtonHeadHole(depth=12, lHead=20);
		//cylinder(d=6.35, h=Base_t+Overlap*2);
		
		// Switch
		translate([0, -OD/2+CK_RotSw_AO_h/2+Overlap, Switch_Z]) rotate([90,0,0]){
				cylinder(d=CK_RotSw_d+IDXtra*2, h=CK_RotSw_AO_h/2-Door_t);
				cylinder(d=CK_RotSw_Face_d+IDXtra*2, h=CK_RotSw_AO_h/2+CK_RotSw_Face_h-Door_t);
				cylinder(d=CK_RotSw_Access_d+IDXtra, h=CK_RotSw_AO_h/2+Overlap*2);
				
				// LED
				translate([CK_RotSw_d/2+5,2,-4]) cylinder(d=3, h=10);
				translate([CK_RotSw_d/2+5,2,-4]) cylinder(d=5, h=3);
			}
			
		if ($preview) translate([0,0,-Overlap]) cube([30,30,100]);
	} // difference
	
	//if ($preview) rotate([0,0,-20]) translate([0,16.5,36]) rotate([-90,0,0]) RocketServoHolder(IsDouble=false);
	
} // MiniBoosterEBay

//MiniBoosterEBay();

module RocketServoRevCBoltPattern(){
	// copied from RocketServoHolderRevC
	PCB_X=14.8;
	PCB_Y=60.5;
	PCB_Z=1.65;
	PCB_BackSpace_Z=2.2;
	Sup1_Y=7;
	Sup1a_Y=23;
	Sup2_Y=46.5;
	Sup_w=3;
	
	Screw2_Y=11.5;
	Screw1_Y=52.0;
	Screw_Offset=1.8;
	
	Foot_Xtra=5;
	Base_t=2.1;
	
	OAH=Base_t+PCB_BackSpace_Z+PCB_Z;
	Spacing_X=PCB_X+Foot_Xtra-1;
	
	translate([-PCB_X/2-Screw_Offset, -PCB_Y/2+Screw1_Y, OAH]) children();
	translate([PCB_X/2+Screw_Offset, -PCB_Y/2+Screw2_Y, OAH]) children();

	
} // RocketServoRevCBoltPattern

module RocketServoHolderRevC(IsDouble=false){
	PCB_X=14.8;
	PCB_Y=60.5;
	PCB_Z=1.65;
	PCB_BackSpace_Z=2.2;
	Sup1_Y=7;
	Sup1a_Y=23;
	Sup2_Y=46.5;
	Sup2a_Y=49.5;
	Sup_w=3;
	
	Screw2_Y=11.5;
	Screw1_Y=52.0;
	Screw_Offset=1.8;
	
	Foot_Xtra=5;
	Base_t=2.1;
	
	OAH=Base_t+PCB_BackSpace_Z+PCB_Z;
	nRS=IsDouble? 2:1;
	Spacing_X=PCB_X+Foot_Xtra-1;
	
	module PCB_Sups(){
		for (j=[0:nRS-1]) translate([(Spacing_X)*j,0,0]){
		// PCB support
		translate([-PCB_X/2-1, -PCB_Y/2+Sup1_Y, Base_t-Overlap]) hull(){
			cylinder(d=Sup_w, h=PCB_BackSpace_Z);
			translate([3,0,0]) cylinder(d=Sup_w, h=PCB_BackSpace_Z);
		}
		translate([PCB_X/2+1, -PCB_Y/2+Sup1a_Y, Base_t-Overlap]) hull(){
			cylinder(d=Sup_w, h=PCB_BackSpace_Z);
			translate([-3,0,0]) cylinder(d=Sup_w, h=PCB_BackSpace_Z);
		}
		
		translate([-PCB_X/2-1, -PCB_Y/2+Sup2a_Y, Base_t-Overlap]) hull(){
			cylinder(d=Sup_w, h=PCB_BackSpace_Z);
			translate([3,0,0]) cylinder(d=Sup_w, h=PCB_BackSpace_Z);
		}
		translate([PCB_X/2+1, -PCB_Y/2+Sup2_Y, Base_t-Overlap]) hull(){
			cylinder(d=Sup_w, h=PCB_BackSpace_Z);
			translate([-3,0,0]) cylinder(d=Sup_w, h=PCB_BackSpace_Z);
		}
	} // for
	
	} // PCB_Sups
	
	difference(){
		union(){
			for (j=[0:nRS-1]) translate([(Spacing_X)*j,0,0]){
				// base
				difference(){
					RoundRect(X=PCB_X+Foot_Xtra, Y=PCB_Y+Foot_Xtra, Z=OAH, R=Foot_Xtra/3);
					translate([0,0,Base_t]) RoundRect(X=PCB_X+IDXtra*2, Y=PCB_Y+IDXtra*2, Z=PCB_BackSpace_Z+PCB_Z+Overlap, R=0.1);
				}
				
				// screw bosses
				translate([-PCB_X/2-Screw_Offset, -PCB_Y/2+Screw1_Y, 0]) cylinder(d=6, h=OAH);
				translate([PCB_X/2+Screw_Offset, -PCB_Y/2+Screw2_Y, 0]) cylinder(d=6, h=OAH);
			} // for
			
			PCB_Sups();
			
		} // union
		
		
		for (j=[0:nRS-1]) translate([(Spacing_X)*j,0,0]){
			translate([0,0,Base_t+PCB_BackSpace_Z]) RoundRect(X=PCB_X+IDXtra*2, Y=PCB_Y+IDXtra*2, Z=PCB_BackSpace_Z+PCB_Z+Overlap, R=0.1);
			
			// bolt holes
			RocketServoRevCBoltPattern() Bolt4Hole();
			
			translate([0, -PCB_Y/2+3.5, Base_t+0.6]) Bolt4ButtonHeadHole();
			translate([0, PCB_Y/2-7, Base_t+0.6]) Bolt4ButtonHeadHole();
		
		} // for
	} // difference
	

} // RocketServoHolderRevC

// RocketServoHolderRevC();
// RocketServoHolderRevC(IsDouble=true);

module RocketServoHolder(IsDouble=false){
	PCB_X=14.8;
	PCB_Y=60.5;
	PCB_Z=1.65;
	PCB_BackSpace_Z=2.2;
	Sup1_Y=7;
	Sup2_Y=47.5;
	Sup_w=3;
	
	Screw1_Y=17.5;
	Screw2_Y=52.5;
	Screw_Offset=1.8;
	
	Foot_Xtra=5;
	Base_t=2.1;
	
	OAH=Base_t+PCB_BackSpace_Z+PCB_Z;
	nRS=IsDouble? 2:1;
	Spacing_X=PCB_X+Foot_Xtra-1;
	
	difference(){
		union(){
			for (j=[0:nRS-1]) translate([(Spacing_X)*j,0,0]){
				// base
				RoundRect(X=PCB_X+Foot_Xtra, Y=PCB_Y+Foot_Xtra, Z=OAH, R=Foot_Xtra/3);
				
				// screw bosses
				translate([-PCB_X/2-Screw_Offset, -PCB_Y/2+Screw1_Y, 0]) cylinder(d=6, h=OAH);
				translate([PCB_X/2+Screw_Offset, -PCB_Y/2+Screw2_Y, 0]) cylinder(d=6, h=OAH);
			} // for
		} // union
		
		for (j=[0:nRS-1]) translate([(Spacing_X)*j,0,0]){
			translate([0,0,Base_t]) RoundRect(X=PCB_X+IDXtra*2, Y=PCB_Y+IDXtra*2, Z=PCB_BackSpace_Z+PCB_Z+Overlap, R=0.1);
			
			// bolt holes
			translate([-PCB_X/2-Screw_Offset, -PCB_Y/2+Screw1_Y, OAH]) Bolt4Hole();
			translate([PCB_X/2+Screw_Offset, -PCB_Y/2+Screw2_Y, OAH]) Bolt4Hole();
			
			translate([0, -PCB_Y/2+3.5, Base_t+0.6]) Bolt4ButtonHeadHole();
			translate([0, PCB_Y/2-7, Base_t+0.6]) Bolt4ButtonHeadHole();
		} // for
	} // difference
	
	for (j=[0:nRS-1]) translate([(Spacing_X)*j,0,0]){
		// PCB support
		translate([-PCB_X/2-1, -PCB_Y/2+Sup1_Y, Base_t-Overlap]) cube([PCB_X+2, Sup_w, PCB_BackSpace_Z]);
		translate([-PCB_X/2-1, -PCB_Y/2+Sup2_Y, Base_t-Overlap]) cube([PCB_X+2, Sup_w, PCB_BackSpace_Z]);
	} // for
} // RocketServoHolder

// RocketServoHolder();
// RocketServoHolder(IsDouble=true);

module BattDoorHole(Tube_OD=PML98Body_OD, Door_X=Batt_Door_X, HasSwitch=false){
	Door_Y=HasSwitch? Batt_Door_Y+CK_RotSw_d+1:Batt_Door_Y+1;
	
	Door_t=Batt_DoorThickness;
	
	DoorHole(Door_X=Door_X, Door_Y=Door_Y, Door_t=Door_t, Tube_OD=Tube_OD);
	
} // BattDoorHole

//rotate([90,0,0]) BattDoorHole(Tube_OD=PML98Body_OD);

module Batt_DoorBoltPattern(Tube_OD=PML98Body_OD, Door_X=Batt_Door_X, HasSwitch=false){
	Door_Y=HasSwitch? Batt_Door_Y+CK_RotSw_d:Batt_Door_Y;
	
	DoorBoltPattern(Door_X=Door_X, Door_Y=Door_Y, Tube_OD=Tube_OD, HasSixBolts=false) children();
	
} // Batt_DoorBoltPattern

//rotate([90,0,0]) Batt_DoorBoltPattern(Tube_OD=PML98Body_OD) Bolt4Hole();

module Batt_BayFrameHole(Tube_OD=PML98Body_OD, Door_X=Batt_Door_X, Door_Y=Batt_Door_Y, HasSwitch=false, DeepHole_t=0){
	Door_Y=HasSwitch? Door_Y+CK_RotSw_d:Door_Y;
	Door_t=Batt_DoorThickness;
	
	DoorFrameHole(Door_X=Door_X, Door_Y=Door_Y, Door_t=Door_t, Tube_OD=Tube_OD);
	
	if (DeepHole_t>0)
	DoorFrameHole(Door_X=Door_X-6, Door_Y=Door_Y-10, Door_t=DeepHole_t, Tube_OD=Tube_OD);
	
} // Batt_BayFrameHole

//Batt_BayFrameHole();
//Batt_BayFrameHole(Tube_OD=PML54Body_OD, Door_X=43, HasSwitch=true);

module Batt_BayDoorFrame(Tube_OD=PML98Body_OD, Door_X=Batt_Door_X, HasSwitch=false, ShowDoor=false){
						
	Door_Y=HasSwitch? Batt_Door_Y+CK_RotSw_d:Batt_Door_Y;
	Door_t=Batt_DoorThickness;
	
	DoorFrame(Door_X=Door_X, Door_Y=Door_Y, Door_t=Door_t, Tube_OD=Tube_OD, HasSixBolts=false, HasBoltBosses=true);
	
	if (ShowDoor)  
		Batt_Door(Tube_OD=Tube_OD, Door_X=Door_X, InnerTube_OD=0, HasSwitch=HasSwitch);
		
} // Batt_BayDoorFrame

//Batt_BayDoorFrame(Tube_OD=LOC65Body_OD, HasSwitch=false, ShowDoor=false);
//DoorFrame(Door_X=53, Door_Y=87.5, Door_t=3, Tube_OD=LOC65Body_OD, HasSixBolts=false);

//Batt_BayDoorFrame(ShowDoor=true);
//Batt_BayDoorFrame(Tube_OD=PML75Body_OD, Door_X=Batt_Door_X, HasSwitch=true, ShowDoor=false);
//Batt_BayDoorFrame(Tube_OD=PML54Body_OD, Door_X=Batt_Door_X-10, HasSwitch=true, ShowDoor=false);
//rotate([90,0,0]) Batt_Door54(Tube_OD=PML54Body_OD, HasSwitch=true);

module Batt_Door(Tube_OD=PML98Body_OD, Door_X=Batt_Door_X, InnerTube_OD=PML38Body_OD, HasSwitch=false, DoubleBatt=false, BlankDoor=false){

	ShowBattery=true;
	Door_Y=HasSwitch? Batt_Door_Y+CK_RotSw_d:Batt_Door_Y;
	//Door_X=Batt_Door_X;
	Door_t=Batt_DoorThickness-0.7;
	DoorEdge_a=asin((Door_X/2)/(Tube_OD/2));
	BoltBossInset=3;
	Batt_Offset_Y=Door_Y/2-68;
	
	BattInset_Z=get_inset(Tube_OD);
	Batt_h=45;
	BattConn_h=8;
	Batt_X=27;
	Batt_Y=17;
	Switch_Y=-Door_Y/2+CK_RotSw_d/2+6;
	
	function get_inset(d) = lookup(d, [
 		[ 54, 3.6 ],
 		[ 98, 2.2 ],
 		[ 137, 1.4 ]
 	]);
	
	difference(){
		union(){
			Door(Door_X=Door_X, Door_Y=Door_Y, Door_t=Door_t, Tube_OD=Tube_OD, HasSixBolts=false);
			
			if (!BlankDoor)
			intersection(){
				difference(){
					translate([0,0,-Door_Y/2])
						cylinder(d=Tube_OD-1, h=Door_Y);
					translate([0,0,-Door_Y/2-Overlap])
						cylinder(d=InnerTube_OD+IDXtra, h=Door_Y+Overlap*2);
				} // difference
				
				union(){
					//Battery holder
					 translate([0, -Tube_OD/2+Door_t+Batt_Y/2+BattInset_Z, Door_Y/2-Batt_h-BattConn_h-10]) 
						if (DoubleBatt){
							translate([0,(Batt_Y*2-Batt_X),0]) rotate([0,0,90]) 
								DoubleBatteryPocket(Extra=5, ShowBattery=ShowBattery);
						}else{
							SingleBatteryPocket(Extra=5, ShowBattery=ShowBattery);
						}
						
					
					// Switch
					if (HasSwitch)
						translate([0, -Tube_OD/2+CK_RotSw_AO_h/2, Switch_Y])
							rotate([90,0,0]) cylinder(d=CK_RotSw_d+4, h=CK_RotSw_AO_h);
				} // union
			} // intersection
		} // union
		
		// Switch
		if (HasSwitch && !BlankDoor)
			translate([0, -Tube_OD/2+CK_RotSw_AO_h/2+Overlap, Switch_Y]) rotate([90,0,0]){
				cylinder(d=CK_RotSw_d+IDXtra*2, h=CK_RotSw_AO_h/2-Door_t);
				cylinder(d=CK_RotSw_Face_d+IDXtra*2, h=CK_RotSw_AO_h/2+CK_RotSw_Face_h-Door_t);
				cylinder(d=CK_RotSw_Access_d+IDXtra, h=CK_RotSw_AO_h/2+Overlap*2);
			translate([10,CK_RotSw_d/2+2,0]) cylinder(d=3, h=10);
			}
	} // difference

} // Batt_Door

//rotate([90,0,0]) Batt_Door(Tube_OD=BT75Body_OD, InnerTube_OD=0, HasSwitch=true, DoubleBatt=true);
//Batt_Door(Tube_OD=BT137Body_OD, InnerTube_OD=0, HasSwitch=true);
//Batt_Door(Tube_OD=BT54Body_OD, Door_X=40, InnerTube_OD=0, HasSwitch=true); // not good


module Batt_Door6xAAA(Tube_OD=BT137Body_OD, InnerTube_OD=BT54Body_OD, HasSwitch=true){
	Door_Y=HasSwitch? Batt_Door_Y+CK_RotSw_d:Batt_Door_Y;
	Door_X=Batt_Door_X;
	Door_t=Batt_DoorThickness-0.7;
	DoorEdge_a=asin((Door_X/2)/(Tube_OD/2));
	BoltBossInset=3;
	Batt_Offset_Y=Door_Y/2-68;
	
	Batt_h=51;
	BattConn_h=2;
	Batt_X=35.5;
	Batt_Y=23.5;
	Switch_Y=-Door_Y/2+CK_RotSw_d/2+6;
	
	difference(){
		union(){
			Door(Door_X=Door_X, Door_Y=Door_Y, Door_t=Door_t, Tube_OD=Tube_OD, HasSixBolts=false);
			
			intersection(){
				difference(){
					translate([0,0,-Door_Y/2])
						cylinder(d=Tube_OD-1, h=Door_Y);
					translate([0,0,-Door_Y/2-Overlap])
						cylinder(d=InnerTube_OD+IDXtra, h=Door_Y+Overlap*2);
				} // difference
				
				union(){
					//Battery holder
					 translate([0, -Tube_OD/2+Door_t+Batt_Y/2+2.0, Door_Y/2-Batt_h-BattConn_h-10]) 
						 BatteryPocket6xAAA();
					
					// Switch
					if (HasSwitch)
						translate([0, -Tube_OD/2+CK_RotSw_AO_h/2, Switch_Y])
							rotate([90,0,0]) cylinder(d=CK_RotSw_d+4, h=CK_RotSw_AO_h);
				} // union
			} // intersection
		} // union

		// Switch
		if (HasSwitch)
			translate([0, -Tube_OD/2+CK_RotSw_AO_h/2+Overlap, Switch_Y]) rotate([90,0,0]){
				cylinder(d=CK_RotSw_d+IDXtra*2, h=CK_RotSw_AO_h/2-Door_t);
				cylinder(d=CK_RotSw_Face_d+IDXtra*2, h=CK_RotSw_AO_h/2+CK_RotSw_Face_h-Door_t);
				cylinder(d=CK_RotSw_Access_d+IDXtra, h=CK_RotSw_AO_h/2+Overlap*2);
			translate([10,CK_RotSw_d/2+2,0]) cylinder(d=3, h=10);
			}
	} // difference

} // Batt_Door6xAAA

//Batt_Door6xAAA(Tube_OD=BT137Body_OD, InnerTube_OD=BT54Body_OD, HasSwitch=true);

module SingleBatteryPocket(Extra=0, ShowBattery=true){
	Batt_h=45;
	BattConn_h=8;
	Batt_X=27;
	Batt_Y=17;
	Batt_r=3;
	
	module BatteryCase(){
		color("Orange") RoundRect(Y=Batt_Y, X=Batt_X, Z=Batt_h+BattConn_h, R=Batt_r);
	} // BatteryCase
	
	difference(){
		translate([0,-Extra/2,0]) RoundRect(X=Batt_X+5, Y=Batt_Y+5+Extra, Z=Batt_h+2, R=2);
			
				
		// Battery
		translate([0,0,3]) RoundRect(X=Batt_X+IDXtra*4, Y=Batt_Y+IDXtra*4, Z=Batt_h, R=Batt_r);
		
		
		// Trim side, Shockcord path
		//translate([Batt_Y/2+3, -TubeOD/2, -Overlap]) cube([TubeOD/2, TubeOD, OAH+Overlap*2]);
		
		
		// Push holes
		translate([0,0,-Overlap]) cylinder(d=12, h=4);
		
	} // difference
	if ($preview && ShowBattery) translate([0,0,3]) BatteryCase();
	
} // SingleBatteryPocket

//SingleBatteryPocket();

module DoubleBatteryPocket(Extra=0, ShowBattery=true){
	Batt_h=45;
	BattConn_h=8;
	Batt_X=27;
	Batt_Y=17;
	Batt_r=3;
	
	module BatteryCase(){
		color("Orange") RoundRect(Y=Batt_Y, X=Batt_X, Z=Batt_h+BattConn_h, R=Batt_r);
	} // BatteryCase
	
	difference(){
		translate([-Extra/2,0,0]) RoundRect(X=Batt_X+5+Extra, Y=Batt_Y*2+5, Z=Batt_h+2, R=2);
			
				
		// Battery
		translate([0,0,3]) RoundRect(X=Batt_X+IDXtra*4, Y=Batt_Y*2+IDXtra*4, Z=Batt_h, R=Batt_r);
				
		// Push holes
		translate([0,-Batt_Y/2,-Overlap]) cylinder(d=12, h=4);
		translate([0,Batt_Y/2,-Overlap]) cylinder(d=12, h=4);
		
	} // difference
	if ($preview && ShowBattery){
		translate([0,-Batt_Y/2,3]) BatteryCase();
		translate([0,Batt_Y/2,3]) BatteryCase();
		}
	
} // DoubleBatteryPocket

//DoubleBatteryPocket();

module BatteryPocket6xAAA(){
	Batt_h=51;
	BattConn_h=1;
	Batt_X=35.5;
	Batt_Y=23.5;
	Batt_r=3;
	
	module BatteryCase(){
		color("Orange") RoundRect(Y=Batt_Y, X=Batt_X, Z=Batt_h+BattConn_h, R=Batt_r);
	} // BatteryCase
	
	difference(){
		RoundRect(X=Batt_X+5, Y=Batt_Y+5, Z=Batt_h-2, R=2);
			
				
		// Battery
		translate([0,0,3]) RoundRect(X=Batt_X+IDXtra*2, Y=Batt_Y+IDXtra*2, Z=Batt_h, R=Batt_r);
		
		
		// Trim side, Shockcord path
		//translate([Batt_Y/2+3, -TubeOD/2, -Overlap]) cube([TubeOD/2, TubeOD, OAH+Overlap*2]);
		
		
		// Push holes
		translate([0,0,-Overlap]) cylinder(d=12, h=4);
		
	} // difference
	if ($preview) translate([0,0,3]) BatteryCase();
	
} // BatteryPocket6xAAA

module TubeEndStackedDoubleBatteryHolder(TubeOD=PML38Body_OD, TubeID=PML38Body_ID, nBatts=2){
	// Sits in the E-Bay in the top of the motor tube. 
	
	Batt_h=45;
	BattConn_h=8;
	Batt_X=27;
	Batt_Y=17;
	Batt_r=3;
	
	Base_h=Batt_h*nBatts+BattConn_h*(nBatts-1)-1;
	OAH=Base_h+5;
	Offset_Y=-1;
	
	module BatteryCase(){
		color("Orange") RoundRect(Y=Batt_X, X=Batt_Y, Z=Batt_h*nBatts+BattConn_h*(nBatts-1), R=Batt_r);
	} // BatteryCase
	
	difference(){
		union(){
			cylinder(d=TubeID-IDXtra*2, h=Base_h);
			translate([0,0,Base_h-Overlap]) cylinder(d=TubeOD, h=5);
		} // union
		
		//Clamp Bolts
		translate([-Batt_Y/2-4,4+Offset_Y,OAH]) Bolt4Hole();
		translate([-Batt_Y/2-4,-4+Offset_Y,OAH]) Bolt4Hole();
		
		// Batteries
		translate([0,Offset_Y,3]) RoundRect(X=Batt_Y+IDXtra*2, Y=Batt_X+IDXtra*2, Z=OAH, R=Batt_r);
		
		// Wire path
		translate([0,Batt_X/2+Offset_Y,Batt_h-2]) RoundRect(X=7, Y=9, Z=OAH, R=2);
		
		// Trim side, Shockcord path
		translate([Batt_Y/2+3, -TubeOD/2, -Overlap]) cube([TubeOD/2, TubeOD, OAH+Overlap*2]);
		
		
		// Push holes
		translate([0,Offset_Y,-Overlap]) cylinder(d=12, h=4);
		
	} // difference
	//if ($preview) translate([0,0,3]) BatteryCase();
} // TubeEndStackedDoubleBatteryHolder

//TubeEndStackedDoubleBatteryHolder();
//TubeEndStackedDoubleBatteryHolder(TubeOD=PML38Body_OD, TubeID=PML38Body_ID, nBatts=1);

module BoltDown(){
	Width=14;
	
	difference(){
		union(){
			translate([-Width/2,0,0]) cube([Width,8,3]);
			translate([-Width/2,0,0]) cube([Width,3,5]);
			translate([-Width/2,-3,3]) cube([Width,6,3]);
		} // union
		translate([4,4,3+3]) Bolt4HeadHole();
		translate([-4,4,3+3]) Bolt4HeadHole();
	} // difference
} // BoltDown

//BoltDown();

module TubeEndDoubleBatteryHolder(TubeID=PML54Body_ID, TubeOD=PML54Body_OD){
	// Sits in the E-Bay in the top of the motor tube. 
	
	Batt_h=45; // Case only
	Batt_X=27;
	Batt_Y=17;
	Batt_r=3;

	Base_h=Batt_h-5;
	OAH=Base_h+5;
	
	module BatteryCase(){
		color("Orange") RoundRect(X=Batt_X, Y=Batt_Y, Z=Batt_h, R=Batt_r);
	} // BatteryCase
	
	module BClip(){
		translate([-6,0,-Overlap]) cube([12,3,5]);
		translate([-6,-3,3]) cube([12,6,3]);
	} // BClip
	
	difference(){
		union(){
			cylinder(d=TubeID-IDXtra*2, h=Base_h);
			translate([0,0,Base_h-Overlap]) cylinder(d=TubeOD, h=5);
			translate([0,Batt_Y,OAH]) BClip();
		} // union
		
		//Clamp Bolts
		translate([-4,-Batt_Y-4,OAH]) Bolt4Hole();
		translate([4,-Batt_Y-4,OAH]) Bolt4Hole();
		
		// Batteries
		translate([0,0,3]) RoundRect(X=Batt_X, Y=Batt_Y*2, Z=Batt_h, R=Batt_r);
		
		// Trim sides
		translate([Batt_X/2+3, -TubeOD/2, -Overlap]) cube([TubeOD/2, TubeOD, OAH+Overlap*2]);
		mirror([1,0,0])
			translate([Batt_X/2+3, -TubeOD/2, -Overlap]) cube([TubeOD/2, TubeOD, OAH+Overlap*2]);
		
		// Push holes
		translate([0,-Batt_Y/2,-Overlap]) cylinder(d=12, h=4);
		translate([0,Batt_Y/2,-Overlap]) cylinder(d=12, h=4);
	} // difference
	
	if ($preview) translate([0,-Batt_Y/2,3]) BatteryCase();
} // TubeEndBatteryHolder

//TubeEndDoubleBatteryHolder();
	
	
module SingleBatteryHolder(Tube_ID=PML75Body_ID){
	// glues to or is part of the inside of the E-Bay or Fairing
	
	Batt_h=45;
	Batt_X=27;
	Batt_Y=17;
	Batt_r=3;
	
	difference(){
		cylinder(d=Tube_ID, h=Batt_h+6);
		
		translate([Batt_X/2+3,-Tube_ID/2-1,-Overlap]) cube([Tube_ID/2,Tube_ID+2,Batt_h+6+Overlap*2]);
		mirror([1,0,0])
		translate([Batt_X/2+3,-Tube_ID/2-1,-Overlap]) cube([Tube_ID/2,Tube_ID+2,Batt_h+6+Overlap*2]);
		translate([-Tube_ID/2,-Tube_ID/2-1,-Overlap]) 
			cube([Tube_ID,Tube_ID+1-Batt_Y*0.75-5,Batt_h+6+Overlap*2]);
		
		translate([0,Tube_ID/2-5-Batt_Y/2,6]) RoundRect(X=Batt_X, Y=Batt_Y, Z=Batt_h+Overlap, R=Batt_r);
		
		//ty-wraps
		translate([0,Tube_ID/2-1,-Overlap]) cylinder(d=3.5, h=Batt_h+6+Overlap*2);
		translate([-Batt_X/2-10,Tube_ID/2-4,18]) rotate([0,90,0]) cylinder(d=3.5, h=Batt_h+6+Overlap*2);
		translate([-Batt_X/2-10,Tube_ID/2-4,6+Batt_h-12]) rotate([0,90,0]) cylinder(d=3.5, h=Batt_h+6+Overlap*2);
	} // difference
	
} // SingleBatteryHolder

//SingleBatteryHolder();

module DoubleBatteryHolder(Tube_ID=PML75Body_ID, HasBoltHoles=true){
	// glues to the inside of the E-Bay
	
	Batt_h=45;
	Batt_X=27;
	Batt_Y=17;
	
	difference(){
		cylinder(d=Tube_ID, h=Batt_h+3, $fn=$preview? 90:360);
		
		// Bolts
		if (HasBoltHoles){
		translate([0,Tube_ID/2-6,Batt_h+3-4.5]) rotate([90,0,0]) Bolt4ButtonHeadHole();
		translate([0,Tube_ID/2-6,3+4.5]) rotate([90,0,0]) Bolt4ButtonHeadHole();}
		
		// Trim sides
		translate([Batt_Y+3,-Tube_ID/2-1,-Overlap]) cube([Tube_ID/2,Tube_ID+2,Batt_h+6+Overlap*2]);
		mirror([1,0,0])
		translate([Batt_Y+3,-Tube_ID/2-1,-Overlap]) cube([Tube_ID/2,Tube_ID+2,Batt_h+6+Overlap*2]);
		
		// Trim front
		translate([-Tube_ID/2,-Tube_ID/2-1,-Overlap]) 
			cube([Tube_ID,Tube_ID+1-Batt_X*0.75-5,Batt_h+6+Overlap*2]);
		
		// Batteries
		translate([0,Tube_ID/2-6-Batt_X/2,3]) RoundRect(X=Batt_Y*2, Y=Batt_X, Z=Batt_h+Overlap, R=3);
		
		//ty-wraps
		translate([Batt_Y+3,Tube_ID/2-6-Batt_X/2,-Overlap]) cylinder(d=3.5, h=Batt_h+6+Overlap*2);
		translate([-Batt_Y-3,Tube_ID/2-6-Batt_X/2,-Overlap]) cylinder(d=3.5, h=Batt_h+6+Overlap*2);
		hull(){
			translate([0,Tube_ID/2-6,18]) rotate([0,90,0]) cylinder(d=3.5, h=Batt_Y*2+6+Overlap*2, center=true);
			translate([0,Tube_ID/2,18]) rotate([0,90,0]) cylinder(d=3.5, h=Batt_Y*2+Overlap*2, center=true);
		}
		hull(){
			translate([0,Tube_ID/2-6,4+Batt_h-12]) rotate([0,90,0]) cylinder(d=3.5, h=Batt_Y*2+6+Overlap*2, center=true);
			translate([0,Tube_ID/2,4+Batt_h-12]) rotate([0,90,0]) cylinder(d=3.5, h=Batt_Y*2+Overlap*2, center=true);
		}
		
	} // difference
	
} // DoubleBatteryHolder

//DoubleBatteryHolder(Tube_ID=PML98Body_ID);




























