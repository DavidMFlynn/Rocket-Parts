// *******************************************
// Project: 3D Printed Rocket
// Filename: Parachute.scad
// Created: 9/13/2022 
// Revision: 0.9.0  9/13/2022
// Units: mm
// *******************************************
//  ***** Notes *****
//
// Export as PDF, Print at 100%
//
// Pointyness controls how pointy the 'chute is. Range 0.40 to 0.49
// Panel_Y controls the center hole 1.5 = no hole the higher the number the bigger the hole.
// Arc_r is the radius of the 2 intersected arcs. 
//
// PrintingOffset_X, PrintingOffset_Y is used to center the pattern on the page for printing.
// 
//  ***** History *****
//
// 0.9.0  9/13/2022 First code, working out the geometry
//
// *******************************************
//  ***** Routines *****
//
// *******************************************

$fn=90;

Pointyness=0.4; // Works for 8 Panels
Panel_Y=2;

//Pointyness=0.44; // Proto for 12 Panels? 
//Panel_Y=2.5;

//Pointyness=0.45; // Proto for 16 Panels? 
//Panel_Y=2.7;

// Make 8 Panels
//Arc_r=800; //160mm x 200mm, 16"
//
Arc_r=500; PrintingOffset_X=0, PrintingOffset_Y=-125; // 200mm x 250mm, 20"
//Arc_r=600; // 240mm x 300mm, 24"
//Arc_r=800; // 320mm x 400mm, 32"

// Make 12 Panels
//Arc_r=1000; // 240mm, 36"
//Arc_r=1250; // 300mm, 45"
//Arc_r=1418; // 340mm, 51"
//Arc_r=1666; // 400mm, 60"

// Make 16 Panels
//Arc_r=1000; // 200mm, 40"
//Arc_r=1200; // 240mm, 48"
//Arc_r=1400; // 280mm, 56"
//Arc_r=1600; // 320mm, 64"
//Arc_r=1800; // 360mm, 72"
//Arc_r=2000; // 400mm x 740mm, 80"

translate([PrintingOffset_X,PrintingOffset_Y,0])
intersection(){
	translate([-Arc_r*2*Pointyness,0,0]) circle(r=Arc_r);
	translate([Arc_r*2*Pointyness,0,0]) circle(r=Arc_r);
	translate([-Arc_r,0,0]) square([Arc_r*2,Arc_r/Panel_Y]);
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}