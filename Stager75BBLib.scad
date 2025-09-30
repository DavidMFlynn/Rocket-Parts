// ***********************************
// Project: 3D Printed Rocket
// Filename: Stager75BBLib.scad
// by David M. Flynn
// Created: 8/14/2024 
// Revision: 1.0.6  9/29/2025
// Units: mm
// ***********************************
//  ***** Notes *****
//
// Problem to solve: Stager for 75mm tube.
// Cup in Saucer w/ locking pins, servo activated active staging system.
//
// There are two versions one for 75mm (3 inch) and one for 65mm (2.6 inch)
// Copy the apropriet constants to your rocket ".scad" file and use "include<>" not "use<>". 
//
//  ***** Hardware *****
//
// #6-32 x 5/16" Button Head (2 per Lock req.)
// #4-40 x 3/8"  Button Head (4 + 2 per Lock req.)
// #4-40 x 1/4"  Button Head (6 req.)
// #4-40 x 3/8"  Socket Head (6 req.)
// #4-40 x 1/4"  Socket Head (4 req.)
// MR84 (8mm OD x 4mm ID x 3mm Bearing) (1 per Lock req.)
// 4mm x 12mm undersize Dowell (1 per Lock req.)
// 6805-2RS Bearing 65mm version only
// 6807-2RS Bearing 75mm version only 
// MG90S Micro Servo
//
//  ***** History *****
//
function Stager75BBLib_Rev()="Stager75BBLib Rev. 1.0.6";
echo(Stager75BBLib_Rev());
// 1.0.6  9/29/2025    Smaller lighter bearing 6705 for 65mm version.
// 1.0.5  9/4/2025     A little bit of cleanup for viewing.
// 1.0.4  9/25/2024    Added servo options ServoMG90S_ID 11 gram micro servo, ServoMS75_ID 21 gram mini servo, ServoMZ996_ID 55 gram standard servo
// 1.0.3  9/15/2024    Little fixes.
// 1.0.2  9/14/2024    Changed geometry of Stager_LockRing() for 98mm version, testing 98mm version ready for test printing
// 1.0.1  9/14/2024    Standarized Stager_ServoMountBoltPattern() Stager_ServoMount() w/ Stager3Lib
// 1.0.0  9/11/2024    Added hardware list, removed Al tube option. Both 65mm and 75mm versions have been built and tested.
// 0.9.9  9/10/2024    Added Stager_Sustainer_Cup(), printing a complete 75mm stager as a test
// 0.9.8  9/8/2024     Stager_ServoMount(), the 65mm version works
// 0.9.7  9/3/2024     Testing if a 65mm version is posible. Lots of changes needs printing and testing.
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
// Stager_Sustainer_Cup(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks, MotorTube_OD=DefaultMotorTube_OD, Motor_Len=10, nFins=5, StagerCollarLen=DefaultCollarLen);
//
// rotate([180,0,0]) Stager_Cup(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks, BoltsOn=true, Collar_h=DefaultCollarLen);
// rotate([-90,0,0]) Stager_LockRod(Adj=0.5); // Looser
// rotate([-90,0,0]) Stager_LockRod(Adj=0.0); // This works!
//
// Stager_Saucer(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks); // Bolts on
//
// Stager_LockRing(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks); 
//
//  *** Main Body ***
// Stager_Mech(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks, Skirt_ID=DefaultBody_ID, Skirt_Len=Default_SkirtLen, nSkirtBolts=4, ShowLocked=true);
// Stager_OuterBearingCover(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks); // Secures Outer Race of Main Bearing
//
// Stager_Indexer(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks); // Secures Inner Race of Main Bearing and has Lock Stops
// Stager_ServoPlate(Tube_OD=DefaultBody_OD, Skirt_ID=DefaultBody_ID, nLocks=Default_nLocks, OverCenter=IDXtra+0.8, Servo_ID=DefaultServo);
// Stager_ServoMount(Servo_ID=DefaultServo);
//
// ***********************************
//  ***** Routines *****
//
// Stager_ServoMountBoltPattern(IsAEnd=true, Servo_ID=DefaultServo);
// Stager_ServoTop(Servo_ID=DefaultServo);
// Stager_LockRod_Holes(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks);
// Stager_CupBoltHoles(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks) Bolt4Hole();
// Stager_CupHoles(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks, BoltsOn=true, Collar_h=DefaultCollarLen);
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
// ShowStagerAssy(Tube_OD=BT65Body_OD, Tube_ID=BT65Body_ID, nLocks=Default_nLocks, ShowLocked=true);
//
// ***********************************

include<TubesLib.scad>
use<LD-20MGServoLib.scad>
use<SG90ServoLib.scad>
//include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

/*
// Heavy spring
Stager_Spring_OD=5/16*25.4;
Stager_Spring_FL=1.25*25.4;
Stager_Spring_CBL=0.7*25.4;
/**/

