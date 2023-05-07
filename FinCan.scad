// ***********************************
// Project: 3D Printed Rocket
// Filename: FinCan.scad
// by David M. Flynn
// Created: 6/14/2022 
// Revision: 0.9.6  5/7/2023
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  This file is sample code.
//
//  ***** History *****
//
echo("FinCan 0.9.6");
//
// 0.9.6  5/7/2023  Still working on it, FinCan3 is now just FinCan.
// 0.9.5  10/4/2022 Moved rail button posts to RailGuide.scad 
// 0.9.4  9/6/2022  Cleaned up RailButtonPost()
// 0.9.3  8/29/2022 Fixed motor tube clearance in FinCan3. 
// 0.9.2  8/27/2022 New Fin Can and TailCone. 
// 0.9.1  6/30/2022 Worked on FinCan2 
// 0.9.0  6/14/2022 First code.
//
// ***********************************
//  ***** for STL output *****
// 
/*
rotate([180,0,0])
	FinCan(Tube_OD=PML98Body_OD, Tube_ID=PML98Body_ID, MtrTube_OD=PML54Body_OD, nFins=5, 
					Post_h=10, Root_L=180, Root_W=10, Chamfer_L=18,
					HasTailCone=false,
					HasIntegratedCouplerTube=true);
/**/

/*
rotate([180,0,0])
	FinCan(Tube_OD=PML98Body_OD, Tube_ID=PML98Body_ID, MtrTube_OD=PML54Body_OD, nFins=5, 
					Post_h=10, Root_L=180, Root_W=10, Chamfer_L=18,
					HasTailCone=true,
					MtrRetainer_OD=63,
					MtrRetainer_L=16,
					MtrRetainer_Inset=5,
					HasIntegratedCouplerTube=false);
/**/
// 
//
//
// ***********************************
//  ***** Routines *****
//
/*
  TailCone(OD=PML98Body_OD, ID=PML54Body_OD, Len=50, 
			MtrRetainer_OD=63,
			MtrRetainer_L=16,
			MtrRetainer_Inset=5,
			Solid=false);
/**/
//
/*
  FinCan(Tube_OD=PML98Body_OD, Tube_ID=PML98Body_ID, MtrTube_OD=PML54Body_OD, nFins=5, 
					Post_h=10, Root_L=180, Root_W=10, Chamfer_L=18,
					HasTailCone=false,
					MtrRetainer_OD=63,
					MtrRetainer_L=16,
					MtrRetainer_Inset=5,
					HasIntegratedCouplerTube=false);
/**/
// ***********************************

include<TubesLib.scad>
include<Fins.scad>
include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

module TailCone(OD=PML98Body_OD, ID=PML54Body_OD, Len=50, 
			MtrRetainer_OD=63,
			MtrRetainer_L=16,
			MtrRetainer_Inset=5,
			Solid=true){
				
	TC_d=(OD-ID)/2;
	TC_h=TC_d*2;
	Wall_t=2.2;
	
	difference(){
		hull(){
			translate([0,0,Len-Overlap]) cylinder(d=OD, h=Overlap, $fn=$preview? 36:360);
			translate([0,0,TC_h]) rotate_extrude($fn=$preview? 36:360) 
				translate([OD/2-TC_d/2,0,0]) circle(d=TC_d, $fn=$preview? 36:90);
			cylinder(d=ID, h=Overlap, $fn=$preview? 36:360);
		} // hull
		
		if (Solid==false)
		difference(){
			hull(){
				translate([0,0,Len]) cylinder(d=OD-Wall_t*2, h=Overlap, $fn=$preview? 36:360);
				translate([0,0,TC_h]) rotate_extrude($fn=$preview? 36:360) 
					translate([OD/2-TC_d/2,0,0]) circle(d=TC_d-Wall_t*2, $fn=$preview? 36:90);
				translate([0,0,MtrRetainer_L+MtrRetainer_Inset+Wall_t*2]) 
					cylinder(d=ID+Wall_t*2, h=Overlap, $fn=$preview? 36:360);
			} // hull
			
			// Motor Tube
			translate([0,0,-Overlap]) cylinder(d=ID+4.4, h=Len+Overlap*2, $fn=$preview? 36:360);
		} // difference
		
		// Motor Tube
		translate([0,0,-Overlap]) cylinder(d=ID, h=Len+Overlap*2, $fn=$preview? 36:360);
		// Motor Retainer
		translate([0,0,-Overlap]) cylinder(d=MtrRetainer_OD+IDXtra*2, 
						h=MtrRetainer_L+MtrRetainer_Inset+Overlap*2, $fn=$preview? 36:360);
		// Trim end
		cylinder(d=OD, h=MtrRetainer_Inset);
	} // difference
	
} // TailCone

