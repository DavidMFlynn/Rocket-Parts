// ***********************************
// Project: 3D Printed Rocket
// Filename: BoosterPooper3.scad
// by David M. Flynn
// Created: 9/3/2022 
// Revision: 0.9.5  5/9/2025
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  Booster Pooper 3 is the 3rd rocket I've built w/ strap-on boosters. 
//  Rocket with 2 strap-on boosters. 
//  Boosters have 38mm motors w/ 54mm body
//  Sustainer has 54mm motor w/ 98mm body
//
//
//  ***** History *****
//
// 0.9.5  5/9/2025  Rework of strap-on boosters begins.
// 0.9.4  9/25/2022 Work on ForwardBoosterLock parts. 
// 0.9.3  9/18/2022 Added some missing parts.
// 0.9.2  9/9/2022  Still working on ForwardBoosterLock
// 0.9.1  9/8/2022  Booster is ready to print, still working on ForwardBoosterLock and parts. 
// 0.9.0  9/3/2022  First code.
//
// ***********************************
//  ***** for STL output *****
//
// CenteringRing(OD=BT98Coupler_ID, ID=LOC29Body_OD+IDXtra, Thickness=5, nHoles=5, Offset=0, myfn=90);
//  
//	Electronics_Bay();	
//   AltDoor54(Tube_OD=BP_Body_OD);
//   FairingBaseBulkPlate(Tube_ID=BP_Fairing_OD, Fairing_ID=BP_Fairing_ID, ShockCord_a=90);
// 
// 
// ForwardBoosterLock();
// BB_LockingThrustPoint(); // Print 2, bolts into ForwardBoosterLock
// BB_Lock(); // Print 2, Rotating lock
// BB_BearingStop(); // Print 2, Only used with ball bearing
// rotate([180,0,0]) BB_LockShaft(Len=LockShaftLen, nTeeth=nLockShaftTeeth);
// rotate([180,0,0]) ServoGear(nTeeth=nServoGearTeeth);
// rotate([180,0,0]) ServoMount();
//
// BP_Fin();
// rotate([180,0,0]) LowerFinCan();
// UpperFinCan();
//
// ************************************************
//  *** Strap-On Booster Parts ***
// 
// BluntOgiveNoseCone(ID=BP_Booster_Body_ID, OD=BP_Booster_Body_OD, L=BP_Booster_NC_Len, Base_L=BP_Booster_NC_Base_L, nRivets=3, RivertInset=0, Tip_R=BP_Booster_NC_Tip_r, HasThreadedTip=false, Wall_T=BP_Booster_NC_Wall_t, Cut_d=0, LowerPortion=false, FillTip=true);
//
//
//  *** Spring Thing Internal 54 ***
//
// STI_ServoMount(Body_ID=LOC54Body_ID, MountBoltBC_d=38);
// STI_LockDisk(nLockBalls=nLockBalls, Xtra_r=0.0);
// rotate([180,0,0]) STI_BallRetainerTop(nLockBalls=nLockBalls, Xtra_r=0.0);
// STI_BallRetainerBottom(nLockBalls=nLockBalls, Xtra_r=0.0);
// STI_SpringEndTwo(Body_ID=LOC54Body_ID-IDXtra, nLockBalls=3, HasPetalLock=true, UseBallGroove=false);
// STI_SpringEndOne();
// STI_SmallSpringSplice();

//
// PD_NC_PetalHub(OD=BP_Booster_Body_ID-0.7, nPetals=2, HasReplaceableSpringHolder=false, nRopes=0, ShockCord_a=-1, HasThreadedCore=true, ST_DSpring_ID=SE_Spring_CS4323_ID(), ST_DSpring_OD=SE_Spring_CS4323_OD(), CouplerTube_ID=0, CouplerTubeLen=-1);
// rotate([-90,0,0]) PD_PetalSpringHolder2();
// rotate([180,0,0]) PD_Petals(OD=BP_Booster_Body_ID-0.5, Len=100, nPetals=2, Wall_t=1.6, AntiClimber_h=0, HasLocks=true, Lock_Span_a=30);
//
//
// BoosterForwardEnd();
// BoosterSpacer(Len=1.5);
// rotate([180,0,0]) BoosterTail();
// BoosterButton(XtraLen=0.8);
//
// ***********************************
//  ***** Routines *****
//
// TailCone5438(OD=BP_Booster_Body_OD, ID=BP_Booster_MtrTube_OD, Len=50);
// BoosterThrustRing();
// BB_ThrustPoint();
// BB_LockingThrustPoint();
//
// ***********************************
//  ***** for Viewing *****
//
// ShowBooster();
// ShowBoosterPooper();
//
// ***********************************

