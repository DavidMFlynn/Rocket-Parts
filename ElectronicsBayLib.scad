// *****************************************************
// Electronics Bay Library
// Project: 3D Printed Rocket
// Filename: ElectronicsBayLib.scad
// by David M. Flynn
// Created: 3/31/2024 
// Revision: 1.1.0  8/1/2024 
// Units: mm
// ***********************************
//  ***** Notes *****
//
// Standard electronics bay designs
//
//  ***** History *****
//
// 1.1.0  8/1/2024   Added EB_Electronics_Bay55()
// 1.0.3  7/15/2024  Added doors shortcuts.
// 1.0.2  5/14/2024  Added EB_LowerElectronics_Bay()
// 1.0.1  4/18/2024  Added nBolts=3, BoltInset=7.5 to EB_Electronics_Bay3
// 1.0.0  3/31/2024  First code, moved stuff here
//
// ***********************************
//  ***** for STL output *****
//
// EB_LowerElectronics_Bay(Tube_OD=BT98Body_OD, Tube_ID=BT98Body_ID, Len=162, nBolts=5, BoltInset=7.5, ShowDoors=false);
//  *** One Battery Door w/o Switch and One Altimeter for sustainer lower e-bay ***
//	
//  *** Standard single altimeter bay w/ 1 or 2 battery doors w/ switch ***
// EB_Electronics_Bay3(Tube_OD=BT75Body_OD, Tube_ID=BT75Body_ID, Len=162, nBolts=3, BoltInset=7.5, DualDeploy=false, ShowDoors=false);
// EB_Electronics_Bay3(Tube_OD=BT75Body_OD, Tube_ID=BT75Body_ID, Len=162, nBolts=3, BoltInset=7.5, DualDeploy=true, ShowDoors=false);
//
//  *** Standard single altimeter bay w/ 2 or 3 battery doors ***
// EB_Electronics_Bay(Tube_OD=BT98Body_OD, Tube_ID=BT98Body_ID, Len=162, nBolts=3, BoltInset=7.5, ShowDoors=false, HasSecondBattDoor=true);
// EB_Electronics_Bay(Tube_OD=BT75Body_OD, Tube_ID=BT75Body_ID, Len=162, nBolts=3, BoltInset=7.5, ShowDoors=false, HasSecondBattDoor=false);
//
//  *** Large 2 altimeter electronics bay ***
// EB_Electronics_Bay55(Tube_OD=BT137Body_OD, Tube_ID=BT137Body_ID, Len=162, nBolts=6, BoltInset=7.5, ShowDoors=false);
// 
//
//  *** Doors ***
// rotate([-90,0,0]) EB_AltDoor(Tube_OD=BT98Body_OD);
// rotate([-90,0,0]) EB_BattDoor(Tube_OD=BT98Body_OD, HasSwitch=false, DoubleBatt=false);
// rotate([-90,0,0]) EB_BattDoor(Tube_OD=BT98Body_OD, HasSwitch=true, DoubleBatt=false);
//
// ***********************************
//  ***** Routines *****
//
//
// ***********************************
//  ***** for Viewing *****
//
//
// ***********************************
include<TubesLib.scad>
use<AltBay.scad>
use<BatteryHolderLib.scad>

//also included
 //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 36:90;

Alt_DoorXtra_X=6;
Alt_DoorXtra_Y=4;
	
module EB_AltDoor(Tube_OD=BT98Body_OD){
	AltDoor54(Tube_OD=Tube_OD, IsLoProfile=false, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowAlt=true);
} // EB_AltDoor

//EB_AltDoor(Tube_OD=BT98Body_OD);

module EB_BattDoor(Tube_OD=BT98Body_OD, HasSwitch=false, DoubleBatt=false){
	Batt_Door(Tube_OD=Tube_OD, Door_X=BattDoorX(), InnerTube_OD=0, HasSwitch=HasSwitch, DoubleBatt=DoubleBatt);
} // EB_BattDoor

//EB_BattDoor(Tube_OD=BT98Body_OD, HasSwitch=false);

module EB_LowerElectronics_Bay(Tube_OD=BT98Body_OD, Tube_ID=BT98Body_ID, Len=162, nBolts=5, BoltInset=7.5, ShowDoors=false){
	// One Battery Door w/o Switch and One Altimeter for sustainer lower e-bay.
	
	Altimeter_Z=Len/2;
	BattSwDoor_Z=Len/2;
	Alt_a=0;
	Batt1_a=180;
	
