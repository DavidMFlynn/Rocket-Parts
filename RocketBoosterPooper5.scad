// ***********************************
// Project: 3D Printed Rocket
// Filename: RocketBoosterPooper5.scad
// by David M. Flynn
// Created: 9/15/2023 
// Revision: 0.9.10  8/6/2024
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  Booster Pooper 5 is the 5th rocket I've built w/ strap-on boosters. 
//  Rocket with 3 strap-on boosters. 
//  Boosters have 54mm motors w/ 102mm body
//  Sustainer has 54mm motor w/ 157mm body
//   550mm BoosterButton spacing
//
//  Motor Tube Length 642mm
//  Body Tube Length 130.8mm
//
//  Boosters are found in RU102StrapOn.scad
//
//  ***** History *****
// 0.9.10  8/6/2024 STB parts have been reworked, stop angle has changed.
// 0.9.9  8/1/2024  Reworked electronics bay for dual deploy like Rocket75D
// 0.9.8  3/28/2024 New spring for nosecone CS11890
// 0.9.7  1/28/2024 Shock cord pass thru in STB at top to e bay.
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
// Nosecone();
// NoseconeBase();
//
// SE_SlidingBigSpringMiddle(OD=Body_ID*CF_Comp-1, SliderLen=60, Extension=0);
//
// rotate([180,0,0]) R157_PusherRing(OD=Coupler_OD*CF_Comp, ID=Coupler_ID*CF_Comp, OA_Len=40, Engagemnet_Len=10, Wall_t=4, PetalStop_h=0, PetalWall_t=2.4, nBolts=0);
// PD_NC_PetalHub(OD=Body_ID*CF_Comp-1, nPetals=nPetals, HasReplaceableSpringHolder=true, nRopes=6, ShockCord_a=-1, HasThreadedCore=false, ST_DSpring_ID=SE_Spring_CS11890_ID(), ST_DSpring_OD=SE_Spring_CS11890_OD(), CouplerTube_ID=Coupler_ID*CF_Comp);
// PD_HubSpringHolder();
// rotate([-90,0,0]) PD_PetalSpringHolder();
// PD_Petals(OD=Coupler_OD*CF_Comp, Len=180, nPetals=nPetals, Wall_t=2.4, AntiClimber_h=5, HasLocks=false, Lock_Span_a=0);
//
// 
// rotate([180,0,0]) R157_PusherRing(OD=Coupler_OD*CF_Comp, ID=Coupler_ID*CF_Comp, OA_Len=40, Engagemnet_Len=7, Wall_t=4, PetalStop_h=3, PetalWall_t=2.4, nBolts=0);
// R157_SkirtRing(Coupler_OD=Coupler_OD*CF_Comp, Coupler_ID=Coupler_ID*CF_Comp, HasPD_Ring=true, Engagemnet_Len=7);
//
// R157_PetalHub(OD=Coupler_OD*CF_Comp, nPetals=nPetals, nBolts=nPetals); // Bolts to bottom of electronics bay
//
// SE_SpringEndTypeC(Coupler_OD=Coupler_OD*CF_Comp, Coupler_ID=Coupler_ID*CF_Comp, Len=15, nRopes=6, UseSmallSpring=false, HasVentHoles=true);
//
//  ***** Ball Lock *****
//
// STB_LockDisk(Body_ID=Body_ID*CF_Comp, nLockBalls=nLockBalls, HasLargeInnerBearing=true, Xtra_r=0.2);
// rotate([180,0,0]) R157_BallRetainerTop(Body_OD=Body_COD, Body_ID=Body_ID*CF_Comp, EBayTube_OD=ULine38Body_OD, Engagement_Len=Engagement_Len, nBolts=6, Xtra_r=0.2, CouplerLenXtra=-20);
// R157_BallRetainerBottom(Body_ID=Body_ID*CF_Comp, Engagement_Len=17, Xtra_r=0.2);
// rotate([180,0,0]) STB_TubeEnd(Body_ID=Body_ID*CF_Comp, nLockBalls=nLockBalls, Body_OD=Body_OD*CF_Comp, Engagement_Len=Engagement_Len);
//
//  ***** Upper Electronics Bay *****
//
// rotate([180,0,0]) R157_MainEBay(TopOnly=true, BottomOnly=false, ShowDoors=false, RedundantAtls=false);
// R157_MainEBay(TopOnly=false, BottomOnly=true, ShowDoors=false, RedundantAtls=false);
//
//  *** Doors ***
//
// rotate([-90,0,0]) EB_AltDoor(Tube_OD=Body_COD);
// rotate([-90,0,0]) EB_BattDoor(Tube_OD=Body_COD, HasSwitch=false, DoubleBatt=false);
// rotate([-90,0,0]) EB_BattDoor(Tube_OD=Body_COD, HasSwitch=true, DoubleBatt=false);
// rotate([-90,0,0]) EB_BattDoor(Tube_OD=Body_COD, HasSwitch=true, DoubleBatt=true); // for redundant electronics
//
//
// CenteringRing(OD=Body_ID, ID=BT38Body_OD, Thickness=5, nHoles=8, Offset=0, myfn=$preview? 90:360);
//
//
// * Drogue PetalHub *
// R157_PetalHub(OD=Coupler_OD*CF_Comp, nPetals=nPetals, nBolts=nPetals, nRopes=0, Skirt_Len=4);
// PD_Petals(OD=Coupler_OD*CF_Comp, Len=100, nPetals=6, Wall_t=2.4, AntiClimber_h=5, HasLocks=false);
//
//
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
// BodyDrillingJig(Tube_OD=Body_OD, Tube_ID=Body_ID, nBolts=6, BoltInset=7.5);
//
//  ***** Strap-On Boosters *****
//
Booster_NC_Len=162;
Booster_NC_Tip_r=8;
Booster_NC_Wall_t=1.8;
Booster_NC_Base_L=15;
//
// RU102S_Nosecone(OD=Booster_Body_COD, ID=Booster_Body_ID, NC_Len=Booster_NC_Len, NC_Base_L=Booster_NC_Base_L, NC_Tip_r=Booster_NC_Tip_r, NC_Wall_t=Booster_NC_Wall_t);
// rotate([180,0,0]) STB_InternalTubeEnd(Body_OD=Booster_Body_COD, Body_ID=Booster_Body_ID, Engagement_ID=Booster_Engagement_D, nLockBalls=Booster_nLockBalls, Engagement_Len=Booster_Engagement_Len);
//
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
/*
	for (j=[0:nBoosters-1]) rotate([0,0,360/nBoosters*j]) translate([0,-Body_COD/2-BoosterBody_OD/2-1,0]) 
		rotate([0,0,90]) ShowRocketStrapOn(ShowInternals=false);
/**/
//
// ***********************************