include<TubesLib.scad>
use<NoseCone.scad>
use<LD-20MGServoLib.scad>
include<BoosterDropperLib.scad>
use<FinCan2Lib.scad>
use<RailGuide.scad>
use<PetalDeploymentLib.scad>
use<Fins.scad>
use<CableReleaseBB.scad>
use<SpringEndsLib.scad>
use<ElectronicsBayLib.scad>
use<BatteryHolderLib.scad>
use<SpringThingInside.scad>
//use<ThreadLib.scad>

//Alt_DoorXtra_X=4;
//Alt_DoorXtra_Y=4;

//also included
  //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

nFins=4;
nBoosters=2;

BP_Booster_Body_OD=PML54Body_OD;
BP_Booster_Body_ID=PML54Body_ID;
BP_Booster_MtrTube_OD=PML38Body_OD;
BP_Booster_MtrTube_ID=PML38Body_ID;
BP_Booster_MtrRtr_OD=PML38Body_OD+6;

BP_Body_OD=PML98Body_OD;
BP_Body_ID=PML98Body_ID;
BP_BobyCoupler_OD=PML98Coupler_OD;
BP_BobyCoupler_ID=PML98Coupler_ID;
BP_MtrTube_OD=BT54Mtr_OD; //PML54Body_OD;

BP_Booster_NC_Base_L=13;
BP_Booster_NC_Len=90;
BP_Booster_NC_Wall_t=1.6;
BP_Booster_NC_Tip_r=6;

BP_ElectronicsBay_Len=140;
BP_LowerBodyTube_Len=276;
BP_UpperBodyTube_Len=200;


BP_Fin_Post_h=10;
BP_Fin_Root_L=240;
BP_Fin_Root_W=12;
BP_Fin_Tip_W=6;
BP_Fin_Tip_L=100;
BP_Fin_Span=180;
BP_Fin_TipOffset=40;
BP_Fin_Chamfer_L=24;
BP_Fin_Inset=5;
BP_FinCan_Len=BP_Fin_Root_L+BP_Fin_Inset*2;

ThrustRing_h=BoosterButtonMinor_d+6;
BP_EBay_Len=170;
BP_Booster_EBay_Len=170;
BP_BoosterTailConeLen=70;
BP_MtrTubeLen=24*25.4;

BP_BoosterButton1_z=50;
BP_BoosterButtonSpacing=BP_FinCan_Len-BP_BoosterButton1_z+BP_LowerBodyTube_Len+85;
echo(BP_BoosterButtonSpacing=BP_BoosterButtonSpacing);
BP_BoosterButton2_z=BP_BoosterButton1_z+BP_BoosterButtonSpacing;

BP_BoosterTubeLen=BP_BoosterButtonSpacing-ThrustRing_h-40;
echo(BP_BoosterTubeLen=BP_BoosterTubeLen);
BP_BoosterMotorTubeLen=BP_BoosterButtonSpacing+ThrustRing_h+BP_BoosterTailConeLen-7;
echo(BP_BoosterMotorTubeLen=BP_BoosterMotorTubeLen);

LockShaftLen=48.0; // Changed -0.5mm 9/11/2022
nLockShaftTeeth=24;
nServoGearTeeth=24;
TailCone_Len=30;


	
module BoosterInTubeEbay(){
	BR_X=3;
	BR_Y=0;
	BR_Z=-20;
	
	MagSw_X=3;
	MagSw_Y=0;
	MagSw_Z=14.5;
	
	RS_X=-2;
	RS_Y=0;
	RS_Z=-20;
	
	Batt_X=-8.5;
	Batt_Y=0;
	Batt_Z=34;
	
	Flange_d=49;
	Flange_t=6;
	Flange_Z=55;
	
	Bolt_d=0.190*25.4;
	Bolt_p=25.4/24;
	Bolt10Inset=5.5;
	Boss_Extra=0;
	
