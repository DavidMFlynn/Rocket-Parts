// ***********************************
// Project: 3D Printed Rocket
// Filename: Rocket75A.scad
// by David M. Flynn
// Created: 4/19/2023 
// Revision: 0.9.4  5/7/2023
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  Rocket with 75mm Body and 54mm motor. 
//  5 fins, uses SpringThingBooster on bottom of E-Bay
//  This rocket was first built 4/23/2023
//
//  ***** Non-3D Printed Parts List *****
//	#4-40 x 3/8" Button Head Cap Screws (10)			Door screws
//	#4-40 x 1/4" Button Head Cap Screws (4)				Altimeter
//  #4-40 x 1/2" Socket Head Cap Screws (5)				STB_LockDisk
//	#2-56 x 1/4" Socket Head Cap Screws (2)				Servo
//  #6-32 x 3/8" Button Head Cap Screws (4)				Rail Button Mount
//  #8-32 x 3/4" Button Head Cap Screws (2)				Rail Buttons
//  5/32" Plastic Rivets				(3)				Nosecone
//
//  Mission Control V3 Altimeter
//  9V Alkaline Batteries (2)
//  Rotary Switch for servo power
//  Rocket Servo PCB
//  MG90S Micro Servo, 12 gram high torque
//  Magnets 3/16" Dia. x 1/8" cylinder N35 or N42 (2)	STB_LockDisk
//  Steel Dowels 4mm Dia undrsized x 10mm (5)			STB_LockDisk
//  Steel Dowels 4mm Dia undrsized x 16mm (3)			STB_LockDisk
//  Delrin Balls 3/8" Dia				  (5)			STB_LockDisk
//  Bearings 8mm Dia. x 4mm ID x 3mm, MR84 (7)			STB_LockDisk
//
//  Shock cord 1/2" Tubular Nylon x 10' ebay to parachute
//	Shock cord 1/2" Tubular Nylon x 20' motor to parachute
//  45" Parachute
//
//  Tail Cone
//  Motor Retainer 
//
//  Body Tube: PML 75mm Quantum Tube x 510mm
//  Motor Tube: Blue Tube 54mm x 500mm
//  Coupler Tubes: Blue Tube 54mm coupler x 280mm, 50mm, 47mm, 35mm
//
//
//  ***** History *****
// 
// 0.9.4  5/7/2023   Updated.
// 0.9.3  4/23/2023  Reworked ShowRocket75, added STLs for parts from SpringThingBooster
// 0.9.2  4/19/2023  Copied from Rocket75
// 0.9.1  9/28/2022  Adding last couple of parts.
// 0.9.0  9/11/2022  First code.
//
// ***********************************
//  ***** for STL output *****
//
// BluntOgiveNoseCone(ID=BT75Coupler_OD, OD=R75_Body_OD, L=NC_Len, Base_L=NC_Base, Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=0, LowerPortion=false);
//
// *** Electronics Bay ***
// R75A_Electronics_Bay();
// AltDoor54(Tube_OD=R75_Body_OD, DoorXtra_X=2, DoorXtra_Y=2);
// Batt_Door(Tube_OD=R75_Body_OD, InnerTube_OD=0, HasSwitch=true);
// Batt_Door(Tube_OD=R75_Body_OD, InnerTube_OD=0, HasSwitch=false);
//
// *** Ball Lock *** 
// STB_LockDisk(BallPerimeter_d=R75_Body_OD, nLockBalls=5);
// rotate([180,0,0]) STB_BallRetainerTop(BallPerimeter_d=R75_Body_OD, Body_OD=R75_Body_ID, nLockBalls=5, HasIntegratedCouplerTube=true, Body_ID=R75_Body_ID);
// STB_BallRetainerBottom(BallPerimeter_d=R75_Body_OD, Body_OD=R75_Body_ID, nLockBalls=5, HasSpringGroove=false);
// rotate([180,0,0]) TubeEnd(BallPerimeter_d=R75_Body_OD, nLockBalls=5, Body_OD=R75_Body_OD, Body_ID=R75_Body_ID, Skirt_Len=20);
//
// *** Spring Control ***
// STB_SpringEnd(Tube_ID=R75_Body_ID, CouplerTube_ID=R75_Coupler_ID);
// STB_SpringMiddle(Tube_ID=R75_Body_ID);
// STB_SpringGuide(InnerTube_ID=R75_MtrTube_ID);
//
// rotate([0,-90,0]) BoltOnRailButtonPost(OD=R75_Body_OD, H=R75_Body_OD/2+5);
// RailButton(); // Print 4 halves + spares
//
// *** Fin Can ***
// UpperFinCan();
// Rocket75Fin();
// rotate([180,0,0]) LowerFinCan();
//
// ***********************************
//  ***** Routines *****
//
//
// ***********************************
//  ***** for Viewing *****
//
// 
ShowRocket75();
// ShowRocket75(ShowInternals=true);
//
// ***********************************

