// ***********************************
// Project: 3D Printed Rocket
// Filename: Rocket75A.scad
// by David M. Flynn
// Created: 4/19/2023 
// Revision: 0.9.2  4/19/2023
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  Rocket with 75mm Body and 54mm motor. 
//  5 fins, uses SpringThingBooster on bottom of E-Bay
//
//  ***** History *****
// 
// 0.9.2  4/19/2023  Copied from Rocket75
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
//
// *** Electronics Bay ***
// FairingBaseBulkPlate(Tube_ID=R75_Body_ID, Fairing_ID=Fairing_ID);
// 
// R75A_Electronics_Bay();
// AltDoor54(Tube_OD=R75_Body_OD, DoorXtra_X=2, DoorXtra_Y=2);
// Batt_Door(Tube_OD=R75_Body_OD, InnerTube_OD=0, HasSwitch=true);
// Batt_Door(Tube_OD=R75_Body_OD, InnerTube_OD=0, HasSwitch=false);
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
// ShowRocket54();
//
// ***********************************

use<Fairing54.scad>
use<FinCan.scad>
include<BatteryHolderLib.scad>
use<AltBay.scad>
use<SpringThingBooster.scad>
include<TubesLib.scad>

//also included
 //include<NoseCone.scad>
 //include<FairingJointLib.scad>
 //include<RailGuide.scad>
 //include<Fins.scad>
 //
 //include<BearingLib.scad>
 //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

nFins=5;
R75_Fin_Post_h=9;
R75_Fin_Root_L=220;
R75_Fin_Root_W=12;
R75_Fin_Tip_W=5;
R75_Fin_Tip_L=80;
R75_Fin_Span=120;
R75_Fin_TipOffset=40;
R75_Fin_Chamfer_L=22;

R75_Body_OD=PML75Body_OD;
R75_Body_ID=PML75Body_ID;
R75_MtrTube_OD=BT54Body_OD;
R75_MtrTube_ID=BT54Body_ID;

EBay_Len=162;

NoseconeSep_Z=0; // This much of the nosecone becomes part of the fairing.
NC_Len=195;
NC_Tip_r=7;
NC_Base=20;
NC_Wall_t=2.2;

BodyTubeLen=300;


module ShowRocket75(){
	
	translate([0,0,R75_Fin_Root_L+100+EBay_Len+60+BodyTubeLen+Overlap*2]){
		FairingConeOGive(Fairing_OD=R75_Body_OD, 
						FairingWall_T=2.2,
						NC_Base=NC_Base, 
						NC_Len=NC_Len, 
						NC_Wall_t=NC_Wall_t,
						NC_Tip_r=NC_Tip_r);
		
		
	}
	
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
	

} // R75_Electronics_Bay

//R75_Electronics_Bay();
//translate([0,0,EBay_Len/2]) rotate([90,0,90]) AltDoor54(Tube_OD=PML75Body_OD);


