// ************************************
// Project: 3D Printed Rocket
// Filename: SmallRocketStand.scad
// by David M. Flynn
// Created: 6/15/2023 
// Revision: 1.1  8/27/2023
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  Rocket Stand originally part of Rocket_Loc_Graduator.scad
//
// Hardware:
// #8-32 x 1/4" Button Head Cap Screw (6 Req.)
// 1/2" Aluminum Tubing x 10 to 12 inches
//
//  ***** History *****
// 1.1    8/27/2023  Copied SpoolBushing() to here.
// 1.0.1  6/29/2023  38mm bushing
// 1.0.0  6/15/2023  First code.
//
// ***********************************
//  ***** for STL output *****
//
// SHS_Arms();
// SHS_Extension(Len=20);
// SHS_Base();
//
// SpoolBushing(H=75, Pipe_OD=Pipe15_OD); // Adaptor to use 1-1/2" PVC pipe and a 2.5kg spool as a stand.
// SpoolBushing(H=45, Pipe_OD=Pipe10_OD); // Adaptor to use 1" PVC pipe and a 2.5kg spool as a stand.
//
// RocketStandLeg(); // print 3
// RocketStandBase(); // print 2
// RocketStandBushing(OD=28.5); // print 2 to 4 as needed
// RocketStandBushing(OD=37); // for 38mm motor tube
//
// ***********************************
//  ***** for Viewing *****
//
// ShowRocketStand();
//
// ***********************************

use<SpringThingBooster.scad>
include<TubesLib.scad>

//include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

// Rocket Stand parameters
LegRoot_h=40;
nLegs=3;
Base_d=100;
Leg_W=20;
LegLen=150;
Base_t=6;

PrepStand_BaseSpan=300;
PrepStand_Hub_d=70;
PrepStand_nSides=6;


// SHS_ Small Horizontal Stand 

module SHS_Base(){
	nLegs=4;
	Base_Leg_X=60;
	Base_Leg_Y=22;
	Base_Leg_Z1=2;
	Base_Leg_Z2=10;
	Base_Leg_R=4;
	Base_Leg_Inset=2.5;
	
	module OneLeg(){
		hull(){
			RoundRect(X=Base_Leg_X, Y=Base_Leg_Y, Z=Base_Leg_Z1, R=Base_Leg_R);
			translate([-Base_Leg_Inset,0,Base_Leg_Z2])
				RoundRect(X=Base_Leg_X-Base_Leg_Inset*2, Y=Base_Leg_Y-Base_Leg_Inset*2, Z=Overlap, R=Base_Leg_R-Base_Leg_Inset/2);
		} // hull
	} // OneLeg
	
	Leg_Offset_a=35;
	Leg_a=[Leg_Offset_a,-Leg_Offset_a,180+Leg_Offset_a,180-Leg_Offset_a];
	
	
	difference(){
		union(){
			RoundRect(X=40, Y=30, Z=Base_Leg_Z2+2, R=5);
			RoundRect(X=36, Y=26, Z=Base_Leg_Z2+12, R=3);
			for (j=Leg_a) rotate([0,0,j]) translate([Base_Leg_X/2,0,0]) OneLeg();
		} // union
			
		translate([0,0,-Overlap]) RoundRect(X=32, Y=22, Z=Base_Leg_Z2+12+Overlap*2, R=1);
		rotate([0,0,Leg_Offset_a]) translate([38,0,9]) #linear_extrude(2) text("DMF",size=9, halign="center", valign="center");
	} // difference
	
} // SHS_Base

// SHS_Base();

module SHS_Arms(){
	Arm_X=60;
	Arm_Y=30;
	Arm_Z1=2;
	Arm_Z2=10;
	Arm_R=4;
	Arm_Inset=2;
	
	module OneArm(){
		hull(){
			translate([-Arm_Inset,0,Arm_Z2]) RoundRect(X=Arm_X, Y=Arm_Y, Z=Arm_Z1, R=Arm_R);
			
			RoundRect(X=Arm_X-Arm_Inset*2, Y=Arm_Y-Arm_Inset*2, Z=Overlap, R=Arm_R-Arm_Inset/2);
		} // hull
	} // OneArm
	
