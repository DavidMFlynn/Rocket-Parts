// ***********************************
// Project: 3D Printed Rocket
// Filename: FairingJointLib.scad
// by David M. Flynn
// Created: 8/5/2022 
// Revision: 0.9.11  2/4/2023
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  A cable released joiner for fairings. 
//
//  ***** History *****
//
echo("FairingJointLib 0.9.11");
// 0.9.11  2/4/2023  removed hard coded number 137, 2 places
// 0.9.10  1/13/2023 Changes tenon inset from 8.5 to Tenon_Y+FairingWall_t
// 0.9.9  1/5/2023   Added BoltOnTenon
// 0.9.8  9/12/2022  Fairing 75 is OK but changes will need to be tested with other sizes.
// 0.9.7  9/9/2022   Finding size for Fairing98
// 0.9.6  9/5/2022   Adjustments for 54mm BT
// 0.9.5  9/3/2022   PJ bug fixes
// 0.9.4  8/28/2022  Moved sample fairing to Fairing.scad, changed to FairingJointLib
// 0.9.1  8/19/2022  Clean-up. 
// 0.9.0  8/5/2022   First code.
//
// ***********************************
//  ***** for STL output *****
//
// Test_PJ();
//
// ***********************************
//  ***** Routines *****
//
// Tenon(Tail=12);
// BoltOnTenon(Tenon_h=Tenon_h);
// SkirtedTenon(Tube_OD=100, Z=15);
// Mortise(Mortise_h=Mortise_h);
//
// Socket(H=12); // includes Mortise
//
// PJ_Clip();
// PJ_CW(Len=30);
// PJ_CCW_Slot(Len=30);
// PJ_CCW(Len=30);
//
// ***********************************
//  ***** for Viewing *****
//
// Test_PJ();
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

JointPin_d=7.92; // 5/16" Delrin Ball

Tenon_h=5;
Tenon_Y=JointPin_d/2-1+2;

//echo(Tenon_Y=Tenon_Y);
Mortise_h=Tenon_h+IDXtra*3;
MortiseOffset=JointPin_d/2+2.5;
//echo(MortiseOffset=MortiseOffset);

module Tenon(Tail=12, Tenon_h=Tenon_h){

	MaxBall_Z=Tenon_h-JointPin_d/3;
	
	translate([0,0,-Tenon_h/2])
	difference(){
		union(){
			hull(){
				translate([-Tail,0,0]) cube([Tail+JointPin_d/2,Tenon_Y,Tenon_h]);
				translate([-Tail,0,0]) cube([Tail+JointPin_d,Tenon_Y/2,Tenon_h]);
			}
			translate([-Tail,0,0]) cube([Tail-2,Tenon_Y+4,Tenon_h]);
		} // union
		
		//translate([0,-1,-Overlap]) cylinder(d=JointPin_d+IDXtra*2,h=Tenon_h+Overlap*2);
		
		translate([0,-1,-Overlap]) cylinder(d=JointPin_d-1,h=Tenon_h+Overlap*2);
		translate([0,-1,-Overlap]) cylinder(d=JointPin_d+IDXtra*2,h=MaxBall_Z+Overlap);
		translate([0,-1,MaxBall_Z]) sphere(d=JointPin_d+IDXtra*2);
		
	} // difference
} // Tenon

//translate([JointPin_d/2+1,0,0]) Tenon(Tail=12, Tenon_h=Tenon_h);

//Tenon(Tail=12, Tenon_h=7);

module BoltOnTenon(Tenon_h=Tenon_h){
	Tail=20;
	Bolt4Inset=4;
	
