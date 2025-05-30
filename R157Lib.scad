// ***********************************
// Project: 3D Printed Rocket
// Filename: R157Lib.scad
// by David M. Flynn
// Created: 1/19/2025 
// Revision: 0.9.0  1/19/2025 
// Units: mm
// ***********************************
//  ***** Notes *****
//
// A collection of parts for 203mm (8" mailing tube) rockets.
//
//  ***** History *****
//
// 0.9.0  1/19/2025   Copied from R203Lib.scad Rev 0.9.3
//
// ***********************************
//  ***** for STL output *****
//
// R157_NC_PetalHub();
// R157_MotorTubeTopper();
// R157_PetalHub(Body_OD=Coupler_OD);
// R157_BallRetainerTop(Body_OD=Body_OD, Body_ID=Body_ID, EBayTube_OD=BT54Body_OD, nBolts=7, Xtra_r=0.0);
// R157_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID, HasPD_Ring=false);
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
nPetals=6;
nEBayBolts=6;
EBayBoltInset=7.5;

Body_OD=ULine157Body_OD;
Body_ID=ULine157Body_ID;

Coupler_OD=ULine157Coupler_OD;
Coupler_ID=ULine157Coupler_ID;

MotorTube_OD=BT75Body_OD;
MotorTube_ID=BT75Body_ID;


module R157_NC_PetalHub(OD=Body_ID-BodyTubeAnnulus, nPetals=nPetals, CouplerTube_ID=Coupler_ID){
	nRopes=nPetals;
	Spring_ID=SE_Spring_CS11890_ID();
	Spring_OD=SE_Spring_CS11890_OD();
				
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
	
} // R157_NC_PetalHub

// R157_NC_PetalHub();

module R157_MotorTubeTopper(){
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

} // R157_MotorTubeTopper

// R157_MotorTubeTopper();

module R157_PetalHub(OD=Coupler_OD){
	// Bolts to bottom of electronics bay
	PD_PetalHub(OD=OD, 
					nPetals=nPetals, 
					HasReplaceableSpringHolder=true,
					HasBolts=true,
					nBolts=nPetals,
					ShockCord_a=-2,
					HasNCSkirt=false, CenterHole_d=OD-60);
					
} // R157_PetalHub

// translate([0,0,-20]) rotate([180,0,0]) R157_PetalHub();
// R157_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID, HasPD_Ring=true);

module R157_BallRetainerTop(Body_OD=Body_OD, Body_ID=Body_ID, EBayTube_OD=BT54Body_OD, Engagement_Len=0, nBolts=7, Xtra_r=0.0){
	Tube_d=12.7;
	Skirt_Len=16;
	Tube_a=-38.5;
	TubeSlot_w=34;
	TubeOffset_X=0;	
		
	BoltInset=8;
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
				
				// Trim outside	
				Tube(OD=Body_OD+20, ID=Body_ID+1, Len=50, myfn=$preview? 90:360);
			} // difference
			
			// Center tube
			translate([0,0,Floor_Z]) Tube(OD=EBayTube_OD+IDXtra*2+6, ID=EBayTube_OD-3, Len=Top_Z-Floor_Z, myfn=$preview? 90:360);
			
			// Spokes
			Spoke_Angles=[0,22,80,115,177,235,270];
			Spoke_w=3;
			translate([0,0,Floor_Z]) for (j=Spoke_Angles) rotate([0,0,j])
				translate([-Spoke_w/2,EBayTube_OD/2+IDXtra*2,0]) cube([Spoke_w, Body_ID/2-EBayTube_OD/2-1, Top_Z-Floor_Z]);
		} // union
		
		// EBay Tube
		translate([0,0,Tube_Z+Tube_d/2-0.5]) cylinder(d=EBayTube_OD+IDXtra*2, h=10);
		
		// Aluminum tube
		translate([TubeOffset_X,0,Tube_Z]) rotate([90,0,Tube_a]) 
			cylinder(d=Tube_d, h=Body_OD, center=true);
			
		//Bolt holes for Electronics bay
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]){
			translate([0, -Body_OD/2-1, EBayInterface_Z+BoltInset]) rotate([90,0,0]) Bolt4Hole();
		} // for
		//cube([100,100,100]);
	} // difference
} // R157_BallRetainerTop

// rotate([180,0,0]) R157_BallRetainerTop();


module R157_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID, Engagement_Len=0, Xtra_r=0.0){
	// PD_Ring is required to attach the petal hub because 3 balls isn't good enough and 5 won't line up.
	
	Bolt_a=0;// offset between PD_PetalHub and R65_BallRetainerBottom
	PD_Ring_h=9;
	
	difference(){
		
		STB_BallRetainerBottom(Body_ID=Body_ID, Body_OD=Body_ID, 
					nLockBalls=nLockBalls, HasSpringGroove=false, 
					Engagement_Len=Engagement_Len, HasLargeInnerBearing=true, Xtra_r=Xtra_r);
		
		rotate([0,0,Bolt_a]) translate([0,0,-Engagement_Len/2])
			PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=nPetals) rotate([180,0,0]) Bolt4Hole(depth=20);

	} // difference
} // R157_BallRetainerBottom

// R157_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID);

module R157_SkirtRing(Coupler_OD=Coupler_OD, Coupler_ID=Coupler_ID, HasPD_Ring=false){
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
} // R157_SkirtRing

// R157_SkirtRing();

module R157_PusherRing(OD=Coupler_OD, ID=Coupler_ID, OA_Len=50, Engagemnet_Len=7, Wall_t=4){
	
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
} // R157_PusherRing

// rotate([180,0,0]) R157_PusherRing();



















