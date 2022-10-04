// ***********************************
// Project: 3D Printed Rocket
// Filename: Fins.scad
// Created: 6/11/2022 
// Revision: 0.9.5  8/31/2022
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  ***** History *****
//
echo("Fins 0.9.5");
// 0.9.5  8/31/2022 Added TipOffset to TrapFin2.
// 0.9.4  8/27/2022 TrapFin2 and Co. 
// 0.9.3  6/30/2022 Worked on Fillet
// 0.9.2  6/27/2022 Added Fin2.
// 0.9.1  6/14/2022 Added TrapFin.
// 0.9.0  6/11/2022 First code.
//
// ***********************************
//  ***** for STL output *****
//
// Fin(Root_L=150, Root_W=5, Tip_W=2.5, Span=70, Chamfer_a=15);
// Fin(Root_L=200, Root_W=6, Tip_W=2.5, Span=90, Chamfer_a=15);
//
// Fin2(Root_L=150, Root_W=5.5, Tip_W=3.5, Span=70, Chamfer=10);
//
// TrapFin2(Post_h=10, Root_L=180, Tip_L=120, Root_W=10, Tip_W=5.0, Span=120, Chamfer_L=18);
//
// ***********************************
//  ***** Routines *****
//
// Chamfer(Len=200, Flat=0.5, Chamfer_a=10);
//
// Fin(Root_L=150, Root_W=5, Tip_W=2.5, Span=70, Chamfer_a=15);
// Fin2(Root_L=150, Root_W=5, Tip_W=2.5, Chamfer=10);
//
// TrapFin2Tail(Post_h=5, Root_L=150, Root_W=10, Chamfer_L=18);
// TrapFin2Slots(Tube_OD=PML98Body_OD, nFins=5, Post_h=10, Root_L=180, Root_W=10, Chamfer_L=18);
// TrapFin2Shape(Post_h=5, Root_L=150, Tip_L=100, Root_W=10, Tip_W=4.0, Span=100, Chamfer_L=18);
// 
//
// Fillet(Tube_OD=50, Len=50, W=4);
//
// ***********************************

include<TubesLib.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

module Chamfer(Len=200, Flat=0.5, Chamfer_a=10){
	translate([-10,0,0]) cube([20,200,Len]);
	translate([Flat/2,Overlap,0]) rotate([0,0,Chamfer_a]) 
		mirror([0,1,0]) cube([20,200,Len]);
	mirror([1,0,0]) translate([Flat/2,Overlap,0]) 
		rotate([0,0,Chamfer_a]) mirror([0,1,0]) cube([20,200,Len]);
} // Chamfer

//Chamfer();

module Fin(Root_L=150, Root_W=5, Tip_W=2.5, Span=70, Chamfer_a=15){
	C_a=Chamfer_a;
	A1=30;
	A2=-15;
	A3=-75;
	
	difference(){
		hull(){
			translate([-Root_W/2,0,0]) cube([Root_W,Overlap,Root_L]);
			translate([-Tip_W/2,Span-Overlap,0]) cube([Tip_W,Overlap,Root_L]);
		} // hull
		
		translate([0,0,Root_L]) rotate([A1,0,0]) mirror([0,0,1]) 
			Chamfer(Len=200, Flat=0.5, Chamfer_a=C_a);
		
		translate([0,Span,Root_L/4]) rotate([A2,0,0]) mirror([0,0,1]) 
			Chamfer(Len=200, Flat=0.5, Chamfer_a=C_a);
		
		rotate([A3,0,0]) Chamfer(Len=200, Flat=0.5, Chamfer_a=C_a);
	} // difference
} // Fin

//Fin(Root_L=150, Root_W=5, Tip_W=2.5, Span=70, Chamfer_a=15);
//Fin(Root_L=200, Root_W=6, Tip_W=2.5, Span=90, Chamfer_a=15);

module Fin2(Root_L=150, Root_W=5, Tip_W=2.5, Chamfer=10){
	A1=30;
	A2=15;
	RootEmbed=2;
	
