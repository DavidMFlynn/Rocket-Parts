


// This is not working. 





include<CommonStuffSAEmm.scad>

IDXtra=0.2;
$fn=$preview? 24:90;
Overlap=0.05;


Ring_d=130; // Bolt Circle
Ball_d=7.95;
nBalls=2;
Spring_d=8.5;
nSprings=2;
BoltPost_d=8;
nBolts=6;
nLocks=nBolts;
FreeRingThickness=Ball_d;

module RingBase(){
	C=Spring_d+6;
	Base_h=2;
	H=FreeRingThickness+Base_h+1;
	
	module BoltPost(){
		translate([0,Ring_d/2,0])
			cylinder(d=BoltPost_d, h=H);
	} // BoltPost
	
	module BoltPostHole(){
		translate([0,Ring_d/2,H]) Bolt4Hole();
	} // BoltPost
	
	module SpringStop(){
		Stop_a=3;
		
		for (j=[0:Stop_a]) hull(){
			rotate([0,0,j]) translate([0,Ring_d/2-Spring_d/2,0]) 
				cube([Overlap,Spring_d,H]);
				
			rotate([0,0,j+1]) translate([0,Ring_d/2-Spring_d/2,0]) 
				cube([Overlap,Spring_d,H]);
		} // hull
	} // SpringStop
	
	module BallStop(){
		Stop_a=7;
		
		difference(){
			for (j=[0:Stop_a]) hull(){
				rotate([0,0,-j]) translate([0,Ring_d/2,0]) 
					cylinder(d=Ball_d-2, h=H, $fn=24);
				rotate([0,0,-j-1]) translate([0,Ring_d/2,0]) 
					cylinder(d=Ball_d-2, h=H, $fn=24);
			} // hull
			
			rotate([0,0,-Stop_a-1]) translate([0,Ring_d/2,-Overlap])				
				cylinder(d=Ball_d+Overlap*2,h=H+Overlap*2);
		} // difference
	} // BallStop
	
	difference(){
		union(){
			cylinder(d=Ring_d+C, h=Base_h);
			for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) BoltPost();
			for (j=[0:nSprings-1]) rotate([0,0,360/nSprings*j]) SpringStop();
			for (j=[0:nBalls-1]) rotate([0,0,360/nBalls*j+360/nBolts]) BallStop();
		} // union
		
		translate([0,0,-Overlap]) cylinder(d=Ring_d-C, h=H+Overlap*2);
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) BoltPostHole();
		
	} // difference
} // RingBase

translate([0,0,-2.5]) RingBase();

module LockingRing(){
	H=FreeRingThickness;
	C=Spring_d+6;
	RingMotion_a=5;
	
	module Lock(){
		Stop_a=2+RingMotion_a;
		
		translate([0,Ring_d/2,-Overlap])
			cylinder(d=Ball_d+IDXtra*2, h=H+Overlap*2);
		
		for (j=[0:Stop_a]) hull(){
			rotate([0,0,-j]) translate([0,Ring_d/2,-Overlap]) 
				cube([Overlap,Ball_d/2+IDXtra*2,H+Overlap*2]);
				
			rotate([0,0,-j-1]) translate([0,Ring_d/2,-Overlap]) 
				cube([Overlap,Ball_d/2+IDXtra*2,H+Overlap*2]);
		} // hull
	} // Lock
	
	module BallStop(){
		Stop_a=7-RingMotion_a;
		
		for (j=[0:Stop_a]) hull(){
			rotate([0,0,-j]) translate([0,Ring_d/2,-Overlap]) 
				cylinder(d=Ball_d+IDXtra*3, h=H+Overlap*2, $fn=24);
			rotate([0,0,-j-1]) translate([0,Ring_d/2,-Overlap]) 
				cylinder(d=Ball_d+IDXtra*3, h=H+Overlap*2, $fn=24);
		} // hull
	} // BallStop
	
	module SpringStop(){
		Stop_a=18;
		
		for (j=[0:Stop_a]) hull(){
			rotate([0,0,j]) translate([0,Ring_d/2-Spring_d/2-IDXtra,-Overlap]) 
				cube([Overlap,Spring_d+IDXtra*2,H+Overlap*2]);
				
			rotate([0,0,j+1]) translate([0,Ring_d/2-Spring_d/2-IDXtra,-Overlap]) 
				cube([Overlap,Spring_d+IDXtra*2,H+Overlap*2]);
		} // hull
	} // SpringStop
	
	module BoltPostHole(){
		Rot_a=RingMotion_a;
		
		for (j=[0:Rot_a]) hull(){
			rotate([0,0,j]) translate([0,Ring_d/2,-Overlap]) 
				cylinder(d=BoltPost_d+IDXtra*3, h=H+Overlap*2);
			rotate([0,0,j+1]) translate([0,Ring_d/2,-Overlap]) 
				cylinder(d=BoltPost_d+IDXtra*3, h=H+Overlap*2);
		} // hull
	} // BoltPostHole
	
	difference(){
		cylinder(d=Ring_d+C, h=H);
		
		for (j=[0:nBalls-1]) rotate([0,0,360/nBalls*j+360/nBolts]) BallStop();
			
		for (j=[0:nSprings-1]) rotate([0,0,360/nSprings*j]) SpringStop();
			
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) BoltPostHole();
			
		for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j+180/nLocks+RingMotion_a]) Lock();
			
		translate([0,0,-Overlap]) cylinder(d=Ring_d-C, h=H+Overlap*2);
	} // difference
} // LockingRing


//
LockingRing();



















