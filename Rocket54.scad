// ***********************************
// Project: 3D Printed Rocket
// Filename: Rocket54.scad
// Created: 9/6/2022 
// Revision: 0.9.1  9/8/2022
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  Rocket with 54mm Body and 38mm motor. 
//
//  ***** History *****
// 
// 0.9.1  9/8/2022  Shalower fin slots. 
// 0.9.0  9/6/2022  First code.
//
// ***********************************
//  ***** for STL output *****
//
// *** Nosecode ***
// FairingConeOGive();
// NoseLockRing();
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
// SpringEndCap();
//
// *** Electronics Bay ***
// R54_Electronics_Bay();
// AltDoor54(Tube_OD=R54_Body_OD);
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
 include<TubesLib.scad>
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
Fairing_OD=PML54Body_OD;
FairingWall_T=2.2;
Fairing_ID=Fairing_OD-FairingWall_T*2;

NoseconeSep_Z=0; // This much of the nosecone becomes part of the fairing.
NC_Len=160;
NC_Tip_r=5;
NC_Base=5;
NC_Lock_OD=Fairing_ID; // Nosecone locking ring.
NC_Lock_ID=NC_Lock_OD-6;


Fairing_Len=130; // Body of the fairing. Overall len is Fairing_Len + NC_Base + NoseconeSep_Z

BodyTubeLen=300;

module ShowRocket54(){
	Fin_X=(R54_Body_OD/2-R54_Fin_Post_h>R54_MtrTube_OD/2)? R54_Body_OD/2-R54_Fin_Post_h:R54_MtrTube_OD/2;
	
	translate([0,0,340+BodyTubeLen+EBay_Len+Fairing_Len+Overlap*3]){
		FairingConeOGive();
		NoseLockRing();
	}
	
	translate([0,0,340+BodyTubeLen+EBay_Len+Overlap*2]) Sample(IsLeftHalf=true);
	
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

module R54_Electronics_Bay(){
	Electronics_Bay(Tube_OD=PML54Body_OD, Tube_ID=PML54Body_ID);
	translate([0,0,-20]) rotate([0,0,-45]) UpperRailButtonPost();
} // R54_Electronics_Bay

//R54_Electronics_Bay();

module UpperRailButtonPost(){
	rotate([0,0,-180/nFins]) 
			RailButtonPost(OD=R54_Body_OD, MtrTube_OD=R54_MtrTube_OD, H=R54_Body_OD/2+5, Len=40);
	translate([0,0,-20]) CenteringRing(OD=R54_Body_OD, ID=R54_MtrTube_OD+1, Thickness=8);
	// Lower Coupler Tube Socket
	translate([0,0,-40])
		Tube(OD=R54_Body_OD, ID=R54_Body_ID, 
			Len=20+Overlap, myfn=$preview? 90:360);
} // UpperRailButtonPost

//translate([0,0,400-50]) UpperRailButtonPost();

module Electronics_Bay(Tube_OD=PML54Body_OD, Tube_ID=PML54Body_ID){
	// Z=0 center of Booster button
	TopOfTube=EBay_Len;
	CablePullerInset=-1;
	CP_a=-5;
	
	// The Fairing clamps onto this. 
	translate([0,0,TopOfTube-4]) FairingBaseLockRing(Fairing_ID=Tube_ID, Interface=Overlap);
	difference(){
		translate([0,0,TopOfTube-7]) cylinder(d=Tube_ID+1, h=3+Overlap);
		translate([0,0,TopOfTube-7-Overlap]) 
				cylinder(d2=Tube_ID-4.2, d1=Tube_ID, h=3+Overlap*3, $fn=$preview? 90:360);
	} // difference
	
	// Standard E-Bay module
	difference(){
		translate([0,0,-Overlap]) rotate([0,0,90])
			AltBay54(Tube_OD=Tube_OD, Tube_ID=Tube_ID, Tube_Len=EBay_Len);
		
		// Cable Puller Bolt Holes
		translate([0,0,TopOfTube-12]) rotate([0,90,135]) 
			translate([0,0,Tube_ID/2-CablePullerInset]) 
				rotate([CP_a,0,0]) CablePullerBoltPattern() Bolt4Hole();
	} // difference
	
	// Lower Coupler Tube Socket
	translate([0,0,-20])
		Tube(OD=Tube_OD, ID=Tube_ID, 
			Len=20+Overlap, myfn=$preview? 90:360);
	
	// Shock code path, keep it out of the way. 
	
	rotate([0,0,10])
	difference(){
		Y1=30;
		Y2=65;
		Y3=110;
		H=6;
		
		union(){
			translate([0,-Tube_OD/2+4.4,Y1]) 
				ShockCordHole(X=NylonTube9_w+4.4, Y=NylonTube9_h+4.4, Len=H);
			translate([0,-Tube_OD/2+4.4,Y2]) 
				ShockCordHole(X=NylonTube9_w+4.4, Y=NylonTube9_h+4.4, Len=H);
			translate([0,-Tube_OD/2+4.4,Y3]) 
				ShockCordHole(X=NylonTube9_w+4.4, Y=NylonTube9_h+4.4, Len=H);
		}// union
		
		translate([0,-Tube_OD/2+4.4,Y1-Overlap]) 
			ShockCordHole(X=NylonTube9_w, Y=NylonTube9_h, Len=H+Overlap*2);
		
		translate([0,-Tube_OD/2+4.4,Y2-Overlap]) 
			ShockCordHole(X=NylonTube9_w, Y=NylonTube9_h, Len=H+Overlap*2);
		
		translate([0,-Tube_OD/2+4.4,Y3-Overlap]) 
			ShockCordHole(X=NylonTube9_w, Y=NylonTube9_h, Len=H+Overlap*2);
		
		// Conform to OD of E-Bay
		
		difference(){
			cylinder(d=Tube_ID+20, h=200);
			translate([0,0,-Overlap]) cylinder(d=Tube_ID+1, h=200+Overlap*2);
		} // difference
	} // difference
	
	translate([0,0,TopOfTube-12]) rotate([0,90,135]) 
	difference(){
		// Cable Puller Bolt Bosses
		translate([0,0,Tube_ID/2-CablePullerInset]) 
			rotate([CP_a,0,0]) CablePullerBoltPattern() 
				hull(){
					rotate([180,0,0]) cylinder(d=8, h=8);
					translate([12,0,0]) rotate([180,0,0]) cylinder(d=3, h=Overlap);
				} // hull
		
		// Cable Puller Bolt Holes
		translate([0,0,Tube_ID/2-CablePullerInset]) 
			rotate([CP_a,0,0]) CablePullerBoltPattern() Bolt4Hole();
		
		// Conform to OD of E-Bay
		rotate([0,90,0]) translate([0,0,-10])
		difference(){
			cylinder(d=Tube_ID+20, h=100);
			translate([0,0,-Overlap]) cylinder(d=Tube_ID+1, h=100+Overlap*2);
		} // difference
	} // difference
} // Electronics_Bay

//Electronics_Bay(Tube_OD=PML54Body_OD, Tube_ID=PML54Body_ID);
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









































