// ***********************************
// Project: 3D Printed Rocket
// Filename: CablePuller.scad
// by David M. Flynn
// Created: 8/21/2022 
// Revision: 1.1.6  11/28/2022
// Units: mm
// ***********************************
//  ***** Notes *****
//
// Uses the release of a strong spring to pull on a cable. 
// Used with success to release a fairing 10/22.
// Needs a servo or something to push on the StopAdjuster.
// The addition of a torsion spring made from 0.015" music wire is 
// used to move the throughOut back, with the slot in the door this allows arming
// without removing the door from the side of the rocket.
//
// Bearing MR84-2RS, 5ea
// Undersize 4mm x 10mm steel dowel, 2ea
// Undersize 4mm x 12mm steel dowel
// Undersize 4mm x 16mm steel dowel
// #8-32 x 1/4" Set Screw
// #4-40 x 1/2" Socket Head Cap Screws, optionally 3/4" to attach to Electronics Bay, 4ea
// 5/16" Dia. x 1-1/4" long spring. 
// SG90 Servo
//
//  ***** History *****
//
echo("CablePuller 1.1.6");
// 1.1.6  11/28/2022  Standardized door thickness. 
// 1.1.5  11/25/2022  Added BoltBossInset as parameter to CP_Door()
// 1.1.4  11/23/2022  Added HasArmingSlot to door. 
// 1.1.3  11/14/2022  Moved end bolts 1mm, changed to 16mm arm. 14mm travel
// 1.1.2  11/2/2022   Added calculation for CP_DoorBoltPattern
// 1.1.1  10/25/2022  Wider door
// 1.1.0  10/14/2022  Added TriggerBellCrank and BellCrankTriggerBearingHolder for CageTop. 
// 1.0.1  9/17/2022   Fixed SpingBody guide width. 
// 1.0    9/11/2022	  It works OK. Changed set screw hole to Bolt8Hole(), Added notes. 
// 0.9.5  9/10/2022   A tighter cage with spring centering. 
// 0.9.4  9/6/2022    Small fixes. 
// 0.9.3  8/30/2022   It jammed! Need a second bearing for stability. 
// 0.9.2  8/25/2022   Added CablePullerBoltPattern()
// 0.9.1  8/23/2022   Ready for testing. 
// 0.9.0  8/21/2022   First code.
//
// ***********************************
//  ***** for STL output *****
// 
// rotate([0,180,0]) CP_Door(Tube_OD=PML98Body_OD, BoltBossInset=2, HasArmingSlot=true);
// *** BoltBossInset=2 was 3, use 2 to clear 54mm motor tube w/ 98mm body tube ***
//
// ThroughOut();
// rotate([0,90,0]) SpringBody();
// CableRetainer();
// StopAdjuster();
// CageBottom();
// AddServo(); // CageTop w/ servo mount translate([0,0,SpringBody_YZ/2+2.5]) rotate([180,0,0]) CageTop();
//
/*
	translate([0,0,CP_SpringBody_YZ/2+2.5]) rotate([180,0,0]){ 
		CageTop();
		BellCrankTriggerBearingHolder();}
/**/
// rotate([180,0,0]) TriggerBellCrank();
//
// BellCrank(Len=38);
//
// ***********************************
//  ***** Routines *****
//
// CablePullerBoltPattern() Bolt4Hole();
//
// CPDoorHole(Tube_OD=PML98Body_OD);
// CP_DoorBoltPattern(Tube_OD=PML98Body_OD) Bolt4Hole();
// CP_BayFrameHole(Tube_OD=PML98Body_OD);
// CP_BayDoorFrame(Tube_OD=PML98Body_OD, Tube_ID=PML98Body_ID, ShowDoor=false);
//
// ***********************************
//  ***** for Viewing *****
//
// ShowCablePuller();
//
// ***********************************

include<TubesLib.scad>
include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2; // Add to ID for tight fit, x2 for loose fit
$fn=$preview? 24:90;

CableEnd_d=3.0;
CableEnd_h=6.9;
Cable_d=1.0;

CP_Spring_OD=5/16*25.4;
CP_Spring_FL=1.25*25.4;
CP_Spring_CBL=0.7*25.4;

