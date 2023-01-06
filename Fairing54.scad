// ***********************************
// Project: 3D Printed Rocket
// Filename: Fairing54.scad
// by David M. Flynn
// Created: 8/5/2022 
// Revision: 1.0.17  11/25/2022
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
echo("Fairing54 1.0.17");
// 1.0.17  11/25/2022 Added fixed stop the lock rings. FairingBaseLockRing() and NoseLockRing() have changed
// 1.0.16  11/6/2022  Added shock cord options to FairingBaseBulkPlate
// 1.0.15  10/27/2022 Added BlendToTube
// 1.0.14  10/23/2022 improved FairingAssemblyTool
// 1.0.13  10/22/2022 Added FairingAssemblyTool
// 1.0.12  10/4/2022  Added IDXtra to ID of Nosecone ring. 
// 1.0.11  10/3/2022  Fairing locks moved to 18mm from ends. 
// 1.0.10  9/29/2022  Added FairingBaseBulkPlate. 
// 1.0.9  9/24/2022   Small improvements.
// 1.0.8  9/23/2022   Reworked the spring parts. Yet another try to fix the coupler.
// 1.0.7  9/22/2022   Spring hole made 1.5mm deeper. 
// 1.0.6  9/21/2022   Fix: Added 1mm to FairingBaseLockRing
// 1.0.5  9/18/2022   Standardizing FairingConeBaseRing
// 1.0.4  9/8/2022    Made more parametric and renamed with F54_ prefix
// 1.0.3  9/3/2022    Copied from Fairing.scad
// 1.0.2  9/2/2022    Added a glue in BatteryHolder();
// 1.0.1  8/31/2022   Code cleanup, more parametric. 
// 1.0.0  8/28/2022   It works. Needs a little cleanup. 
// 0.9.4  8/28/2022   Moved here from FairingJoint.scad 
// 0.9.3  8/25/2022   Changed fairing sample to use <CablePuller.scad> and passive joint. 
// 0.9.2  8/21/2022   Added nosecone and NoseLockRing
//
// ***********************************
//  ***** for STL output *****
//
// FairingCone();
/*
FairingConeOGive(Fairing_OD=Fairing_OD, 
					FairingWall_T=FairingWall_T,
					NC_Base=NC_Base, 
					NC_Len=130, 
					NC_Wall_t=NC_Wall_t,
					NC_Tip_r=NC_Tip_r,
					Cut_Z=0, LowerPortion=false, HasLanyard=true)
/**/
// NoseLockRing(Fairing_OD=Fairing_OD, Fairing_ID =Fairing_ID);
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
// rotate([180,0,0]) FairingBase(BaseXtra=0, Fairing_OD=Fairing_OD, Fairing_ID=Fairing_ID,
//					BodyTubeOD=PML54Body_OD, 
//					CouplerTube_OD=PML54Coupler_OD, CouplerTube_ID=PML54Coupler_ID); // Pring w/ support
// FairingBaseLockRing(Tube_OD=Fairing_OD, Tube_ID=Fairing_ID, Fairing_ID=Fairing_ID, Interface=-IDXtra, BlendToTube=false);
// FairingBaseBulkPlate(Tube_ID=Fairing_ID, Fairing_ID=Fairing_ID, ShockCord_a=-100);
//
// F54_SpringEndCap();
//
//  **** Assembly Tool ****
// FairingAssemblyToolPt1(Fairing_OD=PML98Body_OD+IDXtra*2);
// FairingAssemblyToolPt2(Fairing_OD=PML98Body_OD+IDXtra*2);
// FairingAssemblyToolPt1(Fairing_OD=PML75Body_OD+IDXtra*2);
// FairingAssemblyToolPt2(Fairing_OD=PML75Body_OD+IDXtra*2);
// FairingAssemblyToolPt1(Fairing_OD=PML54Body_OD+IDXtra*2);
// FairingAssemblyToolPt2(Fairing_OD=PML54Body_OD+IDXtra*2);
// FairingAssemblyToolPt1(Fairing_OD=5.5*25.4+IDXtra*2);
// FairingAssemblyToolPt2(Fairing_OD=5.5*25.4+IDXtra*2);
// FairingAssemblyToolPt3();
// FairingAssemblyToolPt4();
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
// ShowAsmTool();
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

