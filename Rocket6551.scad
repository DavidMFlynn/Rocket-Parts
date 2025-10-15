// *********************************************
// Project: 2.6 inch rocket depoyment system
// Filename: Rocket6551.scad
// by David M. Flynn
// Created: 9/18/2025
// Revision: 0.9.8   9/29/2025
// Units: mm
// *********************************************
//  ***** Notes *****
//
//  This is a 2.6 inch diameter rocket, single deploy
//  Uses CableReleaseBBMini, RocketServo and a Blue Raven altimeter.
//  Uses one 4323CS spring and petal deployment system (non-pyro).
//  First built 9/21/2025 w/ LOC 29mm motor tube and 2.6" ??? tube (Estes?)
//
//  2 Stage version w/ 38mm motors, I357T, H123W
//
//  ***** History *****
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
DroguePetal_Len=80;
// PetalHub(OD=Coupler_OD, Skirt_h=5); // also nosecone base
// PetalHub(OD=Coupler_OD, Skirt_h=1); // Used with NC_GPS_Mounting_Plate
// NC_GPS_Mounting_Plate(OD=Coupler_OD, Skirt_h=5, HasAlTube=true);
// rotate([-90,0,0]) PD_PetalSpringHolder();
// rotate([180,0,0]) PD_Petals(OD=Coupler_OD, Len=Petal_Len, nPetals=nPetals, Wall_t=1.2, AntiClimber_h=4, HasLocks=true, Lock_Span_a=30);
// rotate([180,0,0]) PD_Petals(OD=Coupler_OD, Len=DroguePetal_Len, nPetals=nPetals, Wall_t=1.2, AntiClimber_h=4, HasLocks=true, Lock_Span_a=30);
// FwdSpringEnd(nRopes=6, Skirt_h=25);
// SE_SlidingSpringMiddle(OD=Coupler_OD, Wall_t=1.2, nRopes=6, SliderLen=35, SpLen=35, SpringStop_Z=17.5, UseSmallSpring=true);
//
//  *** CableReleaseBBMini ***
//
//  Custom_CenteringRingMount();
//  CRBBm_ExtensionRod(LockPin_d=LockPin_d, Len=26, ID=0.190*25.4, Light=true);
//  CRBBm_LockingPin(nBalls=nBalls, LockPin_d=LockPin_d, LockPin_Len=LockPin_Len, GuidePoint=GuidePoint);
//  rotate([180,0,0]) CRBBm_LockRing(LockPin_d=LockPin_d, nBalls=nBalls, GuidePoint=false, Light=true);
//	rotate([180,0,0]) CRBBm_TopRetainer(LockPin_d=LockPin_d, nBalls=nBalls, LockRing_d=CRBBm_LockRingDiameter(), Flange_t=TopRetainerFlange_t, OD=0, HasMountingBolts=true, GuidePoint=GuidePoint, Light=true);
//  CRBBm_OuterBearingRetainer(Light=true);
//  rotate([180,0,0]) CRBBm_TriggerPost();
//  rotate([180,0,0]) CRBBm_MagnetBracket();
//
// CRBBm_Activator();
// EBay(Light=true);
//
//  *** This spacer fills the space between the MotorTubeTopper and the EBay, must pull the nose cone in tight. ***
// Tube(OD=Coupler_OD, ID=Coupler_OD-2.4, Len=10, myfn=$preview? 90:180); // spacer booster
// Tube(OD=Coupler_OD, ID=Coupler_OD-2.4, Len=25, myfn=$preview? 90:180); // spacer
// Tube(OD=Coupler_OD, ID=Coupler_OD-2.4, Len=29, myfn=$preview? 90:180); // spacer
// Tube(OD=Coupler_OD, ID=Coupler_OD-2.4, Len=30, myfn=$preview? 90:180); // spacer
// Tube(OD=Coupler_OD, ID=Coupler_OD-2.4, Len=31, myfn=$preview? 90:180); // spacer
// Tube(OD=Coupler_OD, ID=Coupler_OD-2.4, Len=77, myfn=$preview? 90:180); // spacer
//
// rotate([180,0,0]) MotorTubeTopper();
// rotate([180,0,0]) MotorTubeTopper(OD=Body_ID, ID=MotorTube_OD, MT_ID=MotorTube_ID-3); // alt w/ flange
// MotorNutStop(MT_ID=MotorTube_ID, Hole_d=MotorBolt_d);
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
// PetalHub(OD=Coupler_OD, Skirt_h=1, HasWirePath=true);
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
// rotate([180,0,0]) DeepSocket();
// DeepSocket500(); // for 5/16-18 nuts
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
use<AT_RMS_Lib.scad>
use<SpringEndsLib.scad>      echo(SpringEndsLibRev());
use<PetalDeploymentLib.scad> echo(PetalDeploymentLibRev());
use<CableReleaseBBMini.scad> echo(CableReleaseBBMiniRev());
use<BatteryHolderLib.scad>   echo(BatteryHolderLibRev());
use<ThreadLib.scad>          echo(ThreadLibRev());
use<SG90ServoLib.scad>       echo(SG90ServoLibRev());
use<Fins.scad>               echo(FinsRev());
use<FinCan2Lib.scad>         echo(FinCan2LibRev());
use<NoseCone.scad>           echo(NoseConeRev());
use<RailGuide.scad>          echo(RailGuideRev());
use<AltBay.scad>			 echo(AltBayRev());
include<Stager75BBLib.scad>  echo(Stager75BBLib_Rev());

// Also included
//include<CommonStuffSAEmm.scad>

$fn=$preview? 36:90;
IDXtra=0.2;
Overlap=0.05;

Bolt4Inset=4;
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

SecurityRod_BC_d=(MotorTube_ID<31)? Body_ID-(Body_ID-MotorTube_OD)/2+4:Body_ID-10; // 29mm:38mm motor
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
			translate([0,0,-5]) color("Tan") rotate([180,0,30]) PetalHub(OD=Coupler_OD);
			
		if (ShowInternals){
			translate([0,0,-14.5]) rotate([180,0,30]) 
				PD_Petals(OD=Coupler_OD, Len=Petal_Len, nPetals=nPetals, Wall_t=1.6, AntiClimber_h=0, HasLocks=true);
		}
	}
	
	if (ShowInternals)			
		translate([0,0,FwdSpringEnd_Z]) color("Tan") rotate([180,0,0]) FwdSpringEnd(nRopes=6, Skirt_h=25);

	
	if (ShowInternals){
		translate([0,0,SCR_Z]) ShowCableRelease();
		translate([0,0,SCR_Z-22.5]) color("LightGreen") rotate([0,0,180]) CRBBm_Activator();
		translate([0,0,EBay_Z]) rotate([0,0,30]) EBay();
	}
		
	if (!ShowInternals)
		translate([0,0,BodyTube_Z]) color("LightBlue") 
			Tube(OD=Body_OD, ID=Body_ID, Len=BodyTubeLen-Overlap*2, myfn=$preview? 90:360);
		
	
	
	if (ShowInternals)
		translate([0,0,MotorTube_Z]) {
			color("Blue") Tube(OD=MotorTube_OD, ID=MotorTube_ID, Len=MotorTubeLen-Overlap*2, myfn=$preview? 90:360);
			translate([0,0,MotorTubeLen-18]) MotorTubeTopper(OD=Body_ID, ID=MotorTube_OD, MT_ID=MotorTube_ID);
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
		translate([0,0,FwdSpringEnd_Z]) color("Tan") rotate([180,0,0]) FwdSpringEnd(nRopes=6, Skirt_h=25);

	
	if (ShowInternals){
		translate([0,0,SCR_Z]) ShowCableRelease();
		translate([0,0,SCR_Z-22.5]) color("LightGreen") rotate([0,0,180]) CRBBm_Activator();
		translate([0,0,EBay_Z]) rotate([0,0,30]) EBayMC();
	}
		
	if (!ShowInternals)
		translate([0,0,BodyTube_Z]) color("LightBlue") 
			Tube(OD=Body_OD, ID=Body_ID, Len=BoosterBodyTubeLen-Overlap*2, myfn=$preview? 90:360);
		
	
	
	if (ShowInternals)
		translate([0,0,MotorTube_Z]) {
			color("Blue") Tube(OD=MotorTube_OD, ID=MotorTube_ID, Len=BoosterMotorTubeLen-Overlap*2, myfn=$preview? 90:360);
			translate([0,0,BoosterMotorTubeLen-18]) MotorTubeTopper(OD=Body_ID, ID=MotorTube_OD, MT_ID=MotorTube_ID);
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
	translate([0,0,TopRetainerFlange_t+8.7]) Custom_CenteringRingMount();
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
			translate([0,0,-73]) rotate([180,0,0]) PetalHub(OD=Coupler_OD, Skirt_h=1, HasWirePath=true);
	}
} // ShowMyStager