use<AT_RMS_Lib.scad>
include<TubesLib.scad>
use<R157Lib.scad>				echo(R157Lib_Rev());
use<LD-20MGServoLib.scad>
use<BoosterDropper5Lib.scad> 	echo(BoosterDropper5LibRev());
use<RailGuide.scad>
use<Fins.scad>
use<FinCan2Lib.scad>
use<NoseCone.scad>
use<SpringThingBooster.scad>
use<ThreadLib.scad>
use<RU102StrapOn.scad>
use<PetalDeploymentLib.scad>
use<SpringEndsLib.scad> 		echo(SpringEndsLibRev());
use<ElectronicsBayLib.scad>

//also included
 //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 36:90;
Bolt4Inset=4;
Epoxy_d=0.4;

Booster_Body_COD=ULine102Body_OD*CF_Comp+Vinyl_d+Epoxy_d;
//echo(ULine102Body_OD=ULine102Body_OD);
//echo(Booster_Body_COD=Booster_Body_COD);
Booster_Body_ID=ULine102Body_ID;
Booster_Engagement_D=ULine102Coupler_ID-1;
Booster_Engagement_Len=20;
Booster_nLockBalls=5;

Body_OD=ULine157Body_OD;
Body_ID=ULine157Body_ID;
Body_COD=Body_OD*CF_Comp+Vinyl_d; // Compensated OD
echo(Body_COD=Body_COD);

