// ***********************************
// Project: 3D Printed Rocket
// Filename: DoorLib.scad
// by David M. Flynn
// Created: 4/29/2023 
// Revision: 1.0.1  6/21/2023
// Units: mm
// ***********************************
//  ***** Notes *****
//
// Routines for making doors.
//
//  ***** History *****
//
echo("DoorLib 1.0.1");
//
// 1.0.1  6/21/2023   Changed door frame.
// 1.0.0  5/7/2023    Tested doors made with this library.
// 0.9.1  4/29/2023   Bolt holes are optional.
// 0.9.0  4/29/2023   First code. New door design.
//
// ***********************************
//  ***** for STL output *****
//
// rotate([-90,0,0]) Door(Door_X=30, Door_Y=50, Door_t=3, Tube_OD=PML98Body_OD, HasSixBolts=true);
//
// ***********************************
//  ***** Routines *****
//
// DoorHole(Door_X=30, Door_Y=50, Door_t=3, Tube_OD=PML98Body_OD);
// DoorFrameHole(Door_X=30, Door_Y=50, Door_t=3, Tube_OD=PML98Body_OD);
// DoorFrame(Door_X=30, Door_Y=50, Door_t=3, Tube_OD=PML98Body_OD, HasSixBolts=true, HasBoltBosses=true);
// DoorBoltPattern(Door_X=30, Door_Y=50, Tube_OD=PML98Body_OD, HasSixBolts=true) Bolt4Hole();
// Door(Door_X=30, Door_Y=50, Door_t=3, Tube_OD=PML98Body_OD, HasSixBolts=true, HasBoltHoles=true);
//
// ***********************************
//  ***** for Viewing *****
//
/*
	difference(){
		translate([0,0,-75]) Tube(OD=PML98Body_OD, ID=PML98Body_ID, Len=150, myfn=$preview? 90:360);
		DoorFrameHole();
	} // difference
	DoorFrame();
/**/
//
// Door();
// 
// ***********************************

include<TubesLib.scad>
include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2; 
$fn=$preview? 24:90;

Bolt4Inset=4;

function Calc_a(Dist=1,D=2)=Dist/(D*PI)*360; // angle of a distance allong a circle w/ diameter D
function DoorEdge_a(Door_X=30, Tube_OD=PML98Body_OD)=asin((Door_X/2)/(Tube_OD/2)); // angle to edge of door
function DoorBolt_a(Door_X=30, Tube_OD=PML98Body_OD)=asin((Door_X/2)/(Tube_OD/2))-asin(Bolt4Inset/(Tube_OD/2));

module DoorHole(Door_X=30, Door_Y=50, Door_t=3, Tube_OD=PML98Body_OD){
	// A hole 1mm larger than the door.
	
	DY=Door_Y+1;
	DX=Door_X+1;
	DR=4+0.5; // Door corner Radius
	
	D_Edge_a=(Door_X<Tube_OD)? DoorEdge_a(Door_X=Door_X, Tube_OD=Tube_OD):90;
	
	difference(){
		hull(){
			rotate([0,0,D_Edge_a]) translate([0,-Tube_OD/2,0])
				rotate([90,0,0]) translate([-Door_X/2+DR,0,-10]) RoundRect(X=DX-DR*2, Y=DY, Z=20, R=DR);
			rotate([0,0,-D_Edge_a]) translate([0,-Tube_OD/2,0])
				rotate([90,0,0]) translate([Door_X/2-DR,0,-10]) RoundRect(X=DX-DR*2, Y=DY, Z=20, R=DR);
			translate([0,-Tube_OD/2,0])
				rotate([90,0,0]) translate([0,0,-10]) RoundRect(X=DX-DR*2, Y=DY, Z=20, R=DR);
			
		} // hull
		
		// Inside
		translate([0,0,-DY/2-Overlap]) 
			cylinder(d=Tube_OD-Door_t*2-IDXtra, h=DY+Overlap*2, $fn=$preview? 90:360);
		
		// Outside
		difference(){
			translate([0,0,-DY/2-Overlap]) 
				cylinder(d=Tube_OD*2, h=DY+Overlap*2);
			translate([0,0,-DY/2-Overlap]) 
				cylinder(d=Tube_OD+Door_t*2+1, h=DY+Overlap*2, $fn=$preview? 90:360);
		} // difference
	} // difference

} // DoorHole

