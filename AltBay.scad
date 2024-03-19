// ***********************************
// Project: 3D Printed Rocket
// Filename: AltBay.scad
// by David M. Flynn
// Created: 6/23/2022 
// Revision: 0.9.18  9/16/2023
// Units: mm
// ***********************************
//  ***** Notes *****
//
// Altimeter Bay for my MissionControl V3
//
//  ***** History *****
// 0.9.18  9/16/2023  Added DeepHole_t to Alt_BayFrameHole
// 0.9.17  5/21/2023  Fixed frame ridge error.
// 0.9.16  4/29/2023  Now using DoorLib.scad
// 0.9.15 12/11/2022  Adjusted door thickness w/o changing frame or hole. 
// 0.9.14 11/28/2022  Standardized door thickness. 
// 0.9.13 11/9/2022   Made low profile door 2mm not so much. 
// 0.9.12 11/4/2022   Added options to make door bigger. 
// 0.9.11 10/31/2022  Added missing bolt bosses the Alt_BayDoorFrame
// 0.9.10 10/17/2022  Added Alt_BayFrameHole and Alt_BayDoorFrame
// 0.9.9  9/12/2022   Fixes. 
// 0.9.8  9/11/2022   Moved UpperRailButtonPost and Electronics_Bay to here
// 0.9.7  9/6/2022    Fixes to 54mm altimeter bay.
// 0.9.6  9/5/2022    Added 54mm altimeter bay.
// 0.9.5  8/30/2022   Lighter and thinner moved holes down 5mm. 
// 0.9.4  8/28/2022   Added shock cord pass thru option. 
// 0.9.3  6/26/2022   Small fixes
// 0.9.2  6/25/2022   Change Bottom + Body.
// 0.9.1  6/24/2022   Moved rivet stuff to TubesLib. 
// 0.9.0  6/23/2022   First code.
//
// ***********************************
//  ***** for STL output *****
//
// rotate([-90,0,0]) AltDoor54(Tube_OD=PML54Body_OD, IsLoProfile=false, DoorXtra_X=2, DoorXtra_Y=2, ShowAlt=true);
//
// rotate([90,0,0]) AltHolder();
// AltBayBottom(CT_Len=75);
// AltBayBody(BT_Len=95);
// 
// AltBayTop(Len=25); // Overlaps into the nosecone 20mm
// AltBayTop(Len=21.5); // Overlaps into the fairing 16.5mm
// Spacer(Len=46);
// rotate([90,0,0]) BatteryHolder(PlateLen=46);
//
// ***********************************
//  ***** Routines *****
//
//  AltHoles() Bolt4Hole(); // Altimeter mounting holes. 
//  AltDoorHole54(Tube_OD=PML54Body_OD, DoorXtra_Y=0);
//
//  Alt_BayFrameHole(Tube_OD=PML98Body_OD, DoorXtra_X=0, DoorXtra_Y=0, DeepHole_t=0);
//  Alt_BayDoorFrame(Tube_OD=PML98Body_OD, Tube_ID=PML98Body_ID, DoorXtra_X=0, DoorXtra_Y=0, ShowDoor=false);
//
//  AltBay54(Tube_OD=PML54Body_OD, Tube_ID=PML54Body_ID, Tube_Len=136, DoorXtra_X=0, DoorXtra_Y=0, ShowDoor=false);
//  AltDoor54(Tube_OD=PML54Body_OD, IsLoProfile=false, DoorXtra_X=0, DoorXtra_Y=0, ShowAlt=true);
//
//  UpperRailButtonPost(Body_OD=PML54Body_OD, Body_ID=PML54Body_ID, MtrTube_OD=PML38Body_OD, Extend=5);
//  Electronics_Bay(Tube_OD=PML54Body_OD, Tube_ID=PML54Body_ID, Fairing_ID=Fairing_ID, HasCablePuller=true);
//
//  TubeSocket(L=10, Wall_T=1.2, HasBoltGuide=false);
//  ShockCordHole(X=NylonTube9_w, Y=NylonTube9_h, Len=10);
//
// ***********************************
//  ***** for Viewing *****
//
// ShowAltBay();
// AltPCB(); // The altimeter
// 
// ***********************************

include<TubesLib.scad>
use<RailGuide.scad>
use<Fairing54.scad>
use<ChargeHolder.scad>
use<CablePuller.scad>
use<DoorLib.scad>
//include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

	NylonTube9_h=3;
	NylonTube9_w=15;

