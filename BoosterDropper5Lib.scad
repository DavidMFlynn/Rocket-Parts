// ***********************************
// Project: 3D Printed Rocket
// Filename: BoosterDropper5Lib.scad
// by David M. Flynn
// Created: 9/8/2025 
// Revision: 0.9.3  1/11/2026
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  Booster Dropper for strap on boosters. 
//  This is the mechanism for retaining and dropping strap-on boosters.
//  New design w/ gears for 2 or more boosters
//  Uses MS62 servo 25kg•cm (2.4Nm) 270° 
//
// Gear ratios:
//  Servo 270° Input:  0.75r * 20t/r = 15t
//  Center Shaft 15t / 40t/r = 0.375r
//  Ring Gear 0.375r * 48t = 18t
//  Driven Gear Output: 18t / 36t/r = 0.5r 
//
//  ***** History *****
//
function BoosterDropper5LibRev()="BoosterDropper5Lib 0.9.3";
echo(BoosterDropper5LibRev());
// 0.9.3  1/11/2026 Little fixes for ULine157Body
// 0.9.2  1/10/2026 Tested good, modify for ULine 6" tube
// 0.9.1  9/10/2025 Cleaned up some code. Ready for a printing and test.
// 0.9.0  9/8/2025  Copied from BoosterDropperLib 9.9, prefix changed to BD5_
// 0.9.9  9/5/2025  Now ball bearing only. Added ShowLockingThrustPoint()
//
// ***********************************
//  ***** for STL output *****
//
//
// BD5_BoosterButton(XtraLen=0.3); // Print 2 per booster
// BD5_ServoMountingRing(Body_ID=Body_ID*CF_Comp-IDXtra*2);
// 
// BD5_LockingThrustPoint(BodyTube_OD=Body_COD, BoosterBody_OD=BoosterBody_COD); // Print 1 per booster, incorperate into rocket body
// BD5_Lock(); // Print 1 per booster
// rotate([180,0,0]) BD5_ServoGear(nTeeth=nTeethServoGear);
// BD5_TopRingGear(Bore_d=CenterBore_d, nTeeth=nTeethTopGear);
// BD5_TopGearMount(Bore_d=CenterBore_d, nBolts=6);
//
// BD5_RingGear(Bore_d=CenterBore_d);
// BD5_InnerRace(Bore_d=CenterBore_d);
// BD5_OuterRace(Bore_d=CenterBore_d);
// BD5_BallSpacer(Bore_d=CenterBore_d);
// BD5_OuterRaceMount(Tube_ID=Body_ID*CF_Comp-IDXtra*2, Bore_d=CenterBore_d);
//
// BD5_DrivenGear(Hub_Len=DrivenGearHubLen);
//
// BD5_RocketBody(Body_OD=Body_COD, Body_ID=Body_ID*CF_Comp, nBoosters=nBoosters);
//
// CenteringRing(OD=Body_ID*CF_Comp, ID=MotorTube_OD+IDXtra*2, Thickness=5, nHoles=7, Offset=0, myfn=$preview? 90:360); // Top
// CenteringRing(OD=Body_ID*CF_Comp-4.4-IDXtra, ID=MotorTube_OD+IDXtra*2, Thickness=5, nHoles=6, Offset=0, myfn=$preview? 90:360); // Bottom
//
// ***********************************
//  ***** Routines *****
//
function BD5_BoosterButtonOAH()=BoosterButtonOA_h;
function BD5_ThrustRing_h(Btn_d=BoosterButtonMinor_d)=Btn_d+6;
function BD5_Calc_nBalls(BallCircle_d=50,Ball_d=6)=floor(BallCircle_d*PI / (Ball_d*2.25)/2)*2;
//
// BD5_ThrustPoint(BodyTube_OD=PML98Body_OD, BoosterBody_OD=PML54Body_OD); 
// BD5_ThrustPoint_Hole(Swell=-Overlap);
// BD5_LTP_Hole(BodyTube_OD=PML98Body_OD);
// BD5_Gear(nTeeth=24, Thickness=8);
// BD5_BearingStop();
//
//
// ***********************************
//  ***** for Viewing *****
//
// BD5_ShowLockingThrustPoint();
// BD5_ShowRocketBody(Body_OD=Body_COD, Body_ID=Body_ID, nBoosters=nBoosters);
// BD5_ShowMech(Bore_d=CenterBore_d);
//
/*
  //for (j=[0:nBoosters-1]) rotate([0,0,360/nBoosters*j])
	translate([0,Body_COD/2-12.4,63]) rotate([-90,0,0]) BD5_ShowLockingThrustPoint(ShowLocked=false);
  translate([0,0,120.1]) color("Tan") BD5_ServoMountingRing();
  BD5_ShowRocketBody(Body_OD=Body_COD, Body_ID=Body_ID, nBoosters=nBoosters);
  translate([0,0,63+31]) rotate([180,0,0]) BD5_ShowMech();
  translate([0,0,63+35]) BD5_OuterRaceMount();
/**/
//
// ***********************************

use<ThreadLib.scad>
include<involute_gears.scad>
include<TubesLib.scad>
use<BearingLib.scad>
include<LD-20MGServoLib.scad>
 //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

Bolt4Inset=4;
LooseFit=IDXtra*3;

// Ball Bearing 6805-2RS
BB6805_2RS_ID=25;
BB6805_2RS_OD=37;
BB6805_2RS_H=7;

BoosterButtonMinor_d=12.7;
BoosterButtonMajor_d=20;
BoosterButtonPost_h=5;
BoosterButtonMajor_h=5;
BoosterButtonTrans_h=(BoosterButtonMajor_d-BoosterButtonMinor_d)/3;
BoosterButtonOA_h=BoosterButtonMajor_h+BoosterButtonPost_h+BoosterButtonTrans_h;