	module Bolt10ThreadedHole(){
		if ($preview) {cylinder(d=Bolt_d, h=10); }else{
			ExternalThread(Pitch=Bolt_p, Dia_Nominal=Bolt_d, Length=10, 
							Step_a=$preview? 5:2, TrimEnd=true, TrimRoot=true);}
	}
	difference(){
		union(){
			translate([BR_X,BR_Y,BR_Z]) rotate([0,-90,180]) BlueRavenMount();
			if ($preview) translate([BR_X,BR_Y,BR_Z]) translate([4.5+6,0,18]) #cube([9,16,7], center=true);
			translate([MagSw_X,MagSw_Y,MagSw_Z]) rotate([90,0,90]) FW_MagSw_Mount(HasMountingEars=false, Reversed=false);
			
			
			translate([RS_X,RS_Y,RS_Z]) rotate([-90,0,90]) RocketServoHolderRevC(IsDouble=false, HasBackHoles=false);
			translate([Batt_X,Batt_Y,Batt_Z]) rotate([0,0,90]) LiPo2S320mAh_BattPocket();
			
			translate([1,0,1.1]) cube([6.6,14,108],center=true);
			
			translate([0,0,Flange_Z]){
				cylinder(d=Flange_d, h=Flange_t);
				translate([0,Flange_d/2-Bolt10Inset,-Boss_Extra]) cylinder(d=Bolt10Inset*2,h=Flange_t+Boss_Extra);
				translate([0,-Flange_d/2+Bolt10Inset,-Boss_Extra]) cylinder(d=Bolt10Inset*2,h=Flange_t+Boss_Extra);
			}
		} // union

		translate([Batt_X,Batt_Y,Batt_Z+10]) {
			rotate([0,0,90]) LiPo2S320mAh_BattHole(Xtra_X=0,Xtra_Y=0, Xtra_Z=0);
			
			// Batt wire path
			hull(){
				translate([0,10,10.5]) cylinder(d=7,h=10);
				translate([0,16,10.5]) cylinder(d=7,h=10);
			} // hull
		}
		
		// Servo wire path
		hull(){
			translate([-14, -14, Flange_Z-Overlap]) cylinder(d=3.5, h=Flange_t+Overlap*2);
			translate([-14+8, -14, Flange_Z-Overlap]) cylinder(d=3.5, h=Flange_t+Overlap*2);
		} // hull
		
		translate([MagSw_X,MagSw_Y,MagSw_Z]) rotate([90,0,90]) FW_MagSw_BoltPattern(Reversed=false) translate([0,0,3]) Bolt4Hole(depth=8);
		translate([BR_X,BR_Y,BR_Z]) rotate([0,-90,180]) BlueRavenBoltPattern() Bolt4Hole(depth=8);
		//translate([RS_X,RS_Y,RS_Z]) RocketServoRevCBoltPattern() Bolt4Hole();
		
		// shock cord
		translate([1,0,0]) cylinder(d=4.5,h=200, center=true);
		
		// Bolts #10-24
		translate([0,Flange_d/2-Bolt10Inset,Flange_Z-Boss_Extra-Overlap]) Bolt10ThreadedHole();
		translate([0,-Flange_d/2+Bolt10Inset,Flange_Z-Boss_Extra-Overlap]) Bolt10ThreadedHole();
	} // difference
	
	if ($preview) translate([0,0,-5]) #Tube(OD=PML38Body_OD, ID=PML38Body_ID, Len=3, myfn=90);
} // BoosterInTubeEbay

// rotate([180,0,0]) BoosterInTubeEbay();

module BoosterSpacer(Len=1.5){
	Tube(OD=BP_Booster_Body_OD, ID=BP_Booster_Body_ID, Len=Len, myfn=$preview? 90:180);
} // BoosterSpacer

// BoosterSpacer(Len=1.5);

module BoosterForwardEnd(){
	Tube_Len=40;
	MtrCR_Z=21;
	Button_Z=30;
	ButtonBoss_d=12.7;
	nBolts=4;
	
	difference(){
		union(){
			Tube(OD=BP_Booster_Body_OD, ID=BP_Booster_Body_ID, Len=Tube_Len, myfn=$preview? 90:180);
			
			translate([0,0,MtrCR_Z]) 
				CenteringRing(OD=BP_Booster_Body_ID+1, ID=BP_Booster_MtrTube_OD+IDXtra*2, Thickness=Tube_Len-MtrCR_Z, nHoles=0);
				
			translate([0,BP_Booster_Body_OD/2,Button_Z]) rotate([90,0,0]) cylinder(d=ButtonBoss_d, h=2);
			
			translate([0,0,Tube_Len-Overlap])
				Tube(OD=BP_Booster_Body_ID-IDXtra, ID=BP_Booster_Body_ID-IDXtra-4.4, Len=15, myfn=$preview? 90:180);
		} // union
		
		translate([0,BP_Booster_Body_OD/2+1,Button_Z]) rotate([90,0,0])
			if ($preview) {
				cylinder(d=6.35, h=10); 
			}else{
				ExternalThread(Pitch=1.27, Dia_Nominal=6.35, Length=10, 
							Step_a=$preview? 5:20, TrimEnd=true, TrimRoot=true);
			}
			
		translate([0,0,Tube_Len+7.5]) for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+180/nBolts]) translate([0,BP_Booster_Body_OD/2,0])
			rotate([-90,0,0]) Bolt4Hole();
	} // difference
} // BoosterForwardEnd

