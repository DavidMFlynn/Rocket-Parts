// ***********************************
// Project: 3D Printed Rocket
// Filename: Stager75BBLib.scad
// by David M. Flynn
// Created: 8/14/2024 
// Revision: 0.9.6  8/20/2024
// Units: mm
// ***********************************
//  ***** Notes *****
//
// Problem to solve: Stager for 75mm tube and 54mm motors.
//
// Cup in Saucer w/ locking pins, servo activated active staging system.
//
// There is still (as of 8/17/24) legacy code and bad math that will prevent scaling to 98mm, needs more work.
// For now, it works and will stay a 75mm only stager.
//
// Assy Note: Align InnerRace key with LockRing key and ServoPlate key. 
//			  Viewed from bottom LockStop w/ magnet goes on the left when keys are aligned.
//
//  ***** History *****
//
echo("Stager75BBLib 0.9.6");
// 0.9.6  8/20/2024	   Code cleanup, release candidate!
// 0.9.5  8/18/2024    It works, made some small improvements.
// 0.9.4  8/17/2024    Ready for a test printing.
// 0.9.3  8/16/2024	   Copied from Stager75Lib.scad, new version using 6807-2RS bearing
// 0.9.2  8/16/2024	   It works, little fixes.
// 0.9.1  8/15/2024    Code cleanup, First printing.
// 0.9.0  8/14/2024    First code.
//
// ***********************************
//  ***** for STL output *****
//
//  *** Sustainer "Cup" bolts to bottom of sustainer, incudes AT RMS 54mm motor retention. ***
// rotate([180,0,0]) Stager_Cup(Tube_OD=DefaultBody_OD, ID=Default_ID, nLocks=Default_nLocks, BoltsOn=true, Collar_h=17); // a.k.a. Sustainer Motor Retainer
// rotate([-90,0,0]) Stager_LockRod(Adj=0.5); // Looser
// rotate([-90,0,0]) Stager_LockRod(Adj=0.0); // This works!
//
// Stager_Saucer(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks); // Bolts on
//
// Stager_LockRing(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks, FlexComp_d=0.0); 
// Stager_LockStop(Tube_OD=DefaultBody_OD, HasMagnet=true);
// Stager_LockStop(Tube_OD=DefaultBody_OD, HasMagnet=false);
//
//  *** Main Body ***
// Stager_Mech(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks, Skirt_ID=DefaultBody_ID, Skirt_Len=Default_SkirtLen, nSkirtBolts=4, ShowLocked=true);
// Stager_OuterBearingCover(nLocks=Default_nLocks); // Secures Outer Race of Main Bearing
//
// Stager_InnerRace(Tube_OD=DefaultBody_OD); // Secures Inner Race of Main Bearing and has mounting holes for Lock Stops
// Stager_ServoPlate(Tube_OD=DefaultBody_OD, Skirt_ID=DefaultBody_ID); // Bottom Plate
//
// ***********************************
//  ***** Routines *****
//
// Stager_CupHoles(Tube_OD=DefaultBody_OD, ID=Default_ID, nLocks=Default_nLocks, BoltsOn=true);
// Stager_SaucerBoltPattern(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks);
// Stager_ArmDisarmAccess(Tube_OD=DefaultBody_OD, Len=DefaultBody_OD);
//
// ***********************************
//  ***** for Viewing *****
//
// ShowStager();
// ShowStagerAssy(Tube_OD=DefaultBody_OD, Tube_ID=DefaultBody_ID, nLocks=Default_nLocks, ShowLocked=true);
// ShowStagerAssy(Tube_OD=DefaultBody_OD, Tube_ID=DefaultBody_ID, nLocks=Default_nLocks, ShowLocked=false);
//
// ***********************************

include<TubesLib.scad>
use<LD-20MGServoLib.scad>
use<SG90ServoLib.scad>
//include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
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

Default_nLocks=3;
Default_SkirtLen=16;
DefaultBody_OD=BT75Body_OD;
DefaultBody_ID=BT75Body_ID;

LooseFit=0.8;

nInnerRaceBolts=6;
Bolt4Inset=4;
Saucer_H=6;
SaucerDepth=2;
SaucerLipInset_ID=8;
SaucerLipInset_OD=4;
CupBoltHoleInset=SaucerLipInset_ID/2+Bolt4Inset;

// Small Bearing
MR84_Bearing_OD=8;
MR84_Bearing_ID=4;
MR84_Bearing_T=3;

// Main Bearing
Bearing6806_OD=42;
Bearing6806_ID=30;
Bearing6806_T=7;

Bearing6807_OD=47;
Bearing6807_ID=35;
Bearing6807_T=7;

Bearing6808_OD=52;
Bearing6808_ID=40;
Bearing6808_T=7;

Bearing6810_OD=65;
Bearing6810_ID=50;
Bearing6810_T=7;

