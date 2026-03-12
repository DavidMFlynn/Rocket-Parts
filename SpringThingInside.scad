// ***********************************
// Project: 3D Printed Rocket
// Filename: SpringThingInside.scad
// by David M. Flynn
// Created: 11/26/2025
// Revision: 1.0.5   2/16/2026
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
//  MG90S or Eqiv. 12g Micro Servo
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
function SpringThingInsideRev()="SpringThingInside Rev. 1.0.5";
echo(SpringThingInsideRev());
//
// 1.0.5   2/16/2026  More parametric
// 1.0.4   12/28/2025 Added rope holes to STI_SmallSpringSplice();
// 1.0.3   12/7/2025  More parametric
// 1.0.2   12/6/2025  54mm version
// 1.0.1   11/27/2025 It works. Ready for testing.
// 1.0.0   11/26/2025 Copied from SpringThingBooster 1.5.0
//
// ***********************************
//  ***** for STL output *****
//
//  *** 75mm ***
//
// STI_ServoMount(Body_ID=ULineH75Body_ID);
// STI_LockDisk(Body_ID=ULineH75Body_ID, nLockBalls=nLockBalls, Xtra_r=0.0);
// STI_SpringEndTwo(Body_ID=ULineH75Body_ID, nLockBalls=nLockBalls, HasPetalLock=true, DualSpring=true);
// rotate([180,0,0]) STI_BallRetainerTop(Body_ID=ULineH75Body_ID, nLockBalls=nLockBalls, Xtra_r=0.0);
// STI_BallRetainerBottom(Body_ID=ULineH75Body_ID, nLockBalls=nLockBalls, Xtra_r=0.0);
// STI_SpringEndOne(Body_ID=ULineH75Body_ID);
// STI_SmallSpringSplice(Body_ID=ULineH75Body_ID);
//
//  *** 65mm ***
//
// STI_ServoMount(Body_ID=LOC65Body_ID);
// STI_LockDisk(Body_ID=LOC65Body_ID, nLockBalls=nLockBalls, Xtra_r=0.0);
// STI_SpringEndTwo(Body_ID=LOC65Body_ID, nLockBalls=nLockBalls, HasPetalLock=false, DualSpring=false);
// rotate([180,0,0]) STI_BallRetainerTop(Body_ID=LOC65Body_ID, nLockBalls=nLockBalls, Xtra_r=0.0);
// STI_BallRetainerBottom(Body_ID=LOC65Body_ID, nLockBalls=nLockBalls, Xtra_r=0.0);
// STI_SpringEndOne(Body_ID=LOC65Body_ID);
//
//  *** 54mm ***
//
// STI_ServoMount(Body_ID=LOC54Body_ID, MountBoltBC_d=38);
// STI_LockDisk(Body_ID=LOC54Body_ID, nLockBalls=nLockBalls, Xtra_r=0.0);
// rotate([180,0,0]) STI_BallRetainerTop(Body_ID=LOC54Body_ID, nLockBalls=nLockBalls, Xtra_r=0.0);
// STI_BallRetainerBottom(Body_ID=LOC54Body_ID, nLockBalls=nLockBalls, Xtra_r=0.0);
// STI_SpringEndTwo(Body_ID=LOC54Body_ID-IDXtra, nLockBalls=3, HasPetalLock=true, DualSpring=false);
// STI_SpringEndOne(Body_ID=LOC54Body_ID);
// STI_SmallSpringSplice(Body_ID=LOC54Body_ID);
//
// ---------------
//  *** Tools ***
//
//
// ***********************************
//  ***** Routines *****
//
//
// ***********************************
//  ***** for Viewing *****
//
// Show_STI(Body_ID=LOC65Body_ID);
// Show_STI(Body_ID=LOC54Body_ID);
// STI_ShowLockBearings(nLockBalls=nLockBalls);
// STI_ShowMyBalls(nLockBalls=nLockBalls, InLockedPosition=true);
//
// ***********************************

include<TubesLib.scad>
use<SpringEndsLib.scad>
use<PetalDeploymentLib.scad>
use<SG90ServoLib.scad>
use<ThreadLib.scad>
//use<BatteryHolderLib.scad>
//include<CommonStuffSAEmm.scad>

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

// -----------------------

BearingMR63_OD=6;
BearingMR63_ID=3;
BearingMR63_W=2.5;

BearingMR84_OD=8;
BearingMR84_ID=4;
BearingMR84_W=3;

Bearing6700_ID=10;
Bearing6700_OD=15;
Bearing6700_W=4;

Bearing6701_ID=12;
Bearing6701_OD=18;
Bearing6701_W=4;

Bearing6703_ID=17;
Bearing6703_OD=23;
Bearing6703_W=4;

Bearing6704_ID=20;
Bearing6704_OD=27;
Bearing6704_W=4;

