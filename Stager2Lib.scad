// ***********************************
// Project: 3D Printed Rocket
// Filename: Stager2Lib.scad
// by David M. Flynn
// Created: 10/10/2022 
// Revision: 0.9.14  11/11/2022
// Units: mm
// ***********************************
//  ***** Notes *****
//
// Specifically built for a 4 inch rocket.
// It could be modified to a larger tube, but smaller would be hard. 
//
// A non-pyro active staging or dual deployment system.
// The "cup" is tightly held to the saucer until triggered.
// Minimum tube is about 4 inches. 
//
// My first intended use is a 4 inch 2 stage rocket. 
// At booster stage burnout: drop away from the sustainer and deploy a parachute.
//
// Parts
// ---------------
// 9 3/8" Delrin Balls
// 6 #4-40 x 3/8" Socket head cap screws
// 10 #4-40 x 3/8" Button head screws
// 2 5/16" Dia. x 1-1/4" strong spring
// 1 5/16" Dia. x 3/4" light spring
// 
//
//  ***** History *****
//
echo("StagerLib 0.9.14");
// 0.9.14  11/11/2022  Code clean up.  
// 0.9.13  11/6/2022   Cleaned up ShowStager(). FC4
// 0.9.12  11/2/2022   Fixed CableEndAndStop for esier assembly, CableEndAndStop stop -6° about 3mm
// 0.9.11  11/1/2022   Back to 15° indexing, added electrical connection to saucer
// 0.9.10  10/31/2022  Added Raceway, Increased ID by 2mm
// 0.9.9  10/30/2022   Stager2 complete redesign, was too complex to be reliable
// 0.9.8  10/26/2022   Realigned the keys, FC3. 
// 0.9.7  10/25/2022   Small fixes, FC2
// 0.9.6  10/24/2022   Added a key to CableRedirect and KeyOffset_a to Stager_Mech
// 0.9.5  10/21/2022   FC1: Worked fully assembled for the first time.
// 0.9.4  10/17/2022   Added CableRedirect(). 
// 0.9.3  10/16/2022   Adapted to booster/sustainer. 
// 0.9.2  10/14/2022   Arming key, added 1.5mm to tube length
// 0.9.1  10/13/2022   Time to print a test article. 
// 0.9.0  10/10/2022   First code.
//
// ***********************************
//  ***** for STL output *****
// 
// rotate([180,0,0]) Stager_Cup(Tube_OD=PML98Body_OD, ID=78, nLocks=2, BoltsOn=true);
// rotate([-90,0,0]) Stager_LockRod(Adj=0); // using this one
// rotate([-90,0,0]) Stager_LockRod(Adj=-0.5);
// rotate([-90,0,0]) Stager_LockRod(Adj=1.0);
// Stager_Saucer(Tube_OD=PML98Body_OD, nLocks=2); // Bolts on
// LockRing(Tube_OD=PML98Body_OD, nLocks=2);
//
// Stager_Mech(Tube_OD=PML98Body_OD, nLocks=2, Skirt_ID=PML98Body_ID, Skirt_Len=30, KeyOffset_a=-30, HasRaceway=true, Raceway_a=270);
//
// Stager_InnerRace(Tube_OD=PML98Body_OD);
// Stager_BallSpacer(Tube_OD=PML98Body_OD);
// CableRedirect(Tube_OD=PML98Body_OD, Skirt_ID=PML98Body_ID, Tube_ID=PML98Coupler_ID, InnerTube_OD=BT54Mtr_OD);
// mirror([0,1,0]) CableEndAndStop(Tube_OD=PML98Body_OD);
// Stager_Detent(Tube_OD=PML98Body_OD);
// BallDetentStopper();
//
// ***********************************
//  ***** Routines *****
//
// Stager_CupHoles(Tube_OD=PML98Body_OD, ID=78, nLocks=2, BoltsOn=true);
// Stager_Cup(Tube_OD=PML98Body_OD, ID=78, nLocks=2);
// 
//
// ***********************************
//  ***** for Viewing *****
//
// ShowStager();
//
// ***********************************

include<TubesLib.scad>
include<BearingLib.scad>
use<RacewayLib.scad>
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
LockBall_d=3/8 * 25.4; // 3/8" Delrin balls
DetentBall_d=3/8 * 25.4;

LooseFit=0.8;
StagerLockInset_Y=11.5; // was 12.5