CP_Bearing_ID=4;
CP_Bearing_OD=8;
CP_Bearing_H=3;
ArmLen=16; // extended version 13mm pull (weak at end of travel)
//ArmLen=14; // original more compact 11mm pull
CR_h=CableEnd_h+2;
CP_SpringBody_YZ=11;
LooseFit=0.8;

Bolt4Inset=4;
CP_Door_Y=120;
CP_Door_X=CP_SpringBody_YZ+5+Bolt4Inset*4+20; // changed 10/25/2022, was +10
CP_DoorThickness=3.7;

module Bearing(){
	color("Red")
	difference(){
		cylinder(d=CP_Bearing_OD, h=CP_Bearing_H, center=true);
		cylinder(d=CP_Bearing_ID, h=CP_Bearing_H+Overlap, center=true);
	} // difference
} // Bearing

// Bearing();

module ShowCablePuller(){
	//TO_a=-45;
	TO_a=0;
	
	rotate([0,0,TO_a]) ThroughOut();
	translate([0,0,-CP_Bearing_H/2]) Bearing();
	translate([0,0,CP_Bearing_H/2]) Bearing();
	color("Silver") Dowel(Len=CP_SpringBody_YZ+5.05);
	rotate([0,0,TO_a]) {
	translate([ArmLen,0,0]) Bearing();
	translate([ArmLen,0,0]) color("Silver") Dowel(Len=CP_Bearing_H+6);}
	
	translate([ArmLen+CP_Bearing_OD,0,0])SpringBody();
	translate([ArmLen+CP_Bearing_OD,0,0]) Bearing();
	translate([ArmLen+CP_Bearing_OD,0,0]) color("Silver") Dowel(Len=CP_SpringBody_YZ);
	
	translate([ArmLen+CR_h+CP_Bearing_OD*1.5+3,0,0])
		color("LightBlue") rotate([0,-90,0]) CableRetainer();
	
	CageBottom();
	
	translate([ArmLen,CP_SpringBody_YZ/2+LooseFit/2+0.4,0]) rotate([-90,0,0]) color("Tan") StopAdjuster();
	
	//translate([10,10,15]) 
	translate([0,0,Overlap]) CageTop();
	
	BellCrankTriggerBearingHolder();
	translate([CP_Bearing_OD*1.5+ArmLen, 7.5+4+CP_Bearing_OD/2, 7.5-2-CP_Bearing_H/2-1.5])
		TriggerBellCrank();
} // ShowCablePuller

//ShowCablePuller();

module CPDoorHole(Tube_OD=PML98Body_OD){
	Door_Y=CP_Door_Y+1;
	Door_X=CP_Door_X+1;
	Door_t=CP_DoorThickness;
	
	intersection(){
		translate([0,-Door_Y/2,0]) rotate([-90,0,0]) 
			Tube(OD=Tube_OD+1, ID=Tube_OD-Door_t*2, Len=Door_Y, myfn=$preview? 36:360);
		RoundRect(X=Door_X, Y=Door_Y, Z=Tube_OD, R=4+0.5);
	} // intersection
} // CPDoorHole

//rotate([90,0,0]) CPDoorHole(Tube_OD=PML98Body_OD);
//translate([0,-20,PML98Body_OD/2-6]) rotate([0,0,90]) CablePullerBoltPattern() cylinder(d=Bolt4Inset*2, h=4);

module CP_DoorBoltPattern(Tube_OD=PML98Body_OD){
	Door_Y=CP_Door_Y;
	Door_X=CP_Door_X;
	DoorBolt_a=asin((Door_X/2)/(Tube_OD/2))-asin(Bolt4Inset/(Tube_OD/2));
	
	rotate([0,DoorBolt_a,0]) translate([0,Door_Y/2-4,Tube_OD/2]) children();
	rotate([0,DoorBolt_a,0]) translate([0,-Door_Y/2+4,Tube_OD/2]) children();
	rotate([0,DoorBolt_a,0]) translate([0,0,Tube_OD/2]) children();
	
	mirror([1,0,0]){
		rotate([0,DoorBolt_a,0]) translate([0,0,Tube_OD/2]) children();
		rotate([0,DoorBolt_a,0]) translate([0,Door_Y/2-4,Tube_OD/2]) children();
		rotate([0,DoorBolt_a,0]) translate([0,-Door_Y/2+4,Tube_OD/2]) children();
	} // mirror
} // CP_DoorBoltPattern

