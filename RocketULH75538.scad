// *********************************************
// Project: 3 inch rocket
// Filename: RocketULH75538.scad
// by David M. Flynn
// Created: 2/15/2026
// Revision: 0.9.1   3/1/2026
// Units: mm
// *********************************************
//  ***** Notes *****
//
//  This is a 3 inch diameter rocket, single deploy
//  Uses CableReleaseBBMini, RocketServo and a Mission Control altimeter.
//  Uses two 4323CS springs and petal deployment system (non-pyro).
//  First built Feb, 2026
//
//  ***** History *****
//
// 0.9.1   3/1/2026   ready for first printing
// 0.9.0   2/15/2026  Copied from Rocket6551, stripped down to it's simplest form
//
//  ***** Hardware *****
//
//
//
// *********************************************
//  ***** for STL output *****
// 
// NoseCone();
// R75_PetalHub(OD=Slider_OD, nPetals=nPetals, nBolts=nPetals*2, Skirt_h=1, HasCenterHole=true); // Used with NC_GPS_Mounting_Plate
// R75_NC_GPS_Mounting_Plate(OD=Slider_OD, nBolts=nPetals*2, Skirt_h=5, HasAlTube=true);
// rotate([-90,0,0]) PD_PetalSpringHolder();
// rotate([180,0,0]) PD_Petals(OD=Coupler_OD, Len=Petal_Len, nPetals=nPetals, Wall_t=1.2, AntiClimber_h=4, HasLocks=true, Lock_Span_a=30);
//
//  *** SpringThingInside ***
//
nLockBalls=3;
// 
// STI_ServoMount(Body_ID=Slider_OD);
// STI_LockDisk(Body_ID=Slider_OD, nLockBalls=nLockBalls, Xtra_r=0.2);
// STI_SpringEndTwo(Body_ID=Slider_OD, nLockBalls=nLockBalls, HasPetalLock=true, DualSpring=true);
// rotate([180,0,0]) STI_BallRetainerTop(Body_ID=Slider_OD, nLockBalls=nLockBalls, Xtra_r=0.2);
// STI_BallRetainerBottom(Body_ID=Slider_OD, nLockBalls=nLockBalls, Xtra_r=0.2);
// STI_SpringEndOne(Body_ID=Slider_OD);
// STI_SmallSpringSplice(Body_ID=Slider_OD);
//
// R75_EBayBR(OD=Slider_OD, CenterBolt_d=MotorBolt_d , CenterBolt_p=MotorBoltPitch); // Blue Raven, option not converted to 75mm
// 
// R75_EBayMC(OD=Slider_OD, CenterBolt_d=MotorBolt_d, CenterBolt_p=MotorBoltPitch, HasRS_Mount=true, BaseOnly=true); // Mission Control V3
// rotate([180,0,0]) R75_EBayMCTop(OD=Slider_OD, CenterBolt_d=MotorBolt_d, CenterBolt_p=MotorBoltPitch);
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
// rotate([180,0,0]) R75_MotorTubeTopperTR(OD=Body_ID, ID=MotorTube_OD, MT_ID=MotorTube_ID-3); // alt w/ flange
// R75_MotorNutStop(MT_ID=MotorTube_ID, Hole_d=MotorBolt_d);
//
// rotate([180,0,0]) Fincan(LowerHalfOnly=false, UpperHalfOnly=false);
//
// rotate([0,0,90]) RocketFin(HasSpiralVaseRibs=false, PrinterBrim_H=0.6);
//
// RailButton(OD=11, Flange_h=2, Slot_w=3.8); //3.8 is for BlackSky rail
// RailButton(OD=11, Flange_h=1.6, Slot_w=2.0); //Top?
// RailButton(OD=11, Flange_h=2, Slot_w=2.8);  // for 1010 Rail
//
//  *** Tools ***
//
// PD_PetalHolder(Petal_OD=Body_ID-0.5, Is_Top=false); // bottom half
// PD_PetalHolder(Petal_OD=Body_ID-0.5, Is_Top=true); // top half
// PD_PetalHolderLockLever();
// 
// R75_DeepSocket500(); // 1/2" Socket for 5/16-18 nuts (38mm RMS)
//
// R75_ExtensionAlignmentRing38(); // Align threaded rod to center of 38mm motor tube
// R75_ShortMotorAdaptor(Len=48); // One 38mm grain is 48mm in case length
//
// *********************************************
//  ***** for Viewing *****
//
// Show_STI(Body_ID=Slider_OD, DualSpring=true);
//
// ShowRocket(ShowInternals=false);
// ShowRocket(ShowInternals=true);
//
// *********************************************

