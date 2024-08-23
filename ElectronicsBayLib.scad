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
//  *** Shock cord attachment and servo space ***
// EB_ExtensionRing(Tube_OD=BT75Body_OD, Tube_ID=BT75Body_ID, Len=21, nBolts=4, BoltInset=7.5)
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
use<RailGuide.scad>

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

module EB_LowerElectronics_Bay(Tube_OD=BT98Body_OD, Tube_ID=BT98Body_ID, Len=162, nBolts=5, nFins=5, BoltInset=7.5, ShowDoors=false,
								Bolted=false, TopOnly=false, BottomOnly=false, HasLowerIntegratedCoupler=false, HasRailGuide=false, RailGuideLen=35){
	// One Battery Door w/o Switch and One Altimeter for sustainer lower e-bay.
	
	Altimeter_Z=Len/2;
	BattSwDoor_Z=Len/2;
	Alt_a=0;
	Batt1_a=180;
	MotorTubeHole_d=BT54Body_OD+IDXtra*3;
	Bolt4Inset=4;
	Bolted_ID=Tube_ID-Bolt4Inset*4;
	Bolt_a=[60,80,105,130,-60,-80,-105,-130];
	OuterTube_Z=HasLowerIntegratedCoupler? 15:0;
	OuterTubeLen=HasLowerIntegratedCoupler? Len-30:Len-15;
	RailGuide_Z=Len-15-30;
	RailGuide_a=90;
	
	difference(){
		union(){
			translate([0,0,OuterTube_Z]) Tube(OD=Tube_OD, ID=Tube_ID, Len=OuterTubeLen, myfn=$preview? 36:360);
		
			//Integrated coupler
			translate([0,0,Len-17]) Tube(OD=Tube_ID, ID=Tube_ID-4.4, Len=17, myfn=$preview? 36:360);
			difference(){
				translate([0,0,Len-22]) cylinder(d=Tube_OD-1, h=5);
				
				translate([0,0,Len-22-Overlap]) cylinder(d1=Tube_ID, d2=Tube_ID-4.4, h=5+Overlap*2);
			} // difference
			
			translate([0,0,Len-5]) rotate([0,0,RailGuide_a]) 
				CenteringRing(OD=Tube_ID-1, ID=MotorTubeHole_d, Thickness=5, nHoles=nFins, Offset=0);
			
			if (HasLowerIntegratedCoupler) {
				Tube(OD=Tube_ID, ID=Tube_ID-4.4, Len=17, myfn=$preview? 36:360);
			
				difference(){
					translate([0,0,17]) cylinder(d=Tube_OD-1, h=5);
				
					translate([0,0,17-Overlap]) cylinder(d2=Tube_ID, d1=Tube_ID-4.4, h=5+Overlap*2);
				} // difference
			
				rotate([0,0,RailGuide_a]) CenteringRing(OD=Tube_ID-1, ID=MotorTubeHole_d, Thickness=5, nHoles=nFins, Offset=0);
			}
			
			if (Bolted){
				
				difference(){
					translate([0,0,Len/2-10]) cylinder(d=Tube_OD-1, h=20);
						
					translate([0,0,Len/2-10-Overlap]) cylinder(d=Bolted_ID, h=20+Overlap*2);
					translate([0,0,Len/2-10-Overlap]) cylinder(d1=Tube_ID, d2=Bolted_ID, h=7);
					translate([0,0,Len/2+3]) cylinder(d2=Tube_ID, d1=Bolted_ID, h=7+Overlap);
					
					translate([0,-30,Len/2]) cube([38,Tube_OD,21], center=true);
					translate([0,30,Len/2]) cube([46,Tube_OD,21], center=true);
					
					
					if (TopOnly){
						for (j=Bolt_a) rotate([0,0,j]) translate([0,Tube_ID/2-Bolt4Inset,Len/2+6]) Bolt4HeadHole();
					}
					
					if (BottomOnly){
						for (j=Bolt_a) rotate([0,0,j]) translate([0,Tube_ID/2-Bolt4Inset,Len/2]) Bolt4Hole();
					}
				} // difference
			
			}
			
			if (HasRailGuide){
				translate([0,0,RailGuide_Z]) difference(){
					rotate([0,0,RailGuide_a]) 
						RailGuidePost(OD=Tube_OD, MtrTube_OD=0, H=Tube_OD/2+2, 
										TubeLen=55, Length = RailGuideLen, BoltSpace=12.7, AddTaper=false);
					cylinder(d=Tube_ID-1.2, h=60, center=true);			
				} // difference
			}
		} // union
				
		if (HasRailGuide) rotate([0,0,RailGuide_a]) 
			translate([0,Tube_OD/2+2,RailGuide_Z]) RailGuideBoltPattern(BoltSpace=12.7) Bolt6Hole();
		
		// Altimeter
		translate([0,0,Altimeter_Z]) rotate([0,0,Alt_a]) 
			Alt_BayFrameHole(Tube_OD=Tube_OD, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y);
		
		// Battery and Switch door holes
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
			Batt_BayFrameHole(Tube_OD=Tube_OD, HasSwitch=false);
			
		// Wire path, 3 of 5 fins over from rail guide
		translate([0,0,-Overlap]) rotate([0,0,RailGuide_a+360/nFins*3]) translate([0,MotorTubeHole_d/2+5,0]) cylinder(d=6, h=30);
		
		//Bolt holes for nosecone and ball lock
		if (nBolts>0)
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]){
			translate([0,-Tube_OD/2-1,BoltInset]) rotate([90,0,0]) Bolt4Hole();
			translate([0,-Tube_OD/2-1,Len-BoltInset]) rotate([90,0,0]) Bolt4Hole();
		} // for
		
		if (TopOnly) translate([0,0,-Overlap]) cylinder(d=Tube_OD+10, h=Len/2+Overlap);
		if (BottomOnly) translate([0,0,Len/2]) cylinder(d=Tube_OD+10, h=Len/2+Overlap);
	} // difference
	
	difference(){
		union(){
			// Altimeter
			translate([0,0,Altimeter_Z]) rotate([0,0,Alt_a])
				Alt_BayDoorFrame(Tube_OD=Tube_OD, Tube_ID=Tube_ID, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowDoor=ShowDoors);
			
			// Battery and Switch door2
			translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a]) 
				Batt_BayDoorFrame(Tube_OD=Tube_OD, HasSwitch=false, ShowDoor=ShowDoors);
				
		} // union
		
		if (TopOnly) translate([0,0,-Overlap]) cylinder(d=Tube_OD+10, h=Len/2+Overlap);
		if (BottomOnly) translate([0,0,Len/2]) cylinder(d=Tube_OD+10, h=Len/2+Overlap);
	} // difference
		
	
} // EB_LowerElectronics_Bay

