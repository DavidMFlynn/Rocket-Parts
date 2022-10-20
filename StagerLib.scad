// ***********************************
// Project: 3D Printed Rocket
// Filename: StagerLib.scad
// by David M. Flynn
// Created: 10/10/2022 
// Revision: 0.9.4  10/17/2022
// Units: mm
// ***********************************
//  ***** Notes *****
//
// A work-in-progress. 
// Specifically built for a 4 inch rocket.
// It could be modified to a larger tube, but smaller would be hard. 
//
// A non-pyro active staging or dual deployment system.
// The "cup" is tightly held to the saucer until triggered.
// Minimum tube is about 4 inches. 
//
// My first intended use is a 4 inch up-scale of the Estes Omega. 
// At booster stage burnout: drop away from the sustainer and deploy a parachute.
//
// Bearing MR84-2RS
// Undersize 4mm x 10mm steel dowel, 2ea
// Undersize 4mm x 12mm steel dowel
//
//  ***** History *****
//
echo("StagerLib 0.9.4");
// 0.9.4  10/17/2022   Added CableRedirect(). 
// 0.9.3  10/16/2022   Adapted to booster/sustainer. 
// 0.9.2  10/14/2022   Arming key, added 1.5mm to tube length
// 0.9.1  10/13/2022   Time to print a test article. 
// 0.9.0  10/10/2022   First code.
//
// ***********************************
//  ***** for STL output *****
// 
// rotate([180,0,0]) Stager_Cup(Tube_OD=102.21, ID=78, nLocks=2, BoltsOn=true);
// BearingBlock();
// rotate([-90,0,0]) Stager_LockRod(Adj=0);
// rotate([-90,0,0]) Stager_LockRod(Adj=0.5)
// rotate([-90,0,0]) Stager_LockRod(Adj=1.0);
// Stager_Saucer(Tube_OD=102.21, nLocks=2); // Bolts on
//
// rotate([0,90,0]) Stager_PushUP();
// rotate([0,-90,0]) mirror([1,0,0]) Stager_PushUP();
// Stager_SpringStop();
//
// Stager_Mech(Tube_OD=PML98Body_OD, nLocks=2, Skirt_ID=PML98Body_ID, Skirt_Len=30);
//
// Stager_TriggerPlateB(Tube_OD=PML98Body_OD);
// Stager_InnerRace(Tube_OD=PML98Body_OD, nLocks=2);
// Stager_BallSpacer(Tube_OD=PML98Body_OD);
// CableRedirect(Tube_OD=PML98Body_OD, Skirt_ID=PML98Body_ID, Tube_ID=PML98Coupler_ID, InnerTube_OD=BT54Mtr_OD);
// CableEndAndStop(Tube_OD=PML98Body_OD);
//
//  *** Tools ***
// rotate([-90,0,0]) Stager_ArmingKey(Tube_OD=102.21);
// rotate([-90,0,0]) Stager_ArmingKeyLock();
//
// ***********************************
//  ***** Routines *****
//
// Stager_CupHoles(Tube_OD=102.21, ID=78, nLocks=2, BoltsOn=true);
// Stager_Cup(Tube_OD=102.21, ID=78, nLocks=2);
// 
//
// ***********************************
//  ***** for Viewing *****
//
// ShowStager();
//
// ***********************************

include<CablePuller.scad>
include<TubesLib.scad>
include<BearingLib.scad>
//include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2; // Add to ID for tight fit, x2 for loose fit
$fn=$preview? 24:90;

// Heavy spring
Stager_Spring_OD=5/16*25.4;
Stager_Spring_FL=1.25*25.4;
Stager_Spring_CBL=0.7*25.4;



Stager_LockRod_X=10;
Stager_LockRod_Y=5;
Stager_LockRod_Z=36;
Stager_LockRod_R=1;

LooseFit=0.8;
StagerLockInset_Y=12.5;
StagerLockArmLen=10;

module ShowStager(){
	translate([0,0,Overlap*2]) Stager_Cup(Tube_OD=102.21, ID=78, nLocks=2);
	color("LightBlue") Stager_Saucer();
	translate([0,0,-Overlap*2]) Stager_Mech(Tube_OD=PML98Body_OD, nLocks=2, Skirt_ID=PML98Body_ID, Skirt_Len=20);
	
	translate([0,0,-100]) color("Orange") {
		Stager_TriggerPlateB(Tube_OD=102.21);
		rotate([0,0,180]) Stager_TriggerPlateB(Tube_OD=102.21);
	}
	translate([0,0,-110]) {
		translate([0,0,-10]) Stager_InnerRace(Tube_OD=102.21, nLocks=2);
		translate([0,0,-30]) Stager_BallSpacer(Tube_OD=102.21);
		translate([0,0,0]) rotate([180,0,0]) Stager_BallSpacer(Tube_OD=102.21);
	}
	
	translate([0,0,-160]) CableRedirect(Tube_ID=PML98Coupler_ID, InnerTube_OD=BT54Mtr_OD);
	
	rotate([0,0,18]) translate([0,70,-50]) {
		Stager_ArmingKey(Tube_OD=102.21);
		translate([0,20,0]) Stager_ArmingKeyLock();
	}
} // ShowStager