Bolt4Inset=4;
Saucer_Len=6;
Ball_d=5/16*25.4;
Stager_PreLoadAdj=-0.35;
Race_W=11;
Tube_Len=40; //44.5;
Race_Z=-Saucer_Len-Tube_Len;
EConnInset=6.5; // use Saucer_ID/2+EConnInset


function BallCircle_d(Tube_OD=PML98Body_OD)=Tube_OD-6-Ball_d;
function Race_ID(Tube_OD=PML98Body_OD)=BallCircle_d(Tube_OD=Tube_OD)-Ball_d-Bolt4Inset*4;
function BoltCircle_d(Tube_OD=PML98Body_OD)=Race_ID(Tube_OD=Tube_OD)+Bolt4Inset*2;
function Saucer_ID(Tube_OD=PML98Body_OD)=Tube_OD-StagerLockInset_Y*2-Stager_LockRod_Y-6;
CamBall_a=-25.0;// was -25.5, calculation needed

module ShowStager(Tube_OD=PML98Body_OD){
	translate([0,0,30]) Stager_Cup(Tube_OD=Tube_OD, ID=78, nLocks=2);
	translate([0,0,10]) color("LightBlue") Stager_Saucer();
	translate([0,0,-Overlap*2]) Stager_Mech(Tube_OD=Tube_OD, nLocks=2, Skirt_ID=PML98Body_ID, Skirt_Len=30);
	
	translate([0,0,-140]) LockRing(nLocks=2);
	
	translate([0,0,-150]) {
		translate([100,0,-20]) rotate([180,0,120]) mirror([0,1,0]) CableEndAndStop(Tube_OD=PML98Body_OD);
		translate([0,0,-10]) Stager_InnerRace(Tube_OD=Tube_OD);
		translate([0,0,-30]) Stager_BallSpacer(Tube_OD=Tube_OD);
		translate([0,0,0]) rotate([180,0,0]) Stager_BallSpacer(Tube_OD=Tube_OD);
		translate([60,0,-20]) rotate([180,0,0]) Stager_Detent();
	}
	
	translate([0,0,-200]) {
		CableRedirect(Tube_ID=PML98Coupler_ID, InnerTube_OD=BT54Mtr_OD);
		translate([80,0,-25]) BallDetentStopper();
	}
	
} // ShowStager

// ShowStager();

