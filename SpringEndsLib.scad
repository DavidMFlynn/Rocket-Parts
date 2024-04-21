// ***********************************
// Project: 3D Printed Rocket
// Filename: SpringEndsLib.scad
// by David M. Flynn
// Created: 11/24/2023 
// Revision: 1.0.7  4/21/2024
// Units: mm
// ***********************************
//  ***** Notes *****
// This is a collection of spring ends used for non-pyro deployment.
//
//  ***** History *****
function SpringEndsLibRev()="SpringEndsLib Rev. 1.0.7";
echo(SpringEndsLibRev());
// 1.0.7  4/21/2024   Removed MotorCoupler_OD param from SE_SpringEndTypeA
// 1.0.6  3/31/2024   Added SE_SpringTop()
// 1.0.5  3/28/2024   Added SE_SlidingBigSpringMiddle()
// 1.0.4  1/28/2024	  Added parameter Al_Tube_Z to SE_EBaySpringStop
// 1.0.3  12/30/2023  Added params to SE_SlidingSpringMiddle()
// 1.0.2  12/24/2023  Added SE_SpringEndTop,SE_SpringEndBottom from Rocket75C
// 1.0.1  12/13/2023  added SE_SlidingSpringMiddle,SE_SpringSpacer
// 1.0.0  11/24/2023  Moved parts here from varius rockets
//
// ***********************************
//  ***** for STL output *****
//
// SE_Tri_Spring_Slider(OD=BT137Coupler_OD, ID=BT137Coupler_ID);
// SE_Tri_Spring_End(OD=BT137Body_ID-5, Rope_BC_r=BT137Coupler_ID/2-5);
// SE_EBaySpringStop(OD=BT54Body_ID, Al_Tube_Z=20);
//
// SE_SpringEndTypeA(Coupler_OD=BT75Coupler_OD, Coupler_ID=BT75Coupler_ID, nRopes=3);
//		An end for Spring_CS4323.
// 		Requires a short piece of coupler tube.
//
// SE_SpringEndTypeB(Coupler_OD=BT75Coupler_OD, MotorCoupler_OD=BT54Coupler_OD, nRopes=3);
//
// SE_SlidingBigSpringMiddle(OD=BT137Coupler_OD, SliderLen=75, Extension=20);
// SE_SlidingSpringMiddle(OD=BT98Coupler_OD, nRopes=6, SliderLen=40, SpLen=40, SpringStop_Z=20);
// SE_SlidingSpringMiddle(OD=BT75Coupler_OD, nRopes=3);
//
// SE_SpringSpacer(OD=BT75Coupler_OD, Tube_ID=BT75Coupler_ID, Len=70);
//
// SE_SpringTop(OD=BT98Coupler_OD, Piston_Len=50, nRopes=6);
// SE_SpringEndTop(OD=BT75Coupler_OD, Tube_ID=BT75Coupler_OD-2.4, nRopeHoles=5);
// SE_SpringEndBottom(OD=BT75Coupler_OD, Tube_ID=BT75Coupler_OD-2.4, nRopeHoles=5, CutOutCenter=false);
// SE_SpringEndBottom(OD=BT75Coupler_OD, Tube_ID=BT75Coupler_OD-2.4, nRopeHoles=5, CutOutCenter=true);
//
// ***********************************
//  ***** Routines *****
//
function SE_Spring_CS4009_OD()=Spring_CS4009_OD;
function SE_Spring_CS4009_ID()=Spring_CS4009_ID;
function SE_Spring_CS4323_OD()=Spring_CS4323_OD;
function SE_Spring_CS4323_ID()=Spring_CS4323_ID;
function SE_Spring_CS11890_OD()=Spring_CS11890_OD;
function SE_Spring_CS11890_ID()=Spring_CS11890_ID;
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

// Bigger Spring
Spring_CS11890_OD=70.5;
Spring_CS11890_ID=64.7;
Spring_CS11890_FL=225;
Spring_CS11890_CL=33;

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



module SE_SpringTop(OD=BT98Coupler_OD, Piston_Len=50, nRopes=6){
	ST_DSpring_OD=Spring_CS4323_OD;

