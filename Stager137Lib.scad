// ***********************************
// Project: 3D Printed Rocket
// Filename: Stager137Lib.scad
// by David M. Flynn
// Created: 8/22/2024 
// Revision: 0.9.0  8/22/2024
// Units: mm
// ***********************************
//  ***** Notes *****
//
// Problem to solve: Stager for 137mm tube. A bigger tougher version is needed.
//
// Cup in Saucer w/ locking pins, servo activated active staging system.
//
//
//  ***** History *****
//
echo("Stager137Lib 0.9.0");
// 0.9.0  8/22/2024	   Copied from Stager75BBLib 0.9.6 with bearing from Stager2Lib
//
// ***********************************
//  ***** for STL output *****
//
//  *** Sustainer "Cup" bolts to bottom of sustainer ***
// rotate([180,0,0]) Stager_Cup(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks, BoltsOn=true, Collar_h=16, Offset_a=0);
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
// Stager_Mech(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks, Skirt_ID=DefaultBody_ID, Skirt_Len=Default_SkirtLen, nSkirtBolts=5, ShowLocked=true);
//
// Stager_BallSpacer(Tube_OD=DefaultBody_OD);
//
// Stager_Indexer(Tube_OD=DefaultBody_OD); // Bolts to InnerRace and has mounting holes for Lock Stops
// Stager_InnerRace(Tube_OD=DefaultBody_OD);
// Stager_ServoPlate(Tube_OD=DefaultBody_OD, Skirt_ID=DefaultBody_ID); // Bottom Plate
//
// ***********************************
//  ***** Routines *****
//
// Stager_CupHoles(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks, BoltsOn=true);
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
use<BearingLib.scad>
use<LD-20MGServoLib.scad>
use<SG90ServoLib.scad>
//include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;
Bolt4Inset=4;

// Heavy spring
Stager_Spring_OD=5/16*25.4;
Stager_Spring_FL=1.25*25.4;
Stager_Spring_CBL=0.7*25.4;

Stager_LockRod_X=12;
Stager_LockRod_Y=6;
Stager_LockRod_Z=38;
Stager_LockRod_R=1;
LockBall_d=1/2 * 25.4; // 1/2" Delrin balls
CupBoltHoleInset=4+Bolt4Inset;

Default_nLocks=5;
Default_SkirtLen=16;
DefaultBody_OD=BT137Body_OD;
DefaultBody_ID=BT137Body_ID;

LooseFit=0.8;

nInnerRaceBolts=6;
InnerRaceXtra_W=2;
Saucer_H=6;

// Small Bearing
MR84_Bearing_OD=8;
MR84_Bearing_ID=4;
MR84_Bearing_T=3;

Ball_d=5/16*25.4; // for bearing
PreLoadAdj=-0.45; // -0.35 is too tight
Race_W=11;


function StagerLockInset_Y(D=DefaultBody_OD)=(D>90)? 9:8; // LockRod inset from tube OD
function Calc_a(Dist=1,R=2)=Dist/(R*2*PI)*360;
function Saucer_ID(Tube_OD=DefaultBody_OD)=Tube_OD-StagerLockInset_Y(D=Tube_OD)*2-Stager_LockRod_Y-LockBall_d*2+6;
function BearingBallCircle_d(Tube_OD=DefaultBody_OD)=Tube_OD-40-Ball_d;
function Race_ID(Tube_OD=DefaultBody_OD)=BearingBallCircle_d(Tube_OD=Tube_OD)-Ball_d-Bolt4Inset*4-4;
function Race_BC_d(Tube_OD=DefaultBody_OD)=Race_ID(Tube_OD=Tube_OD)+Bolt4Inset*2; // Bolt holes in inner race
function BoltCircle_d(Tube_OD=DefaultBody_OD)=Tube_OD-StagerLockInset_Y(D=Tube_OD)-21-Bolt4Inset*2; // Bolt circle for LockStops
function nBearingBalls(Tube_OD=DefaultBody_OD)=floor(BearingBallCircle_d(Tube_OD=Tube_OD)*PI/Ball_d/3)+
					(floor(BearingBallCircle_d(Tube_OD=Tube_OD)*PI/Ball_d/3)%2);

// ============================================================================ //

module ShowStager(Tube_OD=DefaultBody_OD, Tube_ID=DefaultBody_ID, nLocks=Default_nLocks){
	
