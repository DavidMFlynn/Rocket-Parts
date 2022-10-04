// ***********************************
// Project: 3D Printed Rocket
// Filename: CableRelease.scad
// Created: 6/15/2022 
// Revision: 1.0.0  6/19/2022
// Units: mm
// ***********************************
//  ***** Notes *****
//
// This is a ball lock device. A pin is held in a housing by 5 5/16" Delrin balls.
// Pushing in the bottom releases the pin.  The balls are held captive.
//
// 6/17/2022 Needs some cleanup but is ready for testing.
//
//  ***** History *****
//
echo("CableRelease 1.0.0");
// 1.0.0  6/19/2022 Looser spring hole in locking pin. Ready Testing.
// 0.9.3  6/18/2022 Small fixes.
// 0.9.2  6/17/2022 Fixed LockPlateStop. First working version.
// 0.9.1  6/16/2022 Added BallRetainer, worked on servo stuff.
// 0.9.0  6/15/2022 First code.
//
// ***********************************
//  ***** for STL output *****
//
// rotate([180,0,0]) CR_Housing();
// LockPlate();
// LockingPin();
// BallRetainer();
// LockPlateStop();
//
// TopMountSTray(NearTabXtra=5);
// ServoWheel();
// LockPlateExtension(Len=12);
// ServoWheel(HasLockingBar=true, HasHoles=false);
//
// ***********************************
//  ***** for Viewing *****
//
// ShowCR();
//
// ***********************************

include<LD-20MGServoLib.scad>
include<TubesLib.scad>
include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.3; // Add to ID for tight fit, x2 for loose fit
$fn=$preview? 24:90;

Ball_d=5/16*25.4;
BallCircle_d=14+Ball_d;

Pin_d=BallCircle_d-Ball_d*0.7;
Shoulder_h=20;
Spring_d=5/16*25.4;
Housing_d=BallCircle_d+Ball_d*3;
HousingID_d=Housing_d-6;

module BallGroove(BallCircle_d=BallCircle_d, Ball_d=Ball_d){
	rotate_extrude() translate([BallCircle_d/2,0,0]) circle(d=Ball_d);
} // BallGroove

// BallGroove();

module ShowBalls(BallCircle_d=BallCircle_d, nBalls=8){
	for (j=[0:nBalls-1]) rotate([0,0,360/nBalls*j]) translate([BallCircle_d/2,0,0])
		sphere(d=Ball_d);
} // ShowBalls

//translate([0,0,7]) color("Red") ShowBalls(nBalls=5);

module ShowCR(){
	translate([0,0,-7]) LockingPin();
	translate([0,0,-20]) color("LightBlue") LockPlate();
	color("Tan") CR_Housing();
	
	// Coupler Tube
	Tube(OD=PML98Coupler_OD, ID=PML98Coupler_ID, Len=15, myfn=$preview? 36:360);
} // ShowCR

//ShowCR();

// MG996R Servo
Wheel_d=31.5;
nSWheelBolts=6;
SWheelBC_d=21;
SBoltSpace_x=10;
SBoltSpace_y=49;
Servo_x=20; // Body size
Servo_y=40; // Body size
ServoShaftOffset_y=10.5; // Center of servo to center of output shaft
SWheelOffset_z=14; // Top of wheel to bottom of tray

module TopMountSTray(NearTabXtra=5){
	STray_h=4;
	STray_y=56;
	
	module AntiClimber(){
		AC_w=6;
		AC_h=33;
		difference(){
			hull(){
				translate([-AC_w/2,-ServoShaftOffset_y-12,0]) cube([AC_w,24,STray_h]);
				translate([-AC_w/2,-ServoShaftOffset_y-9,AC_h-0.1]) cube([AC_w,18,0.1]);
			} // hull
			translate([-AC_w/2-Overlap,-ServoShaftOffset_y-5.5,AC_h-11])
				cube([AC_w+Overlap*2,11,11+Overlap]);
		} // difference
	} // AntiClimber
	
	difference(){
		RoundRect(X=Servo_x+10, Y=STray_y, Z=STray_h, R=3);
		//translate([0,0,STray_h/2]) cube([Servo_x+10,Servo_y+20,STray_h],center=true);
		
		translate([0,0,STray_h/2]) 
			cube([Servo_x+IDXtra,Servo_y+IDXtra,STray_h+Overlap*2],center=true);
		
		translate([0,0,STray_h]){
			translate([SBoltSpace_x/2,SBoltSpace_y/2,0]) Bolt2Hole();
			translate([SBoltSpace_x/2,-SBoltSpace_y/2,0]) Bolt2Hole();
			translate([-SBoltSpace_x/2,SBoltSpace_y/2,0]) Bolt2Hole();
			translate([-SBoltSpace_x/2,-SBoltSpace_y/2,0]) Bolt2Hole();
		}
	} // difference
	
