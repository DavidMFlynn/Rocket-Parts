// ***********************************
// Project: 3D Printed Rocket
// Filename: SpringThingInside.scad
// by David M. Flynn
// Created: 11/26/2025
// Revision: 1.0.0   11/26/2025
// Units: mm
// ***********************************
//  ***** Notes *****
//
// A.K.A. Ball Lock
//
// Built to deploy a parachute from a rocket with a spring.
// Custom version for LOC65 and PetalLock
//
// Electronics:
//  Rocket Servo PCB (Req. 9V Battery)
//  SG90 or Eqiv. 9g Micro Servo MG90S is better
//
// Hardware(original SpringThingBooster 54mm 3 Ball):
//  #4-40 x 1/2" Socket Head Cap Screw (5 Req.)
//  #2-56 x 1/4" Socket Head Cap Screw (2 Req.)
//  3/16" Dia. x 1/8" Thick Magnet (2 Req.)
//  3/8" Delrin Ball (3 Req.)
//  MR84 Bearing 8mm OD x 4mm ID x 3mm Thick (5 Req.)
//  Steel Dowel Pin 4mm (Undersized) x 10mm (3 Req.)
//  Steel Dowel Pin 4mm (Undersized) x 16mm (3 Req.)
//
//
//  ***** History *****
function SpringThingInsideRev()="SpringThingInside Rev. 1.0.0";
echo(SpringThingInsideRev());
//
// 1.0.0   11/26/2025 Copied from SpringThingBooster 1.5.0
//
// ***********************************
//  ***** for STL output *****
//
// STI_LockDisk(nLockBalls=nLockBalls, Xtra_r=0.0);
// STI_TubeEnd(Body_ID=LOC65Body_ID, nLockBalls=nLockBalls, Engagement_Len=20);
// STI_BallRetainerTop(nLockBalls=nLockBalls, Xtra_r=0.0);
// STI_BallRetainerBottom(nLockBalls=nLockBalls, Xtra_r=0.0);
// STI_SpringEndOne();
//
// ---------------
//  *** Tools ***
//
//  ** Drill the end of the coupler tube before gluing on the body tube. **
// STI_DrillingJig(BallPerimeter_d=PML54Body_ID, Body_OD=BT54Coupler_OD); 
//
// ***********************************
//  ***** Routines *****
//
// function STI_LockPinBC_d(BallPerimeter_d=BT75Body_OD)
// STI_ShockCordHolePattern(BallPerimeter_d=BT75Body_OD, Body_OD=BT75Body_ID);
// STI_ManualDisArmingHole(BallPerimeter_d=BT75Body_OD, nLockBalls=nLockBalls);
// STI_ManualArmingHole(BallPerimeter_d=BT75Body_OD);
//
// ***********************************
//  ***** for Viewing *****
//
// Show_STI();
// STI_ShowLockBearings(nLockBalls=nLockBalls);
// STI_ShowMyBalls(nLockBalls=nLockBalls, InLockedPosition=true);
//
// ***********************************

include<TubesLib.scad>
use<SpringEndsLib.scad>
use<SG90ServoLib.scad>
use<LD-20MGServoLib.scad>
use<BatteryHolderLib.scad>
include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2; // Add to ID for tight fit, x2 for loose fit
LooseFit=IDXtra*3;
$fn=$preview? 24:90;

// -----------------------
// Now a function
//LockBall_d=3/8*25.4;
//LockBall_d=1/2 * 25.4;

Magnet_d=4.8;
Magnet_h=3.2;
Dowel_d=4;

// -----------------------

BearingMR63_OD=6;
BearingMR63_ID=3;
BearingMR63_W=2.5;

LockBearing_OD=BearingMR63_OD;
LockBearing_ID=BearingMR63_ID;
LockBearing_W=BearingMR63_W;

Bearing6704_ID=20;
Bearing6704_OD=27;
Bearing6704_W=4;