	translate([0,0,-Tenon_h/2])
	difference(){
		union(){
			hull(){
				translate([-Tail,0,0]) cube([Tail+JointPin_d/2,Tenon_Y,Tenon_h]);
				translate([-Tail,0,0]) cube([Tail+JointPin_d,Tenon_Y/2,Tenon_h]);
			}
			translate([-Tail,0,0]) cube([Tail-2,Tenon_Y+4,Tenon_h]);
		} // union
		
		translate([0,-1,-Overlap]) cylinder(d=JointPin_d+IDXtra*2,h=Tenon_h+Overlap*2);
		
		translate([-JointPin_d/2-Bolt4Inset,0,Tenon_h/2]) 
			rotate([90,0,0]) Bolt4Hole();
		translate([-JointPin_d/2-Bolt4Inset*3,0,Tenon_h/2]) 
			rotate([90,0,0]) Bolt4Hole();
	} // difference
} // BoltOnTenon

// BoltOnTenon(Tenon_h=6);
		
module SkirtedTenon(Tube_OD=100, Z=15){
	TenonInset=Tenon_Y+2.2;
	
	rotate([0,0,180]) translate([-Tube_OD/2+TenonInset,6.5,Z]) 
		rotate([0,0,90]) Tenon(Tail=15);
	
	translate([0,0,Z])
		hull(){
			translate([Tube_OD/2-8.4,0,-Tenon_h/2]) cube([Overlap,10,Tenon_h]);
			translate([Tube_OD/2,0,-12.5]) cube([Overlap,25,25]);
		} // hull
} // SkirtedTenon

//SkirtedTenon(Tube_OD=100, Z=15);

module MortiseBox(Mortise_h=Mortise_h){
	translate([-MortiseOffset,-JointPin_d/2-3.5,-Mortise_h/2]) 
			cube([JointPin_d+9,JointPin_d/2+3.5+Tenon_Y+4.5,Mortise_h]);
} // MortiseBox

//MortiseBox(Mortise_h=12);

module Mortise(Mortise_h=Mortise_h, HasBallStop=false){
	
	translate([0,0,-Mortise_h/2])
	difference(){
		translate([0,0,Mortise_h/2]) MortiseBox(Mortise_h=Mortise_h);
		
		
		hull(){
			translate([-10,-IDXtra,-Overlap]) 
				cube([10+JointPin_d/2+IDXtra*3,Tenon_Y+IDXtra*3,Mortise_h+Overlap*2]);
			translate([-10,-IDXtra,-Overlap]) 
				cube([10+JointPin_d+IDXtra*3,Tenon_Y/2+IDXtra*2,Mortise_h+Overlap*2]);
		} // hull
		
		// Tenon top
		translate([-MortiseOffset-Overlap,0,Mortise_h/2-Tenon_h/2-1])
			cube([MortiseOffset-JointPin_d/2+3.7-1,JointPin_d/2+Tenon_Y+3,Tenon_h+2]);
		
		// Tenon end
		translate([0,-IDXtra*3,-Overlap]) 
				cube([JointPin_d+IDXtra*3,Tenon_Y/2,Mortise_h+Overlap*2]);
		translate([0,-IDXtra*3,Mortise_h/2-Tenon_h/2-IDXtra]) 
				cube([JointPin_d+4,Tenon_Y/2+IDXtra*3,Tenon_h+IDXtra*2]);
		
		
		// Cable path
		translate([0,-1,-Overlap]) cylinder(d=JointPin_d/2+IDXtra*2,h=Mortise_h/2);
		
		// Locking ball
		if (HasBallStop){
			translate([0,0,Mortise_h/2-0.5])
				hull(){
					translate([0,-1,0]) {
						cylinder(d=JointPin_d+IDXtra*3,h=Mortise_h+Overlap*2);
						sphere(d=JointPin_d+IDXtra*3);
					}
					cylinder(d=JointPin_d+IDXtra*2,h=Mortise_h+Overlap*2);
				} // hull
		} else {
			translate([0,0,-Overlap]) hull(){
				translate([0,-1,0]) cylinder(d=JointPin_d+IDXtra*3, h=Mortise_h+Overlap*2);
				cylinder(d=JointPin_d+IDXtra*3, h=Mortise_h+Overlap*2);
			} // hull
		}
	} // difference
} // Mortise

//Mortise(Mortise_h=Mortise_h+6, HasBallStop=false);

