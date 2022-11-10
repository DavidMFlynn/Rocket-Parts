// ***********************************
// Project: 3D Printed Rocket
// Filename: SpringThing2.scad
// by David M. Flynn
// Created: 10/17/2022 
// Revision: 0.9.12  11/8/2022
// Units: mm
// ***********************************
//  ***** Notes *****
//
// Built to deploy a parachute from a booster with a spring.
//
//  ***** History *****
// 0.9.12  11/8/2022 More parametric
// 0.9.11  11/5/2022 Aligned all so cable is at 0°
// 0.9.10 10/30/2022 Moved the collar tube stop, FC3
// 0.9.9  10/29/2022 Deeper ball entry on ST_LockRing, reworked drilling jig again
// 0.9.8  10/25/2022 Added ST_SpringMiddle
// 0.9.7  10/25/2022 Added StageCable_a to ST_CableRedirect
// 0.9.6  10/24/2022 Added ST_UpperCenteringRing, small fixes, FC2
// 0.9.5  10/23/2022 Added alignment key, FC1
// 0.9.4  10/22/2022 Added ST_LockBallRetainer, Fixed ST_CableRedirect
// 0.9.3  10/21/2022 Added ST_CableEndAndStop and ST_CableRedirect
// 0.9.2  10/21/2022 Worked on ST_LockRing added ST_BallKeeper()
// 0.9.1  10/18/2022 Added ST_MT_DrillingJig(TubeOD=BT54Body_OD)
// 0.9.0  10/17/2022 Moved to here from Stager.scad.
//
// ***********************************
//  ***** for STL output *****
//
// ST_TubeEnd(Tube_OD=BT54Coupler_OD, Tube_ID=BT54Coupler_ID); // print 2, glued to half section of coupler tube
// ST_SpringGuide(Tube_ID=BT54Body_ID); // Sits on top of motor, glued to bottom of spring. 
// ST_SpringMiddle(Tube_ID=BT54Coupler_OD); // optional double spring slider
// ST_TubeLock(Tube_OD=BT54Coupler_OD, Tube_ID=BT54Coupler_ID); // Glued to top of spring.
//
// ST_BallSpacer(Tube_OD=PML98Body_OD, InnerTube_OD=BT54Body_OD); // print 2, spaces balls in bearing
// ST_BallKeeper(Tube_OD=BT54Body_OD); // ball alignment, glue to tube
// 
// ST_LockRing(InnerTube_OD=BT54Body_OD); 
// ST_DetentOnly(InnerTube_OD=BT54Body_OD);
// mirror([0,1,0]) ST_CableEndAndStop(Tube_OD=PML98Body_OD, InnerTube_OD=BT54Body_OD);
// rotate([180,0,0]) ST_LockBallRetainer(Tube_OD=PML98Body_OD, HasDetent=false);
//
// ST_UpperCenteringRing(Tube_OD=PML98Body_OD, Tube_ID=PML98Coupler_ID, Skirt_ID=PML98Body_ID, InnerTube_OD=BT54Mtr_OD);
// ST_Frame(Tube_OD=PML98Body_OD, Skirt_ID=PML98Body_ID, Collar_Len=20, Skirt_Len=30); // 60mm long
//
// ST_CableRedirect(Tube_OD=PML98Body_OD, Skirt_ID=PML98Body_ID, Tube_ID=PML98Coupler_ID, InnerTube_OD=BT54Mtr_OD);
// ST_BallDetentStopper();
//
// ST_MT_DrillingJig(TubeOD=BT54Body_OD);
//
// ***********************************
//  ***** Routines *****
//
// ST_LockRingOuterRace(); // Make this a part of the body tube.
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
IDXtra=0.2; // Add to ID for tight fit, x2 for loose fit
$fn=$preview? 24:90;


// Deployment Spring big and light
ST_DSpring_OD=44.30;
ST_DSpring_ID=40.50;
ST_DSpring_CBL=22; // coil bound length
ST_DSpring_FL=200; // free length

ST_PreLoadAdj=-0.35;
LooseFit=0.8;

LockBall_d=3/8*25.4;
function DeploymentLockBC_d(InnerTube_OD=BT54Body_OD)=InnerTube_OD+2;

DepLockBearingBall_d=5/16*25.4;
function DepLockRingBC(InnerTube_OD=BT54Body_OD)=InnerTube_OD+DepLockBearingBall_d+20;