BD5_Lock_Wall_t=2.2;

Housing_OD=BB6805_2RS_OD+Bolt4Inset*4;
Race_ID=BB6805_2RS_ID-Bolt4Inset*4;
RaceBC_d=BB6805_2RS_OD+Bolt4Inset*2;

TopOfRace=-3.5; 

// Values for BT137Body w/ 3 strap-on boosters
/*
Body_OD=BT137Body;
Body_COD=Body_OD*CF_Comp+Vinyl_d; // Compensated OD
echo(Body_COD=Body_COD);

nBoosters=3;
nTeethServoGear=20;
nTeethTopGear=nTeethServoGear*2;
GearPitch=300;
BevelGearPitch=300;
GearPressureAngle=20;
nDrivenGearTeeth=36;
DrivenGearConeDistance=54.0833;
nBevelRingGearTeeth=48;
BevelRingGearConeDistance=48;
Ball_d=3/8*25.4;
Race_w=10;
BearingPreload=-0.25; // -0.35 was too loose
MotorTube_OD=BT54Body_OD;
MotorTube_ID=BT54Body_ID;
CenterBore_d=60; // clear the BT54Body motor tube
/**/

// Values for ULine157Body_OD w/ 3 strap-on boosters
//*
Body_OD=ULine157Body_OD;
Body_ID=ULine157Body_ID;
Body_COD=Body_OD*CF_Comp+Vinyl_d; // Compensated OD
echo(Body_COD=Body_COD);
BoosterBody_OD=ULine102Body_OD;
BoosterBody_COD=BoosterBody_OD*CF_Comp+Vinyl_d;

nBoosters=3;
nTeethServoGear=20;
nTeethTopGear=nTeethServoGear*2;
GearPitch=300;
BevelGearPitch=300;
GearPressureAngle=20;
nDrivenGearTeeth=36;
DrivenGearConeDistance=54.0833;
nBevelRingGearTeeth=48;
BevelRingGearConeDistance=48;
Ball_d=3/8*25.4;
Race_w=10;
BearingPreload=-0.25; // -0.35 was too loose
MotorTube_OD=BT54Body_OD;
MotorTube_ID=BT54Body_ID;
CenterBore_d=60; // clear the BT54Body motor tube
/**/

// Values for ULine157Body_OD w/ 3 strap-on boosters ULine75 motor tube
// it doesn't fit
/*
Body_OD=ULine157Body_OD;
Body_ID=ULine157Body_ID;
Body_COD=Body_OD*CF_Comp+Vinyl_d; // Compensated OD
echo(Body_COD=Body_COD);
BoosterBody_OD=ULine102Body_OD;
BoosterBody_COD=BoosterBody_OD*CF_Comp+Vinyl_d;

nBoosters=3;
nTeethServoGear=20;
nTeethTopGear=54;
nBevelRingGearTeeth=48; 
nDrivenGearTeeth=36;
GearPitch=300;
BevelGearPitch=300;
GearPressureAngle=20;
DrivenGearConeDistance=54.0833;
BevelRingGearConeDistance=48;
Ball_d=3/8*25.4;
Race_w=10;
BearingPreload=-0.25; // -0.35 was too loose
MotorTube_OD=ULine75Body_OD;
MotorTube_ID=ULine75Body_ID;
CenterBore_d=81; // clear the BT54Body motor tube
/**/

DrivenGearHubLen=Body_COD/2-CenterBore_d/2-35;

module BD5_ShowLockingThrustPoint(Body_OD=Body_COD, BoosterBody_OD=BoosterBody_COD, ShowLocked=true){
	module Bearing(){
		difference(){
			cylinder(d=BB6805_2RS_OD, h=BB6805_2RS_H);
			translate([0,0,-Overlap]) cylinder(d=BB6805_2RS_ID, h=BB6805_2RS_H+Overlap*2);
		} // difference
	} // Bearing
	
	module LockWithBearing(ShowLocked=true){
		Rot_a=ShowLocked? -90:90;
		
		rotate([0,0,Rot_a]){
			BD5_Lock();
			translate([0,0,-10.6]) color("Red") Bearing();
			//translate([0,0,-12.7]) BD5_BearingStop();
			translate([0,0,-12.7-3.1]) rotate([180,0,0]) BD5_DrivenGear(Hub_Len=DrivenGearHubLen);
		}
	} // LockWithBearing
	
	color("Tan") BD5_BoosterButton(XtraLen=0);
	
	//difference(){
		BD5_LockingThrustPoint(BodyTube_OD=Body_OD, BoosterBody_OD=BoosterBody_OD);
		//translate([0,0,-20]) cube([50,70,50]);
	//}
	LockWithBearing(ShowLocked=ShowLocked);
	
	//color("Green") BD5_LTP_Hole();
} // BD5_ShowLockingThrustPoint

// translate([0,Body_COD/2-12.4,63]) rotate([-90,0,0]) BD5_ShowLockingThrustPoint(ShowLocked=false);

module BD5_ShowRocketBody(Body_OD=Body_COD, Body_ID=Body_ID, nBoosters=nBoosters){
	LowerCR_Z=3.5;
	
	translate([0,0,LowerCR_Z-5.1])
		CenteringRing(OD=Body_ID-4.4-IDXtra, ID=MotorTube_OD+IDXtra*2, Thickness=5, nHoles=6, Offset=0, myfn=$preview? 90:360);
	
	
	BD5_RocketBody(Body_OD=Body_OD, Body_ID=Body_ID, nBoosters=nBoosters);
	
	
	translate([0,0,-50]) color("LightBlue") Tube(OD=MotorTube_OD, ID=MotorTube_ID, Len=250, myfn=$preview? 36:360);
} // BD5_ShowRocketBody

// BD5_ShowRocketBody();

module BD5_ShowMech(Bore_d=CenterBore_d){
	Bearing_Z=-14.1;
	