// ShowStager();

module Stager_ArmingKey(Tube_OD=PML98Body_OD){
	Depth=6.5;
	Handle_Len=15;
	
	difference(){
		translate([0,-3,0]) rotate([-90,0,0]) cylinder(d=20, h=3+Handle_Len);
		
		translate([-3,-5-Overlap,-5.5]) cube([6,30,6.5]);
		translate([0,3,0]) rotate([-90,0,0]) cylinder(d=13, h=15);
		
		// Tube outside
		translate([0,-Tube_OD/2,0]) cylinder(d=Tube_OD, h=21, center=true, $fn=$preview? 90:360);
	} // difference
	
	difference(){
		translate([0,-Depth,2]) rotate([-90,0,0]) cylinder(d=5.5, h=6);
		translate([-3,-Depth-Overlap,-4]) cube([6,30,5]);
	} // difference
} // Stager_ArmingKey

//rotate([-90,0,0]) Stager_ArmingKey();

module Stager_ArmingKeyLock(){
	Depth=5;
	
	translate([0,3.5,0]) rotate([-90,0,0]) cylinder(d=12, h=15);
	translate([-2.75,-Depth,-5.25]) cube([5.5,10,6]);
} // Stager_ArmingKeyLock

//rotate([-90,0,0]) Stager_ArmingKeyLock();

module CableRedirect(Tube_OD=PML98Body_OD, Skirt_ID=PML98Body_ID, Tube_ID=PML98Coupler_ID, InnerTube_OD=BT54Mtr_OD){
	BallCircle_d=Tube_OD-6-Ball_d;
	Race_ID=BallCircle_d-Ball_d-Bolt4Inset*4;
	
	CablePath_Y=Race_ID/2+Bolt4Inset; //InnerTube_OD/2+10;
	Exit_a=75;
	
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

	difference(){
		union(){
			CenteringRing(OD=Skirt_ID, ID=InnerTube_OD+IDXtra*2, Thickness=5, nHoles=0);
			
			// Locked position stop
			rotate([0,0,-69]) translate([0,CablePath_Y,0]) cylinder(d=8, h=10);
			
			translate([0,0,-20]) {
				rotate([0,0,-20]) CenteringRing(OD=Tube_ID, ID=InnerTube_OD+IDXtra*2, Thickness=5, nHoles=5);
				Tube(OD=InnerTube_OD+4.4, ID=InnerTube_OD+IDXtra*2, Len=21, myfn=$preview? 36:360);
			}
			
			// vertical tube
			translate([0,CablePath_Y,-20]) cylinder(d=10, h=25);
		} // union
		
		translate([0,CablePath_Y,1]) rotate([0,0,Exit_a]) CablePath();
		
		// vertical tube
		translate([0,CablePath_Y,-20-Overlap]) cylinder(d=6, h=25+Overlap*2);
		
		
	} // difference
	
} // CableRedirect

//CableRedirect();
/*
Sep_Z=28; // 23 down from bearing
Stager_InnerRace(Tube_OD=102.21, nLocks=2);

rotate([0,0,45]){
translate([0,0,-Sep_Z]) CableRedirect();

rotate([0,0,-67.5]) mirror([0,1,0]) translate([0,0,-12]) rotate([180,0,0]) CableEndAndStop();
}
/**/

module CableEndAndStop(Tube_OD=PML98Body_OD){
	BallCircle_d=Tube_OD-6-Ball_d;
	Race_ID=BallCircle_d-Ball_d-Bolt4Inset*4;
	nBottomBolts=8;
	Plate_H=4;
	
	
	module BoltPattern(){
		for (j=[0:1]) rotate([0,0,360/nBottomBolts*j]) 
			translate([0,Race_ID/2+Bolt4Inset,0]) children();
	} // BoltPattern
	
	module StopPattern(){
		for (j=[0:1]) rotate([0,0,180/nBottomBolts*j+90/nBottomBolts]) 
			translate([0,Race_ID/2+Bolt4Inset,0]) children();
	} // BoltPattern
	
	difference(){
		union(){
			hull() {
				BoltPattern() cylinder(d=10, h=Plate_H);
				StopPattern() cylinder(d=10, h=Plate_H);
			} // hull
			rotate([0,0,90/nBottomBolts]) 
				translate([0,Race_ID/2+Bolt4Inset,0]) cylinder(d=8, h=10);
			
			rotate([0,0,360/nBottomBolts-90/nBottomBolts]) 
				translate([0,Race_ID/2+Bolt4Inset,0]) cylinder(d=8, h=7);
			
			// Manual Set and Trigger lever
			rotate([0,0,180/nBottomBolts]) translate([0,Race_ID/2+Bolt4Inset*2,Plate_H/2])
				cube([6,8,Plate_H],center=true);
		} // union
		
		// cable end retension
		rotate([0,0,360/nBottomBolts-90/nBottomBolts]) translate([0,Race_ID/2+Bolt4Inset,0]) {
			rotate([0,90,0]) hull(){ 
				cylinder(d=3.5, h=7); 
				translate([-3,0,0]) cylinder(d=3.5, h=7); 
			} // hull
			
			hull(){
				translate([Overlap,0,2.5]) rotate([0,-75,0]) cylinder(d=1.5, h=10);
				translate([Overlap,0,4.5]) rotate([0,-75,0]) cylinder(d=1.5, h=10);
			} // hull
		}
		
		translate([0,0,-Overlap]) cylinder(d=Race_ID, h=Plate_H+Overlap*2);
		translate([0,0,Plate_H]) BoltPattern() Bolt4ButtonHeadHole();
	} // difference
} // CableEndAndStop