	// Anticlimbers
	difference(){
		union(){
			translate([15,0,0]) AntiClimber();
			translate([-15,0,0]) AntiClimber();
		} // union
		translate([0,-ServoShaftOffset_y,10]) cylinder(d=Wheel_d+1, h=30);
	} // difference
	
	// Mounting Ears
	difference(){
		union(){
			hull(){
				translate([0,-STray_y/2-4-NearTabXtra,0]) cylinder(d=12, h=STray_h);
				translate([-10,-STray_y/2,0]) cube([20,1,STray_h]);
			} // hull
			mirror([0,1,0]) hull(){
				translate([0,-STray_y/2-4,0]) cylinder(d=12, h=STray_h);
				translate([-10,-STray_y/2,0]) cube([20,1,STray_h]);
			} // hull
		} // union
		
		translate([0,-STray_y/2-4-NearTabXtra,STray_h]) Bolt6ClearHole();
		translate([0,STray_y/2+4,STray_h]) Bolt6ClearHole();
	} // difference
	
} // TopMountSTray

//TopMountSTray();

module ShowServoWorks(){
	translate([0,ServoShaftOffset_y,-SWheelOffset_z]) TopMountSTray();
	 color("LightBlue") ServoWheel();
	translate([0,0,13.2]) rotate([180,0,0]) 
		color("Tan") ServoWheel(HasLockingBar=true, HasHoles=false);
	
	//*
	translate([0,0,46.4]) color("LightBlue") CR_Housing();
	translate([0,0,13.4+6+6.3]) {
		
		color("Tan") LockPlate();
		translate([0,0,-12]) color("Green") LockPlateExtension(Len=12);
	}
	
	
	translate([0,0,13.4+6]) LockPlateStop();
	/**/
} // ShowServoWorks

//ShowServoWorks();

module Ramp(Wheel_h=3){
	nSteps=50;
	Ramp_h=5;
	Ramp_w=4;
	
	for (j=[0:nSteps-2]){
				hull(){
					rotate([0,0,j]) translate([0,-Wheel_d/2+0.5,0])
						cube([0.01,Ramp_w,Wheel_h+Ramp_h/nSteps*j]);
					rotate([0,0,j+1]) translate([0,-Wheel_d/2+0.5,0])
						cube([0.01,Ramp_w,Wheel_h+Ramp_h/nSteps*(j+1)]);
				} // hull
				hull(){
					rotate([0,0,3+nSteps*2-j]) translate([0,-Wheel_d/2+0.5,0])
						cube([0.01,Ramp_w,Wheel_h+Ramp_h/nSteps*j]);
					rotate([0,0,3+nSteps*2-(j+1)]) translate([0,-Wheel_d/2+0.5,0])
						cube([0.01,Ramp_w,Wheel_h+Ramp_h/nSteps*(j+1)]);
				} // hull
			} // for
			hull(){
				j=nSteps-2;
				rotate([0,0,j+1]) translate([0,-Wheel_d/2+0.5,0])
						cube([0.01,Ramp_w,Wheel_h+Ramp_h/nSteps*(j+1)]);
				rotate([0,0,3+nSteps*2-(j+1)]) translate([0,-Wheel_d/2+0.5,0])
						cube([0.01,Ramp_w,Wheel_h+Ramp_h/nSteps*(j+1)]);
			} // hull
} // Ramp

module ServoWheelBoltPattern(){
	for (j=[0:nSWheelBolts-1]) rotate([0,0,360/nSWheelBolts*j])
			translate([SWheelBC_d/2,0,0]) children();
} // ServoWheelBoltPattern

module RoundRect(X=10, Y=10, Z=4, R=1){
	hull(){
		translate([-X/2+R, -Y/2+R, 0]) cylinder(r=R, h=Z);
		translate([-X/2+R, Y/2-R, 0]) cylinder(r=R, h=Z);
		translate([X/2-R, -Y/2+R, 0]) cylinder(r=R, h=Z);
		translate([X/2-R, Y/2-R, 0]) cylinder(r=R, h=Z);		
	} // hull
} // RoundRect

module ServoWheel(HasLockingBar=false, HasHoles=true){
	Wheel_h=4;
	