module FairingAssemblyToolPt1(Fairing_OD=PML98Body_OD+IDXtra*2){
	H=18;
	Thickness=10;
	Pin_d=4+IDXtra*2;
	
	difference(){
		cylinder(d=Fairing_OD+Thickness*2, h=H);
		
		// Cut
		translate([-Fairing_OD/2-Thickness-1,-Fairing_OD/2-Thickness-1, -Overlap])
			cube([Fairing_OD+Thickness*2+2,Fairing_OD/2+Thickness+1, H+Overlap*2]);
		
		// Center hole
		translate([0,0,-Overlap]) cylinder(d=Fairing_OD+IDXtra*2, h=H+Overlap*2);
		
		translate([-Fairing_OD/2-Thickness/2, 0, -Overlap]) {
			cylinder(d=Pin_d, h=H+Overlap*2);
			cylinder(d=Thickness+2, h=H/3+0.5);
			translate([0,0,H-H/3-0.5]) cylinder(d=Thickness+2, h=H/3+0.5+Overlap*2);
		}
		
		translate([Fairing_OD/2+Thickness/2, 0, -Overlap]) {
			cylinder(d=Pin_d, h=H+Overlap*2);
			cylinder(d=Thickness+2, h=H/3+0.5);
			translate([0,0,H-H/3-0.5]) cylinder(d=Thickness+2, h=H/3+0.5+Overlap*2);
		}
	} // difference
	
	translate([-Fairing_OD/2-Thickness/2, 0, H/3+0.5]) difference(){
		cylinder(d=Thickness, h=H/3-1);
		translate([0,0,-Overlap]) cylinder(d=Pin_d, h=H/3+Overlap*2);
	} // difference
	
	translate([Fairing_OD/2+Thickness/2, 0, H/3+0.5]) difference(){
		cylinder(d=Thickness, h=H/3-1);
		translate([0,0,-Overlap]) cylinder(d=Pin_d, h=H/3+Overlap*2);
	} // difference
} // FairingAssemblyToolPt1

//translate([0,0,18]) rotate([180,0,0]) FairingAssemblyToolPt1();

module FairingAssemblyToolPt2(Fairing_OD=PML98Body_OD+IDXtra*2){
	H=18;
	Thickness=10;
	Pin_d=4;
	End_a=19.5; // 54mm
	//End_a=15; // 75mm
	//End_a=12; // 98mm <<< calculation needed 
	//End_a=9; // 5.5"
	CutBack_d=50;
	
	difference(){
		cylinder(d=Fairing_OD+Thickness*2, h=H);
		
		// Cut
		translate([-Fairing_OD/2-Thickness-1,-Fairing_OD/2-Thickness-1, -Overlap])
			cube([Fairing_OD+Thickness*2+2,Fairing_OD/2+Thickness+1, H+Overlap*2]);
		
		// Center hole
		translate([0,0,-Overlap]) cylinder(d=Fairing_OD+IDXtra*2, h=H+Overlap*2);
		
		translate([-Fairing_OD/2-Thickness/2, 0, -Overlap]) {
			cylinder(d=Pin_d, h=H+Overlap*2);
			translate([0,0,H/3]) cylinder(d=Thickness+2, h=H/3);
		}
		
		translate([0,0,-Overlap]) rotate([0,0,End_a]) mirror([0,1,0]) 
			cube([Fairing_OD/2+Thickness+1,Fairing_OD/2+Thickness+1,H+Overlap*2]);
		
		rotate([0,0,End_a])
		translate([Fairing_OD/2+Thickness/2, 0, -Overlap]) {
			cylinder(d=Pin_d+IDXtra*2, h=H+Overlap*2);
			cylinder(d=Thickness+CutBack_d, h=H/3+0.5);
			translate([0,0,H-H/3-0.5]) cylinder(d=Thickness+CutBack_d, h=H/3+0.5+Overlap*2);
		}
	} // difference
	
	translate([-Fairing_OD/2-Thickness/2, 0, 0]) difference(){
		union(){
			cylinder(d=Thickness, h=H/3);
			translate([0,0,H/3*2]) cylinder(d=Thickness, h=H/3);
		} // union
		
		translate([0,0,-Overlap]) cylinder(d=Pin_d, h=H+Overlap*2);
	} // difference
	
	rotate([0,0,End_a])
	translate([Fairing_OD/2+Thickness/2, 0, H/3+0.5]) difference(){
		cylinder(d=Thickness, h=H/3-1);
		translate([0,0,-Overlap]) cylinder(d=Pin_d, h=H/3+Overlap*2);
	} // difference
} // FairingAssemblyToolPt2

