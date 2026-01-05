// ***********************************************************
// Project: 3D Printed Rocket
// Filename: FairingNoseconeLib.scad
// by David M. Flynn
// Created: 12/27/2025 
// Revision: 1.0.0  12/28/2025
// Units: mm
// ***********************************
//  ***** Notes *****
//
// A generic fairing nosecone.
// Looks like a fairing but is just an oversized nosecone.
// Shape is similar to a Falcom 9 fairing.
// 
// Originally for BP3, EBay is 98mm fairing inner tube is 102mm
//
// ***********************************
//  ***** History *****
//
// 1.0.0  12/28/2025   Code cleaning, first printing
// 0.9.0  12/27/2025   First Code.
//
// ***********************************
//  ***** for STL output *****
//
// FNL_Nosecone();
//
// FNL_ShockCordAttachment();
// rotate([180,0,0]) FNL_TopSpingEnd();
// FNL_SlidingSpringMiddle();
//
// FNL_PetalHub();
// FNL_Petals();
// rotate([-90,0,0]) PD_PetalSpringHolder();
// PD_HubSpringHolder();
//
// FNL_FairingTube(OD=Fairing_OD*CF_Comp, Len=Fairing_Len);
// FNL_CenteringRing();
//
// FNL_FairingBase(OD=Fairing_OD*CF_Comp); // includes STB_TubeEnd
//
// STB_BallRetainerBottom(Body_ID=Body_ID*CF_Comp, Body_OD=Body_ID*CF_Comp, nLockBalls=nLockBalls, Engagement_Len=Engagement_Len, HasLargeInnerBearing=true, Lighten=false, Xtra_r=0.2);
// rotate([180,0,0]) FNL_Custom_BallRetainerTop();
// STB_LockDisk(Body_ID=Body_ID*CF_Comp, nLockBalls=nLockBalls, HasLargeInnerBearing=true, Xtra_r=0.2);

// ***********************************
//  ***** for Viewing *****
//
// FNL_Show_Fairing(ShowInternals=false);
// FNL_Show_Fairing(ShowInternals=true);
//
// ***********************************
include<TubesLib.scad>
use<NoseCone.scad>
use<PetalDeploymentLib.scad>
use<SpringEndsLib.scad>
use<SpringThingBooster.scad>
//also included
  //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 36:90;

nPetals=3;
Petal_Len=200;
nLockBalls=6;
Engagement_Len=20;

Body_OD=ULine102Body_OD;
Body_ID=ULine102Body_ID;
InnerTubeLen=Petal_Len+91+30;
Fairing_OD=130;
Fairing_Len=Petal_Len;
FairingWall_t=1.6;
nFairingRivets=5;
Rivet_d=4;

NC_Len=185;
NC_Base_L=15;
NC_Tip_R=15;
NC_Wall_t=FairingWall_t;

echo(InnerTubeLen=InnerTubeLen);

module FNL_PetalHub(){
	PD_NC_PetalHub(OD=Body_ID-1, nPetals=nPetals, HasReplaceableSpringHolder=true, nRopes=6, ShockCord_a=-1, 
					HasThreadedCore=false, ST_DSpring_ID=SE_Spring_CS4323_ID(), ST_DSpring_OD=SE_Spring_CS4323_OD(), 
					CouplerTube_ID=0, CouplerTubeLen=0);
} // FNL_PetalHub

module FNL_Petals(){
	PD_Petals(OD=Body_ID-1, Len=Petal_Len, nPetals=nPetals, Wall_t=2.0, AntiClimber_h=4, HasLocks=false, Lock_Span_a=0);
} // FNL_Petals

module FNL_SlidingSpringMiddle(){
	SE_SlidingSpringMiddle(OD=Body_ID-1, Wall_t=1.6, nRopes=0, SliderLen=40, SpLen=40, SpringStop_Z=20, 
					UseSmallSpring=true, nSpokes=6, HasInnerTube=false);
} // FNL_SlidingSpringMiddle

// FNL_SlidingSpringMiddle();