// ShowMyStager();


module DeepSocket(){
	Len=40;
	Al_Tube_d=5/16*25.4;
	
	difference(){
		union(){
			cylinder(d=16, h=Len);
			
			//translate([0,0,Len-12.7]) cylinder(d=0.5*25.4*1.1339, h=12.7, $fn=6);
		} // union
		// center hole
		translate([0,0,-Overlap]) cylinder(d=Al_Tube_d+IDXtra, h=Len+Overlap*2);
	
		translate([0,0,-Overlap]) Bolt250NutHole(depth=7);
	} // difference
} // DeepSocket

// rotate([180,0,0]) DeepSocket();

module DeepSocket500(){
	Len=40;
	Al_Tube_d=1/2*25.4;
	ID=5/16*25.4+IDXtra*4;
	Depth=8;
	
	difference(){
		cylinder(d=Al_Tube_d+6, h=Len); 
			
		// center hole
		hull(){
			translate([0,0,Depth-Overlap*2]) Bolt312NutHole(depth=Overlap);
			translate([0,0,Depth]) cylinder(d=ID, h=4);
		} // hull	
		
		cylinder(d=ID, h=Len);
		translate([0,0,Depth+6]) cylinder(d=Al_Tube_d+IDXtra, h=Len);
	
		// nut
		translate([0,0,-Overlap]) Bolt312NutHole(depth=Depth);
	} // difference
} // DeepSocket500

// DeepSocket500();

module NoseCone(){
	
	BluntOgiveNoseCone(ID=Body_OD-4.4, OD=Body_OD*CF_Comp+Vinyl_d, L=NC_Len, Base_L=NC_Base_L, nRivets=0, RivertInset=0, Tip_R=NC_Tip_R, HasThreadedTip=false, Wall_T=NC_Wall_t, Cut_d=0, LowerPortion=false, FillTip=true);

	difference(){
		PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=nPetals*2) hull(){
			cylinder(d=7, h=NC_Base_L);
			translate([0,3.5,0]) scale([1,0.2,1]) cylinder(d=9, h=NC_Base_L);
		}
		
		PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=nPetals*2) rotate([180,0,0]) Bolt4Hole();					
	} // difference
} // NoseCone

// NoseCone();

module PetalHub(OD=Coupler_OD, Skirt_h=5, HasWirePath=false){
	// attaches to nose cone
	
	
	CenterHole_d=5;
	
	module WireHole(){
		// wire path
		hull(){
			translate([0,-OD/2+5,-Skirt_h-Overlap]) cylinder(d=3.5, h=Skirt_h+20);
			translate([0,-OD/2+13,-Skirt_h-Overlap]) cylinder(d=3.5, h=Skirt_h+20);
		} // hull
		
		// Shock cord, must miss servo
		rotate([0,0,120]) translate([0,-10,-Skirt_h-Overlap]) cylinder(d=4, h=Skirt_h+20);
	} // WireHole
	
	translate([0,0,-Skirt_h])
	difference(){
		union(){
			PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=nPetals*2) hull(){
				cylinder(d=7, h=Skirt_h+Overlap);
				translate([0,3.0,0]) scale([1,0.2,1]) cylinder(d=9, h=Skirt_h+Overlap);
			}
			
			if (Skirt_h==1){
			  cylinder(d=OD, h=Skirt_h+Overlap, $fn=180);
			}else{
				if (Skirt_h>0)
					Tube(OD=Coupler_OD, ID=Coupler_OD-3.6, Len=Skirt_h+Overlap, myfn=$preview? 90:360);
			}
			
			cylinder(d=CenterHole_d+6, h=Skirt_h+Overlap);
		} // union
		
		PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=nPetals*2) rotate([180,0,0]) Bolt4ClearHole(depth=Skirt_h+10);
		translate([0,0,-Overlap]) cylinder(d=CenterHole_d, h=Skirt_h+Overlap*3);
		
		if (HasWirePath) WireHole();
	} // difference
	
	difference(){
		PD_PetalHub(OD=OD, 
					nPetals=nPetals, 
					HasReplaceableSpringHolder=false,
					HasBolts=true,
					nBolts=nPetals*2, // Same as nPetals
					ShockCord_a=-1,
					HasNCSkirt=false, 
						Body_OD=BT75Body_OD,
						Body_ID=BT75Body_ID,
						NC_Base=0, 
						SkirtLen=10, 
					CenterHole_d=0, nRopes=0);
					
		// center hole
		//translate([0,0,-Overlap]) cylinder(d=28, h=30);
		translate([0,0,-Skirt_h-Overlap]) cylinder(d=CenterHole_d, h=Skirt_h+30);
		
		if (HasWirePath) WireHole();
			
	} // difference
} // PetalHub

// translate([0,0,1]) PetalHub(OD=Coupler_OD, Skirt_h=1, HasWirePath=true);
// translate([0,0,5]) PetalHub(OD=Coupler_OD, Skirt_h=5);

module DroguePetalHub(){
	Skirt_H=15;
	
	difference(){
		union(){
			PetalHub(OD=Coupler_OD, Skirt_h=Skirt_H, HasWirePath=true);
			translate([0,0,-Skirt_H]) cylinder(d=LockPin_d, h=Skirt_H+6);
			
			translate([0,0,-4]) Tube(OD=Spring_ID, ID=Spring_ID-4.4, Len=5, myfn=90);
		} // union
		
		Thread_d=Thread1024_d;
		Thread_p=25.4/24;
		
		translate([0,0,-Skirt_H-Overlap]) 				
		if ($preview){
			cylinder(d=Thread_d, h=Skirt_H+7); 
		}else{
			ExternalThread(Pitch=Thread_p, Dia_Nominal=Thread_d+IDXtra*2, 
					Length=Skirt_H+7, 
					Step_a=2,TrimEnd=true,TrimRoot=true);
		}
	} // difference
} // DroguePetalHub

// DroguePetalHub();


module FW_GPS_SW_Hole(){
	// Switch
	translate([5,-1.6-1,-1]) 
		rotate([90,0,0]) cylinder(d=3, h=100);
		
	// Terminal block
	translate([10,0,4]) rotate([0,0,180]) cube([7,10,7]);
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
	
	Boss_Y=1;
	Boss_Z=13.5;
	Post_W=10;
	Post_Y=6;
	GPS_BoltSpace_X=12.7;
	GPS_BoltSpace_Z=25.4;
	
	difference(){
		union(){
			hull(){
				translate([-Post_W/2,Post_Y,0]) cube([Post_W,3,44]);
				translate([-Post_W/2,Post_Y,0]) cube([Post_W,10,1]);
			} // hull
			
			hull(){
				translate([-GPS_BoltSpace_X/2,Post_Y+Boss_Y,Boss_Z]) rotate([-90,0,0]) cylinder(d=Boss_d,h=3);
				translate([0,Post_Y,Boss_Z]) rotate([-90,0,0]) scale([0.1,1,1]) cylinder(d=Post_W+8,h=6);
			} // hull
			
			hull(){
				translate([GPS_BoltSpace_X/2,Post_Y+Boss_Y,Boss_Z+GPS_BoltSpace_Z]) rotate([-90,0,0]) cylinder(d=Boss_d,h=3);
				translate([0,Post_Y,Boss_Z+GPS_BoltSpace_Z-4]) rotate([-90,0,0]) scale([0.1,1,1]) cylinder(d=Post_W+8,h=4);
			} // hull
			
			translate([-GPS_BoltSpace_X/2,Boss_Y,Boss_Z]) Boss();
			translate([-GPS_BoltSpace_X/2,Boss_Y,Boss_Z]) translate([GPS_BoltSpace_X,0,GPS_BoltSpace_Z]) Boss();
		} // union
		
		translate([-GPS_BoltSpace_X/2,Boss_Y,Boss_Z]) rotate([90,0,0]) Bolt4Hole(depth=20);
		translate([-GPS_BoltSpace_X/2,Boss_Y,Boss_Z]) translate([GPS_BoltSpace_X,0,GPS_BoltSpace_Z]) rotate([90,0,0]) Bolt4Hole();
	} // difference
	
} // FW_GPS_Mount


//translate([20,0,0]) rotate([0,0,90]) FW_GPS_Mount();
	
module NC_GPS_Mounting_Plate(OD=Coupler_OD, Skirt_h=5, HasAlTube=true){
// *** not finished ***

	Al_Tube_d=8;
	Al_Tube_Len=30;
	CenterHole_d=18;
	Wall_t=1.8;
	
