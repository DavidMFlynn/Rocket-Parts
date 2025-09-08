// ***********************************************
// Project: Rocket Rotiserie Drive
// Filename: RocketRotiserieDrive.scad
// by David M. Flynn
// Created: 12/21/2024
// Revision: 1.0.1  12/29/2024
// Units: mm
// *******************************************************
//  ***** Notes *****
//
// Built and tested the first one 12/24/2024
//
// A rotisserie for rocket tubes.  Both ends are held securly with internal chucks.
//
// I used a surplus motor I had in a box. 
// To fit your motor edit: MotorHoles() and SunGear().
// Looks like about 4RPM is good for coating a 4" tube, 1.8 volts and less than an 1 amp.
// Going with 3 stages. Should be able to use a 5V 2A wall wort.
//
// Sun=15t, Planets=24t, Ring=63t, 5.2:1 Reduction,
//	 27.04:1 Reduction for 2 stages, 
//   140.608:1 Reduction for 3 stages
// Motor: 24v 4.5A max., 4000RPM / 27.04 = 147RPM max. / 140.608 = 28RPM max.
//
//  *** Hardware ***
// #4-40 x 3/8" BHCS	16 Bearing Clamps
// #4-40 x 1/2" SHCS	48 Output Bearing Plate, Reducer Ring Gear, Threaded Mount
// #4-40 x 5/8" SHCS    12 Output Shaft to Drive Plate
// #4-40 x 3/4" SHCS	6 Plant carriers
// 1/4-20 x 1/2 Nylon Pan Head for chuck locks
//
// 6810-2RS Ball Bearing	2 Output Shaft
// R8-ZZ					6 Planets
//
// Quantities are for both head stock and tail stock.
//
//  ***** History *****
//
// 1.0.1  12/29/2024   Added threaded option to Chuck(), friction fit chuck
// 1.0.0  12/24/2024   A better foot. Printed and tested.
// 0.9.2  12/23/2024   Added bolt offset (ForSecondRing=true) to OutputBearingPlate()
// 0.9.1  12/22/2024   Fixed sun gear, triangular planet carriers, 2nd Stage
// 0.9.0  12/21/2024   First code
//
// *******************************************************
//  ***** for STL output *****
//
// ShaftSpacer(Thickness=3);	// Print 2
// rotate([180,0,0]) OutputShaft();	// Print 2
// BearingClamp();		// Print 2
// OutputBearingPlate(ForSecondRing=false);
// DrivePlate();		// Print 2
// SunGear();
// BB_Planet();			// Print 6
// PlanetCarrier();
// MotorMount();
// Foot(XtraHeight=5); // print 6
//
//  *** 2nd Stage ***
//
// OutputBearingPlate(ForSecondRing=true);
// ReducerRingGear();
// SecondStageSun();
// PlanetCarrier(CenterHole_r=PitchRadius(nSunTeeth)+6);
//
//  *** Tooling ***
//
// ThreadedMount();
//
// Chuck2(OD=ULine102Body_ID, nLocks=4, Threaded=true);
// Chuck2(OD=ULine157Body_ID*CF_Comp+0.5, nLocks=0, Threaded=true); // press fit
// Chuck2(OD=ULine203Body_ID, nLocks=6, Threaded=true);
// ChuckLock();
//
// Chuck(OD=BT54Body_ID);
// Chuck(OD=BT75Body_ID);
// SmallTubeChuck(OD=ULine38Body_ID);
// Chuck2(OD=215.9*CF_Comp, nLocks=0); // for Stubby
//
// *******************************************************
//  ***** Routines *****
//
function PitchRadius(T=15)=PlanetaryPitch*T/360;
// Chuck(OD=ULine203Body_ID, Threaded=true); // Bolt on friction fit
// ChuckInternalThread(Len=30);
// Legs();
// MotorHoles();
// ReducerShim(); // fix for a mistake
//
// *******************************************************
//  ***** for Viewing *****
//
// ShowPlanets();
// ShowSecondStage();
// ShowDrive();
//
// *******************************************************
include<TubesLib.scad>
include<PlanetDriveLib.scad>
use<ThreadLib.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 36:90;

