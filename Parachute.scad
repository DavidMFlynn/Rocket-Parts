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

//Pointyness=0.4; // Works for 8 Panels
//Panel_Y=2;

Pointyness=0.45; // Works for 10 Panels 
Panel_Y=2.7;

//Pointyness=0.47; // Works for 14 Panels 
//Panel_Y=3.5;

// Make 8 Panels
//Arc_r=800; //160mm x 200mm, 16"
//Arc_r=500; PrintingOffset_X=0; PrintingOffset_Y=-125; // 200mm x 250mm, 20"
//Arc_r=600; // 240mm x 300mm, 24"
//Arc_r=800; // 320mm x 400mm, 32"

// Make 14 Panels
//
//Arc_r=1000; // 14 Panels, 120mm, 21"
//
Arc_r=1000; // 10 Panels, 200mm, 25"

//
//



//
//
//Arc_r=2000; //14 Panels 240mm, 42"
//Arc_r=2500; //14 Panels 300mm x 715mm, 52"
//Arc_r=3000; //14 Panels 360mm x 855mm, 63"
//PrintingOffset_X=0; PrintingOffset_Y=0;
// Page 200x260
//PrintingOffset_X=100; PrintingOffset_Y=-130; // Pg 1
//PrintingOffset_X=100-200; PrintingOffset_Y=-130; // Pg 2
//PrintingOffset_X=100; PrintingOffset_Y=-130-260; // Pg 3
//PrintingOffset_X=100-200; PrintingOffset_Y=-130-260; // Pg 4
//PrintingOffset_X=100; PrintingOffset_Y=-130-260-260; // Pg 5
//PrintingOffset_X=100-200; PrintingOffset_Y=-130-260-260; // Pg 6

// Test
//Arc_r=1000; //
//PrintingOffset_X=0; PrintingOffset_Y=-140; // Page 1
//PrintingOffset_X=0; PrintingOffset_Y=-130-260; // Page 2

//translate([PrintingOffset_X,PrintingOffset_Y,0]) 
//
P_Shape();

// Make 16 Panels
//Arc_r=1000; // 200mm, 40"
//Arc_r=1200; // 240mm, 48"
//Arc_r=1400; // 280mm, 56"
//Arc_r=1600; // 320mm, 64"
//Arc_r=1800; // 360mm, 72"
//Arc_r=2000; // 400mm x 740mm, 80"

//2660mm x 1500mm 
for (j=[0:4]) translate([220*j,0,0]) P_Shape();
for (j=[0:4]) translate([220*j+110,670,0]) rotate([0,0,180]) P_Shape();
	
//translate([PrintingOffset_X,PrintingOffset_Y,0])
module P_Shape(){
intersection(){
	translate([-Arc_r*2*Pointyness,0,0]) circle(r=Arc_r);
	translate([Arc_r*2*Pointyness,0,0]) circle(r=Arc_r);
	translate([-Arc_r,0,0]) square([Arc_r*2,Arc_r/Panel_Y]);
}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}