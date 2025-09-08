// ***********************************
// Project: 3D Printed Rocket
// Filename: BoosterDropperLib.scad
// by David M. Flynn
// Created: 9/2/2022 
// Revision: 0.9.9  9/5/2025
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  Booster Dropper for strap on boosters. 
//  This is the mechanism for retaining and dropping strap-on boosters.
//
//  ***** History *****
//
echo("BoosterDropperLib 0.9.9");
// 0.9.9  9/5/2025  Now ball bearing only. Added ShowLockingThrustPoint()
// 0.9.8  9/15/2023 Added 1/4-20 threads to BoosterButton for extra strength
// 0.9.7  9/14/2023 Added function BD_ThrustRing_h()
// 0.9.6  9/26/2022 Modified for HS5645MG servo
// 0.9.5  9/25/2022 Added ServoGear. 
// 0.9.4  9/9/2022  Modified for 6805 ball bearing.
// 0.9.3  9/8/2022  Added XtraLen to BoosterButton.
// 0.9.2  9/4/2022  Nearly ready to test. 
// 0.9.1  9/3/2022  Lowered bearing 0.5mm.
// 0.9.0  9/2/2022  First code.
//
// ***********************************
//  ***** for STL output *****
//
// BoosterThrustRing(MtrTube_OD=PML38Body_OD, BodyTube_OD=PML54Body_OD); // Print 2 per booster
// BoosterButton(XtraLen=0.3); // Print 2 per booster
// BB_ThrustPoint(BodyTube_OD=PML98Body_OD, BoosterBody_OD=PML54Body_OD); // Print 1 per booster, incorperate into lower fin can
// BB_LockingThrustPoint(BodyTube_OD=PML98Body_OD, BoosterBody_OD=PML54Body_OD); // Print 1 per booster, incorperate into rocket body
// BB_Lock(); // Print 1 per booster
// BB_BearingStop(); // Only used with ball bearing
// rotate([180,0,0]) BB_LockShaft(Len=50, nTeeth=24, Gear_z=14);
// rotate([180,0,0]) ServoGear(nTeeth=24);

// DrivenGear(Hub_Len=5);
//
// ***********************************
//  ***** Routines *****
//
// LighteningHole(H=10, W=8, L=50);
// BB_ThrustPoint_Hole(Swell=-Overlap);
// BB_LTP_Hole(BodyTube_OD=PML98Body_OD);
// BB_Gear();
// BB_LockStop(Len=50, Extra_H=2);
//
// ***********************************
//  ***** for Viewing *****
//
// ShowLockingThrustPoint();
//
// ***********************************

use<ThreadLib.scad>
include<involute_gears.scad>
include<TubesLib.scad>
include<BearingLib.scad>
 //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

LooseFit=IDXtra*3;
// Ball Bearing 6805-2RS
BB6805_2RS_ID=25;
BB6805_2RS_OD=37;
BB6805_2RS_H=7;

BoosterButtonMinor_d=12.7;
BoosterButtonMajor_d=20;
BoosterButtonPost_h=5;
BoosterButtonMajor_h=5;
BoosterButtonTrans_h=(BoosterButtonMajor_d-BoosterButtonMinor_d)/3;
BoosterButtonOA_h=BoosterButtonMajor_h+BoosterButtonPost_h+BoosterButtonTrans_h;

function BoosterButtonOAH()=BoosterButtonOA_h;

Bolt4Inset=4;

//BB_Lock_Ball_d=6; // use airsoft pellets
BB_Lock_Wall_t=2.2;
BB_Lock_BallCircle_d=BoosterButtonMajor_d+BB_Lock_Wall_t*2+6;

Housing_OD=BB6805_2RS_OD+Bolt4Inset*4;
Race_ID=BB6805_2RS_ID-Bolt4Inset*4;
RaceBC_d=BB6805_2RS_OD+Bolt4Inset*2; //  BB_Lock_BallCircle_d+6+Bolt4Inset*2;

TopOfRace=-3.5; 

function BD_ThrustRing_h(Btn_d=BoosterButtonMinor_d)=Btn_d+6;

module ShowLockingThrustPoint(ShowLocked=true){
	module Bearing(){
		difference(){
			cylinder(d=BB6805_2RS_OD, h=BB6805_2RS_H);
			translate([0,0,-Overlap]) cylinder(d=BB6805_2RS_ID, h=BB6805_2RS_H+Overlap*2);
		} // difference
	} // Bearing
	
	module LockWithBearing(ShowLocked=true){
		Rot_a=ShowLocked? -90:90;
		
		rotate([0,0,Rot_a]){
			BB_Lock();
			translate([0,0,-10.6]) color("Red") Bearing();
			//translate([0,0,-12.7]) BB_BearingStop();
			translate([0,0,-12.7-3.1]) rotate([180,0,0]) DrivenGear();
		}
	} // LockWithBearing
	
