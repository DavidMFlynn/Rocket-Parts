// ***********************************
// Project: 3D Printed Rocket
// Filename: RocketBoosterPooper4.scad
// by David M. Flynn
// Created: 9/15/2023 
// Revision: 0.9.6  1/3/2024
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  Booster Pooper 4 is the 4th rocket I've built w/ strap-on boosters. 
//  Rocket with 2 strap-on boosters. 
//  Boosters have 54mm motors w/ 75mm body
//  Sustainer has 54mm motor w/ 137mm body
//   550mm BoosterButton spacing
//
//  Motor Tube Length 642mm
//  Body Tube Length 130.8mm
//
//  Boosters are in R75StrapOn.scad
//
//  ***** History *****
// 0.9.6  1/3/2024  Upper e-bay doors
// 0.9.5  12/2/2023 Now using Motor Pod Lock for drogue deployment.
// 0.9.4  11/7/2023 Working down from the nosecone
// 0.9.3  9/25/2023 Independant electronics bay
// 0.9.2  9/22/2023 Three part fin can
// 0.9.1  9/17/2023 Ready for first printing
// 0.9.0  9/15/2023 First code
//
// ***********************************
//  ***** for STL output *****
//
// BluntOgiveNoseCone(ID=Body_ID, OD=Body_OD, L=NC_Len, Base_L=NC_Base_L, nRivets=6, Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=0, LowerPortion=false);
//
// NC_ShockcordRingDual(Tube_OD=Body_OD+Vinyl_t, Tube_ID=Body_ID, NC_Base_L=NC_Base_L, nRivets=6);
// SE_Tri_Spring_End(OD=Body_ID-5, Rope_BC_r=Coupler_ID/2-5);
// SE_Tri_Spring_Slider(OD=Coupler_OD, ID=Coupler_ID);
// NC_PetalHub();
//
// rotate([-90,0,0]) PD_PetalSpringHolder(OD=Coupler_OD);
// rotate([180,0,0]) PD_GridPetals(OD=Coupler_OD, Len=180, nPetals=nPetals, Wall_t=1.2);
//
//  ***** Ball Lock *****
//
// STB_LockDisk(BallPerimeter_d=BT137BallPerimeter_d, nLockBalls=nBT137Balls);
// rotate([180,0,0]) RBP4_BallRetainerTop();
// STB_BallRetainerBottom(BallPerimeter_d=BT137BallPerimeter_d, Body_OD=Body_ID, nLockBalls=nBT137Balls, HasSpringGroove=false, Engagement_Len=25);
// rotate([180,0,0]) STB_TubeEnd(BallPerimeter_d=BT137BallPerimeter_d, nLockBalls=nBT137Balls, Body_OD=Body_OD, Body_ID=Body_ID, Skirt_Len=25);
//
//  ***** Upper Electronics Bay *****
//
// UpperElectronicsBay(Tube_OD=Body_OD+Vinyl_t, Tube_ID=Body_ID, ShowDoors=false);
// rotate([-90,0,0]) AltDoor54(Tube_OD=Body_OD, IsLoProfile=false, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowAlt=true);
// rotate([-90,0,0]) Batt_Door(Tube_OD=Body_OD, Door_X=BattDoorX(), InnerTube_OD=0, HasSwitch=true, DoubleBatt=true);
// rotate([-90,0,0]) CP_Door(Tube_OD=Body_OD, BoltBossInset=3, HasArmingSlot=true);
//
//  ***** Stager *****
// Drogue_InnerRace();
// Drogue_OuterRace();
// Drogue_Saucer();
// Drogue_Cup();
//
// ForwardBoosterLock();
// BB_LockingThrustPoint(BodyTube_OD=Body_OD, BoosterBody_OD=BoosterBody_OD); // Print 1 per booster
// BB_Lock(); // Print 1 per booster
// BB_BearingStop(); // Only used with ball bearing
// rotate([180,0,0]) BB_LockShaft(Len=LockShaftLen, nTeeth=nServoGearTeeth, Gear_z=28);
// rotate([180,0,0]) ServoGear(nTeeth=nServoGearTeeth);
// rotate([180,0,0]) ServoMount();
//
// ElectronicsBay();
//
// rotate([-90,0,0]) AltDoor54(Tube_OD=Body_OD, IsLoProfile=false, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowAlt=true);
// 
// rotate([-90,0,0]) Batt_Door(Tube_OD=Body_OD, InnerTube_OD=0, HasSwitch=true);
//
// Rocket_Fin();
//
// FinCan(HideTop=false, HideBottom=true);
// FinCan(HideTop=true, HideBottom=false);
// rotate([180,0,0]) FinCan(HideNotTail=true);
//
// rotate([90,0,0]) BoltOnRailGuide(Length = 40, BoltSpace=12.7, RoundEnds=true); // lower fin can
// rotate([90,0,0]) BoltOnRailGuide(Length = 35, BoltSpace=12.7, RoundEnds=true); // ForwardBoosterLock
//
// MotorRetainer(HasWrenchCuts=false, Cone_Len=TailConeLen, ExtraLen=0);
//
// ***********************************
//  ***** Routines *****
//
//
// ***********************************
//  ***** for Viewing *****
//
// ShowRocket(ShowInternals=true);
// ShowRocket(ShowInternals=false);
//
// ***********************************

use<AT-RMS-Lib.scad>
include<TubesLib.scad>
use<LD-20MGServoLib.scad>
use<CablePuller.scad>
use<BoosterDropperLib.scad>
use<RailGuide.scad>
use<Fins.scad>
use<FinCan.scad>
use<NoseCone.scad>
use<AltBay.scad>
use<BatteryHolderLib.scad> echo(BatteryHolderLibRev());
use<SpringThingBooster.scad>
use<CableReleaseBB.scad>
use<ThreadLib.scad>
use<R75StrapOn.scad>
use<PetalDeploymentLib.scad>
use<Stager2Lib.scad>
use<SpringEndsLib.scad>
use<MotorPodLockLib.scad>

//also included
 //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

Scale=2.01488; //echo(BT137Coupler_OD/LOC65Body_OD);
echo("Scale on Rocket65 = ",Scale);

Body_OD=BT137Body_OD;
Body_ID=BT137Body_ID;
Coupler_OD=BT137Coupler_OD;
Coupler_ID=BT137Coupler_ID;
BoosterBody_OD=BT75Body_OD;
DrogueBody_OD=BT98Body_OD;
DrogueBody_ID=BT98Body_ID;
DrogueInnerTube_OD=BT98Coupler_OD;
DrogueInnerTube_ID=BT98Coupler_ID;

LockBall_d=1/2 * 25.4;
nBT137Balls=7;
BT137BallPerimeter_d=Body_OD;


// *** 54mm Motor Tube ***
MotorTube_OD=BT54Body_OD;
MotorTube_ID=BT54Body_ID;
MotorTubeHole_d=MotorTube_OD+IDXtra*3;

nFins=4;
Fin_Post_h=14;
Fin_Root_L=300;
Fin_Root_W=14;
Fin_Tip_W=5;
Fin_Tip_L=120;
Fin_Span=180;
Fin_TipOffset=50;
Fin_Chamfer_L=50;

FinInset=10;
FinCanLen=Fin_Root_L+FinInset*2;

TailConeLen=80;
Tail_OD=MotorTube_OD+6;
TC_Thread_d=MotorTube_OD+7;
LockShaftLen=Body_OD-55.2;
echo(LockShaftLen=LockShaftLen);
nServoGearTeeth=28;

EBay_Len=146; // extra short, was 152