PlanetaryPitch=360;
Pressure_a=24;
nPlanetTeeth=24;
nPlanets=3;
nSunTeeth=15;
GearWidth=10;
PlanetCarrier_t=3;

MR84_Bearing_OD=8;
MR84_Bearing_ID=4;
MR84_Bearing_t=3;

R8_Bearing_OD=28.56;
R8_Bearing_ID=12.7;
R8_Bearing_t=7.9;

PlanetBB_OD=R8_Bearing_OD;
PlanetBB_ID=R8_Bearing_ID;
PlanetBB_t=R8_Bearing_t;
R8_BearingMod=-0.3; // Reduce the diameter of the bearing posts, 0 is too tight

// 6810-2RS
DriveBearing_OD=65;
DriveBearing_ID=50;
DriveBearing_t=7;

nDriveBolts=6;
DriveSidePlanetCarrier_t=6;

Bolt4Inset=4;

ChuckMount_Pitch=5; // Thread Pitch
ChuckMount_d=50;	// Thread nominal diameter

module ShaftSpacer(Thickness=1){
	T=Thickness;
	
	difference(){
		cylinder(d=DriveBearing_ID+6, h=T);
		translate([0,0,-Overlap]) cylinder(d=DriveBearing_ID+IDXtra*2, h=T+Overlap*2);
	} // difference
	
} // ShaftSpacer

// translate([0,0,GearWidth+DriveSidePlanetCarrier_t+1]) color("Tan") ShaftSpacer();

module ChuckLock(){
	W=6;
	Angle=30;
	Len=10;
	
	difference(){
		union(){
			hull(){
				cylinder(d=3, h=W);
				translate([10,0,0]) cylinder(d=4, h=W);
			}
			hull(){
				translate([10,0,0]) cylinder(d=4, h=W);
				translate([10,0,0]) rotate([0,0,Angle]) translate([Len,0,0]) cylinder(d=3, h=W);
			} // hull
			translate([10,0,0]) cylinder(d=5, h=W);
			
			// rubber band
			translate([12,0,0])difference(){
				hull(){
					cylinder(d=3, h=W);
					translate([6,0,0]) cylinder(d=3, h=W);
				} // hull
				
				translate([5.5,1.5,-Overlap]) cylinder(d=2, h=W+Overlap*2);
			} // difference
		} // union
		
		translate([10,0,-Overlap]) cylinder(d=2, h=W+Overlap*2);
	} // difference
		
} // ChuckLock

//translate([3,44,14]) rotate([0,-90,0]) translate([-10,0,0]) color("Tan") ChuckLock();

module Chuck2(OD=ULine203Body_ID, nLocks=6, Threaded=true){
	// Press-in friction fit chuck
	
	ChuckMountPlate_d=80;
	ChuckMountPlate_t=8;
	nChuckMountingBolts=8;
	
	module Lock(){
		translate([0,3,6]) rotate([90,0,0])
				if ($preview) {
					cylinder(d=5, h=10);
				}else{
					ExternalThread(Pitch=25.4/20, Dia_Nominal=6.35, Length=10, Step_a=5, TrimEnd=false, TrimRoot=false);
				}
		translate([-4,-12,-Overlap]) cube([8,7,12]);
		translate([-4,-8.5,-Overlap]) cube([8,5,26]);
		
		translate([0,-7,14]) rotate([0,90,0]) cylinder(d=5.4, h=8, center=true);
		translate([-4,-11,9]) rotate([-22.5,0,0]) cube([8,8,18.5]);
		
	} // Lock
	
