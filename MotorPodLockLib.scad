// ***********************************
// Project: 3D Printed Rocket
// Filename: MotorPodLockLib.scad
// by David M. Flynn
// Created: 11/27/2023 
// Revision: 0.9.2  12/2/2023 
// Units: mm
// ***********************************
//  ***** Notes *****
//
// Motor Pod Lock (MPL)
// Rear ejection system
// Curently only for a 4" pod in a 5.5" rocket.
//
//  ***** History *****
//
// 0.9.2  12/2/2023  Parameters!
// 0.9.1  11/28/2023 Needs cleanup, but works. Fixed insertion groove angle on inner race.
// 0.9.0  11/27/2023 Created library, copied from Rocket9Ball.scad
//
// ************************************
//  ***** for STL output *****
//
/*
// includes body tube section
 MPL_OuterRace(Body_ID=MPL_Body_ID,
		BallCircle_d=MPL_BallCircle_d, Ball_d=MPL_Ball_d, PreLoad=MPL_PreLoad, Race_w=MPL_Race_w,
		LockBallBC_d=MPL_LockBallBC_d, LockBall_d=MPL_LockBall_d, nLockBalls=MPL_nLockBalls,
		Race_OD=MPL_Race_OD, Race_ID=MPL_Race_ID,
		Shelf_t=MPL_Shelf_t, FCCoupler_Len=FCCoupler_Len); 
/**/
		
/*
// the moving part
MPL_InnerRace(ShowLocked=false, Body_ID=MPL_Body_ID,
			LockBallBC_d=MPL_LockBallBC_d, 
			LockBall_d=MPL_LockBall_d, 
			nLockBalls=MPL_nLockBalls, UnlockedBC_d=MPL_UnlockedBC_d, LockBall_Z=MPL_LockBall_Z,
			BallCircle_d=MPL_BallCircle_d, Ball_d=MPL_Ball_d, PreLoad=MPL_PreLoad,
			Race_w=MPL_Race_w, Race_ID=MPL_Race_ID, 
			Offset_Z=MPL_Offset_Z); 
/**/

/*
// holds lock balls in place
 MPL_LockBallRetainer(FixedTube_OD=MPL_FixedTube_OD, LockBallCircle_d=MPL_LockBallBC_d,
					LockBall_d=MPL_LockBall_d, LockBall_Z=MPL_LockBall_Z, 
					BallCircle_d=MPL_BallCircle_d, Ball_d=MPL_Ball_d, Race_w=MPL_Race_w,
					Shelf_t=MPL_Shelf_t, Body_ID=MPL_Body_ID, nBalls=MPL_nLockBalls); 	
/**/
// rotate([180,0,0]) MPL_LockRing(OD=MPL_InnerTube_OD, ID=MPL_InnerTube_ID, Ball_d=MPL_LockBall_d, nBalls=MPL_nLockBalls); // held/released by lock balls
//
// ************************************
//  ***** for Viewing *****
//
// ShowMPL(ShowLocked=true);
// MPL_ShowMyBalls(ShowLocked=false);
// ShowFixedBodyTube();
//
// ************************************
//
include<TubesLib.scad>
use<BearingLib.scad>
use<CommonStuffSAEmm.scad>

Vinyl_t=0.5;
FCCoupler_Len=10.6; // Fin can coupler length + 2 layers

//*
// Parameters for a 4" pod in a 5.5" rocket.
MPL_Ball_d=6; // 5/16*25.4;
MPL_LockBall_d=3/8*25.4; // 1/2*25.4;
MPL_nLockBalls=6;

MPL_InnerTube_OD=BT98Coupler_OD;
MPL_InnerTube_ID=BT98Coupler_ID;
MPL_FixedTube_OD=BT98Body_OD;
MPL_FixedTube_ID=BT98Body_ID;

MPL_BallCircle_d=BT137Coupler_ID-MPL_Ball_d-1;
MPL_Race_OD=BT137Body_OD+Vinyl_t;
MPL_Body_ID=BT137Body_ID;

