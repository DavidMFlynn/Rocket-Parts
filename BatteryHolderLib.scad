// ***********************************
// Project: 3D Printed Rocket
// Filename: BatteryHolderLib.scad
// by David M. Flynn
// Created: 9/30/2022 
// Revision: 1.0.1  11/28/2022
// Units: mm
// ***********************************
//  ***** Notes *****
//
// A collection of battery holders. 
//
//  ***** History *****
//
echo("BatteryHolderLib 1.0.1");
//
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
//  Batt_Door(Tube_OD=PML98Body_OD, InnerTube_OD=PML54Body_OD, HasSwitch=false);
//  SingleBatteryPocket();
//
//  rotate([180,0,0]) TubeEndStackedDoubleBatteryHolder(TubeOD=PML38Body_OD, TubeID=PML38Body_ID); // Fits 38mm motor tube
//  rotate([180,0,0]) TubeEndDoubleBatteryHolder(TubeID=PML54Body_ID, TubeOD=PML54Body_OD); // Fits 54mm motor tube
//
//  SingleBatteryHolder(Tube_ID=PML75Body_ID);
//  DoubleBatteryHolder(Tube_ID=PML75Body_ID);
//
// ***********************************
//  ***** Routines *****
//
//	BattDoorHole(Tube_OD=PML98Body_OD, HasSwitch=false);
//  Batt_DoorBoltPattern(Tube_OD=PML98Body_OD, HasSwitch=false);
//  Batt_BayFrameHole(Tube_OD=PML98Body_OD, HasSwitch=false);
//  Batt_BayDoorFrame(Tube_OD=PML98Body_OD, Tube_ID=PML98Body_ID, HasSwitch=false, ShowDoor=false);
//
//  SingleBatteryHolder(Tube_ID=PML75Body_ID);
//  DoubleBatteryHolder(Tube_ID=PML75Body_ID);
//
// ***********************************
//  ***** for Viewing *****
//
// 
// ***********************************

include<TubesLib.scad>
include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2; 
$fn=$preview? 24:90;


Bolt4Inset=4;
Batt_Door_Y=74;
Batt_Door_X=27+Bolt4Inset*4+10;
Batt_DoorThickness=3.7;

// CK Rotary Switch
CK_RotSw_d=23.5;
CK_RotSw_Face_d=18;
CK_RotSw_Face_h=0.6;
CK_RotSw_Access_d=8;
CK_RotSw_AO_h=15;

module BattDoorHole(Tube_OD=PML98Body_OD, HasSwitch=false){
	Door_Y=HasSwitch? Batt_Door_Y+CK_RotSw_d+1:Batt_Door_Y+1;
	Door_X=Batt_Door_X+1;
	Door_t=Batt_DoorThickness;
	
	intersection(){
		translate([0,-Door_Y/2,0]) rotate([-90,0,0]) 
			Tube(OD=Tube_OD+1, ID=Tube_OD-Door_t*2, Len=Door_Y, myfn=$preview? 36:360);
		RoundRect(X=Door_X, Y=Door_Y, Z=Tube_OD, R=4+0.5);
	} // intersection
} // BattDoorHole

//rotate([90,0,0]) BattDoorHole(Tube_OD=PML98Body_OD);

module Batt_DoorBoltPattern(Tube_OD=PML98Body_OD, HasSwitch=false){
	Door_Y=HasSwitch? Batt_Door_Y+CK_RotSw_d:Batt_Door_Y;
	Door_X=Batt_Door_X;
	DoorBolt_a=asin((Door_X/2)/(Tube_OD/2))-asin(Bolt4Inset/(Tube_OD/2));
	
	
	rotate([0,DoorBolt_a,0]) translate([0,Door_Y/2-4,Tube_OD/2]) children();
	rotate([0,DoorBolt_a,0]) translate([0,-Door_Y/2+4,Tube_OD/2]) children();
	
	mirror([1,0,0]){
		rotate([0,DoorBolt_a,0]) translate([0,Door_Y/2-4,Tube_OD/2]) children();
		rotate([0,DoorBolt_a,0]) translate([0,-Door_Y/2+4,Tube_OD/2]) children();
	} // mirror
} // Batt_DoorBoltPattern

//rotate([90,0,0]) Batt_DoorBoltPattern(Tube_OD=PML98Body_OD) Bolt4Hole();