include<TubesLib.scad>
use<NoseCone.scad>
use<RailGuide.scad>
use<FinCan.scad>
use<BatteryHolderLib.scad>
use<AltBay.scad>
use<SpringThingBooster.scad>

//also included
 //
 //include<RailGuide.scad>
 //include<Fins.scad>
 //
 //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

nFins=5;
R75_Fin_Post_h=9;
R75_Fin_Root_L=220;
R75_Fin_Root_W=12;
R75_Fin_Tip_W=5;
R75_Fin_Tip_L=80;
R75_Fin_Span=120;
R75_Fin_TipOffset=40;
R75_Fin_Chamfer_L=22;

R75_Body_OD=PML75Body_OD;
R75_Body_ID=PML75Body_ID;
R75_Coupler_OD=BT75Coupler_OD;
R75_Coupler_ID=BT75Coupler_ID;
R75_MtrTube_OD=BT54Body_OD;
R75_MtrTube_ID=BT54Body_ID;

EBay_Len=148;

NoseconeSep_Z=0; // This much of the nosecone becomes part of the fairing.
NC_Len=185;
NC_Tip_r=8;
NC_Base=23;
NC_Wall_t=2.2;

BodyTubeLen=510;
MotorTubeLen=500;
FinCanCouplerLen=50;
EjectorTubeLen=280;
SpringEndTubeLen=47;
NoseconeCouplerLen=35;


module ShowRocket75(ShowInternals=false){
	
	LowerFinCan_Z=30;
	UpperFinCan_Z=R75_Fin_Root_L+70+Overlap;
	BodyTube_Z=UpperFinCan_Z+Overlap;
	TopRailButton_Z=BodyTube_Z+150;
	BallLock_Z=BodyTube_Z+BodyTubeLen+10;
	EBay_Z=BallLock_Z+22+Overlap;
	Nosecone_Z=EBay_Z+EBay_Len+Overlap;
	
	if (ShowInternals==false) translate([0,0,Nosecone_Z]) color("Purple")
		BluntOgiveNoseCone(ID=BT75Coupler_OD, OD=R75_Body_OD, L=NC_Len, Base_L=NC_Base, Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=0, LowerPortion=false);
	
	if (ShowInternals)
		translate([0,0,Nosecone_Z-14]) color("Blue")
			Tube(OD=R75_Coupler_OD, ID=R75_Coupler_ID, Len=NoseconeCouplerLen, myfn=90);
	
	
		translate([0,0,EBay_Z]) rotate([0,0,30]) R75A_Electronics_Bay(ShowDoors=true);
	
	translate([0,0,BallLock_Z]) {
		color("Green") 
			STB_BallRetainerTop(BallPerimeter_d=R75_Body_OD, Body_OD=R75_Body_ID, 
								nLockBalls=5, HasIntegratedCouplerTube=true, Body_ID=R75_Body_ID);
		if (ShowInternals==false) color("Orange")
			STB_TubeEnd(BallPerimeter_d=R75_Body_OD, nLockBalls=5, Body_OD=R75_Body_OD, 
						Body_ID=R75_Body_ID, Skirt_Len=20);
			}
	
	if (ShowInternals){
		translate([0,0,MotorTubeLen+10+6]) color("Blue")
			Tube(OD=R75_Coupler_OD, ID=R75_Coupler_ID, Len=SpringEndTubeLen, myfn=90);
		translate([0,0,MotorTubeLen+10])
			STB_SpringEnd(Tube_ID=R75_Body_ID, CouplerTube_ID=R75_Coupler_ID);
			
		// inside motor tube
		// STB_SpringMiddle(Tube_ID=R75_Body_ID);
		// STB_SpringGuide(InnerTube_ID=R75_MtrTube_ID)
	}