//CableEndAndStop();

module BearingBlock(){
	//Holds 2 MR84 ball bearings
	Arm_Len=StagerLockArmLen;
	
	difference(){
		hull(){
			cylinder(d=CP_Bearing_OD-1, h=CP_Bearing_H+5, center=true);
			translate([-Arm_Len,0,0]) cylinder(d=CP_Bearing_OD-1, h=CP_Bearing_H+5, center=true);
		} // hull
		
		cylinder(d=CP_Bearing_ID+IDXtra, h=CP_Bearing_H+6, center=true);
		translate([-Arm_Len,0,0]) cylinder(d=CP_Bearing_ID+IDXtra, h=CP_Bearing_H+6, center=true);
	
		
		cylinder(d=CP_Bearing_OD+1.6, h=CP_Bearing_H+1, center=true);
		translate([-Arm_Len,0,0]) cylinder(d=CP_Bearing_OD+1.6, h=CP_Bearing_H+1, center=true);
	} // difference
	
	
} // BearingBlock

//BearingBlock();

module Stager_LockRodBoltPattern(){
	// from bottom center
	LR_Y=Stager_LockRod_Y;
	LR_Z=Stager_LockRod_Z;

	translate([0,-LR_Y/2,LR_Z-5]) rotate([90,0,0]) children();
	translate([0,-LR_Y/2,LR_Z-5-8]) rotate([90,0,0]) children();
	
} // Stager_LockRodBoltPattern

//Stager_LockRodBoltPattern() Bolt6Hole();

module Stager_LockRod(Adj=0){
	LR_X=Stager_LockRod_X;
	LR_Y=Stager_LockRod_Y;
	LR_Z=Stager_LockRod_Z;
	
	difference(){
		RoundRect(X=LR_X, Y=LR_Y, Z=LR_Z+Adj, R=Stager_LockRod_R);
		
		translate([0,0,Adj]) Stager_LockRodBoltPattern() Bolt6ButtonHeadHole();
		
		translate([-CP_Bearing_OD/2-LR_X/2+2, 0, CP_Bearing_OD/2+2])
			rotate([90,0,0]) cylinder(d=CP_Bearing_OD, h=LR_Y+Overlap*2, center=true);
		translate([CP_Bearing_OD/2+LR_X/2-2, 0, CP_Bearing_OD/2+2])
			rotate([90,0,0]) cylinder(d=CP_Bearing_OD, h=LR_Y+Overlap*2, center=true);
	} // difference
	
} // Stager_LockRod

//Stager_LockRod(Adj=1);

module Stager_CupHoles(Tube_OD=PML98Body_OD, ID=78, nLocks=2, BoltsOn=true){
	Collar_h=18;
	nBolts=8;
	
	
	difference(){
		translate([0,0,-Overlap]) cylinder(d=Tube_OD+1, h=Collar_h+Overlap, $fn=$preview? 90:360); // test
		translate([0,0,-Overlap*2]) cylinder(d=ID-IDXtra*2, h=Collar_h+Overlap*4, $fn=$preview? 90:360); 
	} // difference
	
	translate([0,0,-12]) Stager_LockRod_Holes(Tube_OD=Tube_OD, nLocks=nLocks);
	
	// BoltHoles
	if (BoltsOn)
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+180/nBolts]) 
			translate([0,Tube_OD/2-4-Bolt4Inset,Collar_h]) 
				rotate([180,0,0]) Bolt4Hole(depth=12);
} // Stager_CupHoles

//Stager_CupHoles();

module Stager_Cup(Tube_OD=PML98Body_OD, ID=78, nLocks=2, BoltsOn=true){
	Len=3;
	LR_X=Stager_LockRod_X;
	LR_Y=Stager_LockRod_Y;
	LR_Z=Stager_LockRod_Z;
	nBolts=8;
	Collar_h=18;
	
	
	difference(){
		union(){
			difference(){
				translate([0,0,Len-Overlap]) cylinder(d=Tube_OD, h=Collar_h, $fn=$preview? 90:360); // test
				translate([0,0,Len-Overlap*2]) cylinder(d=ID, h=19, $fn=$preview? 90:360); 
			} // difference
			
			cylinder(d=Tube_OD, h=Len, $fn=$preview? 90:360);
			translate([0,0,-2]) cylinder(d1=Tube_OD-8, d2=Tube_OD-4, h=2+Overlap, $fn=$preview? 90:360);
		} // union
		
		// center hole
		translate([0,0,-2-Overlap]) cylinder(d=ID, h=Len+2+Overlap*2, $fn=$preview? 90:360);
		
		// BoltHoles
		if (BoltsOn)
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+180/nBolts]) 
			translate([0,Tube_OD/2-4-Bolt4Inset,Collar_h-6]) 
				rotate([180,0,0]) Bolt4HeadHole(depth=8,lHead=Collar_h);
		
		Stager_LockRod_Holes(Tube_OD=Tube_OD, nLocks=nLocks);
		
		for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]) 
			translate([0,Tube_OD/2-StagerLockInset_Y,-16])
				Stager_LockRodBoltPattern() Bolt6Hole();
		
	} // difference
	
	if ($preview)
		for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]) translate([0, Tube_OD/2-StagerLockInset_Y,-16])
				color("Orange") Stager_LockRod();
} // Stager_Cup

