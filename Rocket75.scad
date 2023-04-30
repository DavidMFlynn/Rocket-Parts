// ***********************************
// Project: 3D Printed Rocket
// Filename: Rocket75.scad
// by David M. Flynn
// Created: 9/11/2022 
// Revision: 0.9.1  9/28/2022
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  Rocket with 75mm Body and 54mm motor. 
//
//  ***** History *****
// 
// 0.9.1  9/28/2022  Adding last couple of parts.
// 0.9.0  9/11/2022  First code.
//
// ***********************************
//  ***** for STL output *****
//
// *** Nosecode ***
/*
FairingConeOGive(Fairing_OD=R75_Body_OD, 
					FairingWall_T=FairingWall_T,
					NC_Base=NC_Base, 
					NC_Len=NC_Len, 
					NC_Wall_t=NC_Wall_t,
					NC_Tip_r=NC_Tip_r);
/**/
// NoseLockRing(Fairing_ID =Fairing_ID);

// BluntOgiveWeight(OD=R75_Body_OD, L=NC_Len, Tip_R=NC_Tip_r, Wall_T=NC_Wall_t);

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
// SpringEndCap();
//
// *** Electronics Bay ***
// FairingBaseBulkPlate(Tube_ID=R75_Body_ID, Fairing_ID=Fairing_ID);
// R75_Electronics_Bay();
// AltDoor54(Tube_OD=R75_Body_OD);
//
// *** Fin Can ***
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

include<Fairing54.scad>
include<FinCan.scad>
include<AltBay.scad>

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
R75_MtrTube_OD=PML54Body_OD;
R75_MtrTube_ID=PML54Body_ID;

EBay_Len=130;

// Fairing Overrides
Fairing_OD=PML75Body_OD;
FairingWall_T=2.2;
Fairing_ID=Fairing_OD-FairingWall_T*2;

NoseconeSep_Z=0; // This much of the nosecone becomes part of the fairing.
NC_Len=195;
NC_Tip_r=7;
NC_Base=5;
NC_Lock_OD=Fairing_ID; // Nosecone locking ring.
NC_Lock_ID=NC_Lock_OD-6;
NC_Lock_H=5;

Fairing_Len=150; // Body of the fairing. Overall len is Fairing_Len + NC_Base + NoseconeSep_Z

BodyTubeLen=300;

// Overrides
F54_Spring_OD=5/16*25.4;
F54_Spring_FL=1.25*25.4;
F54_Spring_CBL=0.7*25.4;
F54_SpringEndCap_OD=F54_Spring_OD+3;



module ShowRocket75(){
	
	translate([0,0,R75_Fin_Root_L+100+EBay_Len+60+BodyTubeLen+Fairing_Len+Overlap*2]){
		FairingConeOGive(Fairing_OD=R75_Body_OD, 
						FairingWall_T=FairingWall_T,
						NC_Base=NC_Base, 
						NC_Len=NC_Len, 
						NC_Wall_t=NC_Wall_t,
						NC_Tip_r=NC_Tip_r);
		
		translate([0,0,-NC_Lock_H]) NoseLockRing(Fairing_ID =Fairing_ID);
	}
	
	translate([0,0,R75_Fin_Root_L+100+60+BodyTubeLen+EBay_Len+Overlap])
		F54_FairingHalf(IsLeftHalf=true, 
				Fairing_OD=Fairing_OD,
				Wall_T=FairingWall_T,
				Len=Fairing_Len);
	
	translate([0,0,R75_Fin_Root_L+100+60+BodyTubeLen]) rotate([0,0,30]) R75_Electronics_Bay();
	
	translate([0,0,R75_Fin_Root_L+100+Overlap]) color("LightBlue") Tube(OD=R75_Body_OD, ID=R75_Body_ID, 
			Len=BodyTubeLen-Overlap*2, myfn=$preview? 90:360);
	
	translate([0,0,R75_Fin_Root_L+100+Overlap]) color("White") UpperFinCan();
	color("LightGreen") LowerFinCan();
	
	//*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j])
		translate([R75_Body_OD/2-R75_Fin_Post_h, 0, R75_Fin_Root_L/2+50]) 
			rotate([0,90,0]) color("Yellow") Rocket75Fin();
	/**/
} // ShowRocket75

//ShowRocket75();

module R75_Electronics_Bay(){
	Electronics_Bay(Tube_OD=PML75Body_OD, Tube_ID=PML75Body_ID, Fairing_ID=PML75Body_OD-4.4, 
				EBay_Len=EBay_Len, HasCablePuller=true);
	
	translate([0,0,-20]) UpperRailButtonPost(Body_OD=PML75Body_OD, Body_ID=PML75Body_ID, MtrTube_OD=PML54Body_OD+IDXtra);
} // R75_Electronics_Bay

//R75_Electronics_Bay();
//translate([0,0,EBay_Len/2]) rotate([90,0,90]) AltDoor54(Tube_OD=PML75Body_OD);

module UpperFinCan(){
	// Upper Half of Fin Can
	
	rotate([180,0,0]) 
		FinCan3(Tube_OD=R75_Body_OD, Tube_ID=R75_Body_ID, MtrTube_OD=R75_MtrTube_OD+IDXtra*2, nFins=nFins,
			Post_h=R75_Fin_Post_h, Root_L=R75_Fin_Root_L, Root_W=R75_Fin_Root_W, 
			Chamfer_L=R75_Fin_Chamfer_L, HasTailCone=false); 

} // UpperFinCan

//UpperFinCan();

module LowerFinCan(){
	
	difference(){
		FinCan3(Tube_OD=R75_Body_OD, Tube_ID=R75_Body_ID, MtrTube_OD=R75_MtrTube_OD+IDXtra*2, nFins=nFins, 
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


