	module ShowMyBalls(Bore_d=CenterBore_d){
		Race_t=2.2;
		Gear_OD=Bore_d+Bolt4Inset*4;
		Race_ID=Gear_OD+1;
		BallCircle_d=Race_ID+Race_t*2+Ball_d;
		
		nBalls=BD5_Calc_nBalls(BallCircle_d,Ball_d);
		for (j=[0:nBalls-1]) rotate([0,0,360/nBalls*j]) translate([BallCircle_d/2,0,0]) color("Red") sphere(d=Ball_d);
	} // ShowMyBalls

	// ShowMyBalls(Bore_d=CenterBore_d);

	rotate([0,0,180/48]) BD5_RingGear(Bore_d=Bore_d);
	translate([0,0,Bearing_Z]) BD5_InnerRace(Bore_d=Bore_d);
	translate([0,0,Bearing_Z+Race_w/2]) BD5_BallSpacer(Bore_d=Bore_d);
	translate([0,0,Bearing_Z+Race_w/2]) rotate([180,0,0]) BD5_BallSpacer(Bore_d=Bore_d);
	translate([0,0,Bearing_Z+Race_w]) rotate([180,0,0]) BD5_OuterRace(Bore_d=Bore_d);
	
	translate([0,0,Bearing_Z-3]) rotate([180,0,0]) BD5_TopGearMount(Bore_d=Bore_d, nBolts=6);
	translate([0,0,Bearing_Z-3]) rotate([180,0,0]) translate([0,0,3]) BD5_TopRingGear(Bore_d=Bore_d, nTeeth=nTeethTopGear);
	translate([0,0,Bearing_Z+Race_w/2]) ShowMyBalls(Bore_d=Bore_d);
	
	translate([0,GearPitch*(nTeethServoGear+nTeethTopGear)/360,-29]) 
		rotate([0,0,180/nTeethServoGear]) BD5_ServoGear(nTeeth=nTeethServoGear);
} // BD5_ShowMech

// translate([0,0,63+31]) rotate([180,0,0]) BD5_ShowMech();


module BD5_ServoMountingRing(Body_ID=Body_ID){
	TubeLen=21;
	GearCenter_Y=-GearPitch*(nTeethServoGear+nTeethTopGear)/360;
	Gear_d=37;
	Gusset_h=8;
	Gusset_Y=-Body_ID/2+2.0;
	Gusset_Y1=GearCenter_Y-14;
	Gusset_Y2=GearCenter_Y+1;
	nBolts=6;
	
	difference(){
		union(){
			Tube(OD=Body_ID, ID=Body_ID-4.4, Len=TubeLen, myfn=$preview? 36:360);
			
			rotate([0,0,24]) 
			hull(){
				translate([0,Gusset_Y,0]) cylinder(d=4, h=TubeLen-3);
				translate([-1,Gusset_Y2,TubeLen-11]) cylinder(d=4, h=Gusset_h);
			} // hull
			
			rotate([0,0,-50]) 
			hull(){
				translate([0,Gusset_Y,0]) cylinder(d=4, h=TubeLen-3);
				translate([4,Gusset_Y2,TubeLen-11]) cylinder(d=4, h=Gusset_h);
			} // hull
			
			rotate([0,0,-36]) 
			hull(){
				translate([0,Gusset_Y,0]) cylinder(d=4, h=TubeLen-4);
				translate([0,Gusset_Y1,TubeLen-11]) cylinder(d=4, h=Gusset_h);
			} // hull
			
			rotate([0,0,14]) 
			hull(){
				translate([0,Gusset_Y,0]) cylinder(d=4, h=TubeLen-4);
				translate([0,Gusset_Y1,TubeLen-11]) cylinder(d=4, h=Gusset_h);
			} // hull
		} // union
		
		translate([0,GearCenter_Y,-Overlap]) cylinder(d=Gear_d+2, h=6);
		
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+180/nBolts]) translate([0,Body_ID/2,7.5]) rotate([-90,0,0]) Bolt4Hole();
	} // difference
	
	
	translate([0,GearCenter_Y,0]) rotate([0,0,80])
		rotate([180,0,0]) translate([0,0,-ServoMS62TopOfWheel_z]) ServoMS62TopMount();
} // BD5_ServoMountingRing

//translate([0,0,120.1]) color("Tan") BD5_ServoMountingRing();
	
module BD5_RocketBody(Body_OD=Body_COD, Body_ID=Body_ID, HasAftCoupler=false, nBoosters=nBoosters){
	MountingBlock_X=Housing_OD+2.4;
	LTP_Z=63;
	LTP_Mount_Z=LTP_Z-57;
	MechMounting_Z=LTP_Z+30;
	MountingBlockSize_Z=87;
	nSkirtBolts=nBoosters*4;
	LowerCR_Z=3.5;
	Gear_d=37;
	TubeLen=141+15; // 141 is top of servo ring
	ServoRing_Z=120;
	nServoRingBolts=6;	
	
	BigFn=180;
	