//NC_Len=360;
//NC_Tip_r=15;
//NC_Base_L=25;
//NC_Wall_t=1.8;

NC_Len=180*Scale;
NC_Tip_r=5*Scale;
NC_Wall_t=2.2;
NC_Base_L=25;

AftClosure_h=10;
Retainer_h=2;
Nut_Len=Retainer_h+AftClosure_h+10;
	
BoosterDropperCL=550;
//BoosterDropperCL=419.5; // minimum, no mid body tube and alignment pins
//BoosterDropperCL=480; // for 54/852 case
UseAlignmentPins=false;

MotorTubeLen=BoosterDropperCL+92+10;
echo(MotorTubeLen=MotorTubeLen);

nBoosters=2;
BoosterButton1_z=52.8+5; // align to bottom of centering ring
RailGuide_Z=35;
RailGuide_a=180/nFins;
RailGuide_H=Body_OD/2+2;

Alt_DoorXtra_X=6;
Alt_DoorXtra_Y=4;

Bolt4Inset=4;

BodyTubeLen=BoosterDropperCL+BoosterButton1_z-FinCanLen-90-126;
echo(BodyTubeLen=BodyTubeLen);

G_a=90; // was 22.5; // Gear angle
// Big Spring
Spring_CS4009_OD=2.328*25.4;
Spring_CS4009_ID=2.094*25.4;
Spring_CS4009_FL=18.5*25.4;
Spring_CS4009_CL=1.64*25.4;
// Small Spring
Spring_CS4323_OD=44.30;
Spring_CS4323_ID=40.50;
Spring_CS4323_CBL=22; // coil bound length
Spring_CS4323_FL=200; // free length

nPetals=3;
FwdTube_L=300;
Vinyl_t=0.5;
UpperBay_Len=162;
UpperEBayTube_OD=BT54Body_OD;



module ShowRocket(ShowInternals=false){
	MotorTube_Z=-TailConeLen+12;
	FwdLock_Z=BoosterDropperCL+BoosterButton1_z;
	EBay_Z=FwdLock_Z-90-126-0.2;
	DrogueCup_Z=FwdLock_Z+55.2;
	
	FwdTubeEnd_Z=FwdLock_Z+600;
	FwdTube_Z=FwdTubeEnd_Z+3+12.5;
	NC_Z=FwdTube_Z+4+FwdTube_L;
	
	/*
	translate([0,0,NC_Z])
	BluntOgiveNoseCone(ID=Body_ID, OD=Body_OD, L=NC_Len, Base_L=NC_Base_L, Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=0, LowerPortion=false);
	/**/
	
	translate([0,0,NC_Z-0.2]) color("Tan") 
		NC_ShockcordRingDual(Tube_OD=Body_OD+Vinyl_t, Tube_ID=Body_ID, 
								NC_Base_L=NC_Base_L, nRivets=6);
								
	if (ShowInternals) translate([0,0,NC_Z-100]) {
		rotate([180,0,0]) NC_PetalHub();
		translate([0,0,-10]) rotate([180,0,0]) 
			PD_GridPetals(OD=Coupler_OD, Len=150, nPetals=nPetals, Wall_t=1.2);
		}
	
	if (ShowInternals==false) translate([0,0,FwdTube_Z+0.1]) 
		color("LightBlue") Tube(OD=Body_OD, ID=Body_ID, Len=FwdTube_L-0.2, 90);
	
	//*
	translate([0,0,FwdTubeEnd_Z+0.2])
		rotate([180,0,0]) color("Blue")
			STB_TubeEnd(BallPerimeter_d=BT137BallPerimeter_d, nLockBalls=nBT137Balls, 
						Body_OD=Body_OD, Body_ID=Body_ID, Skirt_Len=25);
	/**/
	
	//*
	translate([0,0,FwdTubeEnd_Z]) 
		rotate([180,0,0]) {
			STB_BallRetainerTop(BallPerimeter_d=BT137BallPerimeter_d, Body_OD=Body_ID, 
								nLockBalls=nBT137Balls, IntegratedCouplerLenXtra=-19,
								HasIntegratedCouplerTube=true, Body_ID=Body_ID, HasSecondServo=true,
								UsesBigServo=true, Engagement_Len=25);
			if (ShowInternals)
				STB_BallRetainerBottom(BallPerimeter_d=BT137BallPerimeter_d, Body_OD=Body_ID,
								nLockBalls=nBT137Balls, HasSpringGroove=false, Engagement_Len=25);
		}
	/**/
	
	
	//translate([0,0,DrogueCup_Z]) rotate([0,0,-180/nFins]) Drogue_Cup();
	//translate([0,0,FwdLock_Z]) rotate([0,0,-180/nFins]) ForwardBoosterLock();
	
	//translate([0,0,EBay_Z]) rotate([0,0,45]) ElectronicsBay();
	
	/*
	if (ShowInternals==false) translate([0,0,FinCanLen+0.1]) 
		color("LightBlue") Tube(OD=Body_OD, ID=Body_ID, Len=BodyTubeLen-0.2, 90);
	/**/	
	//FinCan();
	
	/*
	for (j=[0:nBoosters-1])
		rotate([0,0,360/nBoosters*j-180/nFins]) 
			translate([0, Body_OD/2+BT75Body_OD/2+1, BoosterButton1_z-44.8]) 
				rotate([0,0,-90]) ShowRocketStrapOn(ShowInternals=false);
	/**/
	
	/*
	for (j=[0:nFins-1])
		rotate([0,0,360/nFins*j]) 
			translate([Body_OD/2-Fin_Post_h, 0, Fin_Root_L/2+FinInset]) 
				rotate([0,90,0]) color("Yellow") Rocket_Fin();
	/**/
	/*
	if (ShowInternals) translate([0,0,MotorTube_Z]) 
		color("LightBlue") Tube(OD=MotorTube_OD, ID=MotorTube_ID, Len=MotorTubeLen, 90);
	/**/
	/*
	if (ShowInternals) translate([0,0,MotorTube_Z]) 
		ATRMS_54_2560_Motor(Extended=true, HasEyeBolt=true); // K270W
		//ATRMS_54_1706_Motor(Extended=true, HasEyeBolt=true); // K185W
	/**/	
	
	//translate([0,0,-0.2]) color("Tan") MotorRetainer(ExtraLen=0);
	
} // ShowRocket

// ShowRocket(ShowInternals=true);
// ShowRocket(ShowInternals=false);

module NC_PetalHub(){
	BodyTube_L=10;
	nHoles=6;
	OD=Body_ID-IDXtra*3;
	
	difference(){
		union(){
			PD_PetalHub(OD=OD, nPetals=nPetals, HasBolts=false, ShockCord_a=-1);
			
			// Coupler tube interface
			translate([0,0,-BodyTube_L]) 
				cylinder(d=Coupler_ID, h=BodyTube_L+1, $fn=$preview? 90:360);
				
		} // union
			
		// Center Hole
		translate([0,0,-BodyTube_L-Overlap]) 
			cylinder(d=80, h=BodyTube_L+30, $fn=$preview? 90:360);
		
		// Retention cord
		for (j=[0:nHoles-1]) rotate([0,0,360/nHoles*(j+0.5)]) {
				translate([0,Coupler_ID/2-5,-BodyTube_L-Overlap]) cylinder(d=4, h=BodyTube_L+20);
				translate([0,Coupler_ID/2-5,5]) cylinder(d=8, h=30);
			}
	} // difference
} // NC_PetalHub

//NC_PetalHub();

module RBP4_BallRetainerTop(){
	XtraLen=0;
	Tube_d=12.7;
	Tube_Z=XtraLen+13+31;
	Tube_a=-30;
	TubeSlot_w=Body_ID-50; //35;
	TubeOffset_X=0; //22;
	