	translate([0,0,30]) Stager_Cup(Tube_OD=Tube_OD, nLocks=nLocks, Collar_h=16, Offset_a=0);
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

	// Shown in the locked position?
	Lock_a=	ShowLocked? 0:Calc_a(11,(BoltCircle_d(Tube_OD=Tube_OD)/2));
						
	
	//translate([0,0,50]) Stager_CupHoles(Tube_OD=Tube_OD, nLocks=Default_nLocks, BoltsOn=true);
	//translate([0,0,50]) 
	//
	translate([0,0,0.4]) Stager_Cup(Tube_OD=Tube_OD, nLocks=Default_nLocks, BoltsOn=true, Collar_h=16, Offset_a=0);
	
	translate([0,0,-Saucer_H-LockBall_d-2+0.2]) rotate([0,0,Lock_a]) Stager_LockRing(Tube_OD=Tube_OD, nLocks=nLocks);

	//*
		difference(){
			Stager_Mech(Tube_OD=Tube_OD, nLocks=nLocks, Skirt_ID=Tube_ID, Skirt_Len=Default_SkirtLen, ShowLocked=ShowLocked);
			rotate([0,0,-38-180]) translate([0,0,-90]) cube([100,100,100]);
		}
	
	/**/

	//*
	//
	translate([0,0,0.2]) Stager_Saucer();
	
	//
	translate([0,0,-Saucer_H-LockBall_d-2-Race_W-InnerRaceXtra_W-22-0.3]) Stager_ServoPlate(Tube_OD=Tube_OD, Skirt_ID=Tube_ID);

	
	
	rotate([0,0,Lock_a]){
		InnerRace_Z=-Saucer_H-LockBall_d-2-Race_W-InnerRaceXtra_W/2;
		
		translate([0,0,-Saucer_H-LockBall_d-2-Race_W-InnerRaceXtra_W-0.1]) Stager_Indexer();
		
		translate([0,0,InnerRace_Z]) color("LightBlue") 
		   Stager_InnerRace(Tube_OD=Tube_OD);

		Stop_Z= -Saucer_H-LockBall_d-2-Race_W-InnerRaceXtra_W-5-0.2;
		
		translate([0,0,Stop_Z]) 
			rotate([0,180,-45-60]) color("Tan") Stager_LockStop(Tube_OD=Tube_OD, HasMagnet=true);
			
		translate([0,0,Stop_Z]) 
			rotate([0,180,-15-60+180]) color("Tan") Stager_LockStop(Tube_OD=Tube_OD, HasMagnet=false);
	}
	/**/
					
} // ShowStagerAssy

//ShowStagerAssy(ShowLocked=true);
//ShowStagerAssy(ShowLocked=false);
//ShowStagerAssy(Tube_OD=BT98Body_OD, Tube_ID=BT98Body_ID, nLocks=Default_nLocks, ShowLocked=true);

module Stager_BallSpacer(Tube_OD=DefaultBody_OD){
	Thickness=1.5;
	nBalls=nBearingBalls(Tube_OD=Tube_OD);
	//echo(nBalls=nBalls);
	
	difference(){
		cylinder(d=BearingBallCircle_d(Tube_OD=Tube_OD)+Ball_d*0.6, h=Ball_d/2+Thickness);
		
		// center hole
		translate([0,0,-Overlap]) cylinder(d=BearingBallCircle_d(Tube_OD=Tube_OD)-Ball_d*0.6, h=Ball_d/2+Thickness+Overlap*2);
		
		for (j=[0:nBalls-1]) rotate([0,0,360/nBalls*j]) translate([BearingBallCircle_d(Tube_OD=Tube_OD)/2,0,Ball_d/2+Thickness])
			sphere(d=Ball_d+LooseFit, $fn=36);
			
		for (j=[0:nBalls/2-1]) rotate([0,0,720/nBalls*j-180/nBalls]){
			translate([BearingBallCircle_d(Tube_OD=Tube_OD)/2,0,0]) rotate([180,0,0]) Bolt2Hole();
			rotate([0,0,360/nBalls]) translate([BearingBallCircle_d(Tube_OD=Tube_OD)/2,0,0]) rotate([180,0,0]) Bolt2HeadHole();
		}
	} // difference
} // Stager_BallSpacer

//Stager_BallSpacer();

module Stager_ServoPlate(Tube_OD=DefaultBody_OD, Skirt_ID=DefaultBody_ID){
											
