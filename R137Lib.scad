// ***********************************
// Project: 3D Printed Rocket
// Filename: R137Lib.scad
// by David M. Flynn
// Created: 8/23/2024 
// Revision: 0.9.0  8/23/2024 
// Units: mm
// ***********************************
//  ***** Notes *****
//
// A collection of parts for 137mm rockets.
//
//  ***** History *****
//
// 0.9.0  8/23/2024  Copied from R98Lib 0.9.2 added R137_BallRetainerTop() from RBP4
//
// ***********************************
//  ***** for STL output *****
//
// R137_PetalHub(Body_OD=Coupler_OD);
// R137_BallRetainerTop(Body_OD=Body_OD, Body_ID=Body_ID);
// R137_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID, HasPD_Ring=false);
//
// ***********************************
include<TubesLib.scad>
use<SpringThingBooster.scad> echo(SpringThingBoosterRev());
use<PetalDeploymentLib.scad>
use<SpringEndsLib.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 36:90;

CouplerLenXtra=-10;
nLockBalls=7;
Engagement_Len=25;
BallPerimeter_d=STB_BT137BallPerimeter_d();
nPetals=3;

NC_Base_L=15;

ShockCord_a=17;// offset between PD_PetalHub and R65_BallRetainerBottom

Body_OD=BT137Body_OD;
Body_ID=BT137Body_ID;
Body75_OD=BT75Body_OD;
Body75_ID=BT75Body_ID;

Coupler_OD=BT137Coupler_OD;
Coupler_ID=BT137Coupler_ID;
MotorTube_OD=BT54Body_OD;
MotorTube_ID=BT54Body_ID;

module R137_PusherRing(OD=Coupler_OD, ID=Coupler_ID, OA_Len=50, Engagemnet_Len=7, Wall_t=4, PetalStop_h=0, PetalWall_t=2.2, nBolts=0){
	
	translate([0,0,Engagemnet_Len]) difference(){
		union(){
			translate([0,0,-Engagemnet_Len]) Tube(OD=OD, ID=ID, Len=OA_Len, myfn=$preview? 90:720);
			Tube(OD=OD, ID=OD-Wall_t*2, Len=OA_Len-Engagemnet_Len, myfn=$preview? 90:720);
		} // union
		
		// Reduce mass by thinning inside
		A=OA_Len-Engagemnet_Len-18;
		if (A>0){
			translate([0,0,3]) cylinder(d1=OD-Wall_t*2-Overlap, d2=ID, h=6, $fn=$preview? 90:720);
			translate([0,0,9-Overlap]) cylinder(d=ID, h=A+Overlap*2, $fn=$preview? 90:720);
			translate([0,0,9+A]) cylinder(d2=OD-Wall_t*2-Overlap, d1=ID, h=6, $fn=$preview? 90:720);
		}
		
		if (nBolts>0)
			translate([0,0,-Engagemnet_Len]) PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=nBolts) Bolt4HeadHole(lHead=20);
	} // difference
	
	if (PetalStop_h>0) translate([0,0,OA_Len-Overlap])
		Tube(OD=OD-PetalWall_t*2-IDXtra*2, ID=OD-Wall_t*2, Len=PetalStop_h, myfn=$preview? 90:360);
} // R137_PusherRing

// rotate([180,0,0]) R137_PusherRing(OD=Coupler_OD, ID=Coupler_ID, OA_Len=50, Engagemnet_Len=7, Wall_t=4, PetalStop_h=3, PetalWall_t=2.2, nBolts=0);



module R137_PetalHub(Body_OD=Coupler_OD, CenterHole_d=34){
	// Bolts to bottom of electronics bay
	difference(){
		PD_PetalHub(OD=Body_OD, 
					nPetals=6, 
					HasReplaceableSpringHolder=true,
					HasBolts=true,
					nBolts=6, // Same as nPetals
					ShockCord_a=-1,
					HasNCSkirt=false);
					
		if (CenterHole_d>0)	
			translate([0,0,-Overlap]) cylinder(d=CenterHole_d,h=10);
	} // difference
} // R137_PetalHub

// translate([0,0,-20]) rotate([180,0,0]) R137_PetalHub();
// R137_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID, HasPD_Ring=true);