	translate([0,0,TopRailButton_Z]) rotate([0,0,-180/nFins]) 
		BoltOnRailButtonPost(OD=R75_Body_OD, H=R75_Body_OD/2+5);
	
	if (ShowInternals==false)
	translate([0,0,BodyTube_Z]) color("LightBlue") Tube(OD=R75_Body_OD, ID=R75_Body_ID, 
			Len=BodyTubeLen-Overlap*2, myfn=90);
	
	if (ShowInternals){
		translate([0,0,UpperFinCan_Z-20]) color("Blue")
			Tube(OD=R75_Coupler_OD, ID=R75_Coupler_ID, Len=FinCanCouplerLen, myfn=90);
	
		translate([0,0,8]) Tube(OD=R75_MtrTube_OD, ID=R75_MtrTube_ID, 
			Len=MotorTubeLen, myfn=90);
		translate([0,0,MotorTubeLen]) color("Tan")
			CenteringRing(OD=R75_Body_ID, ID=R75_MtrTube_OD, Thickness=6, nHoles=0, Offset=0);
	}
	
	translate([0,0,UpperFinCan_Z]) color("White") UpperFinCan();
	if (ShowInternals==false) 
		translate([0,0,LowerFinCan_Z]) color("LightGreen") LowerFinCan();
	
	// Tailcone, cast polyurathane
	translate([0,0,5]) difference(){
		cylinder(d1=64, d2=R75_Body_OD, h=34);
		translate([0,0,-Overlap]) cylinder(d=R75_MtrTube_OD, h=50);
	}
	// Motor retainer
	translate([0,0,-5]) color("Silver") 
		Tube(OD=62.5, ID=54, Len=33, myfn=90);
	//*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j])
		translate([R75_Body_OD/2-R75_Fin_Post_h, 0, R75_Fin_Root_L/2+50]) 
			rotate([0,90,0]) color("Purple") Rocket75Fin();
	/**/
} // ShowRocket75

//ShowRocket75();
//ShowRocket75(ShowInternals=true);

module R75A_Electronics_Bay(Tube_OD=R75_Body_OD, Tube_ID=R75_Body_ID, 
						InnerTube_OD=BT38Body_OD, HasFairingLockRing=false,
					ShowDoors=false){
	Len=EBay_Len;
	
	BattSwDoor_Z=70;
	TopSkirt_Len=15;
	BottomSkirt_Len=15;
	CablePuller_Z=74.5;
	Alt_DoorXtra_X=2;
	Alt_DoorXtra_Y=2;
	
	Alt_a=180;
	Batt1_a=70; // Altimeter Battery
	Batt2_a=290; // Cable puller battery and switch
	TubeOffset=0;
	nCRHoles=4;
	CRHole_a=0;
	
	
	// The Fairing clamps onto this. 
	if (HasFairingLockRing)
	translate([0,0,Len]) FairingBaseLockRing(Tube_OD=Tube_OD, Tube_ID=Tube_ID, Fairing_ID=Fairing_ID, Interface=Overlap, BlendToTube=true);
	

	difference(){
		union(){
			Tube(OD=Tube_OD, ID=Tube_ID, Len=Len, myfn=$preview? 36:360);
			
			translate([0,0,BottomSkirt_Len]) rotate([0,0,45])
				CenteringRing(OD=Tube_OD-1, ID=InnerTube_OD+IDXtra*2, 
								Thickness=5, nHoles=nCRHoles, Offset=TubeOffset);
			
			translate([0,0,Len-5-TopSkirt_Len]) rotate([0,0,45])
				CenteringRing(OD=Tube_OD-1, ID=InnerTube_OD+IDXtra*2, 
							Thickness=5, nHoles=nCRHoles, Offset=TubeOffset);
		} // union
		
		//*
		if (nCRHoles==0)
		for (j=[1:nHoles-1]) rotate([0,0,360/nHoles*j])
			translate([0,InnerTube_OD/2+(Tube_ID/2-InnerTube_OD/2)/2,0])
				cylinder(d=(Tube_ID/2-InnerTube_OD/2)/2, h=Len);
			/**/
			
		// Altimeter
		translate([0,0,CablePuller_Z]) rotate([0,0,Alt_a+180]) 
			Alt_BayFrameHole(Tube_OD=Tube_OD, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y);
		
		// Battery and Switch door holes
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a+180]) 
			Batt_BayFrameHole(Tube_OD=Tube_OD, HasSwitch=false);
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt2_a+180]) 
			Batt_BayFrameHole(Tube_OD=Tube_OD, HasSwitch=true);
		
	} // difference
	
	// Altimeter
	translate([0,0,CablePuller_Z]) rotate([0,0,Alt_a+180])
		Alt_BayDoorFrame(Tube_OD=Tube_OD, Tube_ID=Tube_ID, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowDoor=ShowDoors);
	
	
	// Battery and Switch door2
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a+180]) 
		Batt_BayDoorFrame(Tube_OD=Tube_OD, HasSwitch=false, ShowDoor=ShowDoors);
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt2_a+180]) 
		Batt_BayDoorFrame(Tube_OD=Tube_OD, HasSwitch=true, ShowDoor=ShowDoors);
	
} // R75A_Electronics_Bay