	// GPS mount
	Post_W=10;
	Post_Y=6;
	rotate([0,0,-30]) translate([24,0,4]) rotate([0,-15,0]) rotate([0,0,90]) FW_GPS_Mount();
	rotate([0,0,-30]) translate([24,0,0]) rotate([0,0,90]) translate([-Post_W/2,Post_Y,0]) cube([Post_W,10,Skirt_h]);
	
	difference(){
		union(){
			// GPS support
			intersection(){
				difference(){
					hull(){
						cylinder(d=1, h=Skirt_h);
						rotate([0,0,-120]) translate([0,OD/2,0]) cylinder(d=32, h=Skirt_h);
					} // hull
					
					translate([0,0,-Overlap]) cylinder(d=20, h=Skirt_h+Overlap*2);
				} // difference
				
				cylinder(d=OD, h=Skirt_h);
			} // intersection
			
		
			PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=nPetals*2){
				// Bolt bosses
				hull(){
					cylinder(d=7, h=Skirt_h);
					translate([0,3.0,0]) scale([1,0.2,1]) cylinder(d=9, h=Skirt_h);
				} // hull
				
				// Spokes
				hull(){
					cylinder(d=Wall_t, h=Skirt_h);
					translate([0,-OD/2,0]) cylinder(d=Wall_t, h=Skirt_h);
				} // hull
			}
			
			Tube(OD=Coupler_OD, ID=Coupler_OD-Wall_t*2, Len=Skirt_h, myfn=$preview? 90:360);
			Tube(OD=CenterHole_d+Wall_t*2, ID=CenterHole_d, Len=Skirt_h, myfn=$preview? 90:360);
			
			// Al_Tube mount
			if (HasAlTube)
			hull(){
				translate([0,0,Al_Tube_d/2+Skirt_h]) rotate([90,0,0]) cylinder(d=Al_Tube_d+4, h=Al_Tube_Len, center=true);
				translate([-Al_Tube_d/2-3, -Al_Tube_Len/2,0]) cube([Al_Tube_d+6, Al_Tube_Len, 1]);
			} // hull
			
		} // union
		
		PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=nPetals*2) rotate([180,0,0]) Bolt4ClearHole();
		
		// Aluminum Tube
		if (HasAlTube)
			translate([0,0,Al_Tube_d/2+Skirt_h]) rotate([90,0,0]) cylinder(d=Al_Tube_d, h=Body_OD, center=true);
			
		// Center hole
		translate([0,0,-Overlap]) cylinder(d=CenterHole_d, h=Al_Tube_d+7);
	} // difference
} // NC_GPS_Mounting_Plate

// translate([0,0,-0.1]) rotate([180,0,0]) 
// NC_GPS_Mounting_Plate(OD=Coupler_OD, Skirt_h=4, HasAlTube=true);

module SpringNest(){
	LargeSping_ID=SE_Spring_CS4323_ID();
	LargeSping_OD=SE_Spring_CS4323_OD();
	SmallSpring_ID=SE_Spring3670_ID();
	SmallSpring_OD=SE_Spring3670_OD();
	Len=SE_Spring3670_CBL();
	Wall_t=1.2;
	
	difference(){
		union(){
			cylinder(d=LargeSping_OD, h=2);
			cylinder(d=LargeSping_ID, h=5);
			translate([0,0,5-Overlap]) cylinder(d1=LargeSping_ID, d2=LargeSping_ID-1, h=Len-5+Overlap);
			cylinder(d=SmallSpring_OD+4.4, h=Len);
		} // union
		
		// center hole
		translate([0,0,-Overlap]) cylinder(d=SmallSpring_ID, h=Len+Overlap*2);
		translate([0,0,-Overlap]) cylinder(d=SmallSpring_OD, h=Len-2);
		translate([0,0,-Overlap]) cylinder(d1=SmallSpring_OD+1, d2=SmallSpring_OD, h=Len-4);
		
	} // difference
} // SpringNest

// SpringNest();

module SpringSliderLight(){
	OD=Coupler_OD;
	Wall_t=1.2;
	Len=35;
	nSpokes=6;
	SpringStop_Z=15;
	Spring_OD=SE_Spring_CS4323_OD();
	Spring_ID=SE_Spring_CS4323_ID();
	Taper_d=1;
	
	// Outside
	Tube(OD=OD, ID=OD-Wall_t*2, Len=Len, myfn=$preview? 90:180);
	
	// Inside
	difference(){
		union(){
			// Spokes
			for (j=[0:nSpokes-1]) rotate([0,0,360/nSpokes*j])
				hull(){
					translate([0,OD/2-Wall_t/2,0]) cylinder(d=Wall_t, h=Len);
					translate([0,Spring_OD/2+Wall_t/2,0]) cylinder(d=Wall_t, h=Len);
				} // hull
			
			translate([0,0,SpringStop_Z+8]) cylinder(d2=Spring_OD+Taper_d+Wall_t*2, d1=Spring_OD+Wall_t*2, h=Len-SpringStop_Z-8);
			translate([0,0,SpringStop_Z-5-Overlap]) cylinder(d=Spring_OD+Wall_t*2, h=13+Overlap*2);
			cylinder(d1=Spring_OD+Taper_d+Wall_t*2, d2=Spring_OD+Wall_t*2, h=SpringStop_Z-5);
		} // union
	
		translate([0,0,SpringStop_Z+8]) cylinder(d2=Spring_OD+Taper_d, d1=Spring_OD, h=Len-SpringStop_Z-8+Overlap);
		translate([0,0,SpringStop_Z+3]) cylinder(d=Spring_OD, h=6);
		cylinder(d=Spring_ID-1, h=Len);
		cylinder(d=Spring_OD, h=SpringStop_Z);
		translate([0,0,-Overlap]) cylinder(d1=Spring_OD+Taper_d, d2=Spring_OD, h=SpringStop_Z-5+Overlap);
	} // difference
} // SpringSliderLight

// SpringSliderLight();

module FwdSpringEnd(nRopes=0, Skirt_h=25, HasServoConnector=false){
// This locks onto the bottom of the petals.
	CR_t=2;
	Rope_d=3;
	OD=Coupler_OD;
	Petal_ID=Coupler_OD-3.5; // should fit loose
	PetalLock_ID=Coupler_OD-7.5; // Should not touch at all
	ShockCord_Y=Spring_ID/2-2.2-Rope_d/2-1;
	Boss_t=4;
	nVentHoles=5;
	VentHole_d=7;
	VentHole_Y=LockPin_d/2+VentHole_d/2;
	myFn=floor(Body_OD)*3;
	
	difference(){
		union(){
			difference(){
				cylinder(d=OD, h=6, $fn=$preview? 90:myFn);
				
				translate([0,0,CR_t-Overlap]) cylinder(d1=Coupler_ID-4, d2=Coupler_ID, h=4+Overlap*2, $fn=$preview? 90:myFn);
			} // difference
			
			cylinder(d=LockPin_d, h=Boss_t);
			
			// Skirt
			Tube(OD=Coupler_OD, ID=Coupler_ID, Len=Skirt_h, myfn=$preview? 90:myFn);
			
			difference(){
				cylinder(d=Coupler_OD, h=CR_t+5.5, $fn=$preview? 90:myFn);
				
				translate([0,0,CR_t]) cylinder(d=PetalLock_ID-2.8, h=4.5, $fn=$preview? 90:myFn);
				
				translate([0,0,CR_t+3.5]) cylinder(d1=PetalLock_ID-2.8, d2=Coupler_ID, h=3.5+Overlap, $fn=$preview? 90:myFn);
			} // difference
			
			// Spring
			Tube(OD=Spring_ID, ID=Spring_ID-4.4, Len=CR_t+4, myfn=$preview? 90:myFn);
			
		} // union
		
		// Servo connector
		if (HasServoConnector) rotate([0,0,30]) translate([0,OD/2-7,-Overlap]) RoundRect(X=11, Y=4, Z=10, R=0.2);
		
		// Center hole
		Thread_d=Thread1024_d;
		Thread_p=25.4/24;
		translate([0,0,-Overlap]) 
			if ($preview){
				cylinder(d=Thread_d, h=Boss_t+Overlap*2); 
			}else{
				ExternalThread(Pitch=Thread_p, Dia_Nominal=Thread_d+IDXtra*2, 
						Length=Boss_t+Overlap*2, 
						Step_a=2,TrimEnd=true,TrimRoot=true);
			}
		
		// Air Vent Holes
		for (j=[0:nVentHoles-1]) rotate([0,0,360/nVentHoles*j]) 
			translate([0,VentHole_Y,-Overlap]) cylinder(d=VentHole_d, h=CR_t+Overlap*2);
		
		// Shock cord
		rotate([0,0,180/nVentHoles]) translate([0,ShockCord_Y,-Overlap]) cylinder(d=4, h=30);
		
		// Petal Locks
		difference(){
			translate([0,0,-Overlap]) cylinder(d=Coupler_OD+1, h=4.5+Overlap*2, $fn=$preview? 90:myFn);
			
			// Puller ring
			translate([0,0,-Overlap*2]) cylinder(d=Petal_ID, h=2+Overlap*3, $fn=$preview? 90:myFn);
			// Petal lock
			translate([0,0,-Overlap*2]) cylinder(d=PetalLock_ID, h=4.5+Overlap*3, $fn=$preview? 90:myFn);
			
		} // difference
		
		// Rope holes
		if (nRopes>0) for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j]) 
			translate([0,Spring_OD/2+Rope_d/2+2,-Overlap]) cylinder(d=Rope_d, h=CR_t+Overlap*2);
			
		//if ($preview) translate([0,0,-Overlap]) cube([100,100,100]);
	} // difference
	
} // FwdSpringEnd