// Light Spring CS3715
Stager_Spring_OD=5/16*25.4;
Stager_Spring_FL=1.25*25.4;
Stager_Spring_CBL=0.7*25.4;

// Small Bearing
MR84_Bearing_OD=8;
MR84_Bearing_ID=4;
MR84_Bearing_T=3;

// Main Bearing
Bearing6805_OD=37;
Bearing6805_ID=25;
Bearing6805_T=7;

Bearing6705_OD=32;
Bearing6705_ID=25;
Bearing6705_T=4;

Bearing6806_OD=42;
Bearing6806_ID=30;
Bearing6806_T=7;

Bearing6807_OD=47;
Bearing6807_ID=35;
Bearing6807_T=7;

Bearing6808_OD=52;
Bearing6808_ID=40;
Bearing6808_T=7;

Bearing6809_OD=58;
Bearing6809_ID=45;
Bearing6809_T=7;

Bearing6810_OD=65;
Bearing6810_ID=50;
Bearing6810_T=7;

Bearing6811_OD=72;
Bearing6811_ID=55;
Bearing6811_T=9;

Bearing6812_OD=78;
Bearing6812_ID=60;
Bearing6812_T=10;


Stager_LockRodTipXtra=1;

Stager_LockRod_X=10;
Stager_LockRod_Y=5;
Stager_LockRod_Z=36;
Stager_LockRod_R=1;
LockBall_d=3/8 * 25.4; // 3/8" Delrin balls


Default_SkirtLen=16;
DefaultCollarLen=16;
ServoMG90S_ID=0; // 11 gram micro servo
ServoMS75_ID=1;  // 21 gram mini servo
ServoMZ996_ID=2; // 55 gram standard servo

/*
// constants for 98mm stager
Default_nLocks=3;
DefaultBody_OD=BT98Body_OD;
DefaultBody_ID=BT98Body_ID;
DefaultMotorTube_OD=BT54Body_OD;
DefaultServo=ServoMS75_ID;
MainBearing_OD=Bearing6809_OD;
MainBearing_ID=Bearing6809_ID;
MainBearing_T=Bearing6809_T;
/**/

/*
// constants for 75mm stager
Default_nLocks=3;
DefaultBody_OD=BT75Body_OD;
DefaultBody_ID=BT75Body_ID;
DefaultMotorTube_OD=BT54Body_OD;
DefaultServo=ServoMG90S_ID; //ServoMS75_ID;
MainBearing_OD=Bearing6807_OD;
MainBearing_ID=Bearing6807_ID;
MainBearing_T=Bearing6807_T;
/**/

//*
// constants for 65mm stager
Default_nLocks=2;
DefaultBody_OD=BT65Body_OD;
DefaultBody_ID=BT65Body_ID;
DefaultMotorTube_OD=BT38Body_OD;
DefaultServo=ServoMG90S_ID;
MainBearing_OD=Bearing6705_OD;
MainBearing_ID=Bearing6705_ID;
MainBearing_T=Bearing6705_T;
/**/

/*
// constants for 54mm stager, too small
Default_nLocks=2;
DefaultBody_OD=BT54Body_OD;
DefaultBody_ID=BT54Body_ID;
DefaultMotorTube_OD=BT38Body_OD;
DefaultServo=ServoMG90S_ID;
MainBearing_OD=Bearing6805_OD;
MainBearing_ID=Bearing6805_ID;
MainBearing_T=Bearing6805_T;
/**/

LooseFit=0.8;

nInnerRaceBolts=6;
Bolt4Inset=4;
Saucer_H=6;
SaucerDepth=2;
SaucerLipInset_ID=8;
SaucerLipInset_OD=4;
SaucerClearance=0.3;
CupBoltHoleInset=SaucerLipInset_ID/2+Bolt4Inset;
StagerCupLen=3; // Length of cup without skirt
CupBoltsPerLock=2;

MainBearingSplit=2; // race mounting split 
Magnet_d=3/16*25.4;
StopBlock_W=6;
Bearing_Z=-Saucer_H-LockBall_d-MainBearing_T-4; // bottom of bearing
ServoPlate_T=5;

function StagerLockInset_Y(Tube_OD=DefaultBody_OD)=(Tube_OD>90)? 8:8; // LockRod inset from tube OD
function Calc_a(Dist=1,R=2)=Dist/(R*2*PI)*360;
function BoltCircle_d(Tube_OD=DefaultBody_OD)=Tube_OD-28-Bolt4Inset*2; // Bolt circle for LockStops
function Race_ID()=MainBearing_ID-Bolt4Inset*4;
function Race_BC_d()=MainBearing_ID-Bolt4Inset*2; // Bolt holes in inner race
function Saucer_ID(Tube_OD=DefaultBody_OD)=Tube_OD-StagerLockInset_Y(Tube_OD=Tube_OD)*2-Stager_LockRod_Y-LockBall_d*2+6;

