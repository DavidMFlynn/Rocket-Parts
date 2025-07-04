// *******************************************
// Project: 3D Printed Rocket
// Filename: AT-RMS-Lib.scad
// by David M. Flynn
// Created: 9/13/2023 
// Revision: 0.9.2  9/5/2024 
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  ***** History *****
//
// 0.9.2  9/5/2024    Added 38mm motors 38/120..38/720
// 0.9.1  5/13/2024   Added ATRMS_75_2560_Motor
// 0.9.0  9/13/2023   First code, 54mm only
//
// ***********************************
//  ***** for STL output *****
//
// BT54MotorRetainer();
// UL75MotorRetainer();
//
// ***********************************
//  ***** Routines *****
//
function ATRMS_38_Aft_d()=kATRMS_Aft38_d;
//
// ATRMS_38_120_Motor(HasEyeBolt=false);
// ATRMS_38_240_Motor(HasEyeBolt=false);
// ATRMS_38_360_Motor(HasEyeBolt=false);
// ATRMS_38_480_Motor(HasEyeBolt=false);
// ATRMS_38_600_Motor(HasEyeBolt=false);
// ATRMS_38_720_Motor(HasEyeBolt=false);
//
// ATRMS_ForClosure38();
// ATRMS_AftClosure38();
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
//
// ***********************************
//  ***** for Viewing *****
//
// ShowAll54();
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
// ATRMS_75_2560_Motor(Extended=false, HasEyeBolt=true);
//
// ***********************************
//
include<TubesLib.scad>

$fn=90;
Overlap=0.05;

kATRMS_38_Case_d=38;
kATRMS_38_120_Case_h=79;
kATRMS_38_240_Case_h=127;
kATRMS_38_360_Case_h=174;
kATRMS_38_480_Case_h=222;
kATRMS_38_600_Case_h=270;
kATRMS_38_720_Case_h=318;

kATRMS_For38_d1=38;
kATRMS_For38_h1=3.25;
kATRMS_For38_d2=23.7;
kATRMS_For38_h2=18.5;
kATRMS_For38_d3=25.8;
kATRMS_For38_h3=10;
kATRMS_For38_d4=15.8;
kATRMS_For38_h4=27;
kATRMS_For38_d5=15;
kATRMS_For38_h5=27.8;
kATRMS_For38_oal=27.8;

kATRMS_Aft38_d=41.4;
kATRMS_Aft38_h=10;


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

kATRMS_ExtFor75_h2=20;
kATRMS_For75_d1=75.4;
kATRMS_For75_h1=4.7;
kATRMS_For75_d2=48;
kATRMS_For75_h2=31;
kATRMS_For75_d3=57.3;
kATRMS_For75_h3=16;
kATRMS_For75_d4=25.4;
kATRMS_For75_h4=52;

kATRMS_Aft75_d=79.4;
kATRMS_Aft75_h=12.85;


kATRMS_75_Case_d=75.4;
// + 135mm per grain
kATRMS_75_1280_Case_h=197.5; // J
kATRMS_75_2560_Case_h=332.5; // J+J=K
kATRMS_75_3840_Case_h=467.5; // K+J=L
kATRMS_75_5120_Case_h=602.5; // K+2J=L
kATRMS_75_6400_Case_h=737.5; // L+J=M

kATRMS_For75_oal=kATRMS_For75_h4;

module UL75MotorRetainer(){
	MotorTubeHole_d=ULine75Body_OD+IDXtra*3;
	AftClosure_OD=kATRMS_Aft75_d;
	AftClosure_Len=kATRMS_Aft75_h;
	Motor_OD=kATRMS_75_Case_d;
	MotorRetainer_OD=90;
	MotorStop_Len=4;
	MotorStop_Z=AftClosure_Len+6;
	SnapRing_w=3.6;
	OAL=AftClosure_Len+MotorStop_Len+15+4+SnapRing_w;
	
	
	difference(){
		cylinder(d=MotorRetainer_OD, h=OAL, $fn=$preview? 90:360);
		
	
		translate([0,0,MotorStop_Z+MotorStop_Len]) cylinder(d=MotorTubeHole_d, h=OAL, $fn=$preview? 90:360);
		translate([0,0,MotorStop_Z-Overlap]) cylinder(d=Motor_OD+IDXtra*3, h=OAL, $fn=$preview? 90:360);
		translate([0,0,-Overlap]) cylinder(d=AftClosure_OD+IDXtra*4, h=MotorStop_Z+Overlap, $fn=$preview? 90:360);
		
		// Snap ring
		translate([0,0,MotorStop_Z-AftClosure_Len]) cylinder(d1=AftClosure_OD+3, d2=AftClosure_OD+IDXtra*3, h=3, $fn=$preview? 90:360);
		translate([0,0,MotorStop_Z-AftClosure_Len-SnapRing_w]) cylinder(d=AftClosure_OD+3, h=SnapRing_w+Overlap, $fn=$preview? 90:360);
	} // difference
	
} // UL75MotorRetainer