	difference(){
		union(){
			// Hub
			cylinder(d=ChuckMountPlate_d-1, h=ChuckMountPlate_t);
			if (Threaded) cylinder(d=ChuckMount_d+10, h=20);
			
			
			// Rim
			difference(){
				union(){
					translate([0,0,12]) cylinder(d1=OD, d2=OD-1, h=18, $fn=$preview? 90:360);
					cylinder(d=OD+6, h=12+Overlap, $fn=$preview? 90:360);
				} // union
				cylinder(d=OD-10, h=31, $fn=$preview? 90:360);
			} // difference
			
			// Plate
			cylinder(d=OD-1, h=3);
			
			// Lock pivots
			Block_Y=10;
			for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]) 
				translate([-10,OD/2-3-Block_Y,0]) cube([20,Block_Y,18]);
		} // union
		
		if (Threaded) ChuckInternalThread(Len=30);
		
		// Locks
		for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j]) translate([0,OD/2,0]) Lock();
		
		// Remove Center 
		if (!Threaded)
		translate([0,0,-Overlap]) cylinder(d=DriveBearing_OD, h=ChuckMountPlate_t+Overlap*2);
		
		// Hub bolts
		if (!Threaded)
		for (j=[0:nChuckMountingBolts-1]) rotate([0,0,360/nChuckMountingBolts*j]) 
			translate([0,ChuckMountPlate_d/2-Bolt4Inset,ChuckMountPlate_t])
				Bolt4HeadHole();
		
		if ($preview) translate([0,0,-10])  cube([100,100,100]);
	} // difference
} // Chuck2

// Chuck2(OD=ULine102Body_ID, nLocks=4);
				
module Chuck(OD=ULine203Body_ID, Threaded=true){
	// Press-in friction fit chuck
	
	ChuckMountPlate_d=80;
	ChuckMountPlate_t=8;
	nChuckMountingBolts=8;
	
	difference(){
		union(){
			// Hub
			cylinder(d=ChuckMountPlate_d-1, h=ChuckMountPlate_t, $fn=$preview? 90:360);
			
			// Rim
			difference(){
				cylinder(d1=OD+2, d2=OD-2, h=30, $fn=$preview? 90:360);
				cylinder(d=OD-10, h=31, $fn=$preview? 90:360);
			} // difference
			
			// Plate
			cylinder(d=OD-1, h=3);
		} // union
		
		if (Threaded) ChuckInternalThread(Len=30);
		
		// Remove Center 
		if (!Threaded)
			translate([0,0,-Overlap]) cylinder(d=DriveBearing_OD, h=ChuckMountPlate_t+Overlap*2);
		
		// Hub bolts
		if (!Threaded)
			for (j=[0:nChuckMountingBolts-1]) rotate([0,0,360/nChuckMountingBolts*j]) 
				translate([0,ChuckMountPlate_d/2-Bolt4Inset,ChuckMountPlate_t])
					Bolt4HeadHole();
		
	} // difference
} // Chuck

// Chuck(OD=ULine102Body_ID);

// Chuck(OD=BT54Body_ID);

module SmallTubeChuck(OD=ULine203Body_ID){
	// Press-in friction fit chuck
	
	ChuckMountPlate_d=80;
	Nut_OD=60;
	Thread_Len=25;
	ChuckMountPlate_t=8;
	nChuckMountingBolts=8;
	Taper_Len=30;
	StopPlate_t=3;
	
	difference(){
		union(){
			// Hub
			cylinder(d=ChuckMountPlate_d, h=ChuckMountPlate_t, $fn=$preview? 90:360);
			
			// Nut
			cylinder(d=Nut_OD, h=Thread_Len+StopPlate_t);
			
			// Rim
			translate([0,0,Thread_Len+StopPlate_t-Overlap])
				cylinder(d1=OD+2, d2=OD-2, h=Taper_Len, $fn=$preview? 90:360);
	
		} // union
		
		ChuckInternalThread(Len=Thread_Len);
				
		translate([0,0,Thread_Len-Overlap])
			cylinder(d=OD-10, h=Taper_Len+StopPlate_t+Overlap*2, $fn=$preview? 90:360);
			
		//cube([100,100,100]);
	} // difference
} // SmallTubeChuck

