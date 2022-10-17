// *************************************************
// filename: CommondStuffSAEmm.scad
//  by Dave Flynn 2015, GPL v2
// Rev: 1.0.5 10/16/2022
// Some hole sizes have not been tested.
//
// This file contains constants and some common routines
// Units: mm
// *************************************************
//  Routines for making bolt holes in parts
//  #2-56
// Bolt2ButtonHeadHole(depth=8,lHead=12);
// Bolt2HeadHole(depth=8,lHead=12);
// Bolt2Hole(depth=10);
// Bolt2ClearHole(depth=12);
//  #4-40
// Bolt4FlatHeadHole(depth=8,lAccess=12);
// Bolt4ButtonHeadHole(depth=8,lHead=12);
// Bolt4HeadHole(depth=8,lHead=12);
// Bolt4Hole(depth=12);
// Bolt4ClearHole(depth=12);
// Bolt4RailNut();
//  #6-32
// Bolt6FlatHeadHole(depth=12,lAccess=12);
// Bolt6ButtonHeadHole(depth=12,lHead=12);
// Bolt6HeadHole(depth=16, lAccess=12);
// Bolt6Hole(depth=16);
// Bolt6ClearHole(depth=12);
// Bolt6RailNut();
//  #8-32
// Bolt8ButtonHeadHole(depth=12,lHead=12);
// Bolt8HeadHole(depth=12, lAccess=12);
// Bolt8Hole(depth=19);
// Bolt8ClearHole(depth=12);
//  #10-32, #10-24, M5
// Bolt10ButtonHeadHole(depth=12,lHead=12);
// Bolt10HeadHole(depth=12, lAccess=12);
// Bolt10Hole(depth=19);
// Bolt10ClearHole(depth=19);
//  1/4"-20
// Bolt250FlatHeadHole(depth=12, lAccess=12);
// Bolt250ButtonHeadHole(depth=12, lHead=12);
// Bolt250HeadHole(depth=12, lAccess=12);
// Bolt250Hole(depth=19);
// Bolt250ClearHole(depth=19);
//   M8
// BoltM8ButtonHeadHole(depth=20,lHead=12);
// BoltM8Hole(depth=22);
// BoltM8ClearHole(depth=22);
// BoltM8HeadHole(depth=22, lAccess=18);
//
//  *** Other Stuff ***
// Size17StepperBolts() //children();
// Size17StepperMount(x=Motor17_w,y=Motor17_w,Mount_h=5);
// Size17Stepper();
// RoundRect(X=10,Y=10,Z=5,R=2);
// *************************************************
//  **** History *****
//
echo("CommonStuffSAEmm 1.0.5");
// 1.0.5 10/16/2022 Fixed Bolt2Head_r for my Soc Hd Cap Screws
// 1.0.4 9/1/2022   Added Bolt250FlatHeadHole
// 1.0.3 6/21/2022  Added/Fixed Bolt6RailNut
// 1.0.1 12/28/2021 Added points, added RoundRect
// 1.0.0 2/28/2020  Added BoltM8...
// 0.9.11 2/8/2020  Bolt250Hole smaller
// 0.9.10 7/11/2019 Bolt6FlatHeadHole();
// 0.9.9 2/19/2019  Fixed 250 btn head radius
// 0.9.8 12/29/2018 Added #4 RailNut
// 0.9.7 7/5/2018   Adjusted #6 hole
// 0.9.6 6/9/2018   Adjusted #2 hole
// 0.9.5 1/27/2018  Adjusted #4 hole
// 0.9.4 1/26/2018  Metric version
// 0.9.3 11/23/2017 Added Bolt4FlatHeadHole
// 0.9.2 9/19/2017  Added Size17StepperBolts, Size17StepperMount, Size17Stepper.
// 0.9.1 2/28/2016	Added Bolt6TapHole_r, made Bolt6_r 0.005 smaller
// 0.9 1/30/2016 	First rev'd version, Did a bunck of cleanup
// *************************************************
//ShowAllBolts(); // for visulization
//scale([25.4,25.4,25.4]) HoleTestBlock(); // Print 1 to test fit all bolts

