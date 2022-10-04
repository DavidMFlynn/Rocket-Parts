// ***********************************
// Project: 3D Printed Rocket
// Filename: Rocket54.scad
// Created: 9/6/2022 
// Revision: 0.9.3  10/3/2022
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  Rocket with 54mm Body and 38mm motor. 
//  This is just something I'm playing around with. 
//
//  ***** History *****
// 
// 0.9.3  10/3/2022 Battery Holder
// 0.9.2  10/2/2022 75mm Fairing and E-Bay
// 0.9.1  9/8/2022  Shalower fin slots. 
// 0.9.0  9/6/2022  First code.
//
// ***********************************
//  ***** for STL output *****
//
// *** Nosecode ***
/*
 FairingConeOGive(Fairing_OD=Fairing_OD, 
					FairingWall_T=FairingWall_T,
					NC_Base=5, 
					NC_Len=270, 
					NC_Wall_t=2,
					NC_Tip_r=NC_Tip_r, 
					Cut_Z=150, LowerPortion=false); // Print 2 halves
					/**/
// NoseLockRing(Fairing_ID =Fairing_ID);
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
// F54_SpringEndCap();

// *** Electronics Bay ***
// R54_Electronics_Bay();
// AltDoor54(Tube_OD=R54_Body_OD);
//
/*
 rotate([180,0,0]) 
FairingBase(BaseXtra=10, Fairing_OD=Fairing_OD, Fairing_ID=PML75Body_ID,
				BodyTubeOD=R54_Body_OD, 
					CouplerTube_OD=PML54Coupler_OD+IDXtra*2, CouplerTube_ID=PML54Coupler_ID);
/**/

// TubeEndDoubleBatteryHolder(TubeID=PML54Coupler_ID, TubeOD=PML54Coupler_OD);
// BoltDown();

// R54_Electronics_Bay75();
// AltDoor54(Tube_OD=Fairing_OD);
// FairingBaseBulkPlate(Tube_ID=PML75Body_ID, Fairing_ID=Fairing_ID, ShockCord_a=-89);
//
// *** Fin Can ***
// UpperFinCan();
// Rocket54Fin();
// rotate([180,0,0]) LowerFinCan();
//
// ***********************************
//  ***** Routines *****
//
//
// ***********************************
//  ***** for Viewing *****
//
// ShowRocket54();
//
// ***********************************

include<BatteryHolderLib.scad>
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

nFins=4;
R54_Fin_Post_h=6.8;
R54_Fin_Root_L=180;
R54_Fin_Root_W=10;
R54_Fin_Tip_W=5;
R54_Fin_Tip_L=120;
R54_Fin_Span=120;
R54_Fin_TipOffset=0;
R54_Fin_Chamfer_L=18;

R54_Body_OD=PML54Body_OD;
R54_Body_ID=PML54Body_ID;
R54_MtrTube_OD=PML38Body_OD;
R54_MtrTube_ID=PML38Body_ID;

EBay_Len=130;

// Fairing Overrides
Fairing_OD=PML75Body_OD;
FairingWall_T=2.2;
Fairing_ID=Fairing_OD-FairingWall_T*2;

NoseconeSep_Z=0; // This much of the nosecone becomes part of the fairing.
NC_Len=160;
NC_Tip_r=5;
NC_Base=5;
NC_Lock_OD=Fairing_ID; // Nosecone locking ring.
NC_Lock_ID=NC_Lock_OD-6;


Fairing_Len=150; // Body of the fairing. Overall len is Fairing_Len + NC_Base + NoseconeSep_Z

BodyTubeLen=300;

module ShowRocket54(){
	Fin_X=(R54_Body_OD/2-R54_Fin_Post_h>R54_MtrTube_OD/2)? R54_Body_OD/2-R54_Fin_Post_h:R54_MtrTube_OD/2;
	
	translate([0,0,340+BodyTubeLen+EBay_Len+Fairing_Len+Overlap*3]){
		FairingConeOGive();
		NoseLockRing();
	}
	
	translate([0,0,340+BodyTubeLen+EBay_Len+Overlap*2]) 
		F54_FairingHalf(IsLeftHalf=true, 
				Fairing_OD=Fairing_OD,
				Wall_T=FairingWall_T,
				Len=Fairing_Len);
	
	translate([0,0,340+BodyTubeLen+Overlap]) rotate([0,0,180/nFins]) R54_Electronics_Bay();
	