// ============================================================================ //

module ShowStager(Tube_OD=DefaultBody_OD, Tube_ID=DefaultBody_ID, nLocks=Default_nLocks){
	
	translate([0,0,30]) Stager_Cup(Tube_OD=Tube_OD, nLocks=nLocks);
	translate([0,0,10]) color("LightBlue") Stager_Saucer(Tube_OD=Tube_OD, nLocks=nLocks);
	Stager_Mech(Tube_OD=Tube_OD, nLocks=nLocks, Skirt_ID=Tube_ID, Skirt_Len=Default_SkirtLen);
	
	translate([0,0,-100]) Stager_LockRing(Tube_OD=Tube_OD, nLocks=nLocks);
	
	translate([0,0,-110]) rotate([180,0,0]) Stager_OuterBearingCover(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks); // Secures Outer Race of Main Bearing
	
	translate([0,0,-130]) Stager_Indexer(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks); // Secures Inner Race of Main Bearing and has Lock Stops


	translate([0,0,-160]) Stager_ServoPlate(Tube_OD=Tube_OD, Skirt_ID=Tube_ID);		
	
	//translate([0,0,-250]) Stager_ServoMount(Servo_ID=DefaultServo); // shown as part of Stager_ServoPlate
	
} // ShowStager

// ShowStager();
// ShowStager(Tube_OD=DefaultBody_OD, Tube_ID=DefaultBody_ID, nLocks=Default_nLocks);

module ShowStagerAssy(Tube_OD=DefaultBody_OD, Tube_ID=DefaultBody_ID, nLocks=Default_nLocks, ShowLocked=true){
	
	// Shown in the locked position?
	Lock_a=	ShowLocked? 0:Calc_a(11,(BoltCircle_d(Tube_OD=Tube_OD)/2));
						
	translate([0,0,Bearing_Z+0.1]) color("Red") Tube(OD=MainBearing_OD, ID=MainBearing_ID, Len=MainBearing_T-0.2, myfn=90);
	
	//Stager_CupHoles(Tube_OD=Tube_OD, nLocks=nLocks, BoltsOn=true, Collar_h=DefaultCollarLen);
	//translate([0,0,0.4]) Stager_Cup(Tube_OD=Tube_OD, ID=BT54Body_ID, nLocks=Default_nLocks, BoltsOn=true);
	
	translate([0,0,0.2]) Stager_Saucer();
	
	translate([0,0,-Saucer_H-LockBall_d-2]) rotate([0,0,Lock_a]) Stager_LockRing(Tube_OD=Tube_OD, nLocks=nLocks);

	//*
	difference(){
			Stager_Mech(Tube_OD=Tube_OD, nLocks=nLocks, Skirt_ID=Tube_ID, Skirt_Len=Default_SkirtLen, ShowLocked=ShowLocked);
			//
			rotate([0,0,-45-180]) translate([0,0,-90]) cube([100,100,100]);
		}
	translate([0,0,Bearing_Z+MainBearingSplit]) rotate([180,0,0]) color("Tan") Stager_OuterBearingCover();
	/**/

	//*
	
	
	 translate([0,0,Bearing_Z-16.0-ServoPlate_T]) Stager_ServoPlate(Tube_OD=Tube_OD, Skirt_ID=Tube_ID);

	rotate([0,0,Lock_a]){
		
		  
		translate([0,0,Bearing_Z]) //color("LightBlue")  
			Stager_Indexer();

		//Stop_Z= 10+Overlap;
		
	}
	/**/
					
} // ShowStagerAssy

//
ShowStagerAssy(ShowLocked=true);
//ShowStagerAssy(ShowLocked=false);
//ShowStagerAssy(Tube_OD=BT98Body_OD, Tube_ID=BT98Body_ID, nLocks=Default_nLocks, ShowLocked=true);

module Stager_ServoMountBoltPattern(IsAEnd=true, Servo_ID=DefaultServo){
// copied from Stager3Lib.scad
	ServoBoltSpace=[11,10+Bolt4Inset,12.5+Bolt4Inset];
	BoltOffsetA=[-8.5,-9.5,-13];
	BoltOffsetB=[18.5,24,34];
	
	if (IsAEnd){
		translate([BoltOffsetA[Servo_ID],0,0]){
			translate([0,-ServoBoltSpace[Servo_ID],-2]) rotate([0,180,0]) children();
			translate([0,ServoBoltSpace[Servo_ID],-2]) rotate([0,180,0]) children();
		}
	}else{
		translate([BoltOffsetB[Servo_ID],0,0]){
			translate([0,-ServoBoltSpace[Servo_ID],-2]) rotate([0,180,0]) children();
			translate([0,ServoBoltSpace[Servo_ID],-2]) rotate([0,180,0]) children();
		}
	}	
	
} // Stager_ServoMountBoltPattern

