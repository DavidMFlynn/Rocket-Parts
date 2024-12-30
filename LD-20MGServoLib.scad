// **************************************************
// LD-20MG Servo Library
// David M. Flynn
// Filename: LD-20MGServoLib.scad
// Created: 7/16/2018
// Rev: 1.2.3  4/27/2023
// Units: millimeters
// **************************************************
// History:
	echo("LD-20MGServoLib 1.2.2");
// 1.2.3 4/27/2023  Added ServoHX5010TopBlock
// 1.2.2 8/24/2020	Added Xtra_h=0, range is -2..lots to ServoTray_HX5010_2
// 1.2.1 12/16/2019	ServoTray_HX5010_2(); for tight spaces
// 1.2.0 12/15/2019	added ServoTray_HX5010(UseH_Slots=false) and ServoTray_HX5010Holes(UseH_Slots=false)
// 1.1.1 9/29/2019 Added extra width and height to Servo_HX5010
// 1.1.0 9/27/2019 Added HX5010 servo
// 1.0.0 7/16/2018 Coppied from HS-5245MGServoLib.scad
// **************************************************
// Notes:
//  Mounting of R/C mini servo HS-5245MG.
//  ToDo: Servo wheel needs adjusting.
// **************************************************
//  ***** for STL output *****
// rotate([90,0,0]) ServoTray_HX5010(Xtra_h=0, UseH_Slots=false);
// rotate([90,0,0]) ServoTray_HX5010_2(Xtra_h=2, UseH_Slots=false);
// **************************************************
// Routines
//	Servo_LD20MG(BottomMount=false,TopAccess=false);
//  Servo_HX5010(BottomMount=false,TopAccess=false,Xtra_w=1.2, Xtra_h=1);
//  ServoHX5010TopBlock(Xtra_Len=4, Xtra_Width=4, Xtra_Height=0);
//  ServoTray_HX5010Holes(UseH_Slots=false) Bolt4Hole();
//	LD20MGServoWheel();
// **************************************************

include<CommonStuffSAEmm.scad>

$fn=90;

module Servo_LD20MG(BottomMount=true,TopAccess=true){
	Servo_Shaft_Offset=9.85; // this moves double
	Servo_BoltSpace=10;
	Servo_BoltSpace2=49.4;
	Servo_x=54.5;
	Servo_h1=28.2; // bottom of servo to bottom of mount
	Servo_w=20.2;
	Servo_Body_l=40.5;
	Servo_Deck_h=3.2;
	Servo_TopStep_h=9.7;
	Servo_TopOfWheel=21.4;
	
