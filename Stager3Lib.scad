// ***********************************
// Project: 3D Printed Rocket
// Filename: Stager3Lib.scad
// by David M. Flynn
// Created: 8/22/2024 
// Revision: 0.9.8  9/3/2024
// Units: mm
// ***********************************
//  ***** Notes *****
//
// Problem to solve: Stager for 137mm tube. A bigger tougher version is needed.
//
// Cup in Saucer w/ locking pins, servo activated active staging system.
//
//  ***** History *****
//
echo("Stager3Lib 0.9.8");
// 0.9.8  9/3/2024     Fixed some math in Stager_Cup() and Stager_ArmDisarmAccess()
// 0.9.7  8/29/2024    Made OverCenter a parameter in Stager_ServoPlate()
// 0.9.6  8/28/2024	   Fixed hole depth in Mech, Changed to "Stager3Lib"
// 0.9.5  8/26/2024	   Now the same as Stager98
// 0.9.4  8/25/2024	   Reworked Stager_Cup() now lighter and cleaner, code cleanup, FC1
// 0.9.3  8/24/2024    Reduced the mass of Stager_Mech with slots in the outer race. Stager_Cup bolt pattern changed.
// 0.9.2  8/23/2024	   Made lock rod holes 3mm deeper.
// 0.9.1  8/23/2024    All stops are now if fixed positions (fewer parts).
// 0.9.0  8/22/2024	   Copied from Stager75BBLib 0.9.6 with bearing from Stager2Lib
//
// ***********************************
//  ***** for STL output *****
//
//  *** Sustainer "Cup" bolts to bottom of sustainer ***
// rotate([180,0,0]) Stager_Cup(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks, BoltsOn=true, Collar_h=DefaultCollarLen);
// rotate([-90,0,0]) Stager_LockRod(Adj=0.5); // Looser
// rotate([-90,0,0]) Stager_LockRod(Adj=0.0); // This works!
//
// Stager_Saucer(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks); // Bolts on
//
// Stager_LockRing(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks, FlexComp_d=0.0); 
//
//  *** Main Body ***
// Stager_Mech(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks, Skirt_ID=DefaultBody_ID, Skirt_Len=Default_SkirtLen, nSkirtBolts=Default_nSkirtBolts, ShowLocked=true);
//
// Stager_BallSpacer(Tube_OD=DefaultBody_OD); // print 2
//
// Stager_InnerRace(Tube_OD=DefaultBody_OD);
// rotate([180,0,0]) Stager_Indexer(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks); // Bolts to InnerRace
// Stager_ServoPlate(Tube_OD=DefaultBody_OD, Skirt_ID=DefaultBody_ID, nLocks=Default_nLocks, OverCenter=IDXtra+0.8, HasAlTube=false); // Bottom Plate
//
// ***********************************
//  ***** Routines *****
//
// Stager_CupHoles(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks, BoltsOn=true);
// Stager_LockRod_Holes(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks);
// Stager_SaucerBoltPattern(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks);
// Stager_ArmDisarmAccess(Tube_OD=DefaultBody_OD, Len=DefaultBody_OD, nLocks=Default_nLocks);
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
//include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;
Bolt4Inset=4;

// Heavy spring
Stager_Spring_OD=5/16*25.4;
Stager_Spring_FL=1.25*25.4;
Stager_Spring_CBL=0.7*25.4;

Stager_LockRodTipXtra=1;

/*
// for Stager 98
Stager_LockRod_X=10;
Stager_LockRod_Y=5;
Stager_LockRod_Z=36;
Stager_LockRod_R=1;
LockBall_d=3/8 * 25.4; // 3/8" Delrin balls
Default_nLocks=3;
CupBoltsPerLock=2;
DefaultBody_OD=BT98Body_OD;
DefaultBody_ID=BT98Body_ID;
/**/
//*
// for Stager 137
Stager_LockRod_X=12;
Stager_LockRod_Y=6;
Stager_LockRod_Z=38;
Stager_LockRod_R=1;
LockBall_d=1/2 * 25.4; // 1/2" Delrin balls
Default_nLocks=5;
CupBoltsPerLock=3;
DefaultBody_OD=BT137Body_OD;
DefaultBody_ID=BT137Body_ID;
/**/