MainBearing_OD=Bearing6807_OD;
MainBearing_ID=Bearing6807_ID;
MainBearing_T=Bearing6807_T;
MainBearingSplit=2; // race mounting split 

function StagerLockInset_Y(Tube_OD=DefaultBody_OD)=(Tube_OD>90)? 8:8; // LockRod inset from tube OD
function Calc_a(Dist=1,R=2)=Dist/(R*2*PI)*360;
function BoltCircle_d(Tube_OD=DefaultBody_OD)=Tube_OD-28-Bolt4Inset*2; // Bolt circle for LockStops
function Saucer_ID(Tube_OD=DefaultBody_OD)=Tube_OD-StagerLockInset_Y(Tube_OD=Tube_OD)*2-Stager_LockRod_Y-LockBall_d*2+6;

// ============================================================================ //

module ShowStager(Tube_OD=DefaultBody_OD, Tube_ID=DefaultBody_ID, nLocks=Default_nLocks){
	
	translate([0,0,30]) Stager_Cup(Tube_OD=Tube_OD, ID=Tube_OD-24, nLocks=nLocks);
	translate([0,0,10]) color("LightBlue") Stager_Saucer(Tube_OD=Tube_OD, nLocks=nLocks);
	Stager_Mech(Tube_OD=Tube_OD, nLocks=nLocks, Skirt_ID=Tube_ID, Skirt_Len=Default_SkirtLen);
	
	translate([0,0,-140]) Stager_LockRing(Tube_OD=Tube_OD, nLocks=nLocks);
	
	//*
	translate([0,0,-150]) {
		translate([20,0,-40]) rotate([180,0,120]) Stager_LockStop(Tube_OD=Tube_OD);
		translate([0,0,-10]) Stager_InnerRace(Tube_OD=Tube_OD);
		
	}
	/**/
	translate([0,0,-210]) Stager_ServoPlate(Tube_OD=Tube_OD, Skirt_ID=Tube_ID);		
	
} // ShowStager

// ShowStager();
// ShowStager(Tube_OD=DefaultBody_OD, Tube_ID=DefaultBody_ID, nLocks=Default_nLocks);

module ShowStagerAssy(Tube_OD=DefaultBody_OD, Tube_ID=DefaultBody_ID, nLocks=Default_nLocks, ShowLocked=true){
	
	
	Mech_Z=-Saucer_H-40;

	// Shown in the locked position?
	Lock_a=	ShowLocked? 0:Calc_a(11,(BoltCircle_d(Tube_OD=Tube_OD)/2));
						
	Sep_Z=6; 

	translate([0,0,18.1]) color("Red") Tube(OD=MainBearing_OD, ID=MainBearing_ID, Len=MainBearing_T, myfn=90);
	
	//translate([0,0,45]) Stager_CupHoles(Tube_OD=Tube_OD, ID=Default_ID, nLocks=Default_nLocks, BoltsOn=true);
	//translate([0,0,50]) Stager_Cup(Tube_OD=Tube_OD, ID=BT54Body_ID, nLocks=Default_nLocks, BoltsOn=true);
	
	translate([0,0,40+6+0.2]) Stager_Saucer();
	
	translate([0,0,18.1]) rotate([0,0,Lock_a]) Stager_LockRing(Tube_OD=Tube_OD, nLocks=nLocks);

	//*
	translate([0,0,-Mech_Z]) 
		difference(){
			Stager_Mech(Tube_OD=Tube_OD, nLocks=nLocks, Skirt_ID=Tube_ID, Skirt_Len=Default_SkirtLen, ShowLocked=ShowLocked);
			//rotate([0,0,-45-180]) translate([0,0,-90]) cube([100,100,100]);
		}
	translate([0,0,-Mech_Z-26.1]) rotate([180,0,0]) color("Tan") Stager_OuterBearingCover();
	/**/

	//*
	
	//translate([0,0,-Sep_Z]) Stager_ServoPlate(Tube_OD=Tube_OD, Skirt_ID=Tube_ID);

	rotate([0,0,Lock_a]){
		InnerRace_Z=10;
		
		translate([0,0,InnerRace_Z]) color("LightBlue") 
		   Stager_InnerRace(Tube_OD=Tube_OD);

		Stop_Z= 10+Overlap;
		
		translate([0,0,Stop_Z]) 
			rotate([0,180,-45-60]) color("Tan") Stager_LockStop(Tube_OD=Tube_OD, HasMagnet=true);
			
		translate([0,0,Stop_Z]) 
			rotate([0,180,-15-60+180]) color("Tan") Stager_LockStop(Tube_OD=Tube_OD, HasMagnet=false);
	}
	/**/
					
} // ShowStagerAssy

//
ShowStagerAssy(ShowLocked=true);
//ShowStagerAssy(ShowLocked=false);
//ShowStagerAssy(Tube_OD=BT98Body_OD, Tube_ID=BT98Body_ID, nLocks=Default_nLocks, ShowLocked=true);