// UL75MotorRetainer();

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

module ATRMS_38_120_Motor(HasEyeBolt=false){
	color("LightBlue") ATRMS_38_120_Case();
	color("Silver") ATRMS_AftClosure38();
	if (HasEyeBolt)
		color("Gray") translate([0,0,kATRMS_38_120_Case_h+kATRMS_For38_oal]) Eye_Bolt1();
	translate([0,0,kATRMS_38_120_Case_h]) color("Silver") ATRMS_ForClosure38();
} // ATRMS_38_120_Motor

//ATRMS_38_120_Motor(true);

module ATRMS_38_240_Motor(HasEyeBolt=false){
	color("LightBlue") ATRMS_38_240_Case();
	color("Silver") ATRMS_AftClosure38();
	if (HasEyeBolt)
		color("Gray") translate([0,0,kATRMS_38_240_Case_h+kATRMS_For38_oal]) Eye_Bolt1();
	translate([0,0,kATRMS_38_240_Case_h]) color("Silver") ATRMS_ForClosure38();
} // ATRMS_38_240_Motor

//ATRMS_38_240_Motor(true);

module ATRMS_38_360_Motor(HasEyeBolt=false){
	color("LightBlue") ATRMS_38_360_Case();
	color("Silver") ATRMS_AftClosure38();
	if (HasEyeBolt)
		color("Gray") translate([0,0,kATRMS_38_360_Case_h+kATRMS_For38_oal]) Eye_Bolt1();
	translate([0,0,kATRMS_38_360_Case_h]) color("Silver") ATRMS_ForClosure38();
} // ATRMS_38_360_Motor

//ATRMS_38_360_Motor(true);

module ATRMS_38_480_Motor(HasEyeBolt=false){
	color("LightBlue") ATRMS_38_480_Case();
	color("Silver") ATRMS_AftClosure38();
	if (HasEyeBolt)
		color("Gray") translate([0,0,kATRMS_38_480_Case_h+kATRMS_For38_oal]) Eye_Bolt1();
	translate([0,0,kATRMS_38_480_Case_h]) color("Silver") ATRMS_ForClosure38();
} // ATRMS_38_480_Motor

//ATRMS_38_480_Motor(true);

module ATRMS_38_600_Motor(HasEyeBolt=false){
	color("LightBlue") ATRMS_38_600_Case();
	color("Silver") ATRMS_AftClosure38();
	if (HasEyeBolt)
		color("Gray") translate([0,0,kATRMS_38_600_Case_h+kATRMS_For38_oal]) Eye_Bolt1();
	translate([0,0,kATRMS_38_600_Case_h]) color("Silver") ATRMS_ForClosure38();
} // ATRMS_38_600_Motor

//ATRMS_38_600_Motor(true);

module ATRMS_38_720_Motor(HasEyeBolt=false){
	color("LightBlue") ATRMS_38_720_Case();
	color("Silver") ATRMS_AftClosure38();
	if (HasEyeBolt)
		color("Gray") translate([0,0,kATRMS_38_720_Case_h+kATRMS_For38_oal]) Eye_Bolt1();
	translate([0,0,kATRMS_38_720_Case_h]) color("Silver") ATRMS_ForClosure38();
} // ATRMS_38_720_Motor

//ATRMS_38_720_Motor(true);

module ATRMS_38_240_Motor(HasEyeBolt=false){
	color("LightBlue") ATRMS_38_240_Case();
	color("Silver") ATRMS_AftClosure38();
	if (HasEyeBolt)
		color("Gray") translate([0,0,kATRMS_38_240_Case_h+kATRMS_For38_oal]) Eye_Bolt1();
	translate([0,0,kATRMS_38_240_Case_h]) color("Silver") ATRMS_ForClosure38();
} // ATRMS_38_240_Motor

//ATRMS_38_240_Motor(true);

module ATRMS_ForClosure38(){
	// Standard plugged threaded forward closure
	cylinder(d=kATRMS_For38_d1, h=kATRMS_For38_h1);
	cylinder(d=kATRMS_For38_d2, h=kATRMS_For38_h2);
	translate([0,0,kATRMS_For38_h2-kATRMS_For38_h3/2-1.5]) hull(){
		cylinder(d=kATRMS_For38_d3, h=kATRMS_For38_h3, center=true);
		cylinder(d=kATRMS_For38_d2, h=kATRMS_For38_h3+3, center=true);
	}
	hull(){
		cylinder(d=kATRMS_For38_d4, h=kATRMS_For38_h4);
		cylinder(d=kATRMS_For38_d5, h=kATRMS_For38_h5);
	}
} // ATRMS_ForClosure54

