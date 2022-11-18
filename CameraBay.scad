// ***********************************
// Project: 3D Printed Rocket
// Filename: CameraBay.scad
// by David M. Flynn
// Created: 11/17/2022 
// Revision: 0.9.1 11/18/2022
// Units: mm
// ***********************************
//  ***** Notes *****
//
// Camera Bay for RunCam Scope Cam 2 4K 40mm
//
//  ***** History *****
//
// 0.9.1 11/18/2022   Added Offset to ScopeRail
// 0.9.0 11/17/2022   First code.
//
// ***********************************
//  ***** for STL output *****
//
// CameraBay(Tube_OD=PML98Body_OD, Tube_ID=PML98Body_ID);
// ScopeRail(Len=45, Offset=2);
// Cam_Door(Tube_OD=PML98Body_OD);
//
// ***********************************
//  ***** Routines *****
//
// CamMountBoltPattern();
// Cam_BayFrameHole(Tube_OD=PML98Body_OD);
// CamDoorHole(Tube_OD=PML98Body_OD);
// Cam_DoorBoltPattern(Tube_OD=PML98Body_OD);
// Cam_BayDoorFrame(Tube_OD=PML98Body_OD, Tube_ID=PML98Body_ID, ShowDoor=false);
//
// ***********************************
//  ***** for Viewing *****
//
// RunCamScopeCam4K40();
// ShowCamAndMount();
// 
// ***********************************

include<TubesLib.scad>
include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2; 
$fn=$preview? 24:90;

Bolt4Inset=4;

Cam_a=-65; // 15° from vertical
CamPlate_Z=-8.5;

CamMount_Z=133;
CamOffset_Y=8;
CamOffset_Z=4;
CamDoor_Y=110;
CamDoor_X=44;

module CamMountBoltPattern(){
	BoltCenter_X=25.4;
	BoltCenter_Y=25.4;
	
	translate([-BoltCenter_X/2,-BoltCenter_Y/2,0]) children();
	translate([-BoltCenter_X/2,BoltCenter_Y/2,0]) children();
	translate([BoltCenter_X/2,-BoltCenter_Y/2,0]) children();
	translate([BoltCenter_X/2,BoltCenter_Y/2,0]) children();
} // CamMountBoltPattern

module ScopeRail(Len=45, Offset=2){
	Width=22.5;
	H=5.75;
	XZ=4.06;
	
	translate([0,0,5.5]) //move bottom of plate to Z0.0
	difference(){
		union(){
			hull(){
				translate([-Width/2+H/2,0,0]) rotate([0,45,0]) cube([XZ,Len,XZ], center=true);
				translate([Width/2-H/2,0,0]) rotate([0,45,0]) cube([XZ,Len,XZ], center=true);
			} // hull
			translate([0,0,-1.5-2.5]) cube([33,Len,3],center=true);
		} // union
		
		for (j=[0:Len/8-1]) translate([-Width/2,-Len/2+8*(j+0.5)+Offset,0.6]) cube([Width,4,H]);
			
		translate([0,0,-2.5]) CamMountBoltPattern() Bolt4ButtonHeadHole();
		
	} // difference

} // ScopeRail

//ScopeRail();

module RunCamScopeCam4K40(){
	Cam_X=33;
	CamBody_Y=66;
	CamBody_Z=27.5;
	CamOA_Y=114;
	CamLens_d=26;
	CamLens_Z=CamLens_d/2+1;
	
	translate([-Cam_X/2,0,1]) cube([Cam_X,CamBody_Y,CamBody_Z]);
	translate([0,0,CamLens_Z]) rotate([-90,0,0]) cylinder(d=CamLens_d, h=CamOA_Y);
	
	// controls
	translate([0,16,1+CamBody_Z-Overlap])
		hull(){
			cylinder(d=18, h=2.7);
			translate([0,26,0]) cylinder(d=18, h=2.7);
		}
		
	// rail mount
	translate([-Cam_X/2,10,-6]) cube([Cam_X,40,7.1]);
} // RunCamScopeCam4K40

module ShowCamAndMount(){
	translate([0,-10,CamMount_Z]) rotate([Cam_a,0,0]){
		color("Gray") RunCamScopeCam4K40();
		translate([0,30,CamPlate_Z]) ScopeRail(Len=45);
}} // ShowCamAndMount


//translate([0,CamOffset_Y,CamOffset_Z]) ShowCamAndMount();

module Cam_BayFrameHole(Tube_OD=PML98Body_OD){
	Tube_Len=CamDoor_Y+2;
	Door_Y=CamDoor_Y;
	Door_X=CamDoor_X;
	
	translate([0,-Tube_OD/2+10,0]) rotate([90,0,0]) 
			RoundRect(X=Door_X+5, Y=Tube_Len-1, Z=15, R=0.1);
	
	translate([0,-Tube_OD/2+20,0]) rotate([90,0,0]) 
			RoundRect(X=Door_X-2, Y=Tube_Len-1, Z=20, R=0.1);
} // Cam_BayFrameHole