//R75A_Electronics_Bay(ShowDoors=false);

module UpperFinCan(){
	// Upper Half of Fin Can
	
	rotate([180,0,0]) 
		FinCan(Tube_OD=R75_Body_OD, Tube_ID=R75_Body_ID, MtrTube_OD=R75_MtrTube_OD+IDXtra*2, nFins=nFins,
			Post_h=R75_Fin_Post_h, Root_L=R75_Fin_Root_L, Root_W=R75_Fin_Root_W, 
			Chamfer_L=R75_Fin_Chamfer_L, HasTailCone=false); 

} // UpperFinCan

//UpperFinCan();

module LowerFinCan(){
	RailGuide_Z=55;
	
	difference(){
		FinCan(Tube_OD=R75_Body_OD, Tube_ID=R75_Body_ID, MtrTube_OD=R75_MtrTube_OD+IDXtra*2, nFins=nFins, 
			Post_h=R75_Fin_Post_h, Root_L=R75_Fin_Root_L, Root_W=R75_Fin_Root_W, 
			Chamfer_L=R75_Fin_Chamfer_L, 
			HasTailCone=false,
					MtrRetainer_OD=R75_MtrTube_OD+5,
					MtrRetainer_L=16,
					MtrRetainer_Inset=5); // Lower Half of Fin Can
		
		// modified to fit resin tailcone
		translate([0,0,-Overlap]) cylinder(d=R75_Body_OD+1, h=10);
		
		translate([0,0,RailGuide_Z]) rotate([0,0,-180/nFins]) 
			translate([R75_Body_OD/2+5,0,0]) rotate([0,90,0]) Bolt8Hole(depth=30);
	} // difference
		


	difference(){
		translate([0,0,RailGuide_Z]) rotate([0,0,-180/nFins]) 
			RailButtonPost(OD=R75_Body_OD, MtrTube_OD=R75_MtrTube_OD, H=R75_Body_OD/2+5, Len=30);
		translate([0,0,RailGuide_Z+10]) TrapFin2Slots(Tube_OD=R75_Body_OD, nFins=nFins, 	
			Post_h=R75_Fin_Post_h, Root_L=R75_Fin_Root_L, Root_W=R75_Fin_Root_W, Chamfer_L=R75_Fin_Chamfer_L);
	} // difference

} // LowerFinCan

// LowerFinCan();

module Rocket75Fin(){
	TrapFin2(Post_h=R75_Fin_Post_h, Root_L=R75_Fin_Root_L, Tip_L=R75_Fin_Tip_L, 
			Root_W=R75_Fin_Root_W, Tip_W=R75_Fin_Tip_W, 
			Span=R75_Fin_Span, Chamfer_L=R75_Fin_Chamfer_L,
					TipOffset=R75_Fin_TipOffset);

	if ($preview==false){
		translate([-R75_Fin_Root_L/2+10,0,0]) cylinder(d=R75_Fin_Root_W*2.5, h=0.9); // Neg
		translate([R75_Fin_Root_L/2-10,0,0]) cylinder(d=R75_Fin_Root_W*2.5, h=0.9); // Pos
	}
} // Rocket75Fin

// Rocket75Fin();


