	difference(){
		union(){
			Tube(OD=Body_OD, ID=Body_ID, Len=TubeLen, myfn=$preview? 90:BigFn);
			
			// integrated coupler
			if (HasAftCoupler){
				translate([0,0,-15]) Tube(OD=Body_ID, ID=Body_ID-4.4, Len=19, myfn=$preview? 90:BigFn);
				Tube(OD=Body_ID+1, ID=Body_ID-4.4, Len=8, myfn=$preview? 90:BigFn);
			}else{
				translate([0,0,-15]) Tube(OD=Body_OD, ID=Body_ID, Len=15+Overlap, myfn=$preview? 90:BigFn);
			}
			
			// Stop for Servo Ring
			translate([0,0,ServoRing_Z]) rotate([180,0,0]) TubeStop(InnerTubeID=Body_ID-4.4, OuterTubeOD=Body_ID+2, myfn=$preview? 90:BigFn);
			
			// Stop for lower centering ring
			if (HasAftCoupler){
				translate([0,0,LowerCR_Z]) TubeStop(InnerTubeID=Body_ID-8.8, OuterTubeOD=Body_ID+2, myfn=$preview? 90:BigFn);
			}else{
				translate([0,0,LowerCR_Z]) TubeStop(InnerTubeID=Body_ID-6, OuterTubeOD=Body_ID+2, myfn=$preview? 90:BigFn);
			}
			
			// Mounting Blocks
			intersection(){
				cylinder(d=Body_OD-1, h=100);
				
				union(){
					for (j=[0:nBoosters-1]) rotate([0,0,360/nBoosters*j]) 
						hull(){
							translate([-MountingBlock_X/2,Body_OD/2-27,LTP_Mount_Z]) cube([MountingBlock_X,1,MountingBlockSize_Z]);
							translate([-MountingBlock_X/2-10,Body_OD/2,LTP_Mount_Z]) cube([MountingBlock_X+20,1,MountingBlockSize_Z]);
						} // hull
						
					// key
					translate([0,Body_ID/2,MechMounting_Z-Overlap]) cylinder(d=4, h=5);
					
					// Mounting Face
					translate([0,0,MechMounting_Z]) 
						rotate([180,0,0]) TubeStop(InnerTubeID=Body_ID-4.4, OuterTubeOD=Body_OD, myfn=$preview? 90:BigFn);
				} // union
			} // intersection
			
			// Extra room for servo gear
			difference(){
				translate([0,-GearPitch*(nTeethServoGear+nTeethTopGear)/360,120]) hull(){
					cylinder(d=Gear_d+2+4.4, h=10+4.4, center=true);
					cylinder(d=Gear_d+2, h=18+8.8, center=true);
				}
		
				translate([0,0,120]) cylinder(d=Body_ID, h=30, center=true, $fn=$preview? 90:BigFn);
			} // difference
		} // union
		
		// Servo gear goes here
		translate([0,-GearPitch*(nTeethServoGear+nTeethTopGear)/360,120]) hull(){
			cylinder(d=Gear_d+2, h=10, center=true);
			cylinder(d=Gear_d, h=18, center=true);
		}
		
		// Servo Ring Bolts
		for (j=[0:nServoRingBolts-1]) rotate([0,0,360/nServoRingBolts*j+180/nServoRingBolts]) 
			translate([0,Body_OD/2,ServoRing_Z+7.5]) rotate([-90,0,0]) Bolt4Hole();
		
		// Upper bolts
		for (j=[0:nSkirtBolts-1]) rotate([0,0,360/nSkirtBolts*j+180/nSkirtBolts]) translate([0,Body_OD/2,TubeLen-7.5]) rotate([-90,0,0]) Bolt4Hole();
		
		// Lower integrated coupler bolts
		for (j=[0:nSkirtBolts-1]) rotate([0,0,360/nSkirtBolts*j]) translate([0,Body_OD/2,-7.5]) rotate([-90,0,0]) Bolt4Hole();
		
		// Locking thrust points go here
		for (j=[0:nBoosters-1]) rotate([0,0,360/nBoosters*j]) 
			translate([0,Body_OD/2-11.9,LTP_Z]) rotate([-90,0,0]) BD5_LTP_Hole();
			
		if ($preview) translate([0,0,-50]) cube([100,100,TubeLen+60]);
	} // difference
	
} // BD5_RocketBody

// BD5_RocketBody();

module BD5_TopGearMount(Bore_d=CenterBore_d, nBolts=6){
	BackPlate_t=5;
	Flange_t=3;
	
	BoltCircle_d=Bore_d+Bolt4Inset*2;
	Hub_d=Bore_d+Bolt4Inset*4;
	Flange_ID=Hub_d-6;

	difference(){
		translate([0,0,-BackPlate_t]) cylinder(d=Hub_d, h=BackPlate_t+Flange_t, $fn=$preview? 90:360);
			
		
		translate([0,0,-0.6]) cylinder(d=Flange_ID, h=Flange_t+0.6+Overlap, $fn=$preview? 90:360);
		translate([0,0,1.2]) cylinder(d=Flange_ID+IDXtra, h=1, $fn=$preview? 90:360);
		
		translate([0,0,-BackPlate_t-Overlap]) cylinder(d=Bore_d, h=Flange_t+BackPlate_t+Overlap*2, $fn=$preview? 90:360);
		
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) translate([0,Bore_d/2+Bolt4Inset,0]) Bolt4HeadHole();
	} // difference
	
	
} // BD5_TopGearMount

//BD5_TopGearMount();

module BD5_TopRingGear(Bore_d=CenterBore_d, nTeeth=nTeethTopGear){
	// The servo gear drives this gear
	Flange_t=3;
	Gear_t=8;
	Hub_d=Bore_d+Bolt4Inset*4;
	Flange_ID=Hub_d-6;
		
	difference(){
		union(){
			BD5_Gear(nTeeth=nTeeth, Thickness=Gear_t);
			
			translate([0,0,-Flange_t]) cylinder(d=Flange_ID, h=Flange_t+Overlap, $fn=$preview? 90:360);
			translate([0,0,-Flange_t+1.2]) cylinder(d=Flange_ID+IDXtra, h=1, $fn=$preview? 90:360);
		} // union
		
		translate([0,0,-Flange_ID-Overlap]) cylinder(d=Bore_d-1, h=Gear_t+Flange_ID+Overlap*2, $fn=$preview? 90:360);
		
	} // difference
} // BD5_TopRingGear

// rotate([180,0,0]) translate([0,0,3]) BD5_TopRingGear();

module BD5_RingGear(Bore_d=CenterBore_d){
	nBolts=6;
	BoltCircle_d=Bore_d+Bolt4Inset*2;
	BackPlate_t=3;
	
