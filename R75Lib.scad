// ***********************************
// Project: 3D Printed Rocket
// Filename: R75Lib.scad
// by David M. Flynn
// Created: 7/17/2024 
// Revision: 0.9.2  7/22/2024 
// Units: mm
// ***********************************
//  ***** Notes *****
//
// A collection of parts for 75mm rockets.
//
//  ***** History *****
//
// 0.9.2  7/22/2024  Added R75_UpperRailGuideMount()
// 0.9.1  7/18/2024  3 petals, 5 balls, 6 bolts
// 0.9.0  7/17/2024  First code, copied from many places
//
// ***********************************
//  ***** for STL output *****
//
// R75_UpperRailGuideMount(Body_ID=Body_ID, MotorTube_OD=MotorTube_OD);
// R75_MotorTubeTopper(Body_ID=Body_ID, MotorTube_OD=MotorTube_OD, MotorTube_ID=MotorTube_ID);
// R75_BallRetainerTop(Body_OD=Body_OD, Body_ID=Body_ID);  // One small servo w/ shock cord attachment.
// R75_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID, HasPD_Ring=false);
// R75_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID, HasPD_Ring=true); // for bottom of ebay
// R75_PetalHub(Body_OD=Body_OD, Body_ID=Body_ID); // for bottom of ebay
// R75_NC_Base_PetalHub(Body_OD=Body_OD, Body_ID=Body_ID); // for bottom of nosecone
//
// ***********************************
include<TubesLib.scad>
use<SpringThingBooster.scad> SpringThingBoosterRev();
use<PetalDeploymentLib.scad>
use<SpringEndsLib.scad>
use<NoseCone.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 36:90;

CouplerLenXtra=-5;
nLockBalls=5;
nPetals=5;

Engagement_Len=20;

Body_OD=BT75Body_OD;
Body_ID=BT75Body_ID;

Coupler_OD=BT75Coupler_OD;
Coupler_ID=BT75Coupler_ID;
MotorTube_OD=BT54Body_OD;
MotorTube_ID=BT54Body_ID;

module R75_UpperRailGuideMount(Body_ID=Body_ID, MotorTube_OD=MotorTube_OD){
	Len=25;
	
	difference(){
		Tube(OD=Body_ID, ID=MotorTube_OD+IDXtra*2, Len=Len, myfn=$preview? 36:360);
				
		// Rail guide bolts
		translate([Body_ID/2, 0, Len/2]) {
			translate([0,0,6.35]) rotate([0,90,0]) Bolt6Hole();
			translate([0,0,-6.35]) rotate([0,90,0]) Bolt6Hole();
		}
	} // difference
} // R75_UpperRailGuideMount

// R75_UpperRailGuideMount(Body_ID=Body_ID, MotorTube_OD=MotorTube_OD);


module R75_MotorTubeTopper(Body_ID=Body_ID, MotorTube_OD=MotorTube_OD, MotorTube_ID=MotorTube_ID){
// Z zero is top of motor tube
// Sits on top of motor tube
// Has Rail Guide bolt holes
// Has centering ring
// Has shock cord attachment tube
// Has spring holder

	Al_Tube_d=12.7;
	Al_Tube_Z=-Al_Tube_d/2-5;
	Al_Tube_a=-22.50;
	
	ST_DSpring_OD=SE_Spring_CS4323_OD();
	ST_DSpring_ID=SE_Spring_CS4323_ID();
	
	nRopes=3;
	Rope_d=4;
	RopeHoleBC_r=(MotorTube_OD+6)/2+Rope_d/2;

	difference(){
		union(){
			translate([0,0,-20]) 
				Tube(OD=MotorTube_ID, ID=MotorTube_ID-6, Len=21, myfn=$preview? 36:360);
			translate([0,0,-20]) 
				Tube(OD=MotorTube_OD+6, ID=MotorTube_OD+IDXtra*3, Len=21, myfn=$preview? 36:360);
			translate([0,0,-20]) 
				Tube(OD=Body_ID-IDXtra, ID=Body_ID-IDXtra*2-6, Len=21, myfn=$preview? 36:360);
			
			CenteringRing(OD=Body_ID, ID=ST_DSpring_ID, Thickness=5, nHoles=0, Offset=0);
			translate([0,0,4]) 
				Tube(OD=ST_DSpring_OD+8, ID=ST_DSpring_OD, Len=8, myfn=$preview? 36:360);
				
			// Rail guide bolt bosses
			translate([Body_ID/2-2, 0, -9]) hull(){
				translate([0,0,6.35]) rotate([0,-90,0]) cylinder(d=9, h=6);
				translate([0,0,-6.35]) rotate([0,-90,0]) cylinder(d=9, h=6);
		}
		} // union
	
		//translate([0,0,-20]) Tube(OD=MotorTube_ID, ID=MotorTube_ID-6, Len=21, myfn=$preview? 36:360);
		
		translate([0,0,3]) cylinder(d=ST_DSpring_OD, h=4+Overlap);
		translate([0,0,7]) cylinder(d1=ST_DSpring_OD, d2=ST_DSpring_OD+4, h=5+Overlap);
		
		translate([0,0,Al_Tube_Z]) rotate([90,0,Al_Tube_a]) cylinder(d=Al_Tube_d+IDXtra, h=Body_OD, center=true);
		
		// Rail guide bolts
		translate([Body_OD/2, 0, -9]) {
			translate([0,0,6.35]) rotate([0,90,0]) Bolt6Hole();
			translate([0,0,-6.35]) rotate([0,90,0]) Bolt6Hole();
		}
		
		// Rope holes
		for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j]) {
			translate([0,RopeHoleBC_r,-20-Overlap]) cylinder(d=Rope_d, h=25+Overlap*2);
			translate([0,RopeHoleBC_r,-20-Overlap]) cylinder(d=Rope_d+3, h=19);
			}
		
	} // difference

} // R75_MotorTubeTopper