	BC_r=BoltCircle_d(Tube_OD=Tube_OD)/2;
	
	nBolts=4;
	Bolt_a=35;
	Exit_a=75;
	Servo_X= -Tube_OD/2+28;
	Servo_Y=0;
	Servo_Z=-10;
	Servo_a=8;
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
	
	module LanyardAttachmentPoint(){
		Ly_OD=25;
		Ly_t=5;
		HoleCenter_Z=Ly_t+3;
		Offset_Y=0;
		Offset_X=5;
		
		difference(){
			union(){
				hull(){
					translate([Offset_X,Offset_Y,HoleCenter_Z]) rotate([90,0,0]) cylinder(d=10, h=4, center=true);
					translate([Offset_X,Offset_Y,Ly_t]) cube([12,4,Overlap],center=true);
				} // hull
				translate([Offset_X,Offset_Y,0]) cylinder(d=Ly_OD, h=Ly_t);
			} // union
			
			translate([Offset_X,Offset_Y,HoleCenter_Z]) rotate([90,0,0]) cylinder(d=4, h=4+Overlap*2, center=true);
		} // difference
	} // LanyardAttachmentPoint
	
	LanyardAttachmentPoint();
	
	module StopBlock(LockedBlock=true){
		Block_H=12.5;
		Block_T=4;
		BlockOffset=LockedBlock? Block_T/2+3:-Block_T/2-3;
		Offset_Y=0;
		
		difference(){
			translate([BlockOffset,BC_r+Offset_Y,Block_H/2]) cube([Block_T,12,Block_H],center=true);
			
			translate([BlockOffset,BC_r,7+Magnet_d/2]) rotate([0,90,0]) cylinder(d=Magnet_d, h=Block_T+1, center=true);
			
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
						
						translate([Al_Tube_X,Al_Tube_Y,Al_Tube_Z]) rotate([90,0,Al_Tube_a]) cylinder(d=Al_Tube_d, h=Skirt_ID+6, center=true);
						translate([Al_Tube_X,Al_Tube_Y,Al_Tube_Z]) rotate([90,0,Al_Tube_a]) cylinder(d=Al_Tube_d+17, h=20, center=true);
					} // difference
					
					translate([0,0,Al_Tube_Z-Al_Tube_d/2-4]) cylinder(d=Skirt_ID-7, h=Al_Tube_d+8);
				} // intersection
			}
			
			// Servo base
			rotate([0,0,Servo_a]) translate([Servo_X+10,Servo_Y,-5]) cube([60,25,10],center=true);
			
			// Locked position stop
			rotate([0,0,Stop_a]) StopBlock(LockedBlock=true); //cylinder(d=8, h=10);
			
			// Unlocked position stop, allow 10mm of movement
			rotate([0,0,BackStop_a]) StopBlock(LockedBlock=false); //cylinder(d=8, h=8.5);
			
		} // union
		
		// Servo
		rotate([0,0,Servo_a]) translate([Servo_X,Servo_Y,0]) 
			rotate([0,0,180]) translate([0,0,Servo_Z]) Servo_LD20MG(BottomMount=true,TopAccess=false);
		
		// mounting bolts
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+Bolt_a]) translate([0,Skirt_ID/2-Bolt4Inset,0])
			rotate([180,0,0]) Bolt4ButtonHeadHole();
		
		// Alignment Key
		translate([0,Skirt_ID/2,-Overlap]) cylinder(d=5, h=5+Overlap*2);
	} // difference
	
} // Stager_ServoPlate

// Stager_ServoPlate();


module Stager_LockRing(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks, FlexComp_d=0.0){
	BC_r=Race_BC_d(Tube_OD=Tube_OD)/2;
	nBolts=nInnerRaceBolts;
	OD=Tube_OD-StagerLockInset_Y(D=Tube_OD)*2-Stager_LockRod_Y-LockBall_d*2+4;
	Depth=3;
	Inset=0.0;
	nSteps=15;
	Arc_a=Calc_a(9,(OD/2-Inset));
	echo(Arc_a=Arc_a);
	Large_ID=OD-16; // center hole ID
	Small_ID=Race_BC_d(Tube_OD=Tube_OD)-Bolt4Inset*2;
	
	// center of ball in locked position
	Locked_Ball_Y=Tube_OD/2-StagerLockInset_Y(D=Tube_OD)-Stager_LockRod_Y/2-LockBall_d/2+2+FlexComp_d/2;
		