//FairingAssemblyToolPt2(Fairing_OD=PML98Body_OD+IDXtra*2);

module FairingAssemblyToolPt3(){
	// the lever
	H=18;
	Thickness=10;
	Pin_d=4;
	Arm_T=4;
	Handle_Len=70;
	Pivot_Y=40;
	
	difference(){
		union(){
			translate([0,0,-Arm_T]) cylinder(d=Thickness,h=H/3+Arm_T-0.5);
			translate([0,0,H/3*2+0.5]) cylinder(d=Thickness,h=H/3+Arm_T-0.5);
			
			translate([0,0,-Arm_T])
			hull(){
				translate([0,0,0]) cylinder(d=Thickness,h=Arm_T);
				translate([0,Handle_Len,0]) cylinder(d=Thickness,h=Arm_T);
			} // hull
			
			translate([0,0,H])
			hull(){
				translate([0,0,0]) cylinder(d=Thickness,h=Arm_T);
				translate([0,Handle_Len,0]) cylinder(d=Thickness,h=Arm_T);
			} // hull
			
			translate([0,0,-1])
			hull(){
				translate([0,Handle_Len-15,0]) cylinder(d=Thickness,h=H+2);
				translate([0,Handle_Len,0]) cylinder(d=Thickness,h=H+2);
			} // hull
		} // union
		
		translate([0, 0, -Arm_T-Overlap]) 
			cylinder(d=Pin_d, h=H+Arm_T*2+Overlap*2);
		translate([0, Pivot_Y, -Arm_T-Overlap]) 
			cylinder(d=Pin_d, h=H+Arm_T*2+Overlap*2);
	} // difference
} // FairingAssemblyToolPt3

//translate([PML98Body_OD/2+5,0,0]) FairingAssemblyToolPt3();


module FairingAssemblyToolPt4(){
	// the lever
	H=18;
	Thickness=10;
	Pin_d=4;
	Arm_T=4;
	Arm_Len=30; // was 28
	
	difference(){
		union(){
			translate([0,0,0.5]) cylinder(d=Thickness,h=H/3-1);
			translate([0,0,H/3*2+0.5]) cylinder(d=Thickness,h=H/3-1);
			
			translate([0,0,0.5])
			hull(){
				cylinder(d=Thickness,h=Arm_T);
				translate([0,Arm_Len,0]) cylinder(d=Thickness,h=Arm_T);
			} // hull
			
			translate([0,0,H-Arm_T-0.5])
			hull(){
				translate([0,0,0]) cylinder(d=Thickness,h=Arm_T);
				translate([0,Arm_Len,0]) cylinder(d=Thickness,h=Arm_T);
			} // hull
			
			translate([0,Arm_Len,0.5]) cylinder(d=Thickness, h=H-1);
			
		} // union
		
		translate([0, 0,-Overlap]) 
			cylinder(d=Pin_d, h=H+Overlap*2);
		translate([0, Arm_Len, -Overlap]) 
			cylinder(d=Pin_d, h=H+Overlap*2);
	} // difference
} // FairingAssemblyToolPt4

//FairingAssemblyToolPt4();

module ShowAsmTool(Fairing_OD=PML54Body_OD+IDXtra*2){
	//a=12; // 98mm
	// a=9; // 5.5"
	//a=15; // 75mm
	a=19.5; // 54mm
	translate([0,0,18]) rotate([180,0,0]) FairingAssemblyToolPt1(Fairing_OD=Fairing_OD);
	FairingAssemblyToolPt2(Fairing_OD=Fairing_OD);
	translate([Fairing_OD/2+5,0,0]) rotate([0,0,4]) FairingAssemblyToolPt3();
	rotate([0,0,a]) translate([Fairing_OD/2+5,0,0]) rotate([0,0,-a+3]) FairingAssemblyToolPt4();
} // ShowAsmTool

//ShowAsmTool();

