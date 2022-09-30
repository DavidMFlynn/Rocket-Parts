// ***********************************
// Project: 3D Printed Rocket
// Filename: Fairing.scad
// Created: 8/5/2022 
// Revision: 1.0.3  9/30/2022
// Units: mm
// ***********************************
//  ***** Notes *****
//
// I printed and tested this.
// It will get refined when another one gets built.
// 
// Parts:
// SG90 microservo, 9V Battery, Electronic module
// Spring 5/16"OD x 1-1/4" Free Length (2 Req.)
// Cable puller parts set (3D printed)
// #4-40 x 3/4" Socket head cap screws (4 Req.)
// 4mm ID x 8mm OD x 3mm Bearing (5 Req.)
// 1/32" Wire Rope (8")
// Wire rope ends (5 Req.)
// M4 Set screws or 4mm undersize dowels (3 Req.)
// M4 x 15mm Button head machine screw
// Bell crank
// 5/16" Delrin balls drilled for cable ends (2 Req.)
//
//  ***** History *****
//
// 1.0.3  9/30/2022  Removed BatteryHolder() see BatteryHolderLib.scad
// 1.0.2  9/2/2022   Added a glue in BatteryHolder();
// 1.0.1  8/31/2022  Code cleanup, more parametric. 
// 1.0.0  8/28/2022  It works. Needs a little cleanup. 
// 0.9.4  8/28/2022  Moved here from FairingJoint.scad 
// 0.9.3  8/25/2022  Changed fairing sample to use <CablePuller.scad> and passive joint. 
// 0.9.2  8/21/2022  Added nosecone and NoseLockRing
//
// ***********************************
//  ***** for STL output *****
//
// FairingCone();
// NoseLockRing();
//
// Sample(IsLeftHalf=true);
// Sample(IsLeftHalf=false);
//
// rotate([180,0,0]) FairingBase(); // Pring w/ support
// FairingBaseLockRing();
//
// SpringEndCap();
//
// ***********************************
//  ***** Routines *****
//
// SpringHole();
// SpringEndCapHole();
// LanyardToTube(ID=PML98Coupler_ID);
//
// ***********************************
//  ***** for Viewing *****
//
// ExplodeFairing();
//
// ***********************************

include<NoseCone.scad>
include<CablePuller.scad>
include<FairingJointLib.scad>
include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2; // Add to ID for tight fit, x2 for loose fit
$fn=$preview? 24:90;

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


module ExplodeFairing(){
	translate([0,0,Fairing_Len+NC_Base+NoseconeSep_Z+20]) color("White") FairingCone();
	translate([0,0,Fairing_Len+NC_Base+NoseconeSep_Z+14]) color("Green") NoseLockRing();
	translate([0,40,0]){
		 color("Tan") Sample(IsLeftHalf=true); 
		//translate([60,-30,50]) rotate([-90,0,0]) color("LightBlue") SpringEndCap();
		}
	translate([0,-60,0]){
		color("Tan") Sample(IsLeftHalf=false);
		translate([-60,30,50]) rotate([90,0,0]) color("LightBlue") SpringEndCap();
		}
	
	translate([0,0,-30]) color("Green") FairingBaseLockRing();
	translate([0,0,-60]) color("White") FairingBase();
} // ExplodeFairing

// ExplodeFairing();

module FairingCone(Fairing_ID=Fairing_ID, Fairing_OD=Fairing_OD, 
					NC_Base=NC_Base, FairingWall_T=FairingWall_T,
					NoseconeSep_Z=NoseconeSep_Z){
	
	difference(){
		union(){
			BluntConeNoseCone(ID=Fairing_ID, OD=Fairing_OD, L=180, 
							Base_L=NC_Base, Tip_R=15, Wall_T=FairingWall_T);
			
			// coupler ring
			difference(){
				translate([0,0,NC_Base+NoseconeSep_Z]) 
					cylinder(d1=Fairing_ID-8, d2=Fairing_ID-14, h=10, $fn=$preview? 90:360);
				
				translate([0,0,NC_Base+NoseconeSep_Z-Overlap]) 
					cylinder(d=NC_Lock_ID-2, h=4+Overlap*2, $fn=$preview? 90:360);
				translate([0,0,NC_Base+NoseconeSep_Z+4]) 
					cylinder(d1=NC_Lock_ID-2, d2=NC_Lock_ID-4,h=1, $fn=$preview? 90:360);
				translate([0,0,NC_Base+NoseconeSep_Z-Overlap]) 
					cylinder(d=NC_Lock_ID-4,h=11, $fn=$preview? 90:360);
			} // difference
		} // union

		if ($preview) translate([0,-100,-Overlap]) cube([100,100,200]);
		
		// cut off base
		translate([0,0,-Overlap]) cylinder(d=Fairing_OD+2, h=NC_Base+NoseconeSep_Z+Overlap);
	} // difference
	
	translate([0,15,NC_Base+NoseconeSep_Z+20]) rotate([-18.5,0,0]) LanyardToTube(ID=Fairing_ID);
} // FairingCone

