// ***********************************
// Project: 3D Printed Rocket
// Filename: BoosterDropperLib.scad
// Created: 9/2/2022 
// Revision: 0.9.2  9/4/2022
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  Booster Dropper for strap on boosters
//
//  ***** History *****
//
// 0.9.2  9/4/2022  Nearly ready to test. 
// 0.9.1  9/3/2022  Lowered bearing 0.5mm.
// 0.9.0  9/2/2022  First code.
//
// ***********************************
//  ***** for STL output *****
//
// BoosterThrustRing(); // Print 2 per booster
// BoosterButton(); // Print 2 per booster
// BB_ThrustPoint(); // Print 1 per booster, incorperate into lower fin can
// BB_LockingThrustPoint(); // Print 1 per booster, incorperate into rocket body
// BB_Lock(); // Print 1 per booster
//
// ***********************************
//  ***** Routines *****
//
// LighteningHole(H=10, W=8, L=50);
// BB_ThrustPoint_Hole(BodyTube_OD=PML98Body_OD);
// BB_LTP_Hole(BodyTube_OD=PML98Body_OD)
//
// ***********************************

include<TubesLib.scad>
include<BearingLib.scad>
 //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

LooseFit=IDXtra*3;

BoosterButtonMinor_d=12.7;
BoosterButtonMajor_d=20;
BoosterButtonPost_h=5;
BoosterButtonMajor_h=5;
BoosterButtonTrans_h=(BoosterButtonMajor_d-BoosterButtonMinor_d)/3;
BoosterButtonOA_h=BoosterButtonMajor_h+BoosterButtonPost_h+BoosterButtonTrans_h;

BB_Lock_Preload=-0.25; // -0.2 was still slightly too tight
BB_Lock_Ball_d=6; // use airsoft pellets
BB_Lock_Wall_t=2.2;
BB_Lock_BallCircle_d=BoosterButtonMajor_d+BB_Lock_Wall_t*2+BB_Lock_Ball_d;
BB_Lock_Race_w=BB_Lock_Ball_d+2;

TopOfRace=-3.5; 

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
	OAL=BoosterButtonMinor_d+6;
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

module BoosterButton(){
	difference(){
		union(){
			cylinder(d=BoosterButtonMajor_d, h=BoosterButtonMajor_h);
			translate([0,0,BoosterButtonMajor_h-Overlap]) 
				cylinder(d1=BoosterButtonMajor_d, d2=BoosterButtonMinor_d, h=BoosterButtonTrans_h);
			cylinder(d=BoosterButtonMinor_d, h=BoosterButtonOA_h);
		} // union
		
		translate([0,0,1.5]) rotate([180,0,0]) Bolt250FlatHeadHole(depth=BoosterButtonOA_h+Overlap, lAccess=12);
	} // difference
} // BoosterButton

//BoosterButton();

module BB_ThrustPoint_Hole(Swell=-Overlap){
	Block_w=BoosterButtonMajor_d+BB_Lock_Wall_t*2+Swell*2;
	OAL=BoosterButtonMajor_d*3.2+Swell*2;
	
	translate([-Block_w/2, -BoosterButtonMajor_d/2-BB_Lock_Wall_t-Swell, -3-Swell])
					cube([BoosterButtonMajor_d+BB_Lock_Wall_t*2+Swell*2, OAL, BoosterButtonOA_h+4]);
} // BB_ThrustPoint_Hole

//BB_ThrustPoint_Hole();

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
			rotate([-90,0,0]) cylinder(d=BoosterBody_OD+IDXtra, h=OAL+Overlap*2);
		
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

//translate([0,PML98Body_OD/2-BoosterButtonOA_h,0]) rotate([-90,0,0]) BB_ThrustPoint(BodyTube_OD=PML98Body_OD, BoosterBody_OD=PML54Body_OD);

Bolt4Inset=4;

module BB_LTP_Hole(){
	Race_OD=BB_Lock_BallCircle_d+BB_Lock_Ball_d+Bolt4Inset*4;
	
	BB_ThrustPoint_Hole(Swell=IDXtra*2);
	translate([0,0,TopOfRace-BB_Lock_Race_w-IDXtra*2]) cylinder(d=Race_OD+IDXtra*2, h=BB_Lock_Race_w+17);
	BB_LTP_BoltPattern() Bolt4Hole(depth=24);
} // BB_LTP_Hole

// BB_LTP_Hole();

module BB_LTP_BoltPattern(){
	nBolts=6;
	RaceBC_d=BB_Lock_BallCircle_d+BB_Lock_Ball_d+Bolt4Inset*2;
	
	for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) translate([0,RaceBC_d/2,TopOfRace+2])
			children();
	
	translate([9,49,6]) children();
	translate([-9,49,6]) children();
} // BB_LTP_BoltPattern

module BB_LockingThrustPoint(){
	
	Race_OD=BB_Lock_BallCircle_d+BB_Lock_Ball_d+Bolt4Inset*4;
	
	
	module TheBolts(){
		BB_LTP_BoltPattern() Bolt4HeadHole(depth=12,lHead=22);
	}
	
	
	// Bearing outer race
	difference(){
		translate([0,0,TopOfRace]) rotate([180,0,0])
			OnePieceOuterRace(BallCircle_d=BB_Lock_BallCircle_d, 
					Race_OD=Race_OD, Ball_d=BB_Lock_Ball_d, Race_w=BB_Lock_Race_w, 
					PreLoadAdj=BB_Lock_Preload, VOffset=0.00, BI=true, myFn=$preview? 90:360);
		
		// Bolt holes
		TheBolts();
	} // difference
	