//CP_DoorBoltPattern(Tube_OD=PML98Body_OD) Bolt4Hole();
//CP_Door(Tube_OD=PML98Body_OD);

module CP_BayFrameHole(Tube_OD=PML98Body_OD){
	Tube_Len=CP_Door_Y+2;
	Door_Y=CP_Door_Y;
	Door_X=CP_Door_X;
	
	translate([0,-Tube_OD/2+10,0]) rotate([90,0,0]) 
			RoundRect(X=Door_X+5, Y=Tube_Len-1, Z=15, R=0.1);
	
	translate([0,-Tube_OD/2+20,0]) rotate([90,0,0]) 
			RoundRect(X=Door_X-2, Y=Tube_Len-1, Z=20, R=0.1);
} // CP_BayFrameHole

//CP_BayFrameHole();

module CP_BayDoorFrame(Tube_OD=PML98Body_OD, Tube_ID=PML98Body_ID, ShowDoor=false){
	Tube_Len=CP_Door_Y+7;
	Door_Y=CP_Door_Y;
	Door_X=CP_Door_X;
	Door_t=CP_DoorThickness;
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
					Tube(OD=Tube_OD-1, ID=Tube_ID-9, Len=Door_Y+6, myfn=$preview? 36:360);
					
				hull(){
					translate([0,-Tube_ID/2+12,0]) rotate([90,0,0]) 
						RoundRect(X=Door_X+3, Y=Door_Y+3, Z=Tube_OD, R=4+3);
					translate([0,-Tube_ID/2,0]) rotate([90,0,0]) 
						RoundRect(X=Tube_ID*2, Y=Door_Y+8, Z=Tube_OD, R=4+3);
				} // hull
			} // intersection
		} // union
		
		rotate([90,0,0]) RoundRect(X=Door_X-4, Y=Door_Y-4, Z=Tube_OD, R=4-2);
		
		rotate([90,0,0]) CPDoorHole(Tube_OD=Tube_OD);
	} // difference
	
	// Door Bolts
	difference(){
		// Bolt bosses
		intersection(){
			// trim outside
			translate([0,0,-Door_Y/2-3]) 
					Tube(OD=Tube_OD-1, ID=Tube_ID-9, Len=Door_Y+6, myfn=$preview? 36:360);
				
			// trim inside
			hull(){
				translate([0,-Tube_ID/2+12,0]) rotate([90,0,0]) 
					RoundRect(X=Door_X+3, Y=Door_Y+3, Z=Tube_OD, R=4+3);
				translate([0,-Tube_ID/2,0]) rotate([90,0,0]) 
					RoundRect(X=Tube_ID*2, Y=Door_Y+8, Z=Tube_OD, R=4+3);
			} // hull
		
			
			rotate([90,0,0]) 
				CP_DoorBoltPattern(Tube_OD=Tube_OD) translate([0,0,-6.5]) hull(){
					cylinder(d=Bolt4Inset*2, h=6);
					translate([Bolt4Inset+2,0,0]) cylinder(d=Bolt4Inset*2+2, h=6);
				}
			
		} // intersection
		
		rotate([90,0,0]) CPDoorHole(Tube_OD=Tube_OD);
		
		// mounting bolts
		rotate([90,0,0]) 
			CP_DoorBoltPattern(Tube_OD=Tube_OD) Bolt4Hole();
		
	} // difference
	
	if ($preview&&ShowDoor){ rotate([90,0,0]) CP_Door(Tube_OD=Tube_OD);
		translate([0,-Tube_OD/2+14,-8]) rotate([0,0,-90]) rotate([0,-90,0]) ShowCablePuller();}
	
} // CP_BayDoorFrame

//CP_BayDoorFrame(ShowDoor=false);

module CP_Door(Tube_OD=PML98Body_OD, BoltBossInset=2, HasArmingSlot=false){
	Door_Y=CP_Door_Y;
	Door_X=CP_Door_X;
	Door_t=CP_DoorThickness;
	//BoltBossInset=2; // was 3, use 2 to clear 54mm motor tube w/ 98mm body tube
	CP_Offset_Y=Door_Y/2-68;
	
	translate([9,-Door_Y/2+27,Tube_OD/2-8]) rotate([0,90,0]) ServoMount(Extend=2);
	