module Stager_ServoPlate(Tube_OD=DefaultBody_OD, Skirt_ID=DefaultBody_ID){
											
	BC_r=BoltCircle_d(Tube_OD=Tube_OD)/2;
	LargeServo=false;
	nBolts=4;
	Bolt_a=35;
	Exit_a=75;
	Servo_X=LargeServo? -8:-20;
	Servo_Y=LargeServo? 0:1;
	Servo_Z=LargeServo? -10:-6;
	Stop_a= -105;
	BackStop_a=Stop_a+Calc_a(11,BC_r);
	
	HasAlTube=true;
	Al_Tube_d=12.7;
	Al_Tube_Z=-Al_Tube_d/2-3;
	Al_Tube_a=-10;
	Al_Tube_X=10;
	Al_Tube_Y=-3;
						
	echo(Stop_a=Stop_a);
	Magnet_d=3/16*25.4;
	
	module StopBlock(LockedBlock=true){
		Block_H=11.5;
		Block_T=4;
		BlockOffset=LockedBlock? Block_T/2+3:-Block_T/2-3;
		Offset_Y=0;
		
		difference(){
			translate([BlockOffset,BC_r+Offset_Y,Block_H/2]) cube([Block_T,12,Block_H],center=true);
			
			translate([BlockOffset,BC_r,6+Magnet_d/2]) rotate([0,90,0]) cylinder(d=Magnet_d, h=Block_T+1, center=true);
			
		} // difference
	} // StopBlock

	difference(){
		union(){
			cylinder(d=Skirt_ID, h=5, $fn=$preview? 90:360);
			
			if (HasAlTube){
				intersection(){
					difference(){
						hull(){
							translate([Al_Tube_X,Al_Tube_Y,Al_Tube_Z])
								rotate([90,0,Al_Tube_a]) cylinder(d=Al_Tube_d+6, h=Skirt_ID+5, center=true);
								
							translate([Al_Tube_X,Al_Tube_Y,0])
								rotate([0,0,Al_Tube_a]) cube([Al_Tube_d+7,Skirt_ID+5,Overlap], center=true);
						} // hull
						
						translate([Al_Tube_X,Al_Tube_Y,Al_Tube_Z]) 
							rotate([90,0,Al_Tube_a]) cylinder(d=Al_Tube_d, h=Skirt_ID+6, center=true);
						translate([Al_Tube_X,Al_Tube_Y,Al_Tube_Z]) 
							rotate([90,0,Al_Tube_a]) cylinder(d=Al_Tube_d+17, h=20, center=true);
					} // difference
					
					translate([0,0,Al_Tube_Z-Al_Tube_d/2-4]) cylinder(d=Skirt_ID-7, h=Al_Tube_d+8);
				} // intersection
			}
			
			// Servo base
			if (LargeServo) {
				translate([Servo_X+10,Servo_Y,-5]) cube([60,25,10],center=true);
			}else{
				translate([Servo_X+5,Servo_Y,-2]) cube([35,15,8],center=true);
			}
			
			// Locked position stop
			rotate([0,0,Stop_a]) StopBlock(LockedBlock=true); //cylinder(d=8, h=10);
			
			// Unlocked position stop, allow 10mm of movement
			rotate([0,0,BackStop_a]) StopBlock(LockedBlock=false); //cylinder(d=8, h=8.5);
			
		} // union
		
		// Servo
		if (LargeServo) {
			translate([Servo_X,Servo_Y,0]) rotate([0,0,180]) translate([0,0,Servo_Z]) 
				Servo_LD20MG(BottomMount=true,TopAccess=false);
		}else{
			translate([Servo_X,Servo_Y,0]) translate([0,0,Servo_Z]) ServoSG90(TopMount=true);
		}
		
		// mounting bolts
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+Bolt_a]) translate([0,Skirt_ID/2-Bolt4Inset,0])
			rotate([180,0,0]) Bolt4ButtonHeadHole();
		
		// Alignment Key
		translate([0,Skirt_ID/2,-Overlap]) cylinder(d=5, h=5+Overlap*2);
	} // difference
	
} // Stager_ServoPlate

// Stager_ServoPlate();

module Stager_LockRing(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks, FlexComp_d=0.0){
	
	nBolts=nInnerRaceBolts;
	OD=Tube_OD-StagerLockInset_Y(Tube_OD=Tube_OD)*2-Stager_LockRod_Y-LockBall_d*2+4;
	Depth=3;
	Inset=0.0;
	nSteps=15;
	Arc_a=Calc_a(9,(OD/2-Inset));
	echo(Arc_a=Arc_a);
	Small_ID=OD-15; // center hole ID
	Large_ID=MainBearing_ID-Bolt4Inset*4;
	