module Batt_BayFrameHole(Tube_OD=PML98Body_OD, HasSwitch=false){
	Tube_Len=HasSwitch? Batt_Door_Y+CK_RotSw_d+2:Batt_Door_Y+2;
	Door_Y=HasSwitch? Batt_Door_Y+CK_RotSw_d:Batt_Door_Y;
	Door_X=Batt_Door_X;
	
	translate([0,-Tube_OD/2+10,0]) rotate([90,0,0]) 
			RoundRect(X=Door_X+5, Y=Tube_Len-1, Z=20, R=0.1);
	
	translate([0,-Tube_OD/2+35,0]) rotate([90,0,0]) 
			RoundRect(X=Door_X-20, Y=Tube_Len-1, Z=30, R=0.1);
} // Batt_BayFrameHole

//Batt_BayFrameHole();

module Batt_BayDoorFrame(Tube_OD=PML98Body_OD, Tube_ID=PML98Body_ID, HasSwitch=false, ShowDoor=false){
	Tube_Len=HasSwitch? Batt_Door_Y+CK_RotSw_d+7:Batt_Door_Y+7;
	Door_Y=HasSwitch? Batt_Door_Y+CK_RotSw_d:Batt_Door_Y;
	Door_X=Batt_Door_X;
	Door_t=Batt_DoorThickness;
	BoltBossInset=10.5+2;
	
	difference(){
		union(){
			// Tube section
			intersection(){
				translate([0,0,-Tube_Len/2])
					Tube(OD=Tube_OD, ID=Tube_ID, Len=Tube_Len, myfn=$preview? 36:360);
				rotate([90,0,0]) 
						RoundRect(X=Door_X+22, Y=Tube_Len, Z=Tube_OD, R=0.1);
			} // intersection
			
			// Door frame
			intersection(){
				translate([0,0,-Door_Y/2-3]) 
					Tube(OD=Tube_OD-1, ID=Tube_ID-8, Len=Door_Y+6, myfn=$preview? 36:360);
					
				hull(){
					translate([0,-Tube_ID/2+12,0]) rotate([90,0,0]) 
						RoundRect(X=Door_X+3, Y=Door_Y+3, Z=Tube_OD, R=4+3);
					translate([0,-Tube_ID/2,0]) rotate([90,0,0]) 
						RoundRect(X=Tube_ID*2, Y=Door_Y+8, Z=Tube_OD, R=4+3);
				} // hull
			} // intersection
		} // union
		
		rotate([90,0,0]) RoundRect(X=Door_X-4, Y=Door_Y-4, Z=Tube_OD, R=4-2);
		
		rotate([90,0,0]) BattDoorHole(Tube_OD=Tube_OD, HasSwitch=HasSwitch);
	} // difference
	
	// Door Bolts
	difference(){
		// Bolt bosses
		intersection(){
			translate([0,0,-Door_Y/2-3]) 
				Tube(OD=Tube_OD-1, ID=Tube_ID-8, Len=Door_Y+6, myfn=$preview? 36:360);
			
				rotate([90,0,0]) 
					Batt_DoorBoltPattern(Tube_OD=Tube_OD, HasSwitch=HasSwitch) translate([0,0,-6]) hull(){
						cylinder(d=Bolt4Inset*2, h=6);
						translate([Bolt4Inset,0,0]) cylinder(d=Bolt4Inset*2+2, h=6);
					} // hull
			
		} // intersection
		
		rotate([90,0,0]) BattDoorHole(Tube_OD=Tube_OD, HasSwitch=HasSwitch);
		
		// mounting bolts
		rotate([90,0,0]) 
			Batt_DoorBoltPattern(Tube_OD=Tube_OD, HasSwitch=HasSwitch) Bolt4Hole();
		
	} // difference
	
	if ($preview&&ShowDoor) rotate([90,0,0]) Batt_Door(Tube_OD=Tube_OD, HasSwitch=HasSwitch);
		
	
} // Batt_BayDoorFrame

//Batt_BayDoorFrame(ShowDoor=true);


module Batt_Door(Tube_OD=PML98Body_OD, InnerTube_OD=PML54Body_OD, HasSwitch=false){
	Door_Y=HasSwitch? Batt_Door_Y+CK_RotSw_d:Batt_Door_Y;
	Door_X=Batt_Door_X;
	Door_t=Batt_DoorThickness;
	BoltBossInset=3;
	Batt_Offset_Y=Door_Y/2-68;
	