//LockBall_d=5/16 * 25.4;
LockBall_d=3/8 * 25.4;
Spool_Wall_t=2.0;

nLockBalls=3;

Bolt4Inset=4;
Bolt10Inset=5.5;
Wall_t=1.6;

// Deployment Spring big and light
//ST_DSpring_OD=SE_Spring_CS4323_OD();
//ST_DSpring_ID=SE_Spring_CS4323_ID();
//ST_DSpring_CBL=SE_Spring_CS4323_CBL(); // coil bound length
//ST_DSpring_FL=SE_Spring_CS4323_FL(); // free length

LockDisk_H=10; // length of dowel pins
LockDiskHole_H=LockDisk_H+1;

function STI_Spring_ID(Body_ID)=Body_ID<60? SE_Spring3670_ID():SE_Spring_CS4323_ID();
function STI_Spring_OD(Body_ID)=Body_ID<60? SE_Spring3670_OD():SE_Spring_CS4323_OD();
function STI_Spring_CBL(Body_ID)=Body_ID<60? SE_Spring3670_CBL():SE_Spring_CS4323_CBL();

function STI_LockBall_d(Body_ID=LOC54Body_ID)=LockBall_d;

// Balls out
function STI_BallPerimeter_d(Slider_OD=LOC54Body_ID)=Slider_OD;
//echo(str("Tube ID = ",LOC54Body_ID));
//echo(str("STI_BallPerimeter_d =",STI_BallPerimeter_d()));
function STI_CalcChord_a(Dia=10, Dist=1)=Dist/(Dia*PI)*360;

function STI_LockPinBC_d(Body_ID=LOC54Body_ID)=STI_BallPerimeter_d(Body_ID)-STI_LockBall_d(Body_ID)*2-STI_LockBearing_OD(Body_ID);
	
function STI_Unlocked_a(Body_ID=LOC54Body_ID, nLockBalls=nLockBalls)=STI_CalcChord_a(Dia=STI_LockPinBC_d(Body_ID), 
						Dist=STI_LockBall_d(Body_ID)*0.35+STI_LockBearing_OD(Body_ID)*0.35); // +360/nLockBalls
				
function STI_MagnetPost_a(Body_ID=LOC54Body_ID, nLockBalls=nLockBalls)=
			//STI_UnlockedPost_a(nLockBalls)+
			-180/nLockBalls*3-STI_CalcChord_a(Dia=STI_LockPinBC_d(Body_ID), Dist=Magnet_h/2);
			//STI_CalcChord_a(Dia=STI_LockPinBC_d(), Dist=Dowel_d/2+Magnet_h);
			
//echo(STI_Unlocked_a());

function STI_MagnetBC_d(Body_ID=LOC65Body_ID)=STI_InnerBearing_OD(Body_ID)+Wall_t*2+Magnet_d+4.5;
function STI_Engagement_d(Body_ID=LOC65Body_ID)=STI_BallPerimeter_d(Body_ID)-Spool_Wall_t*2-IDXtra*3;

function STI_InnerBearing_ID(Body_ID=LOC65Body_ID)=(Body_ID>60)? Bearing6704_ID:Bearing6700_ID;
function STI_InnerBearing_OD(Body_ID=LOC65Body_ID)=(Body_ID>60)? Bearing6704_OD:Bearing6700_OD;
function STI_InnerBearing_W(Body_ID=LOC65Body_ID)=(Body_ID>60)? Bearing6704_W:Bearing6700_W;
function STI_LockBearing_OD(Body_ID)=Body_ID>65? BearingMR84_OD:BearingMR63_OD;
function STI_LockBearing_ID(Body_ID)=Body_ID>65? BearingMR84_ID:BearingMR63_ID;
function STI_LockBearing_W(Body_ID)=Body_ID>65? BearingMR84_W:BearingMR63_W;

function STI_TriggerPost_a(Body_ID=LOC65Body_ID)=120-STI_CalcChord_a(Dia=STI_LockPinBC_d(),
									Dist=STI_LockBearing_OD(Body_ID)/2+STI_LockBearing_ID(Body_ID)/2+6);


module Show_STI(Body_ID=LOC65Body_ID, DualSpring=false){
	translate([0,0,8.7]) STI_ServoMount(Body_ID=Body_ID, nLockBalls=nLockBalls);
	STI_LockDisk(Body_ID=Body_ID);
	color("Red") STI_ShowMyBalls(Body_ID=Body_ID, nLockBalls=nLockBalls, InLockedPosition=true);
	STI_ShowLockBearings(Body_ID=Body_ID, nLockBalls=nLockBalls);
	difference(){
		union(){
			translate([0,0,0.1]) color("Tan") STI_BallRetainerTop(Body_ID=Body_ID);
			STI_BallRetainerBottom(Body_ID=Body_ID);
			STI_SpringEndTwo(Body_ID=Body_ID, nLockBalls=nLockBalls, HasPetalLock=true, DualSpring=DualSpring);
		} // union
		
		translate([0,0,-44]) cube([40,40,60]);
	} // difference
	
