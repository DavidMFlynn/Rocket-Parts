// ***********************************
// Project: 3D Printed Rocket
// Filename: R203Lib.scad
// by David M. Flynn
// Created: 12/14/2024 
// Revision: 0.9.2  12/22/2024 
// Units: mm
// ***********************************
//  ***** Notes *****
//
// A collection of parts for 203mm (8" mailing tube) rockets.
//
//  ***** History *****
//
// 0.9.2  12/22/2024  Fixes to R203_BallRetainerTop
// 0.9.1  12/21/2024  Added a cusomized version of PD_NC_PetalHub R203_NC_PetalHub
// 0.9.0  12/14/2024  Copied from R137Lib 0.9.0 
//
// ***********************************
//  ***** for STL output *****
//
// R203_NC_PetalHub();
// R203_MotorTubeTopper();
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

CouplerLenXtra=0;
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
Coupler_ID=ULine203Coupler_ID;

MotorTube_OD=BT75Body_OD;
MotorTube_ID=BT75Body_ID;


module R203_NC_PetalHub(){
	OD=Coupler_OD;
	nPetals=nPetals;
	nRopes=nPetals;
	Spring_ID=SE_Spring_CS11890_ID();
	Spring_OD=SE_Spring_CS11890_OD();
	CouplerTube_ID=Coupler_ID;
				
	BodyTube_L=10;
	SpringHole_ID=Spring_ID-IDXtra*2-4.4;
	CenterHole_d=SpringHole_ID;
	
	
	// Body tube interface
	if (CouplerTube_ID==0)
	translate([0,0,-BodyTube_L]) 
		Tube(OD=OD, ID=OD-4.4, Len=BodyTube_L+1, myfn=$preview? 90:360);
									
	difference(){
		union(){
			PD_PetalHub(OD=OD, nPetals=nPetals, HasReplaceableSpringHolder=true,
							HasBolts=false, ShockCord_a=-1);
			
			translate([0,0,-BodyTube_L])
				Tube(OD=Spring_ID-IDXtra*2, 
						ID=Spring_ID-IDXtra*2-4.4, Len=BodyTube_L+1, myfn=$preview? 90:360);
						
						
			// Coupler tube interface
			translate([0,0,-BodyTube_L]) 
				cylinder(d=Coupler_ID, h=BodyTube_L+1, $fn=$preview? 90:360);
		} // union
			
		// Center Hole
		translate([0,0,-BodyTube_L-Overlap]) 
			cylinder(d=SpringHole_ID, h=BodyTube_L+Overlap*2, $fn=$preview? 90:360);
		translate([0,0,-Overlap]) 
			cylinder(d=CenterHole_d, h=10, $fn=$preview? 90:360);
			
		if (CouplerTube_ID>0){
			translate([0,0,-BodyTube_L-Overlap]) 
				cylinder(d=Spring_OD, h=BodyTube_L, $fn=$preview? 90:360);
			translate([0,0,-BodyTube_L-Overlap]) 
				cylinder(d1=Spring_OD+5, d2=Spring_OD, h=BodyTube_L-5, $fn=$preview? 90:360);
		}
			
		// Retention cord
		for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*(j+0.5)]) {
				translate([0,OD/2-6,-BodyTube_L-Overlap]) cylinder(d=4, h=30);
				translate([0,OD/2-6,5]) cylinder(d=8, h=30);
			}
	} // difference
	
} // R203_NC_PetalHub

// R203_NC_PetalHub();

module R203_MotorTubeTopper(){
// Z zero is top of motor tube
// Sits on top of motor tube
// Has Rail Guide bolt holes
// Has centering ring
// Has shock cord attachment tube
// Has spring holder

	Al_Tube_d=12.7;
	Al_Tube_Z=-Al_Tube_d/2-5;
	
	ST_DSpring_OD=SE_Spring_CS11890_OD();
	ST_DSpring_ID=SE_Spring_CS11890_ID();
	
	Skirt_Len=30;
	nRopes=6;
	Rope_d=4;
	RopeHoleBC_r=(MotorTube_OD+8)/2+Rope_d/2+1;