module FairingConeBaseRing(Fairing_OD=Fairing_OD, 
							FairingWall_T=FairingWall_T, 
							NC_Base=NC_Base, 
							NC_Wall_t=NC_Wall_t){
	
	Fairing_ID=Fairing_OD-FairingWall_T*2;
	
	difference(){
		cylinder(d=Fairing_OD-NC_Wall_t*2+Overlap, h=NC_Base+3, $fn=$preview? 90:360);
				
		translate([0,0,-Overlap]) 
			cylinder(d=NC_Lock_ID(Fairing_ID)+IDXtra, h=NC_Base+Overlap*2, $fn=$preview? 90:360);
		translate([0,0,NC_Base-Overlap]) 
			cylinder(d1=NC_Lock_ID(Fairing_ID), d2=Fairing_ID,h=3+Overlap*2, $fn=$preview? 90:360);
			} // difference
} // FairingConeBaseRing

/*
FairingConeBaseRing(Fairing_OD=5.5*25.4, 
							FairingWall_T=2.2, 
							NC_Base=5, 
							NC_Wall_t=2.2);
/**/

/*
FairingConeBaseRing(Fairing_OD=PML98Body_OD, 
							FairingWall_T=2.2, 
							NC_Base=5, 
							NC_Wall_t=2.2);
/**/

module NoseLockRing(Fairing_OD=Fairing_OD, Fairing_ID =Fairing_ID){
	RingStop_H=5.4; // 18 layers @ 0.3mm layer height
	NC_Lock_ID=NC_Lock_ID(Fairing_ID);
	NC_Lock_OD=NC_Lock_OD(Fairing_ID);
	NC_Lock_H=NC_Lock_H;
	
	//echo(NC_Lock_OD=NC_Lock_OD);
	//echo(Fairing_ID=Fairing_ID);
	
	translate([0,0,-RingStop_H])
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
			
			// Stop
			translate([0,0,RingStop_H])
				cylinder(d=Fairing_OD, h=2, $fn=$preview? 90:360);
			
			cylinder(d=NC_Lock_ID, h=NC_Lock_H+7, $fn=$preview? 90:360); // was +5
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
					NC_Tip_r=NC_Tip_r,
					Cut_Z=0, LowerPortion=false, HasLanyard=true){
	
	Base_ID=Fairing_OD-NC_Wall_t*2;
	
	difference(){
		union(){
			BluntOgiveNoseCone(ID=Base_ID, OD=Fairing_OD, L=NC_Len, 
						Base_L=NC_Base, Tip_R=NC_Tip_r, Wall_T=NC_Wall_t,
						Cut_Z=Cut_Z, LowerPortion=LowerPortion);
			
			if (LowerPortion||(Cut_Z==0))
			// coupler ring
			FairingConeBaseRing(Fairing_OD=Fairing_OD, FairingWall_T=FairingWall_T,
					NC_Base=NC_Base, NC_Wall_t=NC_Wall_t);
			
		} // union

		// Cut in half for viewing
		if ($preview) translate([0,-100,-Overlap]) cube([100,100,200]);
		
	} // difference
	
	if ((LowerPortion||(Cut_Z==0))&&HasLanyard)
	translate([0,0,NC_Base+18]) rotate([-3.5,0,0]) LanyardToTube(ID=Base_ID);
} // FairingConeOGive

//translate([0,0,Fairing_Len+Overlap]) FairingConeOGive(); 
/*
FairingConeOGive(Fairing_OD=BT137Body_OD,
					FairingWall_T=2.2,
					NC_Base=5,
					NC_Len=380,
					NC_Wall_t=3,
					NC_Tip_r=8,
					Cut_Z=0, LowerPortion=true);
					
translate([0,0,-2]) NoseLockRing(Fairing_OD=BT137Body_OD, Fairing_ID =BT137Body_OD-4.4);
/**/
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
				translate([0,0,Base_h+0.3]) 
					cylinder(d1=NC_Lock_ID-IDXtra*5-4, d2=Tube_ID-IDXtra*3-4, h=Base_h, $fn=$preview? 90:360);
				translate([0,0,6.3]) cylinder(d=Tube_ID, h=10);
			} // difference
			
			cylinder(d=NC_Lock_ID-IDXtra*5-4, h=7, $fn=$preview? 90:360);
			
			cylinder(d1=NC_Lock_ID-IDXtra*5, d2=NC_Lock_ID-IDXtra*5-4, h=4, $fn=$preview? 90:360);
			
			translate([0,0,6.3-Overlap]) cylinder(d=NC_Lock_ID-IDXtra*5-2.4, h=1, $fn=$preview? 90:360);
			
		} // union
		
		// Center
		translate([0,0,Plate_h]) cylinder(d=NC_Lock_ID-IDXtra*5-8,h=10, $fn=$preview? 90:360);
		
		// Shock cord
		if (ShockCord_a>0)
		rotate([0,0,ShockCord_a]) translate([NC_Lock_ID/2,0,-Overlap]) RoundRect(X=15, Y=20, Z=20, R=4);
		
		if (ShockCord_a==-1) // center
			translate([0,0,-Overlap]) cylinder(d=16, h=10);
		
		// Cable Path
		translate([NC_Lock_ID/2,0,-Overlap]) RoundRect(X=14, Y=12, Z=20, R=5);
		
		// Make it snap in
		for (j=[0:nTabs-1]) rotate([0,0,360/nTabs*j]) translate([0,0,Plate_h+0.3]) cube([NC_Lock_ID/2,1.5,10]);
	} // difference
	
	if (ShockCord_a==-1) // center
			difference(){
				cylinder(d=20, h=5);
				translate([0,0,-Overlap]) cylinder(d=16, h=10);
			} // difference
	
} // FairingBaseBulkPlate

