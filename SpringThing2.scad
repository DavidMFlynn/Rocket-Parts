// ***********************************
// Project: 3D Printed Rocket
// Filename: SpringThing2.scad
// by David M. Flynn
// Created: 10/17/2022 
// Revision: 0.9.0  10/17/2022
// Units: mm
// ***********************************
//  ***** Notes *****
// To do:
//  Activator
//  motor tube drilling jig
//  centering ring w/ wire guide
//
// Built to deploy a parachute from a booster with a spring.
//
//  ***** History *****
//
// 0.9.0  10/17/2022 Moved to here from Stager.scad.
//
// ***********************************
//  ***** for STL output *****
//
// ST_SpringGuide(); // Sits on top of motor, glued to bottom of spring. 
// ST_DepLockRing(); // Glued to top of spring.
// ST_DepBallSpacer();
// ST_DeploymentTubeLock();
// ST_DepTubeEnd();
//
// ***********************************
//  ***** Routines *****
//
// ST_DepLockRingOuterRace(); // Make this a part of the body tube.
//
// ***********************************
//  ***** for Viewing *****
//
// ShowSpringThing();
//
// ***********************************

include<TubesLib.scad>
include<CableRelease.scad>
include<BearingLib.scad>
//include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.3; // Add to ID for tight fit, x2 for loose fit
$fn=$preview? 24:90;


// Deployment Spring big and light
ST_DSpring_OD=44.30;
ST_DSpring_ID=40.50;
ST_DSpring_CBL=22; // coil bound length
ST_DSpring_FL=200; // free length

ST_PreLoadAdj=-0.35;
LooseFit=0.8;

LockBall_d=3/8*25.4;
DeploymentLockBC_d=BT54Coupler_OD+5;

DepLockBearingBall_d=5/16*25.4;
DepLockRingBC=BT54Body_OD+DepLockBearingBall_d+20;

module ShowSpringThing(){
	ST_SpringGuide();
	translate([0,0,50]){
		ST_DepLockRing();
		translate([0,0,-20]) ST_DepLockRingOuterRace();
		}
	
	translate([0,0,45]) {
		ST_DepBallSpacer();
		translate([0,0,22]) rotate([180,0,0]) ST_DepBallSpacer();
	}
	translate([0,0,80]) ST_DeploymentTubeLock();
	translate([0,0,100]) {
		translate([0,-10,0]) ST_DepTubeEnd();
		translate([0,10,0]) rotate([0,0,180]) ST_DepTubeEnd();
	}
} // ShowSpringThing

//ShowSpringThing();

module ST_SpringGuide(){
	Tube_ID=BT54Body_ID;
	Tail_Len=22;
	MotorTopDepth=Tail_Len-7;
	
	difference(){
		union(){
			cylinder(d=ST_DSpring_ID-1, h=ST_DSpring_CBL);
			translate([0,0,-Tail_Len+Overlap]) cylinder(d=Tube_ID-IDXtra, h=Tail_Len);
		} // union
		
		translate([0,0,-Tail_Len]) cylinder(d=39, h=MotorTopDepth);
		translate([0,0,-Tail_Len]) cylinder(d=35, h=Tail_Len+ST_DSpring_CBL+Overlap*2);
	} // difference
} // ST_SpringGuide

// ST_SpringGuide();


module ST_DepLockRing(){
	Race_ID=DeploymentLockBC_d;
	Race_W=10;
	
	difference(){
		OnePieceInnerRace(BallCircle_d=DepLockRingBC, Race_ID=Race_ID, Ball_d=DepLockBearingBall_d, 
						Race_w=Race_W, PreLoadAdj=ST_PreLoadAdj, 
						VOffset=0.00, BI=true, myFn=$preview? 90:720);
		
		for (k=[0:8])
			for (j=[0:2]) 
				hull(){
					rotate([0,0,120*j+k]) translate([DeploymentLockBC_d/2,0,1+LockBall_d/2])
						sphere(d=LockBall_d+IDXtra*2, $fn=$preview? 18:90);
					rotate([0,0,120*j+k+1]) translate([DeploymentLockBC_d/2,0,1+LockBall_d/2])
						sphere(d=LockBall_d+IDXtra*2, $fn=$preview? 18:90);
				}
					
		for (j=[0:2]) 
				hull(){
					rotate([0,0,120*j+8]) translate([DeploymentLockBC_d/2,0,1+LockBall_d/2])
						sphere(d=LockBall_d+IDXtra*2, $fn=$preview? 18:90);
					rotate([0,0,120*j+9]) translate([DeploymentLockBC_d/2+2.5,0,1+LockBall_d/2])
						sphere(d=LockBall_d+IDXtra*2, $fn=$preview? 18:90);
				}
				
		for (k=[9:14])
			for (j=[0:2]) 
				hull(){
					rotate([0,0,120*j+k]) translate([DeploymentLockBC_d/2+2.5,0,1+LockBall_d/2])
						sphere(d=LockBall_d+IDXtra*2, $fn=$preview? 18:90);
					rotate([0,0,120*j+k+1]) translate([DeploymentLockBC_d/2+2.5,0,1+LockBall_d/2])
						sphere(d=LockBall_d+IDXtra*2, $fn=$preview? 18:90);
				}
				
		for (j=[0:2]) 
				hull(){
					rotate([0,0,120*j+15]) translate([DeploymentLockBC_d/2+2.5,0,1+LockBall_d/2])
						sphere(d=LockBall_d+IDXtra*2, $fn=$preview? 18:90);
					rotate([0,0,120*j+15]) translate([DeploymentLockBC_d/2+2.5,0,2+LockBall_d])
						sphere(d=LockBall_d+IDXtra*2, $fn=$preview? 18:90);
				}
	} // difference
	