// translate([0,0,Fairing_Len+Overlap]) FairingCone();

module NoseLockRing(NC_Lock_OD=NC_Lock_OD, NC_Lock_ID=NC_Lock_ID){
	difference(){
		union(){
			cylinder(d=NC_Lock_OD, h=1, $fn=$preview? 90:360);
			translate([0,0,1-Overlap]) 
				cylinder(d1=NC_Lock_OD, d2=NC_Lock_ID-IDXtra*2, h=4+Overlap*2, $fn=$preview? 90:360);
			cylinder(d=NC_Lock_ID-IDXtra*2, h=7, $fn=$preview? 90:360);
			cylinder(d=NC_Lock_ID-2-IDXtra, h=8+4, $fn=$preview? 90:360);
		} // union
		translate([0,0,-Overlap]) cylinder(d=NC_Lock_ID-IDXtra*2-6, h=20, $fn=$preview? 90:360);
	} // difference
} // NoseLockRing

//translate([0,0,Fairing_Len+NC_Base+7]) NoseLockRing();


module FairingBase(BaseXtra=17, Fairing_OD=Fairing_OD, Fairing_ID=Fairing_ID,
					BodyTubeOD=PML98Body_OD, 
					CouplerTube_OD=PML98Coupler_OD, CouplerTube_ID=PML98Coupler_ID){
	
	Trans_r=4;				
	Len=6+Trans_r;
						
	BodyTubeSocket_L=15;
						
	difference(){
		union(){
			Tube(OD=Fairing_OD, ID=Fairing_ID, Len=Len, myfn=$preview? 36:360);
			
			hull(){
				rotate_extrude() translate([Fairing_OD/2-4,0,0]) circle(r=Trans_r);
				translate([0,0,-BodyTubeSocket_L-BaseXtra]) cylinder(d=BodyTubeOD, h=Overlap);
			} // hull
		} // union
		
		translate([0,0,-BodyTubeSocket_L-BaseXtra-Overlap]) 
			cylinder(d=CouplerTube_OD, h=BodyTubeSocket_L+2);
		translate([0,0,-BodyTubeSocket_L-BaseXtra-Overlap]) 
			cylinder(d=CouplerTube_ID, h=BodyTubeSocket_L+BaseXtra+Len);
		if (BaseXtra>0)
		translate([0,0,4-BaseXtra-Overlap])
			cylinder(d1=CouplerTube_ID, d2=Fairing_ID-6, h=BaseXtra+Overlap*2);
	} // difference
} // FairingBase

//translate([0,0,-10]) FairingBase();

module FairingBaseLockRing(Fairing_ID=Fairing_ID){
	Base_h=4;
	OA_h=9;
	
	difference(){
		union(){
			// glue flange
			cylinder(d=Fairing_ID-IDXtra, h=Base_h, $fn=$preview? 90:360);
			
			// Backbone
			cylinder(d=Fairing_ID-6-IDXtra*2, h=OA_h, $fn=$preview? 90:360);
			
			// 45° locking face
			translate([0,0,OA_h-4+Overlap]) 
				cylinder(d1=Fairing_ID-6-IDXtra*2,d2=Fairing_ID-2-IDXtra*2, h=2, $fn=$preview? 90:360);
			
			// 2mm top stiffener
			translate([0,0,OA_h-2]) 
				cylinder(d=Fairing_ID-2-IDXtra*2, h=2, $fn=$preview? 90:360);
		} // union
		
		// center hole
		translate([0,0,-Overlap]) cylinder(d=Fairing_ID-10, h=OA_h+Overlap*2);
	} // difference
} // FairingBaseLockRing