// BoosterForwardEnd();
//translate([0,0,40+5.0])PD_PetalLockCatch(OD=BP_Booster_Body_ID, ID=BP_Booster_Body_ID-3.4, Wall_t=1.8, Len=30, LockStop=false);

module ShowBooster(){
	//*
	// Booster nosecone
	//translate([0,0,BP_BoosterButton2_z+BP_Booster_EBay_Len+ThrustRing_h/2+Fairing_Len+Overlap*3]){

	
	/**/
	
	// Booster body tube
	//*
	color("LightBlue")
	translate([0,0,BP_BoosterButton1_z+ThrustRing_h/2+20+Overlap])
		Tube(OD=BP_Booster_Body_OD, ID=BP_Booster_Body_ID, 
			Len=BP_BoosterTubeLen-Overlap*2, myfn=$preview? 90:360);
	/**/
	// Booster tail
	translate([0,0,BP_BoosterButton1_z]) 
		rotate([0,0,-90]) color("Orange") BoosterTail();
	
	// Booster motor tube
	color("LightBlue")
	translate([0,0,BP_BoosterButton1_z-ThrustRing_h/2-62])
		Tube(OD=BP_Booster_MtrTube_OD, ID=BP_Booster_MtrTube_ID, 
			Len=BP_BoosterMotorTubeLen, myfn=$preview? 90:360);
			
	translate([-BP_Booster_Body_OD/2-BoosterButtonOA_h,0,BP_BoosterButton1_z])
		rotate([0,90,0]) BoosterButton();
	translate([-BP_Booster_Body_OD/2-BoosterButtonOA_h,0,BP_BoosterButton2_z])
		rotate([0,90,0]) BoosterButton();

} // ShowBooster

//ShowBooster();

module ShowBoosterPooper(){
	FinCan_Z=0;
	LowerBodyTube_Z=FinCan_Z+BP_FinCan_Len;
	//*
	// Nosecone and Fairing
	
	
	/**/
	
	translate([0,0,BP_BoosterButton2_z+40+BP_UpperBodyTube_Len+Overlap*2]) Electronics_Bay();
	
	//*
	translate([0,0,BP_BoosterButton2_z+50+Overlap*2+Overlap]) color("LightBlue")
		Tube(OD=BP_Body_OD, ID=BP_Body_ID, Len=BP_UpperBodyTube_Len-Overlap*2, myfn=$preview? 36:360);
	/**/
	
	translate([0,0,BP_BoosterButton2_z+Overlap*2]) rotate([0,0,45]) rotate([0,90,0]) BB_LockShaft(Len=LockShaftLen);
	

	
	//*
	translate([0,0,BP_BoosterButton2_z+Overlap*2])
		rotate([0,0,-45]) {
			translate([0,BP_Body_OD/2-BoosterButtonOA_h,0]) rotate([-90,0,0]){
				BB_Lock();
				color("Gray") BB_LockingThrustPoint();
				}
			rotate([0,0,180]) translate([0,BP_Body_OD/2-BoosterButtonOA_h,0]) 
				rotate([-90,0,0]) {
					BB_Lock();
					color("Gray") BB_LockingThrustPoint();
					}
	} /**/
	
	
	translate([0,0,BP_BoosterButton2_z+Overlap*2]) rotate([0,0,-45]) ForwardBoosterLock();
	
	//*
	translate([0,0,LowerBodyTube_Z+Overlap]) color("LightBlue")
		Tube(OD=BP_Body_OD, ID=BP_Body_ID, Len=BP_LowerBodyTube_Len-Overlap*2, myfn=$preview? 36:360);
	/**/
	
	/*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j])
		translate([0, BP_Body_OD/2-BP_Fin_Post_h, BP_Fin_Root_L/2+50]) 
			rotate([-90,0,0]) color("Yellow") BP_Fin();
	/**/
	
	/*  // Motor Tube
	translate([0,0,17]) color("Blue") Tube(OD=BP_MtrTube_OD, ID=54, 
			Len=BP_MtrTubeLen, myfn=$preview? 90:360);
	/**/
	 
	translate([0,0,FinCan_Z]) color("White") rotate([0,0,45]) UpperFinCan();
	translate([0,0,FinCan_Z]) color("LightGreen") LowerFinCan();
	
