// ***********************************
// Project: 3D Printed Rocket
// Filename: NoseCone.scad
// by David M. Flynn
// Created: 6/13/2022 
// Revision: 0.9.12  3/31/2024
// Units: mm
// ***********************************
//  ***** Notes *****
//
// Nose Cones
//
//  ***** History *****
//
echo("NoseCone 0.9.12");
// 0.9.12  3/31/2024 Added skirt bolt holes (nBolts) to NC_ShockcordRingDual()
// 0.9.11 12/3/2023  Added NC_ShockcordRing75
// 0.9.10 11/20/2023 Added nRivets=3 parameter
// 0.9.9  10/22/2023 fixed BluntOgiveNoseCone skirt
// 0.9.8  10/21/2023 fixed BluntOgiveNoseCone thicness again
// 0.9.7  2/23/2023  Added HasUBolt to NoseconeBase, fixed nosecode inside again.
// 0.9.6  1/4/2023   Added Bulkplate_BONC, Splice_BONC
// 0.9.5  10/19/2022 edited Transition_OD
// 0.9.4  9/18/2022  More fixes, optioned HasRivets
// 0.9.3  9/8/2022   Added base radius to BluntConeNoseCone. 
// 0.9.2  7/25/2022  Using offset for nosecone wall. Added BluntConeNoseCone and OgiveNoseCone. 
// 0.9.1  6/24/2022  Thinner wall nosecone, added Wall_T
// 0.9.0  6/13/2022  First code.
//
// ***********************************
//  ***** for STL output *****
// NC_ShockcordRing75(Body_OD=BT75Body_OD, Body_ID=BT75Body_ID, NC_Base_L=13);
// NC_ShockcordRingDual(Tube_OD=BT137Body_OD, Tube_ID=BT137Body_ID, NC_Base_L=25, nRivets=6, nBolts=0);
// NC_ShockcordRingDual(Tube_OD=BT98Body_OD, Tube_ID=BT98Body_ID, NC_Base_L=15, nRivets=3, nBolts=0);
//
// BluntConeNoseCone(ID=PML98Body_ID, OD=PML98Body_OD, L=180, Base_L=21, nRivets=3, Tip_R=15, Wall_T=3);
// OgiveNoseCone(ID=PML98Body_ID, OD=PML98Body_OD, L=170, Base_L=21, Wall_T=3);
//
// BluntOgiveNoseCone(ID=PML98Body_ID, OD=PML98Body_OD, L=280, Base_L=5, nRivets=3, Tip_R=5, Wall_T=3, Cut_Z=130, Transition_OD=PML98Body_OD, LowerPortion=false);
// 
// Splice_BONC(OD=58, H=10, L=160, Base_L=5, Tip_R=5, Wall_T=2.2, Cut_Z=80);  // fix a failed print
// Bulkplate_BONC(OD=58, T=10, L=160, Base_L=5, Tip_R=5, Wall_T=2.2, Cut_Z=80);
// BluntOgiveNoseCone(ID=PML98Body_ID, OD=PML98Body_OD, L=190, Base_L=21, Tip_R=22, Wall_T=2);
// NoseconeBase(OD=PML98Body_ID, L=60, NC_Base=21, HasUBolt=true);
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

module NC_ShockcordRing75(Body_OD=BT75Body_OD, Body_ID=BT75Body_ID, NC_Base_L=13){
    // Small Spring
	Spring_CS4323_OD=44.30;
	Spring_CS4323_ID=40.50;
	Spring_CS4323_CBL=22; // coil bound length
	Spring_CS4323_FL=200; // free length

	nRivets=3;
	Rivet_d=4;
	Plate_t=4;
	nHoles=3;
	Tube_d=12.7;
	CR_z=-3;
	Spring_OD=Spring_CS4323_OD;
	Spring_ID=Spring_CS4323_ID;
	
	
	module FW_GPS_SW_Hole(a=0){
		translate([-4,-1.6-1,-1]) 
			rotate([0,-90+a,0]) cylinder(d=1.7, h=100);
	} // FW_GPS_SW_Hole


	module FW_GPS_Mount(){
		Boss_d=10;
		
		module Boss(){
			difference(){
				rotate([-90,0,0]) cylinder(d1=7,d2=Boss_d,h=6);
					
				rotate([90,0,0]) Bolt4Hole();
			} // difference
		} // Boss
		
		// Backing plate
		