Alt_X=33.2;
Alt_Y=91.5;
AltPCB_h=1.6;
AltHoles_X=28;
AltHoles_Y=86.35;
AltArmingScrew_Y=19;
AltLED_Y=35;

Alt54Door_Y=Alt_Y+14;
Alt54Door_X=Alt_X+5;
AltDoorThickness=3.7;

Tubing_d=12.7;
nTubes=3;

	NoseConeRivets_h=11.5;
	BT_OD=PML98Body_OD;
	C_OD=PML98Coupler_OD; // Nominal couple tube outside diameter
	C_ID=PML98Coupler_ID; // Nominal couple tube inside diameter
	WallGap=4; // space between tube and wall

module ShowAltBay(){
	//AltBayBottom();

	translate([0,0,75-8]) AltHolder();
	translate([0,-C_ID/2*0.6-1,Alt_Y/2+75]) rotate([90,0,0]) AltPCB();
	translate([0,0,75+95+25])rotate([0,180,0]) AltBayTop(Len=25);

	translate([0,0,20]) BatteryHolder(PlateLen=46);
} // ShowAltBay

//ShowAltBay();

module AltHoles(){
	translate([-AltHoles_X/2, AltHoles_Y/2, 0]) children();
	translate([AltHoles_X/2, AltHoles_Y/2, 0]) children();
	translate([-AltHoles_X/2, -AltHoles_Y/2, 0]) children();
	translate([AltHoles_X/2, -AltHoles_Y/2, 0]) children();
} // AltHoles

// AltHoles() Bolt4Hole();

module AltDoorHole54(Tube_OD=PML54Body_OD, DoorXtra_X=0, DoorXtra_Y=0){
	Door_Y=Alt54Door_Y+DoorXtra_Y;
	Door_X=Alt54Door_X+DoorXtra_X;
	Door_t=AltDoorThickness;
	
	DoorHole(Door_X=Door_X, Door_Y=Door_Y, Door_t=Door_t, Tube_OD=Tube_OD);
	
} // AltDoorHole54

//AltDoorHole54(Tube_OD=PML54Body_OD);


module Alt_DoorBoltPattern(Tube_OD=PML98Body_OD, DoorXtra_Y=0){
	Door_Y=Alt54Door_Y+DoorXtra_Y;
	
	translate([0,-Tube_OD/2,Door_Y/2-4]) rotate([90,0,0]) children();
	translate([0,-Tube_OD/2,-Door_Y/2+4]) rotate([90,0,0]) children();

} // Alt_DoorBoltPattern

//Alt_DoorBoltPattern(Tube_OD=PML98Body_OD) Bolt4Hole();


module Alt_BayFrameHole(Tube_OD=PML98Body_OD, DoorXtra_X=0, DoorXtra_Y=0, DeepHole_t=0){
	
	Door_Y=Alt54Door_Y+DoorXtra_Y;
	Door_X=Alt54Door_X+DoorXtra_X;
	Door_t=AltDoorThickness;
	
	DoorFrameHole(Door_X=Door_X, Door_Y=Door_Y, Door_t=Door_t, Tube_OD=Tube_OD);
	
	if (DeepHole_t>0)
	DoorFrameHole(Door_X=Door_X-6, Door_Y=Door_Y-10, Door_t=DeepHole_t, Tube_OD=Tube_OD);
	
} // Alt_BayFrameHole

//Alt_BayFrameHole();

//
module TestCode1(){
	Alt_DoorXtra_X=6;
	Alt_DoorXtra_Y=4;

	difference(){
		Tube(OD=BT98Body_OD, ID=BT98Body_ID, Len=162, myfn=$preview? 36:360);
		
		translate([0,0,81]) 
			Alt_BayFrameHole(Tube_OD=BT98Body_OD, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y);
	}
	
	translate([0,0,81]) Alt_BayDoorFrame(Tube_OD=BT98Body_OD, Tube_ID=BT98Body_ID, DoorXtra_X=7.7, DoorXtra_Y=4, ShowDoor=false);
	
} // TestCode1

//TestCode1();

//DoorFrame(Door_X=44.2, Door_Y=109.5, Door_t=3.7,Tube_OD=BT98Body_OD, HasSixBolts=true, HasBoltBosses=false);
					