	translate([0,0,-8.8]) rotate([180,0,53]) color("Green") STI_SpringEndOne(Body_ID=Body_ID);
} // Show_STI

// Show_STI(Body_ID=ULineH75Body_ID);

module STI_LockedStopPosition(Body_ID=LOC65Body_ID){
	OverCenterValue=0.2;
	
	translate([STI_LockBearing_OD(Body_ID)/2+STI_LockBearing_ID(Body_ID)/2+OverCenterValue, STI_LockPinBC_d(Body_ID)/2,0])
		children();
} // STI_LockedStopPosition
	
module STI_UnlockedStopPosition(Body_ID=LOC65Body_ID, nLockBalls=nLockBalls){
	
	rotate([0,0,STI_Unlocked_a(Body_ID=Body_ID, nLockBalls=nLockBalls)])
	translate([-STI_LockBearing_OD(Body_ID)/2-STI_LockBearing_ID(Body_ID)/2, STI_LockPinBC_d(Body_ID)/2,0])
		children();
} // STI_UnlockedStopPosition

module STI_ShowMyBalls(Body_ID=Body_ID, nLockBalls=nLockBalls, InLockedPosition=true){
	BallPerimeter_d=STI_BallPerimeter_d(Body_ID);
	
	Ball_Y=InLockedPosition? BallPerimeter_d/2-STI_LockBall_d()/2 : BallPerimeter_d/2-STI_LockBall_d()/2-2;
	
	for (j=[0:nLockBalls-1]) rotate([0,0,360/nLockBalls*j]) 
			translate([0,Ball_Y,0]) 
				color("Red") sphere(d=STI_LockBall_d());

} // STI_ShowMyBalls

//STI_ShowMyBalls(nLockBalls=nLockBalls, InLockedPosition=true);
//STI_ShowMyBalls(nLockBalls=nLockBalls, InLockedPosition=false);

module STI_ShowLockBearings(Body_ID=LOC65Body_ID, nLockBalls=nLockBalls){
	
	for (j=[0:nLockBalls-1]) rotate([0,0,360/nLockBalls*j]) 
		translate([0,STI_LockPinBC_d(Body_ID)/2,0]) {
			color("Red") cylinder(d=STI_LockBearing_ID(Body_ID), h=10+Overlap, center=true);
			color("Blue") cylinder(d=STI_LockBearing_OD(Body_ID), h=STI_LockBearing_W(Body_ID), center=true);
		} // for
} // ShowLockBearings

//STI_ShowLockBearings();
//STI_ShowLockBearings(nLockBalls=4);


module STI_LockDisk(Body_ID=LOC65Body_ID, nLockBalls=nLockBalls, Xtra_r=0.0){
	TP_a=STI_TriggerPost_a(Body_ID);
	BallPerimeter_d=STI_BallPerimeter_d(Body_ID);
	
	MagnetOvershoot_a=STI_CalcChord_a(Dia=BallPerimeter_d-STI_LockBall_d(Body_ID)*2, Dist=0.6);
	
	Bearing_OD=STI_InnerBearing_OD(Body_ID);
	Bearing_W=STI_InnerBearing_W(Body_ID);
	
	module LockBearingBoss(Body_ID=LOC65Body_ID){
		hull(){
			cylinder(d=STI_LockBearing_OD(Body_ID)+2, h=LockDisk_H, center=true);
				
			translate([0,STI_LockPinBC_d(Body_ID)/2+Xtra_r,0])
				cylinder(d=STI_LockBearing_OD(Body_ID), h=LockDisk_H, center=true);
		}
	} // LockBearingBoss
	