module BallDetentBody(){
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

module BallDetentStopper(){
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

//translate([0,0,-3]) BallDetentStopper();

module CableRedirect(Tube_OD=PML98Body_OD, Skirt_ID=PML98Body_ID, 
							Tube_ID=PML98Coupler_ID, 
							InnerTube_OD=BT54Mtr_OD,
							HasRaceway=false,
							Raceway_a=270){
								
	// Orientation: Wire is at 0°
	CablePath_Y=BoltCircle_d(Tube_OD=Tube_OD)/2; //InnerTube_OD/2+10;
	Exit_a=75;
	Stop_a=-84; // 11/2/22 was -78;
	Key_a=0;
	
								
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

	rotate([0,0,66]) translate([0,BoltCircle_d(Tube_OD=Tube_OD)/2+3,-16.5]) rotate([0,0,100]) BallDetentBody();

	difference(){
		union(){
			rotate([0,0,22.5]) CenteringRing(OD=Skirt_ID-IDXtra, ID=InnerTube_OD+IDXtra, Thickness=5, nHoles=8);
			
			// Locked position stop
			rotate([0,0,Stop_a]) translate([0,CablePath_Y,0]) cylinder(d=8, h=10);
			
			// Unlocked position stop, allow 10mm of movement
			Disp_a=360/((CablePath_Y*2*PI)/(16+11+3)); // 11mm travel of cable puller +3 11/2/22
			//echo(Disp_a=Disp_a);
			rotate([0,0,Stop_a+Disp_a]) translate([0,CablePath_Y,0]) cylinder(d=8, h=8.5);
			
			translate([0,0,-20]) {
				rotate([0,0,-20]) CenteringRing(OD=Tube_ID-IDXtra*2, ID=InnerTube_OD+IDXtra, 
										Thickness=5, nHoles=8);
				Tube(OD=InnerTube_OD+4.4, ID=InnerTube_OD+IDXtra*2, Len=21, myfn=$preview? 36:360);
			}
			
			// vertical tube
			translate([0,CablePath_Y,-20]) cylinder(d=10, h=25);
			
		} // union
		
		// Wire path
		if (HasRaceway) rotate([0,0,Raceway_a]) hull(){
			translate([0,Skirt_ID/2,-20-Overlap]) cylinder(d=6, h=25+Overlap*2);
			translate([0,Skirt_ID/2-4,-20-Overlap]) cylinder(d=6, h=25+Overlap*2);
		}
		
		// Ball Detent
		rotate([0,0,66]) translate([0,BoltCircle_d(Tube_OD=Tube_OD)/2+3,-21]) cylinder(d=14-Overlap, h=30);

		translate([0,CablePath_Y,1]) rotate([0,0,Exit_a]) CablePath();
		
		// vertical tube for cable
		translate([0,CablePath_Y,-20-Overlap]) cylinder(d=6, h=25+Overlap*2);
		
		// Alignment Key
		rotate([0,0,Key_a]) translate([0,Skirt_ID/2,-Overlap]) cylinder(d=5, h=5+Overlap*2);
	} // difference
	
} // CableRedirect

//CableRedirect(HasRaceway=true);

/*
Sep_Z=28; // 23 down from bearing
translate([0,0,1]) rotate([0,0,5]) LockRing();

translate([0,0,-Race_Z]) 
difference(){
	Stager_Mech(Tube_OD=PML98Body_OD, nLocks=2, Skirt_ID=PML98Body_ID, Skirt_Len=30, KeyOffset_a=0);
	//rotate([0,0,-45]) translate([0,0,-90]) cube([100,100,100]);
}


//translate([0,0,Tube_Len+6+0.2]) Stager_Saucer();
//rotate([0,0,0]) translate([0,0,-Sep_Z]) CableRedirect();

rotate([0,0,5]){
Stager_InnerRace(Tube_OD=Tube_OD, nLocks=2);
rotate([0,0,100]) translate([0,0,-12]) rotate([180,0,0]) Stager_Detent();

rotate([0,0,-90]) mirror([0,1,0]) translate([0,0,-12]) rotate([180,0,0]) CableEndAndStop();
}
/**/

module LockRing(Tube_OD=PML98Body_OD, nLocks=2){
	nBolts=6;
	ID=Saucer_ID(Tube_OD=Tube_OD);
	Depth=3;
	Inset=2;
	nSteps=15;
	//echo(ID=ID);
	Small_ID=ID-12;
	
	module BallGroove(){
		for (j=[0:nSteps])
		hull(){
			rotate([0,0,-j]) translate([0,ID/2+LockBall_d/2-Inset-Depth/nSteps*j,0])
				sphere(d=LockBall_d+IDXtra, $fn=$preview? 18:72);
			rotate([0,0,-j-1]) translate([0,ID/2+LockBall_d/2-Inset-Depth/nSteps*(j+1),0])
				sphere(d=LockBall_d+IDXtra, $fn=$preview? 18:72);
		} // hull
	} // BallGroove
	
	difference(){
		union(){
			cylinder(d=BoltCircle_d(Tube_OD=Tube_OD)+Bolt4Inset*2, h=6);
			cylinder(d=ID-1, h=Tube_Len+3);
		} // union
		
		for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j])
			translate([0,0,Tube_Len-LockBall_d/2-0.8]) {
				rotate([0,0,CamBall_a]) BallGroove();
				rotate([0,0,-CamBall_a]) BallGroove();
			}
		
		// Top Outside
		translate([0,0,Tube_Len-LockBall_d-6]) difference(){
				cylinder(d=ID,h=LockBall_d+9+Overlap);
				
				translate([0,0,-Overlap]) cylinder(d1=ID-1, d2=ID-4, h=3+Overlap*2);
				translate([0,0,3]) cylinder(d=ID-4,h=LockBall_d+6+Overlap*3, $fn=$preview? 90:360);
		} // difference
		
		// center hole
		translate([0,0,-Overlap]) cylinder(d=Small_ID, h=Tube_Len+3+Overlap*2); // top
		translate([0,0,-Overlap]) cylinder(d=ID-5, h=Tube_Len-LockBall_d-9+Overlap); // bottom
		translate([0,0,Tube_Len-LockBall_d-9-Overlap]) cylinder(d1=ID-5, d2=Small_ID, h=5); // transition
		translate([0,0,Tube_Len-3]) cylinder(d1=Small_ID, d2=ID-6, h=6+Overlap);
		
