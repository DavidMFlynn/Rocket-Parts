// ***********************************
// Project: 3D Printed Rocket
// Filename: TransitionLib.scad
// by David M. Flynn
// Created: 11/12/2023 
// Revision: 0.9.0  11/12/2023 
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  A transition piece with fillets
//
//  ***** History *****
//
module TransitionLib_Rev(){
	echo("TransitionLib Rev 0.9.0");
}
TransitionLib_Rev();
// 0.9.0  11/12/2023  First Code
//
// ***********************************
//  ***** for STL output *****
//*
Vinyl_t=0.5;
Transition(
				Ratio=3.5, 				// Angle of transition
				OD1=BT98Body_OD+Vinyl_t, 		// Lower Body OD, Must be large end
				OD2=BT75Body_OD+Vinyl_t, 		// Upper Body OD
				C1_OD=BT98Body_ID-IDXtra*2, 	// Lower Coupler OD
				C1_ID=BT98Body_ID-IDXtra*2-4.4, 	// Lower Coupler ID and Center Hole (can be 0, solid)
				C1_Len=15, 				// Lower Coupler Length (can be 0)
				C2_OD=BT75Body_ID-IDXtra*2,	// Upper Coupler OD
				C2_ID=BT75Body_ID-IDXtra*2-4.4, 	// Upper Coupler ID and Center Hole (can be 0, solid)
				C2_Len=15				// Upper Coupler Length (can be 0)
								);
/**/
//
// ***********************************
include<TubesLib.scad>

$fn=$preview? 24:90;
IDXtra=0.2;
Overlap=0.05;

module Transition(
				Ratio=2.5, 				// Angle of transition
				OD1=BT98Body_OD, 		// Lower Body OD, Must be large end
				OD2=BT75Body_OD, 		// Upper Body OD
				C1_OD=BT98Coupler_OD, 	// Lower Coupler OD
				C1_ID=BT98Coupler_ID, 	// Lower Coupler ID and Center Hole (can be 0, solid)
				C1_Len=15, 				// Lower Coupler Length (can be 0)
				C2_OD=BT75Coupler_OD,	// Upper Coupler OD
				C2_ID=BT75Coupler_ID, 	// Upper Coupler ID and Center Hole (can be 0, solid)
				C2_Len=15				// Upper Coupler Length (can be 0)
								){
		
	R=OD1/8;
	Shoulder_Len=10;
	Len=(OD1-OD2)/2*Ratio;
	a=asin(1/Ratio);
	Y_Offset=R*cos(a); // 0.866
	X_Offset=R*sin(a); // 0.5
	
	// Top Shoulder
	difference(){
		union(){
			translate([0,0,Len+Shoulder_Len-Overlap]) cylinder(d=C2_OD, h=C2_Len, $fn=$preview? 90:360);
			translate([0,0,Len]) cylinder(d=OD2, h=Shoulder_Len, $fn=$preview? 90:360);
		} // union
		
		translate([0,0,Len-Overlap]) cylinder(d=C2_ID, h=C2_Len+Shoulder_Len+Overlap*2, $fn=$preview? 90:360);
	} // difference
	
	// Top Fillet
	difference(){
		translate([0,0,Len-X_Offset]) cylinder(d=OD2+X_Offset, h=X_Offset, $fn=$preview? 90:360);
	
		translate([0,0,Len]) rotate_extrude($fn=$preview? 90:360) 
			translate([OD2/2+R,0,0]) circle(r=R, $fn=$preview? 90:360);
		translate([0,0,Len-X_Offset-Overlap]) 
			cylinder(d=C2_ID, h=X_Offset+C2_Len+Shoulder_Len+Overlap*2, $fn=$preview? 90:360);
	} // difference
	
	// Bottom Fillet and  Transition
	difference(){
		hull(){
			rotate_extrude($fn=$preview? 90:360) translate([OD1/2-R,0,0]) circle(r=R, $fn=$preview? 90:360);
			translate([0,0,Len-X_Offset]) cylinder(r=OD2/2+R-Y_Offset, h=Overlap, $fn=$preview? 90:360);
		} // hull
		
		//Remove bottom of rotate_extrude()...
		translate([0,0,-R-Overlap]) cylinder(d=OD1+Overlap, h=R+Overlap, $fn=$preview? 90:360);
		
		// Remove inside
		translate([0,0,-Overlap]) cylinder(d1=C1_ID, d2=C2_ID, h=Len-R/2, $fn=$preview? 90:360);
		translate([0,0,Len-R/2-Overlap*2]) cylinder(d=C2_ID, h=R/2+Overlap*4, $fn=$preview? 90:360);
		
		//cube([OD1,OD1,Len]);
	} // difference
	
	// Bottom Shoulder
	difference(){
		union(){
			translate([0,0,-Shoulder_Len]) cylinder(d=OD1, h=Shoulder_Len, $fn=$preview? 90:360);
			translate([0,0,-Shoulder_Len-C1_Len]) cylinder(d=C1_OD, h=C1_Len, $fn=$preview? 90:360);
		} // union
		
		translate([0,0,-Shoulder_Len-C1_Len-Overlap]) 
			cylinder(d=C1_ID, h=C1_Len+Shoulder_Len+Overlap*2, $fn=$preview? 90:360);
	} // difference
	
} // Transition

//Transition();


