//translate([0,0,-5]) color("Tan") FairingBaseLockRing();


module SpringHole(){
	cylinder(d=Spring_OD, h=Spring_FL, center=true);
	cylinder(d=Spring_OD+IDXtra*3, h=Spring_FL-4, center=true);
} // SpringHole

// SpringHole();

module SpringEndCap(){
	difference(){
		cylinder(d=SpringEndCap_OD, h=Spring_FL/2+2);
		
		translate([0,0,Spring_FL/2+1]) SpringHole();
	} // difference
} // SpringEndCap

//SpringEndCap();

module SpringEndCapHole(){
	SpringHole();
	cylinder(d=SpringEndCap_OD+IDXtra*2, h=Spring_FL-6, center=true);
} // SpringEndCapHole

//SpringEndCapHole();

module LanyardToTube(ID=PML98Coupler_ID){
	LTY_h=30;
	LTY_w=6;
	LTY_y=7;
	Slot_h=10;
	Slot_y=3;
	
	difference(){
		hull(){
			translate([-LTY_w/2,-ID/2-Overlap,-LTY_h/2]) cube([LTY_w,1,LTY_h]);
			translate([-LTY_w/2,-ID/2+LTY_y,-LTY_h/2+LTY_y])
				cube([LTY_w,Overlap,LTY_h-LTY_y*2]);
		} // hull
		
		hull(){
			translate([-LTY_w/2-Overlap,-ID/2,-Slot_h/2-Slot_y]) 
				cube([LTY_w+Overlap*2,1,Slot_h+Slot_y*2]);
			translate([-LTY_w/2-Overlap,-ID/2+LTY_y-3,-Slot_h/2])
				cube([LTY_w+Overlap*2,Overlap,Slot_h]);
		} // hull
		
		difference(){
			translate([0,0,-LTY_h/2-Overlap]) cylinder(d=ID+10, h=LTY_h+Overlap*2);
			translate([0,0,-LTY_h/2-Overlap*2]) cylinder(d=ID+1, h=LTY_h+Overlap*4);
		} // difference
	} // difference
} // LanyardToTube

// LanyardToTube();

module Sample(IsLeftHalf=true){
	M_H=12;
	Len=Fairing_Len;
	Wall_T=FairingWall_T;
	Z1=15;
	Z2=Len-Z1;
	
	
	// first 20mm of nosecone half
	difference(){
		union(){
			translate([0, 0, Len-Overlap]) BluntConeNoseCone(ID=Fairing_ID, OD=Fairing_OD, L=180, 
							Base_L=NC_Base, Tip_R=15, Wall_T=FairingWall_T);
			
			if (IsLeftHalf){
				translate([0, 0, Len-Overlap]) PJ_CCW(Fairing_OD=Fairing_OD, Len=NC_Base);
			}else{
				
			}
			// Nosecone retention
			translate([0,0,Len+NC_Base])
			difference(){
				cylinder(d1=Fairing_ID+1, d2=NC_Lock_OD, h=NoseconeSep_Z, $fn=$preview? 90:360);
				
				translate([0,0,-Overlap]) cylinder(d=NC_Lock_ID, h=16, $fn=$preview? 90:360);
				translate([0,0,-Overlap]) cylinder(d1=Fairing_ID+7, d2=NC_Lock_ID, h=12, $fn=$preview? 90:360);
			} // difference
		} // union
		
		translate([0, 0, Len+NC_Base+NoseconeSep_Z]) cylinder(d=Fairing_OD, h=180);
		
		if (IsLeftHalf){
			translate([0, 0, Len-Overlap]) PJ_CCW_Slot(Fairing_OD=Fairing_OD, Len=NC_Base);
			translate([-Fairing_OD/2-1, 0, Len-Overlap*2]) 
				mirror([0,1,0]) cube([Fairing_OD+2, Fairing_OD/2+2, 21]);
		} else {
			translate([-Fairing_OD/2-1, 0, Len-Overlap*2]) 
				cube([Fairing_OD+2, Fairing_OD/2+2, 21]);
		}
	} // difference
	