	// center of ball in locked position
	Locked_Ball_Y=Tube_OD/2-StagerLockInset_Y(Tube_OD=Tube_OD)-Stager_LockRod_Y/2-LockBall_d/2+2+FlexComp_d/2;
		
	Ball_Z=23-LockBall_d/2-0.8;
	
	module LanyardAttachmentPoint(){
		Ly_OD=Large_ID+4;
		Ly_t=4;
		HoleCenter_Z=Ly_t+MainBearingSplit;
		
		difference(){
			union(){
				hull(){
					translate([0,0,HoleCenter_Z]) rotate([90,0,0]) cylinder(d=10, h=4, center=true);
					translate([0,0,Ly_t]) cube([12,4,Overlap],center=true);
				} // hull
				cylinder(d=Ly_OD, h=Ly_t);
			} // union
			// Key
			translate([0,MainBearing_ID/2-Bolt4Inset*2,-Overlap]) cylinder(d=3, h=1);
		
			translate([0,0,HoleCenter_Z]) rotate([90,0,0]) cylinder(d=4, h=4+Overlap*2, center=true);
		} // difference
	} // LanyardAttachmentPoint
	
	translate([0,0,MainBearingSplit]) LanyardAttachmentPoint();
	
	module Bearing(){
		translate([0,Locked_Ball_Y-LockBall_d/2-MR84_Bearing_OD/2,0]){
			cylinder(d=MR84_Bearing_OD+2, h=MR84_Bearing_T+1, center=true);
			translate([0,0,-11]) cylinder(d=MR84_Bearing_ID, h=20);}
		
		for (j=[0:nSteps])
			hull(){
				rotate([0,0,-(Arc_a/nSteps)*j]) translate([0, Locked_Ball_Y-Depth/nSteps*j, 0])
							sphere(d=LockBall_d+IDXtra, $fn=$preview? 18:72);
				rotate([0,0,-(Arc_a/nSteps)*(j+1)]) translate([0, Locked_Ball_Y-Depth/nSteps*(j+1), 0])
							sphere(d=LockBall_d+IDXtra, $fn=$preview? 18:72);
			} // hull
	} // Bearing
	
	FullD_Z=MainBearing_T+4;
	
	difference(){
		union(){
			translate([0,0,MainBearingSplit]) cylinder(d=MainBearing_ID, h=MainBearing_T, $fn=$preview? 90:360);
			translate([0,0,MainBearing_T]) cylinder(d1=MainBearing_ID+3, d2=OD, h=4+Overlap, $fn=$preview? 90:360);
			translate([0,0,FullD_Z]) cylinder(d=OD, h=14, $fn=$preview? 90:360);
		} // union
		
		for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j])
			translate([0,0,Ball_Z]) Bearing();
			
		// center hole
		translate([0,0,FullD_Z+13]) cylinder(d1=Small_ID, d2=Small_ID+1, h=1+Overlap); // chamfer
		translate([0,0,FullD_Z]) cylinder(d=Small_ID, h=20+Overlap*2); // top
		translate([0,0,MainBearingSplit-Overlap]) cylinder(d=Large_ID, h=5+Overlap); // bottom
		translate([0,0,MainBearingSplit+2]) cylinder(d1=Large_ID, d2=Small_ID, h=7+Overlap); // transition
		
		// Bolts
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) 
			translate([MainBearing_ID/2-Bolt4Inset,0,0]) rotate([180,0,0]) Bolt4Hole();
			
		// Key
		translate([0,MainBearing_ID/2-Bolt4Inset*2,MainBearingSplit-Overlap]) cylinder(d=3, h=1);
		
	} // difference
	
	if ($preview) color("Red") for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j])
			translate([0, Locked_Ball_Y-LockBall_d/2-MR84_Bearing_OD/2, Ball_Z]) 
				cylinder(d=MR84_Bearing_OD, h=MR84_Bearing_T, center=true);
} // Stager_LockRing

// Stager_LockRing();

module Stager_LockStop(Tube_OD=DefaultBody_OD, HasMagnet=true){
	BC_r=BoltCircle_d(Tube_OD=Tube_OD)/2;
	nBottomBolts=nInnerRaceBolts;
	Plate_H=4;
	Stop_a=Calc_a(8,BC_r);
	Magnet_OD=3/16*25.4;
	Block_H=10.5;
	Block_Len=HasMagnet? 8:13;
			
	module BoltPattern(){
		for (j=[0:1]) rotate([0,0,360/nBottomBolts*j-180/nBottomBolts]) 
			translate([0,BC_r,0]) children();
	} // BoltPattern
	