module Alt_BayDoorFrame(Tube_OD=PML98Body_OD, Tube_ID=BT98Body_ID, DoorXtra_X=0, DoorXtra_Y=0, ShowDoor=false){
	Tube_Len=Alt54Door_Y+DoorXtra_Y+7;
	Door_Y=Alt54Door_Y+DoorXtra_Y;
	Door_X=Alt54Door_X+DoorXtra_X;
	Door_t=AltDoorThickness;
	BoltBossInset=10.5+2;
	AltOffset_Y=7;
	
	echo(Door_X=Door_X);
	echo(Door_Y=Door_Y);
	
	difference(){
		DoorFrame(Door_X=Door_X, Door_Y=Door_Y, Door_t=Door_t, 
					Tube_OD=Tube_OD, HasSixBolts=true, HasBoltBosses=false);
					
				
		// Bolt bosses
		rotate([90,0,0]) 
			translate([0,Alt_Y/2-Door_Y/2+AltOffset_Y,Tube_OD/2-Door_t-BoltBossInset]) 
						AltHoles() cylinder(d=10, h=BoltBossInset+4);
	
		//rotate([90,0,0]) RoundRect(X=Door_X-4, Y=Door_Y-4, Z=Tube_OD, R=4-2);
		
		AltDoorHole54(Tube_OD=Tube_OD, DoorXtra_X=DoorXtra_X, DoorXtra_Y=DoorXtra_Y);
	} // difference
	
	// Door Bolts
	difference(){
		// Bolt bosses
		intersection(){
			translate([0,0,-Door_Y/2-3]) 
					Tube(OD=Tube_OD-1, ID=Tube_ID-13, Len=Door_Y+6, myfn=$preview? 36:360);
			hull(){
				translate([0,-Tube_ID/2+Door_t+4,0]) rotate([90,0,0]) 
					RoundRect(X=8, Y=Door_Y+3, Z=6, R=1);
				translate([0,-Tube_ID/2,0]) rotate([90,0,0]) 
					RoundRect(X=12, Y=Door_Y+12, Z=1, R=1);
			} // hull
		} // intersection
		
		// Trim Bolt Brackets
		rotate([90,0,0]) RoundRect(X=16, Y=Alt_Y, Z=Tube_OD/2, R=1);
		
		// Alt Door
		AltDoorHole54(Tube_OD=Tube_OD, DoorXtra_X=DoorXtra_X, DoorXtra_Y=DoorXtra_Y);
		
		// door mounting bolts
		Alt_DoorBoltPattern(Tube_OD=Tube_OD, DoorXtra_Y=DoorXtra_Y) Bolt4Hole();
		
	} // difference
	
	if ($preview&&ShowDoor) AltDoor54(Tube_OD=Tube_OD, DoorXtra_X=DoorXtra_X, DoorXtra_Y=DoorXtra_Y);
} // Alt_BayDoorFrame

//Alt_BayDoorFrame(ShowDoor=false);
//Alt_BayDoorFrame(Tube_OD=PML75Body_OD, Tube_ID=PML75Body_ID, DoorXtra_X=2, DoorXtra_Y=2, ShowDoor=false);

module AltBay54(Tube_OD=PML54Body_OD, Tube_ID=PML54Body_ID, Tube_Len=136, DoorXtra_X=0, DoorXtra_Y=0, ShowDoor=false){

	Door_Y=Alt54Door_Y+DoorXtra_Y;
	Door_X=Alt54Door_X+DoorXtra_X;
	Door_t=AltDoorThickness;
	
	difference(){
		Tube(OD=Tube_OD, ID=Tube_ID, Len=Tube_Len, myfn=$preview? 90:360);
		
		translate([0,0,Tube_Len/2]) Alt_BayFrameHole(Tube_OD=Tube_OD, DoorXtra_X=DoorXtra_X, DoorXtra_Y=DoorXtra_Y);
	} // difference
	
	translate([0,0,Tube_Len/2]) 
		Alt_BayDoorFrame(Tube_OD=Tube_OD, Tube_ID=Tube_ID, DoorXtra_X=DoorXtra_X, DoorXtra_Y=DoorXtra_Y, ShowDoor=ShowDoor);
	
} // AltBay54

//AltBay54(ShowDoor=true);
//AltBay54(ShowDoor=false);
//AltBay54(Tube_OD=PML75Body_OD, Tube_ID=PML75Body_ID, Tube_Len=136, DoorXtra_X=2, DoorXtra_Y=2, ShowDoor=true);

