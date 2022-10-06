// ***********************************
// Project: 3D Printed Rocket
// Filename: Rocket98.scad
// Created: 10/4/2022 
// Revision: 1.0.0  10/4/2022
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  Rocket with 98mm Body and 54mm motor. 
//
//  ***** History *****
// 
// 1.0.0  10/4/2022  First code.
//
// ***********************************
//  ***** for STL output *****
//
// *** Nosecode ***
/*
FairingConeOGive(Fairing_OD=R98_Body_OD, 
					FairingWall_T=FairingWall_T,
					NC_Base=NC_Base, 
					NC_Len=NC_Len, 
					NC_Wall_t=NC_Wall_t,
					NC_Tip_r=NC_Tip_r,
					Cut_Z=180, LowerPortion=false);
/**/
// NoseLockRing(Fairing_ID =Fairing_ID);

// BluntOgiveWeight(OD=R98_Body_OD, L=NC_Len, Tip_R=NC_Tip_r, Wall_T=NC_Wall_t);

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
//
// *** Electronics Bay ***
// R98_Electronics_Bay();
// FairingBaseBulkPlate(Tube_ID=R98_Body_ID, Fairing_ID=Fairing_ID, ShockCord_a=-100);
// AltDoor54(Tube_OD=R98_Body_OD);
//
// *** Fin Can ***
// UpperFinCan();
// Rocket98Fin();
// rotate([180,0,0]) LowerFinCan();
//
// ***********************************
//  ***** Routines *****
//
//
// ***********************************
//  ***** for Viewing *****
//
// ShowRocket98();
//
// ***********************************
include<Fairing54.scad>
include<FinCan.scad>
include<AltBay.scad>
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

nFins=5;
R98_Fin_Post_h=10;
R98_Fin_Root_L=200;
R98_Fin_Root_W=14;
R98_Fin_Tip_W=5;
R98_Fin_Tip_L=80;
R98_Fin_Span=180;
R98_Fin_TipOffset=120;
R98_Fin_Chamfer_L=32;

R98_Body_OD=PML98Body_OD;
R98_Body_ID=PML98Body_ID;
R98_MtrTube_OD=PML54Body_OD;
R98_MtrTube_ID=PML54Body_ID;

EBay_Len=130;

// Fairing Overrides
Fairing_OD=PML98Body_OD;
FairingWall_T=2.2;
Fairing_ID=Fairing_OD-FairingWall_T*2;

NoseconeSep_Z=0; // This much of the nosecone becomes part of the fairing.
NC_Len=350;
NC_Tip_r=5;
NC_Base=5;
NC_Lock_H=5;

Fairing_Len=180; // Body of the fairing.

BodyTubeLen=36*25.4;


module ShowRocket98(){
	
	translate([0,0,R98_Fin_Root_L+100+EBay_Len+20+BodyTubeLen+Fairing_Len+Overlap*2]){
		FairingConeOGive(Fairing_OD=R98_Body_OD, 
						FairingWall_T=FairingWall_T,
						NC_Base=NC_Base, 
						NC_Len=NC_Len, 
						NC_Wall_t=NC_Wall_t,
						NC_Tip_r=NC_Tip_r);
		
		translate([0,0,-NC_Lock_H]) NoseLockRing(Fairing_ID =Fairing_ID);
	}
	
	translate([0,0,R98_Fin_Root_L+100+20+BodyTubeLen+EBay_Len+Overlap])
		F54_FairingHalf(IsLeftHalf=true, 
				Fairing_OD=Fairing_OD,
				Wall_T=FairingWall_T,
				Len=Fairing_Len);
	
	translate([0,0,R98_Fin_Root_L+100+20+BodyTubeLen]) rotate([0,0,30]) R98_Electronics_Bay();
	
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

module R98_Electronics_Bay(){
	Electronics_Bay(Tube_OD=PML98Body_OD, Tube_ID=PML98Body_ID, Fairing_ID=Fairing_ID, 
				EBay_Len=EBay_Len, HasCablePuller=true);
	
	TubeStop(InnerTubeID=PML98Coupler_ID, OuterTubeOD=PML98Body_OD, myfn=$preview? 36:360);
	
	translate([0,0,30]) DoubleBatteryHolder(Tube_ID=Fairing_ID, HasBoltHoles=false);
	
} // R98_Electronics_Bay

//R98_Electronics_Bay();
//translate([0,0,EBay_Len/2]) rotate([90,0,90]) AltDoor54(Tube_OD=PML75Body_OD);

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


































