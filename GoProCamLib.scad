// ***********************************
// Project: 3D Printed Rocket
// Filename: GoProCamLib.scad
// by David M. Flynn
// Created: 6/30/2024 
// Revision: 0.9.1  7/1/2024 
// Units: mm
// ***********************************
//  ***** Notes *****
//
// GoPro Camera Mounts
//
// Prefix: GPC_ 
//
//  ***** History *****
//
function GoProCamLib_Rev()="GoProCamLib 0.9.1";
echo(GoProCamLib_Rev());
//
// 0.9.1  7/1/2024    Added HasMountingEars
// 0.9.0  6/30/2024   Copied from Fairing137 Rev 1.0.1
//
// ***********************************
//  ***** for STL output *****
//
//
// GPC_CameraShellTest();
// rotate([80,0,0]) GPC_CameraBay(Tube_OD=BT98Body_OD, Tube_ID=BT98Body_ID);
//
//
// ***********************************
//  ***** Routines *****
//
// function GoProCamLib_Rev(); // Shows Revision text
//
// GPC_GoProHero11Black(Xtra=0, Xtra_Z=0, IncludeVP=true, BackAccess=false, HasMountingEars=false);
//
//
// ***********************************
//  ***** for Viewing *****
//
//
// ***********************************

include<TubesLib.scad>

Overlap=0.05;
IDXtra=0.2; // Add to ID for tight fit, x2 for loose fit
$fn=$preview? 24:90;


module GPC_GoProHero11Black(Xtra=0, Xtra_Z=0, IncludeVP=true, BackAccess=false, HasMountingEars=false){
	Body_X=72;
	Body_Y=51;
	Body_Z=28;
	Cam_X=Body_X+Xtra;
	Cam_Y=Body_Y+Xtra;
	BattLatch_Y=-Body_Y/2+6;
	Cam_Z=Body_Z+Xtra;
	Cam_R=7+Xtra/2;
	LensBoss_XY=32.2+Xtra;
	LensBoss_Z=Cam_Z+6;
	RecBtn_X=-Body_Z/2;
	
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
		
	Button_R=2;
	
	// Power Button
	translate([Cam_X/2-Button_R, PwrBtn_Y, -Xtra_Z]) hull(){
		RoundRect(X=2+Button_R*2+Xtra/2, Y=16+Xtra/2, Z=21+Xtra/2+Xtra_Z, R=Button_R);
		
		translate([1,0,21+Xtra/2+Xtra_Z]){
		translate([Xtra/4, -8-Xtra/4+Button_R, 0]) sphere(r=Button_R);
		translate([Xtra/4, 8+Xtra/4-Button_R, 0]) sphere(r=Button_R);
		translate([-Xtra/4, -8-Xtra/4+Button_R, 0]) sphere(r=Button_R);
		translate([-Xtra/4, 8+Xtra/4-Button_R, 0]) sphere(r=Button_R);
		}} // hull
	if (BackAccess)
		translate([Cam_X/2-Button_R, PwrBtn_Y, -BackAccess_L]) RoundRect(X=2+Button_R*2, Y=16, Z=21+BackAccess_L, R=Button_R);
		
	// Picture button
	translate([RecBtn_X, Cam_Y/2-Button_R, -Xtra_Z]) hull(){
		RoundRect(X=16+Xtra/2, Y=2+Button_R*2+Xtra/2, Z=21+Xtra/2+Xtra_Z, R=Button_R);
		
		translate([0,1,21+Xtra/2+Xtra_Z]){
		translate([-8-Xtra/4+Button_R,Xtra/4, 0]) sphere(r=Button_R);
		translate([8+Xtra/4-Button_R, Xtra/4, 0]) sphere(r=Button_R);
		translate([-8-Xtra/4+Button_R, -Xtra/4, 0]) sphere(r=Button_R);
		translate([8+Xtra/4-Button_R,-Xtra/4, 0]) sphere(r=Button_R);
		}} // hull
	if (BackAccess)
		translate([RecBtn_X, Cam_Y/2-Button_R, -BackAccess_L]) RoundRect(X=16, Y=2+Button_R*2, Z=21+BackAccess_L, R=Button_R);
		
	// Batt door latch
	translate([-Cam_X/2+1, BattLatch_Y, -Xtra_Z]) cylinder(d=5+Xtra/4, h=Cam_Z+Xtra_Z);
	if (BackAccess)
		translate([-Cam_X/2+1, BattLatch_Y, -BackAccess_L-Xtra_Z]) cylinder(d=5+Xtra/2, h=Cam_Z-2+BackAccess_L+Xtra_Z);
	
	// View Path
	if (IncludeVP)
	translate([Cam_X/2-LensBoss_XY/2, Cam_Y/2-LensBoss_XY/2, LensBoss_Z-Overlap]){
	RoundRect(X=LensBoss_XY-5, Y=LensBoss_XY-5, Z=1, R=Cam_R);
		hull(){
			translate([0,0,-Overlap]) RoundRect(X=LensBoss_XY-5+Xtra*2, Y=LensBoss_XY-5+Xtra*2, Z=0.01, R=Cam_R);
			translate([0,0,30]) RoundRect(X=LensBoss_XY+35+Xtra*2, Y=LensBoss_XY+35+Xtra*2, Z=0.01, R=Cam_R);
		}}
		