module R137_BallRetainerTop(Body_OD=Body_OD, Body_ID=Body_ID){
	XtraLen=-12;
	Tube_d=12.7;
	Tube_Z=XtraLen+13+30.15;
	Tube_a=-30;
	TubeSlot_w=34;
	TubeOffset_X=0;
	nBolts=6;
	
	difference(){
		union(){
			STB_BallRetainerTop(BallPerimeter_d=BallPerimeter_d, Outer_OD=Body_OD,
								Body_OD=Body_ID, nLockBalls=nLockBalls,
								HasIntegratedCouplerTube=true, 
								IntegratedCouplerLenXtra=XtraLen,
								Body_ID=Body_ID, HasSecondServo=true, UsesBigServo=true,
								Engagement_Len=Engagement_Len, HasLargeInnerBearing=true);
				
			translate([0,0,XtraLen+13+35.5]) 
				Tube(OD=Body_ID, ID=Body_ID-6, Len=4, myfn=$preview? 90:360);
			
			translate([0,0,XtraLen+13+35.5+4]) 
				rotate([180,0,0]) Tube(OD=39, ID=34, Len=XtraLen+46.5, myfn=$preview? 90:360);
				
			// Shock cord retention
			difference(){
				hull(){
					rotate([0,0,Tube_a]) translate([TubeOffset_X,0,Tube_Z]) 
						rotate([90,0,0]) cylinder(d=Tube_d+6, h=Body_ID-2, center=true);
					rotate([0,0,Tube_a]) translate([TubeOffset_X,0,7])
						cube([Tube_d+8, Body_ID-2, Overlap],center=true);
				} // hull
				
				hull(){
					rotate([0,0,Tube_a]) translate([TubeOffset_X,0,Tube_Z]) 
						rotate([90,0,0]) cylinder(d=Tube_d+7, h=TubeSlot_w, center=true);
					rotate([0,0,Tube_a]) translate([TubeOffset_X,0,7])
						cube([Tube_d+8+Overlap, TubeSlot_w, Overlap*2], center=true);
				} // hull
					
				// Trim outside
				Tube(OD=Body_OD+20, ID=Body_ID-1, Len=50, myfn=$preview? 90:360);
			} // difference
		} // union
	
		translate([TubeOffset_X,0,Tube_Z]) rotate([90,0,Tube_a]) 
			cylinder(d=Tube_d, h=Body_OD, center=true);
			
		// Bolt holes in skirt
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) translate([0,Body_OD/2,XtraLen+36.5+7.5])
			rotate([-90,0,0]) Bolt4Hole();
			
		//cube([100,100,100]);
	} // difference
} // R137_BallRetainerTop

// rotate([180,0,0]) R137_BallRetainerTop();

module R137_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID, HasPD_Ring=false){
	// PD_Ring is required to attach the petal hub because 3 balls isn't good enough and 5 won't line up.
	
	Bolt_a=0;// offset between PD_PetalHub and R65_BallRetainerBottom

	
	PD_Ring_h=9;
	
	difference(){
		union(){
			STB_BallRetainerBottom(BallPerimeter_d=BallPerimeter_d, Body_OD=Body_ID,
					nLockBalls=nLockBalls, HasSpringGroove=false, Engagement_Len=Engagement_Len, HasLargeInnerBearing=true);
				
		//*
			if (HasPD_Ring){
				translate([0,0,-Engagement_Len/2-PD_Ring_h])
					Tube(OD=Body_ID-IDXtra*2, ID=Body_ID-IDXtra-4.4, Len=PD_Ring_h+Overlap, myfn=$preview? 90:360);
				
				rotate([0,0,Bolt_a]) translate([0,0,-Engagement_Len/2-PD_Ring_h])
					PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=6) cylinder(d=8, h=PD_Ring_h+Overlap);
					
				translate([0,0,-Engagement_Len/2-PD_Ring_h]) 
					Tube(OD=39, ID=34, Len=PD_Ring_h+Overlap, myfn=$preview? 90:360);
			}
		/**/
			
		} // union
		
		if (HasPD_Ring){
			rotate([0,0,Bolt_a]) translate([0,0,-Engagement_Len/2-PD_Ring_h])
				PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=6) rotate([180,0,0]) Bolt4Hole(depth=PD_Ring_h-1);
			
		}

	} // difference
} // R137_BallRetainerBottom

//R137_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID, HasPD_Ring=true);




















