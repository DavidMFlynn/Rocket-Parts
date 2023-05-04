// ***********************************
// Project: 3D Printed Rocket
// Filename: RailGuide.scad
// by David M. Flynn
// Created: 6/11/2022 
// Revision: 1.0.4  1/1/2023
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  Rail guides. Rail button posts and stuff. 
//
//  ***** History *****
//
echo("RailGuide 1.0.4");
// 1.0.4  1/1/2023  Bolt holes now thru in RailGuidePost. 
// 1.0.3  11/7/2022 Shorter cap to clear 8020-1010 rail better. 
// 1.0.2  10/29/2022 Narrower and taller by 0.3mm.
// 1.0.1  10/11/2022 Added TubeBoltedRailGuide
// 1.0.0  10/4/2022 Printed and verified function.  
// 0.9.1  10/4/2022 Added BoltOnRailGuide()
// 0.9.0  6/11/2022 First code.
//
// ***********************************
//  ***** for STL output *****
//
// RailButton();
//
// rotate([90,0,0]) BoltOnRailGuide(Length = 40, BoltSpace=12.7, RoundEnds=true);
// RialGuide(TubeOD = 98, Length = 40, Offset = 3);
//
// TubeBoltedRailGuide(TubeOD=PML98Body_OD, Length = 30, Offset = 3);
//
// BoltOnRailButtonPost(OD=PML98Body_OD, H=5.5*25.4/2);
//
// ***********************************
//  ***** Routines *****
//
// RailGuideBoltPattern(BoltSpace=12.7) Bolt6Hole();
// RialGuide(TubeOD = 98, Length = 40, Offset = 3);
//
// RailGuideMountingPlate(Length = 40, BoltSpace=12.7);
//
// *** Includes sections of tube.  Usually part of a fin can. ***
// RailGuidePost(OD=PML98Body_OD, MtrTube_OD=PML54Body_OD, H=5.5*25.4/2, TubeLen=70, Length = 40, BoltSpace=12.7);
//
// RailButtonPost(OD=PML98Body_OD, MtrTube_OD=PML54Body_OD, H=5.5*25.4/2, Len=50); // Includes sections of tube. 
//
// ***********************************

include <TubesLib.scad>
include <CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

// ***** 8020.net 1010 Profile *****
// ***** Also works with Blacksky standard rail *****
// ***** Verified 10/4/2022 *****

RG_Back_w=0.626*25.4;
RG_Web_w=0.250*25.4 - 0.8;
RG_Web_t=0.125*25.4 + 0.8;
RG_Cap_w=0.500*25.4 - 1.0;
RG_Cap_t=4; //was 0.250*25.4 - 1.0;


module RailButton(){
	OD=10;
	ID=4.2+IDXtra*2;
	Slot_OD=6.3;
	Slot_w=3.8;
	Flange_h=2;
	
	difference(){
		union(){
			cylinder(d=OD, h=Flange_h);
			cylinder(d=Slot_OD, h=Flange_h+Slot_w/2);
			//translate([0,0,Flange_h+Slot_w]) cylinder(d=OD, h=Flange_h);
		} // union
		
		translate([0,0,-Overlap]) cylinder(d=ID, h=Flange_h*2+Slot_w+Overlap*2);
	} // difference
} // RailButton

//RailButton();

module RailGuideBoltPattern(BoltSpace=12.7){
	translate([0,0,BoltSpace/2]) rotate([-90,0,0]) children();
	if (BoltSpace>30)
		translate([0,0,0]) rotate([-90,0,0]) children();
	translate([0,0,-BoltSpace/2]) rotate([-90,0,0]) children();
		
} // RailGuideBoltPattern



module BoltOnRailGuide(Length = 40, BoltSpace=12.7, RoundEnds=true, ExtraBack=0){
	Back_T=3;
	
