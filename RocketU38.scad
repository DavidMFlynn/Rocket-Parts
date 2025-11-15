// ***********************************
// Project: 3D Printed Rocket
// Filename: RocketU38.scad
// by David M. Flynn
// Created: 8/9/2025 
// Revision: 1.1.0  11/12/2025 
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  Rocket with 38mm Body and 29mm motor. 
//  Recommended Motors: G74W, H235T
//
//  Built, Ground test successful and ready to fly 9/2025
//
//  ***** Tubes *****
//
// LOC Motor Tube 29mm x 12"
// U-Line 1-1/2" x 2' (25") Mailing Tube
//
//  ***** Hardware *****
//
// Spring 3670CS (3 Req)
// Machine Screw #2-56 x 1/4" SHCS (1 Req)
// Machine Screw #4-40 x 1/4" BHCS (7 Req)
// Machine Screw #4-40 x 3/8" SHCS (7 Req)
// Machine Screw #4-40 x 3/4" SHCS (4 Req)
// Machine Screw #8-32 x 1/2" Pan Ph Nylon
// Machine Screw #4-40 x 1/4" Pan Ph Nylon
//
// Threaded Rod #10-24 x 100mm
// Aluminum Tube 5/16" O.D. x 65mm
// Delrin Balls 6mm Dia. (3 Req) 
// Servo SG90 9g 
// Dowel Pin 3mm Dia (undersize) x 16mm (3 Req)
// Ball Bearing MR63 (3 Req)
//
//  ***** Parts Not In Kit *****
//
//	Blue Raven Altimeter
//  Magnetic Switch
//  2S 320mAh LIPO Battery
//  Rocket Servo PCBA
//  Parachute
//  Vinyl or Paint
//
//
//  ***** History *****
//
// 1.1.0  11/12/2025 Many changes. CableReleaseBBMicro
// 1.0.0  9/1/2025   Added notes. Ready for test flight.
// 0.9.4  8/21/2025  Reversed servo rotation (the glitch caused deployment on power-up), Added Notes
// 0.9.3  8/19/2025  working on EBay
// 0.9.2  8/14/2025  worked on ShowRocket(), printing and iterating continues
// 0.9.1  8/10/2025  Working on small cable release
// 0.9.0  8/9/2025   Copied from R75D
//
// ***********************************
//  ***** for STL output *****
//
// *** Nosecode ***
//
Vinyl_d=0.5;
//
// NoseCone();
// NC_Base38(Body_OD=Body_OD+Vinyl_d, Body_ID=Body_ID, NC_Base_L=NC_Base_L);
//
// *** petal deployer ***
//
// R38_PetalHub(OD=Body_ID-IDXtra*2);
// rotate([-90,0,0]) PetalNotSpringHolder();
// rotate([180,0,0]) PD_Petals(OD=Coupler_OD, Len=Petal_Len, nPetals=nPetals, Wall_t=1.4, AntiClimber_h=0, HasLocks=true, Lock_Span_a=30);
// PetalCatch();
//
// SE_R38SlidingSmallSpringMiddle(OD=Coupler_OD);
//
// *** Electronics Bay ***
//
// EBayBR();
// EBayRS();
// EBayBase(OD=ULine38Body_ID-IDXtra, H=6);
//
// Tube(OD=Coupler_OD, ID=Coupler_OD-2.4, Len=25, myfn=90); // spacer
//
// *** Fin Can ***
//
// MotorTubePlug();
// rotate([180,0,0]) MotorTubeTopper(OD=Body_ID, ID=MotorTube_OD, MT_ID=MotorTube_ID);
//
// Fincan(LowerHalfOnly=false, UpperHalfOnly=false, Hollow=true);
//
// RocketFin(HasSpiralVaseRibs=true);
//
// RailButton();
//
// SnapRing();
//
// ***********************************
//  ***** Tools *****
//
// AltStopDrillingJig(Len=30, nBolts=2, Xtra_OD=0.5); // for vinyl covered tube
// FinFixture();
//
// CP_SpringWindingTool(); // Only ever need one!
//
// ***********************************
//  ***** Routines *****
//
//
// ***********************************
//  ***** for Viewing *****
//
// ShowRocket(ShowInternals=false);
// translate([300,0,0]) ShowRocket(ShowInternals=true);
//
//
// ***********************************
include<TubesLib.scad>
use<AT_RMS_Lib.scad>
use<RailGuide.scad>
use<Fins.scad>
use<NoseCone.scad>
use<FinCan2Lib.scad>
use<PetalDeploymentLib.scad>
use<SpringEndsLib.scad>			echo(SpringEndsLibRev());
use<BatteryHolderLib.scad>		echo(BatteryHolderLibRev());
use<ThreadLib.scad>
use<CableReleaseBBMicro.scad>