// ATRMS_ForClosure54();

module ATRMS_38_120_Case(){
	cylinder(d=kATRMS_38_Case_d, h=kATRMS_38_120_Case_h);
} // ATRMS_38_120_Case
module ATRMS_38_240_Case(){
	cylinder(d=kATRMS_38_Case_d, h=kATRMS_38_240_Case_h);
} // ATRMS_38_240_Case
module ATRMS_38_360_Case(){
	cylinder(d=kATRMS_38_Case_d, h=kATRMS_38_360_Case_h);
} // ATRMS_38_360_Case
module ATRMS_38_480_Case(){
	cylinder(d=kATRMS_38_Case_d, h=kATRMS_38_480_Case_h);
} // ATRMS_38_480_Case
module ATRMS_38_600_Case(){
	cylinder(d=kATRMS_38_Case_d, h=kATRMS_38_600_Case_h);
} // ATRMS_38_600_Case
module ATRMS_38_720_Case(){
	cylinder(d=kATRMS_38_Case_d, h=kATRMS_38_720_Case_h);
} // ATRMS_38_720_Case
module ATRMS_AftClosure38(){
	translate([0,0,-kATRMS_Aft38_h/2]) hull(){
		cylinder(d=kATRMS_Aft38_d-2, h=kATRMS_Aft38_h, center=true);
		cylinder(d=kATRMS_Aft38_d, h=kATRMS_Aft38_h-2, center=true);
	}
} // ATRMS_AftClosure38

module Eye_Bolt1(){
	cylinder(d=19, h=3); // hard washer
	
	translate([0,0,3]){
		cylinder(d=14, h=6.5);
		translate([0,0,17]) rotate([90,0,0]) rotate_extrude() translate([12.5,0,0]) circle(d=5.3);
		}
} // Eye_Bolt1

// Eye_Bolt1();

module Eye_Bolt2(){
	cylinder(d=21, h=3); // hard washer
	
	translate([0,0,3]){
		cylinder(d=16.5, h=9.5);
		translate([0,0,29]) rotate([90,0,0]) rotate_extrude() translate([20,0,0]) circle(d=10);
		}
} // Eye_Bolt2

// Eye_Bolt2();

module ATRMS_54_427_Motor(HasEyeBolt=true){
	// I115W, I229T
	if (HasEyeBolt)
		color("Gray") translate([0,0,kATRMS_54_427_Case_h+kATRMS_For54_oal]) Eye_Bolt1();
	color("Silver") translate([0,0,kATRMS_54_427_Case_h]) ATRMS_ForClosure54(Extended=false);
	color("LightBlue") ATRMS_54_427_Case();
	color("Silver") ATRMS_AftClosure54();
} // ATRMS_54_427_Motor

// ATRMS_54_427_Motor(HasEyeBolt=true);


module ATRMS_54_852_Motor(Extended=false, HasEyeBolt=true){
	// J275W, J90W, J180T, J460T
	Extra=Extended? kATRMS_ExtFor54_h2:0;
	
	if (HasEyeBolt)
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
	
	if (HasEyeBolt)
		color("Gray") translate([0,0,kATRMS_54_1280_Case_h+kATRMS_For54_oal+Extra]) Eye_Bolt1();
	color("Silver") translate([0,0,kATRMS_54_1280_Case_h]) ATRMS_ForClosure54(Extended=Extended);
	color("LightBlue") ATRMS_54_1280_Case();
	color("Silver") ATRMS_AftClosure54();
} // ATRMS_54_1280_Motor

module ATRMS_54_1706_Motor(Extended=false, HasEyeBolt=true){

	Extra=Extended? kATRMS_ExtFor54_h2:0;
	
	if (HasEyeBolt)
		color("Gray") translate([0,0,kATRMS_54_1706_Case_h+kATRMS_For54_oal+Extra]) Eye_Bolt1();
	color("Silver") translate([0,0,kATRMS_54_1706_Case_h]) ATRMS_ForClosure54(Extended=Extended);
	color("LightBlue") ATRMS_54_1706_Case();
	color("Silver") ATRMS_AftClosure54();
} // ATRMS_54_1706_Motor

module ATRMS_54_2560_Motor(Extended=false, HasEyeBolt=true){

