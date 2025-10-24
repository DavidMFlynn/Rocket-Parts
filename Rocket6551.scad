// *********************************************
// Project: 2.6 inch rocket depoyment system
// Filename: Rocket6551.scad
// by David M. Flynn
// Created: 9/18/2025
// Revision: 0.9.11  10/23/2025
// Units: mm
// *********************************************
//  ***** Notes *****
//
//  This is a 2.6 inch diameter rocket, single deploy
//  Uses CableReleaseBBMini, RocketServo and a Blue Raven altimeter.
//  Uses one 4323CS spring and petal deployment system (non-pyro).
//  First built 9/21/2025 w/ LOC 29mm motor tube and 2.6" ??? tube (Estes?)
//
//  Assemble dual deploy for flight: 
//		1) Assemble entire ebay from R65_DrogueCoupler to NoseCone; parachutes, battery, everything.
//		2) Slide airframe up from the bottom and install 3 rivets to hold it in place. Nosecone should be snug to airframe.
//		3) Stack onto fincan and nut R65_DrogueCoupler in place. There should be a nut on both sides of R65_MotorNutStop.
//			Airframe and fincan should be tight against each other.
//
//
//  2 Stage version w/ 38mm motors, I357T, H123W
//
//  ***** History *****
// 0.9.11  10/23/2025 R65_EBayMiddleRing() now has 6 rivet holes.
// 0.9.10  10/23/2025 Moved ebays to R65Lib.scad
// 0.9.9   10/21/2025 Moved common routines to R65Lib.scad, working on the 2 stage/dual deploy version
// 0.9.8   9/29/2025  Got one finished, work on booster for 2 stage version.
// 0.9.7   9/28/2025  Mission Control EBay, 38mm motor, GPS mount
// 0.9.6   9/26/2025  cleanup, added new variants
// 0.9.5   9/24/2025  Petal locks now 30°. More changes to fin can.
// 0.9.4   9/23/2025  Making all the parts smaller, thinner and lighter.
// 0.9.3   9/21/2025  Added vent holes to FwdSpringEnd. New fin/nosecone shape "Little Bird".
// 0.9.2   9/21/2025  Code cleanup and small fixes. Changed fin post to 12mm.
// 0.9.1   9/20/2025  It's comming together, printing and building...
// 0.9.0   9/18/2025  Copied from RocketScooter
//
//  ***** Hardware *****
//
//
//
// *********************************************
//  ***** for STL output *****
//
// NoseCone();
//
DroguePetal_Len=80; // 80 to 100
SustainerPetal_Len=140; // 140 to 180
// R65_PetalHub(OD=Coupler_OD, nPetals=nPetals, nBolts=nPetals*2, Skirt_h=5, HasWirePath=false); // also nosecone base
// R65_PetalHub(OD=Coupler_OD, nPetals=nPetals, nBolts=nPetals*2, Skirt_h=1, HasWirePath=false); // Used with NC_GPS_Mounting_Plate
// R65_NC_GPS_Mounting_Plate(OD=Coupler_OD, nBolts=nPetals*2, Skirt_h=5, HasAlTube=true);
// rotate([-90,0,0]) PD_PetalSpringHolder();
// rotate([180,0,0]) PD_Petals(OD=Coupler_OD, Len=Petal_Len, nPetals=nPetals, Wall_t=1.2, AntiClimber_h=4, HasLocks=true, Lock_Span_a=30);
// rotate([180,0,0]) PD_Petals(OD=Coupler_OD, Len=DroguePetal_Len, nPetals=nPetals, Wall_t=1.2, AntiClimber_h=4, HasLocks=true, Lock_Span_a=30);
// rotate([180,0,0]) PD_Petals(OD=Coupler_OD, Len=SustainerPetal_Len, nPetals=nPetals, Wall_t=1.2, AntiClimber_h=4, HasLocks=true, Lock_Span_a=30);
// R65_FwdSpringEnd(OD=Coupler_OD, ID=Coupler_ID, LockPin_d=16, nRopes=6, Skirt_h=25, HasServoConnector=false);
// R65_SpringSliderLight(OD=Coupler_OD, Len=35);
//
//
//  *** CableReleaseBBMini ***
//
//  CRBBm_CenteringRingMount(OD=Body_ID, Thickness=7, Spring_OD=SE_Spring_CS4323_OD(), Spring_ID=SE_Spring_CS4323_ID());
//  CRBBm_ExtensionRod(LockPin_d=LockPin_d, Len=26, ID=0.190*25.4, Light=true);
//  CRBBm_LockingPin(nBalls=nBalls, LockPin_d=LockPin_d, LockPin_Len=LockPin_Len, GuidePoint=GuidePoint);
//  rotate([180,0,0]) CRBBm_LockRing(LockPin_d=LockPin_d, nBalls=nBalls, GuidePoint=false, Light=true);
//	rotate([180,0,0]) CRBBm_TopRetainer(LockPin_d=LockPin_d, nBalls=nBalls, LockRing_d=CRBBm_LockRingDiameter(), Flange_t=TopRetainerFlange_t, OD=0, HasMountingBolts=true, GuidePoint=GuidePoint, Light=true);
//  CRBBm_OuterBearingRetainer(Light=true);
//  rotate([180,0,0]) CRBBm_TriggerPost();
//  rotate([180,0,0]) CRBBm_MagnetBracket();
//  CRBBm_Activator(OD=Coupler_OD, Thread_d=MotorBolt_d, Thread_p=MotorBoltPitch);
//  CRBBm_LockPinExtensionEnd(); // Presses onto 5/16" OD Aluminum tube.
//
// R65_EBayBR(OD=Coupler_OD, CenterBolt_d=MotorBolt_d , CenterBolt_p=MotorBoltPitch); // Blue Raven
// R65_EBayMC(OD=Coupler_OD, CenterBolt_d=MotorBolt_d, CenterBolt_p=MotorBoltPitch, HasRS_Mount=true); // Mission Control V3
//
//  *** Single Deploy Only ***
//  *** This spacer fills the space between the MotorTubeTopper and the EBay, must pull the nose cone in tight. ***
// Tube(OD=Coupler_OD, ID=Coupler_OD-2.4, Len=10, myfn=$preview? 90:180); // spacer booster
// Tube(OD=Coupler_OD, ID=Coupler_OD-2.4, Len=25, myfn=$preview? 90:180); // spacer
// Tube(OD=Coupler_OD, ID=Coupler_OD-2.4, Len=29, myfn=$preview? 90:180); // spacer
// Tube(OD=Coupler_OD, ID=Coupler_OD-2.4, Len=30, myfn=$preview? 90:180); // spacer
// Tube(OD=Coupler_OD, ID=Coupler_OD-2.4, Len=31, myfn=$preview? 90:180); // spacer
// Tube(OD=Coupler_OD, ID=Coupler_OD-2.4, Len=77, myfn=$preview? 90:180); // spacer
//
//  *** Dual Deploy Only ***
//
// R65_EBayMiddleRing(OD=Coupler_OD, Len=30, Thread_d=MotorBolt_d, Thread_p=MotorBoltPitch);
// R65_DroguePetalHub(OD=Coupler_OD, nPetals=nPetals, nBolts=nPetals*2, Skirt_h=5, HasWirePath=true);
/*
R65_DrogueCoupler(OD=Body_ID, Coupler_ID=Coupler_ID, 
			Thread_d=MotorBolt_d, Thread_p=MotorBoltPitch, LockPin_d=LockPin_d, 
			nRopes=0, Skirt_h=25, HasTubeStop=false, Body_OD=Body_OD*CF_Comp+Vinyl_d, HasWirePath=true, HasStiffCore=true);
/**/
//
// rotate([180,0,0]) R65_MotorTubeTopper(OD=Body_ID, ID=MotorTube_OD, MT_ID=MotorTube_ID-3); // alt w/ flange
// R65_MotorNutStop(MT_ID=MotorTube_ID, Hole_d=MotorBolt_d);
//
// rotate([180,0,0]) Fincan(LowerHalfOnly=false, UpperHalfOnly=false, HasSecurityRods=false, HasMotorRetainer=false);
// Fincan(LowerHalfOnly=false, UpperHalfOnly=false, HasSecurityRods=false, HasMotorRetainer=false, IsSustainer=true);
//
// rotate([0,0,90]) RocketFin(HasSpiralVaseRibs=false, PrinterBrim_H=0.6);
//
// RailButton();
// RailButton(OD=11, Flange_h=2, Slot_w=2.8);  // for 1010 Rail
// SnapRing(); // optional, not used for now
//
//  *** Stager, yes this can be 2 stages ***
//
// rotate([180,0,0]) Stager_Cup_Light(Collar_H=15);
// rotate([-90,0,0]) Stager_LockRod(Adj=0.0);
//
// Stager_Saucer(Tube_OD=Body_OD*CF_Comp+Vinyl_d, nLocks=nLocks); // Bolts on
// Stager_LockRing(Tube_OD=Body_OD*CF_Comp+Vinyl_d, nLocks=nLocks);
// Stager_Mech(Tube_OD=Body_OD*CF_Comp+Vinyl_d, nLocks=nLocks, Skirt_ID=Body_ID*CF_Comp, Skirt_Len=2, nSkirtBolts=0, ShowLocked=true);
// Stager_OuterBearingCover(Tube_OD=Body_OD*CF_Comp+Vinyl_d, nLocks=nLocks); // Secures Outer Race of Main Bearing
// rotate([180,0,0]) Stager_Indexer(Tube_OD=Body_OD*CF_Comp+Vinyl_d, nLocks=nLocks); // Secures Inner Race of Main Bearing and has Lock Stops
// Custom_ServoPlate();
// rotate([180,0,0]) Stager_ServoMount(Servo_ID=DefaultServo);
//
// rotate([180,0,0]) Stager_Mech_Mount(); // use with 
// R65_PetalHub(OD=Coupler_OD, nPetals=nPetals, nBolts=nPetals*2, Skirt_h=1, HasWirePath=true);
//
// rotate([180,0,0]) BoosterFincan();
// rotate([0,0,90]) BoosterFin(HasSpiralVaseRibs=false, PrinterBrim_H=0.9);
//
//  *** Tools ***
//
// PD_PetalHolder2(Petal_OD=Body_ID-0.5, Is_Top=false); // bottom half
// PD_PetalHolder2(Petal_OD=Body_ID-0.5, Is_Top=true); // top half
// PD_PetalHolderLockLever();
//
// rotate([180,0,0])// R65_DeepSocket(); // 7/16" Socket for 1/4-20 nuts (29mm RMS)
// R65_DeepSocket500(); // 1/2" Socket for 5/16-18 nuts (38mm RMS)
//
// *********************************************
//  ***** for Viewing *****
//
/*
   translate([0,0,TailCone_Len+BFinCan_Len+BoosterBodyTubeLen+36]) ShowRocket(ShowInternals=false, IsSustainer=true);
   ShowBooster(ShowInternals=false);
/**/
// ShowBooster(ShowInternals=false);
// ShowBooster(ShowInternals=true);
//
// ShowRocket(ShowInternals=false);
// ShowRocket(ShowInternals=true);
//
// ShowCableRelease();
//
// ShowStagerAssy(Tube_OD=Body_OD, Tube_ID=Body_ID, nLocks=nLocks, ShowLocked=true);
//
// *********************************************