//Stager_ServoMountBoltPattern(IsAEnd=true, Servo_ID=ServoMS75_ID) Bolt4Hole();
//Stager_ServoMountBoltPattern(IsAEnd=false, Servo_ID=ServoMS75_ID) Bolt4Hole();

module Stager_ServoTop(Servo_ID=DefaultServo){
	
	
	//cube(Servo_Case[Servo_ID]);
	
	if (Servo_ID==ServoMG90S_ID){
		ServoSG90(TopMount=true);
	}
	
	if (Servo_ID==ServoMS75_ID){
		BoltSpacing=35;
		WheelOffset_X=6.5;
		Body_X=28.6;
		Body_Y=13.4;
		Ears_X=41;
		
		// Body
		translate([WheelOffset_X,0,-21]) RoundRect(X=Ears_X, Y=Body_Y, Z=21+Overlap, R=1);
		// Bolts
		translate([-BoltSpacing/2+WheelOffset_X,0,-1]) rotate([180,0,0]) Bolt6Hole();
		translate([BoltSpacing/2+WheelOffset_X,0,-1]) rotate([180,0,0]) Bolt6Hole();
		// Top
		cylinder(d=Body_Y, h=16);
		translate([WheelOffset_X,0,0]) RoundRect(X=Body_X, Y=Body_Y, Z=9.5, R=0.25);
	}
	
	if (Servo_ID==ServoMZ996_ID){
		rotate([0,0,180]) Servo_LD20MG(BottomMount=true,TopAccess=false);
	}

} // Stager_ServoTop

//Stager_ServoTop();

module Stager_ServoMount(Servo_ID=DefaultServo){
// copied from Stager3Lib.scad

	Servo_Z=[-6,-7,-10];
	Base_H=[5,8.5,10];
	Base_X=[35,45,60];
	Base_Y=[16,18,25];
	BaseOffset_X=[5,6.7,10];
	
		difference(){
			union(){
				// Servo base
				translate([BaseOffset_X[Servo_ID],0,-Base_H[Servo_ID]/2]) cube([Base_X[Servo_ID],Base_Y[Servo_ID],Base_H[Servo_ID]],center=true);
				
				// feet
				translate([0,0,2]){
					hull() Stager_ServoMountBoltPattern(IsAEnd=true, Servo_ID=Servo_ID) cylinder(d=8, h=2);
					hull() Stager_ServoMountBoltPattern(IsAEnd=false, Servo_ID=Servo_ID) cylinder(d=8, h=2);
				}
			} // union
			
			// Servo
			translate([0,0,Servo_Z[Servo_ID]]) Stager_ServoTop(Servo_ID=Servo_ID);
			
			// Bolts
			Stager_ServoMountBoltPattern(IsAEnd=true, Servo_ID=Servo_ID) Bolt4ClearHole();
			Stager_ServoMountBoltPattern(IsAEnd=false, Servo_ID=Servo_ID) Bolt4ClearHole();

		} // difference
	
} // Stager_ServoMount

// Stager_ServoMount(Servo_ID=ServoMS75_ID);
// Stager_ServoMount(Servo_ID=ServoMG90S_ID);

module Stager_ServoPlate(Tube_OD=DefaultBody_OD, Skirt_ID=DefaultBody_ID, nLocks=Default_nLocks, OverCenter=IDXtra+0.8, Servo_ID=DefaultServo){
											
	BC_r=BoltCircle_d(Tube_OD=Tube_OD)/2;
	
	nBolts=4;
	Bolt_a=35;
	Servo_X=[-BC_r+3,-BC_r+4.5,-Tube_OD/2+27];
	Servo_Y=[0,0,0];
	Servo_Z=[-6,-7,-10];
	ServoWheel_r=[4,4.5,6];
	Servo_a=-90+180/nLocks*3-Calc_a(ServoWheel_r[Servo_ID]+3,-Servo_X[Servo_ID]);
						
	UnLock_a=Calc_a(11,BC_r);
	
	OverCenter_a=-Calc_a(Dist=OverCenter,R=BC_r-1);
	
	module StopBlock(LockedBlock=true){
		Block_H=8.5;
		Block_T=StopBlock_W;
		BlockOffset=LockedBlock? Block_T:-Block_T;
		
		translate([BlockOffset, BC_r-1, ServoPlate_T-Overlap]) 
			RoundRect(X=Block_T, Y=10, Z=Block_H, R=1);
			
	} // StopBlock

	module MagnetHole(LockedBlock=true){
		Block_T=StopBlock_W;
		BlockOffset=LockedBlock? Block_T:-Block_T;
		
		translate([BlockOffset, BC_r-1, ServoPlate_T+2.5+Magnet_d/2]) 
			rotate([0,90,0]) cylinder(d=Magnet_d, h=7, center=true);
	} // MagnetHole
	
	difference(){
		union(){
			cylinder(d=Skirt_ID, h=ServoPlate_T, $fn=$preview? 90:360);
			
			// Locked position stops
			for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j+OverCenter_a]) StopBlock();
			