module Socket(H=12, HasBallStop=false){
	Wall_T=2;
	Size_Y=17.0;

	Mortise(Mortise_h=H, HasBallStop=HasBallStop);
	
	// tapered receiver
	translate([0,0,-H/2-Wall_T])
	difference(){
		union(){
			hull(){
				translate([-MortiseOffset,-7.5,0]) cube([Overlap,Size_Y,Wall_T+Overlap]);
				translate([JointPin_d/2+6.5,-7.5,0]) cube([Overlap,Size_Y,H/2-Mortise_h/2+Wall_T]);
			} // hull
			
			hull(){
				translate([-MortiseOffset,-7.5,H+Wall_T-Overlap]) 
					cube([Overlap,Size_Y,Wall_T+Overlap]);
				
				translate([JointPin_d/2+6.5,-7.5,H/2+Mortise_h/2+Wall_T-Overlap]) 
					cube([Overlap,Size_Y,H/2-Mortise_h/2+Wall_T+Overlap]);
			} // hull
		} // union
		
		if (HasBallStop){
			translate([0,-1,-Overlap]) cylinder(d=JointPin_d/2+IDXtra*2,h=H+Wall_T*2+Overlap*2);
			translate([0,-1,H/2]) cylinder(d=JointPin_d+IDXtra*3,h=H+Wall_T*2+Overlap*2);
		} else {
			translate([0,-1,-Overlap])  cylinder(d=JointPin_d+IDXtra*3, h=H+Wall_T*2+Overlap*2);
		}
	} // difference
	
	
} // Socket

//Socket();

// **************************************************************************************
//  ***** Passive Joint *****

PJ_Jointer_d=2;
PJ_Clip_L=3;
PJ_Clip_h=5;
PJ_Clip_Body_L=4;

BigFairing_OD=5.5 * 25.4;
SmallFairing_OD=PML54Body_OD;
PJ_Clip_a=6;


module LargeFairing_PJ_Clip_BoltPattern(Fairing_OD=137){
	PJ_Clip_a=BigFairing_OD/Fairing_OD*PJ_Clip_a;

	rotate([0,0,PJ_Clip_a/1.7+PJ_Clip_a*0.2]) translate([Fairing_OD/2,0,0]) rotate([0,90,0]) children();
	rotate([0,0,PJ_Clip_a*1.7+PJ_Clip_a*0.2]) translate([Fairing_OD/2,0,0]) rotate([0,90,0]) children();
		
} // LargeFairing_PJ_Clip_BoltPattern

module LargeFairing_PJ_Clip_Mounting(Fairing_OD=137, FairingWall_t=2.2){
	Fairing_ID=Fairing_OD-FairingWall_t*2;
	PJ_Clip_a=BigFairing_OD/Fairing_OD*PJ_Clip_a;
	
	difference(){
		union(){
			hull(){
				LargeFairing_PJ_Clip_BoltPattern(Fairing_OD=Fairing_OD)
					rotate([0,180,0]) cylinder(d=7+IDXtra*3+2.4, h=6);
			} // hull
			
		} // union
			
		// Trim to Fairing_ID
		translate([0,0,-10])
		difference(){
			cylinder(d=Fairing_ID+10, h=20);
			translate([0,0,-Overlap]) cylinder(d=Fairing_ID+1, h=20+Overlap*2, $fn=$preview? 90:360);
		} // difference
	} // difference
} // LargeFairing_PJ_Clip_Mounting

//LargeFairing_PJ_Clip_Mounting();

module LargeFairing_PJ_Clip_Socket(Fairing_OD=137, FairingWall_t=2.2){
	PJ_Clip_a=BigFairing_OD/Fairing_OD*PJ_Clip_a;
	
	LockTip_X=Fairing_OD/2-FairingWall_t-PJ_Jointer_d/2+1;

	
	