	translate([0,0,-10]) Tube(OD=OD, ID=OD-4.4, Len=Piston_Len, myfn=$preview? 90:360);
	
	difference(){
		union(){
			cylinder(d=ST_DSpring_OD+10, h=10+Overlap);
			translate([0,0,10]) cylinder(d=OD, h=5+Overlap);
		} // union
		
		translate([0,0,-Overlap]) cylinder(d1= ST_DSpring_OD+5, d2=ST_DSpring_OD, h=10);
		cylinder(d= ST_DSpring_OD, h=13);
		cylinder(d= ST_DSpring_OD-6, h=20);
		for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j]) translate([0,OD/2-7,-Overlap])
			cylinder(d=4,h=Piston_Len+Overlap*2);
	} // difference
} // SE_SpringTop

// SE_SpringTop();

module SE_BigSpringReceiver(OD=BT137Coupler_ID, Len=75, Spring_Z=10){
	Wall_t=4;
	Base_t=4;
	nRopes=6;
	Rope_d=4;
	RopeInset=5;
	Sping_OD=Spring_CS11890_OD;
	Sping_ID=Spring_CS11890_ID;
	
	difference(){
		union(){
			cylinder(d=Sping_OD+Wall_t*2, h=Len);
			cylinder(d=OD, h=Base_t);
		} // union
		
		// Rope holes
		for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j])
			translate([0,OD/2-RopeInset,-Overlap]) cylinder(d=Rope_d, h=Base_t+Overlap*2);
			
		//Pass Thru
		translate([0,0,-Overlap]) cylinder(d=Sping_ID-1, h=Len+Overlap*2);
		
		translate([0,0,Spring_Z]) cylinder(d=Sping_OD, h=10);
		translate([0,0,Spring_Z+4-Overlap]) cylinder(d=Sping_OD+1, h=Len);
		translate([0,0,Len-10]) cylinder(d1=Sping_OD+1, d2=Sping_OD+4, h=10+Overlap);
	} // difference
} // SE_BigSpringReceiver

// SE_BigSpringReceiver(OD=BT137Coupler_ID, Len=40, Spring_Z=20);

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

module SE_EBaySpringStop(OD=BT54Body_ID, Al_Tube_Z=20){
	Al_Tube_d=12.7;
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
			translate([0,0,4]) cylinder(d1=SE_Spring_CS4323_OD(), d2=SE_Spring_CS4323_OD()+2, h=6);
			translate([0,0,4+6-Overlap]) cylinder(d=SE_Spring_CS4323_OD()+2,h=Len);
			}
	} // difference
	
} // SE_EBaySpringStop

// SE_EBaySpringStop(OD=BT54Body_ID, Al_Tube_Z=10);

module SE_SpringEndTypeA(Coupler_OD=BT75Coupler_OD, Coupler_ID=BT75Coupler_ID, nRopes=3){
// Glues to a short section of coupler tube
// Requires a short piece of coupler tube

	Spring_OD=Spring_CS4323_OD;
	
