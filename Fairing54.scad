// ***********************************
// Project: 3D Printed Rocket
// Filename: Fairing54.scad
// Created: 8/5/2022 
// Revision: 1.0.10  9/29/2022
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
echo("Fairing54 1.0.10");
// 1.0.10  9/29/2022 Added FairingBaseBulkPlate. 
// 1.0.9  9/24/2022  Small improvements.
// 1.0.8  9/23/2022  Reworked the spring parts. Yet another try to fix the coupler.
// 1.0.7  9/22/2022  Spring hole made 1.5mm deeper. 
// 1.0.6  9/21/2022  Fix: Added 1mm to FairingBaseLockRing
// 1.0.5  9/18/2022  Standardizing FairingConeBaseRing
// 1.0.4  9/8/2022   Made more parametric and renamed with F54_ prefix
// 1.0.3  9/3/2022   Copied from Fairing.scad
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
// NoseLockRing(Fairing_ID =Fairing_ID);
//
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
// rotate([180,0,0]) FairingBase(); // Pring w/ support
// FairingBaseLockRing(Tube_ID=Fairing_ID, Fairing_ID=Fairing_ID, Interface=-IDXtra);
// FairingBaseBulkPlate(Tube_ID=Fairing_ID, Fairing_ID=Fairing_ID, ShockCord_a=-90);
//
// F54_SpringEndCap();
//
// ***********************************
//  ***** Routines *****
//
// FairingConeBaseRing(Fairing_OD=Fairing_OD, FairingWall_T=FairingWall_T, NC_Base=NC_Base, NC_Wall_t=NC_Wall_t);
// F54_SpringHole();
// F54_SpringEndCapHole();
// LanyardA();
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
//include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2; // Add to ID for tight fit, x2 for loose fit
$fn=$preview? 24:90;

// Lighter spring
F54_Spring_OD=5/16*25.4;
F54_Spring_FL=32;
F54_Spring_CBL=14;
F54_SpringEndCap_OD=F54_Spring_OD+3;

Fairing_OD=PML54Body_OD;
FairingWall_T=2.2;
Fairing_ID=Fairing_OD-FairingWall_T*2;
Fairing_Len=130;

NC_Len=90;
NC_Tip_r=7;
NC_Base=5;
NC_Wall_t=2.2;
NC_Lock_H=5;
function NC_Lock_OD(ID) = ID-IDXtra*2; // Nosecone locking ring.
function NC_Lock_ID(ID) = ID-6-IDXtra*2;
//NC_Lock_OD=Fairing_ID; 
//NC_Lock_ID=NC_Lock_OD-6;

//echo(Fairing_OD=Fairing_OD);

module ExplodeFairing(){
	translate([0,0,Fairing_Len+20]) color("White") FairingCone();
	translate([0,0,Fairing_Len+14]) color("Green") NoseLockRing();
	translate([0,40,0]){
		 color("Tan") F54_FairingHalf(IsLeftHalf=true); 
		//translate([60,-30,50]) rotate([-90,0,0]) color("LightBlue") F54_SpringEndCap();
		}
	translate([0,-60,0]){
		color("Tan") F54_FairingHalf(IsLeftHalf=false);
		translate([-60,30,50]) rotate([90,0,0]) color("LightBlue") F54_SpringEndCap();
		}
	
	translate([0,0,-30]) color("Green") FairingBaseLockRing();
	translate([0,0,-60]) color("White") FairingBase();
} // ExplodeFairing

// ExplodeFairing();

module FairingConeBaseRing(Fairing_OD=Fairing_OD, 
							FairingWall_T=FairingWall_T, 
							NC_Base=NC_Base, 
							NC_Wall_t=NC_Wall_t){
	
	Fairing_ID=Fairing_OD-FairingWall_T*2;
	
	difference(){
		cylinder(d=Fairing_OD-NC_Wall_t*2+Overlap, h=NC_Base+3, $fn=$preview? 90:360);
				
		translate([0,0,-Overlap]) 
			cylinder(d=NC_Lock_ID(Fairing_ID), h=NC_Base+Overlap*2, $fn=$preview? 90:360);
		translate([0,0,NC_Base-Overlap]) 
			cylinder(d1=NC_Lock_ID(Fairing_ID), d2=Fairing_ID,h=3+Overlap*2, $fn=$preview? 90:360);
			} // difference
} // FairingConeBaseRing

