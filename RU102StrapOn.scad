// ***********************************
// Project: 3D Printed Rocket
// Filename: RU102StrapOn.scad
// by David M. Flynn
// Created: 9/4/2025
// Revision: 0.9.2  9/7/2025 
// Units: mm
// ***********************************
//  ***** Notes *****
//
//   Strap-On Booster
//   102mm diameter, ???mm Long
//   300mm BoosterButton spacing
//   Mission Control V3 / RocketServo
//   54mm motor, 54/852 case J460T
//
//  ***** Parts *****
//
// Blue Tube 2.1" Body Tube: 300mm (Motor Tube)
// ULine Tube 75mm Body Tube: ???mm (Parachute Bay)
// ULine Tube 102mm Body Tube: ???mm (Lower Body)
// 32" Parachute
// 1/8" Paracord (3 feet)
// 1/2" Braided Nylon Shock Cord (20 feet)
//
//  ***** Hardware *****
// **** needs updated, ball lock parts are incomplete, ++
// #4-40 x 1/2" Socket Head Cap Screw (5 req) Ball Lock
// #4-40 x 3/8" Button Head Cap Screw (6 req) Doors
// #4-40 x 3/8" Socket Head Cap Screw (3 req) PetalHub
// #4-40 x 1/4" Button Head Cap Screw (4 req) Altimeter
// #2-56 x 1/4" Socket Head Cap Screw (2 req) Servo
// MR84-2RS Bearing (5 req) Ball Lock
// 3/8" Delrin Ball (5 req) Ball Lock
// 4mm Dia. x 16mm Undersize Steel Dowel (5 req) Ball Lock
// 3/16" Dia x 1/8" Disc Magnet N42 (2 req) Ball Lock
// SG90 or MG90S Micro Servo (1 req) Ball Lock
// C&K Rotary Switch (1 req) Battery Door
// Mission Control V3 Altimeter PCBA
// Rocket Servo PCBA
// 1/4"-20 x 1" Flat head (2 req) (BoosterButton)
// 1/4"-20 Thin Nut (4 req) (BoosterButton)
// 1/4"-20 x 3/4" Button head (SpringEndTop)
// CS4323 Spring
// 5/16" Dia x 1-1/4" Spring (4 req) PetalHub
//
//  ***** History *****
//
// 0.9.2  9/7/2025   Changed Body_OD, added SE_SlidingSpringMiddle
// 0.9.1  9/5/2025   Printing and iterating
// 0.9.0  9/4/2025   Copied from R75StrapOn
//
// ***********************************
//  ***** for STL output *****
//
// *** Nosecode ***
//
// Nosecone();
// rotate([180,0,0]) SpingTop();
// SE_SlidingSpringMiddle(OD=InnerTube_ID-IDXtra*3, nRopes=3, SliderLen=30, SpLen=30, SpringStop_Z=10, UseSmallSpring=true);
// Petal_Hub();
// PD_Petals(OD=InnerTube_ID-IDXtra*3, Len=150, nPetals=nPetals, Wall_t=1.8, AntiClimber_h=4, HasLocks=false);
// rotate([-90,0,0]) PD_PetalSpringHolder2();
//
// *** Ball Lock ***
//
// STB_LockDisk(Body_ID=Engagement_D, nLockBalls=nLockBalls, HasLargeInnerBearing=true, Xtra_r=0.2);
// rotate([180,0,0]) STB_InternalTubeEnd(Body_OD=Body_OD, Body_ID=Body_ID, Engagement_ID=Engagement_D, nLockBalls=5, Engagement_Len=20);
// STB_BallRetainerBottom(Body_ID=Engagement_D, Body_OD=Engagement_D, nLockBalls=nLockBalls, Engagement_Len=Engagement_Len, HasLargeInnerBearing=true, Lighten=false, Xtra_r=0.2);
// rotate([180,0,0]) BallRetainerTop();
// CenteringRing(OD=Body_ID, ID=InnerTube_OD+IDXtra, Thickness=3, nHoles=0, Offset=0, myfn=$preview? 90:360);
// EBay_CR(IsUpper=true);
// EBay_CR(IsUpper=false);
//
// *** Electronics Bay ***
//
// rotate([180,0,0]) Electronics_Bay(TopOnly=true, BottomOnly=false, ShowDoors=false); // Top
// Electronics_Bay(TopOnly=false, BottomOnly=true, ShowDoors=false); // Bottom
// rotate([-90,0,0]) EB_AltDoor(Tube_OD=Body_OD, BlankDoor=false, IsLoProfile=false);
// rotate([-90,0,0]) EB_BattDoor(Tube_OD=Body_OD, HasSwitch=true, DoubleBatt=false, BlankDoor=false); // alt
// rotate([-90,0,0]) EB_BattDoorMagRS(Tube_OD=Body_OD, HasRS_PCB=true, HasSwitch=true, BlankDoor=false); // alt
//
// RocketFin(HasSpiralVaseRibs=false);
// rotate([180,0,0]) FinCan();
// BT54MotorRetainer();
//
// BoosterButton(XtraLen=0.6); // 0.3 is too short
// BoosterButton(XtraLen=0.9);
//
// ***********************************
//  ***** Routines *****
//
//
// ***********************************
//  ***** for Viewing *****
//
// ShowRocketStrapOn(ShowInternals=true);
// ShowRocketStrapOn(ShowInternals=false);
//
// ***********************************
use<AT_RMS_Lib.scad>
include<TubesLib.scad>
use<BoosterDropperLib.scad>
use<Fins.scad>
use<NoseCone.scad>
use<SpringEndsLib.scad>
use<SpringThingBooster.scad> echo(SpringThingBoosterRev());
use<PetalDeploymentLib.scad>
use<ElectronicsBayLib.scad>