// ********** Constants **********

Overlap=0.05;  // used to ensure manifoldness
ID_Xtra=0.2;	// Added to ID to compensate for printing DMF3D

//ID_Xtra=0.008;	// Added to ID to compensate for printing Bukobot 1

Bolt2_r=0.034*25.4;
Bolt2_Head_h=0.090*25.4;
Bolt2_Head_r=0.068*25.4;
Bolt2_BtnHead_r=0.090*25.4;
Bolt2_BtnHead_h=0.045*25.4;
Bolt2_Clear_r=0.053*25.4;

Bolt4_r=0.0445*25.4; // was 0.050 too loose in the mm version for PETG
Bolt4TapHole_r=0.0445*25.4;
Bolt4_Head_r=0.091*25.4;	
Bolt4_Head_h=0.116*25.4;
Bolt4_BtnHead_r=0.120*25.4;// 0.015 over so M3 is OK
Bolt4_BtnHead_h=0.066*25.4;
Bolt4_FlatHd_d=0.255*25.4;
Bolt4_FlatHd_h=0.083*25.4;
Bolt4_Clear_r=0.063*25.4;

Bolt6_r=0.052*25.4; // was 0.058
Bolt6TapHole_r=0.055*25.4;
Bolt6_Head_r=0.125*25.4;
Bolt6_Head_h=0.140*25.4;
Bolt6_BtnHead_r=0.135*25.4;
Bolt6_BtnHead_h=0.075*25.4;
Bolt6_FlatHd_d=0.277*25.4;
Bolt6_FlatHd_h=0.125*25.4;
Bolt6_Clear_r=0.073*25.4;

Bolt8TapHole_r=0.068*25.4;
Bolt8_r=0.070*25.4;
Bolt8_Head_r=0.145*25.4;
Bolt8_Head_h=0.22*25.4;
Bolt8_BtnHead_r=0.188*25.4;
Bolt8_BtnHead_h=0.095*25.4;
Bolt8_Clear_r=0.090*25.4;

Bolt10TapHole_r=0.080*25.4;
Bolt10_r=0.080*25.4; // was 0.094;
Bolt10_Head_r=0.157*25.4;
Bolt10_Head_h=0.195*25.4;
Bolt10_BtnHead_r=0.190*25.4;
Bolt10_BtnHead_h=0.115*25.4;
Bolt10_Clear_r=0.105*25.4;

Bolt250TapHole_r=0.100*25.4;
Bolt250_r=0.100*25.4;
Bolt250_Head_r=0.190*25.4;
Bolt250_Head_h=0.250*25.4;
Bolt250_BtnHead_r=0.225*25.4; // was .210 2/19/2019
Bolt250_BtnHead_h=0.135*25.4;
Bolt250_FlatHd_d=0.500*25.4; // not verified
Bolt250_FlatHd_h=0.185*25.4; // not verified
Bolt250_Clear_r=0.128*25.4;

BoltM8_r=3.1;
BoltM8_Head_r=6.7;
BoltM8_Head_h=8.2;
BoltM8_BtnHead_r=7;
BoltM8_BtnHead_h=4.4;
BoltM8_Clear_r=4.1;

// ***** #2-56 *****

module Bolt2ButtonHeadHole(depth=8,lHead=12){
	// the point
	translate([0,0,-depth-Bolt2_BtnHead_h-Bolt2_Clear_r+Overlap])
		cylinder(r1=Overlap,r2=Bolt2_Clear_r+ID_Xtra,h=Bolt2_Clear_r,$fn=18);
	
	translate([0,0,-depth-Bolt2_BtnHead_h])
		cylinder(r=Bolt2_Clear_r+ID_Xtra,h=depth+Overlap,$fn=24);
	translate([0,0,-Bolt2_BtnHead_h])
		cylinder(r=Bolt2_BtnHead_r+ID_Xtra,h=lHead,$fn=24);
} // Bolt2ButtonHeadHole

//Bolt2ButtonHeadHole(depth=8,lHead=12);

