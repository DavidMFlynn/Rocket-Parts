// ***********************************
// Project: 3D Printed Rocket
// Filename: Rocket98G.scad
// by David M. Flynn
// Created: 10/4/2022 
// Revision: 1.1.0  11/9/2022
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  Rocket with 98mm Body and 54mm motor. 
//  See Rocket98Dual.scad for forward section.
//
//  ***** History *****
// 1.1.0  11/9/2022  Copied from Rocket98, New file, New fin shape. 
// 1.0.1  10/11/2022 Added Rail Guides
// 1.0.0  10/4/2022  First code.
//
// ***********************************
//  ***** for STL output *****
//
// *** Fin Can ***
// UpperFinCan();
// Rocket98Fin();
// rotate([180,0,0]) LowerFinCan();
// rotate([90,0,0]) BoltOnRailGuide(Length = 40, BoltSpace=12.7, RoundEnds=true);
//
// ***********************************
//  ***** for Viewing *****
//
// ShowRocket98();
//
// ***********************************
use<Rocket98Dual.scad>
include<FinCan.scad>

//also included
 //include<NoseCone.scad>
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
R98_Fin_Post_h=10;
R98_Fin_Root_L=240;
R98_Fin_Root_W=14;
R98_Fin_Tip_W=5;
R98_Fin_Tip_L=80;
R98_Fin_Span=150;
R98_Fin_TipOffset=60;
R98_Fin_Chamfer_L=32;

R98_Body_OD=PML98Body_OD;
R98_Body_ID=PML98Body_ID;
R98_MtrTube_OD=PML54Body_OD;
R98_MtrTube_ID=PML54Body_ID;

BodyTubeLen=12*25.4;

module ShowRocket98(){
	
	translate([0,0,R98_Fin_Root_L+100+BodyTubeLen+1]) ShowUpperBays();
	
	translate([0,0,R98_Fin_Root_L+100+Overlap]) color("LightBlue") Tube(OD=R98_Body_OD, ID=R98_Body_ID, 
			Len=BodyTubeLen-Overlap*2, myfn=$preview? 90:360);
	
	translate([0,0,R98_Fin_Root_L+100+Overlap]) color("White") UpperFinCan();
	color("LightGreen") LowerFinCan();
	
	//*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j])
		translate([R98_Body_OD/2-R98_Fin_Post_h, 0, R98_Fin_Root_L/2+50]) 
			rotate([0,90,0]) color("Yellow") Rocket98Fin();
	/**/
} // ShowRocket98

//ShowRocket98();

module UpperFinCan(){
	// Upper Half of Fin Can
	
	rotate([180,0,0]) 
		FinCan3(Tube_OD=R98_Body_OD, Tube_ID=R98_Body_ID, MtrTube_OD=R98_MtrTube_OD+IDXtra*2, nFins=nFins,
			Post_h=R98_Fin_Post_h, Root_L=R98_Fin_Root_L, Root_W=R98_Fin_Root_W, 
			Chamfer_L=R98_Fin_Chamfer_L, HasTailCone=false); 

} // UpperFinCan

//UpperFinCan();

module LowerFinCan(){
	
	difference(){
		FinCan3(Tube_OD=R98_Body_OD, Tube_ID=R98_Body_ID, MtrTube_OD=R98_MtrTube_OD+IDXtra*2, nFins=nFins, 
			Post_h=R98_Fin_Post_h, Root_L=R98_Fin_Root_L, Root_W=R98_Fin_Root_W, 
			Chamfer_L=R98_Fin_Chamfer_L, 
			HasTailCone=true,
					MtrRetainer_OD=R98_MtrTube_OD+5,
					MtrRetainer_L=20,
					MtrRetainer_Inset=7); // Lower Half of Fin Can
		
		translate([0,0,80]) rotate([0,0,-90-180/nFins]) 
			translate([0,R98_Body_OD/2+2,0]) RailGuideBoltPattern(BoltSpace=12.7) Bolt6Hole();
	} // difference
		


	difference(){
		translate([0,0,80]) rotate([0,0,-90-180/nFins]) 
			//RailButtonPost(OD=R98_Body_OD, MtrTube_OD=R98_MtrTube_OD, H=R98_Body_OD/2+5, Len=30);
			RailGuidePost(OD=R98_Body_OD, MtrTube_OD=R98_MtrTube_OD+IDXtra*2, H=R98_Body_OD/2+2, TubeLen=70, Length = 40, BoltSpace=12.7);
		translate([0,0,50]) TrapFin2Slots(Tube_OD=R98_Body_OD, nFins=nFins, 	
			Post_h=R98_Fin_Post_h, Root_L=R98_Fin_Root_L, Root_W=R98_Fin_Root_W, Chamfer_L=R98_Fin_Chamfer_L);
	} // difference

} // LowerFinCan

// LowerFinCan();

module Rocket98Fin(){
	TrapFin2(Post_h=R98_Fin_Post_h, Root_L=R98_Fin_Root_L, Tip_L=R98_Fin_Tip_L, 
			Root_W=R98_Fin_Root_W, Tip_W=R98_Fin_Tip_W, 
			Span=R98_Fin_Span, Chamfer_L=R98_Fin_Chamfer_L,
					TipOffset=R98_Fin_TipOffset);

	if ($preview==false){
		translate([-R98_Fin_Root_L/2+10,0,0]) cylinder(d=R98_Fin_Root_W*2.5, h=0.9); // Neg
		translate([R98_Fin_Root_L/2-10,0,0]) cylinder(d=R98_Fin_Root_W*2.5, h=0.9); // Pos
	}
} // Rocket98Fin

// Rocket98Fin();

































