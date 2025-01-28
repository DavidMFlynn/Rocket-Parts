// *****************************************************
// Electronics Bay Library
// Project: 3D Printed Rocket
// Filename: ElectronicsBayLib.scad
// by David M. Flynn
// Created: 3/31/2024 
// Revision: 1.3.1  9/21/2024 
// Units: mm
// ***********************************
//  ***** Notes *****
//
// Standard electronics bay design
// Use only EB_Electronics_BayUniversal()
//
//  ***** History *****
//
function ElectronicsBayLibRev()="ElectronicsBayLib Rev. 1.3.1";
echo(ElectronicsBayLibRev());
// 1.3.1  9/21/2024  Made integrated coupler 0.4mm bigger.
// 1.3.0  9/9/2024   Added centering rings to EB_Electronics_BayUniversal(), EB_LowerElectronics_Bay() now calls EB_Electronics_BayUniversal()
// 1.2.1  9/8/2024   Battery doors are 4mm narrower on small rockets (<70mm OD).
// 1.2.0  8/27/2024  Major change: EB_Electronics_BayUniversal()
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
//
//  *** Standard single altimeter bay w/ 2 or 3 battery doors ***
/* EB_Electronics_Bay(Tube_OD=BT98Body_OD, Tube_ID=BT98Body_ID, Len=162, nBolts=3, BoltInset=7.5, ShowDoors=false, 
					HasSecondBattDoor=true, HasFwdIntegratedCoupler=false, HasFwdShockMount=false, 
					HasRailGuide=false, RailGuideLen=35); /**/
//
//  *** Large 2 altimeter electronics bay ***
// EB_Electronics_Bay55(Tube_OD=BT137Body_OD, Tube_ID=BT137Body_ID, Len=162, nBolts=7, BoltInset=7.5, ShowDoors=false, HasRailGuide=false, RailGuideLen=35);
//
//  *** Shock cord attachment and servo space ***
// EB_ExtensionRing(Tube_OD=BT75Body_OD, Tube_ID=BT75Body_ID, Len=21, nBolts=4, BoltInset=7.5);
//
//  *** Universal, uses a list for door type and position ***
/* 
EB_Electronics_BayUniversal(Tube_OD=BT137Body_OD, Tube_ID=BT137Body_ID, DoorAngles=OneAltBay, Len=170, 
									nBolts=6, BoltInset=7.5, ShowDoors=false,
									HasFwdIntegratedCoupler=false, HasFwdShockMount=false,
									HasAftIntegratedCoupler=false, HasAftShockMount=false,
									HasRailGuide=false, RailGuideLen=35,
									HasFwdCenteringRing=false, HasAftCenteringRing=false, InnerTube_OD=BT54Body_OD,
									Bolted=false, ExtraBolts=[], TopOnly=false, BottomOnly=false); 
/**/
//
//  *** Doors ***
// rotate([-90,0,0]) EB_AltDoor(Tube_OD=BT98Body_OD);
// rotate([-90,0,0]) EB_BattDoor(Tube_OD=BT98Body_OD, HasSwitch=false, DoubleBatt=false);
// rotate([-90,0,0]) EB_BattDoor(Tube_OD=BT98Body_OD, HasSwitch=true, DoubleBatt=false);
//
// ***********************************
//  ***** Routines *****
//
// EB_IntegratedCoupler(Tube_OD=BT98Body_OD, Tube_ID=BT98Body_ID, nBolts=3, BoltInset=7.5, HasShockMount=false);
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

//  *** Door Angles ***
// for doors 0° is at 180° (-Y), RailGuide is always at 0° (+Y)
OneAltBay=[[0],[180],[]]; // One altimeter at 0° and one battery door at 180°
ToadBay=[[-72,0],[216,144],[72]]; // Alt and Batt for ignition; Alt, Batt and BattSW for deployment; rail guide.
SimpleOneBattSWBay=[[0],[],[180]];
SimpleTwoBattSWBay=[[0],[],[120,240]];
AltBattOneBattSWBay=[[0],[120],[240]];
AltBattTwoBattSWBay=[[0],[90],[180,270]]; //Alt, Batt, BattSW, BattSW

function EB_BattDoor_X(Tube_OD=BT137Body_OD)=Tube_OD>70? BattDoorX():BattDoorX()-4;

	
module EB_AltDoor(Tube_OD=BT98Body_OD){
	AltDoor54(Tube_OD=Tube_OD, IsLoProfile=false, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowAlt=true);
} // EB_AltDoor