	// Middle section
	difference(){
		translate([0,0,TopOfRace-Overlap]) cylinder(d=Race_OD, h=17);
		//cylinder(d1=Race_OD, d2=BoosterButtonMajor_d+6, h=12);
			
		BB_ThrustPoint_Hole();
		
		// conform to tube OD
		translate([0,-30,-PML98Body_OD/2+BoosterButtonOA_h]) rotate([-90,0,0])
		difference(){
			cylinder(d=PML98Body_OD+15,h=100);
			translate([0,0,-Overlap]) cylinder(d=PML98Body_OD,h=100+Overlap*2, $fn=$preview? 90:360);
		} // difference
		
		// Bolt holes
		TheBolts();
		
		//Ball pushing hole
		translate([0,-BB_Lock_BallCircle_d/2,TopOfRace]) cylinder(d=BB_Lock_Ball_d/2, h=15);
		
		translate([0,0,TopOfRace-Overlap*2]) 
			cylinder(d1=BB_Lock_BallCircle_d+BB_Lock_Ball_d*0.7, d2=BoosterButtonMajor_d+BB_Lock_Wall_t*2+LooseFit, h=1);
		
		translate([0,0,TopOfRace-Overlap*2]) cylinder(d=BoosterButtonMajor_d+BB_Lock_Wall_t*2+1, h=8+Overlap*2);
		
		translate([0,0,-1.5-Overlap]) hull(){
			cylinder(d=BoosterButtonMajor_d+LooseFit, h=12+Overlap*2);
			translate([0,20,0]) cylinder(d=BoosterButtonMajor_d+LooseFit, h=12+Overlap*2);
		} // hull
	} // difference
	
	
	difference(){
		BB_ThrustPoint();
		
		// Bolt holes
		TheBolts();
		
		translate([0,0,TopOfRace-Overlap]) 
			cylinder(d1=BB_Lock_BallCircle_d+BB_Lock_Ball_d*0.7, d2=BoosterButtonMajor_d+BB_Lock_Wall_t*2+LooseFit, h=1);
		
		translate([0,0,TopOfRace-Overlap]) 
			cylinder(d=BoosterButtonMajor_d+BB_Lock_Wall_t*2+1, h=-TopOfRace+BoosterButtonMajor_h );
	} // difference
	
} // BB_LockingThrustPoint

//BB_LockingThrustPoint();

module BB_LockShaft(Len=50){
	nBolts=3;
	Race_ID=BB_Lock_BallCircle_d-BB_Lock_Ball_d-Bolt4Inset*4;
	End_h=8;
	
	difference(){
		union(){
			cylinder(d=Race_ID+6, h=Len, center=true);
			
			translate([0,0,-Len/2])
				cylinder(d=BB_Lock_BallCircle_d-BB_Lock_Ball_d*0.7, h=End_h);
			translate([0,0,-Len/2+End_h-Overlap])
				cylinder(d1=BB_Lock_BallCircle_d-BB_Lock_Ball_d*0.7, d2=Race_ID+6, h=5);
			
			mirror([0,0,1]){
			translate([0,0,-Len/2])
				cylinder(d=BB_Lock_BallCircle_d-BB_Lock_Ball_d*0.7, h=End_h);
			translate([0,0,-Len/2+End_h-Overlap])
				cylinder(d1=BB_Lock_BallCircle_d-BB_Lock_Ball_d*0.7, d2=Race_ID+6, h=5);
			}
		} // union
		
		cylinder(d=Race_ID, h=Len+Overlap*2, center=true);
		
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j])
			translate([BB_Lock_BallCircle_d/2-BB_Lock_Ball_d/2-Bolt4Inset,0,Len/2])
				rotate([180,0,0]) Bolt4HeadHole();
		
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j])
			translate([BB_Lock_BallCircle_d/2-BB_Lock_Ball_d/2-Bolt4Inset,0,-Len/2])
				Bolt4HeadHole();
	} // difference
} // BB_LockShaft

//BB_LockShaft();

module BB_Lock(){
	nBolts=3;
	Race_ID=BB_Lock_BallCircle_d-BB_Lock_Ball_d-Bolt4Inset*4;
	ReceExtend=1.00;
	
	difference(){
		// Race extends 1mm below outer race
		translate([0,0,TopOfRace]) rotate([180,0,0]) OnePieceInnerRace(BallCircle_d=BB_Lock_BallCircle_d,	
			Race_ID=Race_ID,	Ball_d=BB_Lock_Ball_d, 
			Race_w=BB_Lock_Race_w+ReceExtend, PreLoadAdj=BB_Lock_Preload, VOffset=-ReceExtend/2, BI=true, myFn=$preview? 90:360);
		
		// Bolt holes
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j])
			translate([BB_Lock_BallCircle_d/2-BB_Lock_Ball_d/2-Bolt4Inset,0,TopOfRace-BB_Lock_Race_w-ReceExtend])
				rotate([180,0,0]) Bolt4Hole();
			
	} // difference
	
	
	difference(){
		translate([0,0,TopOfRace-Overlap]) cylinder(d=BoosterButtonMajor_d+BB_Lock_Wall_t*2, 2+BoosterButtonMajor_h+0.5);
		
		// Center hole
		translate([0,0,TopOfRace-Overlap*2]) cylinder(d=Race_ID, h=BoosterButtonMajor_h+4);
		
		translate([0,0,-1.5])
		hull(){
			cylinder(d=BoosterButtonMajor_d+IDXtra*2, h=2+BoosterButtonMajor_h);
			translate([BoosterButtonMajor_d,0,0]) 
				cylinder(d=BoosterButtonMajor_d+IDXtra*2, h=2+BoosterButtonMajor_h);
		} // hull
	} // difference
	
} // BB_Lock

//BB_Lock();













