	LockHead_H=LockBall_d+4;
	Ball_Z=LockHead_H/2;
	
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
	
	FullD_Z=5;
	
	difference(){
		cylinder(d=OD, h=LockHead_H, $fn=$preview? 90:360);
		
		for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j])
			translate([0,0,Ball_Z]) Bearing();
			
		// center hole
		translate([0,0,LockHead_H-1]) cylinder(d1=Large_ID, d2=Large_ID+1, h=1+Overlap, $fn=$preview? 90:360); // chamfer
		translate([0,0,FullD_Z]) cylinder(d=Large_ID, h=LockHead_H, $fn=$preview? 90:360); // top
		translate([0,0,-Overlap]) cylinder(d=Small_ID, h=LockHead_H, $fn=$preview? 90:360); // bottom
		
		// Bolts
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+180/nBolts]) 
			translate([0,BC_r,6]) Bolt4HeadHole();
			
		// Key
		translate([0,Small_ID/2,-Overlap]) cylinder(d=3, h=1);
		
	} // difference
	
	if ($preview) color("Red") for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j])
			translate([0, Locked_Ball_Y-LockBall_d/2-MR84_Bearing_OD/2, Ball_Z]) 
				cylinder(d=MR84_Bearing_OD, h=MR84_Bearing_T, center=true);
} // Stager_LockRing

//translate([0,0,-Saucer_H-LockBall_d-2+0.2]) Stager_LockRing();

module Stager_LockStop(Tube_OD=DefaultBody_OD, HasMagnet=true){
	BC_r=BoltCircle_d(Tube_OD=Tube_OD)/2;
	nBottomBolts=12;
	Plate_H=4;
	Stop_a=Calc_a(8,BC_r);
	Magnet_OD=3/16*25.4;
	Block_H=11;
	Block_Len=HasMagnet? 8:13;
	ServoWheelHub_d=13;
			
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
				translate([0,BC_r-6,Plate_H]) cylinder(d=ServoWheelHub_d, h=Block_H);
				translate([0,BC_r-2,Plate_H]) cylinder(d=ServoWheelHub_d, h=Block_H);
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
	LockOffset_Z=-5;

	translate([0,-LR_Y/2,LR_Z+LockOffset_Z]) rotate([90,0,0]) children();
	translate([0,-LR_Y/2,LR_Z+LockOffset_Z-8]) rotate([90,0,0]) children();
	
} // Stager_LockRodBoltPattern

//Stager_LockRodBoltPattern() Bolt6Hole();

module Stager_LockRod(Adj=0){
	LR_X=Stager_LockRod_X;
	LR_Y=Stager_LockRod_Y;
	LR_Z=Stager_LockRod_Z;
	Lock_Z=LockBall_d/2+1;
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

module Stager_CupHoles(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks, BoltsOn=true, Offset_a=0){
	Collar_h=18;
	nBolts=nLocks*4;
	ID=Tube_OD-22;
	
	difference(){
		translate([0,0,-Overlap]) cylinder(d=Tube_OD+1, h=Collar_h+Overlap, $fn=$preview? 90:360); // test
		translate([0,0,-Overlap*2]) cylinder(d=ID-IDXtra*2, h=Collar_h+Overlap*4, $fn=$preview? 90:360); 
	} // difference
	
	translate([0,0,-14]) rotate([0,0,Offset_a]) Stager_LockRod_Holes(Tube_OD=Tube_OD, nLocks=nLocks);
	
	// BoltHoles
	if (BoltsOn)
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+180/nBolts]) 
			translate([0,Tube_OD/2-CupBoltHoleInset,Collar_h]) 
				rotate([180,0,0]) Bolt4Hole(depth=12);
} // Stager_CupHoles

//Stager_CupHoles();

module Stager_Cup(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks, BoltsOn=true, Collar_h=16, Offset_a=0){

	Len=3;
	LR_X=Stager_LockRod_X;
	LR_Y=Stager_LockRod_Y;
	LR_Z=Stager_LockRod_Z;
	nBolts=nLocks*4;
	ID=Tube_OD-22;
	LockRodOffset_Z=-20;
	
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
		Stager_LockRod_Holes(Tube_OD=Tube_OD, nLocks=nLocks, Offset_a=Offset_a);
		