	hull(){
		// Locking surface
		rotate([0,0,-PJ_Clip_a]) translate([LockTip_X,-PJ_Jointer_d,0]){
		
			cylinder(d=PJ_Jointer_d, h=PJ_Clip_h+3, center=true);
			rotate([0,0,PJ_Clip_a])
				translate([-PJ_Jointer_d*2.5,0,0]) 
					cylinder(d=PJ_Jointer_d, h=PJ_Clip_h+3, center=true);
			}
			
		rotate([0,0,-PJ_Clip_a]) translate([LockTip_X,-PJ_Jointer_d*3,0]){
			cylinder(d=PJ_Jointer_d, h=PJ_Clip_h+3, center=true);
			rotate([0,0,PJ_Clip_a])
				translate([-PJ_Jointer_d*5,0,0]) 
					cylinder(d=PJ_Jointer_d, h=PJ_Clip_h+3, center=true);
			}
	} // hull
	Lock_H=0.5;
	difference(){
		translate([Fairing_OD/2-FairingWall_t-Lock_H-2.5-PJ_Jointer_d/2,0,0]) cube([5,20,PJ_Clip_h+3],center=true);
		
		hull(){
			translate([Fairing_OD/2-FairingWall_t-Lock_H-PJ_Jointer_d/2,10,0]) 
				cylinder(d=PJ_Jointer_d, h=PJ_Clip_h+3+Overlap, center=true);
			translate([Fairing_OD/2-FairingWall_t-Lock_H-PJ_Jointer_d/2,-7,0]) 
				cylinder(d=PJ_Jointer_d, h=PJ_Clip_h+3+Overlap, center=true);
		} // hull
	} // difference
} // LargeFairing_PJ_Clip_Socket

//LargeFairing_PJ_Clip_Socket();

module LargeFairing_PJ_Clip_Boss(Fairing_OD=137, FairingWall_t=2.2){
	Fairing_ID=Fairing_OD-FairingWall_t*2;
	PJ_Clip_a=BigFairing_OD/Fairing_OD*PJ_Clip_a;
	
	difference(){
		union(){
			hull(){
				LargeFairing_PJ_Clip_BoltPattern(Fairing_OD=Fairing_OD)
					rotate([0,180,0]) cylinder(d=7+IDXtra*3, h=20);
			} // hull
			scale([1,1,1.1]) PJ_Clip(Fairing_OD=Fairing_OD, FairingWall_t=FairingWall_t);
		} // union
			
		// Trim to Fairing_ID
		translate([0,0,-5])
		difference(){
			cylinder(d=Fairing_ID+10, h=10);
			translate([0,0,-Overlap]) cylinder(d=Fairing_ID, h=10+Overlap*2, $fn=$preview? 90:360);
		} // difference
	} // difference
} // LargeFairing_PJ_Clip_Boss

//LargeFairing_PJ_Clip_Boss(Fairing_OD=137, FairingWall_t=2.2);

module LargeFairing_Tenon_Boss(Fairing_OD=137, FairingWall_t=2.2){
	Fairing_ID=Fairing_OD-FairingWall_t*2;
	PJ_Clip_a=BigFairing_OD/Fairing_OD*PJ_Clip_a;
	H=7;
	TenonInset=Tenon_Y+FairingWall_t;
	//echo(TenonInset=TenonInset);
	
	difference(){
		union(){
			hull(){
				LargeFairing_PJ_Clip_BoltPattern(Fairing_OD=Fairing_OD)
					rotate([0,180,0]) cylinder(d=7+IDXtra*3, h=20);
			} // hull
			rotate([0,0,180]) translate([-Fairing_OD/2+TenonInset,6.5,0]) 
				rotate([0,0,90]) scale([1,1,1.1]) Tenon(Tail=12, Tenon_h=H);
		} // union
			
		// Trim to Fairing_ID
		translate([0,0,-5])
		difference(){
			cylinder(d=Fairing_ID+10, h=10);
			translate([0,0,-Overlap]) 
				cylinder(d=Fairing_ID+IDXtra*2, h=10+Overlap*2, $fn=$preview? 90:360);
		} // difference
	} // difference
} // LargeFairing_Tenon_Boss

//LargeFairing_Tenon_Boss();