/*
FairingConeBaseRing(Fairing_OD=5.5*25.4, 
							FairingWall_T=2.2, 
							NC_Base=10, 
							NC_Wall_t=2.2);
/**/

module NoseLockRing(Fairing_ID =Fairing_ID){
	
	NC_Lock_ID=NC_Lock_ID(Fairing_ID);
	NC_Lock_OD=NC_Lock_OD(Fairing_ID);
	NC_Lock_H=NC_Lock_H;
	
	//echo(NC_Lock_OD=NC_Lock_OD);
	//echo(Fairing_ID=Fairing_ID);
	
	difference(){
		union(){
			// end stiffener
			cylinder(d=Fairing_ID-1, h=1+Overlap, $fn=$preview? 90:360);
			
			// Mating surface
			intersection(){
				translate([0,0,1]) 
					cylinder(d1=NC_Lock_OD, d2=NC_Lock_ID, h=NC_Lock_H-1, $fn=$preview? 90:360);
				
				// Trim end
				cylinder(d=Fairing_ID-1, h=10, $fn=$preview? 90:360);
			} // intersection
			
			
			cylinder(d=NC_Lock_ID, h=NC_Lock_H+5, $fn=$preview? 90:360);
		} // union
		
		translate([0,0,-Overlap]) 
			cylinder(d1=NC_Lock_ID-IDXtra*2, d2=NC_Lock_ID-IDXtra*2-4, h=4, $fn=$preview? 90:360);
		
		translate([0,0,-Overlap]) cylinder(d=NC_Lock_ID-IDXtra*2-4, h=20, $fn=$preview? 90:360);
	} // difference
} // NoseLockRing

//translate([0,0,Fairing_Len-NC_Lock_H-0.4]) NoseLockRing(Fairing_ID =Fairing_ID);
//translate([0,0,5.4]) rotate([180,0,0]) NoseLockRing(Fairing_ID =Fairing_ID);
//translate([0,0,5])mirror([0,0,1])translate([0,0,5]) F54_Retainer(IsLeftHalf=true, NC_Lock_H=NC_Lock_H, Fairing_OD=Fairing_OD, Wall_T=FairingWall_T);


module FairingConeOGive(Fairing_OD=Fairing_OD, 
					FairingWall_T=FairingWall_T,
					NC_Base=NC_Base, 
					NC_Len=130, 
					NC_Wall_t=NC_Wall_t,
					NC_Tip_r=NC_Tip_r){
	
	Fairing_ID=Fairing_OD-FairingWall_T*2;
						
	difference(){
		union(){
			BluntOgiveNoseCone(ID=Fairing_ID, OD=Fairing_OD, L=NC_Len, 
						Base_L=NC_Base, Tip_R=NC_Tip_r, Wall_T=NC_Wall_t);
			
			// coupler ring
			FairingConeBaseRing(Fairing_OD=Fairing_OD, FairingWall_T=FairingWall_T,
					NC_Base=NC_Base, NC_Wall_t=NC_Wall_t);
			
		} // union

		// Cut in half for viewing
		if ($preview) translate([0,-100,-Overlap]) cube([100,100,200]);
		
	} // difference
	
	translate([0,0,NC_Base+18]) rotate([-4,0,0]) LanyardToTube(ID=Fairing_ID);
} // FairingConeOGive

//translate([0,0,Fairing_Len+Overlap]) FairingConeOGive(); 
/*
FairingConeOGive(Fairing_OD=PML75Body_OD, 
					FairingWall_T=FairingWall_T,
					NC_Base=NC_Base, 
					NC_Len=190, 
					NC_Wall_t=NC_Wall_t,
					NC_Tip_r=5);
/**/
/*
FairingConeOGive(Fairing_OD=PML54Body_OD, 
					FairingWall_T=2.2,
					NC_Base=5, 
					NC_Len=130, 
					NC_Wall_t=2,
					NC_Tip_r=5);
/**/



