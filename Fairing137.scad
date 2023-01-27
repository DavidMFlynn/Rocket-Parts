// ***********************************
// Project: 3D Printed Rocket
// Filename: Fairing137.scad
// by David M. Flynn
// Created: 1/26/2023 
// Revision: 1.0.0  1/26/2023
// Units: mm
// ***********************************
//  ***** Notes *****
//
// I printed and tested this.
// It will get refined when another one gets built.
// 
// Parts:
// Spring 5/16"OD x 1-1/4" Free Length
//
//  ***** History *****
//
echo("Fairing137 1.0.0");
// 1.0.0   1/26/2023  Copied from Fairing54 Rev 1.1.0
//
// ***********************************
//  ***** for STL output *****
//
// GoProFairingAdaptor();
// BigFairingAdaptor(Fairing_OD=BT137Body_OD, BodyTubeOD=PML98Body_OD, CouplerTube_OD=PML98Coupler_OD, CouplerTube_ID=PML98Coupler_ID, BaseXtra=25, SkirtXtra=20);
// BigFairingAdaptorCR(Fairing_OD=BT137Body_OD, InnerTube_OD=BT38Body_OD, Offset=0);
// LargeFairing(IsLeftHalf=true, Fairing_OD=Fairing_OD, Wall_T=7, Len=Fairing_Len);
//
// ***********************************
//  ***** Routines *****
//
// GoProHero11Black(Xtra=IDXtra*3, Xtra_Z=0, IncludeVP=true, BackAccess=false);
//
// FairingWallGrigBox(X=10, Y=15, Z=15, R=1.5, A=0);
// GridWall(OD=BT137Body_OD, ID=BT137Body_OD-14, Len=100, Wall_t=1.2);
//
// ***********************************
//  ***** for Viewing *****
//
// ShowGoProFairingAdaptor();
//
// ***********************************

use<Fairing54.scad>
//include<TubesLib.scad>
include<FairingJointLib.scad>
//use<NoseCone.scad>
//include<FairingJointLib.scad>
//include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2; // Add to ID for tight fit, x2 for loose fit
$fn=$preview? 24:90;

// Lighter spring
F54_Spring_OD=5/16*25.4;
F54_Spring_FL=32;
F54_Spring_CBL=14;
F54_SpringEndCap_OD=F54_Spring_OD+3;

Fairing_OD=BT137Body_OD;
FairingWall_T=2.2;
Fairing_ID=Fairing_OD-FairingWall_T*2;
Fairing_Len=120;

// *********************************

module GoProHero11Black(Xtra=IDXtra*3, Xtra_Z=0, IncludeVP=true, BackAccess=false){
	Cam_X=72+Xtra;
	Cam_Y=51+Xtra;
	Cam_Z=28+Xtra;
	Cam_R=6+Xtra/2;
	LensBoss_XY=32.2+Xtra;
	LensBoss_Z=Cam_Z+6;
	
	translate([0,0,-Xtra_Z]) RoundRect(X=Cam_X, Y=Cam_Y, Z=Cam_Z+Xtra_Z, R=Cam_R);
	if (BackAccess) translate([0,0,-50])
		RoundRect(X=Cam_X+1, Y=Cam_Y+1, Z=51, R=Cam_R);
	
	translate([Cam_X/2-LensBoss_XY/2, Cam_Y/2-LensBoss_XY/2, 0])
		RoundRect(X=LensBoss_XY, Y=LensBoss_XY, Z=LensBoss_Z, R=Cam_R);
		
	// Buttons
	if (BackAccess){
		translate([0,0,Cam_Z/2]) rotate([0,90,0]) cylinder(d=6, h=100);
		translate([-12,0,Cam_Z/2]) rotate([-90,0,0]) cylinder(d=6, h=100);
		}
	
	// Picture button
	