//also included
 //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;
Bolt4Inset=4;
Bolt10Inset=5.5;

// Nosecone param's
NC_Len=150;
NC_Tip_r=3; 
NC_Wall_t=1.2;
NC_Base_L=12;

nPetals=2;

Petal_Len=140; // 100 is too short, Main 'chute and lots of shock cord

// U-Line 1.5" Mailing Tube version
Body_OD=ULine38Body_OD;
Body_ID=ULine38Body_ID;
Coupler_OD=BT38Coupler_OD;
Coupler_ID=BT38Coupler_ID;
// *** 38mm Motor Tube ***

MotorTube_OD=LOC29Body_OD;
MotorTube_ID=LOC29Body_ID;

TailCone_Len=20;
TailConeExtra_OD=2;

/*
// big fins
nFins=5;
Fin_Post_h=Body_OD/2-MotorTube_OD/2-1.2;
Fin_Root_L=120;
Fin_Root_W=5;
Fin_Tip_W=2.0;
Fin_Tip_L=50;
Fin_Span=60;
Fin_TipOffset=20;
Fin_Chamfer_L=15;
FinInset_Len=5;
/**/

//*
// Small fins
nFins=5;
Fin_Post_h=Body_OD/2-MotorTube_OD/2-1.2;
Fin_Root_L=120;
Fin_Root_W=5;
Fin_Tip_W=2.0;
Fin_Tip_L=50;
Fin_Span=50;
Fin_TipOffset=20;
Fin_Chamfer_L=15;
FinInset_Len=5;
/**/

FinCan_Len=Fin_Root_L+FinInset_Len*2; // Calculated fin can length

// For display only, not used by parts
BodyTubeLen=637; // stock tube is 637mm
MotorTubeLen=(12*25.4); 

echo(BodyTubeLen=BodyTubeLen);
echo(MotorTubeLen=MotorTubeLen);

module ShowRocket(ShowInternals=false){
	FinCan_Z=TailCone_Len;
	Fin_Z=FinCan_Z+FinCan_Len/2;
	MotorTube_Z=FinCan_Z-TailCone_Len+12;
	EBay_Z=MotorTube_Z+MotorTubeLen+3+32.4;
	BodyTube_Z=FinCan_Z+FinCan_Len+Overlap*2;
	NoseCone_Z=BodyTube_Z+BodyTubeLen+2.1;
	
	SCR_Z=NoseCone_Z-7.2-9-Petal_Len-30.5-35-35-14;
	
	echo(str("Overall Length = ",(NoseCone_Z+NC_Len)/25.4));

	translate([0,0,NoseCone_Z]){
		rotate([0,0,90]) color("Orange") NoseCone();
		rotate([0,0,90]) color("Tan")
			NC_Base38(Body_OD=Body_OD+Vinyl_d, Body_ID=Body_ID, NC_Base_L=NC_Base_L);
			
		if (ShowInternals){
			translate([0,0,-7.2]) rotate([180,0,0]) R38_PetalHub();
			translate([0,0,-7.2-9]) rotate([180,0,0]) 
				PD_Petals2(OD=Coupler_OD, Len=Petal_Len, nPetals=nPetals, Wall_t=1.6, AntiClimber_h=0, HasLocks=true);
				
			translate([0,0,-7.2-9-Petal_Len-30.5]) CatchHolder();
			
			translate([0,0,-7.2-9-Petal_Len-30.5]) rotate([180,0,0]) SE_R38SpingTop();
			translate([0,0,-7.2-9-Petal_Len-30.5-32]) SE_R38SlidingSmallSpringMiddle(OD=Coupler_OD);
			translate([0,0,-7.2-9-Petal_Len-30.5-32-32]) SE_R38SlidingSmallSpringMiddle(OD=Coupler_OD);
			translate([0,0,-7.2-9-Petal_Len-30.5-32-32-7]) SE_R38SpringBottom(OD=Coupler_OD);

		}
	}
	
