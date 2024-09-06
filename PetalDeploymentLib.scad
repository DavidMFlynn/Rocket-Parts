// ***********************************
// Project: 3D Printed Rocket
// Filename: PetalDeploymentLib.scad
// by David M. Flynn
// Created: 10/22/2023 
// Revision: 0.9.8  8/11/2024
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  Deployment spring pushes on the petals not the parachute.
//
//  ***** Hardware *****
//
// #4-40 x 3/8" Socket Head Cap Screw (3 req) PetalHub
// #4-40 x 1/4" Button Head Cap Screw (2 per petal req) Petals
// 0.3" Dia x 1.25" spring CS3715 (1 per petal req)
//
//  ***** History *****
//
function PetalDeploymentLibRev()="PetalDeploymentLib Rev. 0.9.8";
echo(PetalDeploymentLibRev());
// 0.9.8  8/11/2024   Added PD_Booster_PetalHub()
// 0.9.7  7/15/2024	  Removed OD param from PD_PetalSpringHolder() only used as translate([0,OD/2,0])
// 0.9.6  6/3/2024    Added params and coupler tube option to PD_NC_PetalHub
// 0.9.5  4/21/2024   Petal connections are shorter by 2mm
// 0.9.4  3/23/2024	  Worked on locks.
// 0.9.3  11/7/2023   Added PD_GridPetals(), PD_PetalLocks()
// 0.9.2  11/6/2023   Code cleanup.
// 0.9.1  10/26/2023  Added AntiClimber_h to PD_Petals()
// 0.9.0  10/22/2023  Copied from Rocket 75C to create this library
//
// ***********************************
//  ***** for STL output *****
//
// rotate([180,0,0]) PD_Petals(OD=BT75Coupler_OD, Len=110, nPetals=3, Wall_t=1.8, AntiClimber_h=0, HasLocks=false, Lock_Span_a=0);
// rotate([180,0,0]) PD_GridPetals(OD=BT137Coupler_OD, Len=150, nPetals=3, Wall_t=1.2, HasLocks=false);
// rotate([-90,0,0]) PD_PetalSpringHolder();
/*
PD_PetalHub(OD=BT75Coupler_OD, 
					nPetals=3, 
					HasBolts=true,
					nBolts=0, // Same as nPetals
					ShockCord_a=PD_ShockCordAngle(),
					HasNCSkirt=false, 
						Body_OD=BT75Body_OD,
						Body_ID=BT75Body_ID,
						NC_Base=NC_Base, 
						SkirtLen=10);
/**/
// PD_NC_PetalHub(OD=BT75Coupler_OD, nPetals=3, nRopes=3, ShockCord_a=-1, HasThreadedCore=false, ST_DSpring_ID=SE_Spring_CS4323_ID(), ST_DSpring_OD=SE_Spring_CS4323_OD(), CouplerTube_ID=0);
//
// *** Used to prevent drag separation ***
// rotate([0,-90,0]) PD_PetalLockCatch(OD=BT98Coupler_OD, ID=BT98Coupler_ID, Wall_t=1.8, Len=27, LockStop=false);
// PD_CatchHolder(OD=BT98Coupler_OD, ID=BT98Coupler_ID, Wall_t=1.8, nPetals=3);
//
// PD_Booster_PetalHub(OD=BT54Coupler_OD, nPetals=2, nRopes=2, ShockCord_a=-1, HasThreadedCore=true, ST_DSpring_ID=SE_Spring_CS4323_ID(), ST_DSpring_OD=SE_Spring_CS4323_OD(), CouplerTube_ID=0)
//
// ***********************************
//  ***** Routines *****
//
// PD_LockSocket(OD=BT98Coupler_OD, ID=BT98Coupler_ID, Len=22, Wall_t=1.8, nPetals=3);
//
function PD_ShockCordAngle()=ShockCord_a;
//
// PD_PetalLocks(OD=BT75Coupler_OD, Len=25, nPetals=3);
// PD_PetalHubBoltPattern(OD=BT75Coupler_OD, nBolts=3) Bolt4Hole();
// PD_ShockCordHolePattern(OD=BT75Coupler_OD, ShockCord_a=ShockCordAngle()) cylinder(d=4, h=15);
//
// ***********************************

include<TubesLib.scad>
use<ThreadLib.scad>
use<SpringEndsLib.scad>
include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;
Bolt4Inset=4;
ShockCord_a=45;
NC_Base=15;
PetalWidth=15;

module PD_PetalLockCatch(OD=BT98Coupler_OD, ID=BT98Coupler_ID, Wall_t=1.8, Len=23, LockStop=true){
	
	W=10;
	Lock_h=1.7;
	