	difference(){
		union(){
			cylinder(d=Spring_OD+8, h=10+Overlap);
			
			translate([0,0,10]) cylinder(d=Coupler_OD, h=2+Overlap);
			translate([0,0,10]) cylinder(d=Coupler_ID-1, h=7+Overlap);
			//translate([0,0,10]) Tube(OD=Coupler_ID-1, ID=Coupler_ID-6, Len=10, myfn=$preview? 36:360);
		} // union
		
		translate([0,0,-Overlap]) cylinder(d1= Spring_OD+4, d2=Spring_OD, h=10);
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

module SE_SlidingBigSpringMiddle(OD=BT137Coupler_OD, SliderLen=75, Extension=20){
	Wall_t=1.8;
	Spring_OD=Spring_CS11890_OD;
	Hub_OD=Spring_OD+8;
	nRibs=6;
	SpringSocket_H=15;
	SpringSocketFlange_H=2;
	
	// Outside tube
	Tube(OD=OD, ID=OD-Wall_t*2, 
			Len=SliderLen, myfn=$preview? 90:360);
			
	// Outside spring tube
	Tube(OD=Hub_OD, ID=Hub_OD-Wall_t*2, 
			Len=SliderLen+Extension, myfn=$preview? 90:360);
			
	// Ribs
	for (j=[0:nRibs-1]) rotate([0,0,360/nRibs*j]) hull(){
		translate([-Wall_t/2, Hub_OD/2-Wall_t+Overlap, 0]) cube([Wall_t,Overlap,SliderLen]);
		translate([-Wall_t/2, OD/2-Wall_t/2, 0]) cube([Wall_t,Overlap,SliderLen]);
	} // hull
	
	module SpringSocket(){
		Flange_d=8;
		difference(){
			cylinder(d=Hub_OD, h=SpringSocket_H+SpringSocketFlange_H+Flange_d);
		
			translate([0,0,SpringSocket_H+SpringSocketFlange_H-Overlap])
				cylinder(d1=Spring_OD-Flange_d, d2=Hub_OD-Wall_t*2, h=Flange_d+Overlap*2);
				
			translate([0,0,-Overlap]) 
				cylinder(d=Spring_OD-Flange_d, h=SpringSocket_H+SpringSocketFlange_H+Overlap*2);
				
			translate([0,0,-Overlap]) cylinder(d=Spring_OD, h=SpringSocket_H);
			translate([0,0,-Overlap]) cylinder(d1=Hub_OD-Wall_t*2, d2=Spring_OD, h=SpringSocket_H-6);
		} // difference
	} // SpringSocket
	
	SpringSocket();
	translate([0,0,SliderLen+Extension]) rotate([180,0,0]) SpringSocket();
} // SE_SlidingBigSpringMiddle

// SE_SlidingBigSpringMiddle();


module SE_SlidingSpringMiddle(OD=BT98Coupler_OD, nRopes=6, SliderLen=40, SpLen=40, SpringStop_Z=20){
// costom version of ST_SpringMiddle()

	Spring_OD=Spring_CS4323_OD;
	Spring_ID=Spring_CS4323_ID;
	
	// Outside spring tube
	Tube(OD=Spring_OD+IDXtra*3+4.4, ID=Spring_OD+IDXtra*3, 
			Len=SpLen, myfn=$preview? 90:360);
			
	// Inside spring tube
	Tube(OD=Spring_ID-0.5, ID=Spring_ID-0.5-4.4, 
			Len=SpLen, myfn=$preview? 90:360);
			
	// Spring stop
	translate([0,0,SpringStop_Z-1.5]) Tube(OD=Spring_OD+1, ID=Spring_ID-1, 
			Len=3, myfn=$preview? 90:360);
		
	// Sliding tube
	Tube(OD=OD, ID=OD-4.4, Len=SliderLen, myfn=$preview? 90:360);
	
	
	ConeLen=OD/3;
	difference(){
		cylinder(d1=OD-1, d2=Spring_OD+1, h=ConeLen);
		
		translate([0,0,-3]) cylinder(d1=OD-1, d2=Spring_OD+1, h=ConeLen);
		translate([0,0,-Overlap]) cylinder(d=Spring_OD+1, h=ConeLen+Overlap*2);
		
		if (nRopes>0)
		for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j]) translate([0,OD/2-7,-Overlap])
			cylinder(d=10,h=SliderLen);
	} // difference

} // SE_SlidingSpringMiddle

//SE_SlidingSpringMiddle(OD=BT98Coupler_OD, nRopes=6, SliderLen=40, SpLen=40, SpringStop_Z=20);
//SE_SlidingSpringMiddle(OD=BT75Coupler_OD, nRopes=3);

module SE_SpringSpacer(OD=BT75Coupler_OD, Tube_ID=BT75Coupler_ID, Len=70){
	Tube(OD=OD, ID=Tube_ID, Len=Len, myfn=$preview? 36:360);
} // SE_SpringSpacer

//SE_SpringSpacer();


module SE_SpringEndTop(OD=BT75Coupler_OD, Tube_ID=BT75Coupler_OD-2.4, nRopeHoles=3, CutOutCenter=false){
	Spring_OD=Spring_CS4323_OD;
	Spring_ID=Spring_CS4323_ID;
	Piston_h=15;
	Len=30;
	Plate_t=3;
	
	//echo(OD=OD);
	