	difference(){
		union(){
			cylinder(d=Wheel_d, h=Wheel_h);
			// Ramps
			Ramp(Wheel_h=Wheel_h);
			rotate([0,0,180]) Ramp(Wheel_h=Wheel_h);
			
			if (HasLockingBar==true) RoundRect(X=Wheel_d+8, Y=10, Z=Wheel_h, R=2);
		} // union
		
		// Lightenning hole
		if (HasLockingBar==true) 
			difference(){
				translate([0,0,-Overlap]) 
					cylinder(d=22,h=Wheel_h+Overlap*2);
				for (j=[0:2]) rotate([0,0,120*j]) 
					translate([10,0,-Overlap*2]) cylinder(d=8,h=Wheel_h+Overlap*4);
			} // difference
			
		// Bolt holes
		if (HasLockingBar==true) for (j=[0:2]) rotate([0,0,120*j]) 
			translate([10,0,Wheel_h]) Bolt4Hole();
			
		if (HasHoles==true){
		translate([0,0,-Overlap]) cylinder(d=8,h=Wheel_h+Overlap*2);
		
		translate([0,0,Wheel_h]) ServoWheelBoltPattern() Bolt4Hole();
	}
	} // difference
	
} // ServoWheel

//ServoWheel();
//translate([0,0,11]) rotate([180,0,0]) ServoWheel(HasLockingBar=true, HasHoles=false);

module BallRetainer(){
	// Keep the balls in there. 
	nBalls=5;
	
	difference(){
		cylinder(d=Pin_d+3, h=Ball_d+3, center=true);
		
		cylinder(d=Pin_d+1, h=Ball_d+5, center=true);
		
		for (j=[0:nBalls-1]) rotate([0,0,360/nBalls*j]) translate([BallCircle_d/2,0,0])
		sphere(d=Ball_d+0.6);
	} // difference
	
} // BallRetainer

//BallRetainer();

module LockingPin(){
	
	Cord_d=9;
	Pin_h=42;

	difference(){
		union(){
			cylinder(d=Pin_d, h=Shoulder_h+Overlap);
			hull(){
				translate([0,0,Shoulder_h]) cylinder(d1=Pin_d ,d2=Pin_d+3, h=3);
				translate([0,0,Pin_h-Pin_d/2]) scale([1,1,0.7]) sphere(d=Pin_d+3);
			} // hull
		} // union
		
		// Cord
		translate([0,0,Pin_h-Pin_d/2+12]) rotate([0,90,0]) 
			BallGroove(BallCircle_d=40, Ball_d=Cord_d);
		//	cylinder(d=Cord_d,h=Pin_d+3+Overlap*2,center=true);
		
		// Balls
		translate([0,0,7]) BallGroove(BallCircle_d=BallCircle_d);
		
		// spring
		translate([0,0,-Overlap]) cylinder(d1=Spring_d+1.2,d2=Spring_d+IDXtra*2,h=3);
		translate([0,0,3-Overlap*2]) cylinder(d1=Spring_d+IDXtra*2,d2=0.5,h=2);
	} // difference
	
	if ($preview==true) translate([0,0,7]) color("Red") ShowBalls();
} // LockingPin

//translate([0,0,-7]) LockingPin();

module LockPlateExtension(Len=12){
	Ext_d=28;
	
	difference(){
		cylinder(d=Ext_d,h=Len);
		
		translate([0,0,-Overlap]) cylinder(d=Ext_d-3, h=Len+Overlap*2);
	} // difference
		
	difference(){
		for (j=[0:2]) rotate([0,0,120*j]) translate([10,0,0]) cylinder(d=8, h=Len);
		
		// Bolt holes
		for (j=[0:2]) rotate([0,0,120*j]) translate([10,0,Len]) Bolt4ClearHole();
	} // difference
} // LockPlateExtension

//LockPlateExtension(Len=12);

module LockPlate(){
	LP_h=24;
	
	difference(){
		union(){
			cylinder(d=HousingID_d, h=LP_h-Ball_d);
			cylinder(d=HousingID_d-0.5, h=LP_h);
		} // union
		
		// Ball lock
		translate([0,0,LP_h-Ball_d]) cylinder(d=BallCircle_d+Ball_d+IDXtra*2,h=Ball_d+1);
		
		// Ball Un-Lock
		translate([0,0,LP_h-Ball_d-2]) 
			cylinder(d1=BallCircle_d+Ball_d+Ball_d*0.7,d2=BallCircle_d+Ball_d,h=4+Overlap);
		
		
			translate([0,0,LP_h-Ball_d*2]) 
				cylinder(d=BallCircle_d+Ball_d+Ball_d*0.7,h=Ball_d-2+Overlap);
			
		// Bolt holes
		for (j=[0:2]) rotate([0,0,120*j]) translate([10,0,6]) Bolt4HeadHole();
		
		// Sping
		translate([0,0,4]) cylinder(d=Spring_d+IDXtra, h=LP_h);
		//cut-away
		if ($preview==true) translate([0,-50,-50]) cube([50,50,100]);
	} // difference
} // LockPlate

