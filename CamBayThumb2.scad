// ***********************************
// Project: 3D Printed Rocket
// Filename: CamBayThumb2.scad
// by David M. Flynn
// Created: 1/27/2026
// Revision: 0.9.1  2/1/2026
// Units: mm
// ***********************************
//  ***** Notes *****
//
// Camera Bay for RunCam Thumb 2
// As designed it fits between the electronics bay and nosecone.
// First used on an old Blue Tube 98mm rocket.
//
//  ***** History *****
//
// 0.9.1  2/1/2026     Works for BT98 size rocket.
// 0.9.0  1/27/2026    First code
//
// ***********************************
//  ***** for STL output *****
//
// CBT_Airframe(Body_OD=Body_OD+0.4, Body_ID=Body_ID, Coupler_OD=Coupler_OD, Len=50, nRivets=3, RivetInset=6.5, Base_h=15);
// rotate([180,0,0]) CBT_Clip();
//
// ***********************************
//  ***** Routines *****
//
// CBT_Camera(FrontAccess=10, IncludeAccess=true);
// CBT_CameraFrontBlock(Wall_t=1.8, Interface=5);
//
// ***********************************
//  ***** for Viewing *****
//
//
// ***********************************
include<TubesLib.scad>
use<BatteryHolderLib.scad>
//use<NoseCone.scad>
//use<PetalDeploymentLib.scad>

//also included
 //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 36:90;
Bolt4Inset=4;
Vinyl_d=0.3; // measured


Body_OD=BT98Body_OD;
Body_ID=BT98Body_ID;
Coupler_OD=BT98Coupler_OD;
Coupler_ID=BT98Coupler_ID;


Camera_Lens_X=25;
Camera_Lens_Y=25.5;
Camera_Lens_R=5;
Camera_Lens_Z=28;
CameraBody_X=57;
CameraBody_Y=26.2;
CameraBody_Z=13.5;
CameraBody_R=5.5;
CameraBody_Offset_X=CameraBody_X/2-Camera_Lens_X/2;

module CBT_Camera(FrontAccess=10, IncludeAccess=true){
	RoundRect(X=Camera_Lens_X, Y=Camera_Lens_Y, Z=Camera_Lens_Z, R=Camera_Lens_R);
	translate([CameraBody_Offset_X,0,0]) RoundRect(X=CameraBody_X, Y=CameraBody_Y, Z=CameraBody_Z, R=CameraBody_R);
	
	if (IncludeAccess){
		// View Port
		translate([0,0,Camera_Lens_Z-Overlap]) cylinder(d1=16, d2=15+5+FrontAccess, h=FrontAccess);
		
		// Button Access
		translate([CameraBody_Offset_X+CameraBody_X/2-5,0,0]) cylinder(d=10, h=Camera_Lens_Z+FrontAccess);
		
		// Power cable
		translate([CameraBody_Offset_X+CameraBody_X/2-13,0,-10+Overlap]) cylinder(d=8, h=10);
		
		// Cooling air
		translate([CameraBody_Offset_X+CameraBody_X/2-22.5,0,4]) rotate([90,0,0]) hull(){
			translate([7.5,0,0]) cylinder(d=5, h=CameraBody_Y+20, center=true);
			translate([-7.5,0,0]) cylinder(d=5, h=CameraBody_Y+20, center=true);
		} // hull
		
		// Back Cooling air
		translate([CameraBody_Offset_X+CameraBody_X/2-34.5,7.5,-10+Overlap]) hull(){
			translate([7.5,0,0]) cylinder(d=7, h=10);
			translate([-7.5,0,0]) cylinder(d=7, h=10);
		} // hull
		translate([CameraBody_Offset_X+CameraBody_X/2-34.5,-7.5,-10+Overlap]) hull(){
			translate([7.5,0,0]) cylinder(d=7, h=10);
			translate([-7.5,0,0]) cylinder(d=7, h=10);
		} // hull
		
	} // if
} // CBT_Camera

// CBT_Camera(IncludeAccess=true);
// CBT_Camera(IncludeAccess=false);

module CBT_CameraFrontBlock(Wall_t=1.8, Interface=5){
	translate([CameraBody_Offset_X,0,CameraBody_Z-Interface]) 
		RoundRect(X=CameraBody_X+Wall_t*2, Y=CameraBody_Y+Wall_t*2, Z=Interface+20, R=CameraBody_R+Wall_t);
} // CBT_CameraFrontBlock

// CBT_CameraFrontBlock();

module CBT_Airframe(Body_OD=Body_OD+0.4, Body_ID=Body_ID, Coupler_OD=Coupler_OD, Len=50, nRivets=3, RivetInset=6.5, Base_h=15){
	Wall_t=1.8;
	Camera_X=-6.5;
	Camera_Y=-6;
	Camera_Z=Base_h+CameraBody_Y/2+Wall_t+1;
	Rivet_d=4;
	Rivet_a=180;
	
	MagSW_X=-4.5;
	MagSW_Y=Body_ID/2-12;
	MagSW_Z=Camera_Z+CameraBody_Y/2+Wall_t-1;
	MagSW_a=90;
	
	Batt1_X=Body_ID/2-13;
	Batt1_Y=0;
	Batt1_Z=15;
	Batt1_a=90;
	