module FairingCone(Fairing_OD=Fairing_OD, 
					FairingWall_T=FairingWall_T,
					NC_Base=NC_Base, 
					NC_Len=NC_Len,
					NC_Wall_t=NC_Wall_t,
					NC_Tip_r=NC_Tip_r){
	
	Fairing_ID=Fairing_OD-FairingWall_T*2;
						
	difference(){
		union(){
			BluntConeNoseCone(ID=Fairing_ID, OD=Fairing_OD, L=NC_Len, 
							Base_L=NC_Base, Tip_R=NC_Tip_r, Wall_T=NC_Wall_t);
			
			// coupler ring
			FairingConeBaseRing(Fairing_OD=Fairing_OD, FairingWall_T=FairingWall_T,
					NC_Base=NC_Base, NC_Wall_t=NC_Wall_t);
			
		} // union

		if ($preview) translate([0,-100,-Overlap]) cube([100,100,200]);
		
	} // difference
	
	Lanyard_a=asin((Fairing_OD/2-NC_Wall_t-NC_Tip_r)/(NC_Len-NC_Base-NC_Tip_r));
	//echo(Lanyard_a=Lanyard_a);
	translate([0,-Fairing_OD/2+NC_Wall_t/2,NC_Base]) 
		rotate([-Lanyard_a,0,0]) translate([0,0,20]) LanyardA();
	
} // FairingCone

// translate([0,0,Fairing_Len+Overlap]) FairingCone();
/*
FairingCone(Fairing_OD=BP_Fairing_OD, 
					FairingWall_T=BP_FairingWall_T,
					NC_Base=BP_FairingConeBase, 
					NC_Len=BP_FairingCone_Len,
					NC_Wall_t=BP_FairingConeWall_T,
					NC_Tip_r=BP_FairingConeTip_r);

BP_Fairing_OD=5.5*25.4;
BP_FairingWall_T=2.2;
BP_FairingConeBase=10;
BP_FairingCone_Len=190;
BP_FairingConeWall_T=2.2; // may need to be thicker
BP_FairingConeTip_r=7.5;
/**/
/*
FairingCone(Fairing_OD=PML54Body_OD, 
					FairingWall_T=2.2,
					NC_Base=5, 
					NC_Len=90, 
					NC_Wall_t=2,
					NC_Tip_r=5);
/**/
/*
FairingCone(Fairing_OD=PML98Body_OD, 
					FairingWall_T=2.2,
					NC_Base=5, 
					NC_Len=180, 
					NC_Wall_t=2,
					NC_Tip_r=5);
/**/