		// Bolts
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) translate([BoltCircle_d(Tube_OD=Tube_OD)/2,0,6]) Bolt4HeadHole();
	} // difference
	
} // LockRing

//translate([0,0,1])LockRing();

module Stager_Detent(Tube_OD=PML98Body_OD){
	nBottomBolts=6;
	Plate_H=4;
	Offset_a=10;
	
	Detent_a=Offset_a-360/nBottomBolts;
	DetentXtra=1.2;
	
	module BoltPattern(){
		for (j=[3:4]) rotate([0,0,Offset_a+360/nBottomBolts*j]) 
			translate([0,BoltCircle_d(Tube_OD=Tube_OD)/2,0]) children();
	} // BoltPattern
	
	difference(){
		union(){
			hull(){
				BoltPattern() cylinder(d=10, h=Plate_H);
				
				// Ball Detent
				rotate([0,0,Detent_a]) translate([BoltCircle_d(Tube_OD=Tube_OD)/2+3,0,0]) cylinder(d=10, h=Plate_H);
				rotate([0,0,Detent_a+17]) translate([BoltCircle_d(Tube_OD=Tube_OD)/2+3,0,0]) cylinder(d=10, h=Plate_H);
				rotate([0,0,Detent_a-17]) translate([BoltCircle_d(Tube_OD=Tube_OD)/2+3,0,0]) cylinder(d=10, h=Plate_H);
			} // hull
			
			// Ball Detent, raised portion
			hull(){
				rotate([0,0,Detent_a]) translate([BoltCircle_d(Tube_OD=Tube_OD)/2+3,0,0]) cylinder(d=10, h=Plate_H+DetentXtra);
				rotate([0,0,Detent_a+17]) translate([BoltCircle_d(Tube_OD=Tube_OD)/2+3,0,0]) cylinder(d=10, h=Plate_H+DetentXtra);
				rotate([0,0,Detent_a-17]) translate([BoltCircle_d(Tube_OD=Tube_OD)/2+3,0,0]) cylinder(d=10, h=Plate_H+DetentXtra);
			} // hull
				
		} // union
		
		// Ball Detent
		rotate([0,0,Detent_a]) translate([BoltCircle_d(Tube_OD=Tube_OD)/2+3,0,Plate_H+DetentXtra+DetentBall_d/2-1.5])
			sphere(d=DetentBall_d);
		
		translate([0,0,-Overlap]) cylinder(d=Race_ID(Tube_OD=Tube_OD), h=DetentXtra+Plate_H+Overlap*2);
		translate([0,0,Plate_H]) BoltPattern() Bolt4ButtonHeadHole();
	} // difference
			
} // Stager_Detent

//Stager_Detent();

module CableEndAndStop(Tube_OD=PML98Body_OD){
	// Must be printed mirror Y
	
	nBottomBolts=6;
	Plate_H=4;
	
	
	module BoltPattern(){
		for (j=[0:1]) rotate([0,0,360/nBottomBolts*j]) 
			translate([0,BoltCircle_d(Tube_OD=Tube_OD)/2,0]) children();
	} // BoltPattern
	
	module StopPattern(){
		for (j=[0:1]) rotate([0,0,180/nBottomBolts*j+90/nBottomBolts]) 
			translate([0,BoltCircle_d(Tube_OD=Tube_OD)/2,0]) children();
	} // BoltPattern
	