	if (ShowInternals){
		translate([0,0,SCR_Z]) SCR_Show_All(ShowLocked=true);
		translate([0,0,EBay_Z]) EBayBR();
	}
		
	if (!ShowInternals)
		translate([0,0,BodyTube_Z]) color("LightBlue") 
			Tube(OD=Body_OD, ID=Body_ID, Len=BodyTubeLen-Overlap*2, myfn=$preview? 90:360);
						
	if (ShowInternals)
		translate([0,0,MotorTube_Z]) {
			color("Blue") Tube(OD=MotorTube_OD, ID=MotorTube_ID, Len=MotorTubeLen-Overlap*2, myfn=$preview? 90:360);
			translate([0,0,MotorTubeLen-18]) MotorTubeTopper(OD=Body_ID, ID=MotorTube_OD, MT_ID=MotorTube_ID);
		}	
	translate([0,0,FinCan_Z]) color("Orange") Fincan(LowerHalfOnly=false, UpperHalfOnly=false, Hollow=true);
	
	for (j=[0:nFins-1]) rotate([0,0,360/nFins*j+180/nFins])
		translate([0, Body_OD/2-Fin_Post_h, Fin_Z]) 
			rotate([-90,0,0]) color("Orange") RocketFin(false);
		
} // ShowRocket

// ShowRocket(ShowInternals=false);
// ShowRocket(ShowInternals=true);

module PetalNotSpringHolder(){
	// No Spring

	difference(){
		PD_PetalSpringHolder();
		
		translate([0,-19.45,5.95]) cube([20,20,20], center=true);
	} // difference
	
} // PetalNotSpringHolder

// rotate([-90,0,0]) PetalNotSpringHolder();

module MotorTubeTopper(OD=Body_ID, ID=MotorTube_OD, MT_ID=MotorTube_ID){
	Len=20;
	nSpokes=5;
	Spoke_W=2;
	ShockCord_d=2.2;
	
	difference(){
		union(){
			Tube(OD=OD, ID=OD-2.4, Len=Len, myfn=$preview? 90:360);
			Tube(OD=ID+IDXtra+2.4, ID=ID+IDXtra, Len=Len, myfn=$preview? 90:360);
			translate([0,0,Len-2]) Tube(OD=ID+IDXtra+2.4, ID=MT_ID, Len=2, myfn=$preview? 90:360);
			
			// spokes
			for(j=[0:nSpokes-1]) rotate([0,0,360/nSpokes*j]) hull(){
				translate([0,(ID+IDXtra+2.4)/2,0]) cylinder(d=Spoke_W, h=Len);
				translate([0,(OD-2.4)/2,0]) cylinder(d=Spoke_W, h=Len);
			} // hull
			
			// rail button 
			intersection(){
				cylinder(d=OD, h=Len);
				translate([0,ID/2+IDXtra,Len/2]) rotate([-90,0,0]) cylinder(d=10, h=(OD-ID)/2);
			} // intersection
		} // union
		
		// Rail button bolt
		translate([0,OD/2+1,Len/2]) rotate([-90,0,0]) Bolt8Hole();
		
		// Shock cord
		k=0;
		a=22.5;
		rotate([0,0,360/nSpokes*k-a]) 
			translate([0, OD/2-1-ShockCord_d/2, -Overlap]) cylinder(d=ShockCord_d, h=Len+Overlap*2);
		rotate([0,0,360/nSpokes*k+a]) 
			translate([0, OD/2-1-ShockCord_d/2, -Overlap]) cylinder(d=ShockCord_d, h=Len+Overlap*2);
	} // difference
} // MotorTubeTopper

// MotorTubeTopper();

module FinFixture(){
	Wall_t=3.3;
	