// TailCone();

module FinCan(Tube_OD=PML98Body_OD, Tube_ID=PML98Body_ID, MtrTube_OD=PML54Body_OD, nFins=5, 
					Post_h=10, Root_L=180, Root_W=10, Chamfer_L=18,
					HasTailCone=false,
					MtrRetainer_OD=63,
					MtrRetainer_L=16,
					MtrRetainer_Inset=5,
					HasIntegratedCouplerTube=false){
					
	TailCone_Len=50;
	CR_t=5;	//Centering Ring Thickness
	EndExtra=HasTailCone? TailCone_Len:15;
	OAL=Root_L/2+EndExtra+CR_t;
	
	difference(){
		union(){
			translate([0,0,EndExtra]) rotate([0,0,180/nFins])
				CenteringRing(OD=Tube_OD-1, ID=MtrTube_OD+IDXtra*2, Thickness=CR_t, nHoles=nFins);
			translate([0,0,OAL-5]) rotate([0,0,180/nFins])
				CenteringRing(OD=Tube_OD-1, ID=MtrTube_OD+IDXtra*2, Thickness=CR_t, nHoles=nFins);
			
			if (HasTailCone){
				TailCone(OD=Tube_OD, ID=MtrTube_OD, Len=TailCone_Len+Overlap,
						MtrRetainer_OD=MtrRetainer_OD,
						MtrRetainer_L=MtrRetainer_L,
						MtrRetainer_Inset=MtrRetainer_Inset,
						Solid=false);
				
				translate([0,0,EndExtra]) Tube(OD=Tube_OD, ID=Tube_ID, Len=OAL-EndExtra, myfn=$preview? 36:360);
			}else{
				if (HasIntegratedCouplerTube){
					translate([0,0,EndExtra]) 
						Tube(OD=Tube_OD, ID=Tube_ID, Len=OAL-EndExtra, myfn=$preview? 36:360);
					Tube(OD=Tube_ID-IDXtra, ID=Tube_ID-8, Len=EndExtra+Overlap, myfn=$preview? 36:360);
				}else{
					Tube(OD=Tube_OD, ID=Tube_ID, Len=OAL, myfn=$preview? 36:360);
				}
			} // if
			
			for (j=[0:nFins])hull(){
				translate([0,0,EndExtra]) cylinder(d=Root_W+4.4, h=Root_L/2+CR_t);
				rotate([0,0,360/nFins*j]) translate([Tube_OD/2,0,EndExtra]) 
					cylinder(d=Root_W+4.4, h=Root_L/2+CR_t);
			}
		} // union
		
		translate([0,0,-Overlap]) cylinder(d=MtrTube_OD+IDXtra*2, h=OAL+Overlap*2);
		
		difference(){
			translate([0,0,EndExtra-Overlap]) cylinder(d=Tube_OD+40, h=Root_L/2+10+Overlap*2);
			translate([0,0,EndExtra-Overlap*2]) cylinder(d=Tube_OD, h=Root_L/2+10+Overlap*4, $fn=$preview? 36:360);
		} // difference
		
		translate([0,0,OAL])
		TrapFin2Slots(Tube_OD=Tube_OD, nFins=nFins, 
				Post_h=Post_h, Root_L=Root_L, Root_W=Root_W, Chamfer_L=Chamfer_L);
		
	} // difference
} // FinCan

/*
FinCan(Tube_OD=PML98Body_OD, Tube_ID=PML98Body_ID, MtrTube_OD=PML54Body_OD, nFins=5, 
					Post_h=10, Root_L=180, Root_W=10, Chamfer_L=18,
					HasTailCone=false,
					HasIntegratedCouplerTube=true);
/**/

/*
FinCan(Tube_OD=PML98Body_OD, Tube_ID=PML98Body_ID, MtrTube_OD=PML54Body_OD, nFins=5, 
					Post_h=10, Root_L=180, Root_W=10, Chamfer_L=18,
					HasTailCone=true,
					MtrRetainer_OD=63,
					MtrRetainer_L=16,
					MtrRetainer_Inset=5,
					HasIntegratedCouplerTube=false);
/**/


//rotate([180,0,0]) FinCan(Tube_OD=PML98Body_OD, Tube_ID=PML98Body_ID, MtrTube_OD=PML54Body_OD, nFins=5, Post_h=10, Root_L=180, Root_W=10, Chamfer_L=18, HasTailCone=false); // UpperFinCan
//FinCan(Tube_OD=PML98Body_OD, Tube_ID=PML98Body_ID, MtrTube_OD=PML54Body_OD, nFins=5, Post_h=10, Root_L=180, Root_W=10, Chamfer_L=18, HasTailCone=true);