module AltDoor54(Tube_OD=PML54Body_OD, IsLoProfile=false, DoorXtra_X=0, DoorXtra_Y=0, ShowAlt=true){
	Door_Y=Alt54Door_Y+DoorXtra_Y;
	Door_X=Alt54Door_X+DoorXtra_X;
	Door_t=AltDoorThickness-0.7;
	BoltBossInset=IsLoProfile? 7.5:10.5;
	BoltDepth=IsLoProfile? BoltBossInset:BoltBossInset-2; // thru the door:not
	LEDSW_Boss_H=IsLoProfile? 2:3;
	AltOffset_Y=7;
	
	difference(){
		union(){
			Door(Door_X=Door_X, Door_Y=Door_Y, Door_t=Door_t, Tube_OD=Tube_OD,
					HasSixBolts=true, HasBoltHoles=false);
		
			intersection(){
				
				translate([0,0,-Door_Y/2])
						cylinder(d=Tube_OD-1, h=Door_Y);
				union(){
					// LED and Arming holes
					translate([0, -Tube_OD/2+Door_t+LEDSW_Boss_H, -Door_Y/2+AltOffset_Y+AltArmingScrew_Y])
						rotate([90,0,0]) cylinder(d=5+6, h=10);
					translate([0, -Tube_OD/2+Door_t+LEDSW_Boss_H, -Door_Y/2+AltOffset_Y+AltLED_Y]) 
						rotate([90,0,0]) cylinder(d=5+6, h=10);
				
					// Bolt bosses
					translate([0, -Tube_OD/2+Door_t+BoltBossInset, Alt_Y/2-Door_Y/2+AltOffset_Y]) 
						rotate([90,0,0]) AltHoles() cylinder(d=8, h=BoltBossInset+3);
					} // union
			} // intersection
		} // union
	
		// PCB parts
		
		// Pressure transducer
		translate([0, -Tube_OD/2+Door_t+BoltBossInset, -Door_Y/2+AltOffset_Y]) {
			rotate([90,0,0]) translate([-11,27,0]) cube([12,14,11],center=true);
		}
		
		// Altimeter holes
		translate([0, 0, -Door_Y/2+AltOffset_Y]){
			translate([0, -Tube_OD/2+Door_t+BoltBossInset, Alt_Y/2]) 
				rotate([90,0,0]) AltHoles() rotate([180,0,0]) Bolt4Hole(depth=BoltDepth); //Bolt4ButtonHeadHole();
			
			translate([0,0,AltArmingScrew_Y]) rotate([90,0,0]) cylinder(d=5, h=Tube_OD);
			translate([0,0,AltLED_Y]) rotate([90,0,0]) cylinder(d=5, h=Tube_OD);
		}

		// mounting bolts
		translate([0, -Tube_OD/2, Door_Y/2-4]) rotate([90,0,0]) Bolt4ClearHole();
		translate([0, -Tube_OD/2, -Door_Y/2+4]) rotate([90,0,0]) Bolt4ClearHole();
	} // difference

	if ($preview) translate([0,-Tube_OD/2+Door_t+BoltBossInset+1.6,0]) rotate([90,0,0]) AltPCB();
} // AltDoor54

//rotate([90,0,0]) AltDoor54(Tube_OD=PML54Body_OD, IsLoProfile=false);
//rotate([180,0,0]) AltDoor54(Tube_OD=PML98Body_OD, IsLoProfile=true);

module UpperRailButtonPost(Body_OD=PML54Body_OD, Body_ID=PML54Body_ID, MtrTube_OD=PML38Body_OD, Extend=5){
		
	rotate([0,0,-90]) 
			RailButtonPost(OD=Body_OD, MtrTube_OD=MtrTube_OD, H=Body_OD/2+Extend, Len=40);
	translate([0,0,-20]) CenteringRing(OD=Body_OD, ID=MtrTube_OD+1, Thickness=8);
	// Lower Coupler Tube Socket
	translate([0,0,-40])
		Tube(OD=Body_OD, ID=Body_ID, 
			Len=20+Overlap, myfn=$preview? 90:360);
} // UpperRailButtonPost