module Bolt2HeadHole(depth=8,lHead=12){
	// the point
	translate([0,0,-depth-Bolt2_Head_h-Bolt2_Clear_r+Overlap])
		cylinder(r1=Overlap,r2=Bolt2_Clear_r+ID_Xtra,h=Bolt2_Clear_r,$fn=18);

	translate([0,0,-depth-Bolt2_Head_h])
		cylinder(r=Bolt2_Clear_r+ID_Xtra,h=depth+Overlap,$fn=24);
	translate([0,0,-Bolt2_Head_h])
		cylinder(r=Bolt2_Head_r+ID_Xtra,h=lHead,$fn=24);
} // Bolt2HeadHole

//Bolt2HeadHole(depth=8,lHead=12);

module Bolt2Hole(depth=10){
	// the point
	translate([0,0,-depth-Bolt2_r])
		cylinder(r1=Overlap,r2=Bolt2_r+ID_Xtra,h=Bolt2_r,$fn=18);

	translate([0,0,-depth-Overlap])
		cylinder(r=Bolt2_r+ID_Xtra,h=depth+Overlap*2,$fn=24);
} // Bolt2Hole

// Bolt2Hole(depth=10);

module Bolt2ClearHole(depth=12){
	translate([0,0,-depth-Overlap])
		cylinder(r=Bolt2_Clear_r+ID_Xtra,h=depth+Overlap*2,$fn=24);
} // BoltClearHole

// ***** #4-40 *****

module Bolt4ButtonHeadHole(depth=8,lHead=12){
	// the point
	translate([0,0,-depth-Bolt4_BtnHead_h-Bolt4_Clear_r+Overlap])
		cylinder(r1=Overlap,r2=Bolt4_Clear_r+ID_Xtra,h=Bolt4_Clear_r,$fn=18);
	
	translate([0,0,-depth-Bolt4_BtnHead_h])
		cylinder(r=Bolt4_Clear_r+ID_Xtra,h=depth+Overlap,$fn=24);
	translate([0,0,-Bolt4_BtnHead_h])
		cylinder(r=Bolt4_BtnHead_r+ID_Xtra,h=lHead,$fn=24);
} // Bolt4ButtonHeadHole

//Bolt4ButtonHeadHole(depth=8,lHead=12);

module Bolt4HeadHole(depth=8,lHead=12){
	// the point
	translate([0,0,-depth-Bolt4_Head_h-Bolt4_Clear_r+Overlap])
		cylinder(r1=Overlap,r2=Bolt4_Clear_r+ID_Xtra,h=Bolt4_Clear_r,$fn=18);

	translate([0,0,-depth-Bolt4_Head_h])
		cylinder(r=Bolt4_Clear_r+ID_Xtra,h=depth+Overlap,$fn=24);
	translate([0,0,-Bolt4_Head_h])
		cylinder(r=Bolt4_Head_r+ID_Xtra,h=lHead,$fn=24);
} // Bolt4HeadHole

//Bolt4HeadHole(depth=8,lHead=12);

module Bolt4FlatHeadHole(depth=8,lAccess=12){
	translate([0,0,-depth])
		cylinder(r=Bolt4_Clear_r+ID_Xtra,h=depth+Overlap,$fn=24);
	translate([0,0,-Bolt4_FlatHd_h])
		cylinder(d1=Bolt4_Clear_r+ID_Xtra,d2=Bolt4_FlatHd_d+ID_Xtra,h=Bolt4_FlatHd_h,$fn=24);
	translate([0,0,-Overlap])cylinder(d=Bolt4_FlatHd_d+ID_Xtra,h=lAccess,$fn=24);
} // Bolt4FlatHeadHole

module Bolt4Hole(depth=12){
	// the point
	translate([0,0,-depth-Bolt4_r])
		cylinder(r1=Overlap,r2=Bolt4_r+ID_Xtra,h=Bolt4_r,$fn=18);

	//echo(Bolt4_r+ID_Xtra);
	translate([0,0,-depth-Overlap])
		cylinder(r=Bolt4_r+ID_Xtra,h=depth+Overlap*2,$fn=24);
} // Bolt4Hole

//Bolt4Hole(depth=12);