	difference(){
		union(){
			translate([-Arm_X/2,0,24]) rotate([0,45,0]) OneArm();
			mirror([1,0,0]) translate([-Arm_X/2,0,24]) rotate([0,45,0]) OneArm();
			
			RoundRect(X=40, Y=30, Z=15, R=5);
		} // union
		
		translate([0,0,-Overlap]) RoundRect(X=36+IDXtra, Y=26+IDXtra, Z=12, R=3);
	} // difference
	
} // SHS_Arms

//translate([0,0,40+12.4]) SHS_Arms();

module SHS_Extension(Len=20){
	difference(){
		union(){
			RoundRect(X=40, Y=30, Z=Len, R=5);
			RoundRect(X=36, Y=26, Z=Len+10, R=3);
		} // union
		
		hull(){
			translate([0,0,-Overlap]) RoundRect(X=36+IDXtra, Y=26+IDXtra, Z=Len-5, R=3);
			translate([0,0,-Overlap]) RoundRect(X=32, Y=22, Z=Len-1, R=1);
		} // hull
		
		RoundRect(X=32, Y=22, Z=Len+12+Overlap, R=1);
	} // difference
} // SHS_Extension

//translate([0,0,12.2]) SHS_Extension(Len=20);

module PrepStand_HubBoltPattern(){
	nSides=PrepStand_nSides;
	
	for (j=[0:nSides-1]) rotate([0,0,360/nSides*j+180/nSides]) translate([0,PrepStand_Hub_d/2-12,0]) children();
} // PrepStand_HubBoltPattern

//PrepStand_HubBoltPattern();

module PrepStand_Core(){
	H=62.5;
	
	PrepStand_BottomCap();
	
	difference(){
		cylinder(d=PrepStand_Hub_d-11, h=H, $fn=6);
		
		translate([0,0,H]) PrepStand_HubBoltPattern() Bolt6Hole();
		translate([0,0,-Overlap]) cylinder(d=PrepStand_Hub_d-34, h=H+Overlap*2, $fn=6);
	} // difference
	
	difference(){
		union(){
			cylinder(d=12.7+6, h=H);
			rotate([0,0,30])
			PrepStand_HubBoltPattern() hull(){ 
				translate([0,-3,0])cylinder(d=2, h=H);
				translate([0,-15,0]) cylinder(d=2, h=H);
			}
		} // union
		
		translate([0,0,-Overlap]) cylinder(d=12.7+IDXtra, h=H+Overlap*2);
	} // difference
} // PrepStand_Core

//translate([0,0,62.5+4]) rotate([0,180,0]) PrepStand_Core();

module PrepStand_BP4_A(){
	Main_OD=140;
	Booster_OD=80;
	Felt_t=3;
	Wall_t=5;
	Thickness=50;
	Height=Main_OD/2+75;
	
	difference(){
		union(){
			cylinder(d=Main_OD+Felt_t*2+Wall_t*2, h=Thickness);
			translate([Main_OD/2+Booster_OD/2,0,0])
				cylinder(d=Booster_OD+Felt_t*2+Wall_t*2, h=Thickness);
			translate([-Main_OD/2-Booster_OD/2,0,0])
				cylinder(d=Booster_OD+Felt_t*2+Wall_t*2, h=Thickness);
			translate([-Thickness/2,-Height,0]) cube([Thickness,Height,Thickness]);
			
			// gussets
			hull(){
				translate([10, -Height+Wall_t/2, 0]) cylinder(d=Wall_t, h=Thickness);
				translate([Main_OD/2+Booster_OD, -20, 0]) cylinder(d=Wall_t, h=Thickness);
			} // hulll
			hull(){
				translate([-10, -Height+Wall_t/2, 0]) cylinder(d=Wall_t, h=Thickness);
				translate([-Main_OD/2-Booster_OD, -20, 0]) cylinder(d=Wall_t, h=Thickness);
			} // hulll
		} // union

		translate([0,0,-Overlap])
			cylinder(d=Main_OD+Felt_t*2, h=Thickness+Overlap*2);
		translate([Main_OD/2+Booster_OD/2,0,-Overlap])
			cylinder(d=Booster_OD+Felt_t*2, h=Thickness+Overlap*2);
		translate([-Main_OD/2-Booster_OD/2,0,-Overlap])
			cylinder(d=Booster_OD+Felt_t*2, h=Thickness+Overlap*2);
			
		// Trim top
		translate([0,Main_OD/2-20,Thickness/2]) cube([Main_OD+Booster_OD*2+Felt_t*2+Wall_t*2+1, Main_OD, Thickness+Overlap*2], center=true);
	
		//core post
		translate([0,-Height-Overlap, Thickness/2]) rotate([-90,0,0]) cylinder(d=12.7, h=Height);
	} // difference
	
} // PrepStand_BP4_A