MPL_Race_w=10;
/**/

/*
// Parameters for a 5.5" pod in a 7.5" rocket. Doesn't work yet, needs work.
MPL_Ball_d=5/16*25.4;
MPL_LockBall_d=1/2*25.4;
MPL_nLockBalls=6;

MPL_InnerTube_OD=BT137Coupler_OD;
MPL_InnerTube_ID=BT137Coupler_ID;
MPL_FixedTube_OD=BT137Body_OD;
MPL_FixedTube_ID=BT137Body_ID;

MPL_BallCircle_d=BT190Coupler_ID-MPL_Ball_d-1;
MPL_Race_OD=BT190Body_OD+Vinyl_t;
MPL_Body_ID=BT190Body_ID;

MPL_Race_w=12;
/**/

MPL_LockBallBC_d=MPL_InnerTube_OD-5+MPL_LockBall_d; // Locked position
MPL_UnlockedBC_d=MPL_InnerTube_OD+MPL_LockBall_d;

MPL_Offset_Z=6;           // Bearing balls to lock balls

MPL_LockBall_Z=MPL_Race_w/2+MPL_Offset_Z;
MPL_Race_ID=MPL_BallCircle_d-MPL_Ball_d-6;
MPL_PreLoad=-0.4; // -0.3 w/ 100% flow is too tight
MPL_Shelf_t=3;
	
Magnet_d=4.8;
Magnet_h=3.2;
Magnet_Z=22;

Dowel_d=4;
Dowel_L=10;

BearingMR84_OD=8;
BearingMR84_ID=4;
BearingMR84_W=3;



module ShowMPL(ShowLocked=false){

	//
	MPL_ShowMyBalls(ShowLocked=ShowLocked);
	//
	//
	color("Tan") MPL_InnerRace(ShowLocked=ShowLocked);
	//
	MPL_OuterRace();
	//
	color("Green") MPL_LockBallRetainer();
	//
	translate([0,0,11]) rotate([0,0,-7]) MPL_LockRing();
	//
	translate([0,0,-30]) color("LightBlue") Tube(OD=MPL_InnerTube_OD, ID=MPL_InnerTube_ID, Len=30, myfn=$preview? 90:360);
	//
	ShowFixedBodyTube();
	
} // ShowMPL

//ShowMPL();

module MPL_ShowMyBalls(ShowLocked=false){
	nBalls=36;
	UnlockOffset=ShowLocked? 0:2;
	
	for (j=[0:nBalls-1]) rotate([0,0,360/nBalls*j])
		translate([0,MPL_BallCircle_d/2,MPL_Race_w/2]) color("Orange") sphere(d=MPL_Ball_d, $fn=18);
		
	color("White") for (j=[0:MPL_nLockBalls-1]) rotate([0,0,360/MPL_nLockBalls*j])
		translate([0,MPL_LockBallBC_d/2+UnlockOffset,11])
			sphere(d=MPL_LockBall_d, $fn=36);		

} // MPL_ShowMyBalls

//MPL_ShowMyBalls();