module Bolt4ClearHole(depth=12){
	translate([0,0,-depth-Overlap])
		cylinder(r=Bolt4_Clear_r+ID_Xtra,h=depth+Overlap*2,$fn=24);
} // BoltClearHole

module Bolt4RailNut(){
	Rail_w1=13.5; // top of T section
	Rail_w2=6; // base of T section
	Rail_w3=6.2; // slot
	Rail_h1=5;
	Rail_h2=2;
	Washer_OD=10;
	Washer_h=1;
	Nut_l=18;
	Nut4_d=7.4;
	Nut4_h=2.5;
	
	difference(){
		union(){
			translate([-Rail_w3/2,0,Rail_h1-Overlap]) cube([Rail_w3,Nut_l,Rail_h2]);
			hull(){
				translate([-Rail_w1/2,0,Rail_h1-1.2]) cube([Rail_w1,Nut_l,1.2]);
				translate([-Rail_w2/2,0,0]) cube([Rail_w2,Nut_l,0.1]);
			} // hull
	} // union

		translate([0,Nut_l/2,Rail_h1-Washer_h]) cylinder(d=Washer_OD,h=Washer_h+Rail_h2+Overlap,$fn=36);
		translate([0,Nut_l/2,Rail_h1-Washer_h]) Bolt4ClearHole();
		translate([0,Nut_l/2,Rail_h1-Washer_h-Nut4_h+Overlap]) cylinder(d=Nut4_d,h=Nut4_h,$fn=6);
	} // diff
} // Bolt4RailNut

//Bolt4RailNut();

// ***** #6-32 *****

module Bolt6FlatHeadHole(depth=12,lAccess=12){
	translate([0,0,-depth])
		cylinder(r=Bolt6_Clear_r+ID_Xtra,h=depth+Overlap,$fn=24);
	translate([0,0,-Bolt6_FlatHd_h])
		cylinder(d1=Bolt6_Clear_r+ID_Xtra,d2=Bolt6_FlatHd_d+ID_Xtra,h=Bolt6_FlatHd_h,$fn=24);
	translate([0,0,-Overlap])cylinder(d=Bolt6_FlatHd_d+ID_Xtra,h=lAccess,$fn=24);
} // Bolt6FlatHeadHole

module Bolt6ButtonHeadHole(depth=12,lHead=12){
	// the point
	translate([0,0,-depth-Bolt6_BtnHead_h-Bolt6_Clear_r+Overlap])
		cylinder(r1=Overlap,r2=Bolt6_Clear_r+ID_Xtra,h=Bolt6_Clear_r,$fn=18);

	translate([0,0,-depth-Bolt6_BtnHead_h])
		cylinder(r=Bolt6_Clear_r+ID_Xtra,h=depth+Overlap,$fn=24);
	translate([0,0,-Bolt6_BtnHead_h])
		cylinder(r=Bolt6_BtnHead_r+ID_Xtra,h=lHead,$fn=24);
} // Bolt6ButtonHeadHole

// Bolt6ButtonHeadHole(depth=12,lHead=12);

module Bolt6ClearHole(depth=12){
	translate([0,0,-depth-Overlap])
		cylinder(r=Bolt6_Clear_r+ID_Xtra,h=depth+Overlap*2,$fn=24);
} // Bolt6ClearHole

module Bolt6Hole(depth=16){
	// the point
	translate([0,0,-depth-Bolt6_r])
		cylinder(r1=Overlap,r2=Bolt6_r+ID_Xtra,h=Bolt6_r,$fn=18);

	translate([0,0,-depth-Overlap])
		cylinder(r=Bolt6_r+ID_Xtra,h=depth+Overlap*2,$fn=24);
} // Bolt6Hole

//Bolt6Hole(depth=16);

module Bolt6HeadHole(depth=16, lAccess=12){
	// the point
	translate([0,0,-depth-Bolt6_Head_h-Bolt6_Clear_r+Overlap])
		cylinder(r1=Overlap,r2=Bolt6_Clear_r+ID_Xtra,h=Bolt6_Clear_r,$fn=18);