	difference(){
		union(){
			// base
			hull() {
				BoltPattern() cylinder(d=8, h=Plate_H);
				translate([0,BC_r,0]) cylinder(d=8, h=Plate_H);
			} // hull
			
			// Manual Set and Trigger lever
			if (HasMagnet){
				translate([0,BC_r-4+Block_Len/2,Block_H/2])
					cube([6,Block_Len,Block_H],center=true);
			}else{
				translate([0,BC_r-4+Block_Len/2,Block_H/2+Plate_H/2-Overlap])
					cube([6,Block_Len,Block_H-Plate_H],center=true);
			}
		} // union
		
		// magnet
		if (HasMagnet){
			translate([0, BC_r, Block_H-Magnet_OD/2-1]) rotate([0,90,0]) cylinder(d=Magnet_OD, h=7, center=true);
		}else{
			// Servo wheel
			rotate([0,0,10]) hull(){
				translate([0,BC_r-6,Plate_H]) cylinder(d=8, h=7);
				translate([0,BC_r-2,Plate_H]) cylinder(d=8, h=7);
			}
		}
			
		translate([0,0,-Overlap]) cylinder(r=BC_r-Bolt4Inset, h=Plate_H+Overlap*2);
		translate([0,0,Plate_H]) BoltPattern() Bolt4ButtonHeadHole();
	} // difference
} // Stager_LockStop

//rotate([0,180,-60]) 
//Stager_LockStop(HasMagnet=false);

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
	Lock_Cam=2+IDXtra;
	
	difference(){
		RoundRect(X=LR_X, Y=LR_Y, Z=LR_Z+Adj, R=Stager_LockRod_R);
		
		translate([0,0,Adj]) Stager_LockRodBoltPattern() Bolt6ButtonHeadHole();
		
		hull(){
			translate([0, -LockBall_d/2-LR_Y/2+Lock_Cam, Lock_Z]) sphere(d=LockBall_d+IDXtra, $fn=$preview? 24:90);
			translate([0, -LockBall_d/2-LR_Y/2+Lock_Cam, Lock_Z+2]) sphere(d=LockBall_d+IDXtra, $fn=$preview? 24:90);
		} // hull
		
	} // difference
	
} // Stager_LockRod

//Stager_LockRod();
//Stager_LockRod(Adj=0.5);

module Stager_CupHoles(Tube_OD=DefaultBody_OD, ID=Default_ID, nLocks=Default_nLocks, BoltsOn=true){
	Collar_h=18;
	nBolts=nLocks*4;
	
	difference(){
		translate([0,0,-Overlap]) cylinder(d=Tube_OD+1, h=Collar_h+Overlap, $fn=$preview? 90:360); // test
		translate([0,0,-Overlap*2]) cylinder(d=ID-IDXtra*2, h=Collar_h+Overlap*4, $fn=$preview? 90:360); 
	} // difference
	
	translate([0,0,-12]) Stager_LockRod_Holes(Tube_OD=Tube_OD, nLocks=nLocks);
	
	// BoltHoles
	if (BoltsOn)
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+180/nBolts]) 
			translate([0,Tube_OD/2-CupBoltHoleInset,Collar_h]) 
				rotate([180,0,0]) Bolt4Hole(depth=12);
} // Stager_CupHoles

//Stager_CupHoles();

module Stager_Cup(Tube_OD=DefaultBody_OD, ID=Default_ID, nLocks=Default_nLocks, BoltsOn=true, Collar_h=17){
	// also acts as motor retainer

	Len=3;
	LR_X=Stager_LockRod_X;
	LR_Y=Stager_LockRod_Y;
	LR_Z=Stager_LockRod_Z;
	nBolts=nLocks*4;
	
	difference(){
		union(){
			difference(){
				translate([0,0,Len-Overlap]) 
					cylinder(d=Tube_OD, h=Collar_h, $fn=$preview? 90:360);
				translate([0,0,Len-Overlap*2]) 
					cylinder(d=ID, h=Collar_h+Overlap*2, $fn=$preview? 90:360); 
			} // difference
			
			cylinder(d=Tube_OD, h=Len, $fn=$preview? 90:360);
			translate([0,0,-2]) 
				cylinder(d1=Tube_OD-8, d2=Tube_OD-4, h=2+Overlap, $fn=$preview? 90:360);
		} // union
		
		// center hole
		translate([0,0,-2-Overlap]) cylinder(d=ID, h=Len+2+Overlap*2, $fn=$preview? 90:360);
		cylinder(d=BT54Body_OD+1, h=Len+Collar_h, $fn=$preview? 90:360);
		
		// BoltHoles
		if (BoltsOn)
			for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+180/nBolts]) 
				translate([0,Tube_OD/2-CupBoltHoleInset,Collar_h-6]) 
					rotate([180,0,0]) Bolt4HeadHole(depth=8,lHead=Collar_h);
		
		if (nLocks>0)
		Stager_LockRod_Holes(Tube_OD=Tube_OD, nLocks=nLocks);
		
		if (nLocks>0)
		for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]) 
			translate([0,Tube_OD/2-StagerLockInset_Y(Tube_OD=Tube_OD),-16])
				Stager_LockRodBoltPattern() Bolt6Hole(depth=StagerLockInset_Y(Tube_OD=Tube_OD)+4);
		
		// wire path only, for sustainer ignition
		rotate([0,0,-180/nLocks])
			translate([0,Tube_OD/2-2.2-3.5,-2-Overlap]){
				cylinder(d=7, h=Collar_h+Len+2+Overlap*2);
				hull(){
					cylinder(d=7, h=3);
					translate([0,-10,0]) cylinder(d=7, h=3);
				} // hull
			} // translate
		
	} // difference
	
	if ($preview && (nLocks>0))
		for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]) translate([0, Tube_OD/2-StagerLockInset_Y(Tube_OD=Tube_OD),-16])
				color("Orange") Stager_LockRod();
} // Stager_Cup