	module Edge(){
		sphere(d=1, $fn=24);
	}
	module Tip(){
		sphere(d=Tip_W, $fn=36);
	}
	module Root(){
		sphere(d=Root_W, $fn=90);
	}
	
	hull(){
		Edge();
		translate([0,-RootEmbed,0]) Edge();
		translate([0,0,Chamfer+Root_W]) Root();
		translate([0,-RootEmbed,Chamfer+Root_W]) Root();
		translate([0,0,Root_L-Chamfer-Root_W]) Root();
		translate([0,-RootEmbed,Root_L-Chamfer-Root_W]) Root();
		translate([0,0,Root_L]) Edge();
		translate([0,-RootEmbed,Root_L]) Edge();
		
		translate([0,0,Root_L]) rotate([A1,0,0]) translate([0,0,-Root_L*0.9]){
			Edge();
			rotate([90-A2,0,0]) translate([0,0,Chamfer]) Tip();
			
			rotate([-A2-A1,0,0]) translate([0,0,-Root_L/6]){
				Edge();
				rotate([90-A1,0,0]) translate([0,0,Chamfer]) Tip();
			}
		}
	} // hull
} // Fin2

//Fin2(Root_L=150, Root_W=5.5, Tip_W=3.5, Chamfer=10);

// *************************************************************************

module TrapFin2Tail(Post_h=5, Root_L=150, Root_W=10, Chamfer_L=18){
	Edge_r=1;
	
	hull(){
		translate([-Root_L/2+Edge_r,0,0]) cylinder(r=Edge_r+IDXtra*2, h=Post_h);
		translate([-Root_L/2+Chamfer_L,0,0]) cylinder(d=Root_W+IDXtra*2, h=Post_h);
		translate([Root_L/2-Chamfer_L,0,0]) cylinder(d=Root_W+IDXtra*2, h=Post_h);
		translate([Root_L/2-Edge_r,0,0]) cylinder(r=Edge_r+IDXtra*2, h=Post_h);
	} // hull
} // TrapFin2Tail

//TrapFin2Tail(Post_h=10, Root_L=180, Root_W=10, Chamfer_L=18);

module TrapFin2Slots(Tube_OD=PML98Body_OD, nFins=5, Post_h=10, Root_L=180, Root_W=10, Chamfer_L=18){
	
	for (j=[0:nFins]) rotate([0,0,360/nFins*j]) translate([Tube_OD/2-Post_h,0,0])
		rotate([0,90,0]) TrapFin2Tail(Post_h=Post_h, Root_L=Root_L, Root_W=Root_W, Chamfer_L=Chamfer_L);
		
} // TrapFin2Slots

// TrapFin2Slots();

module TrapFin2Shape(Post_h=5, Root_L=150, Tip_L=100, Root_W=10, Tip_W=4.0, Span=100, Chamfer_L=18,
						TipOffset=0){
	Edge_r=1;
	Tip_Chamfer=Chamfer_L-(Root_W-Tip_W);
	
	hull(){
		translate([-Root_L/2+Edge_r,0,0]) cylinder(r=Edge_r, h=Post_h);
		translate([-Root_L/2+Chamfer_L,0,0]) cylinder(d=Root_W, h=Post_h);
		translate([Root_L/2-Chamfer_L,0,0]) cylinder(d=Root_W, h=Post_h);
		translate([Root_L/2-Edge_r,0,0]) cylinder(r=Edge_r, h=Post_h);
		
		translate([-Tip_L/2+Edge_r+TipOffset,0,Span-Chamfer_L]) cylinder(r=Edge_r, h=Overlap);
		translate([-Tip_L/2+Tip_Chamfer+TipOffset,0,Span-Tip_Chamfer]) cylinder(d=Tip_W, h=Overlap);
		translate([Tip_L/2-Tip_Chamfer+TipOffset,0,Span-Tip_Chamfer]) cylinder(d=Tip_W, h=Overlap);
		translate([Tip_L/2-Edge_r+TipOffset,0,Span-Chamfer_L]) cylinder(r=Edge_r, h=Overlap);
		
		translate([-Tip_L/2+Edge_r+TipOffset,0,Span-Edge_r]) sphere(r=Edge_r);
		translate([Tip_L/2-Edge_r+TipOffset,0,Span-Edge_r]) sphere(r=Edge_r);
		} // hull
} // TrapFin2Shape