	// half a tube w/ stiffeners
	difference(){
		union(){
			Tube(OD=Fairing_OD, ID=Fairing_ID, Len=Len, myfn=$preview? 36:360);
			
			if (IsLeftHalf){
				translate([0,0,5]) PJ_CCW(Fairing_OD=Fairing_OD, Len=Len-5);
				translate([-Fairing_ID/2-Overlap,0,0]) cube([3,9,Len+9]);
			} else {
				mirror([0,1,0]) translate([-Fairing_ID/2-Overlap,0,0]) cube([3,9,Len+9]);
			}
			
			
			// Fairing base interface
			cylinder(d=Fairing_ID+Overlap, h=3);
		} // union
	
		translate([0,0,5]) PJ_CCW_Slot(Fairing_OD=Fairing_OD, Len=Len-5);
		
		// Fairing base interface
		translate([0,0,-Overlap]) cylinder(d=Fairing_ID-6, h=3+Overlap);
		translate([0,0,1]) cylinder(d1=Fairing_ID-6, d2=Fairing_ID-2, h=2+Overlap);
		translate([0,0,3]) cylinder(d=Fairing_ID-1, h=2+Overlap);
		
		// cut in half
		if (IsLeftHalf){
			translate([-Fairing_OD/2-1, 0, -Overlap]) 
				mirror([0,1,0]) cube([Fairing_OD+2, Fairing_OD/2+2, Len+Overlap*2]);
		} else {
			translate([-Fairing_OD/2-1, 0, -Overlap]) 
				cube([Fairing_OD+2, Fairing_OD/2+2, Len+Overlap*2]);
		}
		
		
		translate([-Fairing_OD/2+8.5,6.5-Overlap,Z1]) rotate([0,0,90]) MortiseBox(Mortise_h=M_H);
		translate([-Fairing_OD/2+8.5,6.5-Overlap,Z2]) rotate([0,0,90]) MortiseBox(Mortise_h=M_H);
		
	} // difference
	
	if (IsLeftHalf==false) translate([0,0,5]) PJ_CW(Fairing_OD=Fairing_OD, Len=Len-5+NC_Base);
	
	SpringInset=6.5;
	PJ_Spacing=22;
	// Sockets and Tenons
	difference(){
		union(){
			if (IsLeftHalf){
				translate([-Fairing_OD/2+8.5,6.5,Z1]) rotate([0,0,90]) Socket(H=M_H);
				translate([-Fairing_OD/2+8.5,6.5,Z2]) rotate([0,0,90]) Socket(H=M_H);
				
				SpringStop_Len=13;
				mirror([1,0,0]) 
					translate([Fairing_ID/2-SpringEndCap_OD/2-2,SpringStop_Len,Len/2])
						hull(){
							rotate([90,0,0]) cylinder(d=SpringEndCap_OD+4, h=SpringStop_Len);
							sphere(d=SpringEndCap_OD+4);
							
							translate([7,0,0]){
								rotate([90,0,0]) cylinder(d=SpringEndCap_OD+10,h=SpringStop_Len);
								sphere(d=SpringEndCap_OD+10);}
						} // hull
						
				translate([0,0,12.5+PJ_Spacing]) PJ_Clip(Fairing_OD=Fairing_OD);
				translate([0,0,12.5+PJ_Spacing*3]) PJ_Clip(Fairing_OD=Fairing_OD);
						
				rotate([0,0,-45]) translate([-Fairing_ID/2+8,0,Len-65]) 
						rotate([0,-90,0]) CablePullerBoltPattern() cylinder(d=8, h=15);
				
			} else {
				rotate([0,0,180]) SkirtedTenon(Tube_OD=Fairing_OD, Z=Z1);
				rotate([0,0,180]) SkirtedTenon(Tube_OD=Fairing_OD, Z=Z2);
				
				rotate([0,0,180])
					translate([Fairing_ID/2-SpringEndCap_OD/2-3,Spring_FL/2+SpringInset,Len/2])
						hull(){
							rotate([90,0,0]) cylinder(d=SpringEndCap_OD+4, h=Spring_FL/2+SpringInset);
							sphere(d=SpringEndCap_OD+4);
							
							translate([7,0,0]){
							rotate([90,0,0]) cylinder(d=SpringEndCap_OD+10,h=Spring_FL/2+SpringInset);
							sphere(d=SpringEndCap_OD+10);}
						} // hull	
						
				translate([0,0,12.5]) rotate([180,0,0]) PJ_Clip(Fairing_OD=Fairing_OD);
				translate([0,0,12.5+PJ_Spacing*2]) rotate([180,0,0]) PJ_Clip(Fairing_OD=Fairing_OD);
				translate([0,0,12.5+PJ_Spacing*4]) rotate([180,0,0]) PJ_Clip(Fairing_OD=Fairing_OD);
			} // if
		} // union
		
		// Spring
		if (IsLeftHalf==false){
			rotate([0,0,180])
				translate([Fairing_ID/2-SpringEndCap_OD/2-3,SpringInset,Len/2]) 
					rotate([90,0,0]) SpringEndCapHole();
		}
		
		if (IsLeftHalf)
		rotate([0,0,-45]) translate([-Fairing_ID/2+8,0,Len-65]) 
						rotate([0,-90,0]) CablePullerBoltPattern() rotate([180,0,0]) Bolt4Hole();
		// cable path
		translate([-Fairing_ID/2+SpringEndCap_OD/2+2,6.5,Len/2]) cylinder(d=9, h=20, center=true);
		
		// Trim all to outside of fairing
		difference(){
			translate([0,0,-Overlap]) cylinder(d=Fairing_OD+25,h=Len+Overlap*2);
			
			
			translate([0,0,-Overlap*2]) 
				cylinder(d=Fairing_OD,h=Len+Overlap*4, $fn=$preview? 36:360);
		} // difference
	} // difference
	