	difference(){
		intersection(){
			cylinder(d=OD-Wall_t*2, h=Len, $fn=$preview? 90:360);
			translate([-W/2,0,0]) cube([W,OD/2+1,Len]);
		} // intersection
		
		// Inside
		translate([0,0,-Overlap]) cylinder(d=ID-6.5, h=Len+Overlap*2, $fn=$preview? 90:360);
		
		
		difference(){
			translate([0,0,-Overlap]) cylinder(d=OD, h=Len/2);
			translate([0,0,-Overlap*2]) cylinder(d=ID, h=Len/2+Overlap*4);
		} // difference
		
		// Chamfer top
		difference(){
			translate([0,0,Len-3]) cylinder(d=OD+2, h=3+Overlap);
			translate([0,0,Len-3-Overlap]) cylinder(d1=OD-Wall_t*2, d2=ID-Wall_t*2, h=3+Overlap*3, $fn=$preview? 90:360);
		} // difference
		
		// Bolt Hole
		translate([0,ID/2,4]) rotate([-90,0,0]) Bolt4ButtonHeadHole();
		
		// Lock
		Lock_W=LockStop? 2:0;
		translate([0,0,Len-7])
		difference(){
			intersection(){
				cylinder(d=OD, h=3);
				translate([-W/2+Lock_W-Overlap,0,0]) cube([W+Overlap*2,OD/2+1,Len]);
			} // intersection
			
			translate([0,0,-Overlap]) cylinder(d=OD-Wall_t*2-Lock_h*2, h=3+Overlap*2, $fn=$preview? 90:360);
		} // difference
	} // difference
	
} // PD_PetalLockCatch

//PD_PetalLockCatch();

//PD_PetalLockCatch(OD=BT98Coupler_OD, ID=BT98Coupler_ID, Wall_t=1.8, Len=30, LockStop=false);


module PD_LockSocket(OD=BT98Coupler_OD, ID=BT98Coupler_ID, Len=22, Wall_t=1.8, nPetals=3){
	W=10+IDXtra*4;
	
	for (j=[0:nPetals-1]) rotate([0,0,360/nPetals*j]){
		difference(){
			intersection(){
				translate([0,0,-1]) cylinder(d=OD-Wall_t*2+IDXtra*8, h=Len, $fn=$preview? 90:360);
				translate([-W/2,0,-1]) cube([W,OD/2+1,Len]);
			} // intersection
			
			// Inside
			translate([0,0,-1-Overlap]) cylinder(d=ID-6, h=Len-11+Overlap*2, $fn=$preview? 90:360);
			translate([0,0,10]) cylinder(d1=ID-6, d2=ID-10, h=Len-10+Overlap*2, $fn=$preview? 90:360);
		} // difference
		
		// Bolt Hole
		translate([0,ID/2,4]) {
			rotate([-90,0,0]) Bolt4Hole();
			
			translate([0,-2,0]) rotate([-90,0,0]) cylinder(d=10, h=10);
		}
	} // for
} // PD_LockSocket

//PD_LockSocket();

module PD_CatchHolder(OD=BT98Coupler_OD, ID=BT98Coupler_ID, Wall_t=1.8, nPetals=3, HasBasePlate=false){
	Len=22;
	Lip=3;
	W=10+IDXtra*2;
	Core_d=ID-10;
	Core_Z=HasBasePlate? 3:-Overlap;
	
	difference(){
		union(){
			translate([0,0,Len-Lip]) cylinder(d=OD, h=Lip, $fn=$preview? 90:360);
			cylinder(d=ID, h=Len-Lip+Overlap, $fn=$preview? 90:360);
			
		} // union
		
		// Inside
		translate([0,0,Core_Z]) cylinder(d=Core_d, h=Len+Overlap*2, $fn=$preview? 90:360);
		translate([0,0,-Overlap]) cylinder(d=4, h=Len+Overlap*2);
		
		// Chamfer top
		translate([0,0,Len-5]) cylinder(d1=Core_d, d2=ID, h=5+Overlap, $fn=$preview? 90:360);
		
		translate([0,0,2]) PD_LockSocket(OD=OD, ID=ID, Len=Len, Wall_t=Wall_t, nPetals=nPetals);
		
		
		
		
	} // difference
	
	difference(){
		for (j=[0:nPetals-1]) rotate([0,0,360/nPetals*j]) hull(){
				translate([0,ID/2-4,6]) rotate([90,0,0]) cylinder(d=6, h=4);
				scale([1.8,1,1]) translate([0,ID/2-4,6]) rotate([90,0,0]) cylinder(d=10, h=1);}
				
		// Bolt Hole
		translate([0,0,2]) for (j=[0:nPetals-1]) rotate([0,0,360/nPetals*j])
			translate([0,ID/2,4]) rotate([-90,0,0]) Bolt4Hole();
	} // difference
} // PD_CatchHolder

//translate([0,0,-2]) PD_CatchHolder();


