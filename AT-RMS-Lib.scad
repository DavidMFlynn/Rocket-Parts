// *******************************************
// Project: 3D Printed Rocket
// Filename: AT-RMS-Lib.scad
// by David M. Flynn
// Created: 9/13/2023 
// Revision: 0.9.0  9/13/2023 
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  ***** History *****
//
// 0.9.0  9/13/2023   First code, 54mm only
//
// ***********************************
//  ***** for STL output *****
//
// ***********************************
//  ***** Routines *****
//
function ATRMS_54_Aft_d()=kATRMS_Aft54_d;
//
// Eye_Bolt1();
//
// ATRMS_ForClosure54(Extended=false); // Standard plugged threaded forward closure
// ATRMS_AftClosure54();
// ATRMS_54_427_Case();
// ATRMS_54_852_Case();
// ATRMS_54_1280_Case();
// ATRMS_54_1706_Case();
// ATRMS_54_2560_Case();
//
// ***********************************
//  ***** for Viewing *****
//
// 
ShowAll54();
//
// ATRMS_54_427_Motor(HasEyeBolt=true); // I115W, I229T
// ATRMS_54_852_Motor(Extended=false, HasEyeBolt=true); // J275W, J460T, J615ST
// ATRMS_54_852_Motor(Extended=true, HasEyeBolt=true); // J90W, J180T
// ATRMS_54_1280_Motor(Extended=false, HasEyeBolt=true); // J415W, J800T
// ATRMS_54_1280_Motor(Extended=true, HasEyeBolt=true); // J135W
// ATRMS_54_1706_Motor(Extended=false, HasEyeBolt=true); // K550W
// ATRMS_54_1706_Motor(Extended=true, HasEyeBolt=true); // K185W
// ATRMS_54_2560_Motor(Extended=false, HasEyeBolt=true);
//
// ***********************************
//
$fn=90;

kATRMS_54_Case_d=54;
kATRMS_54_427_Case_h=127;
kATRMS_54_852_Case_h=211.5;
kATRMS_54_1280_Case_h=296;
kATRMS_54_1706_Case_h=380.5;
kATRMS_54_2560_Case_h=549;

kATRMS_Aft54_d=57.6;
kATRMS_Aft54_h=10;

kATRMS_For54_d1=54;
kATRMS_For54_h1=3;
kATRMS_For54_d2=35;
kATRMS_For54_h2=20; 
kATRMS_ExtFor54_h2=12.7; // extra length for extended forward closure
kATRMS_For54_d3=38.5;
kATRMS_For54_h3=9;
kATRMS_For54_d4=25.5;
kATRMS_For54_h4=29.5;
kATRMS_For54_d5=23;
kATRMS_For54_h5=31;
kATRMS_For54_oal=kATRMS_For54_h5;

module ShowAll54(){
	ATRMS_54_427_Motor(HasEyeBolt=true); // I115W, I229T
	translate([60,0,0]) ATRMS_54_852_Motor(Extended=false, HasEyeBolt=true); // J275W, J460T, J615ST
	translate([60*2,0,0]) ATRMS_54_852_Motor(Extended=true, HasEyeBolt=true); // J90W, J180T
	translate([60*3,0,0]) ATRMS_54_1280_Motor(Extended=false, HasEyeBolt=true); // J415W, J800T
	translate([60*4,0,0]) ATRMS_54_1280_Motor(Extended=true, HasEyeBolt=true); // J135W
	translate([60*5,0,0]) ATRMS_54_1706_Motor(Extended=false, HasEyeBolt=true); // K550W
	translate([60*6,0,0]) ATRMS_54_1706_Motor(Extended=true, HasEyeBolt=true); // K185W
	translate([60*7,0,0]) ATRMS_54_2560_Motor(Extended=false, HasEyeBolt=true);

} // ShowAll54

//ShowAll54();

module Eye_Bolt1(){
	cylinder(d=19, h=3); // hard washer
	
	translate([0,0,3]){
		cylinder(d=14, h=6.5);
		translate([0,0,17]) rotate([90,0,0]) rotate_extrude() translate([12.5,0,0]) circle(d=5.3);
		}
} // Eye_Bolt1

// Eye_Bolt1();

module ATRMS_54_427_Motor(HasEyeBolt=true){
	// I115W, I229T
	color("Gray") translate([0,0,kATRMS_54_427_Case_h+kATRMS_For54_oal]) Eye_Bolt1();
	color("Silver") translate([0,0,kATRMS_54_427_Case_h]) ATRMS_ForClosure54(Extended=false);
	color("LightBlue") ATRMS_54_427_Case();
	color("Silver") ATRMS_AftClosure54();
} // ATRMS_54_427_Motor

// ATRMS_54_427_Motor(HasEyeBolt=true);