// translate([0,0,Overlap]) Stager_Cup(ID=BT54Body_ID);
// rotate([180,0,0]) Stager_Cup(ID=BT54Body_ID); // STL test

module Stager_SaucerBoltPattern(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks){
	// copied from Stager137
	Inset_Y=StagerLockInset_Y(Tube_OD=Tube_OD);
	Bolt_a=Calc_a(15,(Tube_OD/2));
	
	for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]) {
		rotate([0,0,Bolt_a]) translate([0,Tube_OD/2-Inset_Y,0]) children();
		rotate([0,0,-Bolt_a]) translate([0,Tube_OD/2-Inset_Y,0]) children();
	}
} // Stager_SaucerBoltPattern

//Stager_SaucerBoltPattern() Bolt4ButtonHeadHole();


module Stager_LockRod_Holes(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks){
	// copied from Stager137
	LR_X=Stager_LockRod_X;
	LR_Y=Stager_LockRod_Y;
	LR_Z=Stager_LockRod_Z;
	
	Saucer_H=Saucer_H;
	LockRodDepth=Saucer_H+LockBall_d+1+1;
	SpringDepth=Saucer_H+Stager_Spring_FL-1;
	
	for (j=[0:nLocks-1]) rotate([0, 0, 360/nLocks*j]) 
		translate([0, Tube_OD/2-StagerLockInset_Y(Tube_OD=Tube_OD), 0]){
		
			// BC_LockRod
			translate([0, 0, -LockRodDepth]) RoundRect(X=LR_X+LooseFit, Y=LR_Y+LooseFit, Z=LR_Z+3, R=1+LooseFit/2);
		
			// Spring
			translate([0, 0, -SpringDepth]) translate([0, 1, 0]) 
				cylinder(d=Stager_Spring_OD+LooseFit, h=Stager_Spring_FL);
	}
} // Stager_LockRod_Holes
	
// Stager_LockRod_Holes();

module Stager_Saucer(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks){
	// copied from Stager137
	Len=Saucer_H;
	ID=Saucer_ID(Tube_OD=Tube_OD);
	echo("Saucer ID = ",ID);
	LR_X=Stager_LockRod_X;
	LR_Y=Stager_LockRod_Y;
	LR_Z=Stager_LockRod_Z;
	
	Saucer_IDXtra=IDXtra*4; // was *3
	
	difference(){
		translate([0,0,-Len]) cylinder(d=Tube_OD, h=Len, $fn=$preview? 90:360);
		
		// Cup sits here
		translate([0,0,-SaucerDepth]) 
			cylinder(d1=Tube_OD-SaucerLipInset_ID+Saucer_IDXtra, 
					d2=Tube_OD-SaucerLipInset_OD+Saucer_IDXtra, h=SaucerDepth+Overlap, $fn=$preview? 90:360);
		
		// Center hole
		translate([0,0,-Len-Overlap]) cylinder(d=ID, h=Len, $fn=$preview? 90:360);
		
		translate([0,0,-SaucerDepth]) 
				Stager_SaucerBoltPattern(Tube_OD=Tube_OD, nLocks=nLocks) Bolt4ButtonHeadHole();
		
		Stager_LockRod_Holes(Tube_OD=Tube_OD, nLocks=nLocks);
	} // difference
} // Stager_Saucer

// Stager_Saucer();

module Stager_InnerRace(Tube_OD=DefaultBody_OD){
	
	nBolts=nInnerRaceBolts*4; // allows 15° indexing
	Thickess=5;
	Bearing_Z=8;
	Holes=[5,9,15,19]; // stop mounting holes
	
