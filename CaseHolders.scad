// *****************************************
//  Case Holders
// Filename: CaseHolders.scad
// Created: 10/12/2025
// Revision: 1.0.0   10/12/2025
// Units: mm
// *****************************************
//  ***** Notes *****
//
//
//  ***** History *****
//
// 1.0.0   10/12/2025  First code, 29mm
//
// *****************************************
//  ***** for STL output *****
//
// CaseClip(D=ATRMS_29_Case_OD(), W=10);
// CaseClip(D=ATRMS_38_Case_OD(), W=10);
//
// *****************************************
//  ***** for Viewing *****
//
//
// *****************************************
use<AT_RMS_Lib.scad>
use<ThreadLib.scad>
use<CommonStuffSAEmm.scad>

IDXtra=0.2;
$fn=$preview? 36:90;
Overlap=0.05;

function CaseClipBoltSpace(D)=D+2;

module ClipBoltPattern(D){
	translate([-CaseClipBoltSpace(D)/2,0,0]) children();
	translate([CaseClipBoltSpace(D)/2,0,0]) children();
} // ClipBoltPattern

module CaseClip(D=ATRMS_29_Case_OD(), W=10){
	Clip_a=75;
	Clip_d=6;
	myfn=floor(D)*3;
	
	difference(){
		union(){
			// base
			//translate([-D/2-Clip_d, -D/2-W/2, 0]) cube([D+Clip_d*2, Clip_d+D/2, W]);
			translate([0, -D/2-W/2+(Clip_d+D/2)/2, 0]) RoundRect(X=D+Clip_d*2, Y=Clip_d+D/2, Z=W, R=2);
			
			// top prongs
			rotate([0,0,Clip_a]) translate([0,D/2+Clip_d/2+IDXtra/2,0]) cylinder(d=Clip_d, h=W);
			rotate([0,0,-Clip_a]) translate([0,D/2+Clip_d/2+IDXtra/2,0]) cylinder(d=Clip_d, h=W);
			
			// clip ring
			difference(){
				cylinder(d=D+Clip_d*2+IDXtra, h=W, $fn=myfn);
				
				translate([-D/2,-D/2-Clip_d-2,-Overlap]) cube([D,4,W+Overlap*2]);
				
				rotate([0,0,90-Clip_a]) translate([0,0,-Overlap]) cube([D,D,W+Overlap*2]);
				mirror([1,0,0]) rotate([0,0,90-Clip_a]) translate([0,0,-Overlap]) cube([D,D,W+Overlap*2]);
			} // difference
		} // union
		
		translate([0,0,-Overlap]) cylinder(d=D+IDXtra, h=W+Overlap*2, $fn=myfn);
		
		translate([0, -D/2-W/2, W/2]) ClipBoltPattern(D) rotate([90,0,0]) Bolt8Hole(depth=10);
		
	} // difference
} // CaseClip

// CaseClip();

// CaseClip(D=ATRMS_38_Case_OD(), W=10);

module RMS29SetPlate(D=ATRMS_29_Case_OD()){
	Plate_t=6;
	Plate_X=245;
	Plate_Y=260;
	
	Spacing_X=38;
	
	// 29/60
	
	
	// 29/180
	// 29/240
	// 29/360
	
	module CaseBoltHoles(Spacing=100){
		translate([0,0,Plate_t]) ClipBoltPattern(D) Bolt8ButtonHeadHole();
		translate([0,Spacing,Plate_t]) ClipBoltPattern(D) Bolt8ButtonHeadHole();
		
		// Remove back
		hull(){
			translate([0,10+D/2,-Overlap]) cylinder(d=D, h=Plate_t+Overlap*2);
			translate([0,Spacing-10-D/2,-Overlap]) cylinder(d=D, h=Plate_t+Overlap*2);
		} // hull
	} // CaseBoltHoles
	
	difference(){
		translate([Plate_X/2-25,Plate_Y/2-20,0]) RoundRect(X=Plate_X, Y=Plate_Y, Z=Plate_t, R=5);
		
		// 29/40-120
		CaseBoltHoles(Spacing=80);
		translate([0, 128, 0]) CaseBoltHoles(Spacing=80);
		// 29/100
		translate([Spacing_X, 11, 0]) CaseBoltHoles(Spacing=80);
		translate([Spacing_X, 11+128, 0]) CaseBoltHoles(Spacing=80);
		// 29/120
		translate([Spacing_X*2, 0, 0]) CaseBoltHoles(Spacing=80);
		translate([Spacing_X*2, 128, 0]) CaseBoltHoles(Spacing=80);
		// 29/180
		translate([Spacing_X*3, 11, 0]) CaseBoltHoles(Spacing=130);
		// 29/240
		translate([Spacing_X*4, 0, 0]) CaseBoltHoles(Spacing=170);
		// 29/360
		translate([Spacing_X*5, 11, 0]) CaseBoltHoles(Spacing=210);
		
	} // difference
} // RMS29SetPlate

// RMS29SetPlate();


module RMS38SetPlate(D=ATRMS_38_Case_OD()){
	Plate_t=7;
	Plate_X=200;
	Plate_Y=260;
	
	Spacing_X=46;
	OneGrain_Len=50;
	Grain_Len=48;