//translate([0,0,-20]) LockPlate();
//translate([0,0,-14.2]) LockPlate();

module Locks(nLocks=3, OD=HousingID_d, Pin_d=3, Pin_h=2, Lock_a=45){
	Step_a=$preview? 4:1;
	
	for (j=[0:Step_a:Lock_a-2]) 
		for (k=[0:nLocks-1])
			hull(){
				rotate([0,0,360/nLocks*k+j]) translate([0,OD/2,0])
					cylinder(d=Pin_d, h=Pin_h);
				rotate([0,0,360/nLocks*k+j+Step_a]) translate([0,OD/2,0])
					cylinder(d=Pin_d, h=Pin_h);
			} // hull
} // Locks

//Locks();

module LockPlateStop(){
	Thickness=6;
	
	difference(){
		union(){
			cylinder(d=HousingID_d, h=Thickness);
			Locks(nLocks=3, OD=HousingID_d, Pin_d=3, Pin_h=2, Lock_a=25);
		} // union
		
		// Center hole
		translate([0,0,-Overlap]) cylinder(d=30,h=Thickness+Overlap*2);
		
		for (j=[0:1]) rotate([0,0,180*j]) translate([17.5,0,-Overlap])
			cylinder(d=2, h=Thickness+Overlap*2);
		
		//cut-away
		if ($preview==true) translate([0,-50,-50]) cube([50,50,100]);
	} // difference
} // LockPlateStop

//LockPlateStop();

module CR_Housing(){
	Housing_z=16;
	ThreadedBase_d=Housing_d+2;
	
	difference(){
		union(){
			translate([0,0,-Housing_z-4])
				cylinder(d=Housing_d, h=Housing_z+Shoulder_h);
			
			// threaded portion
			translate([0,0,-Housing_z-4-6]){
				cylinder(d=ThreadedBase_d, h=6+Overlap);
				translate([0,0,6]) cylinder(d1=ThreadedBase_d, d2=Housing_d, h=2);
			}
		} // union
		
		// Pin
		cylinder(d=Pin_d+IDXtra*3, h=Housing_z+Overlap*2);
		translate([0,0,Shoulder_h-7]) 
			cylinder(d1=Pin_d+IDXtra*3, d2=Pin_d+IDXtra*3+3, h=3+Overlap);
		
		// Ball Retainer
		cylinder(d=Pin_d+3+IDXtra, h=Ball_d+3, center=true);
			
		
		// Ball stop
		translate([0,0,-Housing_z-4-Overlap+Housing_z+Ball_d/2]) 
			BallGroove(BallCircle_d=BallCircle_d, Ball_d=Ball_d+IDXtra*2);
			//cylinder(d=BallCircle_d+Ball_d,h=Housing_z+4+Ball_d/2);
		
		// Ball Retainer
		difference(){
			translate([0,0,-Housing_z-4-Overlap]) 
				cylinder(d=HousingID_d+IDXtra*3,h=Housing_z+Shoulder_h-6);
			
			translate([0,0,-Housing_z-0.5-Overlap+Housing_z+Ball_d/2]) 
				cylinder(d=BallCircle_d+Ball_d-IDXtra*4, h=Shoulder_h);
		} // difference
		
		// Lock
		translate([0,0,-Housing_z-4-6-Overlap]) 
			cylinder(d=HousingID_d+IDXtra*3, h=6+Overlap*2);
		translate([0,0,-Housing_z-4-2-IDXtra])
			Locks(nLocks=3, OD=HousingID_d, Pin_d=3+IDXtra*2, Pin_h=2+IDXtra*2, Lock_a=50);
		translate([0,0,-Housing_z-4-6-Overlap])
			Locks(nLocks=3, OD=HousingID_d, Pin_d=3+IDXtra*2, Pin_h=6+Overlap*2, Lock_a=28);
		
		//cut-away
		if ($preview==true) translate([0,-50,-50]) cube([50,50,100]);
	} // difference
	
} // CR_Housing

//CR_Housing();
//color("Red") ShowBalls(nBalls=5);









