// ***********************************
// Project: 3D Printed Rocket
// Filename: FinCan.scad
// Created: 6/14/2022 
// Revision: 0.9.5  10/4/2022
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  This file is sample code.
//
//  ***** History *****
//
echo("FinCan 0.9.5");
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
// rotate([180,0,0]) FinCan2(BodyOD=PML54Body_OD+4, BodyID=PML54Body_OD, Len=150, nFins=5);
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
// FinCan2(BodyOD=PML98Body_OD, BodyID=PML98Body_ID, Len=400, nFins=5, HasForwardRG=true);
// rotate([180,0,0]) FinCan2(BodyOD=PML75Body_OD, BodyID=PML75Body_ID, Len=190, nFins=5, HasForwardRG=true);
//
//
// ***********************************
//  ***** Routines *****
//
//
// ***********************************

include<RailGuide.scad>
include<TubesLib.scad>
include<Fins.scad>
include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

module TailCone(OD=PML98Body_OD, ID=PML54Body_OD, Len=50, 
			MtrRetainer_OD=63,
			MtrRetainer_L=16,
			MtrRetainer_Inset=5){
				
	TC_d=(OD-ID)/2;
	TC_h=TC_d*1.7;
	
	difference(){
		hull(){
			translate([0,0,Len-Overlap]) cylinder(d=OD, h=Overlap, $fn=$preview? 36:360);
			translate([0,0,TC_h]) rotate_extrude($fn=$preview? 36:360) translate([OD/2-TC_d/2,0,0]) circle(d=TC_d, $fn=$preview? 36:90);
			cylinder(d=ID, h=Overlap, $fn=$preview? 36:360);
		} // hull
		
		translate([0,0,-Overlap]) cylinder(d=ID, h=Len+Overlap*2, $fn=$preview? 36:360);
		translate([0,0,-Overlap]) cylinder(d=MtrRetainer_OD+IDXtra*2, h=MtrRetainer_L+MtrRetainer_Inset+Overlap*2, $fn=$preview? 36:360);
		cylinder(d=OD, h=MtrRetainer_Inset);
	} // difference
	
} // TailCone

// TailCone();

module FinCan3(Tube_OD=PML98Body_OD, Tube_ID=PML98Body_ID, MtrTube_OD=PML54Body_OD, nFins=5, 
					Post_h=10, Root_L=180, Root_W=10, Chamfer_L=18,
					HasTailCone=false,
					MtrRetainer_OD=63,
					MtrRetainer_L=16,
					MtrRetainer_Inset=5){
				
	OAL=Root_L/2+50;
	
	difference(){
		union(){
			translate([0,0,40]) CenteringRing(OD=Tube_OD-1, ID=MtrTube_OD+IDXtra*2, Thickness=5);
			translate([0,0,Root_L/2+50-5]) CenteringRing(OD=Tube_OD-1, ID=MtrTube_OD+IDXtra*2, Thickness=5);
			
			if (HasTailCone){
				TailCone(OD=Tube_OD, ID=MtrTube_OD, Len=50+Overlap,
						MtrRetainer_OD=MtrRetainer_OD,
						MtrRetainer_L=MtrRetainer_L,
						MtrRetainer_Inset=MtrRetainer_Inset);
				
				translate([0,0,50]) Tube(OD=Tube_OD, ID=Tube_ID, Len=OAL-50, myfn=$preview? 36:360);
			}else{
				Tube(OD=Tube_OD, ID=Tube_ID, Len=OAL, myfn=$preview? 36:360);
			} // if
			
			for (j=[0:nFins])hull(){
				translate([0,0,40]) cylinder(d=Root_W+4.4, h=Root_L/2+10);
				rotate([0,0,360/nFins*j]) translate([Tube_OD/2,0,40]) cylinder(d=Root_W+4.4, h=Root_L/2+10);
			}
		} // union
		
		translate([0,0,-Overlap]) cylinder(d=MtrTube_OD+IDXtra*2, h=OAL+Overlap*2);
		
		difference(){
			translate([0,0,40-Overlap]) cylinder(d=Tube_OD+40, h=Root_L/2+10+Overlap*2);
			translate([0,0,40-Overlap*2]) cylinder(d=Tube_OD, h=Root_L/2+10+Overlap*4, $fn=$preview? 36:360);
		} // difference
		
		translate([0,0,OAL])
		TrapFin2Slots(Tube_OD=Tube_OD, nFins=nFins, 
				Post_h=Post_h, Root_L=Root_L, Root_W=Root_W, Chamfer_L=Chamfer_L);
		
	} // difference
} // FinCan3