Bolt4Inset=4;

module ShowSpringThing(){
	translate([0,0,-110]) color("Tan") ST_SpringGuide();
	
	color("Silver") translate([0,0,-70]) {
		ST_CableRedirect();
		translate([-40,10,-40]) ST_BallDetentStopper();
	}
	
	translate([0,0,-60]) ST_BallKeeper(Tube_OD=BT54Body_OD);
	
	translate([0,0,-30]) {
		rotate([180,0,0]) rotate([0,0,68]) mirror([0,1,0]) ST_CableEndAndStop();
		rotate([180,0,135]) color("Green") ST_LockBallRetainer();
	}
	
	color("Orange") translate([0,0,50]){
		ST_LockRing();
		translate([0,0,-40]) ST_Frame();
		}
	
	color("Green") translate([0,0,45]) {
		ST_BallSpacer();
		translate([0,0,25]) rotate([180,0,0]) ST_BallSpacer();
	}
	translate([0,0,80]) color("Tan") ST_TubeLock();
	
	color("LightBlue") translate([0,0,100]) {
		translate([0,-10,0]) ST_TubeEnd();
		translate([0,10,0]) rotate([0,0,180]) ST_TubeEnd();
	}
} // ShowSpringThing

//ShowSpringThing();

module ST_SpringMiddle(Tube_ID=BT54Coupler_OD){
		
	difference(){
		translate([0,0,-ST_DSpring_CBL-2]) cylinder(d=Tube_ID, h=ST_DSpring_CBL*2+4);
		
		// center hole
		translate([0,0,-ST_DSpring_CBL-2-Overlap]) cylinder(d=Tube_ID-4.4, h=ST_DSpring_CBL*2+4+Overlap*2);
	} // difference
	
	difference(){
		union(){
			translate([0,0,-2]) cylinder(d=ST_DSpring_ID-1, h=ST_DSpring_CBL+2);
			translate([0,0,-2]) cylinder(d=Tube_ID, h=2);
		} // union
		
		// center hole
		translate([0,0,-ST_DSpring_CBL-Overlap]) cylinder(d=35, h=ST_DSpring_CBL*2+Overlap*2);
		
	} // difference
} // ST_SpringMiddle

//ST_SpringMiddle();

module ST_SpringGuide(Tube_ID=BT54Body_ID){
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

module ST_BallKeeper(Tube_OD=BT54Body_OD){
	nBalls=3;
	H=16;
	Wall_t=2;
	
	difference(){
		cylinder(d=Tube_OD+Wall_t*2, h=H);
		
		translate([0,0,-Overlap]) cylinder(d=Tube_OD+IDXtra*2, h=H+Overlap*2);
		
		for (j=[0:nBalls-1]) rotate([0,0,360/nBalls*j]) translate([0,0,H/2])
			rotate([90,0,0]) cylinder(d=LockBall_d+IDXtra*2, h=Tube_OD);
	} // difference
	
} // ST_BallKeeper

//ST_BallKeeper();

module ST_BallDetentBody(){
	DetentBall_d=3/8 * 25.4;
	DetentSpring_d=7.7;
	DetentSpring_Len=14; // Lightly compressed
	Body_d=14;
	Body_Len=27;
	Nose_h=2;
	Protusion=1.5;
	
	difference(){
		union(){
			translate([0,0,Body_Len-Nose_h-Overlap]) cylinder(d1=Body_d, d2=DetentBall_d, h=Nose_h);
			cylinder(d=Body_d, h=Body_Len-Nose_h);
		} // union
		
		hull(){
			translate([0,0,-Overlap]) cylinder(d=DetentBall_d+LooseFit, h=Overlap);
			translate([0,0,Body_Len-DetentBall_d/2+Protusion]) sphere(d=DetentBall_d+LooseFit);
		} // hull
		
		
		if ($preview){
			translate([0,0,-Overlap]) cube([40,40,40]);
			
		}
	} // difference
	
	if ($preview) translate([0,0,Body_Len-DetentBall_d/2+Protusion]) color("Red") sphere(d=DetentBall_d);
} // ST_BallDetentBody

//ST_BallDetentBody();

module ST_BallDetentStopper(){
	DetentBall_d=3/8 * 25.4;
	DetentSpring_d=7.7;
	DetentSpring_Len=14; // Lightly compressed
	Body_d=14;
	Body_Len=27;
	Nose_h=2;
	Protusion=1.5;
	BottomOfSpring_h=3+Body_Len-DetentBall_d/2+Protusion-DetentSpring_Len;
	