module PD_ShowCatchAssy(OD=BT98Coupler_OD, ID=BT98Coupler_ID, Wall_t=1.8, nPetals=3){
	PD_CatchHolder(OD=OD, ID=ID, Wall_t=Wall_t, nPetals=nPetals);
	
	translate([0,0,2]) for (j=[0:nPetals-1]) rotate([0,0,360/nPetals*j])
		PD_PetalLockCatch(OD=BT98Coupler_OD, ID=BT98Coupler_ID, Wall_t=1.8, Len=27, LockStop=false);
} // PD_ShowCatchAssy

//PD_ShowCatchAssy();


module PD_PetalLocks(OD=BT75Coupler_OD, Len=25, nPetals=3, Lock_Span_a=0){
// Lock_Span_a 0=full, else 10 to 360/nPetals

	BaseOffset=8.2;
	Lock_h=1.5;
	Lock_d=3;
	
	Span_a=(Lock_Span_a==0)? 360/nPetals:Lock_Span_a;
	
	translate([0,0,BaseOffset+Len-Lock_h])
		for (j=[0:nPetals-1]) for (k=[0:Span_a-1]) rotate([0,0,360/nPetals*j+k]) hull(){
			translate([0,OD/2-Lock_d/2,0]) cylinder(d=Lock_d, h=Lock_h);
			rotate([0,0,1]) translate([0,OD/2-Lock_d/2,0]) cylinder(d=Lock_d, h=Lock_h);
			translate([0,OD/2-1,Lock_h/2]) cube([Lock_d, Overlap, Lock_h],center=true);
			rotate([0,0,1]) translate([0,OD/2-1,Lock_h/2]) cube([Lock_d, Overlap, Lock_h],center=true);
		}
} // PD_PetalLocks

// PD_PetalLocks(OD=BT75Coupler_OD, Len=110, nPetals=3);

module PD_Petals(OD=BT75Coupler_OD, Len=25, nPetals=3, Wall_t=1.8, AntiClimber_h=0,
				HasLocks=false, Lock_Span_a=0){
	Bolt1_Z=9.25; // was 11.75
	Thickness=3;
	BaseOffset=8.2; // was 11.2
	AntiClimber_w=2;
	AntiClimber_L=AntiClimber_h*4;
	AntiClimber_LockComp=HasLocks? 10:0;
	
	module AntiClimber(){
		translate([0.6, -OD/2+1, 0])
		hull(){
			cube([AntiClimber_w+1.5,Overlap,AntiClimber_L]);
			translate([AntiClimber_w/2, AntiClimber_h, AntiClimber_h]) 
				cylinder(d=AntiClimber_w,h=AntiClimber_h*2);
		} // hull
	} // AntiClimber
	
	if (HasLocks) PD_PetalLocks(OD=OD, Len=Len, nPetals=nPetals, Lock_Span_a=Lock_Span_a);
	
	difference(){
		union(){
			translate([0,0,BaseOffset]) 
				Tube(OD=OD, ID=OD-Wall_t*2, Len=Len, myfn=$preview? 90:360);
			
			for (j=[0:nPetals-1]) rotate([0,0,360/nPetals*j]) difference(){
				intersection(){
					cylinder(d=OD, h=16+BaseOffset, $fn=$preview? 90:360);
						
					translate([-PetalWidth/2,OD/2-Thickness,0]) 
						cube([PetalWidth, OD, 16+BaseOffset]);
				} // intersection
				translate([0,0,16+BaseOffset-3])
					cylinder(d1=OD-Thickness*2, d2=OD-3.6+Overlap, 
							h=3+Overlap, $fn=$preview? 90:360);
					
				
			} // for difference
			
			if (AntiClimber_h>0)
				for (j=[0:nPetals-1]) 
					rotate([0,0,360/nPetals*j]) {
						translate([0,0,BaseOffset+Len-AntiClimber_L-AntiClimber_LockComp]){
							AntiClimber();
							mirror([1,0,0]) AntiClimber();
						}
						translate([0,0,BaseOffset]){
							AntiClimber();
							mirror([1,0,0]) AntiClimber();
						}
				} // for
		} // union
		
		// Bolt Holes
		for (j=[0:nPetals-1]) rotate([0,0,360/nPetals*j]){
			translate([0,OD/2,Bolt1_Z]) rotate([-90,0,0]) Bolt4ButtonHeadHole();
			translate([0,OD/2,Bolt1_Z+Bolt4Inset*2]) rotate([-90,0,0]) Bolt4ButtonHeadHole();
			}
		
		// Cut here
		for (j=[0:nPetals-1]) rotate([0,0,360/nPetals*(j+0.5)])
			translate([0, OD/2, Len/2+BaseOffset]) 
				cube([2, Wall_t*2-2.4, Len+Overlap*2], center=true); // leave 1.2mm
	} // difference
} // PD_Petals

