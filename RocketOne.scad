// ***********************************
// Project: 3D Printed Rocket
// Filename: RocketOne.scad
// Created: 8/31/2022 
// Revision: 1.0.0  8/31/2022
// Units: mm
// ***********************************
//  ***** Notes *****
//
// My first 3d printed rocket. 
// Many things have changed, this may not work any more. 
//
//  ***** History *****
//
// 1.0.0  8/31/2022  Grouped all the parts here. 
//
// ***********************************
//  ***** for STL output *****
// *** Begin Fairing ***
/*
FairingCone(Fairing_ID=Fairing_ID, Fairing_OD=Fairing_OD, 
					NC_Base=NC_Base, FairingWall_T=FairingWall_T,
					NoseconeSep_Z=NoseconeSep_Z);
					/**/
// NoseLockRing(NC_Lock_OD=NC_Lock_OD, NC_Lock_ID=NC_Lock_ID);
//
// Sample(IsLeftHalf=true);
// Sample(IsLeftHalf=false);
//
//  *** Cable Puller Parts goes inside fairing ***
// ThroughOut();
// rotate([0,90,0]) SpringBody();
// CableRetainer();
// StopAdjuster();
// CageBottom();
// AddServo(); // CageTop w/ servo mount translate([0,0,SpringBody_YZ/2+2.5]) rotate([180,0,0]) CageTop();
//
// BellCrank(Len=38);
//
//
// FairingBaseLockRing(Fairing_ID=Fairing_ID);
/*
 rotate([180,0,0]) FairingBase(BaseXtra=17, Fairing_OD=Fairing_OD, Fairing_ID=Fairing_ID,
					BodyTubeOD=PML98Body_OD, 
					CouplerTube_OD=PML98Coupler_OD, CouplerTube_ID=PML98Coupler_ID); // Pring w/ support
/**/
//
// SpringEndCap();
//
// *** End Fairing ***
// *** Begin Altimeter Bay ***

// *** End Altimeter Bay ***
//
// BoltOnRailButtonPost();
//
//  *** Begin Fin Can ***
//
// TrapFin2(Post_h=10, Root_L=180, Tip_L=120, Root_W=10, Tip_W=5.0, Span=120, Chamfer_L=18); // Print Spiral Vase
//
//
// rotate([180,0,0]) FinCan3(Tube_OD=PML98Body_OD, Tube_ID=PML98Body_ID, MtrTube_OD=PML54Body_OD, nFins=5, Post_h=10, Root_L=180, Root_W=10, Chamfer_L=18, HasTailCone=false); // Upper Half of Fin Can
//
/*
rotate([180,0,0]){
	FinCan3(Tube_OD=PML98Body_OD, Tube_ID=PML98Body_ID, MtrTube_OD=PML54Body_OD, nFins=5, Post_h=10, Root_L=180, Root_W=10, Chamfer_L=18, HasTailCone=true); // Lower Half of Fin Can

	translate([0,0,60]) rotate([0,0,-360/10]) 
		RailButtonPost(OD=PML98Body_OD, MtrTube_OD=PML54Body_OD, H=5.5*25.4/2);}
/**/
//
// ***********************************
//  ***** Routines *****
//
//
// ***********************************
//  ***** for Viewing *****
//
//
// ***********************************

include<FinCan.scad>
//include<RailGuide.scad>
//include<TubesLib.scad>
//include<Fins.scad>
//include<CommonStuffSAEmm.scad>

include<Fairing.scad>
//include<NoseCone.scad>
//include<CablePuller.scad>
//include<FairingJointLib.scad>
//include<CommonStuffSAEmm.scad>


Overlap=0.05;
IDXtra=0.2; // Add to ID for tight fit, x2 for loose fit
$fn=$preview? 24:90;


// overrides from Fairing.scad
Spring_OD=5/16*25.4;
Spring_FL=1.25*25.4;
Spring_CBL=0.7*25.4;
SpringEndCap_OD=Spring_OD+3;

Fairing_OD=5.5 * 25.4;
FairingWall_T=2.2;
Fairing_ID=Fairing_OD-FairingWall_T*2;

NoseconeSep_Z=15; // This much of the nosecone becomes part of the fairing.
NC_Base=5;
NC_Lock_OD=Fairing_ID-6; // Nosecone locking ring.
NC_Lock_ID=NC_Lock_OD-6;

Fairing_Len=100; // Body of the fairing. Overall len is Fairing_Len + NC_Base + NoseconeSep_Z






