//SmallTubeChuck(OD=ULine38Body_ID);


module ChuckInternalThread(Len=30){
	ThreadIDXtra=1.0;
	
	translate([0,0,-Overlap]) 
		ExternalThread(Pitch=ChuckMount_Pitch, Dia_Nominal=ChuckMount_d+ThreadIDXtra, 
					Length=Len+Overlap*2, Step_a=$preview? 10:2, TrimEnd=false, TrimRoot=false);
} // ChuckInternalThread

// ChuckInternalThread(Len=30);

module ThreadedMount(){
	ChuckMount_Len=30;
	nChuckMountingBolts=8;
	ChuckMountPlate_d=80;
	CenterHole_d=ChuckMount_d-ChuckMount_Pitch*2-6;
	Plate_t=8;
	
	difference(){
		union(){
			ExternalThread(Pitch=ChuckMount_Pitch, Dia_Nominal=ChuckMount_d, 
						Length=ChuckMount_Len, Step_a=$preview? 20:2, TrimEnd=true,TrimRoot=false);
			cylinder(d=ChuckMountPlate_d, h=Plate_t, $fn=$preview? 90:360);
		} // union
		
		// Wrench hole
		translate([0,0,Plate_t/2]) rotate([90,0,180/nChuckMountingBolts]) cylinder(d=4, h=ChuckMountPlate_d+1, center=true);
		
		// center hole
		translate([0,0,-Overlap]) cylinder(d=CenterHole_d, h=ChuckMount_Len+Overlap*2);
		
		for (j=[0:nChuckMountingBolts-1]) rotate([0,0,360/nChuckMountingBolts*j]) 
			translate([0,ChuckMountPlate_d/2-Bolt4Inset,Plate_t])
				Bolt4HeadHole();
	} // difference
	
} // ThreadedMount

// ThreadedMount();

module OutputShaft(){
	Shaft_Len=24;
	ChuckMountPlate_d=80;
	ChuckMountPlate_t=8;
	nChuckMountingBolts=8;
	
	difference(){
		union(){
			cylinder(d=DriveBearing_ID, h=Shaft_Len);
			translate([0,0,3+DriveBearing_t]) cylinder(d=DriveBearing_ID+4, h=6);
			translate([0,0,Shaft_Len-ChuckMountPlate_t]) cylinder(d=ChuckMountPlate_d,h=ChuckMountPlate_t);
		} // union
		
		// center hole
		translate([0,0,-Overlap]) cylinder(d=DriveBearing_ID-Bolt4Inset*4-2, h=Shaft_Len+Overlap*2);
		
		for (j=[0:nDriveBolts]) rotate([0,0,360/nDriveBolts*j])
		  translate([DriveBearing_ID/2-Bolt4Inset,0,6+DriveBearing_t])
			Bolt4HeadHole(depth=Shaft_Len, lHead=Shaft_Len);
			
		for (j=[0:nChuckMountingBolts-1]) rotate([0,0,360/nChuckMountingBolts*j]) 
			translate([0,ChuckMountPlate_d/2-Bolt4Inset,Shaft_Len])
				Bolt4Hole();
	} // difference
} // OutputShaft

//translate([0,0,GearWidth+DriveSidePlanetCarrier_t+1]) OutputShaft();

module BearingClamp(){
	Plate_t=3;
	nBearingRetainerBolts=8;
	OD=DriveBearing_OD+Bolt4Inset*4;
	ID=DriveBearing_OD-4;
	
