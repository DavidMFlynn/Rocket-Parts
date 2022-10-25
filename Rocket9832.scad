// ***********************************
// Project: 3D Printed Rocket
// Filename: Rocket9832.scad
// by David M. Flynn
// Created: 10/16/2022 
// Revision: 0.9.2  10/18/2022
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  98mm Body 3 Fins 2 Stages
//  Two Stage Rocket.
//
//  Warning! This is a complex rocket, skill level 11!
//  The only pyrotecnics used in this rocket are the motors.
//  Maximum motors J800T-P and K185W-P. 
//  Threaded forward closures are required to connect the shock cord to. 
//
//  The Sustainer has a Mission Control V3 for detection of booster separation,
//  motor ignition if staged, apogee deployment and main deployment. Uses two 
//  cable pullers to activate a Stager for spring loaded
//  drogue deployment and a fairing for main deployment.
//
//  The Booster has a Mission Control V3 for stage separation and
//  apogee deployment using two cable pullers. Has a Stager and SpringThing.
//
//  ***** History *****
// 
// 0.9.2  10/18/2022  BoosterLowerFinCan
// 0.9.1  10/17/2022  BoosterUpperFinCan
// 0.9.0  10/16/2022  First code.
//
// ***********************************
//  ***** for STL output *****
//
/*
FairingConeOGive(Fairing_OD=R9832_Body_OD, 
					FairingWall_T=FairingWall_T,
					NC_Base=NC_Base, 
					NC_Len=NC_Len, 
					NC_Wall_t=NC_Wall_t,
					NC_Tip_r=NC_Tip_r,
					Cut_Z=180, LowerPortion=true);
/**/
// NoseLockRing(Fairing_ID =Fairing_ID);
//
//
// *** Fairing ***
/*
F54_FairingHalf(IsLeftHalf=true, 
				Fairing_OD=Fairing_OD,
				Wall_T=FairingWall_T,
				Len=Fairing_Len);
/**/
/*
F54_FairingHalf(IsLeftHalf=false, 
				Fairing_OD=Fairing_OD,
				Wall_T=FairingWall_T,
				Len=Fairing_Len);
/**/
//F54_SpringEndCap();
//
//
// *** Electronics Bay ***
// R98_Electronics_Bay();
// FairingBaseBulkPlate(Tube_ID=R9832_Body_ID, Fairing_ID=Fairing_ID, ShockCord_a=-100);
// AltDoor54(Tube_OD=R9832_Body_OD);
// DoubleBatteryHolder(Tube_ID=PML98Body_ID, HasBoltHoles=true); // oops!
//
// ------------
// *** Cable Puller, 4 Req. ***
// ThroughOut();
// rotate([0,90,0]) SpringBody();
// CableRetainer();
// StopAdjuster();
// CageBottom();
// AddServo(); // CageTop w/ servo mount
/*
	translate([0,0,CP_SpringBody_YZ/2+2.5]) rotate([180,0,0]){ 
		CageTop();
		BellCrankTriggerBearingHolder();}
/**/
// rotate([180,0,0]) TriggerBellCrank();
// ------------
//
// rotate([180,0,0]) Drogue_Cup();
//
// UpperFinCan();
// Rocket9832Fin();
// rotate([180,0,0]) LowerFinCan();
//
// *** Booster Parts ***
//
// --------------
//  ** Stager Parts, top of booster **
// rotate([180,0,0]) Stager_Cup(Tube_OD=R9832_Body_OD, ID=78, nLocks=2, BoltsOn=true);
// rotate([-90,0,0]) Stager_LockRod(Adj=0); // print 4
//
// Stager_Saucer(Tube_OD=R9832_Body_OD, nLocks=2); // Bolts on
// Stager_BearingBlock(); // print 4
// rotate([0,90,0]) Stager_PushUP(); // print 2
// rotate([0,-90,0]) mirror([1,0,0]) Stager_PushUP(); // print 2
// Stager_SpringStop(); // print 4
// 
// Stager_Mech(Tube_OD=R9832_Body_OD, nLocks=2, Skirt_ID=R9832_Body_ID, Skirt_Len=30, KeyOffset_a=90);
// Stager_TriggerPlateB(Tube_OD=R9832_Body_OD); // print 2
// Stager_InnerRace(Tube_OD=R9832_Body_OD, nLocks=2);
// Stager_BallSpacer(Tube_OD=R9832_Body_OD); // print 2
// CableRedirect(Tube_OD=R9832_Body_OD, Skirt_ID=R9832_Body_ID, Tube_ID=PML98Coupler_ID, InnerTube_OD=R9832_BoosterMtrTube_OD);
// CableEndAndStop(Tube_OD=R9832_Body_OD);
// -------------
//
// BoosterUpperFinCan();
// Rocket9832BoosterFin();
// rotate([180,0,0]) BoosterLowerFinCan();
// Batt_Door(Tube_OD=R9832_Body_OD, HasSwitch=false);
// Batt_Door(Tube_OD=R9832_Body_OD, HasSwitch=true);
//
// ***********************************
//  ***** Routines *****
//
//
// ***********************************
//  ***** for Viewing *****
//
// ShowRocket9832();
//
// ***********************************
include<Fairing54.scad>
include<FinCan.scad>
include<StagerLib.scad>
include<AltBay.scad>
include<CablePuller.scad>
include<BatteryHolderLib.scad>