	module CaseBoltHoles(Spacing=100){
		translate([0,0,6]) ClipBoltPattern(D) Bolt8ButtonHeadHole();
		translate([0,Spacing,6]) ClipBoltPattern(D) Bolt8ButtonHeadHole();
		
		// Remove back
		hull(){
			translate([0,10+D/2,-Overlap]) cylinder(d=D, h=Plate_t+Overlap*2);
			translate([0,Spacing-10-D/2,-Overlap]) cylinder(d=D, h=Plate_t+Overlap*2);
		} // hull
	} // CaseBoltHoles
	
	difference(){
		translate([Plate_X/2-30,Plate_Y/2-15,0]) RoundRect(X=Plate_X, Y=Plate_Y, Z=Plate_t, R=5);
		
		// 38/120
		CaseBoltHoles(Spacing=OneGrain_Len);
		// 38/240
		translate([0,OneGrain_Len+10, 0]) CaseBoltHoles(Spacing=OneGrain_Len+Grain_Len);
		
		// 38/120
		translate([Spacing_X, 11, 0]) CaseBoltHoles(Spacing=OneGrain_Len);
		// 38/240
		translate([Spacing_X, 11+OneGrain_Len+10, 0]) CaseBoltHoles(Spacing=OneGrain_Len+Grain_Len);
		
		// 38/360
		translate([Spacing_X*2, 0, 0]) CaseBoltHoles(Spacing=OneGrain_Len+Grain_Len*2);
		translate([Spacing_X*3, 11, 0]) CaseBoltHoles(Spacing=OneGrain_Len+Grain_Len*2);
		// 38/480
		//translate([Spacing_X*3, 11, 0]) CaseBoltHoles(Spacing=130);
		// 38/600
		//translate([Spacing_X*4, 0, 0]) CaseBoltHoles(Spacing=170);
		// 38/720
		//translate([Spacing_X*5, 11, 0]) CaseBoltHoles(Spacing=210);
		
	} // difference
} // RMS38SetPlate

// mirror([0,1,0]) RMS38SetPlate();

module RMS38SetPlate2(D=ATRMS_38_Case_OD()){
	Plate_t=7;
	Plate_X=250;
	Plate_Y=190;
	
	Spacing_X=46;
	OneGrain_Len=50;
	Grain_Len=48;

	module CaseBoltHoles(Spacing=100){
		translate([0,0,6]) ClipBoltPattern(D) Bolt8ButtonHeadHole();
		translate([0,Spacing,6]) ClipBoltPattern(D) Bolt8ButtonHeadHole();
		
		// Remove back
		hull(){
			translate([0,10+D/2,-Overlap]) cylinder(d=D, h=Plate_t+Overlap*2);
			translate([0,Spacing-10-D/2,-Overlap]) cylinder(d=D, h=Plate_t+Overlap*2);
		} // hull
	} // CaseBoltHoles
	
	difference(){
		translate([Plate_X/2-30,0,0]) RoundRect(X=Plate_X, Y=Plate_Y, Z=Plate_t, R=5);
		
		// 38/240
		translate([0, -(OneGrain_Len+Grain_Len)/2-6, 0]) CaseBoltHoles(Spacing=OneGrain_Len+Grain_Len);
		
		// 38/240
		translate([Spacing_X, -(OneGrain_Len+Grain_Len)/2+6, 0]) CaseBoltHoles(Spacing=OneGrain_Len+Grain_Len);
		
		// 38/600
		translate([Spacing_X*2, -(OneGrain_Len+Grain_Len*2)/2-6, 0]) CaseBoltHoles(Spacing=OneGrain_Len+Grain_Len*2);
		// 38/600
		translate([Spacing_X*3,-(OneGrain_Len+Grain_Len*2)/2+6, 0]) CaseBoltHoles(Spacing=OneGrain_Len+Grain_Len*2);
		// 38/720
		translate([Spacing_X*4, -(OneGrain_Len+Grain_Len*2)/2-6, 0]) CaseBoltHoles(Spacing=OneGrain_Len+Grain_Len*2);
		
	} // difference
} // RMS38SetPlate2

// mirror([0,1,0]) RMS38SetPlate2();

module CaseEnd38(){
	difference(){
		union(){
			ExternalThread(Pitch=25.4/24,Dia_Nominal=1.437*25.4,Length=9,Step_a=$preview? 20:5,TrimEnd=true,TrimRoot=false,Tooth_a=30);
			cylinder(d=42, h=2.4, $fn=12);
		} // union
		
		translate([0,0,-Overlap]) cylinder(d=28, h=10);
	} // difference
} // CaseEnd38

// CaseEnd38();

module AftClosure38Protector(){
	Len=15;
	Thread_d=1.437*25.4+IDXtra*3;
	difference(){
		union(){
			cylinder(d=47, h=2.4, $fn=12);
			cylinder(d=44, h=Len);
		} // union
		
		translate([0,0,6.5])
			ExternalThread(Pitch=25.4/24, Dia_Nominal=Thread_d, Length=9, Step_a=$preview? 20:5,TrimEnd=true,TrimRoot=false,Tooth_a=30);
		
		translate([0,0,-Overlap]) cylinder(d=28, h=Len+Overlap*2);
		translate([0,0,2.5]) cylinder(d=Thread_d, h=6);
		translate([0,0,Len-2]) cylinder(d=Thread_d, h=6);
	} // difference

} // AftClosure38Protector

// 
AftClosure38Protector();


