	difference(){
		union(){
			cylinder(d=BoltCircle_d(Tube_OD=Tube_OD)+Bolt4Inset*2,h=Thickess, $fn=$preview? 90:360);
			
			cylinder(d=MainBearing_ID, h=Bearing_Z+MainBearingSplit, $fn=$preview? 90:360);
			cylinder(d=MainBearing_ID+2, h=Bearing_Z, $fn=$preview? 90:360);
			
		} // union
		
		translate([0,0,-Overlap]) cylinder(d=MainBearing_ID-Bolt4Inset*4, h=Bearing_Z+2+Overlap*2);
		
		// Screw access
		translate([0,MainBearing_OD/2+Bolt4Inset,0]) Bolt4ButtonHeadHole();
		
		// Bolts for LockRing
		for (j=[0:nInnerRaceBolts-1]) rotate([0,0,360/nInnerRaceBolts*j]) 
			translate([MainBearing_ID/2-Bolt4Inset,0,Bearing_Z-4]) rotate([180,0,0]) Bolt4HeadHole();
			
		// Activator and Stop bolt holes
		for (j=Holes) rotate([0,0,360/nBolts*j]) 
			translate([0,BoltCircle_d(Tube_OD=Tube_OD)/2,Thickess])
				Bolt4Hole();
	} // difference
	
	// Key
	translate([0,MainBearing_ID/2-Bolt4Inset*2,0]) cylinder(d=3, h=1);
	
} //Stager_InnerRace

// Stager_InnerRace();
	
module Stager_Mech(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks, Skirt_ID=DefaultBody_ID, Skirt_Len=Default_SkirtLen, nSkirtBolts=4, ShowLocked=true){
	
	Tube_Len=18;
	Race_Z=-Saucer_H-Tube_Len;

	Locked_Ball_X=0; //Stager_LockRod_X/2+LockBall_d/2-2;
	Locked_Ball_Y=Tube_OD/2-StagerLockInset_Y(Tube_OD=Tube_OD)-Stager_LockRod_Y/2-LockBall_d/2+2;
	
	BC_r=BoltCircle_d(Tube_OD=Tube_OD)/2;
	LockingBallDepthAdj=0.4;
	
	UnLocked_Y=ShowLocked? 0:-2;
	
	module ShowBall(){
		color("Red") sphere(d=LockBall_d, $fn=18);
	} // ShowBall
	
	module BackStop(){
		//Race_W=11;
		//Block_H=-Race_Z-Saucer_H-Race_W+Overlap;
		//echo(Block_H=Block_H);
		//Block_W=22;
		Block_H=LockBall_d+5;
		
		module BallPath(){
			// lock/unlock path
			hull(){
				translate([Locked_Ball_X, Locked_Ball_Y+1, -Saucer_H-LockBall_d/2])
					sphere(d=LockBall_d+IDXtra*2);
				
				translate([Locked_Ball_X, Locked_Ball_Y-4, -Saucer_H-LockBall_d/2])
					sphere(d=LockBall_d+IDXtra*2);
			} // hull
		} // BallPath
		
		difference(){
			intersection(){
				hull(){
					// outside
					translate([0, Tube_OD/2, -Saucer_H-Block_H/2]) 
						cube([LockBall_d+Bolt4Inset*10, Overlap, Block_H], center=true);
					// inside
					translate([0, Locked_Ball_Y-LockBall_d/2+1, -Saucer_H-Block_H/2]) 
						cube([LockBall_d+Bolt4Inset*4, Overlap, Block_H], center=true);
				} // hull
				translate([0,0,-Saucer_H-Block_H]) cylinder(d=Tube_OD-1, h=Block_H);
			} // intersection
							
			BallPath();
			
			Stager_LockRod_Holes(Tube_OD=Tube_OD, nLocks=nLocks);
			Stager_SaucerBoltPattern(Tube_OD=Tube_OD, nLocks=nLocks) Bolt4Hole();
		} // difference
		
		if ($preview) 
			translate([Locked_Ball_X, Locked_Ball_Y+UnLocked_Y, -Saucer_H-LockBall_d/2]) ShowBall();
	} // BackStop
	
// *******************