Coupler_OD=ULine157Coupler_OD;
Coupler_ID=ULine157ThinWallCoupler_ID;
BoosterBody_OD=ULine102Body_OD;
DrogueBody_OD=BT98Body_OD;
DrogueBody_ID=BT98Body_ID;
DrogueInnerTube_OD=BT98Coupler_OD;
DrogueInnerTube_ID=BT98Coupler_ID;
UpperEBayTube_OD=BT54Body_OD;
UpperEBayTube_ID=BT54Body_ID;

nLockBalls=R157_nLockBalls();
Engagement_Len=R157_Engagement_Len();

// *** 54mm Motor Tube ***
MotorTube_OD=BT54Body_OD;
MotorTube_ID=BT54Body_ID;
MotorTubeHole_d=MotorTube_OD+IDXtra*3;

nFins=6;
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

EBay_Len=168; 
nEBayBolts=R157_nEBayBolts();

nPetals=6;

NC_Len=220;
NC_Tip_r=10;
NC_Wall_t=2.2;
NC_Base_L=15;
NC_nRivets=6;

AftClosure_h=10;
Retainer_h=2;
Nut_Len=Retainer_h+AftClosure_h+10;
	
BoosterDropperCL=550;
//BoosterDropperCL=419.5; // minimum, no mid body tube and alignment pins
//BoosterDropperCL=480; // for 54/852 case
UseAlignmentPins=false;

MotorTubeLen=BoosterDropperCL+92+10;
echo(MotorTubeLen=MotorTubeLen);

nBoosters=3;
BoosterButton1_z=52.8+5; // align to bottom of centering ring
RailGuide_Z=35;
RailGuide_a=0;
RailGuide_H=Body_OD/2+2;

Alt_DoorXtra_X=6;
Alt_DoorXtra_Y=4;


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

FwdTube_L=300;
UpperBay_Len=162;

module ShowRocket(ShowInternals=false, ShowBoosters=false, ShowFins=true){
	MotorTube_Z=-TailConeLen+12;
	FwdLock_Z=BoosterDropperCL+BoosterButton1_z;
	EBay_Z=FwdLock_Z-90-126-0.2;
	DrogueCup_Z=FwdLock_Z+55.2;
	
	FwdTubeEnd_Z=FwdLock_Z+600;
	FwdTube_Z=FwdTubeEnd_Z+3+12.5;
	NC_Z=FwdTube_Z+4+FwdTube_L;
	
	
	//translate([0,0,NC_Z]) Nosecone();
		
	//translate([0,0,NC_Z-0.2]) color("Tan") NoseconeBase();
								
	if (ShowInternals) translate([0,0,NC_Z-100]) {
		rotate([180,0,0]) NC_PetalHub();
		translate([0,0,-10]) rotate([180,0,0]) 
			PD_GridPetals(OD=Coupler_OD, Len=150, nPetals=nPetals, Wall_t=1.2);
		}
	
	if (ShowInternals==false) translate([0,0,FwdTube_Z+0.1]) 
		color("LightBlue") Tube(OD=Body_OD, ID=Body_ID, Len=FwdTube_L-0.2, 90);
	
	/*
	translate([0,0,FwdTubeEnd_Z+0.2])
		rotate([180,0,0]) color("Blue")
			STB_TubeEnd(nLockBalls=nLockBalls, 
						Body_OD=Body_OD, Body_ID=Body_ID, Skirt_Len=25);
	/**/
	