//also included
 //include<NoseCone.scad>
 //include<ChargeHolder.scad>
 //include<CablePuller.scad>
 //include<FairingJointLib.scad>
 //include<RailGuide.scad>
 //include<Fins.scad>
 //include<TubesLib.scad>
 //include<BearingLib.scad>
 //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

nFins=3;

// Sustainer Fin
ExtraForward=0;
R9832_Fin_Post_h=10;
R9832_Fin_Root_L=200+ExtraForward;
R9832_Fin_Root_W=12;
R9832_Fin_Tip_W=5;
R9832_Fin_Tip_L=(R9832_Fin_Root_L-ExtraForward)*0.75;
R9832_Fin_Span=(R9832_Fin_Root_L-ExtraForward)*0.75;
R9832_Fin_TipOffset=ExtraForward/2;
R9832_Fin_Chamfer_L=R9832_Fin_Root_W*2.5;

// Booster Fin
R9832Booster_Fin_Post_h=10;
R9832Booster_Fin_Root_L=240;
R9832Booster_Fin_Root_W=14;
R9832Booster_Fin_Tip_W=5;
R9832Booster_Fin_Tip_L=R9832Booster_Fin_Root_L*0.75;
R9832Booster_Fin_Span=R9832Booster_Fin_Root_L*0.75;
R9832Booster_Fin_TipOffset=0;
R9832Booster_Fin_Chamfer_L=R9832Booster_Fin_Root_W*2.5;

R9832_Body_OD=PML98Body_OD;
R9832_Body_ID=PML98Body_ID;
R9832_Coupler_ID=PML98Coupler_ID;
R9832_MtrTube_OD=PML54Body_OD;
R9832_MtrTube_ID=PML54Body_ID;
R9832_BoosterMtrTube_OD=BT54Mtr_OD;

EBay_Len=130;
//Booster_Body_Len=R9832Booster_Fin_Root_L+60+116.5; // minimum length J460T
Booster_Body_Len=R9832Booster_Fin_Root_L+60+116.5+90; // J800T
//echo(Booster_Body_Len=Booster_Body_Len);

// Fairing Overrides
Fairing_OD=PML98Body_OD;
FairingWall_T=2.2;
Fairing_ID=Fairing_OD-FairingWall_T*2;
Fairing_Len=180; // Body of the fairing.

NoseconeSep_Z=0; // This much of the nosecone becomes part of the fairing.
NC_Len=350;
NC_Tip_r=5;
NC_Base=5;
NC_Lock_H=5;


//BodyTubeLen=36*25.4;
module ShowMotorK185W(){
	Casing_Len=296+84.5;
	
	color("Black") cylinder(d=57, h=10);
	translate([0,0,10]) color("Red") cylinder(d=54, h=Casing_Len);
	translate([0,0,10+Casing_Len]) color("Black"){
		cylinder(d=54, h=3);
		cylinder(d=39, h=23);
		cylinder(d=20, h=30);
	}
} // ShowMotorK185W

// ShowMotorK185W();

module ShowMotorJ800T(){
	Casing_Len=296;
	