//Cam_BayFrameHole();

module CamDoorHole(Tube_OD=PML98Body_OD){
	Door_Y=CamDoor_Y+1;
	Door_X=CamDoor_X+1;
	Door_t=3.7;
	
	intersection(){
		translate([0,-Door_Y/2,0]) rotate([-90,0,0]) 
			Tube(OD=Tube_OD+1, ID=Tube_OD-Door_t*2, Len=Door_Y, myfn=$preview? 36:360);
		RoundRect(X=Door_X, Y=Door_Y, Z=Tube_OD, R=4+0.5);
	} // intersection
} // CamDoorHole

//CamDoorHole();

module Cam_DoorBoltPattern(Tube_OD=PML98Body_OD){
	Door_Y=CamDoor_Y;
	Door_X=CamDoor_X;
	DoorBolt_a=asin((Door_X/2)/(Tube_OD/2))-asin(Bolt4Inset/(Tube_OD/2));
	
	rotate([0,DoorBolt_a,0]) translate([0,Door_Y/2-4,Tube_OD/2]) children();
	rotate([0,DoorBolt_a,0]) translate([0,-Door_Y/2+4,Tube_OD/2]) children();
	rotate([0,DoorBolt_a,0]) translate([0,0,Tube_OD/2]) children();
	
	mirror([1,0,0]){
		rotate([0,DoorBolt_a,0]) translate([0,0,Tube_OD/2]) children();
		rotate([0,DoorBolt_a,0]) translate([0,Door_Y/2-4,Tube_OD/2]) children();
		rotate([0,DoorBolt_a,0]) translate([0,-Door_Y/2+4,Tube_OD/2]) children();
	} // mirror
} // Cam_DoorBoltPattern

//Cam_DoorBoltPattern(Tube_OD=PML98Body_OD) Bolt4Hole();

module Cam_BayDoorFrame(Tube_OD=PML98Body_OD, Tube_ID=PML98Body_ID, ShowDoor=false){
	Tube_Len=CamDoor_Y+7;
	Door_Y=CamDoor_Y;
	Door_X=CamDoor_X;
	Door_t=3;
	BoltBossInset=10.5+2;
	
	difference(){
		union(){
			// Tube section
			intersection(){
				translate([0,0,-Tube_Len/2])
					Tube(OD=Tube_OD, ID=Tube_ID, Len=Tube_Len, myfn=$preview? 36:360);
				rotate([90,0,0]) 
						RoundRect(X=Door_X+22, Y=Tube_Len, Z=Tube_OD, R=0.1);
			} // intersection
			
			// Door frame
			intersection(){
				translate([0,0,-Door_Y/2-3]) 
					Tube(OD=Tube_OD-1, ID=Tube_ID-9, Len=Door_Y+6, myfn=$preview? 36:360);
					
				hull(){
					translate([0,-Tube_ID/2+12,0]) rotate([90,0,0]) 
						RoundRect(X=Door_X+3, Y=Door_Y+3, Z=Tube_OD, R=4+3);
					translate([0,-Tube_ID/2,0]) rotate([90,0,0]) 
						RoundRect(X=Tube_ID*2, Y=Door_Y+8, Z=Tube_OD, R=4+3);
				} // hull
			} // intersection
		} // union
		
		rotate([90,0,0]) RoundRect(X=Door_X-4, Y=Door_Y-4, Z=Tube_OD, R=4-2);
		
		rotate([90,0,0]) CamDoorHole(Tube_OD=Tube_OD);
	} // difference
	
	// Door Bolts
	difference(){
		// Bolt bosses
		intersection(){
			// trim outside
			translate([0,0,-Door_Y/2-3]) 
					Tube(OD=Tube_OD-1, ID=Tube_ID-9, Len=Door_Y+6, myfn=$preview? 90:360);
				
			// trim inside
			hull(){
				translate([0,-Tube_ID/2+12,0]) rotate([90,0,0]) 
					RoundRect(X=Door_X+3, Y=Door_Y+3, Z=Tube_OD, R=4+3);
				translate([0,-Tube_ID/2,0]) rotate([90,0,0]) 
					RoundRect(X=Tube_ID*2, Y=Door_Y+8, Z=Tube_OD, R=4+3);
			} // hull
		
			
			rotate([90,0,0]) 
				Cam_DoorBoltPattern(Tube_OD=Tube_OD) translate([0,0,-6.5]) hull(){
					cylinder(d=Bolt4Inset*2, h=6);
					translate([Bolt4Inset+2,0,0]) cylinder(d=Bolt4Inset*2+2, h=6);
				}
			
		} // intersection
		
		rotate([90,0,0]) CamDoorHole(Tube_OD=Tube_OD);
		
		// mounting bolts
		rotate([90,0,0]) 
			Cam_DoorBoltPattern(Tube_OD=Tube_OD) Bolt4Hole();
		
	} // difference
	