			// Unlocked stop
			rotate([0,0,UnLock_a]) StopBlock(LockedBlock=false);
			
		} // union
		
		rotate([0,0,OverCenter_a]) MagnetHole();
		
		// Servo
		rotate([0,0,Servo_a]) translate([Servo_X[Servo_ID],Servo_Y[Servo_ID],0]){
			translate([0,0,Servo_Z[Servo_ID]]) Stager_ServoTop(Servo_ID=Servo_ID);
				
		// Bolts
		Stager_ServoMountBoltPattern(IsAEnd=true, Servo_ID=Servo_ID) Bolt4Hole(depth=7);
		Stager_ServoMountBoltPattern(IsAEnd=false, Servo_ID=Servo_ID) Bolt4Hole(depth=7);
		}
		
	
		// mounting bolts
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+Bolt_a]) translate([0,Skirt_ID/2-Bolt4Inset,0])
			rotate([180,0,0]) Bolt4ButtonHeadHole();
		
		// Alignment Key
		translate([0,Skirt_ID/2,-Overlap]) cylinder(d=5, h=ServoPlate_T+Overlap*2);
	} // difference
	
	if ($preview) rotate([0,0,Servo_a]) translate([Servo_X[Servo_ID],Servo_Y[Servo_ID],0])
			Stager_ServoMount();
} // Stager_ServoPlate

//Stager_ServoPlate();

module Stager_LockRing(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks){
	BC_r=Race_BC_d()/2;
	nBolts=nInnerRaceBolts;
	OD=Tube_OD-StagerLockInset_Y(Tube_OD=Tube_OD)*2-Stager_LockRod_Y-LockBall_d*2+4;
	Depth=3.5;
	Inset=0.0;
	nSteps=15;
	Arc_a=Calc_a(LockBall_d,(OD/2-Inset));
	//echo(Arc_a=Arc_a);
	Large_ID=OD-16; // center hole ID
	Small_ID=Race_BC_d()-Bolt4Inset*2;
	
	// center of ball in locked position
	Locked_Ball_Y=Tube_OD/2-StagerLockInset_Y(Tube_OD=Tube_OD)-Stager_LockRod_Y/2-LockBall_d/2+2;
		
	LockHead_H=LockBall_d+3;
	Ball_Z=LockHead_H/2;
	
	CenterHole_Z=(MainBearing_ID<Large_ID-2)? 2:-2;
	
	module LanyardAttachmentPoint(){
		Ly_OD=Large_ID+1;
		Ly_t=3.6;
		HoleCenter_Z=Ly_t+4;
		
		difference(){
			union(){
				hull(){
					translate([0,0,HoleCenter_Z]) rotate([90,0,0]) cylinder(d=10, h=4, center=true);
					translate([0,0,Ly_t]) cube([12,4,Overlap],center=true);
				} // hull
				//cylinder(d=Ly_OD, h=Ly_t);
			} // union
			
			translate([0,0,HoleCenter_Z]) rotate([90,0,0]) cylinder(d=4, h=4+Overlap*2, center=true);
		
		} // difference
	} // LanyardAttachmentPoint
	
	translate([0,0,-3.2+CenterHole_Z]) LanyardAttachmentPoint();
	
	module Bearing(){
		translate([0,Locked_Ball_Y-LockBall_d/2-MR84_Bearing_OD/2+IDXtra,0]){
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
	Bearing_Z=-MainBearing_T-2;
	
	difference(){
		union(){
			translate([0,0,0.5]) cylinder(d=OD, h=LockHead_H, $fn=$preview? 90:360);
			
			translate([0,0,Bearing_Z+MainBearingSplit]) 
				cylinder(d=MainBearing_ID, h=MainBearing_T-MainBearingSplit+Overlap, $fn=$preview? 90:360);
			
			Taper_D2=min(MainBearing_OD-3,OD);
			translate([0,0,Bearing_Z+MainBearing_T]) cylinder(d1=MainBearing_ID+3, d2=Taper_D2, h=2.5+Overlap, $fn=$preview? 90:360);
		} // union
		
		for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j])
			translate([0,0,Ball_Z]) Bearing();
			
		// center hole
		translate([0,0,0.5]){
			translate([0,0,LockHead_H-2]) cylinder(d1=Large_ID, d2=Large_ID+2, h=2+Overlap, $fn=$preview? 90:360); // chamfer
			translate([0,0,CenterHole_Z]) cylinder(d=Large_ID, h=LockHead_H+2, $fn=$preview? 90:360); // top
		}
		
		// Bolts
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) 
			translate([MainBearing_ID/2-Bolt4Inset,0,-MainBearing_T]) rotate([180,0,0]) Bolt4Hole(depth=9+CenterHole_Z);
		