	color("Black") cylinder(d=57, h=10);
	translate([0,0,10]) color("Red") cylinder(d=54, h=Casing_Len);
	translate([0,0,10+Casing_Len]) color("Black"){
		cylinder(d=54, h=3);
		cylinder(d=39, h=23);
		cylinder(d=20, h=30);
	}
} // ShowMotorJ800T

// ShowMotorJ800T();

module ShowMotorJ460T(){
	Casing_Len=211;
	
	color("Black") cylinder(d=57, h=10);
	translate([0,0,10]) color("Red") cylinder(d=54, h=Casing_Len);
	translate([0,0,10+Casing_Len]) color("Black"){
		cylinder(d=54, h=3);
		cylinder(d=39, h=23);
		cylinder(d=20, h=30);
	}
} // ShowMotorJ460T

//ShowMotorJ460T();

module ShowChuteTube(){
	Len=7*25.4;
	
	//difference(){
		cylinder(d=54, h=Len);
		
	//} // difference
} // ShowChuteTube

//ShowChuteTube();

module ShowBooster9832(){
	
	translate([0,0,Booster_Body_Len-35]) color("Blue") Stager_Saucer(Tube_OD=R9832_Body_OD, nLocks=2);
	translate([0,0,Booster_Body_Len-35]) Stager_Mech(Tube_OD=R9832_Body_OD, nLocks=2, Skirt_ID=R9832_Body_ID, Skirt_Len=20);
	
	translate([0,0,290]) ShowChuteTube();
	
	translate([0,0,R9832Booster_Fin_Root_L+60]) BoosterUpperFinCan();
	
	//*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j])
		translate([R9832_Body_OD/2-R9832_Fin_Post_h, 0, R9832Booster_Fin_Root_L/2+10]) 
			rotate([0,90,0]) color("Orange") Rocket9832BoosterFin();
	/**/
	
	translate([0,0,-40]) color("Green") BoosterLowerFinCan();
	
	//translate([0,0,-40]) ShowMotorJ460T();
	translate([0,0,-40]) ShowMotorJ800T();
} // ShowBooster9832

FinCanExTube_Len=105;

module ShowRocket9832(){
	TopOfFinCan_Z=Booster_Body_Len-40+R9832_Fin_Root_L+100+150;
	
	translate([0,0,TopOfFinCan_Z]) rotate([180,0,0]) Drogue_Cup();
	translate([0,0,TopOfFinCan_Z-60]) rotate([180,0,0]) 
		color("LightBlue") Tube(OD=R9832_Body_OD, ID=R9832_Body_ID, Len=FinCanExTube_Len, myfn=$preview? 36:360);
	
	translate([0,0,Booster_Body_Len-40+R9832_Fin_Root_L+100]) UpperFinCan();
	//*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j])
		translate([R9832_Body_OD/2-R9832_Fin_Post_h, 0, Booster_Body_Len+R9832_Fin_Root_L/2+10]) 
			rotate([0,90,0]) color("Orange") Rocket9832Fin();
	/**/
	
	//*
	translate([0,0,Booster_Body_Len-40]) {
		color("Tan") LowerFinCan();
		translate([0,0,5]) Stager_Cup(Tube_OD=R9832_Body_OD, ID=78, nLocks=2);
	}
	/**/
	
	translate([0,0,Booster_Body_Len-40]) ShowMotorK185W();
	
	ShowBooster9832();
	
} // ShowRocket9832

//ShowRocket9832();


module R98_Electronics_Bay(){
	
	Electronics_Bay(Tube_OD=PML98Body_OD, Tube_ID=PML98Body_ID, Fairing_ID=Fairing_ID, 
				EBay_Len=EBay_Len, HasCablePuller=true);
	
	TubeStop(InnerTubeID=PML98Coupler_ID, OuterTubeOD=PML98Body_OD, myfn=$preview? 36:360);
	
	translate([0,0,30]) DoubleBatteryHolder(Tube_ID=PML98Body_ID, HasBoltHoles=false);
	
} // R98_Electronics_Bay

//R98_Electronics_Bay();

module Drogue_Cup(){
	nHoles=14;
	Hole_d=8;
	