include<TubesLib.scad>
use<AT_RMS_Lib.scad>		 echo(AT_RMS_Lib_Rev());
use<SpringEndsLib.scad>      echo(SpringEndsLibRev());
use<PetalDeploymentLib.scad> echo(PetalDeploymentLibRev());
use<CableReleaseBBMini.scad> echo(CableReleaseBBMiniRev());
use<ThreadLib.scad>          echo(ThreadLibRev());
use<SG90ServoLib.scad>       echo(SG90ServoLibRev());
use<Fins.scad>               echo(FinsRev());
use<FinCan2Lib.scad>         echo(FinCan2LibRev());
use<NoseCone.scad>           echo(NoseConeRev());
use<RailGuide.scad>          echo(RailGuideRev());
include<Stager75BBLib.scad>  echo(Stager75BBLib_Rev());
use<R65Lib.scad>			 echo(R65Lib_Rev());

// Also included
//include<CommonStuffSAEmm.scad>

$fn=$preview? 36:90;
IDXtra=0.2;
Overlap=0.05;

Bolt4Inset=4;
Bolt10Inset=5.5;
LooseFit=0.8; // add to hole ID

//Body_OD=Estes65Body_OD; // Same ID as LOC
Body_OD=LOC65Body_OD;
Body_ID=LOC65Body_ID;
Coupler_OD=LOC65Coupler_OD;
Coupler_ID=Coupler_OD-1.8; // thin wall
// BodyTubeLen=18*25.4; // uncut estes tube
// BodyTubeLen=764; // uncut Loc tube