		if (nLocks>0)
		for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j+Offset_a]) 
			translate([0,Tube_OD/2-StagerLockInset_Y(D=Tube_OD),LockRodOffset_Z])
				Stager_LockRodBoltPattern() Bolt6Hole(depth=StagerLockInset_Y(D=Tube_OD)+4);
		
		// wire path only, for sustainer ignition
		rotate([0,0,-180/nLocks+Offset_a])
			translate([0,Tube_OD/2-2.2-3.5,-2-Overlap]){
				cylinder(d=7, h=Collar_h+Len+2+Overlap*2);
				hull(){
					cylinder(d=7, h=3);
					translate([0,-10,0]) cylinder(d=7, h=3);
				} // hull
			} // translate
		
	} // difference
	
	if ($preview && (nLocks>0))
		for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j+Offset_a]) translate([0, Tube_OD/2-StagerLockInset_Y(D=Tube_OD),LockRodOffset_Z])
				color("Orange") Stager_LockRod();
} // Stager_Cup

// translate([0,0,Overlap]) Stager_Cup(ID=BT54Body_ID);
// rotate([180,0,0]) Stager_Cup(ID=BT54Body_ID); // STL test

module Stager_SaucerBoltPattern(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks){
	Inset_Y=StagerLockInset_Y(D=Tube_OD);
	Bolt_a=Calc_a(15,(Tube_OD/2));
	
	for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]) {
		rotate([0,0,Bolt_a]) translate([0,Tube_OD/2-Inset_Y,0]) children();
		rotate([0,0,-Bolt_a]) translate([0,Tube_OD/2-Inset_Y,0]) children();
	}
} // Stager_SaucerBoltPattern

//Stager_SaucerBoltPattern() Bolt4ButtonHeadHole();

module Stager_LockRod_Holes(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks, Offset_a=0){
	LR_X=Stager_LockRod_X;
	LR_Y=Stager_LockRod_Y;
	LR_Z=Stager_LockRod_Z;
	
	Saucer_H=Saucer_H;
	
	for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j+Offset_a]) 
		translate([0,Tube_OD/2-StagerLockInset_Y(D=Tube_OD), -Saucer_H-12-Overlap]){
		
			// BC_LockRod
			RoundRect(X=LR_X+LooseFit, Y=LR_Y+LooseFit, Z=LR_Z+12, R=1+LooseFit/2);
		
			// Spring
			translate([0,1,-Stager_Spring_CBL]) cylinder(d=Stager_Spring_OD+LooseFit, h=Stager_Spring_FL);
	}
} // Stager_LockRod_Holes
	
//Stager_LockRod_Holes();

module Stager_Saucer(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks){
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
		translate([0,0,-2]) cylinder(d1=Tube_OD-8+Saucer_IDXtra, d2=Tube_OD-4+Saucer_IDXtra, h=2+Overlap, $fn=$preview? 90:360);
		
		// Center hole
		translate([0,0,-Len-Overlap]) cylinder(d=ID, h=Len, $fn=$preview? 90:360);
		
		if (nLocks>0)
			translate([0,0,-2]) 
				Stager_SaucerBoltPattern(Tube_OD=Tube_OD, nLocks=nLocks) Bolt4ButtonHeadHole();
		
		if (nLocks>0)
			Stager_LockRod_Holes(Tube_OD=Tube_OD, nLocks=nLocks);
		
	} // difference
	
} // Stager_Saucer

// Stager_Saucer();

module Stager_Indexer(Tube_OD=DefaultBody_OD){
	
	nBolts=24; // allows 15° indexing
	Thickess=5;
	Bearing_Z=5;
	Holes=[6,8,16,18]; // stop mounting holes
	
	translate([0,0,-Bearing_Z])
	difference(){
		union(){
			cylinder(d=BoltCircle_d(Tube_OD=Tube_OD)+Bolt4Inset*2,h=Thickess, $fn=$preview? 90:360);
			
			cylinder(d=Race_BC_d(Tube_OD=Tube_OD)+Bolt4Inset*2, h=Bearing_Z, $fn=$preview? 90:360);
			
			
		} // union
		
		// Center hole
		translate([0,0,-Overlap]) cylinder(d=Race_ID(Tube_OD=Tube_OD), h=Bearing_Z+2+Overlap*2);
				
		// Bolts for inner race
		for (j=[0:nInnerRaceBolts-1]) rotate([0,0,360/nInnerRaceBolts*j]) 
			translate([0,Race_BC_d(Tube_OD=Tube_OD)/2,Bearing_Z-6]) rotate([180,0,0]) Bolt4HeadHole();
			
		// Activator and Stop bolt holes
		for (j=Holes) rotate([0,0,360/nBolts*j]) 
			translate([0,BoltCircle_d(Tube_OD=Tube_OD)/2,Thickess])
				Bolt4Hole();
	} // difference
	
