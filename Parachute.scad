// *******************************************
// Project: 3D Printed Rocket
// Filename: Parachute.scad
// by David M. Flynn
// Created: 9/13/2022 
// Revision: 0.9.3  10/6/2022
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
// 0.9.3  10/6/2022 Made a 63" 'chute it is good.
// 0.9.2  9/28/2022 20" 'chute worked well, 63" is next. 
// 0.9.1  9/24/2022 Didn't work, starting over. 
// 0.9.0  9/13/2022 First code, working out the geometry
//
// *******************************************
//  ***** Routines *****
//
// *******************************************

$fn=360;

//Pointyness=0.4; // Works for 8 Panels
//Panel_Y=2;
PrintingOffset_Y=0;
PrintingOffset_X=0;

//Pointyness=0.45; // Works for 10 Panels 
//Panel_Y=2.7;

//Pointyness=0.47; // Works for 14 Panels 
//Panel_Y=3.5;

// Make 8 Panels
//Arc_r=800; //160mm x 200mm, 16"
//
// --------------------------------------------------------------
// *** First Article Test ***
// Make 8 panels
// This worked well made a nice 20 inch 8 panel parachute. 
// 1.4oz Rip-Stop Nylon, 2mm Polypropylene rope (knit, cheep from Amazon)
/*
Pointyness=0.4; Panel_Y=2; SeamAllowance=7;
Arc_r=500; Apex_Y=310; Hole_X=30;  // 8 Panels 200mm x 310mm, 20"
/**/
//PrintingOffset_X=100; PrintingOffset_Y=-130;// Page 1
//PrintingOffset_X=100-200; PrintingOffset_Y=-130;// Page 2
//PrintingOffset_X=0; PrintingOffset_Y=-130-260;// Page 3
// --------------------------------------------------------------------------

// *** Built one and it works great 10/10/2022 ***
// Make 14 Panels
// 1.4oz Rip-Stop Nylon, 3mm Polypropylene rope (knit, cheep from Amazon)
//*
Pointyness=0.4; Panel_Y=2; SeamAllowance=7;
Arc_r=900; Apex_Y=855; Hole_X=40; //14 Panels 360mm x 855mm, 63" Dia., 7" Center Hole
/**/
// Page 200x260
//PrintingOffset_X=100; PrintingOffset_Y=-130; // Pg 1
//PrintingOffset_X=100-200; PrintingOffset_Y=-130; // Pg 2
//PrintingOffset_X=100; PrintingOffset_Y=-130-260; // Pg 3
//PrintingOffset_X=100-200; PrintingOffset_Y=-130-260; // Pg 4
//PrintingOffset_X=100; PrintingOffset_Y=-130-260-260; // Pg 5
//PrintingOffset_X=100-200; PrintingOffset_Y=-130-260-260; // Pg 6
//PrintingOffset_X=0; PrintingOffset_Y=-130-260-260-260; // Pg 7
// ---------------------------------------------------------------------------
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


//for (j=[0:13]) rotate([0,0,360/14*j]) translate([0,-940,0])
translate([PrintingOffset_X,PrintingOffset_Y+SeamAllowance,0]) offset(delta=SeamAllowance)
P_Shape();



//2660mm x 1500mm 
//for (j=[0:4]) translate([220*j,0,0]) P_Shape();
//for (j=[0:4]) translate([220*j+110,670,0]) rotate([0,0,180]) P_Shape();
	
//translate([PrintingOffset_X,PrintingOffset_Y,0])
module P_Shape(){
	
	hull(){
		intersection(){
			translate([-Arc_r*2*Pointyness, 0, 0]) circle(r=Arc_r);
			translate([Arc_r*2*Pointyness, 0, 0]) circle(r=Arc_r);
			translate([-Arc_r/4,0,0]) square([Arc_r/2, Arc_r/Panel_Y]);
		}
		
		translate([-Hole_X/2,Apex_Y,0]) square([Hole_X,1]);
	} // hull
	
} // P_Shape
	
	