		Boss_Y=2;
		Boss_Z=13.5;
		difference(){
			union(){
				hull(){
					translate([-4,6,-8]) cube([20.4+8,3,42+12]);
					translate([-4,6,-8]) cube([20.4+8,10,1]);
				} // hull
				
				translate([4,Boss_Y,Boss_Z])Boss();
				translate([4,Boss_Y,Boss_Z])translate([12.7,0,25.4]) Boss();
			} // union
			
			translate([4,Boss_Y,Boss_Z]) rotate([90,0,0]) Bolt4Hole(depth=20);
			translate([4,Boss_Y,Boss_Z]) translate([12.7,0,25.4]) rotate([90,0,0]) Bolt4Hole();
		} // difference
		
	} // FW_GPS_Mount
	
	
	//FW_GPS_Mount();

	module FW_GPS_Batt_Mount(){
		Batt_X=25;
		Batt_Y=5;
		Batt_Z=37;
		Wall_t=2.4;
		
		difference(){
			union(){
				cube([Batt_X+Wall_t*2, Batt_Y+Wall_t*2, Batt_Z+Wall_t*2], center=true);
				//*
				hull(){
					translate([0,Batt_Y/2+Wall_t,Batt_Z/2+Wall_t/2]) 
						cube([10,Overlap,Wall_t],center=true);
					translate([0,Batt_Y/2+Wall_t+6,-Batt_Z/2-Wall_t]) 
						cube([10,12,Overlap],center=true);
				} // hull
				/**/
			} // union
			
			cube([Batt_X, Batt_Y, Batt_Z], center=true);
			
			// Wire Path
			hull(){
				cylinder(d=Batt_Y, h=Batt_Z);
				translate([0,-5,0]) cylinder(d=Batt_Y, h=Batt_Z);
			} // hull
			
			//ty-wrap
			translate([0,Batt_Y/2+Wall_t+2,0]) 
				rotate([0,90,0]) cylinder(d=4, h=Batt_X+Wall_t*2+Overlap, center=true);
			translate([0,-Batt_Y/2-2.4,0]) 
				rotate([0,90,0]) cylinder(d=4, h=Batt_X+Wall_t*2+Overlap, center=true);
			
			translate([0, -5, 5]) cube([Batt_X, Batt_Y, Batt_Z], center=true);
			translate([0, -3, 5]) cube([Batt_X, Batt_Y+1, Batt_Z-10], center=true);
			translate([0, -3, 0]) cube([Batt_X, Batt_Y, Batt_Z-10], center=true);
		} // difference
		
	} // FW_GPS_Batt_Mount

	//FW_GPS_Batt_Mount();

	
	difference(){
		union(){
			// Stop ring
			translate([0,0,-2]) Tube(OD=Body_OD, ID=Body_ID-1, Len=2, myfn=$preview? 36:360);
			
			// GPS mount
			translate([-10,-Body_ID/2+13, 6]) rotate([-10,0,0]) FW_GPS_Mount();
			rotate([0,0,180]) translate([0,-Body_ID/2+17,20])  
				rotate([-10,0,0]) FW_GPS_Batt_Mount();

			// Nosecone interface
			Tube(OD=Body_ID-IDXtra*2, ID=Body_ID-4.4, Len=NC_Base_L, myfn=$preview? 36:360);
			
			// Body tube interface
			translate([0,0,-15]) Tube(OD=Body_ID, ID=Body_ID-4.4, Len=15, myfn=$preview? 36:360);
			// Spring holder
			translate([0,0,-15]) Tube(OD=Spring_OD+8, ID=Spring_OD, Len=15+Overlap, myfn=$preview? 36:360);
				
			// Stiffener
			translate([0,0,-5])
				cylinder(d=Body_ID-1, h=6);
				
			// Tube holder
			difference(){
				hull(){
					translate([0,0,CR_z+3+Tube_d/2]) 
						rotate([0,90,0]) cylinder(d=Tube_d+4.4, h=Body_ID-3, center=true);
					translate([0,0,CR_z+2]) cube([Body_ID-4,Tube_d+8,Overlap],center=true);
				} // hull
				
				translate([0,0,CR_z+3+Tube_d/2]) 
						rotate([0,90,0]) cylinder(d=Tube_d+20, h=Body_ID-38, center=true);
			} // difference
		} // union
		
		// Nosecone rivets
		for (j=[0:nRivets-1]) rotate([0,0,360/nRivets*j]) translate([0,-Body_ID/2-1,NC_Base_L/2])
			rotate([-90,0,0]){ cylinder(d=Rivet_d, h=10); 
			translate([0,0,3.2]) cylinder(d=Rivet_d*2, h=6);}

		// Center hole
		translate([0,0,-6]) hull(){
			translate([8,0,0]) cylinder(d=Tube_d+6, h=28);
			translate([-8,0,0]) cylinder(d=Tube_d+6, h=28);
			}
			
		
		// Spring
		translate([0,0,-6]) cylinder(d=Spring_OD, h=3, $fn=$preview? 36:360);
		translate([0,0,-15-Overlap]) cylinder(d1=Spring_OD+4, d2=Spring_OD, h=8, $fn=$preview? 36:360);
		
		// Tube hole
		translate([0,0,CR_z+3+Tube_d/2]) rotate([0,90,0]) cylinder(d=Tube_d, h=Body_OD, center=true);
		
		// Retention cord
		for (j=[0:nHoles-1]) rotate([0,0,360/nHoles*j]) translate([0,Body_ID/2-6,-10]) cylinder(d=4, h=30);
	} // difference
	
} // NC_ShockcordRing75