/*
FinCan3(Tube_OD=PML98Body_OD, Tube_ID=PML98Body_ID, MtrTube_OD=PML54Body_OD, nFins=5, 
					Post_h=10, Root_L=180, Root_W=10, Chamfer_L=18,
					HasTailCone=false);
*/



//rotate([180,0,0]) FinCan3(Tube_OD=PML98Body_OD, Tube_ID=PML98Body_ID, MtrTube_OD=PML54Body_OD, nFins=5, Post_h=10, Root_L=180, Root_W=10, Chamfer_L=18, HasTailCone=false); // UpperFinCan
//FinCan3(Tube_OD=PML98Body_OD, Tube_ID=PML98Body_ID, MtrTube_OD=PML54Body_OD, nFins=5, Post_h=10, Root_L=180, Root_W=10, Chamfer_L=18, HasTailCone=true);


module FinCan1(Len=180, nFins=4){
	
	for (j=[0:nFins-1]) rotate([0,0,360/nFins*j]){
		//translate([0,0,25])
		//	Fillet(Tube_OD=PML54Body_OD, Len=100, W=4);
		translate([0,PML54Body_OD/2,25]) 
			TrapFin(Root_L=100, Tip_L=60, Root_W=4, Tip_W=2.0, Span=60);
	}
		
	
	Tube(OD=PML54Body_OD, ID=PML54Body_ID, Len=Len, myfn=$preview? 36:360);
	
	translate([0,0,25]) rotate([0,0,45]) 
		RialGuide(TubeOD = PML54Body_OD, Length = 40, Offset = 1);
	
	translate([0,0,Len-25]) rotate([0,0,45]) 
		RialGuide(TubeOD = PML54Body_OD, Length = 40, Offset = 1);

} // FinCan1

//FinCan1();

module FinCan2(BodyOD=PML98Body_OD, BodyID=PML98Body_ID, Len=180, nFins=5, HasForwardRG=false){
	
	FinLen=Len-30;
	FinRoot_w=5.5*(FinLen/150);
	FinChamfer=10*(FinLen/150);
	
	difference(){
		for (j=[0:nFins-1]) rotate([0,0,360/nFins*j]){
			translate([0,BodyOD/2,25]) 
				//Fin(Root_L=FinLen, Root_W=FinRoot_w, Tip_W=2.5, Span=FinLen/4, Chamfer_a=15);
				Fin2(Root_L=FinLen, Root_W=FinRoot_w, Tip_W=2.5, Chamfer=FinChamfer);
				//translate([0,0,25+FinChamfer+10])
					//Fillet(Tube_OD=BodyOD, Len=FinLen-FinChamfer*2-20, W=FinRoot_w-1.2);
			}
			
		cylinder(d=BodyOD-1, h=Len);
	} // difference
		
	
	Tube(OD=BodyOD, ID=BodyID, Len=Len, myfn=$preview? 36:360);
	
	translate([0,0,25]) rotate([0,0,180/nFins]) 
		RialGuide(TubeOD = BodyOD, Length = 40, Offset = 1);
	
	if (HasForwardRG==true)
	translate([0,0,Len-25]) rotate([0,0,180/nFins]) 
		RialGuide(TubeOD = BodyOD, Length = 40, Offset = 1);

} // FinCan2

// FinCan2(BodyOD=PML98Body_OD, BodyID=PML98Body_ID, Len=400, nFins=5, HasForwardRG=true);


//FinCan2(BodyOD=PML54Body_OD+4, BodyID=PML54Body_OD, Len=150, nFins=5);
