module LargeBolt_On_PJ_Clip(Fairing_OD=137, FairingWall_t=2.2){
	// Used to repair a broken clip
	
	Fairing_ID=Fairing_OD-FairingWall_t*2;
	PJ_Clip_a=BigFairing_OD/Fairing_OD*PJ_Clip_a;
	
	difference(){
		union(){
			PJ_Clip(Fairing_OD=Fairing_OD, FairingWall_t=FairingWall_t, Xtra=1);
			
			hull(){
				LargeFairing_PJ_Clip_BoltPattern(Fairing_OD=Fairing_OD)
					rotate([0,180,0]) cylinder(d=7, h=FairingWall_t+9);
				
			} // hull
		} // union
	
		// Bolt holes
		LargeFairing_PJ_Clip_BoltPattern(Fairing_OD=Fairing_OD) Bolt4Hole(depth=20);
		
		// Trim to Fairing_ID
		translate([0,0,-5])
		difference(){
			cylinder(d=Fairing_ID+10, h=10);
			translate([0,0,-Overlap]) 
				cylinder(d=Fairing_ID, h=10+Overlap*2, $fn=$preview? 90:360);
			translate([Fairing_ID/2-5,0,0]) mirror([0,1,0]) cube([20,20,10]);
		} // difference
	} // difference
	
} // LargeBolt_On_PJ_Clip

//LargeBolt_On_PJ_Clip(Fairing_OD=137, FairingWall_t=2.2);

module LargeFairing_BoltOn_Tenon(Fairing_OD=137, FairingWall_t=2.2){
	Fairing_ID=Fairing_OD-FairingWall_t*2;
	PJ_Clip_a=BigFairing_OD/Fairing_OD*PJ_Clip_a;
	
	TenonInset=8;//8.5; // was Tenon_Y+FairingWall_t;
	//echo(TenonInset=TenonInset);
	TenonOffset_Y=5.8; // was 6.5
	H=7;
	
	difference(){
		union(){
			rotate([0,0,180]) translate([-Fairing_OD/2+TenonInset, TenonOffset_Y, 0]) 
				rotate([0,0,90]) Tenon(Tail=15, Tenon_h=H);
				
			hull(){
				LargeFairing_PJ_Clip_BoltPattern(Fairing_OD=Fairing_OD)
					rotate([0,180,0]) cylinder(d=H, h=FairingWall_t+9);
			} // hull
		} // Union
		
		// Bolt holes
		LargeFairing_PJ_Clip_BoltPattern(Fairing_OD=Fairing_OD) Bolt4Hole(depth=20);
		
		// Trim to Fairing_ID
		translate([0,0,-5])
		difference(){
			cylinder(d=Fairing_ID+10, h=10);
			
			translate([0,0,-Overlap]) 
				cylinder(d=Fairing_ID, h=10+Overlap*2, $fn=$preview? 90:360);
					
			translate([Fairing_ID/2-2,-20,-Overlap*2]) cube([30,20,10+Overlap*4]);
		} // difference
		
		// Trim to Fairing_OD
		translate([0,0,-5])
		difference(){
			cylinder(d=Fairing_OD+10, h=10);
			translate([0,0,-Overlap]) 
				cylinder(d=Fairing_OD+1, h=10+Overlap*2, $fn=$preview? 90:360);
				// added 1 to get it flush
		} // difference
	} // difference
	
} // LargeFairing_BoltOn_Tenon

//LargeFairing_BoltOn_Tenon();

module Bolt_On_PJ_Clip(Fairing_OD=100, FairingWall_t=2.2){
	// Used to repair a broken clip
	
	Fairing_ID=Fairing_OD-FairingWall_t*2;
	PJ_Clip_a=BigFairing_OD/Fairing_OD*PJ_Clip_a;
	
