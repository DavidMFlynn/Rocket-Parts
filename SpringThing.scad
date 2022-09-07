// ***********************************
// Project: 3D Printed Rocket
// Filename: SpringThing.scad
// Created: 6/16/2022 
// Revision: 0.9.3  8/6/2022
// Units: mm
// ***********************************
//  ***** History *****
//
// 0.9.3  8/6/2022  Improved Pusher()
// 0.9.2  6/19/2022 Piston is printed for the first time.
// 0.9.1  6/17/2022 ST_Bay ready for test print
// 0.9.0  6/16/2022 First code.
//
// ***********************************
//  ***** for STL output *****
//
// ST_Piston(); // A vented piston to push the pusher and parachute out.
// Pusher(OD=PML98Coupler_OD, ID=PML98Coupler_ID, Len=125); // Pushes the coupler away.
// rotate([180,0,0]) ST_Bay(OD=PML98Coupler_OD, ID=PML98Coupler_ID);
//
// rotate([180,0,0]) NosePusher(OD=PML98Coupler_OD, Len=20);
//
// ***********************************
//  ***** for Viewing *****
//
//
// ***********************************

include<TubesLib.scad>
include<CableRelease.scad>
include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.3; // Add to ID for tight fit, x2 for loose fit
$fn=$preview? 24:90;

SpringLen_CB=110;
SpringLen_Free=285;
Spring_OD=16;
Spring_ID=12;
S_RodCap_d=38.75;
S_Rod_d=11.2;

module ShowSpringThing(){
	ST_Piston(OD=PML98Coupler_OD, ID=PML98Coupler_ID, Len=75);
	translate([0,0,-1]) rotate([180,0,0]) 
		Pusher(OD=PML98Coupler_OD, ID=PML98Coupler_ID, Len=125);
} // ShowSpringThing

//ShowSpringThing();

module TubularNylonSlot(Len=10){
	Slot_L=14;
	Slot_w=4;

	translate([0,0,-Overlap]) hull(){
			translate([-Slot_L/2,0,0]) cylinder(d=Slot_w, h=Len+Overlap*2);
			translate([Slot_L/2,0,0]) cylinder(d=Slot_w, h=Len+Overlap*2);}
} // TubularNylonSlot

module ST_Bay(OD=PML98Coupler_OD, ID=PML98Coupler_ID){
	BP_Thickness=45;
	Len=75;
	CR_Y=-Housing_d/2;
	Spring_Y=8;
	
	Slot_Y=ID/2-10;
	
	Actual_ID=ID-IDXtra*2;
	
	module Hole1(Rot_a=0, Inset=0){
		OuterHole_d=20;
		rotate([0,0,Rot_a])
		hull(){
			translate([Actual_ID/2-OuterHole_d/2-Overlap,0,0]) cylinder(d=OuterHole_d, h=Len-5);
			translate([Actual_ID/2-28+Inset,0,0]) cylinder(d=10, h=Len-5);
		} // hull
	} // Hole1
	
	difference(){
		union(){
			Tube(OD=OD-IDXtra*2, ID=Actual_ID, Len=Len, myfn=$preview? 36:360);
			translate([0,0,Len-BP_Thickness]) cylinder(d=OD-IDXtra*2, h=BP_Thickness);
		} // union
		
		// Cable Release goes here
		translate([0,CR_Y,0]) cylinder(d=Housing_d-1,h=Len+Overlap);
		
		rotate([0,0,0]) translate([25,0,Len]) Bolt6Hole();
		rotate([0,0,180]) translate([25,0,Len]) Bolt6Hole();
		
		Hole1(Rot_a=0, Inset=-5);
		Hole1(Rot_a=45, Inset=0);
		Hole1(Rot_a=90, Inset=4);
		Hole1(Rot_a=135, Inset=2.2);
		Hole1(Rot_a=180, Inset=-5);
		
		// Cone backside
		difference(){
			translate([0,Spring_Y,Len-BP_Thickness-Overlap]) 
				cylinder(d1=Actual_ID+Spring_Y*2, d2=S_Rod_d+8, h=BP_Thickness-6);
			
			difference(){
				translate([0,0,-Overlap*2]) cylinder(d=OD+10,h=Len+Overlap*4);
				translate([0,0,-Overlap*3]) cylinder(d=Actual_ID-Overlap,h=Len+Overlap*6);
			} // difference
			
			translate([0,Spring_Y,Len-BP_Thickness-Overlap*2])
				cylinder(d=S_Rod_d+8, h=BP_Thickness);
		} // difference
		
		// Spring Rod
		translate([0,Spring_Y,0]) cylinder(d=S_Rod_d+1, h=Len+Overlap);
		
		
		translate([0,Slot_Y,0]) TubularNylonSlot(Len=Len);
			
		//cut-away
		//if ($preview==true) translate([0,-50,-50]) cube([50,50,200]);
	} // difference
	
