// ***********************************
// Project: 3D Printed Rocket
// Filename: R98Lib.scad
// by David M. Flynn
// Created: 5/5/2024 
// Revision: 0.9.3  10/27/2024 
// Units: mm
// ***********************************
//  ***** Notes *****
//
// A collection of parts for 98mm rockets.
//
//  ***** History *****
//
// 0.9.3  10/27/2024 Updated to current SpringThingBooster
// 0.9.2  7/16/2024 Added R75_BallRetainerTop
// 0.9.1  5/7/2024  Added R98C_MotorTubeTopper(), R98C_MotorTubeTopperNL()
// 0.9.0  5/5/2024  First code, copied from many places
//
// ***********************************
//  ***** for STL output *****
//
// R98C_MotorTubeTopper(); // Glues to top of motor tube, spring holder and rope holes.
// R98C_MotorTubeTopperNL(); // Glues to top of motor tube, w/o spring holder and rope holes.
// R98C_BallRetainerTop(Body_OD=Body_OD, Body_ID=Body_ID); // One servo w/ shock cord attachment.
// R98_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID); // w/ 3 bolt holes for PetalHub.
//
// R75_BallRetainerTop(Body_OD=Body75_OD, Body_ID=Body75_ID);  // One small servo w/ shock cord attachment.
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
nLockBalls=6;
nPetals=3;

ShockCord_a=17;// offset between PD_PetalHub and R65_BallRetainerBottom


Body_OD=BT98Body_OD;
Body_ID=BT98Body_ID;
Body75_OD=BT75Body_OD;
Body75_ID=BT75Body_ID;

Coupler_OD=BT98Coupler_OD;
Coupler_ID=BT98Coupler_ID;
MotorTube_OD=BT54Body_OD;
MotorTube_ID=BT54Body_ID;


module R98C_MotorTubeTopper(){
// Z zero is top of motor tube
// Sits on top of motor tube
// Has Rail Guide bolt holes
// Has centering ring
// Has shock cord attachment tube
// Has spring holder

	Al_Tube_d=12.7;
	Al_Tube_Z=-Al_Tube_d/2-5;
	
	ST_DSpring_OD=SE_Spring_CS4323_OD();
	ST_DSpring_ID=SE_Spring_CS4323_ID();
	
	nRopes=6;
	Rope_d=4;
	RopeHoleBC_r=(MotorTube_OD+8)/2+Rope_d/2+1;

	difference(){
		union(){
			translate([0,0,-20]) 
				Tube(OD=MotorTube_ID, ID=MotorTube_ID-8, Len=21, myfn=$preview? 36:360);
			translate([0,0,-20]) 
				Tube(OD=MotorTube_OD+8, ID=MotorTube_OD+IDXtra*3, Len=21, myfn=$preview? 36:360);
			translate([0,0,-20]) 
				Tube(OD=Body_ID-IDXtra*2, ID=Body_ID-16, Len=21, myfn=$preview? 36:360);
			CenteringRing(OD=Body_ID, ID=ST_DSpring_ID, Thickness=5, nHoles=0, Offset=0);
			translate([0,0,4]) 
				Tube(OD=ST_DSpring_OD+8, ID=ST_DSpring_OD, Len=8, myfn=$preview? 36:360);
		} // union
	
		//translate([0,0,-20]) Tube(OD=MotorTube_ID, ID=MotorTube_ID-6, Len=21, myfn=$preview? 36:360);
		
		translate([0,0,3]) cylinder(d=ST_DSpring_OD, h=4+Overlap);
		translate([0,0,7]) cylinder(d1=ST_DSpring_OD, d2=ST_DSpring_OD+4, h=5+Overlap);
		
		translate([0,0,Al_Tube_Z]) rotate([90,0,0]) cylinder(d=Al_Tube_d+IDXtra, h=Body_OD, center=true);
		
		translate([Body_OD/2, 0, -9]) {
			translate([0,0,6.35]) rotate([0,90,0]) Bolt6Hole();
			translate([0,0,-6.35]) rotate([0,90,0]) Bolt6Hole();
		}
		
		// Rope holes
		for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j+180/nRopes]) 
			translate([0,RopeHoleBC_r,-Overlap]) cylinder(d=Rope_d, h=5+Overlap*2);
		
	} // difference

} // R98C_MotorTubeTopper

// R98C_MotorTubeTopper();



module R98C_MotorTubeTopperNL(){
// Z zero is top of motor tube
// Sits on top of motor tube
// Has centering ring
// Has shock cord attachment tube

