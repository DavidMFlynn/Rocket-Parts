// *******************************************
// Project: 3D Printed Rocket
// Filename: Parachute.scad
// by David M. Flynn
// Created: 9/13/2022 
// Revision: 0.9.5  11/11/2022
// Units: mm
// *******************************************
//  ***** Notes *****
//
// Export as PDF, Print at 100%
// Cut Panels/2 shroud lines 3x the diameter and heat seal the ends. 
//  Mark the center of each line and 50mm from each end. 
//
// Panel to panel 2mm straight stitch #1. 
// Edge panel to panel with 5mm x 1.5mm zig-zag #2. 
// Hem the diameter and center hole with a 2mm straight stitch #1. 
// Attach the shroud lines with 2 passes of 5.5mm x 0.5mm "Multiple ZigZag" #3. 
//
// Pointyness controls how pointy the 'chute is. Range 0.40 to 0.49
// Panel_Y controls the center hole 1.5 = no hole the higher the number the bigger the hole.
// Arc_r is the radius of the 2 intersected arcs. 
//
// PrintingOffset_X, PrintingOffset_Y is used to center the pattern on the page for printing.
// 
// Laser cutter size: 420mm x 900mm
//
//  ***** History *****
//
// 0.9.5  11/11/2022 Making a 32" 'chute. 
// 0.9.4  10/22/2022 Making a 45" 'chute. 
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
// *** Drogue 'Chute ***
// Make 6 panels
/*
Pointyness=0.44; Panel_Y=2; SeamAllowance=0;
nPanels=6;
Arc_r=14*25.4; Apex_Y=220; Hole_X=28;  // 6 Panels 186mm x 310mm, 14"
Center_r=Apex_Y+45;
/**/
//PrintingOffset_X=100; PrintingOffset_Y=-130;// Page 1
// --------------------------------------------------------------
// *** First Article Test ***
// Make 8 panels
// This worked well made a nice 20 inch 8 panel parachute. (2.1 sqft)
// 1.4oz Rip-Stop Nylon, 2mm Polypropylene rope (knit, cheep from Amazon)
/*
Pointyness=0.4; Panel_Y=2; SeamAllowance=7;
nPanels=8;
Arc_r=500; Apex_Y=310; Hole_X=30;  // 8 Panels 200mm x 310mm, 20"
Center_r=Apex_Y+45;
/**/
//PrintingOffset_X=100; PrintingOffset_Y=-130;// Page 1
//PrintingOffset_X=100-200; PrintingOffset_Y=-130;// Page 2
//PrintingOffset_X=0; PrintingOffset_Y=-130-260;// Page 3
// --------------------------------------------------------------------------

// --------------------------------------------------------------------------
// Make 10 Panels
// 1.4oz Rip-Stop Nylon, 3mm Polypropylene rope (knit, cheep from Amazon)
// 5.6 sqft
/*
Pointyness=0.4; Panel_Y=2; SeamAllowance=7;
nPanels=10;
Arc_r=630; Apex_Y=460; Hole_X=32; //10 Panels 255mm x 460mm, 32" Dia., 4" Center Hole
Center_r=Apex_Y+52;
/**/
// Page 200x260
//PrintingOffset_X=100; PrintingOffset_Y=-130; // Pg 1
//PrintingOffset_X=100-200; PrintingOffset_Y=-130; // Pg 2
//PrintingOffset_X=100; PrintingOffset_Y=-130-260; // Pg 3
//PrintingOffset_X=100-200; PrintingOffset_Y=-130-260; // Pg 4
// --------------------------------------------------------------------------

// --------------------------------------------------------------------------
// *** Built one and it is good 11/2/2022 ***
// 
// Make 12 Panels
// 1.4oz Rip-Stop Nylon, 3mm Polypropylene rope (knit, cheep from Amazon)
// 11 sqft
/*
Pointyness=0.4; Panel_Y=2; SeamAllowance=7;
nPanels=12;
Arc_r=750; Apex_Y=610; Hole_X=33; //12 Panels 300mm x 610mm, 45" Dia., 5" Center Hole
Center_r=Apex_Y+63;
/**/
// Page 200x260
//PrintingOffset_X=100; PrintingOffset_Y=-130; // Pg 1
//PrintingOffset_X=100-200; PrintingOffset_Y=-130; // Pg 2
//PrintingOffset_X=100; PrintingOffset_Y=-130-260; // Pg 3
//PrintingOffset_X=100-200; PrintingOffset_Y=-130-260; // Pg 4
//PrintingOffset_X=0; PrintingOffset_Y=-130-260-260; // Pg 5
// ---------------------------------------------------------------------------

// --------------------------------------------------------------------------

// *** Built one and it works great 10/10/2022 ***
// Make 14 Panels
// 1.4oz Rip-Stop Nylon, 3mm Polypropylene rope (knit, cheep from Amazon)
// 21.6 sqft
/*
Pointyness=0.4; Panel_Y=2; SeamAllowance=7;
nPanels=14; 
Arc_r=900; Apex_Y=855; Hole_X=40; //14 Panels 360mm x 855mm, 63" Dia., 7" Center Hole
Center_r=Apex_Y+85;
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

// --------------------------------------------------------------------------

// Make 16 Panels
// 1.4oz Rip-Stop Nylon, 3mm Polypropylene rope (knit, cheep from Amazon)
// 
/*
Pointyness=0.39; Panel_Y=2; SeamAllowance=0;
nPanels=16; 
Arc_r=887; Apex_Y=975; Hole_X=45; //16 Panels 390mm x 950mm, 78" Dia., 9" Center Hole
Center_r=Apex_Y+114;
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

/*
//for (j=[0:nPanels-1]) rotate([0,0,360/nPanels*j]) translate([0,-Center_r,0]) // show full circle
//
translate([PrintingOffset_X,PrintingOffset_Y+SeamAllowance,0]) // offset for pdf
offset(delta=SeamAllowance) // comment out when showing full circle
P_Shape();
/**/
	
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
	