//rotate([180,0,0]) PD_Petals(OD=BT75Coupler_OD, Len=110, nPetals=3, AntiClimber_h=3, HasLocks=true, Lock_Span_a=20);
//PD_Petals(OD=BT137Coupler_OD, Len=110, nPetals=3, Wall_t=2.4, AntiClimber_h=5);
//rotate([180,0,0]) PD_Petals(OD=BT98Coupler_OD, Len=55, nPetals=3, Wall_t=1.8, AntiClimber_h=4, HasLocks=true, Lock_Span_a=120);

module WallGrigBox(X=10, Y=15, Z=15, R=1.5, A=0){
	myfn=24;
	
	hull(){
		// wall filets
		translate([-X/2+R, -R, -Z/2+R]) sphere(r=R, $fn=myfn);
		translate([-X/2+R, -R, Z/2-R]) sphere(r=R, $fn=myfn);
		translate([X/2-R, -R, -Z/2+R]) sphere(r=R, $fn=myfn);
		translate([X/2-R, -R, Z/2-R]) sphere(r=R, $fn=myfn);
		
		// inside
		translate([-X/2+R, 0, -Z/2+R]) rotate([0,0,A]) 
			rotate([90,0,0]) cylinder(r=R, h=Y, $fn=myfn);
		translate([-X/2+R, 0, Z/2-R])  rotate([0,0,A])
			rotate([90,0,0]) cylinder(r=R, h=Y, $fn=myfn);
		translate([X/2-R, 0, -Z/2+R])  rotate([0,0,-A])
			rotate([90,0,0]) cylinder(r=R, h=Y, $fn=myfn);
		translate([X/2-R, 0, Z/2-R]) rotate([0,0,-A])
			rotate([90,0,0]) cylinder(r=R, h=Y, $fn=myfn);

	} // hull
} // WallGrigBox

//WallGrigBox(X=10, Y=15, Z=15, R=1.5);
			
module GridWall(OD=BT137Coupler_OD, ID=BT137Coupler_OD-14, Len=100, Wall_t=1.2, Arc_a=180){
	Box_X=10;
	Box_Z=15;
	Spacing_Z=Box_Z+Wall_t;
	
	Grid_a=asin((Box_X+Wall_t)/(ID/2));
	nBoxes=floor(Arc_a/Grid_a)-1;
	Start_a=(Arc_a-nBoxes*Grid_a)/2+Grid_a/2;
	nBoxes_Z=floor(Len/Spacing_Z);
	Start_Z=(Len-nBoxes_Z*Spacing_Z)/2+Spacing_Z/2;
	
	difference(){
		Tube(OD=OD, ID=ID, Len=Len, myfn=$preview? 36:360);
		
		for (k=[0:nBoxes_Z-1])
			for (j=[0:nBoxes-1]) rotate([0,0,Start_a+Grid_a*j]) 
				translate([0, OD/2-Wall_t, Start_Z+Spacing_Z*k]) 
					WallGrigBox(X=Box_X, Y=15, Z=Box_Z, R=1.5, A=Grid_a/2);
		
		
		// Remover other half
		rotate([0,0,90]) translate([-OD/2-1, -OD/2-1, -Overlap]) cube([OD+2, OD/2+1, Len+Overlap*2]);
		rotate([0,0,-90+Arc_a]) translate([-OD/2-1, -OD/2-1, -Overlap]) cube([OD+2, OD/2+1, Len+Overlap*2]);
	} // difference
} // GridWall

//GridWall(Arc_a=119);

module PD_GridPetals(OD=BT137Coupler_OD, Len=150, nPetals=3, Wall_t=1.2, HasLocks=false){
	Bolt1_Z=11.75;
	Thickness=3;
	BaseOffset=11.2;
	GridWall_t=7;
	
	if (HasLocks) PD_PetalLocks(OD=OD-GridWall_t*2+3.6, Len=Len, nPetals=nPetals);
	