	difference(){
		union(){
			translate([0,0,-Skirt_Len]) 
				Tube(OD=MotorTube_ID, ID=MotorTube_ID-4.4, Len=Skirt_Len+Overlap, myfn=$preview? 36:360);
			translate([0,0,-Skirt_Len]) 
				Tube(OD=MotorTube_OD+IDXtra*3+4.4, ID=MotorTube_OD+IDXtra*3, 
						Len=Skirt_Len+Overlap, myfn=$preview? 36:360);
			// Outer ring
			translate([0,0,-Skirt_Len]) 
				Tube(OD=Body_ID, ID=Body_ID-4.4, Len=Skirt_Len+Overlap, myfn=$preview? 90:720);
				
			CenteringRing(OD=Body_ID, ID=MotorTube_ID-4.4, Thickness=10, nHoles=6, Offset=0, myfn=$preview? 90:720);
			//translate([0,0,4]) 
			//	Tube(OD=ST_DSpring_OD+8, ID=ST_DSpring_OD, Len=8, myfn=$preview? 36:360);
			
			// Rail guide bolt boss
			translate([Body_ID/2-1, 0, -9]) hull(){
				translate([0,0,6.35]) rotate([0,-90,0]) cylinder(d=20, h=12);
				translate([0,0,-6.35]) rotate([0,-90,0]) cylinder(d=20, h=12);
			} // hull
		} // union
	
		//translate([0,0,-20]) Tube(OD=MotorTube_ID, ID=MotorTube_ID-6, Len=21, myfn=$preview? 36:360);
		
		//translate([0,0,3]) cylinder(d=ST_DSpring_OD, h=4+Overlap);
		//translate([0,0,7]) cylinder(d1=ST_DSpring_OD, d2=ST_DSpring_OD+4, h=5+Overlap);
		
		//translate([0,0,Al_Tube_Z]) rotate([90,0,0]) cylinder(d=Al_Tube_d+IDXtra, h=Body_OD, center=true);
		
		// Rail guide bolts
		translate([Body_ID/2, 0, -9]) {
			translate([0,0,6.35]) rotate([0,90,0]) Bolt6Hole();
			translate([0,0,-6.35]) rotate([0,90,0]) Bolt6Hole();
		}
		
		// Rope holes
		//for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j+180/nRopes]) 
		//	translate([0,RopeHoleBC_r,-Overlap]) cylinder(d=Rope_d, h=5+Overlap*2);
		
	} // difference

} // R203_MotorTubeTopper

// R203_MotorTubeTopper();

module R203_PetalHub(OD=Coupler_OD){
	// Bolts to bottom of electronics bay
	PD_PetalHub(OD=OD, 
					nPetals=nPetals, 
					HasReplaceableSpringHolder=true,
					HasBolts=true,
					nBolts=nPetals,
					ShockCord_a=-2,
					HasNCSkirt=false, CenterHole_d=OD-60);
					
} // R203_PetalHub

// translate([0,0,-20]) rotate([180,0,0]) R203_PetalHub();
// R203_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID, HasPD_Ring=true);

module R203_BallRetainerTop(Body_OD=Body_OD, Body_ID=Body_ID, nBolts=7, Xtra_r=0.0){
	Tube_d=12.7;
	Skirt_Len=16;
	Tube_a=-38.5;
	TubeSlot_w=34;
	TubeOffset_X=0;	
		
	BoltInset=8;
	Engagement_Len=20;
	Floor_Z=8;
	Skirt_H=24;
	EBayInterface_Z=Engagement_Len/2+Skirt_H+CouplerLenXtra;
	Top_Z=EBayInterface_Z+BoltInset*2+1;
	Tube_Z=Top_Z-Tube_d/2-3;
	