//translate([0,0,Overlap]) Stager_Cup();

module Stager_Bearing(){
	// for viewing only
		rotate([90,0,0]) color("Red") cylinder(d=CP_Bearing_OD, h=CP_Bearing_H, center=true);
} // Stager_Bearing
	
module Stager_SaucerBoltPattern(Tube_OD=PML98Body_OD, ID=70, nLocks=2){
	Inset_Y=7.5;
	Bolt_a=37.5;
	
	for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]) {
		rotate([0,0,Bolt_a]) translate([0,Tube_OD/2-Inset_Y,0]) children();
		rotate([0,0,-Bolt_a]) translate([0,Tube_OD/2-Inset_Y,0]) children();
	}
} // Stager_SaucerBoltPattern

//Stager_SaucerBoltPattern() Bolt4ButtonHeadHole();

module Stager_LockRod_Holes(Tube_OD=PML98Body_OD, nLocks=2){
	LR_X=Stager_LockRod_X;
	LR_Y=Stager_LockRod_Y;
	LR_Z=Stager_LockRod_Z;
	
	Saucer_H=Saucer_Len;
	
	for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]) 
		translate([0,Tube_OD/2-StagerLockInset_Y, -Saucer_H-12-Overlap]){
		
			// BC_LockRod
			RoundRect(X=LR_X+LooseFit, Y=LR_Y+LooseFit, Z=LR_Z+12, R=1+LooseFit/2);
		
			// Spring
			translate([0,0,-Stager_Spring_CBL]) cylinder(d=Stager_Spring_OD+LooseFit, h=Stager_Spring_FL);
	}
} // Stager_LockRod_Holes
	
module Stager_Saucer(Tube_OD=PML98Body_OD, nLocks=2){
	Len=Saucer_Len;
	ID=Tube_OD-StagerLockInset_Y*2-Stager_LockRod_Y-4;
	LR_X=Stager_LockRod_X;
	LR_Y=Stager_LockRod_Y;
	LR_Z=Stager_LockRod_Z;
	
	Saucer_IDXtra=IDXtra*3;
	
	
	// The Cup
	difference(){
		translate([0,0,-Len]) cylinder(d=Tube_OD, h=Len, $fn=$preview? 90:360);
		
		translate([0,0,-2]) cylinder(d1=Tube_OD-8+Saucer_IDXtra, d2=Tube_OD-4+Saucer_IDXtra, h=2+Overlap, $fn=$preview? 90:360);
		
		translate([0,0,-Len-Overlap]) cylinder(d=ID, h=Len, $fn=$preview? 90:360);
		
		translate([0,0,-2]) Stager_SaucerBoltPattern() Bolt4ButtonHeadHole();
		
		Stager_LockRod_Holes(Tube_OD=Tube_OD, nLocks=nLocks);
	} // difference
	
} // Stager_Saucer

//Stager_Saucer();

Bolt4Inset=3.5;
Saucer_Len=6;
Ball_d=5/16*25.4;
Stager_PreLoadAdj=-0.35;
Race_W=11;
Stager_PMPU_Lift=4;
Tube_Len=44.5;
Race_Z=-Saucer_Len-Tube_Len;
	
module Stager_BallSpacer(Tube_OD=PML98Body_OD){
	BallCircle_d=Tube_OD-6-Ball_d;
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
} // Stager_BallSpacer

//translate([0,0,Race_Z-Race_W]) Stager_BallSpacer();

module Stager_InnerRace(Tube_OD=PML98Body_OD, nLocks=2){
	BallCircle_d=Tube_OD-6-Ball_d;
	Race_ID=BallCircle_d-Ball_d-Bolt4Inset*4;
	//echo(Race_ID=Race_ID);
	Race_WXtra=2;
	nBolts=4;
	BoltArc_a=90;
	nBottomBolts=8;
	