module CutZone(X_Offset=0, Y=10, Z=100){
	Cut_r=1;
	
	hull(){
		translate([X_Offset-Cut_r,0,-Overlap]) cylinder(r=Cut_r*3, h=Z+Overlap*2);
		translate([X_Offset+Y-Cut_r*2,Y-Cut_r,-Overlap]) cylinder(r=Cut_r*3, h=Z+Overlap*2);
	} // hull
		
	hull(){
		translate([X_Offset-Cut_r,0,-Overlap]) cylinder(r=Cut_r*3, h=Z+Overlap*2);
		translate([X_Offset+Y-Cut_r*2,-Y+Cut_r,-Overlap]) cylinder(r=Cut_r*3, h=Z+Overlap*2);
	} // hull
} // CutZone

//CutZone(X_Offset=0, Y=10, Z=100);

module BisectFin(X_Offset=0, X1=100, Y=10, Z=100, KeepNegXHalf=false){
	Cut_r=1;
	
	module Wedge(R=Cut_r, X1=X1, Y=Y, Z=Z){
		hull(){
			translate([Y-R,Y-R,-Overlap]) cylinder(r=R, h=Z+Overlap*2);
			translate([0,0,-Overlap]) cylinder(r=R, h=Z+Overlap*2);
			translate([Y-R,-Y+R,-Overlap]) cylinder(r=R, h=Z+Overlap*2);
			translate([X1-Overlap,-Y,-Overlap]) cube([Overlap,Y*2,Z+Overlap*2]);
		} // hull
	} // Wedge
		
	if (KeepNegXHalf){
		translate([X_Offset,0,0]) Wedge(R=Cut_r, X1=X1, Y=Y, Z=Z);
	}else{
		difference(){
			translate([X_Offset-X1,-Y,-Overlap]) cube([X1+Y, Y*2, Z+Overlap*2]);
			translate([X_Offset,0,-Overlap]) Wedge(R=Cut_r+IDXtra, X1=X1+Overlap, Y=Y+Overlap, Z=Z+Overlap*2);
		} // difference
	}
} // BisectFin

//BisectFin(X_Offset=0, X1=100, Y=10, Z=100, KeepNegXHalf=false);
//BisectFin(X_Offset=0, X1=100, Y=10, Z=100, KeepNegXHalf=true);

module TrapFin2(Post_h=5, Root_L=150, Tip_L=100, Root_W=10, Tip_W=4.0, Span=100, Chamfer_L=18,
				TipOffset=0,
				Bisect=false, Bisect_X=0){
	Rib_Spacing=20;
	Perimeter=0.8;
	Rib_a=40; // 45 worked well
	Rib_Slot_w=0.1;
	
	difference(){
		TrapFin2Shape(Post_h=Post_h, Root_L=Root_L, Tip_L=Tip_L, 
						Root_W=Root_W, Tip_W=Tip_W, Span=Span, Chamfer_L=Chamfer_L,
						TipOffset=TipOffset);
		
		difference(){
			union(){
				for (j=[0:Root_L/Rib_Spacing*2])
					translate([-Root_L+j*Rib_Spacing,-Root_W,-Overlap]) 
						rotate([0,Rib_a,0]) cube([Rib_Slot_w,Root_W*2,Span*2]);
				for (j=[0:Root_L/Rib_Spacing*2])
					translate([-Root_L+j*Rib_Spacing,-Root_W,-Overlap]) 
						rotate([0,-Rib_a,0]) cube([Rib_Slot_w,Root_W*2,Span*2]);
			} // union
			
			translate([-Root_L-Overlap,-Perimeter,-1]) cube([Root_L*2+Overlap*2, Perimeter*2, Span*2]);
			if (Bisect)
				translate([Bisect_X,0,-1])	CutZone(X_Offset=0, Y=Root_W, Z=Span*2+2);
		} // difference
	} // difference
} // TrapFin2