//also included
 //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

Vinyl_d=0.3; // measured

nLockBalls=5;
Engagement_Len=20;
Engagement_D=ULine102Coupler_ID-1;

InnerTube_OD=ULine75Body_OD;
InnerTube_ID=ULine75Body_ID;
Body_OD=ULine102Body_OD*CF_Comp+Vinyl_d; // OD of Rocket, this is OK because nothing attaches to the OD of the tube
Body_ID=ULine102Body_ID;
Coupler_OD=ULine102Coupler_OD;
Coupler_ID=ULine102Coupler_ID;
echo(Body_OD=Body_OD);

// *** 54mm Motor Tube ***
MotorTube_OD=BT54Body_OD;
MotorTube_ID=BT54Body_ID;

MotorTubeHole_d=MotorTube_OD+IDXtra*3;

EBay_Len=166; 

// Nosecone param's
NC_Len=162;
NC_Tip_r=8;
NC_Wall_t=1.8;
NC_Base_L=15;

nFins=1;
Fin_Post_h=12; 
Fin_Root_L=120;
Fin_Root_W=10;
Fin_Tip_W=3.0;
Fin_Tip_L=70;
Fin_Span=70;
Fin_TipOffset=0;
Fin_Chamfer_L=32;
FinInset_Len=5;
FinCan_Len=Fin_Root_L+FinInset_Len*2; // Calculated fin can length

	
BoosterDropperCL=300; // for 54/852 case, minimum for sustainer
echo(BoosterDropperCL=BoosterDropperCL);

UpperTubeLen=135;
BodyTubeLen=BoosterDropperCL-FinCan_Len-EBay_Len+64; //-BD_ThrustRing_h();
MotorTubeLen=308; // to bottom of ebay

echo(UpperTubeLen=UpperTubeLen);
echo(BodyTubeLen=BodyTubeLen);
echo(MotorTubeLen=MotorTubeLen);


Bolt4Inset=4;
ShockCord_a=45;
nPetals=3;

MotorTube_Z=-20;
MotorTubeOffset=-12;
MotorTube_a=4;
AftThrustPoint_Z=20;

module ShowRocketStrapOn(ShowInternals=true){
	FinCan_Z=35;
	MotorTube_Z=FinCan_Z+MotorTube_Z;
	Fin_Z=FinCan_Z+FinCan_Len/2;
	
	BodyTube_Z=FinCan_Z+FinCan_Len+Overlap*2;
	EBay_Z=BodyTube_Z+BodyTubeLen-15;
	BallRetainerTop_Z=EBay_Z+EBay_Len;
	UpperTube_Z=EBay_Z+EBay_Len+3.1+Overlap;
	R75SRB_TopRetainer_Z=EBay_Z+EBay_Len;
	SpringEnd_Z=R75SRB_TopRetainer_Z+20;
	