// FwdSpringEnd(nRopes=6, HasServoConnector=true);


module AftSpringEnd(nRopes=0, Skirt_h=25){
// This locks onto the bottom of the petals.
// For drogue bay

	CR_t=2;
	Rope_d=3;
	OD=Coupler_OD;
	Petal_ID=Coupler_OD-3.5; // should fit loose
	PetalLock_ID=Coupler_OD-7.5; // Should not touch at all
	ShockCord_Y=Coupler_ID/2-10;
	Boss_t=4;
	nVentHoles=5;
	VentHole_d=7;
	VentHole_Y=15+VentHole_d/2;
	Wall_t=1.8;
	myFn=floor(Body_OD)*3;
	
	difference(){
		union(){
			difference(){
				cylinder(d=OD, h=6, $fn=$preview? 90:myFn);
				
				translate([0,0,CR_t-Overlap]) cylinder(d1=Coupler_ID-4, d2=Coupler_ID, h=4+Overlap*2, $fn=$preview? 90:myFn);
			} // difference
			
			cylinder(d=LockPin_d, h=Boss_t);
			
			// Skirt
			Tube(OD=Coupler_OD, ID=Coupler_OD-Wall_t*2, Len=Skirt_h*2+3, myfn=$preview? 90:myFn);
			
			// Tube Stop
			translate([0,0,Skirt_h]) Tube(OD=Body_OD*CF_Comp+Vinyl_d, ID=Coupler_OD-Wall_t*2, Len=3, myfn=$preview? 90:myFn);
			
			difference(){
				cylinder(d=Coupler_OD, h=CR_t+5.5, $fn=$preview? 90:myFn);
				
				translate([0,0,CR_t]) cylinder(d=PetalLock_ID-2.8, h=4.5, $fn=$preview? 90:myFn);
				
				translate([0,0,CR_t+3.5]) cylinder(d1=PetalLock_ID-2.8, d2=Coupler_ID, h=3.5+Overlap, $fn=$preview? 90:myFn);
			} // difference
			
		} // union
		
		// Center hole
		Thread_d=MotorBolt_d;
		Thread_p=MotorBoltPitch;
		translate([0,0,-Overlap]) 
			if ($preview){
				cylinder(d=Thread_d, h=Boss_t+Overlap*2); 
			}else{
				ExternalThread(Pitch=Thread_p, Dia_Nominal=Thread_d+IDXtra*2, 
						Length=Boss_t+Overlap*2, 
						Step_a=2,TrimEnd=true,TrimRoot=true);
			}
		
		// Air Vent Holes
		for (j=[0:nVentHoles-1]) rotate([0,0,360/nVentHoles*j]) 
			translate([0,VentHole_Y,-Overlap]) cylinder(d=VentHole_d, h=CR_t+Overlap*2);
		
		// Shock cord
		rotate([0,0,180/nVentHoles]) translate([0,ShockCord_Y,-Overlap]) cylinder(d=4, h=30);
		
		// Petal Locks
		difference(){
			translate([0,0,-Overlap]) cylinder(d=Coupler_OD+1, h=4.5+Overlap*2, $fn=$preview? 90:myFn);
			
			// Puller ring
			translate([0,0,-Overlap*2]) cylinder(d=Petal_ID, h=2+Overlap*3, $fn=$preview? 90:myFn);
			// Petal lock
			translate([0,0,-Overlap*2]) cylinder(d=PetalLock_ID, h=4.5+Overlap*3, $fn=$preview? 90:myFn);
			
		} // difference
		
		// Rope holes
		if (nRopes>0) for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j]) 
			translate([0,Spring_OD/2+Rope_d/2+2,-Overlap]) cylinder(d=Rope_d, h=CR_t+Overlap*2);
			
		//if ($preview) translate([0,0,-Overlap]) cube([100,100,100]);
	} // difference
	
} // AftSpringEnd

// AftSpringEnd();

module Custom_CenteringRingMount(){
	ShockCordHole_d=5;
	ShockCord_a=30;
	Rope_d=3;
	nRopes=6;
	Spring_Z=4;
	Thickness=7;
	Wall_t=1.2;
	nBolts=3;
	myFn=floor(Body_ID)*3;
	
	difference(){
		union(){
			// Body centering
			Tube(OD=Body_ID, ID=Body_ID-Wall_t*2, Len=Thickness, myfn=$preview? 90:myFn);
			
			// Spring
			Tube(OD=Spring_OD+Wall_t*2, ID=Spring_OD, Len=Thickness, myfn=$preview? 90:myFn);
			Tube(OD=Spring_OD+Wall_t*2, ID=Spring_ID, Len=Spring_Z, myfn=$preview? 90:myFn);
			
			// Lock Pin Guide Hole
			Tube(OD=LockPin_d+1+Wall_t*2, ID=LockPin_d+1, Len=Spring_Z, myfn=$preview? 90:myFn);
			
			// Bolts to CRBB_TopRetainer
			CRBBm_MountingBoltPattern(nTopBolts=nBolts, LockRing_d=CRBBm_LockRingDiameter()) cylinder(d=Bolt4Inset*2, h=Thickness);
			
			// Ropes
			for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j]) translate([0,Spring_OD/2+Rope_d/2+Wall_t,0])
				cylinder(d=Rope_d+Wall_t*2, h=Thickness);
				
			// Spokes
			for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j]) hull(){
				translate([0,Body_ID/2-Wall_t,0])
					cylinder(d=Wall_t, h=Thickness);
				translate([0,(LockPin_d+1)/2+Wall_t,0])
					cylinder(d=Wall_t, h=Thickness);
			} // hull
		}
	
		// Spring
		//difference(){
			translate([0,0,Spring_Z]) cylinder(d=Spring_OD, h=Thickness);
			//cylinder(d=Spring_ID-10, h=Thickness);
		//} // difference
		
		//CRBBm_CenteringRingMount(Tube_ID=Body_ID, Thickness=Thickness, Skirt_Len=0, nBolts=3, nRopes=6, HasShockcodeAnchor=false, 
		//							LockRing_d=CRBBm_LockRingDiameter(), Spring_OD=Spring_OD, Spring_ID=Spring_ID);
		
		// Bolts to CRBB_TopRetainer
		translate([0,0,4])
			CRBBm_MountingBoltPattern(nTopBolts=nBolts, LockRing_d=CRBBm_LockRingDiameter()) Bolt4ButtonHeadHole();
			
		// Ropes
		for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j]) translate([0,Spring_OD/2+Rope_d/2+Wall_t,-Overlap])
			cylinder(d=Rope_d, h=Thickness+Overlap*2);

		// Shock cord entry		
		rotate([0,0,ShockCord_a]){
			translate([0, Spring_ID/2-ShockCordHole_d/2, 5]) cylinder(d=ShockCordHole_d, h=5);
			hull(){
				translate([0, Spring_ID/2-ShockCordHole_d/2, 5]) sphere(d=ShockCordHole_d);
				translate([0, Coupler_OD/2-ShockCordHole_d/2-2, 1]) sphere(d=ShockCordHole_d);
			} // hull
			translate([0, Coupler_OD/2-ShockCordHole_d/2-2, -Overlap]) cylinder(d=ShockCordHole_d, h=1+Overlap*2);
		} // rotate
		
	} // difference
} // Custom_CenteringRingMount

// Custom_CenteringRingMount();

module LockingPinCentering(){
	Al_Tube_d=5/16*25.4;
	
	difference(){
		union(){
			cylinder(d=LockPin_d, h=2+Overlap);
			translate([0,0,2]) cylinder(d1=LockPin_d, d2=Al_Tube_d+IDXtra+2.4, h=6);
		
		} // union
		
		translate([0,0,2]) cylinder(d=Al_Tube_d+IDXtra, h=6+Overlap);
		translate([0,0,2+Overlap]) Bolt10ClearHole();
		
	} // difference
} // LockingPinCentering