	difference(){
		union(){
			STB_BallRetainerTop(BallPerimeter_d=BT137BallPerimeter_d, 
								Body_OD=Body_ID, nLockBalls=nBT137Balls,
								HasIntegratedCouplerTube=true, 
								IntegratedCouplerLenXtra=XtraLen,
								Body_ID=Body_ID, HasSecondServo=true, UsesBigServo=true,
								Engagement_Len=25);
				
			translate([0,0,XtraLen+13+35.5]) 
				Tube(OD=Body_ID, ID=Body_ID-6, Len=5, myfn=$preview? 90:360);
			
			// Shock cord retention
			difference(){
				union(){
					rotate([0,0,Tube_a]) translate([TubeOffset_X,0,Tube_Z]) 
						rotate([90,0,0]) cylinder(d=Tube_d+6, h=Body_ID-2, center=true);
					rotate([0,0,Tube_a]) translate([TubeOffset_X,0,Tube_Z-18.5])
						cube([Tube_d-3, Body_ID-2, XtraLen+13+21], center=true);
				} // union
				
				rotate([0,0,Tube_a]) translate([TubeOffset_X,0,Tube_Z]) 
					rotate([90,0,0]) cylinder(d=Tube_d+7, h=TubeSlot_w, center=true);
				rotate([0,0,Tube_a]) translate([TubeOffset_X,0,Tube_Z-12.2])
					cube([Tube_d-1, TubeSlot_w,21.1], center=true);
					
				Tube(OD=Body_OD+20, ID=Body_ID-1, Len=50, myfn=$preview? 90:360);
			} // difference
		} // union
	
		translate([TubeOffset_X,0,Tube_Z]) rotate([90,0,Tube_a]) 
			cylinder(d=Tube_d, h=Body_OD, center=true);
			
		//cube([100,100,100]);
	} // difference
} // RBP4_BallRetainerTop

// rotate([180,0,0]) RBP4_BallRetainerTop();

module UpperElectronicsBay(Tube_OD=Body_OD+Vinyl_t, Tube_ID=Body_ID, ShowDoors=false){

	Wall_t=(Tube_OD-Tube_ID)/2;
	Coupler_Len=15;
	Len=UpperBay_Len;
	BattSwDoor_Z=Len/2;
	CP_Door_Z=Len/2-10;
	Altimeter_Z=Len/2;

	Alt1_a=120;
	Alt2_a=300;
	Batt1_a=0;
	Batt2_a=180;
	CP1_a=60;
	CP2_a=180+60;
	
	module TubeHolder(){
		Al_Tube_d=12.7;
		Al_Tube_Len=UpperEBayTube_OD+30;
		H=20;
		
		difference(){
			union(){
				rotate([90,0,0]) cylinder(d=Al_Tube_d+6, h=Al_Tube_Len, center=true);
				
				hull(){
					rotate([90,0,0]) cylinder(d=Al_Tube_d, h=Al_Tube_Len, center=true);
					
					translate([0,0,-H]) cube([Al_Tube_d,Al_Tube_Len,Overlap],center=true);
				} // hull
			} // union
			
			rotate([90,0,0]) cylinder(d=Al_Tube_d, h=Al_Tube_Len+Overlap*2, center=true);
			
			translate([0,0,-H-Overlap]) cylinder(d=UpperEBayTube_OD+IDXtra*2, h=H+Al_Tube_d);
		} // difference
	} // TubeHolder
	
	//translate([0,0,UpperBay_Len-40]) rotate([180,0,0]) rotate([0,0,-60]) TubeHolder();
	
	//*
	// Centering rings
	difference(){
		union(){
			translate([0,0,-Coupler_Len])
				CenteringRing(OD=Body_ID-1, ID=BT98Body_OD+IDXtra*2, 
								Thickness=8+Overlap, nHoles=0, Offset=0);
			translate([0,0,-Coupler_Len+8])
				CenteringRing(OD=Body_ID-1, ID=UpperEBayTube_OD+IDXtra*2, 
								Thickness=5, nHoles=0, Offset=0);
								
			translate([0,0,UpperBay_Len-22])
				CenteringRing(OD=Body_ID+1, ID=UpperEBayTube_OD+IDXtra*2, 
								Thickness=5, nHoles=0, Offset=0);
		} // union
		
		// cable paths
		translate([0,0,-Coupler_Len-Overlap]) rotate([0,0,CP1_a]) 
			translate([0,Body_OD/2-10,0]) cylinder(d=10, h=30);
		translate([0,0,-Coupler_Len-Overlap]) rotate([0,0,CP2_a]) 
			translate([0,Body_OD/2-10,0]) cylinder(d=10, h=30);
	} // difference
	/**/
	
	difference(){
		union(){
			Tube(OD=Tube_OD, ID=Tube_ID, Len=Len, myfn=$preview? 90:360);
			
			//*
			// integrated coupler
			translate([0,0,-Coupler_Len])
				Tube(OD=Tube_ID-IDXtra, ID=Tube_ID-4, Len=Coupler_Len+Overlap, myfn=$preview? 90:360);
			
			
			difference(){
				Tube(OD=Tube_OD-1, ID=Tube_ID-4, Len=5, myfn=$preview? 90:360);
				translate([0,0,-Overlap]) 
					cylinder(d2=Tube_ID+Overlap, d1=Tube_ID-4-Overlap, h=5+Overlap*2, $fn=$preview? 90:360);
			} // difference
			/**/
		} // union
		
		//*
		// Altimeter
		translate([0,0,Altimeter_Z]) rotate([0,0,Alt1_a]) 
			Alt_BayFrameHole(Tube_OD=Tube_OD, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, DeepHole_t=42);
		
		// Altimeter
		translate([0,0,Altimeter_Z]) rotate([0,0,Alt2_a]) 
			Alt_BayFrameHole(Tube_OD=Tube_OD, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, DeepHole_t=42);
		/**/
		
		// Battery and Switch door holes
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
			Batt_BayFrameHole(Tube_OD=Tube_OD, HasSwitch=true);
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt2_a]) 
			Batt_BayFrameHole(Tube_OD=Tube_OD, HasSwitch=true);
		translate([0,0,CP_Door_Z]) rotate([0,0,CP1_a]) 
			CP_BayFrameHole(Tube_OD=Tube_OD);
		translate([0,0,CP_Door_Z]) rotate([0,0,CP2_a]) 
			CP_BayFrameHole(Tube_OD=Tube_OD);
			
		//if ($preview) cube([100,100,200]);
	} // difference
	
	// Altimeter
	translate([0,0,Altimeter_Z]) rotate([0,0,Alt1_a])
			Alt_BayDoorFrame(Tube_OD=Tube_OD, Tube_ID=Tube_ID, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowDoor=ShowDoors);
	translate([0,0,Altimeter_Z]) rotate([0,0,Alt2_a])
			Alt_BayDoorFrame(Tube_OD=Tube_OD, Tube_ID=Tube_ID, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowDoor=ShowDoors);
		
	
			
	// Battery and Switch doors
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
		Batt_BayDoorFrame(Tube_OD=Tube_OD, HasSwitch=true, ShowDoor=ShowDoors);
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt2_a]) 
		Batt_BayDoorFrame(Tube_OD=Tube_OD, HasSwitch=true, ShowDoor=ShowDoors);
		
	// Cable Puller doors
	translate([0,0,CP_Door_Z]) rotate([0,0,CP1_a]) 
		CP_BayDoorFrame(Tube_OD=Tube_OD, ShowDoor=ShowDoors);
	translate([0,0,CP_Door_Z]) rotate([0,0,CP2_a]) 
		CP_BayDoorFrame(Tube_OD=Tube_OD, ShowDoor=ShowDoors);
	
	
} // UpperElectronicsBay