	difference(){
		union(){
			// Hub
			cylinder(d=Bearing_OD+Wall_t*2, h=LockDisk_H, center=true);
			
			// Bearing holders
			for (j=[0:nLockBalls-1]) rotate([0,0,360/nLockBalls*j]) LockBearingBoss(Body_ID);
				
			// Magnetic latch
			rotate([0,0,STI_MagnetPost_a(Body_ID, nLockBalls)+MagnetOvershoot_a]) translate([-Magnet_h/2,0,0])
			hull(){
				cylinder(d=Magnet_h, h=LockDisk_H, center=true);
				translate([0,STI_MagnetBC_d(Body_ID)/2+Magnet_d/2,0])
					cylinder(d=Magnet_h, h=LockDisk_H, center=true);
			}
			
			// Trigger Post
			rotate([0,0,TP_a]) LockBearingBoss(Body_ID);
			
		} // union
		
		// Trigger Post
		rotate([0,0,TP_a]) translate([0,STI_LockPinBC_d(Body_ID)/2+Xtra_r,0])
			cylinder(d=STI_LockBearing_ID(Body_ID)+IDXtra, h=LockDisk_H+Overlap*2, center=true);
		
		// Magnet
		#rotate([0,0,STI_MagnetPost_a(Body_ID, nLockBalls)+MagnetOvershoot_a]) 
			translate([-Magnet_h/2, STI_MagnetBC_d(Body_ID)/2,0])
				rotate([0,90,0]) cylinder(d=Magnet_d, h=Magnet_h+Overlap*2, center=true);
		
		// Center Bearings
		cylinder(d=Bearing_OD-1, h=LockDisk_H+Overlap*2, center=true);
		translate([0,0,-Bearing_W/2]) 
				cylinder(d=Bearing_OD+IDXtra, h=LockDisk_H); // 12/30/2024 was IDXtra*2
				
		// Lock axles and bearings
		for (j=[0:nLockBalls-1]) rotate([0,0,360/nLockBalls*j]) 
			translate([0,STI_LockPinBC_d(Body_ID)/2+Xtra_r,0]) {
				cylinder(d=STI_LockBearing_ID(Body_ID)+IDXtra, h=LockDisk_H+Overlap*2, center=true);
				cylinder(d=STI_LockBearing_OD(Body_ID)+2, h=STI_LockBearing_W(Body_ID)+1, center=true);
				}
	} // difference
} // STI_LockDisk

// STI_LockDisk();

// STI_BallRetainerBottom(nLockBalls=3);

//rotate([0,0,Unlocked_a]) 
//{ STI_LockDisk(); STI_ShowLockBearings(); }

module STI_BR_BoltPattern(Body_ID=LOC65Body_ID, nLockBalls=nLockBalls){
	// Body bolt pattern
	
	Offset_a=STI_CalcChord_a(Dia=STI_BallPerimeter_d(Body_ID)-STI_LockBall_d(Body_ID), Dist=STI_LockBall_d(Body_ID)/2+Bolt4Inset);
	
	for (j=[0:nLockBalls-1]) 
		rotate([0,0,360/nLockBalls*j+Offset_a]) translate([0,STI_BallPerimeter_d(Body_ID)/2-1-Bolt4Inset,0]) children();
		
} // STI_BR_BoltPattern

// STI_BR_BoltPattern() Bolt4Hole();

module STI_MountingBoltPattern(Body_ID=LOC65Body_ID, nLockBalls=nLockBalls){
	Offset_a=-STI_CalcChord_a(Dia=STI_BallPerimeter_d(Body_ID)-STI_LockBall_d(Body_ID), Dist=STI_LockBall_d(Body_ID)/2+Bolt4Inset);
	
	for (j=[0:nLockBalls-1]) 
		rotate([0,0,360/nLockBalls*j+Offset_a]) translate([0,STI_BallPerimeter_d(Body_ID)/2-1-Bolt4Inset,0]) children();

} // STI_MountingBoltPattern

module STI_SpringEndTwo(Body_ID=LOC65Body_ID, nLockBalls=nLockBalls, HasPetalLock=false, DualSpring=false){

	// Made for 5.5" rockets w/ tighter ball fit and more contact area.
	BallPerimeter_d=STI_BallPerimeter_d(Body_ID);
	Ball_d=STI_LockBall_d(Body_ID);
	ThinWall_t=1.8; // 2 perimeters at thinnest wall, was 2.2
	Ring_OD=Body_ID-IDXtra*2;
	BallCalcdRing_OD=BallPerimeter_d+ThinWall_t*2; // needed only for thin walled tubes
	DepthExtra=0.0;
	
	SmallSpring=(Body_ID<STI_Spring_OD(Body_ID)+12);
	
	Spring_ID=STI_Spring_ID(Body_ID);
	Spring_OD=STI_Spring_OD(Body_ID);
	Spring_CBL=DualSpring? STI_Spring_CBL(Body_ID)*2+5:STI_Spring_CBL(Body_ID);
	OD=Body_ID;
	ID=Ring_OD-ThinWall_t*2;
	
	Engagement_Len=17;
	Extension_Len=SmallSpring? Spring_CBL*2+2+12:Spring_CBL+10;
	echo(Extension_Len=Extension_Len);
	
	nRopes=6;
	Rope_d=3;
	RopeBC_d=Spring_OD+Rope_d+2;
	
	echo("STI_TubeEnd_d = ",Ring_OD);
	