module MPL_OuterRace(Body_ID=MPL_Body_ID,
		BallCircle_d=MPL_BallCircle_d, Ball_d=MPL_Ball_d, PreLoad=MPL_PreLoad, Race_w=MPL_Race_w,
		LockBallBC_d=MPL_LockBallBC_d, LockBall_d=MPL_LockBall_d, nLockBalls=MPL_nLockBalls,
		Race_OD=MPL_Race_OD, Race_ID=MPL_Race_ID,
		Shelf_t=MPL_Shelf_t, FCCoupler_Len=FCCoupler_Len){
					
	Race_w_Xtra=1; // sits on MPL_LockBallRetainer
	Inset_z=1;
	TopExtension=10;
	
	module CableRedirect(){
		ID=4;
		OD=7;
		R=10;
		
		rotate([0,0,-16])
		translate([-BallCircle_d/2,0,28])
		rotate([0,90,0])
		difference(){
			intersection(){
				union(){
					rotate_extrude() translate([R,0,0]) circle(d=OD);
					
					translate([R-1,0,-OD/2-1]) cube([OD/2+5,R,OD-1]);
				} // union
				
				// keep 1/4
				translate([0,0,-(OD+2)/2]) cube([R+OD/2+4,R+OD/2,OD+2]);
			} // intersection
			
			rotate_extrude() translate([R,0,0]) circle(d=ID);
		} // difference
	} // CableRedirect
	
	//CableRedirect();
	
	module ManualLockHole(){
		translate([-BallCircle_d/2,0,Race_w+Race_w_Xtra+3]) 
			rotate([90,0,0]) cylinder(d=2, h=200, center=true);
	} // ManualLockHole
	
	//ManualLockHole();
	
	module Stop(){
		Magnet_d=3/16*25.4;
		Magnet_Len=1/8*25.4;
		
		Len=Magnet_Len;
		
		Cable_Y=Race_ID/2+4;
		
		difference(){
			union(){
				hull(){
					translate([0,Cable_Y,Magnet_Z]) 
						rotate([0,90,0]) cylinder(d=10, h=Len);
					translate([0,Cable_Y+4,Magnet_Z-6]) 
						rotate([0,90,0]) cylinder(d=7, h=Len);
					translate([0,Cable_Y+4,Magnet_Z]) 
						rotate([0,90,0]) cylinder(d=7, h=Len);
				} // hull
				hull(){
					translate([0,BallCircle_d/2,Race_w-1]) cube([8,5,1]);
					translate([0,Cable_Y+4,Magnet_Z-6]) 
						rotate([0,90,0]) cylinder(d=7, h=Len);
				} // hull
			} // union
			
			translate([0,Cable_Y,Magnet_Z]) rotate([0,90,0]) 
				translate([0,0,-Overlap]) cylinder(d=Magnet_d, h=Len+Overlap*2);
			
			
			translate([0,0,-10]) cylinder(d=LockBallBC_d+LockBall_d, h=40, $fn=$preview? 90:360);
		} // difference
	} // Stop
	
	// part of fincan
	difference(){
		union(){
			for (j=[0:1]) rotate([0,0,180*j]) {
				rotate([0,0,20-3]) Stop(); // unlocked
				rotate([0,0,20+3+12]) mirror([1,0,0]) Stop(); // locked
			}
			
			for (j=[0:1]) rotate([0,0,180*j]) CableRedirect();
			
			translate([0,0,Race_w]) rotate([0,180,5]) 
				OnePieceOuterRace(BallCircle_d=BallCircle_d, Race_OD=Race_OD, 
									Ball_d=Ball_d, Race_w=Race_w+Race_w_Xtra, 
									PreLoadAdj=PreLoad, VOffset=-Race_w_Xtra/2, 
									BI=true, myFn=$preview? 90:360);
					
			// Tube section, sits on top of fincan
			translate([0,0,-Race_w_Xtra-Shelf_t-FCCoupler_Len])
				Tube(OD=Race_OD, ID=Body_ID, 
						Len=FCCoupler_Len+Shelf_t+Race_w+Race_w_Xtra, 
						myfn=$preview? 90:360);
						
			// Extended tube for manual lock/unlock driver
			translate([0,0,Race_w+Race_w_Xtra-Overlap])
				Tube(OD=Race_OD, ID=Race_OD-6, 
						Len=TopExtension+Overlap, 
						myfn=$preview? 90:360);
						
			//*
			// integrated coupler
			translate([0,0,Race_w-Overlap])
				Tube(OD=Body_ID-IDXtra, ID=Body_ID-4, Len=10+TopExtension, 
						myfn=$preview? 90:360);
			/**/
			// Keying
			intersection(){
				for (j=[0:nLockBalls-1]) rotate([0,0,360/nLockBalls*j])
					translate([0,Body_ID/2,-Race_w_Xtra-Shelf_t]) cylinder(d=7, h=Shelf_t+1);
				
				translate([0,0,-Race_w_Xtra-Shelf_t]) cylinder(d=Race_OD-1, h=Shelf_t+1);
			} // intersection
		} // union
		
		ManualLockHole();
		
		if ($preview) rotate([0,0,180]) translate([0,0,-20]) cube([100,100,100]);
	} // difference

	// Ball backstop
	difference(){
		translate([0,0,Race_w-Inset_z]) 
			cylinder(d=Race_OD, h=2, $fn=$preview? 90:360);
		
		translate([0,0,Race_w-Inset_z-Overlap]) 
			cylinder(d=BallCircle_d-2, h=2+Overlap*2, $fn=$preview? 90:360);
			
		
		
		if ($preview) rotate([0,0,180]) translate([0,0,-20]) cube([100,100,100]);
	} // difference
	
} // MPL_OuterRace