module Electronics_Bay(Tube_OD=PML54Body_OD, Tube_ID=PML54Body_ID, Fairing_ID=PML54Body_OD-4.4,
						EBay_Len=130, HasCablePuller=true){
	
	TopOfTube=EBay_Len;
	CablePullerInset=-1;
	CablePuller_Z=TopOfTube-30;
	CP_a=(Tube_OD<PML75Body_OD)? -5:0;
	CP_Za=(Tube_OD<PML75Body_OD)? 135:180;
	
	// The Fairing clamps onto this. 
	translate([0,0,TopOfTube]) 
		FairingBaseLockRing(Tube_OD=Tube_OD, Tube_ID=Tube_ID, Fairing_ID=Fairing_ID, Interface=Overlap);
	translate([0,0,EBay_Len-2.5]) rotate([180,0,0]) 
		TubeStop(InnerTubeID=Tube_ID-5, OuterTubeOD=Tube_OD, myfn=$preview? 36:360);
	
	// Standard E-Bay module
	difference(){
		translate([0,0,-Overlap]) rotate([0,0,90])
			AltBay54(Tube_OD=Tube_OD, Tube_ID=Tube_ID, Tube_Len=EBay_Len);
		
		// Cable Puller Bolt Holes
		if (HasCablePuller) translate([0,0,CablePuller_Z]) rotate([0,90,CP_Za]) 
			translate([0,0,Tube_ID/2-CablePullerInset]) 
				rotate([CP_a,0,0]) CablePullerBoltPattern() Bolt4Hole();
	} // difference
	
	// Lower Coupler Tube Socket
	translate([0,0,-20])
		Tube(OD=Tube_OD, ID=Tube_ID, 
			Len=20+Overlap, myfn=$preview? 90:360);
	
	// Shock code path, keep it out of the way. 
	
	if (HasCablePuller)
	rotate([0,0,10])
	difference(){
		Y1=30;
		Y2=65;
		Y3=110;
		H=6;
		
		union(){
			translate([0,-Tube_OD/2+4.4,Y1]) 
				ShockCordHole(X=NylonTube9_w+4.4, Y=NylonTube9_h+4.4, Len=H);
			translate([0,-Tube_OD/2+4.4,Y2]) 
				ShockCordHole(X=NylonTube9_w+4.4, Y=NylonTube9_h+4.4, Len=H);
			translate([0,-Tube_OD/2+4.4,Y3]) 
				ShockCordHole(X=NylonTube9_w+4.4, Y=NylonTube9_h+4.4, Len=H);
		}// union
		
		translate([0,-Tube_OD/2+4.4,Y1-Overlap]) 
			ShockCordHole(X=NylonTube9_w, Y=NylonTube9_h, Len=H+Overlap*2);
		
		translate([0,-Tube_OD/2+4.4,Y2-Overlap]) 
			ShockCordHole(X=NylonTube9_w, Y=NylonTube9_h, Len=H+Overlap*2);
		
		translate([0,-Tube_OD/2+4.4,Y3-Overlap]) 
			ShockCordHole(X=NylonTube9_w, Y=NylonTube9_h, Len=H+Overlap*2);
		
		// Conform to OD of E-Bay
		
		difference(){
			cylinder(d=Tube_ID+20, h=200);
			translate([0,0,-Overlap]) cylinder(d=Tube_ID+1, h=200+Overlap*2);
		} // difference
	} // difference
	
	if (HasCablePuller)
	translate([0,0,CablePuller_Z]) rotate([0,90,CP_Za]) 
	difference(){
		// Cable Puller Bolt Bosses
		translate([0,0,Tube_ID/2-CablePullerInset]) 
			rotate([CP_a,0,0]) CablePullerBoltPattern() 
				hull(){
					rotate([180,0,0]) cylinder(d=8, h=8);
					translate([12,0,0]) rotate([180,0,0]) cylinder(d=3, h=Overlap);
				} // hull
		
		// Cable Puller Bolt Holes
		translate([0,0,Tube_ID/2-CablePullerInset]) 
			rotate([CP_a,0,0]) CablePullerBoltPattern() Bolt4Hole();
		
		// Conform to OD of E-Bay
		rotate([0,90,0]) translate([0,0,-10])
		difference(){
			cylinder(d=Tube_ID+20, h=100);
			translate([0,0,-Overlap]) cylinder(d=Tube_ID+1, h=100+Overlap*2);
		} // difference
	} // difference
} // Electronics_Bay

/*
Electronics_Bay(Tube_OD=PML54Body_OD, Tube_ID=PML54Body_ID, Fairing_ID=PML54Body_OD-4.4,
						EBay_Len=130, HasCablePuller=true);
/**/