	difference(){
		union(){
			translate([0,0,BaseOffset]) 
				for (j=[0:nPetals-1]) rotate([0,0,360/nPetals*(j+0.5)]){
					GridWall(OD=OD, ID=OD-GridWall_t*2, Len=Len, Wall_t=Wall_t, Arc_a=360/nPetals-1);
					translate([0,OD/2-Wall_t/2-0.6, Len/2]) cube([3, Wall_t, Len], center=true);
				} // for
	
			for (j=[0:nPetals-1]) rotate([0,0,360/nPetals*j]) difference(){
					intersection(){
						cylinder(d=OD-IDXtra*2, h=16+BaseOffset, $fn=$preview? 90:360);
							
						translate([-PetalWidth/2,OD/2-Thickness,0]) 
							cube([PetalWidth, OD, 16+BaseOffset]);
					} // intersection
					
					translate([0,0,16+BaseOffset-3])
						cylinder(d1=OD-Thickness*2, d2=OD-3.6+Overlap, 
								h=3+Overlap, $fn=$preview? 90:360);
			} // for difference	
			
			intersection(){
				translate([0,0,BaseOffset]) cylinder(d=OD, h=16, $fn=$preview? 90:360);
				
				for (j=[0:nPetals-1]) rotate([0,0,360/nPetals*j])
					hull(){
						translate([0, OD/2-Thickness+Overlap, Bolt1_Z-5]) 
							rotate([90,0,0]) cylinder(d=14, h=4);
						translate([0, OD/2-Thickness+Overlap, Bolt1_Z+Bolt4Inset*2]) 
							rotate([90,0,0]) cylinder(d=14, h=4);
					} // hull
			} // intersection
			
		} // union
		
		// Bolt Holes
		for (j=[0:nPetals-1]) rotate([0,0,360/nPetals*j]){
			translate([0,OD/2,Bolt1_Z]) rotate([-90,0,0]) Bolt4ButtonHeadHole();
			translate([0,OD/2,Bolt1_Z+Bolt4Inset*2]) rotate([-90,0,0]) Bolt4ButtonHeadHole();
			
			hull(){
				translate([0, OD/2-Thickness, Bolt1_Z-5]) rotate([90,0,0]) cylinder(d=11.4, h=10);
				translate([0, OD/2-Thickness, Bolt1_Z+Bolt4Inset*2]) rotate([90,0,0]) cylinder(d=11.4, h=10);
			} // hull
		} // for
	} // difference
} // PD_GridPetals

//PD_GridPetals(HasLocks=true);

module PD_PetalSpringHolder(){
	Width=11;
	Thickness=3;
	Spring_d=5/16*25.4;
	Axle_d=4;
	Axle_L=Width+9;
	AxleBoss_d=Axle_d+2.4;
	
	
	difference(){
		union(){
			translate([0,0,8]) hull(){
				translate([0,-Thickness-Width/2,0]) cylinder(d=Width, h=10);
				translate([-Width/2,-Thickness-1,0]) cube([Width,1,1]);
			
				translate([0,-Thickness,Bolt4Inset*3]) rotate([90,0,0]) cylinder(d=Width,h=3);
			} // hull
			
			translate([0,-Thickness-AxleBoss_d/2,0]) hull(){
				rotate([0,90,0]) cylinder(d=AxleBoss_d, h=PetalWidth, center=true);
				translate([0,0,8]) rotate([0,90,0]) cylinder(d=AxleBoss_d, h=Width, center=true);
			} // hull
			
			// Axle
			translate([0,-Thickness-AxleBoss_d/2,0])
				rotate([0,90,0]) cylinder(d=Axle_d, h=Axle_L, center=true);
		} // union
		
		
		// Sping	
		translate([0,-Thickness-Width/2,-AxleBoss_d/2-Overlap]) {
			cylinder(d=Spring_d+IDXtra, h=16+AxleBoss_d/2);
			cylinder(d=4, h=30);
		}
		
		translate([0,0,12]) rotate([-90,0,0]) Bolt4Hole(depth=6);
		translate([0,0,12+Bolt4Inset*2]) rotate([-90,0,0]) Bolt4Hole(depth=9.5);
	} // difference
} // PD_PetalSpringHolder

//PD_PetalSpringHolder();

//rotate([-90,0,0]) PD_PetalSpringHolder();

module PD_PetalHubBoltPattern(OD=BT75Coupler_OD, nBolts=3){
	for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*(j+0.5)])
			translate([0,OD/2-Bolt4Inset,0]) children();
} // PD_PetalHubBoltPattern

// PD_PetalHubBoltPattern(OD=BT75Coupler_OD, nBolts=3) Bolt4Hole();

module PD_ShockCordHolePattern(OD=BT75Coupler_OD, ShockCord_a=ShockCord_a){
	rotate([0,0,ShockCord_a]) translate([0,OD/2-6,0]) children();
	rotate([0,0,ShockCord_a]) translate([0,OD/2-17.5,0]) children();
} // ShockCordHolePattern

// PD_ShockCordHolePattern(OD=BT75Coupler_OD, ShockCord_a=ShockCord_a);

module PD_HubSpringExtension(Len=150){
	SpringGuide_Len=20;
	
	difference(){
		union(){
			cylinder(d=SE_Spring_CS4323_OD(), h=Len);
			translate([0,0,Len-Overlap]) cylinder(d=SE_Spring_CS4323_ID(), h=SpringGuide_Len);
		} // union
		
		
		translate([0,0,-Overlap]) cylinder(d=SE_Spring_CS4323_ID(), h=Len-3+Overlap); // PetalHub end
		translate([0,0,Len-3-Overlap]) 
			cylinder(d1=SE_Spring_CS4323_ID(), d2=SE_Spring_CS4323_ID()-4.4, h=3+Overlap*2);
		translate([0,0,Len-Overlap]) cylinder(d=SE_Spring_CS4323_ID()-4.4, h=SpringGuide_Len+Overlap*2);
	} // difference

} // PD_HubSpringExtension