include<TubesLib.scad>
use<AT_RMS_Lib.scad>		 echo(AT_RMS_Lib_Rev());
use<SpringEndsLib.scad>      echo(SpringEndsLibRev());
use<PetalDeploymentLib.scad> echo(PetalDeploymentLibRev());
use<Fins.scad>               echo(FinsRev());
use<FinCan2Lib.scad>         echo(FinCan2LibRev());
use<NoseCone.scad>           echo(NoseConeRev());
use<RailGuide.scad>          echo(RailGuideRev());
include<Stager75BBLib.scad>  echo(Stager75BBLib_Rev());
use<SpringThingInside.scad>  echo(SpringThingInsideRev());
use<R75Lib.scad>			 echo(R75Lib_Rev());

// Also included
//include<CommonStuffSAEmm.scad>

$fn=$preview? 36:90;
IDXtra=0.2;
Overlap=0.05;

Bolt4Inset=4;
Bolt10Inset=5.5;

Body_OD=ULineH75Body_OD;
Body_COD=Body_OD*CF_Comp+Vinyl_d;
Body_ID=ULineH75Body_ID;
Slider_OD=Body_ID*CF_Comp-1;

Coupler_OD=BT75Coupler_OD;
Coupler_ID=Coupler_OD-1.8; // thin wall

MotorTube_OD=ULine38Body_OD;
MotorTube_ID=ULine38Body_ID;
MotorBolt_d=5/16*25.4;
MotorBoltPitch=25.4/18;

MotorTubeLen=640;
BodyTubeLen=880;

NC_Len=220;
NC_Base_L=6;
NC_Tip_R=4;
NC_Wall_t=1.0;

nPetals=3;
Petal_Len=180;

nFins=5;
Fin_Post_h=14;
Fin_Root_L=140;
Fin_Root_W=8;
Fin_Tip_W=2.0;
Fin_Tip_L=90;
Fin_Span=90;
Fin_TipOffset=75;
Fin_Chamfer_L=24;
FinInset_Len=5;
Fin_TipBase=10;
FinCan_Len=Fin_Root_L+FinInset_Len*2;
FinCanWall_t=0.8;

Vinyl_d=0.3;
TailCone_Len=30;
TailConeExtra_OD=2;

Thread1024_d=0.190*25.4;
Thread25020_d=0.250*25.4;

module ShowRocket(ShowInternals=false, IsSustainer=false){
	FinCan_Z=TailCone_Len;
	Fin_Z=FinCan_Z+FinCan_Len/2;
	MotorTube_Z=FinCan_Z-TailCone_Len;
	
	BodyTube_Z=FinCan_Z+FinCan_Len+Overlap*2;
	NoseCone_Z=BodyTube_Z+BodyTubeLen+0.1;
	
	STI_Z=NoseCone_Z-Petal_Len-85;
	EBay_Z=STI_Z-127;
	
	echo(str("Overall Length = ",(NoseCone_Z+NC_Len)/25.4));

	translate([0,0,NoseCone_Z]){
		rotate([0,0,90]) color("Orange") NoseCone();
		
		if (ShowInternals)
			translate([0,0,-5]) color("Tan") rotate([180,0,30]) 
				R75_PetalHub(OD=Slider_OD, nPetals=nPetals, nBolts=nPetals*2, Skirt_h=5);
			
		if (ShowInternals){
			translate([0,0,-14.5]) rotate([180,0,30]) 
				PD_Petals(OD=Slider_OD, Len=Petal_Len, nPetals=nPetals, Wall_t=1.6, AntiClimber_h=0, HasLocks=true);
		}
	}
	
	if (ShowInternals) translate([0,0,STI_Z]) rotate([0,0,70]) rotate([180,0,0]) Show_STI(Body_ID=Slider_OD, DualSpring=true);

	if (ShowInternals){
		translate([0,0,EBay_Z]) rotate([0,0,30]) {
			R75_EBayMC(OD=Slider_OD, CenterBolt_d=MotorBolt_d , CenterBolt_p=MotorBoltPitch); 
			R75_EBayMCTop(OD=Slider_OD, CenterBolt_d=MotorBolt_d, CenterBolt_p=MotorBoltPitch);
		}
	}
		
	if (!ShowInternals)
		translate([0,0,BodyTube_Z]) color("LightBlue") 
			Tube(OD=Body_OD, ID=Body_ID, Len=BodyTubeLen-Overlap*2, myfn=$preview? 90:360);
	
	if (ShowInternals)
		translate([0,0,MotorTube_Z]) {
			color("Blue") Tube(OD=MotorTube_OD, ID=MotorTube_ID, Len=MotorTubeLen-Overlap*2, myfn=$preview? 90:360);
			translate([0,0,MotorTubeLen-18]) R75_MotorTubeTopperTR(OD=Body_ID, ID=MotorTube_OD, MT_ID=MotorTube_ID);
			translate([0,0,MotorTubeLen+3]) color("LightGreen") Tube(OD=Coupler_OD, ID=Coupler_OD-2.4, Len=25, myfn=$preview? 90:180); // spacer
		}	
	translate([0,0,FinCan_Z]) color("Orange") Fincan(LowerHalfOnly=false, UpperHalfOnly=false, IsSustainer=IsSustainer);
	