	difference(){
		union(){
			PJ_Clip(Fairing_OD=Fairing_OD, FairingWall_t=FairingWall_t);
			
			hull(){
				rotate([0,0,PJ_Clip_a*1.7]) translate([Fairing_ID/2-5,0,0]) 
					rotate([0,90,0]) cylinder(d=7, h=6);
				rotate([0,0,PJ_Clip_a/1.7]) translate([Fairing_ID/2-8,0,0]) 
					rotate([0,90,0]) cylinder(d=7, h=8);
			} // hull
		} // union
	
		rotate([0,0,PJ_Clip_a/10]) translate([0,0,-5]) 
			PJ_CW(Fairing_OD=Fairing_OD, FairingWall_T=FairingWall_t, Len=10);
		translate([0,0,-5]) PJ_CCW(Fairing_OD=Fairing_OD, FairingWall_T=FairingWall_t, Len=10);
		
		// Bolt holes
		rotate([0,0,PJ_Clip_a/1.7]) translate([Fairing_ID/2-12,0,0]) rotate([0,-90,0]) Bolt4Hole(depth=20);
		rotate([0,0,PJ_Clip_a*1.7]) translate([Fairing_ID/2-9,0,0]) rotate([0,-90,0]) Bolt4Hole(depth=20);
		
		translate([0,0,-5])
		difference(){
			cylinder(d=Fairing_ID+10, h=10);
			translate([0,0,-Overlap]) cylinder(d=Fairing_ID, h=10+Overlap*2, $fn=$preview? 90:360);
		} // difference
	} // difference
	
} // Bolt_On_PJ_Clip

//Bolt_On_PJ_Clip(Fairing_OD=PML75Body_OD, FairingWall_t=2.2);

module PJ_Clip(Fairing_OD=100, FairingWall_t=2.2, Xtra=0){
	PJ_Clip_a=BigFairing_OD/Fairing_OD*PJ_Clip_a;
	
	// LockXtra=-0.6; // Cheet for Fairing54 -0.4 was still too tight, -0.6 work perfectly

	//LockXtra=-0.3; // Cheet for BigFairing_OD Fairing, -0.3 is Loose but usable, -0.6 was too loose
	
	//
	LockXtra=-0.6; // Cheet for Fairing98 Fairing
	
	//LockXtra=-0.6; // Cheet for Fairing75 Fairing, -0.2 works well just a little cleanup,
		//-0.4 is same trim required
	
	LockTip_X=Fairing_OD/2-FairingWall_t-PJ_Jointer_d/2;
	Back_Face_X=LockTip_X-PJ_Jointer_d*1.5;
	Back_Back_X=LockTip_X-PJ_Jointer_d*2.5;
	
	// Locking end
	hull(){
		// Locking surface
		rotate([0,0,-PJ_Clip_a+LockXtra]) translate([LockTip_X+Xtra,-PJ_Jointer_d,0])
			cylinder(d=PJ_Jointer_d, h=PJ_Clip_h, center=true);
		rotate([0,0,-PJ_Clip_a+LockXtra]) translate([LockTip_X+Xtra-0.2,-PJ_Jointer_d*2,0])
			cylinder(d=PJ_Jointer_d, h=PJ_Clip_h, center=true);
		rotate([0,0,-PJ_Clip_a+LockXtra]) translate([Back_Back_X,-PJ_Jointer_d*2-Xtra,0])
			cylinder(d=PJ_Jointer_d, h=PJ_Clip_h, center=true);
		rotate([0,0,-PJ_Clip_a+LockXtra]) translate([Back_Back_X,-PJ_Jointer_d*2,0])
			cylinder(d=PJ_Jointer_d, h=PJ_Clip_h, center=true);
	} // hull
	
	// Backing
	hull(){
		// Lock end
		rotate([0,0,-PJ_Clip_a+LockXtra]) translate([Back_Back_X,-PJ_Jointer_d*2-Xtra,0])
			cylinder(d=PJ_Jointer_d, h=PJ_Clip_h, center=true);
		rotate([0,0,-PJ_Clip_a+LockXtra]) translate([Back_Face_X,-PJ_Jointer_d*2,0])
			cylinder(d=PJ_Jointer_d, h=PJ_Clip_h, center=true);
		
		// Root end
		rotate([0,0,BigFairing_OD/Fairing_OD*2.8]) translate([Back_Back_X-1,0,0])
			cylinder(d=PJ_Jointer_d, h=PJ_Clip_h, center=true);
		rotate([0,0,BigFairing_OD/Fairing_OD*1.8]) translate([Back_Face_X-1,0,0])
			cylinder(d=PJ_Jointer_d, h=PJ_Clip_h, center=true);
	} // hull
	