	// Key
	translate([0,Race_ID(Tube_OD=Tube_OD)/2,-Bearing_Z]) cylinder(d=3, h=1);
	
} //Stager_Indexer

//translate([0,0,-Saucer_H-LockBall_d-2-Race_W-InnerRaceXtra_W/2-8]) Stager_Indexer();



module Stager_InnerRace(Tube_OD=DefaultBody_OD){
	nBolts=12;
	
	difference(){
		translate([0,0,-InnerRaceXtra_W/2])
			OnePieceInnerRace(BallCircle_d=BearingBallCircle_d(Tube_OD=Tube_OD), Race_ID=Race_ID(Tube_OD=Tube_OD), Ball_d=Ball_d, 
						Race_w=Race_W+InnerRaceXtra_W, PreLoadAdj=PreLoadAdj, 
						VOffset=0.00, BI=false, myFn=$preview? 90:720);
		
			
		// Activator and Stop bolt holes
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) 
			translate([0,Race_BC_d(Tube_OD=Tube_OD)/2,Race_W+InnerRaceXtra_W/2])
				Bolt4Hole(depth=Race_W+InnerRaceXtra_W);
	} // difference
	
} //Stager_InnerRace

// translate([0,0,-Saucer_H-LockBall_d-2-Race_W-InnerRaceXtra_W/2]) Stager_InnerRace(Tube_OD=DefaultBody_OD);
	
module Stager_Mech(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks, Skirt_ID=DefaultBody_ID, Skirt_Len=Default_SkirtLen, nSkirtBolts=4, ShowLocked=true){
		
	Len=Saucer_H;
	ID=Saucer_ID(Tube_OD=Tube_OD);
	Raceway_Len=44;
	Raceway_Z=-49;
	Tube_Len=10+LockBall_d;
	Race_Z=-Saucer_H-LockBall_d-2-Race_W-InnerRaceXtra_W/2;

	Locked_Ball_X=0; //Stager_LockRod_X/2+LockBall_d/2-2;
	Locked_Ball_Y=Tube_OD/2-StagerLockInset_Y(D=Tube_OD)-Stager_LockRod_Y/2-LockBall_d/2+2;
	
	BC_r=BoltCircle_d(Tube_OD=Tube_OD)/2;
	LockingBallDepthAdj=0.4;
	Cable_Offset_a=15*round((-60+Calc_a(12,BC_r)+Calc_a(26,BC_r) )/15);
	//echo(Cable_Offset_a=Cable_Offset_a);	
	
	UnLocked_Y=ShowLocked? 0:-2;
	
	module ShowBall(){
		color("Red") sphere(d=LockBall_d, $fn=18);
	} // ShowBall
	
	module BackStop(){
		Block_W=24;
		Block_H=LockBall_d+5;
		
		module BallPath(){
			// lock/unlock path
			hull(){
				translate([Locked_Ball_X, Locked_Ball_Y+1, -LockBall_d/2])
					sphere(d=LockBall_d+IDXtra*2);
				
				translate([Locked_Ball_X, Locked_Ball_Y-4, -LockBall_d/2])
					sphere(d=LockBall_d+IDXtra*2);
			} // hull
		} // BallPath
		
		difference(){
			intersection(){
				translate([0,Tube_OD/2-StagerLockInset_Y(D=Tube_OD),-Block_H/2]) 
					cube([Tube_OD,Block_W,Block_H], center=true);
				translate([0,0,-Block_H]) cylinder(d=Tube_OD-1, h=Block_H);
			} // intersection
			
			// center hole
			translate([0,0,-Block_H-Overlap])
				cylinder(d=ID, h=Block_H+Overlap*2);
				
			BallPath();
			
			translate([0,0,5]) Stager_LockRod_Holes(Tube_OD=Tube_OD, nLocks=nLocks);
			Stager_SaucerBoltPattern(Tube_OD=Tube_OD, nLocks=nLocks) Bolt4Hole();
		} // difference
		
		if ($preview) 
			translate([Locked_Ball_X, Locked_Ball_Y+UnLocked_Y, -LockBall_d/2]) ShowBall();
	} // BackStop
	
// *******************