	if ($preview&&ShowDoor) rotate([90,0,0]) Cam_Door(Tube_OD=Tube_OD);
	
} // Cam_BayDoorFrame

//Cam_BayDoorFrame(ShowDoor=false);


module Cam_Door(Tube_OD=PML98Body_OD){
	Door_Y=CamDoor_Y;
	Door_X=CamDoor_X;
	Door_t=3;
	BoltBossInset=2; // was 3, use 2 to clear 54mm motor tube w/ 98mm body tube
	Cam_Offset_Y=Door_Y/2-68;
	
	
	difference(){
		union(){
			// a section of tube
			intersection(){
				translate([0,-Door_Y/2,0]) rotate([-90,0,0]) 
					Tube(OD=Tube_OD, ID=Tube_OD-Door_t*2, Len=Door_Y, myfn=$preview? 36:360);
				
				RoundRect(X=Door_X, Y=Door_Y, Z=Tube_OD, R=4);
			} // intersection
			
			difference(){
				union(){
					hull(){
						translate([0,50,18]) rotate([-Cam_a,0,0]) cylinder(d=32, h=100);
						translate([0,50,18]) rotate([-Cam_a,0,0]) translate([0,-10,0]) cylinder(d=34, h=100);
					} //hull
					
					hull(){
						translate([-19,50,0]) rotate([-Cam_a,0,0]) translate([0,0,39]) cube([38,34,21]);
						translate([-11,50,0]) rotate([-Cam_a,0,0]) translate([0,0,31]) cube([22,37,21]);
						translate([0,50,18]) rotate([-Cam_a,0,0]) translate([0,0,61]) cylinder(d=32, h=1);
					} // hull
					
					translate([-19,50,0]) rotate([-Cam_a,0,0]) cube([38,34,60]);
					translate([-11,50,0]) rotate([-Cam_a,0,0]) cube([22,37,52]);
				} // union
				translate([0,-Door_Y/2-5,0]) rotate([-90,0,0]) cylinder(d=Tube_OD-1, h=Door_Y+20);
			} // difference
			
			
		} // union
	
		hull(){
			translate([0,50,18]) rotate([-Cam_a,0,0]) cylinder(d=27, h=101);
			translate([0,50,18]) rotate([-Cam_a,0,0])  translate([0,-10,0]) cylinder(d=27, h=101);
		} // hull
		translate([-17,50,0]) rotate([-Cam_a,0,0]) cube([34,31,58]);
		translate([-11,50,0]) rotate([-Cam_a,0,0]) cube([22,34,50]);

		// Door mounting bolts
		Cam_DoorBoltPattern(Tube_OD=Tube_OD)  translate([0,0,1.5]) Bolt4ButtonHeadHole();//Bolt4ClearHole();
	} // difference

} // Cam_Door

//translate([0,0,162/2]) rotate([0,0,180]) rotate([90,0,0]) Cam_Door();

module CameraBay(Tube_OD=PML98Body_OD, Tube_ID=PML98Body_ID){
	Tube_Len=162;
	Rod_CL_r=1.5*25.4;
	Rod_d=4+IDXtra;
	
	difference(){
		union(){
			Tube(OD=Tube_OD, ID=Tube_ID, Len=Tube_Len, myfn=$preview? 90:360);
			
			intersection(){
				translate([0,-10+CamOffset_Y,CamMount_Z+CamOffset_Z]) rotate([Cam_a,0,0]) 
					translate([-Tube_OD/2,5,CamPlate_Z-8]) cube([Tube_OD,80,8]);
				cylinder(d=Tube_OD-1, h=Tube_Len);
			}
		} // union
		
		translate([0,0,Tube_Len/2]) rotate([0,0,180]) Cam_BayFrameHole();
		
		translate([0,-10+CamOffset_Y,CamMount_Z+CamOffset_Z]) rotate([Cam_a,0,0])
			translate([0,30,CamPlate_Z]) CamMountBoltPattern() Bolt4Hole();
		
		// Threaded rods
		translate([Rod_CL_r,0,0]) cylinder(d=Rod_d, h=Tube_Len);
		translate([-Rod_CL_r,0,0]) cylinder(d=Rod_d, h=Tube_Len);
	} // difference
	
	translate([0,0,Tube_Len-20])
		rotate([0,180,0]) TubeStop(InnerTubeID=PML98Coupler_ID, OuterTubeOD=Tube_OD, myfn=$preview? 36:360);
	
	translate([0,0,20])
		TubeStop(InnerTubeID=PML98Coupler_ID, OuterTubeOD=Tube_OD, myfn=$preview? 36:360);
	
	translate([0,0,Tube_Len/2]) rotate([0,0,180]) Cam_BayDoorFrame(ShowDoor=false);
} // CameraBay

//CameraBay(Tube_OD=PML98Body_OD, Tube_ID=PML98Body_ID);