	Extra=Extended? kATRMS_ExtFor54_h2:0;
	
	if (HasEyeBolt)
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


module BT54MotorRetainer(){
	MotorTubeHole_d=BT54Body_OD+IDXtra*3;
	MotorAftClosure_d=kATRMS_Aft54_d;
	MotorAftClosure_h=kATRMS_Aft54_h;
	Retainer_d=65;
	OAH=33;
	
	difference(){
		cylinder(d=Retainer_d, h=OAH, $fn=$preview? 90:360);
		
		// Aft closure
		translate([0,0,-Overlap]) cylinder(d=MotorAftClosure_d+IDXtra*4, h=15, $fn=$preview? 90:360);
		// motor body
		cylinder(d=BT54Body_ID+IDXtra, h=OAH, $fn=$preview? 90:360);
		// C-clip
		translate([0,0,3]) cylinder(d=MotorAftClosure_d+3, h=2, $fn=$preview? 90:360);
		translate([0,0,5]) cylinder(d1=MotorAftClosure_d+3, d2=MotorAftClosure_d+IDXtra*4, h=2, $fn=$preview? 90:360);
		// motor tube
		translate([0,0,18]) cylinder(d=MotorTubeHole_d, h=15+Overlap, $fn=$preview? 90:360);
		
		if ($preview) translate([0,0,-Overlap]) cube([50,50,50]);
	} // difference
	
} // BT54MotorRetainer

// BT54MotorRetainer();


module ATRMS_75_2560_Motor(Extended=false, HasEyeBolt=true){

	Extra=Extended? kATRMS_ExtFor75_h2:0;
	
	if (HasEyeBolt)
		color("Gray") translate([0,0,kATRMS_75_2560_Case_h+kATRMS_For75_oal+Extra]) Eye_Bolt2();
	color("Silver") translate([0,0,kATRMS_75_2560_Case_h]) ATRMS_ForClosure75(Extended=Extended);
	color("LightBlue") ATRMS_75_2560_Case();
	color("Silver") ATRMS_AftClosure75();
} // ATRMS_75_2560_Motor

//ATRMS_75_2560_Motor(Extended=false, HasEyeBolt=true);

module ATRMS_75_3840_Motor(Extended=false, HasEyeBolt=true){

	Extra=Extended? kATRMS_ExtFor75_h2:0;
	
	if (HasEyeBolt)
		color("Gray") translate([0,0,kATRMS_75_3840_Case_h+kATRMS_For75_oal+Extra]) Eye_Bolt2();
	color("Silver") translate([0,0,kATRMS_75_3840_Case_h]) ATRMS_ForClosure75(Extended=Extended);
	color("LightBlue") ATRMS_75_3840_Case();
	color("Silver") ATRMS_AftClosure75();
} // ATRMS_75_3840_Motor

//ATRMS_75_3840_Motor(Extended=false, HasEyeBolt=true);

module ATRMS_ForClosure75(Extended=false){
	// Standard plugged threaded forward closure
	Etra=Extended? kATRMS_ExtFor75_h2:0;
	
	cylinder(d=kATRMS_For75_d1, h=kATRMS_For75_h1);
	cylinder(d=kATRMS_For75_d2, h=kATRMS_For75_h2+Etra);
	
	translate([0,0,kATRMS_For75_h2+Etra-kATRMS_For75_h3/2-1.5]) hull(){
		cylinder(d=kATRMS_For75_d3, h=kATRMS_For75_h3, center=true);
		cylinder(d=kATRMS_For75_d2, h=kATRMS_For75_h3+3, center=true);
	}
	
	cylinder(d=kATRMS_For75_d4, h=kATRMS_For75_h4+Etra);
	
} // ATRMS_ForClosure75

// ATRMS_ForClosure75(Extended=false);


module ATRMS_75_2560_Case(){
	cylinder(d=kATRMS_75_Case_d, h=kATRMS_75_2560_Case_h);
} // ATRMS_75_2560_Case

// ATRMS_75_2560_Case();

module ATRMS_75_3840_Case(){
	cylinder(d=kATRMS_75_Case_d, h=kATRMS_75_3840_Case_h);
} // ATRMS_75_3840_Case

// ATRMS_75_3840_Case();

module ATRMS_AftClosure75(){
	
	translate([0,0,-kATRMS_Aft75_h/2]) hull(){
		cylinder(d=kATRMS_Aft75_d-2, h=kATRMS_Aft75_h, center=true);
		cylinder(d=kATRMS_Aft75_d, h=kATRMS_Aft75_h-2, center=true);
	}
	
} // ATRMS_AftClosure75

// ATRMS_AftClosure75();