	translate([-12,Cam_Y/2,0]) hull(){
		RoundRect(X=16+Xtra/2,Y=2+Xtra/2,Z=21+Xtra/2,R=1);
		translate([-8-Xtra/4+1,Xtra/4,21+Xtra/2]) sphere(r=1);
		translate([8+Xtra/4-1,Xtra/4,21+Xtra/2]) sphere(r=1);
		translate([-8-Xtra/4+1,-Xtra/4,21+Xtra/2]) sphere(r=1);
		translate([8+Xtra/4-1,-Xtra/4,21+Xtra/2]) sphere(r=1);
		}
	if (BackAccess)
		translate([-12,Cam_Y/2,-50]) RoundRect(X=16,Y=2,Z=21+50,R=1);
		
	// Batt door latch
	translate([-Cam_X/2+1, -Cam_Y/2+Cam_R*0.7, -Xtra/2]) cylinder(d=5+Xtra/2, h=Cam_Z-2+Xtra/2);
	if (BackAccess)
		translate([-Cam_X/2+1, -Cam_Y/2+Cam_R*0.7, -50]) cylinder(d=5, h=Cam_Z-2+50);
	
	// View Path
	if (IncludeVP)
	translate([Cam_X/2-LensBoss_XY/2, Cam_Y/2-LensBoss_XY/2, LensBoss_Z-Overlap]){
	RoundRect(X=LensBoss_XY-5, Y=LensBoss_XY-5, Z=1, R=Cam_R);
		hull(){
			translate([0,0,1-Overlap]) RoundRect(X=LensBoss_XY-5, Y=LensBoss_XY-5, Z=1, R=Cam_R);
			translate([0,0,30]) RoundRect(X=LensBoss_XY+35, Y=LensBoss_XY+35, Z=1, R=Cam_R);
		}}
} // GoProHero11Black

//GoProHero11Black(BackAccess=true);

module ShowGoProFairingAdaptor(){
	SkirtXtra=42;
	
	//translate([0,-32,20]) rotate([155,0,0]) color("Gray") GoProHero11Black();
	//
	translate([0,10,-50]) color("Blue") Tube(OD=BT38Body_OD, ID=BT38Body_ID, Len=100, myfn=$preview? 36:360);
	
	
	translate([0,0,12.1+SkirtXtra]) color("Tan") FairingBaseLockRing(Tube_OD=BT137Body_OD, Tube_ID=BT137Body_OD-4.4, Fairing_ID=BT137Body_OD-4.4, Interface=-IDXtra, BlendToTube=false);
	
	//translate([0,0,SkirtXtra]) BigFairingAdaptorCR(Fairing_OD=BT137Body_OD, InnerTube_OD=BT38Body_OD, Offset=10);
	GoProFairingAdaptor();
} // ShowGoProFairingAdaptor

//ShowGoProFairingAdaptor();
//BigFairingAdaptorCR(Fairing_OD=BT137Body_OD, InnerTube_OD=BT38Body_OD, Offset=10);
//FairingBaseLockRing(Tube_OD=BT137Body_OD+0.5, Tube_ID=BT137Body_OD-4.4, Fairing_ID=BT137Body_OD-4.4, Interface=0, BlendToTube=false);

module GoProFairingAdaptor(){
	SkirtXtra=42;
	CameraOffset_Y=-38;
	CameraOffset_Z=24;
	
	difference(){
		union(){
			BigFairingAdaptor(Fairing_OD=BT137Body_OD, BodyTubeOD=PML98Body_OD,
						CouplerTube_OD=PML98Coupler_OD, CouplerTube_ID=PML98Coupler_ID,
						BaseXtra=20, SkirtXtra=SkirtXtra);
			
			
			translate([0,CameraOffset_Y,CameraOffset_Z]) rotate([155,0,0]) 
				GoProHero11Black(Xtra=5, Xtra_Z=3, IncludeVP=false, BackAccess=false);
		} // union
		
		difference(){
			translate([0,CameraOffset_Y,CameraOffset_Z]) rotate([155,0,0]) 
				GoProHero11Black(Xtra=IDXtra*3, IncludeVP=true, BackAccess=true);
				
			translate([0,0,-35]) Tube(OD=PML98Body_OD, ID=PML98Body_OD-6, Len=CameraOffset_Z-3, myfn=$preview? 36:360);
			//cylinder(d=PML98Body_OD, h=CameraOffset_Z);
		} // difference
	} // difference
} // GoProFairingAdaptor