	module SCH(){
		hull(){
			translate([-6,0,-Overlap]) cylinder(d=3, h=Plate_t+Overlap*2);
			translate([6,0,-Overlap]) cylinder(d=3, h=Plate_t+Overlap*2);
		} // hull
	} // SCH
	
	difference(){
		union(){
			Tube(OD=OD, ID=Tube_ID, Len=Len, myfn=$preview? 36:360);
			
			translate([0,0,Len-Piston_h]) cylinder(d=OD-1, h=Piston_h);
			
			// Spring
			translate([0,0,8]) Tube(OD=Spring_OD+10, ID=Spring_OD, Len=12, myfn=$preview? 36:360);
		} // union
		
		if (CutOutCenter) cylinder(d=Spring_ID, h=Len);
		
		// Rope Holes
		Rope_d=4;
		for (j=[0:nRopeHoles-1]) rotate([0,0,360/nRopeHoles*j]) translate([0,Spring_OD/2+Rope_d/2+6,0])
			cylinder(d=Rope_d, h=Len);
		
		// Top dish
		translate([0,0,Len-Piston_h+3+Plate_t]) 
			cylinder(d1=Tube_ID-20, d2=Tube_ID-2, h=Piston_h-3-Plate_t+Overlap);
	
		// Spring
		cylinder(d=Spring_OD, h=Len-Piston_h+3);
		cylinder(d1=Spring_OD+5, d2=Spring_OD, h=Len-Piston_h);
		
		// Shock Cord
		translate([0,0,Len-Piston_h+3]) SCH();
		//translate([0,0,-Overlap]) cylinder(d=5, h=Len);
		
		// Air Vents
		nVents=8;
		Vent_d=9;
		for (j=[0:nVents-1]) rotate([0,0,360/nVents*j]) translate([0,Spring_OD/2-Vent_d/2-2,0])
			cylinder(d=Vent_d, h=Len);
	} // difference
	

} // SE_SpringEndTop

//SE_SpringEndTop(OD=BT75Coupler_OD, Tube_ID=BT75Coupler_OD-2.4, nRopeHoles=5, CutOutCenter=true);

module SE_SpringEndBottom(OD=BT75Coupler_OD, Tube_ID=BT75Coupler_OD-2.4, nRopeHoles=3, CutOutCenter=false){
	Spring_OD=Spring_CS4323_OD;
	Spring_ID=Spring_CS4323_ID;
	Piston_h=15;
	Len=30;
	Plate_t=3;
	Rope_d=4;
	Rope_Y=CutOutCenter? OD/2-7:Spring_OD/2+Rope_d/2+2;
	
	module SCH(){
		hull(){
			translate([-6,0,-Overlap]) cylinder(d=3, h=Plate_t+4);
			translate([6,0,-Overlap]) cylinder(d=3, h=Plate_t+4);
		} // hull
	} // SCH
	
	difference(){
		union(){
			Tube(OD=OD, ID=Tube_ID, Len=Len, myfn=$preview? 36:360);
			
			cylinder(d=OD-1, h=Piston_h);
		} // union
		
		if (CutOutCenter) cylinder(d=Spring_ID, h=Len);
		
		// Rope Holes
		
		for (j=[0:nRopeHoles-1]) rotate([0,0,360/nRopeHoles*j]) translate([0,Rope_Y,-Overlap])
			cylinder(d=Rope_d, h=Len);
		
		// Top dish
		translate([0,0,3+Plate_t]) 
			cylinder(d1=Tube_ID-20, d2=Tube_ID, h=Piston_h-3-Plate_t+Overlap);
	
		// Spring
		translate([0,0,-Overlap]) cylinder(d=Spring_OD, h=3);
		
		// Shock Cord
		SCH();
		//translate([0,0,-Overlap]) cylinder(d=5, h=10);
		
		// Air Vents
		nVents=8;
		Vent_d=9;
		for (j=[0:nVents-1]) rotate([0,0,360/nVents*j]) translate([0,Spring_OD/2-Vent_d/2-2,0])
			cylinder(d=Vent_d, h=Len);
	} // difference
	
} // SE_SpringEndBottom

//SE_SpringEndBottom(OD=BT75Coupler_OD, Tube_ID=BT75Coupler_OD-2.4, nRopeHoles=5, CutOutCenter=true);





















