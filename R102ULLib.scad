// ***********************************
// Project: 3D Printed Rocket
// Filename: R102ULLib.scad
// by David M. Flynn
// Created: 5/5/2024 
// Revision: 0.9.6  12/30/2024 
// Units: mm
// ***********************************
//  ***** Notes *****
//
// A collection of parts for 102mm rockets.
//
//  ***** History *****
//
// 0.9.6  12/30/2024 Fixed it again.
// 0.9.5  12/30/2024 Better ball lock w/ 6806 bearing.
// 0.9.4  12/27/2024 Updated for ULine 4 inch tubes
// 0.9.3  10/27/2024 Updated to current SpringThingBooster
// 0.9.2  7/16/2024 Added R75_BallRetainerTop
// 0.9.1  5/7/2024  Added R98C_MotorTubeTopper(), R98C_MotorTubeTopperNL()
// 0.9.0  5/5/2024  First code, copied from many places
//
// ***********************************
//  ***** for STL output *****
//
// R102UL_SkirtRing(Coupler_OD=Coupler_OD, Coupler_ID=Coupler_ID, HasPD_Ring=false);
// R102UL_PusherRing(OD=Coupler_OD, ID=Coupler_ID, OA_Len=50, Engagemnet_Len=7, Wall_t=4);
//
// R102UL_MotorTubeTopper(); // Glues to top of motor tube, spring holder and rope holes.
// R102UL_BallRetainerTop(Body_OD=Body_OD, Body_ID=Body_ID); // One servo w/ shock cord attachment.
// R102UL_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID); // w/ 3 bolt holes for PetalHub.
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
nLockBalls=6;
nPetals=3;
nRopes=6;

Body_OD=ULine102Body_OD;
Body_ID=ULine102Body_ID;
BodyTubeAnnulus=1.0; // for sliders

Coupler_OD=BT98Body_OD;
Coupler_ID=BT98Body_ID;
MotorTube_OD=BT54Body_OD;
MotorTube_ID=BT54Body_ID;


module R102UL_SkirtRing(Coupler_OD=Coupler_OD, Coupler_ID=Coupler_ID, HasPD_Ring=false){
	Engagemnet_Len=7;
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
} // R102UL_SkirtRing

// R102UL_SkirtRing(HasPD_Ring=true);

module R102UL_PusherRing(OD=Coupler_OD, ID=Coupler_ID, OA_Len=50, Engagemnet_Len=7, Wall_t=4){
	
	
	Tube(OD=OD, ID=ID, Len=OA_Len, myfn=$preview? 90:720);
	
	translate([0,0,Engagemnet_Len]) difference(){
		Tube(OD=OD, ID=OD-Wall_t*2, Len=OA_Len-Engagemnet_Len, myfn=$preview? 90:720);
		
		// Reduce mass by thinning inside
		A=OA_Len-Engagemnet_Len-18;
		if (A>0){
			translate([0,0,3]) cylinder(d1=OD-Wall_t*2-Overlap, d2=ID, h=6, $fn=$preview? 90:720);
			translate([0,0,9-Overlap]) cylinder(d=ID, h=A+Overlap*2, $fn=$preview? 90:720);
			translate([0,0,9+A]) cylinder(d2=OD-Wall_t*2-Overlap, d1=ID, h=6, $fn=$preview? 90:720);
		}
	} // difference
} // R102UL_PusherRing

// rotate([180,0,0]) R102UL_PusherRing();

module R102UL_LowerSpringBottom(){
	// Sits on top of coupler tube sitting on R102UL_MotorTubeTopper
	
	ST_DSpring_OD=SE_Spring_CS4323_OD();
	ST_DSpring_ID=SE_Spring_CS4323_ID();
	Len=12;
	OD=Body_ID-BodyTubeAnnulus;
				
	Tube(OD=OD, ID=OD-4.4, 
			Len=Len, myfn=$preview? 90:360);
			
	difference(){
		translate([0,0,Len-5]) cylinder(d=OD-1, h=5);
		
		translate([0,0,Len-3]) cylinder(d=ST_DSpring_OD, h=5);
		translate([0,0,-Overlap]) cylinder(d=ST_DSpring_ID-1, h=35+Overlap*2);
		for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j]) translate([0,OD/2-7,-Overlap])
			cylinder(d=4,h=Len+Overlap*2);
	} // difference


} // R102UL_LowerSpringBottom

//rotate([180,0,0]) R102UL_LowerSpringBottom();

module R102UL_MotorTubeTopper(MotorTube_OD=MotorTube_OD, MotorTube_ID=MotorTube_ID, HasPassThru=true, nRopes=6){
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
	
	Rope_d=4;
	RopeHoleBC_r=(MotorTube_OD+8)/2+Rope_d/2+1;
	
	Bottom=21;