	Stager_Cup(Tube_OD=R9832_Body_OD, ID=78, nLocks=2, BoltsOn=false);
	/*
	difference(){
		union(){
			Stager_Cup(Tube_OD=R9832_Body_OD, ID=78, nLocks=2, BoltsOn=false);
			translate([0,0,21-Overlap]) cylinder(d=R9832_Body_OD-1,h=12);
		} // union
		
		// holes
		for (j=[0:nHoles-1]) rotate([0,0,180/nHoles+360/nHoles*j]) translate([0,R9832_Coupler_ID/2-Hole_d/2,3]){
			cylinder(d1=1, d2=Hole_d, h=4);
			translate([0,0,4-Overlap]) cylinder(d=Hole_d, h=30);
		}
		translate([0,0,21-Overlap*2]) cylinder(d1=78, d2=R9832_Coupler_ID-1 ,h=12+Overlap*3);
	} // difference
	/**/
	
	Tube(OD=R9832_Body_OD, ID=R9832_Body_ID, Len=60, myfn=$preview? 36:360);
	
} // Drogue_Cup

//Drogue_Cup();

module UpperFinCan(){
	// Upper Half of Fin Can
	
	
		rotate([180,0,0]) 
			FinCan3(Tube_OD=R9832_Body_OD, Tube_ID=R9832_Body_ID, 
				MtrTube_OD=R9832_MtrTube_OD+IDXtra*2, nFins=nFins,
				Post_h=R9832_Fin_Post_h, Root_L=R9832_Fin_Root_L, 
				Root_W=R9832_Fin_Root_W, 
				Chamfer_L=R9832_Fin_Chamfer_L, HasTailCone=false); 
		
	
	
} // UpperFinCan

//UpperFinCan();

module LowerFinCan(){
	RailGuide_Z=110;
	
	difference(){
		union(){
			FinCan3(Tube_OD=R9832_Body_OD, Tube_ID=R9832_Body_ID, 
				MtrTube_OD=R9832_MtrTube_OD+IDXtra*2, nFins=nFins, 
				Post_h=R9832_Fin_Post_h, Root_L=R9832_Fin_Root_L, Root_W=R9832_Fin_Root_W, 
				Chamfer_L=R9832_Fin_Chamfer_L, 
				HasTailCone=true,
						MtrRetainer_OD=R9832_MtrTube_OD+5,
						MtrRetainer_L=20,
						MtrRetainer_Inset=7); // Lower Half of Fin Can
			
			
			
			
			// Stager cup mounts here
			translate([0,0,15])
			difference(){
				cylinder(d=R9832_Body_OD, h=30, $fn=$preview? 90:360);
				translate([0,0,-Overlap]) cylinder(d=72, h=30+Overlap*2);
			} // difference
		} // union
		
		// Igniter wirs
			rotate([0,0,180/nFins]) translate([R9832_MtrTube_OD/2+8,0,0]) 
				cylinder(d=7, h=R9832_Fin_Root_L);
		
		translate([0,0,RailGuide_Z]) rotate([0,0,-90-180/nFins]) 
			translate([0,R9832_Body_OD/2+2,0]) RailGuideBoltPattern(BoltSpace=12.7) Bolt6Hole();
		
		// Booster attachment
		translate([0,0,8]) Stager_CupHoles(Tube_OD=R9832_Body_OD, ID=78, nLocks=2);
	} // difference
		

	//*
	// Rail Guide
	difference(){
		translate([0,0,RailGuide_Z]) rotate([0,0,-90-180/nFins]) 
			//RailButtonPost(OD=R98_Body_OD, MtrTube_OD=R98_MtrTube_OD, H=R98_Body_OD/2+5, Len=30);
			RailGuidePost(OD=R9832_Body_OD, MtrTube_OD=R9832_MtrTube_OD+IDXtra*2, H=R9832_Body_OD/2+2, TubeLen=70, Length = 40, BoltSpace=12.7);
		
		translate([0,0,RailGuide_Z]) TrapFin2Slots(Tube_OD=R9832_Body_OD, nFins=nFins, 	
			Post_h=R9832_Fin_Post_h, Root_L=R9832_Fin_Root_L, Root_W=R9832_Fin_Root_W, Chamfer_L=R9832_Fin_Chamfer_L);
	} // difference
	/**/
} // LowerFinCan