	translate([0,0,-depth-Bolt6_Head_h])
		cylinder(r=Bolt6_Clear_r+ID_Xtra,h=depth+Overlap,$fn=24);
	translate([0,0,-Bolt6_Head_h])
		cylinder(r=Bolt6_Head_r+ID_Xtra,h=Bolt6_Head_h+lAccess+Overlap,$fn=24);
} // Bolt6HeadHole

// Bolt6HeadHole(depth=16, lAccess=12);

module Bolt6RailNut(){
	Rail_w1=14.0; // top of T section
	Rail_w2=6; // base of T section
	Rail_w3=6.2; // slot
	Rail_h1=4.8;
	Rail_h2=2;
	Washer_OD=10.4+ID_Xtra;
	Washer_h=1.2;
	Nut_l=18;
	Nut6_d=9.4+ID_Xtra;
	Nut6_h=2.8;
	
	difference(){
		union(){
			translate([-Rail_w3/2,0,Rail_h1-Overlap]) cube([Rail_w3, Nut_l, Rail_h2]);
			
			hull(){
				translate([-Rail_w1/2, 0, Rail_h1-1.2]) cube([Rail_w1, Nut_l, 1.2]);
				translate([-Rail_w2/2, 0, 0]) cube([Rail_w2, Nut_l, 0.1]);
			} // hull
	} // union

		translate([0, Nut_l/2, Rail_h1-Washer_h]) 
			cylinder(d=Washer_OD, h=Washer_h+Rail_h2+Overlap, $fn=36);
		translate([0, Nut_l/2, Rail_h1-Washer_h]) Bolt6ClearHole();
		translate([0, Nut_l/2, Rail_h1-Washer_h-Nut6_h+Overlap]) 
			rotate([0, 0, 30]) cylinder(d=Nut6_d, h=Nut6_h, $fn=6);
	} // diff
} // Bolt6RailNut

// Bolt6RailNut();

// ***** #8-32 *****

module Bolt8ButtonHeadHole(depth=12,lHead=12){
	// the point
	translate([0,0,-depth-Bolt8_BtnHead_h-Bolt8_Clear_r+Overlap])
		cylinder(r1=Overlap,r2=Bolt8_Clear_r+ID_Xtra,h=Bolt8_Clear_r,$fn=18);

	translate([0,0,-depth-Bolt8_BtnHead_h])
		cylinder(r=Bolt8_Clear_r+ID_Xtra,h=depth+Overlap,$fn=24);
	translate([0,0,-Bolt8_BtnHead_h])
		cylinder(r=Bolt8_BtnHead_r+ID_Xtra,h=lHead,$fn=24);
} // Bolt8ButtonHeadHole

//Bolt8ButtonHeadHole(depth=12,lHead=12);

module Bolt8Hole(depth=19){
	// the point
	translate([0,0,-depth-Bolt8_r])
		cylinder(r1=Overlap,r2=Bolt8_r+ID_Xtra,h=Bolt8_r,$fn=18);

	translate([0,0,-depth-Overlap])
		cylinder(r=Bolt8_r+ID_Xtra,h=depth+Overlap*2,$fn=24);
} // Bolt8Hole

//Bolt8Hole(depth=19);

module Bolt8HeadHole(depth=12, lAccess=12){
	// the point
	translate([0,0,-depth-Bolt8_Head_h-Bolt8_Clear_r+Overlap])
		cylinder(r1=Overlap,r2=Bolt8_Clear_r+ID_Xtra,h=Bolt8_Clear_r,$fn=18);

	translate([0,0,-depth-Bolt8_Head_h])
		cylinder(r=Bolt8_Clear_r+ID_Xtra,h=depth+Overlap,$fn=24);
	translate([0,0,-Bolt8_Head_h])
		cylinder(r=Bolt8_Head_r+ID_Xtra,h=Bolt8_Head_h+lAccess+Overlap,$fn=24);
} // Bolt8HeadHole

//Bolt8HeadHole(depth=12, lAccess=12);

module Bolt8ClearHole(depth=12){
	translate([0,0,-depth-Overlap])
		cylinder(r=Bolt8_Clear_r+ID_Xtra,h=depth+Overlap*2,$fn=24);
} // Bolt8ClearHole