	Batt_h=45;
	BattConn_h=8;
	Batt_X=27;
	Batt_Y=17;
	Switch_Y=-Door_Y/2+CK_RotSw_d/2+6;
	
	difference(){
		union(){
			// a section of tube
			intersection(){
				translate([0,-Door_Y/2,0]) rotate([-90,0,0]) 
					Tube(OD=Tube_OD, ID=Tube_OD-Door_t*2, Len=Door_Y, myfn=$preview? 36:360);
				
				RoundRect(X=Door_X, Y=Door_Y, Z=Tube_OD, R=4);
			} // intersection
			
			intersection(){
				difference(){
					translate([0,-Door_Y/2,0]) rotate([-90,0,0]) 
						cylinder(d=Tube_OD-1, h=Door_Y);
					translate([0,-Door_Y/2-Overlap,0]) rotate([-90,0,0]) 
						cylinder(d=InnerTube_OD+IDXtra, h=Door_Y+Overlap*2);
				} // difference
				
				union(){
					//Battery holder
					 translate([0, Door_Y/2-Batt_h-BattConn_h-10, Tube_OD/2-Door_t-Batt_Y/2-1.5]) 
						rotate([-90,0,0]) SingleBatteryPocket();
					
					// Switch
					if (HasSwitch)
						translate([0, Switch_Y, Tube_OD/2-CK_RotSw_AO_h/2])
							cylinder(d=CK_RotSw_d+4, h=CK_RotSw_AO_h);
				} // union
			} // intersection
		} // union

		// Door mounting bolts
		Batt_DoorBoltPattern(Tube_OD=Tube_OD, HasSwitch=HasSwitch)
			Bolt4ClearHole(); //translate([0,0,0.5]) Bolt4ButtonHeadHole();
		
		// Switch
		if (HasSwitch)
			translate([0, Switch_Y, Tube_OD/2-CK_RotSw_AO_h/2-Overlap]){
				cylinder(d=CK_RotSw_d+IDXtra*2, h=CK_RotSw_AO_h/2-Door_t);
				cylinder(d=CK_RotSw_Face_d+IDXtra*2, h=CK_RotSw_AO_h/2+CK_RotSw_Face_h-Door_t);
				cylinder(d=CK_RotSw_Access_d+IDXtra, h=CK_RotSw_AO_h/2+Overlap*2);
				
			}
	} // difference

} // Batt_Door

//rotate([90,0,0]) Batt_Door(Tube_OD=PML98Body_OD, HasSwitch=false);
//Batt_Door(Tube_OD=PML98Body_OD, HasSwitch=true);

module SingleBatteryPocket(){
	Batt_h=45;
	BattConn_h=8;
	Batt_X=27;
	Batt_Y=17;
	Batt_r=3;
	
	module BatteryCase(){
		color("Orange") RoundRect(Y=Batt_Y, X=Batt_X, Z=Batt_h+BattConn_h, R=Batt_r);
	} // BatteryCase
	
	difference(){
		RoundRect(X=Batt_X+5, Y=Batt_Y+5, Z=Batt_h+2, R=2);
			
				
		// Battery
		translate([0,0,3]) RoundRect(X=Batt_X+IDXtra*2, Y=Batt_Y+IDXtra*2, Z=Batt_h, R=Batt_r);
		
		
		// Trim side, Shockcord path
		//translate([Batt_Y/2+3, -TubeOD/2, -Overlap]) cube([TubeOD/2, TubeOD, OAH+Overlap*2]);
		
		
		// Push holes
		translate([0,0,-Overlap]) cylinder(d=12, h=4);
		
	} // difference
	if ($preview) translate([0,0,3]) BatteryCase();
	
} // SingleBatteryPocket

//SingleBatteryPocket();

module TubeEndStackedDoubleBatteryHolder(TubeOD=PML38Body_OD, TubeID=PML38Body_ID){
	// Sits in the E-Bay in the top of the motor tube. 
	
	Batt_h=45;
	BattConn_h=8;
	Batt_X=27;
	Batt_Y=17;
	Batt_r=3;
	
	Base_h=Batt_h+Batt_h+BattConn_h-1;
	OAH=Base_h+5;
	Offset_Y=-1;
	
	module BatteryCase(){
		color("Orange") RoundRect(Y=Batt_X, X=Batt_Y, Z=Batt_h*2+BattConn_h, R=Batt_r);
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




