	difference(){
		union(){
			translate([0,0,-Fin_Root_L/2-20]) cylinder(d=Body_OD+Wall_t*2, h=60);
			
			for (j=[0:nFins-1]) rotate([0,0,360/nFins*j+180/nFins])
				translate([0,Body_OD/2,-Fin_Root_L/2-20]) cube([10,30,60]);
		} // union
		
		translate([0,0,-Fin_Root_L/2-20-Overlap]) cylinder(d=Body_OD+Vinyl_d+IDXtra*2, h=100);
	
		for (j=[0:nFins-1]) hull(){
			rotate([0,0,360/nFins*j+180/nFins])
				translate([0, Body_OD/2-Fin_Post_h, 0]) 
					rotate([-90,0,0]) RocketFin(HasSpiralVaseRibs=false, PrinterBrim_H=0);
			rotate([0,0,360/nFins*j+180/nFins+3])
				translate([0, Body_OD/2-Fin_Post_h, 0]) 
					rotate([-90,0,0]) RocketFin(HasSpiralVaseRibs=false, PrinterBrim_H=0);}

		// Avoid glue	
		for (j=[0:nFins-1]) rotate([0,0,360/nFins*j]) translate([0, -Body_OD/2-6, 0]) hull(){
			rotate([-90,0,0]) cylinder(d1=Fin_Root_W, d2=Fin_Root_W+8, h=8);
			translate([0,0,-Fin_Root_L/2])
				rotate([-90,0,0]) cylinder(d1=Fin_Root_W, d2=Fin_Root_W+8, h=8);
		} // hull			
		
	} // difference
} // FinFixture

// FinFixture();

module EBayBR(){
	// Blue Raven Alt Bay
	
	OAH=48; // OAH=65.5; // height of Rocket Servo
	Batt_X=20;
	Batt_Y=12.2;
	Batt_Z=43;
	
	TubeCenter=[0,0,0];
	
	module BattHole(Xtra_X=0,Xtra_Y=0, Xtra_Z=0){
		cube([Batt_X+Xtra_X, Batt_Y+Xtra_Y, Batt_Z+Xtra_Z], center=true);
	} // BattHole
	
	module BattPocket(){
		Wall_t=1.2;
		
		difference(){
			BattHole(Xtra_X=Wall_t*2,Xtra_Y=Wall_t*2, Xtra_Z=Wall_t*2);
			
			translate([0,0,2]) BattHole(Xtra_X=0, Xtra_Y=0, Xtra_Z=4);
			
			// wires
			translate([0,0,Batt_Z/2+2]) rotate([0,90,0]) cylinder(d=7, h=20);
			
			// push-up
			translate([0,0,-Batt_Z/2-Wall_t-Overlap]) cylinder(d=5,h=5);
		} // difference
	} // BattPocket
	
	
	Thread_p=25.4/24;
	
	translate([0,0,Thread_p*floor((OAH-6)/Thread_p)]) rotate([0,0,90]) EBayEndRing(OD=ULine38Body_ID-IDXtra, H=6);
	
	difference(){
		rotate([0,0,90]) EBayEndRing(OD=ULine38Body_ID-IDXtra, H=6);
		translate([BR_X, BR_Y, BR_Z]) rotate([0,180,0]) rotate([0,0,-90]) rotate([0,90,0]) 
				BlueRavenBoltPattern() rotate([180,0,0]) Bolt4Hole(depth=25);
	} // difference
	
	
	
	//*
	BR_Y=6.8;
	BR_X=0;
	BR_Z=23;
	BattPocketPos_Z=22.7;
	BattPocketPos_Y=8.4;
	
		//BlueRavenMount();
		difference(){
			union(){
				translate([BR_X, BR_Y, BR_Z]) rotate([0,180,0]) rotate([0,0,-90]) rotate([0,90,0]) 
					BlueRavenBoltPattern() cylinder(d=6.5, h=4);
				translate([BR_X,BattPocketPos_Y,BattPocketPos_Z]) BattPocket();
			} // union
			
			translate([BR_X, BR_Y, BR_Z]) rotate([0,180,0]) rotate([0,0,-90]) rotate([0,90,0]) 
				BlueRavenBoltPattern() rotate([180,0,0]) Bolt4Hole(depth=25);
				
			// big capacitor
			//translate([BR_X, BR_Y, BR_Z]) rotate([0,180,0]) rotate([0,0,90]) rotate([0,90,0]) 
			//	translate([-8.5,-4,0]) cube([15,13,14.5]);
		} // difference
		
		if ($preview) translate([BR_X, BR_Y, BR_Z]) rotate([0,180,0]) rotate([0,0,-90]) rotate([0,90,0]) 
			translate([14,-8,0]) #cube([7,16,14.5]);
	
	/**/

} // EBayBR

// EBayBR();


module EBayRS(){
	// Blue Raven Alt Bay
	
	OAH=67; // height of Rocket Servo
	

	
	Thread_p=25.4/24;
	