	difference(){
		union(){
			Tube(OD=Tube_OD, ID=Tube_ID, Len=Len-15, myfn=$preview? 36:360);
		
			//Integrated coupler
			translate([0,0,Len-17]) Tube(OD=Tube_ID, ID=Tube_ID-4.4, Len=17, myfn=$preview? 36:360);
			difference(){
				translate([0,0,Len-22]) cylinder(d=Tube_OD-1, h=5);
				
				translate([0,0,Len-22-Overlap]) cylinder(d1=Tube_ID, d2=Tube_ID-4.4, h=5+Overlap*2);
			} // difference
			
			translate([0,0,Len-5]) CenteringRing(OD=Tube_ID-1, ID=BT54Body_OD+IDXtra*2, Thickness=5, nHoles=nBolts, Offset=0);
		} // union
				
		// Altimeter
		translate([0,0,Altimeter_Z]) rotate([0,0,Alt_a]) 
			Alt_BayFrameHole(Tube_OD=Tube_OD, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y);
		
		// Battery and Switch door holes
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
			Batt_BayFrameHole(Tube_OD=Tube_OD, HasSwitch=false);
			
		
		//Bolt holes for nosecone and ball lock
		if (nBolts>0)
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]){
			translate([0,-Tube_OD/2-1,BoltInset]) rotate([90,0,0]) Bolt4Hole();
			//translate([0,-Tube_OD/2-1,Len-BoltInset]) rotate([90,0,0]) Bolt4Hole();
		} // for
		
	} // difference
	
	// Altimeter
	translate([0,0,Altimeter_Z]) rotate([0,0,Alt_a])
		Alt_BayDoorFrame(Tube_OD=Tube_OD, Tube_ID=Tube_ID, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowDoor=ShowDoors);
	
	// Battery and Switch door2
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
		Batt_BayDoorFrame(Tube_OD=Tube_OD, HasSwitch=false, ShowDoor=ShowDoors);
		
	
} // EB_LowerElectronics_Bay

// EB_LowerElectronics_Bay();

module EB_Electronics_Bay3(Tube_OD=BT75Body_OD, Tube_ID=BT75Body_ID, Len=162, nBolts=3, BoltInset=7.5, DualDeploy=false, ShowDoors=false){
	// One/two Battery Door w/ Switch and One Altimeter
	Altimeter_Z=Len/2;
	BattSwDoor_Z=Len/2;
	Alt_a=0;
	Batt1_a=DualDeploy? 120:180;
	Batt2_a=240;
	
	difference(){
		
		Tube(OD=Tube_OD, ID=Tube_ID, Len=Len, myfn=$preview? 36:360);
				
		// Altimeter
		translate([0,0,Altimeter_Z]) rotate([0,0,Alt_a]) 
			Alt_BayFrameHole(Tube_OD=Tube_OD, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y);
		
		// Battery and Switch door holes
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
			Batt_BayFrameHole(Tube_OD=Tube_OD, HasSwitch=true);
			
		if (DualDeploy)
			translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt2_a]) 
				Batt_BayFrameHole(Tube_OD=Tube_OD, HasSwitch=true);
		
		//Bolt holes for nosecone and ball lock
		if (nBolts>0)
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]){
			translate([0,-Tube_OD/2-1,BoltInset]) rotate([90,0,0]) Bolt4Hole();
			translate([0,-Tube_OD/2-1,Len-BoltInset]) rotate([90,0,0]) Bolt4Hole();
		} // for
		
	} // difference
	
	// Altimeter
	translate([0,0,Altimeter_Z]) rotate([0,0,Alt_a])
		Alt_BayDoorFrame(Tube_OD=Tube_OD, Tube_ID=Tube_ID, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowDoor=ShowDoors);
	
	// Battery and Switch door2
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
		Batt_BayDoorFrame(Tube_OD=Tube_OD, HasSwitch=true, ShowDoor=ShowDoors);
		
	if (DualDeploy)
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt2_a]) 
			Batt_BayDoorFrame(Tube_OD=Tube_OD, HasSwitch=true, ShowDoor=ShowDoors);
	
} // EB_Electronics_Bay3

// EB_Electronics_Bay3();

module EB_Electronics_Bay(Tube_OD=BT98Body_OD, Tube_ID=BT98Body_ID, Len=162, nBolts=3, BoltInset=7.5, ShowDoors=false, HasSecondBattDoor=true){
	// Standard single altimeter bay

	Altimeter_Z=Len/2;
	BattSwDoor_Z=Len/2;

	Alt_a=0;
	Batt1_a=HasSecondBattDoor? 90:120;
	Batt2_a=HasSecondBattDoor? 180:240;
	Batt3_a=270;
	
