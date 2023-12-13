// ***********************************
// Project: 3D Printed Rocket
// Filename: SpringEndsLib.scad
// by David M. Flynn
// Created: 11/24/2023 
// Revision: 1.0.1  12/13/2023
// Units: mm
// ***********************************
//  ***** Notes *****
// This is a collection of spring ends used for non-pyro deployment.
//
//  ***** History *****
// 1.0.1  12/13/2023  added SE_SlidingSpringMiddle,SE_SpringSpacer
// 1.0.0  11/24/2023  Moved parts here from varius rockets
//
// ***********************************
//  ***** for STL output *****
//
// SE_Tri_Spring_Slider(OD=BT137Coupler_OD, ID=BT137Coupler_ID);
// SE_Tri_Spring_End(OD=BT137Body_ID-5, Rope_BC_r=BT137Coupler_ID/2-5);
// SE_EBaySpringStop(OD=BT54Body_ID);
//
// SE_SpringEndTypeA(Coupler_OD=BT75Coupler_OD, Coupler_ID=BT75Coupler_ID, MotorCoupler_OD=BT54Coupler_OD, nRopes=3);
//		An end for Spring_CS4323.
// 		Sits in the top of the motor tube.
// 		Requires a short piece of coupler tube.
//
// SE_SpringEndTypeB(Coupler_OD=BT75Coupler_OD, MotorCoupler_OD=BT54Coupler_OD, nRopes=3);
//
// SE_SlidingSpringMiddle(OD=BT98Coupler_OD, nRopes=6);
// SE_SlidingSpringMiddle(OD=BT75Coupler_OD, nRopes=3);
//
// SE_SpringSpacer(OD=BT75Coupler_OD, Tube_ID=BT75Coupler_ID, Len=70);
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

module SE_SpringEndTypeA(Coupler_OD=BT75Coupler_OD, Coupler_ID=BT75Coupler_ID, MotorCoupler_OD=BT54Coupler_OD,
				nRopes=3){
// Sits in the top of the motor tube
// Requires a short piece of coupler tube

	Spring_OD=Spring_CS4323_OD;
	
	difference(){
		union(){
			cylinder(d=MotorCoupler_OD, h=10+Overlap);
			
			translate([0,0,10]) cylinder(d=Coupler_OD, h=2+Overlap);
			translate([0,0,10]) cylinder(d=Coupler_ID-1, h=7+Overlap);
			//translate([0,0,10]) Tube(OD=Coupler_ID-1, ID=Coupler_ID-6, Len=10, myfn=$preview? 36:360);
		} // union
		
		translate([0,0,-Overlap]) cylinder(d1= MotorCoupler_OD-4.4, d2=Spring_OD, h=10);
		cylinder(d= Spring_OD, h=13);
		cylinder(d= Spring_OD-6, h=20);
		
		// Retention cord
		if (nRopes>0) 
			for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j]) 
				translate([Coupler_ID/2-5,0,0]) cylinder(d=4, h=30);
	} // difference
} // SE_SpringEndTypeA

//rotate([180,0,0]) SE_SpringEndTypeA();

module SE_SpringEndTypeB(Coupler_OD=BT75Coupler_OD, MotorCoupler_OD=BT54Coupler_OD,
				nRopes=3){
				
	Len=12;
// Sits in the top of the motor tube


	Spring_OD=Spring_CS4323_OD;
	Spring_ID=Spring_CS4323_ID;
	
	difference(){
		union(){
			cylinder(d=MotorCoupler_OD, h=Len);
			
			cylinder(d=Coupler_OD, h=3);
			cylinder(d=MotorCoupler_OD+6, h=7);
			//translate([0,0,10]) cylinder(d=Coupler_ID-1, h=7+Overlap);
			//translate([0,0,10]) Tube(OD=Coupler_ID-1, ID=Coupler_ID-6, Len=10, myfn=$preview? 36:360);
		} // union
		
		translate([0,0,-Overlap]) cylinder(d1= MotorCoupler_OD-4.4, d2=Spring_OD, h=Len-6);
		cylinder(d= Spring_OD, h=Len-2);
		cylinder(d= Spring_ID, h=Len+1);
		
		// Retention cord
		if (nRopes>0) 
			for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j]) 
				translate([Coupler_OD/2-6,0,-Overlap]) cylinder(d=4, h=Len);
	} // difference
} // SE_SpringEndTypeB

//SE_SpringEndTypeB();

module SE_SlidingSpringMiddle(OD=BT98Coupler_OD, nRopes=6){
// costom version of ST_SpringMiddle()

	Spring_OD=Spring_CS4323_OD;
	Spring_ID=Spring_CS4323_ID;
	Len=40;
	
	// Outside spring tube
	Tube(OD=Spring_OD+IDXtra*3+4.4, ID=Spring_OD+IDXtra*3, 
			Len=Len, myfn=$preview? 90:360);
			
	// Inside spring tube
	Tube(OD=Spring_ID-0.5, ID=Spring_ID-0.5-4.4, 
			Len=Len, myfn=$preview? 90:360);
			
	// Spring stop
	translate([0,0,Len/2-1.5]) Tube(OD=Spring_OD+1, ID=Spring_ID-1, 
			Len=3, myfn=$preview? 90:360);
		
	// Sliding tube
	Tube(OD=OD, ID=OD-4.4, Len=35, myfn=$preview? 90:360);
	
	
	ConeLen=OD/3;
	difference(){
		cylinder(d1=OD-1, d2=Spring_OD+1, h=ConeLen);
		
		translate([0,0,-3]) cylinder(d1=OD-1, d2=Spring_OD+1, h=ConeLen);
		translate([0,0,-Overlap]) cylinder(d=Spring_OD+1, h=ConeLen+Overlap*2);
		
		if (nRopes>0)
		for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j]) translate([0,OD/2-7,-Overlap])
			cylinder(d=10,h=Len);
	} // difference

} // SE_SlidingSpringMiddle

//SE_SlidingSpringMiddle(OD=BT98Coupler_OD, nRopes=6);
//SE_SlidingSpringMiddle(OD=BT75Coupler_OD, nRopes=3);

module SE_SpringSpacer(OD=BT75Coupler_OD, Tube_ID=BT75Coupler_ID, Len=70){
	Tube(OD=OD, ID=Tube_ID, Len=Len, myfn=$preview? 36:360);
} // SE_SpringSpacer

//SE_SpringSpacer();





















