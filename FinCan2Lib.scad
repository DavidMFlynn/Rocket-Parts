// ***********************************
// Project: 3D Printed Rocket
// Filename: FinCan2Lib.scad
// by David M. Flynn
// Created: 12/24/2023 
// Revision: 0.9.7  8/24/2024
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  This file is sample code.
//
//  ***** History *****
//
function FinCan2LibRev()="FinCan2Lib 0.9.7";
echo(FinCan2LibRev());
//
// 0.9.7  8/24/2024   Added HollowFinRoots parameter to FC2_FinCan()
// 0.9.6  8/21/2024	  Geometry changed: Rail guide/post is now at 0° (+Y) first fin at 180/nFins.
// 0.9.5  8/13/2024   Fixed calculation for rail guide position
// 0.9.4  7/18/2024   Added Extra_OD Parameter
// 0.9.3  4/21/2024   Looser nut, global parameters added
// 0.9.2  4/18/2024   Fixed a tail cone problem.
// 0.9.1  4/7/2024	  Added options.
// 0.9.0  12/24/2023  First code. Copied from Rocket98C.
//
// ***********************************
//  ***** for STL output *****
// 
/*
FC2_FinCan(Body_OD=BT98Body_OD, Body_ID=BT98Body_ID, Can_Len=160,
				MotorTube_OD=BT54Body_OD, RailGuide_h=BT98Body_OD/2+2,
				nFins=5, HasIntegratedCoupler=true, HasMotorSleeve=true, HasAftIntegratedCoupler=false,
				Fin_Root_W=14, Fin_Root_L=130, Fin_Post_h=14, Fin_Chamfer_L=32,
				Cone_Len=65, ThreadedTC=true, Extra_OD=0, RailGuideLen=30, LowerHalfOnly=false, UpperHalfOnly=false, HasWireHoles=false);
/**/
/*
FC2_FinCan(Body_OD=BT75Body_OD, Body_ID=BT75Body_ID, Can_Len=160,
				MotorTube_OD=BT54Body_OD, RailGuide_h=BT75Body_OD/2+2,
				nFins=5, HasIntegratedCoupler=true, HasMotorSleeve=true, HasAftIntegratedCoupler=false,
				Fin_Root_W=12, Fin_Root_L=130, Fin_Post_h=10, Fin_Chamfer_L=32,
				Cone_Len=35, ThreadedTC=true, Extra_OD=0, RailGuideLen=30, LowerHalfOnly=false, UpperHalfOnly=false, HasWireHoles=false);
/**/
/*
  FC2_FinCan(Body_OD=BT98Body_OD, Body_ID=BT98Body_ID, Can_Len=160,
				MotorTube_OD=BT54Body_OD, RailGuide_h=BT98Body_OD/2+2,
				nFins=5,
				Fin_Root_W=14, Fin_Root_L=130, Fin_Post_h=14, Fin_Chamfer_L=32,
				Cone_Len=65, ThreadedTC=true, Extra_OD=0, RailGuideLen=30, LowerHalfOnly=false, UpperHalfOnly=false, HasWireHoles=false);
/**/
/*
  FC2_MotorRetainer(Body_OD=BT98Body_OD,
						MotorTube_OD=BT54Body_OD, MotorTube_ID=BT54Body_ID,
						HasWrenchCuts=false, Cone_Len=65, ExtraLen=0, Extra_OD=0);
/**/
//
// ***********************************
//  ***** Routines *****
//
/*
FC2_TailCone(Body_OD=BT98Body_OD, MotorTube_OD=BT54Body_OD,
				nFins=5,
				Fin_Root_W=12, Fin_Root_L=100, Fin_Post_h=10, Fin_Chamfer_L=22,
				Threaded=true, Cone_Len=65, Interface_OD=Body_ID, Extra_OD=0);
/**/
// ***********************************

include<TubesLib.scad>
use<Fins.scad>
use<RailGuide.scad>
include<CommonStuffSAEmm.scad>
use<ThreadLib.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

MotorTubeHoleIDXtra=IDXtra*3;
InternalThreadIDXtra=IDXtra*5;
ThreadPitch=2.5;
NominalThreadWall_t=ThreadPitch+1.5; // added to motor tube radius