// LockingPinCentering();

module CRBBm_Activator(){
	Plate_t=6;
	Plate_d=CRBBm_BottomBoltCircle_d()+Bolt4Inset*2+2;
	Ring_h=8;
	Ring_t=2;
	Wall_t=1.2;
	
	Magnet_d=3/16*25.4;
	Magnet_Z=-3-Magnet_d/2;
	Magnet_a=180;
	
	Servo_Z=-19;
	Plate_Z=Servo_Z+2.5;
	Servo_Y=CRBBm_LockRingBoltCircle_d()/2+1;
	ServoRot_a=12+180;
	ServoPos_a=-70;
	
	ShockCord_a=-150;
	ShockCordGuide_H=3;
	ShockCordHole_d=5;
	ShockCord_Y=Coupler_OD/2-2.5-2;
	
	module ShockCordGuide(){
		difference(){
			hull(){
				rotate([0,0,ShockCord_a]) translate([0,ShockCord_Y,Plate_Z]) cylinder(d=ShockCordHole_d+2.4, h=ShockCordGuide_H);
				rotate([0,0,ShockCord_a]) translate([0,Coupler_OD/2-Ring_t,Plate_Z]) 
					scale([1,0.1,1]) cylinder(d=ShockCordHole_d+2.4+2, h=ShockCordGuide_H);
			} // hull
			
			rotate([0,0,ShockCord_a]) translate([0,ShockCord_Y,Plate_Z-Overlap]) cylinder(d=ShockCordHole_d, h=ShockCordGuide_H+Overlap*2);
		} // difference
	} // ShockCordGuide
	
	ShockCordGuide();
	
	module TopMountingBolts(){
		nBolts=3;
		
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j])
			translate([0,CRBBm_BottomBoltCircle_d()/2,1.6])
				rotate([180,0,0]) Bolt4HeadHole(depth=Plate_t+8,lHead=12);
	} // TopMountingBolts
	
	module MagnetHole(){
		translate([-1.5,0,Magnet_Z]) rotate([0,90,0]) cylinder(d=Magnet_d, h=7, center=true);
	} // MagnetHole
	
	module MagnetPost(){
		H=-Servo_Z-2.5-2;
		W=3.5;
		
		
		rotate([0,0,Magnet_a])
		translate([W,CRBBm_LockRingBoltCircle_d()/2,0])
		difference(){
			hull(){
				translate([-1.5,-3,-2-H]) cylinder(d=W, h=H);
				translate([-1.5,4,-2-H]) cylinder(d=W, h=H);
				translate([-1.5,10,-2-H]) cylinder(d=W, h=6);
			} // hull
			
			MagnetHole();
		} // difference
	} // MagnetPost
	
	MagnetPost();
		
	// Spokes
	Spoke_a=[46,63,135,175,225,242,326+ServoPos_a]; // 342+ServoPos_a
	for (j=Spoke_a) difference(){
		rotate([0,0,j]) hull(){
			translate([0,Plate_d/2-1.2,-Plate_t]) cylinder(d=1.2, h=Plate_t);
			translate([0,Coupler_OD/2-Ring_t,Servo_Z+2.5]) cylinder(d=1.2, h=Ring_h);
		} // hull
		
		if (j==175) rotate([0,0,Magnet_a])
			translate([3.5,CRBBm_LockRingBoltCircle_d()/2,0]) MagnetHole();
	} // difference
	
	
	// servo support
	rotate([0,0,55+ServoPos_a]) hull(){
		translate([0,Plate_d/2-1.2,-Plate_t]) cylinder(d=1.2, h=Plate_t);
		translate([0,Coupler_OD/2-Ring_t,Servo_Z+2.5]) cylinder(d=1.2, h=Ring_h);
	} // hull
	
	ServoStruts_a=[55+ServoPos_a,63+ServoPos_a,326+ServoPos_a]; // ,342+ServoPos_a
	//*
	for (j=ServoStruts_a) rotate([0,0,j]) hull(){
		translate([0,Coupler_OD/2-Ring_t,Servo_Z+2.5]) cylinder(d=1.2, h=4.5);
		translate([0,Coupler_OD/2-8.5,Servo_Z+2.5]) cylinder(d=1.2, h=4.5);
	} // hull
	/**/

	difference(){
		union(){
			translate([0,0,-Plate_t]) CRBBm_BlankInnerBearingRetainer(H=Plate_t+8, HasCenterHole=true, Light=true);
			translate([0,0,-Plate_t]) cylinder(d=MotorBolt_d+4.4, h=Plate_t+8);
			
			intersection(){
				rotate([0,0,ServoPos_a]) translate([0,Servo_Y,Servo_Z])
					rotate([0,0,ServoRot_a]) ServoSG90TopBlock(Xtra_Len=4, Xtra_Width=-Overlap, Xtra_Height=2, HasWireNotch=false);
					
				translate([0,0,Servo_Z]) cylinder(d=Coupler_OD, h=10);
			} // intersection

		} // union
		
		rotate([0,0,ServoPos_a]) translate([0,Servo_Y,Servo_Z]) translate([0,0,10])
			hull(){
				cylinder(d=9, h=8);
				translate([0,3,0]) cylinder(d=14, h=8);
			} // hull
		
		TopMountingBolts();
		
		// center hole
		translate([0,0,-Plate_t-Overlap]){
			Thread_d=MotorBolt_d;
			Thread_p=MotorBoltPitch;

			translate([0,0,-Overlap])
					cylinder(d1=Thread_d+2, d2=Thread_d, h=2);
			if ($preview){
				cylinder(d=Thread_d, h=Plate_t+8+Overlap*2); 
			}else{
				ExternalThread(Pitch=Thread_p, Dia_Nominal=Thread_d+IDXtra*2, 
						Length=Plate_t+8+Overlap*2, 
						Step_a=2,TrimEnd=true,TrimRoot=true);
			}}
	} // difference
		
	translate([0,0,Servo_Z+2.5]) rotate([0,0,54]) EBay_TopPlate();
	
	if ($preview){
	rotate([0,0,ServoPos_a]) translate([0,Servo_Y,Servo_Z]) color("Red") {
		rotate([0,0,ServoRot_a]) ServoSG90(TopMount=false, HasGear=false);
		cylinder(d=7, h=20);
		}
	//translate([0,0,Servo_Z+3]) cylinder(d=Body_ID, h=1);
	}
	
	
} // CRBBm_Activator

// translate([0,0,81.7]) rotate([0,0,180]) CRBBm_Activator();
// translate([0,0,-120]) rotate([0,0,155]) EBayMC(Light=true, HasRS_Mount=true);
// translate([0,0,81.7+22.2]) ShowCableRelease();

module EBay(Light=false){
	Raven_Z=30;
	Raven_a=-90;
	Raven_X=-7;
	Raven_Y=0;

	RocketServo_Z=33.5;
	RocketServo_a=0;
	RocketServo_Y=-7;
	
	Mag_SW_a=0;
	Mag_SW_X=23;
	Mag_SW_Y=0;
	
	
	Battery_Z=22.2;
	Battery_X=0;
	Battery_Y=20;
	Battery_a=90;
	
	Batt_X=20;
	Batt_Y=12.2;
	Batt_Z=40; // was 43
	
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
			