// DoorHole(Door_X=30, Door_Y=50, Door_t=3, Tube_OD=PML98Body_OD);
//DoorHole(Door_X=67, Door_Y=111.5, Door_t=1, Tube_OD=64.8);

module DoorFrameHole(Door_X=30, Door_Y=50, Door_t=3, Tube_OD=PML98Body_OD){
	DoorHole(Door_X=Door_X, Door_Y=Door_Y, Door_t=Door_t+1, Tube_OD=Tube_OD);
} // DoorFrameHole

// DoorFrameHole();

module DoorFrameEdge(Door_X=30, Door_Y=50, Door_t=3, Tube_OD=PML98Body_OD, BorderXtra=1){
	// A hole 1mm larger than the door.
	
	DY=Door_Y+BorderXtra;
	DX=Door_X;
	DR=4+0.5; // Door corner Radius
	
	D_Edge_a=(Door_X<Tube_OD)? DoorEdge_a(Door_X=Door_X, Tube_OD=Tube_OD)+Calc_a(Dist=BorderXtra/2,D=Tube_OD)
				:90+Calc_a(Dist=BorderXtra/2,D=Tube_OD);
	
	difference(){
		hull(){
			rotate([0,0,D_Edge_a]) translate([0,-Tube_OD/2,0])
				rotate([90,0,0]) translate([-Door_X/2+DR,0,-10]) RoundRect(X=DX-DR*2, Y=DY, Z=20, R=DR);
			rotate([0,0,-D_Edge_a]) translate([0,-Tube_OD/2,0])
				rotate([90,0,0]) translate([Door_X/2-DR,0,-10]) RoundRect(X=DX-DR*2, Y=DY, Z=20, R=DR);
			translate([0,-Tube_OD/2,0])
				rotate([90,0,0]) translate([0,0,-10]) RoundRect(X=DX-DR*2, Y=DY, Z=20, R=DR);
			
		} // hull
		
		// Inside
		translate([0,0,-DY/2-Overlap]) 
			cylinder(d=Tube_OD-Door_t*2-IDXtra, h=DY+Overlap*2, $fn=$preview? 90:360);
		
		// Outside
		difference(){
			translate([0,0,-DY/2-Overlap]) 
				cylinder(d=Tube_OD*2, h=DY+Overlap*2);
			translate([0,0,-DY/2-Overlap]) 
				cylinder(d=Tube_OD, h=DY+Overlap*2, $fn=$preview? 90:360);
		} // difference
	} // difference

} // DoorFrameEdge

module DoorFrame(Door_X=30, Door_Y=50, Door_t=3, Tube_OD=PML98Body_OD, HasSixBolts=true, HasBoltBosses=true){
	DY=Door_Y;
	DX=Door_X;
	DR=4+2;
	BoltBoss_t=2.2;
	Sill_t=1.5;
	
