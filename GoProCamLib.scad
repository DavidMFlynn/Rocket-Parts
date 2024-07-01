// ***********************************
// Project: 3D Printed Rocket
// Filename: GoProCamLib.scad
// by David M. Flynn
// Created: 6/30/2024 
// Revision: 0.9.0  6/30/2024 
// Units: mm
// ***********************************
//  ***** Notes *****
//
// GoPro Camera Mounts
// 
//
//  ***** History *****
//
echo("GoProCamLib 0.9.0");
// 0.9.0  6/30/2024   Copied from Fairing137 Rev 1.0.1
//
// ***********************************
//  ***** for STL output *****
//
//
// CameraShellTest();
// rotate([80,0,0]) CameraBay(Tube_OD=BT98Body_OD, Tube_ID=BT98Body_ID);
//
//
// ***********************************
//  ***** Routines *****
//
// GoProHero11Black(Xtra=0, Xtra_Z=0, IncludeVP=true, BackAccess=false);
//
//
// ***********************************
//  ***** for Viewing *****
//
// ShowGoProFairingAdaptor();
//
// ***********************************

include<TubesLib.scad>

Overlap=0.05;
IDXtra=0.2; // Add to ID for tight fit, x2 for loose fit
$fn=$preview? 24:90;


module GoProHero11Black(Xtra=0, Xtra_Z=0, IncludeVP=true, BackAccess=false){
	Cam_X=72+Xtra;
	Cam_Y=51+Xtra;
	BattLatch_Y=-51/2+6;
	Cam_Z=28+Xtra;
	Cam_R=7+Xtra/2;
	LensBoss_XY=32.2+Xtra;
	LensBoss_Z=Cam_Z+6;
	RecBtn_X=-14;
	
	PwrBtn_Y=-1;
	BackAccess_L=40;
	
	translate([0,0,-Xtra_Z]) RoundRect(X=Cam_X, Y=Cam_Y, Z=Cam_Z+Xtra_Z, R=Cam_R);
	if (BackAccess) translate([0,0,-BackAccess_L])
		RoundRect(X=Cam_X+1, Y=Cam_Y+1, Z=BackAccess_L+1, R=Cam_R);
	
	translate([Cam_X/2-LensBoss_XY/2, Cam_Y/2-LensBoss_XY/2, 0])
		RoundRect(X=LensBoss_XY, Y=LensBoss_XY, Z=LensBoss_Z, R=Cam_R);
		
	// Buttons
	if (BackAccess){
		translate([0,PwrBtn_Y,Cam_Z/2]) rotate([0,90,0]) cylinder(d=6, h=100);
		translate([RecBtn_X,0,Cam_Z/2]) rotate([-90,0,0]) cylinder(d=6, h=100);
		}
	
	// Power Button
	translate([Cam_X/2, PwrBtn_Y, -Xtra_Z]) hull(){
		RoundRect(X=2+Xtra/2, Y=16+Xtra/2, Z=21+Xtra/2+Xtra_Z, R=1);
		
		translate([0,0,21+Xtra/2+Xtra_Z]){
		translate([Xtra/4, -8-Xtra/4+1, 0]) sphere(r=1);
		translate([Xtra/4, 8+Xtra/4-1, 0]) sphere(r=1);
		translate([-Xtra/4, -8-Xtra/4+1, 0]) sphere(r=1);
		translate([-Xtra/4, 8+Xtra/4-1, 0]) sphere(r=1);
		}}
	if (BackAccess)
		translate([Cam_X/2, PwrBtn_Y, -BackAccess_L]) RoundRect(X=2, Y=16, Z=21+BackAccess_L, R=1);
		
	
	// Picture button
	translate([RecBtn_X, Cam_Y/2, -Xtra_Z]) hull(){
		RoundRect(X=16+Xtra/2, Y=2+Xtra/2, Z=21+Xtra/2+Xtra_Z, R=1);
		
		translate([0,0,21+Xtra/2+Xtra_Z]){
		translate([-8-Xtra/4+1, Xtra/4, 0]) sphere(r=1);
		translate([8+Xtra/4-1, Xtra/4, 0]) sphere(r=1);
		translate([-8-Xtra/4+1, -Xtra/4, 0]) sphere(r=1);
		translate([8+Xtra/4-1,-Xtra/4, 0]) sphere(r=1);
		}}
	if (BackAccess)
		translate([RecBtn_X,Cam_Y/2,-BackAccess_L]) RoundRect(X=16,Y=2,Z=21+BackAccess_L,R=1);
		