module FairingBase(BaseXtra=0, Fairing_OD=Fairing_OD, Fairing_ID=Fairing_ID,
					BodyTubeOD=PML54Body_OD, 
					CouplerTube_OD=PML54Coupler_OD, CouplerTube_ID=PML54Coupler_ID){
	
	Trans_r=4;				
	Len=6+Trans_r;
						
	BodyTubeSocket_L=15;
						
	difference(){
		union(){
			Tube(OD=Fairing_OD, ID=Fairing_ID, Len=Len, myfn=$preview? 36:360);
			
			if (Fairing_OD>BodyTubeOD)
			hull(){
				rotate_extrude() translate([Fairing_OD/2-4,0,0]) circle(r=Trans_r);
				translate([0,0,-BodyTubeSocket_L-BaseXtra]) cylinder(d=BodyTubeOD, h=Overlap);
			} // hull
			else 
				translate([0,0,-BodyTubeSocket_L-BaseXtra]) 
					cylinder(d=BodyTubeOD, h=BodyTubeSocket_L+BaseXtra+Overlap, $fn=$preview? 36:360);
				
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

module FairingBaseBulkPlate(Tube_ID=Fairing_ID, Fairing_ID=Fairing_ID, ShockCord_a=-90){
	// Stops the parchute from falling into the E-Bay
	
	nTabs=(Fairing_ID>90)? 16:10;
	Plate_h=(Fairing_ID>90)? 2.5:2;
	NC_Lock_OD=NC_Lock_OD(Fairing_ID);
	NC_Lock_ID=NC_Lock_ID(Fairing_ID);
	NC_Lock_H=NC_Lock_H;
	Base_h=5;

	difference(){
		union(){
			difference(){
				translate([0,0,5]) 
					cylinder(d1=NC_Lock_ID-IDXtra*5-4, d2=Tube_ID-IDXtra*3-4, h=Base_h, $fn=$preview? 90:360);
				translate([0,0,6]) cylinder(d=Tube_ID, h=10);
			} // difference
			cylinder(d=NC_Lock_ID-IDXtra*5-4, h=5, $fn=$preview? 90:360);
			cylinder(d1=NC_Lock_ID-IDXtra*5, d2=NC_Lock_ID-IDXtra*5-4, h=4, $fn=$preview? 90:360);
			translate([0,0,6-Overlap]) cylinder(d=NC_Lock_ID-IDXtra*5-2.4, h=1, $fn=$preview? 90:360);
		} // union
		
		// Center
		translate([0,0,Plate_h]) cylinder(d=NC_Lock_ID-IDXtra*5-8,h=10, $fn=$preview? 90:360);
		
		// Shock cord
		rotate([0,0,ShockCord_a]) translate([NC_Lock_ID/2,0,-Overlap]) RoundRect(X=15, Y=20, Z=20, R=4);
		
		// Cable Path
		translate([NC_Lock_ID/2,0,-Overlap]) RoundRect(X=14, Y=12, Z=20, R=5);
		
		// Make it snap in
		for (j=[0:nTabs-1]) rotate([0,0,360/nTabs*j]) translate([0,0,Plate_h+0.3]) cube([NC_Lock_ID/2,1.5,10]);
	} // difference
	
} // FairingBaseBulkPlate

//FairingBaseBulkPlate(Tube_ID=PML75Body_ID, Fairing_ID=PML75Body_OD-4.4, ShockCord_a=-135);

module FairingBaseLockRing(Tube_ID=Fairing_ID, Fairing_ID=Fairing_ID, Interface=-IDXtra){
				
	NC_Lock_OD=NC_Lock_OD(Fairing_ID);
	NC_Lock_ID=NC_Lock_ID(Fairing_ID);
	NC_Lock_H=NC_Lock_H;
					
	Base_h=5;
	OA_h=10;
	
	Adjustment=0.6;
	
	
	difference(){
		union(){
			// glue flange
			cylinder(d=Tube_ID+Interface, h=Base_h-Adjustment, $fn=$preview? 90:360);
			
			translate([0,0,OA_h]) mirror([0,0,1])
				NoseLockRing(Fairing_ID=Fairing_ID);
		} // union
			
		
		// center hole
		translate([0,0,-Overlap]) cylinder(d=NC_Lock_ID-IDXtra*2-4, h=OA_h+Overlap*2);
		
		// Chamfer
		translate([0,0,-Overlap]) 
				cylinder(d2=NC_Lock_ID-IDXtra*2-4, d1=Tube_ID-4, h=Base_h, $fn=$preview? 90:360);
	} // difference
} // FairingBaseLockRing

//FairingBaseLockRing(Tube_ID=PML75Body_ID, Fairing_ID=PML75Body_OD-4.4, Interface=Overlap);
//translate([0,0,0]) mirror([0,0,1]) F54_Retainer(IsLeftHalf=true, Fairing_OD=Fairing_OD, Wall_T=FairingWall_T);
//translate([0,0,-5]) color("Tan") FairingBaseLockRing(Tube_ID=PML54Body_ID, Fairing_ID=Fairing_ID, Interface=Overlap);
//FairingBaseLockRing(Tube_ID=BP_Booster_Body_ID, 
//		Fairing_ID=BP_Booster_Fairing_ID, Interface=Overlap);
//translate([0,0,10]) NoseLockRing(Fairing_ID=Fairing_ID);


// This is the female half
module F54_Retainer(IsLeftHalf=true, Fairing_OD=Fairing_OD, Wall_T=FairingWall_T){
	NC_Lock_H=NC_Lock_H;
	Fairing_ID=Fairing_OD-Wall_T*2;		
	
	difference(){	
			// Nosecone retention
			translate([0,0,-NC_Lock_H])
			difference(){
				cylinder(d=Fairing_OD-1, h=NC_Lock_H, $fn=$preview? 90:360);
				
				// Center hole
				translate([0,0,-Overlap]) 
					cylinder(d=NC_Lock_ID(Fairing_ID)+1, h=NC_Lock_H+Overlap*2, $fn=$preview? 90:360);
				
				translate([0,0,-Overlap]) 
					cylinder(d=Fairing_ID, h=0.6+Overlap*2, $fn=$preview? 90:360);
				
				// Blend into fairing
				translate([0,0,0.6]) 
					cylinder(d1=Fairing_ID, d2=NC_Lock_OD(Fairing_ID), h=0.4+Overlap, $fn=$preview? 90:360);
				
				// Gripping surface
				translate([0,0,1]) 
					cylinder(d1=NC_Lock_OD(Fairing_ID), d2=NC_Lock_ID(Fairing_ID), h=NC_Lock_H-1, $fn=$preview? 90:360);
			} // difference

		
		if (IsLeftHalf){
			translate([-Fairing_OD/2-1, 0, -NC_Lock_H-Overlap]) 
				mirror([0,1,0]) cube([Fairing_OD+2, Fairing_OD/2+2, NC_Lock_H+Overlap*2]);
		} else {
			translate([-Fairing_OD/2-1, 0, -NC_Lock_H-Overlap]) 
				cube([Fairing_OD+2, Fairing_OD/2+2, NC_Lock_H+Overlap*2]);
		}
	} // difference
} // F54_Retainer

//mirror([0,0,1]) F54_Retainer(IsLeftHalf=true, Fairing_OD=Fairing_OD, Wall_T=FairingWall_T);

module F54_SpringHole(){
	cylinder(d=F54_Spring_OD, h=F54_Spring_FL, center=true);
	cylinder(d=F54_Spring_OD+IDXtra*3, h=F54_Spring_FL-4, center=true);
} // F54_SpringHole

// F54_SpringHole();

module F54_SpringEndCap(){
	difference(){
		cylinder(d=F54_SpringEndCap_OD, h=F54_Spring_CBL);
		
		translate([0,0,1]) cylinder(d=F54_Spring_OD, h=F54_Spring_CBL);
		translate([0,0,2.5]) cylinder(d=F54_Spring_OD+IDXtra*2, h=F54_Spring_CBL);
	} // difference
} // F54_SpringEndCap

//F54_SpringEndCap();

module F54_SpringEndCapHole(){
	cylinder(d=F54_Spring_OD, h=F54_Spring_CBL+3);
	cylinder(d=F54_SpringEndCap_OD+IDXtra*3, h=F54_Spring_CBL+1.5);
} // F54_SpringEndCapHole

//F54_SpringEndCapHole();

module LanyardA(){
	LTY_h=30;
	LTY_w=6;
	LTY_y=7;
	Slot_h=10;
	Slot_y=3;
	
	difference(){
		hull(){
			translate([-LTY_w/2,0,-LTY_h/2]) cube([LTY_w,1,LTY_h]);
			translate([-LTY_w/2,LTY_y,-LTY_h/2+LTY_y])
				cube([LTY_w,Overlap,LTY_h-LTY_y*2]);
		} // hull
		
		translate([0,-Overlap,0])
		hull(){
			translate([-LTY_w/2-Overlap,0,-Slot_h/2-Slot_y]) 
				cube([LTY_w+Overlap*2,1,Slot_h+Slot_y*2]);
			translate([-LTY_w/2-Overlap,LTY_y-3,-Slot_h/2])
				cube([LTY_w+Overlap*2,Overlap,Slot_h]);
		} // hull
		
		
	} // difference
} // LanyardA

//LanyardA();

module LanyardToTube(ID=PML98Coupler_ID){
	LTY_h=30;
	LTY_w=6;
	LTY_y=7;
	Slot_h=10;
	Slot_y=3;
	
	difference(){
		translate([0,-ID/2-Overlap,0]) LanyardA();
		
		
		difference(){
			translate([0,0,-LTY_h/2-Overlap]) cylinder(d=ID+10, h=LTY_h+Overlap*2);
			translate([0,0,-LTY_h/2-Overlap*2]) cylinder(d=ID+1, h=LTY_h+Overlap*4);
		} // difference
	} // difference
} // LanyardToTube

// LanyardToTube();

module F54_FairingHalf(IsLeftHalf=true, 
				Fairing_OD=Fairing_OD,
				Wall_T=FairingWall_T,
				Len=Fairing_Len,
				HasArmingHole=true){
				
	Fairing_ID=Fairing_OD-Wall_T*2;		
	M_H=12;
	Z1=16;
	Z2=Len-Z1;
	SpringInset=0.0;
	PJ_Spacing=(Len-25)/4;
	
	module LockingBallAccessHole(H=JointPin_d){
		hull(){
			rotate([90,0,0]) cylinder(d=5, h=H);
			translate([0,0,-7]) rotate([90,0,0]) cylinder(d=5, h=H);
		} // hull
	} // LockingBallAccessHole
	
	module SpringSocket(){
		rotate([0,0,180])
				translate([Fairing_ID/2-F54_SpringEndCap_OD/2-3, SpringInset-Overlap, Len/2]) 
					rotate([-90,0,0]) F54_SpringEndCapHole();
		}

	translate([0,0,Len])			
		F54_Retainer(IsLeftHalf=IsLeftHalf, Fairing_OD=Fairing_OD, Wall_T=Wall_T);
	
	// Fairing base interface
	mirror([0,0,1])
		F54_Retainer(IsLeftHalf=IsLeftHalf, Fairing_OD=Fairing_OD, Wall_T=Wall_T);
	
	
	BallHole_X=-Fairing_OD/2+9.5;
	M_H2=16;
				
	// Ball Tube
	if (IsLeftHalf)
	difference(){
		
		translate([BallHole_X,6.5-Overlap,Z1+M_H2/2]) 
			cylinder(d=JointPin_d+5, h=Z2-Z1-M_H2);
		
		// Tube ID
		translate([BallHole_X,6.5-Overlap,Z1+M_H2/2-Overlap]) 
			cylinder(d=JointPin_d+IDXtra*4, h=Z2-Z1-M_H2+Overlap*2);
		
		// Access hole
		translate([BallHole_X,6.5-Overlap,Z2-M_H2/2])
			rotate([0,0,22.5]) LockingBallAccessHole(H=JointPin_d);
		
		translate([BallHole_X,6.5-Overlap,Z2-M_H2/2]) 
			rotate([0,0,-90]) LockingBallAccessHole(H=JointPin_d);
		
	} // difference
			
			
	// half a tube w/ stiffeners
	difference(){
		union(){
			Tube(OD=Fairing_OD, ID=Fairing_ID, Len=Len, myfn=$preview? 36:360);
			
			if (IsLeftHalf){
				translate([0,0,6]) PJ_CCW(Fairing_OD=Fairing_OD, Len=Len-NC_Lock_H-7);
				translate([-Fairing_ID/2-Overlap,0,6]) cube([3,9,Len-NC_Lock_H-7]); // extra 1mm T&B
			} else {
				mirror([0,1,0]) translate([-Fairing_ID/2-Overlap,0,6]) cube([3,9,Len-NC_Lock_H-7]);
			}
			
			
			// Fairing base interface
			//cylinder(d=Fairing_ID+Overlap, h=3);
		} // union
	
		translate([0,0,6]) PJ_CCW_Slot(Fairing_OD=Fairing_OD, Len=Len-NC_Lock_H-7);
		
		// Spring
		if (IsLeftHalf==false) SpringSocket();
			
		// cut in half
		if (IsLeftHalf){
			translate([-Fairing_OD/2-1, 0, -Overlap]) 
				mirror([0,1,0]) cube([Fairing_OD+2, Fairing_OD/2+2, Len+Overlap*2]);
		} else {
			translate([-Fairing_OD/2-1, 0, -Overlap]) 
				cube([Fairing_OD+2, Fairing_OD/2+2, Len+Overlap*2]);
		}
		
		if (IsLeftHalf){
			if (HasArmingHole) translate([BallHole_X,6.5-Overlap,Z2-M_H2/2]) 
				rotate([0,0,-90]) LockingBallAccessHole(H=10);
		
			translate([-Fairing_OD/2+8.5,6.5-Overlap,Z1]) rotate([0,0,90]) MortiseBox(Mortise_h=M_H);
			translate([-Fairing_OD/2+8.5,6.5-Overlap,Z2]) rotate([0,0,90]) MortiseBox(Mortise_h=M_H);
		}
	} // difference
	
	if (IsLeftHalf==false) translate([0,0,6]) PJ_CW(Fairing_OD=Fairing_OD, Len=Len-NC_Lock_H-7);
	
	
	// Sockets and Tenons
	difference(){
		union(){
			if (IsLeftHalf){
				translate([-Fairing_OD/2+8.5,6.5,Z1]) rotate([0,0,90]) Socket(H=M_H);
				translate([-Fairing_OD/2+8.5,6.5,Z2]) rotate([0,0,90]) Socket(H=M_H);
				
				SpringStop_Len=7;
				// The spring pushes on this. Fixed 9/24/2022
				mirror([1,0,0]) 
					translate([Fairing_ID/2-F54_SpringEndCap_OD/2-2,0,Len/2])
						hull(){
							rotate([-90,0,0]) cylinder(d=F54_SpringEndCap_OD+4, h=1);
							translate([0,SpringStop_Len,0]) sphere(d=F54_SpringEndCap_OD);
							
							translate([7,0,0]){
								rotate([-90,0,0]) cylinder(d=F54_SpringEndCap_OD+10,h=1);
								translate([0,SpringStop_Len+4,0]) sphere(d=F54_SpringEndCap_OD+4);}
						} // hull
						
				translate([0,0,12.5+PJ_Spacing]) PJ_Clip(Fairing_OD=Fairing_OD);
				translate([0,0,12.5+PJ_Spacing*3]) PJ_Clip(Fairing_OD=Fairing_OD);
						
				//rotate([0,0,-45]) translate([-Fairing_ID/2+8,0,Len-65]) 
				//		rotate([0,-90,0]) CablePullerBoltPattern() cylinder(d=8, h=15);
				
			} else {
				rotate([0,0,180]) SkirtedTenon(Tube_OD=Fairing_OD, Z=Z1);
				rotate([0,0,180]) SkirtedTenon(Tube_OD=Fairing_OD, Z=Z2);
				
				// Spring and SpringCap go in this. 
				rotate([0,0,180])
					translate([Fairing_ID/2-F54_SpringEndCap_OD/2-3,0, Len/2])
						hull(){
							#rotate([-90,0,0]) cylinder(d=F54_SpringEndCap_OD+4, h=1);
							translate([0,F54_Spring_FL/2+SpringInset,0]) sphere(d=F54_SpringEndCap_OD+4);
							
							translate([7,0,0]){
							rotate([-90,0,0]) cylinder(d=F54_SpringEndCap_OD+10,h=1);
							translate([0,F54_Spring_FL/2+4+SpringInset,0]) sphere(d=F54_SpringEndCap_OD+10);}
						} // hull	
						
				translate([0,0,12.5]) rotate([180,0,0]) PJ_Clip(Fairing_OD=Fairing_OD);
				translate([0,0,12.5+PJ_Spacing*2]) rotate([180,0,0]) PJ_Clip(Fairing_OD=Fairing_OD);
				translate([0,0,12.5+PJ_Spacing*4]) rotate([180,0,0]) PJ_Clip(Fairing_OD=Fairing_OD);
			} // if
		} // union
		
		// Spring
		if (IsLeftHalf==false) SpringSocket();
		
		// cable path
		translate([-Fairing_ID/2+F54_SpringEndCap_OD/2+2,6.5,Len/2]) cylinder(d=9, h=20, center=true);
		
		// Trim all to outside of fairing
		difference(){
			translate([0,0,-Overlap]) cylinder(d=Fairing_OD+35,h=Len+Overlap*2);
			
			
			translate([0,0,-Overlap*2]) 
				cylinder(d=Fairing_OD,h=Len+Overlap*4, $fn=$preview? 36:360);
		} // difference
	} // difference
	
	if (IsLeftHalf) {
		translate([0,0,25]) rotate([0,0,135]) LanyardToTube(ID=Fairing_ID);
	} else {
		translate([0,0,25]) rotate([0,0,135+180]) LanyardToTube(ID=Fairing_ID);
	}
	
} // F54_FairingHalf

/*
F54_FairingHalf(IsLeftHalf=true,  
				Fairing_OD=Fairing_OD,
				Wall_T=FairingWall_T,
				Len=Fairing_Len);
/**/
/*

F54_FairingHalf(IsLeftHalf=false,  
				Fairing_OD=PML98Body_OD,
				Wall_T=FairingWall_T,
				Len=Fairing_Len);
/**/



