	SpringEndOffet=90;
	NoseCone_Z=UpperTube_Z+UpperTubeLen+Overlap*2;
	
	/*
	translate([0,0,NoseCone_Z]){
		Nosecone();
	
		if (ShowInternals) {
			translate([0,0,SpringEndOffet]) rotate([180,0,0]) SpingTop();
			translate([0,0,SpringEndOffet-40]) rotate([180,0,0]) Petal_Hub();
			translate([0,0,SpringEndOffet-40-3]) rotate([180,0,0]) PD_Petals2(OD=InnerTube_ID, Len=150, nPetals=nPetals, Wall_t=1.8, AntiClimber_h=4, HasLocks=true);
			}
	}
	/**/
	
	if (!ShowInternals) translate([0,0,UpperTube_Z]) 
		color("LightBlue") Tube(OD=Body_OD, ID=Body_ID, Len=UpperTubeLen, myfn=$preview? 90:360);
		
	/*
	translate([0,0,BallRetainerTop_Z+13.1]) rotate([180,0,18]) BallRetainerTop();
	if (ShowInternals) translate([0,0,BallRetainerTop_Z+13.1]) rotate([180,0,18]) 
		STB_BallRetainerBottom(Body_ID=Engagement_D, Body_OD=Engagement_D, nLockBalls=nLockBalls, 
			Engagement_Len=Engagement_Len, HasLargeInnerBearing=true, Lighten=false, Xtra_r=0.2);
	/**/
	
	translate([0,0,EBay_Z]) rotate([0,0,-90]) Electronics_Bay(ShowDoors=!ShowInternals);
	
	
	
	if (ShowInternals==false) translate([0,0,BodyTube_Z]) 
		color("LightBlue") Tube(OD=Body_OD, ID=Body_ID, Len=BodyTubeLen, myfn=$preview? 90:360);
		
	translate([0,0,FinCan_Z]) rotate([0,0,90]) FinCan();
	
	// Motor tube
	if (ShowInternals)
	translate([MotorTubeOffset,0,MotorTube_Z]) rotate([0,MotorTube_a,0]){
		color("LightBlue") Tube(OD=MotorTube_OD, ID=MotorTube_ID, Len=MotorTubeLen-Overlap*2+50, myfn=$preview? 90:360);
		translate([0,0,MotorTube_Z]) ATRMS_54_852_Motor(HasEyeBolt=true);
	}
	
	translate([Body_OD/2+13,0,FinCan_Z+AftThrustPoint_Z]){
		rotate([0,-90,0]) BoosterButton(XtraLen=0.3);
		translate([0,0,BoosterDropperCL]) rotate([0,-90,0]) BoosterButton(XtraLen=0.3);
		}
		
	rotate([0,0,90])
		translate([0, Body_OD/2-Fin_Post_h, Fin_Z]) 
			rotate([-90,0,0]) color("Yellow") RocketFin(false);
	

} // ShowRocketStrapOn

// ShowRocketStrapOn(ShowInternals=true);
// ShowRocketStrapOn(ShowInternals=false);

module FinCanFix(){
	// only reprint the portion that failed
	
	GoodPortion_H=159;
	
	difference(){
		translate([0,0,FinCan_Len+15]) rotate([180,0,0]) FinCan();
		
		translate([0,0,-Overlap]) cylinder(d=Body_OD+10, h=GoodPortion_H);
	} // difference
} // FinCanFix

// FinCanFix();

module EBay_CR(IsUpper=true){
	CR_t=4;
	FinCan_Z=35;
	MotorTube_Z=FinCan_Z+MotorTube_Z;
	BodyTube_Z=FinCan_Z+FinCan_Len;
	EBay_Z=BodyTube_Z+BodyTubeLen-15;
	TopOfEBay=EBay_Z+EBay_Len;
	TopCR_Z=TopOfEBay-16-CR_t;
	BotCR_Z=EBay_Z+9;
	
	Servo_X=15;
	Servo_Y=25;
	Servo_a=55;
	ServoPos_X=0;
	ServoPos_Y=31;
	ServoPos_a=98;
	