// R75_MotorTubeTopper();


module R75_BallRetainerTop(Body_OD=Body_OD, Body_ID=Body_ID){
	Tube_d=12.7;
	Tube_Z=25;
	Tube_a=-70;
	TubeSlot_w=35;
	TubeOffset_X=10;
	
	Wall_t=3;
	nBolts=3;
	BoltInset=7.5;
	Skirt_H=8;
	
	difference(){
		union(){
			STB_BallRetainerTop(BallPerimeter_d=Body_OD, Body_OD=Body_ID, nLockBalls=nLockBalls,
								HasIntegratedCouplerTube=true, IntegratedCouplerLenXtra=CouplerLenXtra,
								Outer_OD=Body_OD,
								Body_ID=Body_ID-IDXtra, HasSecondServo=false, UsesBigServo=false, Engagement_Len=Engagement_Len);
			
			translate([0,0,Tube_Z]) 
				Tube(OD=Body_ID-IDXtra, ID=Body_ID-IDXtra-Wall_t*2, Len=Tube_d/2+Wall_t, myfn=$preview? 90:360);
			
			// Shock cord retention
			difference(){
				rotate([0,0,Tube_a]) translate([TubeOffset_X,0,Tube_Z])
				hull(){
					rotate([90,0,0]) cylinder(d=Tube_d+Wall_t*2, h=Body_ID-2, center=true);
					translate([0,0,-17]) 
						cube([Tube_d+6, Body_ID-2, 1], center=true);
				} // hull
				
				rotate([0,0,Tube_a]) translate([TubeOffset_X,0,Tube_Z]) hull(){
					rotate([90,0,0]) cylinder(d=Tube_d+7, h=TubeSlot_w, center=true);
					translate([0,0,-17]) 
						cube([Tube_d+6+Overlap, TubeSlot_w,1], center=true);
					}
				// Trim outside
				Tube(OD=Body_OD+20, ID=Body_ID-1, Len=50, myfn=$preview? 90:360);
			} // difference
		} // union
	
		rotate([0,0,Tube_a]) translate([TubeOffset_X,0,Tube_Z]) rotate([90,0,0]) cylinder(d=Tube_d, h=Body_OD, center=true);
		
		//Bolt holes for ebay
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j])
			translate([0, -Body_OD/2-1, Engagement_Len/2+Skirt_H+7.5]) 
				rotate([90,0,0]) Bolt4Hole();
		
	} // difference
} // R75_BallRetainerTop

//  R75_BallRetainerTop(Body_OD=Body_OD, Body_ID=Body_ID);



module R75_BallRetainerTopTest(Body_OD=Body_OD, Body_ID=Body_ID){
  // test of thick walled e-bay

	Tube_d=12.7;
	Tube_Z=25;
	Tube_a=-70;
	TubeSlot_w=35;
	TubeOffset_X=10;
	
	Wall_t=3;
	nBolts=3;
	BoltInset=7.5;
	Skirt_H=8;
	
	EBayWall_t=3.5;
	EBay_ID=Body_OD-EBayWall_t*2;
	