	difference(){
		union(){
			bevel_gear(
				number_of_teeth=nBevelRingGearTeeth,
				cone_distance=BevelRingGearConeDistance,
				face_width=6,
				outside_circular_pitch=BevelGearPitch,
				pressure_angle=GearPressureAngle,
				clearance = 0.2,
				bore_diameter=5,
				gear_thickness = 5,
				backlash = 0,
				involute_facets=5,
				finish = bevel_gear_back_cone);
			
			// Back plate
			translate([0,0,-6-BackPlate_t]) cylinder(d=Bore_d+Bolt4Inset*4, h=BackPlate_t+3, $fn=$preview? 90:360);
		} // union
			
		translate([0,0,-6-BackPlate_t-Overlap]) cylinder(d=Bore_d, h=30, $fn=$preview? 90:360);
			
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) translate([0, BoltCircle_d/2, -10]) rotate([180,0,0]) Bolt4Hole(depth=BackPlate_t+3);
	} // difference
} // BD5_RingGear

// BD5_RingGear();

module BD5_InnerRace(Bore_d=CenterBore_d){
	BoltFrame_t=5;
	Race_t=2.2;
	
	nBolts=6;
	BoltCircle_d=Bore_d+Bolt4Inset*2;
	Gear_OD=Bore_d+Bolt4Inset*4;
	Race_ID=Gear_OD+1;
	BallCircle_d=Race_ID+Race_t*2+Ball_d;
	
	OnePieceInnerRace(BallCircle_d=BallCircle_d, Race_ID=Race_ID, Ball_d=Ball_d, Race_w=Race_w, 
						PreLoadAdj=BearingPreload, VOffset=0.00, BI=false, myFn=$preview? 90:720);
						
	difference(){
		cylinder(d=Race_ID+1, h=BoltFrame_t);
		
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) translate([0,BoltCircle_d/2,BoltFrame_t]) Bolt4ClearHole();
		translate([0,0,-Overlap]) cylinder(d=Bore_d, h=BoltFrame_t+Overlap*2, $fn=$preview? 90:360);
	} // difference
} // BD5_InnerRace

//translate([0,0,-14.1]) BD5_InnerRace();
// translate([0,0,-14.1+5])BD5_BallSpacer();

module BD5_OuterRace(Bore_d=CenterBore_d){
	BoltFrame_t=5;
	Race_t=2.2;
	nBolts=6;
	
	Gear_OD=Bore_d+Bolt4Inset*4;
	Race_ID=Gear_OD+1;
	BallCircle_d=Race_ID+Race_t*2+Ball_d;
	Race_OD=BallCircle_d+Ball_d+Race_t*2;
	BoltCircle_d=Race_OD+Bolt4Inset*2;
	Boss_OD=Race_OD+Bolt4Inset*4;

	OnePieceOuterRace(BallCircle_d=BallCircle_d, Race_OD=Race_OD, Ball_d=Ball_d, Race_w=Race_w, 
						PreLoadAdj=BearingPreload, VOffset=0.00, BI=false, myFn=$preview? 90:720);
						
	difference(){
		cylinder(d=Boss_OD, h=3, $fn=$preview? 90:360);
		
		translate([0,0,-Overlap]) cylinder(d=Race_OD-1, h=3+Overlap*2);
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) translate([0,BoltCircle_d/2,3]) Bolt4ClearHole();
	} // difference
} // BD5_OuterRace

//translate([0,0,-14.1]) BD5_OuterRace();

module BD5_OuterRaceMount(Tube_ID=Body_ID, Bore_d=CenterBore_d){
	Race_t=2.2;
	nBolts=6;
	Thickness=5;
	Gear_OD=Bore_d+Bolt4Inset*4;
	Race_ID=Gear_OD+1;
	BallCircle_d=Race_ID+Race_t*2+Ball_d;
	Race_OD=BallCircle_d+Ball_d+Race_t*2;
	BoltCircle_d=Race_OD+Bolt4Inset*2;
	CenterHole_d=BoltCircle_d-Bolt4Inset*2;
	nHoles=nBolts*2;
	LHole_d=(Tube_ID-CenterHole_d)/2-6;
	
	translate([0,0,-Thickness])
	difference(){
		cylinder(d=Tube_ID, h=Thickness, $fn=$preview? 90:360);
		
		// center hole
		translate([0,0,-Overlap]) cylinder(d=CenterHole_d, h=Thickness+Overlap*2, $fn=$preview? 90:360);
		
		// key
		translate([0,0,-Overlap]) translate([0,Tube_ID/2,0]) cylinder(d=5, h=Thickness+Overlap*2);
		
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) translate([0,BoltCircle_d/2,Thickness]) Bolt4Hole();
		
		for (j=[0:nHoles-1]) rotate([0,0,360/nHoles*j+180/nHoles]) translate([0,Tube_ID/2-LHole_d/2-3,-Overlap])
			cylinder(d=LHole_d, Thickness+Overlap*2);
	} // difference
} // BD5_OuterRaceMount

// BD5_OuterRaceMount();

module BD5_BallSpacer(Bore_d=CenterBore_d){
	BoltFrame_t=5;
	Race_t=2.2;
	BoltCircle_d=Bore_d+Bolt4Inset*2;
	
	Gear_OD=Bore_d+Bolt4Inset*4;
	Race_ID=Gear_OD+1;
	BallCircle_d=Race_ID+Race_t*2+Ball_d;
	nBalls=BD5_Calc_nBalls(BallCircle_d,Ball_d);
	echo(nBalls=nBalls);

	module TwoPartBoltedBallSpacer(BallCircle_d=72, Ball_d=7.9375, nBalls=14){ // 9.525
		// nBalls must be even
		Race_w=Ball_d+3.5;
		Race_depth=Ball_d*0.6;
		