	difference(){
		translate([0,0,Race_WXtra/2])
		rotate([0,0,180/nLocks]) rotate([180,0,0]) 
			OnePieceInnerRace(BallCircle_d=BallCircle_d, Race_ID=Race_ID, Ball_d=Ball_d, 
						Race_w=Race_W+Race_WXtra, PreLoadAdj=Stager_PreLoadAdj, 
						VOffset=0.00, BI=true, myFn=$preview? 90:720);

		// trigger plate bolt holes
		for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j])
			for (k=[0:nBolts-1]) rotate([0,0,-(BoltArc_a/nBolts)*1.5+BoltArc_a/nBolts*k])
				translate([0,BallCircle_d/2-Ball_d/2-Bolt4Inset,Race_WXtra/2]) Bolt4Hole(depth=6);
		
		// Activator and Stop bolt holes
		for (j=[0:nBottomBolts-1]) rotate([0,0,360/nBottomBolts*j+180/nBottomBolts]) 
			translate([0,Race_ID/2+Bolt4Inset,-Race_W-Race_WXtra])
				rotate([180,0,0]) Bolt4Hole(depth=8);
	} // difference
	
} //Stager_InnerRace

//translate([0,0,Race_Z]) Stager_InnerRace();
//ShowPMPU();

module Stager_TriggerPlateB(Tube_OD=PML98Body_OD){
	// This is a ball bearing version of Stager_TriggerPlate();
	
	BallCircle_d=Tube_OD-6-Ball_d;
	Race_ID=BallCircle_d-Ball_d-Bolt4Inset*4;
	nBolts=4;
	BoltArc_a=90;
	Thickness=3;
	Pin_h=8.5;
	Pin_d=10;
	Bearing_a=23;
	
	LR_X=Stager_LockRod_X;
	LR_Y=Stager_LockRod_Y;
	LR_Z=Stager_LockRod_Z;
	
	difference(){
		union(){
			translate([-LR_X/2+2+4-CP_Bearing_OD-StagerLockArmLen, Tube_OD/2-StagerLockInset_Y, 0]) 
				hull(){
				cylinder(d=Pin_d, h=Thickness);
				translate([0,0,Pin_h-CP_Bearing_OD/2-0.5])
					rotate([90,0,Bearing_a]) cylinder(d=CP_Bearing_OD, h=CP_Bearing_H+5, center=true);
			}
				
			mirror([1,0,0]) 
				translate([-LR_X/2+2+4-CP_Bearing_OD-StagerLockArmLen, 
							Tube_OD/2-StagerLockInset_Y, 0])
					hull(){
				cylinder(d=Pin_d, h=Thickness);
				translate([0,0,Pin_h-CP_Bearing_OD/2-0.5])
					rotate([90,0,Bearing_a]) cylinder(d=CP_Bearing_OD, h=CP_Bearing_H+5, center=true);
			}
				
			hull(){
				for (k=[0:nBolts-1]) rotate([0,0,-(BoltArc_a/nBolts)*1.5+BoltArc_a/nBolts*k])
					translate([0,BallCircle_d/2-Ball_d/2-Bolt4Inset,0]) cylinder(d=10, h=Thickness);
				
				translate([-LR_X/2+2+4-CP_Bearing_OD-StagerLockArmLen, 
						Tube_OD/2-StagerLockInset_Y, 0]) 
					cylinder(d=Pin_d+1, h=Thickness);
			
				mirror([1,0,0]) 
				translate([-LR_X/2+2+4-CP_Bearing_OD-StagerLockArmLen, 
							Tube_OD/2-StagerLockInset_Y, 0])
					cylinder(d=Pin_d+1, h=Thickness);
			} // hull
		} // union
		
		// center hole
		translate([0,0,-Overlap]) cylinder(d=Race_ID, h=Thickness+Overlap*2);
		
		translate([-LR_X/2+2+4-CP_Bearing_OD-StagerLockArmLen, 
					Tube_OD/2-StagerLockInset_Y, Pin_h-CP_Bearing_OD/2]) 
			rotate([90,0,Bearing_a]){
				hull(){
					cylinder(d=CP_Bearing_OD+2, h=CP_Bearing_H+1, center=true);
					translate([0,4,0]) cylinder(d=CP_Bearing_OD+2, h=CP_Bearing_H+1, center=true);
				} // hull
				cylinder(d=CP_Bearing_ID, h=12, center=true);
				
			}
			
		mirror([1,0,0]) // copied from above
			translate([-LR_X/2+2+4-CP_Bearing_OD-StagerLockArmLen, 
					Tube_OD/2-StagerLockInset_Y, Pin_h-CP_Bearing_OD/2]) 
			rotate([90,0,Bearing_a]){
				hull(){
					cylinder(d=CP_Bearing_OD+2, h=CP_Bearing_H+1, center=true);
					translate([0,4,0]) cylinder(d=CP_Bearing_OD+2, h=CP_Bearing_H+1, center=true);
				} // hull
				cylinder(d=CP_Bearing_ID, h=12, center=true);
			}
		
		// Arming tool space
		//difference(){
		//	translate([0,0,-Overlap]) cylinder(d=Tube_OD, h=Pin_h+Overlap*2);
		//	translate([0,0,-Overlap*2]) cylinder(d=BallCircle_d+2, h=Pin_h+Overlap*4);
		//} // difference
		
		// trigger plate bolt holes
		for (k=[0:nBolts-1]) rotate([0,0,-(BoltArc_a/nBolts)*1.5+BoltArc_a/nBolts*k])
				translate([0,BallCircle_d/2-Ball_d/2-Bolt4Inset,Thickness]) Bolt4ButtonHeadHole();
	} // difference
	