	module TieBar(){
		TBar_w=22;
		translate([-2,0,0])
		hull(){
			translate([0,-TBar_w/2,0]) cylinder(d=2, h=6);
			translate([0,TBar_w/2,0]) cylinder(d=2, h=6);
		} // hull
	} // TieBar

	translate([0,0,Thread_p*floor((OAH-6)/Thread_p)]) {
		EBayEndRing(OD=ULine38Body_ID-IDXtra, H=6);
		TieBar();
	}
	EBayEndRing(OD=ULine38Body_ID-IDXtra, H=6);
	TieBar();
	
	MagSw_Z=15;
	translate([-2,2,MagSw_Z]) rotate([0,0,90]) rotate([90,0,0]) FW_MagSw_Mount(HasMountingEars=false);
	
	RS_Z=32.75;
	
	
		difference(){
			translate([-2,0,RS_Z]) rotate([0,0,-90]) rotate([90,0,0]) RocketServoHolderRevC(IsDouble=false);
			
			translate([3,2,MagSw_Z]) rotate([0,0,90]) rotate([90,0,0]) FW_MagSw_BoltPattern() Bolt4Hole();
			
			// Remove back
			translate([-2,0,RS_Z]) rotate([0,0,-90]) rotate([90,0,0]) 
			translate([0,0,-Overlap]) 
			hull(){
				cylinder(d=12, h=10);
				translate([0,28,0]) cylinder(d=3, h=10);
				translate([0,-28,0]) cylinder(d=3, h=10);
			} // hull
			
			
		} // difference
		
	

} // EBayRS

// EBayRS();

module EBayEndRing(OD=ULine38Body_ID-IDXtra, H=6){
	Wall_t=1.2;
	Boss_t=H;

	module BoltBoss(){
		difference(){
			hull(){
				translate([0,OD/2-Bolt10Inset,0]) cylinder(d=8, h=Boss_t);
				translate([0,OD/2-Wall_t,0]) scale([1,0.2,1]) cylinder(d=9, h=Boss_t);
			} // hull
		
			Thread_d=Thread1024_d;
			Thread_p=25.4/24;
					
			if ($preview){
				translate([0,OD/2-Bolt10Inset,-Overlap]) cylinder(d=Thread_d, h=Boss_t+Overlap*2); 
			}else{
				translate([0,OD/2-Bolt10Inset,-Overlap]) 
					ExternalThread(Pitch=Thread_p, Dia_Nominal=Thread_d+IDXtra*2, 
						Length=Boss_t+Overlap*2, 
						Step_a=2,TrimEnd=true,TrimRoot=true);
			} // if
		} // difference
	} // BoltBoss
	
	Tube(OD=OD, ID=OD-Wall_t*2, Len=H, myfn=90);
	BoltBoss();
	rotate([0,0,180]) BoltBoss();
} // EBayEndRing

// EBayEndRing();
Thread25020_d=0.25*25.4;

module EBayBase(OD=ULine38Body_ID-IDXtra, H=6){
	Boss_t=10;
	Boss_d=12;
	nSpokes=6;
	Spoke_t=1.2;
	
	EBayEndRing(OD=OD, H=H);
	
	difference(){
		union(){
			cylinder(d=Boss_d, h=Boss_t);
			
			for (j=[0:nSpokes-1]) rotate([0,0,360/nSpokes*j+180/nSpokes])
				hull(){
					translate([0,Boss_d/2-Spoke_t/2,0]) cylinder(d=Spoke_t, h=Boss_t);
					translate([0,OD/2-Spoke_t/2,0]) cylinder(d=Spoke_t, h=H);
				} // hull
				
			for (j=[0,180]) rotate([0,0,j])
				hull(){
					translate([0,Boss_d/2-Spoke_t/2,0]) cylinder(d=Spoke_t, h=H);
					translate([0,OD/2-Bolt10Inset-3.5,0]) cylinder(d=Spoke_t, h=H);
				} // hull
		} // union
		
		Thread_d=Thread25020_d;
		Thread_p=25.4/20;
					
			if ($preview){
				translate([0,0,-Overlap]) cylinder(d=Thread_d, h=Boss_t+Overlap*2); 
			}else{
				translate([0,0,-Overlap]) 
					ExternalThread(Pitch=Thread_p, Dia_Nominal=Thread_d+IDXtra*2, 
						Length=Boss_t+Overlap*2, 
						Step_a=2,TrimEnd=true,TrimRoot=true);
			} // if
	} // difference
	
} // EBayBase