	cylinder(d=Body_d-IDXtra*2, h=3);
	
	difference(){
		cylinder(d=DetentBall_d, h=BottomOfSpring_h+2);
		translate([0,0,BottomOfSpring_h]) cylinder(d=DetentSpring_d+IDXtra, h=3);
	} // difference
	
} // ST_BallDetentStopper

//translate([0,0,-3]) ST_BallDetentStopper();

module ST_UpperCenteringRing(Tube_OD=PML98Body_OD, Tube_ID=PML98Coupler_ID, Skirt_ID=PML98Body_ID, InnerTube_OD=BT54Mtr_OD){
	
	Stop_a=-84;
	Key_a=Stop_a+33;
	
	difference(){
		rotate([0,0,22.5]) CenteringRing(OD=Skirt_ID-IDXtra, ID=InnerTube_OD+IDXtra, Thickness=5, nHoles=8);
		
		// Alignment Key
		rotate([0,0,Key_a]) translate([0,Skirt_ID/2,-Overlap]) cylinder(d=5, h=5+Overlap*2);
	} // difference
		
} // ST_UpperCenteringRing

//ST_UpperCenteringRing();

module ST_CableRedirect(Tube_OD=PML98Body_OD, Skirt_ID=PML98Body_ID, 
							Tube_ID=PML98Coupler_ID, 
							InnerTube_OD=BT54Mtr_OD){
								
	BallCircle_d=Tube_OD-6-Ball_d;
	Race_ID=BallCircle_d-Ball_d-Bolt4Inset*4;
	BoltCircle_d=DepLockRingBC(InnerTube_OD=InnerTube_OD)-DepLockBearingBall_d-Bolt4Inset*2;
	CablePath_Y=BoltCircle_d/2; //Race_ID/2+Bolt4Inset; //InnerTube_OD/2+10;
	Exit_a=75;
	Stop_a=-84;
	Key_a=Stop_a+33;
	//echo(Key_a=Key_a);
	
	module CablePath(){
		R=7;
		translate([0,-R,0]) rotate([0,-90,0])			
			rotate([0,0,-0.5]) rotate_extrude(angle=91) translate([R,0,0]) circle(d=6);
			
	} // CablePath
	
	module CableGuide(){
		R=7;
		translate([0,-R,0])
		rotate([0,-90,0])
		difference(){
			rotate_extrude(angle=90) translate([R,0,0]) circle(d=10);
			rotate([0,0,-0.5]) rotate_extrude(angle=91) translate([R,0,0]) circle(d=6);
		} // difference	
	} // CableGuide

	difference(){
		translate([0,CablePath_Y,1]) rotate([0,0,Exit_a]) CableGuide();
		// Trim top
		translate([0,CablePath_Y,11.5]) cylinder(d=20, h=10);
	} // difference

	rotate([0,0,66]) translate([0,BoltCircle_d/2+3,-16.5]) rotate([0,0,100]) ST_BallDetentBody();
	
	difference(){
		union(){
			rotate([0,0,-22.5]) CenteringRing(OD=Skirt_ID-IDXtra, ID=InnerTube_OD+IDXtra, Thickness=5, nHoles=8);
			
			// Locked position stop
			rotate([0,0,Stop_a]) translate([0,CablePath_Y,0]) cylinder(d=8, h=10);
			
			translate([0,0,-20]) {
				rotate([0,0,-22.5]) CenteringRing(OD=Tube_ID-IDXtra, ID=InnerTube_OD+IDXtra, Thickness=5, nHoles=8);
				Tube(OD=InnerTube_OD+4.4, ID=InnerTube_OD+IDXtra*2, Len=21, myfn=$preview? 36:360);
			}
			
			// vertical tube for cable
			translate([0,CablePath_Y,-20]) cylinder(d=10, h=25);
			
		} // union
		
		// Ball Detent
		rotate([0,0,66]) translate([0,BoltCircle_d/2+3,-21]) cylinder(d=14-Overlap, h=30);
		
		// Alignment Key
		rotate([0,0,Key_a]) translate([0,Skirt_ID/2,-Overlap]) cylinder(d=5, h=5+Overlap*2);
		
		translate([0,CablePath_Y,1]) rotate([0,0,Exit_a]) CablePath();
		
		// vertical tube for cable
		translate([0,CablePath_Y,-20-Overlap]) cylinder(d=6, h=25+Overlap*2);
		
	} // difference
	
} // ST_CableRedirect

// ST_CableRedirect();

/*
Sep_Z=29; // 23 down from bearing
BoltCircle_d=DepLockRingBC()-DepLockBearingBall_d-Bolt4Inset*2;


difference(){
	translate([0,0,-10-1.5]) ST_Frame(Tube_OD=PML98Body_OD, Skirt_ID=PML98Body_ID, Collar_Len=20, Skirt_Len=30);
	
	rotate([0,0,-51]) // Key_a
		translate([0,0,-50]) cube([100,100,100]);
}

//
translate([0,0,5.5]) ST_UpperCenteringRing();

//
translate([0,0,-Sep_Z]) ST_CableRedirect();

rotate([0,0,-35]){
ST_LockBallRetainer(Tube_OD=PML98Body_OD, HasDetent=false);
rotate([0,0,-60]) mirror([0,1,0]) translate([0,0,-13]) rotate([180,0,0]) ST_CableEndAndStop();
translate([0,0,-13]) ST_LockRing();
rotate([0,0,-100-120]) translate([0,0,-13]) rotate([180,0,0]) ST_DetentOnly();
}
/**/


module ST_CableEndAndStop(Tube_OD=PML98Body_OD, InnerTube_OD=BT54Body_OD){
	Race_ID=InnerTube_OD+5; 
	BoltCircle_d=DepLockRingBC(InnerTube_OD=InnerTube_OD)-DepLockBearingBall_d-Bolt4Inset*2;
	nBottomBolts=6;
	Plate_H=4;
	Offset_a=10;
	