//UpperElectronicsBay();
//translate([0,0,UpperBay_Len+12.5+12]) rotate([180,0,0]) RBP4_BallRetainerTop();

MPL_Ball_d=6;
MPL_PreLoad=-0.4;
MPL_BallCircle_d=BT137Coupler_ID-MPL_Ball_d-1;
MPL_Race_OD=BT137Body_OD+Vinyl_t;
MPL_Body_ID=BT137Body_ID;
MPL_Race_ID=MPL_BallCircle_d-MPL_Ball_d-6;
MPL_Race_w=10;
MPL_LockBall_d=3/8*25.4; // 1/2*25.4;
MPL_nLockBalls=6;
MPL_InnerTube_OD=DrogueInnerTube_OD;
MPL_LockBallBC_d=MPL_InnerTube_OD-5+MPL_LockBall_d; // Locked position
MPL_UnlockedBC_d=MPL_InnerTube_OD+MPL_LockBall_d;

MPL_Offset_Z=6;           // Bearing balls to lock balls
MPL_LockBall_Z=MPL_Race_w/2+MPL_Offset_Z;
MPL_Shelf_t=3;

module Drogue_InnerRace(){
	MPL_InnerRace(ShowLocked=false, Body_ID=MPL_Body_ID,
			LockBallBC_d=MPL_LockBallBC_d, 
			LockBall_d=MPL_LockBall_d, 
			nLockBalls=MPL_nLockBalls, UnlockedBC_d=MPL_UnlockedBC_d, LockBall_Z=MPL_LockBall_Z,
			BallCircle_d=MPL_BallCircle_d, Ball_d=MPL_Ball_d, PreLoad=MPL_PreLoad,
			Race_w=MPL_Race_w, Race_ID=MPL_Race_ID, 
			Offset_Z=MPL_Offset_Z); 
} // Drogue_InnerRace

// translate([0,0,10.0]) Drogue_InnerRace();

module Drogue_OuterRace(){
	MPL_OuterRace(Body_ID=MPL_Body_ID,
		BallCircle_d=MPL_BallCircle_d, Ball_d=MPL_Ball_d, PreLoad=MPL_PreLoad, Race_w=MPL_Race_w,
		LockBallBC_d=MPL_LockBallBC_d, LockBall_d=MPL_LockBall_d, nLockBalls=MPL_nLockBalls,
		Race_OD=MPL_Race_OD, Race_ID=MPL_Race_ID,
		Shelf_t=MPL_Shelf_t, FCCoupler_Len=0.6); 
} // Drogue_OuterRace

//translate([0,0,10.0]) Drogue_OuterRace();
		
module Drogue_Saucer(){
	difference(){
		union(){
			rotate([180,0,0]) Stager_Saucer(Tube_OD=Body_OD, nLocks=0, HasElectrical=false);
			translate([0,0,10-Overlap])
				MPL_LockBallRetainer(FixedTube_OD=DrogueBody_OD, LockBallCircle_d=MPL_LockBallBC_d,
					LockBall_d=MPL_LockBall_d, LockBall_Z=MPL_LockBall_Z, 
					BallCircle_d=MPL_BallCircle_d, Ball_d=MPL_Ball_d, Race_w=MPL_Race_w,
					Shelf_t=MPL_Shelf_t, Body_ID=MPL_Body_ID, nBalls=MPL_nLockBalls); 
			translate([0,0,2]) Tube(OD=DrogueBody_OD+6, ID=DrogueBody_ID+IDXtra*3, Len=5, myfn=$preview? 36:360);
		} // union
		
		cylinder(d=Body_ID-4.0, h=3, $fn=$preview? 90:360); // allow support to hang down
	} // difference
} // Drogue_Saucer

//color("Tan") Drogue_Saucer();

module Drogue_Cup(){
	WireHole_d=5.5;
	RailGuide_Z=-40;
	RG_Len=35;
	Rivet_Z=-15;
	nRivets=6;
	nLocks=3;

	module Rivets(){
	// Rivet holes
		for (j=[0:nRivets-1]) rotate([0,0,360/nRivets*j+180/nRivets]){
			translate([0, Body_OD/2+1, Rivet_Z])
				rotate([90,0,0]) cylinder(d=4, h=10);
			translate([0, Body_ID/2-3, Rivet_Z])
				rotate([90,0,0]) cylinder(d=7, h=5);
		}}
		
	CR_Z=-5;
	
	difference(){
		union(){
			translate([0,0,CR_Z]) CenteringRing(OD=Body_ID-7, ID=0, Thickness=5, nHoles=0);
			
			rotate([0,180,0]) 
				Stager_Cup(Tube_OD=Body_OD, ID=Body_OD-28, nLocks=0, 
							BoltsOn=false, Collar_h=18, HasElectrical=false);
							
			translate([0,0,MPL_LockBall_d+10+1.5])
				MPL_LockRing(OD=DrogueInnerTube_OD, ID=DrogueInnerTube_OD, 
							Ball_d=MPL_LockBall_d, nBalls=MPL_nLockBalls);
				
			difference(){
				translate([0,0,CR_Z]) cylinder(d=DrogueInnerTube_OD-1, h=10);
				translate([0,0,CR_Z-Overlap]) 
					cylinder(d1=DrogueInnerTube_OD-25, d2=DrogueInnerTube_OD-9.5, h=10+Overlap*2, $fn=$preview? 90:360);
			} // difference
		} // union
			
		// Shockcord
		rotate([0,0,40]) translate([0,-Body_ID/2+34, CR_Z-Overlap]) cylinder(d=20, h=10);
		
		// Skirt
		translate([0,0,-30]) Tube(OD=Body_OD+3, ID=Body_ID-IDXtra, Len=25, myfn=$preview? 36:360);
		
		// Trim inside
		translate([0,0,-21])
			cylinder(d1=Body_ID-8, d2=Body_ID-22, h=21+CR_Z-Overlap, $fn=$preview? 36:360);
			
		Rivets();
	} // difference

	
} // Drogue_Cup

// translate([0,0,-0.2]) rotate([0,0,-21]) Drogue_Cup();
// translate([0,0,-0.2]) rotate([0,0,0]) Drogue_Cup();

module AlignmentPins(nPins=6){
	Pin_d=4;
	PinLen=10;
	
	for (j=[0:nPins-1]) rotate([0,0,360/nPins*j+180/nPins]) translate([0,Body_ID/2-4,-Overlap])
		cylinder(d=Pin_d, h=PinLen+Overlap*2);
} // AlignmentPins

//AlignmentPins();

module ForwardBoosterLock(ShowDoors=false){
	// Z=0, BoosterButton center line
	// Includes altimeter and rocket servo
	Bottom_Z=-90;
	Top_Z=50;
	OAL_Z=Top_Z-Bottom_Z;
	//
	echo(OAL_Z=OAL_Z);
	CentralCavity_Y=Body_OD-40;
	CentralCavity2_Y=Body_OD-60;
	ServoMount_Y=-2;
	RailGuideTubeLen=55;
	RailGuide_Z=-50;
	//echo(RailGuide_Z=RailGuide_Z);
	//echo(RailGuide_Z+RailGuideTubeLen/2-5);
	UpperCR_Z=RailGuide_Z+22.5;
	LowerCR_Z=RailGuide_Z-22.5-5;
	Altimeter_Z=Bottom_Z+58;
	BattSwDoor_Z=Bottom_Z+52;
	Alt_a=130+180;
	Batt1_a=115;
	
	
	