//EB_AltDoor(Tube_OD=BT98Body_OD);

module EB_BattDoor(Tube_OD=BT98Body_OD, HasSwitch=false, DoubleBatt=false){
	Batt_Door(Tube_OD=Tube_OD, Door_X=EB_BattDoor_X(Tube_OD=Tube_OD), InnerTube_OD=0, HasSwitch=HasSwitch, DoubleBatt=DoubleBatt);
} // EB_BattDoor

//EB_BattDoor(Tube_OD=BT98Body_OD, HasSwitch=false);

module EB_LowerElectronics_Bay(Tube_OD=BT98Body_OD, Tube_ID=BT98Body_ID, Len=162, nBolts=5, BoltInset=7.5, ShowDoors=false,
								Bolted=false, TopOnly=false, BottomOnly=false, HasLowerIntegratedCoupler=false, 
								HasRailGuide=false, RailGuideLen=35){
	// One Battery Door w/o Switch and One Altimeter for sustainer lower e-bay.
	
	LowerAltBayDoors=[[90],[270],[]];
	
	EB_Electronics_BayUniversal(Tube_OD=Tube_OD, Tube_ID=Tube_ID, DoorAngles=LowerAltBayDoors, Len=Len, 
									nBolts=nBolts, BoltInset=BoltInset, ShowDoors=false,
									HasFwdIntegratedCoupler=true, HasFwdShockMount=false,
									HasAftIntegratedCoupler=HasLowerIntegratedCoupler, HasAftShockMount=false,
									HasRailGuide=HasRailGuide, RailGuideLen=RailGuideLen,
									HasFwdCenteringRing=true, HasAftCenteringRing=HasLowerIntegratedCoupler, InnerTube_OD=BT54Body_OD,
									Bolted=true, ExtraBolts=[90], TopOnly=false, BottomOnly=false);

} // EB_LowerElectronics_Bay

// EB_LowerElectronics_Bay(Tube_OD=BT75Body_OD, Tube_ID=BT75Body_ID, Len=162, nBolts=5, Bolted=true, TopOnly=false, BottomOnly=false,HasLowerIntegratedCoupler=true, HasRailGuide=true );
// rotate([180,0,0]) EB_LowerElectronics_Bay(Tube_OD=BT75Body_OD, Tube_ID=BT75Body_ID, Len=162, nBolts=5, Bolted=true, TopOnly=true, BottomOnly=false,HasLowerIntegratedCoupler=true);
// EB_LowerElectronics_Bay(Tube_OD=BT75Body_OD, Tube_ID=BT75Body_ID, Len=162, nBolts=5, Bolted=true, TopOnly=false, BottomOnly=true,HasLowerIntegratedCoupler=true);

// EB_LowerElectronics_Bay(Tube_OD=BT65Body_OD, Tube_ID=BT65Body_ID, Len=162, nBolts=4, Bolted=true, TopOnly=false, BottomOnly=true,HasLowerIntegratedCoupler=true);

module EB_Electronics_Bay3(Tube_OD=BT75Body_OD, Tube_ID=BT75Body_ID, Len=162, nBolts=3, BoltInset=7.5, DualDeploy=false, ShowDoors=false){
	// One/two Battery Door w/ Switch and One Altimeter
	
	DA=DualDeploy? SimpleTwoBattSWBay:SimpleOneBattSWBay;
	
	EB_Electronics_BayUniversal(Tube_OD=Tube_OD, Tube_ID=Tube_ID, DoorAngles=DA, Len=Len, 
									nBolts=nBolts, BoltInset=BoltInset, ShowDoors=ShowDoors,
									HasRailGuide=false, RailGuideLen=35);
	
} // EB_Electronics_Bay3

// EB_Electronics_Bay3(DualDeploy=false);

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
//EB_ExtensionRing(Tube_OD=BT65Body_OD, Tube_ID=BT65Body_ID, Len=8, nBolts=4, BoltInset=7.5);

module EB_IntegratedCoupler(Tube_OD=BT98Body_OD, Tube_ID=BT98Body_ID, nBolts=3, BoltInset=7.5, HasShockMount=false){
	IntegratedCoupler_OD=Tube_ID;
	IntegratedCoupler_ID=Tube_ID-6;
	IntegratedCoupler_Len=HasShockMount? 17:15;
	
