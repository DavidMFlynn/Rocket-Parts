// ***********************************
// Project: 3D Printed Rocket
// Filename: ShroudLineTool.scad
// by David M. Flynn
// Created: 7/23/2024 
// Revision: 1.0.0  7/23/2024 
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  ***** History *****
//
// 1.0.0  7/23/2024   First code.
//
// ***********************************
//  ***** for STL output *****
//
//
// ***********************************
//  ***** Routines *****
//
//
// ***********************************
//  ***** for Viewing *****
//
// ShowRocket();
// translate([300,0,0]) ShowRocket(ShowInternals=true);
//
// ***********************************


include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

module ServingPost(){
	Post_CL=240;
	Tube_d=12.7;
	Thickness=30;
	
	difference(){
		hull(){
			translate([-Post_CL/2,0,0]) cylinder(d=Tube_d+12, h=Thickness);
			cylinder(d=40, h=Thickness+10);
			translate([Post_CL/2,0,0]) cylinder(d=Tube_d+12, h=Thickness);
		} // hull
	
		translate([0,0,4]) rotate([180,0,0]) BoltM8ButtonHeadHole(depth=Thickness+10,lHead=12);
		translate([-Post_CL/2,0,-Overlap]) cylinder(d=Tube_d, h=Thickness+10);
		translate([Post_CL/2,0,-Overlap]) cylinder(d=Tube_d, h=Thickness+10);
	} // difference
} // ServingPost

//ServingPost();

module ServingSpoolFrame(){
	Width=54;
	Thickness=4;
	H=34;
	Length=40+H/2;
	V=7;
	
	difference(){
		union(){
			translate([-Width/2-Thickness,0,0]) cube([Thickness, Length, H]);
			translate([Width/2,0,0]) cube([Thickness, Length, H]);
			
			hull(){
				translate([-Width/2-Thickness/2,0,0]) cylinder(d=Thickness, h=H);
				translate([-V, 0, 0]) cylinder(d=Thickness, h=H);
			} // hull
			
			hull(){
				translate([Width/2+Thickness/2,0,0]) cylinder(d=Thickness, h=H);
				translate([V, 0, 0]) cylinder(d=Thickness, h=H);
			} // hull
			
			hull(){
				translate([0, V, 0]) cylinder(d=Thickness, h=H);
				translate([V, 0, 0]) cylinder(d=Thickness, h=H);
			} // hull
			
			hull(){
				translate([0, V, 0]) cylinder(d=Thickness, h=H);
				translate([-V, 0, 0]) cylinder(d=Thickness, h=H);
			} // hull
			
			difference(){
				translate([0,10,H/2-3]) cube([Width+1, 20, Thickness],center=true);
				translate([0,0,H/2-3]) rotate([0,0,45]) cube([V*2-2, V*2-2, Thickness+Overlap],center=true);
			} // difference
		} // union
		
		// Spool
		translate([-Width/2-Thickness, Length-H/2, H/2]) rotate([0,-90,0]) Bolt8Hole();
		translate([Width/2+Thickness, Length-H/2, H/2]) rotate([0,90,0]) Bolt8Hole();
		
		// Tensioning holes
		translate([0,12,0]) cylinder(d=2, h=H);
		translate([0,18,0]) cylinder(d=2, h=H);
		translate([10,15,0]) cylinder(d=2, h=H);
		
		// String hole
		translate([0,0,H/2]) rotate([-90,0,0]) cylinder(d=2, h=20);
	} // difference

} // ServingSpoolFrame

// ServingSpoolFrame();







