// PrepStand_BP4_A();

module PrepStand_BP4_B(Lower=false){
	Main_OD=140;
	Booster_OD=80;
	Felt_t=3;
	Wall_t=5;
	Thickness=50;
	Height=Main_OD/2+75;
	
	difference(){
		union(){
			cylinder(d=Main_OD+Felt_t*2+Wall_t*2, h=Thickness);
			
			hull(){
				translate([-Thickness/4,-Height,0]) cube([Thickness/2,Height,Thickness]);
				translate([-Thickness/2,-Height/2,Thickness/2]) rotate([90,0,0]) cylinder(d=5, h=Height, center=true);
				translate([Thickness/2,-Height/2,Thickness/2]) rotate([90,0,0]) cylinder(d=5, h=Height, center=true);
			} // hull
			
			if (Lower){
				//rotate([0,0,-45]) translate([Main_OD/2+Felt_t+10,-7-Felt_t-10,0]) cylinder(d=20, h=Thickness);
				rotate([0,0,-45]) translate([Main_OD/2+Felt_t,-7-Felt_t-Wall_t,0]) cube([10,Wall_t, Thickness]);
				mirror([1,0,0]) rotate([0,0,-45]) translate([Main_OD/2+Felt_t,-7-Felt_t-Wall_t,0]) cube([10,Wall_t, Thickness]);
			}
			
		} // union

		translate([0,0,-Overlap])
			cylinder(d=Main_OD+Felt_t*2, h=Thickness+Overlap*2);
		translate([Main_OD/2+Booster_OD/2,0,-Overlap])
			cylinder(d=Booster_OD+Felt_t*2, h=Thickness+Overlap*2);
		translate([-Main_OD/2-Booster_OD/2,0,-Overlap])
			cylinder(d=Booster_OD+Felt_t*2, h=Thickness+Overlap*2);
			
		// Trim top
		translate([0,Main_OD/2-20,Thickness/2]) cube([Main_OD+Booster_OD*2+Felt_t*2+Wall_t*2+1, Main_OD, Thickness+Overlap*2], center=true);
		
		if (Lower){
			rotate([0,0,-45]) translate([0, -7-Felt_t, -Overlap]) cube([Main_OD, 100, Thickness+Overlap*2]);
			mirror([1,0,0]) rotate([0,0,-45]) translate([0, -7-Felt_t, -Overlap]) cube([Main_OD, 100, Thickness+Overlap*2]);
		}
	
		//core post
		translate([0,-Height-Overlap, Thickness/2]) rotate([-90,0,0]) cylinder(d=12.7, h=Height);
	} // difference
	
} // PrepStand_BP4_B

// PrepStand_BP4_B(Lower=true);

module PrepStand_Omega6_B(Lower=false){
	Main_OD=ULine157Body_OD*CF_Comp;
	Felt_t=3;
	Wall_t=5;
	Thickness=50;
	Height=Main_OD/2+75;
	Fin_t=23;
	
	difference(){
		union(){
			cylinder(d=Main_OD+Felt_t*2+Wall_t*2, h=Thickness);
			
			hull(){
				translate([-Thickness/4,-Height,0]) cube([Thickness/2,Height,Thickness]);
				translate([-Thickness/2,-Height/2,Thickness/2]) rotate([90,0,0]) cylinder(d=5, h=Height, center=true);
				translate([Thickness/2,-Height/2,Thickness/2]) rotate([90,0,0]) cylinder(d=5, h=Height, center=true);
			} // hull
			
			if (Lower){
				//rotate([0,0,-45]) translate([Main_OD/2+Felt_t+10,-7-Felt_t-10,0]) cylinder(d=20, h=Thickness);
				rotate([0,0,-45]) translate([Main_OD/2+Felt_t,-Fin_t/2-Felt_t-Wall_t,0]) cube([10, Wall_t, Thickness]);
				mirror([1,0,0]) rotate([0,0,-45]) translate([Main_OD/2+Felt_t,-Fin_t/2-Felt_t-Wall_t,0]) cube([10, Wall_t, Thickness]);
			}
			
		} // union

		translate([0,0,-Overlap])
			cylinder(d=Main_OD+Felt_t*2, h=Thickness+Overlap*2);
		
			
		// Trim top
		translate([0,Main_OD/2-20,Thickness/2]) cube([Main_OD+Felt_t*2+Wall_t*2+1, Main_OD, Thickness+Overlap*2], center=true);
		
		if (Lower){
			rotate([0,0,-45]) translate([0, -Fin_t/2-Felt_t, -Overlap]) cube([Main_OD, 100, Thickness+Overlap*2]);
			mirror([1,0,0]) rotate([0,0,-45]) translate([0, -Fin_t/2-Felt_t, -Overlap]) cube([Main_OD, 100, Thickness+Overlap*2]);
		}
	
		//core post
		translate([0,-Height-Overlap, Thickness/2]) rotate([-90,0,0]) cylinder(d=12.7, h=Height);
	} // difference
	
} // PrepStand_Omega6_B