	if ($preview) translate([-LR_X/2+2+4-CP_Bearing_OD-StagerLockArmLen, 
					Tube_OD/2-StagerLockInset_Y, Pin_h-CP_Bearing_OD/2]) 
			rotate([90,0,Bearing_a]) color("Red") cylinder(d=CP_Bearing_OD, h=CP_Bearing_H, center=true);
} // Stager_TriggerPlateB

//translate([0,0,Race_Z+1]) Stager_TriggerPlateB();


module Stager_TriggerPlate(Tube_OD=PML98Body_OD){
	BallCircle_d=Tube_OD-6-Ball_d;
	Race_ID=BallCircle_d-Ball_d-Bolt4Inset*4;
	nBolts=4;
	BoltArc_a=90;
	Thickness=3;
	Pin_h=8.5;
	Pin_d=10;
	
	LR_X=Stager_LockRod_X;
	LR_Y=Stager_LockRod_Y;
	LR_Z=Stager_LockRod_Z;
	
	difference(){
		union(){
			translate([-LR_X/2+2+4-CP_Bearing_OD-StagerLockArmLen, Tube_OD/2-StagerLockInset_Y, 0]) 
				cylinder(d=Pin_d, h=Pin_h);
				
			mirror([1,0,0]) 
				translate([-LR_X/2+2+4-CP_Bearing_OD-StagerLockArmLen, 
							Tube_OD/2-StagerLockInset_Y, 0])
					cylinder(d=Pin_d, h=Pin_h);
				
			hull(){
				for (k=[0:nBolts-1]) rotate([0,0,-(BoltArc_a/nBolts)*1.5+BoltArc_a/nBolts*k])
					translate([0,BallCircle_d/2-Ball_d/2-Bolt4Inset,0]) cylinder(d=10, h=Thickness);
				
				translate([-LR_X/2+2+4-CP_Bearing_OD-StagerLockArmLen, 
						Tube_OD/2-StagerLockInset_Y, 0]) 
					cylinder(d=Pin_d, h=Thickness);
			
				mirror([1,0,0]) 
				translate([-LR_X/2+2+4-CP_Bearing_OD-StagerLockArmLen, 
							Tube_OD/2-StagerLockInset_Y, 0])
					cylinder(d=Pin_d, h=Thickness);
			} // hull
		} // union
		
		// center hole
		translate([0,0,-Overlap]) cylinder(d=Race_ID, h=Thickness+Overlap*2);
		
		// Arming tool space
		difference(){
			translate([0,0,-Overlap]) cylinder(d=Tube_OD, h=Pin_h+Overlap*2);
			translate([0,0,-Overlap*2]) cylinder(d=BallCircle_d+2, h=Pin_h+Overlap*4);
		} // difference
		
		// trigger plate bolt holes
		for (k=[0:nBolts-1]) rotate([0,0,-(BoltArc_a/nBolts)*1.5+BoltArc_a/nBolts*k])
				translate([0,BallCircle_d/2-Ball_d/2-Bolt4Inset,Thickness]) Bolt4ButtonHeadHole();
	} // difference
	
} // Stager_TriggerPlate

//translate([0,0,Race_Z+1]) Stager_TriggerPlate();



module ShowPMPU(Tube_OD=PML98Body_OD, nLocks=2){
	
	LR_X=Stager_LockRod_X;
	LR_Y=Stager_LockRod_Y;
	LR_Z=Stager_LockRod_Z;
	
			// Push me pull you
		for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]) {
			translate([-LR_X/2+2+4-CP_Bearing_OD-StagerLockArmLen, Tube_OD/2-StagerLockInset_Y, -Saucer_Len-CP_Bearing_OD/2-10+Stager_PMPU_Lift]){
				color("Orange") Stager_PushUP();
				translate([0,0,-PU_Tail_Len-1]) color("Orange") Stager_SpringStop();
				translate([0,0,-PU_Tail_Len+6.5]) color("Silver") cylinder(d=10,h=6.5);
			}
			
			mirror([1,0,0]) 
			translate([-LR_X/2+2+4-CP_Bearing_OD-StagerLockArmLen, Tube_OD/2-StagerLockInset_Y, -Saucer_Len-CP_Bearing_OD/2-10]){
				color("Orange") Stager_PushUP();
			translate([0,0,-PU_Tail_Len-1]) color("Orange") Stager_SpringStop();
				translate([0,0,-PU_Tail_Len+6.5]) color("Silver") cylinder(d=10,h=6.5);
		}
		}
	} // ShowPMPU

module Stager_Mech(Tube_OD=PML98Body_OD, nLocks=2, Skirt_ID=PML98Body_ID, Skirt_Len=30){
	Len=Saucer_Len;
	ID=Tube_OD-StagerLockInset_Y*2-Stager_LockRod_Y-6;
	LR_X=Stager_LockRod_X;
	LR_Y=Stager_LockRod_Y;
	LR_Z=Stager_LockRod_Z;
	
	Arm_Len=StagerLockArmLen;
	Disengage_a=25;