nPetals=3;

LockPin_d=16; // OD is determined by the bearing OD so making this smaller doesn't change the OD
LockPin_Len=25;
TopRetainerFlange_t=4;
nBalls=3;
GuidePoint=false;
Spring_OD=SE_Spring_CS4323_OD();
Spring_ID=SE_Spring_CS4323_ID();

/*
// Original
NC_Len=155;
NC_Base_L=6;
NC_Tip_R=5;
NC_Wall_t=1.2;
/**/

/*
// More Pointy
NC_Len=185;
NC_Base_L=6;
NC_Tip_R=4;
NC_Wall_t=1.2;
/**/

/*
// Little Blue Data
Petal_Len=120; // 80 minimum, 100,120 or 140 is preferred 140 is max for a single 4323 spring
MotorTube_OD=LOC29Body_OD;
MotorTube_ID=LOC29Body_ID;
MotorBolt_d=6.35;
MotorBoltPitch=25.4/20;

MotorTubeLen=304;
BodyTubeLen=18*25.4; // uncut estes tube

NC_Len=155;
NC_Base_L=6;
NC_Tip_R=5;
NC_Wall_t=1.2;

// Small fins
nFins=5;
Fin_Post_h=12;
Fin_Root_L=130;
Fin_Root_W=6;
Fin_Tip_W=2.0;
Fin_Tip_L=60;
Fin_Span=60;
Fin_TipOffset=20;
Fin_Chamfer_L=20;
FinInset_Len=5;
Fin_TipBase=0;
FinCan_Len=Fin_Root_L+FinInset_Len*2;
/**/

/*
// Little Bird data
MotorTube_OD=LOC29Body_OD;
MotorTube_ID=LOC29Body_ID;
MotorBolt_d=6.35;
MotorBoltPitch=25.4/20;

MotorTubeLen=304;
BodyTubeLen=18*25.4; // uncut estes tube

NC_Len=185;
NC_Base_L=6;
NC_Tip_R=4;
NC_Wall_t=1.2;

// Little Bird fins
nFins=5;
Fin_Post_h=12;
Fin_Root_L=130;
Fin_Root_W=6;
Fin_Tip_W=2.0;
Fin_Tip_L=80;
Fin_Span=80;
Fin_TipOffset=65;
Fin_Chamfer_L=20;
FinInset_Len=5;
Fin_TipBase=10;
FinCan_Len=Fin_Root_L+FinInset_Len*2;
/**/

//*
// Little Red One Data
Petal_Len=140; // 80 minimum, 100,120 or 140 is preferred 140 is max for a single 4323 spring
BPetal_Len=140;

//MotorTube_OD=LOC29Body_OD;
//MotorTube_ID=LOC29Body_ID;
MotorTube_OD=ULine38Body_OD;
MotorTube_ID=ULine38Body_ID;
MotorBolt_d=5/16*25.4;
MotorBoltPitch=25.4/18;

MotorTubeLen=304;
BoosterMotorTubeLen=330; // 330 is min for 38/600 case, 380 is min for 38/720 case

BodyTubeLen=764; // uncut Loc tube
BoosterBodyTubeLen=540;

NC_Len=185;
NC_Base_L=6;
NC_Tip_R=4;
NC_Wall_t=1.2;

// Little Red One fins
nFins=5;
Fin_Post_h=12;
Fin_Root_L=140;
Fin_Root_W=7.5;
Fin_Tip_W=2.0;
Fin_Tip_L=70;
Fin_Span=70;
Fin_TipOffset=25;
Fin_Chamfer_L=24;
FinInset_Len=5;
Fin_TipBase=0;
FinCan_Len=Fin_Root_L+FinInset_Len*2;

// Booster fins
B_Scale=1.25; // Booster fins are 125% of sustainer fins
BFin_Post_h=12;
BFin_Root_L=140*B_Scale;
BFin_Root_W=7.5*B_Scale;
BFin_Tip_W=2.0;
BFin_Tip_L=70*B_Scale;
BFin_Span=70*B_Scale;
BFin_TipOffset=25*B_Scale;
BFin_Chamfer_L=24*B_Scale;
BFinInset_Len=5;
BFin_TipBase=0;
BFinCan_Len=BFin_Root_L+BFinInset_Len*2;
/**/

SecurityRod_BC_d=(MotorTube_ID<31)? Body_ID-(Body_ID-MotorTube_OD)/2+4:Body_ID-Bolt10Inset*2; // 29mm:38mm motor
echo(SecurityRod_BC_d=SecurityRod_BC_d);

Vinyl_d=0.3;
TailCone_Len=30;
TailConeExtra_OD=2;