// rotate([180,0,0]) GoProFairingAdaptor();

// **********************************

module BigFairingAdaptor(Fairing_OD=BT137Body_OD, BodyTubeOD=PML98Body_OD,
						CouplerTube_OD=PML98Coupler_OD, CouplerTube_ID=PML98Coupler_ID,
						BaseXtra=25, SkirtXtra=20){
	nBolts=7;
	CR_H=5;
	CR_Inset_Z=11;
	CR_Inset=16;
	
	difference(){	
		union(){
			// Centering Ring Mount
			translate([0,0,SkirtXtra-CR_Inset_Z]) cylinder(d=Fairing_OD-1, h=15);
			
			FairingBase(BaseXtra=BaseXtra, SkirtXtra=SkirtXtra, Fairing_OD=Fairing_OD, Fairing_ID=Fairing_OD-4.4,
					BodyTubeOD=BodyTubeOD, 
					CouplerTube_OD=CouplerTube_OD, CouplerTube_ID=CouplerTube_ID);
		} // union
		
		// Cable Puller Cable Hole
		rotate([0,0,60]) translate([0,Fairing_OD/2-CR_Inset/2-6,SkirtXtra-12]) cylinder(d=12, h=12);
		
		// Centering Ring	
		translate([0,0,SkirtXtra-1]) cylinder(d=Fairing_OD-CR_Inset+IDXtra*2, h=5+Overlap);
		translate([0,0,SkirtXtra-3]) cylinder(d=Fairing_OD-CR_Inset-14, h=5);
		translate([0,0,SkirtXtra-CR_Inset_Z-Overlap]) 
			cylinder(d1=Fairing_OD-4, d2=Fairing_OD-CR_Inset-14, h=8+Overlap*2);
		
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+180/nBolts])
			translate([0,Fairing_OD/2-CR_Inset/2-4,SkirtXtra]) Bolt4Hole();
	} // difference
	
} // BigFairingAdaptor

//rotate([180,0,0]) BigFairingAdaptor();

module BigFairingAdaptorCR(Fairing_OD=BT137Body_OD, InnerTube_OD=BT38Body_OD, Offset=0){
	nBolts=7;
	CR_H=5;
	CR_Inset=16;
	
	difference(){
		CenteringRing(OD=Fairing_OD-CR_Inset, ID=InnerTube_OD+IDXtra*2, Thickness=CR_H, nHoles=9, Offset=Offset);
		
		// Cable Puller Cable Hole
		rotate([0,0,60]) translate([0,Fairing_OD/2-CR_Inset/2-6,-Overlap]) cylinder(d=9, h=12);
		
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+180/nBolts])
			translate([0,Fairing_OD/2-CR_Inset/2-4,CR_H]) Bolt4HeadHole();
	} // diff
} // BigFairingAdaptorCR

//BigFairingAdaptorCR(Fairing_OD=BT137Body_OD, InnerTube_OD=BT38Body_OD);

//translate([0,0,12]) FairingBaseLockRing(Tube_OD=BT137Body_OD, Tube_ID=BT137Body_OD-4.4, Fairing_ID=BT137Body_OD-4.4, Interface=-IDXtra, BlendToTube=false);

module FairingWallGrigBox(X=10, Y=15, Z=15, R=1.5, A=0){
	myfn=24;
	