	module BoltPattern(){
		for (j=[0:1]) rotate([0,0,Offset_a+360/nBottomBolts*j]) 
			translate([0,BoltCircle_d/2,0]) children();
	} // BoltPattern
	
	module StopPattern(){
		for (j=[0:1]) rotate([0,0,Offset_a+180/nBottomBolts*j+90/nBottomBolts]) 
			translate([0,BoltCircle_d/2,0]) children();
	} // BoltPattern
	
	difference(){
		union(){
			hull() {
				BoltPattern() cylinder(d=10, h=Plate_H);
				StopPattern() cylinder(d=10, h=Plate_H);
			} // hull
			
			// Stop
			rotate([0,0,Offset_a+90/nBottomBolts]) 
				translate([0,BoltCircle_d/2,0]) cylinder(d=8, h=10);
			
			// cable anchor
			rotate([0,0,Offset_a+360/nBottomBolts-90/nBottomBolts]) 
				translate([0,BoltCircle_d/2,0]) cylinder(d=8, h=7);
			
			// Manual Set and Trigger lever
			rotate([0,0,Offset_a+180/nBottomBolts]) translate([0,Race_ID/2+Bolt4Inset*2,5])
				cube([6,12,10],center=true);
		} // union
		
		// cable end retension
		rotate([0,0,Offset_a+360/nBottomBolts-90/nBottomBolts]) translate([0,Race_ID/2+Bolt4Inset,0]) {
			rotate([0,90,0]) hull(){ 
				cylinder(d=3.5, h=8); 
				translate([-3,0,0]) cylinder(d=3.5, h=8); 
			} // hull
			
			// cable end insertion hole
			translate([-5.4,0,-Overlap]) cylinder(d=3.6, h=Plate_H+Overlap*2);
			
			hull(){
				translate([Overlap,0,-Overlap]) rotate([0,-90,0]) cylinder(d=1.5, h=6);
				translate([Overlap,0,4.5]) rotate([0,-75,0]) cylinder(d=1.2, h=6);
			} // hull
		}
		
		translate([0,0,-Overlap]) cylinder(d=Race_ID, h=Plate_H+Overlap*2);
		translate([0,0,Plate_H]) BoltPattern() Bolt4ButtonHeadHole();
	} // difference
} // ST_CableEndAndStop

//translate([0,0,13]) mirror([0,1,0]) ST_CableEndAndStop();

module ST_LockRing(InnerTube_OD=BT54Body_OD){
	Race_ID=InnerTube_OD+5; //was DeploymentLockBC_d;
	BallCircle_r=DeploymentLockBC_d(InnerTube_OD=InnerTube_OD)/2;
	Race_W=13;
	nBalls=3;
	nBolts=6;
	BoltCircle_d=DepLockRingBC(InnerTube_OD=InnerTube_OD)-DepLockBearingBall_d-Bolt4Inset*2;
	