	translate([-Servo_Shaft_Offset,0,0]){
	// body
	if (BottomMount==true){
		translate([-Servo_x/2,-Servo_w/2,-Servo_h1]) cube([Servo_x,Servo_w,Servo_h1+Overlap]);
	} else{
		translate([-Servo_Body_l/2,-Servo_w/2,-Servo_h1]) cube([Servo_Body_l,Servo_w,Servo_h1+Overlap]);
	}
	
	// top
	if (BottomMount==true){
		translate([-Servo_x/2,-Servo_w/2,0]) cube([Servo_x,Servo_w,Servo_Deck_h+Overlap]);
		translate([-Servo_Body_l/2,-Servo_w/2,Servo_Deck_h]) cube([Servo_Body_l, Servo_w, Servo_TopStep_h+Overlap]);
		// gussets
		hull(){
			translate([-Servo_x/2,-0.8,Servo_Deck_h]) cube([Servo_x,1.6,0.01]);
			translate([-Servo_Body_l/2,-0.8,Servo_Deck_h+2.4]) cube([Servo_Body_l,1.6,0.01]);
		} // hull
	} else
	if (TopAccess==true){
		translate([-Servo_x/2,-Servo_w/2,0]) cube([Servo_x, Servo_w, 19]);
	} else {
	translate([-Servo_x/2,-Servo_w/2,0]) cube([Servo_x, Servo_w, 14]);
	}
	
	// Bolt holes
	translate([-Servo_BoltSpace2/2,Servo_BoltSpace/2,0]) Bolt4Hole();
	translate([-Servo_BoltSpace2/2,-Servo_BoltSpace/2,0]) Bolt4Hole();
	translate([Servo_BoltSpace2/2,Servo_BoltSpace/2,0]) Bolt4Hole();
	translate([Servo_BoltSpace2/2,-Servo_BoltSpace/2,0]) Bolt4Hole();
		
	if (BottomMount==true){
		translate([-Servo_BoltSpace2/2,Servo_BoltSpace/2,0]) rotate([180,0,0]) Bolt4Hole(depth=20);
		translate([-Servo_BoltSpace2/2,-Servo_BoltSpace/2,0]) rotate([180,0,0]) Bolt4Hole(depth=20);
		translate([Servo_BoltSpace2/2,Servo_BoltSpace/2,0]) rotate([180,0,0]) Bolt4Hole(depth=20);
		translate([Servo_BoltSpace2/2,-Servo_BoltSpace/2,0]) rotate([180,0,0]) Bolt4Hole(depth=20);
	} else{
		translate([-Servo_BoltSpace2/2,Servo_BoltSpace/2,0]) Bolt4Hole();
		translate([-Servo_BoltSpace2/2,-Servo_BoltSpace/2,0]) Bolt4Hole();
		translate([Servo_BoltSpace2/2,Servo_BoltSpace/2,0]) Bolt4Hole();
		translate([Servo_BoltSpace2/2,-Servo_BoltSpace/2,0]) Bolt4Hole();
	}
	
	if (BottomMount==true){
		// servo wheel
		translate([Servo_Shaft_Offset,0,Servo_Deck_h+Servo_TopStep_h-Overlap])
			cylinder(d=21.3,h=Servo_TopOfWheel-Servo_Deck_h-Servo_TopStep_h+Overlap);
	} else {
		translate([Servo_Shaft_Offset,0,0]) cylinder(d=21.3,h=19.6);
	}
	translate([Servo_Shaft_Offset,0,0]) cylinder(d=9,h=30);
	translate([Servo_Shaft_Offset,14.5/2,19.6+6]) Bolt4HeadHole();
	translate([Servo_Shaft_Offset,-14.5/2,19.6+6]) Bolt4HeadHole();
	}
} // Servo_LD20MG

//Servo_LD20MG(BottomMount=false,TopAccess=false);

module ServoHX5010TopBlock(Xtra_Len=4, Xtra_Width=4, Xtra_Height=0){
	Servo_Shaft_Offset=9.4; // this moves double
	Servo_BoltSpace=10;
	Servo_BoltSpace2=49.4;
	Servo_x=54.75;
	Servo_h1=27.7; // bottom of servo to bottom of mount
	Servo_w=20.2;
	Servo_Body_l=41.0;
	Servo_Deck_h=2.6;
	Servo_TopStep_h=10.2;
	Servo_TopOfWheel=18.5;
	
	difference(){
		translate([Servo_Shaft_Offset-Servo_x/2-Xtra_Len/2, -Servo_w/2-Xtra_Width/2, Servo_TopStep_h]) 
			cube([Servo_x+Xtra_Len, Servo_w+Xtra_Width, Servo_TopStep_h+Xtra_Height]);
			
		// top rectangle
		translate([Servo_Shaft_Offset-Servo_Body_l/2, -Servo_w/2, Servo_TopStep_h-Overlap]) 
			cube([Servo_Body_l, Servo_w, Servo_TopStep_h+1]);
		
		translate([Servo_Shaft_Offset-Servo_BoltSpace2/2,Servo_BoltSpace/2,0]) 
			rotate([180,0,0]) Bolt4Hole();
		translate([Servo_Shaft_Offset-Servo_BoltSpace2/2,-Servo_BoltSpace/2,0]) 
			rotate([180,0,0]) Bolt4Hole();
		translate([Servo_Shaft_Offset+Servo_BoltSpace2/2,Servo_BoltSpace/2,0])
			rotate([180,0,0]) Bolt4Hole();
		translate([Servo_Shaft_Offset+Servo_BoltSpace2/2,-Servo_BoltSpace/2,0]) 
			rotate([180,0,0]) Bolt4Hole();
		
		cylinder(d=Servo_w, h=Servo_TopOfWheel);
		
		hull(){
			cylinder(d=6.35,h=11.5);
			translate([7,0,0])cylinder(d=6.35,h=11.5);
		}
	} // difference
} // ServoHX5010TopBlock