	hull(){
		// wall filets
		translate([-X/2+R, -R, -Z/2+R]) sphere(r=R, $fn=myfn);
		translate([-X/2+R, -R, Z/2-R]) sphere(r=R, $fn=myfn);
		translate([X/2-R, -R, -Z/2+R]) sphere(r=R, $fn=myfn);
		translate([X/2-R, -R, Z/2-R]) sphere(r=R, $fn=myfn);
		
		// inside
		translate([-X/2+R, 0, -Z/2+R]) rotate([0,0,A]) 
			rotate([90,0,0]) cylinder(r=R, h=Y, $fn=myfn);
		translate([-X/2+R, 0, Z/2-R])  rotate([0,0,A])
			rotate([90,0,0]) cylinder(r=R, h=Y, $fn=myfn);
		translate([X/2-R, 0, -Z/2+R])  rotate([0,0,-A])
			rotate([90,0,0]) cylinder(r=R, h=Y, $fn=myfn);
		translate([X/2-R, 0, Z/2-R]) rotate([0,0,-A])
			rotate([90,0,0]) cylinder(r=R, h=Y, $fn=myfn);

	} // hull
} // FairingWallGrigBox

//FairingWallGrigBox(X=10, Y=15, Z=15, R=1.5);
			
module GridWall(OD=BT137Body_OD, ID=BT137Body_OD-14, Len=100, Wall_t=1.2){
	Box_X=10;
	Box_Z=15;
	Spacing_Z=Box_Z+Wall_t;
	
	Grid_a=asin((Box_X+Wall_t)/(ID/2));
	nBoxes=floor(180/Grid_a)-1;
	Start_a=(180-nBoxes*Grid_a)/2+Grid_a/2;
	nBoxes_Z=floor(Len/Spacing_Z);
	Start_Z=(Len-nBoxes_Z*Spacing_Z)/2+Spacing_Z/2;
	
	difference(){
		Tube(OD=OD, ID=ID, Len=Len, myfn=$preview? 36:360);
		
		for (k=[0:nBoxes_Z-1])
			for (j=[0:nBoxes-1]) rotate([0,0,-90+Start_a+Grid_a*j]) 
				translate([0, OD/2-Wall_t, Start_Z+Spacing_Z*k]) 
					FairingWallGrigBox(X=Box_X, Y=15, Z=Box_Z, R=1.5, A=Grid_a/2);
		
		
		translate([-OD/2-1, -OD/2-1, -Overlap]) cube([OD+2, OD/2+1, Len+Overlap*2]);
	} // difference
} // GridWall

//GridWall();