	color("Tan") BoosterButton(XtraLen=0);
	
	//difference(){
		BB_LockingThrustPoint(BodyTube_OD=BT137Body_OD, BoosterBody_OD=ULine102Body_OD);
		//translate([0,0,-20]) cube([50,70,50]);
	//}
	LockWithBearing(ShowLocked=ShowLocked);
	
	//color("Green") BB_LTP_Hole();
} // ShowLockingThrustPoint

// translate([0,0,BT137Body_OD/2-12.4]) ShowLockingThrustPoint(ShowLocked=false);

module ShowRocketBody(){
	MountingBlock_X=Housing_OD+2.4;
	MountingBlock_Y=92;
	nBoosters=3;
	
	difference(){
		union(){
			translate([0,-30,0]) rotate([-90,0,0]) Tube(OD=BT137Body_OD, ID=BT137Body_ID, Len=100, myfn=$preview? 36:360);
			
			intersection(){
				translate([0,20,0]) rotate([90,0,0]) cylinder(d=BT137Body_OD-1, h=100, center=true);
				
				for (j=[0:nBoosters-1]) rotate([0,360/nBoosters*j,0]) 
				hull(){
					translate([-MountingBlock_X/2,15-50,BT137Body_OD/2-27]) cube([MountingBlock_X,MountingBlock_Y,1]);
					translate([-MountingBlock_X/2-10,15-50,BT137Body_OD/2]) cube([MountingBlock_X+20,MountingBlock_Y,1]);
				} // hull
			} // intersection
		} // union
		
		for (j=[0:nBoosters-1]) rotate([0,360/nBoosters*j,0]) 
			translate([0,0,BT137Body_OD/2-12.4]) BB_LTP_Hole();
	} // difference
	
	translate([0,-40,0]) rotate([-90,0,0]) color("LightBlue") Tube(OD=BT54Body_OD, ID=BT54Body_ID, Len=120, myfn=$preview? 36:360);
} // ShowRocketBody

// ShowRocketBody();

module BB_TopGearMount(){
	Bore_d=60;
	nBolts=6;
	BackPlate_t=5;
	Flange_t=3;
	
	BoltCircle_d=Bore_d+Bolt4Inset*2;
	Hub_d=Bore_d+Bolt4Inset*4;
	Flange_ID=Hub_d-6;

	difference(){
		translate([0,0,-BackPlate_t]) cylinder(d=Hub_d, h=BackPlate_t+Flange_t, $fn=$preview? 90:360);
			
		
		cylinder(d=Flange_ID+IDXtra, h=Flange_t+Overlap, $fn=$preview? 90:360);
		translate([0,0,-BackPlate_t-Overlap]) cylinder(d=Bore_d, h=Flange_t+BackPlate_t+Overlap*2, $fn=$preview? 90:360);
		
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) translate([0,Bore_d/2+Bolt4Inset,0]) Bolt4HeadHole();
	} // difference
	
	
} // BB_TopGearMount

//BB_TopGearMount();

module BB_TopRingGear(){
	Bore_d=60;
	nBolts=6;
	Flange_t=3;
	Gear_t=8;
	BoltCircle_d=Bore_d+Bolt4Inset*2;
	Hub_d=Bore_d+Bolt4Inset*4;
	Flange_ID=Hub_d-6;
	nTeeth=40;
	
	difference(){
		union(){
			BB_Gear(nTeeth=nTeeth, Thickness=Gear_t);
			
			translate([0,0,-Flange_t]) cylinder(d=Flange_ID, h=Flange_t+Overlap, $fn=$preview? 90:360);
		} // union
		
		translate([0,0,-Flange_ID-Overlap]) cylinder(d=Bore_d-1, h=Gear_t+Flange_ID+Overlap*2, $fn=$preview? 90:360);
		
	} // difference
	
	
} // BB_TopRingGear

// rotate([180,0,0]) translate([0,0,3]) BB_TopRingGear();

module BB_RingGear(){
/*
	bevel_gear (
		number_of_teeth=24,
		cone_distance=24.037,
		face_width=6,
		outside_circular_pitch=300,
		pressure_angle=22.5,
		clearance = 0.2,
		bore_diameter=5,
		gear_thickness = 5,
		backlash = 0,
		involute_facets=5,
		finish = bevel_gear_back_cone);
		/**/
		
	Bore_d=60;
	nBolts=6;
	BackPlate_t=3;
	