//NC_ShockcordRing75(Body_OD=BT75Body_OD, Body_ID=BT75Body_ID, NC_Base_L=13);

module NC_ShockcordRingDual(Tube_OD=BT98Body_OD, Tube_ID=BT98Body_ID, NC_Base_L=20, nRivets=3, nBolts=0){
	// Connects nosecone to deployment tube
	// Has aluminum tube shock cord mount
	// Has spring end and resess for spring into nosecone
	// Mount for Featherweight GPS tracker

// Bigger Spring
Spring_CS11890_OD=70.5;
Spring_CS11890_ID=64.7;
Spring_CS11890_FL=225;
Spring_CS11890_CL=33;

// Big Spring
Spring_CS4009_OD=2.328*25.4;
Spring_CS4009_ID=2.094*25.4;
Spring_CS4009_FL=18.5*25.4;
Spring_CS4009_CL=1.64*25.4;
// Small Spring
Spring_CS4323_OD=44.30;
Spring_CS4323_ID=40.50;
Spring_CS4323_CBL=22; // coil bound length
Spring_CS4323_FL=200; // free length


	Plate_t=4;
	nHoles=6;
	Rivet_d=4;
	Tube_d=12.7;
	Tube_Z=30;
	CR_z=-3;
	Spring_OD=(Tube_OD>110)? Spring_CS11890_OD:Spring_CS4323_OD;
	BodyTube_L=15;
	SpringEnd_Z=Tube_Z-Tube_d/2-3;
	SpringSplice_OD=Spring_OD+10;
	
		
	module FW_GPS_SW_Hole(a=0){
		translate([-4,-1.6-1,-1]) 
			rotate([0,-90+a,0]) cylinder(d=1.7, h=100);
	} // FW_GPS_SW_Hole

	module FW_GPS_Mount(){
		Boss_d=10;
		
		module Boss(){
			difference(){
				rotate([-90,0,0]) cylinder(d1=7,d2=Boss_d,h=6);
					
				rotate([90,0,0]) Bolt4Hole();
			} // difference
		} // Boss
		
		// Backing plate
		
		Boss_Y=2;
		Boss_Z=13.5;
		difference(){
			union(){
				hull(){
					translate([-4,6,-8]) cube([20.4+8,3,42+12]);
					translate([-4,6,-8]) cube([20.4+8,10,1]);
				} // hull
				
				translate([4,Boss_Y,Boss_Z])Boss();
				translate([4,Boss_Y,Boss_Z])translate([12.7,0,25.4]) Boss();
			} // union
			
			translate([4,Boss_Y,Boss_Z]) rotate([90,0,0]) Bolt4Hole(depth=20);
			translate([4,Boss_Y,Boss_Z]) translate([12.7,0,25.4]) rotate([90,0,0]) Bolt4Hole();
		} // difference
		
	} // FW_GPS_Mount
	
	
		/*
		// Switch access
		translate([-4,-1.6-1,-1]) 
		rotate([0,90,0])
		difference(){
			hull(){
				cylinder(d=4, h=4);
				translate([4,10,0]) cylinder(d=4, h=4);
			} // hull
			
			translate([0,0,-Overlap]) cylinder(d=1.7, h=5);
		}
		/**/
	//FW_GPS_Mount();