	module Flanges(){
		rotate([0,0,DoorBolt_a(Door_X=Door_X, Tube_OD=Tube_OD)]) translate([0,-Tube_OD/2,0]) { 
			hull(){
				translate([0,0,Door_Y/2-4]) rotate([-90,0,0]) cylinder(r=Bolt4Inset, h=Door_t+BoltBoss_t);
				translate([4,2,Door_Y/2-4]) rotate([-90,0,0]) cylinder(r=Bolt4Inset, h=Door_t-1);
				translate([0,2,Door_Y/2]) rotate([-90,0,0]) cylinder(r=Bolt4Inset, h=Door_t-1);
			}
			hull(){
				translate([0,0,-Door_Y/2+4]) rotate([-90,0,0]) cylinder(r=Bolt4Inset, h=Door_t+BoltBoss_t);
				translate([4,2,-Door_Y/2+4]) rotate([-90,0,0]) cylinder(r=Bolt4Inset, h=Door_t-1);
				translate([0,2,-Door_Y/2]) rotate([-90,0,0]) cylinder(r=Bolt4Inset, h=Door_t-1);
			}
			if (HasSixBolts) hull(){
				rotate([-90,0,0]) cylinder(r=Bolt4Inset, h=Door_t+BoltBoss_t);
				translate([4,2,0]) rotate([-90,0,0]) cylinder(r=Bolt4Inset+1, h=Door_t-1);
			}
		}
	} // Flanges
	
	difference(){
		union(){
			hull(){
				difference(){
					DoorFrameEdge(Door_X=DX, Door_Y=DY, Door_t=1, 
									Tube_OD=Tube_OD, BorderXtra=14);
					translate([0,-Tube_OD/2-1,-DY/2-10]) cube([Tube_OD,Tube_OD,DY+20]);		
				} // difference
				
				DoorFrameEdge(Door_X=DX, Door_Y=DY, Door_t=Door_t+Sill_t, 
								Tube_OD=Tube_OD, BorderXtra=8);
			} // hull
			
			hull(){
				difference(){
					DoorFrameEdge(Door_X=DX, Door_Y=DY, Door_t=1, 
									Tube_OD=Tube_OD, BorderXtra=14);
					translate([0,-Tube_OD/2-1,-DY/2-10]) mirror([1,0,0]) cube([Tube_OD,Tube_OD,DY+20]);		
				} // difference
				
				DoorFrameEdge(Door_X=DX, Door_Y=DY, Door_t=Door_t+Sill_t, 
								Tube_OD=Tube_OD, BorderXtra=8);
			} // hull
		} // union
		
		// Shave Top
		translate([0,0,DY/2+3]) cylinder(r1=Tube_OD/2-(Door_t+Sill_t),
										r2=Tube_OD/2, h=5);
		// Shave bottom
		translate([0,0,-DY/2-3-5]) cylinder(r2=Tube_OD/2-(Door_t+Sill_t),
										r1=Tube_OD/2, h=5);
		
		// Inside
		translate([0,0,-DY/2-6]) 
			cylinder(d=Tube_OD-Door_t*2-Sill_t*2, h=DY+12, $fn=$preview? 90:360);
			
		// Outside
		difference(){
			translate([0,0,-DY/2-10]) 
				cylinder(d=Tube_OD*3, h=DY+20);
			translate([0,0,-DY/2-10-Overlap]) 
				cylinder(d=Tube_OD-1, h=DY+20+Overlap*2, $fn=$preview? 90:360);
		} // difference
		
		// Door
		DoorHole(Door_X=Door_X, Door_Y=Door_Y, Door_t=Door_t, Tube_OD=Tube_OD);
		
		// Sill
		DoorHole(Door_X=Door_X-4, Door_Y=Door_Y-4, Door_t=Door_t+3, Tube_OD=Tube_OD);
	} // difference
	