		difference(){
			translate([0,0,-Race_w/2])cylinder(d=BallCircle_d+Race_depth,h=Race_w/2);
			
			cylinder(d=BallCircle_d-Race_depth,h=Race_w+Overlap*2,center=true);
			for (j=[0:nBalls-1]) rotate([0,0,360/nBalls*j]) translate([BallCircle_d/2,0,0]) sphere(d=Ball_d+IDXtra*2);
				
			// Bolt holes
			for (j=[0:nBalls/2]) {
				rotate([0,0,360/nBalls*(j*2)+180/nBalls]) translate([BallCircle_d/2,0,-4]) rotate([180,0,0])  Bolt2HeadHole();
				rotate([0,0,360/nBalls*(j*2+1)+180/nBalls]) translate([BallCircle_d/2,0,-Race_w/2]) rotate([180,0,0])  Bolt2Hole();
			}
		} // diff
	} // TwoPartBoltedBallSpacer
	
	TwoPartBoltedBallSpacer(BallCircle_d=BallCircle_d, Ball_d=Ball_d, nBalls=nBalls);
} // BD5_BallSpacer

// BD5_BallSpacer();

module BD5_BoosterButton(XtraLen=0){
	
	module Bolt250FlatHeadHole(depth=12,lAccess=12){
		// custom version
		if ($preview){
			translate([0,0,-depth])
				cylinder(r=Bolt250_Clear_r+ID_Xtra, h=depth+Overlap, $fn=24);
		}else{
			translate([0,0,-depth])
				ExternalThread(Pitch=25.4/20, Dia_Nominal=6.35+IDXtra*2, Length=depth+Overlap*2, 
								Step_a=2, TrimEnd=true, TrimRoot=true);
		}
		translate([0,0,-Bolt250_FlatHd_h])
			cylinder(d1=Bolt250_Clear_r+ID_Xtra, d2=Bolt250_FlatHd_d+ID_Xtra, h=Bolt250_FlatHd_h, $fn=24);
		translate([0,0,-Overlap]) cylinder(d=Bolt250_FlatHd_d+ID_Xtra, h=lAccess, $fn=24);
	} // Bolt250FlatHeadHole
	
	difference(){
		union(){
			cylinder(d=BoosterButtonMajor_d, h=BoosterButtonMajor_h);
			translate([0,0,BoosterButtonMajor_h-Overlap]) 
				cylinder(d1=BoosterButtonMajor_d, d2=BoosterButtonMinor_d, h=BoosterButtonTrans_h);
			cylinder(d=BoosterButtonMinor_d, h=BoosterButtonOA_h+XtraLen);
		} // union
		
		translate([0,0,1.5]) rotate([180,0,0]) Bolt250FlatHeadHole(depth=BoosterButtonOA_h+Overlap, lAccess=12);
		
	} // difference
} // BD5_BoosterButton

// BD5_BoosterButton(XtraLen=0.3); // XtraLen=0.3 works well

module BD5_ThrustPoint_Hole(Swell=-Overlap){
	Block_w=BoosterButtonMajor_d+BD5_Lock_Wall_t*2+Swell*2;
	OAL=BoosterButtonMajor_d*3.2+Swell*2;
	
	translate([-Block_w/2, -BoosterButtonMajor_d/2-BD5_Lock_Wall_t+Swell, -3-Swell])
					cube([BoosterButtonMajor_d+BD5_Lock_Wall_t*2+Swell*2, OAL, BoosterButtonOA_h+4]);
} // BD5_ThrustPoint_Hole

//BD5_ThrustPoint_Hole();
//BD5_ThrustPoint_Hole(Swell=IDXtra*2);

module BD5_ThrustPoint(BodyTube_OD=Body_COD, BoosterBody_OD=BoosterBody_COD){
	Ramp_h=12;
	OAL=BoosterButtonMajor_d*3.25;
	Block_w=BoosterButtonMajor_d+BD5_Lock_Wall_t*2;
	
	module PostClearance1(){
		translate([0,0,-Overlap]) cylinder(d=BoosterButtonMinor_d+IDXtra*2, h=BoosterButtonOA_h+Overlap*2);
	} // PostClearance1
	
	module PostClearance2(){
		translate([0,0,-1-Overlap]) cylinder(d=BoosterButtonMajor_d+IDXtra*2, h=BoosterButtonMajor_h+1+Overlap*2);
	} // PostClearance2
	
	module PostClearance3(){
		translate([0,0,BoosterButtonMajor_h-Overlap])
			cylinder(d1=BoosterButtonMajor_d+IDXtra*2, d2=BoosterButtonMinor_d+IDXtra*2, h=BoosterButtonTrans_h+Overlap*2);
	} // PostClearance
	