		if ($preview) translate([0,0,-20]) cube([100,100,100]);
	} // difference
	
	if ($preview) color("Red") for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j])
			translate([0, Locked_Ball_Y-LockBall_d/2-MR84_Bearing_OD/2+IDXtra, Ball_Z]) 
				cylinder(d=MR84_Bearing_OD, h=MR84_Bearing_T, center=true);
} // Stager_LockRing

// Stager_LockRing();

module Stager_LockRodBoltPattern(){
// copied from Stager3Lib
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
// copied from Stager3Lib
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

module Stager_CupBoltHoles(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks){
	nBolts=nLocks*CupBoltsPerLock;
	Len=StagerCupLen; // thickness without collar
	
	for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+180/nBolts]) 
			translate([0,Tube_OD/2-CupBoltHoleInset,0]) 
				rotate([180,0,0]) children();
} // Stager_CupBoltHoles

// Stager_CupBoltHoles() Bolt4Hole();

module Stager_CupHoles(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks, BoltsOn=true, Collar_h=DefaultCollarLen){
 // copied from Stager3.scad
 
	// refferenced from top of saucer
	Len=StagerCupLen; // thickness without collar
	nBolts=nLocks*CupBoltsPerLock;
	ID=Tube_OD-CupBoltHoleInset*2-Bolt4Inset*2;
	
	difference(){
		translate([0,0,-Overlap]) cylinder(d=Tube_OD+1, h=Len+Collar_h+Overlap, $fn=$preview? 90:360); // test
		translate([0,0,-Overlap*2]) cylinder(d=ID-IDXtra*2, h=Len+Collar_h+Overlap*4, $fn=$preview? 90:360); 
	} // difference
	
	Stager_LockRod_Holes(Tube_OD=Tube_OD, nLocks=nLocks);
	
	// BoltHoles
	if (BoltsOn) translate([0,0,Len+Collar_h]) 
		Stager_CupBoltHoles(Tube_OD=Tube_OD, nLocks=nLocks) Bolt4Hole(depth=12);
} // Stager_CupHoles

// Stager_CupHoles();

module Stager_Cup(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks, BoltsOn=true, Collar_h=DefaultCollarLen){
 // copied from Stager3.scad
 
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

// translate([0,0,Overlap]) Stager_Cup();
// rotate([180,0,0]) Stager_Cup(ID=BT54Body_ID); // STL test

module Stager_Sustainer_Cup(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks,
					MotorTube_OD=DefaultMotorTube_OD, Motor_Len=10, nFins=5, StagerCollarLen=DefaultCollarLen){
	
	module Wires(){
		rotate([0,0,360/nFins]) translate([0,MotorTube_OD/2+4,-2]) scale([1.75,1,1]) cylinder(d=4, h=StagerCollarLen+3+2+Overlap);
		hull(){
			rotate([0,0,360/nFins]) translate([0,MotorTube_OD/2+4,-2]) scale([1.75,1,1]) cylinder(d=4, h=5);
			rotate([0,0,360/nFins]) translate([0,MotorTube_OD/2-4,-2]) scale([1.75,1,1]) cylinder(d=4, h=5);
		} // hull
	}
	
	difference(){
		Stager_Cup(Tube_OD=Tube_OD, nLocks=nLocks, BoltsOn=true, Collar_h=StagerCollarLen);
		
		// wire path
		Wires();
		
		translate([0,0,StagerCollarLen+3-Motor_Len]) cylinder(d=MotorTube_OD+1, h=Motor_Len+Overlap, $fn=$preview? 90:360);
	} // difference
	
	difference(){
		
		union(){
			
			translate([0,0,StagerCollarLen+3-Motor_Len]) Tube(OD=Tube_OD-10, ID=MotorTube_OD+1, Len=Motor_Len, myfn=$preview? 90:360);
			translate([0,0,StagerCollarLen+3-Motor_Len-3]) Tube(OD=Tube_OD-10, ID=MotorTube_OD-4, Len=3, myfn=$preview? 90:360);
		} // union
		
		// wire path
		Wires();
		
		Stager_LockRod_Holes(Tube_OD=Tube_OD, nLocks=nLocks);
		translate([0,0,StagerCollarLen+3-8]) Stager_CupBoltHoles(Tube_OD=Tube_OD, nLocks=nLocks) Bolt4HeadHole(depth=8,lHead=StagerCollarLen);
		
		for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j])
			translate([0,Tube_OD/2-10,-16.5]) Stager_LockRodBoltPattern() Bolt6ButtonHeadHole();
		
	} // difference
	
} // Stager_Sustainer_Cup

// Stager_Sustainer_Cup();

module Stager_SaucerBoltPattern(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks){
	Inset_Y=StagerLockInset_Y(Tube_OD=Tube_OD);
	Bolt_a=Calc_a(15,(Tube_OD/2));
	
	for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]) {
		rotate([0,0,Bolt_a]) translate([0,Tube_OD/2-Inset_Y,0]) children();
		rotate([0,0,-Bolt_a]) translate([0,Tube_OD/2-Inset_Y,0]) children();
	}
} // Stager_SaucerBoltPattern