//ServoHX5010TopBlock();
//ServoHX5010TopBlock(Xtra_Len=0, Xtra_Width=2.4, Xtra_Height=6);

module Servo_HX5010(BottomMount=true,TopAccess=true,Xtra_w=0.2, Xtra_h=1, XtraTop=0){
	Servo_Shaft_Offset=9.4; // this moves double
	Servo_BoltSpace=10;
	Servo_BoltSpace2=49.4;
	Servo_x=54.75;
	Servo_h1=27.7; // bottom of servo to bottom of mount
	Servo_w=20.2;
	Servo_Body_l=41.0;
	Servo_Deck_h=2.6;
	Servo_TopStep_h=10.2;
	Servo_TopOfWheel=18.5;
	
	translate([-Servo_Shaft_Offset,0,0]){
	// body
	if (BottomMount==true){
		translate([-Servo_x/2,-Servo_w/2-Xtra_w/2,-Servo_h1-Xtra_h]) cube([Servo_x,Servo_w+Xtra_w,Servo_h1+Xtra_h+Overlap]);
	} else{
		translate([-Servo_Body_l/2,-Servo_w/2-Xtra_w/2,-Servo_h1-Xtra_h]) cube([Servo_Body_l,Servo_w+Xtra_w,Servo_h1+Xtra_h+Overlap]);
	}
	
	// top
	if (BottomMount==true){
		translate([-Servo_x/2,-Servo_w/2-Xtra_w/2,0]) cube([Servo_x,Servo_w+Xtra_w,Servo_Deck_h+Overlap]);
		translate([-Servo_Body_l/2,-Servo_w/2-Xtra_w/2,Servo_Deck_h]) cube([Servo_Body_l,Servo_w+Xtra_w, Servo_TopStep_h+XtraTop+Overlap]);
		// gussets
		hull(){
			translate([-Servo_x/2,-0.8,Servo_Deck_h])cube([Servo_x,1.6,0.01]);
			translate([-Servo_Body_l/2,-0.8,Servo_Deck_h+2.4])cube([Servo_Body_l,1.6,0.01]);
		} // hull
	} else
	if (TopAccess==true){
		translate([-Servo_x/2,-Servo_w/2-Xtra_w/2,0]) cube([Servo_x,Servo_w+Xtra_w,19]);
	} else {
		translate([-Servo_x/2,-Servo_w/2-Xtra_w/2,0]) cube([Servo_x,Servo_w+Xtra_w,14]);
	}
	
	// Bolt holes
	translate([-Servo_BoltSpace2/2,Servo_BoltSpace/2,0]) Bolt4Hole(depth=20);
	translate([-Servo_BoltSpace2/2,-Servo_BoltSpace/2,0]) Bolt4Hole(depth=20);
	translate([Servo_BoltSpace2/2,Servo_BoltSpace/2,0]) Bolt4Hole(depth=20);
	translate([Servo_BoltSpace2/2,-Servo_BoltSpace/2,0]) Bolt4Hole(depth=20);
		
	if (BottomMount==true){
		translate([-Servo_BoltSpace2/2,Servo_BoltSpace/2,0]) rotate([180,0,0]) Bolt4Hole(depth=20);
		translate([-Servo_BoltSpace2/2,-Servo_BoltSpace/2,0]) rotate([180,0,0]) Bolt4Hole(depth=20);
		translate([Servo_BoltSpace2/2,Servo_BoltSpace/2,0]) rotate([180,0,0]) Bolt4Hole(depth=20);
		translate([Servo_BoltSpace2/2,-Servo_BoltSpace/2,0]) rotate([180,0,0]) Bolt4Hole(depth=20);
	}
	
	if (BottomMount==true){
		// servo wheel
		translate([Servo_Shaft_Offset,0,Servo_Deck_h+Servo_TopStep_h+XtraTop-Overlap])
			cylinder(d=21.3,h=Servo_TopOfWheel-Servo_Deck_h-Servo_TopStep_h+XtraTop+Overlap);
	} else {
		translate([Servo_Shaft_Offset,0,0]) cylinder(d=21.3,h=19.6);
	}
	translate([Servo_Shaft_Offset,0,0]) cylinder(d=9,h=30);
	translate([Servo_Shaft_Offset,14.5/2,19.6+6]) Bolt4HeadHole();
	translate([Servo_Shaft_Offset,-14.5/2,19.6+6]) Bolt4HeadHole();
	}
} // Servo_HX5010