	difference(){
		union(){
			hull() {
				BoltPattern() cylinder(d=10, h=Plate_H);
				StopPattern() cylinder(d=10, h=Plate_H);
			} // hull
			rotate([0,0,90/nBottomBolts]) 
				translate([0,BoltCircle_d(Tube_OD=Tube_OD)/2,0]) cylinder(d=8, h=10);
			
			rotate([0,0,360/nBottomBolts-90/nBottomBolts]) 
				translate([0,BoltCircle_d(Tube_OD=Tube_OD)/2,0]) cylinder(d=8, h=7);
			
			// Manual Set and Trigger lever
			rotate([0,0,180/nBottomBolts]) translate([0,BoltCircle_d(Tube_OD=Tube_OD)/2+4,3])
				cube([6,12,6],center=true);
		} // union
		
		// cable end retension
		rotate([0,0,360/nBottomBolts-90/nBottomBolts]) translate([0,BoltCircle_d(Tube_OD=Tube_OD)/2,0]) {
			rotate([0,90,0]) hull(){ 
				cylinder(d=3.5, h=8); 
				translate([-3,0,0]) cylinder(d=3.5, h=8); 
			} // hull
			
			// cable end insertion hole
			translate([-5.4,0,-Overlap]) cylinder(d=3.6, h=Plate_H+Overlap*2);
			
			hull(){
				translate([Overlap,0,-Overlap]) rotate([0,-90,0]) cylinder(d=1.5, h=5);
				translate([Overlap,0,4.5]) rotate([0,-75,0]) cylinder(d=1.2, h=5);
			} // hull
		}
		
		translate([0,0,-Overlap]) cylinder(d=Race_ID(Tube_OD=Tube_OD), h=Plate_H+Overlap*2);
		translate([0,0,Plate_H]) BoltPattern() Bolt4ButtonHeadHole();
	} // difference
} // CableEndAndStop

//mirror([0,1,0]) CableEndAndStop();

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
	Lock_Z=10-LockBall_d/2; // 10mm is the bottom of the saucer
	Lock_Cam=2;
	
	difference(){
		RoundRect(X=LR_X, Y=LR_Y, Z=LR_Z+Adj, R=Stager_LockRod_R);
		
		translate([0,0,Adj]) Stager_LockRodBoltPattern() Bolt6ButtonHeadHole();
		
		translate([-LockBall_d/2-LR_X/2+Lock_Cam, 0, Lock_Z])
			rotate([90,0,0]) cylinder(d=LockBall_d-1, h=LR_Y+Overlap*2, center=true);
		translate([LockBall_d/2+LR_X/2-Lock_Cam, 0, Lock_Z])
			rotate([90,0,0]) cylinder(d=LockBall_d-1, h=LR_Y+Overlap*2, center=true);
	} // difference
	
} // Stager_LockRod

//Stager_LockRod(Adj=-0.5);

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
			translate([0,Tube_OD/2-7.5,Collar_h]) 
				rotate([180,0,0]) Bolt4Hole(depth=12);
} // Stager_CupHoles

//Stager_CupHoles();

module Stager_Cup(Tube_OD=PML98Body_OD, ID=78, nLocks=2, BoltsOn=true, Collar_h=18, HasElectrical=false){
	Len=3;
	LR_X=Stager_LockRod_X;
	LR_Y=Stager_LockRod_Y;
	LR_Z=Stager_LockRod_Z;
	nBolts=8;
	
	
	difference(){
		union(){
			difference(){
				translate([0,0,Len-Overlap]) cylinder(d=Tube_OD, h=Collar_h, $fn=$preview? 90:360);
				translate([0,0,Len-Overlap*2]) cylinder(d=ID, h=Collar_h+Overlap*2, $fn=$preview? 90:360); 
			} // difference
			
			cylinder(d=Tube_OD, h=Len, $fn=$preview? 90:360);
			translate([0,0,-2]) cylinder(d1=Tube_OD-8, d2=Tube_OD-4, h=2+Overlap, $fn=$preview? 90:360);
			
			
		} // union
		
		// center hole
		translate([0,0,-2-Overlap]) cylinder(d=ID, h=Len+2+Overlap*2, $fn=$preview? 90:360);
		
		// BoltHoles
		if (BoltsOn)
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+180/nBolts]) 
			translate([0,Tube_OD/2-7.5,Collar_h-6]) 
				rotate([180,0,0]) Bolt4HeadHole(depth=8,lHead=Collar_h);
		
		Stager_LockRod_Holes(Tube_OD=Tube_OD, nLocks=nLocks);
		
		for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]) 
			translate([0,Tube_OD/2-StagerLockInset_Y,-16])
				Stager_LockRodBoltPattern() Bolt6Hole(depth=StagerLockInset_Y);
		
		if (HasElectrical){
			translate([Saucer_ID(Tube_OD=Tube_OD)/2+EConnInset,0,-2]) cube([10,10,22], center=true);
			translate([Saucer_ID(Tube_OD=Tube_OD)/2+EConnInset,0,8]) RoundRect(X=12, Y=12, Z=Collar_h, R=0.2);
			//translate([0,0,-2]) SaucerEConnBoltPattern() Bolt4ButtonHeadHole();
		}
	} // difference
	
	if (HasElectrical)
			difference(){
				intersection(){
					translate([0,0,-2]) cylinder(d=Tube_OD-8, h=10);
					translate([Saucer_ID(Tube_OD=Tube_OD)/2+EConnInset,0,-2]) RoundRect(X=14, Y=14, Z=10, R=1);
				} // intersection
				translate([Saucer_ID(Tube_OD=Tube_OD)/2+EConnInset,0,-2-Overlap]) RoundRect(X=10, Y=10, Z=10+Overlap*2, R=0.2);
			} // difference
			
	if ($preview)
		for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]) translate([0, Tube_OD/2-StagerLockInset_Y,-16])
				color("Orange") Stager_LockRod();
} // Stager_Cup