Thread1024_d=0.190*25.4;
Thread25020_d=0.250*25.4;
CRBBm_Activator_Bolt_a=[22.5,162,253,323];
EBay_Len=84;

// constants for 65mm stager
Default_nLocks=2;
nLocks=Default_nLocks;
DefaultBody_OD=LOC65Body_OD;
DefaultBody_ID=LOC65Body_ID;
DefaultMotorTube_OD=ULine38Body_OD;
DefaultServo=ServoMG90S_ID;
MainBearing_OD=Bearing6705_OD;
MainBearing_ID=Bearing6705_ID;
MainBearing_T=Bearing6705_T;
//

module ShowRocket(ShowInternals=false, IsSustainer=false){
	FinCan_Z=TailCone_Len;
	Fin_Z=FinCan_Z+FinCan_Len/2;
	MotorTube_Z=FinCan_Z-TailCone_Len;
	EBay_Z=MotorTube_Z+MotorTubeLen+3+25.2;
	BodyTube_Z=FinCan_Z+FinCan_Len+Overlap*2;
	NoseCone_Z=BodyTube_Z+BodyTubeLen+0.1;
	
	FwdSpringEnd_Z=NoseCone_Z-14.5-Petal_Len-4;
	SCR_Z=FwdSpringEnd_Z-50;
	
	echo(str("Overall Length = ",(NoseCone_Z+NC_Len)/25.4));

	translate([0,0,NoseCone_Z]){
		rotate([0,0,90]) color("Orange") NoseCone();
		
		if (ShowInternals)
			translate([0,0,-5]) color("Tan") rotate([180,0,30]) 
				R65_PetalHub(OD=Coupler_OD, nPetals=nPetals, nBolts=nPetals*2, Skirt_h=5, HasWirePath=false);
			
		if (ShowInternals){
			translate([0,0,-14.5]) rotate([180,0,30]) 
				PD_Petals(OD=Coupler_OD, Len=Petal_Len, nPetals=nPetals, Wall_t=1.6, AntiClimber_h=0, HasLocks=true);
		}
	}
	
	if (ShowInternals)			
		translate([0,0,FwdSpringEnd_Z]) color("Tan") rotate([180,0,0]) 
			R65_FwdSpringEnd(OD=Coupler_OD, ID=Coupler_ID, LockPin_d=16, nRopes=6, Skirt_h=25, HasServoConnector=false);

	
	if (ShowInternals){
		translate([0,0,SCR_Z]) ShowCableRelease();
		translate([0,0,SCR_Z-22.5]) color("LightGreen") rotate([0,0,180]) CRBBm_Activator();
		translate([0,0,EBay_Z]) rotate([0,0,30]) 
			R65_EBayBR(OD=Coupler_OD, CenterBolt_d=MotorBolt_d , CenterBolt_p=MotorBoltPitch); // Blue Raven
	}
		
	if (!ShowInternals)
		translate([0,0,BodyTube_Z]) color("LightBlue") 
			Tube(OD=Body_OD, ID=Body_ID, Len=BodyTubeLen-Overlap*2, myfn=$preview? 90:360);
		
	
	
	if (ShowInternals)
		translate([0,0,MotorTube_Z]) {
			color("Blue") Tube(OD=MotorTube_OD, ID=MotorTube_ID, Len=MotorTubeLen-Overlap*2, myfn=$preview? 90:360);
			translate([0,0,MotorTubeLen-18]) R65_MotorTubeTopper(OD=Body_ID, ID=MotorTube_OD, MT_ID=MotorTube_ID);
			translate([0,0,MotorTubeLen+3]) color("LightGreen") Tube(OD=Coupler_OD, ID=Coupler_OD-2.4, Len=25, myfn=$preview? 90:180); // spacer
		}	
	translate([0,0,FinCan_Z]) color("Orange") Fincan(LowerHalfOnly=false, UpperHalfOnly=false, IsSustainer=IsSustainer);
	
	for (j=[0:nFins-1]) rotate([0,0,360/nFins*j+180/nFins])
		translate([0, Body_OD/2-Fin_Post_h, Fin_Z]) 
			rotate([-90,0,0]) color("Orange") RocketFin(false);
		
} // ShowRocket

// ShowRocket(ShowInternals=false);

module ShowBooster(ShowInternals=false){
	FinCan_Z=TailCone_Len;
	Fin_Z=FinCan_Z+BFinCan_Len/2;
	MotorTube_Z=FinCan_Z-TailCone_Len;
	EBay_Z=MotorTube_Z+BoosterMotorTubeLen+3+8;
	BodyTube_Z=FinCan_Z+BFinCan_Len+Overlap*2;
	NoseCone_Z=BodyTube_Z+BoosterBodyTubeLen+0.1;
	
	FwdSpringEnd_Z=NoseCone_Z-36-BPetal_Len-3;
	SCR_Z=FwdSpringEnd_Z-50;
	

	translate([0,0,NoseCone_Z]){
		ShowMyStager(ShowInternals=ShowInternals);
			
		if (ShowInternals){
			translate([0,0,-36]) rotate([180,0,0]) 
				PD_Petals(OD=Coupler_OD, Len=Petal_Len, nPetals=nPetals, Wall_t=1.6, AntiClimber_h=0, HasLocks=true);
		}
	}
	
	if (ShowInternals)			
		translate([0,0,FwdSpringEnd_Z]) color("Tan") rotate([180,0,0]) 
			R65_FwdSpringEnd(OD=Coupler_OD, ID=Coupler_ID, LockPin_d=16, nRopes=6, Skirt_h=25, HasServoConnector=false);

	
	if (ShowInternals){
		translate([0,0,SCR_Z]) ShowCableRelease();
		translate([0,0,SCR_Z-22.5]) color("LightGreen") rotate([0,0,180]) CRBBm_Activator();
		translate([0,0,EBay_Z]) rotate([0,0,30]) 
			R65_EBayMC(OD=Coupler_OD, CenterBolt_d=MotorBolt_d, CenterBolt_p=MotorBoltPitch, HasRS_Mount=true);
	}
		