	difference(){
		union(){
			bevel_gear (
				number_of_teeth=48,
				cone_distance=48,
				face_width=6,
				outside_circular_pitch=300,
				pressure_angle=22.5,
				clearance = 0.2,
				bore_diameter=5,
				gear_thickness = 5,
				backlash = 0,
				involute_facets=5,
				finish = bevel_gear_back_cone);
			
			// Back plate
			translate([0,0,-6-BackPlate_t]) cylinder(d=Bore_d+Bolt4Inset*4, h=BackPlate_t+3, $fn=$preview? 90:360);
		} // union
			
		translate([0,0,-6-BackPlate_t-Overlap]) cylinder(d=Bore_d, h=30, $fn=$preview? 90:360);
			
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) translate([0, Bore_d/2+Bolt4Inset, -10]) rotate([180,0,0]) Bolt4Hole(depth=BackPlate_t+3);
	} // difference
} // BB_RingGear

/*
translate([0,-30,0]) rotate([-90,0,0]) {rotate([0,0,180/48]) 
BB_RingGear();
translate([0,0,-14.1]) BB_InnerRace(); 
translate([0,0,-14.1+5]) BB_BallSpacer();
translate([0,0,-14.1]) BB_OuterRace();
translate([0,0,-14.1-3]) rotate([180,0,0]) BB_TopGearMount();
translate([0,0,-14.1-3]) rotate([180,0,0]) translate([0,0,3]) BB_TopRingGear();}
nServoGearTeeth=20;
translate([0,-55-3,0]) rotate([0,60,0]) translate([0,0,300*(nServoGearTeeth+40)/360]) rotate([-90,0,0])  ServoGear2(nTeeth=nServoGearTeeth);
/**/
	
module ServoGear2(nTeeth=24){
	ServoWheel_d=20.84+IDXtra*2; // MG996R
	ServoWheel_h=4; //2.7;
	ServoBC_r=8;
	ServoBC2_r=8;
	//ServoWheel_d=23.75+IDXtra*2; // HS5645MG
	//ServoWheel_h=2.0;
	//ServoBC_r=17/2;
	//ServoBC2_r=20/2;
	
	difference(){
		BB_Gear(nTeeth=nTeeth);
		
		translate([0,0,-Overlap]) cylinder(d=ServoWheel_d, h=ServoWheel_h);
		translate([0,0,ServoWheel_h+5.3]){ // gear thickness
			for (j=[0:1]) rotate([0,0,180*j]) translate([ServoBC_r,0,0]) Bolt4HeadHole();
			for (j=[0:1]) rotate([0,0,180*j+90]) translate([ServoBC2_r,0,0]) Bolt4HeadHole();
			}
	} // difference
} // ServoGear2

//rotate([180,0,0]) ServoGear2(nTeeth=20);

module BB_InnerRace(){
	Ball_d=3/8*25.4;
	Race_w=10;
	BoltFrame_t=5;
	Race_t=2.2;
	Bore_d=60;
	nBolts=6;
	BoltCircle_d=Bore_d+Bolt4Inset*2;
	Gear_OD=Bore_d+Bolt4Inset*4;
	Race_ID=Gear_OD+1;
	BallCircle_d=Race_ID+Race_t*2+Ball_d;
	BearingPreload=-0.35;
	
	
	OnePieceInnerRace(BallCircle_d=BallCircle_d, Race_ID=Race_ID, Ball_d=Ball_d, Race_w=Race_w, 
						PreLoadAdj=BearingPreload, VOffset=0.00, BI=false, myFn=$preview? 90:720);
						
	difference(){
		cylinder(d=Race_ID+1, h=BoltFrame_t);
		
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) translate([0,BoltCircle_d/2,BoltFrame_t]) Bolt4ClearHole();
		translate([0,0,-Overlap]) cylinder(d=Bore_d, h=BoltFrame_t+Overlap*2, $fn=$preview? 90:360);
	} // difference
} // BB_InnerRace

//translate([0,0,-14.1]) BB_InnerRace();
// translate([0,0,-14.1+5])BB_BallSpacer();

module BB_OuterRace(){
	Ball_d=3/8*25.4;
	Race_w=10;
	BoltFrame_t=5;
	Race_t=2.2;
	Bore_d=60;
	nBolts=6;
	
	Gear_OD=Bore_d+Bolt4Inset*4;
	Race_ID=Gear_OD+1;
	BallCircle_d=Race_ID+Race_t*2+Ball_d;
	Race_OD=BallCircle_d+Ball_d+Race_t*2;
	BoltCircle_d=Race_OD+Bolt4Inset*2;
	Boss_OD=Race_OD+Bolt4Inset*4;
	BearingPreload=-0.35;

	OnePieceOuterRace(BallCircle_d=BallCircle_d, Race_OD=Race_OD, Ball_d=Ball_d, Race_w=Race_w, 
						PreLoadAdj=BearingPreload, VOffset=0.00, BI=false, myFn=$preview? 90:720);
						