	translate([0,0,280+Overlap]) color("LightBlue") Tube(OD=R54_Body_OD, ID=R54_Body_ID, 
			Len=BodyTubeLen-Overlap*2, myfn=$preview? 90:360);
	
	translate([0,0,R54_Fin_Root_L+100+Overlap]) color("White") UpperFinCan();
	color("LightGreen") LowerFinCan();
	//*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j])
		translate([Fin_X,0,R54_Fin_Root_L/2+50]) 
			rotate([0,90,0]) color("Yellow") Rocket54Fin();
	/**/
} // ShowRocket54

//ShowRocket54();

module R54_Electronics_Bay75(){
	
	Electronics_Bay(Tube_OD=PML75Body_OD, Tube_ID=PML75Body_ID, Fairing_ID=Fairing_ID);
	
	TubeStop(InnerTubeID=PML75Coupler_ID, OuterTubeOD=PML75Body_OD, myfn=$preview? 36:360);
	
} // R54_Electronics_Bay75

//R54_Electronics_Bay75();

module R54_Electronics_Bay(){
	Electronics_Bay(Tube_OD=PML54Body_OD, Tube_ID=PML54Body_ID, Fairing_ID=Fairing_ID);
	translate([0,0,-20]) 
		UpperRailButtonPost(Body_OD=R54_Body_OD, Body_ID=R54_Body_ID, MtrTube_OD=R54_MtrTube_OD);
} // R54_Electronics_Bay

//R54_Electronics_Bay();

//Electronics_Bay(Tube_OD=PML54Body_OD, Tube_ID=PML54Body_ID, Fairing_ID=Fairing_ID);
//AltDoor54(Tube_OD=BP_Booster_Body_OD);

module UpperFinCan(){
	// Upper Half of Fin Can
	
	rotate([180,0,0]) 
		FinCan3(Tube_OD=R54_Body_OD, Tube_ID=R54_Body_ID, MtrTube_OD=R54_MtrTube_OD+IDXtra*2, nFins=nFins,
			Post_h=R54_Fin_Post_h, Root_L=R54_Fin_Root_L, Root_W=R54_Fin_Root_W, 
			Chamfer_L=R54_Fin_Chamfer_L, HasTailCone=false); 

} // UpperFinCan

//UpperFinCan();

module LowerFinCan(){
	
	difference(){
		FinCan3(Tube_OD=R54_Body_OD, Tube_ID=R54_Body_ID, MtrTube_OD=R54_MtrTube_OD+IDXtra*2, nFins=nFins, 
			Post_h=R54_Fin_Post_h, Root_L=R54_Fin_Root_L, Root_W=R54_Fin_Root_W, 
			Chamfer_L=R54_Fin_Chamfer_L, 
			HasTailCone=true,
					MtrRetainer_OD=R54_MtrTube_OD+5,
					MtrRetainer_L=16,
					MtrRetainer_Inset=5); // Lower Half of Fin Can
		
		translate([0,0,40]) rotate([0,0,-180/nFins]) 
			translate([R54_Body_OD/2+5,0,0]) rotate([0,90,0]) Bolt8Hole(depth=30);
	} // difference
		


	difference(){
		translate([0,0,40]) rotate([0,0,-180/nFins]) 
			RailButtonPost(OD=R54_Body_OD, MtrTube_OD=R54_MtrTube_OD, H=R54_Body_OD/2+5, Len=30);
		translate([0,0,50]) TrapFin2Slots(Tube_OD=R54_Body_OD, nFins=nFins, 	
			Post_h=R54_Fin_Post_h, Root_L=R54_Fin_Root_L, Root_W=R54_Fin_Root_W, Chamfer_L=R54_Fin_Chamfer_L);
	} // difference

} // LowerFinCan

// LowerFinCan();

module Rocket54Fin(){
	TrapFin2(Post_h=R54_Fin_Post_h, Root_L=R54_Fin_Root_L, Tip_L=R54_Fin_Tip_L, 
			Root_W=R54_Fin_Root_W, Tip_W=R54_Fin_Tip_W, 
			Span=R54_Fin_Span, Chamfer_L=R54_Fin_Chamfer_L);

	if ($preview==false){
		translate([-R54_Fin_Root_L/2+10,0,0]) cylinder(d=R54_Fin_Root_W*2.5, h=0.9); // Neg
		translate([R54_Fin_Root_L/2-10,0,0]) cylinder(d=R54_Fin_Root_W*2.5, h=0.9); // Pos
	}
} // Rocket54Fin

// Rocket54Fin();









































