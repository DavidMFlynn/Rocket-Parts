// ***********************************
// Project: 3D Printed Rocket
// Filename: RocketOmega.scad
// by David M. Flynn
// Created: 10/10/2022 
// Revision: 0.9.1  11/14/2022
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  5.5" Upscale of Estes Astron Omega
//  Two Stage Rocket with 137mm Body.
//
//  ***** History *****
// 0.9.1  11/14/2022  Worked on booster fin can. 
// 0.9.0  10/10/2022  First code.
//
// ***********************************
//  ***** for STL output *****
//

// *** Cable Puller ***
// ThroughOut();
// rotate([0,90,0]) SpringBody();
// CableRetainer();
// StopAdjuster();
// CageBottom();
// AddServo(); // CageTop w/ servo mount
//
// RocketOmegaFin();
//
// ***********************************
//  ***** Routines *****
//
//
// ***********************************
//  ***** for Viewing *****
//
// 
ShowRocketOmega();
//
// ***********************************
include<TubesLib.scad>
use<SpringThing2.scad>
use<Fairing54.scad>
use<FinCan.scad>
use<AltBay.scad>
use<CablePuller.scad>
use<BatteryHolderLib.scad>

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

Scale=BT137Body_OD/41.58; // Body tube diameters
echo(Scale=Scale);

nFins=4;
// Sustainer Fin
ROmega_Fin_Post_h=10;
ROmega_Fin_Root_L=72*Scale;
ROmega_Fin_Root_W=5*Scale;
ROmega_Fin_Tip_W=2*Scale;
ROmega_Fin_Tip_L=ROmega_Fin_Root_L*0.75;
ROmega_Fin_Span=ROmega_Fin_Root_L*0.75;
ROmega_Fin_TipOffset=0;
ROmega_Fin_Chamfer_L=ROmega_Fin_Root_W*3;

// Booster Fin
ROmegaBooster_Fin_Post_h=15;
ROmegaBooster_Fin_Root_L=90*Scale;
ROmegaBooster_Fin_Root_W=5.7*Scale;
ROmegaBooster_Fin_Tip_W=2*Scale;
ROmegaBooster_Fin_Tip_L=ROmegaBooster_Fin_Root_L*0.75;
ROmegaBooster_Fin_Span=ROmegaBooster_Fin_Root_L*0.75;
ROmegaBooster_Fin_TipOffset=0;
ROmegaBooster_Fin_Chamfer_L=ROmegaBooster_Fin_Root_W*3;
echo(ROmegaBooster_Fin_Root_L=ROmegaBooster_Fin_Root_L);
echo(ROmegaBooster_Fin_Span=ROmegaBooster_Fin_Span);

ROmega_Body_OD=BT137Body_OD;
ROmega_Body_ID=BT137Body_ID;
ROmega_Coupler_OD=BT137Coupler_OD;
ROmega_Coupler_ID=BT137Coupler_ID;
ROmega_MtrTube_OD=PML75Body_OD;
ROmega_MtrTube_ID=PML75Body_ID;
ROmega_MtrCoupleTube_OD=PML75Coupler_OD;
ROmega_MtrCoupleTube_ID=PML75Coupler_ID;


EBay_Len=130;
Booster_Body_Len=5*25.4*Scale;
//echo(Booster_Body_Len=Booster_Body_Len);

// Fairing Overrides
Fairing_OD=PML98Body_OD;
FairingWall_T=2.2;
Fairing_ID=Fairing_OD-FairingWall_T*2;

NoseconeSep_Z=0; // This much of the nosecone becomes part of the fairing.
NC_Len=350;
NC_Tip_r=5;
NC_Base=5;
NC_Lock_H=5;

//Fairing_Len=180; // Body of the fairing.

//BodyTubeLen=36*25.4;

module ShowRocketOmega(){
	
	//*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j])
		translate([ROmega_Body_OD/2-ROmega_Fin_Post_h, 0, Booster_Body_Len+ROmega_Fin_Root_L/2+10]) 
			rotate([0,90,0]) color("White") RocketOmegaFin();
	/**/
	translate([0,0,Booster_Body_Len-40]) LowerFinCan();
	
	translate([0,0,ROmegaBooster_Fin_Root_L+60]) BoosterUpperFinCan();
	//*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j])
		translate([ROmega_Body_OD/2-ROmega_Fin_Post_h, 0, ROmegaBooster_Fin_Root_L/2+10]) 
			rotate([0,90,0]) color("White") RocketOmegaBoosterFin();
	/**/
} // ShowRocketOmega

//ShowRocketOmega();

/*
ShowSpringThing(Tube_OD=ROmega_Body_OD, Tube_ID=ROmega_Body_ID, 
				CouplerTube_OD=ROmega_Coupler_OD, CouplerTube_ID=ROmega_Coupler_ID,
				InnerTube_OD=ROmega_MtrTube_OD, InnerTube_ID=ROmega_MtrTube_ID, 
				InnerCouplerTube_OD=ROmega_MtrCoupleTube_OD, InnerCouplerTube_ID=ROmega_MtrCoupleTube_ID);
/**/

module LowerFinCan(){
	RailGuide_Z=110;
	
	difference(){
		FinCan3(Tube_OD=ROmega_Body_OD, Tube_ID=ROmega_Body_ID, MtrTube_OD=ROmega_MtrTube_OD+IDXtra*2, nFins=nFins, 
			Post_h=ROmega_Fin_Post_h, Root_L=ROmega_Fin_Root_L, Root_W=ROmega_Fin_Root_W, 
			Chamfer_L=ROmega_Fin_Chamfer_L, 
			HasTailCone=false,
					MtrRetainer_OD=ROmega_MtrTube_OD+5,
					MtrRetainer_L=20,
					MtrRetainer_Inset=7); // Lower Half of Fin Can
		
		translate([0,0,RailGuide_Z]) rotate([0,0,-90-180/nFins]) 
			translate([0,ROmega_Body_OD/2+2,0]) RailGuideBoltPattern(BoltSpace=12.7) Bolt6Hole();
		
		// Booster attachment?
		//translate([0,0,-Overlap]) cylinder(d=ROmega_Body_OD+1,40+Overlap);
	} // difference
		