module R75A_Electronics_Bay(Tube_OD=R75_Body_OD, Tube_ID=R75_Body_ID, 
						InnerTube_OD=BT38Body_OD, HasFairingLockRing=false,
					ShowDoors=false){
	Len=148;
	
	BattSwDoor_Z=70;
	TopSkirt_Len=15;
	BottomSkirt_Len=15;
	CablePuller_Z=74.5;
	Alt_DoorXtra_X=2;
	Alt_DoorXtra_Y=2;
	
	Alt_a=180;
	Batt1_a=70; // Altimeter Battery
	Batt2_a=290; // Cable puller battery and switch
	TubeOffset=0;
	nCRHoles=4;
	CRHole_a=0;
	
	
	// The Fairing clamps onto this. 
	if (HasFairingLockRing)
	translate([0,0,Len]) FairingBaseLockRing(Tube_OD=Tube_OD, Tube_ID=Tube_ID, Fairing_ID=Fairing_ID, Interface=Overlap, BlendToTube=true);
	

	difference(){
		union(){
			Tube(OD=Tube_OD, ID=Tube_ID, Len=Len, myfn=$preview? 36:360);
			
			translate([0,0,BottomSkirt_Len]) rotate([0,0,45])
				CenteringRing(OD=Tube_OD-1, ID=InnerTube_OD+IDXtra*2, 
								Thickness=5, nHoles=nCRHoles, Offset=TubeOffset);
			
			translate([0,0,Len-5-TopSkirt_Len]) rotate([0,0,45])
				CenteringRing(OD=Tube_OD-1, ID=InnerTube_OD+IDXtra*2, 
							Thickness=5, nHoles=nCRHoles, Offset=TubeOffset);
		} // union
		
		//*
		if (nCRHoles==0)
		for (j=[1:nHoles-1]) rotate([0,0,360/nHoles*j])
			translate([0,InnerTube_OD/2+(Tube_ID/2-InnerTube_OD/2)/2,0])
				cylinder(d=(Tube_ID/2-InnerTube_OD/2)/2, h=Len);
			/**/
			
		// Altimeter
		translate([0,0,CablePuller_Z]) rotate([0,0,Alt_a+180]) 
			Alt_BayFrameHole(Tube_OD=Tube_OD, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y);
		
		// Battery and Switch door holes
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a+180]) 
			Batt_BayFrameHole(Tube_OD=Tube_OD, HasSwitch=false);
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt2_a+180]) 
			Batt_BayFrameHole(Tube_OD=Tube_OD, HasSwitch=true);
		
		
	} // difference
	
	
	
	// Altimeter
	translate([0,0,CablePuller_Z]) rotate([0,0,Alt_a+180])
		Alt_BayDoorFrame(Tube_OD=Tube_OD, Tube_ID=Tube_ID, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowDoor=ShowDoors);
	
	
	// Battery and Switch door2
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a+180]) 
		Batt_BayDoorFrame(Tube_OD=Tube_OD, Tube_ID=Tube_ID, HasSwitch=false, ShowDoor=ShowDoors);
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt2_a+180]) 
		Batt_BayDoorFrame(Tube_OD=Tube_OD, Tube_ID=Tube_ID, HasSwitch=true, ShowDoor=ShowDoors);
	
} // R75A_Electronics_Bay

//R75A_Electronics_Bay(ShowDoors=true);

module UpperFinCan(){
	// Upper Half of Fin Can
	
	rotate([180,0,0]) 
		FinCan3(Tube_OD=R75_Body_OD, Tube_ID=R75_Body_ID, MtrTube_OD=R75_MtrTube_OD+IDXtra*2, nFins=nFins,
			Post_h=R75_Fin_Post_h, Root_L=R75_Fin_Root_L, Root_W=R75_Fin_Root_W, 
			Chamfer_L=R75_Fin_Chamfer_L, HasTailCone=false); 

} // UpperFinCan

//UpperFinCan();

module LowerFinCan(){
	RailGuide_Z=55;
	
	difference(){
		FinCan3(Tube_OD=R75_Body_OD, Tube_ID=R75_Body_ID, MtrTube_OD=R75_MtrTube_OD+IDXtra*2, nFins=nFins, 
			Post_h=R75_Fin_Post_h, Root_L=R75_Fin_Root_L, Root_W=R75_Fin_Root_W, 
			Chamfer_L=R75_Fin_Chamfer_L, 
			HasTailCone=false,
					MtrRetainer_OD=R75_MtrTube_OD+5,
					MtrRetainer_L=16,
					MtrRetainer_Inset=5); // Lower Half of Fin Can
		
		// modified to fit resin tailcone
		translate([0,0,-Overlap]) cylinder(d=R75_Body_OD+1, h=40-5.5);
		
		translate([0,0,RailGuide_Z]) rotate([0,0,-180/nFins]) 
			translate([R75_Body_OD/2+5,0,0]) rotate([0,90,0]) Bolt8Hole(depth=30);
	} // difference
		


	difference(){
		translate([0,0,RailGuide_Z]) rotate([0,0,-180/nFins]) 
			RailButtonPost(OD=R75_Body_OD, MtrTube_OD=R75_MtrTube_OD, H=R75_Body_OD/2+5, Len=30);
		translate([0,0,RailGuide_Z+10]) TrapFin2Slots(Tube_OD=R75_Body_OD, nFins=nFins, 	
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


