	difference(){
		union(){
			STB_BallRetainerTop(BallPerimeter_d=Body_OD, Body_OD=Body_ID, nLockBalls=nLockBalls,
								HasIntegratedCouplerTube=true, IntegratedCouplerLenXtra=CouplerLenXtra,
								Outer_OD=Body_OD,
								Body_ID=EBay_ID-IDXtra, HasSecondServo=false, UsesBigServo=false, Engagement_Len=Engagement_Len);
			
			translate([0,0,Tube_Z]) 
				Tube(OD=EBay_ID-IDXtra, ID=EBay_ID-IDXtra-Wall_t*2, Len=Tube_d/2+Wall_t, myfn=$preview? 90:360);
			
			// Shock cord retention
			difference(){
				rotate([0,0,Tube_a]) translate([TubeOffset_X,0,Tube_Z])
				hull(){
					rotate([90,0,0]) cylinder(d=Tube_d+Wall_t*2, h=EBay_ID-2, center=true);
					translate([0,0,-17]) 
						cube([Tube_d+6, EBay_ID-2, 1], center=true);
				} // hull
				
				rotate([0,0,Tube_a]) translate([TubeOffset_X,0,Tube_Z]) hull(){
					rotate([90,0,0]) cylinder(d=Tube_d+7, h=TubeSlot_w, center=true);
					translate([0,0,-17]) 
						cube([Tube_d+6+Overlap, TubeSlot_w,1], center=true);
					}
				// Trim outside
				Tube(OD=Body_OD+20, ID=EBay_ID-1, Len=50, myfn=$preview? 90:360);
			} // difference
		} // union
	
		rotate([0,0,Tube_a]) translate([TubeOffset_X,0,Tube_Z]) rotate([90,0,0]) cylinder(d=Tube_d, h=Body_OD, center=true);
		
		//Bolt holes for ebay
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+12])
			translate([0, -Body_OD/2-1, Engagement_Len/2+Skirt_H+7.5]) 
				rotate([90,0,0]) Bolt4Hole();
		
	} // difference
} // R75_BallRetainerTopTest

//  R75_BallRetainerTopTest(Body_OD=Body_OD, Body_ID=Body_ID);

module R75_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID, HasPD_Ring=false){
	// PD_Ring is required to attach the petal hub because 3 balls isn't good enough and 5 won't line up.
	
	Bolt_a=20;// offset between PD_PetalHub and R65_BallRetainerBottom

	
	PD_Ring_h=9;
	
	difference(){
		union(){
			STB_BallRetainerBottom(BallPerimeter_d=Body_OD, Body_OD=Body_ID, 
					nLockBalls=nLockBalls, HasSpringGroove=false, Engagement_Len=Engagement_Len, HasLargeInnerBearing=false);
					
		
			if (HasPD_Ring){
				translate([0,0,-Engagement_Len/2-PD_Ring_h])
					Tube(OD=Body_ID-IDXtra*2, ID=Body_ID-IDXtra-4.4, Len=PD_Ring_h+Overlap, myfn=$preview? 90:360);
				
				rotate([0,0,Bolt_a]) translate([0,0,-Engagement_Len/2-PD_Ring_h])
					PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=6) cylinder(d=8, h=PD_Ring_h+Overlap);
			}
		} // union
		
		if (HasPD_Ring)
		rotate([0,0,Bolt_a]) translate([0,0,-Engagement_Len/2-PD_Ring_h])
			PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=6) rotate([180,0,0]) Bolt4Hole(depth=PD_Ring_h-1);

	} // difference
} // R75_BallRetainerBottom

// R75_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID, HasPD_Ring=false);
// R75_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID, HasPD_Ring=true);


module R75_PetalHub(Body_OD=Body_OD, Body_ID=Body_ID, Coupler_OD=Coupler_OD){
	ShockCord_a=45;
	
	PD_PetalHub(OD=Coupler_OD, 
					nPetals=3, 
					HasBolts=true,
					nBolts=6,
					ShockCord_a=ShockCord_a,
					HasNCSkirt=false, 
						Body_OD=Body_OD,
						Body_ID=Body_ID,
						NC_Base=0, 
						SkirtLen=10);
} // R75_PetalHub

//translate([0,0,-21]) rotate([180,0,200]) R75_PetalHub(Body_OD=Body_OD, Body_ID=Body_ID);
						
module R75_NC_Base_PetalHub(Body_OD=Body_OD, Body_ID=Body_ID, Coupler_OD=Coupler_OD){
	ShockCord_a=-1;
	
	difference(){
		PD_PetalHub(OD=Coupler_OD, 
					nPetals=3, 
					HasBolts=true,
					nBolts=6,
					ShockCord_a=ShockCord_a,
					HasNCSkirt=false, 
						Body_OD=Body_OD,
						Body_ID=Body_ID,
						NC_Base=0, 
						SkirtLen=10);
						
		translate([0,0,-Overlap]) cylinder(d=21, h=10);
	} // difference
} // R75_NC_Base_PetalHub

// R75_NC_Base_PetalHub();

module R75_NC_Base(Body_OD=Body_OD, Body_ID=Body_ID, NC_Base_L=15, Coupler_OD=Coupler_OD){
	nBolts=6;
	
	difference(){
		union(){
			NC_ShockcordRing75(Body_OD=Body_OD, Body_ID=Body_ID, NC_Base_L=NC_Base_L);
			
			translate([0,0,-3]) cylinder(d=Body_OD, h=3, $fn=$preview? 90:360);
		} // union
		
		translate([0,0,-20]) cylinder(d=Body_OD+1, h=17);
		translate([0,0,-3-Overlap]) hull(){
			translate([-8,0,0]) cylinder(d=19, h=6);
			translate([8,0,0]) cylinder(d=19, h=6);
		} // hull
		
		rotate([0,0,20]) translate([0,0,-3]) PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=nBolts) rotate([180,0,0]) Bolt4Hole();
	} // difference
} // R75_NC_Base

// R75_NC_Base();






