			// Lighter
			if (Light){
				hull(){
					rotate([90,0,0]) cylinder(d=14, h=Batt_Y+Wall_t*2+Overlap, center=true);
					translate([0,0,Battery_Z/2]) rotate([90,0,0]) cylinder(d=4, h=Batt_Y+Wall_t*2+Overlap, center=true);
					translate([0,0,-Battery_Z/2]) rotate([90,0,0]) cylinder(d=4, h=Batt_Y+Wall_t*2+Overlap, center=true);
				} // hull
				
				hull(){
					rotate([0,90,0]) cylinder(d=10, h=Batt_X+Wall_t*2+Overlap, center=true);
					translate([0,0,Battery_Z/2]) rotate([0,90,0]) cylinder(d=4, h=Batt_X+Wall_t*2+Overlap, center=true);
					translate([0,0,-Battery_Z/2]) rotate([0,90,0]) cylinder(d=4, h=Batt_X+Wall_t*2+Overlap, center=true);
				} // hull
			} // if
		} // difference
	} // BattPocket
	
	// Mag_Sw
	rotate([0,0,Mag_SW_a]) translate([Mag_SW_X,Mag_SW_Y,0])
	hull(){
		H=18.5;
		translate([-7,0,0]) cylinder(d=4, h=H);
		translate([7,0,0]) cylinder(d=4, h=H);
	} // hull
	
	// Raven
	rotate([0,0,90+Raven_a]) translate([Raven_Y,-Raven_X+3,0])
	hull(){
		translate([-9,0,0]) cylinder(d=6, h=7);
		translate([9,0,0]) cylinder(d=6, h=7);
	} // hull
		
	difference(){
		rotate([0,0,30]) EBay_BasePlate();
		
		// Battery pushing hole and cleanup inside
		rotate([0,0,Battery_a]) translate([Battery_X,Battery_Y,Battery_Z]) rotate([0,0,-90]) {
			translate([0,0,2]) BattHole(Xtra_X=0, Xtra_Y=0, Xtra_Z=4);
			translate([0,0,-Batt_Z/2-4-Overlap]) cylinder(d=5,h=5);}
	} // difference

	rotate([0,0,Mag_SW_a]) translate([Mag_SW_X,Mag_SW_Y+2,28]) rotate([0,0,0]) rotate([90,0,0]) FW_MagSw_Mount(HasMountingEars=false);
	
	difference(){
		rotate([0,0,Raven_a]) translate([Raven_X,Raven_Y,Raven_Z]) rotate([0,-90,0]) BlueRavenMount();
		
		rotate([0,0,Mag_SW_a]) translate([18.5,2,28]) rotate([0,0,0]) rotate([90,0,0]) FW_MagSw_BoltPattern() Bolt4Hole();
	} // difference
	
	rotate([0,0,RocketServo_a]) translate([0,RocketServo_Y,RocketServo_Z]) rotate([0,180,0]) rotate([90,0,0]) 
		difference(){
			RocketServoHolderRevC(IsDouble=false);
			
			if (Light)
				hull(){
					translate([0,0,-Overlap]) cylinder(d=12, h=5);
					translate([0,28,-Overlap]) cylinder(d=4, h=5);
					translate([0,-28,-Overlap]) cylinder(d=4, h=5);
				} // hull
		} // difference
	
	rotate([0,0,Battery_a]) translate([Battery_X,Battery_Y,Battery_Z]) rotate([0,0,-90]) BattPocket();
	
} // EBay

// EBay(Light=true);
//translate([0,0,85]) rotate([0,0,155]) CRBBm_Activator();

module EBayMC(Light=true, HasRS_Mount=false){
	// Mission Control version
	// Featherweight Mag Switch, Rocket Servo PCBA, 2S LiPo
		
	Mag_SW_a=-122;
	Mag_SW_X=23.5;
	Mag_SW_Y=0;
	Mag_SW_Z=18;

	EBayMC_Len=MC_Size_Z()+10;
	Alt_Z=EBayMC_Len/2+2;
	Alt_Y=Body_ID/2-15;
	
	Battery_Z=22.2;
	Battery_X=0;
	Battery_Y=-20;
	Battery_a=0;
	BattRotation_a=90;

	// Battery size
	Batt_X=20;
	Batt_Y=12.2;
	Batt_Z=40; // was 43

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
			
			// Lighter
			if (Light){
				hull(){
					rotate([90,0,0]) cylinder(d=14, h=Batt_Y+Wall_t*2+Overlap, center=true);
					translate([0,0,Batt_Z/3]) rotate([90,0,0]) cylinder(d=3, h=Batt_Y+Wall_t*2+Overlap, center=true);
					translate([0,0,-Batt_Z/3]) rotate([90,0,0]) cylinder(d=3, h=Batt_Y+Wall_t*2+Overlap, center=true);
				} // hull
				
				hull(){
					rotate([0,90,0]) cylinder(d=10, h=Batt_X+Wall_t*2+Overlap, center=true);
					translate([0,0,Batt_Z/3]) rotate([0,90,0]) cylinder(d=3, h=Batt_X+Wall_t*2+Overlap, center=true);
					translate([0,0,-Batt_Z/3]) rotate([0,90,0]) cylinder(d=3, h=Batt_X+Wall_t*2+Overlap, center=true);
				} // hull
			} // if
		} // difference
	} // BattPocket
	
	rotate([0,0,Battery_a]) translate([Battery_X,Battery_Y,Battery_Z]) rotate([0,0,BattRotation_a]) BattPocket();
	
	// Base Plate
	difference(){
		rotate([0,0,259+180]) EBay_BasePlate(OD=Coupler_OD, IsLowerPlate=false, HasSecBolts=true, ShockCord_a=-20);
		
		// Battery pushing hole and cleanup inside
		rotate([0,0,Battery_a]) translate([Battery_X,Battery_Y,Battery_Z]) rotate([0,0,BattRotation_a]) rotate([0,0,-90]) {
			translate([0,0,2]) BattHole(Xtra_X=0, Xtra_Y=0, Xtra_Z=4);
			translate([0,0,-Batt_Z/2-4-Overlap]) cylinder(d=5,h=5);}
	} // difference
	
	AltBoltBoss_h=3.5;
	BackPlate_W=42;
	BackPlate_t=4;
	// Mission Control Mount
	difference(){
		union(){
			// Alt bolt bosses
			translate([0,Alt_Y,Alt_Z]) rotate([90,0,0]) AltHoles() cylinder(d2=10, d1=6, h=AltBoltBoss_h+0.5+Overlap);
			
			// Backing plate
			hull(){
				translate([BackPlate_W/2-6.5, Alt_Y-AltBoltBoss_h-BackPlate_t/2, Alt_Z+MC_HoleSpace_Z()/2]) 
					rotate([90,0,0]) cylinder(d=10, h=BackPlate_t, center=true);
					
				translate([-BackPlate_W/2+6.5, Alt_Y-AltBoltBoss_h-BackPlate_t/2, Alt_Z+MC_HoleSpace_Z()/2]) 
					rotate([90,0,0]) cylinder(d=10, h=BackPlate_t, center=true);
			
				translate([BackPlate_W/2-BackPlate_t/2, Alt_Y-AltBoltBoss_h-BackPlate_t/2, 0]) 
					cylinder(d=BackPlate_t, h=Alt_Z+MC_HoleSpace_Z()/2);
				
				translate([-BackPlate_W/2+BackPlate_t/2, Alt_Y-AltBoltBoss_h-BackPlate_t/2, 0]) 
					cylinder(d=BackPlate_t, h=Alt_Z+MC_HoleSpace_Z()/2);
			} // hull
			
			// Threaded rod 
			translate([0, 0, Alt_Z+MC_Size_Z()/2-2]) 
				hull(){
					cylinder(d=MotorBolt_d+4.4, h=5, center=true);
					translate([0, Alt_Y-AltBoltBoss_h-2.5, 0]) scale([1,0.1,1]) cylinder(d=MotorBolt_d+10, h=5, center=true);
				} // hull
		} // union
		
		// Terminal block clearance
		translate([-27/2,0,Alt_Z+MC_Size_Z()/2-20.7]) cube([27,20,15]);
		
		// connector
		translate([0, Alt_Y-AltBoltBoss_h-1.5, Alt_Z-MC_Size_Z()/2+5.5]) cube([21,20,12], center=true);
		
		// Center cut-out
		translate([0, Alt_Y-AltBoltBoss_h-1.5, Alt_Z+2.5]) cube([26,20,75], center=true);
		
		// Threaded rod
		//cylinder(d=MotorBolt_d, h=EBayMC_Len+10);
		Boss_t=5;
		Thread_d=MotorBolt_d;
		Thread_p=MotorBoltPitch;
		
		// Align to lower thread
		translate([0,0,-Overlap+floor((Alt_Z+MC_Size_Z()/2-2-Boss_t/2)/Thread_p)*Thread_p])
			if ($preview){
				cylinder(d=Thread_d, h=Boss_t+Thread_p); 
			}else{
				ExternalThread(Pitch=Thread_p, Dia_Nominal=Thread_d+IDXtra*2, 
						Length=Boss_t+Thread_p, 
						Step_a=2,TrimEnd=true,TrimRoot=true);
			} // if
	
		
		// alt bolts
		translate([0,Alt_Y,Alt_Z]) rotate([90,0,0]) AltHoles() rotate([180,0,0]) Bolt4Hole(depth=AltBoltBoss_h+5);
	} // difference
	
	if (HasRS_Mount){
		translate([12,-2,0]) rotate([0,0,90]) RocketServoMountVert(Base_h=1);
		translate([-12,-2,0]) rotate([0,0,-90]) RocketServoMountVert(Base_h=1);
	}
	
	// LED face plate
	MC_LED_Z=Alt_Z-MC_Size_Z()/2+MC_LED_Z();
	MC_ArmScrew_Z=Alt_Z-MC_Size_Z()/2+MC_ArmingScrew_Z();
	RS_LED_Z=MC_LED_Z-7;
	RS2_LED_Z=MC_ArmScrew_Z-7;
	difference(){
		translate([0,Body_ID/2-2.2,0]) RoundRect(X=12, Y=3, Z=MC_LED_Z()+15, R=1.3);
		
		translate([0,Alt_Y,MC_LED_Z]) rotate([-90,0,0]) cylinder(d=5, h=20);
		translate([0,Alt_Y,MC_ArmScrew_Z]) rotate([-90,0,0]) cylinder(d=5, h=20);
		
		translate([0,Alt_Y,RS_LED_Z]) rotate([-90,0,0]) cylinder(d=3, h=20);
		translate([0,Alt_Y,RS2_LED_Z]) rotate([-90,0,0]) cylinder(d=3, h=20);
	} // difference
	
	rotate([0,0,Mag_SW_a]) translate([Mag_SW_X,Mag_SW_Y+2,Mag_SW_Z]) rotate([90,0,0]) FW_MagSw_Mount(HasMountingEars=false);
	rotate([0,0,Mag_SW_a]) translate([Mag_SW_X,Mag_SW_Y,0]) RoundRect(X=17,Y=4,Z=Mag_SW_Z-9.5, R=1);
	
	//if ($preview) translate([0,Alt_Y,Alt_Z]) rotate([0,0,180]) rotate([90,0,0]) AltPCB();
} // EBayMC