	difference(){
		union(){
			intersection(){
				translate([-Block_w/2, -BoosterButtonMajor_d/2-BD5_Lock_Wall_t, -3])
					cube([BoosterButtonMajor_d+BD5_Lock_Wall_t*2, OAL, BoosterButtonOA_h+6]);
				translate([0,-Block_w/2-Overlap,BoosterButtonOA_h-BodyTube_OD/2]) 
					rotate([-90,0,0]) cylinder(d=BodyTube_OD+Overlap, h=OAL+Overlap*2, $fn=$preview? 90:360);
			} // intersection
			
			translate([-BoosterButtonMajor_d/2-BD5_Lock_Wall_t, -BoosterButtonMajor_d/2-BD5_Lock_Wall_t, 0])
				cube([BoosterButtonMajor_d+BD5_Lock_Wall_t*2, 5.5, BoosterButtonOA_h+3]);
		} // union
		
		translate([0,-Block_w/2-Overlap,BoosterButtonOA_h+BoosterBody_OD/2]) 
			rotate([-90,0,0]) cylinder(d=BoosterBody_OD+IDXtra, h=OAL+Overlap*2, $fn=$preview? 90:360);
		
		hull(){
			PostClearance1();
			translate([0,BoosterButtonMinor_d/2,0]) PostClearance1();
		} // hull
		hull(){
			PostClearance2();
			translate([0,BoosterButtonMinor_d/2,0]) PostClearance2();
		} // hull
		hull(){
			PostClearance3();
			translate([0,BoosterButtonMinor_d/2,0]) PostClearance3();
		} // hull
		
		hull(){
			translate([0,BoosterButtonMinor_d/2,0]) PostClearance1();
			translate([0, BoosterButtonMajor_d*2.5, BoosterButtonPost_h+Ramp_h]) 
				PostClearance1();
		} // hull
		hull(){
			translate([0,BoosterButtonMinor_d/2,0]) PostClearance2();
			translate([0, BoosterButtonMajor_d*2.5, BoosterButtonPost_h+Ramp_h]) 
				PostClearance2();
		} // hull
		hull(){
			translate([0,BoosterButtonMinor_d/2,0]) PostClearance3();
			translate([0, BoosterButtonMajor_d*2.5, BoosterButtonPost_h+Ramp_h]) 
				PostClearance3();
		} // hull
		
	} // difference
} // BD5_ThrustPoint

//translate([0,PML98Body_OD/2-BoosterButtonOA_h,0]) rotate([-90,0,0]) BD5_ThrustPoint(BodyTube_OD=BT137Body_OD, BoosterBody_OD=ULine102Body_OD);

module BD5_LTP_Hole(){
	// This is the hole a locking thrust point fits in. 
	
	rotate([180,0,0]) cylinder(d=BB6805_2RS_OD-4, h=50);
	
	BD5_ThrustPoint_Hole(Swell=IDXtra*3);
	translate([0,0,TopOfRace-BB6805_2RS_H-IDXtra*3]) cylinder(d=Housing_OD+IDXtra*3, h=BB6805_2RS_H+17);
	BD5_LTP_BoltPattern() Bolt4Hole(depth=24);
} // BD5_LTP_Hole

// BD5_LTP_Hole();

module BD5_LTP_BoltPattern(){
	nBolts=6;
	
	for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) translate([0,RaceBC_d/2,TopOfRace+2])
			children();
	
	translate([9,49,6]) children();
	translate([-9,49,6]) children();
} // BD5_LTP_BoltPattern

module BD5_LockingThrustPoint(BodyTube_OD=Body_COD, BoosterBody_OD=BoosterBody_COD){	
	// Ball Bearing 6805-2RS
	//BB6805_2RS_ID=25;
	//BB6805_2RS_OD=37;
	//BB6805_2RS_H=7;

	module TheBolts(){
		BD5_LTP_BoltPattern() Bolt4HeadHole(depth=12,lHead=22);
	} // TheBolts
	
	difference(){
		translate([0,0,TopOfRace-BB6805_2RS_H]) cylinder(d=Housing_OD, h=BB6805_2RS_H+17, $fn=$preview? 90:360);
			
		difference(){
			BD5_ThrustPoint_Hole();
			// Rotating lock
			translate([0,0,TopOfRace-Overlap*3]) 
				cylinder(d=BoosterButtonMajor_d+BD5_Lock_Wall_t*2+6, h=14);
		}
		
		// conform to tube OD
		translate([0,-30,-BodyTube_OD/2+BoosterButtonOA_h]) rotate([-90,0,0])
		difference(){
			cylinder(d=BodyTube_OD+15,h=100, $fn=$preview? 90:360);
			translate([0,0,-Overlap]) cylinder(d=BodyTube_OD,h=100+Overlap*2, $fn=$preview? 90:360);
		} // difference
		
		// Bearing
		translate([0,0,TopOfRace-BB6805_2RS_H-Overlap])
				cylinder(d=BB6805_2RS_OD+IDXtra, h=BB6805_2RS_H+Overlap*2);
		
		// Bolt holes
		TheBolts();
		
		translate([0,0,TopOfRace-Overlap]) cylinder(d=BB6805_2RS_OD-3, h=1);
		translate([0,0,TopOfRace-Overlap]) cylinder(d=BB6805_2RS_ID+3, h=3+Overlap*2);
		
		// Rotating lock
		translate([0,0,TopOfRace-Overlap*2]) 
				cylinder(d=BoosterButtonMajor_d+BD5_Lock_Wall_t*2+1, h=8+Overlap*2);
		
		// Button clearance
		translate([0,0,-1.5-Overlap]) hull(){
			cylinder(d=BoosterButtonMajor_d+LooseFit, h=12+Overlap*2);
			translate([0,20,0]) cylinder(d=BoosterButtonMajor_d+LooseFit, h=12+Overlap*2);
		} // hull
	} // difference
	
	difference(){
		BD5_ThrustPoint(BodyTube_OD=BodyTube_OD, BoosterBody_OD=BoosterBody_OD);
		
		// Bolt holes
		TheBolts();
		
		translate([0,0,TopOfRace-Overlap]) cylinder(d=BB6805_2RS_OD-3, h=1);
		translate([0,0,TopOfRace-Overlap]) cylinder(d=BB6805_2RS_ID+3,h=3);
		
		// Clearance for the rotating lock
		translate([0,0,TopOfRace-Overlap]) 
			cylinder(d=BoosterButtonMajor_d+BD5_Lock_Wall_t*2+1, h=-TopOfRace+BoosterButtonMajor_h );
	} // difference
	
} // BD5_LockingThrustPoint

//BD5_LockingThrustPoint(BodyTube_OD=BT137Body_OD, BoosterBody_OD=ULine102Body_OD);

module BD5_DrivenGearBevel(){
	// Rotates the lock
	BackOfGear_Z=-3;
	HubThickness=5;
	