	translate([0,CR_Y,Len-16]) CR_Housing();
	
	// Servo Mounting Posts
	 Servo_a=68;
		difference(){
			translate([0,CR_Y,4]) rotate([0,0,Servo_a]) translate([0,10.5+28+4,0])  hull(){
				cylinder(d=10, h=10);
				rotate([0,0,-45]) translate([-20,0,0]) cylinder(d=16, h=40);
			}
			difference(){
				cylinder(d=OD+40, h=50);
				translate([0,0,-Overlap]) cylinder(d=Actual_ID+1, h=50+Overlap*2);
			} // difference
			translate([0,CR_Y,4]) rotate([0,0,Servo_a]) 
				translate([0,10.5+28+4,0]) rotate([180,0,0]) Bolt6Hole();}
			
		// Servo Mounting Near end
		NearTabXtra=5;
		difference(){
			translate([0,CR_Y,4]) rotate([0,0,Servo_a]) translate([0,10.5-28-4-NearTabXtra,0])  hull(){
				cylinder(d=10, h=10);
				rotate([0,0,45]) translate([-20,0,0]) cylinder(d=16, h=40);
			}
			difference(){
				cylinder(d=OD+40+NearTabXtra*2, h=50);
				translate([0,0,-Overlap]) cylinder(d=Actual_ID+1, h=50+Overlap*2);
			} // difference
			translate([0,CR_Y,4]) rotate([0,0,Servo_a]) 
				translate([0,10.5-28-4-NearTabXtra,0]) rotate([180,0,0]) Bolt6Hole();
			}
} // ST_Bay

//ST_Bay();
//translate([0,-Housing_d/2,0]) rotate([0,0,68]) 
//	translate([0,10.5,0]) color("Green") TopMountSTray();
//translate([0,6,0]) color("Red") cylinder(d=S_Rod_d, h=100);
			
module ST_Piston(OD=PML98Coupler_OD, ID=PML98Coupler_ID, Len=75){
	Slot_L=13;
	Slot_w=3;
	Slot_Y=ID/2-20;
	BP_T=5;
	nVents=6;
	Vent_d=15;
	Vent_X=(ID-IDXtra*2)/2-Vent_d/2-2;
	
	difference(){
		Piston(OD=OD, ID=ID, Len=Len, BP_Thickness=BP_T);
		
		translate([0,Slot_Y,0]) rotate([0,0,90]) TubularNylonSlot(Len=Len);
		
		// Vents
		for (j=[0:nVents-1]) rotate([0,0,360/nVents*j])
			translate([Vent_X,0,-Overlap])
				cylinder(d=Vent_d, h=Len+Overlap*2);
	} // difference
} // ST_Piston();

//ST_Piston();


module NosePusher(OD=PML98Coupler_OD, Len=20){
	// Pushes on the nose code, bolts to the nose cone. 
	FinalOD=OD-IDXtra*2;
	Wall=2.4;
	nTabs=3;
	
	//echo(PML98Coupler_OD=PML98Coupler_OD);
	//echo(FinalOD=FinalOD);
	