	if (!ShowInternals)
		translate([0,0,BodyTube_Z]) color("LightBlue") 
			Tube(OD=Body_OD, ID=Body_ID, Len=BoosterBodyTubeLen-Overlap*2, myfn=$preview? 90:360);
		
	
	
	if (ShowInternals)
		translate([0,0,MotorTube_Z]) {
			color("Blue") Tube(OD=MotorTube_OD, ID=MotorTube_ID, Len=BoosterMotorTubeLen-Overlap*2, myfn=$preview? 90:360);
			translate([0,0,BoosterMotorTubeLen-18]) R65_MotorTubeTopper(OD=Body_ID, ID=MotorTube_OD, MT_ID=MotorTube_ID);
			//translate([0,0,BoosterMotorTubeLen+3]) color("LightGreen") Tube(OD=Coupler_OD, ID=Coupler_OD-2.4, Len=25, myfn=$preview? 90:180); // spacer
		}	
	translate([0,0,FinCan_Z]) color("Orange") BoosterFincan(LowerHalfOnly=false, UpperHalfOnly=false);
	
	for (j=[0:nFins-1]) rotate([0,0,360/nFins*j+180/nFins])
		translate([0, Body_OD/2-BFin_Post_h, Fin_Z]) 
			rotate([-90,0,0]) color("Orange") BoosterFin(false);
		
} // ShowBooster

// ShowBooster(ShowInternals=true);
// translate([0,0,TailCone_Len+BFinCan_Len+BoosterBodyTubeLen+36]) ShowRocket(ShowInternals=false, IsSustainer=true);

module ShowCableRelease(){
//*
	translate([0,0,LockPin_Len-7.5]) CRBBm_ExtensionRod(LockPin_d=LockPin_d, Len=26, ID=0.190*25.4, Light=true);

	CRBBm_LockingPin(nBalls=nBalls, LockPin_d=LockPin_d, LockPin_Len=LockPin_Len, GuidePoint=GuidePoint);
	CRBBm_LockRing(LockPin_d=LockPin_d, nBalls=nBalls, GuidePoint=GuidePoint, Light=true);
	CRBBm_TopRetainer(LockPin_d=LockPin_d, nBalls=nBalls, LockRing_d=CRBBm_LockRingDiameter(), Flange_t=TopRetainerFlange_t, OD=0, HasMountingBolts=true, GuidePoint=GuidePoint, Light=true);
/**/	
	translate([0,0,-19.5]){ 
		CRBBm_OuterBearingRetainer(Light=true);
		//translate([0,0,-2.5]) rotate([0,0,60]) CRBBm_BlankInnerBearingRetainer(H=8, HasCenterHole=true);
		rotate([0,0,360/9*3]) CRBBm_MagnetBracket();
		rotate([0,0,360/9*2]) CRBBm_TriggerPost();
		}
//*
	translate([0,0,TopRetainerFlange_t+8.7]) 
		CRBBm_CenteringRingMount(OD=Body_ID, Thickness=7, Spring_OD=SE_Spring_CS4323_OD(), Spring_ID=SE_Spring_CS4323_ID());
/**/
} // ShowCableRelease

// ShowCableRelease();

module ShowMyStager(ShowInternals=false){
	translate([0,0,47]){
		translate([0,0,0.1]) Stager_Cup_Light(Collar_H=15);
		// rotate([-90,0,0]) Stager_LockRod(Adj=0.0);
		color("Blue") Stager_Saucer(Tube_OD=Body_OD*CF_Comp+Vinyl_d, nLocks=nLocks);
		
		if (ShowInternals) translate([0,0,-18]) 
			Stager_LockRing(Tube_OD=Body_OD*CF_Comp+Vinyl_d, nLocks=nLocks);
			
		translate([0,0,-0.1]) Stager_Mech(Tube_OD=Body_OD*CF_Comp+Vinyl_d, nLocks=nLocks, Skirt_ID=Body_ID*CF_Comp, Skirt_Len=2, nSkirtBolts=0, ShowLocked=true);
		if (ShowInternals) translate([0,0,-22]) rotate([180,0,0]) 
			color("Tan") Stager_OuterBearingCover(Tube_OD=Body_OD*CF_Comp+Vinyl_d, nLocks=nLocks); 
	 
		if (ShowInternals) translate([0,0,-23.7]) color("Orange") 
			Stager_Indexer(Tube_OD=Body_OD*CF_Comp+Vinyl_d, nLocks=nLocks);
			
		if (ShowInternals) 
			color("Tan") translate([0,0,-45]) Custom_ServoPlate();
		// rotate([180,0,0]) Stager_ServoMount(Servo_ID=DefaultServo);

		if (ShowInternals) 
			translate([0,0,-71.6]) rotate([0,0,-30]) Stager_Mech_Mount(); // use with 
			
		if (ShowInternals) 
			translate([0,0,-73]) rotate([180,0,0]) 
				R65_PetalHub(OD=Coupler_OD, nPetals=nPetals, nBolts=nPetals*2, Skirt_h=1, HasWirePath=true);
		
	}
} // ShowMyStager

// ShowMyStager();

module NoseCone(){
	R65_NoseCone(Shoulder_OD=Coupler_OD, OD=Body_OD*CF_Comp+Vinyl_d, nBolts=nPetals*2,
			NC_Len=NC_Len, NC_Base_L=NC_Base_L, NC_Tip_R=NC_Tip_R, NC_Wall_t=NC_Wall_t);
} // NoseCone

module ShortMotorAdaptor(Len=48){ // One 38mm grain is 48mm in case length
	// a.k.a. Long Nut
	
	Thread_d=MotorBolt_d;
	Thread_p=MotorBoltPitch;
		