//Servo_HX5010(BottomMount=true,TopAccess=false, Xtra_w=1.2, Xtra_h=0, XtraTop=-1);
//Servo_HX5010(BottomMount=true,TopAccess=false, Xtra_w=1.2, Xtra_h=0);
//Servo_HX5010(BottomMount=false,TopAccess=true, Xtra_w=1.2, Xtra_h=1);

module ServoTray_HX5010(Xtra_h=0, UseH_Slots=false){
	PushUp=Xtra_h;
	
	difference(){
		union(){
			translate([-40,-12.7-PushUp,-6])
			hull(){
				cube([3,22.5+PushUp,Overlap]);
				translate([0,0,-15]) cube([3,Overlap,15]);
			} // hull
			
			translate([-40+62-3,-12.7-PushUp,-6])
			hull(){
				cube([3,22.5+PushUp,Overlap]);
				translate([0,0,-15]) cube([3,Overlap,15]);
			} // hull
			
			translate([-40,-12.7-PushUp,-6]) cube([62,22.5+PushUp,6]);
			
			translate([-40,-12.7-PushUp,-21]) cube([62,3,21]);
		} // union
		
		Servo_HX5010(BottomMount=false,TopAccess=false,Xtra_w=0.2, Xtra_h=1);
		
		translate([0,-PushUp,0])
		if (UseH_Slots==true) {
			translate([-40+3+2,-12.7-Overlap,-10]) hull(){
				rotate([-90,0,0]) cylinder(d=3,h=4);
				translate([6,0,0]) rotate([-90,0,0]) cylinder(d=3,h=4);}
			translate([-40+62-3-2,-12.7-Overlap,-10]) hull(){
				rotate([-90,0,0]) cylinder(d=3,h=4);
				translate([-6,0,0]) rotate([-90,0,0]) cylinder(d=3,h=4);}
		} else {
			translate([-40+3+3.5,-12.7-Overlap,-10]) hull(){
				rotate([-90,0,0]) cylinder(d=3,h=4);
				translate([0,0,-6]) rotate([-90,0,0]) cylinder(d=3,h=4);}
			translate([-40+62-3-3.5,-12.7-Overlap,-10]) hull(){
				rotate([-90,0,0]) cylinder(d=3,h=4);
				translate([0,0,-6]) rotate([-90,0,0]) cylinder(d=3,h=4);}
		}
		
	} // difference
	
	
} // ServoTray_HX5010

// ServoTray_HX5010(Xtra_h=0, UseH_Slots=false);
// ServoTray_HX5010(Xtra_h=0, UseH_Slots=true);

module ServoTray_HX5010_2(Xtra_h=0, UseH_Slots=false){
	// Shorter in X and taller in Z
	Servo_Shaft_Offset=-9.4;
	Len=55;
	PushUp=4+Xtra_h;
	