	difference(){
		Tube(OD=Tube_OD, ID=Tube_ID, Len=Len, myfn=$preview? 36:360);
		
		// Altimeter
		translate([0,0,Altimeter_Z]) rotate([0,0,Alt_a]) 
			Alt_BayFrameHole(Tube_OD=Tube_OD, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y);
			
		// Battery and Switch door holes
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
			Batt_BayFrameHole(Tube_OD=Tube_OD, HasSwitch=false);
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt2_a]) 
			Batt_BayFrameHole(Tube_OD=Tube_OD, HasSwitch=true);
			
		if (HasSecondBattDoor)
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt3_a]) 
			Batt_BayFrameHole(Tube_OD=Tube_OD, HasSwitch=true);
			
		//Bolt holes for nosecone and ball lock
		if (nBolts>0)
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]){
			translate([0,-Tube_OD/2-1,BoltInset]) rotate([90,0,0]) Bolt4Hole();
			translate([0,-Tube_OD/2-1,Len-BoltInset]) rotate([90,0,0]) Bolt4Hole();
		} // for
	
	} // difference
	
	// Altimeter
	translate([0,0,Altimeter_Z]) rotate([0,0,Alt_a])
		Alt_BayDoorFrame(Tube_OD=Tube_OD, Tube_ID=Tube_ID, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowDoor=ShowDoors);
	
	// Battery and Switch doors
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
		Batt_BayDoorFrame(Tube_OD=Tube_OD, HasSwitch=false, ShowDoor=ShowDoors);
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt2_a]) 
		Batt_BayDoorFrame(Tube_OD=Tube_OD, HasSwitch=true, ShowDoor=ShowDoors);
		
	if (HasSecondBattDoor)
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt3_a]) 
		Batt_BayDoorFrame(Tube_OD=Tube_OD, HasSwitch=true, ShowDoor=ShowDoors);
	
} // EB_Electronics_Bay

// EB_Electronics_Bay(ShowDoors=false, HasSecondBattDoor=false);

module EB_Electronics_Bay55(Tube_OD=BT137Body_OD, Tube_ID=BT137Body_ID, Len=162, nBolts=7, BoltInset=7.5, ShowDoors=false){
	// Large 2 altimeter electronics bay
	
	Altimeter_Z=Len/2;
	BattSwDoor_Z=Len/2;
	
	Alt1_a=0;
	Alt2_a=60;
	Batt1_a=-60;
	Batt2_a=-120;
	Batt3_a=120;
	Batt4_a=180;

	difference(){
		Tube(OD=Tube_OD, ID=Tube_ID, Len=Len, myfn=$preview? 36:360);
		
		// Altimeter
		translate([0,0,Altimeter_Z]) rotate([0,0,Alt1_a]) 
			Alt_BayFrameHole(Tube_OD=Tube_OD, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y);

		translate([0,0,Altimeter_Z]) rotate([0,0,Alt2_a]) 
			Alt_BayFrameHole(Tube_OD=Tube_OD, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y);
			
		// Battery and Switch door holes
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
			Batt_BayFrameHole(Tube_OD=Tube_OD, HasSwitch=false);
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt2_a]) 
			Batt_BayFrameHole(Tube_OD=Tube_OD, HasSwitch=false);
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt3_a]) 
			Batt_BayFrameHole(Tube_OD=Tube_OD, HasSwitch=true);
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt4_a]) 
			Batt_BayFrameHole(Tube_OD=Tube_OD, HasSwitch=true);
						
		//Bolt holes for nosecone and ball lock
		if (nBolts>0)
		for (j=[0:nBolts-1]) rotate([0, 0, 360/nBolts*j+180/nBolts]){
			translate([0, -Tube_OD/2-1, BoltInset]) rotate([90,0,0]) Bolt4Hole();
			translate([0, -Tube_OD/2-1, Len-BoltInset]) rotate([90,0,0]) Bolt4Hole();
		} // for
	
	} // difference
	
	// Altimeter
	translate([0,0,Altimeter_Z]) rotate([0,0,Alt1_a])
		Alt_BayDoorFrame(Tube_OD=Tube_OD, Tube_ID=Tube_ID, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowDoor=ShowDoors);
	translate([0,0,Altimeter_Z]) rotate([0,0,Alt2_a])
		Alt_BayDoorFrame(Tube_OD=Tube_OD, Tube_ID=Tube_ID, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowDoor=ShowDoors);
	
	// Battery and Switch doors
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
		Batt_BayDoorFrame(Tube_OD=Tube_OD, HasSwitch=false, ShowDoor=ShowDoors);
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt2_a]) 
		Batt_BayDoorFrame(Tube_OD=Tube_OD, HasSwitch=false, ShowDoor=ShowDoors);

	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt3_a]) 
		Batt_BayDoorFrame(Tube_OD=Tube_OD, HasSwitch=true, ShowDoor=ShowDoors);
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt4_a]) 
		Batt_BayDoorFrame(Tube_OD=Tube_OD, HasSwitch=true, ShowDoor=ShowDoors);
		
} // EB_Electronics_Bay55

// EB_Electronics_Bay55();




