	BallLocked_a=6;
	BallUnlocked_a=20;
	BallInsertion_a=22;
	
	difference(){
		OnePieceInnerRace(BallCircle_d=DepLockRingBC(InnerTube_OD=InnerTube_OD), Race_ID=Race_ID, Ball_d=DepLockBearingBall_d, 
						Race_w=Race_W, PreLoadAdj=ST_PreLoadAdj, 
						VOffset=0.00, BI=false, myFn=$preview? 90:720);
		
		// locked
		for (j=[0:nBalls-1]) 
			for (k=[0:BallLocked_a-1])
				hull(){
					rotate([0,0,360/nBalls*j+k]) translate([BallCircle_r, 0, Race_W/2])
						sphere(d=LockBall_d+IDXtra*2, $fn=$preview? 18:36);
					rotate([0,0,360/nBalls*j+k+1]) translate([BallCircle_r, 0, Race_W/2])
						sphere(d=LockBall_d+IDXtra*2, $fn=$preview? 18:36);
				} // hull
			
		// Ramp to locked position		
		for (j=[0:nBalls-1]) 
				hull(){
					rotate([0,0,360/nBalls*j+BallLocked_a]) translate([BallCircle_r, 0, Race_W/2])
						sphere(d=LockBall_d+IDXtra*2, $fn=$preview? 18:36);
					rotate([0,0,360/nBalls*j+BallUnlocked_a]) translate([BallCircle_r+2.5, 0, Race_W/2])
						sphere(d=LockBall_d+IDXtra*2, $fn=$preview? 18:36);
					rotate([0,0,360/nBalls*j+BallUnlocked_a]) translate([BallCircle_r, 0, Race_W/2])
						sphere(d=LockBall_d+IDXtra*2, $fn=$preview? 18:36);
				} // hull
				
		// unlocked	
		for (j=[0:nBalls-1]) 
			for (k=[BallUnlocked_a:BallInsertion_a])
				hull(){
					rotate([0,0,360/nBalls*j+k]) translate([BallCircle_r+2.5, 0, Race_W/2])
						sphere(d=LockBall_d+IDXtra*2, $fn=$preview? 18:36);
					rotate([0,0,360/nBalls*j+k]) translate([BallCircle_r, 0, Race_W/2])
						sphere(d=LockBall_d+IDXtra*2, $fn=$preview? 18:36);
					rotate([0,0,360/nBalls*j+k+1]) translate([BallCircle_r+2.5, 0, Race_W/2])
						sphere(d=LockBall_d+IDXtra*2, $fn=$preview? 18:36);
					rotate([0,0,360/nBalls*j+k+1]) translate([BallCircle_r, 0, Race_W/2])
						sphere(d=LockBall_d+IDXtra*2, $fn=$preview? 18:36);
				} // hull
			
		// Ball insertion	
		for (j=[0:nBalls-1]) 
				hull(){
					rotate([0,0,360/nBalls*j+BallInsertion_a]) translate([BallCircle_r+2.5, 0, Race_W/2])
						sphere(d=LockBall_d+IDXtra*2, $fn=$preview? 18:36);
					rotate([0,0,360/nBalls*j+BallInsertion_a]) translate([BallCircle_r, 0, Race_W/2])
						sphere(d=LockBall_d+IDXtra*2, $fn=$preview? 18:36);
					rotate([0,0,360/nBalls*j+BallInsertion_a]) translate([BallCircle_r+4.0, 0, Race_W+1])
						sphere(d=LockBall_d+IDXtra*2, $fn=$preview? 18:36);
					rotate([0,0,360/nBalls*j+BallInsertion_a]) translate([BallCircle_r, 0, Race_W+1])
						sphere(d=LockBall_d+IDXtra*2, $fn=$preview? 18:36);
				} // hull
				
		
		for (j=[0:nBolts]) rotate([0,0,180/nBolts+10+360/nBolts*j]) 
			translate([BoltCircle_d/2,0,Race_W]) Bolt4Hole(depth=Race_W);
	} // difference
	