	difference(){
		union(){
			translate([Servo_Shaft_Offset-Len/2,-12.7-PushUp,-6])
				hull(){
					cube([3,22.5+PushUp,Overlap]);
					translate([0,0,-15]) cube([3,Overlap,15]);
				} // hull
			
			translate([Servo_Shaft_Offset+Len/2-3,-12.7-PushUp,-6])
				hull(){
					cube([3,22.5+PushUp,Overlap]);
					translate([0,0,-15]) cube([3,Overlap,15]);
				} // hull
			
			translate([Servo_Shaft_Offset-Len/2,-12.7-PushUp,-6]) cube([Len,22.5+PushUp,6]);
			
			translate([Servo_Shaft_Offset-Len/2,-12.7-PushUp,-21]) cube([Len,3,21]);
		} // union
		
		Servo_HX5010(BottomMount=false,TopAccess=false,Xtra_w=0.2, Xtra_h=1);
		
		translate([0,-PushUp,0])
		if (UseH_Slots==true) {
			translate([Servo_Shaft_Offset-Len/2+3+2,-12.7-Overlap,-10]) hull(){
				rotate([-90,0,0]) cylinder(d=3,h=4);
				translate([6,0,0]) rotate([-90,0,0]) cylinder(d=3,h=4);}
			translate([Servo_Shaft_Offset+Len/2-3-2,-12.7-Overlap,-10]) hull(){
				rotate([-90,0,0]) cylinder(d=3,h=4);
				translate([-6,0,0]) rotate([-90,0,0]) cylinder(d=3,h=4);}
		} else {
			translate([Servo_Shaft_Offset-Len/2+3+3.5,-12.7-Overlap,-10]) hull(){
				rotate([-90,0,0]) cylinder(d=3,h=4);
				translate([0,0,-6]) rotate([-90,0,0]) cylinder(d=3,h=4);}
			translate([Servo_Shaft_Offset+Len/2-3-3.5,-12.7-Overlap,-10]) hull(){
				rotate([-90,0,0]) cylinder(d=3,h=4);
				translate([0,0,-6]) rotate([-90,0,0]) cylinder(d=3,h=4);}
		}
		
	} // difference
	
	
} // ServoTray_HX5010_2

//rotate([90,0,0]) ServoTray_HX5010_2(UseH_Slots=true);
// ServoTray_HX5010_2(Xtra_h=0, UseH_Slots=false);

module ServoTray_HX5010Holes(UseH_Slots=false){
	if (UseH_Slots==true) {
		translate([-40+3+2+3,0,0]) children();
		translate([-40+62-3-2-3,0,0]) children();
	} else {
		translate([-40+3+3.5,0,0]) children();
		translate([-40+62-3-3.5,0,0]) children();
	}
} // ServoTray_HX5010Holes

//ServoTray_HX5010Holes(UseH_Slots=false) Bolt4Hole();
//ServoTray_HX5010Holes(UseH_Slots=true) Bolt4Hole();

module LD20MGServoWheel(){
	kHornThickness=2.1;
	kHub_d=13;
	
	cylinder(d=7.8,h=kHornThickness+1.2);
	cylinder(d=5.8,h=kHornThickness+10);
	
	hull(){
			translate([0,0,-Overlap]) cylinder(d=kHub_d,h=kHornThickness);
			translate([0,16.05,-Overlap]) cylinder(d=5.1,h=kHornThickness);
		} // hull
		
	hull(){
			translate([0,0,-Overlap]) cylinder(d=kHub_d,h=kHornThickness);
			translate([0,-16.05,-Overlap]) cylinder(d=5.1,h=kHornThickness);
		} // hull
		
		hull(){
			translate([0,0,-Overlap]) cylinder(d=kHub_d,h=kHornThickness);
			translate([-15.05,0,-Overlap]) cylinder(d=5.1,h=kHornThickness);
		} // hull
		
		hull(){
			translate([0,0,-Overlap]) cylinder(d=kHub_d,h=kHornThickness);
			translate([15.05,0,-Overlap]) cylinder(d=5.1,h=kHornThickness);
		} // hull
} // LD20MGServoWheel

//LD20MGServoWheel();