//Stager_SaucerBoltPattern() Bolt4ButtonHeadHole();


module Stager_LockRod_Holes(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks){
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
	Len=Saucer_H;
	ID=Saucer_ID(Tube_OD=Tube_OD);
	//echo("Saucer ID = ",ID);
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

module Stager_Indexer(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks, Servo_ID=DefaultServo){
	
	
	BC_r=BoltCircle_d(Tube_OD=Tube_OD)/2;
	UnLock_a=Calc_a(11,BC_r);
	Servo_X=[-BC_r+3,-BC_r+4.5,-Tube_OD/2+27];
	ServoWheel_r=[4,4.5,6];
	Servo_a=-90+180/nLocks*3-Calc_a(ServoWheel_r[Servo_ID]+3,-Servo_X[Servo_ID]);

	
	Thickess=4;
	Bearing_Z=7; // Bottom of index plate to bottom of bearing
	
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
					
			cylinder(d=MainBearing_ID, h=Bearing_Z+MainBearingSplit, $fn=$preview? 90:360);
			
			cylinder(d=MainBearing_ID+2, h=Bearing_Z, $fn=$preview? 90:360);
			
			// Locked position stops	
			for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]) StopBlock();
			
			// Servo/manual activation
			rotate([0,0,360/nLocks]) ActivationBlock();
		} // union
		
		// Servo wheel clearance
		rotate([0,0,Servo_a]) translate([Servo_X[Servo_ID],0,-12]) cylinder(r=ServoWheel_r[Servo_ID], h=10);
		rotate([0,0,Servo_a-UnLock_a]) translate([Servo_X[Servo_ID],0,-12]) cylinder(r=ServoWheel_r[Servo_ID], h=10);
		
		MagnetHole();
		
		// Center hole
		translate([0,0,-Overlap]) cylinder(d=Race_ID(), h=Bearing_Z+2+Overlap*2);
				
		// Bolts for inner race
		for (j=[0:nInnerRaceBolts-1]) rotate([0,0,360/nInnerRaceBolts*j+180/nInnerRaceBolts]) 
			translate([0,Race_BC_d()/2,Bearing_Z-6]) rotate([180,0,0]) Bolt4HeadHole(lHead=20);
			
		//translate([0,MainBearing_OD/2+Bolt4Inset,Thickness]) Bolt4ButtonHeadHole();
	} // difference
		
} //Stager_Indexer

// Stager_Indexer();

module Stager_Mech(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks, Skirt_ID=DefaultBody_ID, Skirt_Len=Default_SkirtLen, nSkirtBolts=4, ShowLocked=true){
	
	Tube_Len=18;

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
		Block_H=LockBall_d+4;
		
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
			translate([0,0,-Saucer_H]) Stager_SaucerBoltPattern(Tube_OD=Tube_OD, nLocks=nLocks) Bolt4Hole();
		} // difference
		
		if ($preview) 
			translate([Locked_Ball_X, Locked_Ball_Y+UnLocked_Y, -Saucer_H-LockBall_d/2]) ShowBall();
	} // BackStop
	