//FairingBaseBulkPlate(Tube_ID=102, Fairing_ID=102, ShockCord_a=-1);

module FairingBaseLockRing(Tube_OD=Fairing_OD, Tube_ID=Fairing_ID, Fairing_ID=Fairing_ID, Interface=-IDXtra, BlendToTube=false){
				
	NC_Lock_OD=NC_Lock_OD(Fairing_ID);
	NC_Lock_ID=NC_Lock_ID(Fairing_ID);
	NC_Lock_H=NC_Lock_H;
				
	BlendTail_h=BlendToTube? 4+Interface:0;
	Chanfer_OD=BlendToTube? Tube_ID+Interface:Tube_ID-4;
	Base_h=7;
	OA_h=10;

	difference(){
		union(){
			// glue flange
			translate([0,0,-BlendTail_h-Base_h])
				cylinder(d=Tube_ID+Interface, h=BlendTail_h+Base_h, $fn=$preview? 90:360);
			
			mirror([0,0,1])
				NoseLockRing(Fairing_OD=Tube_OD, Fairing_ID=Fairing_ID);
		} // union
			
		
		// center hole
		translate([0,0,-Overlap]) cylinder(d=NC_Lock_ID-IDXtra*2-4, h=OA_h+Overlap*2);
		
		// Chamfer
		translate([0,0,-BlendTail_h-Base_h-Overlap]) 
				cylinder(d1=Chanfer_OD, d2=NC_Lock_ID-IDXtra*2-4, h=BlendTail_h+Base_h+Overlap, $fn=$preview? 90:360);
	} // difference
} // FairingBaseLockRing

//FairingBaseLockRing(Tube_OD=PML75Body_OD, Tube_ID=PML75Body_ID, Fairing_ID=PML75Body_OD-4.4, Interface=Overlap, BlendToTube=false);
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

module F54_SpringEndCapHole(Xtra=0){
	cylinder(d=F54_Spring_OD, h=F54_Spring_CBL+3+Xtra);
	cylinder(d=F54_SpringEndCap_OD+IDXtra*3, h=F54_Spring_CBL+1.5+Xtra);
} // F54_SpringEndCapHole

//F54_SpringEndCapHole();

module LanyardA(Foot=0){
	LTY_h=30;
	LTY_w=6;
	LTY_y=7;
	Slot_h=10;
	Slot_y=3;
	
	difference(){
		hull(){
			translate([-LTY_w/2,-1-Foot,-LTY_h/2]) cube([LTY_w,2+Foot,LTY_h]);
			translate([-LTY_w/2,LTY_y,-LTY_h/2+LTY_y])
				cube([LTY_w,Overlap,LTY_h-LTY_y*2]);
		} // hull
		
		translate([0,-Overlap,0])
		hull(){
			translate([-LTY_w/2-Overlap,-1,-Slot_h/2-Slot_y]) 
				cube([LTY_w+Overlap*2,2,Slot_h+Slot_y*2]);
			translate([-LTY_w/2-Overlap,LTY_y-3,-Slot_h/2])
				cube([LTY_w+Overlap*2,Overlap,Slot_h]);
		} // hull
		
		
	} // difference
} // LanyardA

//LanyardA();

module LanyardToTube(ID=PML98Coupler_ID, Foot=0){
	LTY_h=30;
	