module ATRMS_54_852_Motor(Extended=false, HasEyeBolt=true){
	// J275W, J90W, J180T, J460T
	Extra=Extended? kATRMS_ExtFor54_h2:0;
	
	color("Gray") translate([0,0,kATRMS_54_852_Case_h+kATRMS_For54_oal+Extra]) Eye_Bolt1();
	color("Silver") translate([0,0,kATRMS_54_852_Case_h]) ATRMS_ForClosure54(Extended=Extended);
	color("LightBlue") ATRMS_54_852_Case();
	color("Silver") ATRMS_AftClosure54();
} // ATRMS_54_852_Motor

// ATRMS_54_852_Motor(Extended=false, HasEyeBolt=true);
// ATRMS_54_852_Motor(Extended=true, HasEyeBolt=true);

module ATRMS_54_1280_Motor(Extended=false, HasEyeBolt=true){
	// J415W, J135W, J800T
	Extra=Extended? kATRMS_ExtFor54_h2:0;
	
	color("Gray") translate([0,0,kATRMS_54_1280_Case_h+kATRMS_For54_oal+Extra]) Eye_Bolt1();
	color("Silver") translate([0,0,kATRMS_54_1280_Case_h]) ATRMS_ForClosure54(Extended=Extended);
	color("LightBlue") ATRMS_54_1280_Case();
	color("Silver") ATRMS_AftClosure54();
} // ATRMS_54_1280_Motor

module ATRMS_54_1706_Motor(Extended=false, HasEyeBolt=true){

	Extra=Extended? kATRMS_ExtFor54_h2:0;
	
	color("Gray") translate([0,0,kATRMS_54_1706_Case_h+kATRMS_For54_oal+Extra]) Eye_Bolt1();
	color("Silver") translate([0,0,kATRMS_54_1706_Case_h]) ATRMS_ForClosure54(Extended=Extended);
	color("LightBlue") ATRMS_54_1706_Case();
	color("Silver") ATRMS_AftClosure54();
} // ATRMS_54_1706_Motor

module ATRMS_54_2560_Motor(Extended=false, HasEyeBolt=true){

	Extra=Extended? kATRMS_ExtFor54_h2:0;
	
	color("Gray") translate([0,0,kATRMS_54_2560_Case_h+kATRMS_For54_oal+Extra]) Eye_Bolt1();
	color("Silver") translate([0,0,kATRMS_54_2560_Case_h]) ATRMS_ForClosure54(Extended=Extended);
	color("LightBlue") ATRMS_54_2560_Case();
	color("Silver") ATRMS_AftClosure54();
} // ATRMS_54_2560_Motor

module ATRMS_ForClosure54(Extended=false){
	// Standard plugged threaded forward closure
	Etra=Extended? kATRMS_ExtFor54_h2:0;
	
	cylinder(d=kATRMS_For54_d1, h=kATRMS_For54_h1);
	cylinder(d=kATRMS_For54_d2, h=kATRMS_For54_h2+Etra);
	
	translate([0,0,kATRMS_For54_h2+Etra-kATRMS_For54_h3/2-1.5]) hull(){
		cylinder(d=kATRMS_For54_d3, h=kATRMS_For54_h3, center=true);
		cylinder(d=kATRMS_For54_d2, h=kATRMS_For54_h3+3, center=true);
	}
	hull(){
		cylinder(d=kATRMS_For54_d4, h=kATRMS_For54_h4+Etra);
		cylinder(d=kATRMS_For54_d5, h=kATRMS_For54_h5+Etra);
	}
} // ATRMS_ForClosure54

// ATRMS_ForClosure54();

module ATRMS_54_427_Case(){
	cylinder(d=kATRMS_54_Case_d, h=kATRMS_54_427_Case_h);
} // ATRMS_54_427_Case

module ATRMS_54_852_Case(){
	cylinder(d=kATRMS_54_Case_d, h=kATRMS_54_852_Case_h);
} // ATRMS_54_852_Case

module ATRMS_54_1280_Case(){
	cylinder(d=kATRMS_54_Case_d, h=kATRMS_54_1280_Case_h);
} // ATRMS_54_1280_Case

module ATRMS_54_1706_Case(){
	cylinder(d=kATRMS_54_Case_d, h=kATRMS_54_1706_Case_h);
} // ATRMS_54_1706_Case

module ATRMS_54_2560_Case(){
	cylinder(d=kATRMS_54_Case_d, h=kATRMS_54_2560_Case_h);
} // ATRMS_54_2560_Case

module ATRMS_AftClosure54(){
	
	translate([0,0,-kATRMS_Aft54_h/2]) hull(){
		cylinder(d=kATRMS_Aft54_d-2, h=kATRMS_Aft54_h, center=true);
		cylinder(d=kATRMS_Aft54_d, h=kATRMS_Aft54_h-2, center=true);
	}
	
} // ATRMS_AftClosure54

// ATRMS_AftClosure54();




