	difference(){
		cylinder(d=Boss_OD, h=3, $fn=$preview? 90:360);
		
		translate([0,0,-Overlap]) cylinder(d=Race_OD-1, h=3+Overlap*2);
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) translate([0,BoltCircle_d/2,3]) Bolt4ClearHole();
	} // difference
} // BB_OuterRace

//translate([0,0,-14.1]) BB_OuterRace();

module BB_BallSpacer(){
	Ball_d=3/8*25.4;
	Race_w=10;
	BoltFrame_t=5;
	Race_t=2.2;
	Bore_d=60;
	nBolts=6;
	BoltCircle_d=Bore_d+Bolt4Inset*2;
	Gear_OD=Bore_d+Bolt4Inset*4;
	Race_ID=Gear_OD+1;
	BallCircle_d=Race_ID+Race_t*2+Ball_d;

	
	module TwoPartBoltedBallSpacer(BallCircle_d=72,Ball_d=7.9375,nBalls=14){ // 9.525
		// nBalls must be even
		Race_w=Ball_d+3.5;
		Race_depth=Ball_d*0.6;
		
		difference(){
			translate([0,0,-Race_w/2])cylinder(d=BallCircle_d+Race_depth,h=Race_w/2);
			
			cylinder(d=BallCircle_d-Race_depth,h=Race_w+Overlap*2,center=true);
			for (j=[0:nBalls-1]) rotate([0,0,360/nBalls*j]) translate([BallCircle_d/2,0,0]) sphere(d=Ball_d+IDXtra*2);
				
			// Bolt holes
			for (j=[0:nBalls/2]) {
				rotate([0,0,360/nBalls*(j*2)+180/nBalls]) translate([BallCircle_d/2,0,-4]) rotate([180,0,0])  Bolt2HeadHole();
				rotate([0,0,360/nBalls*(j*2+1)+180/nBalls]) translate([BallCircle_d/2,0,-Race_w/2]) rotate([180,0,0])  Bolt2Hole();
			}
		} // diff
	} // TwoPartBoltedBallSpacer
	
	TwoPartBoltedBallSpacer(BallCircle_d=BallCircle_d, Ball_d=Ball_d, nBalls=12);
} // BB_BallSpacer

// BB_BallSpacer();

module LighteningHole(H=10, W=8, L=50){
	R=1;
	hull(){
		translate([0,H/2-R,0]) cylinder(r=R, h=L);
		translate([0,-H/2+R,0]) cylinder(r=R, h=L);
		translate([-W/2+R,0,0]) cylinder(r=R, h=L);
		translate([W/2-R,0,0]) cylinder(r=R, h=L);
	} // hull
} // LighteningHole

//LighteningHole();

module BoosterThrustRing(MtrTube_OD=PML38Body_OD, BodyTube_OD=PML54Body_OD){
	OAL=BD_ThrustRing_h();
	//echo(MtrTube_OD=MtrTube_OD);
	
	difference(){
		union(){
			cylinder(d=BodyTube_OD, h=OAL, $fn=$preview? 90:360);
			translate([0,-BodyTube_OD/2,OAL/2])
				rotate([-90,0,0]) cylinder(d=BoosterButtonMinor_d, h=5);
		} // union
		
		//for (j=[7:17]) rotate([0,0,30*j]) translate([0,0,OAL/2]) 
		//	rotate([-90,0,0]) LighteningHole(H=OAL-6, W=8, L=50);
			
		translate([0,0,-Overlap]) cylinder(d=MtrTube_OD+IDXtra*3, h=OAL+Overlap*2);
		translate([0,0,3]) cylinder(d1=MtrTube_OD+IDXtra*3, d2=MtrTube_OD+IDXtra*5, h=1+Overlap*2);
		translate([0,0,OAL-4-Overlap]) cylinder(d2=MtrTube_OD+IDXtra*3, d1=MtrTube_OD+IDXtra*5, h=1+Overlap*2);
		translate([0,0,4]) cylinder(d=MtrTube_OD+IDXtra*5, h=OAL-8);
		
		translate([0,-BodyTube_OD/2,OAL/2])
				rotate([90,0,0]) Bolt250Hole();
	} // difference
} // BoosterThrustRing

//translate([0,BoosterButtonMinor_d/2,PML54Body_OD/2+BoosterButtonOA_h+Overlap]) rotate([90,0,0]) BoosterThrustRing();

module BoosterButton(XtraLen=0){
	
	module Bolt250FlatHeadHole(depth=12,lAccess=12){
		// custom version
		if ($preview){
			translate([0,0,-depth])
				cylinder(r=Bolt250_Clear_r+ID_Xtra, h=depth+Overlap, $fn=24);
		}else{
			translate([0,0,-depth])
				ExternalThread(Pitch=25.4/20, Dia_Nominal=6.35+IDXtra*2, Length=depth+Overlap*2, 
								Step_a=2, TrimEnd=true, TrimRoot=true);
		}
		translate([0,0,-Bolt250_FlatHd_h])
			cylinder(d1=Bolt250_Clear_r+ID_Xtra, d2=Bolt250_FlatHd_d+ID_Xtra, h=Bolt250_FlatHd_h, $fn=24);
		translate([0,0,-Overlap]) cylinder(d=Bolt250_FlatHd_d+ID_Xtra, h=lAccess, $fn=24);
	} // Bolt250FlatHeadHole
	
