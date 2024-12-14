// *******************************************************
// Project: 3D Printed Rocket
// Filename: Rocket20351D.scad
// by David M. Flynn
// Created: 12/13/2024
// Revision: 0.9.0  12/13/2024
// Units: mm
// *******************************************************
//  ***** Notes *****
//
// A big fat mailing tube rocket. Level 3 in 7000 feet AGL.
//
//  ***** History *****
//
// 0.9.0  12/13/2024   First code
//
// *******************************************************
//  ***** for STL output *****
//
// BluntOgiveNoseCone(ID=Body_ID, OD=Body_OD, L=Nosecone_Len, Base_L=NoseconeBase_Len, nRivets=nNoseconeRivets, Tip_R=NoseconeTip_R, Wall_T=NoseconeWall_t, Cut_Z=0, Transition_OD=Body_OD, LowerPortion=false);
//
// NC_ShockcordRingDual(Tube_OD=Body_OD, Tube_ID=Body_ID, NC_ID=0, NC_Base_L=NoseconeBase_Len, nRivets=nNoseconeRivets, nBolts=0);
//
// FinCan(LowerHalfOnly=false, UpperHalfOnly=false);
// Rocket_Fin();
//
// *******************************************************
//  ***** for Viewing *****
//
//
// *******************************************************
include<TubesLib.scad>
use<AT-RMS-Lib.scad>
use<RailGuide.scad>
use<NoseCone.scad>
use<Fins.scad>
use<FinCan2Lib.scad>
use<SpringThingBooster.scad>
use<SpringEndsLib.scad>

//include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

Nosecone_Len=400;
NoseconeBase_Len=15;
NoseconeTip_R=15;
NoseconeWall_t=2.2;
nNoseconeRivets=7;


nFins=5;
Fin_Post_h=20;
Fin_Root_L=380;
Fin_Root_W=16;
Fin_Tip_W=5;
Fin_Tip_L=140;
Fin_Span=200;
Fin_TipOffset=50;
Fin_Chamfer_L=50;
Fin_Inset=10;

Body_OD=ULine203Body_OD;
Body_ID=ULine203Body_ID;
Coupler_OD=ULine203Body_ID-1.10;
MotorTube_OD=BT75Body_OD;
MotorTube_ID=BT75Body_ID;

FinCan_Len=Fin_Root_L+Fin_Inset*2;
Cone_Len=140;

module ShowRocket(ShowInternals=false){
	Fin_Z=FinCan_Len/2;
	
	FinCan();
	
	for (j=[0:nFins]) rotate([0,0,360/nFins*j+180/nFins])
		translate([0, Body_OD/2-Fin_Post_h, Fin_Z]) 
			rotate([-90,0,0]) color("LightGreen") Rocket_Fin();
	
} // ShowRocket

// ShowRocket();

module FinCan(LowerHalfOnly=false, UpperHalfOnly=false){
	MotorRetainer_OD=MotorTube_OD+5;
	MotorRetainer_Len=40;
	
	Cutout_d=60;
	Cutout_Depth=35;
	
	module Decor(D=Cutout_d){
		hull(){
			translate([0,Body_OD/2,FinCan_Len-65-Fin_Inset-Cutout_d/2]) sphere(d=D);
			translate([0,Body_OD/2-Cutout_Depth, FinCan_Len-65-Fin_Inset-Cutout_d/2-Cutout_Depth]) 
				sphere(d=D-Cutout_Depth);
			translate([0,Body_OD/2,-Cone_Len]) sphere(d=D);
			translate([0,Body_OD/2-Cutout_Depth,-Cone_Len]) sphere(d=D-Cutout_Depth);
		} // hull
		for (j=[1:nFins-1]) rotate([0,0,360/nFins*j]) hull(){
			translate([0,Body_OD/2,FinCan_Len-Fin_Inset-Cutout_d/2]) sphere(d=D);
			translate([0,Body_OD/2-Cutout_Depth,FinCan_Len-Fin_Inset-Cutout_d/2-Cutout_Depth]) 
				sphere(d=D-Cutout_Depth);
			translate([0,Body_OD/2,-Cone_Len]) sphere(d=D);
			translate([0,Body_OD/2-Cutout_Depth,-Cone_Len]) sphere(d=D-Cutout_Depth);
		} // hull
	} // Decor
	
	difference(){
		FC2_FinCan(Body_OD=Body_OD, Body_ID=Body_ID, Can_Len=FinCan_Len,
				MotorTube_OD=MotorTube_OD, RailGuide_h=Body_OD/2+2, RailGuide_z=FinCan_Len-40,
				nFins=nFins, HasIntegratedCoupler=true, HasMotorSleeve=true, HasAftIntegratedCoupler=false,
				Fin_Root_W=Fin_Root_W, Fin_Root_L=Fin_Root_L, Fin_Post_h=Fin_Post_h, Fin_Chamfer_L=Fin_Chamfer_L,
				Cone_Len=Cone_Len, ThreadedTC=false, Extra_OD=0, RailGuideLen=40,
				LowerHalfOnly=LowerHalfOnly, UpperHalfOnly=UpperHalfOnly, HasWireHoles=false, 
				HollowTailcone=false, 
				HollowFinRoots=true, Wall_t=2.2);
				
		// Motor Retainer
		translate([0,0,-Cone_Len-5]) cylinder(d=MotorRetainer_OD, h=MotorRetainer_Len);
		translate([0,0,-Cone_Len-Overlap]) cylinder(d=Body_OD, h=5);
		
		Decor(D=Cutout_d);

	} // difference
	
	difference(){
		intersection(){
			cylinder(d=Body_OD-1, h=FinCan_Len);
			
			Decor(D=Cutout_d+4.4);
		} // intersection
		
		Decor(D=Cutout_d);
	} // difference
				
} // FinCan

// FinCan();

module Rocket_Fin(){
	TrapFin2(Post_h=Fin_Post_h, Root_L=Fin_Root_L, Tip_L=Fin_Tip_L,
			Root_W=Fin_Root_W, Tip_W=Fin_Tip_W,
			Span=Fin_Span, Chamfer_L=Fin_Chamfer_L,
					TipOffset=Fin_TipOffset);

} // Rocket_Fin

// Rocket_Fin();

