	difference(){
		translate([0,-ID/2-Overlap,0]) LanyardA(Foot=Foot);
		
		
		difference(){
			translate([0,0,-LTY_h/2-Overlap]) cylinder(d=ID+10+Foot*2, h=LTY_h+Overlap*2);
			translate([0,0,-LTY_h/2-Overlap*2]) cylinder(d=ID+1+Foot*2, h=LTY_h+Overlap*4);
		} // difference
	} // difference
} // LanyardToTube

// LanyardToTube(Foot=5);

module FairingWallGrigBox(X=10, Y=15, Z=15, R=1.5, A=0){
	myfn=24;
	
	hull(){
		// wall filets
		translate([-X/2+R, -R, -Z/2+R]) sphere(r=R, $fn=myfn);
		translate([-X/2+R, -R, Z/2-R]) sphere(r=R, $fn=myfn);
		translate([X/2-R, -R, -Z/2+R]) sphere(r=R, $fn=myfn);
		translate([X/2-R, -R, Z/2-R]) sphere(r=R, $fn=myfn);
		
		// inside
		translate([-X/2+R, 0, -Z/2+R]) rotate([0,0,A]) 
			rotate([90,0,0]) cylinder(r=R, h=Y, $fn=myfn);
		translate([-X/2+R, 0, Z/2-R])  rotate([0,0,A])
			rotate([90,0,0]) cylinder(r=R, h=Y, $fn=myfn);
		translate([X/2-R, 0, -Z/2+R])  rotate([0,0,-A])
			rotate([90,0,0]) cylinder(r=R, h=Y, $fn=myfn);
		translate([X/2-R, 0, Z/2-R]) rotate([0,0,-A])
			rotate([90,0,0]) cylinder(r=R, h=Y, $fn=myfn);

	} // hull
} // FairingWallGrigBox

//FairingWallGrigBox(X=10, Y=15, Z=15, R=1.5);

module GridWall(OD=BT137Body_OD, ID=BT137Body_OD-14, Len=100, Wall_t=1.2){
	Box_X=10;
	Box_Z=15;
	Spacing_Z=Box_Z+Wall_t;
	
	Grid_a=asin((Box_X+Wall_t)/(ID/2));
	nBoxes=floor(180/Grid_a)-1;
	Start_a=(180-nBoxes*Grid_a)/2+Grid_a/2;
	nBoxes_Z=floor(Len/Spacing_Z);
	Start_Z=(Len-nBoxes_Z*Spacing_Z)/2+Spacing_Z/2;
	
	difference(){
		Tube(OD=OD, ID=ID, Len=Len, myfn=$preview? 36:360);
		
		for (k=[0:nBoxes_Z-1])
			for (j=[0:nBoxes-1]) rotate([0,0,-90+Start_a+Grid_a*j]) 
				translate([0, OD/2-Wall_t, Start_Z+Spacing_Z*k]) 
					FairingWallGrigBox(X=Box_X, Y=15, Z=Box_Z, R=1.5, A=Grid_a/2);
		
		
		translate([-OD/2-1, -OD/2-1, -Overlap]) cube([OD+2, OD/2+1, Len+Overlap*2]);
	} // difference
} // GridWall

//GridWall();