	difference(){
		union(){
			cylinder(d=BoosterButtonMajor_d, h=BoosterButtonMajor_h);
			translate([0,0,BoosterButtonMajor_h-Overlap]) 
				cylinder(d1=BoosterButtonMajor_d, d2=BoosterButtonMinor_d, h=BoosterButtonTrans_h);
			cylinder(d=BoosterButtonMinor_d, h=BoosterButtonOA_h+XtraLen);
		} // union
		
		translate([0,0,1.5]) rotate([180,0,0]) Bolt250FlatHeadHole(depth=BoosterButtonOA_h+Overlap, lAccess=12);
		
	} // difference
} // BoosterButton

// BoosterButton(XtraLen=0.3); // XtraLen=0.3 works well

module BB_ThrustPoint_Hole(Swell=-Overlap){
	Block_w=BoosterButtonMajor_d+BB_Lock_Wall_t*2+Swell*2;
	OAL=BoosterButtonMajor_d*3.2+Swell*2;
	
	translate([-Block_w/2, -BoosterButtonMajor_d/2-BB_Lock_Wall_t+Swell, -3-Swell])
					cube([BoosterButtonMajor_d+BB_Lock_Wall_t*2+Swell*2, OAL, BoosterButtonOA_h+4]);
} // BB_ThrustPoint_Hole

//BB_ThrustPoint_Hole();
//BB_ThrustPoint_Hole(Swell=IDXtra*2);

module BB_ThrustPoint(BodyTube_OD=PML98Body_OD, BoosterBody_OD=PML54Body_OD){
	Ramp_h=12;
	OAL=BoosterButtonMajor_d*3.25;
	Block_w=BoosterButtonMajor_d+BB_Lock_Wall_t*2;
	
	module PostClearance1(){
		translate([0,0,-Overlap]) cylinder(d=BoosterButtonMinor_d+IDXtra*2, h=BoosterButtonOA_h+Overlap*2);
	} // PostClearance1
	
	module PostClearance2(){
		translate([0,0,-1-Overlap]) cylinder(d=BoosterButtonMajor_d+IDXtra*2, h=BoosterButtonMajor_h+1+Overlap*2);
	} // PostClearance2
	
	module PostClearance3(){
		translate([0,0,BoosterButtonMajor_h-Overlap])
			cylinder(d1=BoosterButtonMajor_d+IDXtra*2, d2=BoosterButtonMinor_d+IDXtra*2, h=BoosterButtonTrans_h+Overlap*2);
	} // PostClearance
	
	difference(){
		union(){
			intersection(){
				translate([-Block_w/2, -BoosterButtonMajor_d/2-BB_Lock_Wall_t, -3])
					cube([BoosterButtonMajor_d+BB_Lock_Wall_t*2, OAL, BoosterButtonOA_h+6]);
				translate([0,-Block_w/2-Overlap,BoosterButtonOA_h-BodyTube_OD/2]) 
					rotate([-90,0,0]) cylinder(d=BodyTube_OD+Overlap, h=OAL+Overlap*2, $fn=$preview? 90:360);
			} // intersection
			
			translate([-BoosterButtonMajor_d/2-BB_Lock_Wall_t, -BoosterButtonMajor_d/2-BB_Lock_Wall_t, 0])
				cube([BoosterButtonMajor_d+BB_Lock_Wall_t*2, 5.5, BoosterButtonOA_h+3]);
		} // union
		
		translate([0,-Block_w/2-Overlap,BoosterButtonOA_h+BoosterBody_OD/2]) 
			rotate([-90,0,0]) cylinder(d=BoosterBody_OD+IDXtra, h=OAL+Overlap*2, $fn=$preview? 90:360);
		
		hull(){
			PostClearance1();
			translate([0,BoosterButtonMinor_d/2,0]) PostClearance1();
		} // hull
		hull(){
			PostClearance2();
			translate([0,BoosterButtonMinor_d/2,0]) PostClearance2();
		} // hull
		hull(){
			PostClearance3();
			translate([0,BoosterButtonMinor_d/2,0]) PostClearance3();
		} // hull
		
		hull(){
			translate([0,BoosterButtonMinor_d/2,0]) PostClearance1();
			translate([0, BoosterButtonMajor_d*2.5, BoosterButtonPost_h+Ramp_h]) 
				PostClearance1();
		} // hull
		hull(){
			translate([0,BoosterButtonMinor_d/2,0]) PostClearance2();
			translate([0, BoosterButtonMajor_d*2.5, BoosterButtonPost_h+Ramp_h]) 
				PostClearance2();
		} // hull
		hull(){
			translate([0,BoosterButtonMinor_d/2,0]) PostClearance3();
			translate([0, BoosterButtonMajor_d*2.5, BoosterButtonPost_h+Ramp_h]) 
				PostClearance3();
		} // hull
		
	} // difference
} // BB_ThrustPoint