// ***** #10-32, #10-24, M5 *****

module Bolt10ButtonHeadHole(depth=12,lHead=12){
	// the point
	translate([0,0,-depth-Bolt10_BtnHead_h-Bolt10_Clear_r+Overlap])
		cylinder(r1=Overlap,r2=Bolt10_Clear_r+ID_Xtra,h=Bolt10_Clear_r,$fn=18);

	translate([0,0,-depth-Bolt10_BtnHead_h])
		cylinder(r=Bolt10_Clear_r+ID_Xtra,h=depth+Overlap,$fn=24);
	translate([0,0,-Bolt10_BtnHead_h])
		cylinder(r=Bolt10_BtnHead_r+ID_Xtra,h=lHead,$fn=24);
} // Bolt10ButtonHeadHole

//Bolt10ButtonHeadHole(depth=12,lHead=12);

module Bolt10Hole(depth=19){
	// the point
	translate([0,0,-depth-Bolt10_r])
		cylinder(r1=Overlap,r2=Bolt10_r+ID_Xtra,h=Bolt10_r,$fn=18);

	translate([0,0,-depth+Overlap])
		cylinder(r=Bolt10_r+ID_Xtra,h=depth+Overlap*2,$fn=24);
} // Bolt10Hole

//Bolt10Hole(depth=19);

module Bolt10HeadHole(depth=12, lAccess=12){
	// the point
	translate([0,0,-depth-Bolt10_Head_h-Bolt10_Clear_r+Overlap])
		cylinder(r1=Overlap,r2=Bolt10_Clear_r+ID_Xtra,h=Bolt10_Clear_r,$fn=18);

	translate([0,0,-depth-Bolt10_Head_h])
		cylinder(r=Bolt10_Clear_r+ID_Xtra,h=depth+Overlap,$fn=24);
	translate([0,0,-Bolt10_Head_h])
		cylinder(r=Bolt10_Head_r+ID_Xtra,h=Bolt10_Head_h+lAccess+Overlap,$fn=24);
} // Bolt10HeadHole

//Bolt10HeadHole(depth=12, lAccess=12);

module Bolt10ClearHole(depth=19){
	translate([0,0,-depth+Overlap])
		cylinder(r=Bolt10_Clear_r+ID_Xtra,h=depth+Overlap*2,$fn=24);
} // Bolt10ClearHole

// ***** 1/4"-20 *****

module Bolt250FlatHeadHole(depth=12,lAccess=12){
	translate([0,0,-depth])
		cylinder(r=Bolt250_Clear_r+ID_Xtra, h=depth+Overlap, $fn=24);
	translate([0,0,-Bolt250_FlatHd_h])
		cylinder(d1=Bolt250_Clear_r+ID_Xtra, d2=Bolt250_FlatHd_d+ID_Xtra, h=Bolt250_FlatHd_h, $fn=24);
	translate([0,0,-Overlap]) cylinder(d=Bolt250_FlatHd_d+ID_Xtra, h=lAccess, $fn=24);
} // Bolt250FlatHeadHole

module Bolt250ButtonHeadHole(depth=12,lHead=12){
	// the point
	translate([0,0,-depth-Bolt250_BtnHead_h-Bolt250_Clear_r+Overlap])
		cylinder(r1=Overlap,r2=Bolt250_Clear_r+ID_Xtra,h=Bolt250_Clear_r,$fn=18);

	translate([0,0,-depth-Bolt250_BtnHead_h])
		cylinder(r=Bolt250_Clear_r+ID_Xtra,h=depth+Overlap,$fn=24);
	translate([0,0,-Bolt250_BtnHead_h])
		cylinder(r=Bolt250_BtnHead_r+ID_Xtra,h=lHead,$fn=24);
} // Bolt250ButtonHeadHole

//Bolt250ButtonHeadHole(depth=12,lHead=12);

module Bolt250Hole(depth=19){
	// the point
	translate([0,0,-depth-Bolt250_r])
		cylinder(r1=Overlap,r2=Bolt250_r+ID_Xtra,h=Bolt250_r,$fn=18);