	difference(){
		cylinder(d=OD, h=Plate_t);
		
		translate([0,0,-Overlap]) cylinder(d=ID, h=Plate_t+Overlap*2);
		
		for (j=[0:nBearingRetainerBolts-1]) rotate([0,0,360/nBearingRetainerBolts*j]) 
			translate([0,DriveBearing_OD/2+Bolt4Inset,Plate_t+1])
				Bolt4ButtonHeadHole();
	} // difference
} // BearingClamp

// translate([0,0,GearWidth+DriveSidePlanetCarrier_t+2.2+DriveBearing_t+2.2]) BearingClamp();

module Foot(XtraHeight=0){
	Plate_t=10;
	Foot_W=60;
	Foot_L=80;
	R=5;
	
	difference(){
		union(){
			hull(){
				translate([-Plate_t,0,0]) cube([Plate_t,Foot_W,Overlap]);
				translate([0,R,Plate_t+Bolt4Inset*4+XtraHeight-R]) rotate([0,-90,0]) cylinder(r=R, h=Plate_t);
				translate([0,Foot_W-R,Plate_t+Bolt4Inset*4+XtraHeight-R]) rotate([0,-90,0]) cylinder(r=R, h=Plate_t);
			} // hull
			
			translate([-Overlap,0,0]) cube([Plate_t+Overlap,Foot_W,Plate_t+XtraHeight]);
			
			translate([-Foot_L/2+Plate_t*2,Foot_W/2,0]) RoundRect(X=Foot_L, Y=Foot_W, Z=Plate_t, R=R);
		} // union
	
		translate([-Foot_L/2,Foot_W/2,Plate_t]) BoltM8ButtonHeadHole(); //BoltM8ClearHole();
		
		translate([-Plate_t,0,Plate_t+Bolt4Inset*2+XtraHeight])
			for (j=[0:4]) translate([0,10*j+10,0]) rotate([0,-90,0]) Bolt4HeadHole();
			
	} // difference
} // Foot

// Foot(XtraHeight=5);

module Legs(){
	Plate_t=DriveBearing_t+2;
	Foot_Height=120;
	Foot_Len=60;
	Plate_d=150;
	
	difference(){
		union(){
			hull(){
				cylinder(d=40, h=Plate_t);
				translate([Foot_Height-Plate_t,Foot_Len/2,0]) cube([Plate_t,Foot_Len,Plate_t]);
			} // hull
			hull(){
				cylinder(d=40, h=Plate_t);
				translate([Foot_Height-Plate_t,-Foot_Len*1.5,0]) cube([Plate_t,Foot_Len,Plate_t]);
			} // hull
		} // union
		
		translate([0,0,-Overlap]) cylinder(d=Plate_d-1, h=Plate_t+Overlap*2);
		
		translate([Foot_Height-Bolt4Inset*2,Foot_Len/2,Plate_t]) 
			for (j=[0:4]) translate([0,10*j+10,0]) Bolt4Hole();
			
		translate([Foot_Height-Bolt4Inset*2,-Foot_Len/2,Plate_t]) 
			for (j=[0:4]) translate([0,-10*j-10,0]) Bolt4Hole();
	} // difference
} // Legs

// Legs();

module OutputBearingPlate(ForSecondRing=false){
	Plate_t=DriveBearing_t+2;
	Plate_d=150;
	nBolts=16;
	nBearingRetainerBolts=8;
	Offset_a=ForSecondRing? 0.5:0;
	
	difference(){
		union(){
			cylinder(d=Plate_d, h=Plate_t);
			Legs();
		} // union
		
		
		// Ring Gear Bolts
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*(j+Offset_a)]) translate([0,Plate_d/2-Bolt4Inset,Plate_t])
				Bolt4HeadHole();
				
		translate([0,0,-Overlap]) cylinder(d=DriveBearing_OD-1, h=Plate_t+Overlap*2);
		translate([0,0,2]) cylinder(d=DriveBearing_OD+IDXtra, h=Plate_t);
		
		// Bearing Retainer Bolts
		for (j=[0:nBearingRetainerBolts-1]) rotate([0,0,360/nBearingRetainerBolts*j]) 
			translate([0,DriveBearing_OD/2+Bolt4Inset,Plate_t])
				Bolt4Hole();
				
		
	} // difference
} // OutputBearingPlate