	// Root
	hull(){
		rotate([0,0,BigFairing_OD/Fairing_OD*2.8]) translate([Back_Back_X-1,0,0])
			cylinder(d=PJ_Jointer_d, h=PJ_Clip_h, center=true);
		rotate([0,0,BigFairing_OD/Fairing_OD*1.8]) translate([Back_Face_X-1,0,0])
			cylinder(d=PJ_Jointer_d, h=PJ_Clip_h, center=true);
		
		// Root
		rotate([0,0,PJ_Clip_a*1.2]) translate([Fairing_OD/2-PJ_Jointer_d*2,-PJ_Jointer_d,0])
			cylinder(d=PJ_Jointer_d, h=PJ_Clip_h, center=true);
		rotate([0,0,PJ_Clip_a*1.05]) translate([Fairing_OD/2-PJ_Jointer_d*2,-PJ_Jointer_d*2,0])
			cylinder(d=PJ_Jointer_d, h=PJ_Clip_h, center=true);
	} // hull
} // PJ_Clip

//PJ_Clip(Fairing_OD=SmallFairing_OD, Xtra=0);
//rotate([0,0,-0.2]) PJ_CW(Fairing_OD=SmallFairing_OD, FairingWall_T=2.2, Len=10);
//PJ_CCW(Fairing_OD=SmallFairing_OD, FairingWall_T=2.2, Len=10);

//PJ_Clip(Fairing_OD=BigFairing_OD, FairingWall_t=2.2);
//rotate([0,0,-0.2]) PJ_CW(Fairing_OD=BigFairing_OD, FairingWall_T=2.2, Len=10);
//PJ_CCW(Fairing_OD=BigFairing_OD, FairingWall_T=2.2, Len=10);

//PJ_Clip(Fairing_OD=PML75Body_OD, FairingWall_t=2.2);
//rotate([0,0,-0.4]) PJ_CW(Fairing_OD=PML75Body_OD, FairingWall_T=2.2, Len=10);
//PJ_CCW(Fairing_OD=PML75Body_OD, FairingWall_T=2.2, Len=10);

module PJ_CW(Fairing_OD=100, FairingWall_T=2.2, Len=30){
	Clip_L=PJ_Clip_L;
	Clip_a=BigFairing_OD/Fairing_OD*PJ_Clip_a;
	
	for (j=[0:Clip_a-1])
	hull(){
		rotate([0,0,-j]) translate([Fairing_OD/2-FairingWall_T-Clip_L,0,0])
			cube([Clip_L+FairingWall_T-Overlap,Overlap,Len]);
		rotate([0,0,-j-1]) translate([Fairing_OD/2-FairingWall_T-Clip_L,0,0])
			cube([Clip_L+FairingWall_T-Overlap,Overlap,Len]);
	} // hull
	// Fairing half seam
	translate([Fairing_OD/2-PJ_Jointer_d/2-Overlap,0,0]) cylinder(d=PJ_Jointer_d, h=Len);
	translate([Fairing_OD/2-PJ_Jointer_d*2.25-Overlap,0,0]) cylinder(d=PJ_Jointer_d, h=Len);
	
	//Lock lump
	rotate([0,0,-Clip_a]) hull(){
		translate([Fairing_OD/2-PJ_Jointer_d*2.25-Overlap,IDXtra,0]) cylinder(d=PJ_Jointer_d, h=Len);
		translate([Fairing_OD/2-PJ_Jointer_d-Overlap,IDXtra*2,0]) cylinder(d=PJ_Jointer_d, h=Len);
	} // hull
} // PJ_CW