	Al_Tube_d=12.7;
	Al_Tube_Z=Al_Tube_d/2+1;
	Al_Tube_a=0; //was 180/nBolts;
	
	difference(){
		union(){
			translate([0,0,-5]) 
				Tube(OD=IntegratedCoupler_OD, ID=IntegratedCoupler_ID, Len=IntegratedCoupler_Len+5, myfn=$preview? 36:360);
			translate([0,0,-5]) 
				Tube(OD=Tube_OD, ID=IntegratedCoupler_ID, Len=5, myfn=$preview? 36:360);
			translate([0,0,-5+Overlap]) 
				rotate([180,0,0]) TubeStop(InnerTubeID=IntegratedCoupler_ID, OuterTubeOD=Tube_OD, myfn=$preview? 36:360);
				
			// Shock cord mount
			if (HasShockMount){
				difference(){
					intersection(){
						translate([0, 0, Al_Tube_Z]) 
							rotate([90, 0, Al_Tube_a]) cylinder(d=Al_Tube_d+6, h=IntegratedCoupler_OD, center=true);
							
						translate([0,0,-5]) cylinder(d=IntegratedCoupler_OD-1, h=IntegratedCoupler_Len+5);
					} // intersection
					translate([0,0,Al_Tube_Z]) 
						rotate([90, 0, Al_Tube_a]) cylinder(d=Al_Tube_d+7, h=IntegratedCoupler_ID-20, center=true);
				} // difference
				}
		} // union
		
		if (HasShockMount) 
			translate([0,0,Al_Tube_Z]) rotate([90, 0, Al_Tube_a]) 
				cylinder(d=Al_Tube_d, h=Tube_OD, center=true);
				
		//Bolt holes for nosecone and ball lock
		if (nBolts>0) for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+180/nBolts])
			translate([0, -Tube_OD/2-1, BoltInset]) rotate([90,0,0]) Bolt4Hole();
	} // difference
} // EB_IntegratedCoupler

// EB_IntegratedCoupler(HasShockMount=true);

module EB_Electronics_Bay(Tube_OD=BT98Body_OD, Tube_ID=BT98Body_ID, Len=162, nBolts=3, BoltInset=7.5, ShowDoors=false, 
					HasSecondBattDoor=true, HasFwdIntegratedCoupler=false, HasFwdShockMount=false, 
					HasRailGuide=false, RailGuideLen=35){
	// Standard single altimeter bay

	DA=HasSecondBattDoor? AltBattTwoBattSWBay:AltBattOneBattSWBay;
	
	
	EB_Electronics_BayUniversal(Tube_OD=Tube_OD, Tube_ID=Tube_ID, DoorAngles=DA, Len=Len, 
									nBolts=nBolts, BoltInset=BoltInset, ShowDoors=ShowDoors,
									HasFwdIntegratedCoupler=HasFwdIntegratedCoupler, HasFwdShockMount=HasFwdShockMount,
									HasAftIntegratedCoupler=false, HasAftShockMount=false,
									HasRailGuide=HasRailGuide, RailGuideLen=RailGuideLen);
	
	
} // EB_Electronics_Bay

// EB_Electronics_Bay(Tube_OD=BT75Body_OD, Tube_ID=BT75Body_ID, Len=162, nBolts=4, BoltInset=7.5, ShowDoors=false, HasSecondBattDoor=false, HasFwdIntegratedCoupler=true, HasFwdShockMount=false);