InnerBearing_ID=Bearing6704_ID;
InnerBearing_OD=Bearing6704_OD;
InnerBearing_W=Bearing6704_W;

nLockBalls=3;

Bolt4Inset=4;
Wall_t=1.6;

// Deployment Spring big and light
ST_DSpring_OD=SE_Spring_CS4323_OD();
ST_DSpring_ID=SE_Spring_CS4323_ID();
ST_DSpring_CBL=SE_Spring_CS4323_CBL(); // coil bound length
ST_DSpring_FL=SE_Spring_CS4323_FL(); // free length

LockDisk_H=10; // length of dowel pins
LockDiskHole_H=LockDisk_H+1;


function STI_LockBall_d()=5/16 * 25.4;

// Balls out
function STI_BallPerimeter_d()=InnerBearing_OD+1+LockBearing_OD*2+STI_LockBall_d()*2;

function STI_CalcChord_a(Dia=10, Dist=1)=Dist/(Dia*PI)*360;

function STI_LockPinBC_d()=STI_BallPerimeter_d()-STI_LockBall_d()*2-LockBearing_OD;

function STI_LockedPost_a()=
			-STI_CalcChord_a(Dia=STI_LockPinBC_d(), Dist=LockBearing_OD/2+Dowel_d/2+0.4);
			
function STI_Unlocked_a()=STI_CalcChord_a(Dia=STI_LockPinBC_d(), 
						Dist=STI_LockBall_d()*0.35+LockBearing_OD*0.35);

function STI_UnlockedPost_a(nLockBalls=nLockBalls)=
			STI_Unlocked_a()+360/nLockBalls+
				STI_CalcChord_a(Dia=STI_LockPinBC_d(), Dist=LockBearing_OD/2+Dowel_d/2+IDXtra*2);
				
function STI_MagnetPost_a(nLockBalls=nLockBalls)=
			STI_UnlockedPost_a(nLockBalls)+
			STI_CalcChord_a(Dia=STI_LockPinBC_d(), Dist=Dowel_d/2+Magnet_h);
			
//echo(STI_Unlocked_a());

function STI_MagnetBC_d()=InnerBearing_OD+Wall_t*2+Magnet_d+4;


module Show_STI(){
	STI_LockDisk();
	color("Red") STI_ShowMyBalls(nLockBalls=nLockBalls, InLockedPosition=true);
	STI_ShowLockBearings(nLockBalls=nLockBalls);
	difference(){
		union(){
			translate([0,0,0.1]) color("Tan") STI_BallRetainerTop();
			STI_BallRetainerBottom();
			STI_TubeEnd(Body_ID=LOC65Body_ID, nLockBalls=3, Engagement_Len=17);
		} // union
		
		translate([0,0,-44]) cube([40,40,60]);
	} // difference
	
	translate([0,0,-8.8]) rotate([180,0,53]) color("Green") STI_SpringEndOne();
} // Show_STI

// Show_STI();

module STI_LockedStopPosition(){
	BallPerimeter_d=STI_BallPerimeter_d();
	OverCenterValue=0.2;
	
	translate([LockBearing_OD/2+Dowel_d/2+OverCenterValue, BallPerimeter_d/2-STI_LockBall_d()-LockBearing_OD/2,0])
		children();
} // STI_LockedStopPosition
	
module STI_UnlockedStopPosition(nLockBalls=nLockBalls){
	BallPerimeter_d=STI_BallPerimeter_d();
	
	rotate([0,0,STI_Unlocked_a()+360/nLockBalls])
	translate([-LockBearing_OD/2-Dowel_d/2-IDXtra, BallPerimeter_d/2-STI_LockBall_d()-LockBearing_OD/2,0])
		children();
} // STI_UnlockedStopPosition

module STI_ShowMyBalls(nLockBalls=nLockBalls, InLockedPosition=true){
	BallPerimeter_d=STI_BallPerimeter_d();
	