Default_nSkirtBolts=5;
Default_SkirtLen=16;
DefaultCollarLen=16;

LooseFit=0.8;

nInnerRaceBolts=6;
InnerRaceXtra_W=2; //Makes inner race thicker than the outer race and ball spacers.

Saucer_H=6;
SaucerDepth=2;
SaucerLipInset_ID=8;
SaucerLipInset_OD=4;
SaucerClearance=0.3; // shorten bottom of cup
CupBoltHoleInset=SaucerLipInset_ID/2+Bolt4Inset;
StagerCupLen=3; // Length of cup without skirt

// Small Bearing
MR84_Bearing_OD=8;
MR84_Bearing_ID=4;
MR84_Bearing_T=3;

Ball_d=5/16*25.4; // for bearing
PreLoadAdj=-0.45; // -0.35 is too tight
Race_W=11;
Magnet_d=3/16*25.4;
StopBlock_W=6;

function StagerLockInset_Y(Tube_OD=DefaultBody_OD)=(Tube_OD>90)? 9:8; // center of LockRod inset from tube OD
function Calc_a(Dist=1,R=2)=Dist/(R*2*PI)*360;
function Saucer_ID(Tube_OD=DefaultBody_OD)=Tube_OD-StagerLockInset_Y(Tube_OD=Tube_OD)*2-Stager_LockRod_Y-LockBall_d*2+6;
function BearingBallCircle_d(Tube_OD=DefaultBody_OD)=Tube_OD-40-Ball_d;
function Race_ID(Tube_OD=DefaultBody_OD)=BearingBallCircle_d(Tube_OD=Tube_OD)-Ball_d-Bolt4Inset*4-4;
function Race_BC_d(Tube_OD=DefaultBody_OD)=Race_ID(Tube_OD=Tube_OD)+Bolt4Inset*2; // Bolt holes in inner race
function BoltCircle_d(Tube_OD=DefaultBody_OD)=
				Tube_OD-StagerLockInset_Y(Tube_OD=Tube_OD)-21-Bolt4Inset*2; // Bolt circle for LockStops
function nBearingBalls(Tube_OD=DefaultBody_OD)=floor(BearingBallCircle_d(Tube_OD=Tube_OD)*PI/Ball_d/3)+
					(floor(BearingBallCircle_d(Tube_OD=Tube_OD)*PI/Ball_d/3)%2);

// ============================================================================ //

module ShowStager(Tube_OD=DefaultBody_OD, Tube_ID=DefaultBody_ID, nLocks=Default_nLocks){
	
	translate([0,0,30]) Stager_Cup(Tube_OD=Tube_OD, nLocks=nLocks, Collar_h=DefaultCollarLen);
	translate([0,0,10]) color("LightBlue") Stager_Saucer(Tube_OD=Tube_OD, nLocks=nLocks);
	Stager_Mech(Tube_OD=Tube_OD, nLocks=nLocks, Skirt_ID=Tube_ID, Skirt_Len=Default_SkirtLen);
	
	translate([0,0,-140]) Stager_LockRing(Tube_OD=Tube_OD, nLocks=nLocks);
	
	//*
	translate([0,0,-150]) {
		translate([20,0,-40]) rotate([180,0,120]) Stager_LockStop(Tube_OD=Tube_OD);
		translate([0,0,-10]) Stager_InnerRace(Tube_OD=Tube_OD);
		
	}
	/**/
	translate([0,0,-210]) Stager_ServoPlate(Tube_OD=DefaultBody_OD, Skirt_ID=DefaultBody_ID, nLocks=Default_nLocks, HasAlTube=false);		
	
} // ShowStager

// ShowStager();
// ShowStager(Tube_OD=DefaultBody_OD, Tube_ID=DefaultBody_ID, nLocks=Default_nLocks);

module ShowStagerAssy(Tube_OD=DefaultBody_OD, Tube_ID=DefaultBody_ID, nLocks=Default_nLocks, ShowLocked=true){

	// Shown in the locked position?
	Lock_a=	ShowLocked? 0:Calc_a(11,(BoltCircle_d(Tube_OD=Tube_OD)/2));
						 
	//Stager_CupHoles(Tube_OD=Tube_OD, nLocks=Default_nLocks, BoltsOn=true);
	