module EB_Electronics_Bay55(Tube_OD=BT137Body_OD, Tube_ID=BT137Body_ID, Len=162, nBolts=7, BoltInset=7.5, ShowDoors=false,
							HasRailGuide=false, RailGuideLen=35, TopOnly=false, BottomOnly=false){
	// Large 2 altimeter electronics bay
	AltDoorInc_a=27.5;
	BattDoorInc_a=58.75;
	Batt2DoorInc_a=62.5;
	Big55Bay=[[-AltDoorInc_a,AltDoorInc_a],[-AltDoorInc_a-BattDoorInc_a,AltDoorInc_a+BattDoorInc_a],[-AltDoorInc_a-BattDoorInc_a-Batt2DoorInc_a,AltDoorInc_a+BattDoorInc_a+Batt2DoorInc_a]]; // Original Bay55

	EBayCR_t=5;
	TubeStop_Z=BoltInset*2+EBayCR_t+1.9;
	
	if (HasRailGuide==false){
		EB_Electronics_BayUniversal(Tube_OD=Tube_OD, Tube_ID=Tube_ID, DoorAngles=Big55Bay, Len=Len, 
									nBolts=nBolts, BoltInset=BoltInset, ShowDoors=ShowDoors,
									HasRailGuide=HasRailGuide, RailGuideLen=RailGuideLen,
									Bolted=true, ExtraBolts=[], TopOnly=TopOnly, BottomOnly=BottomOnly);
	}else{
		EB_Electronics_BayUniversal(Tube_OD=Tube_OD, Tube_ID=Tube_ID, DoorAngles=ToadBay, Len=Len, 
									nBolts=nBolts, BoltInset=BoltInset, ShowDoors=ShowDoors,
									HasRailGuide=HasRailGuide, RailGuideLen=RailGuideLen,
									Bolted=true, ExtraBolts=[], TopOnly=TopOnly, BottomOnly=BottomOnly);
	}				
	
	// Bottom centering ring stop
	if (!TopOnly) translate([0,0,TubeStop_Z]) 
		TubeStop(InnerTubeID=Tube_ID-5, OuterTubeOD=Tube_OD-2, myfn=$preview? 36:360);
		
	// Top centering ring stop
	if (!BottomOnly) translate([0,0,Len-TubeStop_Z]) rotate([180,0,0])
		TubeStop(InnerTubeID=Tube_ID-5, OuterTubeOD=Tube_OD-2, myfn=$preview? 36:360);
} // EB_Electronics_Bay55

// EB_Electronics_Bay55(Len=170, HasRailGuide=false, RailGuideLen=35);