	Ball_Y=InLockedPosition? BallPerimeter_d/2-STI_LockBall_d()/2 : BallPerimeter_d/2-STI_LockBall_d()/2-2;
	
	for (j=[0:nLockBalls-1]) rotate([0,0,360/nLockBalls*j]) 
			translate([0,Ball_Y,0]) 
				color("Red") sphere(d=STI_LockBall_d());

} // STI_ShowMyBalls

//STI_ShowMyBalls(nLockBalls=nLockBalls, InLockedPosition=true);
//STI_ShowMyBalls(nLockBalls=nLockBalls, InLockedPosition=false);

module STI_ShowLockBearings(nLockBalls=nLockBalls){
	
	for (j=[0:nLockBalls-1]) rotate([0,0,360/nLockBalls*j]) 
		translate([0,STI_LockPinBC_d()/2,0]) {
			color("Red") cylinder(d=LockBearing_ID, h=10+Overlap, center=true);
			color("Blue") cylinder(d=LockBearing_OD, h=LockBearing_W, center=true);
		} // for
} // ShowLockBearings

//STI_ShowLockBearings();
//STI_ShowLockBearings(nLockBalls=4);

module STI_LockDisk(nLockBalls=nLockBalls, Xtra_r=0.0){
	
	BallPerimeter_d=STI_BallPerimeter_d();
	
	MagnetOvershoot_a=STI_CalcChord_a(Dia=BallPerimeter_d-STI_LockBall_d()*2, Dist=0.6);
	
	Bearing_OD=InnerBearing_OD;
	Bearing_W=InnerBearing_W;
	
	difference(){
		union(){
			// Hub
			cylinder(d=Bearing_OD+Wall_t*2, h=LockDisk_H, center=true);
			
			// Bearing holders
			for (j=[0:nLockBalls-1]) rotate([0,0,360/nLockBalls*j]) hull(){
				cylinder(d=LockBearing_OD+2, h=LockDisk_H, center=true);
				translate([0,STI_LockPinBC_d()/2+Xtra_r,0])
					cylinder(d=LockBearing_OD, h=LockDisk_H, center=true);
				}
				
			// Magnetic latch
			rotate([0,0,STI_MagnetPost_a(nLockBalls)+MagnetOvershoot_a]) translate([-Magnet_h/2,0,0])
			hull(){
				cylinder(d=Magnet_h, h=LockDisk_H, center=true);
				translate([0,STI_MagnetBC_d()/2+Magnet_d/2,0])
					cylinder(d=Magnet_h, h=LockDisk_H, center=true);
			}
		} // union
		
		// Magnet
		rotate([0,0,STI_MagnetPost_a(nLockBalls)+MagnetOvershoot_a]) 
			translate([-Magnet_h/2, STI_MagnetBC_d()/2,0])
				rotate([0,90,0]) cylinder(d=Magnet_d, h=Magnet_h+Overlap*2, center=true);
		
		// Center Bearings
		cylinder(d=Bearing_OD-1, h=LockDisk_H+Overlap*2, center=true);
		translate([0,0,-Bearing_W/2]) 
				cylinder(d=Bearing_OD+IDXtra, h=LockDisk_H); // 12/30/2024 was IDXtra*2
				
		// Lock axles and bearings
		for (j=[0:nLockBalls-1]) rotate([0,0,360/nLockBalls*j]) 
			translate([0,STI_LockPinBC_d()/2+Xtra_r,0]) {
				cylinder(d=LockBearing_ID+IDXtra, h=LockDisk_H+Overlap*2, center=true);
				cylinder(d=LockBearing_OD+2, h=LockBearing_W+1, center=true);
				}
	} // difference
} // STI_LockDisk

//STI_LockDisk();

//STI_BallRetainerBottom(nLockBalls=3);

//rotate([0,0,Unlocked_a]) 
//{ STI_LockDisk(); STI_ShowLockBearings(); }

