// ***********************************
// Project: 3D Printed Rocket
// Filename: RocketBoosterPooper5.scad
// by David M. Flynn
// Created: 9/15/2023 
// Revision: 0.9.11  2/2/2026
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
// 
// 0.9.11  2/2/2026 BP4 old stuff removed, Worked on fincan.
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
//
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
// BT54MotorRetainer();
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
// ShowRocket(ShowInternals=true, ShowBoosters=false, ShowFins=false);
// ShowRocket(ShowInternals=false, ShowBoosters=true, ShowFins=true);
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

nLockBalls=R157_nLockBalls();
Engagement_Len=R157_Engagement_Len();

// *** 54mm Motor Tube ***
MotorTube_OD=BT54Body_OD;
MotorTube_ID=BT54Body_ID;
MotorTubeHole_d=MotorTube_OD+IDXtra*3;

nFins=6;
Fin_Post_h=14;
Fin_Root_L=270;
Fin_Root_W=14;
Fin_Tip_W=5;
Fin_Tip_L=120;
Fin_Span=180;
Fin_TipOffset=50;
Fin_Chamfer_L=50;

FinInset=5;
FinCanLen=Fin_Root_L+FinInset*2;

TailConeLen=25;
Tail_OD=ATRMS_Motor54Retainer_OD()+10;

EBay_Len=168; 
nEBayBolts=R157_nEBayBolts();

nPetals=6;

NC_Len=220;
NC_Tip_r=10;
NC_Wall_t=2.2;
NC_Base_L=15;
NC_nRivets=6;
	
BoosterDropperCL=300;
UseAlignmentPins=false;

MotorTubeLen=24*25.4;
echo(MotorTubeLen=MotorTubeLen);

nBoosters=3;
BoosterButton1_z=52.8+5; // align to bottom of centering ring
RailGuide_Z=35;
RailGuide_a=0;
RailGuide_H=Body_OD/2+2;

BodyTubeLen=400;
echo(BodyTubeLen=BodyTubeLen);

FwdTube_L=400;

module ShowRocket(ShowInternals=false, ShowBoosters=false, ShowFins=true){
	MotorTube_Z=-TailConeLen+12;
	FinCan_Z=0;
	FwdLock_Z=BoosterDropperCL+BoosterButton1_z-63;
	LowerBody_Z=FwdLock_Z+156;
	EBay_Z=LowerBody_Z+BodyTubeLen+30;
	
	
	FwdTubeEnd_Z=EBay_Z+EBay_Len+30;
	FwdTube_Z=FwdTubeEnd_Z+3+12.5;
	NC_Z=FwdTube_Z+4+FwdTube_L;
	
	
	//
	translate([0,0,NC_Z]) Nosecone();
		
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
	
	
	//translate([0,0,FwdLock_Z]) rotate([0,0,-180/nFins]) ForwardBoosterLock();
	
	//
	translate([0,0,EBay_Z]) rotate([0,0,45]) R157_MainEBay(TopOnly=false, BottomOnly=false, ShowDoors=false, RedundantAtls=false);
	
	//*
	if (ShowInternals==false) translate([0,0,LowerBody_Z+0.1]) 
		color("LightBlue") Tube(OD=Body_OD, ID=Body_ID, Len=BodyTubeLen-0.2, 90);
	/**/
	
	//translate([0,0,BoosterDropperCL+BoosterButton1_z]) color("Red") cylinder(d=Body_OD+10, h=1);
	//translate([0,0,BoosterButton1_z]) color("Red") cylinder(d=Body_OD+10, h=1);
	
	translate([0,0,FwdLock_Z]) rotate([0,0,180/nBoosters]) BD5_ShowRocketBody(Body_OD=Body_COD, Body_ID=Body_ID, nBoosters=nBoosters);
	
	translate([0,0,FinCan_Z]) FinCan();
	
	if (ShowBoosters)
		for (j=[0:nBoosters-1]) rotate([0,0,360/nBoosters*j]) translate([0,-Body_COD/2-BoosterBody_OD/2-1,0]) 
			rotate([0,0,90]) ShowRocketStrapOn(ShowInternals=false);

	
	
	if (ShowFins)
	for (j=[0:nFins-1])
		rotate([0,0,360/nFins*j+180/nFins]) 
			translate([0, Body_OD/2-Fin_Post_h, Fin_Root_L/2+FinInset]) 
				rotate([-90,0,0]) color("Yellow") Rocket_Fin();
	
	//*
	if (ShowInternals) translate([0,0,MotorTube_Z]) 
		color("LightBlue") Tube(OD=MotorTube_OD, ID=MotorTube_ID, Len=MotorTubeLen, 90);
	/**/
	/*
	if (ShowInternals) translate([0,0,MotorTube_Z]) 
		ATRMS_54_2560_Motor(Extended=true, HasEyeBolt=true); // K270W
		//ATRMS_54_1706_Motor(Extended=true, HasEyeBolt=true); // K185W
	/**/	
	
	//
	translate([0,0,MotorTube_Z-18]) color("Tan") BT54MotorRetainer();
	
} // ShowRocket

// ShowRocket(ShowInternals=true, ShowBoosters=false, ShowFins=false);
// ShowRocket(ShowInternals=false, ShowBoosters=true, ShowFins=false);
// ShowRocket(ShowInternals=false, ShowBoosters=false, ShowFins=false);

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

// NC_PetalHub();

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