	//translate([0,0,0.4]) Stager_Cup(Tube_OD=Tube_OD, nLocks=nLocks, BoltsOn=true, Collar_h=DefaultCollarLen);
	
	//translate([0,0,0.2]) Stager_Saucer(Tube_OD=Tube_OD, nLocks=nLocks);
	
	translate([0,0,-Saucer_H-LockBall_d-2+0.2]) rotate([0,0,Lock_a]) Stager_LockRing(Tube_OD=Tube_OD, nLocks=nLocks);

	//*
	difference(){
		Stager_Mech(Tube_OD=Tube_OD, nLocks=nLocks, Skirt_ID=Tube_ID, Skirt_Len=Default_SkirtLen, ShowLocked=ShowLocked);
		rotate([0,0,-38-180-90]) translate([0,0,-90]) cube([100,100,100]);
	}
	/**/
	
	translate([0,0,-Saucer_H-LockBall_d-2-Race_W-InnerRaceXtra_W-19-0.3]) 
		Stager_ServoPlate(Tube_OD=DefaultBody_OD, Skirt_ID=DefaultBody_ID, nLocks=Default_nLocks, HasAlTube=false);

	rotate([0,0,Lock_a]){
		InnerRace_Z=-Saucer_H-LockBall_d-2-Race_W-InnerRaceXtra_W/2;
		
		translate([0,0,-Saucer_H-LockBall_d-2-Race_W-InnerRaceXtra_W-0.1]) 
			Stager_Indexer(Tube_OD=Tube_OD, nLocks=nLocks);
		
		translate([0,0,InnerRace_Z]) color("LightBlue") 
		   Stager_InnerRace(Tube_OD=Tube_OD);
	}
					
} // ShowStagerAssy

//ShowStagerAssy(ShowLocked=true);
//ShowStagerAssy(ShowLocked=false);
//ShowStagerAssy(Tube_OD=BT98Body_OD, Tube_ID=BT98Body_ID, nLocks=3, ShowLocked=true);
//ShowStagerAssy(Tube_OD=PML150Body_OD, Tube_ID=PML150Body_ID, nLocks=5, ShowLocked=true);

module Stager_BallSpacer(Tube_OD=DefaultBody_OD){
	Thickness=1.5;
	nBalls=nBearingBalls(Tube_OD=Tube_OD);
	//echo(nBalls=nBalls);
	
	difference(){
		cylinder(d=BearingBallCircle_d(Tube_OD=Tube_OD)+Ball_d*0.6, h=Ball_d/2+Thickness, $fn=$preview? 90:360);
		
		// center hole
		translate([0,0,-Overlap]) 
			cylinder(d=BearingBallCircle_d(Tube_OD=Tube_OD)-Ball_d*0.6, h=Ball_d/2+Thickness+Overlap*2, $fn=$preview? 90:360);
		
		for (j=[0:nBalls-1]) rotate([0,0,360/nBalls*j]) translate([BearingBallCircle_d(Tube_OD=Tube_OD)/2,0,Ball_d/2+Thickness])
			sphere(d=Ball_d+LooseFit, $fn=36);
			
		for (j=[0:nBalls/2-1]) rotate([0,0,720/nBalls*j-180/nBalls]){
			translate([BearingBallCircle_d(Tube_OD=Tube_OD)/2,0,0]) rotate([180,0,0]) Bolt2Hole();
			rotate([0,0,360/nBalls]) translate([BearingBallCircle_d(Tube_OD=Tube_OD)/2,0,0]) rotate([180,0,0]) Bolt2HeadHole();
		}
	} // difference
} // Stager_BallSpacer

// Stager_BallSpacer();

module Stager_ServoPlate(Tube_OD=DefaultBody_OD, Skirt_ID=DefaultBody_ID, nLocks=Default_nLocks, OverCenter=IDXtra+0.8, HasAlTube=false){
											
	BC_r=BoltCircle_d(Tube_OD=Tube_OD)/2;
	
	nBolts=4;
	Plate_t=5;
	Bolt_a=35;
	Servo_X= -Tube_OD/2+28;
	Servo_Y=0;
	Servo_Z=-10;
	Servo_a=-90+180/nLocks*3-10;
	
	Al_Tube_d=12.7;
	Al_Tube_Z=-Al_Tube_d/2-3;
	Al_Tube_a=-10;
	Al_Tube_X=10;
	Al_Tube_Y=-3;
						