// translate([0,0,GearWidth+DriveSidePlanetCarrier_t+2.2]) OutputBearingPlate();

module ReducerShim(){
	Plate_d=150;
	RingGear_OD=134;
	nBolts=16;
	
	T=2; // 2mm shim to fix a oops
	
	difference(){
		cylinder(d=Plate_d, h=T);
		
		translate([0,0,-Overlap]) cylinder(d=RingGear_OD, h=T+Overlap*2);
		
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) translate([0,Plate_d/2-Bolt4Inset,T])
				Bolt4ClearHole();
				
	} // difference
} // ReducerShim

// ReducerShim();

module ReducerRingGear(){
	Plate_d=150;
	RingGear_OD=134;
	nBolts=16;
	Ring_t=GearWidth+PlanetCarrier_t+DriveSidePlanetCarrier_t+10; // was +8 too tight
	
	RingGear(Pitch=PlanetaryPitch, nTeeth=nPlanetTeeth, nTeethPinion=nSunTeeth, Thickness=Ring_t);
	
	difference(){
		cylinder(d=Plate_d, h=Ring_t);
		
		translate([0,0,-Overlap]) cylinder(d=RingGear_OD, h=Ring_t+Overlap*2);
		
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) translate([0,Plate_d/2-Bolt4Inset,Ring_t])
				Bolt4Hole();
				
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*(j+0.5)]) translate([0,Plate_d/2-Bolt4Inset,8])
				Bolt4HeadHole(lHead=Ring_t);
	} // difference
} // ReducerRingGear

// ReducerRingGear();

module MotorHoles(){
	// change this module to fit your motor
	
	Plate_t=7;
	nMotorBolts=4;
	MotorBC_d=39.4;
	
	translate([0,0,-Overlap]) cylinder(d=25+IDXtra*2, h=Plate_t+Overlap*2);
	
	translate([0,0,Plate_t+2]) for (j=[0:nMotorBolts-1]) rotate([0,0,360/nMotorBolts*j])
		translate([0,MotorBC_d/2,0]) Bolt8HeadHole();
} // MotorHoles

module MotorMount(){
	Plate_t=7;
	Plate_d=150;
	nBolts=16;
	
	
	RingGear_OD=134;
	Ring_t=GearWidth+PlanetCarrier_t+DriveSidePlanetCarrier_t+4;
	
	translate([0,0,-PlanetCarrier_t-2])
		RingGear(Pitch=PlanetaryPitch, nTeeth=nPlanetTeeth, nTeethPinion=nSunTeeth, Thickness=Ring_t);
		
	translate([0,0,-PlanetCarrier_t-2])
		difference(){
			cylinder(d=Plate_d, h=Ring_t);
			
			translate([0,0,-Overlap]) cylinder(d=RingGear_OD, h=Ring_t+Overlap*2);
			
			for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) translate([0,Plate_d/2-Bolt4Inset,Ring_t])
				Bolt4Hole();
		} // difference
	
//*
	// end plate
	translate([0,0,-PlanetCarrier_t-2-Plate_t]) 
	difference(){
		union(){
			cylinder(d=Plate_d, h=Plate_t);
			Legs();
		} // union
		
		MotorHoles();
		
	} // difference
	/**/
} // MotorMount

// MotorMount();

module DrivePlate(){
	Plate_t=DriveSidePlanetCarrier_t;
	Xtra_r=IDXtra;
	