// 
EB_LowerElectronics_Bay(Tube_OD=BT75Body_OD, Tube_ID=BT75Body_ID, Len=162, nBolts=5, Bolted=true, TopOnly=false, BottomOnly=false,HasLowerIntegratedCoupler=true, HasRailGuide=true );
// rotate([180,0,0]) EB_LowerElectronics_Bay(Tube_OD=BT75Body_OD, Tube_ID=BT75Body_ID, Len=162, nBolts=5, Bolted=true, TopOnly=true, BottomOnly=false,HasLowerIntegratedCoupler=true);
// EB_LowerElectronics_Bay(Tube_OD=BT75Body_OD, Tube_ID=BT75Body_ID, Len=162, nBolts=5, Bolted=true, TopOnly=false, BottomOnly=true,HasLowerIntegratedCoupler=true);

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

module EB_ExtensionRing(Tube_OD=BT75Body_OD, Tube_ID=BT75Body_ID, Len=21, nBolts=4, BoltInset=7.5){
	FwdCouplerLen=15;
	
	Coupler_OD=Tube_ID-IDXtra*2;
	Coupler_ID=Coupler_OD-6;
	Al_Tube_d=12.7;
	Al_Tube_Z=Al_Tube_d/2+3;
	AftCouplerLen=Al_Tube_d+6;
	OAL=FwdCouplerLen+Len+AftCouplerLen;
	