module LargeFairing(IsLeftHalf=true, 
				Fairing_OD=Fairing_OD,
				Wall_T=7,
				Len=Fairing_Len,
				HasArmingHole=true){
	
	TubeWall_T=2.2;
	PJ_Spacing=(Len-25)/4;
	Fairing_ID=Fairing_OD-2*Wall_T;
	BallHole_X=-Fairing_OD/2+9.5;
	Z1=18; // was 16
	Z2=Len-Z1;
	M_H=12;
	M_H2=16;
	
	module LockingBallAccessHole(H=JointPin_d){
		hull(){
			rotate([90,0,0]) cylinder(d=5, h=H);
			translate([0,0,-7]) rotate([90,0,0]) cylinder(d=5, h=H);
		} // hull
	} // LockingBallAccessHole
	
	module SpringSocket(){
		rotate([0,0,180])
			translate([Fairing_ID/2-F54_SpringEndCap_OD/2, -Overlap, Len/2]) 
					rotate([-90,0,0]) F54_SpringEndCapHole(Xtra=2);
	} // SpringSocket
		
	translate([0,0,Len])			
		F54_Retainer(IsLeftHalf=IsLeftHalf, Fairing_OD=Fairing_OD, Wall_T=TubeWall_T);
	
	// Fairing base interface
	mirror([0,0,1])
		F54_Retainer(IsLeftHalf=IsLeftHalf, Fairing_OD=Fairing_OD, Wall_T=TubeWall_T);
	
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
			
	difference(){
		union(){
			if (IsLeftHalf){
				translate([0,0,5])
					GridWall(OD=Fairing_OD, ID=Fairing_ID, Len=Len-10, Wall_t=1.2);
			}else{
				rotate([0,0,180]) translate([0,0,5])
					GridWall(OD=Fairing_OD, ID=Fairing_ID, Len=Len-10, Wall_t=1.2);
				
				translate([Fairing_OD/2-3,0,-Overlap]) cylinder(d=4-IDXtra*3, h=Len+Overlap);
			}
			
			Tube(OD=Fairing_OD, ID=Fairing_OD-2.4, Len=Len, myfn=$preview? 36:360);
			
		} // union
		
		// cut in half
		if (IsLeftHalf){
			translate([-Fairing_OD/2-1, 0, -Overlap]) 
				mirror([0,1,0]) cube([Fairing_OD+2, Fairing_OD/2+2, Len+Overlap*2]);
		} else {
			translate([-Fairing_OD/2-1, 0, -Overlap]) 
				cube([Fairing_OD+2, Fairing_OD/2+2, Len+Overlap*2]);
		}
		
		if (IsLeftHalf)
			translate([Fairing_OD/2-3,0,-Overlap]) cylinder(d=4, h=Len+Overlap);
		
		if (IsLeftHalf){
			if (HasArmingHole) translate([BallHole_X,6.5-Overlap,Z2-M_H2/2]) 
				rotate([0,0,-90]) LockingBallAccessHole(H=10);
		
			translate([-Fairing_OD/2+8.5,6.5-Overlap,Z1]) 
				rotate([0,0,90]) MortiseBox(Mortise_h=M_H);
			translate([-Fairing_OD/2+8.5,6.5-Overlap,Z2]) 
				rotate([0,0,90]) MortiseBox(Mortise_h=M_H);
				
			translate([0,0,12.5+PJ_Spacing]){
				LargeFairing_PJ_Clip_Boss(Fairing_OD=Fairing_OD, FairingWall_t=TubeWall_T);
				LargeFairing_PJ_Clip_BoltPattern(Fairing_OD=Fairing_OD) Bolt4ClearHole();}
			translate([0,0,12.5+PJ_Spacing*3]){
				LargeFairing_PJ_Clip_Boss(Fairing_OD=Fairing_OD, FairingWall_t=TubeWall_T);
				LargeFairing_PJ_Clip_BoltPattern(Fairing_OD=Fairing_OD) Bolt4ClearHole();}

		}else{
			// Spring
			if (IsLeftHalf==false) SpringSocket();
		
			translate([0,0,12.5]) rotate([180,0,0]){
				LargeFairing_PJ_Clip_Boss(Fairing_OD=Fairing_OD, FairingWall_t=TubeWall_T);
				LargeFairing_PJ_Clip_BoltPattern(Fairing_OD=Fairing_OD) Bolt4ClearHole();}
			translate([0,0,12.5+PJ_Spacing*2]) rotate([180,0,0]){
				LargeFairing_PJ_Clip_Boss(Fairing_OD=Fairing_OD, FairingWall_t=TubeWall_T);
				LargeFairing_PJ_Clip_BoltPattern(Fairing_OD=Fairing_OD) Bolt4ClearHole();}
			translate([0,0,12.5+PJ_Spacing*4]) rotate([180,0,0]){ 
				LargeFairing_PJ_Clip_Boss(Fairing_OD=Fairing_OD, FairingWall_t=TubeWall_T);
				LargeFairing_PJ_Clip_BoltPattern(Fairing_OD=Fairing_OD) Bolt4ClearHole();}
		}
	} // diff
	
	
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
						
				//translate([0,0,12.5+PJ_Spacing]) PJ_Clip(Fairing_OD=Fairing_OD);
				//translate([0,0,12.5+PJ_Spacing*3]) PJ_Clip(Fairing_OD=Fairing_OD);
						
				//rotate([0,0,-45]) translate([-Fairing_ID/2+8,0,Len-65]) 
				//		rotate([0,-90,0]) CablePullerBoltPattern() cylinder(d=8, h=15);
				
			} else {
				rotate([0,0,180]) SkirtedTenon(Tube_OD=Fairing_OD, Z=Z1);
				rotate([0,0,180]) SkirtedTenon(Tube_OD=Fairing_OD, Z=Z2);
				
				// Spring and SpringCap go in this. 
				rotate([0,0,180])
					translate([Fairing_ID/2-F54_SpringEndCap_OD/2,0, Len/2])
						hull(){
							rotate([-90,0,0]) cylinder(d=F54_SpringEndCap_OD+4, h=1);
							translate([0,F54_Spring_FL/2,0]) 
								sphere(d=F54_SpringEndCap_OD+4);
							
							translate([7,0,0]){
							rotate([-90,0,0]) cylinder(d=F54_SpringEndCap_OD+10,h=1);
							translate([0,F54_Spring_FL/2+4,0]) 
								sphere(d=F54_SpringEndCap_OD+10);}
						} // hull	
						
				
			} // if
		} // union
		
		// Spring
		if (IsLeftHalf==false) SpringSocket();
		
		// cable path
		translate([-Fairing_ID/2+F54_SpringEndCap_OD/2+2,6.5,Len/2]) 
			cylinder(d=9, h=20, center=true);
		
		// Trim all to outside of fairing
		difference(){
			translate([0,0,-Overlap]) cylinder(d=Fairing_OD+35,h=Len+Overlap*2);
			
			
			translate([0,0,-Overlap*2]) 
				cylinder(d=Fairing_OD,h=Len+Overlap*4, $fn=$preview? 36:360);
		} // difference
	} // difference
	
	
	if (IsLeftHalf) {
		translate([0,0,Len-20]) rotate([0,0,135]) LanyardToTube(ID=Fairing_ID, Foot=6);
	} else {
		translate([0,0,Len-20]) rotate([0,0,135+180]) LanyardToTube(ID=Fairing_ID, Foot=6);
	}
	
} // LargeFairing