	difference(){
		union(){
			if (!HasPassThru) translate([0,0,-Bottom]) 
				Tube(OD=MotorTube_ID, ID=MotorTube_ID-8, Len=Bottom+1, myfn=$preview? 36:360);
			translate([0,0,-Bottom]) 
				Tube(OD=MotorTube_OD+8, ID=MotorTube_OD+IDXtra*3, Len=Bottom+1, myfn=$preview? 36:360);
			translate([0,0,-Bottom]) 
				Tube(OD=Body_ID, ID=Body_ID-16, Len=Bottom+1, myfn=$preview? 36:360);
			if (HasPassThru){
				CenteringRing(OD=Body_ID, ID=MotorTube_ID, Thickness=5, nHoles=0, Offset=0, myfn=$preview? 90:360);
			}else{
				CenteringRing(OD=Body_ID, ID=ST_DSpring_ID, Thickness=5, nHoles=0, Offset=0, myfn=$preview? 90:360);
			}
			
			if (!HasPassThru) translate([0,0,4]) 
				Tube(OD=ST_DSpring_OD+8, ID=ST_DSpring_OD, Len=8, myfn=$preview? 36:360);
				
			translate([Body_ID/2-1, 0, -Bottom+5+6.35]) hull(){
				translate([0,0,6.35]) rotate([0,-90,0]) cylinder(d=10, h=20);
				translate([0,0,-6.35]) rotate([0,-90,0]) cylinder(d=10, h=20);
			}
		} // union
	
		translate([0,0,-Bottom-Overlap]) cylinder(d=MotorTube_OD+IDXtra*3, h=Bottom, $fn=$preview? 36:360);
		if (HasPassThru) 
			translate([0,0,-Bottom-Overlap]) cylinder(d=MotorTube_ID, h=Bottom+5+Overlap*2, $fn=$preview? 36:360);
		
		translate([0,0,3]) cylinder(d=ST_DSpring_OD, h=4+Overlap);
		translate([0,0,7]) cylinder(d1=ST_DSpring_OD, d2=ST_DSpring_OD+4, h=5+Overlap);
		
		if (!HasPassThru) 
		translate([0,0,Al_Tube_Z]) rotate([90,0,0]) cylinder(d=Al_Tube_d+IDXtra, h=Body_OD, center=true);
		
		translate([Body_OD/2, 0, -Bottom+5+6.35]) {
			translate([0,0,6.35]) rotate([0,90,0]) Bolt6Hole();
			translate([0,0,-6.35]) rotate([0,90,0]) Bolt6Hole();
		}
		
		// Rope holes
		if (nRopes>0)
			for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j]) // +180/nRopes
				translate([0,RopeHoleBC_r,-Overlap]) cylinder(d=Rope_d, h=5+Overlap*2);
		
	} // difference

} // R102UL_MotorTubeTopper

// R102UL_MotorTubeTopper();

// R102UL_MotorTubeTopper(MotorTube_OD=MotorTube_OD, MotorTube_ID=MotorTube_ID, HasPassThru=true, nRopes=6);

module R102UL_BallRetainerTop(Body_OD=Body_OD, Body_ID=Body_ID, nBolts=3, Xtra_r=0.0){
	Tube_d=12.7;
	
	Tube_a=-15;
	TubeSlot_w=35;
	TubeOffset_X=0;
	Engagement_Len=20;
	BoltInset=7.5;
	Skirt_H=24;
	EBayInterface_Z=Engagement_Len/2+Skirt_H+CouplerLenXtra;
	Floor_Z=8;
	Top_Z=EBayInterface_Z+BoltInset*2+1;
	Tube_Z=Top_Z-Tube_d/2-3;
	
	difference(){
		union(){
		
			STB_BallRetainerTop(Body_ID=Body_ID, Outer_OD=Body_OD, Engagement_d=Body_ID, nLockBalls=nLockBalls,
								HasIntegratedCouplerTube=true, nBolts=0,
								IntegratedCouplerLenXtra=CouplerLenXtra,
								HasSecondServo=false, UsesBigServo=true,
								Engagement_Len=Engagement_Len, HasLargeInnerBearing=true, Xtra_r=Xtra_r);
			
		
			// Extend skirt
			translate([0,0,Top_Z-15]) 
				Tube(OD=Body_ID, ID=Body_ID-IDXtra-6, Len=15, myfn=$preview? 90:360);
			
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
	
		translate([TubeOffset_X,0,Tube_Z]) rotate([90,0,Tube_a]) cylinder(d=Tube_d, h=Body_OD, center=true);
		
		//Bolt holes for nosecone and ball lock
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+5]){
			translate([0, -Body_OD/2-1, EBayInterface_Z+BoltInset]) rotate([90,0,0]) Bolt4Hole();
		} // for
	} // difference
} // R102UL_BallRetainerTop

// rotate([180,0,0]) R102UL_BallRetainerTop();

module R102UL_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID, Xtra_r=0.0){
	Engagement_Len=20;
	
	difference(){
		STB_BallRetainerBottom(Body_ID=Body_ID, Body_OD=Body_ID, nLockBalls=nLockBalls, HasSpringGroove=false, 
			Engagement_Len=Engagement_Len, HasLargeInnerBearing=true, Xtra_r=Xtra_r);
		
		rotate([0,0,180/nLockBalls]) 
			PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=nPetals) Bolt4Hole();
			
		// a second set of holes, 6 total
		rotate([0,0,180/nLockBalls+360/nLockBalls]) 
			PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=nPetals) Bolt4Hole();

	} // difference
} // R102UL_BallRetainerBottom

// translate([0,0,-9]) rotate([180,0,0]) R102UL_BallRetainerBottom();





















