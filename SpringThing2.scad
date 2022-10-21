// ***********************************
// Project: 3D Printed Rocket
// Filename: SpringThing2.scad
// by David M. Flynn
// Created: 10/17/2022 
// Revision: 0.9.1  10/18/2022
// Units: mm
// ***********************************
//  ***** Notes *****
// To do:
//  Activator
//  centering ring w/ wire guide
//
// Built to deploy a parachute from a booster with a spring.
//
//  ***** History *****
//
// 0.9.1  10/18/2022 Added ST_MT_DrillingJig(TubeOD=BT54Body_OD)
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
// ST_MT_DrillingJig(TubeOD=BT54Body_OD);
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
DeploymentLockBC_d=BT54Body_OD+2;

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

module ST_MT_DrillingJig(TubeOD=BT54Body_OD){
	H=20;
	
	
	difference(){
		cylinder(d=TubeOD+20, h=H);
		
		for (j=[0:2]) rotate([0,0,120*j]) translate([0,0,H/2])
			rotate([90,0,0]) cylinder(d=DepLockBearingBall_d-2, h=TubeOD);
		
		translate([0,0,-Overlap]) cylinder(d=TubeOD+IDXtra*2, h=H+Overlap*2);
	} // difference
} // ST_MT_DrillingJig

//ST_MT_DrillingJig();

module ST_DepLockRing(){
	Race_ID=DeploymentLockBC_d;
	Race_W=10;
	Bolt4Inset=4;
	
	difference(){
		OnePieceInnerRace(BallCircle_d=DepLockRingBC, Race_ID=Race_ID, Ball_d=DepLockBearingBall_d, 
						Race_w=Race_W, PreLoadAdj=ST_PreLoadAdj, 
						VOffset=0.00, BI=true, myFn=$preview? 90:720);
		
		// locked
		for (k=[0:8])
			for (j=[0:2]) 
				hull(){
					rotate([0,0,120*j+k]) translate([DeploymentLockBC_d/2,0,1+LockBall_d/2])
						sphere(d=LockBall_d+IDXtra*2, $fn=$preview? 18:36);
					rotate([0,0,120*j+k+1]) translate([DeploymentLockBC_d/2,0,1+LockBall_d/2])
						sphere(d=LockBall_d+IDXtra*2, $fn=$preview? 18:36);
				} // hull
			
		// Ramp to locked position		
		for (j=[0:2]) 
				hull(){
					rotate([0,0,120*j+8]) translate([DeploymentLockBC_d/2,0,1+LockBall_d/2])
						sphere(d=LockBall_d+IDXtra*2, $fn=$preview? 18:36);
					rotate([0,0,120*j+9]) translate([DeploymentLockBC_d/2+2.5,0,1+LockBall_d/2])
						sphere(d=LockBall_d+IDXtra*2, $fn=$preview? 18:36);
				} // hull
		// unlocked	
		for (k=[9:14])
			for (j=[0:2]) 
				hull(){
					rotate([0,0,120*j+k]) translate([DeploymentLockBC_d/2+2.5,0,1+LockBall_d/2])
						sphere(d=LockBall_d+IDXtra*2, $fn=$preview? 18:36);
					rotate([0,0,120*j+k+1]) translate([DeploymentLockBC_d/2+2.5,0,1+LockBall_d/2])
						sphere(d=LockBall_d+IDXtra*2, $fn=$preview? 18:36);
				} // hull
			
		// Ball insertion	
		for (j=[0:2]) 
				hull(){
					rotate([0,0,120*j+15]) translate([DeploymentLockBC_d/2,0,1+LockBall_d/2])
						sphere(d=LockBall_d+IDXtra*2, $fn=$preview? 18:36);
					rotate([0,0,120*j+15]) translate([DeploymentLockBC_d/2,0,2+LockBall_d])
						sphere(d=LockBall_d+IDXtra*2, $fn=$preview? 18:36);
				} // hull
				
		nBolts=6;
		for (j=[0:nBolts]) rotate([0,0,180/nBolts+10+360/nBolts*j]) 
			translate([Race_ID/2+Bolt4Inset,0,Race_W]) Bolt4Hole();
	} // difference
	
	if ($preview) for (j=[0:2]) rotate([0,0,120*j]) translate([DeploymentLockBC_d/2,0,1+LockBall_d/2])
		color("Red") sphere(d=LockBall_d);
} // ST_DepLockRing

//ST_DepLockRing();

module ST_DepBallSpacer(Tube_OD=PML98Body_OD){
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

module ST_Frame(Tube_OD=PML98Body_OD, Tube_ID=PML98Body_ID, InnerTube_OD=BT54Body_OD){
	
	Tube(OD=Tube_OD, ID=Tube_ID, Len=80, myfn=$preview? 36:360);
	translate([0,0,20]) CenteringRing(OD=Tube_OD-1, ID=InnerTube_OD+IDXtra*2, Thickness=5, nHoles=6);
	//translate([0,0,60]) CenteringRing(OD=Tube_OD-1, ID=InnerTube_OD+IDXtra*2, Thickness=5, nHoles=6);
	
	
	translate([0,0,40]) ST_DepLockRingOuterRace(Tube_OD=Tube_OD);
} // ST_Frame

//ST_Frame();

module ST_DepLockRingOuterRace(Tube_OD=PML98Body_OD, Skirt_ID=PML98Body_ID, Skirt_Len=30){
	Race_W=10;
	
	OnePieceOuterRace(BallCircle_d=DepLockRingBC, Race_OD=Tube_OD-1, 
					Ball_d=DepLockBearingBall_d, Race_w=Race_W, PreLoadAdj=ST_PreLoadAdj, 
					VOffset=0.00, BI=true, myFn=$preview? 90:720);
	
	// collar
	Tube(OD=Tube_OD, ID=Skirt_ID, Len=20, myfn=$preview? 36:360);
	
	if (Skirt_Len>0)
		difference(){
			union(){
				translate([0,0,-Skirt_Len]) 
					Tube(OD=Tube_OD, ID=Skirt_ID, Len=Skirt_Len+Overlap*2, myfn=$preview? 36:360);
				translate([0,0,-13]) 
					TubeStop(InnerTubeID=Skirt_ID-2, OuterTubeOD=Tube_OD, myfn=$preview? 36:360);
			} // union
			
			// Arm / Trigger access hole
			translate([0,DepLockRingBC/2-2,-3]) rotate([0,90,0])
				cylinder(d=3, h=Tube_OD, center=true);
		} // difference
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

