	// Boosters 
	//*
	rotate([0,0,45]) translate([BP_Booster_Body_OD/2+BP_Body_OD/2,0,0]) ShowBooster();
	rotate([0,0,45+180]) translate([BP_Booster_Body_OD/2+BP_Body_OD/2,0,0]) ShowBooster();
	/**/
		
} // ShowBoosterPooper

//ShowBoosterPooper();

module BoosterTubeJig(){
	Wall_t=2.2;
	nBolts=4;
	Tube_OD=BP_Booster_Body_OD+IDXtra*2;
	
	difference(){
		Tube(OD=Tube_OD+Wall_t*2, ID=Tube_OD, Len=15, myfn=90);
		
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) translate([0,Tube_OD/2+Wall_t,7.5]) rotate([-90,0,0]) #Bolt4Hole();
	} // difference
} // BoosterTubeJig

// BoosterTubeJig();

module R54_NC_Base(Body_OD=BP_Booster_Body_OD, Body_ID=BP_Booster_Body_ID, NC_Base_L=BP_Booster_NC_Base_L, Coupler_OD=BP_Booster_Body_ID-0.5){
	nBolts=4;
	
	difference(){
		union(){
			NC_ShockcordRing54(Body_OD=Body_OD, Body_ID=Body_ID, NC_Base_L=NC_Base_L, nRopes=0, nBolts=0);
			
			translate([0,0,-3]) cylinder(d=Body_OD, h=3, $fn=$preview? 90:360);
		} // union
		
		translate([0,0,-20]) cylinder(d=Body_OD+1, h=17);
		translate([0,0,-3-Overlap]) hull(){
			translate([-8,0,0]) cylinder(d=19, h=6);
			translate([8,0,0]) cylinder(d=19, h=6);
		} // hull
		
		//rotate([0,0,20]) 
		translate([0,0,-3]) PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=nBolts) rotate([180,0,0]) Bolt4Hole();
		
		hull(){
			translate([0,-10,-3]) cylinder(d=6,h=6);
			translate([0,-20,-3]) cylinder(d=6,h=6);
		} // hull
	} // difference
} // R54_NC_Base

// R54_NC_Base();

module R54_NC_Base_PetalHub(Body_OD=BP_Booster_Body_OD, Body_ID=BP_Booster_Body_ID, Coupler_OD=BP_Booster_Body_ID-0.5){
	ShockCord_a=90;
	
	PD_PetalHub(OD=LOC54Body_ID-IDXtra, 
					nPetals=2, 
					HasBolts=true,
					nBolts=4,
					ShockCord_a=ShockCord_a,
					HasNCSkirt=false, 
						Body_OD=Body_OD,
						Body_ID=Body_ID,
						NC_Base=0, 
						SkirtLen=10);
						
} // R54_NC_Base_PetalHub

// translate([0,0,-0.1]) rotate([180,0,0]) R54_NC_Base_PetalHub();

module SimpleBoosterNoseconeBase(){
	nRivets=3;
	Wall_t=1.8;
	ShockCord_a=90;
	
	difference(){
		union(){
			Tube(OD=BP_Booster_Body_ID, ID=BP_Booster_Body_ID-Wall_t*2, Len=16, myfn=90);
			cylinder(d=BP_Booster_Body_OD, h=3, $fn=90);
		} // union
		
		for (j=[0:nRivets-1]) rotate([0,0,360/nRivets*j]) translate([0,0,3+BP_Booster_NC_Base_L/2])
			rotate([90,0,0]) cylinder(d=4, h=BP_Booster_Body_ID);
			
		translate([0,0,3]) PD_PetalHubBoltPattern(OD=LOC54Body_ID, nBolts=4) Bolt4Hole();
		translate([0,0,-Overlap]) hull() PD_ShockCordHolePattern(OD=LOC54Body_ID, ShockCord_a=ShockCord_a) cylinder(d=4, h=15);
	} // difference
} // SimpleBoosterNoseconeBase

//SimpleBoosterNoseconeBase();

module Electronics_Bay(){
	// Z=0 center of Booster button
	TopOfTube=BP_EBay_Len+ThrustRing_h/2;
	CablePullerInset=-1;
	CP_a=0;
	CP_z=-40;
	
	CT_z=30;
		

} // Electronics_Bay

//Electronics_Bay();



module TailCone5438(OD=BP_Booster_Body_OD, ID=BP_Booster_MtrTube_OD, Len=50){
	TC_d=(OD-ID)/2;
	TC_h=TC_d*1.7;
	MtrRetainer_OD=BP_Booster_MtrRtr_OD;
	MtrRetainer_L=16;
	MtrRetainer_Inset=5;
	