	/*
	translate([0,0,FwdTubeEnd_Z]) 
		rotate([180,0,0]) {
			STB_BallRetainerTop(BallPerimeter_d=BT137BallPerimeter_d, Body_OD=Body_ID, 
								nLockBalls=nLockBalls, IntegratedCouplerLenXtra=-19,
								HasIntegratedCouplerTube=true, Body_ID=Body_ID, HasSecondServo=true,
								UsesBigServo=true, Engagement_Len=Engagement_Len);
			if (ShowInternals)
				STB_BallRetainerBottom(BallPerimeter_d=BT137BallPerimeter_d, Body_OD=Body_ID,
								nLockBalls=nLockBalls, HasSpringGroove=false, Engagement_Len=Engagement_Len);
		}
	/**/
	
	
	//translate([0,0,DrogueCup_Z]) rotate([0,0,-180/nFins]) Drogue_Cup();
	//translate([0,0,FwdLock_Z]) rotate([0,0,-180/nFins]) ForwardBoosterLock();
	
	//translate([0,0,EBay_Z]) rotate([0,0,45]) R157_MainEBay(TopOnly=false, BottomOnly=false, ShowDoors=false, RedundantAtls=false);
	
	/*
	if (ShowInternals==false) translate([0,0,FinCanLen+0.1]) 
		color("LightBlue") Tube(OD=Body_OD, ID=Body_ID, Len=BodyTubeLen-0.2, 90);
	/**/
	
	//FinCan();
	
	if (ShowBoosters)
		for (j=[0:nBoosters-1]) rotate([0,0,360/nBoosters*j]) translate([0,-Body_COD/2-BoosterBody_OD/2-1,0]) 
			rotate([0,0,90]) ShowRocketStrapOn(ShowInternals=false);

	
	
	if (ShowFins)
	for (j=[0:nFins-1])
		rotate([0,0,360/nFins*j+180/nFins]) 
			translate([0, Body_OD/2-Fin_Post_h, Fin_Root_L/2+FinInset]) 
				rotate([-90,0,0]) color("Yellow") Rocket_Fin();
	
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
// ShowRocket(ShowInternals=false, ShowBoosters=true, ShowFins=false);
// ShowRocket(ShowInternals=false, ShowBoosters=false, ShowFins=false);

module R137_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID, HasPD_Ring=false){
	// PD_Ring is required to attach the petal hub because 3 balls isn't good enough and 5 won't line up.
	
	Bolt_a=0;// offset between PD_PetalHub and R65_BallRetainerBottom

	
	PD_Ring_h=9;
	
	difference(){
		union(){
			STB_BallRetainerBottom(Body_ID=Body_ID, Body_OD=Body_ID, nLockBalls=nLockBalls, HasSpringGroove=false, 
									Engagement_Len=Engagement_Len, HasLargeInnerBearing=true, Xtra_r=0.0);
			
				
		//*
			if (HasPD_Ring){
				translate([0,0,-Engagement_Len/2-PD_Ring_h])
					Tube(OD=Body_ID-IDXtra*2, ID=Body_ID-IDXtra-4.4, Len=PD_Ring_h+Overlap, myfn=$preview? 90:360);
				
				rotate([0,0,Bolt_a]) translate([0,0,-Engagement_Len/2-PD_Ring_h])
					PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=6) cylinder(d=8, h=PD_Ring_h+Overlap);
					
				translate([0,0,-Engagement_Len/2-PD_Ring_h]) 
					Tube(OD=39, ID=34, Len=PD_Ring_h+Overlap, myfn=$preview? 90:360);
			}
		/**/
			
		} // union
		
		if (HasPD_Ring){
			rotate([0,0,Bolt_a]) translate([0,0,-Engagement_Len/2-PD_Ring_h])
				PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=6) rotate([180,0,0]) Bolt4Hole(depth=PD_Ring_h-1);
			
		}

	} // difference
} // R137_BallRetainerBottom

// R137_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID, HasPD_Ring=true);
// R137_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID, HasPD_Ring=false);

module Nosecone(){
	BluntOgiveNoseCone(ID=Body_ID*CF_Comp+IDXtra, OD=Body_COD, L=NC_Len, Base_L=NC_Base_L, nRivets=NC_nRivets, Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, LowerPortion=false, FillTip=true);
} // Nosecone