module FNL_CenteringRing(){
	CenteringRing(OD=Fairing_OD*CF_Comp-FairingWall_t*2, ID=Body_OD*CF_Comp+IDXtra, Thickness=3, nHoles=3, Offset=0, myfn=$preview? 90:180);
} // FNL_CenteringRing

module FNL_Show_Fairing(ShowInternals=false){
	FairingTube_Z=0;
	InnerTube_Z=FairingTube_Z-30;
	Nosecone_Z=FairingTube_Z+Fairing_Len;
	TopSpingEnd_Z=Nosecone_Z+91;

	translate([0,0,Nosecone_Z]) FNL_Nosecone();
	
	translate([0,0,TopSpingEnd_Z]) {
		translate([0,0,4.1]) FNL_ShockCordAttachment();
		FNL_TopSpingEnd();
	}
	
	if (ShowInternals) translate([0,0,TopSpingEnd_Z-60])
		FNL_SlidingSpringMiddle();
	
	if (ShowInternals)	translate([0,0,Nosecone_Z]){
		rotate([180,0,0]) FNL_PetalHub();
		translate([0,0,-10]) rotate([180,0,0]) FNL_Petals();
	}
	
	
	FNL_FairingTube(OD=Fairing_OD*CF_Comp, Len=Fairing_Len);
	translate([0,0,Fairing_Len-10]) FNL_CenteringRing();
	
	// InnerTube
	if (!ShowInternals) translate([0,0,InnerTube_Z]) color("Tan") Tube(OD=Body_OD, ID=Body_ID, Len=InnerTubeLen, myfn=90);
	
	FNL_FairingBase();
} // FNL_Show_Fairing

// FNL_Show_Fairing();

module FNL_Custom_BallRetainerTop(){
	EBay_OD=PML98Body_OD;
	EBay_ID=PML98Body_ID;
	Wall_t=2.2;
	Retainer_OD=Body_ID*CF_Comp;
	Skirt_Len=8;
	nBolts=4;
	SC_Tube_OD=LOC29Body_OD+IDXtra*2;
	
	difference(){
		STB_BallRetainerTop(Body_ID=Retainer_OD, Outer_OD=Retainer_OD, Engagement_d=Body_ID*CF_Comp, 
							nLockBalls=nLockBalls, HasIntegratedCouplerTube=false, nBolts=4, 
							HasSecondServo=false, UsesBigServo=true, Engagement_Len=Engagement_Len, HasLargeInnerBearing=true, Xtra_r=0.2);
		//cube([100,100,100]);		
	} // difference
							
	difference(){
		union(){
			translate([0,0,Engagement_Len/2]) Tube(OD=EBay_OD+Wall_t*2, ID=EBay_ID-1, Len=Skirt_Len, myfn=$preview? 90:360);
			translate([0,0,Engagement_Len/2-4.5]) Tube(OD=EBay_ID, ID=EBay_ID-Wall_t*2, Len=5+Skirt_Len+15, myfn=$preview? 90:360);
			
			// Shockcord tube
			translate([0,0,Engagement_Len/2-4.5]) 
				Tube(OD=28, ID=23, Len=5+Skirt_Len, myfn=90);
				
			difference(){
				translate([0,0,Engagement_Len/2-4.5+5+Skirt_Len-Overlap]) 
					cylinder(d1=28, d2=SC_Tube_OD+2.4, h=5+Overlap*2);
				
				translate([0,0,Engagement_Len/2-4.5+5+Skirt_Len-Overlap*2])
					cylinder(d1=23, d2=SC_Tube_OD-3, h=5+Overlap*4);
			} // difference
			
			translate([0,0,Engagement_Len/2+Skirt_Len+0.5+5]) 
				Tube(OD=SC_Tube_OD+2.4, ID=SC_Tube_OD, Len=10, myfn=90);
		} // union
		
		difference(){
			translate([0,0,Engagement_Len/2+1]) cylinder(d=EBay_OD+Wall_t*2+1, h=Skirt_Len-1+Overlap);
			translate([0,0,Engagement_Len/2+1-Overlap]) cylinder(d1=EBay_OD+Wall_t*2, d2=EBay_OD, h=Skirt_Len-1+Overlap*3, $fn=180);
		} // difference
		
		// Bolts
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) 
			translate([0,EBay_OD/2,Engagement_Len/2+Skirt_Len+7.5]) rotate([-90,0,0]) Bolt4Hole();
		
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+180/nBolts]) 
			translate([0,EBay_OD/2,Engagement_Len/2+Skirt_Len+5]) rotate([-90,0,0]) Bolt4Hole();
		
		translate([0,0,Engagement_Len/2-3]) STB_BR_BoltPattern(Body_ID=Retainer_OD, Body_OD=Retainer_OD, nLockBalls=nLockBalls) 
			Bolt4HeadHole(depth=8,lHead=12);
			
		//cube([100,100,100]);
	} // difference

	
} // FNL_Custom_BallRetainerTop