// PD_HubSpringExtension(Len=122);

module PD_PetalHub(OD=BT75Coupler_OD, 
					nPetals=3, 
					HasBolts=true,
					nBolts=0, // Same as nPetals
					ShockCord_a=ShockCord_a,
					HasNCSkirt=false, 
						Body_OD=BT75Body_OD,
						Body_ID=BT75Body_ID,
						NC_Base=NC_Base, 
						SkirtLen=10){
	
	Width=PetalWidth+1;
	Thickness=3;
	Spring_d=5/16*25.4;
	Shelf_Z=16;
	SpringEnd_Y=OD/2-16;
	Axle_d=4+IDXtra*3;
	Axle_L=Width+7;
	AxleBoss_d=Axle_d+2.4;
	Skirt_OD=Body_ID-IDXtra;
	Skirt_ID=Skirt_OD-4.4;
	nMountingBolts=(nBolts==0)? nPetals:nBolts;
	
	difference(){
		union(){
			difference(){
				cylinder(d=OD, h=16, $fn=$preview? 90:360);
				
				translate([0, 0, 6+Overlap]) cylinder(d1=OD-40, d2=OD-6, h=10);
			} // difference
			
			// Close bottom
			cylinder(d=OD-1, h=6);
			
			// Spring holders
			for (j=[0:nPetals-1]) rotate([0,0,360/nPetals*j]) 
				hull(){
					translate([0, SpringEnd_Y, Shelf_Z-10+Spring_d/2]) 
						rotate([90,0,0]) cylinder(d=Spring_d+3, h=11);
					translate([-(Spring_d+5)/2, SpringEnd_Y-11, Shelf_Z-12]) 
						cube([Spring_d+5, 11, 1]);
				} // hull
				
			if (HasNCSkirt){
				
				// Nosecone
				translate([0, 0, -SkirtLen-NC_Base-3]) // Fit to nosecone
				Tube(OD=OD-IDXtra*2, ID=Skirt_ID, 
					Len=NC_Base+Overlap, myfn=$preview? 90:360);
					
				// Nosecone stop
				translate([0,0,-SkirtLen-3]) // Fit to nosecone
				Tube(OD=Body_OD+IDXtra, ID=Skirt_ID, 
					Len=3+Overlap, myfn=$preview? 90:360);
					
				// Skirt
				translate([0,0,-SkirtLen]) // Fit to nosecone
				Tube(OD=Skirt_OD, ID=Skirt_ID, 
					Len=SkirtLen+16, myfn=$preview? 90:360);
			}
		} // union
		
		// Bolt to BallRetainerBottom
		if (HasNCSkirt){
			translate([0,0,-SkirtLen-3-NC_Base/2]) RivetPattern(BT_Dia=Body_ID, nRivets=3, Dia=5/32*25.4);
		}else{
			if (HasBolts)
				PD_PetalHubBoltPattern(OD=OD, nBolts=nMountingBolts) 
					translate([0,0,5]) Bolt4HeadHole(lHead=20);
		}
		
		// Petal ledge and Spring slot
		for (j=[0:nPetals-1]) rotate([0,0,360/nPetals*j]){
			translate([-Width/2,5,Shelf_Z]) cube([Width,OD/2,20]);
			
			// Axle 
			translate([0, OD/2-Thickness-AxleBoss_d/2-0.5, 7]){
			
				// Petal pivot socket
				hull(){
					rotate([0,90,0]) cylinder(d=Axle_d, h=Axle_L, center=true);
					translate([0,-6,5])
						rotate([0,90,0]) cylinder(d=Axle_d, h=Axle_L, center=true);
				} // hull
				
				// Petal clearance
				hull(){
					translate([0,-3,0]) rotate([0,90,0]) cylinder(d=AxleBoss_d+5, h=Width, center=true);
					translate([0,-3,10]) rotate([0,90,0]) cylinder(d=AxleBoss_d+5, h=Width, center=true);
					translate([0,10,0]) rotate([0,90,0]) cylinder(d=AxleBoss_d+5, h=Width, center=true);
					translate([0,3,10]) rotate([0,90,0]) cylinder(d=AxleBoss_d+4, h=Width, center=true);
					}}
				
			// Spring clearance
			hull(){
				translate([0, OD/2-16, Shelf_Z-10+Spring_d/2]) 
					rotate([-90,0,0]) cylinder(d=Spring_d+1, h=20);
				translate([0, OD/2-16, Shelf_Z+Spring_d/2]) 
					rotate([-90,0,0]) cylinder(d=Spring_d+1, h=20);
			} // hull
		}
		
		// Spring holders
		for (j=[0:nPetals-1]) rotate([0,0,360/nPetals*j]) 
			translate([0,SpringEnd_Y+Overlap,Shelf_Z-10+Spring_d/2]) {
				rotate([90,0,0]) cylinder(d=Spring_d, h=8);
				rotate([90,0,0]) cylinder(d=4, h=12);
		}
				
		// Shock cord hole
		if (ShockCord_a>=0)
		translate([0,0,-Overlap]) hull() 
			PD_ShockCordHolePattern(OD=OD, ShockCord_a=ShockCord_a) cylinder(d=4, h=20);
			
	} // difference
	
} // PD_PetalHub