	difference(){
		if (IsUpper){
			translate([0,0,TopCR_Z]) cylinder(d=Body_ID, h=CR_t);
		}else{
			translate([0,0,BotCR_Z]) cylinder(d=Body_ID-6, h=CR_t);
		}
		
		translate([MotorTubeOffset,0,MotorTube_Z]) rotate([0,MotorTube_a,0])
			cylinder(d=MotorTube_OD+IDXtra*2, h=TopOfEBay);
			
		// Servo Hole
		#if (IsUpper)
			rotate([0,0,ServoPos_a]) translate([ServoPos_X,ServoPos_Y,TopCR_Z-Overlap]) 
				rotate([0,0,Servo_a]) {
					RoundRect(X=Servo_X, Servo_Y, Z=CR_t+Overlap*2, R=1);
					// wires
					translate([0,Servo_Y/2,0]) cylinder(d=8, h=CR_t+Overlap*2);
				}
			
		// Key
		if (IsUpper){
			translate([-Body_ID/2,0,TopCR_Z-Overlap]) cylinder(d=5, h=CR_t+Overlap*2);
		}else{
			translate([-Body_ID/2+3,0,BotCR_Z-Overlap]) cylinder(d=5, h=CR_t+Overlap*2);
		}
	} // difference
	
} // EBay_CR

// 
EBay_CR(IsUpper=true); 
// EBay_CR(IsUpper=false);

module Nosecone(){
	AeroShellCoupler_Len=15;
	nBolts=5;
	
	module BodyTubeAlignment(OD=100){
		nSpokes=7;
		
		Tube(OD=InnerTube_OD+IDXtra*2+4.4, ID=InnerTube_OD+IDXtra*2, Len=5, myfn=$preview? 90:360);
		for (j=[0:nSpokes-1]) rotate([0,0,360/nSpokes*j]) hull(){
			translate([0,InnerTube_OD/2+1.2,0]) cylinder(d=2, h=5);
			translate([0,OD/2,0]) cylinder(d=2, h=5);
		} // hull
	} // BodyTubeAlignment
	
	BluntOgiveNoseCone(ID=Body_ID, OD=Body_OD, L=NC_Len, Base_L=NC_Base_L, 
		nRivets=0, RivertInset=0, Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, FillTip=true);
		
	difference(){
		translate([0,0,-AeroShellCoupler_Len])
			Tube(OD=Body_ID, ID=Body_ID-4.4, Len=AeroShellCoupler_Len+Overlap, myfn=$preview? 90:360);
			
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+6]) translate([0,Body_OD/2,-7.5]) rotate([-90,0,0]) Bolt4Hole();
	} // difference
		
	difference(){
		cylinder(d=Body_OD-1, h=3, $fn=$preview? 90:360);
		
		translate([0,0,-Overlap]) cylinder(d1=Body_ID-4.4, d2=Body_ID, h=3+Overlap*2, $fn=$preview? 90:360);
	} // difference
	
	
	translate([0,0,-AeroShellCoupler_Len]) BodyTubeAlignment(OD=Body_ID-2);
	translate([0,0,40]) BodyTubeAlignment(OD=101);
		
} // Nosecone

// Nosecone();

module SpingTop(Tube_OD=InnerTube_OD, Tube_ID=InnerTube_ID, Spring_OD=SE_Spring_CS4323_OD(), Spring_ID=SE_Spring_CS4323_ID(), nRopes=3){
	Len=10;
	Engagement=7;
	Rope_d=4;
	HasAlTube=true;
	AlTube_OD=12.7;
	AlTube_a=30;
	AlTube_Z=-14;
	AlTube_Len=66;
	