	ShowBody=true;
	ShowRG=true;
	
	module BD_Holes(){
		translate([0,Body_OD/2-BoosterButtonOAH(),0]) rotate([-90,0,0]) BB_LTP_Hole();
		rotate([0,0,180]) translate([0,Body_OD/2-BoosterButtonOAH(),0]) rotate([-90,0,0]) BB_LTP_Hole();
		
		// d=33 Ball Bearing OD - 4
		rotate([-90,0,0]) cylinder(d=33, h=Body_OD, center=true);
	} // BD_Holes
	
	rotate([-90,0,0]) rotate([0,0,90]) BB_LockStop(Len=LockShaftLen, Extra_H=4);
	
	//*
	// Rail guide and centering rings
	difference(){
		union(){
			// Body
			if (ShowBody)
				translate([0,0,Bottom_Z]) Tube(OD=Body_OD, ID=Body_ID, Len=OAL_Z, myfn=$preview? 36:360);
		
			if (ShowRG)
			translate([0,0,RailGuide_Z]) rotate([0,0,90])
				RailGuidePost(OD=Body_OD, MtrTube_OD=MotorTubeHole_d, H=RailGuide_H, 
					TubeLen=RailGuideTubeLen, Length = 35, BoltSpace=12.7);
			translate([0,0,LowerCR_Z]) rotate([0,0,30]) 
				CenteringRing(OD=Body_OD-1, ID=MotorTubeHole_d, Thickness=5, nHoles=6);
			translate([0,0,UpperCR_Z])  rotate([0,0,30]) 
				CenteringRing(OD=Body_OD-1, ID=MotorTubeHole_d, Thickness=5, nHoles=6);
				
			
			difference(){
				H=30-RailGuide_Z+RailGuideTubeLen/2-5;
				translate([0,0,RailGuide_Z-RailGuideTubeLen/2+5-Overlap]) 
						cylinder(d=Body_OD-1, h=H, $fn=$preview? 90:360);
				
				
				// Servo mounting bolts
				rotate([0,G_a,0]) translate([0, ServoMount_Y, 24*300/180]) rotate([0,-G_a,0]) 
						rotate([0,90,90]) ServoMountHolePattern() translate([0,0,2]) Bolt4Hole();
				
				// Clean up base below centering ring
				//translate([0,0,Bottom_Z+48-Overlap]) cylinder(d1=Body_ID, d2=MotorTubeHole_d-14, h=40);
				translate([0,0,Bottom_Z]) cylinder(d=MotorTubeHole_d, h=80);
				difference(){
					translate([-Body_OD/2, -CentralCavity2_Y/2, Bottom_Z-Overlap]) 
						cube([Body_OD, CentralCavity2_Y, OAL_Z+Overlap*2]);
					
					// Servo bolt bosses
					rotate([0,G_a,0]) translate([0, ServoMount_Y, 24*300/180]) rotate([0,-G_a,0]) 
						 rotate([0,90,90]) hull() ServoMountHolePattern() {
							 translate([0,0,0]) rotate([180,0,0]) cylinder(d=10,h=1);
							 translate([0,0,-27]) cylinder(d=10,h=1);
						 }
				} // difference
				
				// Servo
				rotate([0,G_a,0]) translate([0, ServoMount_Y, 24*300/180]) rotate([0,90-G_a,0]) 
					rotate([-90,0,0]) Servo_HX5010(BottomMount=false, TopAccess=false, Xtra_w=1.2, Xtra_h=1);
					
				//*
				//translate([0,0,27]) cylinder(d1=CentralCavity2_Y, d2=Body_OD-2, h=8+Overlap);
				hull(){
					translate([-Body_OD/2, -CentralCavity_Y/2, Bottom_Z-Overlap])
						cube([Body_OD, CentralCavity_Y, 45]);
					translate([-Body_OD/2, -CentralCavity2_Y/2, Bottom_Z+45+CentralCavity_Y-CentralCavity2_Y])
						cube([Body_OD, CentralCavity2_Y, Overlap]);
				} // hull
				/**/

			} // difference
	
		} // union
		
		if (UseAlignmentPins) translate([0,0,Bottom_Z]) AlignmentPins();
			
		nRivets=6;
		Rivet_Z=Top_Z-10;
		// Rivet holes
		for (j=[0:nRivets-1]) rotate([0,0,360/nRivets*j+180/nRivets])
			translate([0, Body_OD/2+1, Rivet_Z])
				rotate([90,0,0]) cylinder(d=4, h=25);
				
		BD_Holes();
		
		// Rail guide bolts
		rotate([0,0,90]) translate([0, RailGuide_H, RailGuide_Z])
					RailGuideBoltPattern(BoltSpace=12.7) Bolt6Hole();
		
		//Motor Tube
		translate([0,0,UpperCR_Z-10]){
			cylinder(d=MotorTubeHole_d, h=15);
			translate([0,0,15-Overlap]) cylinder(d1=MotorTubeHole_d, d2=MotorTubeHole_d-10, h=5);
			}
	} // difference
	/**/
	
	//if ($preview) translate([0,0,Top_Z+5+0.2]) Drogue_Cup();
} // ForwardBoosterLock

// ForwardBoosterLock();
// rotate([-90,0,0]) BB_LockShaft(Len=LockShaftLen, nTeeth=24, Gear_z=28);
/*
	//translate([0,0,BoosterButton2_z+Overlap*2])
		rotate([0,0,0]) {
			translate([0,Body_OD/2-BoosterButtonOAH(),0]) rotate([-90,0,0]){
				color("Green") BB_Lock();
				color("Gray") BB_LockingThrustPoint(BodyTube_OD=Body_OD);
				}
			rotate([0,0,180]) translate([0, Body_OD/2-BoosterButtonOAH(),0]) 
				rotate([-90,0,0]) {
					color("Green") BB_Lock();
					color("Gray") BB_LockingThrustPoint(BodyTube_OD=Body_OD);
					}
	} /**/

	
module ElectronicsBay(ShowDoors=false){
	// Z=0, BoosterButton center line
	// Includes altimeter and rocket servo
	OAL_Z=126;
	//
	echo(OAL_Z=OAL_Z);
	
	UpperCR_Z=OAL_Z;
	LowerCR_Z=-10;
	
	Altimeter_Z=OAL_Z/2;
	BattSwDoor_Z=OAL_Z/2;
	Alt_a=-30;
	Batt1_a=30;
	