//PD_PetalHub(OD=BT75Coupler_OD, nPetals=3, ShockCord_a=ShockCord_a);
//PD_PetalHub(OD=BT98Coupler_OD, nPetals=6, ShockCord_a=22.5);

//PD_PetalHub(OD=BT75Coupler_OD, HasNCSkirt=true, SkirtLen=10, nPetals=3, ShockCord_a=ShockCord_a);
/*
PD_PetalHub(OD=BT137Coupler_OD, Body_OD=BT137Body_OD,
						nPetals=3, HasBolts=true, nBolts=0, // Same as nPetals
						ShockCord_a=-1,
						HasNCSkirt=false,
							Body_ID=BT137Body_ID,
							NC_Base=25, 
							SkirtLen=10);
/**/


module PD_NC_PetalHub(OD=BT75Coupler_OD, nPetals=3, nRopes=3, ShockCord_a=-1, HasThreadedCore=false,
				ST_DSpring_ID=SE_Spring_CS4323_ID(), ST_DSpring_OD=SE_Spring_CS4323_OD(), CouplerTube_ID=0){
	BodyTube_L=(CouplerTube_ID>0)? 10:20;
	SpringHole_ID=ST_DSpring_ID-IDXtra*2-4.4;
	CenterHole_d=OD>80? SpringHole_ID : 21;
	
	
	// Body tube interface
	if (CouplerTube_ID==0)
	translate([0,0,-BodyTube_L]) 
		Tube(OD=OD, ID=OD-4.4, Len=BodyTube_L+1, myfn=$preview? 90:360);
									
	difference(){
		union(){
			PD_PetalHub(OD=OD, nPetals=nPetals, HasBolts=false, ShockCord_a=ShockCord_a);
			
			translate([0,0,-BodyTube_L])
				Tube(OD=ST_DSpring_ID-IDXtra*2, 
						ID=ST_DSpring_ID-IDXtra*2-4.4, Len=BodyTube_L+1, myfn=$preview? 90:360);
						
						
			// Coupler tube interface
			if (CouplerTube_ID>0)
			translate([0,0,-BodyTube_L]) 
				cylinder(d=CouplerTube_ID, h=BodyTube_L+1, $fn=$preview? 90:360);
		} // union
			
		// Center Hole
		translate([0,0,-BodyTube_L-Overlap]) 
			cylinder(d=SpringHole_ID, h=BodyTube_L+Overlap*2, $fn=$preview? 90:360);
		translate([0,0,-Overlap]) 
			cylinder(d=CenterHole_d, h=10, $fn=$preview? 90:360);
			
		if (CouplerTube_ID>0){
			translate([0,0,-BodyTube_L-Overlap]) 
				cylinder(d=ST_DSpring_OD, h=BodyTube_L, $fn=$preview? 90:360);
			translate([0,0,-BodyTube_L-Overlap]) 
				cylinder(d1=ST_DSpring_OD+5, d2=ST_DSpring_OD, h=BodyTube_L-5, $fn=$preview? 90:360);
		}
			
		// Retention cord
		for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*(j+0.5)]) {
				translate([0,OD/2-6,-BodyTube_L-Overlap]) cylinder(d=4, h=30);
				translate([0,OD/2-6,5]) cylinder(d=8, h=30);
			}
	} // difference
	
	if (HasThreadedCore) translate([0,0,-BodyTube_L])
		difference(){
			union(){
				cylinder(d=20, h=BodyTube_L);
				
				for (j=[0:2]) rotate([0,0,120*j]) hull(){
					cylinder(d=4, h=BodyTube_L);
					translate([0,CenterHole_d/2,0]) cylinder(d=4, h=BodyTube_L);
				} // hull
			} // union
			
			translate([0,0,-Overlap]) 
			if ($preview){ 
				cylinder(d=6.35, h=BodyTube_L+Overlap*2); }
			else { 
				ExternalThread(Pitch=25.4/20, Dia_Nominal=6.35+IDXtra*2, 
							Length=BodyTube_L+Overlap*2, Step_a=2,TrimEnd=true,TrimRoot=true); }
			
		} // difference
	
	
} // PD_NC_PetalHub