	BallCircle_d=Tube_OD-6-Ball_d;

	
	module ShowBearing(){
		rotate([90,0,0]) color("Red") cylinder(d=CP_Bearing_OD, h=CP_Bearing_H, center=true);
	} // ShowBearing
	
	module BackStop(){
		Block_W=18;
		
		difference(){
			hull(){
				translate([0,-5,0]) cube([10,Block_W,CP_Bearing_OD/2+1]);
				translate([-2, -5, -2-Overlap]) cube([10, Block_W, Overlap]);
			} // hull
			
			translate([8,-0.5,-3]) cube([4,3,15]);
		} // difference
		
		translate([-2, -5, -2-CP_Bearing_OD-Overlap]) cube([10, Block_W, CP_Bearing_OD+Overlap]);
		translate([-2, -5, -2-CP_Bearing_OD-3-Overlap]) cube([20+CP_Bearing_OD, Block_W, 5+Overlap]);
			
		//*
		hull(){
			translate([22, -5, -2-CP_Bearing_OD-3-Overlap]) cube([CP_Bearing_OD/2+LR_X, Block_W, 5+4+Overlap]);
			translate([15, -5, -2-CP_Bearing_OD-3-Overlap]) cube([CP_Bearing_OD+LR_X, Block_W, 5+Overlap]);
		}
		/**/
		
		// Back Plate
		translate([5,10.5,-15]) cube([30,6,20]);
		
		// Base
		translate([-2, -5, -15]) cube([36, Block_W, 5+Overlap]);
		
		
	} // BackStop
	
	
	// The Tube
	//*
	
	module ArmingKeyHole(){
		translate([0, Tube_OD/2-3,0]) 
		 hull(){
				translate([-3,0,0]) cube([6,6,Overlap]);
				translate([0,0,7.5]) rotate([-90,0,0]) cylinder(d=6, h=6);
			}
	} // ArmingKeyHole
	
	difference(){
		translate([0,0,-Len-Tube_Len]) 
			cylinder(d=Tube_OD, h=Tube_Len, $fn=$preview? 90:360);
		
		translate([0,0,-Len-Tube_Len-Overlap]) 
			cylinder(d=Tube_OD-4.0, h=Tube_Len+Overlap*2, $fn=$preview? 90:360);
		
		// Arming key ports
		translate([0,0,Race_Z]) for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]){
			rotate([0,0,22.5]) ArmingKeyHole();
			rotate([0,0,-22.5]) ArmingKeyHole();
		}
	}
	/**/
	
	difference(){
		for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]) {
			translate([LR_X/2-2+CP_Bearing_OD+10+Arm_Len, Tube_OD/2-StagerLockInset_Y-6, -Len-CP_Bearing_OD/2-1]) 
				mirror([1,0,0]) BackStop();
			
			translate([-LR_X/2+2-CP_Bearing_OD-Arm_Len-10, Tube_OD/2-StagerLockInset_Y-6, -Len-CP_Bearing_OD/2-1])
			  BackStop();
		} // for
		
		
		// Push me pull you
		for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]) {
			translate([-LR_X/2+2+4-CP_Bearing_OD-Arm_Len, Tube_OD/2-StagerLockInset_Y, -Len-CP_Bearing_OD/2-11])
				Stager_PushUP_Hole();
			mirror([1,0,0]) 
			translate([-LR_X/2+2+4-CP_Bearing_OD-Arm_Len, Tube_OD/2-StagerLockInset_Y, -Len-CP_Bearing_OD/2-11])
				Stager_PushUP_Hole();
		}
		
		translate([0,0,-Len]) Stager_SaucerBoltPattern() Bolt4Hole();
		
		Stager_LockRod_Holes(Tube_OD=Tube_OD, nLocks=nLocks);
		
		
		// center hole
		translate([0,0,-Len-20-Overlap]) cylinder(d=ID, h=Len+20+Overlap*2, $fn=$preview? 90:360);
		
		difference(){
			translate([0,0,-50]) cylinder(d=Tube_OD+40, h=50);
			translate([0,0,-50-Overlap]) cylinder(d=Tube_OD-Overlap, h=50+Overlap*2);
		} // difference
	} // difference
	
	// Spring wells
	difference(){
		for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]) 
			translate([0,Tube_OD/2-StagerLockInset_Y, -Len-Stager_Spring_FL])
				difference(){
					cylinder(d=Stager_Spring_OD+5, h=Stager_Spring_CBL);
					translate([0,0,2]) cylinder(d=Stager_Spring_OD+LooseFit, h=Stager_Spring_FL);
					// center hole
				} // difference
		translate([0,0,-Len-Tube_Len-Overlap]) cylinder(d=ID, h=Len+Tube_Len+Overlap*2, $fn=$preview? 90:360);
	} // difference
	
	
	translate([0,0,Race_Z+Overlap]) rotate([0,0,180/nLocks]) rotate([180,0,0])
		OnePieceOuterRace(BallCircle_d=BallCircle_d, Race_OD=Tube_OD, 
					Ball_d=Ball_d, Race_w=Race_W, PreLoadAdj=Stager_PreLoadAdj, 
					VOffset=0.00, BI=true, myFn=$preview? 90:720);
	
	if (Skirt_Len>0)
		difference(){
			union(){
				translate([0,0,Race_Z-Race_W-Skirt_Len]) 
					Tube(OD=Tube_OD, ID=Skirt_ID, Len=Skirt_Len+Overlap*2, myfn=$preview? 36:360);
				translate([0,0,Race_Z-23]) 
					TubeStop(InnerTubeID=Skirt_ID-2, OuterTubeOD=Tube_OD, myfn=$preview? 36:360);
			} // union
			
			// Arm / Trigger access hole
			translate([0,BallCircle_d/2-2,Race_Z-Race_W-3]) rotate([0,90,0])
				cylinder(d=3, h=Tube_OD, center=true);
		} // difference
	
	if ($preview){
		for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]) 
			translate([0,Tube_OD/2-StagerLockInset_Y,-Len-CP_Bearing_OD/2]){
			
			translate([-LR_X/2-CP_Bearing_OD/2+2-Overlap,0,0]){ 
				ShowBearing();
				rotate([90,0,0]) color("Green") BearingBlock();
				translate([-Arm_Len,0,0]) ShowBearing();
				
			}
			translate([LR_X/2+CP_Bearing_OD/2+Overlap,0,0]) {
				ShowBearing();
				
				rotate([0,Disengage_a,0]) translate([Arm_Len,0,0]){
					ShowBearing();
					rotate([90,0,0]) color("Green") BearingBlock();}
			}
		} // for
		
		ShowPMPU();
			
		} // if
} // Stager_Mech

