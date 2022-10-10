// ***********************************
// Project: 3D Printed Rocket
// Filename: ChargeHolder.scad
// by David M. Flynn
// Created: 6/23/2022 
// Revision: 0.9.0  6/23/2022
// Units: mm
// ***********************************
//  ***** Notes *****
//
// ChargeHolder for black powder ejection charge.
//
//  ***** History *****
//
echo("ChargeHolder 0.9.0");
// 0.9.0  6/23/2022 First code.
//
// ***********************************
//  ***** for STL output *****
//
// ChargeHolder(CH_BoltSp=0, Dia=14, CC=3); // BoltSp=0 = calculated
// ChargeHolder(CH_BoltSp=28, Dia=14, CC=3);
// ChargeHolder(CH_BoltSp=28, Dia=12, CC=2);
//
// ***********************************
//  ***** Routines *****
//
// CH_Bolts() Bolt6HeadHole(depth=16, lAccess=12);
// CH_Bolts(CH_BoltSpacing=28) Bolt6Hole(depth=10);
//
// ***********************************
//  ***** for Viewing *****
//
// 
// ***********************************

include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.3; // looser normally 0.2
$fn=$preview? 24:90;

CH_BoltSpacing=25;
CH_Wall=3.4;
WirePath_w=3;
WirePath_t=1.4;
Bolt6Inset=5.5;

module CH_Bolts(CH_BoltSpacing=CH_BoltSpacing){
	translate([-CH_BoltSpacing/2,0,0]) children();
	translate([CH_BoltSpacing/2,0,0]) children();
} // CH_Bolts

//CH_Bolts() Bolt6HeadHole(depth=16, lAccess=12);

module ChargeHolder(CH_BoltSp=0, Dia=14, CC=3){
	CH_Depth=CC*1000/(Dia*Dia*0.785398); // CC x 1000 = mm^3 / area in mm^2
	echo(CH_Depth=CH_Depth);
	CH_BC=CH_BoltSp==0? Dia+CH_Wall*2+Bolt6Inset*2:CH_BoltSp;
	echo(CH_BC=CH_BC);
	BaseDia=Dia+CH_Wall*2;
	
	module Dome(){
		hull(){
			cylinder(d=12, h=Overlap);
			translate([0,0,6]) scale([1,1,0.7]) sphere(d=12);
		}
	} // Dome
	
	difference(){
		union(){
			cylinder(d=BaseDia,h=CH_Wall*2+CH_Depth);
			hull(){
				translate([CH_BC/2,0,0]) Dome();
				cylinder(d=BaseDia, h=11);
				translate([-CH_BC/2,0,0]) Dome();
			} // hull
		} // union
		
		// Bolts
		translate([0,0,8]) CH_Bolts(CH_BoltSpacing=CH_BC) Bolt6HeadHole();
		
		// Charge well
		translate([0,0,CH_Wall]) cylinder(d1=WirePath_w,d2=Dia,h=CH_Wall);
		translate([0,0,CH_Wall*2-Overlap]) cylinder(d=Dia,h=CH_Wall*2+CH_Depth);
		
		// Wire path
		hull(){
			translate([-WirePath_w/2+WirePath_t/2,0,-Overlap]) 
				cylinder(d=WirePath_t+IDXtra,h=CH_Wall*2);
			translate([WirePath_w/2-WirePath_t/2,0,-Overlap]) 
				cylinder(d=WirePath_t+IDXtra,h=CH_Wall*2);
		} // hull
		hull(){
			translate([0,BaseDia/2,0]) cube([WirePath_w+IDXtra*2,BaseDia,Overlap], center=true);
			translate([-WirePath_w/2+WirePath_t/2,0,WirePath_t/2])
				rotate([-90,0,0]) cylinder(d=WirePath_t+IDXtra,h=BaseDia/2+Overlap*2);
			translate([WirePath_w/2-WirePath_t/2,0,WirePath_t/2])
				rotate([-90,0,0]) cylinder(d=WirePath_t+IDXtra,h=BaseDia/2+Overlap*2);

		} // hull
		
	} // difference
	
} // ChargeHolder

// ChargeHolder();





