module STI_BR_BoltPattern(nLockBalls=nLockBalls){
	// Body bolt pattern
	
	Offset_a=STI_CalcChord_a(Dia=STI_BallPerimeter_d()-STI_LockBall_d(), Dist=STI_LockBall_d()/2+Bolt4Inset);
	
	for (j=[0:nLockBalls-1]) 
		rotate([0,0,360/nLockBalls*j+Offset_a]) translate([0,STI_BallPerimeter_d()/2-1-Bolt4Inset,0]) children();
		
} // STI_BR_BoltPattern

// STI_BR_BoltPattern() Bolt4Hole();

module STI_TubeEnd(Body_ID=LOC65Body_ID, nLockBalls=nLockBalls, Engagement_Len=20){

	// Made for 5.5" rockets w/ tighter ball fit and more contact area.
	BallPerimeter_d=STI_BallPerimeter_d();
	Ball_d=STI_LockBall_d();
	StandardWall_t=2.0;
	ThinWall_t=1.8; // 2 perimeters at thinnest wall, was 2.2
	
	Ring_OD=Body_ID-IDXtra*2; //BallPerimeter_d+StandardWall_t*2;
	BallCalcdRing_OD=BallPerimeter_d+ThinWall_t*2; // needed only for thin walled tubes
	DepthExtra=0.5;
	Extension_Len=ST_DSpring_CBL+10;
	
	nRopes=6;
	Rope_d=3;
	
	echo("STI_TubeEnd_d = ",Ring_OD);
	
	difference(){
		union(){
			translate([0,0,-Engagement_Len/2-Extension_Len]) 
				Tube(OD=Ring_OD, ID=BallPerimeter_d-4+IDXtra*3, Len=Engagement_Len+Extension_Len, myfn=180);
			
			translate([0,0,-Engagement_Len/2-Extension_Len]) cylinder(d=Ring_OD, h=3);
			
			
		} // union
		
		translate([0,0,-Engagement_Len/2-Extension_Len+3+Overlap]) cylinder(d=Ring_OD-4.4, h=Extension_Len-3, $fn=180);
		translate([0,0,-Engagement_Len/2-Overlap*2]) cylinder(d1=Ring_OD-4.4, d2=BallPerimeter_d-4+IDXtra*3-Overlap, h=4, $fn=180);
		translate([0,0,-Engagement_Len/2-Extension_Len-Overlap]) cylinder(d=InnerBearing_ID-4, h=4);
		
		//translate([0,0,-Engagement_Len/2-10-Overlap]) cylinder(d=Body_OD+IDXtra, h=10, $fn=$preview? 90:360);
		
		// Ropes
		for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j]) 
			translate([0,Ring_OD/2-Rope_d/2-4,-Engagement_Len/2-Extension_Len-Overlap])
				cylinder(d=Rope_d, h=10);
		
		//Ball Groove
		Slot_Width=Ball_d+IDXtra*3;
		myFn=$preview? 36:90;
		rotate_extrude() translate([BallPerimeter_d/2-Ball_d/2+DepthExtra,0,0]) circle(d=Slot_Width);
		
	} // difference
	
	translate([0,0,-Engagement_Len/2-Extension_Len]) 
				Tube(OD=ST_DSpring_ID, ID=ST_DSpring_ID-4.4, Len=7, myfn=180);
	
	//echo("STI_LockBall_d=",STI_LockBall_d());
} // STI_TubeEnd

// STI_TubeEnd(Body_ID=LOC65Body_ID, nLockBalls=3, Engagement_Len=17);
			
ArmingHole_d=2.5;

module STI_ManualDisArmingHole(nLockBalls=nLockBalls){
	rotate([0,0,360/nLockBalls]) translate([0, STI_LockPinBC_d()/2, -LockDiskHole_H/2+2])
		rotate([0,90,0]) cylinder(d=ArmingHole_d, h=100);
} // STI_ManualDisArmingHole