//translate([0,0,Overlap]) Stager_Cup(Collar_h=18+15,HasElectrical=false);

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
	
module SaucerEConnBoltPattern(Tube_OD=PML98Body_OD){
	Bolt_a=15;
	BoltInset=10;
	
	rotate([0,0,Bolt_a]) translate([Tube_OD/2-BoltInset,0,0]) children();
	rotate([0,0,-Bolt_a]) translate([Tube_OD/2-BoltInset,0,0]) children();
} // SaucerEConnBoltPattern

module SaucerEConnHolder(Tube_OD=PML98Body_OD){
	ID=Saucer_ID(Tube_OD=Tube_OD);
	difference(){
		union(){
			hull(){
				SaucerEConnBoltPattern(Tube_OD=Tube_OD) cylinder(d=8, h=4);
				translate([ID/2+EConnInset,0,0]) RoundRect(X=14,Y=14,Z=4, R=2);
			} // hull
			
			translate([ID/2+EConnInset,0,0]) RoundRect(X=14,Y=14,Z=10, R=2);
		} // union
		
		// Connector
		translate([ID/2+EConnInset,0,-Overlap]) RoundRect(X=10,Y=10,Z=11, R=0.2);
		
		// Bolt holes
		translate([0,0,4])SaucerEConnBoltPattern(Tube_OD=Tube_OD) Bolt4Hole();
		
		// Trim Inside
		translate([0,0,-Overlap]) cylinder(d=ID, h=30);
		
		// Trim Outside
		difference(){
			translate([0,0,-Overlap]) cylinder(d=Tube_OD+10, h=30);
			translate([0,0,-Overlap*2]) cylinder(d=Tube_OD-4, h=31);
		} // difference
		
	} // difference
	
} // SaucerEConnHolder

//translate([0,0,-6.2]) rotate([180,0,0]) SaucerEConnHolder();

module Stager_Saucer(Tube_OD=PML98Body_OD, nLocks=2, HasElectrical=false){
	Len=Saucer_Len;
	ID=Saucer_ID(Tube_OD=Tube_OD);
	LR_X=Stager_LockRod_X;
	LR_Y=Stager_LockRod_Y;
	LR_Z=Stager_LockRod_Z;
	
	Saucer_IDXtra=IDXtra*3;
	
	difference(){
		translate([0,0,-Len]) cylinder(d=Tube_OD, h=Len, $fn=$preview? 90:360);
		
		// Cup sits here
		translate([0,0,-2]) cylinder(d1=Tube_OD-8+Saucer_IDXtra, d2=Tube_OD-4+Saucer_IDXtra, h=2+Overlap, $fn=$preview? 90:360);
		
		// Center hole
		translate([0,0,-Len-Overlap]) cylinder(d=ID, h=Len, $fn=$preview? 90:360);
		
		translate([0,0,-2]) Stager_SaucerBoltPattern(nLocks=nLocks) Bolt4ButtonHeadHole();
		
		Stager_LockRod_Holes(Tube_OD=Tube_OD, nLocks=nLocks);
		
		if (HasElectrical){
			translate([ID/2+EConnInset,0,-Len]) cube([10,10,22], center=true);
			translate([0,0,-2]) SaucerEConnBoltPattern() Bolt4ButtonHeadHole();
		}
	} // difference
	
} // Stager_Saucer

//translate([0,0,Tube_Len+6+0.2]) Stager_Saucer( HasElectrical=true);

module Stager_BallSpacer(Tube_OD=PML98Body_OD){
	Thickness=1.5;
	nBalls=12;
	