	//if ($preview) for (j=[0:nBalls-1]) rotate([0,0,120*j]) translate([BallCircle_r,0,1+LockBall_d/2])
	//	color("Red") sphere(d=LockBall_d);
} // ST_LockRing

//ST_LockRing();

module ST_DetentOnly(InnerTube_OD=BT54Body_OD){
	Race_W=13;
	Race_ID=InnerTube_OD+5; 
	BoltCircle_d=DepLockRingBC(InnerTube_OD=InnerTube_OD)-DepLockBearingBall_d-Bolt4Inset*2;
	nBottomBolts=6;
	Plate_H=4;
	Offset_a=10;
	DetentBall_d=3/8*25.4;
	Detent_a=Offset_a-360/nBottomBolts;
	DetentXtra=1.2;
	
	module BoltPattern(){
		for (j=[3:4]) rotate([0,0,Offset_a+360/nBottomBolts*j]) 
			translate([0,BoltCircle_d/2,0]) children();
	} // BoltPattern
	
	difference(){
		union(){
			hull(){
				BoltPattern() cylinder(d=10, h=Plate_H);
				
				// Ball Detent
				rotate([0,0,Detent_a]) translate([BoltCircle_d/2+3,0,0]) cylinder(d=10, h=Plate_H);
				rotate([0,0,Detent_a+17]) translate([BoltCircle_d/2+3,0,0]) cylinder(d=10, h=Plate_H);
				rotate([0,0,Detent_a-17]) translate([BoltCircle_d/2+3,0,0]) cylinder(d=10, h=Plate_H);
			} // hull
			
			// Ball Detent, raised portion
			hull(){
				rotate([0,0,Detent_a]) translate([BoltCircle_d/2+3,0,0]) cylinder(d=10, h=Plate_H+DetentXtra);
				rotate([0,0,Detent_a+17]) translate([BoltCircle_d/2+3,0,0]) cylinder(d=10, h=Plate_H+DetentXtra);
				rotate([0,0,Detent_a-17]) translate([BoltCircle_d/2+3,0,0]) cylinder(d=10, h=Plate_H+DetentXtra);
			} // hull
				
		} // union
		
		// Ball Detent
		rotate([0,0,Detent_a]) translate([BoltCircle_d/2+3,0,Plate_H+DetentXtra+DetentBall_d/2-1.5])
			sphere(d=DetentBall_d);
		
		translate([0,0,-Race_W/2]) cylinder(d=Race_ID+20, h=LockBall_d+IDXtra*2, center=true);
		translate([0,0,-Race_W-Overlap]) cylinder(d=Race_ID, h=Race_W+DetentXtra+Plate_H+Overlap*2);
		translate([0,0,Plate_H]) BoltPattern() Bolt4ButtonHeadHole();
	} // difference
			
} // ST_DetentOnly

//ST_DetentOnly();

module ST_LockBallRetainer(Tube_OD=PML98Body_OD, InnerTube_OD=BT54Body_OD, HasDetent=true){
	BallCircle_d=Tube_OD-6-Ball_d;
	Race_W=13;
	Race_ID=InnerTube_OD+5; 
	BoltCircle_d=DepLockRingBC(InnerTube_OD=InnerTube_OD)-DepLockBearingBall_d-Bolt4Inset*2;
	nBottomBolts=6;
	Plate_H=4;
	Offset_a=10;
	nBalls=3;
	DetentBall_d=3/8*25.4;
	BallInsertion_a=22;
	Detent_a=Offset_a-360/nBottomBolts;
	DetentXtra=1.2;
	
	module BoltPattern(){
		for (j=[1:4]) rotate([0,0,Offset_a+360/nBottomBolts*j]) 
			translate([0,BoltCircle_d/2,0]) children();
	} // BoltPattern
	