	Ear_d=15.6;
	Ear_t=3.4;
	Ear_CL=3.5+Ear_t;
	Ear_Bolt_d=5;
	Ear_Bolt_Y=8.2;
	Shell=(Xtra>1)? 0:Overlap;
	
	if(HasMountingEars){
		hull(){
			translate([Ear_CL/2,-Body_Y/2,Body_Z/2])
				rotate([0,90,0]) cylinder(d=Ear_d+Xtra*2+Shell, h=Ear_t+Xtra*2+Shell, center=true);
			translate([Ear_CL/2,-Body_Y/2-Ear_Bolt_Y,Body_Z/2]) 
				rotate([0,90,0]) cylinder(d=Ear_d+Xtra*2+Shell, h=Ear_t+Xtra*2+Shell, center=true);
			
			if (BackAccess)translate([0,0,-BackAccess_L]) {
				translate([Ear_CL/2,-Body_Y/2,Body_Z/2]) 
					rotate([0,90,0]) cylinder(d=Ear_d+Xtra*2+Shell, h=Ear_t+Xtra*2+Shell, center=true);
				translate([Ear_CL/2,-Body_Y/2-Ear_Bolt_Y,Body_Z/2]) 
					rotate([0,90,0]) cylinder(d=Ear_d+Xtra*2+Shell, h=Ear_t+Xtra*2+Shell, center=true);
			}
		} // hull
		hull(){
			translate([-Ear_CL/2,-Body_Y/2,Body_Z/2]) 
				rotate([0,90,0]) cylinder(d=Ear_d+Xtra*2+Shell, h=Ear_t+Xtra*2+Shell, center=true);
			translate([-Ear_CL/2,-Body_Y/2-Ear_Bolt_Y,Body_Z/2]) 
				rotate([0,90,0]) cylinder(d=Ear_d+Xtra*2+Shell, h=Ear_t+Xtra*2+Shell, center=true);
			
			if (BackAccess)translate([0,0,-BackAccess_L]) {
				translate([-Ear_CL/2,-Body_Y/2,Body_Z/2]) 
					rotate([0,90,0]) cylinder(d=Ear_d+Xtra*2+Shell, h=Ear_t+Xtra*2+Shell, center=true);
				translate([-Ear_CL/2,-Body_Y/2-Ear_Bolt_Y,Body_Z/2]) 
					rotate([0,90,0]) cylinder(d=Ear_d+Xtra*2+Shell, h=Ear_t+Xtra*2+Shell, center=true);
			}
		} // hull
		
		if (BackAccess){
			translate([-Ear_CL/2-Ear_t/2-1+40,-Body_Y/2-Ear_Bolt_Y,Body_Z/2]) rotate([0,90,0]) Bolt10ClearHole(depth=40);
			translate([-Ear_CL/2,-Body_Y/2-Ear_Bolt_Y,Body_Z/2]) rotate([0,90,0]) Bolt10Hole();
			}
	}
} // GPC_GoProHero11Black

//GPC_GoProHero11Black(Xtra=0, Xtra_Z=0, IncludeVP=false, BackAccess=false, HasMountingEars=true);
//GPC_GoProHero11Black(Xtra=5, Xtra_Z=0, IncludeVP=true, BackAccess=true, HasMountingEars=true);

module GPC_CameraShellTest(){
	difference(){
		GoProHero11Black(Xtra=5, Xtra_Z=0, IncludeVP=false, BackAccess=false, HasMountingEars=true);
						
		translate([0,0,33.0]) cylinder(d=100, h=20);
		
		GoProHero11Black(Xtra=0, Xtra_Z=0, IncludeVP=true, BackAccess=true, HasMountingEars=true);
	} // difference
} // GPC_CameraShellTest

//rotate([180,0,0]) GPC_CameraShellTest();

module GPC_CameraBay(Tube_OD=BT98Body_OD, Tube_ID=BT98Body_ID){
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
						rotate([Cam_X_a,Cam_Y_a,Cam_Z_a]) 
							GoProHero11Black(Xtra=5, Xtra_Z=0, IncludeVP=false, BackAccess=false, HasMountingEars=true);
					translate([CamOffset_X-9.5,CamOffset_Y-20,CamOffset_Z+12]) 
						rotate([100,0,0]) RoundRect(X=40, Y=50, Z=30, R=5);
				} // union
					
				//translate([0,-38.5,CamOffset_Z]) rotate([100,0,0]) cylinder(d=100, h=20);
				
				cylinder(d=Tube_OD-1, h=100);
			} // intersection
			
			
		} // union
		
		translate([CamOffset_X,CamOffset_Y,CamOffset_Z]) rotate([10,0,0]) 
			rotate([Cam_X_a,Cam_Y_a,Cam_Z_a]) GoProHero11Black(Xtra=0, Xtra_Z=0, IncludeVP=true, BackAccess=true, HasMountingEars=true);
			
		// Bolts
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) {
			translate([0,Tube_OD/2,7.5]) rotate([-90,0,0]) Bolt4ClearHole();
			translate([0,Tube_OD/2,Len+7.5]) rotate([-90,0,0]) Bolt4Hole();
			}
	} // difference
	
} // GPC_CameraBay

//rotate([80,0,0]) GPC_CameraBay();

