	translate([0,0,-depth+Overlap])
		cylinder(r=Bolt250_r+ID_Xtra,h=depth+Overlap*2,$fn=24);
} // Bolt250Hole

//Bolt250Hole(depth=19);

module Bolt250ClearHole(depth=19){
	translate([0,0,-depth+Overlap])
		cylinder(r=Bolt250_Clear_r+ID_Xtra,h=depth+Overlap*2,$fn=24);
} // Bolt250ClearHole

module Bolt250HeadHole(depth=12, lAccess=12){
	// the point
	translate([0,0,-depth-Bolt250_Head_h-Bolt250_Clear_r+Overlap])
		cylinder(r1=Overlap,r2=Bolt250_Clear_r+ID_Xtra,h=Bolt250_Clear_r,$fn=18);

	translate([0,0,-depth-Bolt250_Head_h])
		cylinder(r=Bolt250_Clear_r+ID_Xtra,h=depth+Overlap*2,$fn=24);
	translate([0,0,-Bolt250_Head_h])
		cylinder(r=Bolt250_Head_r+ID_Xtra,h=Bolt250_Head_h+lAccess+Overlap*2,$fn=24);
} // Bolt250HeadHole

//Bolt250HeadHole(depth=12, lAccess=12);

// ***** M8 *****

module BoltM8ButtonHeadHole(depth=20,lHead=12){
	// the point
	translate([0,0,-depth-BoltM8_BtnHead_h-BoltM8_Clear_r+Overlap])
		cylinder(r1=Overlap,r2=BoltM8_Clear_r+ID_Xtra,h=BoltM8_Clear_r,$fn=18);

	translate([0,0,-depth-BoltM8_BtnHead_h])
		cylinder(r=BoltM8_Clear_r+ID_Xtra,h=depth+Overlap,$fn=24);
	translate([0,0,-BoltM8_BtnHead_h])
		cylinder(r=BoltM8_BtnHead_r+ID_Xtra,h=lHead,$fn=24);
} // BoltM8ButtonHeadHole

//BoltM8ButtonHeadHole(depth=20,lHead=12);

module BoltM8Hole(depth=22){
	// the point
	translate([0,0,-depth-BoltM8_r])
		cylinder(r1=Overlap,r2=BoltM8_r+ID_Xtra,h=BoltM8_r,$fn=18);

	translate([0,0,-depth+Overlap])
		cylinder(r=BoltM8_r+ID_Xtra,h=depth+Overlap*2,$fn=24);
} // BoltM8Hole

//BoltM8Hole(depth=22);

module BoltM8ClearHole(depth=22){
	translate([0,0,-depth+Overlap])
		cylinder(r=BoltM8_Clear_r+ID_Xtra,h=depth+Overlap*2,$fn=24);
} // BoltM8ClearHole

module BoltM8HeadHole(depth=22, lAccess=18){
	// the point
	translate([0,0,-depth-BoltM8_Head_h-BoltM8_Clear_r+Overlap])
		cylinder(r1=Overlap,r2=BoltM8_Clear_r+ID_Xtra,h=BoltM8_Clear_r,$fn=18);

	translate([0,0,-depth-BoltM8_Head_h])
		cylinder(r=BoltM8_Clear_r+ID_Xtra,h=depth+Overlap*2,$fn=24);
	translate([0,0,-BoltM8_Head_h])
		cylinder(r=BoltM8_Head_r+ID_Xtra,h=BoltM8_Head_h+lAccess+Overlap*2,$fn=24);
} // BoltM8HeadHole

//BoltM8HeadHole(depth=22, lAccess=18);

// **********************************

module ShowAllBolts(){
	translate([0,55,0]){ Bolt2ButtonHeadHole();
	translate([12,0,0]) Bolt2Hole();
	translate([25,0,0]) Bolt2ClearHole();
	translate([40,0,0]) Bolt2HeadHole();}

	translate([0,45,0]){ Bolt4ButtonHeadHole();
	translate([12,0,0]) Bolt4Hole();
	translate([25,0,0]) Bolt4ClearHole();
	translate([40,0,0]) Bolt4HeadHole();}