// MPL_OuterRace(FCCoupler_Len=0);

module MPL_InnerRace(ShowLocked=false, Body_ID=MPL_Body_ID,
			LockBallBC_d=MPL_LockBallBC_d, 
			LockBall_d=MPL_LockBall_d, 
			nLockBalls=MPL_nLockBalls, UnlockedBC_d=MPL_UnlockedBC_d, LockBall_Z=MPL_LockBall_Z,
			BallCircle_d=MPL_BallCircle_d, Ball_d=MPL_Ball_d, PreLoad=MPL_PreLoad,
			Race_w=MPL_Race_w, Race_ID=MPL_Race_ID, 
			Offset_Z=MPL_Offset_Z){
			
	$fn=$preview? 90:360;
	
	Xtra_Z=1;
	OAH=Race_w+Offset_Z+Xtra_Z;
	
	Locked_a=3;
	UnLocked_a=-11;
	Rot_a=ShowLocked? Locked_a:UnLocked_a;
	
	
	module CableEnd(){
		CableHole_d=1.4;
		CableEndHole_d=3.4;
		Len=10;
		Cable_Z=19;
		Cable_Y=Race_ID/2+4;
		
		difference(){
			hull(){
				translate([0,Cable_Y,Cable_Z]) rotate([0,90,0]) cylinder(d=12, h=Len);
				translate([0,Cable_Y+5,Cable_Z-6]) rotate([0,90,0]) cylinder(d=2, h=Len);
				translate([0,Cable_Y,Cable_Z-6]) rotate([0,90,0]) cylinder(d=2, h=Len);
			} // hull
				
			
			translate([0,Cable_Y,Cable_Z]) rotate([0,90,0]) 
				translate([0,0,-Overlap]) cylinder(d=CableHole_d, h=Len+Overlap*2);
			translate([0,Cable_Y,Cable_Z]) rotate([0,90,0]) 
				translate([0,0,-4]) cylinder(d=CableEndHole_d, h=Len);
			
			// Trim inside
			translate([0,0,-10]) 
				cylinder(d=LockBallBC_d+LockBall_d, h=40, $fn=$preview? 90:360);
				
			// Trim outside
			translate([0,0,-10]) difference(){
				cylinder(d=Body_ID, h=40, $fn=$preview? 90:360);
				
				translate([0,0,-Overlap])
					cylinder(d=Body_ID-5, h=40+Overlap*2, $fn=$preview? 90:360);
			} // difference
				
			//translate([-1,Cable_Y+3,Cable_Z-6]) cube([12,5,12]);
		} // difference
	} // CableEnd
	
	module Stop(){
		Magnet_d=3/16*25.4;
		Magnet_Len=1/8*25.4;
		
		Len=Magnet_Len;

		Cable_Y=Race_ID/2+4;
		
		difference(){
			hull(){
				translate([0,Cable_Y,Magnet_Z]) rotate([0,-90,0]) cylinder(d=10, h=Len, center=true);
				translate([0,Cable_Y-2,Magnet_Z-4]) rotate([0,-90,0]) cylinder(d=9, h=Len, center=true);
				
			} // hull
			
			translate([0,Cable_Y,Magnet_Z]) rotate([0,-90,0]) 
				cylinder(d=Magnet_d, h=Len+Overlap*2, center=true);
			
			
			translate([0,0,-10]) cylinder(d=LockBallBC_d+LockBall_d, h=40, $fn=$preview? 90:360);
		} // difference
	} // Stop
	
	for (j=[0:1]) rotate([0,0,180*j]){
		rotate([0,0,30+Rot_a]) Stop();
		rotate([0,0,100+Rot_a]) CableEnd();
	}
	
	difference(){
		union(){
			translate([0,0,Race_w+Offset_Z+Xtra_Z]) rotate([0,180,3]) // The 3 aligns ball insertions
				OnePieceInnerRace(BallCircle_d=BallCircle_d, 
					Race_ID=Race_ID, Ball_d=Ball_d,
						Race_w=OAH, 
						PreLoadAdj=PreLoad, 
						VOffset=(Offset_Z+Xtra_Z)/2, BI=true, myFn=$preview? 90:360);
			// Inner ring
			
			difference(){
				cylinder(d=Race_ID+1, h=OAH, $fn=$preview? 90:360);
					
				translate([0,0,-Overlap])
					cylinder(d=LockBallBC_d+LockBall_d, 
							h=OAH+Overlap*2, $fn=$preview? 90:360);
			} // difference
			
		} // union
		
		// Trim top
		translate([0,0,OAH-3]) 
		difference(){
			cylinder(d=BallCircle_d, h=3+Overlap);
			
			translate([0,0,-Overlap]) 
				cylinder(d1=BallCircle_d-Ball_d*0.7, d2=Race_ID+4, h=3+Overlap*3);
		} // difference
		
		Travel=(UnlockedBC_d-LockBallBC_d+IDXtra*2)/20;
		echo(Travel=Travel);
		
		translate([0,0,LockBall_Z]) rotate([0,0,Rot_a])
			for (j=[0:nLockBalls-1]) rotate([0,0,360/nLockBalls*j])
				for (k=[0:10]) hull(){
					rotate([0,0,k]) translate([0, LockBallBC_d/2+Travel*k,0]) 
						sphere(d=LockBall_d+0.6, $fn=24);
					rotate([0,0,k+1]) translate([0, LockBallBC_d/2+Travel*(k+1),0]) 
						sphere(d=LockBall_d+0.6, $fn=24);
				} // hull
		
		if ($preview) rotate([0,0,180]) translate([0,0,-Overlap]) cube([100,100,100]);
	} // difference
	
} // MPL_InnerRace