	difference(){
		union(){
			STB_BallRetainerTop(Body_ID=Body_ID, Outer_OD=Body_OD, Body_OD=Body_ID, nLockBalls=nLockBalls,
						HasIntegratedCouplerTube=true, nBolts=0,
						IntegratedCouplerLenXtra=CouplerLenXtra,
						HasSecondServo=true,
						UsesBigServo=true,
						Engagement_Len=Engagement_Len, HasLargeInnerBearing=true, Xtra_r=Xtra_r);
			
			// Extend skirt
			translate([0,0,Top_Z-Skirt_Len]) 
				Tube(OD=Body_ID, ID=Body_ID-IDXtra-6, Len=Skirt_Len, myfn=$preview? 90:360);
							
			// Shock cord retention
			difference(){
				union(){
					// Tube holder
					hull(){
						rotate([0,0,Tube_a]) translate([TubeOffset_X,0,Top_Z-Overlap/2]) 
							cube([Tube_d+6, Body_ID-2, Overlap], center=true);
						rotate([0,0,Tube_a]) translate([TubeOffset_X,0,Tube_Z])
							rotate([90,0,0]) cylinder(d=Tube_d+6, h=Body_ID-2, center=true);
					} // hull
					
					// Support
					rotate([0,0,Tube_a]) translate([TubeOffset_X-(Tube_d-3)/2,-(Body_ID-2)/2,Floor_Z])
							cube([Tube_d-3, Body_ID-2, Tube_Z-Floor_Z]);
				} // union
				rotate([0,0,Tube_a]) translate([TubeOffset_X,0,Tube_Z]) 
					rotate([90,0,0]) cylinder(d=Tube_d*3, h=TubeSlot_w, center=true);
					
				rotate([0,0,Tube_a]) translate([TubeOffset_X-(Tube_d-1)/2,-TubeSlot_w/2,Floor_Z-Overlap])
					cube([Tube_d-1, TubeSlot_w, Tube_Z-Floor_Z+Overlap*2]);
					
				Tube(OD=Body_OD+20, ID=Body_ID+1, Len=50, myfn=$preview? 90:360);
			} // difference
		} // union
		
		// Aluminum tube
		translate([TubeOffset_X,0,Tube_Z]) rotate([90,0,Tube_a]) 
			cylinder(d=Tube_d, h=Body_OD, center=true);
			
		//Bolt holes for Electronics bay
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]){
			translate([0, -Body_OD/2-1, EBayInterface_Z+BoltInset]) rotate([90,0,0]) Bolt4Hole();
		} // for
		//cube([100,100,100]);
	} // difference
} // R203_BallRetainerTop

// rotate([180,0,0]) R203_BallRetainerTop();


module R203_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID, HasPD_Ring=false, Xtra_r=0.0){
	// PD_Ring is required to attach the petal hub because 3 balls isn't good enough and 5 won't line up.
	
	Bolt_a=0;// offset between PD_PetalHub and R65_BallRetainerBottom

	
	PD_Ring_h=9;
	
	difference(){
		union(){
			STB_BallRetainerBottom(Body_ID=Body_ID, Body_OD=Body_ID, 
					nLockBalls=nLockBalls, HasSpringGroove=false, 
					Engagement_Len=Engagement_Len, HasLargeInnerBearing=true, Xtra_r=Xtra_r);
		
				
		/*
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

module R203_SkirtRing(Coupler_OD=Coupler_OD, Coupler_ID=Coupler_ID, HasPD_Ring=false){
	Engagemnet_Len=10;
	Plate_t=6;
	ID=Coupler_ID-16;
	
	difference(){
		union(){
			cylinder(d=Coupler_ID, h=Plate_t+Engagemnet_Len, $fn=$preview? 90:360);
			cylinder(d=Coupler_OD, h=Plate_t, $fn=$preview? 90:360);
		} // union
		
		// Remove Center
		translate([0,0,-Overlap]) cylinder(d=ID, h=Plate_t+Engagemnet_Len+Overlap*2, $fn=$preview? 90:360);
		translate([0,0,Plate_t]) cylinder(d1=ID, d2=Coupler_ID-4.4, h=Engagemnet_Len+Overlap, $fn=$preview? 90:360);
		
		if (HasPD_Ring){
			translate([0,0,Plate_t])
				PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=6) Bolt4HeadHole(lHead=Plate_t+Engagemnet_Len);
			
		}else{
			translate([0,0,Plate_t])
				PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=nPetals) Bolt4HeadHole(lHead=Plate_t+Engagemnet_Len);
		}
	} // difference
} // R203_SkirtRing

// R203_SkirtRing();

module R203_PusherRing(OA_Len=50, Engagemnet_Len=10, Wall_t=4){
	
	
	Tube(OD=Coupler_OD, ID=Coupler_ID, Len=OA_Len, myfn=$preview? 90:720);
	translate([0,0,Engagemnet_Len]) 
		Tube(OD=Coupler_OD, ID=Coupler_OD-Wall_t*2, Len=OA_Len-Engagemnet_Len, myfn=$preview? 90:720);
	
} // R203_PusherRing

// rotate([180,0,0]) R203_PusherRing();



