// FNL_Custom_BallRetainerTop();

module FNL_FairingBase(OD=Fairing_OD*CF_Comp){
	FairingBase_r=10;
	Base_Len=25;
	
	difference(){
		union(){
			Tube(OD=OD-FairingWall_t*2, ID=OD-FairingWall_t*4, Len=15, myfn=$preview? 90:360);
			translate([0,0,-5]) Tube(OD=OD, ID=OD-FairingWall_t*4, Len=5+Overlap, myfn=$preview? 90:360);
			
			hull(){
				translate([0,0,-5]) rotate_extrude($fn=$preview? 90:360) translate([OD/2-FairingBase_r,0,0]) circle(r=FairingBase_r);
					
				translate([0,0,-Base_Len]) cylinder(d=Body_OD*CF_Comp+FairingWall_t*2, h=Overlap, $fn=$preview? 90:360);
			} // hull
		} // union
		
		translate([0,0,-5]) cylinder(d=OD-FairingWall_t*4, h=FairingBase_r, $fn=$preview? 90:360);
		translate([0,0,-5-FairingBase_r-Overlap]) 
				cylinder(d1=Body_OD*CF_Comp+IDXtra*2, d2=OD-FairingWall_t*4, h=FairingBase_r+Overlap*2, $fn=$preview? 90:360);
							
		translate([0,0,-Base_Len-Overlap]) cylinder(d=Body_OD*CF_Comp+IDXtra*2, h=Base_Len+10);
		
		
		for (j=[0:nFairingRivets-1]) rotate([0,0,360/nFairingRivets*j]) 
			translate([0,OD/2,7.5]) rotate([90,0,0]) cylinder(d=Rivet_d, h=10);
			
		if ($preview) translate([0,0,-Base_Len-20]) rotate([0,0,-90]) cube([100,100,100]);
	} // difference
	
	translate([0,0,-Base_Len-15]) rotate([180,0,0])
		STB_TubeEnd(Body_ID=Body_ID*CF_Comp, nLockBalls=nLockBalls, Body_OD=Body_OD*CF_Comp, Engagement_Len=Engagement_Len);
} // FNL_FairingBase

//FNL_FairingBase();

module FNL_Nosecone(OD=Fairing_OD*CF_Comp){
	
	BluntOgiveNoseCone(ID=OD-FairingWall_t*2, OD=OD, L=NC_Len, Base_L=NC_Base_L, 
						nRivets=nFairingRivets, RivertInset=7.5, Tip_R=NC_Tip_R, 
						HasThreadedTip=false, Wall_T=NC_Wall_t, 
						Cut_d=0, LowerPortion=false, FillTip=true);
} // FNL_Nosecone

// FNL_Nosecone();

module FNL_FairingTube(OD=Fairing_OD*CF_Comp, Len=Fairing_Len){
	