	if (IsLeftHalf) {
		translate([0,0,20]) rotate([0,0,110]) LanyardToTube(ID=Fairing_ID);
	} else {
		translate([0,0,20]) rotate([0,0,110+180]) LanyardToTube(ID=Fairing_ID);
	}
	
	// Bellcrank pivot, etc. 
	//rotate([0,0,-45]) translate([-Fairing_ID/2+15,0,60]) cylinder(d=2, h=50);
	//rotate([0,0,-6]) translate([-Fairing_ID/2+7,0,60]) cylinder(d=2, h=50);
	
	//rotate([0,0,-4.4-19.5]) translate([-Fairing_ID/2+15,0,100]) rotate([0,0,-12.8])
	//	rotate([-90,0,0]) cylinder(d=2, h=38, center=true);
	
	
	BellCrank_Z=104;
	/*
	if ($preview)
	rotate([0,0,-4.4-19.5]) translate([-Fairing_ID/2+15-3,0,BellCrank_Z]) rotate([0,0,-12.8])
		rotate([90,0,90]) rotate([0,0,15]) BellCrank(Len=38);
	*/
	if (IsLeftHalf)
	difference(){
		hull(){
			rotate([0,0,-4.4-19.5]) translate([-Fairing_ID/2+14,0,BellCrank_Z]) rotate([0,0,-12.8])
				rotate([0,-90,0]) translate([0,0,3]) cylinder(d=14, h=8);
			
			rotate([0,0,-4.4-19.5]) translate([-Fairing_ID/2+14,0,BellCrank_Z]) 
				rotate([0,-90,0])  translate([0,0,13.8]) cylinder(d=16, h=Overlap);
			
			rotate([0,0,-4.4-19.5-2]) translate([-Fairing_ID/2+14,0,BellCrank_Z]) 
				rotate([0,-90,0])  translate([0,0,13.8]) cylinder(d=16, h=Overlap);
		} // hull
		
		rotate([0,0,-4.4-19.5]) translate([-Fairing_ID/2+14,0,BellCrank_Z]) rotate([0,0,-12.8])
			rotate([0,-90,0]) translate([0,0,3]) rotate([180,0,0]) Bolt8Hole();
	} // difference
} // Sample

//Sample(IsLeftHalf=true);

//Sample(IsLeftHalf=false);





