	difference(){
		union(){
			if (RoundEnds){
				hull(){
				translate([0,-ExtraBack,-Length/2+RG_Back_w/2]) 
					rotate([-90,0,0]) cylinder(d=RG_Back_w, h=Back_T+ExtraBack);
				translate([0,-ExtraBack,Length/2-RG_Back_w/2]) 
					rotate([-90,0,0]) cylinder(d=RG_Back_w, h=Back_T+ExtraBack);
				} // hull
			}else{
			translate([0,Back_T/2,-Length/2])
				RoundRect(X=RG_Back_w, Y=Back_T, Z=Length, R=Back_T/2);
			}
			
			if (RoundEnds){
				hull(){
					translate([0,0,-Length/2+RG_Web_w/2]) 
						rotate([-90,0,0]) cylinder(d=RG_Web_w, h=Back_T+RG_Web_t+Overlap);
					translate([0,0,Length/2-RG_Web_w/2]) 
						rotate([-90,0,0]) cylinder(d=RG_Web_w, h=Back_T+RG_Web_t+Overlap);
				} // hull
			}else{
			translate([-RG_Web_w/2,0,-Length/2]) 
				cube([RG_Web_w,Back_T+RG_Web_t+Overlap,Length]);
			}
			
			hull(){
				translate([0,Back_T+RG_Web_t+1,-Length/2]){
					translate([-RG_Cap_w/2+1,0,0]) cylinder(r=1, h=Length);
					translate([RG_Cap_w/2-1,0,0]) cylinder(r=1, h=Length);
				}
				translate([0,Back_T+RG_Web_t+RG_Cap_t-1,-Length/2]){
					translate([-RG_Web_w/2+1,0,0]) cylinder(r=1, h=Length);
					translate([RG_Web_w/2-1,0,0]) cylinder(r=1, h=Length);
				}
			} // hull
		} // union
		
		// Bolts 
		translate([0,Back_T+RG_Web_t+3,0]) 
			RailGuideBoltPattern(BoltSpace=BoltSpace) Bolt6ButtonHeadHole();
		
		//Chamfer
		translate([-RG_Cap_w,-5,-Length/2-8]) 
			rotate([-45,0,0]) cube([RG_Cap_w*2,Back_T+50,Length]);
		mirror([0,0,1])
		translate([-RG_Cap_w,-5,-Length/2-8]) 
			rotate([-45,0,0]) cube([RG_Cap_w*2,Back_T+50,Length]);
		
	} // difference
} // BoltOnRailGuide

//BoltOnRailGuide();

module RailGuideMountingPlate(Length = 40, BoltSpace=12.7){
	Plate_t=5;
	
	difference(){
		translate([-RG_Back_w/2,-Plate_t,-Length/2]) cube([RG_Back_w,Plate_t,Length]);
		
		// Bolts 
		RailGuideBoltPattern(BoltSpace=BoltSpace) Bolt6Hole();
	} // difference
} // RailGuideMountingPlate

//RailGuideMountingPlate();


module RailGuidePost(OD=PML98Body_OD, MtrTube_OD=PML54Body_OD, H=5.5*25.4/2, TubeLen=60,
						Length = 30, BoltSpace=12.7){
	Size_Z=TubeLen;
	
	translate([0,0,-Size_Z/2]) 
		Tube(OD=MtrTube_OD+4.4+IDXtra*3, ID=MtrTube_OD+IDXtra*3, Len=Size_Z, myfn=$preview? 36:360);
	
	difference(){
		union(){
			translate([0,0,-Size_Z/2]) Tube(OD=OD, ID=OD-4.4, Len=Size_Z, myfn=$preview? 36:360);
			
			translate([0,MtrTube_OD/2+IDXtra,0])
			hull(){
				translate([0,0,Size_Z/2-1]) 
					rotate([-90,0,0]) cylinder(d=2, h=OD/2-MtrTube_OD/2);
				translate([0,0,-Size_Z/2+1]) 
					rotate([-90,0,0]) cylinder(d=2, h=OD/2-MtrTube_OD/2);
				
				translate([0,0,Length/2]) 
					rotate([-90,0,0]) cylinder(d=18, h=OD/2-MtrTube_OD/2);
				translate([0,0,-Length/2]) 
					rotate([-90,0,0]) cylinder(d=18, h=OD/2-MtrTube_OD/2);
				
				translate([0,0,Length/2-RG_Back_w/2]) 
					rotate([-90,0,0]) cylinder(d=RG_Back_w, h=H-MtrTube_OD/2-IDXtra);
				translate([0,0,-Length/2+RG_Back_w/2]) 
					rotate([-90,0,0]) cylinder(d=RG_Back_w, h=H-MtrTube_OD/2-IDXtra);
				
				//translate([0,H-MtrTube_OD/2-IDXtra,0]) 
				//RailGuideMountingPlate(Length = Length, BoltSpace=BoltSpace);
			} // hull
		} // union
		
		translate([0,H,0]) RailGuideBoltPattern(BoltSpace=BoltSpace) Bolt6Hole(depth=H);
	} // difference
} // RailGuidePost