// EBayBase();

module NoseCone(){
	nLocks=5;
	
	difference(){
		BluntOgiveNoseCone(ID=Body_ID, OD=Body_OD+Vinyl_d, L=NC_Len, Base_L=NC_Base_L, Tip_R=NC_Tip_r, 
			HasThreadedTip=false, Wall_T=NC_Wall_t, LowerPortion=false, FillTip=true);
		
		TwistLockFemale(OD=Body_ID, nLocks=nLocks, Inset=5, LockSize=2); // Adds grooves to ID
		
	} // difference
} // NoseCone

// NoseCone();

module NC_Base38(Body_OD=ULine38Body_OD, Body_ID=ULine38Body_ID, NC_Base_L=12){
    // Small Spring
	Spring_CS4323_OD=44.30;
	Spring_CS4323_ID=40.50;
	Spring_CS4323_CBL=22; // coil bound length
	Spring_CS4323_FL=200; // free length

	nBolts=2;
	nRivets=0;
	Rivet_d=4;
	Plate_t=4;
	nRopes=0;
	Rope_d=4;
	Tube_d=12.7;
	CR_z=-3;
	StopRing_h=2;
	Spring_OD=Spring_CS4323_OD;
	Spring_ID=Spring_CS4323_ID;
	nLocks=5;
	OD_Xtra=0.4;
	
	
	module FW_GPS_SW_Hole(){
		// Switch
		translate([5,-1.6-1,-1]) 
			rotate([90,0,0]) cylinder(d=3, h=100);
			
		// Terminal block
		translate([10,5,4]) rotate([0,0,180]) cube([7,10,7]);
	} // FW_GPS_SW_Hole


	module FW_GPS_Mount(){
		Boss_d=10;
		
		module Boss(){
			difference(){
				rotate([-90,0,0]) cylinder(d1=7,d2=Boss_d,h=6);
					
				rotate([90,0,0]) Bolt4Hole();
			} // difference
		} // Boss
		
		// Backing plate
		
		Boss_Y=2;
		Boss_Z=13.5;
		Plate_W=20.4+8;
		
		difference(){
			union(){
				hull(){
					translate([-Plate_W/2,6,-8]) cube([Plate_W,3,42+12]);
					translate([-Plate_W/2,6,-8]) cube([Plate_W,10,1]);
				} // hull
				
				translate([-Plate_W/2+8,Boss_Y,Boss_Z]) Boss();
				translate([-Plate_W/2+8,Boss_Y,Boss_Z]) translate([12.7,0,25.4]) Boss();
			} // union
			
			translate([-Plate_W/2+8,Boss_Y,Boss_Z]) rotate([90,0,0]) Bolt4Hole(depth=20);
			translate([-Plate_W/2+8,Boss_Y,Boss_Z]) translate([12.7,0,25.4]) rotate([90,0,0]) Bolt4Hole();
		} // difference
		
	} // FW_GPS_Mount
	
	
	//FW_GPS_Mount();

	
	difference(){
		union(){
			// Stop ring
			translate([0,0,-StopRing_h]) Tube(OD=Body_OD+OD_Xtra, ID=Body_ID-2, Len=StopRing_h, myfn=$preview? 36:360);
			
			// GPS mount
			translate([0,-5, 6]) FW_GPS_Mount();

			// Nosecone interface
			Tube(OD=Body_ID-IDXtra, ID=Body_ID-4.4, Len=NC_Base_L, myfn=$preview? 36:360);
							
			// Stiffener
			translate([0,0,-StopRing_h])
				cylinder(d=Body_ID-1, h=4);
				
			// Twist lock
			TwistLockMale(OD=Body_ID-IDXtra, nLocks=5, Inset=5, LockSize=2); // Adds bumps to OD
			
		} // union
		
		translate([-10,-10, 6]) FW_GPS_SW_Hole();
		
		// Nosecone rivets
		if (nRivets>0)
		for (j=[0:nRivets-1]) rotate([0,0,360/nRivets*j+5]) translate([0,-Body_ID/2-1,NC_Base_L/2])
			rotate([-90,0,0]){ cylinder(d=Rivet_d, h=10); 
			translate([0,0,3.2]) cylinder(d=Rivet_d*2, h=6);}

			
		//EBay Bolts
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) translate([0,Body_ID/2,-StopRing_h-7.5]) 
			rotate([-90,0,0]) Bolt4Hole();
		