//rotate([0,0,3]) MPL_InnerRace(ShowLocked=false);

module MPL_LockBallRetainer(FixedTube_OD=MPL_FixedTube_OD, LockBallCircle_d=MPL_LockBallBC_d, LockBall_d=MPL_LockBall_d, LockBall_Z=MPL_LockBall_Z, 
			BallCircle_d=MPL_BallCircle_d, Ball_d=MPL_Ball_d, Race_w=MPL_Race_w, Shelf_t=MPL_Shelf_t, Body_ID=MPL_Body_ID, nBalls=MPL_nLockBalls){
			
	H=LockBall_d+6+5+3;
	OD=LockBallCircle_d+LockBall_d-1;
	Shelf_Z=-4.0;
	Retension_w=2;
	
	difference(){
		union(){
			translate([0,0,Shelf_Z]) 
				cylinder(d=OD, h=H, $fn=$preview? 90:360);

			translate([0,0,Shelf_Z]) cylinder(d=Body_ID-IDXtra*3, h=Shelf_t, $fn=$preview? 90:360);
			// Ball retension
			BR_h=Shelf_t+Race_w/2-Ball_d/2+0.5;
			translate([0,0,Shelf_Z])
			difference(){
				cylinder(d=BallCircle_d+Retension_w, h=BR_h);
				translate([0,0,-Overlap]) cylinder(d=BallCircle_d-Retension_w, h=BR_h+Overlap*2);
			} // difference
		} // union
				
		// Center hole
		translate([0,0,Shelf_Z-Overlap]) 
			cylinder(d=FixedTube_OD+IDXtra*3, h=H+Overlap*2, $fn=$preview? 90:360);
		
		for (j=[0:nBalls-1]) rotate([0,0,360/nBalls*j]) {
			translate([0, FixedTube_OD/2, LockBall_Z]) 
				rotate([90,0,0]) cylinder(d=LockBall_d+IDXtra*3, h=20, center=true);
		
			// Keying notches
			translate([0, Body_ID/2, Shelf_Z-Overlap]) cylinder(d=8, h=Shelf_t+Overlap*2);
		}
				
		if ($preview) rotate([0,0,180]) translate([0,0,-50]) cube([100,100,100]);
	} // difference
} // MPL_LockBallRetainer