	difference(){
		bevel_gear (
			number_of_teeth=nDrivenGearTeeth,
			cone_distance=DrivenGearConeDistance,
			face_width=6,
			outside_circular_pitch=BevelGearPitch,
			pressure_angle=GearPressureAngle,
			clearance = 0.2,
			bore_diameter=0,
			gear_thickness = 6,
			backlash = 0,
			involute_facets=5,
			finish = bevel_gear_back_cone);
			
		// trim back
		translate([0,0,-10+BackOfGear_Z]) cylinder(d=100, h=10);
	} // difference
 
	// hub
	translate([0,0,BackOfGear_Z]) cylinder(d=Housing_OD, h=HubThickness);
} // BD5_DrivenGearBevel

// BD5_DrivenGearBevel();

module BD5_DrivenGear(Hub_Len=DrivenGearHubLen){

	difference(){
		union(){
			translate([0,0,Hub_Len-2]) BD5_DrivenGearBevel();
			translate([0,0,-5]) cylinder(d=BB6805_2RS_ID+3, h=Hub_Len+Overlap);
			
			// Stop Plate
			cylinder(d=RaceBC_d+8, h=Hub_Len-4, $fn=90);
		} // union
		
		// Bolts
		translate([0,0,6]) BD5_LockBoltPattern() Bolt4HeadHole(depth=6+Hub_Len);
		
		// center hole
		translate([0,0,-5-Overlap]) cylinder(d=Race_ID, h=5+Hub_Len+Overlap*3);
		
		// Stop
		translate([0,0,-1]) rotate_extrude(angle=188, start=-4, $fn=90) translate([RaceBC_d/2-2,0,0]) square(4);
	} // difference
} // BD5_DrivenGear

// BD5_DrivenGear(Hub_Len=7);

module BD5_Gear(nTeeth=24, Thickness=8){
	Pitch=GearPitch;
	PressureAngle=GearPressureAngle;
	Clearance=0.4;
	
	Backlash=0.2;
	
	gear(number_of_teeth=nTeeth, circular_pitch=Pitch, diametral_pitch=false,
				pressure_angle=PressureAngle, clearance = Clearance,
				gear_thickness=Thickness, rim_thickness=Thickness, rim_width=3,
				hub_thickness=Thickness, hub_diameter=15, bore_diameter=7.5, circles=0, 
				backlash=Backlash, twist=0, 
				involute_facets=0, flat=false);
} // BD5_Gear

// BD5_Gear();

module BD5_ServoGear(nTeeth=nTeethServoGear){
	ServoWheel_d=20.84+IDXtra*2; // MG996R
	ServoWheel_h=4; //2.7;
	ServoBC_r=8;
	ServoBC2_r=8;
	//ServoWheel_d=23.75+IDXtra*2; // HS5645MG
	//ServoWheel_h=2.0;
	//ServoBC_r=17/2;
	//ServoBC2_r=20/2;
	
	difference(){
		BD5_Gear(nTeeth=nTeeth);
		
		translate([0,0,-Overlap]) cylinder(d=ServoWheel_d, h=ServoWheel_h);
		translate([0,0,ServoWheel_h+5.3]){ // gear thickness
			for (j=[0:1]) rotate([0,0,180*j]) translate([ServoBC_r,0,0]) Bolt4HeadHole();
			for (j=[0:1]) rotate([0,0,180*j+90]) translate([ServoBC2_r,0,0]) Bolt4HeadHole();
			}
	} // difference
} // BD5_ServoGear

//BD5_ServoGear();

module BD5_LockBoltPattern(){
	nBolts=3;
	
	for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j])
			translate([BB6805_2RS_ID/2-Bolt4Inset,0,0]) children();
				
} // BD5_LockBoltPattern

// BD5_LockBoltPattern() Bolt4HeadHole();

module BD5_Lock(){
	
	difference(){
		difference(){
			union(){
				translate([0,0,TopOfRace]) cylinder(d=BB6805_2RS_ID+2, h=2.5);
				translate([0,0,TopOfRace-BB6805_2RS_H]) cylinder(d=BB6805_2RS_ID, h=BB6805_2RS_H+Overlap);
			} // union
			
			translate([0,0,TopOfRace-BB6805_2RS_H-Overlap]) cylinder(d=Race_ID, h=BB6805_2RS_H+3+Overlap*3);
		} // difference
		
		translate([0,0,TopOfRace-BB6805_2RS_H-1]) BD5_LockBoltPattern() rotate([180,0,0]) Bolt4Hole();
			
	} // difference
	
	
	difference(){
		translate([0,0,TopOfRace-Overlap]) cylinder(d=BoosterButtonMajor_d+BD5_Lock_Wall_t*2, 2+BoosterButtonMajor_h+0.5);
		
		// Center hole
		translate([0,0,TopOfRace-Overlap*2]) cylinder(d=Race_ID, h=BoosterButtonMajor_h+4);
		
		translate([0,0,TopOfRace-Overlap*2])
		hull(){
			cylinder(d=BoosterButtonMajor_d+IDXtra*2, h=4+BoosterButtonMajor_h);
			translate([BoosterButtonMajor_d,0,0]) 
				cylinder(d=BoosterButtonMajor_d+IDXtra*2, h=4+BoosterButtonMajor_h);
		} // hull
		
	} // difference
	
} // BD5_Lock

// BD5_Lock();

module BD5_BearingStop(){	
	
	difference(){
		cylinder(d=BB6805_2RS_ID+3, h=2);
		
		translate([0,0,-Overlap]) cylinder(d=Race_ID, h=2+Overlap*2);
		
		// Bolt holes
		BD5_LockBoltPattern()
			translate([0,0,-Overlap])
				rotate([180,0,0]) Bolt4ClearHole();
	} // difference
	
} // BD5_BearingStop

// BD5_BearingStop(); // Only used with ball bearing














