	UnLock_a=	Calc_a(11,(BoltCircle_d(Tube_OD=Tube_OD)/2));
	
	OverCenter_a=-Calc_a(Dist=OverCenter,R=BoltCircle_d(Tube_OD=Tube_OD)/2-1);

	module LanyardAttachmentPoint(){
		Ly_t=5;
		HoleCenter_Z=Ly_t+3;
		Offset_Y=0;
		Offset_X=5;
		
		difference(){
			hull(){
				translate([Offset_X,Offset_Y,HoleCenter_Z]) rotate([90,0,0]) cylinder(d=10, h=4, center=true);
				translate([Offset_X,Offset_Y,Ly_t]) cube([12,4,Overlap],center=true);
			} // hull
			
			translate([Offset_X,Offset_Y,HoleCenter_Z]) rotate([90,0,0]) cylinder(d=4, h=4+Overlap*2, center=true);
		} // difference
	} // LanyardAttachmentPoint
	
	LanyardAttachmentPoint();
	
	module StopBlock(LockedBlock=true){
		Block_H=8.5;
		Block_T=StopBlock_W;
		BlockOffset=LockedBlock? Block_T:-Block_T;
		
		translate([BlockOffset, BoltCircle_d(Tube_OD=Tube_OD)/2-1, Plate_t-Overlap]) 
			RoundRect(X=Block_T, Y=10, Z=Block_H, R=1);
	} // StopBlock
	
	module MagnetHole(LockedBlock=true){
		Block_T=StopBlock_W;
		BlockOffset=LockedBlock? Block_T:-Block_T;
		
		translate([BlockOffset, BoltCircle_d(Tube_OD=Tube_OD)/2-1, Plate_t+2.5+Magnet_d/2]) 
			rotate([0,90,0]) cylinder(d=Magnet_d, h=7, center=true);
	} // MagnetHole
	
	difference(){
		union(){
			cylinder(d=Skirt_ID, h=Plate_t, $fn=$preview? 90:360);
				
			// Locked position stops
			for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j+OverCenter_a]) StopBlock();
			
			// Unlocked stop
			rotate([0,0,UnLock_a]) StopBlock(LockedBlock=false);
			
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
			rotate([0,0,Servo_a]) translate([Servo_X+10,Servo_Y,-5]) cube([60,25,10],center=true);
		} // union
		
		rotate([0,0,OverCenter_a]) MagnetHole();
		
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
	OD=Tube_OD-StagerLockInset_Y(Tube_OD=Tube_OD)*2-Stager_LockRod_Y-LockBall_d*2+4;
	Depth=3;
	Inset=0.0;
	nSteps=15;
	Arc_a=Calc_a(9,(OD/2-Inset));
	echo(Arc_a=Arc_a);
	Large_ID=OD-16; // center hole ID
	Small_ID=Race_BC_d(Tube_OD=Tube_OD)-Bolt4Inset*2;
	
	// center of ball in locked position
	Locked_Ball_Y=Tube_OD/2-StagerLockInset_Y(Tube_OD=Tube_OD)-Stager_LockRod_Y/2-LockBall_d/2+2+FlexComp_d/2;
		
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

module Stager_LockRodBoltPattern(){
	// from bottom center
	LR_Y=Stager_LockRod_Y;
	LR_Z=Stager_LockRod_Z;
	LockOffset_Z=-5; // End of rod to top hole
	LockRodBoltSpacing=8;

	translate([0,-LR_Y/2,LR_Z+LockOffset_Z]) rotate([90,0,0]) children();
	translate([0,-LR_Y/2,LR_Z+LockOffset_Z-LockRodBoltSpacing]) rotate([90,0,0]) children();
	
} // Stager_LockRodBoltPattern

//Stager_LockRodBoltPattern() Bolt6Hole();

module Stager_LockRod(Adj=0){
	LR_X=Stager_LockRod_X;
	LR_Y=Stager_LockRod_Y;
	LR_Z=Stager_LockRod_Z;
	Lock_Z=LockBall_d/2+Stager_LockRodTipXtra; // bottom of rod to center of lock ball
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

// Stager_LockRod();
// Stager_LockRod(Adj=0.5);

module Stager_CupHoles(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks, BoltsOn=true, Collar_h=DefaultCollarLen){
	// refferenced from top of saucer
	Len=StagerCupLen; // thickness without collar
	nBolts=nLocks*CupBoltsPerLock;
	ID=Tube_OD-22;
	