	module FW_GPS_Batt_Mount(){
		Batt_X=25;
		Batt_Y=5;
		Batt_Z=37;
		Wall_t=2.4;
		
		difference(){
			union(){
				cube([Batt_X+Wall_t*2, Batt_Y+Wall_t*2, Batt_Z+Wall_t*2], center=true);
				hull(){
					translate([0,Batt_Y/2+Wall_t,Batt_Z/2+Wall_t/2]) 
						cube([10,Overlap,Wall_t],center=true);
					translate([0,Batt_Y/2+Wall_t+10,-Batt_Z/2-Wall_t]) 
						cube([10,20,Overlap],center=true);
				} // hull
			} // union
			
			cube([Batt_X, Batt_Y, Batt_Z], center=true);
			
			// Wire Path
			hull(){
				cylinder(d=Batt_Y, h=Batt_Z);
				translate([0,-5,0]) cylinder(d=Batt_Y, h=Batt_Z);
			} // hull
			
			//ty-wrap
			translate([0,Batt_Y/2+Wall_t+2,0]) 
				rotate([0,90,0]) cylinder(d=4, h=Batt_X+Wall_t*2+Overlap, center=true);
			translate([0,-Batt_Y/2-2.4,0]) 
				rotate([0,90,0]) cylinder(d=4, h=Batt_X+Wall_t*2+Overlap, center=true);
			
			translate([0, -5, 5]) cube([Batt_X, Batt_Y, Batt_Z], center=true);
			translate([0, -3, 5]) cube([Batt_X, Batt_Y+1, Batt_Z-10], center=true);
			translate([0, -3, 0]) cube([Batt_X, Batt_Y, Batt_Z-10], center=true);
		} // difference
		
	} // FW_GPS_Batt_Mount

	//FW_GPS_Batt_Mount();
		
	difference(){
		union(){
			// GPS mount
			rotate([0,0,-45]) translate([-4,-Spring_OD/2-16,6]) rotate([-10,0,8]) FW_GPS_Mount();
			rotate([0,0,32]) translate([0,-Spring_OD/2-13,20]) FW_GPS_Batt_Mount();
			
			// Stop ring
			translate([0,0,CR_z]) Tube(OD=Tube_OD, ID=Tube_ID-1, Len=3, myfn=$preview? 90:360);
	
			// Nosecone interface
			translate([0,0,-1]) Tube(OD=Tube_ID-IDXtra*2, 
									ID=Tube_ID-IDXtra*2-4.4, Len=NC_Base_L+1, myfn=$preview? 90:360);
			// Body tube interface
			translate([0,0,-BodyTube_L-3]) Tube(OD=Tube_ID, 
									ID=Tube_ID-4.4, Len=BodyTube_L+1, myfn=$preview? 90:360);
				
			// Stiffener Plate
			translate([0,0,-5])
				cylinder(d=Tube_ID-1, h=6);
				
			// Tube holder
			hull(){
				translate([0,0,Tube_Z]) 
					rotate([0,90,0]) cylinder(d=Tube_d+4.4, h=Tube_ID-5, center=true);
				translate([0,0,CR_z+5]) cube([Tube_ID-4, Tube_d+12, 10],center=true);
			} // hull
			
			// Spring Holder
			cylinder(d1=SpringSplice_OD+10, d2=Spring_OD+6, h=SpringEnd_Z+4);
		} // union
		
		if (nBolts>0){
			for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j])
				translate([0,-Tube_ID/2-1,-3-BodyTube_L/2]) rotate([90,0,0]) Bolt4Hole();
		}
		
		//translate([-4,-34,4]) FW_GPS_SW_Hole(-9);
		
		// Nosecone rivets
		for (j=[0:nRivets-1]) rotate([0,0,360/nRivets*j]) translate([0,-Tube_ID/2-1,NC_Base_L/2])
			rotate([-90,0,0]){ cylinder(d=Rivet_d, h=10); 
			translate([0,0,3.2]) cylinder(d=Rivet_d*2, h=6);}
		
		// Center hole
		translate([0,0,-6]) cylinder(d=Spring_OD-6, h=Tube_Z+30);
		
		// Spring
		translate([0,0,SpringEnd_Z]) rotate([180,0,0]) {
			cylinder(d=Spring_OD, h=30);
			translate([0,0,4]) cylinder(d1=Spring_OD, d2=SpringSplice_OD, h=8);
			translate([0,0,12-Overlap]) cylinder(d=SpringSplice_OD, h=30);
			}
		
		// Tube hole
		translate([0,0,Tube_Z]) rotate([0,90,0]) cylinder(d=Tube_d, h=Tube_OD, center=true);
		
		// Retention cord
		for (j=[0:nHoles-1]) rotate([0,0,360/nHoles*j]) translate([0,Tube_ID/2-8,-10]) cylinder(d=4, h=30);
		
		//if ($preview) cube([50,50,50]);
		
		//cube([100,100,100]);
	} // difference
	
} // NC_ShockcordRingDual