//TrapFin2(Post_h=10, Root_L=180, Tip_L=120, Root_W=10, Tip_W=5.0, Span=120, Chamfer_L=18);
//TrapFin2(Post_h=10, Root_L=240, Tip_L=150, Root_W=14, Tip_W=8.0, Span=180, Chamfer_L=24, TipOffset=0, Bisect=false, Bisect_X=0);

//TrapFin2(Post_h=10, Root_L=240, Tip_L=50, Root_W=12, Tip_W=7.0, Span=150, Chamfer_L=24, TipOffset=60);

// Too big to print in one piece
module TooBigFin(KeepNegXHalf=false){
	
	if (KeepNegXHalf){
		translate([-200+10,0,0]) cylinder(d=14*2.5, h=0.9); // Neg
		cylinder(d=14*2.5, h=0.9); // Neg Center
	}else{
		translate([200-5,0,0]) cylinder(d=14*2, h=0.9); // Pos
		translate([5,0,0]) cylinder(d=14*2, h=0.9); // Pos Center
	}

	difference(){
		TrapFin2(Post_h=10, Root_L=400, Tip_L=80, Root_W=14, Tip_W=7.0, Span=180, Chamfer_L=34, TipOffset=60,
					Bisect=true, Bisect_X=0);
		

		BisectFin(X_Offset=0, X1=220, Y=10, Z=200, KeepNegXHalf=KeepNegXHalf);
	} // difference
} // TooBigFin

//TooBigFin(KeepNegXHalf=false);
//TooBigFin(KeepNegXHalf=true);

// **********************************************************************************


module Fillet(Tube_OD=50, Len=50, W=4){
	difference(){
		hull(){
			translate([0,Tube_OD/2,W/2]) sphere(d=W);
			translate([0,Tube_OD/2-W/2,W/2]) sphere(d=W);
			
			translate([0,Tube_OD/2,Len-W/2]) sphere(d=W);
			translate([0,Tube_OD/2-W/2,Len-W/2]) sphere(d=W);
			
			translate([0,Tube_OD/2+W*0.40,W]) rotate([0,0,-30]) 
				cylinder(d=W*2*1.4, h=Len-W*2, $fn=3);
		} // hull
		
		// Tube
		translate([0,0,-Overlap]) 
			cylinder(d=Tube_OD-Overlap, h=Len+Overlap*2, $fn=$preview? 60:180);
		
		Fillet_r=W*0.7;
		Fillet_a=asin((Fillet_r+W/2)/(Tube_OD/2+Fillet_r));
		
		rotate([0,0,Fillet_a]) translate([0,Tube_OD/2+Fillet_r,-Overlap])
			cylinder(r=Fillet_r, h=Len+Overlap*2);
		rotate([0,0,-Fillet_a]) translate([0,Tube_OD/2+Fillet_r,-Overlap])
			cylinder(r=Fillet_r+Overlap, h=Len+Overlap*2);
		
		rotate([0,0,Fillet_a]) translate([-W,Tube_OD/2+Fillet_r,-Overlap])
			cube([W*2.5,W*2,Len+Overlap*2]);
		rotate([0,0,-Fillet_a]) translate([-W*1.5,Tube_OD/2+Fillet_r,-Overlap])
			cube([W*2,W*2,Len+Overlap*2]);
	} // difference
	
	//if ($preview==true) translate([0,Tube_OD/2,Len/2]) cube([W,20,Len],center=true);
} // Fillet

//Fillet(Tube_OD=50, Len=50, W=4);
//cylinder(d=50, h=100, $fn=$preview? 60:180);

//Fillet(Tube_OD=98, Len=50, W=10);
//cylinder(d=98, h=100, $fn=$preview? 60:180);
