	difference(){
		union(){
			// a section of tube
			intersection(){
				translate([0,-Door_Y/2,0]) rotate([-90,0,0]) 
					Tube(OD=Tube_OD, ID=Tube_OD-Door_t*2, Len=Door_Y, myfn=$preview? 36:360);
				
				RoundRect(X=Door_X, Y=Door_Y, Z=Tube_OD, R=4);
			} // intersection
			
			intersection(){
				translate([0,-Door_Y/2,0]) rotate([-90,0,0]) 
						cylinder(d=Tube_OD-1, h=Door_Y);
				
				// Bolt bosses
				translate([0,CP_Offset_Y,Tube_OD/2-Door_t-BoltBossInset]) 
						rotate([0,0,90]) CablePullerBoltPattern() cylinder(d=8, h=BoltBossInset+3);
					
			} // intersection
		} // union
	
		// CablePuller bolt holes
		translate([0,CP_Offset_Y,Tube_OD/2-Door_t-BoltBossInset]) 
			rotate([0,0,90]) CablePullerBoltPattern() {
				rotate([180,0,0]) Bolt4Hole(depth=BoltBossInset+2); 
				rotate([180,0,0]) cylinder(d=8, h=2);
			}
		
		// Arming slot
		if (HasArmingSlot) translate([0,CP_Offset_Y+ArmLen+CP_SpringBody_YZ,0]) hull(){
			cylinder(d=3, h=Tube_OD/2+1);
			translate([0,20,0]) cylinder(d=3, h=Tube_OD/2+1);
		} // hull
			
		// Door mounting bolts
		CP_DoorBoltPattern(Tube_OD=Tube_OD) Bolt4ClearHole(); //translate([0,0,0.5]) Bolt4ButtonHeadHole();
	} // difference

} // CP_Door

//rotate([90,0,0]) 
//rotate([0,180,0]) CP_Door(Tube_OD=PML98Body_OD, BoltBossInset=3, HasArmingSlot=true);

module ServoMount(Extend=0){
	Servo_X=12;
	Servo_Y=22.6;
	ServoBC_Y=28;
	SM_Y=36;
	MountPlate_h=3;
	
	Extra_X=3.5+Extend;
	
	difference(){
		translate([-Extra_X,-SM_Y/2,0]) cube([Servo_X+Extra_X, SM_Y, MountPlate_h]);
		
		translate([0,-Servo_Y/2,-Overlap]) 
			cube([Servo_X+Overlap, Servo_Y, MountPlate_h+Overlap*2]);
		
		translate([Servo_X/2, -ServoBC_Y/2, MountPlate_h]) Bolt2Hole();
		translate([Servo_X/2, ServoBC_Y/2, MountPlate_h]) Bolt2Hole();
	} // difference
} // ServoMount

//translate([28,-CP_SpringBody_YZ/2-2.5-4,0]) rotate([0,0,-90]) ServoMount();

module StopAdjuster(){
	OA_h=6.5;
	Base_h=2;
	
	difference(){
		union(){
			RoundRect(X=CP_SpringBody_YZ, Y=CP_SpringBody_YZ, Z=Base_h, R=1);
			cylinder(d=8, h=OA_h);
			translate([0,0,OA_h-Base_h]){
				cylinder(d1=8, d2=10, h=1);
				translate([0,0,1-Overlap]) cylinder(d=10, h=Base_h-1+Overlap);
			}
		} // union
		
		translate([0,0,OA_h]) Bolt8Hole();
	} // 
} // StopAdjuster

// translate([ArmLen,CP_SpringBody_YZ/2-1,0]) rotate([-90,0,0]) StopAdjuster();

module AddServo(){
	translate([0,0,CP_SpringBody_YZ/2+2.5]) rotate([180,0,0]) CageTop();
	
	difference(){
		translate([28,-CP_SpringBody_YZ/2-2.5-4,0]) rotate([0,0,-90]) ServoMount();
		
		translate([ArmLen,-CP_SpringBody_YZ/2-1,CP_SpringBody_YZ/2+2.5]) 
			rotate([90,0,0]) cylinder(d=11, h=5.5);
	} // difference
} // AddServo

//AddServo();

module CablePullerBoltPattern(){
	Bolt_X1=-2;
	Cage_YZ=CP_SpringBody_YZ+5;
	Cage_PX=ArmLen+CP_Bearing_OD*1.5+CP_Spring_CBL+CableEnd_h+4+4;
	BoltOffset=2;
	