	difference(){
		union(){
			cylinder(d=Tube_OD, h=3+Overlap, $fn=$preview? 90:360);
			
			translate([0,0,3]) Tube(OD=Tube_ID, ID=Tube_ID-4.4, Len=Len-3+Overlap, myfn=$preview? 90:360);
			
			translate([0,0,-10]) cylinder(d=Spring_OD+6, h=10);
			
			rotate([0,0,AlTube_a])
				hull(){
					translate([0,0,AlTube_Z]) rotate([90,0,0]) cylinder(d=AlTube_OD+6, h=AlTube_Len, center=true, $fn=$preview? 90:360);
					cube([AlTube_OD+8, AlTube_Len, Overlap], center=true);
				} // hull
		} // union
				
		// center hole
		translate([0,0,AlTube_Z-10]) cylinder(d=Spring_ID, h=50, $fn=$preview? 90:180);
		
		translate([0,0,-7]) cylinder(d=Spring_OD, h=Len+Overlap*2, $fn=$preview? 90:360);
		translate([0,0,-4]) cylinder(d1=Spring_OD, d2=Spring_OD+2, h=7+Overlap*2, $fn=$preview? 90:360);
		
		for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j]) translate([0,Spring_OD/2+10,-Overlap]) cylinder(d=Rope_d, h=Len);
		
		translate([0,0,95]) rotate([180,0,0]) Nosecone();
		
		rotate([0,0,AlTube_a])
			translate([0,0,AlTube_Z]) rotate([90,0,0]) cylinder(d=AlTube_OD+IDXtra, h=AlTube_Len+Overlap, center=true, $fn=90);
	} // difference
	
	
} // SpingTop

// rotate([180,0,0]) SpingTop();

module Petal_Hub(){

	PD_NC_PetalHub(OD=InnerTube_ID-IDXtra*3, nPetals=3, HasReplaceableSpringHolder=false, nRopes=3, ShockCord_a=-1, 
		HasThreadedCore=false, ST_DSpring_ID=SE_Spring_CS4323_ID(), ST_DSpring_OD=SE_Spring_CS4323_OD(), CouplerTube_ID=0, CouplerTubeLen=0);

} // Petal_Hub

// Petal_Hub();

module BallRetainerTop(){
	STB_BallRetainerTop(Outer_OD=Body_OD, Engagement_d=Engagement_D, nLockBalls=nLockBalls, 
			HasIntegratedCouplerTube=true, nBolts=5, Bolt_a=0, IntegratedCouplerLenXtra=-10, Body_ID=Body_ID, 	
			HasSecondServo=false, UsesBigServo=false, Engagement_Len=Engagement_Len, HasLargeInnerBearing=true, Xtra_r=0.2);
		
} // BallRetainerTop

// BallRetainerTop();

module Electronics_Bay(TopOnly=false, BottomOnly=false, ShowDoors=false){
	Alt_a=45;
	Batt1_a=-45;
	CR_t=4;
	
	DoorAngles=[[Alt_a],[],[Batt1_a]];
	ExtraBolts=[165,195,180+40,180-40,180+70,180-70];
	
	difference(){
		union(){
			EB_Electronics_BayUniversal(Tube_OD=Body_OD, Tube_ID=Body_ID, DoorAngles=DoorAngles, Len=EBay_Len, 
									nBolts=5, BoltInset=7.5, ShowDoors=ShowDoors,
									HasFwdIntegratedCoupler=false, HasFwdShockMount=false,
									HasAftIntegratedCoupler=true, HasAftShockMount=false,
									HasRailGuide=false, RailGuideLen=35,
									HasFwdCenteringRing=false, HasAftCenteringRing=false, InnerTube_OD=0,
									Bolted=true, ExtraBolts=[], GlobalExtraBolts=ExtraBolts, TopOnly=TopOnly, BottomOnly=BottomOnly); 
		} // union
		
		translate([0,Body_OD/2,EBay_Len-25-CR_t]) rotate([-90,0,0]) Bolt250Hole();
	} // difference
	
	// Top CR Stop
	if (!BottomOnly)
	translate([0,0,EBay_Len-16-CR_t]) {
		rotate([180,0,0]) TubeStop(InnerTubeID=Coupler_ID, OuterTubeOD=Body_OD, myfn=$preview? 36:360);
		// Key
		translate([0,-Body_ID/2,-Overlap]) cylinder(d=4, h=CR_t);
	}
	
	// Bottom CR Stop
	if (!TopOnly)
	translate([0,0,CR_t+9]) {
		TubeStop(InnerTubeID=Coupler_ID-6, OuterTubeOD=Coupler_ID, myfn=$preview? 36:360);
		// Key
		translate([0,-Coupler_ID/2+1,-CR_t]) cylinder(d=4, h=CR_t+Overlap);
	}
	