// EBayMC(Light=true, HasRS_Mount=true);

module SustainerMiddleRing(Len=30){
	OD=Coupler_OD;
	nSpokes=6;
	Spoke_t=1.2;
	Wall_t=1.8;
	nRivets=3;
	Thread_d=MotorBolt_d;
	Thread_p=MotorBoltPitch;
	nOuterBolts=2;
	Outer_BC_d=SecurityRod_BC_d;
	
	difference(){
		union(){
			cylinder(d=Thread_d+4.4, h=Len);
			
			for (j=[0:nSpokes-1]) rotate([0,0,360/nSpokes*j])
					hull(){
						H=(j==1)? 8:Len;
						cylinder(d=Spoke_t, h=H);
						translate([0,OD/2-Wall_t,0]) cylinder(d=Spoke_t, h=H);
					} // hull
				
			
			Tube(OD=OD, ID=OD-Wall_t*2, Len=Len, myfn=$preview? 36:180);
			
			// #10-24 threaded rods
			for (j=[0:nOuterBolts-1]) rotate([0,0,360/nOuterBolts*j])
				hull(){
					translate([0,Outer_BC_d/2,0]) cylinder(d=Thread1024_d+4.4, h=Len);
					translate([0,OD/2-1,0]) scale([1,0.1,1]) cylinder(d=Thread1024_d+6.4, h=Len);
				} // hull
			
			// shock cord
			ShockCord_a=-30;
			rotate([0,0,ShockCord_a])
				translate([0,10,Len/2]) cylinder(d=11, h=10, center=true);
				
		
			
		} // union
		
		// shock cord
			ShockCord_a=-30;
			rotate([0,0,ShockCord_a])
				translate([0,10,Len/2]) cylinder(d=3.6, h=11, center=true);
				
		for (j=[0:nRivets-1]) rotate([0,0,360/nRivets*j+180/nSpokes])
			translate([0,OD/2,Len/2]) rotate([90,0,0]) cylinder(d=4, h=6, center=true);
		
		// center Thread
		translate([0,0,-Overlap])
			if ($preview){
				cylinder(d=Thread_d, h=Len+Overlap*2); 
			}else{
				ExternalThread(Pitch=Thread_p, Dia_Nominal=Thread_d+IDXtra*2, 
						Length=Len+Overlap*2, 
						Step_a=2,TrimEnd=true,TrimRoot=true);
			} // if
			
		for (j=[0:nOuterBolts-1]) rotate([0,0,360/nOuterBolts*j])
			translate([0,Outer_BC_d/2,-Overlap]) {
				Thread_d=Thread1024_d;
				Thread_p=25.4/24;
						
				if ($preview){
					cylinder(d=Thread_d, h=Len+Overlap*2); 
				}else{
					ExternalThread(Pitch=Thread_p, Dia_Nominal=Thread_d+IDXtra*2, 
							Length=Len+Overlap*2, 
							Step_a=2,TrimEnd=true,TrimRoot=true);
				}}
	} // difference

} // SustainerMiddleRing

// SustainerMiddleRing();

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
	
	
	EBayMC_Len=MC_Size_Z()+10;
	Alt_Z=EBayMC_Len/2+2;
	Alt_Y=Body_ID/2-15;
	MC_LED_Z=Alt_Z-MC_Size_Z()/2+MC_LED_Z();
	MC_ArmScrew_Z=Alt_Z-MC_Size_Z()/2+MC_ArmingScrew_Z();
	RS_LED_Z=MC_LED_Z-7;
	RS2_LED_Z=MC_ArmScrew_Z-7;
	RailButton_Z=-20;
	Lock_Unlock_Z=133;
	Lock_Unlock_a=-90;
	
	Rivet_Z=108.5;
	
	nDDRivets=3;
	RivetDD_Z=-15;
	RivetDD_a=-11;
	
	Rivet2_Z=-34;
	Rivet2_a=-22;
	
	echo("Top Rivet ",Rivet_Z);
	echo("Alt Sw ",MC_ArmScrew_Z);
	echo("Bottom Rivet ",Rivet2_Z);
	
		
	difference(){
		translate([0,0,RailButton_Z-20]) Tube(OD=OD+3.6, ID=OD, Len=180, myfn=$preview? 90:180);
	
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
		
		
	} // difference
} // EBayMC_Jig

// EBayMC_Jig();
/*
 EBayMC(Light=true, HasRS_Mount=true);
 translate([0,0,-0.1]) rotate([0,0,79]) rotate([180,0,0]) color("Gray") SustainerMiddleRing();
 translate([0,0,-46.7]) rotate([180,0,0]) rotate([0,0,47]) CRBBm_Activator();
/**/

module RocketServoMountVert(Base_h=0){
	RS_PCB_X=15;
	RS_PCB_Z=61;
	RS_PCB_t=1.6;
	Wall_t=1.2;
	
	// Base
	difference(){
		translate([0,1,0]) RoundRect(X=RS_PCB_X+1+Wall_t*2, Y=7, Z=4+Base_h, R=0.5);
		
		translate([0,0,4+Base_h]) cube([RS_PCB_X+IDXtra*2, RS_PCB_t+IDXtra*2, 4], center=true);
	} // difference
	
	translate([0,0,2+45+Base_h]) 
		difference(){
			hull(){
				translate([0,2,2]) RoundRect(X=RS_PCB_X+1+Wall_t*2, Y=4, Z=2, R=0.5);
				translate([0,3,-2]) RoundRect(X=RS_PCB_X+1+Wall_t*2, Y=1.5, Z=1, R=0.5);
			} // hull
			
			translate([0,-2+RS_PCB_t/2,2]) cube([RS_PCB_X+IDXtra*2, 4, 25], center=true);
			
			translate([0,-2+RS_PCB_t/2,2]) cube([RS_PCB_X-2, 8, 25], center=true);
		} //difference
	
	// post
	translate([0,4,0]) RoundRect(X=RS_PCB_X+1+Wall_t*2, Y=3, Z=51+Base_h, R=0.5);
} // RocketServoMountVert

//RocketServoMountVert(Base_h=0);

module EBay_TopPlate(OD=Coupler_OD){
	nOuterBolts=2;
	Outer_BC_d=SecurityRod_BC_d;
	Boss_t=8;
	Thread1024_d=0.190*25.4;
	Activator_a=178;
	
	difference(){
		Tube(OD=OD, ID=OD-4, Len=Boss_t, myfn=$preview? 90:180);
		
		// Rivet hole
		rotate([0,0,101]) translate([0,OD/2,Boss_t/2]) rotate([90,0,0]) cylinder(d=4, h=10, center=true);
	} // difference
	
	difference(){
		if (nOuterBolts>0)
			for (j=[0:nOuterBolts-1]) rotate([0,0,360/nOuterBolts*j])
					hull(){
						translate([0,Outer_BC_d/2,0]) cylinder(d=Thread1024_d+4.4, h=Boss_t);
						translate([0,OD/2-1,0]) scale([1,0.1,1]) cylinder(d=Thread1024_d+6.4, h=Boss_t);
					} // hull
					
		if (nOuterBolts>0)
		for (j=[0:nOuterBolts-1]) rotate([0,0,360/nOuterBolts*j])
			translate([0,Outer_BC_d/2,-Overlap]) {
				Thread_d=Thread1024_d;
				Thread_p=25.4/24;
		
				//translate([0,0,-Overlap])
				//	cylinder(d1=Thread_d+2, d2=Thread_d, h=2);
				
				if ($preview){
					cylinder(d=Thread_d, h=Boss_t+Overlap*2); 
				}else{
					ExternalThread(Pitch=Thread_p, Dia_Nominal=Thread_d+IDXtra*2, 
							Length=Boss_t+Overlap*2, 
							Step_a=2,TrimEnd=true,TrimRoot=true);
				}}
	} // difference
} // EBay_TopPlate