	difference(){
		union(){
			// Body
			Tube(OD=Body_OD, ID=Body_ID, Len=OAL_Z, myfn=$preview? 36:360);
		
			translate([0,0,LowerCR_Z]) rotate([0,0,30]) 
				CenteringRing(OD=Body_ID-1, ID=MotorTubeHole_d, Thickness=5, nHoles=6);
				
			//translate([0,0,UpperCR_Z])  rotate([0,0,30]) 
			//	CenteringRing(OD=Body_ID-1, ID=MotorTubeHole_d, Thickness=5, nHoles=6);
			
			// Integrated lower coupler
			LowerCT_Len=10;
			translate([0,0,-LowerCT_Len])
					Tube(OD=Body_ID-IDXtra, ID=Body_ID-6, Len=LowerCT_Len+1, myfn=$preview? 36:360);
			translate([0,0,1-Overlap]) 
			difference(){
				cylinder(d=Body_OD-1, h=6);
				translate([0,0,-Overlap]) cylinder(d1=Body_ID-6-Overlap, d2=Body_ID+Overlap, h=6+Overlap*2, $fn=$preview? 36:360);
			} // difference
					
			
			// Integrated upper coupler
			UpperCT_Len=10;
				translate([0,0,OAL_Z-1])
					Tube(OD=Body_ID-IDXtra, ID=Body_ID-6, Len=UpperCT_Len+1, myfn=$preview? 36:360);
			translate([0,0,OAL_Z-1-6-Overlap]) 
			difference(){
				cylinder(d=Body_OD-1, h=6);
				translate([0,0,-Overlap]) cylinder(d2=Body_ID-6-Overlap, d1=Body_ID+Overlap, h=6+Overlap*2, $fn=$preview? 36:360);
			} // difference
		} // union		
			
	
		// Altimeter
		translate([0,0,Altimeter_Z]) rotate([0,0,Alt_a]) 
			Alt_BayFrameHole(Tube_OD=Body_OD, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, DeepHole_t=42);
		
		// Battery and Switch door holes
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
			Batt_BayFrameHole(Tube_OD=Body_OD, HasSwitch=true, DeepHole_t=42);
	
	} // difference
	

	// Altimeter
	translate([0,0,Altimeter_Z]) rotate([0,0,Alt_a])
			Alt_BayDoorFrame(Tube_OD=Body_OD, Tube_ID=Body_ID, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowDoor=ShowDoors);
			
	// Battery and Switch door2
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
			Batt_BayDoorFrame(Tube_OD=Body_OD, HasSwitch=true, ShowDoor=ShowDoors);
			
		
} // ElectronicsBay

//ElectronicsBay();
	
module ServoMountHolePattern(){
	Tray_W=30;
	MountFace_X=6;
	MountFace_H=28;
	
	translate([MountFace_X,-Tray_W/2,-MountFace_H+4]) rotate([0,-90,0]) children();
	translate([MountFace_X,Tray_W/2,-MountFace_H+4]) rotate([0,-90,0]) children();
	translate([MountFace_X,-Tray_W/2,-MountFace_H+12]) rotate([0,-90,0]) children();
	translate([MountFace_X,Tray_W/2,-MountFace_H+12]) rotate([0,-90,0]) children();
} // ServoMountHolePattern


module ServoMount(){
	Tray_L=57;
	Tray_W=30;
	Tray_H=8;
	TrayOffset_X=-38+Tray_L/2;
	MountFace_X=6;
	MountFace_H=28;
	
	difference(){
		union(){
			//translate([TrayOffset_X,-Tray_W/2,-Tray_H]) cube([Tray_L,Tray_W,Tray_H]);
			translate([TrayOffset_X,0,-Tray_H]) 
			RoundRect(X=Tray_L, Y=Tray_W, Z=Tray_H, R=8);
			
			hull(){
				translate([MountFace_X-3,-Tray_W/2,-MountFace_H]) cube([3,Tray_W,MountFace_H-2]);
				translate([-20,-Tray_W/2,-Tray_H]) cube([Overlap,Tray_W,Tray_H-2]);
				
				ServoMountHolePattern() cylinder(d=8,h=6);
				
			} // hull
		} // union
		
		Servo_HX5010(BottomMount=false,TopAccess=false,Xtra_w=1.2, Xtra_h=1);
		
		ServoMountHolePattern() translate([0,0,8]) Bolt4HeadHole(lHead=20);
		
		// Wire path
		translate([-TrayOffset_X+1,0,-Tray_H-Overlap]) cylinder(d=6, h=Tray_H+Overlap*2);
	} // difference
} // ServoMount

//ServoMount();
/*
ServoGear_Y=15;

rotate([0,G_a,0]) translate([0, ServoGear_Y, 300*nServoGearTeeth/180]) 
	rotate([-90,0,0]) ServoGear(nTeeth=nServoGearTeeth);
//ForwardBoosterLock();
translate([0,0,Overlap])
	rotate([0,G_a,0]) translate([0, ServoGear_Y-17, 24*300/180]) rotate([0,-G_a,0]) 
		rotate([0,90,90]){ 
			ServoMount();
			Servo_HX5010(BottomMount=false, TopAccess=false, Xtra_w=1.2, Xtra_h=1);
		}
/**/

module Rocket_Fin(){
	TrapFin2(Post_h=Fin_Post_h, Root_L=Fin_Root_L, Tip_L=Fin_Tip_L,
			Root_W=Fin_Root_W, Tip_W=Fin_Tip_W,
			Span=Fin_Span, Chamfer_L=Fin_Chamfer_L,
					TipOffset=Fin_TipOffset);

	if ($preview==false){
		translate([-Fin_Root_L/2+10,0,0]) cylinder(d=Fin_Root_W*2.5, h=0.9); // Neg
		translate([Fin_Root_L/2-10,0,0]) cylinder(d=Fin_Root_W*2.5, h=0.9); // Pos
	}
} // Rocket_Fin

// Rocket_Fin();

module FinCan(HideTop=false, HideBottom=false, HideNotTail=false){
	
	difference(){
		union(){
			//Integrated coupler
			CouplerLen=10;
			if (UseAlignmentPins==false) translate([0,0,FinCanLen-Overlap])
				Tube(OD=Body_ID, ID=Body_ID-6, Len=CouplerLen, myfn=$preview? 90:360);
				
			Tube(OD=Body_OD, ID=Body_ID, Len=FinCanLen, myfn=$preview? 36:360);
			
			// Top centering ring
			translate([0,0,FinCanLen-5]) rotate([0,0,180/nFins])
				CenteringRing(OD=Body_OD-1, ID=MotorTubeHole_d, Thickness=5, nHoles=nFins);
				
			// Middle centering rings
			translate([0,0,FinCanLen/2-5]) rotate([0,0,180/nFins])
				CenteringRing(OD=Body_OD-1, ID=MotorTubeHole_d, Thickness=10, nHoles=nFins);
				
			// Bottom centering ring
			rotate([0,0,180/nFins])
				CenteringRing(OD=Body_OD-1, ID=MotorTubeHole_d, Thickness=10, nHoles=nFins);
				
			// Fin Holders
			intersection(){
				cylinder(d=Body_ID+1, h=FinCanLen);

				for (j=[0:nFins-1]) hull(){
					cylinder(d=Fin_Root_W+4.4, h=FinCanLen);

					rotate([0,0,360/nFins*j]) translate([Body_OD/2,0,0])
						cylinder(d=Fin_Root_W+4.4, h=FinCanLen);
				} // hull
			} // intersection
			
			// Thrust transfer blocks
			intersection(){
				cylinder(d=Body_ID+1, h=FinCanLen/2);

				for (j=[0:nBoosters-1]) hull(){
					cylinder(d=Fin_Root_W+4.4, h=FinCanLen/2);

					rotate([0,0,360/nBoosters*j+180/nFins]) translate([Body_OD/2,0,0])
						cylinder(d=Fin_Root_W+4.4, h=FinCanLen/2);
				} // hull
			} // intersection
		} // union
		
		//Top alignment pins
		if (UseAlignmentPins) translate([0,0,FinCanLen-5]) rotate([0,0,RailGuide_a+30]) AlignmentPins();
		
		// Middle alignment pins
		translate([0,0,FinCanLen/2-5]) AlignmentPins(nPins=8);
		
		// Bottom alignment pins
		AlignmentPins(nPins=8);
		
		// Rail guide bolts
		rotate([0,0,RailGuide_a]) translate([0,RailGuide_H,RailGuide_Z])
			RailGuideBoltPattern(BoltSpace=12.7) Bolt6Hole();
		
		for (j=[0:nBoosters-1])
			rotate([0,0,360/nBoosters*j-180/nFins]) 
				translate([0,Body_OD/2-BoosterButtonOAH(), BoosterButton1_z]) 
					rotate([-90,0,0]) BB_ThrustPoint_Hole();
					
		// Fin slots
		translate([0,0,FinCanLen/2])
			TrapFin2Slots(Tube_OD=Body_OD, nFins=nFins,
				Post_h=Fin_Post_h, Root_L=Fin_Root_L,
				Root_W=Fin_Root_W, Chamfer_L=Fin_Chamfer_L);
		
		// Motor tube
		translate([0,0,-Overlap]) cylinder(d=MotorTubeHole_d, h=FinCanLen+Overlap*2);
		
		if (HideTop){
			translate([0,0,FinCanLen/2]) cylinder(d=Body_OD+10, h=FinCanLen);
			translate([0,0,5]) mirror([0,0,1]) cylinder(d=Body_OD+10, h=FinCanLen);
		}
		if (HideBottom) translate([0,0,-FinCanLen/2]) cylinder(d=Body_OD+10, h=FinCanLen+Overlap);
		if (HideNotTail) translate([0,0,5]) cylinder(d=Body_OD+10, h=FinCanLen+20);
	} // difference