	translate([0,0,-AftCouplerLen]) // align for viewing
	difference(){
		union(){
			Tube(OD=Coupler_OD, ID=Coupler_ID, Len=OAL, myfn=$preview? 36:360);
		
			translate([0,0,AftCouplerLen])
				Tube(OD=Tube_OD, ID=Coupler_ID, Len=Len, myfn=$preview? 36:360);
				
			CenteringRing(OD=Coupler_OD-1, ID=Coupler_ID-20, Thickness=5, nHoles=0, Offset=0, myfn=$preview? 36:90);
			
			translate([0,0,Al_Tube_Z]) rotate([0,90,180/nBolts]) cylinder(d=Al_Tube_d+6, h=Coupler_ID+Overlap, center=true);
		} // union
		
		// Center hole
		translate([0,0,-Overlap]) cylinder(d=Coupler_ID-20, h=AftCouplerLen+Overlap*2);
		translate([0,0,Al_Tube_Z]) rotate([0,90,180/nBolts]) cylinder(d=Al_Tube_d, h=Coupler_OD+Overlap, center=true);
		
		if (nBolts>0) for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]){
			translate([0,Coupler_OD/2,AftCouplerLen-BoltInset]) rotate([-90,0,0]) Bolt4Hole();
			translate([0,Coupler_OD/2,AftCouplerLen+Len+BoltInset]) rotate([-90,0,0]) Bolt4Hole();
		}
	} // difference
} // EB_ExtensionRing

//EB_ExtensionRing();

module EB_Electronics_Bay(Tube_OD=BT98Body_OD, Tube_ID=BT98Body_ID, Len=162, nBolts=3, BoltInset=7.5, ShowDoors=false, HasSecondBattDoor=true, HasFwdIntegratedCoupler=false, HasFwdShockMount=false){
	// Standard single altimeter bay

	Altimeter_Z=Len/2;
	BattSwDoor_Z=Len/2;

	Alt_a=0;
	Batt1_a=HasSecondBattDoor? 90:120;
	Batt2_a=HasSecondBattDoor? 180:240;
	Batt3_a=270;
	
	FwdBolt_Z=HasFwdIntegratedCoupler? Len-BoltInset:Len-BoltInset;
	IntegratedCoupler_OD=Tube_ID-IDXtra*2;
	IntegratedCoupler_ID=Tube_ID-IDXtra*2-6;
	IntegratedCoupler_Len=HasFwdShockMount? 20:15;
	Al_Tube_d=12.7;
	
	Fwd_Coupler_Adjustment=HasFwdIntegratedCoupler? 15:0;
	Fwd_Al_Tube_Z=Len-Fwd_Coupler_Adjustment+Al_Tube_d/2+1;
	
	difference(){
		union(){
			Tube(OD=Tube_OD, ID=Tube_ID, Len=Len-Fwd_Coupler_Adjustment, myfn=$preview? 36:360);
			
			if (HasFwdIntegratedCoupler) {
				translate([0,0,Len-Fwd_Coupler_Adjustment-5]) 
					Tube(OD=IntegratedCoupler_OD, ID=IntegratedCoupler_ID, Len=IntegratedCoupler_Len+5, myfn=$preview? 36:360);
				translate([0,0,Len-Fwd_Coupler_Adjustment-5]) 
					Tube(OD=Tube_OD, ID=IntegratedCoupler_ID, Len=5, myfn=$preview? 36:360);
				translate([0,0,Len-Fwd_Coupler_Adjustment-5+Overlap]) 
					rotate([180,0,0]) TubeStop(InnerTubeID=IntegratedCoupler_ID, OuterTubeOD=Tube_OD, myfn=$preview? 36:360);
					
				
				// Shock cord mount
				if (HasFwdShockMount){
					difference(){
						intersection(){
							translate([0,0,Fwd_Al_Tube_Z]) 
								rotate([90,0,180/nBolts]) cylinder(d=Al_Tube_d+6, h=IntegratedCoupler_OD, center=true);
								
							translate([0,0,Len-5]) cylinder(d=IntegratedCoupler_OD-1, h=IntegratedCoupler_Len+5);
						} // intersection
						translate([0,0,Fwd_Al_Tube_Z]) 
							rotate([90,0,180/nBolts]) cylinder(d=Al_Tube_d+7, h=20, center=true);
					} // difference
				}
			}
		} // union
		
		if (HasFwdIntegratedCoupler && HasFwdShockMount) {
			translate([0,0,Fwd_Al_Tube_Z]) rotate([90,0,180/nBolts]) cylinder(d=Al_Tube_d, h=Tube_OD, center=true);
			
		}
		
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
			translate([0,-Tube_OD/2-1,FwdBolt_Z]) rotate([90,0,0]) Bolt4Hole();
		} // for
	
		//cube([50,50,200]);
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
// EB_Electronics_Bay(Tube_OD=BT75Body_OD, Tube_ID=BT75Body_ID, Len=162, nBolts=4, BoltInset=7.5, ShowDoors=false, HasSecondBattDoor=false, HasFwdIntegratedCoupler=true, HasFwdShockMount=false);

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




