	CP_Bolt_CL=(Cage_PX-4)-Bolt_X1;
	echo(CP_Bolt_CL=CP_Bolt_CL);
	
	translate([Cage_PX-4,-Cage_YZ/2-BoltOffset,0]) children();
	translate([Cage_PX-4,Cage_YZ/2+BoltOffset,0]) children();
	translate([Bolt_X1,-Cage_YZ/2-BoltOffset,0]) children();
	translate([Bolt_X1,Cage_YZ/2+BoltOffset,0]) children();

} // CablePullerBoltPattern

//CablePullerBoltPattern() Bolt4Hole();

module CR_Cage(){
	Bolt_X1=-2;
	Cage_YZ=CP_SpringBody_YZ+5;
	SpB_Hole_YZ=CP_SpringBody_YZ+LooseFit;
	SpB_Bearing_YZ=CP_SpringBody_YZ+IDXtra;
	Cage_PX=ArmLen+CP_Bearing_OD*1.5+CP_Spring_CBL+CableEnd_h+4+4;
	BoltOffset=2;
	TO_a=45;
	
	echo(SpB_Hole_YZ=SpB_Hole_YZ);
	
	module Bolt1(){
		translate([0,0,Cage_YZ/2]){
			Bolt4HeadHole(depth=Cage_YZ/2-3);
			Bolt4Hole(depth=Cage_YZ);
		}
	} // Bolt1
	
	difference(){
		union(){
			hull(){
				cylinder(d=Cage_YZ, h=Cage_YZ, center=true);
				translate([0,-Cage_YZ/2,-Cage_YZ/2]) cube([Cage_PX,Cage_YZ,Cage_YZ]);
				// Adjuster
				translate([0,0,-Cage_YZ/2]) cube([ArmLen+8,Cage_YZ/2+2,Cage_YZ]);
			} // hull
			
			
			
			// Bolts
			translate([Cage_PX-4,0,0])
			hull(){
				translate([0,-Cage_YZ/2-BoltOffset,0]) cylinder(d=8, h=Cage_YZ, center=true);
				translate([0,Cage_YZ/2+BoltOffset,0]) cylinder(d=8, h=Cage_YZ, center=true);
			} // hull
			
			hull(){
				translate([Bolt_X1,-Cage_YZ/2-BoltOffset,0]) cylinder(d=8, h=Cage_YZ, center=true);
				translate([Bolt_X1,Cage_YZ/2+BoltOffset,0]) cylinder(d=8, h=Cage_YZ, center=true);
			} // hull
		} // union
		
		// hole for stop
		translate([ArmLen,Cage_YZ/2+2+Overlap,0]) rotate([90,0,0]) cylinder(d=8+LooseFit, h=4);
		translate([ArmLen,CP_SpringBody_YZ/2,0]) rotate([-90,0,0]) 
			RoundRect(X=CP_SpringBody_YZ+LooseFit, Y=CP_SpringBody_YZ+LooseFit, Z=3.2, R=1+IDXtra);
		
		// Throughout path
		for (j=[0:2:TO_a-2]) rotate([0,0,-j])
		hull(){
			translate([CP_Bearing_OD/2,-3.5,-CP_Bearing_H-1]) cube([Overlap,7,CP_Bearing_H*2+2]);
			translate([ArmLen,0,0]) cylinder(d=CP_Bearing_OD+1, h=CP_Bearing_H+8, center=true);
		
			rotate([0,0,-2]){
			translate([CP_Bearing_OD/2,-3.5,-CP_Bearing_H-1]) cube([Overlap,7,CP_Bearing_H*2+2]);
			translate([ArmLen,0,0]) cylinder(d=CP_Bearing_OD+1, h=CP_Bearing_H+8, center=true);}
		} // hull
		
		// Bolts
		CablePullerBoltPattern() Bolt1();
		
		// cable path
		translate([Cage_PX+1,0,0]) rotate([0,-90,0]) cylinder(d=CableEnd_d+1, h=10);
		
		// Throughout bearing
		cylinder(d=CP_Bearing_OD+6, h=CP_Bearing_H*2+LooseFit, center=true);
		
		// Top/Bottom cutout
		hull(){
			translate([CP_Bearing_OD/2+3,0,0]) cylinder(d=6, h=Cage_YZ+Overlap*2, center=true);
			translate([Cage_PX-8,0,0]) cylinder(d=6, h=Cage_YZ+Overlap*2, center=true);
		} // hull 
		
		// Front/Back cutout
		hull(){
			translate([ArmLen+CP_Bearing_OD*1.5,0,0]) 
				rotate([90,0,0]) cylinder(d=6, h=Cage_YZ+10, center=true);
			translate([Cage_PX-11,0,0]) 
				rotate([90,0,0]) cylinder(d=6, h=Cage_YZ+10, center=true);
		} // hull 
		
		// Hold the end of the spring centered
		translate([CP_Bearing_OD/2+Cage_PX-6-CP_Bearing_OD/2,0,0])
			rotate([0,90,0]) cylinder(d=CP_Spring_OD+IDXtra*2, h=3);
		
		// Body cutout
		difference(){
			translate([CP_Bearing_OD/2,0,0]) 
				rotate([0,90,0]) RoundRect(X=SpB_Hole_YZ, Y=SpB_Hole_YZ, Z=Cage_PX-4-CP_Bearing_OD/2, R=1);
			//translate([CP_Bearing_OD/2+ArmLen+Overlap,0,0]) 
				//rotate([0,90,0]) RoundRect(X=8, Y=SpB_Hole_YZ+Overlap, Z=25-Overlap*2, R=0.5);
			translate([CP_Bearing_OD/2+ArmLen+Overlap,0,0]) 
				rotate([0,90,0]) RoundRect(Y=8, X=SpB_Hole_YZ+Overlap, Z=25-Overlap*2, R=0.5);
		} // difference
		
		translate([CP_Bearing_OD/2+ArmLen,0,0]) 
			rotate([0,90,0]) RoundRect(X=SpB_Bearing_YZ, Y=SpB_Bearing_YZ, Z=25, R=0.5);
		//translate([CP_Bearing_OD/2+ArmLen,0,0]) 
			//rotate([0,90,0]) RoundRect(X=6, Y=SpB_Hole_YZ, Z=25, R=0.1);
		//translate([CP_Bearing_OD/2+ArmLen,0,0]) 
		//	rotate([0,90,0]) RoundRect(X=SpB_Hole_YZ, Y=6, Z=25, R=0.1);
		
		/*
		translate([0,0,Cage_YZ/2]){
			Bolt8ButtonHeadHole(depth=Cage_YZ/2);
			Bolt8Hole(depth=Cage_YZ+1);
		}
		*/
		// dowel pin
		cylinder(d=4+IDXtra, h=Cage_YZ+Overlap*2, center=true);
	} // difference
} // CR_Cage