	difference(){
		cylinder(d=1/2*25.4*1.1339, h=Len, $fn=6);
		
		// Thread
		translate([0,0,-Overlap])
			if ($preview){
				cylinder(d=Thread_d, h=Len+Overlap*2); 
			}else{
				ExternalThread(Pitch=Thread_p, Dia_Nominal=Thread_d+IDXtra*2, 
						Length=Len+Overlap*2, 
						Step_a=2,TrimEnd=true,TrimRoot=true);
			} // if
	} // difference
} // ShortMotorAdaptor

//ShortMotorAdaptor();

module ExtensionAlignmentRing(){
	OD=MotorTube_ID-1;
	Len=6;
	nSpokes=6;
	Wall_t=1.2;
	Thread_d=MotorBolt_d;
	Thread_p=MotorBoltPitch;
	
	difference(){
		union(){
			rotate([0,0,30]) cylinder(d=1/2*25.4*1.1339, h=Len, $fn=6);
			
			Tube(OD=OD, ID=OD-Wall_t*2, Len=3, myfn=$preview? 36:90);
			for (j=[0:nSpokes-1]) rotate([0,0,360/nSpokes*j])
				hull(){
					cylinder(d=Wall_t, h=3);
					translate([0,OD/2-Wall_t,0]) cylinder(d=Wall_t, h=3);
				} // hull
		} // union
		
		// Thread
		translate([0,0,-Overlap])
			if ($preview){
				cylinder(d=Thread_d, h=Len+Overlap*2); 
			}else{
				ExternalThread(Pitch=Thread_p, Dia_Nominal=Thread_d+IDXtra*2, 
						Length=Len+Overlap*2, 
						Step_a=2,TrimEnd=true,TrimRoot=true);
			} // if
		
	} // difference
} // ExtensionAlignmentRing

// ExtensionAlignmentRing();

module EBayMC_Jig(){
// for drilling airframe holes
	OD=Body_OD*CF_Comp+Vinyl_d;
	Wall_t=1.10;
	
	EBayMC_Len=MC_Size_Z()+10;
	Alt_Z=EBayMC_Len/2+2;
	Alt_Y=Body_ID/2-15;
	MC_LED_Z=Alt_Z-MC_Size_Z()/2+MC_LED_Z();
	MC_ArmScrew_Z=Alt_Z-MC_Size_Z()/2+MC_ArmingScrew_Z();
	RS_LED_Z=MC_LED_Z-7;
	RS2_LED_Z=MC_ArmScrew_Z-7;
	RailButton_Z=-20;
	
	Rivet_Z=108.5;
	Rivet_a=0;
	Lock_Unlock_Z=Rivet_Z+24.5;
	Lock_Unlock_a=Rivet_a-90;
	
	nDDRivets=3;
	RivetDD_Z=-15.7;
	RivetDD_a=-11;
	
	Rivet2_Z=-35.4;
	Rivet2_a=-22;
	Lock_Unlock2_Z=Rivet2_Z-24.5;
	Lock_Unlock2_a=Rivet2_a+90;
	
	echo("Top Rivet ",Rivet_Z);
	echo("Alt Sw ",MC_ArmScrew_Z);
	echo("Bottom Rivet ",Rivet2_Z);
	
	difference(){
		translate([0,0,RailButton_Z-50]) Tube(OD=OD+Wall_t*2, ID=OD, Len=210, myfn=$preview? 90:180);
	
		// LEDs and Alt switch
		translate([0,OD/2,MC_LED_Z]) rotate([-90,0,0]) cylinder(d=3, h=20, center=true);
		translate([0,OD/2,MC_ArmScrew_Z]) rotate([-90,0,0]) cylinder(d=3, h=20, center=true);
		translate([0,OD/2,RS_LED_Z]) rotate([-90,0,0]) cylinder(d=3, h=20, center=true);
		translate([0,OD/2,RS2_LED_Z]) rotate([-90,0,0]) cylinder(d=3, h=20, center=true);
		
		// Rivet
		translate([0,OD/2,Rivet_Z]) rotate([-90,0,0]) cylinder(d=4, h=20, center=true);
		rotate([0,0,Rivet2_a]) translate([0,OD/2,Rivet2_Z]) rotate([-90,0,0]) cylinder(d=4, h=20, center=true);
		
		// Dual deploy ring rivets
		for (j=[0:nDDRivets-1]) rotate([0,0,360/nDDRivets*j+RivetDD_a])
			translate([0,OD/2,RivetDD_Z]) rotate([-90,0,0]) cylinder(d=4, h=20, center=true);
		
		// Rail button
		rotate([0,0,180]) translate([0,OD/2,RailButton_Z]) rotate([-90,0,0]) cylinder(d=3, h=20, center=true);
		
		// Lock/unlock access hole
		rotate([0,0,Lock_Unlock_a]) translate([0,OD/2,Lock_Unlock_Z]) rotate([-90,0,0]) cylinder(d=3, h=20, center=true);
		rotate([0,0,Lock_Unlock2_a]) translate([0,OD/2,Lock_Unlock2_Z]) rotate([-90,0,0]) cylinder(d=3, h=20, center=true);

	} // difference
} // EBayMC_Jig

// EBayMC_Jig();
/*
 EBayMC(Light=true, HasRS_Mount=true);
 translate([0,0,-0.7]) rotate([0,0,79]) rotate([180,0,0]) color("Gray") SustainerMiddleRing();
 translate([0,0,-47.7]) rotate([180,0,0]) rotate([0,0,47]) CRBBm_Activator();
/**/


module Fincan(LowerHalfOnly=false, UpperHalfOnly=false, HasSecurityRods=false, HasMotorRetainer=false, IsSustainer=false){
	Wall_t=1.2;
	HasMotorSleeve=false;
	AftClosure_OD=HasMotorRetainer? 32.2+IDXtra*2:0;
	AftClosure_Len=HasMotorRetainer? 15:0;
	TailConeExtra_OD=HasMotorRetainer? HasMotorRetainer:0;
	