//PD_NC_PetalHub();
//PD_NC_PetalHub(OD=BT98Coupler_OD, nPetals=3, nRopes=6, ShockCord_a=45, HasThreadedCore=true);
//PD_NC_PetalHub(OD=BT54Coupler_OD, nPetals=2, nRopes=2, ShockCord_a=60, HasThreadedCore=true);
/*
PD_NC_PetalHub(OD=BT137Coupler_OD, nPetals=3, nRopes=6, ShockCord_a=-1, HasThreadedCore=false,
		ST_DSpring_ID=SE_Spring_CS11890_ID(),
		ST_DSpring_OD=SE_Spring_CS11890_OD(), CouplerTube_ID=BT137Coupler_ID);
/**/


module PD_Booster_PetalHub(OD=BT54Coupler_OD, nPetals=2, nRopes=2, ShockCord_a=-1, HasThreadedCore=true,
				ST_DSpring_ID=SE_Spring_CS4323_ID(), ST_DSpring_OD=SE_Spring_CS4323_OD(), CouplerTube_ID=0){
				
	// Custom for 54mm Omega booster
	
	BodyTube_L=10;
	SpringHole_ID=ST_DSpring_ID-IDXtra*2-4.4;
	CenterHole_d=6;
	
	
	// Body tube interface
	if (CouplerTube_ID==0)
	translate([0,0,-BodyTube_L]) 
		Tube(OD=OD, ID=OD-4.4, Len=BodyTube_L+1, myfn=$preview? 90:360);
									
	difference(){
		union(){
			PD_PetalHub(OD=OD, nPetals=nPetals, HasBolts=false, ShockCord_a=ShockCord_a);
			
			translate([0,0,-BodyTube_L])
				Tube(OD=ST_DSpring_ID-IDXtra*2, 
						ID=ST_DSpring_ID-IDXtra*2-4.4, Len=BodyTube_L+1, myfn=$preview? 90:360);
						
						
			// Coupler tube interface
			if (CouplerTube_ID>0)
			translate([0,0,-BodyTube_L]) 
				cylinder(d=CouplerTube_ID, h=BodyTube_L+1, $fn=$preview? 90:360);
		} // union
			
		// Center Hole
		translate([0,0,-BodyTube_L-Overlap]) 
			cylinder(d=SpringHole_ID, h=BodyTube_L+Overlap*2, $fn=$preview? 90:360);
		//translate([0,0,-Overlap]) 
		//	cylinder(d=CenterHole_d, h=20, $fn=$preview? 90:360);
			
		if (CouplerTube_ID>0){
			translate([0,0,-BodyTube_L-Overlap]) 
				cylinder(d=ST_DSpring_OD, h=BodyTube_L, $fn=$preview? 90:360);
			translate([0,0,-BodyTube_L-Overlap]) 
				cylinder(d1=ST_DSpring_OD+5, d2=ST_DSpring_OD, h=BodyTube_L-5, $fn=$preview? 90:360);
		}
			
		// Retention cord
		if (nRopes>0)
		for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*(j+0.5)]) {
				translate([0,14,-BodyTube_L-Overlap]) cylinder(d=4, h=30);
				translate([0,14,5]) cylinder(d=8, h=30);
			}
	} // difference
	
	if (HasThreadedCore) translate([0,0,-BodyTube_L])
		difference(){
			union(){
				cylinder(d=20, h=BodyTube_L);
				
				for (j=[0:2]) rotate([0,0,120*j]) hull(){
					cylinder(d=4, h=BodyTube_L);
					translate([0,SpringHole_ID/2,0]) cylinder(d=4, h=BodyTube_L);
				} // hull
			} // union
			
			translate([0,0,-Overlap]) 
			if ($preview){ 
				cylinder(d=6.35, h=BodyTube_L+Overlap*2); }
			else { 
				ExternalThread(Pitch=25.4/20, Dia_Nominal=6.35+IDXtra*2, 
							Length=BodyTube_L+Overlap*2, Step_a=2,TrimEnd=true,TrimRoot=true); }
			
		} // difference
	
	
} // PD_Booster_PetalHub

// *** Parts for Omega54
// PD_Booster_PetalHub(OD=BT54Coupler_OD, nPetals=2, nRopes=2, ShockCord_a=-1, HasThreadedCore=true, ST_DSpring_ID=SE_Spring_CS4323_ID(), ST_DSpring_OD=SE_Spring_CS4323_OD(), CouplerTube_ID=0);
// rotate([180,0,0])PD_Petals(OD=BT54Coupler_OD, Len=50, nPetals=2, Wall_t=1.8, AntiClimber_h=0, HasLocks=true, Lock_Span_a=180);
// rotate([0,90,0]) translate([0,0,2])PD_PetalLockCatch(OD=BT54Coupler_OD, ID=BT54Coupler_ID, Wall_t=1.8, Len=27, LockStop=false);
// PD_CatchHolder(OD=BT54Coupler_OD, ID=BT54Coupler_ID, Wall_t=1.8, nPetals=2, HasBasePlate=true);