// *******************

	for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j])
		BackStop();
				
	difference(){
		union(){
			// Spring wells
			for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]) 
				translate([0,Tube_OD/2-StagerLockInset_Y(Tube_OD=Tube_OD)+1, -Saucer_H-Stager_Spring_FL])
					cylinder(d=Stager_Spring_OD+5, h=Stager_Spring_CBL);
					
			// Main bearing
			translate([0,0,Bearing_Z+MainBearingSplit])
				difference(){
					cylinder(d=Tube_OD-1, h=MainBearing_T);
										
					translate([0,0,-Overlap]) cylinder(d=MainBearing_OD+IDXtra*2, h=MainBearing_T-MainBearingSplit);
					cylinder(d=MainBearing_OD-2, h=MainBearing_T+4, $fn=$preview? 90:360);
				} // difference
	
		} // union
		
		// bearing holder Bolts
		nBolts=nLocks*2;
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+180/nBolts])
				translate([0,MainBearing_OD/2+Bolt4Inset,Bearing_Z]) rotate([180,0,0]) Bolt4Hole();
						
		// Spring wells
		for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]) 
				translate([0,Tube_OD/2-StagerLockInset_Y(Tube_OD=Tube_OD)+1, -Saucer_H-Stager_Spring_FL])
					translate([0,0,2]) cylinder(d=Stager_Spring_OD+LooseFit, h=Stager_Spring_FL);
					
	} // difference
	
	
	// The Tube
	difference(){
		nBolts=4;
		Bolt_a=35;
		SupportRing_t=3;
		Plate_Z=Bearing_Z-16.0; // top of ServoPlate
		
		union(){
			//translate([0,0,-Saucer_H-Tube_Len]) 
			//	cylinder(d=Tube_OD, h=Tube_Len, $fn=$preview? 90:360);
			
			// Lower Skirt, connects to E_Bay
			translate([0,0,Plate_Z-5-Skirt_Len]) 
				Tube(OD=Tube_OD, ID=Skirt_ID, Len=Skirt_Len+6, myfn=$preview? 90:360);
				
			// Upper Skirt
			translate([0,0,Plate_Z]) 
				Tube(OD=Tube_OD, ID=Tube_OD-4.4, Len=-Plate_Z-Saucer_H, myfn=$preview? 90:360);
				
			// Support ring
			translate([0,0,Bearing_Z]) difference(){
				Tube(OD=Tube_OD, ID=Tube_OD-SupportRing_t*2, Len=-Bearing_Z-Saucer_H, myfn=$preview? 90:360);
				translate([0,0,-Overlap]) cylinder(d1=Tube_OD-4.4, d2=Tube_OD-SupportRing_t*2, h=2, $fn=$preview? 90:360);
			} // difference
			
			translate([0,0,Plate_Z]) 
				TubeStop(InnerTubeID=Skirt_ID-3, OuterTubeOD=Tube_OD, myfn=$preview? 90:360);
				
			// Bolt bosses
			difference(){
				for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+Bolt_a]) translate([0,Skirt_ID/2-Bolt4Inset,Plate_Z])
					hull(){
						cylinder(d=Bolt4Inset*2, h=5);
						translate([-Bolt4Inset-1,Bolt4Inset,0]) cube([Bolt4Inset*2+2,Overlap,5]);
					} // hull
					
				translate([0,0,Plate_Z-Overlap]) cylinder(d=Skirt_ID-Bolt4Inset*3.25, h=5+Overlap*2);
			} // difference
			
			// Alignment key
			intersection(){
				translate([0,Skirt_ID/2,Plate_Z-5]) cylinder(d=4,h=5);
				translate([0,0,Plate_Z-5]) cylinder(d=Skirt_ID+1, h=5);
			} // intersection

		} // union
		
		// Bolt holes
		if (nSkirtBolts>0) for (j=[0:nSkirtBolts-1]) rotate([0,0,360/nSkirtBolts*j]) 
			translate([0,Tube_OD/2,Plate_Z-ServoPlate_T-Skirt_Len+7.5]) rotate([-90,0,0]) Bolt4Hole();
		
		// Bolts
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+Bolt_a])
			translate([0,Skirt_ID/2-Bolt4Inset,Plate_Z+5]) Bolt4Hole();
		
		// Arm / Trigger access hole
		Stager_ArmDisarmAccess(Tube_OD=Tube_OD, Len=Tube_OD);

		//
		if ($preview) translate([0,0,-100]) cube([50,50,100]);
	} // difference
	
} // Stager_Mech

// Stager_Mech();

module Stager_OuterBearingCover(Tube_OD=DefaultBody_OD, nLocks=Default_nLocks){
	nBolts=nLocks*2;
	Thickness=4;
	SpringWellBC_r=Tube_OD/2-StagerLockInset_Y(Tube_OD=Tube_OD)+1;
	
	difference(){
		union(){
			cylinder(d=MainBearing_OD+6, h=Thickness);
			
			// bearing holder Bolts
			hull() for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+180/nBolts])
				translate([0,MainBearing_OD/2+Bolt4Inset,0]) cylinder(d=Bolt4Inset*2, h=Thickness);
		} // union
		
		translate([0,0,-Overlap]) cylinder(d=MainBearing_OD-2, h=Thickness+Overlap*2);
		translate([0,0,-Overlap]) cylinder(d=MainBearing_OD+IDXtra*2, h=MainBearingSplit+Overlap);
		
		// clear the spring holders
		for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j+180/nLocks]) translate([0,SpringWellBC_r,-Overlap]) 
			cylinder(d=14, h=Thickness+Overlap*2);
		
		// bearing holder Bolts
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+180/nBolts])
			translate([0,MainBearing_OD/2+Bolt4Inset,Thickness]) Bolt4ButtonHeadHole();
	} // difference
} // Stager_OuterBearingCover

//translate([0,0,Bearing_Z+2]) rotate([180,0,0]) Stager_OuterBearingCover();

/*
// test
difference(){
	Stager_Mech();
	translate([0,0,-100]) cylinder(d=100, h=63);
}
/**/

module Stager_ArmDisarmAccess(Tube_OD=DefaultBody_OD, Len=DefaultBody_OD, nLocks=Default_nLocks){
	Post_Z=Bearing_Z-10;
	
	ArmingPost_a=180/nLocks*3;
	
	rotate([0,0,ArmingPost_a]) translate([0,MainBearing_OD/2+4,Post_Z])
			rotate([0,90,0]) cylinder(d=3, h=Len, center=true);
} // Stager_ArmDisarmAccess

//Stager_ArmDisarmAccess();




























