// ***********************************
// Project: 3D Printed Rocket
// Filename: Rocket75.scad
// by David M. Flynn
// Created: 9/11/2022 
// Revision: 1.0  7/15/2024
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  Rocket with 75mm Body and 54mm motor. 
//
//  ***** History *****
// 
// 1.0    7/15/2024  Updated to current Libs. Now uses petal deployer in place of fairing.
// 0.9.2  5/7/2023   Updated.
// 0.9.1  9/28/2022  Adding last couple of parts.
// 0.9.0  9/11/2022  First code.
//
// ***********************************
//  ***** for STL output *****
//
//  *** Nosecode ***
/*
BluntOgiveNoseCone(ID=R75_Body_ID, OD=R75_Body_OD, L=NC_Len, Base_L=NC_Base, nRivets=3, Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=0, Transition_OD=R75_Body_OD, LowerPortion=false);
/**/
//
// NC_ShockcordRing75(Body_OD=R75_Body_OD, Body_ID=R75_Body_ID, NC_Base_L=NC_Base);
//
//  *** Petal Deployer ***
//
// SE_SlidingSpringMiddle(OD=R75_Coupler_OD, nRopes=3, SliderLen=40, SpLen=40, SpringStop_Z=20);
//
/*
 PD_NC_PetalHub(OD=R75_Coupler_OD, nPetals=3, nRopes=3, ShockCord_a=-1, HasThreadedCore=false, ST_DSpring_ID=SE_Spring_CS4323_ID(), ST_DSpring_OD=SE_Spring_CS4323_OD(), CouplerTube_ID=0);

/**/
// rotate([180,0,0]) PD_Petals(OD=R75_Coupler_OD, Len=200, nPetals=3, Wall_t=1.8, AntiClimber_h=4, HasLocks=false, Lock_Span_a=0);
// rotate([-90,0,0]) PD_PetalSpringHolder();
//
//
//  *** Ball Lock ***
//
// STB_LockDisk(BallPerimeter_d=R75_Body_OD, nLockBalls=nLockBalls, HasLargeInnerBearing=false);
// 
/*
rotate([180,0,0]) STB_BallRetainerTop(BallPerimeter_d=R75_Body_OD, Outer_OD=R75_Body_OD, Body_OD=R75_Body_ID, nLockBalls=nLockBalls, 
			HasIntegratedCouplerTube=true, Body_ID=R75_Body_ID, HasSecondServo=false, UsesBigServo=false, 
			Engagement_Len=20, HasLargeInnerBearing=false);
/**/
// STB_BallRetainerBottom(BallPerimeter_d=R75_Body_OD, Body_OD=R75_Body_ID, nLockBalls=nLockBalls, HasSpringGroove=false, Engagement_Len=20, HasLargeInnerBearing=false);
// rotate([180,0,0]) STB_TubeEnd(BallPerimeter_d=R75_Body_OD, nLockBalls=nLockBalls, Body_OD=R75_Body_OD, Body_ID=R75_Body_ID, Skirt_Len=20);
//
//  *** Electronics Bay ***
//
// EB_Electronics_Bay(Tube_OD=R75_Body_OD, Tube_ID=R75_Body_ID, Len=162, nBolts=3, BoltInset=7.5, ShowDoors=false, HasSecondBattDoor=false);
// rotate([-90,0,0]) EB_AltDoor(Tube_OD=R75_Body_OD);
// rotate([-90,0,0]) EB_BattDoor(Tube_OD=R75_Body_OD, HasSwitch=false);
// rotate([-90,0,0]) EB_BattDoor(Tube_OD=R75_Body_OD, HasSwitch=true);
//
//
// R75_UpperRailButtonPost();
//
//  *** Fin Can ***
// UpperFinCan();
// Rocket75Fin();
// rotate([180,0,0]) LowerFinCan();
//
// ***********************************
//  ***** Routines *****
//
//
// ***********************************
//  ***** for Viewing *****
//
// ShowRocket75();
//
// ***********************************

include<CommonStuffSAEmm.scad>
use<NoseCone.scad>
use<SpringEndsLib.scad>
use<PetalDeploymentLib.scad>
use<ElectronicsBayLib.scad>
use<RailGuide.scad>
use<FinCan.scad>
use<AltBay.scad>
use<SpringThingBooster.scad>
include<TubesLib.scad>

 
Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

nLockBalls=5;

nFins=3;
R75_Fin_Post_h=9;
R75_Fin_Root_L=220;
R75_Fin_Root_W=12;
R75_Fin_Tip_W=5;
R75_Fin_Tip_L=80;
R75_Fin_Span=140;
R75_Fin_TipOffset=40;
R75_Fin_Chamfer_L=22;

R75_Body_OD=PML75Body_OD;
R75_Body_ID=PML75Body_ID;
R75_Coupler_OD=PML75Coupler_OD;

R75_MtrTube_OD=PML54Body_OD;
R75_MtrTube_ID=PML54Body_ID;

EBay_Len=130;

NC_Len=195;
NC_Tip_r=7;
NC_Base=15;
NC_Wall_t=2.4;

UpperTube_Len=200;

BodyTubeLen=300;


module ShowRocket75(){
	Fin_Z=R75_Fin_Root_L/2+55;
	UpperFinCan_Z=R75_Fin_Root_L+75+Overlap;
	BodyTube_Z=UpperFinCan_Z+Overlap;
	EBay_Z=BodyTube_Z+BodyTubeLen+60;
	UpperTube_Z=EBay_Z+EBay_Len+Overlap;
	Nosecone_Z=UpperTube_Z+UpperTube_Len+Overlap;
	