	difference(){
		cylinder(d=BallCircle_d(Tube_OD=Tube_OD)+Ball_d*0.6, h=Ball_d/2+Thickness);
		
		// center hole
		translate([0,0,-Overlap]) cylinder(d=BallCircle_d(Tube_OD=Tube_OD)-Ball_d*0.6, h=Ball_d/2+Thickness+Overlap*2);
		
		for (j=[0:nBalls-1]) rotate([0,0,360/nBalls*j]) translate([BallCircle_d(Tube_OD=Tube_OD)/2,0,Ball_d/2+Thickness])
			sphere(d=Ball_d+LooseFit, $fn=36);
			
		for (j=[0:nBalls/2-1]) rotate([0,0,720/nBalls*j-180/nBalls]){
			translate([BallCircle_d(Tube_OD=Tube_OD)/2,0,0]) rotate([180,0,0]) Bolt2Hole();
			rotate([0,0,360/nBalls]) translate([BallCircle_d(Tube_OD=Tube_OD)/2,0,0]) rotate([180,0,0]) Bolt2HeadHole();
		}
	} // difference
} // Stager_BallSpacer

//translate([0,0,Race_Z-Race_W]) Stager_BallSpacer();

module Stager_InnerRace(Tube_OD=PML98Body_OD){
	Race_WXtra=2;
	nBolts=24;
	
	difference(){
		translate([0,0,Race_WXtra/2]) rotate([180,0,0]) 
			OnePieceInnerRace(BallCircle_d=BallCircle_d(Tube_OD=Tube_OD), Race_ID=Race_ID(Tube_OD=Tube_OD), Ball_d=Ball_d, 
						Race_w=Race_W+Race_WXtra, PreLoadAdj=Stager_PreLoadAdj, 
						VOffset=0.00, BI=true, myFn=$preview? 90:720);

		
		// Activator and Stop bolt holes
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) 
			translate([0,BoltCircle_d(Tube_OD=Tube_OD)/2,Race_WXtra/2])
				Bolt4Hole(depth=Race_W+Race_WXtra);
	} // difference
	
} //Stager_InnerRace

//translate([0,0,Race_Z]) Stager_InnerRace();
	