	difference(){
		hull(){
			translate([0,0,Len-Overlap]) cylinder(d=OD, h=Overlap, $fn=$preview? 90:360);
			translate([0,0,TC_h]) rotate_extrude($fn=$preview? 90:360) translate([OD/2-TC_d/2,0,0]) circle(d=TC_d, $fn=$preview? 36:90);
			cylinder(d=ID, h=Overlap, $fn=$preview? 90:360);
		} // hull
		
		translate([0,0,-Overlap]) cylinder(d=ID+IDXtra*3, h=Len+Overlap*2, $fn=$preview? 90:360);
		translate([0,0,-Overlap]) cylinder(d=MtrRetainer_OD+IDXtra*2, h=MtrRetainer_L+MtrRetainer_Inset+Overlap*2, $fn=$preview? 90:360);
		cylinder(d=OD, h=MtrRetainer_Inset);
	} // difference
	
} // TailCone

//TailCone5438();

module BoosterTail(){
	// Z=0 : center of thrust ring
	TC_Len=BP_BoosterTailConeLen;
	
	translate([0,0,ThrustRing_h/2-Overlap]) 
		Tube(OD=PML54Body_OD, ID=PML54Body_ID, Len=20, myfn=$preview? 90:360);
	translate([0,0, -ThrustRing_h/2]) 
		BoosterThrustRing(MtrTube_OD=BP_Booster_MtrTube_OD, BodyTube_OD=BP_Booster_Body_OD);
	translate([0,0,-ThrustRing_h/2+Overlap-TC_Len]) TailCone5438(Len=TC_Len);
} // BoosterTail

//rotate([0,0,45]) translate([BP_Booster_Body_OD/2+BP_Body_OD/2,0,100]) rotate([0,0,-90]) BoosterTail();

module ServoMountAdaptor(){
	G_a=22.5;
	CentralCavity_Y=58;
	CentralCavity2_Y=44;
	Bottom_Z=-85;
	OAL_Z=135;
	ServoMount_Y=-8;
	
	difference(){
		// Servo bolt bosses
			rotate([0,G_a,0]) translate([0,ServoMount_Y,24*300/180]) rotate([0,-G_a,0]) 
				 rotate([0,90,90]) hull() ServoMountHolePattern() {
					 translate([0,0,0.9]) rotate([180,0,0]) cylinder(d=10,h=1);
					 translate([0,0,-6]) sphere(d=10);
				 }
				 
		// Servo
		rotate([0,G_a,0]) translate([0,ServoMount_Y,24*300/180]) rotate([0,90-G_a,0]) 
			rotate([-90,0,0]) Servo_HX5010(BottomMount=false,TopAccess=false,Xtra_w=1.2, Xtra_h=1);
				 
		difference(){
			translate([0,0,Bottom_Z+20]) cylinder(d=BP_Body_OD-1, h=OAL_Z-40, $fn=$preview? 90:360);
			
		
			translate([-BP_Body_OD/2,-CentralCavity2_Y/2,Bottom_Z-Overlap]) 
				cube([BP_Body_OD,CentralCavity2_Y,OAL_Z+Overlap*2]);
			
			
		} // difference
				 
		// Servo mounting bolts
		rotate([0,G_a,0]) translate([0,ServoMount_Y,24*300/180]) rotate([0,-G_a,0]) 
				rotate([0,90,90]) ServoMountHolePattern() translate([0,0,2]) Bolt4Hole();
	} // difference
} // ServoMountAdaptor

//rotate([180,0,0]) ServoMountAdaptor();

module ForwardBoosterLock(){
	// Z=0, BoosterButton center line
	Bottom_Z=-85;
	OAL_Z=135;
	CentralCavity_Y=58;
	CentralCavity2_Y=44;
	ServoMount_Y=-8;
	
	module BD_Holes(){
		translate([0,BP_Body_OD/2-BoosterButtonOA_h,0]) rotate([-90,0,0]) BB_LTP_Hole();
		rotate([0,0,180]) translate([0,BP_Body_OD/2-BoosterButtonOA_h,0]) rotate([-90,0,0]) BB_LTP_Hole();
		
		// d=33 Ball Bearing OD - 4
		rotate([-90,0,0]) cylinder(d=33, h=BP_Body_OD, center=true);
	} // BD_Holes
	
	
	rotate([-90,0,0]) rotate([0,0,90]) BB_LockStop(Len=50, Extra_H=4);
	