//NC_ShockcordRingDual(Tube_OD=BT137Body_OD, Tube_ID=BT137Body_ID, NC_Base_L=25, nRivets=6);
//NC_ShockcordRingDual(Tube_OD=BT98Body_OD, Tube_ID=BT98Body_ID, NC_Base_L=15, nRivets=3, nBolts=3);
//NC_ShockcordRingDual(Tube_OD=Body_OD+Vinyl_t, Tube_ID=Body_ID, NC_Base_L=NC_Base_L);

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

module BluntConeNoseCone(ID=54, OD=58, L=160, Base_L=10, Tip_R=5, Wall_T=3, HasRivets=true){
	
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
		
		if (Base_L>12 && HasRivets) translate([0,0,Base_L/2])
			RivetPattern(BT_Dia=OD, nRivets=3, Dia=5/32*25.4);
		
		if ($preview==true) translate([0,-100,-1]) cube([100,100,200]);
	} // difference
	
} // BluntConeNoseCone

//BluntConeNoseCone(ID=PML54Body_ID, OD=PML54Body_OD, L=120, Base_L=5, Tip_R=7, Wall_T=2.2);
//BluntConeNoseCone();
/*
Fairing55_OD=5.5*25.4;
BluntConeNoseCone(ID=Fairing55_OD-4.4, OD=Fairing55_OD, L=190, Base_L=15, Tip_R=7, Wall_T=2.2, HasRivets=false);
/**/


module ElipticalShape(L=100, D=50, Base_L=2){
	// tangent ogive
	R=D/2;
	p=L/R;
	
	translate([0,Base_L,0])
	difference(){
		intersection(){
			square([R,L]);
			scale([1,p,1]) circle(r=R,$fn=$preview? 90:360);
		} // intersection
		
		translate([-100,-Overlap,0]) square([100,L+Overlap*2]);
	} // difference
	if (Base_L>0) square([R,Base_L+Overlap]);
} // ElipticalShape

//rotate_extrude() ElipticalShape(Base_L=0);

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
	if (Base_L>0) square([R,Base_L+Overlap]);
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

/*
module BluntSecantOgiveShape(L=150, D=50, Base_L=10, Tip_R=5, Thickness=0){
	
	Xtra_p=D/10;
	R=D/2;
	p=(R*R+L*L)/(2*R)+Xtra_p;
	X0 = L-sqrt((p-Tip_R)*(p-Tip_R)-(p-R)*(p-R));
	
	translate([0,Base_L,0])
	difference(){
		hull(){
			difference(){
				intersection(){
					square([R,L]);
					translate([-p+R, 0, 0]) circle(r=p-Thickness, $fn=$preview? 90:720);
				} // intersection
				
				translate([0, L-X0, 0]) square([D, D]);
			} // difference
			
			translate([0,L-X0, 0]) circle(r=Tip_R-Thickness, $fn=$preview? 90:720);
		} // hull
	
		translate([-D, -Overlap, 0]) square([D, L+Overlap*2]);
	} // difference
	
	if (Thickness==0)
		square([R,Base_L+Overlap]);
} // BluntSecantOgiveShape

BluntSecantOgiveShape(L=190, D=BT98Body_OD, Base_L=15, Tip_R=8, Thickness=0);
/**/

module BluntOgiveShape(L=150, D=50, Base_L=10, Tip_R=5, Thickness=0){
	// Spherically blunted tangent ogive
	R=D/2;
	p=(R*R+L*L)/(2*R);
	X0 = L-sqrt((p-Tip_R)*(p-Tip_R)-(p-R)*(p-R));
	
	translate([0,Base_L,0])
	difference(){
		hull(){
			
			difference(){
				intersection(){
					square([R,L]); // keep first quadrant only
					translate([-p+R, 0, 0]) circle(r=p-Thickness, $fn=$preview? 180:720);
				} // intersection
				
				translate([0, L-X0, 0]) square([D, D]);
			} // difference
			
			// Tip
			translate([0, L-X0, 0]) circle(r=Tip_R-Thickness, $fn=$preview? 180:720);
		} // hull
	
		translate([-D, -Overlap, 0]) square([D, L+Overlap*2]);
	} // difference
	