	if (HideBottom==false && HideNotTail==false) 
	for (j=[0:nBoosters-1])
		rotate([0,0,360/nBoosters*j-180/nFins]) 
			translate([0, Body_OD/2-BoosterButtonOAH(), BoosterButton1_z]) 
				rotate([-90,0,0]) BB_ThrustPoint(BodyTube_OD=Body_OD, BoosterBody_OD=BT75Body_OD);
				
	//*
	// Rail Guide
	if (HideBottom==false && HideNotTail==false) 
	difference(){
		translate([0,0,RailGuide_Z]) rotate([0,0,RailGuide_a])
			RailGuidePost(OD=Body_OD, MtrTube_OD=MotorTubeHole_d, H=RailGuide_H, TubeLen=70, Length = 40, BoltSpace=12.7);

		translate([0,0,RailGuide_Z]) TrapFin2Slots(Tube_OD=Body_OD, nFins=nFins,
			Post_h=Fin_Post_h, Root_L=Fin_Root_L, Root_W=Fin_Root_W, Chamfer_L=Fin_Chamfer_L);
			
		for (j=[0:nBoosters-1])
			rotate([0,0,360/nBoosters*j-180/nFins]) 
				translate([0,Body_OD/2-BoosterButtonOAH(), BoosterButton1_z]) 
					rotate([-90,0,0]) BB_ThrustPoint_Hole();
					
		translate([0,0,5]) mirror([0,0,1]) cylinder(d=Body_OD+10, h=FinCanLen);
	} // difference
	/**/
	
	if ((!HideBottom && !HideNotTail && !HideTop) || (HideNotTail==true) || (!HideTop && !HideBottom)) TailCone();
} // FinCan

// FinCan();
//FinCan(HideTop=true);
//FinCan(HideTop=false, HideBottom=true);
//FinCan(HideNotTail=true);


module TailCone(Threaded=true, Cone_Len=TailConeLen, Interface_OD=Body_ID){
	TC_Ts_r=22;
	
	difference(){
		
		hull(){
			translate([0,0,-Cone_Len]) cylinder(d=Tail_OD, h=2, $fn=$preview? 90:360);
			
			difference(){
				rotate_extrude($fn=$preview? 90:360) translate([Body_OD/2-TC_Ts_r,0,0]) circle(r=TC_Ts_r);
				translate([0,0,Overlap]) cylinder(d=Body_OD+1,h=10);
			}
		} // hull
		
		// make hollow
		difference(){
			hull(){
				translate([0,0,-Cone_Len]) cylinder(d=Tail_OD-6, h=2, $fn=$preview? 90:360);
				
				difference(){
					rotate_extrude($fn=$preview? 90:360) translate([Body_OD/2-TC_Ts_r,0,0]) circle(r=TC_Ts_r-6);
					translate([0,0,Overlap]) cylinder(d=Body_OD+1,h=10);
				} // difference
			} // hull
			
			translate([0,0,-Cone_Len-Overlap]) cylinder(d=MotorTubeHole_d+6, h=Cone_Len+TC_Ts_r);
			
			if (Threaded)
				translate([0,0,-Cone_Len-Overlap]) cylinder(d=Body_OD, h=Nut_Len+5);
		} // difference
		
		// Trim top
		translate([0,0,Overlap]) cylinder(d=Body_OD+1, h=TC_Ts_r);
		
		// Motor tube
		translate([0,0,-Cone_Len-Overlap]) 
			cylinder(d=MotorTubeHole_d, h=Cone_Len+Overlap*3);
	
		if (Threaded) translate([0,0,-Cone_Len-Overlap]) cylinder(d=Body_OD, h=Nut_Len);
		
		if ($preview) translate([0,0,-Cone_Len-1]) cube([100,100,100]);
	} // difference
	
	if (Threaded) difference(){
		translate([0,0,-Cone_Len+Nut_Len-10]) 
			ExternalThread(Pitch=2.5, Dia_Nominal=TC_Thread_d, 
							Length=10+Overlap, Step_a=$preview? 10:2, TrimEnd=true, TrimRoot=false);
			
		// Motor tube
		translate([0,0,-Cone_Len-Overlap]) 
			cylinder(d=MotorTubeHole_d, h=Cone_Len+Overlap*2);
	}
} // TailCone

//rotate([180,0,0]) TailCone();

module MotorRetainer(HasWrenchCuts=false, Cone_Len=TailConeLen, ExtraLen=0){
	TC_Ts_r=22;
	
	difference(){
		hull(){
			difference(){
				hull(){
					// Bottom
					translate([0,0,-Cone_Len]) cylinder(d=Tail_OD, h=2, $fn=$preview? 90:360);
						
					// Top
					rotate_extrude($fn=$preview? 90:360) translate([Body_OD/2-TC_Ts_r,0,0]) circle(r=TC_Ts_r);
				} // hull
				
				// Trim Top	
				translate([0,0,-Cone_Len+Nut_Len-Overlap]) cylinder(d=Body_OD+3, h=Cone_Len+TC_Ts_r);
			} // difference
		
			translate([0,0,-Cone_Len-ExtraLen]) 
				cylinder(d=Tail_OD, h=2, $fn=$preview? 90:360);
		} // hull
			
		// Exit
		translate([0,0,-Cone_Len-ExtraLen-Overlap]) 
			cylinder(d=MotorTube_ID+IDXtra*2, h=Cone_Len);
			
		// Motor tube
		translate([0,0,-Cone_Len-ExtraLen+Retainer_h]) 
			cylinder(d=ATRMS_54_Aft_d()+IDXtra*3, h=Cone_Len);
	
		translate([0,0,-Cone_Len+Nut_Len-12+Overlap])
			ExternalThread(Pitch=2.5, Dia_Nominal=TC_Thread_d+IDXtra*4, 
							Length=15, Step_a=$preview? 10:2, TrimEnd=true, TrimRoot=false);
		
		// Spanner Wrench
		if (HasWrenchCuts){
			SW_Z=16;
			SW_W=Body_OD-22;
			translate([SW_W/2,-Body_OD/2,-Cone_Len]) cube([Body_OD,Body_OD,SW_Z]);
			mirror([1,0,0])
			translate([SW_W/2,-Body_OD/2,-Cone_Len]) cube([Body_OD,Body_OD,SW_Z]);
		} // if
		
		if ($preview) translate([0,0,-Cone_Len-ExtraLen-1]) cube([100,100,100]);
	} // difference
} // MotorRetainer