		// Petal Hub Bolts
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+22.5]) translate([0,Body_ID/2-4,3]) 
			Bolt4Hole();
			
		// Shock cord
		rotate([0,0,22.5+180]) translate([0,10,-StopRing_h-Overlap]) cylinder(d=3, h=20);
		
		// Retention cord
		for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j+180/nRopes]) translate([0,Body_ID/2-Rope_d/2-2.5,-10]) cylinder(d=Rope_d, h=30);
	} // difference
	
	// Stelth battery holder
	
	Batt_Wall_t=1.7;
	Batt_W=25;
	Batt_H=39;
	Batt_t=5;
	Batt_a=7.2;
	Batt_Z=10;
	Batt_Y=7.8;
	
	translate([Batt_W/2,Batt_Y,Batt_Z]) rotate([Batt_a,0,0]) cube([Batt_Wall_t,Batt_t,Batt_H]);
	translate([-Batt_W/2-Batt_Wall_t,Batt_Y,Batt_Z]) rotate([Batt_a,0,0]) cube([Batt_Wall_t,Batt_t,Batt_H]);
	translate([-Batt_W/2-Batt_Wall_t,Batt_Y,Batt_Z]) rotate([Batt_a,0,0]) cube([Batt_W+Batt_Wall_t*2,Batt_t,Batt_Wall_t]);
	
} // NC_Base38

// NC_Base38();

module R38_PetalHub(OD=Body_ID-IDXtra){
	nBolts=2;

	difference(){
		union(){
			PD_SmallPetalHub(OD=OD, 
					nPetals=2, 
					HasBolts=true,
					nBolts=nBolts, // Same as nPetals
					nRopes=0);
						
	
			translate([0,0,-5+Overlap]) cylinder(d=OD, h=5);
		} // union
		
		// Petal Hub Bolts
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j+90]) translate([0,Body_ID/2-4,1]) 
			Bolt4ClearHole();
			
		// Shock cord
		translate([10,0,-5]) cylinder(d=4, h=20);
	} // difference

} // R38_PetalHub

// R38_PetalHub();

Thread1024_d=0.190*25.4;

module PetalCatch(){
	//OAH=14;
	Boss_t=10;
	OD=Body_ID-IDXtra*2;
	Wall_t=1.2;
	Groove_h=2.8;
	Clip_OD=OD-4.5;
	Clip_ID=OD-10;
	
	Spring_OD=SE_Spring3670_OD();
	Spring_ID=SE_Spring3670_ID();
	
		
	// Petal holding ring
	difference(){
		translate([0,0,Boss_t-4-Overlap]) Tube(OD=OD, ID=Clip_ID, Len=2+4+Overlap, myfn=90);
		
		translate([0,0,Boss_t-4-Overlap*2]) cylinder(d1=OD-Wall_t*2, d2=Clip_ID-Overlap, h=4);
	} // difference
		
		
		translate([0,0,Boss_t+2-Overlap]) Tube(OD=OD-7, ID=Clip_ID, Len=Groove_h+Overlap, myfn=90);
		translate([0,0,Boss_t+2+Groove_h-Overlap]) Tube(OD=Clip_OD, ID=Clip_ID, Len=2.2+Overlap, myfn=90);
		
	
	nSpokes=4;
	// Threaded rod
	difference(){
		union(){
			Tube(OD=OD, ID=OD-Wall_t*2, Len=Boss_t, myfn=90);
			cylinder(d=OD,h=3);
			
			cylinder(d=10,h=Boss_t);
			
			for (j=[0:nSpokes-1]) rotate([0,0,360/nSpokes*j+180/nSpokes]) hull(){
				cylinder(d=Wall_t, h=Boss_t);
				translate([0,OD/2-Wall_t,0]) cylinder(d=Wall_t, h=Boss_t);
			} // hull
		} // union
		
		// spring
		translate([0,0,-Overlap]) Tube(OD=Spring_OD, ID=Spring_ID, Len=2, myfn=90);
		
		// Shock cord
		translate([0,Spring_ID/2-3,-Overlap]) cylinder(d=4,h=20);
		
		Thread_d=Thread1024_d;
		Thread_p=25.4/24;
				
		if ($preview){
			translate([0,0,-Overlap]) cylinder(d=Thread_d, h=Boss_t+Overlap*2); 
		}else{
			translate([0,0,-Overlap]) 
				ExternalThread(Pitch=Thread_p, Dia_Nominal=Thread_d+IDXtra*2, 
					Length=Boss_t+Overlap*2, 
					Step_a=2,TrimEnd=true,TrimRoot=true);
		}
	} // difference
} // PetalCatch