	// Batt door latch
	translate([-Cam_X/2+1, BattLatch_Y, -Xtra_Z]) cylinder(d=5+Xtra/4, h=Cam_Z-2+Xtra/2+Xtra_Z);
	if (BackAccess)
		translate([-Cam_X/2+1, BattLatch_Y, -BackAccess_L-Xtra_Z]) cylinder(d=5+Xtra/2, h=Cam_Z-2+BackAccess_L+Xtra_Z);
	
	// View Path
	if (IncludeVP)
	translate([Cam_X/2-LensBoss_XY/2, Cam_Y/2-LensBoss_XY/2, LensBoss_Z-Overlap]){
	RoundRect(X=LensBoss_XY-5, Y=LensBoss_XY-5, Z=1, R=Cam_R);
		hull(){
			translate([0,0,1-Overlap]) RoundRect(X=LensBoss_XY-5+Xtra*2, Y=LensBoss_XY-5+Xtra*2, Z=1, R=Cam_R);
			translate([0,0,30]) RoundRect(X=LensBoss_XY+35+Xtra*2, Y=LensBoss_XY+35+Xtra*2, Z=1, R=Cam_R);
		}}
} // GoProHero11Black

//GoProHero11Black(Xtra_Z=0, IncludeVP=false, BackAccess=false);


module CameraShellTest(){
	difference(){
		GoProHero11Black(Xtra=5, Xtra_Z=5, IncludeVP=false, BackAccess=false);
						
		translate([0,0,33.0]) cylinder(d=100, h=20);
		
		GoProHero11Black(Xtra=0, Xtra_Z=5, IncludeVP=true, BackAccess=true);
	} // difference
} // CameraShellTest

//rotate([180,0,0]) CameraShellTest();

module CameraBay(Tube_OD=BT98Body_OD, Tube_ID=BT98Body_ID){
	Cam_X_a=90;
	Cam_Y_a=-90;
	Cam_Z_a=0;
	CamOffset_X=3;
	CamOffset_Y=-5;
	CamOffset_Z=60;
	
	nBolts=3;
	Len=100;
	
	difference(){
		union(){
			Tube(OD=Tube_OD, ID=Tube_ID, Len=Len, myfn=$preview? 36:360);
			translate([0,0,Len]) Tube(OD=Tube_ID-IDXtra*2, ID=Tube_ID-IDXtra*2-4.4, Len=14, myfn=$preview? 36:360);
			translate([0,0,Len-5]) Tube(OD=Tube_OD-1, ID=Tube_ID-IDXtra*2-4.4, Len=5, myfn=$preview? 36:360);
			
	
			intersection(){
			//difference(){
				union(){
					translate([CamOffset_X,CamOffset_Y,CamOffset_Z]) rotate([10,0,0]) 
						rotate([Cam_X_a,Cam_Y_a,Cam_Z_a]) GoProHero11Black(Xtra=5, Xtra_Z=5, IncludeVP=false, BackAccess=false);
					translate([CamOffset_X-9.5,CamOffset_Y-20,CamOffset_Z+12]) 
						rotate([100,0,0]) RoundRect(X=40, Y=50, Z=30, R=5);
				} // union
					
				//translate([0,-38.5,CamOffset_Z]) rotate([100,0,0]) cylinder(d=100, h=20);
				
				cylinder(d=Tube_OD-1, h=100);
			} // intersection
			
			
		} // union
		
		translate([CamOffset_X,CamOffset_Y,CamOffset_Z]) rotate([10,0,0]) 
			rotate([Cam_X_a,Cam_Y_a,Cam_Z_a]) GoProHero11Black(Xtra=IDXtra*3, Xtra_Z=0, IncludeVP=true, BackAccess=true);
			
		// Bolts
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) {
			translate([0,Tube_OD/2,7.5]) rotate([-90,0,0]) Bolt4ClearHole();
			translate([0,Tube_OD/2,Len+7.5]) rotate([-90,0,0]) Bolt4Hole();
			}
	} // difference
	
} // CameraBay

//rotate([80,0,0]) CameraBay();

