	SecurityRodHole_d=0.190*25.4+LooseFit;
	SecurityWrenchHole_d=15;
	SecurityWrenchHole_h=TailCone_Len-5;
	SecurityRodHole_a=17.5;
	
	TC_Len=IsSustainer? 0:TailCone_Len;
	OD=Body_OD*CF_Comp+Vinyl_d;
	MotorTubeHole_d=MotorTube_OD+IDXtra*2;
	myfn=180;
	
	echo(str("Body OD w/ Comp = ",Body_OD*CF_Comp+Vinyl_d));
	echo(str("Target OD = ", Body_OD+Vinyl_d));
	
	difference(){
		union(){
			FC2_FinCanLight(Body_OD=OD, Body_ID=Body_ID*CF_Comp, Can_Len=FinCan_Len,
				MotorTube_OD=MotorTube_OD, 
				nFins=nFins, HasIntegratedCoupler=true, HasFwdCenteringRing=false, Coupler_Len=10, nCouplerBolts=0,
				HasMotorSleeve=HasMotorSleeve, 
				Fin_Root_W=Fin_Root_W, Fin_Root_L=Fin_Root_L, Fin_Post_h=Fin_Post_h, Fin_Chamfer_L=Fin_Chamfer_L,
				Cone_Len=TC_Len, ThreadedTC=false, Extra_OD=TailConeExtra_OD,
				LowerHalfOnly=LowerHalfOnly, UpperHalfOnly=UpperHalfOnly,
				Wall_t=Wall_t,
				AftClosure_OD=AftClosure_OD, AftClosure_Len=AftClosure_Len, IncludeCenteringRings=false);
				
			if (IsSustainer){
				//translate([0,0,-8]) Tube(OD=MotorTubeHole_d+3.6, ID=MotorTubeHole_d, Len=8, myfn=$preview? 90:myfn);
				
				difference(){
					translate([0,0,-Overlap]) Tube(OD=OD, ID=MotorTubeHole_d, Len=FinInset_Len-1, myfn=$preview? 90:myfn);
						
					translate([0,0,-4-Overlap]) rotate([0,0,90]) Stager_CupHoles(Tube_OD=OD, nLocks=nLocks, BoltsOn=true, Collar_h=0);
				} // difference
			}
		} // union

		// Wire path
		if (IsSustainer)
			rotate([0,0,156]) translate([0,OD/2-8,-5]) cylinder(d=5/16*25.4+IDXtra, h=20);
		
				//*
		// Snap ring groove
		if (HasMotorRetainer){
			translate([0,0,-TailCone_Len+3]) cylinder(d=AftClosure_OD+2.5, h=2);
			translate([0,0,-TailCone_Len+5-Overlap]) cylinder(d1=AftClosure_OD+2.5, d2=AftClosure_OD+IDXtra*3, h=3);
		}
		
		// Security Rods
		if (HasSecurityRods) rotate([0,0,SecurityRodHole_a]){
			translate([0,SecurityRod_BC_d/2,-TailCone_Len]){
				cylinder(d=SecurityRodHole_d, h=FinCan_Len+TailCone_Len);
				cylinder(d=SecurityWrenchHole_d, h=SecurityWrenchHole_h);
			}
			translate([0,-SecurityRod_BC_d/2,-TailCone_Len]){
				cylinder(d=SecurityRodHole_d, h=FinCan_Len+TailCone_Len);
				cylinder(d=SecurityWrenchHole_d, h=SecurityWrenchHole_h);
			}
		} // if (HasSecurityRods)
		/**/
	} // difference
} // Fincan

// Fincan(LowerHalfOnly=false, UpperHalfOnly=false, HasSecurityRods=false, HasMotorRetainer=false, IsSustainer=true);
// Fincan(LowerHalfOnly=false, UpperHalfOnly=false, HasSecurityRods=false, HasMotorRetainer=false);
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

module BoosterFincan(LowerHalfOnly=false, UpperHalfOnly=false, HasSecurityRods=false, HasMotorRetainer=false){
	Wall_t=1.2;
	HasMotorSleeve=false;
	AftClosure_OD=HasMotorRetainer? 32.2+IDXtra*2:0;
	AftClosure_Len=HasMotorRetainer? 15:0;
	TailConeExtra_OD=HasMotorRetainer? HasMotorRetainer:0;
	
	SecurityRodHole_d=0.190*25.4+LooseFit;
	SecurityWrenchHole_d=15;
	SecurityWrenchHole_h=TailCone_Len-5;
	SecurityRodHole_a=17.5;
	
	echo(str("Body OD w/ Comp = ",Body_OD*CF_Comp+Vinyl_d));
	echo(str("Target OD = ", Body_OD+Vinyl_d));
	