//translate([0,PML98Body_OD/2-BoosterButtonOA_h,0]) rotate([-90,0,0]) BB_ThrustPoint(BodyTube_OD=BT137Body_OD, BoosterBody_OD=ULine102Body_OD);

module BB_LTP_Hole(){
	// This is the hole a locking thrust point fits in. 
	
	
	rotate([180,0,0]) cylinder(d=BB6805_2RS_OD-4, h=50);
	
	BB_ThrustPoint_Hole(Swell=IDXtra*3);
	translate([0,0,TopOfRace-BB6805_2RS_H-IDXtra*3]) cylinder(d=Housing_OD+IDXtra*3, h=BB6805_2RS_H+17);
	BB_LTP_BoltPattern() Bolt4Hole(depth=24);
} // BB_LTP_Hole

// BB_LTP_Hole();

module BB_LTP_BoltPattern(){
	nBolts=6;
	
	for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) translate([0,RaceBC_d/2,TopOfRace+2])
			children();
	
	translate([9,49,6]) children();
	translate([-9,49,6]) children();
} // BB_LTP_BoltPattern

module BB_LockingThrustPoint(BodyTube_OD=PML98Body_OD, BoosterBody_OD=PML54Body_OD){	
	
	module TheBolts(){
		BB_LTP_BoltPattern() Bolt4HeadHole(depth=12,lHead=22);
	} // TheBolts
	
// Ball Bearing 6805-2RS
//BB6805_2RS_ID=25;
//BB6805_2RS_OD=37;
//BB6805_2RS_H=7;

	
	difference(){
		translate([0,0,TopOfRace-BB6805_2RS_H]) cylinder(d=Housing_OD, h=BB6805_2RS_H+17, $fn=$preview? 90:360);
			
		difference(){
			BB_ThrustPoint_Hole();
			// Rotating lock
			translate([0,0,TopOfRace-Overlap*3]) 
				cylinder(d=BoosterButtonMajor_d+BB_Lock_Wall_t*2+6, h=14);
		}
		
		// conform to tube OD
		translate([0,-30,-BodyTube_OD/2+BoosterButtonOA_h]) rotate([-90,0,0])
		difference(){
			cylinder(d=BodyTube_OD+15,h=100, $fn=$preview? 90:360);
			translate([0,0,-Overlap]) cylinder(d=BodyTube_OD,h=100+Overlap*2, $fn=$preview? 90:360);
		} // difference
		
		// Bearing
		translate([0,0,TopOfRace-BB6805_2RS_H-Overlap])
				cylinder(d=BB6805_2RS_OD+IDXtra, h=BB6805_2RS_H+Overlap*2);
		
		// Bolt holes
		TheBolts();
		
		translate([0,0,TopOfRace-Overlap]) cylinder(d=BB6805_2RS_OD-3, h=1);
		translate([0,0,TopOfRace-Overlap]) cylinder(d=BB6805_2RS_ID+3, h=3+Overlap*2);
		
		// Rotating lock
		translate([0,0,TopOfRace-Overlap*2]) 
				cylinder(d=BoosterButtonMajor_d+BB_Lock_Wall_t*2+1, h=8+Overlap*2);
		
		// Button clearance
		translate([0,0,-1.5-Overlap]) hull(){
			cylinder(d=BoosterButtonMajor_d+LooseFit, h=12+Overlap*2);
			translate([0,20,0]) cylinder(d=BoosterButtonMajor_d+LooseFit, h=12+Overlap*2);
		} // hull
	} // difference
	
	difference(){
		BB_ThrustPoint(BodyTube_OD=BodyTube_OD, BoosterBody_OD=BoosterBody_OD);
		
		// Bolt holes
		TheBolts();
		
		translate([0,0,TopOfRace-Overlap]) cylinder(d=BB6805_2RS_OD-3, h=1);
		translate([0,0,TopOfRace-Overlap]) cylinder(d=BB6805_2RS_ID+3,h=3);
		
		// Clearance for the rotating lock
		translate([0,0,TopOfRace-Overlap]) 
			cylinder(d=BoosterButtonMajor_d+BB_Lock_Wall_t*2+1, h=-TopOfRace+BoosterButtonMajor_h );
	} // difference
	
} // BB_LockingThrustPoint

//BB_LockingThrustPoint(BodyTube_OD=BT137Body_OD, BoosterBody_OD=ULine102Body_OD);