// bottom only
module CageBottom(){
	difference(){
		CR_Cage();
		translate([-50,-50,0]) cube([150,100,20]);
	} // difference
} // CageBottom

//CageBottom();

// top only
module CageTop(){
	difference(){
		CR_Cage();
		translate([-50,-50,0]) mirror([0,0,1]) cube([150,100,20]);
	} // difference
} // CageTop

//CageTop();

module BellCrankTriggerBearingHolder(){
	// Add to CR_Cage();
	Cage_YZ=CP_SpringBody_YZ+5;
	B_Offset_Y=4.5; // added 0.5mm 10/14/22
	
	module BearingEar(){
		translate([CP_Bearing_OD*1.5+ArmLen,Cage_YZ/2-Overlap,Cage_YZ/2-2]) hull(){
			translate([-CP_Bearing_OD/2-2,0,0]) cube([CP_Bearing_OD+4,Overlap,2]);
			translate([0,CP_Bearing_OD/2+B_Offset_Y,0]) cylinder(d=CP_Bearing_OD, h=2);
		} // hull
	} // BearingEar
	
	difference(){
		union(){
			BearingEar();
			translate([CP_Bearing_OD+ArmLen-2, Cage_YZ/2, Cage_YZ/2-2-CP_Bearing_H-3]) 
				cube([CP_Bearing_OD+4,2,CP_Bearing_H+5]);
			translate([0, 0, -2-CP_Bearing_H-1]) BearingEar();
		} // union
		
		translate([CP_Bearing_OD*1.5+ArmLen, Cage_YZ/2+B_Offset_Y+CP_Bearing_OD/2,
						Cage_YZ/2-CP_Bearing_H-5-Overlap]) 
			cylinder(d=CP_Bearing_ID+IDXtra, h=10);
		
		//translate([CP_Bearing_OD*1.5+ArmLen, Cage_YZ/2+B_Offset_Y+CP_Bearing_OD/2, 
		//		Cage_YZ/2-2-CP_Bearing_H-1]) cylinder(d=CP_Bearing_OD+5, h=CP_Bearing_H+1);
	} // difference
	