	difference(){
		union(){
			translate([0,0,-Engagement_Len/2-Extension_Len]) 
				Tube(OD=Ring_OD, ID=BallPerimeter_d-4+IDXtra*3, Len=Engagement_Len+Extension_Len, myfn=180);
			
			translate([0,0,-Engagement_Len/2-Extension_Len]) cylinder(d=Ring_OD, h=3);
			
			if (HasPetalLock) translate([0,0,-Engagement_Len/2-Extension_Len]) 
				difference(){
					Tube(OD=Ring_OD, ID=Ring_OD-12, Len=8, myfn=180);
					
					translate([0,0,5]) cylinder(d1=Ring_OD-12, d2=Body_ID-ThinWall_t*2, h=3+Overlap,$fn=180);
				} // difference
		} // union
		
		Lock_H=4;
		
		if (HasPetalLock) {
			translate([0,0,-Engagement_Len/2-Extension_Len+Lock_H+6]) cylinder(d=ID, h=Extension_Len+Engagement_Len/2+Overlap, $fn=180);
		}else{
			translate([0,0,-Engagement_Len/2-Extension_Len+3+Overlap]) cylinder(d=ID, h=Extension_Len+Engagement_Len/2+6, $fn=180);
		}
		
		// Center hole
		translate([0,0,-Engagement_Len/2-Extension_Len-Overlap]) cylinder(d=STI_InnerBearing_ID(Body_ID)-4, h=4);
				
		// Ropes
		for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j]) 
			translate([0,RopeBC_d/2,-Engagement_Len/2-Extension_Len-Overlap])
				cylinder(d=Rope_d, h=10);
				
		for (j=[0:nLockBalls]) rotate([0,0,360/nLockBalls*j]) rotate([-90,0,0]) cylinder(d=Ball_d*0.8, h=Body_ID/2+1);
		
		// Petal Locks
		if (HasPetalLock) translate([0,0,-Engagement_Len/2-Extension_Len])
			PD_PetalLockGroove(Tube_ID=Body_ID);
		
		if ($preview) translate([0,0,-50]) cube([100,100,100]);
	} // difference
	
	// Spring alignment ring
	translate([0,0,-Engagement_Len/2-Extension_Len]) 
				Tube(OD=Spring_ID, ID=Spring_ID-4.4, Len=7, myfn=180);
	
	//echo("STI_LockBall_d=",STI_LockBall_d());
	//cylinder(d=Spring_OD, h=20);
} // STI_SpringEndTwo

// STI_SpringEndTwo(Body_ID=LOC65Body_ID, nLockBalls=3, HasPetalLock=true);
// STI_SpringEndTwo(Body_ID=LOC54Body_ID, nLockBalls=3, HasPetalLock=true);

module STI_ServoMount(Body_ID=LOC65Body_ID, nLockBalls=nLockBalls, MountBoltBC_d=0){
	Top_H=3;
	SmallBody=(Body_ID<56);
	OD=Body_ID-IDXtra*2;
	
	ServoArm_Len=4;
	Servo_Z=17;
	ServoPos_a=STI_TriggerPost_a(Body_ID)-STI_CalcChord_a(Dia=STI_LockPinBC_d(Body_ID), Dist=ServoArm_Len); // was SmallBody? 54:54;
	ServoRot_a=SmallBody? 10:0;
	Servo_r=SmallBody? STI_LockPinBC_d(Body_ID)/2-ServoArm_Len : STI_LockPinBC_d(Body_ID)/2-ServoArm_Len;
	// old STI_InnerBearing_OD(Body_ID)/2+Wall_t+3+ServoArm_Len;
	
	MountingPost_H=8;
	MountingPost_a=SmallBody? [-50,-50+180]:[-50,180-50];
	
	Thread1024_d=0.190*25.4;
	Thread_d=Thread1024_d;
	Thread_p=25.4/24;

	Post_r=(MountBoltBC_d==0)? OD/2-Bolt10Inset:MountBoltBC_d/2;
	
	module ServoPosition(){
		//echo(Servo_r=Servo_r);
		//echo(nLockBalls=nLockBalls);
		rotate([0,0,ServoPos_a])
			translate([0,Servo_r,Servo_Z]) rotate([0,0,ServoRot_a]) rotate([180,0,0]) children();
		