//RailGuidePost();
//translate([0,5.5*25.4/2,0]) BoltOnRailGuide(Length = 40, BoltSpace=12.7);

module BoltOnRailGuidePost(OD=PML98Body_OD, H=5.5*25.4/2,
						Length = 30, BoltSpace=12.7){
	Size_Z=Length+10;
	
	difference(){
		union(){
			translate([0,0,-Size_Z/2]) Tube(OD=OD+4.4, ID=OD, Len=Size_Z, myfn=$preview? 36:360);
			
			hull(){
				translate([0,0,Size_Z/2-1]) 
					rotate([-90,0,0]) cylinder(d=2, h=OD/2);
				translate([0,0,-Size_Z/2+1]) 
					rotate([-90,0,0]) cylinder(d=2, h=OD/2);
				
				translate([0,0,Length/2]) 
					rotate([-90,0,0]) cylinder(d=18, h=OD/2);
				translate([0,0,-Length/2]) 
					rotate([-90,0,0]) cylinder(d=18, h=OD/2);
				
				translate([0,0,Length/2-RG_Back_w/2]) 
					rotate([-90,0,0]) cylinder(d=RG_Back_w, h=H);
				translate([0,0,-Length/2+RG_Back_w/2]) 
					rotate([-90,0,0]) cylinder(d=RG_Back_w, h=H);
				
			} // hull
		} // union
		
		translate([0,H,0]) RailGuideBoltPattern(BoltSpace=BoltSpace) Bolt6Hole(depth=H);
	} // difference
} // BoltOnRailGuidePost

//BoltOnRailGuidePost(OD=PML98Body_OD, H=PML98Body_OD/2+2, Length = 30, BoltSpace=12.7);

module RialGuide(TubeOD = 98, Length = 40, Offset = 3){
	
	difference(){
		union(){
			translate([-RG_Cap_w/2,0,-Length/2]) 
				cube([RG_Cap_w,TubeOD/2+Offset,Length]);
			translate([-RG_Web_w/2,0,-Length/2]) 
				cube([RG_Web_w,TubeOD/2+Offset+RG_Web_t+Overlap,Length]);
			hull(){
				translate([0,TubeOD/2+Offset+RG_Web_t+1,-Length/2]){
					translate([-RG_Cap_w/2+1,0,0]) cylinder(r=1, h=Length);
					translate([RG_Cap_w/2-1,0,0]) cylinder(r=1, h=Length);
				}
				translate([0,TubeOD/2+Offset+RG_Web_t+RG_Cap_t-1,-Length/2]){
					translate([-RG_Web_w/2+1,0,0]) cylinder(r=1, h=Length);
					translate([RG_Web_w/2-1,0,0]) cylinder(r=1, h=Length);
				}
			} // hull
		} // union
		
		//Chamfer
		translate([-RG_Cap_w,TubeOD/2-5+Offset,-Length/2-4]) 
			rotate([-45,0,0]) cube([RG_Cap_w*2,Offset+50,Length]);
		mirror([0,0,1])
		translate([-RG_Cap_w,TubeOD/2-5+Offset,-Length/2-4]) 
			rotate([-45,0,0]) cube([RG_Cap_w*2,Offset+50,Length]);
		
		// Body tube
		translate([0,0,-Length/2-Overlap]) 
			cylinder(r=TubeOD/2, h=Length+Overlap*2, $fn=$preview? 36:360);
	} // difference
} // RialGuide

// RialGuide();


module TubeBoltedRailGuide(TubeOD=PML98Body_OD, Length = 30, Offset = 2){
	Size_Z=50;
	Size_Y=30;
	
	function CalcChord_a(Dia=10, Dist=1)=Dist/(Dia*PI)*360;
	
	Bolt_a=CalcChord_a(TubeOD,Size_Y/2-6);
	
	rotate([0,0,-90]) translate([0,TubeOD/2+Offset-3,0])
		BoltOnRailGuide(Length = Length, BoltSpace=12.7, RoundEnds=true, ExtraBack=Offset-4);
		
