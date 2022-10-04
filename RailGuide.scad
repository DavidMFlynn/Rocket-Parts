// ***********************************
// Project: 3D Printed Rocket
// Filename: RailGuide.scad
// Created: 6/11/2022 
// Revision: 0.9.0  6/11/2022
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  Rail guides.
//
//  ***** History *****
//
echo("RailGuide 0.9.0");
// 0.9.0  6/11/2022 First code.
//
// ***********************************
//  ***** for STL output *****
//
// RialGuide(TubeOD = 98, Length = 40, Offset = 3);
//
// ***********************************
//  ***** Routines *****
//
// RialGuide(TubeOD = 98, Length = 40, Offset = 3);
//
// ***********************************

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

// ***** 8020.net 1010 Profile *****
RG_Web_w=0.256*25.4 - 0.5;
RG_Web_t=0.087*25.4 + 1.0;
RG_Cap_w=0.584*25.4 - 1.0;
RG_Cap_t=0.230*25.4 - 1.0;


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
		translate([-RG_Cap_w,TubeOD/2-5,-Length/2-4]) 
			rotate([-45,0,0]) cube([RG_Cap_w*2,Offset+50,Length]);
		mirror([0,0,1])
		translate([-RG_Cap_w,TubeOD/2-5,-Length/2-4]) 
			rotate([-45,0,0]) cube([RG_Cap_w*2,Offset+50,Length]);
		
		// Body tube
		translate([0,0,-Length/2-Overlap]) 
			cylinder(r=TubeOD/2-Overlap, h=Length+Overlap*2);
	} // difference
} // RialGuide

// RialGuide();