/*
Electronics_Bay(Tube_OD=PML75Body_OD, Tube_ID=PML75Body_ID, Fairing_ID=PML75Body_OD-4.4,
						EBay_Len=130, HasCablePuller=true);
/**/


AltUSB_Y=29;
AltUSB_Z=1.5;

module USB_Connector_Hole(){
	translate([Alt_X/2-1,-Alt_Y/2+AltUSB_Y,AltPCB_h+AltUSB_Z]) rotate([0,90,0]) children();
} // USB_Connector_Hole

//USB_Connector_Hole() RoundRect(X=8, Y=11, Z=10, R=1);

module AltPCB(){
	module Conn4Pin(){
		translate([0,-7.5,0])
		hull(){
			cube([7,15,6]);
			cube([5,15,8]);
		}
	} // Conn4Pin
	
	module Conn8Pin(){
		translate([-10,-6.35/2,0]) cube([20,6.35,11]);
	}
	
	difference(){
		union(){
			translate([-Alt_X/2,-Alt_Y/2,0]) 
				color("LightGreen") cube([Alt_X,Alt_Y,AltPCB_h]);
			
			translate([0,-Alt_Y/2+AltArmingScrew_Y,AltPCB_h+Overlap])
				color("LightGray") cylinder(d=7,h=3);
			translate([0,-Alt_Y/2+AltLED_Y,AltPCB_h+Overlap])
				color("Blue") cylinder(d=4,h=3);
				
			translate([6.5,Alt_Y/2-14,0]) mirror([0,0,1]) Conn4Pin();
			translate([-6.5,Alt_Y/2-14,0]) mirror([1,0,1]) Conn4Pin();
			translate([0,-Alt_Y/2+6,0]) mirror([0,0,1]) Conn8Pin();
		} // union
		
		translate([0,0,AltPCB_h]) AltHoles() Bolt4ClearHole();
	} // difference
} // AltPCB
	
//AltPCB();

module TubeSocket(L=10, Wall_T=1.2, HasBoltGuide=false){
	
	difference(){
		cylinder(d=Tubing_d+Wall_T*2+IDXtra, h=L);
		
		translate([0,0,-Overlap]) cylinder(d=Tubing_d+IDXtra, h=L+Overlap*2);
	} // difference
	
	if (HasBoltGuide) difference(){
		cylinder(d=10.8-IDXtra*3, h=L/2);
		
		translate([0,0,-Overlap]) cylinder(r1=Bolt6_Clear_r, r2=4, h=L/2+Overlap*2);
	} // if difference
} // TubeSocket

// TubeSocket(L=10, Wall_T=1.2, HasBoltGuide=false);
// TubeSocket(L=10, Wall_T=1.2, HasBoltGuide=true);

module AltHolder(){
	// A bracket to hold the altimeter. 
	Plate_X=C_ID*0.75;
		
	for (j=[0:1]) rotate([0,0,360/nTubes*j-90-180/nTubes]){
		translate([C_ID/2-Tubing_d/2-WallGap,0,0]) TubeSocket(L=15, Wall_T=3);
		translate([C_ID/2-Tubing_d/2-WallGap,0,Alt_Y]) TubeSocket(L=15, Wall_T=3);
	} // for
	
	difference(){
		translate([-Plate_X/2,-C_ID/2*0.6,0]) cube([Plate_X,5,Alt_Y+15]);
		 
		// Tubes
		for (j=[0:1]) rotate([0,0,360/nTubes*j-90-180/nTubes])
			translate([C_ID/2-Tubing_d/2-WallGap,0,-Overlap]) 
				cylinder(d=Tubing_d+IDXtra*2, h=Alt_Y+15+Overlap*2);
		
		translate([0,-C_ID/2*0.6,(Alt_Y+15)/2]) rotate([90,0,0]) 
			AltHoles() Bolt4Hole();
		
		difference(){
			translate([-(Alt_X-2)/2,-C_ID/2*0.6-Overlap,(Alt_Y+15)/2-(Alt_Y-2)/2]) 
				cube([Alt_X-2,5+Overlap*2,Alt_Y-2]);
			
			translate([0,-C_ID/2*0.6-Overlap,(Alt_Y+15)/2]) rotate([-90,0,0]) 
				AltHoles() cylinder(d=7, h=6);
		} // difference
	} // difference
} // AltHolder