module Stager_Mech(Tube_OD=PML98Body_OD, nLocks=2, Skirt_ID=PML98Body_ID, Skirt_Len=30, KeyOffset_a=0, HasRaceway=true,
	Raceway_a=270){
		
	// KeyOffset_a must be a multiple 15°
		
	Len=Saucer_Len;
	ID=Saucer_ID(Tube_OD=Tube_OD);
	Raceway_Len=44;
	Raceway_Z=-49;

	
	
	module ShowBall(){
		color("Red") sphere(d=LockBall_d, $fn=18);
	} // ShowBall
	
	module BackStop(){
		Block_W=22;
		Block_H=LockBall_d+5;
		
		module BallPath(){
			
			// lock/unlock path
			hull(){
				translate([Stager_LockRod_X/2+LockBall_d/2-2,Tube_OD/2-StagerLockInset_Y,-LockBall_d/2])
					sphere(d=LockBall_d+IDXtra*2);
				
				translate([Stager_LockRod_X/2+LockBall_d/2+2,Tube_OD/2-StagerLockInset_Y,-LockBall_d/2])
					sphere(d=LockBall_d+IDXtra*2);
			} // hull
				
			// locking ball insertion hole
			hull(){
				translate([Stager_LockRod_X/2+LockBall_d/2+2,Tube_OD/2-StagerLockInset_Y,-LockBall_d/2])
					sphere(d=LockBall_d+IDXtra*2);
				translate([Stager_LockRod_X/2+LockBall_d/2+2,Tube_OD/2-StagerLockInset_Y,1])
					sphere(d=LockBall_d+IDXtra*2);
			} // hull
			
			// Cam ball
			hull(){
				rotate([0,0,CamBall_a])
					translate([0,Tube_OD/2-StagerLockInset_Y-2,-LockBall_d/2]) sphere(d=LockBall_d+IDXtra*2);
				
				rotate([0,0,CamBall_a])
				  translate([0,Tube_OD/2-StagerLockInset_Y-2,-LockBall_d/2]) 
					rotate([0,0,5]) translate([0,-10,0]) sphere(d=LockBall_d+IDXtra*2);
			} // hull
			
		} // BallPath
		
		difference(){
			intersection(){
				translate([0,Tube_OD/2-StagerLockInset_Y,-Block_H/2]) 
					cube([Tube_OD,Block_W,Block_H], center=true);
				translate([0,0,-Block_H]) cylinder(d=Tube_OD-1, h=Block_H);
			} // intersection
			
			// center hole
			translate([0,0,-Block_H-Overlap])
				cylinder(d=ID, h=Block_H+Overlap*2);
				
			BallPath();
			mirror([1,0,0]) BallPath();
			
			translate([0,0,5]) Stager_LockRod_Holes(Tube_OD=Tube_OD, nLocks=nLocks);
			Stager_SaucerBoltPattern() Bolt4Hole();
		} // difference
		
		if ($preview) {
			translate([Stager_LockRod_X/2+LockBall_d/2-2,Tube_OD/2-StagerLockInset_Y,-LockBall_d/2])
				ShowBall();
			rotate([0,0,CamBall_a]) translate([0,Tube_OD/2-StagerLockInset_Y-2,-LockBall_d/2]) 
				ShowBall();
		}
	} // BackStop
	
	for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j])
		translate([0,0,-Len]) BackStop();
		
	
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
	
	// The Tube
	//*
	difference(){
		union(){
			translate([0,0,-Len-Tube_Len]) 
				cylinder(d=Tube_OD, h=Tube_Len, $fn=$preview? 90:360);
			
			// Skirt
			translate([0,0,Race_Z-Race_W-Skirt_Len]) 
				Tube(OD=Tube_OD, ID=Skirt_ID, Len=Skirt_Len+Overlap*2, myfn=$preview? 36:360);
			
			translate([0,0,Race_Z-23]) 
				TubeStop(InnerTubeID=Skirt_ID-3, OuterTubeOD=Tube_OD, myfn=$preview? 36:360);
			
			// Alignment key
			intersection(){
				rotate([0,0,KeyOffset_a]) translate([0,Skirt_ID/2,Race_Z-27]) cylinder(d=4,h=5);
				translate([0,0,Race_Z-27]) cylinder(d=Skirt_ID+1, h=5);
			} // intersection

		} // union
		
		translate([0,0,-Len-Tube_Len-Overlap]) 
			cylinder(d=Tube_OD-4.0, h=Tube_Len+Overlap*2, $fn=$preview? 90:360);
		
		// Arm / Trigger access hole
		rotate([0,0,-39+KeyOffset_a]) translate([0,BallCircle_d(Tube_OD=Tube_OD)/2-2,Race_Z-Race_W-3])
			rotate([0,90,0]) cylinder(d=3, h=Tube_OD, center=true);

		if (HasRaceway){
			translate([0,0,Raceway_Z+Raceway_Len/2]) 
				Raceway_Exit(Tube_OD=Tube_OD, Race_ID=6, Wall_t=4, Top_Len=10, Bottom_Len=10);
			translate([0,0,Raceway_Z-Raceway_Len/2]) rotate([180,0,0]) 
				Raceway_Exit(Tube_OD=Tube_OD, Race_ID=6, Wall_t=4, Top_Len=10, Bottom_Len=10);
		} // if

	} // difference
	
	if (HasRaceway){
		translate([0,0,Raceway_Z+Raceway_Len/2]) 
			Raceway_End(Tube_OD=Tube_OD, Race_ID=6, Wall_t=4, Len=Raceway_Len/2); //External cover end
		translate([0,0,Raceway_Z-Raceway_Len/2]) rotate([180,0,0]) 
			Raceway_End(Tube_OD=Tube_OD, Race_ID=6, Wall_t=4, Len=Raceway_Len/2); //External cover end
	} // if
	
	/**/
	
	
	/**/
	translate([0,0,Race_Z+Overlap]) rotate([0,0,180/nLocks]) rotate([180,0,0])
		OnePieceOuterRace(BallCircle_d=BallCircle_d(Tube_OD=Tube_OD), Race_OD=Tube_OD, 
					Ball_d=Ball_d, Race_w=Race_W, PreLoadAdj=Stager_PreLoadAdj, 
					VOffset=0.00, BI=true, myFn=$preview? 90:720);
	
	
	if ($preview){
		
		} // if
} // Stager_Mech

//Stager_Mech();


