	if (Thickness==0)
		square([R,Base_L+Overlap]);
} // BluntOgiveShape

//rotate_extrude() 
//offset(-3) BluntOgiveShape(L=190, D=137, Base_L=1, Tip_R=15);

module BluntOgiveNoseCone(ID=54, OD=58, L=160, Base_L=10, nRivets=3, Tip_R=5, Wall_T=3, Cut_Z=0, Transition_OD=58, LowerPortion=false){

	R=OD/2;
	p=(R*R+L*L)/(2*R);
	X0 = L-sqrt((p-Tip_R)*(p-Tip_R)-(p-R)*(p-R));
	
	difference(){
		rotate_extrude($fn=$preview? 90:720) difference(){
			BluntOgiveShape(L=L, D=OD, Base_L=Base_L, Tip_R=Tip_R);
			
			// Remove inside
			BluntOgiveShape(L=L, D=OD, Base_L=Base_L, Tip_R=Tip_R, Thickness=Wall_T);
		} // difference
		
		// Make Skirt fit coupler tube
		translate([0,0,-Overlap]) cylinder(d=ID, h=Base_L+Overlap*2, $fn=$preview? 90:720);
		// Taper so no support is needed
		translate([0,0,Base_L]) cylinder(d1=ID, d2=OD-Wall_T*2, h=Wall_T, $fn=$preview? 90:720);
		
		if (Base_L>12 && nRivets>0) translate([0,0,Base_L/2])
			RivetPattern(BT_Dia=OD, nRivets=nRivets, Dia=5/32*25.4);
		
		if ($preview==true) translate([0,-OD/2-1,-1]) cube([OD/2+1,OD/2+1,L+2]);
			
		if (Cut_Z!=0 && LowerPortion==false)
			translate([0,0, -Overlap]) cylinder(d=OD+1, h=Cut_Z+Overlap, $fn=90);
		
		if (Cut_Z!=0 && LowerPortion)
			translate([0,0,Cut_Z]) cylinder(d=OD+1, h=Base_L+L-Cut_Z+Overlap);
		
	} // difference
	
	if (Cut_Z!=0 && LowerPortion)
		difference(){
			union(){
				// gluing flange
				rotate_extrude($fn=$preview? 90:360) 
					offset(-Wall_T-IDXtra) // did IDXtra*2, too much, IDXtra/2=too big
						BluntOgiveShape(L=L, D=OD, Base_L=Base_L, Tip_R=Tip_R);
					
				// connect outer shell to gluing flange	
				intersection(){
					translate([0,0,Cut_Z-7]) cylinder(d=OD, h=12, $fn=$preview? 90:360);
					rotate_extrude($fn=$preview? 90:360) 
						offset(-1) BluntOgiveShape(L=L, D=OD, Base_L=Base_L, Tip_R=Tip_R);
				}
			} // union
			
			// Remove lower part
			translate([0,0, -Overlap]) cylinder(d=OD+1, h=Cut_Z-5);
			// Remove upper part
			translate([0,0,Cut_Z+5]) cylinder(d=OD+1, h=L-Cut_Z+Overlap);
			// Clean up inside
			translate([0,0,Cut_Z-6]) cylinder(d=OD/2, h=12);
			
			// this needs fixed, should be calculated, 
			//Transition_OD=OD*0.7-Wall_T*2+16; // works for 102mm OD x 350mm L Cut @180mm
			//Transition_OD=OD*((Cut_Z-Base_L)/(L-Base_L));
			translate([0,0,Cut_Z-7]) 
				cylinder(d1=Transition_OD, d2=Transition_OD-12, h=8, $fn=$preview? 90:360);
			
			rotate_extrude($fn=$preview? 90:360) 
				offset(-Wall_T-2.2-IDXtra*2) BluntOgiveShape(L=L, D=OD, Base_L=Base_L, Tip_R=Tip_R);
			
			if ($preview==true) translate([0,-OD/2-1,-1]) cube([OD/2+2,OD/2+2,L+2]);
		} // difference
	
} // BluntOgiveNoseCone

//BluntOgiveNoseCone(ID=BT75Coupler_OD, OD=BT75Body_OD, L=220, Base_L=13, Tip_R=7, Wall_T=1.8, Cut_Z=0, LowerPortion=false);