	difference(){
		union(){
			hull() for (j=[0:nPlanets]) rotate([0,0,360/nPlanets*j])
				translate([PitchRadius(nSunTeeth)+PitchRadius(nPlanetTeeth)+Xtra_r,0,0])
					cylinder(d=R8_Bearing_OD-2, h=Plate_t);

			for (j=[0:nPlanets]) rotate([0,0,360/nPlanets*j])
				translate([PitchRadius(nSunTeeth)+PitchRadius(nPlanetTeeth)+Xtra_r,0,0]) {
					cylinder(d=R8_Bearing_ID+R8_BearingMod, h=Plate_t+1+PlanetBB_t/2);
					cylinder(d=R8_Bearing_ID+4, h=Plate_t+1);
				}
		} // union
		
		for (j=[0:nPlanets]) rotate([0,0,360/nPlanets*j])
				translate([PitchRadius(nSunTeeth)+PitchRadius(nPlanetTeeth)+Xtra_r,0,0])
			rotate([180,0,0]) Bolt4Hole();
			
		for (j=[0:nDriveBolts]) rotate([0,0,360/nDriveBolts*j])
				translate([DriveBearing_ID/2-Bolt4Inset,0,0])
			rotate([180,0,0]) Bolt4Hole();
			
		translate([0,0,-Overlap]) cylinder(r=PitchRadius(nSunTeeth), h=Plate_t+Overlap*2);
	} // difference
} // DrivePlate

// translate([0,0,DriveSidePlanetCarrier_t+1+GearWidth]) rotate([180,0,0]) DrivePlate();

module SecondStageSun(){
	Plate_t=5;
	Gear_H=GearWidth+PlanetCarrier_t+4;
	
	difference(){
		union(){
			cylinder(d=DriveBearing_ID, h=Plate_t);
			translate([0,0,Plate_t-Overlap]) 
				SunGear(nTeeth=nSunTeeth, Thickness=Gear_H, HasSpline=false);
		} // union
		
		translate([0,0,-Overlap]) cylinder(d=18.3, h=Plate_t+Gear_H+Overlap*2);
		translate([0,0,-Overlap]) cylinder(d1=22, d2=18.3, h=Plate_t+Overlap*2);
		
		for (j=[0:nDriveBolts]) rotate([0,0,360/nDriveBolts*j])
			translate([DriveBearing_ID/2-Bolt4Inset,0,Plate_t])
				Bolt4ButtonHeadHole();
	} // difference
	
} // SecondStageSun

// SecondStageSun();

module PlanetCarrier(CenterHole_r=PitchRadius(nSunTeeth)){
  // Input/Motor side
  
	Xtra_r=IDXtra;
	
	Plate_t=PlanetCarrier_t;
	
	difference(){
		union(){
			hull() for (j=[0:nPlanets]) rotate([0,0,360/nPlanets*j])
				translate([PitchRadius(nSunTeeth)+PitchRadius(nPlanetTeeth)+Xtra_r,0,0])
					cylinder(d=R8_Bearing_OD-2, h=Plate_t);
					
			for (j=[0:nPlanets]) rotate([0,0,360/nPlanets*j])
				translate([PitchRadius(nSunTeeth)+PitchRadius(nPlanetTeeth)+Xtra_r,0,0]) {
					cylinder(d=R8_Bearing_ID+R8_BearingMod, h=Plate_t+GearWidth-R8_Bearing_t+1+PlanetBB_t/2);
					cylinder(d=R8_Bearing_ID+4, h=Plate_t+GearWidth-R8_Bearing_t+1);
				}
		} // union
		
		for (j=[0:nPlanets]) rotate([0,0,360/nPlanets*j])
				translate([PitchRadius(nSunTeeth)+PitchRadius(nPlanetTeeth)+Xtra_r,0,0])
			rotate([180,0,0]) Bolt4HeadHole();
			
		translate([0,0,-Overlap]) cylinder(r=CenterHole_r, h=Plate_t+Overlap*2);
	} // difference
} // PlanetCarrier