	translate([0,0,Nosecone_Z]){
		BluntOgiveNoseCone(ID=R75_Body_ID, OD=R75_Body_OD, L=NC_Len, Base_L=NC_Base, nRivets=3, 
			Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=0, Transition_OD=R75_Body_OD, LowerPortion=false);

		rotate([0,0,-30]) NC_ShockcordRing75(Body_OD=R75_Body_OD, Body_ID=R75_Body_ID, NC_Base_L=NC_Base);
	}
	
	
	translate([0,0,EBay_Z]) rotate([0,0,-30])
		EB_Electronics_Bay(Tube_OD=R75_Body_OD, Tube_ID=R75_Body_ID, Len=162, 
												nBolts=3, BoltInset=7.5, ShowDoors=true, HasSecondBattDoor=false);
												
	translate([0,0,EBay_Z-20-Overlap]) rotate([0,0,30]) R75_UpperRailButtonPost();
	
	translate([0,0,BodyTube_Z]) color("LightBlue") Tube(OD=R75_Body_OD, ID=R75_Body_ID, 
			Len=BodyTubeLen-Overlap*2, myfn=$preview? 90:360);
	
	translate([0,0,UpperFinCan_Z]) color("White") UpperFinCan();
	color("LightGreen") LowerFinCan();
	
	//*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j])
		translate([R75_Body_OD/2-R75_Fin_Post_h, 0, Fin_Z]) 
			rotate([0,90,0]) color("Yellow") Rocket75Fin();
	/**/
} // ShowRocket75

//ShowRocket75();

module R75_UpperRailButtonPost(){
	Coupler_Z=20;
	nBolts=3;
	
	UpperRailButtonPost(Body_OD=R75_Body_OD, Body_ID=R75_Body_ID, MtrTube_OD=R75_MtrTube_OD+IDXtra);
	
	
	translate([0,0,Coupler_Z-Overlap]) difference(){
		Tube(OD=R75_Body_ID, ID=R75_Body_ID-6, Len=15, myfn=$preview? 90:360);
		
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) translate([0,R75_Body_OD/2,7.5])
			rotate([-90,0,0]) Bolt4Hole();
	} // difference
					
		// gap filler
	difference(){
		translate([0,0,Coupler_Z-5]) 
			Tube(OD=R75_Body_ID-1, ID=R75_Body_ID-6, Len=6, myfn=$preview? 90:360);
			
		translate([0,0,Coupler_Z-5-Overlap]) 
			cylinder(d1=R75_Body_ID-1, d2=R75_Body_ID-6-Overlap, h=5, $fn=$preview? 90:360);
	} // difference
	//translate([0,0,Coupler_Z]) 
	//	Tube(OD=OuterRing_OD, ID=Body_ID-4.4, Len=IntCouplerLen, myfn=$preview? 90:360);
				
} // R75_UpperRailButtonPost

//R75_UpperRailButtonPost();

module UpperFinCan(){
	// Upper Half of Fin Can
	
	rotate([180,0,0]) 
		FinCan(Tube_OD=R75_Body_OD, Tube_ID=R75_Body_ID, MtrTube_OD=R75_MtrTube_OD+IDXtra*2, nFins=nFins,
			Post_h=R75_Fin_Post_h, Root_L=R75_Fin_Root_L, Root_W=R75_Fin_Root_W, 
			Chamfer_L=R75_Fin_Chamfer_L, HasTailCone=false); 

} // UpperFinCan

//UpperFinCan();

module LowerFinCan(){
	
	difference(){
		FinCan(Tube_OD=R75_Body_OD, Tube_ID=R75_Body_ID, MtrTube_OD=R75_MtrTube_OD+IDXtra*2, nFins=nFins, 
			Post_h=R75_Fin_Post_h, Root_L=R75_Fin_Root_L, Root_W=R75_Fin_Root_W, 
			Chamfer_L=R75_Fin_Chamfer_L, 
			HasTailCone=true,
					MtrRetainer_OD=R75_MtrTube_OD+5,
					MtrRetainer_L=16,
					MtrRetainer_Inset=5); // Lower Half of Fin Can
		
		translate([0,0,40]) rotate([0,0,-180/nFins]) 
			translate([R75_Body_OD/2+5,0,0]) rotate([0,90,0]) Bolt8Hole(depth=30);
	} // difference
		


	difference(){
		translate([0,0,40]) rotate([0,0,-180/nFins]) 
			RailButtonPost(OD=R75_Body_OD, MtrTube_OD=R75_MtrTube_OD, H=R75_Body_OD/2+5, Len=30);
		translate([0,0,50]) TrapFin2Slots(Tube_OD=R75_Body_OD, nFins=nFins, 	
			Post_h=R75_Fin_Post_h, Root_L=R75_Fin_Root_L, Root_W=R75_Fin_Root_W, Chamfer_L=R75_Fin_Chamfer_L);
	} // difference

} // LowerFinCan

// LowerFinCan();

module Rocket75Fin(){
	TrapFin2(Post_h=R75_Fin_Post_h, Root_L=R75_Fin_Root_L, Tip_L=R75_Fin_Tip_L, 
			Root_W=R75_Fin_Root_W, Tip_W=R75_Fin_Tip_W, 
			Span=R75_Fin_Span, Chamfer_L=R75_Fin_Chamfer_L,
					TipOffset=R75_Fin_TipOffset);

	if ($preview==false){
		translate([-R75_Fin_Root_L/2+10,0,0]) cylinder(d=R75_Fin_Root_W*2.5, h=0.9); // Neg
		translate([R75_Fin_Root_L/2-10,0,0]) cylinder(d=R75_Fin_Root_W*2.5, h=0.9); // Pos
	}
} // Rocket75Fin

// Rocket75Fin();


