//BluntOgiveNoseCone(ID=BT75Coupler_OD, OD=BT75Body_OD, L=220, Base_L=13, Tip_R=6, Wall_T=1.8, Cut_Z=120, Transition_OD=BT75Body_OD-17, LowerPortion=true);

//BluntOgiveNoseCone(ID=BT54Coupler_OD, OD=BT54Body_OD, L=190, 	Base_L=20, Tip_R=10, Wall_T=2.2, Cut_Z=0, LowerPortion=false);
/*
BluntOgiveNoseCone(ID=BT137Body_ID, 
					OD=PML98Body_OD,
					Base_L=5,
					L=400, 
					Wall_T=7,
					Tip_R=16,
					Cut_Z=190, LowerPortion=true);
/**/

/*
BluntOgiveNoseCone(ID=PML98Body_ID, 
					OD=PML98Body_OD,
					L=350, 
					Wall_T=2.2,
					Tip_R=5,
					Cut_Z=180, LowerPortion=true);
/**/
//BluntOgiveNoseCone(ID=PML98Body_ID, OD=PML98Body_OD, L=180, Base_L=21, Tip_R=23, Wall_T=3);

//BluntOgiveNoseCone(ID=PML75Body_ID, OD=PML75Body_OD, L=180, Base_L=21, Tip_R=10, Wall_T=2.2);
//BluntOgiveNoseCone(ID=PML75Body_ID, OD=PML75Body_OD, L=280, Base_L=5, Tip_R=5, Wall_T=2.2, 
//		Cut_Z=150, LowerPortion=true);

//BluntOgiveNoseCone(ID=PML54Body_ID, OD=PML54Body_OD, L=160, Base_L=10, Tip_R=7, Wall_T=3);

module Splice_BONC(OD=58, H=10, L=160, Base_L=5, Tip_R=5, Wall_T=2.2, Cut_Z=80){
	// Failed print from power outage? Print this and the missing top protion.
	difference(){
		rotate_extrude($fn=$preview? 90:360) 
			offset(-Wall_T-IDXtra*2) 
				BluntOgiveShape(L=L, D=OD, Base_L=Base_L, Tip_R=Tip_R);
				
		// inside
		rotate_extrude($fn=$preview? 90:360) 
			offset(-Wall_T*2-IDXtra*2) 
				BluntOgiveShape(L=L, D=OD, Base_L=Base_L, Tip_R=Tip_R);
				
		// Remove lower part
			translate([0,0, -Overlap]) cylinder(d=OD+1, h=Cut_Z-H/2);
			
		// Remove upper part
			translate([0,0,Cut_Z+H/2]) cylinder(d=OD+1, h=L-Cut_Z);
			
		// Clean up inside
		translate([0,0,Cut_Z-H/2-1]) cylinder(d=10, h=H+2);
	} // difference
} // Splice_BONC

//Splice_BONC(OD=102, H=12, L=320, Base_L=5, Tip_R=8, Wall_T=2.2, Cut_Z=160);

module Bulkplate_BONC(OD=58, T=10, L=160, Base_L=5, Tip_R=5, Wall_T=2.2, Cut_Z=80){
	
	difference(){
		rotate_extrude($fn=$preview? 90:360) 
			offset(-Wall_T-IDXtra*2) 
				BluntOgiveShape(L=L, D=OD, Base_L=Base_L, Tip_R=Tip_R);
		
		// Remove lower part
		translate([0,0, -Overlap]) cylinder(d=OD+1, h=Cut_Z+5+Overlap);
		// Remove upper part
		translate([0,0,Cut_Z+5+T]) cylinder(d=OD+1, h=L-Cut_Z+Overlap);
		
		translate([0,0,Cut_Z+5+T]) Bolt250Hole(depth=T);
		translate([0,0,Cut_Z+T]) Bolt250NutHole();
	} // diff
	
} // Bulkplate_BONC

//Bulkplate_BONC();

module BluntOgiveWeight(OD=58, L=160, Tip_R=5, Wall_T=3){
	R=OD/2;
	p=(R*R+L*L)/(2*R);
	X0 = L-sqrt((p-Tip_R)*(p-Tip_R)-(p-R)*(p-R));
	
	Weight_d=20;
	
