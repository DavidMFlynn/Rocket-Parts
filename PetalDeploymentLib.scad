// ***********************************
// Project: 3D Printed Rocket
// Filename: PetalDeploymentLib.scad
// by David M. Flynn
// Created: 10/22/2023 
// Revision: 0.9.1  10/26/2023 
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  Deployment spring pushes on the petals not the parachute.
//
//  ***** Hardware *****
//
// #4-40 x 3/8" Socket Head Cap Screw (3 req) PetalHub
// #4-40 x 1/4" Button Head Cap Screw (6 req) Petals
// 0.3" Dia x 1.25" spring
//
//  ***** History *****
//
// 0.9.1  10/26/2023  Added AntiClimber_h to PD_Petals()
// 0.9.0  10/22/2023  Copied from Rocket 75C to create this library
//
// ***********************************
//  ***** for STL output *****
//
// rotate([180,0,0]) PD_Petals(Coupler_OD=BT75Coupler_OD, Len=110, nPetals=3, AntiClimber_h=0);
// rotate([-90,0,0]) PD_PetalSpringHolder(Coupler_OD=BT75Coupler_OD);
/*
PD_PetalHub(Coupler_OD=BT75Coupler_OD, 
					nPetals=3, 
					HasBolts=true,
					ShockCord_a=PD_ShockCordAngle(),
					HasNCSkirt=false, 
						Body_OD=BT75Body_OD,
						Body_ID=BT75Body_ID,
						NC_Base=NC_Base, 
						SkirtLen=10);
/**/
//
// ***********************************
//  ***** Routines *****
//
function PD_ShockCordAngle()=ShockCord_a;
// PD_PetalHubBoltPattern(Coupler_OD=BT75Coupler_OD, nPetals=3) Bolt4Hole();
// PD_ShockCordHolePattern(Coupler_OD=BT75Coupler_OD, ShockCord_a=ShockCordAngle()) cylinder(d=4, h=15);
//
// ***********************************

include<TubesLib.scad>
use<SpringThingBooster.scad>
include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;
Bolt4Inset=4;
ShockCord_a=45;
NC_Base=15;
PetalWidth=15;


module PD_Petals(Coupler_OD=BT75Coupler_OD, Len=25, nPetals=3, AntiClimber_h=0){
	Bolt1_Z=11.75;
	Thickness=3;
	BaseOffset=11.2;
	AntiClimber_w=2;
	AntiClimber_L=AntiClimber_h*4;
	
	module AntiClimber(){
		translate([0.6,-Coupler_OD/2+1,0])
		hull(){
			cube([AntiClimber_w+1.5,Overlap,AntiClimber_L]);
			translate([AntiClimber_w/2, AntiClimber_h, AntiClimber_h]) 
				cylinder(d=AntiClimber_w,h=AntiClimber_h*2);
		} // hull
	} // AntiClimber
	