// PrepStand_Omega6_B(Lower=true);
// PrepStand_Omega6_B(Lower=false);

module PrepStand_BottomCap(){
	nSides=PrepStand_nSides;
	
	for (j=[0:nSides-1]) rotate([0,0,360/nSides*j]) translate([0,PrepStand_Hub_d/2,0])
		translate([-20,-5+IDXtra,0]) cube([40,4.5,8]);
		
	
		difference(){
			cylinder(d=PrepStand_Hub_d+10, h=3, $fn=6);
			
			translate([0,0,-Overlap]) cylinder(d=PrepStand_Hub_d-34, h=3+Overlap*2, $fn=6);
			
			translate([0,0,3]) PrepStand_HubBoltPattern() Bolt6ClearHole();
		} // difference
} // PrepStand_BottomCap

//PrepStand_BottomCap();
/*
rotate([0,0,30]) translate([-1,-15,-41.5]) PrepStand_Leg();
rotate([0,0,180]) rotate([0,0,30]) translate([0,-15,8]) PrepStand_RocketArm();
translate([0,0,180]) rotate([0,0,30]) rotate([90,0,0]) cylinder(d=203, h=50);
/**/
module PrepStand_Leg(){
	// old
	
	hull(){
		translate([PrepStand_BaseSpan/2,0,0]) cube([30,30,3]);
		translate([PrepStand_Hub_d/2,0,50]) cube([3,30,50]);
	} // hull
		
	translate([PrepStand_Hub_d/2-4,0,50]) cube([4+Overlap,30,50]);
	translate([PrepStand_Hub_d/2-8,0,46]) cube([4+Overlap,30,58]);
	
} // PrepStand_Leg

//rotate([90,0,0]) PrepStand_Leg();

module PrepStand_Leg2(){
	module LegShape(){
		
	} // LegShape
	
	difference(){
		hull(){
			translate([PrepStand_BaseSpan/2,0,0]) cube([30,30,3]);
			translate([PrepStand_Hub_d/2+1,0,50]) cube([3,30,50]);
		} // hull
		
		translate([PrepStand_Hub_d/2,-Overlap,54]) cube([3+Overlap,30+Overlap*2,43]);
		
		//translate([PrepStand_Hub_d/2+3,-Overlap,53]) cube([Overlap,30+Overlap*2,44]);
		hull(){
			translate([PrepStand_BaseSpan/2,-Overlap,3]) cube([24,30+Overlap*2,Overlap]);
			translate([PrepStand_Hub_d/2+3,-Overlap,53]) cube([Overlap,30+Overlap*2,44]);
		} // hull
	} // difference
	
	
	translate([PrepStand_Hub_d/2-4,0,50]) cube([5+Overlap,30,50]);
	translate([PrepStand_Hub_d/2-8,0,46]) cube([4+Overlap,30,58]);
	