module DrivenGearBevel(){
	BackOfGear_Z=-3;
	HubThickness=5;
	
	difference(){
		bevel_gear (
			number_of_teeth=36,
			cone_distance=54.0833,
			face_width=6,
			outside_circular_pitch=300,
			pressure_angle=22.5,
			clearance = 0.2,
			bore_diameter=0,
			gear_thickness = 6,
			backlash = 0,
			involute_facets=5,
			finish = bevel_gear_back_cone);
			
		// trim back
		translate([0,0,-10+BackOfGear_Z]) cylinder(d=100, h=10);
	} // difference
 
	// hub
	translate([0,0,BackOfGear_Z]) cylinder(d=Housing_OD, h=HubThickness);
} // DrivenGearBevel

//DrivenGearBevel();

module DrivenGear(Hub_Len=5){
	
	
	difference(){
		union(){
			//BB_Gear(nTeeth=36, Thickness=6);
			translate([0,0,Hub_Len-2]) DrivenGearBevel();
			translate([0,0,-Hub_Len]) cylinder(d=BB6805_2RS_ID+3, h=Hub_Len+Overlap);
		} // union
		
		translate([0,0,6]) BB_LockBoltPattern() Bolt4HeadHole(depth=6+Hub_Len);
		
		// center hole
		translate([0,0,-Hub_Len-Overlap]) cylinder(d=Race_ID, h=5+Hub_Len+Overlap*3);
		
		translate([0,0,-1]) rotate_extrude(angle=188, start=-4, $fn=90) translate([RaceBC_d/2-2,0,0]) square(4);
	} // difference
} // DrivenGear

// DrivenGear();

module BB_Gear(nTeeth=24, Thickness=8){
	Pitch=300;
	PressureAngle=20;
	Clearance=0.4;
	
	Backlash=0.2;
	
	
	gear(number_of_teeth=nTeeth, circular_pitch=Pitch, diametral_pitch=false,
				pressure_angle=PressureAngle, clearance = Clearance,
				gear_thickness=Thickness, rim_thickness=Thickness, rim_width=3,
				hub_thickness=Thickness, hub_diameter=15, bore_diameter=7.5, circles=0, 
				backlash=Backlash, twist=0, 
				involute_facets=0, flat=false);
} // BB_Gear

//BB_Gear();

// TL Torque Limiter, WIP

module TLClutchPlate(){
	ClutchPlate_d=32;
	
	difference(){
		union(){
			cylinder(d=ClutchPlate_d, h=2.1);
			for (j=[0:5]) rotate([0,0,60*j]) translate([ClutchPlate_d/2-3,0,0]) cylinder(d=6, h=7);
		} // union
		
		translate([0,0,8]) // gear thickness
			for (j=[0:5]) rotate([0,0,60*j]) translate([ClutchPlate_d/2-3,0,0]) Bolt4Hole();
				
		translate([0,0,-Overlap]) cylinder(d=22, h=13);
	} // difference
} // TLClutchPlate

//TLClutchPlate();

module TLServoGear(nTeeth=24){
	ClutchPlate_d=32;
	
	difference(){
		BB_Gear(nTeeth=nTeeth);
		
		translate([0,0,-Overlap]) cylinder(d=ClutchPlate_d+IDXtra*2, h=6.8);
		translate([0,0,8]) // gear thickness
			for (j=[0:5]) rotate([0,0,60*j]) translate([ClutchPlate_d/2-3,0,0]) Bolt4ClearHole();
	} // difference
} // TLServoGear

//TLServoGear();

module ServoGear(nTeeth=24){
	ServoWheel_d=20.84+IDXtra*2; // MG996R
	ServoWheel_h=4; //2.7;
	ServoBC_r=8;
	ServoBC2_r=8;
	//ServoWheel_d=23.75+IDXtra*2; // HS5645MG
	//ServoWheel_h=2.0;
	//ServoBC_r=17/2;
	//ServoBC2_r=20/2;
	
	difference(){
		BB_Gear(nTeeth=nTeeth);
		
		translate([0,0,-Overlap]) cylinder(d=ServoWheel_d, h=ServoWheel_h);
		translate([0,0,ServoWheel_h+5.3]){ // gear thickness
			for (j=[0:1]) rotate([0,0,180*j]) translate([ServoBC_r,0,0]) Bolt4HeadHole();
			for (j=[0:1]) rotate([0,0,180*j+90]) translate([ServoBC2_r,0,0]) Bolt4HeadHole();
			}
	} // difference
} // ServoGear

//ServoGear(30);

module BB_LockShaft(Len=50, nTeeth=24, Gear_z=14){
	nBolts=3;
	
	End_h=8;
	Taper_h=8;
	