// ******************************************************************
// *** Parameter test ***

/*
// *** 88", 20 panels, 42 sqft ***
nPanels=20;
Diameter=88*25.4;
CenterHole_d=10.0*25.4;
echo(Diameter=Diameter);
// DrawTip();
// DrawBase();
/**/
module DrawTip(){
	difference(){
		P_ShapeTest(Diameter=Diameter, nPanels=nPanels, CenterHole_d=CenterHole_d, SeamAllowance=6);
		
		translate([-210,-10,0]) square([420,504]); // 500-seam
	} // difference
} // DrawTip

module DrawBase(){
	difference(){
		P_ShapeTest(Diameter=Diameter, nPanels=nPanels, CenterHole_d=CenterHole_d, SeamAllowance=6);
		
		translate([-210,506,0]) square([420,1000]); // 500+seam
	} // difference
} // DrawBase


/*
// *** 78", 16 panels, 33 sqft ***
nPanels=16;
Diameter=78*25.4;
CenterHole_d=9.0*25.4;
echo(Diameter=Diameter);
P_ShapeTest(Diameter=Diameter, nPanels=nPanels, CenterHole_d=CenterHole_d, SeamAllowance=6);
/**/

/*
// *** 63", 14 panels, 21.6 sqft ***
nPanels=14;
Diameter=63*25.4;
CenterHole_d=7.0*25.4;
echo(Diameter=Diameter);
P_ShapeTest(Diameter=Diameter, nPanels=nPanels, CenterHole_d=CenterHole_d, SeamAllowance=6);
/**/

/*
// *** 45", 12 panels, 11 sqft ***
nPanels=12;
Diameter=45*25.4;
CenterHole_d=5.0*25.4;
echo(Diameter=Diameter);
P_ShapeTest(Diameter=Diameter, nPanels=nPanels, CenterHole_d=CenterHole_d, SeamAllowance=6);
/**/

/*
// *** 32", 10 panels, 5.58 sqft  ***
nPanels=10;
Diameter=32*25.4;
CenterHole_d=4.0*25.4;
echo(Diameter=Diameter);
P_ShapeTest(Diameter=Diameter, nPanels=nPanels, CenterHole_d=CenterHole_d, SeamAllowance=6);
/**/

/*
// *** 20", 8 panels, 314 sqin, 2.18 sqft ***
nPanels=8;
Diameter=20*25.4;
CenterHole_d=3.0*25.4;
echo(Diameter=Diameter);
P_ShapeTest(Diameter=Diameter, nPanels=nPanels, CenterHole_d=CenterHole_d, SeamAllowance=6);
/**/

/*
// *** 14", 6 panels, 153 sqin ***
nPanels=6;
Diameter=14*25.4;
R=Diameter/2;
CenterHole_d=2.5*25.4;
echo(Diameter=Diameter);
/**/


//*

//P_ShapeTest(Diameter=14*25.4, nPanels=6, CenterHole_d=2.5*25.4, SeamAllowance=6);

//P_ShapeTest(Diameter=160*25.4, nPanels=20, CenterHole_d=12*25.4, SeamAllowance=6);

//for (j=[0:nPanels-1]) rotate([0,0,360/nPanels*j]) translate([0,-Center_Y,0]) // show full circle
//translate([PrintingOffset_X,PrintingOffset_Y+SeamAllowance,0]) // offset for pdf
 // comment out when showing full circle
	
module P_ShapeTest(Diameter=14*25.4, nPanels=6, CenterHole_d=2.5*25.4, SeamAllowance=6){
	R=Diameter/2;
	Panel_w=Diameter*PI/nPanels;
	Apex_w=CenterHole_d*PI/nPanels;
	Skirt_Y=(R-R*0.707)*2*PI/4;
	Center_Y=Skirt_Y+R*0.707;
	Apex_Y=Center_Y-CenterHole_d/2;
	
	echo(Apex_Y=Apex_Y);
	echo(R=R);
	
	offset(delta=SeamAllowance)
	difference(){
		hull(){
			intersection(){
				translate([Panel_w/2-R, 0, 0]) circle(r=R);
				translate([-Panel_w/2+R, 0, 0]) circle(r=R);
				translate([-Panel_w/2,0,0]) square([Panel_w, Apex_Y]);
			}
			
			translate([0,Center_Y,0]) circle(d=1);
		} // hull
		
		translate([0,Center_Y,0]) color("Orange") circle(d=CenterHole_d);
	} // difference
} // P_ShapeTest

//P_ShapeTest();
/*
offset(delta=6) difference(){
	P_ShapeTest(Diameter=110*25.4, nPanels=24, CenterHole_d=12*25.4, SeamAllowance=0);
	translate([-200,0,0]) square([400,800]);
}


/**/


