// translate([0,0,EBay_Len-8]) EBay_TopPlate();

module EBay_BasePlate(OD=Coupler_OD, IsLowerPlate=false, HasSecBolts=false, ShockCord_a=-30){
	Plate_t=2;
	Boss_t=8;
	nOuterBolts=2;
	Outer_BC_d=SecurityRod_BC_d;
	LP_OuterBolt_a=22.5;
	Nut_a=IsLowerPlate? 180:0;
	
	Thread1024_d=0.190*25.4;
	
	module ThreadedHole(Chamfer=false){
		Thread_d=Thread1024_d;
		Thread_p=25.4/24;
		
		if (Chamfer)
			cylinder(d1=Thread_d+2, d2=Thread_d, h=2);
			
		if ($preview){
			cylinder(d=Thread_d, h=Boss_t+Overlap*2); 
		}else{
			ExternalThread(Pitch=Thread_p, Dia_Nominal=Thread_d+IDXtra*2, 
					Length=Boss_t+Overlap*2, 
					Step_a=2,TrimEnd=true,TrimRoot=true);
		} // if
	} // ThreadedHole

	difference(){
		union(){
			cylinder(d=OD, h=Plate_t);
			Tube(OD=Coupler_OD, ID=Coupler_ID, Len=Boss_t, myfn=$preview? 90:180);
			
			// Bolt bosses
			if (!IsLowerPlate || HasSecBolts)
				cylinder(d=MotorBolt_d+4.4, h=Boss_t);
			
			if (nOuterBolts>0)
				for (j=[0:nOuterBolts-1]) rotate([0,0,360/nOuterBolts*j])
					translate([0,Outer_BC_d/2,0]) cylinder(d=Thread1024_d+4.4, h=Boss_t);
					
			if (nOuterBolts>0 && (IsLowerPlate || HasSecBolts))
				for (j=[0:nOuterBolts-1]) rotate([0,0,360/nOuterBolts*j+LP_OuterBolt_a])
					translate([0,Outer_BC_d/2,0]) cylinder(d=Thread1024_d+4.4, h=Boss_t);
			
		} // union
		
		// Motor tube hole
		if (IsLowerPlate) translate([0,0,-Overlap]) cylinder(d=33, h=Plate_t+Overlap*2);
			
		// Shock cord
		rotate([0,0,ShockCord_a]) translate([0,Coupler_ID/2-4,-Overlap]) cylinder(d=6, h=Plate_t+Overlap*2);
		
		if (!IsLowerPlate || HasSecBolts)
		translate([0,0,-Overlap]){
			Thread_d=MotorBolt_d;
			Thread_p=MotorBoltPitch;
		
			translate([0,0,-Overlap])
					cylinder(d1=Thread_d+2, d2=Thread_d, h=2);
			if ($preview){
				cylinder(d=Thread_d, h=Boss_t+Overlap*2); 
			}else{
				ExternalThread(Pitch=Thread_p, Dia_Nominal=Thread_d+IDXtra*2, 
						Length=Boss_t+Overlap*2, 
						Step_a=2,TrimEnd=true,TrimRoot=true);
			} // if
		} // translate
	
		if (nOuterBolts>0)
			if (IsLowerPlate){
				for (j=[0:nOuterBolts-1]){
					rotate([0,0,360/nOuterBolts*j+LP_OuterBolt_a]) 
						translate([0,Outer_BC_d/2,-Overlap]) ThreadedHole(Chamfer=true);
						
					rotate([0,0,360/nOuterBolts*j]) 
						translate([0,Outer_BC_d/2,-Overlap]) rotate([0,0,Nut_a]) ThreadedHole();	
				} // for
			}else{
				for (j=[0:nOuterBolts-1]){
					rotate([0,0,360/nOuterBolts*j])
						translate([0,Outer_BC_d/2,-Overlap]) ThreadedHole();
					
					if (HasSecBolts){
						rotate([0,0,360/nOuterBolts*j+LP_OuterBolt_a]) 
							translate([0,Outer_BC_d/2,-Overlap]) rotate([0,0,Nut_a]) ThreadedHole();
					}else{
						rotate([0,0,360/nOuterBolts*j+LP_OuterBolt_a])
							translate([0,Outer_BC_d/2,Plate_t]) Bolt10ClearHole();
					}
				} // for
			} // if

	} // difference
} // EBay_BasePlate

// EBay_BasePlate(IsLowerPlate=true);
// EBay_BasePlate(IsLowerPlate=false);

module MotorTubeTopper(OD=Body_ID, ID=MotorTube_OD, MT_ID=MotorTube_ID){
	Len=20;
	nSpokes=5;
	Spoke_W=2;
	ShockCord_d=2.2;
	myfn=180;
	
	difference(){
		union(){
			// Body
			Tube(OD=OD, ID=OD-2.4, Len=Len, myfn=$preview? 90:myfn);
			// Motor
			Tube(OD=ID+IDXtra*2+2.4, ID=ID+IDXtra*2, Len=Len, myfn=$preview? 90:myfn);
			// Stop
			translate([0,0,Len-2]) Tube(OD=ID+IDXtra+2.4, ID=MT_ID, Len=2, myfn=$preview? 90:myfn);
			
			// spokes
			for(j=[0:nSpokes-1]) rotate([0,0,360/nSpokes*j]) hull(){
				translate([0,(ID+IDXtra+2.4)/2,0]) cylinder(d=Spoke_W, h=Len);
				translate([0,(OD-2.4)/2,0]) cylinder(d=Spoke_W, h=Len);
			} // hull
			
			// rail button 
			intersection(){
				cylinder(d=OD, h=Len);
					
				hull(){
					translate([0,ID/2+IDXtra,Len/2]) rotate([-90,0,0]) cylinder(d=10, h=(OD-ID)/2);
					translate([0,ID/2+IDXtra,2.5]) rotate([-90,0,0]) cylinder(d=5, h=(OD-ID)/2);
					translate([0,ID/2+IDXtra,Len-2.5]) rotate([-90,0,0]) cylinder(d=5, h=(OD-ID)/2);
				} // hull
			} // intersection
		} // union
		
		// Rail button bolt
		translate([0,OD/2+1,Len/2]) rotate([-90,0,0]) Bolt8Hole();
		
	} // difference
} // MotorTubeTopper

// rotate([180,0,0]) MotorTubeTopper(OD=Body_ID, ID=MotorTube_OD, MT_ID=MotorTube_ID-3);

module MotorNutStop(MT_ID=MotorTube_ID, Hole_d=6.35){
	Len=20;
	
	difference(){
		cylinder(d=MT_ID, h=Len);
		
		translate([0,0,-Overlap]) cylinder(d=Hole_d+IDXtra*2, h=Len+Overlap*2);
		translate([0,0,Len-5]) cylinder(d1=Hole_d+IDXtra*2, d2=MT_ID-3, h=5+Overlap);
	} // difference
} // MotorNutStop

// MotorNutStop();

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

module ThreadedForwardClosure(){
	// Top for a standard forward closure with guide cone and 1/4-20 threads
	// Presses onto forward closure
	
	OD=MotorTube_ID-IDXtra*2;
	Len=28;
	InterfaceDepth=11.5;
	Thread_d=Thread25020_d;
	Thread_p=25.4/20;
	
	difference(){
		cylinder(d=OD, h=Len);
		
		translate([0,0,-Overlap]) cylinder(d=25.8, h=InterfaceDepth);
		
		// Guide cone
		translate([0,0,Len-8])
				cylinder(d1=Thread_d, d2=OD-2, h=8+Overlap);
				
		// Threads
		translate([0,0,-Overlap])
			if ($preview){
				cylinder(d=Thread_d, h=Len+Overlap*2); 
			}else{
				ExternalThread(Pitch=Thread_p, Dia_Nominal=Thread_d+IDXtra*2, 
						Length=Len+Overlap*2, 
						Step_a=2,TrimEnd=true,TrimRoot=true);
			}
		
		
	} // difference
} // ThreadedForwardClosure

// ThreadedForwardClosure();

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
		
		translate([0,0,5])
			ServoPlateBoltPattern(20) Bolt4Hole();
	} // difference
} // Custom_ServoPlate

// Custom_ServoPlate();





