	Web_t=2;
	// web
	hull(){
		translate([PrepStand_Hub_d/2+3,0,53]) rotate([-90,0,0]) cylinder(d=Web_t, h=30);
		translate([PrepStand_Hub_d/2+3+22,0,53+30]) rotate([-90,0,0]) cylinder(d=Web_t, h=30);
	} // hull
	hull(){
		translate([PrepStand_Hub_d/2+3+22,0,53+30]) rotate([-90,0,0]) cylinder(d=Web_t, h=30);
		translate([PrepStand_Hub_d/2+3+22,0,53-10]) rotate([-90,0,0]) cylinder(d=Web_t, h=30);
	} // hull
	hull(){
		translate([PrepStand_Hub_d/2+3+22,0,53-10]) rotate([-90,0,0]) cylinder(d=Web_t, h=30);
		translate([PrepStand_Hub_d/2+3+22+56,0,53-10]) rotate([-90,0,0]) cylinder(d=Web_t, h=30);
	} // hull
	hull(){
		translate([PrepStand_Hub_d/2+3+22+56,0,53-10]) rotate([-90,0,0]) cylinder(d=Web_t, h=30);
		translate([PrepStand_Hub_d/2+3+22+56,0,53-10-25]) rotate([-90,0,0]) cylinder(d=Web_t, h=30);
	} // hull
	hull(){
		translate([PrepStand_Hub_d/2+3+22+56,0,53-10-25]) rotate([-90,0,0]) cylinder(d=Web_t, h=30);
		translate([PrepStand_Hub_d/2+3+22+56+36,0,53-10-25]) rotate([-90,0,0]) cylinder(d=Web_t, h=30);
	} // hull
	hull(){
		translate([PrepStand_Hub_d/2+3+22+56+36,0,53-10-25]) rotate([-90,0,0]) cylinder(d=Web_t, h=30);
		translate([PrepStand_Hub_d/2+3+22+56+36,0,53-10-25-16]) rotate([-90,0,0]) cylinder(d=Web_t, h=30);
	} // hull
} // PrepStand_Leg2

// rotate([90,0,0]) PrepStand_Leg2();

module PrepStand_RocketArm(){
	Len=150;
	MountingPlate_t=4;
	
	difference(){
		union(){
			hull(){
				translate([Len-30,0,Len]) cube([10,30,3]);
				translate([PrepStand_Hub_d/2,0,0]) cube([3,30,50]);
			} // hull
			difference(){
				translate([2,0,180]) rotate([-90,0,0]) cylinder(r=105+5+4, h=30, $fn=$preview? 90:360);
				
				translate([4,-Overlap,0]) mirror([1,0,0]) cube([200,30+Overlap*2,400]);
				translate([4,-Overlap,120]) cube([200,30+Overlap*2,400]);
			} // difference
		} // union
		
		translate([2,-Overlap,180]) rotate([-90,0,0]) cylinder(r=105+5, h=30+Overlap*2, $fn=$preview? 90:360);
		
	} // difference
	
	translate([PrepStand_Hub_d/2-4,0,0]) cube([4+Overlap,30,50]);
	translate([PrepStand_Hub_d/2-4-MountingPlate_t,0,-4]) cube([MountingPlate_t+Overlap,30,58]);
	
} // PrepStand_RocketArm

// rotate([90,0,0]) PrepStand_RocketArm();
//translate([0,15,62.5-4]) rotate([0,180,30]) PrepStand_Core();

module TopBushing75(){
	difference(){
		cylinder(d=73, h=30);
		
		translate([0,0,-Overlap]) cylinder(d=45, h=4);
		translate([0,0,3.3]) cylinder(d=49, h=30);
	} // difference
	
} // TopBushing75

// TopBushing75();

module Bushing75(){
	difference(){
		union(){
			cylinder(d=160, h=5);
			cylinder(d=73, h=30);
		} // union
		
		translate([0,0,-Overlap]) cylinder(d=50, h=500);
	} // difference
} // Bushing75

// Bushing75();

module ShowRocketStand(){
	for (j=[0:3]) translate([0,0,LegRoot_h+40+25*j]) RocketStand29mmBushing();
	RocketStandBase();
	translate([0,0,LegRoot_h+Base_t*2-4]) rotate([0,180,0]) RocketStandBase();
	for (j=[0:nLegs-1]) rotate([0,0,360/nLegs*j]) translate([-Leg_W/2,Base_d/2,-LegLen-1])
		rotate([0,0,90]) rotate([90,0,0]) RocketStandLeg();
		
	color("Silver") cylinder(d=12, h=165);
} // ShowRocketStand

//ShowRocketStand();

Pipe15_OD=48.3;
Pipe10_OD=33.3;

module SpoolBushing(H=75, Pipe_OD=Pipe15_OD){
	// Adaptor to use 1-1/2" PVC pipe and a 2.5kg spool as a stand.
	Spool_ID=52.8;
	Spool_OD=58;

