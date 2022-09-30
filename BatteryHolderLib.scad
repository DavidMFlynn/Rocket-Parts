// ***********************************
// Project: 3D Printed Rocket
// Filename: BatteryHolderLib.scad
// Created: 9/30/2022 
// Revision: 0.9.0  9/30/2022
// Units: mm
// ***********************************
//  ***** Notes *****
//
// A collection of battery holders. 
//
//  ***** History *****
//
// 0.9.0  9/30/2022 First code. Moved stuff to this file. 
//
// ***********************************
//  ***** for STL output *****
//
//  
//  rotate([180,0,0]) TubeEndDoubleBatteryHolder();
//  SingleBatteryHolder(Tube_ID=PML75Body_ID);
//  DoubleBatteryHolder(Tube_ID=PML75Body_ID);
//
// ***********************************
//  ***** Routines *****
//
//  SingleBatteryHolder(Tube_ID=PML75Body_ID);
//  DoubleBatteryHolder(Tube_ID=PML75Body_ID);
//
// ***********************************
//  ***** for Viewing *****
//
// 
// ***********************************

include<TubesLib.scad>
include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2; 
$fn=$preview? 24:90;

module TubeEndDoubleBatteryHolder(){
	// Sits in the E-Bay in the top of the motor tube. 
	
	Batt_h=45;
	Batt_X=27;
	Batt_Y=17;
	Batt_r=3;
	
	TubeID=PML54Body_ID; // motor tube
	TubeOD=PML54Body_OD;
	Base_h=Batt_h/2+5;
	
	difference(){
		union(){
			cylinder(d=TubeID-IDXtra*2, h=Base_h);
			translate([0,0,Base_h-Overlap]) cylinder(d=TubeOD, h=5);
		} // union
		
		translate([0,0,3]) RoundRect(X=Batt_X+IDXtra*2, Y=Batt_Y*2+IDXtra*2, Z=Batt_h, R=Batt_r);
		
		// Trim sides
		translate([Batt_X/2+3, -TubeOD/2, -Overlap]) cube([TubeOD/2, TubeOD, Batt_h]);
		mirror([1,0,0])
			translate([Batt_X/2+3, -TubeOD/2, -Overlap]) cube([TubeOD/2, TubeOD, Batt_h]);
		
	} // difference
	
} // TubeEndBatteryHolder

//TubeEndDoubleBatteryHolder();
	
	
module SingleBatteryHolder(Tube_ID=PML75Body_ID){
	// glues to or is part of the inside of the E-Bay or Fairing
	
	Batt_h=45;
	Batt_X=27;
	Batt_Y=17;
	Batt_r=3;
	
	difference(){
		cylinder(d=Tube_ID, h=Batt_h+6);
		
		translate([Batt_X/2+3,-Tube_ID/2-1,-Overlap]) cube([Tube_ID/2,Tube_ID+2,Batt_h+6+Overlap*2]);
		mirror([1,0,0])
		translate([Batt_X/2+3,-Tube_ID/2-1,-Overlap]) cube([Tube_ID/2,Tube_ID+2,Batt_h+6+Overlap*2]);
		translate([-Tube_ID/2,-Tube_ID/2-1,-Overlap]) 
			cube([Tube_ID,Tube_ID+1-Batt_Y*0.75-5,Batt_h+6+Overlap*2]);
		
		translate([0,Tube_ID/2-5-Batt_Y/2,6]) RoundRect(X=Batt_X, Y=Batt_Y, Z=Batt_h+Overlap, R=Batt_r);
		
		//ty-wraps
		translate([0,Tube_ID/2-1,-Overlap]) cylinder(d=3.5, h=Batt_h+6+Overlap*2);
		translate([-Batt_X/2-10,Tube_ID/2-4,18]) rotate([0,90,0]) cylinder(d=3.5, h=Batt_h+6+Overlap*2);
		translate([-Batt_X/2-10,Tube_ID/2-4,6+Batt_h-12]) rotate([0,90,0]) cylinder(d=3.5, h=Batt_h+6+Overlap*2);
	} // difference
	
} // SingleBatteryHolder

//SingleBatteryHolder();

module DoubleBatteryHolder(Tube_ID=PML75Body_ID){
	// glues to the inside of the E-Bay
	
	Batt_h=45;
	Batt_X=27;
	Batt_Y=17;
	
	difference(){
		cylinder(d=Tube_ID, h=Batt_h+3, $fn=$preview? 90:360);
		
		// Trim sides
		translate([Batt_Y+3,-Tube_ID/2-1,-Overlap]) cube([Tube_ID/2,Tube_ID+2,Batt_h+6+Overlap*2]);
		mirror([1,0,0])
		translate([Batt_Y+3,-Tube_ID/2-1,-Overlap]) cube([Tube_ID/2,Tube_ID+2,Batt_h+6+Overlap*2]);
		
		// Trim front
		translate([-Tube_ID/2,-Tube_ID/2-1,-Overlap]) 
			cube([Tube_ID,Tube_ID+1-Batt_X*0.75-5,Batt_h+6+Overlap*2]);
		
		// Batteries
		translate([0,Tube_ID/2-6-Batt_X/2,3]) RoundRect(X=Batt_Y*2, Y=Batt_X, Z=Batt_h+Overlap, R=3);
		
		//ty-wraps
		translate([Batt_Y+3,Tube_ID/2-6-Batt_X/2,-Overlap]) cylinder(d=3.5, h=Batt_h+6+Overlap*2);
		translate([-Batt_Y-3,Tube_ID/2-6-Batt_X/2,-Overlap]) cylinder(d=3.5, h=Batt_h+6+Overlap*2);
		hull(){
			translate([0,Tube_ID/2-6,18]) rotate([0,90,0]) cylinder(d=3.5, h=Batt_Y*2+6+Overlap*2, center=true);
			translate([0,Tube_ID/2,18]) rotate([0,90,0]) cylinder(d=3.5, h=Batt_Y*2+Overlap*2, center=true);
		}
		hull(){
			translate([0,Tube_ID/2-6,4+Batt_h-12]) rotate([0,90,0]) cylinder(d=3.5, h=Batt_Y*2+6+Overlap*2, center=true);
			translate([0,Tube_ID/2,4+Batt_h-12]) rotate([0,90,0]) cylinder(d=3.5, h=Batt_Y*2+Overlap*2, center=true);
		}
		
	} // difference
	
} // DoubleBatteryHolder

//DoubleBatteryHolder(Tube_ID=PML75Body_ID);




