		//#translate([-10,4,4]) cylinder(d=10, h=3);
	} // ServoPosition
	
	
	difference(){
		union(){
			cylinder(d=OD, h=Top_H, $fn=180);
		
			// Servo Mount
			intersection(){
				ServoPosition()
					ServoSG90TopBlock(Xtra_Len=0, Xtra_Width=-0.1, Xtra_Height=9.5);
					
				cylinder(d=OD, h=20, $fn=180);
			} // intersection
					
			// Mounting posts
			for (j=MountingPost_a) rotate([0,0,j]) translate([0,Post_r,Top_H-Overlap])
				cylinder(d=Bolt10Inset*2, h=MountingPost_H-Top_H+Overlap);
		} // union
		
		// Servo wheel clearance
		translate([0,0,-5]) ServoPosition() 
		if (SmallBody){
			hull(){
				cylinder(d=13, h=20);
				translate([0,-4,0]) cylinder(d=13, h=20);
				//translate([-3,-5,0]) cylinder(d=12, h=20);
			} // hull
		}else{
			hull(){
				cylinder(d=13, h=20);
				translate([0,4,0]) cylinder(d=13, h=20);
				translate([0,-4,0]) cylinder(d=13, h=20);
				translate([3,5,0]) cylinder(d=12, h=20);
			} // hull
		}
		
		// Trigger Post, copied from STI_BallRetainerTop
		TP_a=STI_TriggerPost_a(Body_ID);
		TP_Travel_a=STI_Unlocked_a(Body_ID);
		TP_W=3;
		
		for (j=[-4:TP_Travel_a+1]){
			hull(){
				rotate([0,0,TP_a+j]) translate([0, STI_LockPinBC_d(Body_ID)/2, -Overlap]) 
					cylinder(d=TP_W+2, h=Top_H+Overlap*2);
				rotate([0,0,TP_a+j+1]) translate([0, STI_LockPinBC_d(Body_ID)/2, -Overlap]) 
					cylinder(d=TP_W+2, h=Top_H+Overlap*2);
			} // hull
			
		}
		
		
		// Mounting post threads
		for (j=MountingPost_a) rotate([0,0,j]) translate([0,Post_r,0])
			if ($preview){ 
				translate([0,0,-Overlap]) cylinder(d=Thread_d, h=MountingPost_H+Overlap*2);
			}else{ 
				translate([0,0,-Overlap]) 
					ExternalThread(Pitch=Thread_p, Dia_Nominal=Thread_d+IDXtra*2, 
								Length=MountingPost_H+Overlap*2, 
								Step_a=2,TrimEnd=true,TrimRoot=true); 
			} // if
							
		// center hole
		translate([0,0,-Overlap]) cylinder(d=STI_InnerBearing_ID(Body_ID)-Wall_t*2, h=Top_H+Overlap*2);			

		// Bolt holes
		translate([0,0,Top_H+1.68]) STI_MountingBoltPattern(Body_ID=Body_ID, nLockBalls=nLockBalls) Bolt4ButtonHeadHole(depth=Top_H+1);
		//rotate([0,0,-45]) STI_BR_BoltPattern(nLockBalls=nLockBalls) 
	} // difference
} // STI_ServoMount

//translate([0,0,8.7]) STI_ServoMount(Body_ID=LOC54Body_ID);
//STI_BallRetainerTop();
//STI_LockDisk();
// STI_ServoMount(Body_ID=LOC65Body_ID, nLockBalls=nLockBalls, MountBoltBC_d=38);

module STI_BallRetainerTop(Body_ID=LOC65Body_ID, nLockBalls=nLockBalls, Xtra_r=0.0){
			
	BallPerimeter_d=STI_BallPerimeter_d(Body_ID);
	Plate_T=3;
	Engagement_d=BallPerimeter_d-Spool_Wall_t*2-IDXtra*3;	
	Ball_d=STI_LockBall_d(Body_ID);
	LockDisk_d=STI_LockPinBC_d(Body_ID)+STI_LockBearing_OD(Body_ID);
	echo(LockDisk_d=LockDisk_d);
	
	Top_H=LockDiskHole_H/2+Plate_T;
		
	BigBearing_ID=STI_InnerBearing_ID(Body_ID);
	BigBearing_OD=STI_InnerBearing_OD(Body_ID);
	BigBearing_W=STI_InnerBearing_W(Body_ID);

	Bearing_ID=BigBearing_ID;
	OuterRing_OD=BallPerimeter_d;
	
		
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
		translate([0,0,Top_H]){
			STI_BR_BoltPattern(Body_ID=Body_ID, nLockBalls=nLockBalls) Bolt4HeadHole(depth=8, lHead=20);
			STI_MountingBoltPattern(Body_ID=Body_ID, nLockBalls=nLockBalls) Bolt4Hole(depth=Top_H+1);
		}
				
		// Lock Disk goes here
		cylinder(d=LockDisk_d+1+Xtra_r*2, h=LockDiskHole_H, center=true);
		
				
		// Trigger Post
			TP_a=STI_TriggerPost_a(Body_ID);
			TP_W=STI_LockBearing_ID(Body_ID);
			TP_Travel_a=STI_Unlocked_a(Body_ID);
			
			for (j=[0:TP_Travel_a]){
				hull(){
					rotate([0,0,TP_a+j]) translate([0, STI_LockPinBC_d(Body_ID)/2, 0]) 
						cylinder(d=TP_W+1.4, h=Top_H+Overlap);
					rotate([0,0,TP_a+j+1]) translate([0, STI_LockPinBC_d(Body_ID)/2, 0]) 
						cylinder(d=TP_W+1.4, h=Top_H+Overlap);
				} // hull
				
			}
			
