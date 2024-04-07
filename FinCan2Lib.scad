// ***********************************
// Project: 3D Printed Rocket
// Filename: FinCan2Lib.scad
// by David M. Flynn
// Created: 12/24/2023 
// Revision: 0.9.0  12/24/2023
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  This file is sample code.
//
//  ***** History *****
//
function FinCan2LibRev()="FinCan2Lib 0.9.0";
echo(FinCan2LibRev());
//
// 0.9.0  12/24/2023  First code. Copied from Rocket98C.
//
// ***********************************
//  ***** for STL output *****
// 
/*
  FC2_FinCan(Body_OD=BT98Body_OD, Body_ID=BT98Body_ID, Can_Len=160,
				MotorTube_OD=BT54Body_OD, RailGuide_h=BT98Body_OD/2+2,
				nFins=5,
				Fin_Root_W=14, Fin_Root_L=130, Fin_Post_h=14, Fin_Chamfer_L=32,
				Cone_Len=65, LowerHalfOnly=false, UpperHalfOnly=false, HasWireHoles=false);
/**/
/*
  FC2_MotorRetainer(Body_OD=BT98Body_OD,
						MotorTube_OD=BT54Body_OD, MotorTube_ID=BT54Body_ID,
						HasWrenchCuts=false, Cone_Len=65, ExtraLen=0);
/**/
//
// ***********************************
//  ***** Routines *****
//
/*
FC2_TailCone(Body_OD=BT98Body_OD, MotorTube_OD=BT54Body_OD,
				nFins=5,
				Fin_Root_W=12, Fin_Root_L=100, Fin_Post_h=10, Fin_Chamfer_L=22,
				Threaded=true, Cone_Len=65, Interface_OD=Body_ID);
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


module FC2_FinCan(Body_OD=BT98Body_OD, Body_ID=BT98Body_ID, Can_Len=160,
				MotorTube_OD=BT54Body_OD, RailGuide_h=BT98Body_OD/2+2,
				nFins=5,
				Fin_Root_W=14, Fin_Root_L=130, Fin_Post_h=14, Fin_Chamfer_L=32,
				Cone_Len=65, LowerHalfOnly=false, UpperHalfOnly=false, HasWireHoles=false){
				
	Wall_t=1.2;
	FinBox_W=Fin_Root_W+Wall_t*2;
	RailGuide_Z=25;
	MotorTubeHole_d=MotorTube_OD+IDXtra*3;
	FinInset_Len=(Can_Len-Fin_Root_L)/2;
	
	difference(){
		union(){
			// Body Tube
			Tube(OD=Body_OD, ID=Body_OD-Wall_t*2, Len=Can_Len, myfn=$preview? 36:360);
			// Motor Tube Sleeve
			Tube(OD=MotorTubeHole_d+Wall_t*2, ID=MotorTubeHole_d, Len=Can_Len, myfn=$preview? 36:360);
			
			// integrated coupler
			translate([0,0,Can_Len-Overlap])
				Tube(OD=Body_ID-IDXtra, ID=Body_ID-4, Len=10, myfn=$preview? 36:360);
			difference(){
				translate([0,0,Can_Len-5])
					Tube(OD=Body_OD-1, ID=Body_ID-4, Len=5, myfn=$preview? 36:360);
				translate([0,0,Can_Len-5-Overlap]) cylinder(d1=Body_OD-Wall_t*2, d2=Body_ID-5, h=5);
			} // difference
			
			// Upper Centering Ring
			//translate([0,0,Can_Len-3])
			//	CenteringRing(OD=Body_OD-1, ID=Body_ID-10, Thickness=3, nHoles=0, Offset=0);
				
			// Middle Centering Rings
			translate([0,0,Can_Len/2-3])
				rotate([0,0,180/nFins])
					CenteringRing(OD=Body_OD-1, ID=MotorTubeHole_d, Thickness=6, nHoles=nFins, Offset=0);
			
			// Fin Boxes
			difference(){
				for (j=[0:nFins]) rotate([0,0,360/nFins*j]) 
					translate([0,-FinBox_W/2,0]) cube([Body_OD/2,FinBox_W,Can_Len]);
					
				difference(){
					translate([0,0,-Overlap]) cylinder(d=Body_OD+10, h=Can_Len+Overlap*2);
					translate([0,0,-Overlap*2]) cylinder(d=Body_OD-1, h=Can_Len+Overlap*4);
				} // difference
				
				translate([0,0,-Overlap]) cylinder(d=MotorTubeHole_d, h=Can_Len+Overlap*2);
			} // difference
			
			if (Cone_Len>0)
			FC2_TailCone(Body_OD=Body_OD, MotorTube_OD=MotorTube_OD, 
						nFins=nFins,
						Fin_Root_W=Fin_Root_W, Fin_Root_L=Fin_Root_L, 
						Fin_Post_h=Fin_Post_h, Fin_Chamfer_L=Fin_Chamfer_L,
						Threaded=true, Cone_Len=Cone_Len, Interface_OD=Body_OD-1);
			
			// Rail guide bolt boss
			if (RailGuide_h>0)
			translate([0,0,RailGuide_Z]) rotate([0,0,90]) 
				RailGuidePost(OD=Body_OD, MtrTube_OD=MotorTubeHole_d, H=RailGuide_h, 
					TubeLen=50, Length = 30, BoltSpace=12.7);
		} // union
	
		// Fin Sockets
		translate([0,0,Fin_Root_L/2+FinInset_Len])
			TrapFin2Slots(Tube_OD=Body_OD, nFins=nFins, Post_h=Fin_Post_h, 
					Root_L=Fin_Root_L, Root_W=Fin_Root_W, Chamfer_L=Fin_Chamfer_L);
		
		// Wire holes for night launch fins w/ LEDs
		if (HasWireHoles)
			for (j=[0:nFins]) rotate([0,0,360/nFins*j]) 
					translate([Body_OD/2-Fin_Post_h, 0, Can_Len/2-20]) hull(){
						cylinder(d=4, h=Can_Len/2+30);
						translate([-2,0,2]) cylinder(d=4, h=Can_Len/2+30);
						}
		
		// Rail guide bolt holes
		if (RailGuide_h>0)
			translate([-RailGuide_h,0,RailGuide_Z]) rotate([0,0,90]) 
				RailGuideBoltPattern(BoltSpace=12.7) Bolt6Hole();
		
		if (LowerHalfOnly) translate([0,0,Can_Len/2]) cylinder(d=Body_OD+1, h=Can_Len/2+50);
		if (UpperHalfOnly) translate([0,0,Can_Len/2]) 
			rotate([180,0,0]) cylinder(d=Body_OD+10, h=Can_Len/2+50);
			
		if ($preview) cube([Body_OD/2+1,Body_OD/2+1,Can_Len+20]);
	} // difference
} // FC2_FinCan

//rotate([180,0,0]) 
FC2_FinCan(LowerHalfOnly=false, UpperHalfOnly=false, HasWireHoles=false);


module FC2_TailCone(Body_OD=BT98Body_OD, MotorTube_OD=BT54Body_OD,
				nFins=5,
				Fin_Root_W=12, Fin_Root_L=100, Fin_Post_h=10, Fin_Chamfer_L=22,
				Threaded=true, Cone_Len=65, Interface_OD=Body_ID){
				
	FinInset_Len=5;
	FinAlignment_Len=0;
	AftClosure_h=10;
	Retainer_h=2;
	Nut_Len=Retainer_h+AftClosure_h+10;
	Tail_r=20;
	Base_d=MotorTube_OD+4.4;
	NomonalThread_d=MotorTube_OD+8;
	MotorTubeHole_d=MotorTube_OD+IDXtra*3;
	
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
		
		// Fin slots
		translate([0,0,Fin_Root_L/2+FinInset_Len])
			TrapFin2Slots(Tube_OD=Body_OD, nFins=nFins, Post_h=Fin_Post_h, 
							Root_L=Fin_Root_L, Root_W=Fin_Root_W, Chamfer_L=Fin_Chamfer_L);
		
		
		// Motor tube
		translate([0,0,-Cone_Len-Overlap]) 
			cylinder(d=MotorTubeHole_d, h=Cone_Len+Tail_r+FinInset_Len+FinAlignment_Len+Overlap*2);
	
		// Rail button bolt hole
		translate([-Body_OD/2,0,10]) rotate([0,-90,0]) Bolt8Hole();
		
		if (Threaded) translate([0,0,-Cone_Len-Overlap]) cylinder(d=Body_OD, h=Nut_Len);
	} // difference
	
	if (Threaded) difference(){
		translate([0,0,-Cone_Len+Nut_Len-10]) 
			ExternalThread(Pitch=2.5, Dia_Nominal=NomonalThread_d, 
							Length=10+Overlap, Step_a=$preview? 10:2, TrimEnd=true, TrimRoot=false);
			
		// Motor tube
		translate([0,0,-Cone_Len-Overlap]) 
			cylinder(d=MotorTubeHole_d, h=Cone_Len+FinInset_Len+FinAlignment_Len+Overlap*2);
	}
} // FC2_TailCone

//rotate([180,0,0]) FC2_TailCone(Interface_OD=BT98Body_ID);

module FC2_MotorRetainer(Body_OD=BT98Body_OD,
						MotorTube_OD=BT54Body_OD, MotorTube_ID=BT54Body_ID,
						HasWrenchCuts=false, Cone_Len=65, ExtraLen=0){
	
	
	AftClosure_h=10;
	Retainer_h=2;
	Nut_Len=Retainer_h+AftClosure_h+10;
	Tail_r=20;
	Base_d=MotorTube_OD+4.4;
	NomonalThread_d=MotorTube_OD+8;
	
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
			ExternalThread(Pitch=2.5, Dia_Nominal=NomonalThread_d+IDXtra*4, 
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
difference(){
	union(){
		TailCone(Cone_Len=35);
		translate([0,0,-Overlap]) rotate([0,0,-150]) MotorRetainer(Cone_Len=35,ExtraLen=4);
	} // union
	
	translate([0,0,-50]) cube([50,50,50]);
} // difference
/**/





