module AlignmentPins(nPins=6, Pin_d=4, PinLen=10){
	
	
	for (j=[0:nPins-1]) rotate([0,0,360/nPins*j]) translate([0,Body_ID/2-4,-Overlap])
		cylinder(d=Pin_d, h=PinLen+Overlap*2);
} // AlignmentPins

//AlignmentPins();


module Rocket_Fin(){
	TrapFin3(Post_h=Fin_Post_h, Root_L=Fin_Root_L, Tip_L=Fin_Tip_L,
			Root_W=Fin_Root_W, Tip_W=Fin_Tip_W,
			Span=Fin_Span, Chamfer_L=Fin_Chamfer_L,
					TipOffset=Fin_TipOffset, PrinterBrim_H=0.8, HasSpiralVaseRibs=false);
} // Rocket_Fin

// Rocket_Fin();

module FinCan(){
	nCouplerBolts=nFins*2;
	
	difference(){
		union(){
			//Integrated coupler
			CouplerLen=15;
			if (UseAlignmentPins==false) translate([0,0,FinCanLen-Overlap])
				Tube(OD=Body_ID, ID=Body_ID-6, Len=CouplerLen, myfn=$preview? 90:360);
				
			Tube(OD=Body_OD, ID=Body_ID, Len=FinCanLen, myfn=$preview? 90:360);
			
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
		
		//CouplerBolts
		for (j=[0:nCouplerBolts]) rotate([0,0,360/nCouplerBolts*j]) 
			translate([0,Body_OD/2+1,FinCanLen+7.5]) rotate([-90,0,0]) Bolt4Hole();
		
		//Top alignment pins
		if (UseAlignmentPins) translate([0,0,FinCanLen-5]) rotate([0,0,RailGuide_a+30]) AlignmentPins();
		
		// Middle alignment pins
		translate([0,0,FinCanLen/2-5]) AlignmentPins(nPins=6);
		
		// Bottom alignment pins
		AlignmentPins(nPins=6);
		
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
				
	} // difference

	
	for (j=[0:nBoosters-1])
		rotate([0,0,360/nBoosters*j-360/nFins]) 
			translate([0, Body_OD/2-BD5_BoosterButtonOAH(), BoosterButton1_z]) 
				rotate([-90,0,0]) BD5_ThrustPoint(BodyTube_OD=Body_COD, BoosterBody_OD=BoosterBody_OD);
			
	//*
	// Rail Guide
	
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
	
	//TailCone();
} // FinCan

// FinCan();

module FinCanBottomHalf(){
	difference(){
		FinCan();
		
		translate([0,0,FinCanLen/2]) cylinder(d=Body_OD+10, h=FinCanLen);
	} // difference
} // FinCanBottomHalf

//rotate([180,0,0]) FinCanBottomHalf();

module FinCanTopHalf(){
	difference(){
		FinCan();
		
		translate([0,0,-TailConeLen-Overlap]) cylinder(d=Body_OD+10, h=FinCanLen/2+TailConeLen+Overlap);
	} // difference
} // FinCanTopHalf

// FinCanTopHalf();

module TailCone(Cone_Len=TailConeLen, Interface_OD=Body_ID){
	TC_Ts_r=22;
	OD=Body_COD;
	
	difference(){
		
		hull(){
			translate([0,0,-Cone_Len]) cylinder(d=Tail_OD, h=2, $fn=$preview? 90:360);
			
			difference(){
				rotate_extrude($fn=$preview? 90:360) translate([OD/2-TC_Ts_r,0,0]) circle(r=TC_Ts_r);
				translate([0,0,Overlap]) cylinder(d=OD+1,h=10);
			}
		} // hull
		
		translate([0,0,-3]) rotate([0,0,180/12]) AlignmentPins(nPins=6, Pin_d=4, PinLen=10);
		
		// make hollow
		difference(){
			hull(){
				translate([0,0,-Cone_Len+2]) cylinder(d=Tail_OD-6, h=2, $fn=$preview? 90:360);
				
				difference(){
					rotate_extrude($fn=$preview? 90:360) translate([OD/2-TC_Ts_r,0,0]) circle(r=TC_Ts_r-6);
					translate([0,0,Overlap]) cylinder(d=OD+1,h=10);
				} // difference
			} // hull
			
			translate([0,0,-Cone_Len-Overlap]) cylinder(d=ATRMS_Motor54Retainer_OD()+6, h=Cone_Len+TC_Ts_r);
			
			//Spokes
			nSpokes=12;
			for (j=[0:nSpokes-1]) rotate([0,0,360/nSpokes*j]) 
				translate([-1,0,-Cone_Len-Overlap]) cube([2,Interface_OD/2,Cone_Len]);
			
			translate([0,0,-2]) rotate([0,0,180/12]) AlignmentPins(nPins=6, Pin_d=7, PinLen=10);
		} // difference
		
		// Trim top
		translate([0,0,Overlap]) cylinder(d=OD+1, h=TC_Ts_r);
		
		// Motor tube
		translate([0,0,-Cone_Len-Overlap]) 
			cylinder(d=MotorTubeHole_d, h=Cone_Len+Overlap*3);
	
		translate([0,0,-Cone_Len-Overlap]) cylinder(d=ATRMS_Motor54Retainer_OD()+IDXtra*3, h=33);	
	

		if ($preview) translate([0,0,-Cone_Len-1]) rotate([0,0,10]) cube([100,100,100]);
	} // difference
	
	
} // TailCone

// rotate([180,0,0]) TailCone();


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


