		// Locked stop
		STI_LockedStopPosition(Body_ID)
			cylinder(d=STI_LockBearing_ID(Body_ID), h=Top_H*2+Overlap*2,center=true);
			
		// Unlocked Stop
		STI_UnlockedStopPosition(Body_ID=Body_ID, nLockBalls=nLockBalls)
			cylinder(d=STI_LockBearing_ID(Body_ID), h=Top_H*2+Overlap*2, center=true);
		
		//notch for magnet latch
		rotate([0,0,STI_MagnetPost_a(Body_ID=Body_ID, nLockBalls=nLockBalls)]) translate([Magnet_h/2,0,0])
			hull(){
				translate([0,STI_MagnetBC_d(Body_ID=Body_ID)/2-3,0])
					cylinder(d=Magnet_h+IDXtra*4, h=LockDisk_H+4, center=true);
				translate([0,STI_MagnetBC_d(Body_ID=Body_ID)/2+4,0])
					cylinder(d=Magnet_h+IDXtra*4, h=LockDisk_H+4, center=true);
			}
			
		//if ($preview) translate([0,0,-1]) cube([Engagement_d/2+10,Engagement_d/2+10,50]);
	} // difference
	
	// Large bearing holder
	difference(){
		translate([0,0,STI_InnerBearing_W(Body_ID)/2+0.3]) 
				cylinder(d=Bearing_ID+3, h=LockDiskHole_H/2-STI_InnerBearing_W(Body_ID)/2);
		
		translate([0,0,-Overlap]) cylinder(d=Bearing_ID+IDXtra*2, h=LockDiskHole_H/2+0.3+Overlap*2);
	} // difference
			
} // STI_BallRetainerTop

// STI_BallRetainerTop(Body_ID=ULineH75Body_ID);
// STI_LockDisk(Body_ID=ULineH75Body_ID);

module STI_BallRetainerBottom(Body_ID=LOC65Body_ID, nLockBalls=nLockBalls, Xtra_r=0.0){

	BallPerimeter_d=STI_BallPerimeter_d(Body_ID);
	Ball_d=STI_LockBall_d(Body_ID);
	Plate_T=3;
	Bottom_H=LockDiskHole_H/2+Plate_T;
	LockDisk_d=STI_LockPinBC_d(Body_ID)+STI_LockBearing_OD(Body_ID);
	echo(LockDisk_d=LockDisk_d);
	Engagement_d=STI_Engagement_d(Body_ID);
	//echo(Bottom_H=Bottom_H);
	
	BigBearing_ID=STI_InnerBearing_ID(Body_ID);
	BigBearing_OD=STI_InnerBearing_OD(Body_ID);
	BigBearing_W=STI_InnerBearing_W(Body_ID);

	Bearing_ID=BigBearing_ID;
		
	
	difference(){
		translate([0,0,-Bottom_H]) 
			cylinder(d=Engagement_d, h=Bottom_H, $fn=$preview? 90:360);
		
		// Balls go here
		for (j=[0:nLockBalls-1]) rotate([0,0,360/nLockBalls*j]) hull(){
			translate([0,BallPerimeter_d/2-Ball_d/2,0]) sphere(d=Ball_d+IDXtra*3);
			translate([0,BallPerimeter_d/2-Ball_d/2-2,0]) sphere(d=Ball_d+IDXtra*3);
		}
		
		// center hole
		translate([0,0,-Bottom_H-Overlap]) cylinder(d=Bearing_ID-Wall_t*2, h=Bottom_H);
		
		// Bolt holes
		STI_BR_BoltPattern(Body_ID=Body_ID, nLockBalls=nLockBalls) Bolt4Hole(depth=Bottom_H);
		STI_MountingBoltPattern(Body_ID=Body_ID, nLockBalls=nLockBalls) Bolt4Hole(depth=Bottom_H);
			
		// Lock Disk goes here
		cylinder(d=LockDisk_d+1+Xtra_r*2, h=LockDiskHole_H, center=true);
					
		// Locked stop
		STI_LockedStopPosition(Body_ID)
				cylinder(d=STI_LockBearing_ID(Body_ID), h=Bottom_H*2+Overlap*2,center=true);
		
		// Unlocked Stop
		STI_UnlockedStopPosition(Body_ID,nLockBalls=nLockBalls)
				cylinder(d=STI_LockBearing_ID(Body_ID), h=Bottom_H*2+Overlap*2, center=true);
				
		//if ($preview) translate([0,0,-20]) cube([Body_OD/2+10,Body_OD/2+10,50]);
	} // difference
	