	// Bolt flanges
	if (HasBoltBosses)
	difference(){
		union(){
			Flanges();
			mirror([1,0,0]) Flanges();
		} // union
			
		// Door
		DoorHole(Door_X=Door_X, Door_Y=Door_Y, Door_t=Door_t, Tube_OD=Tube_OD);
		
		// Bolts
		DoorBoltPattern(Door_X=Door_X, Door_Y=Door_Y, Tube_OD=Tube_OD, HasSixBolts=HasSixBolts)
			Bolt4Hole();
			
		// Shave Top
		translate([0,0,DY/2+3]) cylinder(r1=Tube_OD/2-(Door_t+Sill_t),
										r2=Tube_OD/2, h=5);
		// Shave bottom
		translate([0,0,-DY/2-3-5]) cylinder(r2=Tube_OD/2-(Door_t+Sill_t),
										r1=Tube_OD/2, h=5);
		// Outside
		difference(){
			translate([0,0,-DY/2-6]) 
				cylinder(d=Tube_OD*2, h=DY+12);
			translate([0,0,-DY/2-6-Overlap]) 
				cylinder(d=Tube_OD-1, h=DY+12+Overlap*2, $fn=$preview? 90:360);
		} // difference
	} // difference
} // DoorFrame

//DoorFrame();
//DoorFrame(Door_X=53, Door_Y=74, Door_t=3, Tube_OD=LOC65Body_OD, HasSixBolts=false);

/*
difference(){
	translate([0,0,-75]) Tube(OD=PML98Body_OD, ID=PML98Body_ID, Len=150, myfn=$preview? 90:360);
	DoorFrameHole();
} // difference
DoorFrame();
/**/

module DoorBoltPattern(Door_X=30, Door_Y=50, Tube_OD=PML98Body_OD, HasSixBolts=true){
	
	rotate([0,0,DoorBolt_a(Door_X=Door_X, Tube_OD=Tube_OD)]) translate([0,-Tube_OD/2,0]) { 
		translate([0,0,Door_Y/2-4]) rotate([90,0,0]) children();
		translate([0,0,-Door_Y/2+4]) rotate([90,0,0]) children();
		if (HasSixBolts) rotate([90,0,0]) children();}
	
	rotate([0,0,-DoorBolt_a(Door_X=Door_X, Tube_OD=Tube_OD)]) translate([0,-Tube_OD/2,0]) { 
		translate([0,0,Door_Y/2-4]) rotate([90,0,0]) children();
		translate([0,0,-Door_Y/2+4]) rotate([90,0,0]) children();
		if (HasSixBolts) rotate([90,0,0]) children();}
} // DoorBoltPattern

// DoorBoltPattern() Bolt4ButtonHeadHole();

module Door(Door_X=30, Door_Y=50, Door_t=3, Tube_OD=PML98Body_OD, HasSixBolts=true, HasBoltHoles=true){
	DY=Door_Y;
	DX=Door_X;
	DR=4;
	
	difference(){
		hull(){
			rotate([0,0,DoorEdge_a(Door_X=Door_X, Tube_OD=Tube_OD)]) translate([0,-Tube_OD/2,0])
				rotate([90,0,0]) translate([-Door_X/2+DR,0,-10]) RoundRect(X=DX-DR*2, Y=DY, Z=20, R=DR);
			rotate([0,0,-DoorEdge_a(Door_X=Door_X, Tube_OD=Tube_OD)]) translate([0,-Tube_OD/2,0])
				rotate([90,0,0]) translate([Door_X/2-DR,0,-10]) RoundRect(X=DX-DR*2, Y=DY, Z=20, R=DR);
		} // hull
		
		// Inner surface
		translate([0,0,-DY/2-Overlap]) 
			cylinder(d=Tube_OD-Door_t*2, h=DY+Overlap*2, $fn=$preview? 90:360);
		
		// Outer surface
		difference(){
			translate([0,0,-DY/2-Overlap]) 
				cylinder(d=Tube_OD*2, h=DY+Overlap*2);
			translate([0,0,-DY/2-Overlap]) 
				cylinder(d=Tube_OD, h=DY+Overlap*2, $fn=$preview? 90:360);
		} // difference
		
		if (HasBoltHoles)
		DoorBoltPattern(Door_X=Door_X, Door_Y=Door_Y, Tube_OD=Tube_OD, HasSixBolts=HasSixBolts) 
			Bolt4ClearHole();
			
	} // difference
} // Door

// Door();