	module HS_Bolts(){
		translate([0,-Body_OD/2,25]) rotate([90,0,0]) children();
		translate([0,-Body_OD/2,45]) rotate([90,0,0]) children();
	} // HS_Bolts
	
	// HS_Bolts() Bolt6Hole();

	// Mag Switch
	translate([MagSW_X,MagSW_Y,MagSW_Z]) rotate([0,0,MagSW_a]) FW_MagSw_Mount(HasMountingEars=false, Reversed=false);
			
	// Batteries
	intersection(){
		union(){
			cylinder(d=Body_OD-1, h=Len);
			cylinder(d=Coupler_OD-1, h=Len+15);
		} // union
		
		union(){
			rotate([0,0,-15])
			translate([Batt1_X,Batt1_Y,Batt1_Z]) rotate([0,0,Batt1_a]) {
				SingleBatteryPocket(ShowBattery=false);
				translate([-16,-19,0]) cube([32,10,47]);
			}
			
			rotate([0,0,195])
			translate([Batt1_X,Batt1_Y,Batt1_Z]) rotate([0,0,Batt1_a]) {
				SingleBatteryPocket(ShowBattery=false);
				translate([-16,-19,0]) cube([32,10,47]);
			}
		} // union
	} // intersection
	
	// Heat sync mount
	difference(){
		intersection(){
			union(){
				cylinder(d=Body_OD-1, h=Len);
				cylinder(d=Coupler_OD-1, h=Len+15);
			} // union
			
			translate([-20,-Body_ID/2-1,15]) cube([40,8,38]);
		} // intersection
		
		HS_Bolts() Bolt6ButtonHeadHole();
	} // difference

	
	difference(){
		union(){
			Tube(OD=Body_OD, ID=Body_ID, Len=Len, myfn=$preview? 90:180);
			
			// Integrated Coupler
			translate([0,0,Len-5]) Tube(OD=Coupler_OD, ID=Coupler_OD-4.4, Len=5+RivetInset*2, myfn=$preview? 90:180);
			translate([0,0,Len-5]) Tube(OD=Body_ID+1, ID=Coupler_OD-1, Len=5, myfn=$preview? 90:180);
			
			// Camera Block
			intersection(){
				translate([Camera_X,Body_OD/2-Camera_Lens_Z+Camera_Y,Camera_Z]) rotate([-90,0,0]) CBT_CameraFrontBlock(Wall_t=Wall_t, Interface=5);
				
				cylinder(d=Body_OD-1, h=Len);
			} // intersection
			
		} // union
		
		// Integrated Coupler transition
		translate([0,0,Len-5-Overlap]) cylinder(d1=Body_ID, d2=Coupler_OD-4.4-Overlap, h=5+Overlap*2, $fn=180);
		for (j=[0:nRivets-1]) rotate([0,0,360/nRivets*j+Rivet_a]) translate([0,Body_OD/2+1,Len+RivetInset]) 
			rotate([90,0,0]) cylinder(d=Rivet_d, h=10);
		
		for (j=[0:nRivets-1]) rotate([0,0,360/nRivets*j+Rivet_a]) translate([0,Body_OD/2+1,RivetInset]) 
			rotate([90,0,0]) cylinder(d=Rivet_d, h=10);
		
		// Camera
		translate([Camera_X,Body_OD/2-Camera_Lens_Z+Camera_Y,Camera_Z]) rotate([-90,0,0]) CBT_Camera(IncludeAccess=true);
		
		// Mag Switch Bolts
		translate([MagSW_X,MagSW_Y,MagSW_Z]) rotate([0,0,MagSW_a]) translate([0,0,1]) FW_MagSw_BoltPattern(Reversed=false) Bolt4Hole();
		
		// Heatsync bolts
		HS_Bolts() Bolt6ButtonHeadHole();
		
		// Clamp Bolts
		translate([Camera_X+30,Body_OD/2-Camera_Lens_Z+Camera_Y+17,Camera_Z+CameraBody_Y/2+Wall_t]){
			Bolt4Hole();
			translate([-Bolt4Inset*2,0,0]) Bolt4Hole();
		}
	} // difference
} // CBT_Airframe

// CBT_Airframe();
// translate([23.5,34,45]) CBT_Clip();

module CBT_Clip(){
	Tang_w=5;
	Tang_X=-5;
	
	difference(){
		union(){
			hull(){
				cylinder(d=10, h=5);
				translate([-Bolt4Inset*2,0,0]) cylinder(d=10, h=5);
			} // hull
			
			hull(){
				translate([Tang_X-4-5,-17-Tang_w/2,-20]) cylinder(d=Tang_w,h=25);
				translate([Tang_X-4+5,-17-Tang_w/2,-20]) cylinder(d=Tang_w,h=25);
			} // hull
			
			hull(){
				translate([Tang_X-4-5,-17-Tang_w/2,0]) cylinder(d=Tang_w,h=5);
				translate([Tang_X-4+5,-17-Tang_w/2,0]) cylinder(d=Tang_w,h=5);
				translate([-4-5,0,0]) cylinder(d=Tang_w,h=5);
				translate([-4+5,0,0]) cylinder(d=Tang_w,h=5);
			} // hull
		} // union
	
		// bolt holes
		translate([0,0,5]) Bolt4ButtonHeadHole();
		translate([-Bolt4Inset*2,0,5]) Bolt4ButtonHeadHole();
	} // difference

} // CBT_Clip

// rotate([180,0,0]) CBT_Clip();












