	if ($preview) for (j=[0:2]) rotate([0,0,120*j]) translate([DeploymentLockBC_d/2,0,1+LockBall_d/2])
		color("Red") sphere(d=LockBall_d);
} // ST_DepLockRing

//ST_DepLockRing();

module ST_DepBallSpacer(Tube_OD=102.21){
	BallCircle_d=DepLockRingBC;
	Thickness=1.5;
	nBalls=12;
	
	difference(){
		cylinder(d=BallCircle_d+Ball_d*0.6, h=Ball_d/2+Thickness);
		
		// center hole
		translate([0,0,-Overlap]) cylinder(d=BallCircle_d-Ball_d*0.6, h=Ball_d/2+Thickness+Overlap*2);
		
		for (j=[0:nBalls-1]) rotate([0,0,360/nBalls*j]) translate([BallCircle_d/2,0,Ball_d/2+Thickness])
			sphere(d=Ball_d+LooseFit, $fn=36);
			
		for (j=[0:nBalls/2-1]) rotate([0,0,720/nBalls*j-180/nBalls]){
			translate([BallCircle_d/2,0,0]) rotate([180,0,0]) Bolt2Hole();
			rotate([0,0,360/nBalls]) translate([BallCircle_d/2,0,0]) rotate([180,0,0]) Bolt2HeadHole();
		}
	} // difference
} // ST_DepBallSpacer

//ST_DepBallSpacer();

module ST_DepLockRingOuterRace(Tube_OD=PML98Body_OD){
	Race_W=10;
	
	OnePieceOuterRace(BallCircle_d=DepLockRingBC, Race_OD=Tube_OD-1, 
					Ball_d=DepLockBearingBall_d, Race_w=Race_W, PreLoadAdj=ST_PreLoadAdj, 
					VOffset=0.00, BI=true, myFn=$preview? 90:720);
} // ST_DepLockRingOuterRace

//ST_DepLockRingOuterRace();

module ST_DepTubeEnd(){
	Tube_OD=BT54Coupler_OD;
	Tube_ID=BT54Coupler_ID;
	
	difference(){
		union(){
			cylinder(d=Tube_OD,h=2);
			cylinder(d=Tube_ID,h=6);
		} // union
		
		translate([0,0,-Overlap]) cylinder(d=Tube_ID-4, h=6+Overlap*2);
		translate([-Tube_OD/2-1,0,-Overlap]) cube([Tube_OD+2,Tube_OD,6+Overlap*2]);
	} // difference
} // ST_DepTubeEnd

//ST_DepTubeEnd();

module ST_DeploymentTubeLock(){
	Tube_OD=BT54Coupler_OD;
	Tube_ID=BT54Coupler_ID;
	
	H=LockBall_d+7;
	
	difference(){
			cylinder(d=Tube_OD, h=H);
			
		
		
		translate([0,0,-Overlap]) cylinder(d=ST_DSpring_OD, h=4);
		cylinder(d=ST_DSpring_ID, h=H+7);
		translate([0,0,H-5]) cylinder(d1=ST_DSpring_ID, d2=ST_DSpring_ID+7, h=5+Overlap);
		//translate([0,0,5 ]) cylinder(d=ST_DSpring_ID,h=15);
		
		translate([0,0,1+LockBall_d/2]) rotate_extrude()
			translate([DeploymentLockBC_d/2,0,0]) circle(d=LockBall_d+IDXtra);
	} // difference
} // ST_DeploymentTubeLock

//ST_DeploymentTubeLock();

