/*
LargeFairing(IsLeftHalf=true, 
				Fairing_OD=BT137Body_OD,
				Wall_T=7,
				Len=Fairing_Len,
				HasArmingHole=true);
/**/

/*
LargeFairing(IsLeftHalf=false, 
				Fairing_OD=BT137Body_OD,
				Wall_T=7,
				Len=Fairing_Len,
				HasArmingHole=true);
/**/
		
module F54_FairingHalf(IsLeftHalf=true, 
				Fairing_OD=Fairing_OD,
				Wall_T=FairingWall_T,
				Len=Fairing_Len,
				HasArmingHole=true){
				
	Fairing_ID=Fairing_OD-Wall_T*2;
	BallHole_X=-Fairing_OD/2+9.5;
	M_H2=16;
	M_H=12;
	Z1=18; // was 16
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
		
			translate([-Fairing_OD/2+8.5,6.5-Overlap,Z1]) 
				rotate([0,0,90]) MortiseBox(Mortise_h=M_H);
			translate([-Fairing_OD/2+8.5,6.5-Overlap,Z2]) 
				rotate([0,0,90]) MortiseBox(Mortise_h=M_H);
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
							translate([0,F54_Spring_FL/2+SpringInset,0]) 
								sphere(d=F54_SpringEndCap_OD+4);
							
							translate([7,0,0]){
							rotate([-90,0,0]) cylinder(d=F54_SpringEndCap_OD+10,h=1);
							translate([0,F54_Spring_FL/2+4+SpringInset,0]) 
								sphere(d=F54_SpringEndCap_OD+10);}
						} // hull	
						
				translate([0,0,12.5]) rotate([180,0,0]) PJ_Clip(Fairing_OD=Fairing_OD);
				translate([0,0,12.5+PJ_Spacing*2]) rotate([180,0,0]) 
					PJ_Clip(Fairing_OD=Fairing_OD);
				translate([0,0,12.5+PJ_Spacing*4]) rotate([180,0,0]) 
					PJ_Clip(Fairing_OD=Fairing_OD);
			} // if
		} // union
		
		// Spring
		if (IsLeftHalf==false) SpringSocket();
		
		// cable path
		translate([-Fairing_ID/2+F54_SpringEndCap_OD/2+2,6.5,Len/2]) 
			cylinder(d=9, h=20, center=true);
		
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



