// translate([0,0,-40]) LowerFinCan();


module Rocket9832Fin(){
	TrapFin2(Post_h=R9832_Fin_Post_h, Root_L=R9832_Fin_Root_L, Tip_L=R9832_Fin_Tip_L, 
			Root_W=R9832_Fin_Root_W, Tip_W=R9832_Fin_Tip_W, 
			Span=R9832_Fin_Span, Chamfer_L=R9832_Fin_Chamfer_L,
					TipOffset=R9832_Fin_TipOffset);

	if ($preview==false){
		translate([-R9832_Fin_Root_L/2+10,0,0]) cylinder(d=R9832_Fin_Root_W*2.5, h=0.9); // Neg
		translate([R9832_Fin_Root_L/2-10,0,0]) cylinder(d=R9832_Fin_Root_W*2.5, h=0.9); // Pos
	}
} // Rocket9832Fin

// Rocket9832Fin();



module BoosterUpperFinCan(){
	// Upper Half of Fin Can
	
	CablePuller_Z=-R9832Booster_Fin_Root_L/2+16;
	
	difference(){
		rotate([180,0,0]) 
			FinCan3(Tube_OD=R9832_Body_OD, Tube_ID=R9832_Body_ID, 
				MtrTube_OD=R9832_BoosterMtrTube_OD+IDXtra*2, nFins=nFins,
				Post_h=R9832Booster_Fin_Post_h, Root_L=R9832Booster_Fin_Root_L, 
				Root_W=R9832Booster_Fin_Root_W, 
				Chamfer_L=R9832Booster_Fin_Chamfer_L, HasTailCone=false); 
		
		// Cable Pullers
		translate([0,0,CablePuller_Z]) rotate([0,0,90-180/nFins]) 
			CP_BayFrameHole(Tube_OD=R9832_Body_OD);
		translate([0,0,CablePuller_Z]) rotate([0,0,90-180/nFins+360/nFins]) 
			CP_BayFrameHole(Tube_OD=R9832_Body_OD);
		
		// Altimeter
		translate([0,0,CablePuller_Z]) rotate([0,0,90-180/nFins+360/nFins*2]) 
		  Alt_BayFrameHole(Tube_OD=R9832_Body_OD);

	} // difference
	
	// Cable Pullers
	translate([0,0,CablePuller_Z]) rotate([0,0,90-180/nFins]) 
		CP_BayDoorFrame(Tube_OD=R9832_Body_OD, Tube_ID=R9832_Body_ID, ShowDoor=false);
	translate([0,0,CablePuller_Z]) rotate([0,0,90-180/nFins+360/nFins]) 
		CP_BayDoorFrame(Tube_OD=R9832_Body_OD, Tube_ID=R9832_Body_ID, ShowDoor=false);
	
	// Altimeter
	translate([0,0,CablePuller_Z]) rotate([0,0,90-180/nFins+360/nFins*2])
		Alt_BayDoorFrame(Tube_OD=R9832_Body_OD, Tube_ID=R9832_Body_ID, ShowDoor=false);
	
	// Battery holder for altimeter
	//SingleBatteryPocket();

} // BoosterUpperFinCan

//BoosterUpperFinCan();


module Rocket9832BoosterFin(){
	TrapFin2(Post_h=R9832Booster_Fin_Post_h, Root_L=R9832Booster_Fin_Root_L, Tip_L=R9832Booster_Fin_Tip_L, 
			Root_W=R9832Booster_Fin_Root_W, Tip_W=R9832Booster_Fin_Tip_W, 
			Span=R9832Booster_Fin_Span, Chamfer_L=R9832Booster_Fin_Chamfer_L,
					TipOffset=R9832Booster_Fin_TipOffset);

	if ($preview==false){
		translate([-R9832Booster_Fin_Root_L/2+10,0,0]) cylinder(d=R9832Booster_Fin_Root_W*2.5, h=0.9); // Neg
		translate([R9832Booster_Fin_Root_L/2-10,0,0]) cylinder(d=R9832Booster_Fin_Root_W*2.5, h=0.9); // Pos
	}
} // Rocket9832BoosterFin

// Rocket9832BoosterFin();