	//*
	difference(){
		translate([0,0,Bottom_Z]) Tube(OD=BP_Body_OD, ID=BP_Body_ID, Len=OAL_Z, myfn=$preview? 36:360);
		BD_Holes();
	} // difference
	/**/
	
	difference(){
		union(){
			translate([0,0,-40]) 
				RailButtonPost(OD=BP_Body_OD, MtrTube_OD=BP_MtrTube_OD, H=5.5*25.4/2);
			translate([0,0,-40-25]) rotate([0,0,30]) 
				CenteringRing(OD=BP_Body_OD-1, ID=BP_MtrTube_OD+IDXtra*3, Thickness=5, nHoles=6);
			translate([0,0,-40+20])  rotate([0,0,30]) 
				CenteringRing(OD=BP_Body_OD-1, ID=BP_MtrTube_OD+IDXtra*3, Thickness=5, nHoles=6);
		} // union
		
		BD_Holes();
	} // difference
	
	difference(){
		G_a=22.5;
		
		union(){
			translate([0,0,Bottom_Z+20]) cylinder(d=BP_Body_OD-1, h=OAL_Z-40, $fn=$preview? 90:360);
			
			// Servo bolt bosses
			rotate([0,G_a,0]) translate([0,ServoMount_Y,24*300/180]) rotate([0,-G_a,0]) 
				 rotate([0,90,90]) hull() ServoMountHolePattern() {
					 translate([0,0,0.9]) rotate([180,0,0]) cylinder(d=10,h=1);
					 translate([0,0,-6]) sphere(d=10);
				 }
		} // union
			
		// Servo mounting bolts
		rotate([0,G_a,0]) translate([0,ServoMount_Y,24*300/180]) rotate([0,-G_a,0]) 
				rotate([0,90,90]) ServoMountHolePattern() translate([0,0,2]) Bolt4Hole();
		
		// Clean up base below centering ring
		translate([0,0,Bottom_Z+15-Overlap]) cylinder(d1=BP_Body_OD, d2=BP_Body_OD-50, h=25);
		difference(){
			translate([-BP_Body_OD/2,-CentralCavity2_Y/2,Bottom_Z-Overlap]) 
				cube([BP_Body_OD,CentralCavity2_Y,OAL_Z+Overlap*2]);
			
			// Servo bolt bosses
			rotate([0,G_a,0]) translate([0,ServoMount_Y,24*300/180]) rotate([0,-G_a,0]) 
				 rotate([0,90,90]) hull() ServoMountHolePattern() {
					 translate([0,0,2]) rotate([180,0,0]) cylinder(d=10,h=1);
					 translate([0,0,-6]) sphere(d=10);
				 }
		} // difference
		
		// Servo
		rotate([0,G_a,0]) translate([0,ServoMount_Y,24*300/180]) rotate([0,90-G_a,0]) 
			rotate([-90,0,0]) Servo_HX5010(BottomMount=false,TopAccess=false,Xtra_w=1.2, Xtra_h=1);
		// Servo wires
		translate([16,ServoMount_Y-8,25]) hull(){
			rotate([90,0,0]) cylinder(d=6, h=18);
			translate([0,0,5]) rotate([90,0,0]) cylinder(d=6, h=18);
		} // hull
		
		
		/*
		translate([0,0,27]) cylinder(d1=CentralCavity2_Y, d2=BP_Body_OD-2, h=8+Overlap);
		hull(){
			translate([-BP_Body_OD/2,-CentralCavity_Y/2,Bottom_Z-Overlap])
				cube([BP_Body_OD,CentralCavity_Y,45]);
			translate([-BP_Body_OD/2,-CentralCavity2_Y/2,Bottom_Z+45+CentralCavity_Y-CentralCavity2_Y])
				cube([BP_Body_OD,CentralCavity2_Y,Overlap]);
		} // hull
		/**/
		BD_Holes();
	} // difference
	
	
} // ForwardBoosterLock

//G_a=22.5;
//ForwardBoosterLock();

//translate([0,0,0]) rotate([-90,0,0]) BB_LockShaft(Len=LockShaftLen);
//rotate([0,G_a,0]) translate([0,11,24*300/180]) rotate([-90,0,0]) 
//rotate([0,0,180/24]) 
//BB_Gear();

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
G_a=22.5;
ForwardBoosterLock();
translate([0,0,Overlap])
rotate([0,G_a,0]) translate([0,-8,24*300/180]) rotate([0,-G_a,0]) 
rotate([0,90,90]) ServoMount();
/**/


