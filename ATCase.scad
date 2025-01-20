// ******************************************
// 75/1280 Case 
// Filename: ATCase.scad
// Created: 1/19/2025
// Revision: 0.9.0    1/19/2025
// Units: mm
// ******************************************
//  ***** Notes *****
//
// Cases for motor cases.
//
//  ***** History *****
//
// 0.9.0    1/19/2025  First code
//
// ******************************************
//  ***** for STL output *****
//
// CaseEnd(Label="75/1280");
// CaseEnd(Label="75/2560");
// CaseTube(Len=200);
// ExtenderTube(Len=134);
//
// ******************************************

include<CommonStuffSAEmm.scad>
use<ThreadLib.scad>

IDXtra=0.2;
$fn=$preview? 36:90;
Overlap=0.05;

NominalThread_d=2.820*25.4;
ThreadPitch=25.4/16;
Step_a=$preview? 20:2;
Case_d=75.4;
AT751280_Len=198;
AT752560_Len=332;

module CaseEnd(Label="75/1280"){
	
	
	difference(){
		cylinder(d=88,h=3,$fn=20);
		
		rotate([180,0,0]) linear_extrude(height=1, center=true) text(text=Label, valign="center", size=10, halign="center");
	} // difference
	
	difference(){
		ExternalThread(Pitch=ThreadPitch, Dia_Nominal=NominalThread_d, Length=10, Step_a=Step_a, TrimEnd=true, TrimRoot=false);
		translate([0,0,-Overlap]) cylinder(d=NominalThread_d-10, h=13);
	} // difference

	difference(){
		cylinder(d=Case_d+1+4.4, h=8, $fn=$preview? 90:360);
		
		translate([0,0,-Overlap]) cylinder(d=Case_d+1, h=8+Overlap*2, $fn=$preview? 90:360);
	} // difference
} // CaseEnd

// CaseEnd();

module ExtenderTube(Len=134){
	Wall_t=1.8;
	Tube_ID=Case_d+1+4.4+IDXtra*2;
	Tube_OD=Tube_ID+Wall_t*2;

	difference(){
		cylinder(d=Tube_OD, h=Len, $fn=$preview? 90:360);
	
		translate([0,0,-Overlap]) cylinder(d=Tube_ID, h=Len+Overlap*2, $fn=$preview? 90:360);
	} // difference

	translate([0,0,Len])
		difference(){
			cylinder(d=Tube_ID-IDXtra, h=5, $fn=$preview? 90:360);
	
			translate([0,0,-Overlap]) cylinder(d=Tube_ID-IDXtra-Wall_t*2, h=5+Overlap*2, $fn=$preview? 90:360);
		} // difference

	translate([0,0,Len-5])
		difference(){
			cylinder(d=Tube_ID+Overlap, h=5+Overlap, $fn=$preview? 90:360);
	
			translate([0,0,-Overlap]) cylinder(d1=Tube_ID, d2=Tube_ID-IDXtra-Wall_t*2, h=5+Overlap*3, $fn=$preview? 90:360);
		} // difference
} // ExtenderTube

//ExtenderTube();

module CaseTube(Len=200){
	Wall_t=1.8;
	Tube_ID=Case_d+1+4.4+IDXtra*2;
	Tube_OD=Tube_ID+Wall_t*2;
	
	difference(){
		cylinder(d=Tube_OD, h=Len, $fn=$preview? 90:360);
	
		translate([0,0,-Overlap]) cylinder(d=Tube_ID, h=Len+Overlap*2, $fn=$preview? 90:360);
	} // difference

	translate([0,0,Len/2-10])
		difference(){
			cylinder(d=Tube_OD-1, h=20);
			
			cylinder(d=Case_d+1, h=20, $fn=$preview? 90:360);
			translate([0,0,-Overlap])
				cylinder(d1=Tube_ID+0.1, d2=Case_d+1, h=8, $fn=$preview? 90:360);
			translate([0,0,20+Overlap]) mirror([0,0,1])
				cylinder(d1=Tube_ID+0.1, d2=Case_d+1, h=8, $fn=$preview? 90:360);
		} // difference
} // CaseTube

// CaseTube(Len=200);

/*
difference(){
	union(){
		CaseEnd();
		CaseTube();
	} // union
	
	translate([0,0,-Overlap]) cube([100,100,220]);
} // difference
/**/










