// STI_ManualDisArmingHole();	

module STI_ManualArmingHole(){

	rotate([0,0,STI_Unlocked_a()]) 
		translate([0,STI_LockPinBC_d()/2,LockDiskHole_H/2-2])
			rotate([0,-90,0]) cylinder(d=ArmingHole_d, h=100);
} // STI_ManualArmingHole
	
//STI_ManualArmingHole();

module STI_BallRetainerTop(nLockBalls=nLockBalls, Xtra_r=0.0){
			
	BallPerimeter_d=STI_BallPerimeter_d();
	Plate_T=3;
	Engagement_d=BallPerimeter_d-4;	
	Ball_d=STI_LockBall_d();
	LockDisk_d=STI_LockPinBC_d()+LockBearing_OD;
	echo(LockDisk_d=LockDisk_d);
	
	Top_H=LockDiskHole_H/2+Plate_T;
	
	ServoArm_Len=4; 
	Servo_Z=18;
	Servo_r=BallPerimeter_d/2-STI_LockBall_d()-LockBearing_OD/2-ServoArm_Len;
	
	BigBearing_ID=InnerBearing_ID;
	BigBearing_OD=InnerBearing_OD;
	BigBearing_W=InnerBearing_W;

	Bearing_ID=BigBearing_ID;
	OuterRing_OD=BallPerimeter_d;
	
	module ServoPosition(SecondServo=false){
		SecondServo_a=SecondServo? 360/nLockBalls*2:0;
		
		if (BallPerimeter_d<=PML54Body_OD){
			translate([-10,4,Servo_Z]) rotate([180,0,-90])  children();
		}else{
			Servo_a=360/nLockBalls-STI_CalcChord_a(Dia=Servo_r*2, Dist=LockBearing_OD/2+5);
			//echo(Servo_r=Servo_r);
		    //echo(nLockBalls=nLockBalls);
			rotate([0,0,Servo_a+SecondServo_a])
				translate([0,Servo_r,Servo_Z]) rotate([0,0,-135]) rotate([180,0,0]) children();
		}
		//#translate([-10,4,4]) cylinder(d=10, h=3);
	} // ServoPosition
	
	module ServoArm(){
		cylinder(d=7, h=2);
		hull(){
			cylinder(d=7, h=2);
			translate([0,10,0]) cylinder(d=4, h=2);
		}
	} // ServoArm
	
	// Show Servo Arm
	//translate([0,0,-14]) ServoPosition() rotate([0,0,20]) ServoArm();
		