	if ($preview) 
		translate([CP_Bearing_OD*1.5+ArmLen, Cage_YZ/2+B_Offset_Y+CP_Bearing_OD/2, Cage_YZ/2-2-CP_Bearing_H/2-0.5])
		Bearing();
	
} // BellCrankTriggerBearingHolder

// translate([0,0,Overlap]) BellCrankTriggerBearingHolder();


module TriggerBellCrank(){
	TriggerArm_Len=12;
	ServoArm_Len=12;
	
	difference(){
		union(){
			cylinder(d=CP_Bearing_OD+4, h=CP_Bearing_H);
			
			hull(){
				translate([-TriggerArm_Len,0,0]) cylinder(d=5, h=CP_Bearing_H);
				translate([0,2,0]) cylinder(d=7, h=CP_Bearing_H);
			} // hull
			translate([-TriggerArm_Len,0,-2]) cylinder(d=5, h=3);
			
			hull(){
				translate([0,ServoArm_Len,0]) cylinder(d=5, h=CP_Bearing_H);
				cylinder(d=7, h=CP_Bearing_H);
			} // hull
		} // union
		
		translate([0,ServoArm_Len,CP_Bearing_H]) Bolt2Hole(); 
		translate([0,0,-Overlap]) cylinder(d=CP_Bearing_OD+IDXtra, h=CP_Bearing_H+Overlap*2);
	} // difference
} // TriggerBellCrank

//translate([CP_Bearing_OD*1.5+ArmLen, 7.5+4+CP_Bearing_OD/2, 7.5-2-CP_Bearing_H/2-1.5])
//TriggerBellCrank();

module CableRetainer(){
	difference(){
		cylinder(d=CP_Spring_OD, h=CableEnd_h+2);
		
		translate([0,0,2-Overlap]) cylinder(d=CableEnd_d+LooseFit, h=CableEnd_h+Overlap*2);
		
		hull(){
			translate([0,0,-Overlap]) cylinder(d=Cable_d+IDXtra*2, h=CR_h+Overlap*2);
			translate([CP_Spring_OD/2+1,0,-Overlap]) cylinder(d=Cable_d+IDXtra*2, h=CR_h+Overlap*2);
		} // hull
		
	} // difference
} // CableRetainer

// CableRetainer();

module BellCrank(Len=38){
	Thickness=6;
	Ball_d=5/16*25.4;
	
	module Ball(){
		hull(){
			sphere(d=Ball_d+IDXtra);
			rotate([-90,0,0]) cylinder(d=Ball_d+IDXtra, h=8);
		} // hull
	}
	
	module CableEndHole(){
		rotate([-90,0,0]) cylinder(d=CableEnd_d+LooseFit, h=8);
	}
	
	module Slot(dd=-10){
		hull(){
			translate([0,-10,Thickness/2]) rotate([-90,0,0]) cylinder(d=Cable_d+IDXtra*2, h=20);
			translate([dd,-10,Thickness/2]) rotate([-90,0,0]) cylinder(d=Cable_d+IDXtra*2, h=20);
		} // hull
	}
	
	difference(){
		hull(){
			translate([-Len/2,0,0]) cylinder(d=9.2, h=Thickness);
			cylinder(d=CP_Bearing_OD+6, h=Thickness);
			translate([Len/2,0,0]) cylinder(d=9.2, h=Thickness);
		} // hull
		
		translate([0,0,-Overlap]) cylinder(d=CP_Bearing_OD+IDXtra, h=Thickness+Overlap*2);
		
		translate([-Len/2,2,Thickness/2]) CableEndHole(); //Ball();
		translate([Len/2,2,Thickness/2]) CableEndHole(); // Ball();
		
		translate([-Len/2,0,0]) Slot(dd=-10);
		translate([Len/2,0,0]) Slot(dd=10);
		
	} // difference
} // BellCrank

//BellCrank(Len=38);

module SpringBody(){