	difference(){
	
		FC2_FinCanLight(Body_OD=Body_OD*CF_Comp+Vinyl_d, Body_ID=Body_ID*CF_Comp, Can_Len=BFinCan_Len,
				MotorTube_OD=MotorTube_OD, 
				nFins=nFins, HasIntegratedCoupler=true, HasFwdCenteringRing=false, Coupler_Len=10, nCouplerBolts=0,
				HasMotorSleeve=HasMotorSleeve, 
				Fin_Root_W=BFin_Root_W, Fin_Root_L=BFin_Root_L, Fin_Post_h=BFin_Post_h, Fin_Chamfer_L=BFin_Chamfer_L,
				Cone_Len=TailCone_Len, ThreadedTC=false, Extra_OD=TailConeExtra_OD,
				LowerHalfOnly=LowerHalfOnly, UpperHalfOnly=UpperHalfOnly,
				Wall_t=Wall_t,
				AftClosure_OD=AftClosure_OD, AftClosure_Len=AftClosure_Len, IncludeCenteringRings=false);

		
		//*
		// Snap ring groove
		if (HasMotorRetainer){
			translate([0,0,-TailCone_Len+3]) cylinder(d=AftClosure_OD+2.5, h=2);
			translate([0,0,-TailCone_Len+5-Overlap]) cylinder(d1=AftClosure_OD+2.5, d2=AftClosure_OD+IDXtra*3, h=3);
		}
		
		// Security Rods
		if (HasSecurityRods) rotate([0,0,SecurityRodHole_a]){
			translate([0,SecurityRod_BC_d/2,-TailCone_Len]){
				cylinder(d=SecurityRodHole_d, h=FinCan_Len+TailCone_Len);
				cylinder(d=SecurityWrenchHole_d, h=SecurityWrenchHole_h);
			}
			translate([0,-SecurityRod_BC_d/2,-TailCone_Len]){
				cylinder(d=SecurityRodHole_d, h=FinCan_Len+TailCone_Len);
				cylinder(d=SecurityWrenchHole_d, h=SecurityWrenchHole_h);
			}
		} // if (HasSecurityRods)
		/**/
	} // difference
} // BoosterFincan

// BoosterFincan();

module RocketFin(HasSpiralVaseRibs=true, PrinterBrim_H=0.6){
	TrapFin3(Post_h=Fin_Post_h, Root_L=Fin_Root_L, Tip_L=Fin_Tip_L, Root_W=Fin_Root_W,
				Tip_W=Fin_Tip_W, Span=Fin_Span, Chamfer_L=Fin_Chamfer_L,
				TipOffset=Fin_TipOffset,
				Bisect=false, Bisect_X=0,
				HasSpar=false, Spar_d=8, Spar_L=100, PrinterBrim_H=PrinterBrim_H, HasSpiralVaseRibs=HasSpiralVaseRibs, TipBase=Fin_TipBase);
} // RocketFin

// RocketFin(HasSpiralVaseRibs=true);

module BoosterFin(HasSpiralVaseRibs=true, PrinterBrim_H=0.6){
	TrapFin3(Post_h=BFin_Post_h, Root_L=BFin_Root_L, Tip_L=BFin_Tip_L, Root_W=BFin_Root_W,
				Tip_W=BFin_Tip_W, Span=BFin_Span, Chamfer_L=BFin_Chamfer_L,
				TipOffset=BFin_TipOffset,
				Bisect=false, Bisect_X=0,
				HasSpar=false, Spar_d=8, Spar_L=100, PrinterBrim_H=PrinterBrim_H, HasSpiralVaseRibs=HasSpiralVaseRibs, TipBase=BFin_TipBase);
} // BoosterFin

// BoosterFin(HasSpiralVaseRibs=false);

module Stager_Cup_Light(Collar_H=17){
	OD=Body_OD*CF_Comp+Vinyl_d;
	
	difference(){
		Stager_Cup(Tube_OD=OD, nLocks=nLocks, BoltsOn=true, Collar_h=Collar_H);
		
		translate([0,0,-4]) cylinder(d=Body_ID-12.7, h=10, $fn=180);
		translate([0,0,4]) cylinder(d1=Body_ID-13, d2=Body_ID-7, h=6, $fn=180);
		translate([0,0,10-Overlap]) cylinder(d=Body_ID-7, h=4, $fn=180);
		
		rotate([0,0,156+90]) translate([0,OD/2-8,0]) cylinder(d=5/16*25.4+IDXtra, h=30);
	} // difference
} // Stager_Cup_Light

// Stager_Cup_Light(Collar_H=15);

module Stager_Mech_Mount(Len=26, HasSkirtHoles=false){
	myfn=180;
	nBolts=4;
	OD=Coupler_OD*CF_Comp;
	Boss_h=4;
	Wall_t=1.2;
	TopBolt_a=50;
	
	module BoltBoss(){
		hull(){
			cylinder(d=7, h=Boss_h);
			translate([0,3.0,0]) scale([1,0.2,1]) cylinder(d=9, h=Boss_h);
		} // hull
	} // BoltBoss
	
	difference(){
		union(){
			Tube(OD=OD, ID=OD-Wall_t*2, Len=Len, myfn=$preview? 90:myfn);
			
			PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=nPetals*2) BoltBoss();
			translate([0,0,Len-Boss_h])
				ServoPlateBoltPattern(TopBolt_a) BoltBoss();
		} // union
		
		if (HasSkirtHoles)
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) translate([0,OD/2,Len-7.5])
			rotate([-90,0,0]) Bolt4Hole();
		
		PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=nPetals*2) rotate([180,0,0]) Bolt4Hole();

		translate([0,0,Len-Boss_h])
			ServoPlateBoltPattern(TopBolt_a) rotate([180,0,0]) Bolt4ClearHole();		
	
	} // difference
} // Stager_Mech_Mount

// translate([0,0,-26]) rotate([0,0,-30]) Stager_Mech_Mount();

module ServoPlateBoltPattern(Angle=0){
	Hole_a=[0,60,120,175,260,300];
	Hole_Y=Coupler_OD*CF_Comp/2-Bolt4Inset;
	
	for (j=Hole_a) rotate([0,0,j+Angle]) translate([0,Hole_Y,0]) children();
} // ServoPlateBoltPattern

// ServoPlateBoltPattern() Bolt4Hole();

module Custom_ServoPlate(){
	Bolt_a=20;
	
	difference(){
		Stager_ServoPlate(Tube_OD=Body_OD*CF_Comp+Vinyl_d, Skirt_ID=Body_ID*CF_Comp, nLocks=nLocks, OverCenter=IDXtra+0.8, Servo_ID=DefaultServo);
		
		// Bolt holes for coupler and petal hub
		translate([0,0,5])
			ServoPlateBoltPattern(Angle=Bolt_a) Bolt4Hole();
	} // difference
} // Custom_ServoPlate

// Custom_ServoPlate();





