//translate([0,0,21]) AltHolder();
//translate([0,-C_ID/2*0.6-1,(Alt_Y+15)/2+21]) rotate([90,0,0]) AltPCB();

module Spacer(Len=46){
	TubeSocket(L=Len, Wall_T=3);
} // Spacer

//Spacer(Len=46);

module BatteryHolder(PlateLen=46){
	Plate_X=C_ID*0.75;
	Batt_Width=26;
	Batt_Height=52.5;
		
	for (j=[0:1]) rotate([0,0,360/nTubes*j-90-180/nTubes]){
		translate([C_ID/2-Tubing_d/2-WallGap,0,0]) TubeSocket(L=15, Wall_T=3);
		translate([C_ID/2-Tubing_d/2-WallGap,0,PlateLen-15]) TubeSocket(L=15, Wall_T=3);
	} // for
	
	difference(){
		union(){
			translate([-Plate_X/2,-C_ID/2*0.6,0]) cube([Plate_X,5,PlateLen]);
			
			translate([0,0,PlateLen/2])
			rotate([0,90,0]){
			translate([-Batt_Width/2+3,-C_ID/2*0.6,-Batt_Width/2-5])
				cube([Batt_Width-6,12,5]);
			translate([-Batt_Width/2+3,-C_ID/2*0.6,Batt_Width/2])
				cube([Batt_Width-6,12,5]);
			}
		} // union
		 
		
		// Tubes
		for (j=[0:1]) rotate([0,0,360/nTubes*j-90-180/nTubes])
			translate([C_ID/2-Tubing_d/2-WallGap,0,-Overlap]) 
				cylinder(d=Tubing_d+IDXtra*2, h=Alt_Y+15+Overlap*2);
		
		// ty-wrap holes
		translate([0,0,PlateLen/2]) rotate([0,90,0]){
		translate([-Batt_Width/2,-C_ID/2*0.6-Overlap,-Batt_Width/2]) 
			rotate([-90,0,0]) cylinder(d=4, h=10);
		translate([Batt_Width/2,-C_ID/2*0.6-Overlap,-Batt_Width/2]) 
			rotate([-90,0,0]) cylinder(d=4, h=10);
		translate([-Batt_Width/2,-C_ID/2*0.6-Overlap,Batt_Width/2]) 
			rotate([-90,0,0]) cylinder(d=4, h=10);
		translate([Batt_Width/2,-C_ID/2*0.6-Overlap,Batt_Width/2]) 
			rotate([-90,0,0]) cylinder(d=4, h=10);
		}
		
		
	} // difference
	
	if ($preview==true)
		translate([0,0,PlateLen/2]) rotate([0,90,0])	
		translate([-Batt_Height/2,-C_ID/2*0.6+5,-Batt_Width/2]) 
			color("Red") cube([Batt_Height,13,Batt_Width]);
} // BatteryHolder

//BatteryHolder(PlateLen=46);


module AltBayTop(Len=20, HasShockcordPassThru=true){
	BP_T=5;	
	
	difference(){
		union(){
			Piston(OD=C_OD, ID=C_ID, Len=Len, BP_Thickness=BP_T);
			for (j=[0:nTubes-1]) rotate([0,0,360/nTubes*j-30]) 
				translate([C_ID/2-Tubing_d/2-WallGap,0,BP_T-Overlap])
					TubeSocket(L=10, Wall_T=1.2, HasBoltGuide=true);
		} // union
		
		if (HasShockcordPassThru) hull(){
			translate([-NylonTube9_w/2,0,-Overlap]) cylinder(d=NylonTube9_h, h=BP_T+Overlap*2);
			translate([NylonTube9_w/2,0,-Overlap]) cylinder(d=NylonTube9_h, h=BP_T+Overlap*2);
		} // if hull
			
		for (j=[0:nTubes-1]) rotate([0,0,360/nTubes*j-30]) 
			translate([C_ID/2-Tubing_d/2-WallGap,0,BP_T]) Bolt6ClearHole();
		
		// Rivet holes
		translate([0,0,NoseConeRivets_h]) RivetPattern(BT_Dia=BT_OD, nRivets=3, Dia=5/32*25.4);

	} // difference
	
} // AltBayTop

// AltBayTop(Len=20);

module AltBayBody(BT_Len=95){
	BT_Wall_T=2.2;
	