	for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j])
		translate([0,0,-Len]) BackStop();
		
	MainBearing_Z=-Len-22; // bottom of main bearing
		
	difference(){
		union(){
			translate([0,0,Race_Z])
			OnePieceOuterRace(BallCircle_d=BearingBallCircle_d(Tube_OD=Tube_OD), Race_OD=Tube_OD, 
					Ball_d=Ball_d, Race_w=Race_W, PreLoadAdj=PreLoadAdj, 
					VOffset=0.00, BI=false, myFn=$preview? 90:720);

	
			// Spring wells
			for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]) 
				translate([0,Tube_OD/2-StagerLockInset_Y(D=Tube_OD)+1, -Len-Stager_Spring_FL])
					cylinder(d=Stager_Spring_OD+5, h=Stager_Spring_CBL);
		} // union
						
		// Spring wells
		for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]) 
				translate([0,Tube_OD/2-StagerLockInset_Y(D=Tube_OD)+1, -Len-Stager_Spring_FL])
					translate([0,0,2]) cylinder(d=Stager_Spring_OD+LooseFit, h=Stager_Spring_FL);
					
	} // difference
	
	Plate_Z=Race_Z-18.5;
	
	// The Tube
	difference(){
		nBolts=4;
		Bolt_a=35;
		
		union(){
			// Lower Skirt, connects to E_Bay
			translate([0,0,Plate_Z-5-Skirt_Len]) 
				Tube(OD=Tube_OD, ID=Skirt_ID, Len=Skirt_Len+6, myfn=$preview? 90:360);
				
			// Upper Skirt
			translate([0,0,Plate_Z]) 
				Tube(OD=Tube_OD, ID=Tube_OD-4.4, Len=-Plate_Z-Saucer_H, myfn=$preview? 90:360);
				
			translate([0,0,Plate_Z]) 
				TubeStop(InnerTubeID=Skirt_ID-3, OuterTubeOD=Tube_OD, myfn=$preview? 90:360);
				
			// Bolt bosses
			difference(){
				for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+Bolt_a]) translate([0,Skirt_ID/2-Bolt4Inset,Plate_Z])
					hull(){
						cylinder(d=Bolt4Inset*2, h=5);
						translate([-Bolt4Inset-1,Bolt4Inset+1,0]) cube([Bolt4Inset*2+2,Overlap,5]);
					} // hull
					
				translate([0,0,Plate_Z-Overlap]) cylinder(d=Skirt_ID-Bolt4Inset*3.25, h=5+Overlap*2);
			} // difference
			
			// Alignment key
			intersection(){
				translate([0,Skirt_ID/2,Plate_Z-4]) cylinder(d=4,h=5);
				translate([0,0,Plate_Z-4]) cylinder(d=Skirt_ID+1, h=5);
			} // intersection

		} // union
		
		// Rivet holes
		if (nSkirtBolts>0) for (j=[0:nSkirtBolts-1]) rotate([0,0,360/nSkirtBolts*j]) 
			translate([0,Tube_OD/2,Plate_Z-5-Skirt_Len+7.5]) rotate([-90,0,0]) Bolt4ClearHole();
		
		// Bolts
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+Bolt_a])
			translate([0,Skirt_ID/2-Bolt4Inset,Plate_Z+5]) Bolt4Hole();
			
		//translate([0,0,-Len-Tube_Len-Overlap]) 
		//	cylinder(d=Tube_OD-4.0, h=Tube_Len+Overlap*2, $fn=$preview? 90:360);
		
		// Arm / Trigger access hole
		Stager_ArmDisarmAccess(Tube_OD=Tube_OD, Len=Tube_OD);

		//if ($preview) translate([0,0,-100]) cube([Tube_OD/2,Tube_OD/2,100]);
	} // difference
	

} // Stager_Mech

// Stager_Mech();

module Stager_ArmDisarmAccess(Tube_OD=DefaultBody_OD, Len=DefaultBody_OD){
	Post_Z=-Saucer_H-41;
	
	ArmingPost_a=108;
	
	rotate([0,0,ArmingPost_a]) translate([0,BoltCircle_d(Tube_OD=Tube_OD)/2+4,Post_Z])
			rotate([0,90,0]) cylinder(d=3, h=Len, center=true);
} // Stager_ArmDisarmAccess

//Stager_ArmDisarmAccess();




