module FC2_FinCan(Body_OD=BT98Body_OD, Body_ID=BT98Body_ID, Can_Len=160,
				MotorTube_OD=BT54Body_OD, RailGuide_h=BT98Body_OD/2+2,
				nFins=5, HasIntegratedCoupler=true, HasMotorSleeve=true, HasAftIntegratedCoupler=false,
				Fin_Root_W=14, Fin_Root_L=130, Fin_Post_h=14, Fin_Chamfer_L=32,
				Cone_Len=65, ThreadedTC=true, Extra_OD=0, RailGuideLen=30,
				LowerHalfOnly=false, UpperHalfOnly=false, HasWireHoles=false, HollowTailcone=false, 
				HollowFinRoots=false, Wall_t=1.2){
				
	FinBox_W=Fin_Root_W+IDXtra*2+Wall_t*2;
	RailGuideTube_Len=(RailGuideLen-5)*2;
	RailGuide_Z=RailGuideTube_Len/2;
	MotorTubeHole_d=MotorTube_OD+MotorTubeHoleIDXtra;
	FinInset_Len=(Can_Len-Fin_Root_L)/2;
	Coupler_Len=10;
	FB_Xtra_Fwd=HasIntegratedCoupler? Coupler_Len:0;
	
	difference(){
		union(){
			// Body Tube
			Tube(OD=Body_OD, ID=Body_OD-Wall_t*2, Len=Can_Len, myfn=$preview? 36:360);
			
			// Motor Tube Sleeve
			if (HasMotorSleeve)
			Tube(OD=MotorTubeHole_d+Wall_t*2, ID=MotorTubeHole_d, Len=Can_Len, myfn=$preview? 36:360);
			
			// integrated coupler
			if (HasIntegratedCoupler){
				translate([0,0,Can_Len-Overlap]){
					Tube(OD=Body_ID-IDXtra, ID=Body_ID-4, Len=Coupler_Len+Overlap, myfn=$preview? 36:360);
					if (HasMotorSleeve)
						Tube(OD=MotorTubeHole_d+Wall_t*2, ID=MotorTubeHole_d, Len=Coupler_Len+Overlap, myfn=$preview? 36:360);
				}
				difference(){
					translate([0,0,Can_Len-5])
						Tube(OD=Body_OD-1, ID=Body_ID-4, Len=5, myfn=$preview? 36:360);
					translate([0,0,Can_Len-5-Overlap]) cylinder(d1=Body_OD-Wall_t*2, d2=Body_ID-5, h=5);
				} // difference
			}
			
			if (HasAftIntegratedCoupler){
				translate([0,0,-Coupler_Len]){
					Tube(OD=Body_ID-IDXtra, ID=Body_ID-4, Len=Coupler_Len+Overlap, myfn=$preview? 36:360);
					if (HasMotorSleeve)
						Tube(OD=MotorTubeHole_d+Wall_t*2, ID=MotorTubeHole_d, Len=Coupler_Len+Overlap, myfn=$preview? 36:360);
				}
				difference(){
					Tube(OD=Body_OD-1, ID=Body_ID-4, Len=5, myfn=$preview? 36:360);
					translate([0,0,-Overlap]) cylinder(d2=Body_OD-Wall_t*2, d1=Body_ID-5, h=5);
				} // difference
				
			}
			
			UpperRing_Z=HasIntegratedCoupler? Can_Len+7:Can_Len-3;
			UpperRing_OD=HasIntegratedCoupler? Body_ID-1:Body_OD-1;
			// Upper Centering Ring
			if (Cone_Len==0)
				translate([0,0,UpperRing_Z])
					CenteringRing(OD=UpperRing_OD, ID=MotorTubeHole_d, Thickness=3, nHoles=nFins, Offset=0);
					
			// Lower Centering Ring
			LowerRing_Z=HasAftIntegratedCoupler? -Coupler_Len:0;
			LowerRing_OD=HasAftIntegratedCoupler? Body_ID-1:Body_OD-1;
			if (Cone_Len==0) translate([0,0,LowerRing_Z])
				CenteringRing(OD=LowerRing_OD, ID=MotorTubeHole_d, Thickness=3, nHoles=nFins, Offset=0);
				
			// Middle Centering Rings
			translate([0,0,Can_Len/2-3])
					CenteringRing(OD=Body_OD-1, ID=MotorTubeHole_d, Thickness=6, nHoles=nFins, Offset=0);
			
			// Fin Boxes
			difference(){
				for (j=[0:nFins]) rotate([0,0,360/nFins*j+180/nFins]) 
					translate([-FinBox_W/2,0,0]) cube([FinBox_W, Body_OD/2, Can_Len+FB_Xtra_Fwd]);
				
				// remove outside
				difference(){
					translate([0,0,-Overlap]) cylinder(d=Body_OD+10, h=FB_Xtra_Fwd+Can_Len+Overlap*2);
					translate([0,0,-Overlap*2]) cylinder(d=Body_OD-1, h=FB_Xtra_Fwd+Can_Len+Overlap*4);
				} // difference
				
				// remove inside
				translate([0,0,-Overlap]) cylinder(d=MotorTubeHole_d, h=FB_Xtra_Fwd+Can_Len+Overlap*2);
				
				// Remove outside of HasIntegratedCoupler
				if (FB_Xtra_Fwd>0)
					translate([0,0,Can_Len]) Tube(OD=Body_OD+1, ID=Body_ID-1, Len=15, myfn=$preview? 36:360);
					
				
			} // difference
			
			//*
			if (Cone_Len>0)
			FC2_TailCone(Body_OD=Body_OD, MotorTube_OD=MotorTube_OD, 
						nFins=nFins,
						Fin_Root_W=Fin_Root_W, Fin_Root_L=Fin_Root_L, 
						Fin_Post_h=Fin_Post_h, Fin_Chamfer_L=Fin_Chamfer_L,
						Threaded=ThreadedTC, Cone_Len=Cone_Len, Interface_OD=Body_OD-1,
						FinInset_Len=(Can_Len-Fin_Root_L)/2, MakeHollow=HollowTailcone, Extra_OD=Extra_OD);
			/**/
			
			// Rail guide bolt boss
			if (RailGuide_h>5)
			translate([0,0,RailGuide_Z]) 
				RailGuidePost(OD=Body_OD, MtrTube_OD=MotorTubeHole_d, H=RailGuide_h, 
					TubeLen=RailGuideTube_Len, Length = RailGuideLen, BoltSpace=12.7, AddTaper=true);
					
			// Rail button bolt boss
			if (RailGuide_h==1)
			translate([0,Body_OD/2,10]) rotate([90,0,0]) cylinder(d=10, h=(Body_OD-MotorTubeHole_d)/2);
		} // union
	
		// Hollow roots
		if (HollowFinRoots && (Body_OD/2-MotorTubeHole_d/2-Fin_Post_h)>5) 
			for (j=[0:nFins]) rotate([0,0,360/nFins*j+180/nFins]){
				// Forward box
				translate([-FinBox_W/2+Wall_t, MotorTubeHole_d/2+Wall_t, Can_Len/2+3])
					cube([FinBox_W-Wall_t*2, Body_OD/2-MotorTubeHole_d/2-Fin_Post_h-Wall_t*2, Can_Len/2+FB_Xtra_Fwd-Wall_t-6]);
				// Aft box
				translate([-FinBox_W/2+Wall_t, MotorTubeHole_d/2+Wall_t, 3])
					cube([FinBox_W-Wall_t*2, Body_OD/2-MotorTubeHole_d/2-Fin_Post_h-Wall_t*2, Can_Len/2-6]);
				// Make manifold for printing
				translate([0, MotorTubeHole_d/2+Wall_t+2.5, Can_Len/2-6]) cylinder(d=1, h=Can_Len);
			}
					
		// Fin Sockets
		translate([0,0,Fin_Root_L/2+FinInset_Len])
			TrapFin2Slots(Tube_OD=Body_OD, nFins=nFins, Post_h=Fin_Post_h, 
					Root_L=Fin_Root_L, Root_W=Fin_Root_W, Chamfer_L=Fin_Chamfer_L);
		
		// Wire holes for night launch fins w/ LEDs
		if (HasWireHoles)
			for (j=[0:nFins]) rotate([0,0,360/nFins*j+180/nFins]) 
					translate([0, Body_OD/2-Fin_Post_h, Can_Len/2-20]) hull(){
						cylinder(d=4, h=Can_Len/2+30);
						translate([0,-2,2]) cylinder(d=4, h=Can_Len/2+30);
						}
		
		// Rail guide bolt holes
		if (RailGuide_h>5)
			translate([0,RailGuide_h,RailGuide_Z])
				RailGuideBoltPattern(BoltSpace=12.7) Bolt6Hole();
				
		// Rail button bolt hole
		if (RailGuide_h==1)
			translate([0,Body_OD/2,10]) rotate([-90,0,0]) Bolt8Hole();
		
		if (LowerHalfOnly) translate([0,0,Can_Len/2]) cylinder(d=Body_OD+1, h=Can_Len/2+50);
		if (UpperHalfOnly) translate([0,0,Can_Len/2]) 
			rotate([180,0,0]) cylinder(d=Body_OD+10, h=Can_Len/2+Cone_Len+1);
			
		if ($preview) rotate([0,0,-180/nFins]) translate([0,0,-Cone_Len-Overlap]) cube([Body_OD/2+1,Body_OD/2+1,Cone_Len+Can_Len+20]);
	} // difference
} // FC2_FinCan

