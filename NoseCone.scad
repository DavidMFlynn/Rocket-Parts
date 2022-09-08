// ***********************************
// Project: 3D Printed Rocket
// Filename: NoseCone.scad
// Created: 6/13/2022 
// Revision: 0.9.3  9/8/2022
// Units: mm
// ***********************************
//  ***** Notes *****
//
// Nose Cones
//
//  ***** History *****
//
// 0.9.3  9/8/2022  Added base radius to BluntConeNoseCone. 
// 0.9.2  7/25/2022 Using offset for nosecone wall. Added BluntConeNoseCone and OgiveNoseCone. 
// 0.9.1  6/24/2022 Thinner wall nosecone, added Wall_T
// 0.9.0  6/13/2022 First code.
//
// ***********************************
//  ***** for STL output *****
//
// BluntConeNoseCone(ID=PML98Body_ID, OD=PML98Body_OD, L=180, Base_L=21, Tip_R=15, Wall_T=3);
// OgiveNoseCone(ID=PML98Body_ID, OD=PML98Body_OD, L=170, Base_L=21, Wall_T=3);
//
// BluntOgiveNoseCone(ID=PML54Body_ID, OD=PML54Body_OD, L=160, Base_L=10, Tip_R=7, Wall_T=3);
// BluntOgiveNoseCone(ID=PML98Body_ID, OD=PML98Body_OD, L=190, Base_L=21, Tip_R=22, Wall_T=2);
// NoseconeBase(OD=PML98Body_ID, L=60, NC_Base=21);
//
// ***********************************
//  ***** Routines *****
//
// BluntConeShape(L=100, D=50, Base_L=2, Tip_R=5); //Spherically blunted conic
// OgiveShape(L=100, D=50, Base_L=2, Tip_R=5); // tangent ogive
// BluntOgiveShape(L=150, D=50, Base_L=10, Tip_R=5); // Spherically blunted tangent ogive
//
// ***********************************

include<TubesLib.scad>
include<CommonStuffSAEmm.scad>

Overlap=0.05;
$fn=$preview? 24:90;
IDXtra=0.2;

module BluntConeShape(L=100, D=50, Base_L=2, Tip_R=5){
	//Spherically blunted conic
	Trans_R=Tip_R<=Base_L? Tip_R:Base_L;
	
	difference(){
		hull(){
			translate([0,L-Tip_R,0]) circle(r=Tip_R); 
			translate([D/2-Trans_R,Base_L,0]) circle(r=Trans_R); 
			translate([-D/2,0,0]) square([D,Base_L]);
		} // hull
		
		translate([-D/2-1,-Overlap,0]) square([D/2+1,L+Overlap*2]);
	} // difference
} // BluntConeShape

// rotate_extrude() BluntConeShape(L=100, D=50, Base_L=5, Tip_R=5);

// BluntConeShape(L=100, D=50, Base_L=15, Tip_R=10);

module BluntConeNoseCone(ID=54, OD=58, L=160, Base_L=10, Tip_R=5, Wall_T=3){
	
	difference(){
		rotate_extrude($fn=$preview? 90:720) 
			BluntConeShape(L=L, D=OD, Base_L=Base_L, Tip_R=Tip_R);
		
		// Skirt
		translate([0,0,-Overlap]) cylinder(d=ID, h=Base_L+Overlap*2, $fn=$preview? 90:720);
		translate([0,0,Base_L]) cylinder(d1=ID, d2=OD-Wall_T*4, h=Wall_T*2, $fn=$preview? 90:720);
		
		rotate_extrude($fn=$preview? 90:720) 
			offset(-Wall_T) BluntConeShape(L=L, D=OD, Base_L=Base_L, Tip_R=Tip_R);
		cylinder(d=Wall_T*3, h=L-Tip_R);
		translate([0,0,L-Tip_R]) sphere(r=Tip_R-Wall_T,$fn=$preview? 36:360);
		
		if (Base_L>12) translate([0,0,Base_L/2])
			RivetPattern(BT_Dia=OD, nRivets=3, Dia=5/32*25.4);
		
		if ($preview==true) translate([0,-100,-1]) cube([100,100,200]);
	} // difference
	
} // BluntConeNoseCone

//BluntConeNoseCone(ID=PML54Body_ID, OD=PML54Body_OD, L=120, Base_L=5, Tip_R=7, Wall_T=2.2);
//BluntConeNoseCone();

module OgiveShape(L=100, D=50, Base_L=2){
	// tangent ogive
	R=D/2;
	p=(R*R+L*L)/(2*R);
	
	translate([0,Base_L,0])
	difference(){
		intersection(){
			square([R,L]);
			translate([-p+R,0]) circle(r=p,$fn=$preview? 90:360);
		} // intersection
		
		translate([-100,-Overlap,0]) square([100,L+Overlap*2]);
	} // difference
	square([R,Base_L+Overlap]);
} // OgiveShape

//rotate_extrude() OgiveShape();

module OgiveNoseCone(ID=54, OD=58, L=160, Base_L=10, Wall_T=3){
	R=OD/2;
	p=(R*R+L*L)/(2*R);
	