// Nosecone();

module NoseconeBase(){
	NC_ShockcordRingDual(Tube_OD=Body_COD, Tube_ID=Body_ID*CF_Comp, NC_ID=0, NC_Base_L=NC_Base_L, 
		nRivets=NC_nRivets, nBolts=nEBayBolts, Flat=true, UseHardSpring=false);
} // NoseconeBase

// NoseconeBase();

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
	Tube_Z=XtraLen+13+30.15;
	Tube_a=-30;
	TubeSlot_w=34;
	TubeOffset_X=0;
	nBolts=6;
	
	difference(){
		union(){
			STB_BallRetainerTop(Body_ID=Body_ID, Outer_OD=Body_OD, Body_OD=Body_ID, nLockBalls=nLockBalls,
			HasIntegratedCouplerTube=true, nBolts=0,
			IntegratedCouplerLenXtra=XtraLen,
				
			HasSecondServo=true,
			UsesBigServo=true,
			Engagement_Len=Engagement_Len, HasLargeInnerBearing=true, Xtra_r=0.0);
				
			translate([0,0,XtraLen+13+35.5]) 
				Tube(OD=Body_ID, ID=Body_ID-6, Len=4, myfn=$preview? 90:360);
			
			translate([0,0,XtraLen+13+35.5+4]) 
				rotate([180,0,0]) Tube(OD=39, ID=34, Len=XtraLen+46.5, myfn=$preview? 90:360);
				
			// Shock cord retention
			difference(){
				hull(){
					rotate([0,0,Tube_a]) translate([TubeOffset_X,0,Tube_Z]) 
						rotate([90,0,0]) cylinder(d=Tube_d+6, h=Body_ID-2, center=true);
					rotate([0,0,Tube_a]) translate([TubeOffset_X,0,7])
						cube([Tube_d+8, Body_ID-2, Overlap],center=true);
				} // hull
				
				hull(){
					rotate([0,0,Tube_a]) translate([TubeOffset_X,0,Tube_Z]) 
						rotate([90,0,0]) cylinder(d=Tube_d+7, h=TubeSlot_w, center=true);
					rotate([0,0,Tube_a]) translate([TubeOffset_X,0,7])
						cube([Tube_d+8+Overlap, TubeSlot_w, Overlap*2], center=true);
				} // hull
					
				// Trim outside
				Tube(OD=Body_OD+20, ID=Body_ID-1, Len=50, myfn=$preview? 90:360);
			} // difference
		} // union
	
		translate([TubeOffset_X,0,Tube_Z]) rotate([90,0,Tube_a]) 
			cylinder(d=Tube_d, h=Body_OD, center=true);
			
		// Bolt holes in skirt
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) translate([0,Body_OD/2,XtraLen+36.5+7.5])
			rotate([-90,0,0]) Bolt4Hole();
			
		//cube([100,100,100]);
	} // difference
} // RBP4_BallRetainerTop

// rotate([180,0,0]) RBP4_BallRetainerTop();

module CableStop(){
	D=9.7;
	L=10;
	Slot_W=1.8;
	
	difference(){
		union(){
			cylinder(d=D, h=L);
			translate([0,1,0]) scale([1.2,1,1]) cylinder(d=D+2, h=2);
		} // union
		
		translate([0,0,3]) cylinder(d=D-4, h=L);
		
		hull(){
			translate([0,2,-Overlap]) cylinder(d=Slot_W, h=L+Overlap*2);
			translate([0,-D,-Overlap]) cylinder(d=Slot_W, h=L+Overlap*2);
		} // hull
	} // difference
} // CableStop

// CableStop();

/*
MPL_Ball_d=6;
MPL_PreLoad=-0.4;
MPL_BallCircle_d=BT137Coupler_ID-MPL_Ball_d-1;
MPL_Race_OD=Body_COD;
MPL_Body_ID=Body_ID*CF_Comp;
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
/**/


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