	difference(){
		union(){
			Tube(OD=OD, ID=OD-FairingWall_t*2, Len=Len, myfn=$preview? 90:360);
			
			translate([0,0,Len-Overlap]) Tube(OD=OD-IDXtra-FairingWall_t*2, ID=OD-IDXtra-FairingWall_t*4, Len=15, myfn=$preview? 90:360);
			difference(){
				translate([0,0,Len-5]) cylinder(d=OD-1, h=5);
				translate([0,0,Len-5-Overlap]) cylinder(d1=OD-FairingWall_t*2, d2=OD-IDXtra-FairingWall_t*4, h=5+Overlap*2, $fn=$preview? 90:360);
			} // difference
		} // union
		
		for (j=[0:nFairingRivets-1]) rotate([0,0,360/nFairingRivets*j]) {
			translate([0,OD/2,7.5]) rotate([90,0,0]) cylinder(d=Rivet_d, h=10);
			translate([0,OD/2,Len+7.5]) rotate([90,0,0]) cylinder(d=Rivet_d, h=10);
		}
		if ($preview) translate([0,0,-Overlap]) rotate([0,0,-90]) cube([100,100,Len+15+Overlap*2]);
	} // difference
} // FNL_FairingTube

//FNL_FairingTube();

module FNL_TopSpingEnd(){
	Sping_OD=SE_Spring_CS4323_OD();
	Sping_ID=SE_Spring_CS4323_ID();
	
	nRopes=6;
	Rope_d=4;
	nBolts=5;
	nTopBolts=6;
	Skirt_Len=12;
	Plate_t=4;
	PlateBC_d=60;
	
	difference(){
		union(){
			cylinder(d=Body_OD*CF_Comp, h=Plate_t, $fn=180);
			translate([0,0,-Skirt_Len]) cylinder(d=Body_ID*CF_Comp, h=Skirt_Len+Overlap, $fn=180);
		} // union
		
		// Ropes
		for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j]) translate([0,Body_ID/2-10,-Overlap]) cylinder(d=Rope_d, h=Plate_t+1);
		
		// Bolts
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j])
			translate([0, Body_ID*CF_Comp/2, -7.5]) rotate([-90,0,0]) Bolt4Hole();
			
		for (j=[0:nTopBolts-1]) rotate([0,0,360/nTopBolts*j])
			translate([0, PlateBC_d/2, Plate_t]) Bolt4Hole();
		
		
		translate([0,0,-Skirt_Len-Overlap])
			difference(){
				cylinder(d=Body_ID*CF_Comp-4.4, h=Skirt_Len+Overlap, $fn=180);
				translate([0,0,-Overlap]) cylinder(d=Sping_OD+6, h=Skirt_Len+Overlap*2, $fn=180);
			} // difference
		
		// Spring hole
		translate([0,0,-Skirt_Len-Overlap]) cylinder(d1=Sping_OD+1, d2=Sping_OD, h=6+Overlap*2);
		translate([0,0,-Skirt_Len+6]) cylinder(d=Sping_OD, h=3+Overlap);
		translate([0,0,-Skirt_Len-Overlap]) cylinder(d=Sping_ID-1, h=Skirt_Len+Plate_t+Overlap*2);
		
		translate([0,0,-91]) FNL_Nosecone();
	} // difference
} // FNL_TopSpingEnd

// FNL_TopSpingEnd();
Bolt4Inset=4;

module FNL_ShockCordAttachment(){
	Sping_ID=SE_Spring_CS4323_ID();

	nTopBolts=6;
	Plate_t=3;
	PlateBC_d=60;
	AlTube_d=12.6;
	
	difference(){
		union(){
			cylinder(d=PlateBC_d+Bolt4Inset*2, h=Plate_t);
			
			hull(){
				translate([0,0,Plate_t+AlTube_d/2+1]) rotate([0,90,0]) cylinder(d=AlTube_d+6, h=PlateBC_d, center=true);
				translate([-PlateBC_d/2, -(AlTube_d+8)/2, 0]) cube([PlateBC_d, AlTube_d+8, Plate_t]);
			} // hull
		} // union
		
		translate([0,0,Plate_t+AlTube_d/2+1]) rotate([0,90,0]) cylinder(d=AlTube_d+IDXtra, h=PlateBC_d+Overlap*2, center=true);
		
		for (j=[0:nTopBolts-1]) rotate([0,0,360/nTopBolts*j]) translate([0,PlateBC_d/2,Plate_t]) Bolt4ClearHole();
		translate([0,0,-Overlap]) cylinder(d=Sping_ID-1, h=Plate_t+AlTube_d+4+Overlap*2);
	} // difference
} // FNL_ShockCordAttachment

// FNL_ShockCordAttachment();




