// PetalCatch();

module MotorTubePlug(){
	Len=25;
	MotorBoltHole_d=0.25*25.4+IDXtra;
	
	difference(){
		cylinder(d=MotorTube_ID, h=Len);
		
		translate([0,0,-Overlap]) cylinder(d=MotorBoltHole_d, h=Len+Overlap*2);
		translate([0,0,Len-6]) cylinder(d1=MotorBoltHole_d, d2=MotorTube_ID-2, h=6+Overlap);
	} // difference

} // MotorTubePlug

// MotorTubePlug();

module Fincan(LowerHalfOnly=false, UpperHalfOnly=false, Hollow=true, HasSnapRing=true){
	Wall_t=1.0;
	HasMotorSleeve=false;
	AftClosure_OD=HasSnapRing? ATRMS_29_Aft_d():MotorTube_OD;
	TCX=HasSnapRing? TailConeExtra_OD:0;
	
	difference(){
		FC2_FinCan(Body_OD=Body_OD+Vinyl_d, Body_ID=Body_ID, Can_Len=FinCan_Len,
				MotorTube_OD=MotorTube_OD, RailGuide_h=1, RailGuideLen=0, // rail button
				nFins=nFins, HasIntegratedCoupler=true, HasFwdCenteringRing=false, HasMidCenteringRing=false,
				HasMotorSleeve=HasMotorSleeve, HasAftIntegratedCoupler=false,
				Fin_Root_W=Fin_Root_W, Fin_Root_L=Fin_Root_L, Fin_Post_h=Fin_Post_h, Fin_Chamfer_L=Fin_Chamfer_L,
				Cone_Len=TailCone_Len, ThreadedTC=false, Extra_OD=TCX,
				LowerHalfOnly=LowerHalfOnly, UpperHalfOnly=UpperHalfOnly, HasWireHoles=false, HollowTailcone=Hollow, 
				HollowFinRoots=Hollow, Wall_t=Wall_t, UseTrapFin3=true, AftClosure_OD=AftClosure_OD, AftClosure_Len=15);
		
		// Snap ring groove
		if (HasSnapRing){
			translate([0,0,-TailCone_Len+3]) cylinder(d=AftClosure_OD+2.5, h=2);
			translate([0,0,-TailCone_Len+5-Overlap]) cylinder(d1=AftClosure_OD+2.5, d2=AftClosure_OD+IDXtra*3, h=3);
		}
	} // difference
} // Fincan

// Fincan(HasSnapRing=false);
// Fincan(LowerHalfOnly=false, UpperHalfOnly=true);
// Fincan(LowerHalfOnly=true, UpperHalfOnly=false);

module SnapRing(){
	Thickness=1.5;
	OD=MotorTube_OD+3;
	ID=MotorTube_ID-1;
	Notch_XY=(ID-5)/2*0.707;
	
	difference(){
		cylinder(d=OD, h=Thickness);
		
		translate([0,0,-Overlap]) cylinder(d=ID, h=Thickness+Overlap*2);
		translate([Notch_XY,Notch_XY,-Overlap]) cube([20,20,Thickness+Overlap*2]);
	} // difference
} // SnapRing

// SnapRing();
	
module RocketFin(HasSpiralVaseRibs=true, PrinterBrim_H=0.6){
	
	TrapFin3(Post_h=Fin_Post_h, Root_L=Fin_Root_L, Tip_L=Fin_Tip_L, Root_W=Fin_Root_W,
				Tip_W=Fin_Tip_W, Span=Fin_Span, Chamfer_L=Fin_Chamfer_L,
				TipOffset=Fin_TipOffset,
				Bisect=false, Bisect_X=0,
				HasSpar=false, Spar_d=8, Spar_L=100, PrinterBrim_H=PrinterBrim_H, HasSpiralVaseRibs=HasSpiralVaseRibs);
				
	
} // RocketFin

// RocketFin(HasSpiralVaseRibs=true);