	difference(){
		translate([0,0,-Overlap]) cylinder(d=Tube_OD+1, h=Len+Collar_h+Overlap, $fn=$preview? 90:360); // test
		translate([0,0,-Overlap*2]) cylinder(d=ID-IDXtra*2, h=Len+Collar_h+Overlap*4, $fn=$preview? 90:360); 
	} // difference
	
	Stager_LockRod_Holes(Tube_OD=Tube_OD, nLocks=nLocks);
	
	// BoltHoles
	if (BoltsOn)
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+180/nBolts]) 
			translate([0,Tube_OD/2-CupBoltHoleInset,Len+Collar_h]) 
				rotate([180,0,0]) Bolt4Hole(depth=12);
} // Stager_CupHoles

// Stager_CupHoles();

module Stager_Cup(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks, BoltsOn=true, Collar_h=DefaultCollarLen){
	Len=StagerCupLen; // thickness without collar
	LR_X=Stager_LockRod_X;
	LR_Y=Stager_LockRod_Y;
	LR_Z=Stager_LockRod_Z;
	nBolts=nLocks*CupBoltsPerLock;
	ID=Tube_OD-CupBoltHoleInset*2;
	
	Inset_Y=StagerLockInset_Y(Tube_OD=Tube_OD);
	LockRodOffset_Z=-Saucer_H-Stager_LockRodTipXtra-LockBall_d;

	difference(){
		union(){
			difference(){
				union(){
					cylinder(d=Tube_OD, h=Len+Collar_h, $fn=$preview? 90:360);
					translate([0,0,-SaucerDepth]) 
						cylinder(d1=Tube_OD-SaucerLipInset_ID, d2=Tube_OD-SaucerLipInset_OD, 
							h=SaucerDepth+Overlap, $fn=$preview? 90:360);
				} // union
				
				translate([0,0,-SaucerDepth-Overlap]) 
					cylinder(d=ID, h=SaucerDepth+Len+Collar_h+Overlap*2, $fn=$preview? 90:360); 
			} // difference
			
			// Bolt bosses
			if (BoltsOn)
			for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+180/nBolts]) 
				translate([0,Tube_OD/2-CupBoltHoleInset,-SaucerDepth]) 
					cylinder(d=Bolt4Inset*2, h=SaucerDepth+Len+Collar_h);
		} // union
		
		// Saucer clearance
		translate([0,0,-SaucerDepth-Overlap]) cylinder(d=Tube_OD+Overlap, h=SaucerClearance+Overlap);
		
		// BoltHoles
		if (BoltsOn)
			for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+180/nBolts]) 
				translate([0,Tube_OD/2-CupBoltHoleInset,Collar_h-6]) 
					rotate([180,0,0]) Bolt4HeadHole(depth=8,lHead=Collar_h);
		
		Stager_LockRod_Holes(Tube_OD=Tube_OD, nLocks=nLocks);			
		
		for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]) 
			translate([0, Tube_OD/2-Inset_Y, LockRodOffset_Z])
				Stager_LockRodBoltPattern() Bolt6Hole(depth=Inset_Y+4);
		
	} // difference
	
	//*
	if ($preview)
		for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]) 
			translate([0, Tube_OD/2-Inset_Y, LockRodOffset_Z])
				color("Orange") Stager_LockRod();
	/**/
} // Stager_Cup

// translate([0,0,Overlap]) Stager_Cup(BoltsOn=true,Collar_h=20);
// rotate([180,0,0]) Stager_Cup(); // STL test

module Stager_SaucerBoltPattern(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks){
	Inset_Y=StagerLockInset_Y(Tube_OD=Tube_OD);
	Bolt_a=Calc_a(15,(Tube_OD/2));
	
	for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]) {
		rotate([0,0,Bolt_a]) translate([0,Tube_OD/2-Inset_Y,0]) children();
		rotate([0,0,-Bolt_a]) translate([0,Tube_OD/2-Inset_Y,0]) children();
	}
} // Stager_SaucerBoltPattern

// Stager_SaucerBoltPattern() Bolt4ButtonHeadHole();

