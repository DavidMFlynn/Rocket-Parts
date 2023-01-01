// ***********************************************************
// CubeSat project parts
// Filename: CubeSat.scad
// Created: 12/31/2022
// Revision: 0.9.0 12/31/2022
// Units: mm
// ***********************************************************
// Notes:
//
// ***********************************************************
//  ***** for STL output *****
//
// CubeSatAnalog();
//
// ***********************************************************

Overlap=0.05;
$fn=$preview? 24:90;
IDXtra=0.2;

module CubeSatAnalog(){
	X=100; // Sat size
	Y=100;
	Z=100;
	R=2; // makes a better print
	Rail_X=12;
	Rail_Y=12;
	Rail_Z=12;
	
	module FrameRail(X=10, Y=10, Z=10){
		
		hull(){
			translate([-X/2+R, -Y/2+R, -Z/2+R]) sphere(r=R, $fn=24);
			translate([X/2-R, -Y/2+R, -Z/2+R]) sphere(r=R, $fn=24);
			translate([-X/2+R, Y/2-R, -Z/2+R]) sphere(r=R, $fn=24);
			translate([X/2-R, Y/2-R, -Z/2+R]) sphere(r=R, $fn=24);
			translate([-X/2+R, -Y/2+R, Z/2-R]) sphere(r=R, $fn=24);
			translate([X/2-R, -Y/2+R, Z/2-R]) sphere(r=R, $fn=24);
			translate([-X/2+R, Y/2-R, Z/2-R]) sphere(r=R, $fn=24);
			translate([X/2-R, Y/2-R, Z/2-R]) sphere(r=R, $fn=24);
			
		} // hull
	} // FrameRail
	
	module RailCube(XYZ=100, Rail_XYZ=12){
		X=XYZ;
		Y=XYZ;
		Z=XYZ;
		Rail_X=Rail_XYZ;
		Rail_Y=Rail_XYZ;
		Rail_Z=Rail_XYZ;
	
		translate([-X/2+Rail_X/2, -Y/2+Rail_Y/2, 0]) FrameRail(X=Rail_X, Y=Rail_Y, Z=Z);
		translate([-X/2+Rail_X/2, Y/2-Rail_Y/2, 0]) FrameRail(X=Rail_X, Y=Rail_Y, Z=Z);
		translate([X/2-Rail_X/2, -Y/2+Rail_Y/2, 0]) FrameRail(X=Rail_X, Y=Rail_Y, Z=Z);
		translate([X/2-Rail_X/2, Y/2-Rail_Y/2, 0]) FrameRail(X=Rail_X, Y=Rail_Y, Z=Z);
		
		translate([0, -Y/2+Rail_Y/2, -Z/2+Rail_Z/2]) FrameRail(X=X, Y=Rail_Y, Z=Rail_Z);
		translate([0, Y/2-Rail_Y/2, -Z/2+Rail_Z/2]) FrameRail(X=X, Y=Rail_Y, Z=Rail_Z);
		translate([0, -Y/2+Rail_Y/2, Z/2-Rail_Z/2]) FrameRail(X=X, Y=Rail_Y, Z=Rail_Z);
		translate([0, Y/2-Rail_Y/2, Z/2-Rail_Z/2]) FrameRail(X=X, Y=Rail_Y, Z=Rail_Z);
		
		translate([-X/2+Rail_X/2, 0, -Z/2+Rail_Z/2]) FrameRail(X=Rail_X, Y=Y, Z=Rail_Z);
		translate([X/2-Rail_X/2, 0, -Z/2+Rail_Z/2]) FrameRail(X=Rail_X, Y=Y, Z=Rail_Z);
		translate([-X/2+Rail_X/2, 0, Z/2-Rail_Z/2]) FrameRail(X=Rail_X, Y=Y, Z=Rail_Z);
		translate([X/2-Rail_X/2, 0, Z/2-Rail_Z/2]) FrameRail(X=Rail_X, Y=Y, Z=Rail_Z);
	} // RailCube
	
	difference(){
		RailCube(XYZ=X, Rail_XYZ=Rail_X);
		
		//RailCube(XYZ=X-2, Rail_XYZ=Rail_X-2);
		//if ($preview==false)
			translate([0,0,Z/2]) cube([X+Overlap*2, Y+Overlap*2, Z],center=true);
			
		translate([-X/2+Rail_X/2, Y/2-Rail_Y/2, -Overlap]) 
			FrameRail(X=Rail_X-2-IDXtra*2, Y=Rail_Y-2-IDXtra*2, Z=7);
		translate([X/2-Rail_X/2, Y/2-Rail_Y/2, -Overlap]) 
			FrameRail(X=Rail_X-2-IDXtra*2, Y=Rail_Y-2-IDXtra*2, Z=7);
		
	} // Diff
	
	
	translate([-X/2+Rail_X/2, -Y/2+Rail_Y/2, -Overlap]) 
		FrameRail(X=Rail_X-2-IDXtra*2, Y=Rail_Y-2-IDXtra*2, Z=5);
	translate([X/2-Rail_X/2, -Y/2+Rail_Y/2, -Overlap]) 
		FrameRail(X=Rail_X-2-IDXtra*2, Y=Rail_Y-2-IDXtra*2, Z=5);
		
} // CubeSatAnalog

CubeSatAnalog();


