module GearCover(){
	Gear1_d=43;
	Gear2_d=50;
	Shaft1_d=20;
	Shaft2_d=25;
	GearCover_w=16;
	Wall_t=2.2;
	Face_Y=21.5;
	Shelf_h=30;
	
	
	difference(){
		union(){
			// gear covers
			rotate([-90,0,0]) cylinder(d=Gear1_d+12, h=GearCover_w, center=true);
			translate([40,0,17]) rotate([-90,0,0]) cylinder(d=Gear2_d+12, h=GearCover_w, center=true);
		
			// mounting
			translate([-(Gear1_d+12)/2,Face_Y,-10]) mirror([0,1,0]) cube([Gear1_d+12+30,Face_Y-6,40]);
			translate([-(Gear1_d+12)/2,Face_Y+6,Shelf_h]) mirror([0,1,0]) cube([Gear1_d+12+30, Face_Y, 3]);
		} // union
		
		// trim bottom
		translate([0,0,-30]) cube([200,100,46],center=true);
		
		// trim right side
		translate([50,-15,-20]) cube([50,50,100]);
		
		// trim outside
		translate([0,-18,-20]) Tube(OD=Body_OD, ID=Coupler_ID-1, Len=100, myfn=$preview? 36:360);
		
		// Gears
		hull(){
			rotate([-90,0,0]) cylinder(d=Gear1_d+7, h=GearCover_w-Wall_t*2, center=true);
			translate([0,0,-50]) rotate([-90,0,0]) cylinder(d=Gear1_d+7, h=GearCover_w-Wall_t*2, center=true);
		} // hull
		hull(){
			translate([40,0,17]) rotate([-90,0,0]) cylinder(d=Gear2_d+7, h=GearCover_w-Wall_t*2, center=true);
			translate([40,0,17-50]) rotate([-90,0,0]) cylinder(d=Gear2_d+7, h=GearCover_w-Wall_t*2, center=true);
		} // hull

		// Shafts
		hull(){
			rotate([-90,0,0]) cylinder(d=Shaft1_d, h=GearCover_w+40, center=true);
			translate([0,0,-50]) rotate([-90,0,0]) cylinder(d=Shaft1_d, h=GearCover_w+40, center=true);
		} // hull
		
		hull(){
			translate([0,8,0]) rotate([-90,0,0]) cylinder(d=Shaft1_d, h=1);
			translate([0,Face_Y-6,0]) rotate([-90,0,0]) cylinder(d=30, h=7);
			
			translate([0,8,-50]) rotate([-90,0,0]) cylinder(d=Shaft1_d, h=1);
			translate([0,Face_Y-6,-50]) rotate([-90,0,0]) cylinder(d=30, h=7);
		} // hull
		
		
		hull(){
			translate([40,0,17]) rotate([-90,0,0]) cylinder(d=Shaft2_d, h=GearCover_w+10, center=true);
			translate([40,0,17-50]) rotate([-90,0,0]) cylinder(d=Shaft2_d, h=GearCover_w+10, center=true);
		} // hull
	
	} // difference


} // GearCover

//GearCover();

module DrogueBayBase(){
	Wall_t=2.2;
	
	Interface_L=20;
	OAL_Z=Interface_L*2+5;
	
	difference(){
		union(){
			Tube(OD=Body_ID, ID=Body_ID-Wall_t*2, Len=OAL_Z, myfn=$preview? 36:360);
			translate([0,0,Interface_L]) Tube(OD=Body_OD+IDXtra*2, ID=Body_ID-Wall_t*2, Len=5, myfn=$preview? 36:360);
			SE_SpringEndTypeB(Coupler_OD=Coupler_OD, MotorCoupler_OD=BT75Body_OD, nRopes=6, UseSmallSpring=false);
		} // union
	
		nRivets=6;
		Rivet_Z=OAL_Z-10;
		// Rivet holes
		for (j=[0:nRivets-1]) rotate([0,0,360/nRivets*j+180/nRivets])
			translate([0, Body_OD/2+1, Rivet_Z])
				rotate([90,0,0]) cylinder(d=4, h=25);
	} // difference
} // DrogueBayBase