	difference(){
		union(){
			cylinder(d=Engagement_d, h=Top_H, $fn=$preview? 90:360);
			
			// Servo Mount
			//ServoPosition()
			//	ServoSG90TopBlock(Xtra_Len=0, Xtra_Width=2.4, Xtra_Height=6);
			
		} // union
				
		// Balls go here
		for (j=[0:nLockBalls-1]) rotate([0,0,360/nLockBalls*j]) hull(){
			translate([0,BallPerimeter_d/2-Ball_d/2,0]) sphere(d=Ball_d+IDXtra*3);
			translate([0,Engagement_d/2-Ball_d/2,0]) sphere(d=Ball_d+IDXtra*3);
			translate([0,BallPerimeter_d/2-Ball_d/2,0.3]) sphere(d=Ball_d+IDXtra*3);
			translate([0,Engagement_d/2-Ball_d/2,0.3]) sphere(d=Ball_d+IDXtra*3);
		}
		
		// center hole
		translate([0,0,-Overlap]) cylinder(d=Bearing_ID-Wall_t*2, h=Top_H+Overlap*2);			
		
		// Bolt holes
		translate([0,0,Top_H])
			STI_BR_BoltPattern(nLockBalls=nLockBalls) 
				Bolt4HeadHole(depth=8, lHead=20);
				
		// Lock Disk goes here
		cylinder(d=LockDisk_d+1+Xtra_r*2, h=LockDiskHole_H, center=true);
		hull() for (j=[-9:9]) rotate([0,0,j]) {
			translate([0,-(BallPerimeter_d-4)/2+7,0]) cylinder(d=10, h=LockDiskHole_H, center=true);
			translate([0,-(BallPerimeter_d-4)/2+10,0]) cylinder(d=10, h=LockDiskHole_H, center=true);
		}
				
		// Locked stop
		STI_LockedStopPosition()
			cylinder(d=Dowel_d, h=Top_H*2+Overlap*2,center=true);
			
		// Unlocked Stop
		STI_UnlockedStopPosition(nLockBalls=nLockBalls)
			cylinder(d=Dowel_d, h=Top_H*2+Overlap*2, center=true);
		
		// Servo
		//ServoPosition() ServoSG90(TopMount=false,HasGear=false); 
			
		//notch for magnet latch
		rotate([0,0,STI_MagnetPost_a(nLockBalls)]) translate([Magnet_h/2,0,0])
			hull(){
				translate([0,STI_MagnetBC_d()/2-3,0])
					cylinder(d=Magnet_h+IDXtra*4, h=LockDisk_H+4, center=true);
				translate([0,STI_MagnetBC_d()/2+4,0])
					cylinder(d=Magnet_h+IDXtra*4, h=LockDisk_H+4, center=true);
			}
			
		//if ($preview) translate([0,0,-1]) cube([Engagement_d/2+10,Engagement_d/2+10,50]);
	} // difference
	
	// Large bearing holder
	difference(){
		translate([0,0,InnerBearing_W/2+0.3]) 
				cylinder(d=Bearing_ID+4, h=LockDiskHole_H/2-InnerBearing_W/2);
		
		translate([0,0,-Overlap]) cylinder(d=Bearing_ID+IDXtra*2, h=LockDiskHole_H/2+0.3+Overlap*2);
	} // difference
			
} // STI_BallRetainerTop

// STI_BallRetainerTop();
		
module STI_BallRetainerBottom(nLockBalls=nLockBalls, Xtra_r=0.0){

	BallPerimeter_d=STI_BallPerimeter_d();
	Ball_d=STI_LockBall_d();
	Plate_T=3;
	Bottom_H=LockDiskHole_H/2+Plate_T;
	LockDisk_d=STI_LockPinBC_d()+LockBearing_OD;
	echo(LockDisk_d=LockDisk_d);
	
	//echo(Bottom_H=Bottom_H);
	
	BigBearing_ID=InnerBearing_ID;
	BigBearing_OD=InnerBearing_OD;
	BigBearing_W=InnerBearing_W;

	Bearing_ID=BigBearing_ID;
		
	difference(){
		translate([0,0,-Bottom_H]) 
			cylinder(d=BallPerimeter_d-4, h=Bottom_H, $fn=$preview? 90:360);
		
		// Balls go here
		for (j=[0:nLockBalls-1]) rotate([0,0,360/nLockBalls*j]) hull(){
			translate([0,BallPerimeter_d/2-Ball_d/2,0]) sphere(d=Ball_d+IDXtra*3);
			translate([0,BallPerimeter_d/2-Ball_d/2-2,0]) sphere(d=Ball_d+IDXtra*3);
		}
		
		// center hole
		translate([0,0,-Bottom_H-Overlap]) cylinder(d=Bearing_ID-Wall_t*2, h=Bottom_H);
		
		// Bolt holes
		STI_BR_BoltPattern(nLockBalls=nLockBalls) Bolt4Hole(depth=Bottom_H);
		rotate([0,0,-45]) STI_BR_BoltPattern(nLockBalls=nLockBalls) Bolt4Hole(depth=Bottom_H);
			
		// Lock Disk goes here
		cylinder(d=LockDisk_d+1+Xtra_r*2, h=LockDiskHole_H, center=true);
		hull() for (j=[-9:9]) rotate([0,0,j]) {
			translate([0,-(BallPerimeter_d-4)/2+7,0]) cylinder(d=10, h=LockDiskHole_H, center=true);
			translate([0,-(BallPerimeter_d-4)/2+10,0]) cylinder(d=10, h=LockDiskHole_H, center=true);
		}
			
		// Lock disk axle goes here
		cylinder(d=LockBearing_ID+IDXtra, h=LockDiskHole_H*2+Overlap*2, center=true);
	
		// Locked stop
		STI_LockedStopPosition()
				cylinder(d=Dowel_d, h=Bottom_H*2+Overlap*2,center=true);
		
		// Unlocked Stop
		STI_UnlockedStopPosition(nLockBalls=nLockBalls)
				cylinder(d=Dowel_d, h=Bottom_H*2+Overlap*2, center=true);
				
		//if ($preview) translate([0,0,-20]) cube([Body_OD/2+10,Body_OD/2+10,50]);
	} // difference
	
