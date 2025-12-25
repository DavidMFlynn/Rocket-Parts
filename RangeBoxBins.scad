//**********************************************************
// Project: Bins for Range Box
// Filename: RangeBoxBins.scad
// Created: 12/23/2025
// Revision: 1.0.0 12/23/2025
// Units: mm
//**********************************************************
//  ***** Notes *****
//
// Bins for Dewalt drawers.
//
//  ***** History *****
//
// 1.0.0 12/23/2025   First code
//
//**********************************************************
//  ***** for STL output *****
//
// StandardBin(X=100, Y=57, Z=58, R=3, Base_t=1.5, Wall_t=1.6);
// StandardBin(X=200, Y=57, Z=58, R=3, Base_t=1.5, Wall_t=1.6);
// StandardBin(X=200, Y=107, Z=58, R=3, Base_t=1.5, Wall_t=1.6);
// EndBin(X=200, Y=57, Z=58, R=3, Base_t=1.5, Wall_t=1.6);
//
// FrontBin(X=84, Y=226, Z=58, R=3, Base_t=1.5, Wall_t=1.6);
// mirror([0,1,0]) FrontBin(X=84, Y=226, Z=58, R=3, Base_t=1.5, Wall_t=1.6);
//
//**********************************************************
include<CommonStuffSAEmm.scad>

$fn=90;
IDXtra=0.2;
Overlap=0.05;


module StandardBin(X=200, Y=57, Z=58, R=3, Base_t=1.5, Wall_t=1.2){
	difference(){
		RoundRect(X=X, Y=Y, Z=Z, R=R);
		
		translate([0,0,Base_t]) RoundRect(X=X-Wall_t*2, Y=Y-Wall_t*2, Z=Z, R=R-Wall_t);
	} // difference

} // StandardBin

// StandardBin(X=200, Y=57, Z=58, R=3, Base_t=1.5, Wall_t=1.2);

module EndBin(X=200, Y=57, Z=58, R=3, Base_t=1.5, Wall_t=1.2){
	Edge_Y=4;
	Edge_Z=18;
	
	difference(){
		union(){
			translate([0,Edge_Y/2,0]) RoundRect(X=X, Y=Y-Edge_Y, Z=Edge_Z+Overlap, R=R);
			hull(){
				translate([0,Edge_Y/2,Edge_Z]) RoundRect(X=X, Y=Y-Edge_Y, Z=Overlap, R=R);
				translate([0,0,Edge_Z+Edge_Y]) RoundRect(X=X, Y=Y, Z=Z-Edge_Z-Edge_Y, R=R);
			} // hull
		} // union
		
		
		translate([0,Edge_Y/2,Base_t]) RoundRect(X=X-Wall_t*2, Y=Y-Edge_Y-Wall_t*2, Z=Z, R=R-Wall_t);
		
		hull(){
			translate([0,Edge_Y/2,Edge_Z]) RoundRect(X=X-Wall_t*2, Y=Y-Edge_Y-Wall_t*2, Z=Overlap, R=R-Wall_t);
			translate([0,0,Edge_Z+Edge_Y]) RoundRect(X=X-Wall_t*2, Y=Y-Wall_t*2, Z=Z, R=R-Wall_t);
		} // hull
	} // difference

} // EndBin

// EndBin();

module FrontBin(X=84, Y=226, Z=58, R=3, Base_t=1.5, Wall_t=1.6){
	Edge_Y=4;
	Edge_Z=18;
	LatchCutOut_X=25;
	LatchCutOut_Y=85;
	
	difference(){
		union(){
			translate([0, Edge_Y/2-LatchCutOut_Y/2, 0]) RoundRect(X=X, Y=Y-Edge_Y-LatchCutOut_Y, Z=Edge_Z+Overlap, R=R);
			translate([-LatchCutOut_X/2, Edge_Y/2, 0]) RoundRect(X=X-LatchCutOut_X, Y=Y-Edge_Y, Z=Z, R=R);
			
			hull(){
				translate([0, Edge_Y/2-LatchCutOut_Y/2, Edge_Z]) RoundRect(X=X, Y=Y-Edge_Y-LatchCutOut_Y, Z=Overlap, R=R);
				translate([0, -LatchCutOut_Y/2, Edge_Z+Edge_Y]) RoundRect(X=X, Y=Y-LatchCutOut_Y, Z=Z-Edge_Z-Edge_Y, R=R);
			} // hull
			
			translate([X/2-LatchCutOut_X+R/2, Y/2-LatchCutOut_Y+R/2, 0]) cylinder(r=R, h=Z);
		} // union
		
		
		
		translate([0, Edge_Y/2-LatchCutOut_Y/2, Base_t]) RoundRect(X=X-Wall_t*2, Y=Y-LatchCutOut_Y-Edge_Y-Wall_t*2, Z=Z, R=R-Wall_t);
		translate([-LatchCutOut_X/2, Edge_Y/2, Base_t]) RoundRect(X=X-LatchCutOut_X-Wall_t*2, Y=Y-Edge_Y-Wall_t*2, Z=Z, R=R-Wall_t);
		
		hull(){
			translate([0, Edge_Y/2-LatchCutOut_Y/2, Edge_Z]) RoundRect(X=X-Wall_t*2, Y=Y-LatchCutOut_Y-Edge_Y-Wall_t*2, Z=Overlap, R=R-Wall_t);
			translate([0, -LatchCutOut_Y/2, Edge_Z+Edge_Y]) RoundRect(X=X-Wall_t*2, Y=Y-LatchCutOut_Y-Wall_t*2, Z=Z, R=R-Wall_t);
		} // hull
		
		translate([X/2-LatchCutOut_X/2+Overlap/2, Y/2-LatchCutOut_Y/2+Overlap/2, -Overlap]) 
			RoundRect(X=LatchCutOut_X, Y=LatchCutOut_Y, Z=Z+Overlap*2, R=R-Wall_t);
		
		translate([X/2-LatchCutOut_X+R/2-Overlap*2, Y/2-LatchCutOut_Y+R/2-Overlap*2, Base_t])
			difference(){
				cylinder(r=R+2, h=Z);
				
				hull(){
					cylinder(r=R, h=Z+Overlap);
					translate([5,0,0]) cylinder(r=R, h=Z+Overlap);
					translate([0,5,0]) cylinder(r=R, h=Z+Overlap);
				} // hull
			} // difference
	} // difference

} // FrontBin

// FrontBin();
