	for (j=[0:nFins-1]) rotate([0,0,360/nFins*j+180/nFins])
		translate([0, Body_OD/2-Fin_Post_h, Fin_Z]) 
			rotate([-90,0,0]) color("Orange") RocketFin(false);
		
} // ShowRocket

// ShowRocket(ShowInternals=false);
// ShowRocket(ShowInternals=true);

module NoseCone(){
	R75_NoseCone(Shoulder_OD=Coupler_OD, OD=Body_OD*CF_Comp+Vinyl_d, nBolts=nPetals*2,
			NC_Len=NC_Len, NC_Base_L=NC_Base_L, NC_Tip_R=NC_Tip_R, NC_Wall_t=NC_Wall_t);
} // NoseCone

// NoseCone();

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



module Fincan(LowerHalfOnly=false, UpperHalfOnly=false, IsSustainer=false){
	Wall_t=FinCanWall_t;
	HasMotorSleeve=false;
	TailConeExtra_OD=0;
		
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
				AftClosure_OD=0, AftClosure_Len=0, IncludeCenteringRings=false);
				
			if (IsSustainer)				
				difference(){
					translate([0,0,-Overlap]) Tube(OD=OD, ID=MotorTubeHole_d, Len=FinInset_Len-1, myfn=$preview? 90:myfn);
						
					translate([0,0,-4-Overlap]) rotate([0,0,90]) Stager_CupHoles(Tube_OD=OD, nLocks=nLocks, BoltsOn=true, Collar_h=0);
				} // difference
			
		} // union

		// Wire path
		if (IsSustainer)
			rotate([0,0,156]) translate([0,OD/2-8,-5]) cylinder(d=5/16*25.4+IDXtra, h=20);
		
	} // difference
} // Fincan

// Fincan(LowerHalfOnly=false, UpperHalfOnly=false, IsSustainer=true);
// Fincan(LowerHalfOnly=false, UpperHalfOnly=false, IsSustainer=false);
// Fincan(LowerHalfOnly=false, UpperHalfOnly=true);
// Fincan(LowerHalfOnly=true, UpperHalfOnly=false);

module BoosterFincan(LowerHalfOnly=false, UpperHalfOnly=false){
	Wall_t=FinCanWall_t;
	HasMotorSleeve=false;
	TailConeExtra_OD=0;
	OD=Body_OD*CF_Comp+Vinyl_d;
		
	echo(str("Body OD w/ Comp = ",Body_OD*CF_Comp+Vinyl_d));
	echo(str("Target OD = ", Body_OD+Vinyl_d));
	
	FC2_FinCanLight(Body_OD=OD, Body_ID=Body_ID*CF_Comp, Can_Len=BFinCan_Len,
				MotorTube_OD=MotorTube_OD, 
				nFins=nFins, HasIntegratedCoupler=true, HasFwdCenteringRing=false, Coupler_Len=10, nCouplerBolts=0,
				HasMotorSleeve=HasMotorSleeve, 
				Fin_Root_W=BFin_Root_W, Fin_Root_L=BFin_Root_L, Fin_Post_h=BFin_Post_h, Fin_Chamfer_L=BFin_Chamfer_L,
				Cone_Len=TailCone_Len, ThreadedTC=false, Extra_OD=TailConeExtra_OD,
				LowerHalfOnly=LowerHalfOnly, UpperHalfOnly=UpperHalfOnly,
				Wall_t=Wall_t,
				AftClosure_OD=0, AftClosure_Len=0, IncludeCenteringRings=false);

		
} // BoosterFincan

// BoosterFincan();

module RocketFin(HasSpiralVaseRibs=true, PrinterBrim_H=0.6){
	TrapFin3(Post_h=Fin_Post_h, Root_L=Fin_Root_L, Tip_L=Fin_Tip_L, Root_W=Fin_Root_W,
				Tip_W=Fin_Tip_W, Span=Fin_Span, Chamfer_L=Fin_Chamfer_L,
				TipOffset=Fin_TipOffset,
				Bisect=false, Bisect_X=0,
				HasSpar=false, Spar_d=8, Spar_L=100, PrinterBrim_H=PrinterBrim_H, HasSpiralVaseRibs=HasSpiralVaseRibs, TipBase=Fin_TipBase);
} // RocketFin

// RocketFin(HasSpiralVaseRibs=false);

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





