module Stager_LockRod_Holes(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks){
	LR_X=Stager_LockRod_X;
	LR_Y=Stager_LockRod_Y;
	LR_Z=Stager_LockRod_Z;
	
	Saucer_H=Saucer_H;
	LockRodDepth=Saucer_H+LockBall_d+1+1;
	//echo(LockRodDepth=LockRodDepth);
	SpringDepth=Saucer_H+Stager_Spring_FL-1;
	//echo(SpringDepth=SpringDepth);
	
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

module Stager_Indexer(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks){
	
	Thickess=5;
	Bearing_Z=5;
	
	module ActivationBlock(){
		Block_H=8.5;
		Lever_a=180/nLocks; // was 30 = 72-42?
		
		rotate([0,0,Lever_a])
		translate([0, BoltCircle_d(Tube_OD=Tube_OD)/2+2, -Block_H+Overlap]) RoundRect(X=StopBlock_W, Y=15, Z=Block_H, R=1);
	} // ActivationBlock
	
	module StopBlock(){
		Block_H=8.5;
		
		translate([0, BoltCircle_d(Tube_OD=Tube_OD)/2-1, -Block_H+Overlap]) RoundRect(X=StopBlock_W, Y=10, Z=Block_H, R=1);
	} // StopBlock
	
	module MagnetHole(){
		translate([0, BoltCircle_d(Tube_OD=Tube_OD)/2-1, -2-Magnet_d/2]) rotate([0,90,0]) cylinder(d=Magnet_d, h=7, center=true);
	} // MagnetHole
	
	translate([0,0,-Bearing_Z])
	difference(){
		union(){
			cylinder(d=BoltCircle_d(Tube_OD=Tube_OD)+Bolt4Inset*2,h=Thickess, $fn=$preview? 90:360);
					
			// Locked position stops	
			for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]) StopBlock();
			
			// Servo/manual activation
			rotate([0,0,360/nLocks]) ActivationBlock();
		} // union
		
		MagnetHole();
		
		// Center hole
		translate([0,0,-Overlap]) cylinder(d=Race_ID(Tube_OD=Tube_OD), h=Bearing_Z+2+Overlap*2);
				
		// Bolts for inner race
		for (j=[0:nInnerRaceBolts-1]) rotate([0,0,360/nInnerRaceBolts*j]) 
			translate([0,Race_BC_d(Tube_OD=Tube_OD)/2,Bearing_Z-6]) rotate([180,0,0]) Bolt4HeadHole();
			
	} // difference
		
} //Stager_Indexer