	Al_Tube_d=12.7;
	Al_Tube_Z=-Al_Tube_d/2-5;
	
	difference(){
		union(){
			translate([0,0,-20]) 
				Tube(OD=MotorTube_ID, ID=MotorTube_ID-8, Len=21, myfn=$preview? 36:360);
			translate([0,0,-20]) 
				Tube(OD=MotorTube_OD+8, ID=MotorTube_OD+IDXtra*3, Len=21, myfn=$preview? 36:360);
			translate([0,0,-20]) 
				Tube(OD=Coupler_ID-IDXtra*2, ID=Coupler_ID-13, Len=21, myfn=$preview? 36:360);
			CenteringRing(OD=Coupler_ID, ID=MotorTube_ID-8, Thickness=5, nHoles=0, Offset=0);
			
		} // union
		
		translate([0,0,Al_Tube_Z]) rotate([90,0,0]) 
			cylinder(d=Al_Tube_d+IDXtra, h=Body_OD, center=true);
		
	} // difference

} // R98C_MotorTubeTopperNL

// R98C_MotorTubeTopperNL();

module R98C_BallRetainerTop(Body_OD=Body_OD, Body_ID=Body_ID){
	Tube_d=12.7;
	Tube_Z=31;
	Tube_a=-3;
	TubeSlot_w=35;
	TubeOffset_X=22;
	Engagement_Len=20;
	nBolts=3;
	BoltInset=7.5;
	Skirt_H=24;
	
	difference(){
		union(){
			STB_BallRetainerTop(Body_ID=Body_ID, Outer_OD=0, Body_OD=Body_ID, nLockBalls=nLockBalls,
			HasIntegratedCouplerTube=true, nBolts=0,
			IntegratedCouplerLenXtra=CouplerLenXtra,
				
			HasSecondServo=false,
			UsesBigServo=true,
			Engagement_Len=Engagement_Len, HasLargeInnerBearing=false);
			
		
				
			translate([0,0,35.5]) 
				Tube(OD=Body_ID-IDXtra, ID=Body_ID-IDXtra-6, Len=5, myfn=$preview? 90:360);
			
			// Shock cord retention
			difference(){
				union(){
					rotate([0,0,Tube_a]) translate([TubeOffset_X,0,Tube_Z]) 
						rotate([90,0,0]) cylinder(d=Tube_d+6, h=Body_ID-2, center=true);
					rotate([0,0,Tube_a]) translate([TubeOffset_X,0,Tube_Z-12.2])
						cube([Tube_d-3, Body_ID-2, 21], center=true);
				} // union
				
				rotate([0,0,Tube_a]) translate([TubeOffset_X,0,Tube_Z]) 
					rotate([90,0,0]) cylinder(d=Tube_d+7, h=TubeSlot_w, center=true);
				rotate([0,0,Tube_a]) translate([TubeOffset_X,0,Tube_Z-12.2])
					cube([Tube_d-1, TubeSlot_w,21.1], center=true);
					
				Tube(OD=Body_OD+20, ID=Body_ID-1, Len=50, myfn=$preview? 90:360);
			} // difference
		} // union
	
		translate([TubeOffset_X,0,Tube_Z]) rotate([90,0,Tube_a]) cylinder(d=Tube_d, h=Body_OD, center=true);
		
		//Bolt holes for nosecone and ball lock
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]){
			translate([0,-Body_OD/2-1,Engagement_Len/2+Skirt_H+CouplerLenXtra+BoltInset]) rotate([90,0,0]) Bolt4Hole();
		} // for
	} // difference
} // R98C_BallRetainerTop

// rotate([180,0,0]) R98C_BallRetainerTop();

module R98_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID){
	Engagement_Len=20;
	
	difference(){
		STB_BallRetainerBottom(Body_ID=Body_ID, Body_OD=Body_ID, nLockBalls=nLockBalls, HasSpringGroove=false, 
			Engagement_Len=Engagement_Len, HasLargeInnerBearing=false);
		
		rotate([0,0,PD_ShockCordAngle()-ShockCord_a]) 
			PD_PetalHubBoltPattern(OD=Coupler_OD) Bolt4Hole();

	} // difference
} // R98_BallRetainerBottom

// translate([0,0,-9]) rotate([180,0,0]) R98_BallRetainerBottom();
//rotate([0,0,152]) PD_PetalHub(Coupler_OD=Coupler_OD, nPetals=nPetals, ShockCord_a=PD_ShockCordAngle());





