// DrogueBayBase();

module AlignmentPins(nPins=6){
	Pin_d=4;
	PinLen=10;
	
	for (j=[0:nPins-1]) rotate([0,0,360/nPins*j+180/nPins]) translate([0,Body_ID/2-4,-Overlap])
		cylinder(d=Pin_d, h=PinLen+Overlap*2);
} // AlignmentPins

//AlignmentPins();

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
	TrapFin3(Post_h=Fin_Post_h, Root_L=Fin_Root_L, Tip_L=Fin_Tip_L,
			Root_W=Fin_Root_W, Tip_W=Fin_Tip_W,
			Span=Fin_Span, Chamfer_L=Fin_Chamfer_L,
					TipOffset=Fin_TipOffset, PrinterBrim_H=0.8, HasSpiralVaseRibs=false);
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
			translate([0,0,FinCanLen-5])
				CenteringRing(OD=Body_OD-1, ID=MotorTubeHole_d, Thickness=5, nHoles=nFins);
				
			// Middle centering rings
			translate([0,0,FinCanLen/2-5]) 
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
			rotate([0,0,360/nBoosters*j-360/nFins]) 
				translate([0,Body_OD/2-BD5_BoosterButtonOAH(), BoosterButton1_z]) 
					rotate([-90,0,0]) BD5_ThrustPoint_Hole();
					
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
		rotate([0,0,360/nBoosters*j-360/nFins]) 
			translate([0, Body_OD/2-BD5_BoosterButtonOAH(), BoosterButton1_z]) 
				rotate([-90,0,0]) BD5_ThrustPoint(BodyTube_OD=Body_OD, BoosterBody_OD=BT75Body_OD);
				
	//*
	// Rail Guide
	if (!HideBottom && !HideNotTail) 
	difference(){
		translate([0,0,RailGuide_Z]) rotate([0,0,RailGuide_a])
			RailGuidePost(OD=Body_OD, MtrTube_OD=MotorTubeHole_d, H=RailGuide_H, TubeLen=70, Length = 40, BoltSpace=12.7);

		translate([0,0,RailGuide_Z]) TrapFin2Slots(Tube_OD=Body_OD, nFins=nFins,
			Post_h=Fin_Post_h, Root_L=Fin_Root_L, Root_W=Fin_Root_W, Chamfer_L=Fin_Chamfer_L);
			
		for (j=[0:nBoosters-1])
			rotate([0,0,360/nBoosters*j-360/nFins]) 
				translate([0,Body_OD/2-BD5_BoosterButtonOAH(), BoosterButton1_z]) 
					rotate([-90,0,0]) BD5_ThrustPoint_Hole();
					
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

/* 
// Too Big
BF_OD=250;
BF_NC_Len=300;
BF_Body_Len=200;
/**/

BF_OD=190;
BF_NC_Len=240;
BF_Body_Len=200;

BigFairingWall_t=12;

module ShowBigFairing(){
	BigFairing();
	translate([0,0,-0.2]) BF_Tube();
	translate([0,0,-BF_Body_Len-0.4-30]) BF_Base();
	
	translate([0,0,-BF_Body_Len-0.4-30-100])
	Tube(OD=BT137Body_OD, ID=BT137Body_ID, Len=50, myfn=$preview? 90:360);
} // ShowBigFairing

//ShowBigFairing();

module BigFairing(){
	
	NC_Wall_t=BigFairingWall_t;
	NC_Len=BF_NC_Len;
	NC_Base_L=15;
	NC_Tip_R=30;
	
	BluntOgiveNoseCone(ID=BF_OD-NC_Wall_t*2, OD=BF_OD, L=NC_Len, Base_L=NC_Base_L, nRivets=0, Tip_R=NC_Tip_R, Wall_T=NC_Wall_t, Cut_Z=0, Transition_OD=PML98Body_OD, LowerPortion=false);

	translate([0,0,NC_Base_L+40]){
		CenteringRing(OD=BF_OD-NC_Wall_t*2, ID=BT137Body_OD+IDXtra*3, Thickness=5, nHoles=0, Offset=0);
		Trans_L=20;
		difference(){
			translate([0,0,-Trans_L+Overlap]) 
				cylinder(d=BF_OD-NC_Wall_t*2, h=Trans_L);
		
			translate([0,0,-Trans_L]) 
				cylinder(d1=BF_OD-NC_Wall_t*2, d2=BT137Body_OD+IDXtra*3, h=Trans_L+Overlap*3);
		} // difference
	}
		
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
	CouplerWall_t=2.4;
	
	translate([0,0,NC_Base_L-5])
		CenteringRing(OD=BF_OD-NC_Wall_t*2-1, ID=BT137Body_OD+IDXtra*3, Thickness=5, nHoles=0, Offset=0);
		
	// filet		
	translate([0,0,NC_Base_L-30])
	difference(){
		union(){
			cylinder(d=BF_OD-NC_Wall_t*2+1, h=15+Overlap);
			translate([0,0,5]) cylinder(d=BF_OD-NC_Wall_t*2-1, h=20+Overlap);
		} // union
		
		translate([0,0,-Overlap]) 
			cylinder(d1=BF_OD-NC_Wall_t*2, d2=BT137Body_OD+IDXtra*3, h=25+Overlap*3);
	} // difference
			
	translate([0,0,-Overlap])
	Tube(OD=BF_OD-NC_Wall_t*2-IDXtra*2, ID=BF_OD-NC_Wall_t*2-CouplerWall_t*2, Len=NC_Base_L, myfn=$preview? 90:360);
	
	difference(){
		translate([0,0,-5-CouplerWall_t]) cylinder(d=BF_OD-1, h=5+CouplerWall_t);
		
		translate([0,0,-5-CouplerWall_t-Overlap]) 
			cylinder(d1=BF_OD-NC_Wall_t*2, d2=BF_OD-NC_Wall_t*2-CouplerWall_t*2, h=CouplerWall_t, $fn=$preview? 90:360);
			
		translate([0,0,-5-CouplerWall_t-Overlap]) 
			cylinder(d=BF_OD-NC_Wall_t*2-CouplerWall_t*2, h=5+CouplerWall_t+Overlap*2, $fn=$preview? 90:360);
	} // difference
	
	translate([0,0,-BF_Body_Len])
	Tube(OD=BF_OD, ID=BF_OD-NC_Wall_t*2, Len=BF_Body_Len, myfn=$preview? 90:360);
} // BF_Tube

// translate([0,0,-1]) BF_Tube();

module BF_Base(){
	Tr_r=30;
	NC_Wall_t=BigFairingWall_t;
	Base_Len=20;
	TubeWall_t=3;
	
	difference(){
		union(){
			translate([0,0,Tr_r+15])
				CenteringRing(OD=BF_OD-NC_Wall_t*2-1, ID=BT137Body_OD+IDXtra*3, 
								Thickness=5, nHoles=0, Offset=0);
			// filet				
			difference(){
				translate([0,0,Tr_r-10]) cylinder(d=BF_OD-NC_Wall_t*2-1, h=25+Overlap);
				
				translate([0,0,Tr_r-10-Overlap]) 
					cylinder(d1=BF_OD-NC_Wall_t*2-1, d2=BT137Body_OD+IDXtra*3, h=25+Overlap*3);
				
			} // difference
								
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
			cylinder(d=BT137Body_OD+IDXtra*3, h=Tr_r*2+Base_Len+Overlap*2, $fn=$preview? 90:360);
			
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
	
	rotate([180,0,0]) STB_TubeEnd(BallPerimeter_d=BT137BallPerimeter_d, nLockBalls=nLockBalls, Body_OD=Body_OD, Body_ID=Body_ID, Skirt_Len=25);
} // BF_Base_TubeEnd

// translate([0,0,-201-31-101]) BF_Base_TubeEnd();


