//rotate([180,0,0]) 
FC2_FinCan(RailGuide_h=1, LowerHalfOnly=false, UpperHalfOnly=false, HasWireHoles=false, HollowFinRoots=true);


module FC2_TailCone(Body_OD=BT98Body_OD, MotorTube_OD=BT54Body_OD,
				nFins=5,
				Fin_Root_W=12, Fin_Root_L=100, Fin_Post_h=10, Fin_Chamfer_L=22,
				Threaded=true, Cone_Len=65, Interface_OD=Body_ID, FinInset_Len=5, MakeHollow=false, Extra_OD=0){
				
	
	FinAlignment_Len=0;
	AftClosure_h=10;
	Retainer_h=2;
	Nut_Len=Retainer_h+AftClosure_h+10;
	Tail_r=Body_OD/4; // was 20
	Base_d=MotorTube_OD+4.4+Extra_OD;
	NomonalThread_d=MotorTube_OD+NominalThreadWall_t*2;
	MotorTubeHole_d=MotorTube_OD+MotorTubeHoleIDXtra;
	HollowWall_t=3;
	Wall_t=1.2;
	FinBox_W=Fin_Root_W+Wall_t*2;
	MotorRetainer_Len=33;
	
	//echo(Interface_OD=Interface_OD);
	difference(){
		union(){
			hull(){
				translate([0,0,-Cone_Len]) cylinder(d=Base_d, h=2, $fn=$preview? 90:360);
				
				difference(){
					rotate_extrude($fn=$preview? 90:360) translate([Body_OD/2-Tail_r,0,0]) circle(r=Tail_r);
					translate([0,0,Overlap]) cylinder(d=Body_OD+1,h=50);
				}
			} // hull
			
			translate([0,0,-Overlap]) 
				cylinder(d=Interface_OD, h=FinInset_Len+FinAlignment_Len+Overlap, $fn=$preview? 90:360);
		} // union
		
		// Hollow core
		if (MakeHollow) difference(){
			union(){
				hull(){
					translate([0,0,-Cone_Len]) cylinder(d=Base_d-HollowWall_t*2, h=1, $fn=$preview? 90:360);
					
					difference(){
						rotate_extrude($fn=$preview? 90:360) translate([Body_OD/2-Tail_r,0,0]) circle(r=Tail_r-HollowWall_t);
						translate([0,0,Overlap]) cylinder(d=Body_OD+1,h=50);
					}
				} // hull
				
				translate([0,0,-Overlap]) cylinder(d=Body_OD-HollowWall_t*2, h=FinInset_Len+FinAlignment_Len+Overlap*2, $fn=$preview? 90:360);
			} // union
		
			translate([0,0,-Cone_Len-Overlap]) 
				cylinder(d=MotorTubeHole_d+HollowWall_t*2, h=Cone_Len+Tail_r+FinInset_Len+FinAlignment_Len+Overlap*2);
			
			if (Threaded) {
				translate([0,0,-Cone_Len-Overlap]) cylinder(d=Body_OD, h=Nut_Len+HollowWall_t+Overlap);
			} else {
				translate([0,0,-Cone_Len-Overlap]) cylinder(d=Body_OD, h=MotorRetainer_Len+HollowWall_t+Overlap);
			}
			
			// Fin Boxes
			for (j=[0:nFins]) rotate([0,0,360/nFins*j]) 
				translate([0,-FinBox_W/2,-Cone_Len]) 
					cube([Body_OD/2,FinBox_W,Cone_Len+Tail_r+FinInset_Len+FinAlignment_Len+Overlap*2]);
					
	
		} // difference
		
		
		// Fin slots, just incase the fins protrude into the tailcone
		translate([0,0,Fin_Root_L/2+FinInset_Len])
			TrapFin2Slots(Tube_OD=Body_OD, nFins=nFins, Post_h=Fin_Post_h, 
							Root_L=Fin_Root_L, Root_W=Fin_Root_W, Chamfer_L=Fin_Chamfer_L);
		
		
		// Motor tube
		translate([0,0,-Cone_Len-Overlap]) 
			cylinder(d=MotorTubeHole_d, h=Cone_Len+Tail_r+FinInset_Len+FinAlignment_Len+Overlap*2);
	
		// Rail button bolt hole
		translate([-Body_OD/2,0,10]) rotate([0,-90,0]) Bolt8Hole();
		
		if (Threaded) translate([0,0,-Cone_Len-Overlap]) cylinder(d=Body_OD, h=Nut_Len);
		
		if ($preview) translate([3,3,-Cone_Len-Overlap]) cube([Body_OD/2,Body_OD/2,Cone_Len+10]);
	} // difference
	
	if (Threaded) difference(){
		translate([0,0,-Cone_Len+Nut_Len-10]) 
			ExternalThread(Pitch=ThreadPitch, Dia_Nominal=NomonalThread_d, 
							Length=10+Overlap, Step_a=$preview? 10:2, TrimEnd=true, TrimRoot=false);
			
		// Motor tube
		translate([0,0,-Cone_Len-Overlap]) 
			cylinder(d=MotorTubeHole_d, h=Cone_Len+FinInset_Len+FinAlignment_Len+Overlap*2);
	}
} // FC2_TailCone