	if (!BottomOnly)
	difference(){
		union(){
			intersection(){
				cylinder(d=Body_OD-1, h=EBay_Len-16-CR_t);
				
				union(){
					translate([0,Body_OD/2,EBay_Len*0.75]) cube([40,10,70], center=true);
					translate([0,Body_OD/2-4,EBay_Len-25-CR_t]) rotate([90,0,0]) cylinder(d1=30, d2=20, h=6);
				} // union
			} // intersection
			
			translate([0,Body_OD/2,EBay_Len-25-CR_t]) rotate([90,0,0]) cylinder(d=12, h=3);
		} // union
		
		translate([0,Body_OD/2,EBay_Len-25-CR_t]) rotate([-90,0,0]) Bolt250Hole();
		translate([0,Body_OD/2-4,EBay_Len-25-CR_t]) rotate([90,0,0]) Bolt250NutHole();
	} // difference
} // Electronics_Bay

// Electronics_Bay();

module BoosterMount(){
	difference(){
		rotate([0,0,90]) BoosterThrustRing(MtrTube_OD=MotorTube_OD, BodyTube_OD=Body_OD);
		
		// Embed nuts
		translate([MotorTube_OD/2+4.5,0,BD_ThrustRing_h()/2]) rotate([0,-90,0]) Bolt250NutHole(depth=7);
		translate([Body_OD/2-4,0,BD_ThrustRing_h()/2]) rotate([0,90,0]) Bolt250NutHole(depth=5);
		
	} // difference
} // BoosterMount

// BoosterMount();

MotorRetainer_d=65;
MotorRetainer_Len=33;

module FinCan(){
	//FinCan_Len
	//MotorTubeOffset
	//MotorTube_a

	Can_OD=Body_OD;
	nBolts=5;
	Wall_t=1.2;
	FinBox_W=Fin_Root_W+Wall_t*2;
	Coupler_Len=15;
	FB_Xtra_Fwd=15;
	nFinBoxes=3;
	