// Stager_Indexer();

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
		
	Race_Z=-Saucer_H-LockBall_d-2-Race_W-InnerRaceXtra_W/2; // Bottom of outer race

	// Center of ball in locked position
	Locked_Ball_Y=Tube_OD/2-StagerLockInset_Y(Tube_OD=Tube_OD)-Stager_LockRod_Y/2-LockBall_d/2+2;
		
	UnLocked_Y=ShowLocked? 0:-2;
	
	module ShowBall(){
		color("Red") sphere(d=LockBall_d, $fn=18);
	} // ShowBall
	
	module BackStop(){
		Block_H=-Race_Z-Saucer_H-Race_W+Overlap;
		
		module BallPath(){
			// lock/unlock path
			hull(){
				translate([0, Locked_Ball_Y+1, -Saucer_H-LockBall_d/2])
					sphere(d=LockBall_d+IDXtra*2);
				
				translate([0, Locked_Ball_Y-4, -Saucer_H-LockBall_d/2])
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
			
			translate([0,0,-Saucer_H]) Stager_SaucerBoltPattern(Tube_OD=Tube_OD, nLocks=nLocks) Bolt4Hole();
		} // difference
		
		if ($preview) 
			translate([0, Locked_Ball_Y+UnLocked_Y, -Saucer_H-LockBall_d/2]) ShowBall();
	} // BackStop
	
// *******************

	for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j])
		BackStop();
		
	MainBearing_Z=-Saucer_H-22; // bottom of main bearing
		
	difference(){
		union(){
			translate([0,0,Race_Z]) difference(){
				BallCircle_d=BearingBallCircle_d(Tube_OD=Tube_OD);
				
				OnePieceOuterRace(BallCircle_d=BallCircle_d, Race_OD=Tube_OD, 
					Ball_d=Ball_d, Race_w=Race_W, PreLoadAdj=PreLoadAdj, 
					VOffset=0.00, BI=false, myFn=$preview? 90:720);
					
				MidBearing_r=((BallCircle_d/2+Ball_d/2+3)+Tube_OD/2)/2;
				
				// Mass reduction
				Cut_w=13;
				Cut_Center_a=360/nLocks/4;
				Cut_a=floor(Cut_Center_a/2-1);
				
				for (k=[0:nLocks*2-1])
					for (j=[-Cut_a:Cut_a-1]) hull(){
						rotate([0,0,180/nLocks*k+Cut_Center_a+j]) 
							translate([0,MidBearing_r,-Overlap]) cylinder(d=Cut_w, h=Race_W+Overlap*2);
						rotate([0,0,180/nLocks*k+Cut_Center_a+j+1]) 
							translate([0,MidBearing_r,-Overlap]) cylinder(d=Cut_w, h=Race_W+Overlap*2);
				} // hull
		
			} // difference

			BottomOfSpring=-Saucer_H-Stager_Spring_FL+1;
			// Spring wells
			for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]) 
				translate([0,Tube_OD/2-StagerLockInset_Y(Tube_OD=Tube_OD)+1, BottomOfSpring-2])
					cylinder(d=Stager_Spring_OD+5, h=16);
		} // union
		
		// LockRod holes
		Stager_LockRod_Holes(Tube_OD=Tube_OD, nLocks=nLocks);
		
		//if ($preview) rotate([0,0,15]) translate([0,0,-100]) cube([Tube_OD/2,Tube_OD/2,100]);
	} // difference
	
	// The Tube
	difference(){
		nBolts=4;
		Bolt_a=35;
		SupportRing_t=3;
		Plate_Z=Race_Z-15.5; // top of ServoPlate
		
		union(){
			// Lower Skirt, connects to E_Bay
			translate([0,0,Plate_Z-5-Skirt_Len]) 
				Tube(OD=Tube_OD, ID=Skirt_ID, Len=Skirt_Len+6, myfn=$preview? 90:360);
				
			// Upper Skirt
			translate([0,0,Plate_Z]) 
				Tube(OD=Tube_OD, ID=Tube_OD-4.4, Len=-Plate_Z-Saucer_H, myfn=$preview? 90:360);
				
			// Support ring
			translate([0,0,Race_Z+Race_W-4]) difference(){
				Tube(OD=Tube_OD, ID=Tube_OD-SupportRing_t*2, Len=-Race_Z-Saucer_H-Race_W+4, myfn=$preview? 90:360);
				translate([0,0,-Overlap]) cylinder(d1=Tube_OD-4.4, d2=Tube_OD-SupportRing_t*2, h=2, $fn=$preview? 90:360);
			} // difference
				
			translate([0,0,Plate_Z]) 
				TubeStop(InnerTubeID=Skirt_ID-3, OuterTubeOD=Tube_OD, myfn=$preview? 90:360);
				
			// Bolt bosses
			for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+Bolt_a]) translate([0, Skirt_ID/2-Bolt4Inset, Plate_Z])
					hull(){
						cylinder(d=Bolt4Inset*2, h=5);
						translate([-Bolt4Inset-2, Bolt4Inset+1, 0]) cube([Bolt4Inset*2+4, Overlap, 5]);
					} // hull
			
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
					
		// Arm / Trigger access hole
		Stager_ArmDisarmAccess(Tube_OD=Tube_OD, Len=Tube_OD, nLocks=nLocks);

		if ($preview) translate([0,0,-100]) cube([Tube_OD/2,Tube_OD/2,100]);
	} // difference
	
/**/
} // Stager_Mech

// Stager_Mech( ShowLocked=true);

module Stager_ArmDisarmAccess(Tube_OD=DefaultBody_OD, Len=DefaultBody_OD, nLocks=Default_nLocks){
	Post_Z=-Saucer_H-36;
	
	ArmingPost_a=180/nLocks*3;
	
	rotate([0,0,ArmingPost_a]) translate([0,BoltCircle_d(Tube_OD=Tube_OD)/2+4,Post_Z])
			rotate([0,90,0]) cylinder(d=3, h=Len, center=true);
} // Stager_ArmDisarmAccess

//Stager_ArmDisarmAccess();




