module EB_Electronics_BayUniversal(Tube_OD=BT137Body_OD, Tube_ID=BT137Body_ID, DoorAngles=OneAltBay, Len=170, 
									nBolts=6, BoltInset=7.5, ShowDoors=false,
									HasFwdIntegratedCoupler=false, HasFwdShockMount=false,
									HasAftIntegratedCoupler=false, HasAftShockMount=false,
									HasRailGuide=false, RailGuideLen=35,
									HasFwdCenteringRing=false, HasAftCenteringRing=false, InnerTube_OD=BT54Body_OD,
									Bolted=false, ExtraBolts=[], TopOnly=false, BottomOnly=false){
	
	Altimeter_Z=HasRailGuide? 80:Len/2;
	BattSwDoor_Z=HasRailGuide? 80:Len/2;
	
	AltDoorAngles=DoorAngles[0];
	BattDoorAngles=DoorAngles[1];
	BattSWDoorAngles=DoorAngles[2];
	
	RailGuide_Z=Len-15-RailGuideLen;
	RailGuide_a=0;
	
	Mod1=HasFwdIntegratedCoupler? 1:0;
	Mod2=HasAftIntegratedCoupler? 1:0;
	LA=[Len,Len-15,Len-30];
	Idx=Mod1+Mod2;
	
	Body_Len=LA[Idx];
	Body_Z=HasAftIntegratedCoupler? 15:0;
	
	Bolt4Inset=4;
	Bolted_ID=Tube_ID-Bolt4Inset*4;
	BoltCircle_r=Tube_ID/2-Bolt4Inset;
	
	CenteringRing_t=5;
	CenteringRing_ID=InnerTube_OD+IDXtra*2; // slide thru fit
	FwdCenteringRing_OD=HasFwdIntegratedCoupler? Tube_ID-1:Tube_OD-1;
	AftCenteringRing_OD=HasAftIntegratedCoupler? Tube_ID-1:Tube_OD-1;
	FwdCenteringRing_Z=HasFwdIntegratedCoupler? Len-CenteringRing_t:Len-BoltInset*2-CenteringRing_t-1;
	AftCenteringRing_Z=HasAftIntegratedCoupler? 0:BoltInset*2+1;
	
	function Calc_a(Dist=1,R=2)=Dist/(R*2*PI)*360;
	
	module BoltHole(){
		if (!BottomOnly)
			translate([0, -BoltCircle_r, Len/2+6]) Bolt4HeadHole(depth=4);
					
		if (!TopOnly)
			translate([0, -BoltCircle_r, Len/2]) Bolt4Hole(depth=12);
	} // BoltHole

	difference(){
		union(){
			if (HasFwdCenteringRing) translate([0,0,FwdCenteringRing_Z])
				CenteringRing(OD=FwdCenteringRing_OD, ID=CenteringRing_ID, Thickness=CenteringRing_t, nHoles=5, Offset=0);
			
			if (HasAftCenteringRing) translate([0,0,AftCenteringRing_Z])
				CenteringRing(OD=AftCenteringRing_OD, ID=CenteringRing_ID, Thickness=CenteringRing_t, nHoles=5, Offset=0);
				
			translate([0,0,Body_Z]) Tube(OD=Tube_OD, ID=Tube_ID, Len=Body_Len, myfn=$preview? 36:360);
			
			if (HasRailGuide)
				translate([0,0,RailGuide_Z]) difference(){
					rotate([0,0,RailGuide_a]) 
						RailGuidePost(OD=Tube_OD, MtrTube_OD=0, H=Tube_OD/2+2, 
										TubeLen=55, Length = RailGuideLen, BoltSpace=12.7, AddTaper=false);
					cylinder(d=Tube_ID-1.2, h=60, center=true);			
				} // difference
				
			if (HasFwdIntegratedCoupler) translate([0,0,Len-15])
				EB_IntegratedCoupler(Tube_OD=Tube_OD, Tube_ID=Tube_ID, 
									nBolts=nBolts, BoltInset=BoltInset, HasShockMount=HasFwdShockMount);
									
			if (HasAftIntegratedCoupler) translate([0,0,15]) rotate([180,0,0])
				EB_IntegratedCoupler(Tube_OD=Tube_OD, Tube_ID=Tube_ID, 
									nBolts=nBolts, BoltInset=BoltInset, HasShockMount=HasAftShockMount);
									
			if (Bolted)
				difference(){
					translate([0,0,Len/2-10]) cylinder(d=Tube_OD-1, h=20);
						
					translate([0,0,Len/2-10-Overlap]) cylinder(d=Bolted_ID, h=20+Overlap*2);
					translate([0,0,Len/2-10-Overlap]) cylinder(d1=Tube_ID, d2=Bolted_ID, h=7);
					translate([0,0,Len/2+3]) cylinder(d2=Tube_ID, d1=Bolted_ID, h=7+Overlap);
					
					// door holes
					for (j=AltDoorAngles) rotate([0,0,j]) 
						translate([0,-30,Len/2]) cube([39.2,Tube_OD,21], center=true);
						
					for (j=BattDoorAngles) rotate([0,0,j]) 
						translate([0,-30,Len/2]) cube([EB_BattDoor_X(Tube_OD=Tube_OD)-5,Tube_OD,21], center=true); // 47.6

					for (j=BattSWDoorAngles) rotate([0,0,j]) 
						translate([0,-30,Len/2]) cube([EB_BattDoor_X(Tube_OD=Tube_OD)-5,Tube_OD,21], center=true);
					
					AltBolt_a=Calc_a(Dist=24+Bolt4Inset,R=BoltCircle_r);
					BattBolt_a=Calc_a(Dist=28+Bolt4Inset,R=BoltCircle_r);
					// Bolts
					for (j=AltDoorAngles){
						rotate([0,0,j+AltBolt_a]) BoltHole();
						rotate([0,0,j-AltBolt_a]) BoltHole();
						for (k=ExtraBolts) rotate([0,0,j+k]) BoltHole();
					}
					for (j=BattDoorAngles){
						rotate([0,0,j+BattBolt_a]) BoltHole();
						rotate([0,0,j-BattBolt_a]) BoltHole();
						for (k=ExtraBolts) rotate([0,0,j+k]) BoltHole();
					}
					for (j=BattSWDoorAngles){
						rotate([0,0,j+BattBolt_a]) BoltHole();
						rotate([0,0,j-BattBolt_a]) BoltHole();
						for (k=ExtraBolts) rotate([0,0,j+k]) BoltHole();
					}
					
				} // difference
		} // union
		
		// Altimeter(s)
		for (j=AltDoorAngles)
		translate([0,0,Altimeter_Z]) rotate([0,0,j]) 
			Alt_BayFrameHole(Tube_OD=Tube_OD, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y);

		// Battery and Switch door holes
		for (j=BattDoorAngles)
		translate([0,0,BattSwDoor_Z]) rotate([0,0,j]) 
			Batt_BayFrameHole(Tube_OD=Tube_OD, Door_X=EB_BattDoor_X(Tube_OD=Tube_OD), HasSwitch=false);
		
		for (j=BattSWDoorAngles)
		translate([0,0,BattSwDoor_Z]) rotate([0,0,j]) 
			Batt_BayFrameHole(Tube_OD=Tube_OD, Door_X=EB_BattDoor_X(Tube_OD=Tube_OD), HasSwitch=true);
		
		
		//Bolt holes for nosecone and ball lock
		if (nBolts>0)
		for (j=[0:nBolts-1]) rotate([0, 0, 360/nBolts*j+180/nBolts]){
			if (!HasAftIntegratedCoupler) translate([0, -Tube_OD/2-1, BoltInset]) rotate([90,0,0]) Bolt4Hole();
			if (!HasFwdIntegratedCoupler) translate([0, -Tube_OD/2-1, Len-BoltInset]) rotate([90,0,0]) Bolt4Hole();
		} // for
		
		if (HasRailGuide) rotate([0,0,RailGuide_a]) 
			translate([0,Tube_OD/2+2,RailGuide_Z]) RailGuideBoltPattern(BoltSpace=12.7) Bolt6Hole();
	
		if (TopOnly) translate([0,0,-10]) cylinder(d=Tube_OD+10, h=Len/2+10);
		if (BottomOnly) translate([0,0,Len/2]) cylinder(d=Tube_OD+10, h=Len/2+10);

	} // difference
	
	difference(){
		union(){
			// Altimeter
			for (j=AltDoorAngles)
			translate([0,0,Altimeter_Z]) rotate([0,0,j])
				Alt_BayDoorFrame(Tube_OD=Tube_OD, Tube_ID=Tube_ID, 
						DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowDoor=ShowDoors);
			
			// Battery and Switch doors
			for (j=BattDoorAngles)
			translate([0,0,BattSwDoor_Z]) rotate([0,0,j]) 
				Batt_BayDoorFrame(Tube_OD=Tube_OD, Door_X=EB_BattDoor_X(Tube_OD=Tube_OD), HasSwitch=false, ShowDoor=ShowDoors);

			for (j=BattSWDoorAngles)
			translate([0,0,BattSwDoor_Z]) rotate([0,0,j]) 
				Batt_BayDoorFrame(Tube_OD=Tube_OD, Door_X=EB_BattDoor_X(Tube_OD=Tube_OD), HasSwitch=true, ShowDoor=ShowDoors);
		} // union
		
		if (TopOnly) translate([0,0,-10]) cylinder(d=Tube_OD+10, h=Len/2+10);
		if (BottomOnly) translate([0,0,Len/2]) cylinder(d=Tube_OD+10, h=Len/2+10);
	} // difference
		
} // EB_Electronics_BayUniversal