	Stop_Len=18;
	StopBlock_a=22.5;
	
	
	difference(){
		union(){
			translate([0,0,Len/2-Gear_z])
				BB_Gear(nTeeth=nTeeth);

			#cylinder(d=Race_ID+6, h=Len, center=true);
			
			translate([0,0,-Len/2])
				cylinder(d=BB_Lock_BallCircle_d-6*0.7, h=End_h);
			translate([0,0,-Len/2+End_h-Overlap])
				cylinder(d1=BB_Lock_BallCircle_d-6*0.7, d2=Race_ID+6, h=Taper_h);
			
			mirror([0,0,1]){
			translate([0,0,-Len/2])
				cylinder(d=BB_Lock_BallCircle_d-6*0.7, h=End_h);
			translate([0,0,-Len/2+End_h-Overlap])
				cylinder(d1=BB_Lock_BallCircle_d-6*0.7, d2=Race_ID+6, h=Taper_h);
			}
			
			
			// Hard Stops
			translate([0,0,-Len/2+5]){
				cube([8,Stop_Len,5]);
				rotate([0,0,180+StopBlock_a]) mirror([1,0,0]) cube([8,Stop_Len,5]);
			}
		} // union
		
		cylinder(d=Race_ID, h=Len+Overlap*2, center=true);
		
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j])
			translate([BB_Lock_BallCircle_d/2-3-Bolt4Inset,0,Len/2])
				rotate([180,0,0]) Bolt4HeadHole();
		
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j])
			translate([BB_Lock_BallCircle_d/2-3-Bolt4Inset,0,-Len/2])
				Bolt4HeadHole();
	} // difference
} // BB_LockShaft

//rotate([180,0,0]) BB_LockShaft(Len=50);

module BB_LockStop(Len=50, Extra_H=2){
	StopBlock_a=22.5;
	Stop_Len=18;
	
	translate([0,0,-Len/2+5-Extra_H]) hull(){
		translate([-Overlap, Stop_Len-4, 0]) cube([Overlap,10,5+Extra_H]);
		rotate([0,0,StopBlock_a]) translate([0, Stop_Len-4, 0]) cube([Overlap,10,5+Extra_H]);
	} // hull
	
} // BB_LockStop

// BB_LockStop(Len=50, Extra_H=2);

module BB_LockBoltPattern(){
	nBolts=3;
	
	for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j])
			translate([BB6805_2RS_ID/2-Bolt4Inset,0,0]) children();
				
} // BB_LockBoltPattern

// BB_LockBoltPattern() Bolt4HeadHole();

module BB_Lock(){
	
	difference(){
			difference(){
				union(){
					translate([0,0,TopOfRace]) cylinder(d=BB6805_2RS_ID+2, h=2.5);
					translate([0,0,TopOfRace-BB6805_2RS_H]) cylinder(d=BB6805_2RS_ID, h=BB6805_2RS_H+Overlap);
				} // union
				
				translate([0,0,TopOfRace-BB6805_2RS_H-Overlap]) cylinder(d=Race_ID, h=BB6805_2RS_H+3+Overlap*3);
			} // difference
		
		// Bolt holes
		//for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j])
		//	translate([BB6805_2RS_ID/2-Bolt4Inset,0,0])
		translate([0,0,TopOfRace-BB6805_2RS_H-1]) BB_LockBoltPattern() rotate([180,0,0]) Bolt4Hole();
			
	} // difference
	
	//*
	difference(){
		translate([0,0,TopOfRace-Overlap]) cylinder(d=BoosterButtonMajor_d+BB_Lock_Wall_t*2, 2+BoosterButtonMajor_h+0.5);
		
		// Center hole
		translate([0,0,TopOfRace-Overlap*2]) cylinder(d=Race_ID, h=BoosterButtonMajor_h+4);
		
		translate([0,0,TopOfRace-Overlap*2])
		hull(){
			cylinder(d=BoosterButtonMajor_d+IDXtra*2, h=4+BoosterButtonMajor_h);
			translate([BoosterButtonMajor_d,0,0]) 
				cylinder(d=BoosterButtonMajor_d+IDXtra*2, h=4+BoosterButtonMajor_h);
		} // hull
		
		
	} // difference
	/**/
	
} // BB_Lock

// BB_Lock();

module BB_BearingStop(){
	// Only used with ball bearing
	
	nBolts=3;
	
	difference(){
		cylinder(d=BB6805_2RS_ID+3, h=2);
		
		translate([0,0,-Overlap]) cylinder(d=Race_ID, h=2+Overlap*2);
		
		// Bolt holes
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j])
			translate([BB_Lock_BallCircle_d/2-3-Bolt4Inset,0,-Overlap])
				rotate([180,0,0]) Bolt4ClearHole();
	} // difference
	
} // BB_BearingStop

// BB_BearingStop(); // Only used with ball bearing














