	difference(){
		union(){
			cylinder(d=FinalOD, h=4+Overlap, $fn=$preview? 36:360);
			translate([0,0,4]) cylinder(d1=FinalOD, d2=FinalOD-2, h=4, $fn=$preview? 36:360);
			cylinder(d=FinalOD-2, h=Len, $fn=$preview? 36:360);
		} // union
		
		translate([0,0,-Overlap]) cylinder(d=FinalOD-Wall*2, h=3+Overlap*2);
		translate([0,0,3]) cylinder(d1=FinalOD-Wall*2, d2=FinalOD-2-Wall*2, h=4);
		cylinder(d=FinalOD-2-Wall*2, h=Len+Overlap);
		
	} // difference
	
	// Screw tabs
	difference(){
		for (j=[0:nTabs]) rotate([0,0,360/nTabs*j]) hull(){
			translate([FinalOD/2-2-Wall-5,0,Len-7]) cylinder(d=10, h=4);
			translate([FinalOD/2-2,0,Len-7]) cylinder(d=14, h=4);
		}
			
		for (j=[0:nTabs]) rotate([0,0,360/nTabs*j])
			translate([FinalOD/2-2-Wall-5,0,Len-3]) Bolt6ClearHole();
		
		difference(){
			cylinder(d=FinalOD+20, h=Len);
			cylinder(d=FinalOD-2-Overlap, h=Len);
		} // difference
	} // difference
} // NosePusher

// NosePusher();


module LanyardToTube(ID=PML98Coupler_ID){
	LTY_h=30;
	LTY_w=6;
	LTY_y=7;
	Slot_h=10;
	Slot_y=3;
	
	difference(){
		hull(){
			translate([-LTY_w/2,-ID/2-Overlap,-LTY_h/2]) cube([LTY_w,1,LTY_h]);
			translate([-LTY_w/2,-ID/2+LTY_y,-LTY_h/2+LTY_y])
				cube([LTY_w,Overlap,LTY_h-LTY_y*2]);
		} // hull
		
		hull(){
			translate([-LTY_w/2-Overlap,-ID/2,-Slot_h/2-Slot_y]) 
				cube([LTY_w+Overlap*2,1,Slot_h+Slot_y*2]);
			translate([-LTY_w/2-Overlap,-ID/2+LTY_y-3,-Slot_h/2])
				cube([LTY_w+Overlap*2,Overlap,Slot_h]);
		} // hull
		
		difference(){
			translate([0,0,-LTY_h/2-Overlap]) cylinder(d=ID+10, h=LTY_h+Overlap*2);
			translate([0,0,-LTY_h/2-Overlap*2]) cylinder(d=ID+1, h=LTY_h+Overlap*4);
		} // difference
	} // difference
} // LanyardToTube

// LanyardToTube();

module TubeLock(ID=PML98Coupler_ID-IDXtra*2){
	hull(){
		translate([0,-ID/2+IDXtra,0]) rotate([-90,0,0]) cylinder(d=3, h=2);
		translate([-0.6,-ID/2+IDXtra,-3]) cube([0.1,2,6]);
	} // hull
	
	difference(){
		hull(){
			translate([-0.6,-ID/2-Overlap,-3]) cube([0.1,2.3+Overlap,6]);
			difference(){
				translate([0,-ID/2+2.2+Overlap,0]) rotate([-90,0,0]) cylinder(d=3, h=Overlap);
				
				translate([-0.6,-ID/2+2.2-Overlap*2,-3]) cube([3,1,6]);
			} // difference
			translate([-0.6,-ID/2-Overlap,-6]) cube([0.1,Overlap,12]);
			translate([-5,-ID/2-Overlap,0]) rotate([-90,0,0]) cylinder(d=4, h=Overlap);
		} // hull
		
		difference(){
			translate([0,0,-10]) cylinder(d=ID+10, h=20);
			translate([0,0,-10-Overlap]) cylinder(d=ID+Overlap, h=20+Overlap*2);
		} // difference
	} // difference
	
} // TubeLock