	difference(){
		union(){
			translate([0,0,FinCan_Len-Overlap]) Tube(OD=Body_ID, ID=Coupler_ID, Len=Coupler_Len, myfn=$preview? 90:360);
			translate([0,0,FinCan_Len-6]) 
				difference(){
					Tube(OD=Can_OD-1, ID=Coupler_ID, Len=6, myfn=$preview? 90:360);
					translate([0,0,-Overlap]) cylinder(d1=Can_OD-1, d2=Coupler_ID, h=5, $fn=$preview? 90:360);
				} // difference
			
			// Body
			Tube(OD=Can_OD, ID=Can_OD-Wall_t*2, Len=FinCan_Len, myfn=$preview? 90:360);
			
			// Tailcone
			TC_r=10;
			hull(){
				translate([0,-MotorTubeOffset,MotorTube_Z]) rotate([180+MotorTube_a,0,0])	
					cylinder(d=MotorRetainer_d+1.2, h=15, $fn=$preview? 90:360);
					
				difference(){
					rotate_extrude($fn=$preview? 90:360) translate([Can_OD/2-TC_r,0,0]) circle(r=TC_r);
					translate([0,0,Overlap]) cylinder(d=Can_OD+Overlap, h=TC_r, $fn=$preview? 90:360);
				} // difference
				//Tube(OD=Can_OD, ID=Body_ID, Len=Overlap, myfn=$preview? 90:360);
			} // hull
			
			// Motor tube sleeve
			difference(){
				translate([0, -MotorTubeOffset, MotorTube_Z]) rotate([MotorTube_a,0,0]) 
					Tube(OD=MotorTubeHole_d+Wall_t*2, ID=MotorTubeHole_d, Len=FinCan_Len+50, myfn=$preview? 90:360);
				translate([0,0,FinCan_Len+15]) cylinder(d=Can_OD+10, h=20);
			} // difference
			
			// Fin Boxes
			difference(){
				union(){
					for (j=[0:nFinBoxes-1]) rotate([0,0,360/nFinBoxes*j]) 
						translate([-FinBox_W/2,0,0]) cube([FinBox_W, Can_OD/2, FinCan_Len+FB_Xtra_Fwd]);
				
					// extra box on thrust line
					rotate([0,0,180]) translate([-FinBox_W/2,0,0]) cube([FinBox_W, Can_OD/2, FinCan_Len+FB_Xtra_Fwd]);
				} // union
				
				// remove outside
				difference(){
					translate([0,0,-Overlap]) cylinder(d=Can_OD+10, h=FB_Xtra_Fwd+FinCan_Len+Overlap*2);
					translate([0,0,-Overlap*2]) cylinder(d=Can_OD-1, h=FB_Xtra_Fwd+FinCan_Len+Overlap*4);
				} // difference
				
				// remove inside
				translate([0,-MotorTubeOffset,MotorTube_Z]) rotate([MotorTube_a,0,0])
					translate([0,0,-Overlap]) cylinder(d=MotorTubeHole_d+1, h=FB_Xtra_Fwd+FinCan_Len+50);
				
				// Remove outside of Integrated Coupler
				if (FB_Xtra_Fwd>0)
					translate([0,0,FinCan_Len]) Tube(OD=Can_OD+1, ID=Body_ID-1, Len=Coupler_Len+Overlap, myfn=$preview? 36:360);
					
			} // difference
			
			// Thrust transfer point
			translate([0,-Can_OD/2+1,AftThrustPoint_Z]){
					rotate([-90,0,0]) cylinder(d=20, h=50);
					rotate([-90,0,0]) translate([0,0,-1]) cylinder(d=12, h=5);
				}
		} // union
		
		// Body tube bolts
		for(j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) translate([0,Can_OD/2,FinCan_Len+7.5]) rotate([-90,0,0]) Bolt4Hole();
		
		// Fin socket
		rotate([0,0,180]) translate([0,0,FinCan_Len/2])
			TrapFin3Slots(Tube_OD=Can_OD, nFins=nFins, Post_h=Fin_Post_h, 
					Root_L=Fin_Root_L, Root_W=Fin_Root_W, Chamfer_L=Fin_Chamfer_L);
				
		//translate([0,-MotorTubeOffset,MotorTube_Z]) rotate([MotorTube_a,0,0]) 
		//	translate([0,0,-Overlap]) cylinder(d=MotorTube_ID, h=5, $fn=$preview? 90:360);
		
		translate([0,-MotorTubeOffset,MotorTube_Z]) rotate([MotorTube_a,0,0]) 
			translate([0,0,-Overlap]) cylinder(d=MotorTubeHole_d, h=100, $fn=$preview? 90:360);

		// Motor Retainer
		translate([0,-MotorTubeOffset,MotorTube_Z]) rotate([180+MotorTube_a,0,0])	
			translate([0,0,-15]) cylinder(d=MotorRetainer_d+IDXtra*2, h=MotorRetainer_Len, $fn=$preview? 90:360);
			
		translate([0,-Can_OD/2,AftThrustPoint_Z]){
			rotate([90,0,0]) Bolt250Hole();
			translate([0,4,0]) rotate([-90,0,0]) Bolt250NutHole(depth=50);
			}
		
		
		if ($preview) rotate([0,0,160]) translate([0,0,-50]) cube([100,100,500]);
	} // difference
	
	/*
	if ($preview) translate([0,-MotorTubeOffset,MotorTube_Z]) rotate([MotorTube_a,0,0]) {
		color("Blue") Tube(OD=MotorTube_OD, ID=MotorTube_ID, Len=MotorTubeLen, myfn=$preview? 90:360);
		color("LightGray") translate([0,0,-18]) Tube(OD=MotorRetainer_d, ID=MotorRetainer_d-6, Len=MotorRetainer_Len, myfn=$preview? 90:360);
		}
		/**/
} // FinCan

// FinCan();

module RocketFin(HasSpiralVaseRibs=true){
	
	TrapFin3(Post_h=Fin_Post_h, Root_L=Fin_Root_L, Tip_L=Fin_Tip_L, Root_W=Fin_Root_W,
				Tip_W=Fin_Tip_W, Span=Fin_Span, Chamfer_L=Fin_Chamfer_L,
				TipOffset=Fin_TipOffset,
				Bisect=false, Bisect_X=0,
				HasSpar=false, Spar_d=8, Spar_L=100, HasSpiralVaseRibs=HasSpiralVaseRibs);
				
	
} // RocketFin

// RocketFin(HasSpiralVaseRibs=false);




































