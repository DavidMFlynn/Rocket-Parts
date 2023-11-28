// ***********************************
// Project: 3D Printed Rocket
// Filename: SpringEndsLib.scad
// by David M. Flynn
// Created: 11/24/2023 
// Revision: 1.0.0  11/24/2023
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  ***** History *****
// 1.0.0  11/24/2023  Moved parts here from varius rockets
//
// ***********************************
//  ***** for STL output *****
//
// SE_Tri_Spring_Slider(OD=BT137Coupler_OD, ID=BT137Coupler_ID);
// SE_Tri_Spring_End(OD=BT137Body_ID-5, Rope_BC_r=BT137Coupler_ID/2-5);
// SE_EBaySpringStop(OD=BT54Body_ID);
//
// ***********************************
//  ***** Routines *****
//
function SE_Spring_CS4009_OD()=Spring_CS4009_OD;
function SE_Spring_CS4009_ID()=Spring_CS4009_ID;
function SE_Spring_CS4323_OD()=Spring_CS4323_OD;
function SE_Spring_CS4323_ID()=Spring_CS4323_ID;
//
// ***********************************
//  ***** for Viewing *****
//
//
// ***********************************
include<TubesLib.scad>
include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

// Big Spring
Spring_CS4009_OD=2.328*25.4;
Spring_CS4009_ID=2.094*25.4;
Spring_CS4009_FL=18.5*25.4;
Spring_CS4009_CL=1.64*25.4;
// Small Spring
Spring_CS4323_OD=44.30;
Spring_CS4323_ID=40.50;
Spring_CS4323_CBL=22; // coil bound length
Spring_CS4323_FL=200; // free length


module SE_Tri_Spring_Slider(OD=BT137Coupler_OD, ID=BT137Coupler_ID){
	nRopes=6;
	CR_h=5;
	Len=Spring_CS4323_CBL*2+CR_h;
	SS_Y=Spring_CS4323_OD*0.707;
 
	Tube(OD=OD, ID=ID, Len=Len,  myfn=$preview? 90:360);
	
	for (j=[0:2]) rotate([0,0,120*j]) translate([0,SS_Y,0]){
		Tube(OD=Spring_CS4323_OD+5.6, ID=Spring_CS4323_OD+1.2, Len=Len,  myfn=$preview? 90:360);
		translate([0,0,Len/2-10])
			Tube(OD=Spring_CS4323_OD+4, ID=Spring_CS4323_OD, Len=20,  myfn=$preview? 90:360);
			
		translate([0,0,Len/2-CR_h/2])
			Tube(OD=Spring_CS4323_OD+4, ID=Spring_CS4323_ID, Len=CR_h,  myfn=$preview? 90:360);
		}
 
	difference(){
		
		cylinder(d1=OD-1, d2=20, h=Len);
		translate([0,0,-3]) cylinder(d1=OD-1, d2=20, h=Len);
		
		
		for (j=[0:2]) rotate([0,0,120*j]) translate([0,SS_Y,-Overlap])
			cylinder(d=Spring_CS4323_OD+2, h=Len+Overlap*2);
			
		for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*(j+0.5)]) translate([0,OD/2-5,-Overlap])
			cylinder(d=4, h=Len+Overlap*2);
	} //difference
} // SE_Tri_Spring_Slider

// SE_Tri_Spring_Slider();

module SE_Tri_Spring_End(OD=BT137Body_ID-5, Rope_BC_r=BT137Coupler_ID/2-5){
	nRopes=6;
	SS_Y=Spring_CS4323_OD*0.707;
	CR_h=5;
	Len=Spring_CS4323_CBL+CR_h;
	
	for (j=[0:2]) rotate([0,0,120*j]) translate([0,SS_Y,0])
		Tube(OD=Spring_CS4323_ID, ID=Spring_CS4323_ID-4.4, Len=Len,  myfn=$preview? 90:360);
		
	difference(){
		cylinder(d=OD, h=CR_h);
		
		// Retention cord
		for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*(j+0.5)]) 
			translate([0,Rope_BC_r,-10]) cylinder(d=4, h=30);
			
		for (j=[0:2]) rotate([0,0,120*j]) translate([0,SS_Y,-Overlap])
			cylinder(d=Spring_CS4323_ID-4.4, h=Len);
	} // difference	
	
} // SE_Tri_Spring_End

// SE_Tri_Spring_End();

module SE_EBaySpringStop(OD=BT54Body_ID){
	Al_Tube_d=12.7;
	Al_Tube_Z=20;
	Len=40;
	
	difference(){
		union(){
			Tube(OD=OD, ID=SE_Spring_CS4323_ID(), Len=Len, myfn=$preview? 36:360);
			
			
			translate([0,0,Al_Tube_Z]) rotate([90,0,0]) 
				cylinder(d=Al_Tube_d+7, h=OD-6+Overlap, center=true);
		} // union
		
		translate([0,0,Al_Tube_Z]) rotate([90,0,0]) {
			cylinder(d=Al_Tube_d+IDXtra, h=OD+1, center=true);
			cylinder(d=Al_Tube_d+8, h=20, center=true);
		}
		
		translate([0,0,Al_Tube_Z+Al_Tube_d/2+4]) {
			cylinder(d=SE_Spring_CS4323_OD(), h=5);
			translate([0,0,4]) cylinder(d1=SE_Spring_CS4323_OD(), d2=SE_Spring_CS4323_OD()+4, h=6);
			}
	} // difference
	
} // SE_EBaySpringStop

// SE_EBaySpringStop(OD=BT54Body_ID);
