	difference(){
		// body tube
		cylinder(d=BT_OD, h=BT_Len, $fn=$preview? 90:360);
		
		// Attimeter access
		translate([0,-BT_OD/2-1,-5]){
			translate([0,0,AltArmingScrew_Y]) rotate([-90,0,0]) cylinder(d=7,h=10);
			translate([0,0,AltLED_Y]) rotate([-90,0,0]) cylinder(d=7,h=10);
		}
		
		// Inside diameter of altimeter bay
		translate([0,0,-Overlap]) 
			cylinder(d=C_ID-IDXtra*2, h=BT_Len+Overlap*2, $fn=$preview? 90:360);
		
		// Top goes in here
		translate([0,0,BT_Len-5-Overlap]) 
			cylinder(d=C_OD, h=6, $fn=$preview? 90:360);

		// Make it lighter
		translate([0,0,10]) 
			cylinder(d1=C_ID-IDXtra*2, d2=BT_OD-BT_Wall_T*2, h=BT_Wall_T+Overlap, $fn=$preview? 90:360);
		translate([0,0,10+BT_Wall_T]) 
			cylinder(d=BT_OD-BT_Wall_T*2, h=BT_Len-20-BT_Wall_T*2+Overlap, $fn=$preview? 90:360);
		
		translate([0,0,BT_Len-10-BT_Wall_T]) 
			cylinder(d2=C_ID-IDXtra*2, d1=BT_OD-BT_Wall_T*2, h=BT_Wall_T, $fn=$preview? 90:360);
		
		
		// Bottom goes in here
		translate([0,0,5]) 
			cylinder(d2=C_ID-IDXtra*2, d1=C_OD, h=2, $fn=$preview? 90:360);
		translate([0,0,-Overlap]) 
			cylinder(d=C_OD, h=5+Overlap*2, $fn=$preview? 90:360);
		
		if ($preview==true) translate([0,-100,-10]) cube([100,100,200]);
	} // difference
	
} // AltBayBody

//AltBayBody();

module ShockCordHole(X=NylonTube9_w, Y=NylonTube9_h, Len=10){
	hull(){
		translate([-X/2,0,-Overlap]) cylinder(d=Y, h=Len+Overlap*2);
		translate([X/2,0,-Overlap]) cylinder(d=Y, h=Len+Overlap*2);
	} // if hull
} // ShockCordHole

//ShockCordHole();

module AltBayBottom(CT_Len=75, HasShockcordPassThru=true){
	BP_T=5; // Coupler Bulkplate thickness
	Skirt_h=5; // Overlap with body
	
	difference(){
		union(){
			Piston(OD=C_OD, ID=C_ID, Len=CT_Len+Skirt_h, BP_Thickness=BP_T);
			for (j=[0:nTubes-1]) rotate([0,0,360/nTubes*j-30]) 
				translate([C_ID/2-Tubing_d/2-WallGap,0,BP_T-Overlap]) 
					TubeSocket(L=10, Wall_T=1.2, HasBoltGuide=true);
						
		} // union
		
		if (HasShockcordPassThru) ShockCordHole(Len=BP_T);
		
		for (j=[0:nTubes-1]) rotate([0,0,360/nTubes*j-30]) 
			translate([C_ID/2-Tubing_d/2-WallGap,0,BP_T]) Bolt6ClearHole();
		
		// Attimeter access
		translate([0,-BT_OD/2-1,75]){
			translate([0,0,AltArmingScrew_Y]) rotate([-90,0,0]) cylinder(d=7,h=10);
			translate([0,0,AltLED_Y]) rotate([-90,0,0]) cylinder(d=7,h=10);
		}

		// Rivet holes
		translate([0,0,CT_Len-25]) RivetPattern(BT_Dia=BT_OD, nRivets=3, Dia=5/32*25.4);
		
		
		// Charge holder
		translate([0,20,5]) CH_Bolts(CH_BoltSpacing=28) Bolt6Hole(depth=10);
		
		// Charge holder wire
		translate([0,0,-Overlap]) cylinder(d=3, h=10);
	} // difference
	
} // AltBayBottom

//AltBayBottom(CT_Len=75, HasShockcordPassThru=true);

//translate([0,0,75-8]) AltHolder();
//translate([0,-C_ID/2*0.6-1,Alt_Y/2+75]) rotate([90,0,0]) AltPCB();
//translate([0,0,75+95+25])rotate([0,180,0]) AltBayTop(Len=25);