	AO_YZ=CP_SpringBody_YZ;
	Body_L=CP_Spring_CBL+CableEnd_h+1.5;
	ArmingBlock_w=5.5; // fits the 6mm slots
	
	difference(){
		union(){
			// Body
			hull(){
				cylinder(d=CP_Bearing_OD-1, h=AO_YZ, center=true);
				translate([CP_Bearing_OD/2+1,0,0]) 
					rotate([0,90,0]) RoundRect(X=AO_YZ,Y=AO_YZ,Z=Body_L,R=1);
			} // hull
			
			// Arming ears
			hull(){
				translate([CP_Bearing_OD/2+1,-ArmingBlock_w/2,-AO_YZ/2-2.5]) cube([2,ArmingBlock_w,AO_YZ+5]);
				translate([CP_Bearing_OD/2+5,-ArmingBlock_w/2,-AO_YZ/2]) cube([2,ArmingBlock_w,AO_YZ]);
			} // hull
			
			// Arming ears/guide posts
			hull(){
				translate([CP_Bearing_OD/2+Body_L-8,-ArmingBlock_w/2,-AO_YZ/2-2.5]) cube([2,ArmingBlock_w,AO_YZ+5]);
				translate([CP_Bearing_OD/2+Body_L-4,-ArmingBlock_w/2,-AO_YZ/2]) cube([2,ArmingBlock_w,AO_YZ]);
			} // hull
		} // union
		
		// Bearing
		cylinder(d=CP_Bearing_OD+2, h=CP_Bearing_H+IDXtra*3, center=true);
		
		// Spring and retainer
		translate([CP_Bearing_OD/2+1+Body_L+Overlap,0,0]){
			rotate([0,-90,0]) cylinder(d=CP_Spring_OD+LooseFit, h=CP_Spring_CBL+CableEnd_h);
			rotate([0,-90,0]) cylinder(d=CableEnd_d+IDXtra*3, h=CP_Spring_CBL+CableEnd_h+5);
		}
		
		// clearance for adjuster
		translate([5,AO_YZ/2,0]) cube([10,2,4],center=true);
		
		/*
		translate([0,0,AO_YZ/2]){
			Bolt8ClearHole(depth=AO_YZ/2);
			Bolt8Hole(depth=AO_YZ+1);
		}
		*/
		// dowel pin
		cylinder(d=4+IDXtra, h=AO_YZ+Overlap*2, center=true);
	} // difference
} // SpringBody

//translate([ArmLen+CP_Bearing_OD,0,0]) SpringBody();
//translate([ArmLen+CP_Bearing_OD,0,0]) Bearing();

module Dowel(Len=8){
	cylinder(d=CP_Bearing_ID, h=Len, center=true);
} // Dowel

//Dowel(Len=8);

module ThroughOut(){
	
	
	difference(){
		union(){
			cylinder(d=CP_Bearing_OD+4, h=CP_Bearing_H*2, center=true);
			translate([0,-3,-CP_Bearing_H/2]) cube([ArmLen,6,CP_Bearing_H]);
			hull(){
				translate([ArmLen/3,-3,-CP_Bearing_H]) cube([Overlap,6,CP_Bearing_H*2]);
				translate([ArmLen,0,-CP_Bearing_H/2-3]) cylinder(d=CP_Bearing_OD-1, h=CP_Bearing_H+6);
				translate([ArmLen,CP_Bearing_OD/2-1,-CP_Bearing_H/2-3]) cylinder(d=5, h=CP_Bearing_H+6);
			} // hull
		} // union
		
		cylinder(d=CP_Bearing_OD+IDXtra, h=CP_Bearing_H*2+Overlap*2, center=true);
		translate([ArmLen,0,0]) cylinder(d=CP_Bearing_OD+1, h=CP_Bearing_H+IDXtra*2, center=true);
		
		/*
		translate([ArmLen,0,CP_Bearing_H/2+3]){
			Bolt8ClearHole(depth=4);
			Bolt8Hole(depth=19);
		}
		*/
		
		// dowel pin
		translate([ArmLen,0,0])
		cylinder(d=4+IDXtra, h=CP_Bearing_H+6+Overlap*2, center=true);
	} // difference
} // ThroughOut

// ThroughOut();
//Bearing();
//translate([ArmLen,0,0]) Dowel(Len=CP_Bearing_H+6);
//translate([ArmLen,0,0]) Bearing();












