	difference(){
		intersection(){
			translate([0,0,-Size_Z/2]) Tube(OD=TubeOD+4.4, ID=TubeOD+IDXtra*2, 
				Len=Size_Z, myfn=$preview? 36:360);
			rotate([0,90,0]) RoundRect(X=Size_Z, Y=Size_Y, Z=TubeOD, R=4);
		} // intersection
		
		rotate([0,0,Bolt_a]){ 
			translate([TubeOD/2+3,0,Size_Z/2-6]) 
				rotate([0,90,0]) Bolt6ClearHole();
			translate([TubeOD/2+3,0,-Size_Z/2+6]) 
				rotate([0,90,0]) Bolt6ClearHole();
		}
		rotate([0,0,-Bolt_a]){
			translate([TubeOD/2+3,0,Size_Z/2-6]) 
				rotate([0,90,0]) Bolt6ClearHole();
			translate([TubeOD/2+3,0,-Size_Z/2+6]) 
				rotate([0,90,0]) Bolt6ClearHole();
		}
		
		
	} // difference
	
} // TubeBoltedRailGuide

// rotate([0,-90,0]) TubeBoltedRailGuide(TubeOD=PML98Body_OD, Length = 35,  Offset = 5.5);



module RailButtonPost(OD=PML98Body_OD, MtrTube_OD=PML54Body_OD, H=5.5*25.4/2, Len=50){
	Size_Z=Len;
	
	translate([0,0,-Size_Z/2]) Tube(OD=MtrTube_OD+4.4+IDXtra*3, ID=MtrTube_OD+IDXtra*3, Len=Size_Z, myfn=$preview? 36:360);
	
	difference(){
		union(){
			translate([0,0,-Size_Z/2]) Tube(OD=OD, ID=OD-4.4, Len=Size_Z, myfn=$preview? 36:360);
			hull(){
				translate([MtrTube_OD/2+IDXtra,0,Size_Z/2-1]) 
					rotate([0,90,0]) cylinder(d=2, h=OD/2-MtrTube_OD/2);
				translate([MtrTube_OD/2+IDXtra,0,-Size_Z/2+1]) 
					rotate([0,90,0]) cylinder(d=2, h=OD/2-MtrTube_OD/2);
				translate([MtrTube_OD/2+IDXtra,0,0]) 
					rotate([0,90,0]) cylinder(d=16, h=OD/2-MtrTube_OD/2);
				translate([MtrTube_OD/2+IDXtra,0,0]) 
					rotate([0,90,0]) cylinder(d=10, h=H-MtrTube_OD/2-IDXtra);
			} // hull
		} // union
		
		translate([H,0,0]) rotate([0,90,0]) Bolt8Hole();
	} // difference
} // RailButtonPost

//RailButtonPost(OD=PML98Body_OD, MtrTube_OD=PML54Body_OD, H=5.5*25.4/2);

module BoltOnRailButtonPost(OD=PML98Body_OD, H=5.5*25.4/2){
	Size_Z=50;
	
	difference(){
		union(){
			translate([0,0,-Size_Z/2]) Tube(OD=OD+4.4, ID=OD+IDXtra*2, Len=Size_Z, myfn=$preview? 36:360);
			
			hull(){
				translate([OD/2+IDXtra,0,Size_Z/2-1]) rotate([0,90,0]) cylinder(d=2, h=2);
				translate([OD/2+IDXtra,0,-Size_Z/2+1]) rotate([0,90,0]) cylinder(d=2, h=2);
				translate([OD/2+IDXtra,0,0]) rotate([0,90,0]) cylinder(d=16, h=2);
				translate([OD/2+IDXtra,0,0]) rotate([0,90,0]) cylinder(d=10, h=H-OD/2-IDXtra);
			} // hull
			
		} // union
		
		translate([-OD/2-5,-OD/2-5,-Size_Z/2-Overlap]) cube([OD*0.75,OD+10,Size_Z+Overlap*2]);
		translate([0,15,-Size_Z/2-Overlap]) cube([OD*0.75,OD+10,Size_Z+Overlap*2]);
		translate([0,-15,-Size_Z/2-Overlap]) mirror([0,1,0]) cube([OD*0.75,OD+10,Size_Z+Overlap*2]);
		
		rotate([0,0,10]) translate([OD/2+3,0,Size_Z/3]) rotate([0,90,0]) Bolt8Hole();
		rotate([0,0,-10]) translate([OD/2+3,0,Size_Z/3]) rotate([0,90,0]) Bolt8Hole();
		rotate([0,0,10]) translate([OD/2+3,0,-Size_Z/3]) rotate([0,90,0]) Bolt8Hole();
		rotate([0,0,-10]) translate([OD/2+3,0,-Size_Z/3]) rotate([0,90,0]) Bolt8Hole();
		
		translate([H,0,0]) rotate([0,90,0]) Bolt8Hole();
	} // difference
	
} // BoltOnRailButtonPost

// BoltOnRailButtonPost();