	difference(){
		// inside
		rotate_extrude($fn=$preview? 90:360) 
			offset(-Wall_T) BluntOgiveShape(L=L, D=OD, Base_L=0, Tip_R=Tip_R);
		
		translate([0,0,55+42]) cylinder(d=Weight_d, h=L/2);
		
		translate([0,0,55])
		#for (j=[0:4]) rotate([0,0,360/5*j]) translate([Weight_d*0.9,0,0]) 
			cylinder(d=Weight_d, h=40);
		
		// cut off bottom
		cylinder(d=200,h=55+Overlap);
		
		//cylinder(d=Wall_T*3, h=L-X0+Tip_R-Wall_T*2);
		//translate([0,0,L-X0]) sphere(r=Tip_R-Wall_T,$fn=$preview? 36:360);
		
		if ($preview==true) translate([0,-100,-1]) cube([100,100,200]);
				
	} // difference
	
} // BluntOgiveWeight

//BluntOgiveWeight(OD=PML75Body_OD, L=195, Tip_R=7, Wall_T=2.2);

module NoseconeBase(OD=PML98Body_ID, L=60, NC_Base=21, HasUBolt=true){
	Wall_T=2.2;
	UBolt_X=25.4;
	Base_H=4;
	
	difference(){
		cylinder(d=OD, h=L+NC_Base, $fn=$preview? 90:720);
		
		translate([0,0,Base_H]) cylinder(d=OD-Wall_T*2,h=L+NC_Base, $fn=$preview? 90:720);
		
		if (HasUBolt){
			// ubolt
			translate([-UBolt_X/2,0,Base_H]) Bolt250ClearHole();
			translate([UBolt_X/2,0,Base_H]) Bolt250ClearHole();
		}else{
			translate([0,OD/2-Wall_T-4,-Overlap]) RoundRect(X=16, Y=4, Z=Base_H+1, R=1.5);
			translate([0,-OD/2+Wall_T+4,-Overlap]) RoundRect(X=16, Y=4, Z=Base_H+1, R=1.5);
		}
		
		if (NC_Base>12) translate([0,0,L+NC_Base/2])
			RivetPattern(BT_Dia=OD, nRivets=3, Dia=5/32*25.4);
		
		if ($preview==true) translate([0,-100,-100]) cube([100,100,200]);
	} // difference
} // NoseconeBase

//NoseconeBase(OD=PML54Body_ID, L=60, NC_Base=21, HasUBolt=false);
//translate([0,0,-60]) NoseconeBase(OD=PML75Coupler_OD, L=60, NC_Base=21);


//NoseconeBase(OD=PML75Body_ID, L=60, NC_Base=21);


module FairingTest(){
	NC_OD=200;
	NC_ID=NC_OD-28;
	NC_Len=200;
	NC_Tip_r=20;
	NC_Wall_T=(NC_OD-NC_ID)/2;

	R=NC_OD/2;
	p=(R*R+NC_Len*NC_Len)/(2*R);
	X0 = NC_Len-sqrt((p-NC_Tip_r)*(p-NC_Tip_r)-(p-R)*(p-R));
	
	//translate([0,0,1+NC_Len-X0]) sphere(r=NC_Tip_r);
	
	difference(){
		BluntOgiveNoseCone(ID=NC_ID, OD=NC_OD, L=NC_Len, Base_L=1, 
			Tip_R=NC_Tip_r, Wall_T=NC_Wall_T, Cut_Z=0, Transition_OD=58, LowerPortion=false);
			
		translate([0,-NC_OD/2-1,-Overlap]) cube([NC_OD/2+1,NC_OD+2,NC_Len]);
		
		
		
		// Slot
		difference(){
			union(){
				difference(){
					translate([0,-p+R,1]) rotate([0,90,0]) 
						cylinder(r=p-NC_Wall_T/2+1, h=10, center=true, $fn=$preview? 90:360); 
					
					translate([0,-p+R,1]) rotate([0,90,0]) 
						cylinder(r=p-NC_Wall_T/2-1, h=10+Overlap, center=true, $fn=$preview? 90:360); 
				} // difference
				
				for (j=[0:90]) translate([-6,-p+R,1]) hull(){
					rotate([j,0,0]) translate([0,p-NC_Wall_T/2,1]) sphere(d=8);
					rotate([j+1,0,0]) translate([0,p-NC_Wall_T/2,1]) sphere(d=8);
					}
			} // union
			
			
			translate([-25,5,0]) rotate([90,0,0]) cube([50,NC_Len,NC_Len]);
		} // difference
	} // difference
		
		
} // FairingTest

//FairingTest();

















