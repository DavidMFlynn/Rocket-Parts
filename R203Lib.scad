// ***********************************
// Project: 3D Printed Rocket
// Filename: R203Lib.scad
// by David M. Flynn
// Created: 12/14/2024 
// Revision: 0.9.0  12/14/2024 
// Units: mm
// ***********************************
//  ***** Notes *****
//
// A collection of parts for 203mm (8" mailing tube) rockets.
//
//  ***** History *****
//
// 0.9.0  12/14/2024  Copied from R137Lib 0.9.0 
//
// ***********************************
//  ***** for STL output *****
//
// R203_PetalHub(Body_OD=Coupler_OD);
// R203_BallRetainerTop(Body_OD=Body_OD, Body_ID=Body_ID);
// R203_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID, HasPD_Ring=false);
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
Engagement_Len=30;
//BallPerimeter_d=STB_BT137BallPerimeter_d();
nPetals=7;
nEBayBolts=7;
EBayBoltInset=8;

//NC_Base_L=15;

Body_OD=ULine203Body_OD;
Body_ID=ULine203Body_ID;

Coupler_OD=ULine203Coupler_OD;
//Coupler_ID=ULine203Coupler_ID;

module R203_PetalHub(Body_OD=Coupler_OD){
	// Bolts to bottom of electronics bay
	difference(){
		PD_PetalHub(OD=Coupler_OD, 
					nPetals=nPetals, 
					HasBolts=true,
					nBolts=nPetals,
					ShockCord_a=-1,
					HasNCSkirt=false);
					
		// Remove center	
		translate([0,0,-Overlap]) cylinder(d=Coupler_OD-60,h=10);
	} // difference
} // R203_PetalHub

// translate([0,0,-20]) rotate([180,0,0]) R203_PetalHub();
// R203_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID, HasPD_Ring=true);

module R203_BallRetainerTop(Body_OD=Body_OD, Body_ID=Body_ID){
	XtraLen=-5;
	Tube_d=12.7;
	Skirt_Len=16;
	TubeInset=Tube_d/2+3;
	Tube_Z=XtraLen+39+Skirt_Len-TubeInset;
	Tube_a=-30;
	TubeSlot_w=34;
	TubeOffset_X=0;	
	
	difference(){
		union(){
			STB_BallRetainerTop(Body_ID=Body_ID, Outer_OD=Body_OD, Body_OD=Body_ID, nLockBalls=nLockBalls,
			HasIntegratedCouplerTube=true, nBolts=0,
			IntegratedCouplerLenXtra=XtraLen,
			HasSecondServo=true,
			UsesBigServo=true,
			Engagement_Len=Engagement_Len, HasLargeInnerBearing=true);
			
			// Extend Coupler
			translate([0,0,XtraLen+39]) 
				Tube(OD=Body_ID, ID=Body_ID-6, Len=Skirt_Len+Overlap, myfn=$preview? 90:360);
			
			// Shock cord hole
			translate([0,0,XtraLen+39+Skirt_Len]) 
				rotate([180,0,0]) Tube(OD=39, ID=34, Len=XtraLen+39+Skirt_Len-6, myfn=$preview? 90:360);
				
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
		for (j=[0:nEBayBolts-1]) rotate([0,0,360/nEBayBolts*j+10]) 
			translate([0,Body_OD/2,XtraLen+39.0+EBayBoltInset])
				rotate([-90,0,0]) Bolt4Hole();
			
		//cube([100,100,100]);
	} // difference
} // R203_BallRetainerTop

// rotate([180,0,0]) R203_BallRetainerTop();

module R203_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID, HasPD_Ring=false){
	// PD_Ring is required to attach the petal hub because 3 balls isn't good enough and 5 won't line up.
	
	Bolt_a=0;// offset between PD_PetalHub and R65_BallRetainerBottom

	
	PD_Ring_h=9;
	
	difference(){
		union(){
			STB_BallRetainerBottom(Body_ID=Body_ID, Body_OD=Body_ID, 
					nLockBalls=nLockBalls, HasSpringGroove=false, 
					Engagement_Len=Engagement_Len, HasLargeInnerBearing=true);
		
				
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
			
		}else{
			rotate([0,0,Bolt_a]) translate([0,0,-Engagement_Len/2])
				PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=nPetals) rotate([180,0,0]) Bolt4Hole(depth=20);
		}

	} // difference
} // R203_BallRetainerBottom

// R203_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID, HasPD_Ring=false);




