	for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j])
		BackStop();
		
	MainBearing_Z=-Saucer_H-22; // bottom of main bearing
		
	difference(){
		union(){
			// Spring wells
			for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]) 
				translate([0,Tube_OD/2-StagerLockInset_Y(Tube_OD=Tube_OD)+1, -Saucer_H-Stager_Spring_FL])
					cylinder(d=Stager_Spring_OD+5, h=Stager_Spring_CBL);
					
			// Main bearing
			translate([0,0,MainBearing_Z])
				difference(){
					translate([0,0,MainBearingSplit]) cylinder(d=Tube_OD-1, h=MainBearing_T);
										
					cylinder(d=MainBearing_OD+IDXtra*2, h=MainBearing_T);
				} // difference
	
		} // union
		
		// bearing holder Bolts
		nBolts=nLocks*2;
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+180/nBolts])
				translate([0,MainBearing_OD/2+Bolt4Inset,MainBearing_Z]) rotate([180,0,0]) Bolt4Hole();
						
		// Spring wells
		for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]) 
				translate([0,Tube_OD/2-StagerLockInset_Y(Tube_OD=Tube_OD)+1, -Saucer_H-Stager_Spring_FL])
					translate([0,0,2]) cylinder(d=Stager_Spring_OD+LooseFit, h=Stager_Spring_FL);
					
		// center hole
		translate([0,0,-Saucer_H-Tube_Len-Overlap]) 
			cylinder(d=Saucer_ID(Tube_OD=Tube_OD), h=Saucer_H+Tube_Len+Overlap*2, $fn=$preview? 90:360);
	} // difference
	
	
	// The Tube
	difference(){
		nBolts=4;
		Bolt_a=35;
		
		union(){
			translate([0,0,-Saucer_H-Tube_Len]) 
				cylinder(d=Tube_OD, h=Tube_Len, $fn=$preview? 90:360);
			
			// Lower Skirt, connects to E_Bay
			translate([0,0,Race_Z-23-5-Skirt_Len]) 
				Tube(OD=Tube_OD, ID=Skirt_ID, Len=Skirt_Len+6, myfn=$preview? 90:360);
				
			// Upper Skirt
			translate([0,0,Race_Z-23]) 
				Tube(OD=Tube_OD, ID=Tube_OD-4.4, Len=40, myfn=$preview? 90:360);
				
			translate([0,0,Race_Z-23]) 
				TubeStop(InnerTubeID=Skirt_ID-3, OuterTubeOD=Tube_OD, myfn=$preview? 90:360);
				
			// Bolt bosses
			difference(){
				for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+Bolt_a]) translate([0,Skirt_ID/2-Bolt4Inset,Race_Z-23])
					hull(){
						cylinder(d=Bolt4Inset*2, h=5);
						translate([-Bolt4Inset-1,Bolt4Inset+1,0]) cube([Bolt4Inset*2+2,Overlap,5]);
					} // hull
					
				translate([0,0,Race_Z-23-Overlap]) cylinder(d=Skirt_ID-Bolt4Inset*3.25, h=5+Overlap*2);
			} // difference
			
			// Alignment key
			intersection(){
				translate([0,Skirt_ID/2,Race_Z-27]) cylinder(d=4,h=5);
				translate([0,0,Race_Z-27]) cylinder(d=Skirt_ID+1, h=5);
			} // intersection

		} // union
		
		// Rivet holes
		if (nSkirtBolts>0) for (j=[0:nSkirtBolts-1]) rotate([0,0,360/nSkirtBolts*j]) 
			translate([0,Tube_OD/2,Race_Z-23-5-Skirt_Len+7.5]) rotate([-90,0,0]) Bolt4ClearHole();
		
		// Bolts
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+Bolt_a])
			translate([0,Skirt_ID/2-Bolt4Inset,Race_Z-23+5]) Bolt4Hole();
			
		translate([0,0,-Saucer_H-Tube_Len-Overlap]) 
			cylinder(d=Tube_OD-4.0, h=Tube_Len+Overlap*2, $fn=$preview? 90:360);
		
		// Arm / Trigger access hole
		Stager_ArmDisarmAccess(Tube_OD=Tube_OD, Len=Tube_OD);

		//if ($preview) translate([0,0,-100]) cube([50,50,100]);
	} // difference
	
	
} // Stager_Mech

// Stager_Mech();

module Stager_OuterBearingCover(nLocks=Default_nLocks){
	nBolts=nLocks*2;
	Thickness=4;
	
	difference(){
		union(){
			cylinder(d=MainBearing_OD+6, h=Thickness);
			
			// bearing holder Bolts
			hull() for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+180/nBolts])
				translate([0,MainBearing_OD/2+Bolt4Inset,0]) cylinder(d=Bolt4Inset*2, h=Thickness);
		} // union
		
		translate([0,0,-Overlap]) cylinder(d=MainBearing_OD-2, h=Thickness+Overlap*2);
		translate([0,0,-Overlap]) cylinder(d=MainBearing_OD+IDXtra*2, h=MainBearingSplit+Overlap);
		
		for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j+180/nLocks]) translate([0,MainBearing_OD/2+9,-Overlap]) 
			cylinder(d=14, h=Thickness+Overlap*2);
		
		// bearing holder Bolts
			for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+180/nBolts])
				translate([0,MainBearing_OD/2+Bolt4Inset,Thickness]) Bolt4ButtonHeadHole();
	} // difference
} // Stager_OuterBearingCover

//translate([0,0,-25]) rotate([180,0,0]) Stager_OuterBearingCover();

/*
// test
difference(){
	Stager_Mech();
	translate([0,0,-100]) cylinder(d=100, h=63);
}
/**/

module Stager_ArmDisarmAccess(Tube_OD=DefaultBody_OD, Len=DefaultBody_OD){
	Post_Z=-Saucer_H-36;
	
	ArmingPost_a=108;
	
	rotate([0,0,ArmingPost_a]) translate([0,MainBearing_OD/2+4,Post_Z])
			rotate([0,90,0]) cylinder(d=3, h=Len, center=true);
} // Stager_ArmDisarmAccess

//Stager_ArmDisarmAccess();




