//MPL_LockBallRetainer();

module MPL_LockRing(OD=MPL_InnerTube_OD, ID=MPL_InnerTube_ID, Ball_d=MPL_LockBall_d, nBalls=MPL_nLockBalls){

	OAL=Ball_d*2+15;
	Wall_t=5;
	Slot_w=Ball_d-0.5;
	
	module BallPath(){
		a=14;
		Slope=1;
		Depth=3.2;
		
		for (j=[0:a*2]) translate([0,0,-Slope/2+Slope/(a*2)*j]) hull(){
			rotate([0,0,a/20*j]) translate([0,OD/2+Overlap,0]) 
				rotate([90,0,0]) cylinder(d=Slot_w, h=Depth);
			rotate([0,0,a/20*(j+1)]) translate([0,OD/2+Overlap,0])
				rotate([90,0,0]) cylinder(d=Slot_w, h=Depth);
		} // hull
	} // BallPath
	
	difference(){
		translate([0, 0, -Ball_d-15]) cylinder(d=OD, h=OAL, $fn=$preview? 90:360);
		
		for (j=[0:nBalls-1]) rotate([0,0,360/nBalls*j]) BallPath();
		
		// Center hole
		translate([0,0,-Ball_d-15-Overlap]) cylinder(d=ID-Wall_t*2, h=OAL+Overlap*2, $fn=$preview? 90:360);
		
		//Glue face
		difference(){
			translate([0,0,-Ball_d-15-Overlap]) 
				cylinder(d=OD+1, h=15+Overlap);
			
			translate([0,0,-Ball_d-15-Overlap*2]) 
				cylinder(d=ID, h=15+Overlap*3, $fn=$preview? 90:360);
		} // difference
		
		translate([0,0,-Ball_d-15-Overlap]) cylinder(d1=ID-Wall_t, d2=ID-Wall_t*2-Overlap, h=Wall_t);
		
		if ($preview) rotate([0,0,180]) translate([0,0,-30]) cube([OD/2+5,OD/2+5,100]);
	} // difference

} // MPL_LockRing

// MPL_LockRing();

/*
translate([0,0,10]) rotate([0,0,-7]) MPL_LockRing();
translate([0,0,-30]) color("LightBlue") Tube(OD=MPL_InnerTube_OD, ID=MPL_InnerTube_ID, Len=30, myfn=$preview? 90:360);
/**/


// fixed body tube
module ShowFixedBodyTube(){

difference(){
	translate([0,0,-50]) color("LightBlue")
		Tube(OD=MPL_FixedTube_OD, ID=MPL_FixedTube_ID, Len=100, myfn=$preview? 90:360);
		
	for (j=[0:MPL_nLockBalls-1]) rotate([0,0,360/MPL_nLockBalls*j])
		translate([0,MPL_InnerTube_ID/2+MPL_LockBall_d/2-1,11])
			sphere(d=MPL_LockBall_d+1, $fn=18);
	
	if ($preview) rotate([0,0,180]) translate([0,0,-20]) cube([100,100,100]);
} // difference
} // ShowFixedBodyTube

// ShowFixedBodyTube();





