	difference(){
		union(){
			cylinder(d=Spool_OD, h=3);
			cylinder(d1=Spool_ID, d2=Spool_ID-0.5, h=H+3);
		} // union

		translate([0,0,-Overlap]) cylinder(d=Pipe_OD+IDXtra*3, h=H+Overlap*2);
		translate([0,0,H]) cylinder(d1=Pipe_OD+IDXtra*2, d2=Pipe_OD-2, h=3+Overlap);
	} // difference

} // SpoolBushing

// SpoolBushing(H=75, Pipe_OD=Pipe15_OD);
// SpoolBushing(H=45, Pipe_OD=Pipe10_OD);

module SpoolBushingAlTube(H=50){
	Spool_ID=52.8;
	Spool_OD=58;
	AlTube_d=12.7;
	Wall_t=1.6;
	nSpokes=6;

	//Tube(OD=Spool_OD, ID=Spool_ID-Wall_t*2, Len=3, myfn=$preview? 90:myFn);
	//Tube(OD=Spool_ID-0.5, ID=Spool_ID-0.5-Wall_t*2, Len=H+3, myfn=$preview? 90:myFn);
			
	Tube(OD=AlTube_d+IDXtra+Wall_t*2, ID=AlTube_d+IDXtra, Len=H+3, myfn=90);
	
	for (j=[0:nSpokes-1]) rotate([0,0,360/nSpokes*j]) 
		hull(){
			translate([0,AlTube_d/2+Wall_t,0]) cylinder(d=1.2, h=H+3);
			translate([0,Spool_ID/2-Wall_t,0]) cylinder(d=1.2, h=H+3);
		} // hull

	// taper
	difference(){
		union(){
			translate([0,0,]) cylinder(d1=Spool_ID, d2=Spool_ID-0.5, h=H+3);
			cylinder(d=Spool_OD, h=3);
		} // union
		
		translate([0,0,-Overlap]) cylinder(d1=Spool_ID-Wall_t*2, d2=Spool_ID-0.5-Wall_t*2, h=H+3+Overlap*2);
	} // difference
	
	// tube stop
	difference(){
		translate([0,0,H]) cylinder(d=AlTube_d+1, h=3);
		translate([0,0,H-Overlap]) cylinder(d1=AlTube_d+IDXtra, d2=AlTube_d-2, h=3+Overlap*2);
	}
} // SpoolBushingAlTube

// SpoolBushingAlTube();

module RocketStandBushing(OD=28.5){
	ID=12.7;
	
	Wall_t=1.2;
	Trim=7;
	Stretch=4;
	
	difference(){
		hull(){
			translate([0,0,-Stretch/2]) sphere(d=OD);
			translate([0,0,Stretch/2]) sphere(d=OD);
		} // hull
		
		hull(){
			translate([0,0,-Stretch/2]) sphere(d=OD-Wall_t*2);
			translate([0,0,Stretch/2]) sphere(d=OD-Wall_t*2);
		} // hull
		
		translate([0,0,OD/2+Stretch/2-Trim]) cylinder(d=OD+1, h=Trim+1);
		translate([0,0,-OD/2-Stretch/2-1]) cylinder(d=OD+1, h=Trim+1);
	} // difference
	
	difference(){
		union(){
			translate([0,0,-OD/2-Stretch/2+Trim]) cylinder(d=ID+Wall_t*2, h=OD+Stretch-Trim*2);
			
			hull(){
				translate([0,0,-Stretch/2]) rotate([90,0,0]) cylinder(d=OD-1, h=Wall_t, center=true);
				translate([0,0,Stretch/2]) rotate([90,0,0]) cylinder(d=OD-1, h=Wall_t, center=true);
			} // hull
			hull(){
				translate([0,0,-Stretch/2]) rotate([0,90,0]) cylinder(d=OD-1, h=Wall_t, center=true);
				translate([0,0,Stretch/2]) rotate([0,90,0]) cylinder(d=OD-1, h=Wall_t, center=true);
			} // hull
		} // union
		
		translate([0,0,OD/2+Stretch/2-Trim]) cylinder(d=OD+1, h=Trim+1);
		translate([0,0,-OD/2-Stretch/2-1]) cylinder(d=OD+1, h=Trim+1);
		translate([0,0,-OD/2-Stretch/2+Trim-Overlap]) cylinder(d=ID, h=OD+Stretch-Trim*2+Overlap*2);
	} // difference
} // RocketStandBushing