// translate([0,0,-4]) PlanetCarrier();

module SunGear(nTeeth=nSunTeeth, Thickness=GearWidth, HasSpline=true){
	nSplineTeeth=20;
	Spline_ID=16.5;
	Spline_OD=18.5;
	
	difference(){
		gear (
			number_of_teeth=nTeeth,
			circular_pitch=PlanetaryPitch, diametral_pitch=false,
			pressure_angle=Pressure_a,
			clearance = 0.2,
			gear_thickness=Thickness,
			rim_thickness=Thickness,
			rim_width=5,
			hub_thickness=Thickness,
			hub_diameter=15,
			bore_diameter=Spline_ID,
			circles=0,
			backlash=0.4,
			twist=0,
			involute_facets=0,
			flat=false);
		
		if (HasSpline)
		translate([0,0,-Overlap]) for (j=[0:nSplineTeeth-1]) rotate([0,0,360/nSplineTeeth*j])
			translate([0,Spline_ID/2,0]) hull(){
				cylinder(d=Spline_OD-Spline_ID, h=Thickness+Overlap*2);
				translate([0,0.6,]) cylinder(d=Spline_OD-Spline_ID-0.4, h=Thickness+Overlap*2);
			} // hull
	} // difference
			
		
} // SunGear

// SunGear();

module BB_Planet(){
	difference(){
		PlanetGear(Pitch=PlanetaryPitch, nTeeth=nPlanetTeeth, Thickness=GearWidth, SholderBolt=1);
		
		translate([0,0,-Overlap]) cylinder(d=PlanetBB_OD-1, h=GearWidth);
		translate([0,0,GearWidth-PlanetBB_t-0.5]) cylinder(d=PlanetBB_OD, h=PlanetBB_t+0.5+Overlap);
	} // difference
} // BB_Planet

module ShowPlanets(){
	for (j=[0:nPlanets-1]) rotate([0,0,360/nPlanets*j])
		translate([PitchRadius(nSunTeeth)+PitchRadius(nPlanetTeeth),0,0]) 
			rotate([0,0,180/nPlanetTeeth]) 
				BB_Planet();
} // ShowPlanets


module ShowSecondStage(){
translate([0,0,DriveSidePlanetCarrier_t+1+GearWidth]){
	SecondStageSun();
	translate([0,0,5+1]) PlanetCarrier(CenterHole_r=PitchRadius(nSunTeeth)+6);
	translate([0,0,5+1+PlanetCarrier_t+1]) ShowPlanets();
	translate([0,0,5+1+PlanetCarrier_t+1+GearWidth+DriveSidePlanetCarrier_t+1]) rotate([180,0,0]) DrivePlate();
	//translate([0,0,GearWidth+PlanetCarrier_t+DriveSidePlanetCarrier_t+4]) 
	translate([0,0,1.2]) ReducerRingGear();
	}
} // ShowSecondStage

module ShowDrive(){
	
	translate([0,0,GearWidth+DriveSidePlanetCarrier_t+1]) color("Tan") ShaftSpacer();
	SunGear();
	ShowPlanets();
				
	//*
	difference(){
		union(){
			translate([0,0,GearWidth+DriveSidePlanetCarrier_t+1]) OutputShaft();

			translate([0,0,GearWidth+DriveSidePlanetCarrier_t+2.2+DriveBearing_t+2.2]) BearingClamp();
		
			translate([0,0,GearWidth+DriveSidePlanetCarrier_t+2.2]) OutputBearingPlate();
		
			translate([0,0,DriveSidePlanetCarrier_t+1+GearWidth]) rotate([180,0,0]) DrivePlate();
		} // union
		
		translate([-10,10,-50]) rotate([0,0,90]) cube([100,100,100]);
	} // difference
	
	/**/
	
				
	translate([0,0,-4]) PlanetCarrier();
	
	MotorMount();
} // ShowDrive

// ShowDrive();


