module UpperFinCan(){
	// Upper Half of Fin Can
	FC2_FinCan(Body_OD=BP_Body_OD, Body_ID=BP_Body_ID, Can_Len=BP_Fin_Root_L+10,
				MotorTube_OD=BP_MtrTube_OD, RailGuide_h=0,
				nFins=nFins, HasIntegratedCoupler=true, Coupler_Len=10, nCouplerBolts=0, HasMotorSleeve=true, HasAftIntegratedCoupler=false,
				Fin_Root_W=BP_Fin_Root_W, Fin_Root_L=BP_Fin_Root_L, Fin_Post_h=BP_Fin_Post_h, Fin_Chamfer_L=BP_Fin_Chamfer_L,
				Cone_Len=0, ThreadedTC=false, Extra_OD=0, RailGuideLen=35, LowerHalfOnly=false, UpperHalfOnly=true, HasWireHoles=false);
} // UpperFinCan

//UpperFinCan();

module LowerFinCan(){
	
	for (j=[0:nBoosters-1])
		rotate([0,0,360/nBoosters*j-180/nFins]) 
		translate([0,BP_Body_OD/2-BoosterButtonOA_h,BP_BoosterButton1_z]) 
		rotate([-90,0,0]) BB_ThrustPoint(BodyTube_OD=BP_Body_OD, BoosterBody_OD=BP_MtrTube_OD);

	difference(){
		union(){
			translate([0,0,BP_BoosterButton1_z+BoosterButtonMajor_d/2+1]) 
				CenteringRing(OD=BP_Body_OD-1, ID=BP_MtrTube_OD+IDXtra*2, Thickness=5);
			translate([0,0,BP_BoosterButton1_z-BoosterButtonMajor_d*2.5-5]) 
				CenteringRing(OD=BP_Body_OD-1, ID=BP_MtrTube_OD+IDXtra*2, Thickness=5);
		} // union
		
		translate([0,0,50]) rotate([0,0,45]) TrapFin2Slots(Tube_OD=BP_Body_OD, nFins=nFins, 	
			Post_h=BP_Fin_Post_h, Root_L=BP_Fin_Root_L, Root_W=BP_Fin_Root_W, Chamfer_L=BP_Fin_Chamfer_L);
	} // difference

	difference(){
		union(){
			rotate([0,0,45]) FC2_FinCan(Body_OD=BP_Body_OD, Body_ID=BP_Body_ID, Can_Len=BP_Fin_Root_L+10,
				MotorTube_OD=BP_MtrTube_OD, RailGuide_h=0,
				nFins=nFins, HasIntegratedCoupler=true, Coupler_Len=10, nCouplerBolts=0, HasMotorSleeve=true, HasAftIntegratedCoupler=false,
				Fin_Root_W=BP_Fin_Root_W, Fin_Root_L=BP_Fin_Root_L, Fin_Post_h=BP_Fin_Post_h, Fin_Chamfer_L=BP_Fin_Chamfer_L,
				Cone_Len=TailCone_Len, ThreadedTC=false, Extra_OD=0, RailGuideLen=35, LowerHalfOnly=true, UpperHalfOnly=false, HasWireHoles=false);
				
			translate([0,0,60]) rotate([0,0,-180/nFins+90]) 
				RailButtonPost(OD=BP_Body_OD, MtrTube_OD=BP_MtrTube_OD, H=5.5*25.4/2);
		} // union
		
		for (j=[0:nBoosters-1])
			rotate([0,0,360/nBoosters*j-180/nFins]) translate([0,BP_Body_OD/2-BoosterButtonOA_h,
					BP_BoosterButton1_z]) rotate([-90,0,0]) BB_ThrustPoint_Hole();
	} // difference

	

} // LowerFinCan

// LowerFinCan();


module BP_Fin(){
	
	TrapFin2(Post_h=10, Root_L=BP_Fin_Root_L, Tip_L=BP_Fin_Tip_L, 
			Root_W=BP_Fin_Root_W, Tip_W=BP_Fin_Tip_W, 
			Span=BP_Fin_Span, Chamfer_L=BP_Fin_Chamfer_L, TipOffset=BP_Fin_TipOffset, 
			Bisect=false, Bisect_X=0);
	
	if ($preview==false){
		translate([-BP_Fin_Root_L/2+10,0,0]) cylinder(d=BP_Fin_Root_W*2.5, h=0.9); // Neg
		translate([BP_Fin_Root_L/2-10,0,0]) cylinder(d=BP_Fin_Root_W*2.5, h=0.9); // Pos
	}
} // BP_Fin

//BP_Fin();



