module LargeFairing(IsLeftHalf=true, 
				Fairing_OD=Fairing_OD,
				Wall_T=7,
				Len=Fairing_Len){
	
	TubeWall_T=2.2;
	PJ_Spacing=(Len-25)/4;
	Fairing_ID=Fairing_OD-2*Wall_T;
	BallHole_X=-Fairing_OD/2+9.5;
	Z1=18; // was 16
	Z2=Len-Z1;
	M_H=12;
	M_H2=16;
	HingeInset=2.5;
	WallInset_Z=6;
	MortiseOffset=8.5;
	
	module LockingBallAccessHole(H=JointPin_d){
		hull(){
			rotate([90,0,0]) cylinder(d=5, h=H);
			translate([0,0,-7]) rotate([90,0,0]) cylinder(d=5, h=H);
		} // hull
	} // LockingBallAccessHole
	
	module SpringSocket(){
		rotate([0,0,180])
			translate([Fairing_ID/2-F54_SpringEndCap_OD/2, -Overlap, Len/2]) 
					rotate([-90,0,0]) F54_SpringEndCapHole(Xtra=2);
	} // SpringSocket
		
	
	// Ball Tube
	if (IsLeftHalf)
	difference(){
		
		translate([BallHole_X,6.5-Overlap,Z1+M_H2/2]) 
			cylinder(d=JointPin_d+5, h=Z2-Z1-M_H2);
		
		// Tube ID
		translate([BallHole_X,6.5-Overlap,Z1+M_H2/2-Overlap]) 
			cylinder(d=JointPin_d+IDXtra*4, h=Z2-Z1-M_H2+Overlap*2);
		
		// Access hole
		translate([BallHole_X,6.5-Overlap,Z2-M_H2/2])
			rotate([0,0,22.5]) LockingBallAccessHole(H=JointPin_d);
		
		translate([BallHole_X,6.5-Overlap,Z2-M_H2/2]) 
			rotate([0,0,-90]) LockingBallAccessHole(H=JointPin_d);
		
	} // difference
			
	difference(){
		union(){
			translate([0,0,Len])			
				F54_Retainer(IsLeftHalf=IsLeftHalf, Fairing_OD=Fairing_OD, Wall_T=TubeWall_T);
			mirror([0,0,1])
				F54_Retainer(IsLeftHalf=IsLeftHalf, Fairing_OD=Fairing_OD, Wall_T=TubeWall_T);

			if (IsLeftHalf){
				translate([0,0,WallInset_Z])
					GridWall(OD=Fairing_OD, ID=Fairing_ID, Len=Len-WallInset_Z*2, Wall_t=1.2);
					
				// Keys to align fairing and nosecone
				translate([-Fairing_OD/2+3, 6.5, 0]) cylinder(d=4, h=6);
				translate([-Fairing_OD/2+3, 6.5, Len-6]) cylinder(d=4, h=6);
				
			}else{
				rotate([0,0,180]) translate([0,0,WallInset_Z])
					GridWall(OD=Fairing_OD, ID=Fairing_ID, Len=Len-WallInset_Z*2, Wall_t=1.2);
			}
			
			Tube(OD=Fairing_OD, ID=Fairing_OD-2.4, Len=Len, myfn=$preview? 36:360);
			
			// Fairing clip mounts
			if (IsLeftHalf){
				translate([0,0,12.5+PJ_Spacing])
					LargeFairing_PJ_Clip_Mounting(Fairing_OD=Fairing_OD, FairingWall_t=1.2);
				translate([0,0,12.5+PJ_Spacing*3])
					LargeFairing_PJ_Clip_Mounting(Fairing_OD=Fairing_OD, FairingWall_t=1.2);
			}else{
				translate([0,0,12.5]) rotate([180,0,0])
					LargeFairing_PJ_Clip_Mounting(Fairing_OD=Fairing_OD, FairingWall_t=1.2);
				translate([0,0,12.5+PJ_Spacing*2]) rotate([180,0,0])
					LargeFairing_PJ_Clip_Mounting(Fairing_OD=Fairing_OD, FairingWall_t=1.2);
				translate([0,0,12.5+PJ_Spacing*4]) rotate([180,0,0])
					LargeFairing_PJ_Clip_Mounting(Fairing_OD=Fairing_OD, FairingWall_t=1.2);
					
				translate([0,0,Z1]) rotate([0,0,180]) 
					LargeFairing_PJ_Clip_Mounting(Fairing_OD=Fairing_OD, FairingWall_t=1.2);
				translate([0,0,Z2]) rotate([0,0,180]) 
					LargeFairing_PJ_Clip_Mounting(Fairing_OD=Fairing_OD, FairingWall_t=1.2);
			}
		} // union
		
		// cut in half
		if (IsLeftHalf){
			translate([-Fairing_OD/2-1, 0, -Overlap]) 
				mirror([0,1,0]) cube([Fairing_OD+2, Fairing_OD/2+2, Len+Overlap*2]);
		} else {
			translate([-Fairing_OD/2-1, 0, -Overlap]) 
				cube([Fairing_OD+2, Fairing_OD/2+2, Len+Overlap*2]);
		}
		
		
		if (IsLeftHalf){
			// Hinge
			translate([Fairing_OD/2-HingeInset,0,-Overlap]) cylinder(d=3.6, h=Len+Overlap+2);
			translate([Fairing_OD/2,-1.5,Len/2]) 
				rotate([0,0,30]) cube([4,4,Len+Overlap+2],center=true);
		
			// cable path
			translate([BallHole_X,6.5,Len/2]) 
				cylinder(d=JointPin_d+IDXtra*3, h=Len-10, center=true);
			
			translate([BallHole_X,6.5-Overlap,Z2-M_H2/2]) 
				rotate([0,0,-90]) LockingBallAccessHole(H=10);
		
			translate([-Fairing_OD/2+MortiseOffset,6.5-Overlap,Z1]) 
				rotate([0,0,90]) MortiseBox(Mortise_h=M_H);
			translate([-Fairing_OD/2+MortiseOffset,6.5-Overlap,Z2]) 
				rotate([0,0,90]) MortiseBox(Mortise_h=M_H);
				
			translate([0,0,12.5+PJ_Spacing]){
				LargeFairing_PJ_Clip_Boss(Fairing_OD=Fairing_OD, FairingWall_t=TubeWall_T);
				LargeFairing_PJ_Clip_BoltPattern(Fairing_OD=Fairing_OD) Bolt4ClearHole();}
			translate([0,0,12.5+PJ_Spacing*3]){
				LargeFairing_PJ_Clip_Boss(Fairing_OD=Fairing_OD, FairingWall_t=TubeWall_T);
				LargeFairing_PJ_Clip_BoltPattern(Fairing_OD=Fairing_OD) Bolt4ClearHole();}

			translate([0,0,12.5]) rotate([180,0,0]) 
				LargeFairing_PJ_Clip_Socket(Fairing_OD=Fairing_OD, FairingWall_t=TubeWall_T);
			translate([0,0,12.5+PJ_Spacing*2]) rotate([180,0,0]) 
				LargeFairing_PJ_Clip_Socket(Fairing_OD=Fairing_OD, FairingWall_t=TubeWall_T);
			translate([0,0,12.5+PJ_Spacing*4]) rotate([180,0,0]) 
				LargeFairing_PJ_Clip_Socket(Fairing_OD=Fairing_OD, FairingWall_t=TubeWall_T);
		}else{
			// Spring
			if (IsLeftHalf==false) SpringSocket();
		
			translate([0,0,12.5]) rotate([180,0,0]){
				LargeFairing_PJ_Clip_Boss(Fairing_OD=Fairing_OD, FairingWall_t=TubeWall_T);
				LargeFairing_PJ_Clip_BoltPattern(Fairing_OD=Fairing_OD) Bolt4ClearHole();}
			translate([0,0,12.5+PJ_Spacing*2]) rotate([180,0,0]){
				LargeFairing_PJ_Clip_Boss(Fairing_OD=Fairing_OD, FairingWall_t=TubeWall_T);
				LargeFairing_PJ_Clip_BoltPattern(Fairing_OD=Fairing_OD) Bolt4ClearHole();}
			translate([0,0,12.5+PJ_Spacing*4]) rotate([180,0,0]){ 
				LargeFairing_PJ_Clip_Boss(Fairing_OD=Fairing_OD, FairingWall_t=TubeWall_T);
				LargeFairing_PJ_Clip_BoltPattern(Fairing_OD=Fairing_OD) Bolt4ClearHole();}
				
			translate([0,0,12.5+PJ_Spacing]) 
				LargeFairing_PJ_Clip_Socket(Fairing_OD=Fairing_OD, FairingWall_t=TubeWall_T);
			translate([0,0,12.5+PJ_Spacing*3]) 
				LargeFairing_PJ_Clip_Socket(Fairing_OD=Fairing_OD, FairingWall_t=TubeWall_T);
			
			// Tenons go here
			translate([0,0,Z1]) rotate([0,0,180]){ 
				LargeFairing_Tenon_Boss(Fairing_OD=Fairing_OD, FairingWall_t=TubeWall_T);
				LargeFairing_PJ_Clip_BoltPattern(Fairing_OD=Fairing_OD) Bolt4ClearHole();}
				
			translate([0,0,Z2]) rotate([0,0,180]){ 
				LargeFairing_Tenon_Boss(Fairing_OD=Fairing_OD, FairingWall_t=TubeWall_T);
				LargeFairing_PJ_Clip_BoltPattern(Fairing_OD=Fairing_OD) Bolt4ClearHole();}
		}
	} // diff
	
	// Hinge
	if (IsLeftHalf==false)
		translate([Fairing_OD/2-HingeInset,0,6]) cylinder(d=3, h=Len-12);
				
	//*
	// Sockets and Tenons
	difference(){
		union(){
			if (IsLeftHalf){
				translate([-Fairing_OD/2+MortiseOffset,6.5,Z1]) rotate([0,0,90]) Socket(H=M_H);
				translate([-Fairing_OD/2+MortiseOffset,6.5,Z2]) rotate([0,0,90]) Socket(H=M_H);
				
				// The spring pushes on this. Fixed 9/24/2022
				mirror([1,0,0]) 
					translate([Fairing_ID/2-F54_SpringEndCap_OD/2,0,Len/2])
						hull(){
							rotate([-90,0,0]) cylinder(d=14, h=1);
							translate([0,5,0]) sphere(d=10);
							
							translate([7,0,0]){
								rotate([-90,0,0]) cylinder(d=20,h=1);
								translate([0,5,0]) sphere(d=10);}
						} // hull
						
			} else {
			
				// Spring and SpringCap go in this. 
				rotate([0,0,180])
					translate([Fairing_ID/2-F54_SpringEndCap_OD/2,0, Len/2])
						hull(){
							rotate([-90,0,0]) cylinder(d=F54_SpringEndCap_OD+4, h=1);
							translate([0,F54_Spring_FL/2,0]) 
								sphere(d=F54_SpringEndCap_OD+4);
							
							translate([7,0,0]){
							rotate([-90,0,0]) cylinder(d=F54_SpringEndCap_OD+10,h=1);
							translate([0,F54_Spring_FL/2+4,0]) 
								sphere(d=F54_SpringEndCap_OD+10);}
						} // hull	
						
				
			} // if
		} // union
		
		// Spring
		if (IsLeftHalf==false) SpringSocket();
		
		// cable path
		translate([BallHole_X,6.5,Len/2]) 
			cylinder(d=JointPin_d+IDXtra*4, h=20, center=true);
		
		// Trim all to outside of fairing
		difference(){
			translate([0,0,-Overlap]) cylinder(d=Fairing_OD+35,h=Len+Overlap*2);
			
			
			translate([0,0,-Overlap*2]) 
				cylinder(d=Fairing_OD,h=Len+Overlap*4, $fn=$preview? 36:360);
		} // difference
	} // difference
	/**/
	
	if (IsLeftHalf) {
		translate([0,0,Len-21]) rotate([0,0,135]) LanyardToTube(ID=Fairing_ID, Foot=6);
	} else {
		translate([0,0,Len-21]) rotate([0,0,-135+180]) LanyardToTube(ID=Fairing_ID, Foot=6);
	}
	
} // LargeFairing

//translate([0,0,80.1]) NoseLockRing(Fairing_OD=BT137Body_OD, Fairing_ID =BT137Body_OD-4.4);
//LargeBolt_On_PJ_Clip(Fairing_OD=BT137Body_OD, FairingWall_t=2.2);
//LargeFairing_BoltOn_Tenon(Fairing_OD=BT137Body_OD, FairingWall_t=2.2);
/*
translate([0,0.2,0]) LargeFairing(IsLeftHalf=true, 
				Fairing_OD=BT137Body_OD,
				Wall_T=7,
				Len=80);
/**/

/*
LargeFairing(IsLeftHalf=false, 
				Fairing_OD=BT137Body_OD,
				Wall_T=7,
				Len=80);
/**/
		