//RocketStandBushing(OD=37);

module RocketStandBase(){
	
	
	difference(){
		union(){
			//cylinder(d=Base_d+Leg_W,h=Base_t);
			hull() for (j=[0:nLegs-1]) rotate([0,0,360/nLegs*j]) translate([0,Base_d/2+Leg_W/4,0]){
				translate([-Leg_W/2,0,0]) cylinder(d=Leg_W/2, h=Base_t);
				translate([Leg_W/2,0,0]) cylinder(d=Leg_W/2, h=Base_t);
			}
			translate([0,0,Base_t-Overlap]) cylinder(d1=30, d2=20, h=10);
		} // union
		
		for (j=[0:nLegs-1]) rotate([0,0,360/nLegs*j]) translate([0,Base_d/2,Base_t-2]){
			Bolt8ClearHole();
			hull(){
				cylinder(d=Leg_W+IDXtra*2, h=3);
				translate([0,Leg_W,0]) cylinder(d=Leg_W+IDXtra*2, h=3);
			} // hull
		}
		translate([0,0,-Overlap]) cylinder(d=12.7, h=20);
	} // difference
} // RocketStandBase

//RocketStandBase();

module RocketStandLeg(){
	Leg_Lift=30;
	Wall_t=1.8; //2.4; too thick
	Multi=1.3;
	Multi_B=2.4;
	
	difference(){
		union(){
			intersection(){
				union(){
					difference(){
						cylinder(r=LegLen*Multi, h=Leg_W, $fn=$preview? 90:360);
						translate([0,0,-Overlap]) 
							cylinder(r=LegLen*Multi-Wall_t, h=Leg_W+Overlap*2, $fn=$preview? 90:360);
					} // difference
					
					translate([0,LegLen*Multi-LegLen*Multi_B-LegRoot_h,0])
					difference(){
						cylinder(r=LegLen*Multi_B+Wall_t, h=Leg_W, $fn=$preview? 90:360);
						translate([0,0,-Overlap]) 
							cylinder(r=LegLen*Multi_B, h=Leg_W+Overlap*2, $fn=$preview? 90:360);
					} // difference
					
					hull(){
						translate([0,LegLen*Multi-LegRoot_h,0]) cylinder(d=2.4, h=Leg_W);
						translate([50,LegLen*Multi-LegRoot_h+50,0]) cylinder(d=2.4, h=Leg_W);
					} // hull
					
					translate([80,-10,0])
					mirror([1,0,0])
					hull(){
						translate([0,LegLen*Multi-LegRoot_h,0]) cylinder(d=2.4, h=Leg_W);
						translate([50,LegLen*Multi-LegRoot_h+50,0]) cylinder(d=2.4, h=Leg_W);
					} // hull
					
					translate([80,-10,0])
					hull(){
						translate([0,LegLen*Multi-LegRoot_h,0]) cylinder(d=2.4, h=Leg_W);
						translate([50,LegLen*Multi-LegRoot_h+50,0]) cylinder(d=2.4, h=Leg_W);
					} // hull
					
				} // union
				
				difference(){
					cylinder(r=LegLen*Multi, h=Leg_W, $fn=$preview? 90:360);
					translate([0,LegLen*Multi-LegLen*Multi_B-LegRoot_h,-Overlap])
						cylinder(r=LegLen*Multi_B, h=Leg_W+Overlap*2, $fn=$preview? 90:360);
				} // difference
				
				translate([0,LegLen*Multi-LegRoot_h-Leg_Lift,0]) cube([LegLen,LegLen*Multi+1,Leg_W]);
			} // intersection
			
			hull(){
				translate([LegLen,LegLen*Multi-LegRoot_h-Leg_Lift,0]) cylinder(d=8, h=Leg_W);
				translate([LegLen-10,LegLen*Multi-LegRoot_h-Leg_Lift,0]) cylinder(d=8, h=Leg_W);
			} // hull
			
			translate([0,LegLen*Multi-LegRoot_h,Leg_W/2]) rotate([-90,0,0]) cylinder(d=Leg_W, h=LegRoot_h);
		} // union
		
		translate([0,LegLen*Multi,Leg_W/2]) rotate([-90,0,0]) Bolt8Hole(depth=LegRoot_h);
	} // difference
} // RocketStandLeg

//RocketStandLeg();