	// Large bearing holder
	difference(){
		union(){
			translate([0,0,-LockDiskHole_H/2-Overlap]) cylinder(d=Bearing_ID, h=LockDiskHole_H);
			translate([0,0,-LockDiskHole_H/2-Overlap]) 
				cylinder(d=Bearing_ID+4, h=LockDiskHole_H/2-BigBearing_W/2-0.3);
		} // union
		
		translate([0,0,-Bottom_H-Overlap]) cylinder(d=Bearing_ID-Wall_t*2, h=Plate_T+LockDiskHole_H+5);
	} // difference
			
	
	// Magnetic latch
	difference(){
		rotate([0,0,STI_MagnetPost_a(nLockBalls)]) translate([Magnet_h/2,0,0])
			hull(){
				translate([0,STI_MagnetBC_d()/2-3,0])
					cylinder(d=Magnet_h, h=LockDisk_H+2, center=true);
				translate([0,STI_MagnetBC_d()/2+4,0])
					cylinder(d=Magnet_h, h=LockDisk_H+2, center=true);
			}
			
		// Magnet
		rotate([0,0,STI_MagnetPost_a(nLockBalls)]) translate([Magnet_h/2,STI_MagnetBC_d()/2,0])
			rotate([0,90,0]) cylinder(d=Magnet_d, h=Magnet_h+Overlap*2, center=true);
	} // difference
} // STI_BallRetainerBottom

// STI_BallRetainerBottom();

module STI_SpringEndOne(){
	nRopes=6;
	Rope_d=3;
	OD=STI_BallPerimeter_d()-4;
	Base_t=3;
	H=8;
	
	difference(){
		union(){
			STI_BR_BoltPattern(nLockBalls=nLockBalls) cylinder(d=6, h=H);
			Tube(OD=OD, ID=OD-Wall_t*2, Len=H, myfn=180);
			Tube(OD=ST_DSpring_OD+Wall_t*2, ID=ST_DSpring_ID, Len=2, myfn=180);
			Tube(OD=OD, ID=ST_DSpring_ID-4.4, Len=Base_t, myfn=180);
			Tube(OD=OD, ID=ST_DSpring_OD, Len=H, myfn=180);
			Tube(OD=ST_DSpring_ID, ID=ST_DSpring_ID-4.4, Len=Base_t+2, myfn=180);
		} // union

		translate([0,0,3.7]) STI_BR_BoltPattern(nLockBalls=nLockBalls) Bolt4ButtonHeadHole();
		
		for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j]) translate([0,OD/2-Rope_d/2-1,-Overlap]){
			cylinder(d=Rope_d, h=H+Overlap*2);
			cylinder(d=Rope_d+2, h=Base_t-0.6);
		}
		
	} // difference
} // STI_SpringEndOne

// translate([0,0,-9]) rotate([180,0,53]) STI_SpringEndOne();



