/*
EB_Electronics_BayUniversal(Tube_OD=BT75Body_OD, Tube_ID=BT75Body_ID, DoorAngles=OneAltBay, Len=162, 
									nBolts=4, BoltInset=7.5, ShowDoors=false,
									HasFwdIntegratedCoupler=true, HasFwdShockMount=false,
									HasAftIntegratedCoupler=true, HasAftShockMount=false,
									HasRailGuide=false, RailGuideLen=35,
									HasFwdCenteringRing=true, HasAftCenteringRing=true, InnerTube_OD=BT54Body_OD,
									Bolted=false, ExtraBolts=[], TopOnly=false, BottomOnly=false);
/**/
							
//EB_Electronics_BayUniversal(Tube_OD=BT137Body_OD, Tube_ID=BT137Body_ID, DoorAngles=ToadBay, Len=170, nBolts=6, BoltInset=7.5, ShowDoors=false, HasFwdIntegratedCoupler=true, HasFwdShockMount=false, HasAftIntegratedCoupler=true, HasAftShockMount=false,HasRailGuide=false, RailGuideLen=35, HasFwdCenteringRing=false, HasAftCenteringRing=false, InnerTube_OD=BT54Body_OD, Bolted=true);


//EB_Electronics_BayUniversal(Tube_OD=BT65Body_OD, Tube_ID=BT65Body_ID, DoorAngles=SimpleOneBattSWBay, Len=162, nBolts=4, BoltInset=7.5, ShowDoors=false, HasFwdIntegratedCoupler=true, HasFwdShockMount=false, HasAftIntegratedCoupler=false, HasAftShockMount=false,HasRailGuide=false, RailGuideLen=35, HasFwdCenteringRing=false, HasAftCenteringRing=false, InnerTube_OD=BT54Body_OD, Bolted=true);





