	difference(){
		rotate_extrude($fn=$preview? 90:720) 
			OgiveShape(L=L, D=OD, Base_L=Base_L);
		
		// Skirt
		translate([0,0,-Overlap]) cylinder(d=ID, h=Base_L+Overlap*2, $fn=$preview? 90:720);
		translate([0,0,Base_L]) cylinder(d1=ID, d2=OD-Wall_T*2, h=Wall_T, $fn=$preview? 90:720);
		
		rotate_extrude($fn=$preview? 90:720) 
			offset(-Wall_T) OgiveShape(L=L, D=OD, Base_L=Base_L);
		cylinder(d=Wall_T*2.2, h=Base_L+L-Wall_T*4);
		
		if (Base_L>12) translate([0,0,Base_L/2])
			RivetPattern(BT_Dia=OD, nRivets=3, Dia=5/32*25.4);
		
		if ($preview==true) translate([0,-100,-1]) cube([100,100,200]);
	} // difference
	
} // OgiveNoseCone

//OgiveNoseCone(ID=PML98Body_ID, OD=PML98Body_OD, L=180, Base_L=21, Wall_T=3);

module BluntOgiveShape(L=150, D=50, Base_L=10, Tip_R=5){
	// Spherically blunted tangent ogive
	R=D/2;
	p=(R*R+L*L)/(2*R);
	X0 = L-sqrt((p-Tip_R)*(p-Tip_R)-(p-R)*(p-R));
	
	translate([0,Base_L,0])
	difference(){
		hull(){
			difference(){
				intersection(){
					square([R,L]);
					translate([-p+R,0]) circle(r=p, $fn=$preview? 90:720);
				} // intersection
				translate([0,L-X0]) square([50,50]);
			} // difference
			translate([0,L-X0, 0]) circle(r=Tip_R, $fn=$preview? 90:720);
		} // hull
	
		translate([-100,-Overlap,0]) square([100,L+Overlap*2]);
	} // difference
	
	square([R,Base_L+Overlap]);
} // BluntOgiveShape

//rotate_extrude() 
//offset(-3) BluntOgiveShape();

module BluntOgiveNoseCone(ID=54, OD=58, L=160, Base_L=10, Tip_R=5, Wall_T=3){
	R=OD/2;
	p=(R*R+L*L)/(2*R);
	X0 = L-sqrt((p-Tip_R)*(p-Tip_R)-(p-R)*(p-R));
	
	difference(){
		rotate_extrude($fn=$preview? 90:720) 
			BluntOgiveShape(L=L, D=OD, Base_L=Base_L, Tip_R=Tip_R);
		
		// Skirt
		translate([0,0,-Overlap]) cylinder(d=ID, h=Base_L+Overlap*2, $fn=$preview? 90:720);
		translate([0,0,Base_L]) cylinder(d1=ID, d2=OD-Wall_T*2, h=Wall_T, $fn=$preview? 90:720);
		
		rotate_extrude($fn=$preview? 90:720) 
			offset(-Wall_T) BluntOgiveShape(L=L, D=OD, Base_L=Base_L, Tip_R=Tip_R);
		cylinder(d=Wall_T*3, h=Base_L+L-X0+Tip_R-Wall_T*2);
		translate([0,0,Base_L+L-X0]) sphere(r=Tip_R-Wall_T,$fn=$preview? 36:360);
		
		if (Base_L>12) translate([0,0,Base_L/2])
			RivetPattern(BT_Dia=OD, nRivets=3, Dia=5/32*25.4);
		
		if ($preview==true) translate([0,-100,-1]) cube([100,100,200]);
	} // difference
	
} // BluntOgiveNoseCone

//BluntOgiveNoseCone(ID=PML98Body_ID, OD=PML98Body_OD, L=180, Base_L=21, Tip_R=23, Wall_T=3);

//BluntOgiveNoseCone(ID=PML75Body_ID, OD=PML75Body_OD, L=180, Base_L=21, Tip_R=10, Wall_T=2.2);

//BluntOgiveNoseCone(ID=PML54Body_ID, OD=PML54Body_OD, L=160, Base_L=10, Tip_R=7, Wall_T=3);

module NoseconeBase(OD=PML98Body_ID, L=60, NC_Base=21){
	Wall_T=2;
	UBolt_X=25.4;
	
	difference(){
		cylinder(d=OD, h=L+NC_Base, $fn=$preview? 90:720);
		
		translate([0,0,4]) cylinder(d=OD-Wall_T*2,h=L+NC_Base, $fn=$preview? 90:720);
		
		// ubolt
		translate([-UBolt_X/2,0,4]) Bolt250ClearHole();
		translate([UBolt_X/2,0,4]) Bolt250ClearHole();
		
		if (NC_Base>12) translate([0,0,L+NC_Base/2])
			RivetPattern(BT_Dia=OD, nRivets=3, Dia=5/32*25.4);
		
		if ($preview==true) translate([0,-100,-100]) cube([100,100,200]);
	} // difference
} // NoseconeBase

//translate([0,0,-60]) NoseconeBase(OD=PML75Coupler_OD, L=60, NC_Base=21);


//NoseconeBase(OD=PML75Body_ID, L=60, NC_Base=21);




