//TubeLock();

module LockReceiver(ID=PML98Coupler_ID-IDXtra*2){
	
	
	difference(){
		hull(){
			translate([-0.6,-ID/2-Overlap,-3]) cube([0.1,2.3+Overlap,6]);
			difference(){
				translate([0,-ID/2+2.2+Overlap,0]) rotate([-90,0,0]) cylinder(d=3, h=Overlap);
				
				translate([-0.6,-ID/2+2.2-Overlap*2,-3]) cube([3,1,6]);
			} // difference
			translate([-0.6,-ID/2-Overlap,-6]) cube([0.1,Overlap,12]);
			translate([-5,-ID/2-Overlap,0]) rotate([-90,0,0]) cylinder(d=4, h=Overlap);
		} // hull
		
		difference(){
			translate([0,0,-10]) cylinder(d=ID+10, h=20);
			translate([0,0,-10-Overlap]) cylinder(d=ID+Overlap, h=20+Overlap*2);
		} // difference
		
		mirror([1,0,0]) translate([1,0,0])
		hull(){
			translate([0,-ID/2-Overlap,0]) rotate([-90,0,0]) cylinder(d=3, h=2.4);
			translate([-0.6,-ID/2,-3]) cube([0.1,3,6]);
		} // hull
	} // difference
	
} // LockReceiver

//LockReceiver();

module Pusher(OD=PML98Coupler_OD-IDXtra*3, ID=PML98Coupler_ID, Len=150){
	// The parachute goes here
	
	Lip_Thickness=3;
	
	module LessFriction(){
		difference(){
			translate([0,0,10]) cylinder(d=OD+1, h=Len/2-15);
			
			translate([0,0,10-Overlap]) 
				cylinder(d1=OD+Overlap, d2=OD-1, h=3+Overlap*2, $fn=$preview? 36:360);
			translate([0,0,13]) 
				cylinder(d=OD-1, h=Len/2-15-3, $fn=$preview? 36:360);
			translate([0,0,Len/2-8-Overlap]) 
				cylinder(d1=OD-1, d2=OD+Overlap, h=3+Overlap*2, $fn=$preview? 36:360);
		} // difference
	}
	
	difference(){
		union(){
			Tube(OD=OD, ID=ID, Len=Len, myfn=$preview? 36:360);
			
			// Fat Ends
			cylinder(d=ID+Overlap, h=4);
			translate([0,0,Len-4]) cylinder(d=ID+Overlap, h=4);
		} // union
		
		LessFriction();
		
		translate([0,0,Len/2-5]) LessFriction();
		
		
		// Fat Ends
		translate([0,0,-Overlap]) cylinder(d=OD-Lip_Thickness*2, h=2+Overlap*2);
		translate([0,0,2]) cylinder(d1=OD-Lip_Thickness*2, d2=ID, h=2+Overlap*2);
		translate([0,0,Len-2-Overlap]) cylinder(d=OD-Lip_Thickness*2, h=2+Overlap*2);
		translate([0,0,Len-4-Overlap]) cylinder(d2=OD-Lip_Thickness*2, d1=ID, h=2+Overlap*2);
		
		// Cut in half
		translate([-0.5,-OD/2-1,-Overlap]) cube([100,OD+2,Len+Overlap*2]);
		
		
		
	} // difference
	
	rotate([0,0,-90]) translate([0,0,15]) LanyardToTube(ID=PML98Coupler_ID);
	
	for (j=[0:Len/30-1]){
		translate([0,0,8+j*30]){
			TubeLock(ID=ID);
			mirror([0,1,0]) LockReceiver(ID=ID);
		}
		translate([0,0,23+j*30]){
				LockReceiver(ID=ID);
				mirror([0,1,0]) TubeLock(ID=ID);
		}
	}
} // Pusher

//Pusher(OD=PML98Coupler_OD-IDXtra*3, ID=PML98Coupler_ID-1.2, Len=150);
