//Stager_Mech();
//rotate([0,0,-20]) mirror([0,1,0]) translate([0,0,Race_Z-12]) rotate([180,0,0]) CableEndAndStop();

PU_Tail_Len=24;

Stager_PushUpSpring_OD=9.75;
Stager_PushUpSpring_ID=7.8;
Stager_PushUpSpring_FL=28;
Stager_PushUpSpring_CBL=6.5;
Stager_PushUp_X=Stager_PushUpSpring_ID-0.4;

module Stager_SpringStop(){
	Len=7;
	SpringPinHole_d=2.2+IDXtra;
	
	difference(){
		cylinder(d=Stager_PushUpSpring_OD+1, h=Len);
		
		translate([0,0,1]) RoundRect(X=Stager_PushUp_X+LooseFit, Y=3+LooseFit, Z=Len, R=1);
		
		translate([0,0,1.2+SpringPinHole_d/2+2]) rotate([90,0,0]) cylinder(d=SpringPinHole_d, h=Stager_PushUpSpring_OD+1, center=true);
	} // difference
} // Stager_SpringStop

//Stager_SpringStop();

module Stager_PushUP_Hole(){
	W=5;
	Pull_Y=3.5;
	Oblong=-1;
	
	translate([0,-2,0]) RoundRect(X=CP_Bearing_OD+1, Y=W+5, Z=6, R=1);
	translate([0,0,-PU_Tail_Len]) RoundRect(X=Stager_PushUp_X+LooseFit, Y=3+LooseFit, Z=PU_Tail_Len+1, R=1);
	
} // Stager_PushUP_Hole

//Stager_PushUP_Hole();

module Stager_PushUP(){
	W=5;
	Pull_Y=3.5;
	Oblong=-1.5;
	SpringPinHole_d=2.2+IDXtra;
	
	translate([0,-1,0]) RoundRect(X=CP_Bearing_OD, Y=W+2, Z=2, R=1);
	
	difference(){
		translate([0,0,-PU_Tail_Len]) RoundRect(X=Stager_PushUp_X, Y=3, Z=PU_Tail_Len+1, R=1);
		
		//# rotate([0,0,15]) 
		translate([0,0,-PU_Tail_Len+SpringPinHole_d/2+2]) rotate([90,0,0]) cylinder(d=SpringPinHole_d, h=6, center=true);
	} // difference
	
	translate([-CP_Bearing_OD/2,-Pull_Y-W/2,0]) cube([CP_Bearing_OD,2,2]);
	
	difference(){
		hull(){
			translate([-CP_Bearing_OD/2,-Pull_Y-W/2,2-Overlap]) cube([CP_Bearing_OD,2,Overlap]);
			translate([0,-Pull_Y-W/2,CP_Bearing_OD/2+2]) 
				rotate([-90,0,0]) cylinder(d=CP_Bearing_OD, h=2);
			translate([Oblong,-Pull_Y-W/2,CP_Bearing_OD/2+2]) 
				rotate([-90,0,0]) cylinder(d=CP_Bearing_OD, h=2);
		} // hull
		
		
		hull(){
			translate([0,-Pull_Y-W/2-Overlap,CP_Bearing_OD/2+2]) 
				rotate([-90,0,0]) cylinder(d=CP_Bearing_ID+LooseFit, h=2+Overlap*2);
			
			translate([Oblong,-Pull_Y-W/2-Overlap,CP_Bearing_OD/2+2]) 
				rotate([-90,0,0]) cylinder(d=CP_Bearing_ID+LooseFit, h=2+Overlap*2);
		} // hull
	} // difference
	
} // Stager_PushUP

//rotate([0,90,0]) Stager_PushUP();




