	// Large bearing holder
	difference(){
		union(){
			translate([0,0,-LockDiskHole_H/2-Overlap]) cylinder(d=Bearing_ID, h=LockDiskHole_H-0.5);
			translate([0,0,-LockDiskHole_H/2-Overlap]) 
				cylinder(d=Bearing_ID+3, h=LockDiskHole_H/2-BigBearing_W/2-0.3);
		} // union
		
		translate([0,0,-Bottom_H-Overlap]) cylinder(d=Bearing_ID-Wall_t*2, h=Plate_T+LockDiskHole_H+5);
	} // difference
			
	
	// Magnetic latch
	difference(){
		rotate([0,0,STI_MagnetPost_a(Body_ID=Body_ID, nLockBalls=nLockBalls)]) translate([Magnet_h/2,0,0])
			hull(){
				translate([0,STI_MagnetBC_d(Body_ID)/2-3,0])
					cylinder(d=Magnet_h, h=LockDisk_H+2, center=true);
				translate([0,STI_MagnetBC_d(Body_ID)/2+4,0])
					cylinder(d=Magnet_h, h=LockDisk_H+2, center=true);
			}
			
		// Magnet
		rotate([0,0,STI_MagnetPost_a(Body_ID=Body_ID, nLockBalls)]) translate([Magnet_h/2,STI_MagnetBC_d(Body_ID)/2,0])
			rotate([0,90,0]) cylinder(d=Magnet_d, h=Magnet_h+Overlap*2, center=true);
	} // difference
} // STI_BallRetainerBottom

// STI_BallRetainerBottom(Body_ID=ULineH75Body_ID);
// rotate([0,0,STI_Unlocked_a(nLockBalls=nLockBalls)]) 
//	STI_LockDisk();
// STI_ShowMyBalls(nLockBalls=nLockBalls, InLockedPosition=true);


module STI_SpringEndOne(Body_ID=LOC65Body_ID){
	nRopes=6;
	Rope_d=3;
	OD=STI_Engagement_d(Body_ID);
	Base_t=3;
	H=8;
	
	Spring_ID=STI_Spring_ID(Body_ID);
	Spring_OD=STI_Spring_OD(Body_ID);
	
	difference(){
		union(){
			STI_BR_BoltPattern(Body_ID=Body_ID, nLockBalls=nLockBalls) cylinder(d=6, h=H);
			Tube(OD=OD, ID=OD-Wall_t*2, Len=H, myfn=180);
			Tube(OD=Spring_OD+Wall_t*2, ID=Spring_ID, Len=2, myfn=180);
			Tube(OD=OD, ID=Spring_ID-4.4, Len=Base_t, myfn=180);
			Tube(OD=OD, ID=Spring_OD+1, Len=H, myfn=180);
			Tube(OD=Spring_ID-1, ID=Spring_ID-1-4.4, Len=Base_t+2, myfn=180);
		} // union

		translate([0,0,3.7]) STI_BR_BoltPattern(Body_ID=Body_ID, nLockBalls=nLockBalls) Bolt4ButtonHeadHole();
		
		// Ropes
		for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j]) translate([0,OD/2-Rope_d/2-1,-Overlap]){
			cylinder(d=Rope_d, h=H+Overlap*2);
			hull(){
				translate([0,0,Rope_d/2]) rotate([90,0,0]) cylinder(d=Rope_d, h=20);
				translate([0,0,-Overlap]) rotate([90,0,0]) cylinder(d=Rope_d, h=20);
			} // hull
		}
		
	} // difference
} // STI_SpringEndOne

// translate([0,0,-9]) rotate([180,0,53]) STI_SpringEndOne();

module STI_SmallSpringSplice(Body_ID=LOC65Body_ID){

	Engagement_d=STI_Engagement_d(Body_ID);
	Spring_ID=STI_Spring_ID(Body_ID);
	Spring_OD=STI_Spring_OD(Body_ID);
	
	Len=22;
	Wall_t=1.6;
	Devider_OD=(Engagement_d>Spring_OD)? Engagement_d:Spring_OD+1;
	
	nRopes=6;
	Rope_d=5;
	RopeBC_d=Spring_OD+Rope_d+2;
	
	difference(){
		union(){
			cylinder(d=Spring_ID, h=Len);
			translate([0,0,Len/2-1]) cylinder(d=Devider_OD, h=2);
			Tube(OD=Engagement_d, ID=Engagement_d-2.4, Len=Len, myfn=90);
		} // union
		
		translate([0,0,-Overlap]) cylinder(d=Spring_ID-Wall_t*2, h=Len+Overlap*2);
		
		// Ropes
		for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j]) 
			translate([0,RopeBC_d/2,0])
				cylinder(d=Rope_d, h=Len);

	} // difference
} // STI_SmallSpringSplice

// STI_SmallSpringSplice(Body_ID=ULineH75Body_ID);

