	difference(){
		union(){
			translate([0,0,BaseOffset]) 
				Tube(OD=Coupler_OD-IDXtra*2, ID=Coupler_OD-3.6, Len=Len, myfn=$preview? 90:360);
			
			for (j=[0:nPetals-1]) rotate([0,0,360/nPetals*j]) difference(){
				intersection(){
					cylinder(d=Coupler_OD-IDXtra*2, h=16+BaseOffset, $fn=$preview? 90:360);
						
					translate([-PetalWidth/2,Coupler_OD/2-Thickness,0]) 
						cube([PetalWidth, Coupler_OD, 16+BaseOffset]);
				} // intersection
				translate([0,0,16+BaseOffset-3])
					cylinder(d1=Coupler_OD-Thickness*2, d2=Coupler_OD-3.6+Overlap, 
							h=3+Overlap, $fn=$preview? 90:360);
					
				
			} // for difference
			
			if (AntiClimber_h>0)
				for (j=[0:nPetals-1]) 
					rotate([0,0,360/nPetals*j]) {
						translate([0,0,BaseOffset+Len-AntiClimber_L]){
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
			translate([0,Coupler_OD/2,Bolt1_Z]) rotate([-90,0,0]) Bolt4ButtonHeadHole();
			translate([0,Coupler_OD/2,Bolt1_Z+Bolt4Inset*2]) rotate([-90,0,0]) Bolt4ButtonHeadHole();
			}
		
		// Cut here
		for (j=[0:nPetals-1]) rotate([0,0,360/nPetals*(j+0.5)])
			translate([0,Coupler_OD/2,Len/2+BaseOffset]) cube([2,2,Len+Overlap*2], center=true);
	} // difference
} // PD_Petals

//rotate([180,0,0]) PD_Petals(Coupler_OD=BT75Coupler_OD, Len=110, nPetals=3, AntiClimber_h=3);

module PD_PetalSpringHolder(Coupler_OD=BT75Coupler_OD){
	Width=11;
	Thickness=3;
	Spring_d=5/16*25.4;
	Axle_d=4;
	Axle_L=Width+9;
	AxleBoss_d=Axle_d+2.4;
	
	
	difference(){
		union(){
			translate([0,0,8]) hull(){
				translate([0,Coupler_OD/2-Thickness-Width/2,0]) cylinder(d=Width, h=10);
				translate([-Width/2,Coupler_OD/2-Thickness-1,0]) cube([Width,1,1]);
			
				translate([0,Coupler_OD/2-Thickness,Bolt4Inset*3]) rotate([90,0,0]) cylinder(d=Width,h=3);
			} // hull
			
			translate([0,Coupler_OD/2-Thickness-AxleBoss_d/2,0]) hull(){
				rotate([0,90,0]) cylinder(d=AxleBoss_d, h=PetalWidth, center=true);
				translate([0,0,8]) rotate([0,90,0]) cylinder(d=AxleBoss_d, h=Width, center=true);
			} // hull
			
			// Axle
			translate([0,Coupler_OD/2-Thickness-AxleBoss_d/2,0])
			rotate([0,90,0]) cylinder(d=Axle_d, h=Axle_L, center=true);
		} // union
		
		
		// Sping	
		translate([0,Coupler_OD/2-Thickness-Width/2,-AxleBoss_d/2-Overlap]) {
			cylinder(d=Spring_d+IDXtra, h=16+AxleBoss_d/2);
			cylinder(d=4, h=30);
		}
		
		translate([0,Coupler_OD/2,12]) rotate([-90,0,0]) Bolt4Hole(depth=6);
		translate([0,Coupler_OD/2,12+Bolt4Inset*2]) rotate([-90,0,0]) Bolt4Hole(depth=9.5);
	} // difference
} // PD_PetalSpringHolder

//translate([0,-1,7]) PD_PetalSpringHolder(Coupler_OD=BT75Coupler_OD);
//rotate([-90,0,0]) PD_PetalSpringHolder(Coupler_OD=BT75Coupler_OD);

module PD_PetalHubBoltPattern(Coupler_OD=BT75Coupler_OD, nPetals=3){
	for (j=[0:nPetals-1]) rotate([0,0,360/nPetals*(j+0.5)])
			translate([0,Coupler_OD/2-Bolt4Inset,0]) children();
} // PD_PetalHubBoltPattern

// PD_PetalHubBoltPattern(Coupler_OD=BT75Coupler_OD, nPetals=3) Bolt4Hole();

module PD_ShockCordHolePattern(Coupler_OD=BT75Coupler_OD, ShockCord_a=ShockCord_a){
	rotate([0,0,ShockCord_a]) translate([0,Coupler_OD/2-6,0]) children();
	rotate([0,0,ShockCord_a]) translate([0,Coupler_OD/2-17.5,0]) children();
} // ShockCordHolePattern

// PD_ShockCordHolePattern(Coupler_OD=BT75Coupler_OD, ShockCord_a=ShockCord_a);

module PD_PetalHub(Coupler_OD=BT75Coupler_OD, 
					nPetals=3, 
					HasBolts=true,
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
	SpringEnd_Y=Coupler_OD/2-16;
	Axle_d=4+IDXtra*3;
	Axle_L=Width+7;
	AxleBoss_d=Axle_d+2.4;
	Skirt_OD=Body_ID-IDXtra;
	Skirt_ID=Skirt_OD-4.4;
	
	difference(){
		union(){
			STB_SpringEnd(Tube_ID=Coupler_OD, CouplerTube_ID=Coupler_OD-3.6, SleeveLen=16, nRopeHoles=0);
			
			// Close bottom
			//translate([0,0,3]) 
			cylinder(d=Coupler_OD-1, h=6);
			
			// Spring holders
			for (j=[0:nPetals-1]) rotate([0,0,360/nPetals*j]) 
				hull(){
					translate([0,SpringEnd_Y,Shelf_Z-10+Spring_d/2]) 
						rotate([90,0,0]) cylinder(d=Spring_d+3, h=11);
					translate([-(Spring_d+5)/2,SpringEnd_Y-11,Shelf_Z-12]) 
						cube([Spring_d+5,11,1]);
				} // hull
				
			if (HasNCSkirt){
				
				// Nosecone
				translate([0,0,-SkirtLen-NC_Base-3]) // Fit to nosecone
				Tube(OD=Coupler_OD-IDXtra*2, ID=Skirt_ID, 
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
				PD_PetalHubBoltPattern(Coupler_OD=Coupler_OD, nPetals=nPetals) 
					translate([0,0,5]) Bolt4HeadHole(lHead=20);
		}
		
		// Petal ledge and Spring slot
		for (j=[0:nPetals-1]) rotate([0,0,360/nPetals*j]){
			translate([-Width/2,5,Shelf_Z]) cube([Width,Coupler_OD/2,20]);
			
			// Axle 
			translate([0,Coupler_OD/2-Thickness-AxleBoss_d/2-0.5,7]){
			
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
				translate([0,Coupler_OD/2-16,Shelf_Z-10+Spring_d/2]) 
					rotate([-90,0,0]) cylinder(d=Spring_d+1, h=20);
				translate([0,Coupler_OD/2-16,Shelf_Z+Spring_d/2]) 
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
			PD_ShockCordHolePattern(Coupler_OD=Coupler_OD, ShockCord_a=ShockCord_a) cylinder(d=4, h=20);
			
	} // difference
	
} // PD_PetalHub

//PD_PetalHub(Coupler_OD=BT75Coupler_OD, nPetals=3, ShockCord_a=ShockCord_a);
//PD_PetalHub(Coupler_OD=BT98Coupler_OD, nPetals=6, ShockCord_a=22.5);

//PD_PetalHub(Coupler_OD=BT75Coupler_OD, HasNCSkirt=true, SkirtLen=10, nPetals=3, ShockCord_a=ShockCord_a);