module BoosterLowerFinCan(){
	// Upper Half of Fin Can
	BattDoor_Z=128;
	BattSwDoor_Z=115;
	
	RailGuide_Z=60;
	
	difference(){
		
		FinCan3(Tube_OD=R9832_Body_OD, Tube_ID=R9832_Body_ID, 
			MtrTube_OD=R9832_BoosterMtrTube_OD+IDXtra*2, nFins=nFins,
			Post_h=R9832Booster_Fin_Post_h, Root_L=R9832Booster_Fin_Root_L, 
			Root_W=R9832Booster_Fin_Root_W, 
			Chamfer_L=R9832Booster_Fin_Chamfer_L, HasTailCone=true,
					MtrRetainer_OD=63,
					MtrRetainer_L=14,
					MtrRetainer_Inset=7); 
		
		// Wire Paths
		for (j=[0:nFins-1]) rotate([0,0,360/nFins*j])
			translate([R9832_BoosterMtrTube_OD/2+5,0,R9832Booster_Fin_Root_L/2])
				rotate([90,0,0]) cylinder(d=7, h=22, center=true);
		
		translate([0,0,BattDoor_Z]) rotate([0,0,90-180/nFins]) 
			Batt_BayFrameHole(Tube_OD=R9832_Body_OD, HasSwitch=false);
		
		translate([0,0,BattSwDoor_Z]) rotate([0,0,90-180/nFins+360/nFins]) 
			Batt_BayFrameHole(Tube_OD=R9832_Body_OD, HasSwitch=true);
		translate([0,0,BattSwDoor_Z]) rotate([0,0,90-180/nFins+360/nFins*2]) 
			Batt_BayFrameHole(Tube_OD=R9832_Body_OD, HasSwitch=true);
		
		translate([0,0,RailGuide_Z]) rotate([0,0,-90-180/nFins]) 
			translate([0,R9832_Body_OD/2+2,0]) RailGuideBoltPattern(BoltSpace=12.7) Bolt6Hole();
	} // difference
	
	
	translate([0,0,BattDoor_Z]) rotate([0,0,90-180/nFins]) 
		Batt_BayDoorFrame(Tube_OD=PML98Body_OD, Tube_ID=PML98Body_ID, HasSwitch=false, ShowDoor=false);
	
	translate([0,0,BattSwDoor_Z]) rotate([0,0,90-180/nFins+360/nFins]) 
		Batt_BayDoorFrame(Tube_OD=PML98Body_OD, Tube_ID=PML98Body_ID, HasSwitch=true, ShowDoor=true);
	translate([0,0,BattSwDoor_Z]) rotate([0,0,90-180/nFins+360/nFins*2]) 
		Batt_BayDoorFrame(Tube_OD=PML98Body_OD, Tube_ID=PML98Body_ID, HasSwitch=true, ShowDoor=false);
	
	//*
	// Rail Guide
	difference(){
		translate([0,0,RailGuide_Z]) rotate([0,0,-90-180/nFins]) 
			RailGuidePost(OD=R9832_Body_OD, MtrTube_OD=R9832_BoosterMtrTube_OD+IDXtra*2, 
				H=R9832_Body_OD/2+2, TubeLen=40, Length = 30, BoltSpace=12.7);
		
		translate([0,0,RailGuide_Z]) TrapFin2Slots(Tube_OD=R9832_Body_OD, nFins=nFins, 	
			Post_h=R9832Booster_Fin_Post_h, Root_L=R9832Booster_Fin_Root_L, 
			Root_W=R9832Booster_Fin_Root_W, Chamfer_L=R9832_Fin_Chamfer_L);
		
		translate([0,0,BattSwDoor_Z]) rotate([0,0,90-180/nFins+360/nFins]) 
			Batt_BayFrameHole(Tube_OD=R9832_Body_OD, HasSwitch=true);
		translate([0,0,BattSwDoor_Z]) rotate([0,0,90-180/nFins+360/nFins*2]) 
			Batt_BayFrameHole(Tube_OD=R9832_Body_OD, HasSwitch=true);
	} // difference
	/**/
} // BoosterUpperFinCan

//BoosterLowerFinCan();

//Batt_Door(Tube_OD=PML98Body_OD, HasSwitch=false);


