	difference(){
		union(){
			hull(){
				BoltPattern() cylinder(d=10, h=Plate_H);
				
				// Ball Detent
				if (HasDetent){
				rotate([0,0,Detent_a]) translate([BoltCircle_d/2+3,0,0]) cylinder(d=10, h=Plate_H);
				rotate([0,0,Detent_a+17]) translate([BoltCircle_d/2+3,0,0]) cylinder(d=10, h=Plate_H);
				rotate([0,0,Detent_a-17]) translate([BoltCircle_d/2+3,0,0]) cylinder(d=10, h=Plate_H);
				}
				
				for (j=[0:nBalls-1]) 
					rotate([0,0,360/nBalls*j+BallInsertion_a]) translate([DeploymentLockBC_d(InnerTube_OD=InnerTube_OD)/2+2.5, 0, 0])
						cylinder(d=LockBall_d, h=Plate_H);
			} // hull
			
			// Ball Detent, raised portion
			if (HasDetent)
			hull(){
				rotate([0,0,Detent_a]) translate([BoltCircle_d/2+3,0,0]) cylinder(d=10, h=Plate_H+DetentXtra);
				rotate([0,0,Detent_a+17]) translate([BoltCircle_d/2+3,0,0]) cylinder(d=10, h=Plate_H+DetentXtra);
				rotate([0,0,Detent_a-17]) translate([BoltCircle_d/2+3,0,0]) cylinder(d=10, h=Plate_H+DetentXtra);
			} // hull
				
			// Ball insertion	
			for (j=[0:nBalls-1]) rotate([0,0,360/nBalls*j+BallInsertion_a])
				translate([DeploymentLockBC_d(InnerTube_OD=InnerTube_OD)/2+2.5, 0, -3])
						cylinder(d=LockBall_d, h=4);
				
		} // union
		
		// Ball Detent
		if (HasDetent)
		rotate([0,0,Detent_a]) translate([BoltCircle_d/2+3,0,Plate_H+DetentXtra+DetentBall_d/2-1.5])
			sphere(d=DetentBall_d);
		
		translate([0,0,-Race_W/2]) cylinder(d=Race_ID+20, h=LockBall_d+IDXtra*2, center=true);
		translate([0,0,-Race_W-Overlap]) cylinder(d=Race_ID, h=Race_W+DetentXtra+Plate_H+Overlap*2);
		translate([0,0,Plate_H]) BoltPattern() Bolt4ButtonHeadHole();
	} // difference
			
} // ST_LockBallRetainer

//ST_LockBallRetainer();

module ST_BallSpacer(Tube_OD=PML98Body_OD, InnerTube_OD=BT54Body_OD){
	BallCircle_d=DepLockRingBC(InnerTube_OD=InnerTube_OD);
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
} // ST_BallSpacer

//ST_BallSpacer();

module ST_MT_DrillingJig(Tube_OD=PML98Body_OD, Skirt_ID=PML98Body_ID, InnerTubeOD=BT54Body_OD, Skirt_Len=30){
	// Sits on top of CableRedirect in place of Frame
	H=16; // same as the ball keeper
	
	Ball1_a=60;
	Race_W=10;
	
	// Skirt
			translate([0,0,-Skirt_Len]) 
				Tube(OD=Tube_OD, ID=Skirt_ID, Len=Skirt_Len+Overlap*2, myfn=$preview? 36:360);
			
			translate([0,0,-13]) 
				TubeStop(InnerTubeID=Skirt_ID-3, OuterTubeOD=Tube_OD, myfn=$preview? 36:360);
			
			// Alignment key
			intersection(){
				translate([0,Skirt_ID/2,-16]) cylinder(d=4,h=5);
					
				translate([0,0,-18]) cylinder(d=Skirt_ID+1, h=40);
			} // intersection
	
	
	difference(){
		union(){
			translate([0,0,Race_W/2]) cylinder(d=InnerTubeOD+20, h=H, center=true);
			translate([0,0,Race_W/2-H/2]) cylinder(d=Tube_OD, h=4);
			// Alignment key
			translate([0,Tube_OD/2-5,Race_W/2-H/2]) cylinder(d=5, h=5);
		} // union
		
		for (j=[0:2]) rotate([0,0,120*j+Ball1_a]) translate([0,0,Race_W/2])
			rotate([-90,0,0]) cylinder(d=DepLockBearingBall_d-2, h=InnerTubeOD);
		
		translate([0,0,Race_W/2]) cylinder(d=InnerTubeOD+IDXtra*2, h=H+Overlap*2, center=true);
	} // difference
} // ST_MT_DrillingJig

//ST_MT_DrillingJig();

module ST_Frame(Tube_OD=PML98Body_OD, InnerTube_OD=BT54Body_OD, Skirt_ID=PML98Body_ID, Collar_Len=20, Skirt_Len=30){
	