	//*
	difference(){
		translate([0,0,RailGuide_Z]) rotate([0,0,-90-180/nFins]) 
			RailGuidePost(OD=ROmega_Body_OD, MtrTube_OD=ROmega_MtrTube_OD+IDXtra*2, H=ROmega_Body_OD/2+2, TubeLen=70, Length = 40, BoltSpace=12.7);
		
		translate([0,0,RailGuide_Z]) TrapFin2Slots(Tube_OD=ROmega_Body_OD, nFins=nFins, 	
			Post_h=ROmega_Fin_Post_h, Root_L=ROmega_Fin_Root_L, Root_W=ROmega_Fin_Root_W, Chamfer_L=ROmega_Fin_Chamfer_L);
	} // difference
	/**/
} // LowerFinCan

// translate([0,0,-40]) LowerFinCan();


module RocketOmegaFin(){
	TrapFin2(Post_h=ROmega_Fin_Post_h, Root_L=ROmega_Fin_Root_L, Tip_L=ROmega_Fin_Tip_L, 
			Root_W=ROmega_Fin_Root_W, Tip_W=ROmega_Fin_Tip_W, 
			Span=ROmega_Fin_Span, Chamfer_L=ROmega_Fin_Chamfer_L,
					TipOffset=ROmega_Fin_TipOffset);

	if ($preview==false){
		translate([-ROmega_Fin_Root_L/2+10,0,0]) cylinder(d=ROmega_Fin_Root_W*2.5, h=0.9); // Neg
		translate([ROmega_Fin_Root_L/2-10,0,0]) cylinder(d=ROmega_Fin_Root_W*2.5, h=0.9); // Pos
	}
} // RocketOmegaFin

// RocketOmegaFin();



module BoosterUpperFinCan(){
	// Upper Half of Fin Can
	CablePuller_Z=-50-ROmegaBooster_Fin_Root_L/4;
	WirePath_Z=CablePuller_Z;
	
	difference(){
		rotate([180,0,0]) 
			FinCan3(Tube_OD=ROmega_Body_OD, Tube_ID=ROmega_Body_ID, 
				MtrTube_OD=ROmega_MtrTube_OD+IDXtra*2, nFins=nFins,
				Post_h=ROmegaBooster_Fin_Post_h, Root_L=ROmegaBooster_Fin_Root_L, 
				Root_W=ROmegaBooster_Fin_Root_W, 
				Chamfer_L=ROmegaBooster_Fin_Chamfer_L, HasTailCone=false); 
		
		// Cable Pullers
		translate([0,0,CablePuller_Z]) rotate([0,0,90-180/nFins]) 
			CP_BayFrameHole(Tube_OD=ROmega_Body_OD);
		translate([0,0,CablePuller_Z]) rotate([0,0,90-180/nFins+360/nFins]) 
			CP_BayFrameHole(Tube_OD=ROmega_Body_OD);
		
		// Altimeter
		translate([0,0,CablePuller_Z]) rotate([0,0,90-180/nFins+360/nFins*2]) 
		  Alt_BayFrameHole(Tube_OD=ROmega_Body_OD);
		
		// Wire Paths
		for (j=[0:nFins-1]) rotate([0,0,360/nFins*j])
			translate([ROmega_MtrTube_OD/2+5,0,WirePath_Z]) hull(){
				rotate([90,0,0]) cylinder(d=7, h=30, center=true);
				translate([0,0,10]) rotate([90,0,0]) cylinder(d=7, h=30, center=true);
			}
	} // difference
	
	// Cable Pullers
	translate([0,0,CablePuller_Z]) rotate([0,0,90-180/nFins]) 
		CP_BayDoorFrame(Tube_OD=ROmega_Body_OD, ShowDoor=false);
	translate([0,0,CablePuller_Z]) rotate([0,0,90-180/nFins+360/nFins]) 
		CP_BayDoorFrame(Tube_OD=ROmega_Body_OD, ShowDoor=false);
	
	// Altimeter
	translate([0,0,CablePuller_Z]) rotate([0,0,90-180/nFins+360/nFins*2])
		Alt_BayDoorFrame(Tube_OD=ROmega_Body_OD, Tube_ID=ROmega_Body_ID, ShowDoor=false);
} // BoosterUpperFinCan

//BoosterUpperFinCan();


module RocketOmegaBoosterFin(){
	TrapFin2(Post_h=ROmegaBooster_Fin_Post_h, Root_L=ROmegaBooster_Fin_Root_L, Tip_L=ROmegaBooster_Fin_Tip_L, 
			Root_W=ROmegaBooster_Fin_Root_W, Tip_W=ROmegaBooster_Fin_Tip_W, 
			Span=ROmegaBooster_Fin_Span, Chamfer_L=ROmegaBooster_Fin_Chamfer_L,
					TipOffset=ROmegaBooster_Fin_TipOffset);

	if ($preview==false){
		translate([-ROmegaBooster_Fin_Root_L/2+10,0,0]) cylinder(d=ROmegaBooster_Fin_Root_W*2.5, h=0.9); // Neg
		translate([ROmegaBooster_Fin_Root_L/2-10,0,0]) cylinder(d=ROmegaBooster_Fin_Root_W*2.5, h=0.9); // Pos
	}
} // RocketOmegaBoosterFin

// RocketOmegaBoosterFin();




