/*
rotate([180,0,0]) FC2_TailCone(Body_OD=BT75Body_OD, MotorTube_OD=BT54Body_OD,
				nFins=5,
				Fin_Root_W=12, Fin_Root_L=100, Fin_Post_h=10, Fin_Chamfer_L=22,
				Threaded=true, Cone_Len=40, Interface_OD=BT75Body_ID, FinInset_Len=5, MakeHollow=false, Extra_OD=2);
/**/

module FC2_MotorRetainer(Body_OD=BT98Body_OD,
						MotorTube_OD=BT54Body_OD, MotorTube_ID=BT54Body_ID,
						HasWrenchCuts=false, Cone_Len=65, ExtraLen=0, Extra_OD=0){
	
	
	AftClosure_h=10;
	Retainer_h=2;
	Nut_Len=Retainer_h+AftClosure_h+10;
	Tail_r=Body_OD/4;
	Base_d=MotorTube_OD+4.4+Extra_OD;
	NomonalThread_d=MotorTube_OD+NominalThreadWall_t*2;
	
	difference(){
		hull(){
			difference(){
				hull(){
					// Bottom
					translate([0,0,-Cone_Len]) cylinder(d=Base_d, h=2, $fn=$preview? 90:360);
						
					// Top
					rotate_extrude($fn=$preview? 90:360) translate([Body_OD/2-Tail_r,0,0]) circle(r=Tail_r);
				} // hull
				
				// Trim Top	
				translate([0,0,-Cone_Len+Nut_Len-Overlap]) cylinder(d=Body_OD+1, h=Cone_Len);
			} // difference
		
			translate([0,0,-Cone_Len-ExtraLen]) 
				cylinder(d=MotorTube_OD+2.4+IDXtra*2, h=2, $fn=$preview? 90:360);
		} // hull
			
		// Exit
		translate([0,0,-Cone_Len-ExtraLen-Overlap]) 
			cylinder(d=MotorTube_ID+IDXtra*2, h=Cone_Len);
			
		// Motor tube
		translate([0,0,-Cone_Len-ExtraLen+Retainer_h]) 
			cylinder(d=MotorTube_OD+IDXtra*3, h=Cone_Len);
	
		translate([0,0,-Cone_Len+Nut_Len-12+Overlap])
			ExternalThread(Pitch=ThreadPitch, Dia_Nominal=NomonalThread_d+InternalThreadIDXtra, 
							Length=15, Step_a=$preview? 10:2, TrimEnd=true, TrimRoot=false);
		
		// Spanner Wrench
		if (HasWrenchCuts){
			SW_Z=16;
			SW_W=Body_OD-22;
			translate([SW_W/2,-Body_OD/2,-Cone_Len]) cube([Body_OD,Body_OD,SW_Z]);
			mirror([1,0,0])
			translate([SW_W/2,-Body_OD/2,-Cone_Len]) cube([Body_OD,Body_OD,SW_Z]);
		} // if
		
		if ($preview) translate([0,0,-Cone_Len-ExtraLen-1]) cube([50,50,100]);
	} // difference
} // FC2_MotorRetainer

//translate([0,0,-0.2]) FC2_MotorRetainer(ExtraLen=0);

/*
translate([0,0,-0.2]) FC2_MotorRetainer(Body_OD=BT75Body_OD,
						MotorTube_OD=BT54Body_OD, MotorTube_ID=BT54Body_ID,
						HasWrenchCuts=false, Cone_Len=40, ExtraLen=0, Extra_OD=2);
/**/						
/*
difference(){
	union(){
		TailCone(Cone_Len=35);
		translate([0,0,-Overlap]) rotate([0,0,-150]) MotorRetainer(Cone_Len=35,ExtraLen=4);
	} // union
	
	translate([0,0,-50]) cube([50,50,50]);
} // difference
/**/





