//rotate([0,0,-0.2]) PJ_CW(Fairing_OD=BigFairing_OD, FairingWall_T=2.2, Len=30);

module PJ_CCW_Slot(Fairing_OD=100, Len=30){
	translate([Fairing_OD/2-PJ_Jointer_d/2-Overlap,0,-Overlap]) 
			cylinder(d=PJ_Jointer_d+IDXtra*2, h=Len+Overlap*2);
	translate([Fairing_OD/2-PJ_Jointer_d*2.25-Overlap,0,-Overlap]) 
			cylinder(d=PJ_Jointer_d+IDXtra*2, h=Len+Overlap*2);
} // PJ_CCW_Slot

module PJ_CCW(Fairing_OD=100, FairingWall_T=2.2, Len=30){
	Clip_L=PJ_Clip_L;
	Clip_a=BigFairing_OD/Fairing_OD*PJ_Clip_a;
	
	difference(){
		for (j=[0:Clip_a-1])
		hull(){
			rotate([0,0,j]) translate([Fairing_OD/2-FairingWall_T-Clip_L,-Overlap,0])
				cube([Clip_L+FairingWall_T-Overlap,Overlap,Len]);
			rotate([0,0,j+1]) translate([Fairing_OD/2-FairingWall_T-Clip_L,0-Overlap,])
				cube([Clip_L+FairingWall_T-Overlap,Overlap,Len]);
		} // hull
		
		PJ_CCW_Slot(Fairing_OD=Fairing_OD, Len=Len);
		
	} // difference
	//Lock lump
	rotate([0,0,Clip_a]) hull(){
		translate([Fairing_OD/2-PJ_Jointer_d*2.25-Overlap,-IDXtra,0]) cylinder(d=PJ_Jointer_d, h=Len);
		translate([Fairing_OD/2-PJ_Jointer_d-Overlap,-IDXtra*2,0]) cylinder(d=PJ_Jointer_d, h=Len);
	} // hull
} // PJ_CCW

//PJ_CCW(Fairing_OD=BigFairing_OD, FairingWall_T=2.2, Len=30);

module Test_PJ(){
	// Test the fit of the passive joint
	FairingWall_T=2.2;
	//Fairing_OD=5.5 * 25.4;
	//Fairing_OD=PML98Body_OD;
	Fairing_OD=PML75Body_OD;
	//Fairing_OD=PML54Body_OD;
	Fairing_ID=Fairing_OD-FairingWall_T*2;
	
	//Arc_a=180;
	Arc_a=90;
	
	difference(){
		Tube(OD=Fairing_OD, ID=Fairing_ID, Len=30, myfn=$preview? 36:360);
		
			
		// cut in half
		translate([-Fairing_OD/2-Overlap,-Fairing_OD/2-Overlap,-Overlap])
			cube([Fairing_OD+Overlap*2,Fairing_OD/2+Overlap,30+Overlap*2]);
		if (Arc_a==90)
			translate([-Fairing_OD/2-Overlap,-Overlap,-Overlap])
				cube([Fairing_OD/2+Overlap*2,Fairing_OD/2+Overlap,30+Overlap*2]);
		
		
		PJ_CCW_Slot(Fairing_OD=Fairing_OD, Len=30);
	} // difference
	
	rotate([0,0,Arc_a]) PJ_CW(Fairing_OD=Fairing_OD, Len=30);
	
	translate([0,0,12.5]) rotate([0,0,Arc_a]) 
		rotate([180,0,0]) PJ_Clip(Fairing_OD=Fairing_OD, FairingWall_t=FairingWall_T);
	
	translate([0,0,5]) PJ_Clip(Fairing_OD=Fairing_OD, FairingWall_t=FairingWall_T);
	translate([0,0,20]) PJ_Clip(Fairing_OD=Fairing_OD, FairingWall_t=FairingWall_T);
	PJ_CCW(Fairing_OD=Fairing_OD, Len=30);
} // Test_PJ

// Test_PJ();