	translate([0,35,0]){ Bolt6ButtonHeadHole();
	translate([12,0,0]) Bolt6Hole();
	translate([25,0,0]) Bolt6ClearHole();
	translate([40,0,0]) Bolt6HeadHole();}

	translate([0,25,0]){ Bolt8ButtonHeadHole();
	translate([12,0,0]) Bolt8Hole();
	translate([25,0,0]) Bolt8ClearHole();
	translate([40,0,0]) Bolt8HeadHole();}

	translate([0,12,0]){ Bolt10ButtonHeadHole();
	translate([12,0,0]) Bolt10Hole();
	translate([25,0,0]) Bolt10ClearHole();
	translate([40,0,0]) Bolt10HeadHole();}

	translate([0,0,0]){ Bolt250ButtonHeadHole();
	translate([12,0,0]) Bolt250Hole();
	translate([25,0,0]) Bolt250ClearHole();
	translate([40,0,0]) Bolt250HeadHole();}
	
} // ShowAllBolts

module HoleTestBlock(){
	difference(){
		cube([60,75,12]);
		
		translate([10,10,12]) ShowAllBolts();
	} // diff
	
} // HoleTestBlock

//HoleTestBlock();

Motor17_w=1.662*25.4;

module Size17StepperBolts(){
	MotorBoltCircle_d=1.732*25.4;
	
	for (J=[0:3]) rotate([0,0,90*J])
			translate([MotorBoltCircle_d/2*0.707,MotorBoltCircle_d/2*0.707,0]) children();
}// Size17StepperBolts

module Size17StepperMount(x=Motor17_w,y=Motor17_w,Mount_h=5){
	MotorBoss17_d=0.866*25.4+ID_Xtra;
	MotorBoltCircle_d=1.732*25.4;

	difference(){
		translate([-x/2,-y/2,0]) cube([x,y,Mount_h]);

		translate([0,0,-Overlap]) cylinder(d=MotorBoss17_d,h=Mount_h+Overlap*2,$fn=90);

		translate([0,0,Mount_h])Size17StepperBolts() Bolt4Hole();
	} // diff

} // Size17StepperMount

//Size17StepperMount();

module Size17Stepper(){
	Motor17_h=1.867*25.4;
	MotorBoss17_d=0.866*25.4;
	MotorBoss17_h=0.080*25.4;
	MotorShaft_d=5;
	MotorShaft_l=0.9*25.4;
	MotorBoltCircle_d=1.732*25.4;
	MotorBoltHole_d=0.070*25.4;
	MotorBigShaft_h=0.9*25.4;
	MotorBigShaft_d=0.661*25.4;

	translate([0,0,MotorBigShaft_h-0.350*25.4]) cylinder(d=MotorBigShaft_d,h=0.350*25.4,$fn=24);
	translate([0,0,-Motor17_h]) {
	translate([0,0,Motor17_h]) cylinder(d=MotorBoss17_d, h=MotorBoss17_h,$fn=24);
	translate([0,0,Motor17_h]) cylinder(d=MotorShaft_d, h=MotorShaft_l,$fn=24);
	
	
	difference(){
		translate([-Motor17_w/2,-Motor17_w/2,0]) cube([Motor17_w,Motor17_w,Motor17_h]);
		translate([0,0,-Overlap]) Size17StepperBolts() cylinder(d=MotorBoltHole_d, h=Motor17_h+Overlap*2,$fn=18);

	} // diff
	}
} // Size17Stepper

//Size17Stepper();

module RoundRect(X=10,Y=10,Z=5,R=2){
	hull(){
		translate([-X/2+R, -Y/2+R, 0]) cylinder(r=R, h=Z);
		translate([-X/2+R, Y/2-R, 0]) cylinder(r=R, h=Z);
		translate([X/2-R, -Y/2+R, 0]) cylinder(r=R, h=Z);
		translate([X/2-R, Y/2-R, 0]) cylinder(r=R, h=Z);
	} // hull
} // RoundRect

// RoundRect(X=10,Y=10,Z=5,R=2);





