	Race_W=10;
	SkirtTubeStop_Z=-13;
	CollarTubeStop_Z=17; // added 1 11/5/22
	
	Stop_a=-84;
	Key_a=Stop_a+33;
	
	difference(){
		union(){
			// collar
			Tube(OD=Tube_OD, ID=Skirt_ID, Len=Collar_Len+Race_W, myfn=$preview? 36:360);
			translate([0,0,CollarTubeStop_Z]) rotate([180,0,0])
				TubeStop(InnerTubeID=Skirt_ID-3, OuterTubeOD=Tube_OD, myfn=$preview? 36:360);
	
			ST_LockRingOuterRace(Tube_OD=Tube_OD);
			
			// Skirt
			translate([0,0,-Skirt_Len]) 
				Tube(OD=Tube_OD, ID=Skirt_ID, Len=Skirt_Len+Overlap*2, myfn=$preview? 36:360);
			
			translate([0,0,SkirtTubeStop_Z]) 
				TubeStop(InnerTubeID=Skirt_ID-3, OuterTubeOD=Tube_OD, myfn=$preview? 36:360);
			
			// Alignment key
			rotate([0,0,Key_a])
			intersection(){
				union(){
					translate([0,Skirt_ID/2,SkirtTubeStop_Z-5]) cylinder(d=4,h=5);
					translate([0,Skirt_ID/2,SkirtTubeStop_Z-Overlap]) cylinder(d2=3, d1=4, h=2+Overlap);
					
					translate([0,Skirt_ID/2,CollarTubeStop_Z-2]) cylinder(d1=3, d2=4, h=2+Overlap);
					translate([0,Skirt_ID/2,CollarTubeStop_Z]) cylinder(d=4,h=5);
				} // union
				
				// don't protrude
				translate([0,0,-18]) cylinder(d=Skirt_ID+1, h=40);
			} // intersection
	
		} // union
		
		// Arm / Trigger access hole
		rotate([0,0,Key_a])
		translate([0,DepLockRingBC(InnerTube_OD=InnerTube_OD)/2-2,-3]) rotate([0,90,0])
			cylinder(d=3, h=Tube_OD, center=true);
		
	} // difference
	
} // ST_Frame

//ST_Frame();

module ST_LockRingOuterRace(Tube_OD=PML98Body_OD, InnerTube_OD=BT54Body_OD){
	Race_W=10;
	
	OnePieceOuterRace(BallCircle_d=DepLockRingBC(InnerTube_OD=InnerTube_OD), Race_OD=Tube_OD-1, 
					Ball_d=DepLockBearingBall_d, Race_w=Race_W, PreLoadAdj=ST_PreLoadAdj, 
					VOffset=0.00, BI=false, myFn=$preview? 90:720);
	
	
} // ST_LockRingOuterRace

//ST_LockRingOuterRace();

module ST_TubeEnd(Tube_OD=BT54Coupler_OD, Tube_ID=BT54Coupler_ID){
	
	difference(){
		union(){
			cylinder(d=Tube_OD,h=2);
			cylinder(d=Tube_ID,h=6);
		} // union
		
		translate([0,0,-Overlap]) cylinder(d=Tube_ID-4, h=6+Overlap*2);
		translate([-Tube_OD/2-1,0,-Overlap]) cube([Tube_OD+2,Tube_OD,6+Overlap*2]);
	} // difference
} // ST_TubeEnd

//ST_TubeEnd();

module ST_TubeLock(Tube_OD=BT54Coupler_OD, Tube_ID=BT54Coupler_ID){
	
	H=LockBall_d+7;
	
	difference(){
		cylinder(d=Tube_OD, h=H);
			
		translate([0,0,-Overlap]) cylinder(d=ST_DSpring_OD, h=4);
		cylinder(d=ST_DSpring_ID, h=H+7);
		translate([0,0,H-5]) cylinder(d1=ST_DSpring_ID, d2=ST_DSpring_ID+7, h=5+Overlap);
		//translate([0,0,5 ]) cylinder(d=ST_DSpring_ID,h=15);
		
		translate([0,0,1+LockBall_d/2]) rotate_extrude()
			translate([DeploymentLockBC_d(InnerTube_OD=Tube_OD)/2,0,0]) circle(d=LockBall_d+IDXtra);
	} // difference
} // ST_TubeLock

//ST_TubeLock();

