//translate([0,0,-0.2]) MotorRetainer(ExtraLen=0);

BF_OD=250;
BF_Body_Len=200;

BigFairingWall_t=12;

module BigFairing(){
	
	NC_Wall_t=BigFairingWall_t;
	NC_Len=300;
	NC_Base_L=15;
	NC_Tip_R=40;
	
	BluntOgiveNoseCone(ID=BF_OD-NC_Wall_t*2, OD=BF_OD, L=NC_Len, Base_L=NC_Base_L, nRivets=0, Tip_R=NC_Tip_R, Wall_T=NC_Wall_t, Cut_Z=0, Transition_OD=PML98Body_OD, LowerPortion=false);

	translate([0,0,NC_Base_L+75])
		CenteringRing(OD=BF_OD-10-NC_Wall_t*2, ID=BT137Body_OD+IDXtra*3, Thickness=5, nHoles=6, Offset=0);
		
	translate([0,0,NC_Base_L+NC_Len-NC_Tip_R-20])
	difference(){
		sphere(r=NC_Tip_R-1);
		
		//translate([0,0,NC_Tip_R*0.5]) {
			rotate([180,0,0]) cylinder(r=NC_Tip_R, h=NC_Tip_R+20);
			//rotate([180,0,0]) Bolt250Hole();
		
			translate([0,0,-Overlap])
			if ($preview){ 
				cylinder(d=6.35, h=NC_Tip_R); }
			else { 
				ExternalThread(Pitch=25.4/20, Dia_Nominal=6.35+IDXtra*2, 
							Length=NC_Tip_R, 
							Step_a=2,TrimEnd=true,TrimRoot=true); }
			//}
	} // difference
} // BigFairing

//BigFairing();

module BF_Tube(){
	NC_Base_L=15;
	NC_Wall_t=BigFairingWall_t;
	
	translate([0,0,NC_Base_L-5])
		CenteringRing(OD=BF_OD-NC_Wall_t*2-1, ID=BT137Body_OD+IDXtra*3, Thickness=5, nHoles=6, Offset=0);
		
	translate([0,0,-Overlap])
	Tube(OD=BF_OD-NC_Wall_t*2-IDXtra*2, ID=BF_OD-NC_Wall_t*4, Len=NC_Base_L, myfn=$preview? 90:360);
	
	translate([0,0,-5])
	Tube(OD=BF_OD-1, ID=BF_OD-NC_Wall_t*4, Len=5, myfn=$preview? 90:360);
	
	translate([0,0,-BF_Body_Len])
	Tube(OD=BF_OD, ID=BF_OD-NC_Wall_t*2, Len=BF_Body_Len, myfn=$preview? 90:360);
} // BF_Tube

// translate([0,0,-1]) BF_Tube();
// rotate([180,0,0]) BF_Tube();

module BF_Base(){
	Tr_r=30;
	NC_Wall_t=BigFairingWall_t;
	Base_Len=40;
	TubeWall_t=3;
	
	difference(){
		union(){
			translate([0,0,Tr_r+15])
				CenteringRing(OD=BF_OD-NC_Wall_t*2-1, ID=BT137Body_OD+IDXtra*3, 
								Thickness=5, nHoles=6, Offset=0);
								
			translate([0,0,Tr_r-Overlap])
				Tube(OD=BF_OD-NC_Wall_t*2-IDXtra*2, ID=BF_OD-NC_Wall_t*2-TubeWall_t*2, 
				Len=20, myfn=$preview? 90:360);
				
			Tube(OD=BF_OD, ID=BF_OD-NC_Wall_t*2-TubeWall_t*2, Len=Tr_r, myfn=$preview? 90:360);
		} // union
		
		if ($preview) translate([0,0,-100]) cube([200,200,200]);
	} // difference
	
	difference(){
		
		hull(){
			rotate_extrude($fn=$preview? 90:360) translate([BF_OD/2-Tr_r,0,0]) circle(r=Tr_r);
			translate([0,0,-Tr_r-Base_Len]) 
				Tube(OD=BT137BallPerimeter_d+4.5, 
						ID=BT137Body_ID+IDXtra*3, Len=1, myfn=$preview? 90:360);
		} // hull
			
		translate([0,0,Overlap]) cylinder(d=BF_OD+1, h=Tr_r);
		
		// Body Tube
		translate([0,0,-Tr_r-Base_Len-Overlap])
			cylinder(d=BT137Body_ID+IDXtra*3, h=Tr_r*2+Base_Len+Overlap*2, $fn=$preview? 90:360);
			
		// Internal Cone
		translate([0,0,-Tr_r-Base_Len+10]) 
			cylinder(d1=BT137Body_ID+IDXtra*3, d2=BF_OD-NC_Wall_t*2-TubeWall_t*2, h=Base_Len+Tr_r-10+Overlap*2);
			
		if ($preview) translate([0,0,-100]) cube([200,200,200]);
	} // difference
} // BF_Base

// translate([0,0,-201-31]) BF_Base();
// rotate([180,0,0]) BF_Base();

module BF_Base_TubeEnd(){
	translate([0,0,20]) Tube(OD=BT137BallPerimeter_d+4.5, ID=BT137Body_OD+IDXtra*2, Len=10, myfn=$preview? 90:360);
	
	rotate([180,0,0]) STB_TubeEnd(BallPerimeter_d=BT137BallPerimeter_d, nLockBalls=nBT137Balls, Body_OD=Body_OD, Body_ID=Body_ID, Skirt_Len=25);
} // BF_Base_TubeEnd

// translate([0,0,-201-31-101]) BF_Base_TubeEnd();

// ****************************************************************
// old stuff
/*
module Drogue_Cup(){
	WireHole_d=5.5;
	RailGuide_Z=-40;
	RG_Len=35;
	Rivet_Z=-15;
	nRivets=6;
	nLocks=3;

	module Rivets(){
	// Rivet holes
		for (j=[0:nRivets-1]) rotate([0,0,360/nRivets*j+180/nRivets]){
			translate([0, Body_OD/2+1, Rivet_Z])
				rotate([90,0,0]) cylinder(d=4, h=10);
			translate([0, Body_ID/2-3, Rivet_Z])
				rotate([90,0,0]) cylinder(d=7, h=5);
		}}
		
	CR_Z=-5;
	
	difference(){
		translate([0,0,CR_Z]) CenteringRing(OD=Body_ID-IDXtra, ID=0, Thickness=5, nHoles=0);
		
		translate([0,0,2]) Stager_CupHoles(Tube_OD=Body_OD, ID=78, nLocks=nLocks, BoltsOn=true);
		
		//Rivets();
		
		// Shockcord
		rotate([0,0,40]) translate([0,-Body_ID/2+30,CR_Z-Overlap]) cylinder(d=20, h=10);
	} // difference
	
	difference(){
		rotate([0,180,0]) 
			Stager_Cup(Tube_OD=Body_OD, ID=Body_OD-28, nLocks=nLocks, 
							BoltsOn=false, Collar_h=18, HasElectrical=false);
			
		// Skirt
		translate([0,0,-30]) Tube(OD=Body_OD+3, ID=Body_ID-IDXtra, Len=25, myfn=$preview? 36:360);
		
		// Trim inside
		translate([0,0,-21]) difference(){
			cylinder(d1=Body_ID-8, d2=Body_ID-24, h=22);
			for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]) translate([0,Body_ID/2-4,-Overlap])
				RoundRect(X=11,Y=6,Z=30,R=2);
			}
			
		Rivets();
	} // difference

	
} // Drogue_Cup
/**/


























