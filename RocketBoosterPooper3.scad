// ***********************************
// Project: 3D Printed Rocket
// Filename: BoosterPooper3.scad
// by David M. Flynn
// Created: 9/3/2022 
// Revision: 0.9.5  5/9/2025
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  Booster Pooper 3 is the 3rd rocket I've built w/ strap-on boosters. 
//  Rocket with 2 strap-on boosters. 
//  Boosters have 38mm motors w/ 54mm body
//  Sustainer has 54mm motor w/ 98mm body
//
//
//  ***** History *****
//
// 0.9.5  5/9/2025  Rework of strap-on boosters begins.
// 0.9.4  9/25/2022 Work on ForwardBoosterLock parts. 
// 0.9.3  9/18/2022 Added some missing parts.
// 0.9.2  9/9/2022  Still working on ForwardBoosterLock
// 0.9.1  9/8/2022  Booster is ready to print, still working on ForwardBoosterLock and parts. 
// 0.9.0  9/3/2022  First code.
//
// ***********************************
//  ***** for STL output *****
//
/*
FairingCone(Fairing_OD=BP_Fairing_OD, 
					FairingWall_T=BP_FairingWall_T,
					NC_Base=5, 
					NC_Len=BP_FairingCone_Len,
					NC_Wall_t=BP_FairingConeWall_T,
					NC_Tip_r=BP_FairingConeTip_r);
/**/

//rotate([0,180,0]) NoseLockRing(Fairing_OD=BP_Fairing_OD, Fairing_ID =BP_Fairing_ID);

/*
// *** >>>Enable override for larger main fairing spring<<< ***

F54_FairingHalf(IsLeftHalf=true, 
				Fairing_OD=BP_Fairing_OD,
				Wall_T=BP_FairingWall_T,
				Len=BP_Fairing_Len,
				HasArmingHole=true);
/**/
// F54_SpringEndCap();
/*
F54_FairingHalf(IsLeftHalf=false, 
				Fairing_OD=BP_Fairing_OD,
				Wall_T=BP_FairingWall_T,
				Len=BP_Fairing_Len,
				HasArmingHole=true);
/**/
/*
rotate([180,0,0])
	FairingBase(BaseXtra=10, Fairing_OD=BP_Fairing_OD, Fairing_ID=BP_Fairing_ID,
					BodyTubeOD=BP_Body_OD, 
					CouplerTube_OD=BP_BobyCoupler_OD, CouplerTube_ID=BP_BobyCoupler_ID);
/**/				
// FairingBaseLockRing(Tube_OD=BP_Fairing_OD, Tube_ID=BP_Fairing_ID, Fairing_ID=BP_Fairing_ID, Interface=-IDXtra);

//	Electronics_Bay();	
//   AltDoor54(Tube_OD=BP_Body_OD);
//   FairingBaseBulkPlate(Tube_ID=BP_Fairing_OD, Fairing_ID=BP_Fairing_ID, ShockCord_a=90);
// 
// 
// ForwardBoosterLock();
// BB_LockingThrustPoint(); // Print 2, bolts into ForwardBoosterLock
// BB_Lock(); // Print 2, Rotating lock
// BB_BearingStop(); // Print 2, Only used with ball bearing
// rotate([180,0,0]) BB_LockShaft(Len=LockShaftLen, nTeeth=nLockShaftTeeth);
// rotate([180,0,0]) ServoGear(nTeeth=nServoGearTeeth);
// rotate([180,0,0]) ServoMount();
//
// BP_Fin();
// rotate([180,0,0]) LowerFinCan();
// UpperFinCan();
//
// ************************************************
//  *** Strap-On Booster Parts ***
// 
BoosterNose_L=90;
BoosterNoseBase_L=13;
BoosterNoseWall_T=1.8;

// BluntOgiveNoseCone(ID=BP_Booster_Body_ID, OD=BP_Booster_Body_OD, L=BoosterNose_L, Base_L=BoosterNoseBase_L, nRivets=3, Tip_R=5, HasThreadedTip=false, Wall_T=BoosterNoseWall_T, Cut_d=0, LowerPortion=false, FillTip=true);

// R54_NC_Base();
// R54_NC_Base_PetalHub();

//
// Booster_E_Bay();
//  AltDoor54(Tube_OD=BP_Booster_Body_OD);
//  FairingBaseBulkPlate(Tube_ID=BP_Booster_Body_ID, Fairing_ID=BP_Booster_Fairing_ID, ShockCord_a=-140);
//  rotate([180,0,0]) TubeEndStackedDoubleBatteryHolder(); // Fits 38mm motor tube
//
// rotate([180,0,0]) BoosterTail();
// BoosterButton();
//
// ***********************************
//  ***** Routines *****
//
// TailCone5438(OD=BP_Booster_Body_OD, ID=BP_Booster_MtrTube_OD, Len=50);
// BoosterThrustRing();
// BB_ThrustPoint();
// BB_LockingThrustPoint();
//
// ***********************************
//  ***** for Viewing *****
//
// ShowBooster();
// ShowBoosterPooper();
//
// ***********************************

include<TubesLib.scad>
use<NoseCone.scad>
use<LD-20MGServoLib.scad>
include<BoosterDropperLib.scad>
use<FinCan2Lib.scad>
use<RailGuide.scad>
use<PetalDeploymentLib.scad>
use<Fins.scad>
use<CableReleaseBB.scad>
use<SpringEndsLib.scad>

//also included
  //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

nFins=4;
nBoosters=2;

BP_Booster_Body_OD=PML54Body_OD;
BP_Booster_Body_ID=PML54Body_ID;
BP_Booster_MtrTube_OD=PML38Body_OD;
BP_Booster_MtrTube_ID=PML38Body_ID;
BP_Booster_MtrRtr_OD=PML38Body_OD+6;



BP_Body_OD=PML98Body_OD;
BP_Body_ID=PML98Body_ID;
BP_BobyCoupler_OD=PML98Coupler_OD;
BP_BobyCoupler_ID=PML98Coupler_ID;
BP_MtrTube_OD=BT54Mtr_OD; //PML54Body_OD;

			
BP_Fairing_OD=5.5*25.4;
BP_Fairing_Len=150;
BP_FairingWall_T=2.2;
BP_Fairing_ID=BP_Fairing_OD-BP_FairingWall_T*2;
BP_FairingConeBase=10;
BP_FairingCone_Len=190;
BP_FairingConeWall_T=2.2; // may need to be thicker
BP_FairingConeTip_r=20;

BP_Booster_FairingWall_T=2.2;
BP_Booster_NC_Base=5;
BP_Booster_NC_Len=90;
BP_Booster_NC_Wall_t=2.2;
BP_Booster_NC_Tip_r=10;

BP_ElectronicsBay_Len=140;
BP_LowerBodyTube_Len=236;
BP_UpperBodyTube_Len=200;


BP_Fin_Post_h=10;
BP_Fin_Root_L=240;
BP_Fin_Root_W=12;
BP_Fin_Tip_W=6;
BP_Fin_Tip_L=100;
BP_Fin_Span=180;
BP_Fin_TipOffset=40;
BP_Fin_Chamfer_L=24;

ThrustRing_h=BoosterButtonMinor_d+6;
BP_EBay_Len=170;
BP_Booster_EBay_Len=120;
BP_BoosterTailConeLen=70;
BP_MtrTubeLen=24*25.4;

BP_BoosterButton1_z=100;
BP_BoosterButtonSpacing=BP_Fin_Root_L+85+BP_LowerBodyTube_Len;
BP_BoosterButton2_z=BP_BoosterButton1_z+BP_BoosterButtonSpacing;

BP_BoosterTubeLen=BP_BoosterButtonSpacing-ThrustRing_h-40;
echo(BP_BoosterTubeLen=BP_BoosterTubeLen);
BP_BoosterMotorTubeLen=BP_BoosterButtonSpacing+ThrustRing_h+BP_BoosterTailConeLen-7;
echo(BP_BoosterMotorTubeLen=BP_BoosterMotorTubeLen);

LockShaftLen=48.0; // Changed -0.5mm 9/11/2022
nLockShaftTeeth=24;
nServoGearTeeth=24;

/*
module BoosterLockPin(){
	LockPin_Len=30;

	CRBB_LockingPin(LockPin_Len=LockPin_Len, GuidePoint=true, IsThreaded=false);
	
} // BoosterLockPin

BoosterLockPin();

module BoosterInnerBearingRetainer(){
	difference(){
		CRBB_InnerBearingRetainer(HasServo=true);
		
		// Shock cord hole
		translate([0,0,-10]) cylinder(d=4.4, h=18);
	} // difference

}

//SE_Spring_CS4323_OD()

CRBB_LockRing(GuidePoint=true);

module Booster_CRBB_TopRetainer(){

	difference(){
		CRBB_TopRetainer(LockRing_d=CRBB_LockRingDiameter(), OD=BP_Booster_Body_ID, HasMountingBolts=false, GuidePoint=true);
		
		// Spring groove
		translate([0,0,13]) difference(){
			cylinder(d=SE_Spring_CS4323_OD(), h=3);
			translate([0,0,-Overlap]) cylinder(d=SE_Spring_CS4323_ID()-1, h=3+Overlap*2);
		} // difference
		
	} // difference

} // Booster_CRBB_TopRetainer

Booster_CRBB_TopRetainer();

translate([0,0,-26]) CRBB_OuterBearingRetainer();
translate([0,0,-26]) BoosterInnerBearingRetainer();
translate([0,0,-26]) CRBB_MagnetBracket();
translate([0,0,-26]) CRBB_TriggerPost(HasOuterPost=false);
/**/

module ShowBooster(){
	//*
	// Booster nosecone
	translate([0,0,BP_BoosterButton2_z+BP_Booster_EBay_Len+ThrustRing_h/2+Fairing_Len+Overlap*3]){
		color("Green") FairingCone(Fairing_OD=BP_Booster_Body_OD, 
					FairingWall_T=BP_Booster_FairingWall_T,
					NC_Base=BP_Booster_NC_Base, 
					NC_Len=BP_Booster_NC_Len,
					NC_Wall_t=BP_Booster_NC_Wall_t,
					NC_Tip_r=BP_Booster_NC_Tip_r);
		color("Tan") NoseLockRing(Fairing_OD=BP_Booster_Body_OD, Fairing_ID =BP_Booster_Fairing_ID);
	}

	// Booster fairing
	translate([0,0,BP_BoosterButton2_z+BP_Booster_EBay_Len+ThrustRing_h/2+Overlap*3]) 
		F54_FairingHalf(IsLeftHalf=true, 
				Fairing_OD=BP_Booster_Body_OD,
				Wall_T=BP_Booster_Fairing_Wall_t,
				Len=BP_Booster_Fairing_Len);
	
	// Booster electronics bay
	translate([0,0,BP_BoosterButton2_z+Overlap*2]) rotate([0,0,-90]) color("Orange") Booster_E_Bay();
	/**/
	
	// Booster body tube
	//*
	color("LightBlue")
	translate([0,0,BP_BoosterButton1_z+ThrustRing_h/2+20+Overlap])
		Tube(OD=BP_Booster_Body_OD, ID=BP_Booster_Body_ID, 
			Len=BP_BoosterTubeLen-Overlap*2, myfn=$preview? 90:360);
	/**/
	// Booster tail
	translate([0,0,BP_BoosterButton1_z]) 
		rotate([0,0,-90]) color("Orange") BoosterTail();
	
	// Booster motor tube
	color("LightBlue")
	translate([0,0,BP_BoosterButton1_z-ThrustRing_h/2-62])
		Tube(OD=BP_Booster_MtrTube_OD, ID=BP_Booster_MtrTube_ID, 
			Len=BP_BoosterMotorTubeLen, myfn=$preview? 90:360);
			
	translate([-BP_Booster_Body_OD/2-BoosterButtonOA_h,0,BP_BoosterButton1_z])
		rotate([0,90,0]) BoosterButton();
	translate([-BP_Booster_Body_OD/2-BoosterButtonOA_h,0,BP_BoosterButton2_z])
		rotate([0,90,0]) BoosterButton();

} // ShowBooster

//ShowBooster();

module ShowBoosterPooper(){
	
	//*
	// Nosecone and Fairing
	translate([0,0,BP_BoosterButton2_z+50+Overlap*2+BP_UpperBodyTube_Len+BP_ElectronicsBay_Len+BP_Fairing_Len+65]){
		FairingCone(Fairing_OD=BP_Fairing_OD, 
					FairingWall_T=BP_FairingWall_T,
					NC_Base=BP_FairingConeBase, 
					NC_Len=BP_FairingCone_Len,
					NC_Wall_t=BP_FairingConeWall_T,
					NC_Tip_r=BP_FairingConeTip_r);
		translate([0,0,-2]) NoseLockRing(Fairing_OD=BP_Fairing_OD, Fairing_ID =BP_Fairing_ID);
	}
	
	translate([0,0,BP_BoosterButton2_z+50+Overlap*2+BP_UpperBodyTube_Len+BP_ElectronicsBay_Len+65])
		F54_FairingHalf(IsLeftHalf=true, 
				Fairing_OD=BP_Fairing_OD,
				Wall_T=BP_FairingWall_T,
				Len=BP_Fairing_Len,
				HasArmingHole=true);
	
	translate([0,0,BP_BoosterButton2_z+50+Overlap*2+BP_UpperBodyTube_Len+BP_ElectronicsBay_Len+55]){
		FairingBase(BaseXtra=10, Fairing_OD=BP_Fairing_OD, Fairing_ID=BP_Fairing_ID,
					BodyTubeOD=BP_Body_OD, 
					CouplerTube_OD=BP_BobyCoupler_OD, CouplerTube_ID=BP_BobyCoupler_ID);
			
		translate([0,0,5])
			FairingBaseLockRing(Tube_ID=BP_Fairing_ID, Fairing_ID=BP_Fairing_ID, Interface=-IDXtra);
	}
	/**/
	
	translate([0,0,BP_BoosterButton2_z+40+BP_UpperBodyTube_Len+Overlap*2]) Electronics_Bay();
	
	//*
	translate([0,0,BP_BoosterButton2_z+50+Overlap*2+Overlap]) color("LightBlue")
		Tube(OD=BP_Body_OD, ID=BP_Body_ID, Len=BP_UpperBodyTube_Len-Overlap*2, myfn=$preview? 36:360);
	/**/
	
	translate([0,0,BP_BoosterButton2_z+Overlap*2]) rotate([0,0,45]) rotate([0,90,0]) BB_LockShaft(Len=LockShaftLen);
	

	
	//*
	translate([0,0,BP_BoosterButton2_z+Overlap*2])
		rotate([0,0,-45]) {
			translate([0,BP_Body_OD/2-BoosterButtonOA_h,0]) rotate([-90,0,0]){
				BB_Lock();
				color("Gray") BB_LockingThrustPoint();
				}
			rotate([0,0,180]) translate([0,BP_Body_OD/2-BoosterButtonOA_h,0]) 
				rotate([-90,0,0]) {
					BB_Lock();
					color("Gray") BB_LockingThrustPoint();
					}
	} /**/
	
	
	translate([0,0,BP_BoosterButton2_z+Overlap*2]) rotate([0,0,-45]) ForwardBoosterLock();
	
	//*
	translate([0,0,BP_BoosterButton1_z+BP_Fin_Root_L+Overlap]) color("LightBlue")
		Tube(OD=BP_Body_OD, ID=BP_Body_ID, Len=BP_LowerBodyTube_Len-Overlap*2, myfn=$preview? 36:360);
	/**/
	
	//*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j])
		translate([BP_Body_OD/2-BP_Fin_Post_h,0,BP_Fin_Root_L/2+50]) 
			rotate([0,90,0]) color("Yellow") BP_Fin();
	/**/
	
	/*  // Motor Tube
	translate([0,0,17]) color("Blue") Tube(OD=BP_MtrTube_OD, ID=54, 
			Len=BP_MtrTubeLen, myfn=$preview? 90:360);
	/**/
	 
	translate([0,0,BP_Fin_Root_L+100+Overlap]) color("White") UpperFinCan();
		color("LightGreen") LowerFinCan();
	
	// Boosters 
	//*
	rotate([0,0,45]) translate([BP_Booster_Body_OD/2+BP_Body_OD/2,0,0]) ShowBooster();
	rotate([0,0,45+180]) translate([BP_Booster_Body_OD/2+BP_Body_OD/2,0,0]) ShowBooster();
	/**/
		
} // ShowBoosterPooper

//ShowBoosterPooper();

module R54_NC_Base(Body_OD=BP_Booster_Body_OD, Body_ID=BP_Booster_Body_ID, NC_Base_L=BoosterNoseBase_L, Coupler_OD=BP_Booster_Body_ID-0.5){
	nBolts=4;
	
	difference(){
		union(){
			NC_ShockcordRing54(Body_OD=Body_OD, Body_ID=Body_ID, NC_Base_L=NC_Base_L, nRopes=0, nBolts=0);
			
			translate([0,0,-3]) cylinder(d=Body_OD, h=3, $fn=$preview? 90:360);
		} // union
		
		translate([0,0,-20]) cylinder(d=Body_OD+1, h=17);
		translate([0,0,-3-Overlap]) hull(){
			translate([-8,0,0]) cylinder(d=19, h=6);
			translate([8,0,0]) cylinder(d=19, h=6);
		} // hull
		
		//rotate([0,0,20]) 
		translate([0,0,-3]) PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=nBolts) rotate([180,0,0]) Bolt4Hole();
		
		hull(){
			translate([0,-10,-3]) cylinder(d=6,h=6);
			translate([0,-20,-3]) cylinder(d=6,h=6);
		} // hull
	} // difference
} // R54_NC_Base

// R54_NC_Base();

module R54_NC_Base_PetalHub(Body_OD=BP_Booster_Body_OD, Body_ID=BP_Booster_Body_ID, Coupler_OD=BP_Booster_Body_ID-0.5){
	ShockCord_a=90;
	
	PD_PetalHub(OD=Coupler_OD, 
					nPetals=2, 
					HasBolts=true,
					nBolts=4,
					ShockCord_a=ShockCord_a,
					HasNCSkirt=false, 
						Body_OD=Body_OD,
						Body_ID=Body_ID,
						NC_Base=0, 
						SkirtLen=10);
						
} // R54_NC_Base_PetalHub

// translate([0,0,-3]) rotate([180,0,90]) R54_NC_Base_PetalHub();

module Electronics_Bay(){
	// Z=0 center of Booster button
	TopOfTube=BP_EBay_Len+ThrustRing_h/2;
	CablePullerInset=-1;
	CP_a=0;
	CP_z=-40;
	
	CT_z=30;
		
	translate([0,0,30]) rotate([0,0,180]) DoubleBatteryHolder(Tube_ID=BP_Body_ID);
	
	difference(){
		translate([0,0,TopOfTube-CT_z]) cylinder(d=BP_Body_ID+1, h=3+Overlap);
		translate([0,0,TopOfTube-CT_z-Overlap]) 
				cylinder(d2=BP_Body_ID-4.2, d1=BP_Body_ID, h=3+Overlap*3, $fn=$preview? 90:360);
	} // difference
	
	difference(){
		translate([0,0,CT_z]) cylinder(d=BP_Body_ID+1, h=3+Overlap);
		translate([0,0,CT_z-Overlap]) 
				cylinder(d1=BP_Body_ID-4.2, d2=BP_Body_ID, h=3+Overlap*3, $fn=$preview? 90:360);
	} // difference
	
	// Standard E-Bay module
	difference(){
		translate([0,0,ThrustRing_h/2-Overlap]) rotate([0,0,90])
			AltBay54(Tube_OD=BP_Body_OD, Tube_ID=BP_Body_ID, Tube_Len=BP_EBay_Len);
		
		// Cable Puller Bolt Holes
		translate([0,0,TopOfTube+CP_z]) rotate([0,90,180]) 
			translate([0,0,BP_Body_ID/2-CablePullerInset]) 
				rotate([CP_a,0,0]) CablePullerBoltPattern() Bolt4Hole();
	} // difference
		
	
	translate([0,0,TopOfTube+CP_z]) rotate([0,90,180]) 
	difference(){
		// Cable Puller Bolt Bosses
		translate([0,0,BP_Body_ID/2-CablePullerInset]) 
			rotate([CP_a,0,0]) CablePullerBoltPattern() 
				hull(){
					rotate([180,0,0]) cylinder(d=8, h=8);
					translate([12,0,0]) rotate([180,0,0]) cylinder(d=3, h=Overlap);
				} // hull
		
		// Cable Puller Bolt Holes
		translate([0,0,BP_Body_ID/2-CablePullerInset]) 
			rotate([CP_a,0,0]) CablePullerBoltPattern() Bolt4Hole();
		
		// Conform to OD of E-Bay
		rotate([0,90,0]) translate([0,0,-10])
		difference(){
			cylinder(d=BP_Body_ID+20, h=100);
			translate([0,0,-Overlap]) cylinder(d=BP_Body_ID+1, h=100+Overlap*2);
		} // difference
	} // difference
} // Electronics_Bay

//Electronics_Bay();
// Retrofit Battery holder
//DoubleBatteryHolder(Tube_ID=BP_Body_ID);

module Booster_E_Bay(){
	// Z=0 center of Booster button
	TopOfTube=BP_Booster_EBay_Len+ThrustRing_h/2;
	CablePullerInset=-1;
	CP_a=-5;
	
	// The Fairing clamps onto this. 
	translate([0,0,TopOfTube-4.5]) 
		FairingBaseLockRing(Tube_ID=BP_Booster_Body_ID, 
		Fairing_ID=BP_Booster_Fairing_ID, Interface=Overlap);
	
	difference(){
		translate([0,0,TopOfTube-7]) cylinder(d=BP_Booster_Body_ID+1, h=3+Overlap);
		translate([0,0,TopOfTube-7-Overlap]) 
				cylinder(d2=BP_Booster_Body_ID-4.2, d1=BP_Booster_Body_ID, h=3+Overlap*3, $fn=$preview? 90:360);
	} // difference
	
	// Standard E-Bay module
	difference(){
		translate([0,0,ThrustRing_h/2-Overlap]) rotate([0,0,90])
			AltBay54(Tube_OD=BP_Booster_Body_OD, Tube_ID=BP_Booster_Body_ID, Tube_Len=BP_Booster_EBay_Len);
		
		// Cable Puller Bolt Holes
		translate([0,0,TopOfTube-12]) rotate([0,90,135]) 
			translate([0,0,BP_Booster_Body_ID/2-CablePullerInset]) 
				rotate([CP_a,0,0]) CablePullerBoltPattern() Bolt4Hole();
	} // difference
		
	// Upper Thrust Point, The motor tube stops here. 
	translate([0,0,-ThrustRing_h/2])
		BoosterThrustRing(MtrTube_OD=BP_Booster_MtrTube_OD, BodyTube_OD=BP_Booster_Body_OD);
	
	// Lower Coupler Tube Socket
	translate([0,0,-ThrustRing_h/2-20])
		Tube(OD=BP_Booster_Body_OD, ID=BP_Booster_Body_ID, 
			Len=20+Overlap, myfn=$preview? 90:360);
	
	// Shock code path, keep it out of the way. 
	
	rotate([0,0,10])
	difference(){
		Y1=30;
		Y2=65;
		Y3=110;
		H=6;
		
		union(){
			translate([0,-BP_Booster_Body_OD/2+4.4,Y1]) 
				ShockCordHole(X=NylonTube9_w+4.4, Y=NylonTube9_h+4.4, Len=H);
			translate([0,-BP_Booster_Body_OD/2+4.4,Y2]) 
				ShockCordHole(X=NylonTube9_w+4.4, Y=NylonTube9_h+4.4, Len=H);
			translate([0,-BP_Booster_Body_OD/2+4.4,Y3]) 
				ShockCordHole(X=NylonTube9_w+4.4, Y=NylonTube9_h+4.4, Len=H);
		}// union
		
		translate([0,-BP_Booster_Body_OD/2+4.4,Y1-Overlap]) 
			ShockCordHole(X=NylonTube9_w, Y=NylonTube9_h, Len=H+Overlap*2);
		
		translate([0,-BP_Booster_Body_OD/2+4.4,Y2-Overlap]) 
			ShockCordHole(X=NylonTube9_w, Y=NylonTube9_h, Len=H+Overlap*2);
		
		translate([0,-BP_Booster_Body_OD/2+4.4,Y3-Overlap]) 
			ShockCordHole(X=NylonTube9_w, Y=NylonTube9_h, Len=H+Overlap*2);
		
		// Conform to OD of E-Bay
		
		difference(){
			cylinder(d=BP_Booster_Body_ID+20, h=200);
			translate([0,0,-Overlap]) cylinder(d=BP_Booster_Body_ID+1, h=200+Overlap*2);
		} // difference
	} // difference
	
	translate([0,0,TopOfTube-12]) rotate([0,90,135]) 
	difference(){
		// Cable Puller Bolt Bosses
		translate([0,0,BP_Booster_Body_ID/2-CablePullerInset]) 
			rotate([CP_a,0,0]) CablePullerBoltPattern() 
				hull(){
					rotate([180,0,0]) cylinder(d=8, h=8);
					translate([12,0,0]) rotate([180,0,0]) cylinder(d=3, h=Overlap);
				} // hull
		
		// Cable Puller Bolt Holes
		translate([0,0,BP_Booster_Body_ID/2-CablePullerInset]) 
			rotate([CP_a,0,0]) CablePullerBoltPattern() Bolt4Hole();
		
		// Conform to OD of E-Bay
		rotate([0,90,0]) translate([0,0,-10])
		difference(){
			cylinder(d=BP_Booster_Body_ID+20, h=100);
			translate([0,0,-Overlap]) cylinder(d=BP_Booster_Body_ID+1, h=100+Overlap*2);
		} // difference
	} // difference
} // Booster_E_Bay

//Booster_E_Bay();
//AltDoor54(Tube_OD=BP_Booster_Body_OD);
//translate([0,0,BP_Booster_EBay_Len+ThrustRing_h/2-12]) rotate([0,90,135]) translate([0,0,BP_Booster_Body_ID/2+1]) 
	//		rotate([-5,0,0]) translate([0,0,-20]) CR_Cage();

module TailCone5438(OD=BP_Booster_Body_OD, ID=BP_Booster_MtrTube_OD, Len=50){
	TC_d=(OD-ID)/2;
	TC_h=TC_d*1.7;
	MtrRetainer_OD=BP_Booster_MtrRtr_OD;
	MtrRetainer_L=16;
	MtrRetainer_Inset=5;
	
	difference(){
		hull(){
			translate([0,0,Len-Overlap]) cylinder(d=OD, h=Overlap, $fn=$preview? 90:360);
			translate([0,0,TC_h]) rotate_extrude($fn=$preview? 90:360) translate([OD/2-TC_d/2,0,0]) circle(d=TC_d, $fn=$preview? 36:90);
			cylinder(d=ID, h=Overlap, $fn=$preview? 90:360);
		} // hull
		
		translate([0,0,-Overlap]) cylinder(d=ID+IDXtra*3, h=Len+Overlap*2, $fn=$preview? 90:360);
		translate([0,0,-Overlap]) cylinder(d=MtrRetainer_OD+IDXtra*2, h=MtrRetainer_L+MtrRetainer_Inset+Overlap*2, $fn=$preview? 90:360);
		cylinder(d=OD, h=MtrRetainer_Inset);
	} // difference
	
} // TailCone

//TailCone5438();

module BoosterTail(){
	// Z=0 : center of thrust ring
	TC_Len=BP_BoosterTailConeLen;
	
	translate([0,0,ThrustRing_h/2-Overlap]) 
		Tube(OD=PML54Body_OD, ID=PML54Body_ID, Len=20, myfn=$preview? 90:360);
	translate([0,0, -ThrustRing_h/2]) 
		BoosterThrustRing(MtrTube_OD=BP_Booster_MtrTube_OD, BodyTube_OD=BP_Booster_Body_OD);
	translate([0,0,-ThrustRing_h/2+Overlap-TC_Len]) TailCone5438(Len=TC_Len);
} // BoosterTail

//rotate([0,0,45]) translate([BP_Booster_Body_OD/2+BP_Body_OD/2,0,100]) rotate([0,0,-90]) BoosterTail();

module ServoMountAdaptor(){
	G_a=22.5;
	CentralCavity_Y=58;
	CentralCavity2_Y=44;
	Bottom_Z=-85;
	OAL_Z=135;
	ServoMount_Y=-8;
	
	difference(){
		// Servo bolt bosses
			rotate([0,G_a,0]) translate([0,ServoMount_Y,24*300/180]) rotate([0,-G_a,0]) 
				 rotate([0,90,90]) hull() ServoMountHolePattern() {
					 translate([0,0,0.9]) rotate([180,0,0]) cylinder(d=10,h=1);
					 translate([0,0,-6]) sphere(d=10);
				 }
				 
		// Servo
		rotate([0,G_a,0]) translate([0,ServoMount_Y,24*300/180]) rotate([0,90-G_a,0]) 
			rotate([-90,0,0]) Servo_HX5010(BottomMount=false,TopAccess=false,Xtra_w=1.2, Xtra_h=1);
				 
		difference(){
			translate([0,0,Bottom_Z+20]) cylinder(d=BP_Body_OD-1, h=OAL_Z-40, $fn=$preview? 90:360);
			
		
			translate([-BP_Body_OD/2,-CentralCavity2_Y/2,Bottom_Z-Overlap]) 
				cube([BP_Body_OD,CentralCavity2_Y,OAL_Z+Overlap*2]);
			
			
		} // difference
				 
		// Servo mounting bolts
		rotate([0,G_a,0]) translate([0,ServoMount_Y,24*300/180]) rotate([0,-G_a,0]) 
				rotate([0,90,90]) ServoMountHolePattern() translate([0,0,2]) Bolt4Hole();
	} // difference
} // ServoMountAdaptor

//rotate([180,0,0]) ServoMountAdaptor();

module ForwardBoosterLock(){
	// Z=0, BoosterButton center line
	Bottom_Z=-85;
	OAL_Z=135;
	CentralCavity_Y=58;
	CentralCavity2_Y=44;
	ServoMount_Y=-8;
	
	module BD_Holes(){
		translate([0,BP_Body_OD/2-BoosterButtonOA_h,0]) rotate([-90,0,0]) BB_LTP_Hole();
		rotate([0,0,180]) translate([0,BP_Body_OD/2-BoosterButtonOA_h,0]) rotate([-90,0,0]) BB_LTP_Hole();
		
		// d=33 Ball Bearing OD - 4
		rotate([-90,0,0]) cylinder(d=33, h=BP_Body_OD, center=true);
	} // BD_Holes
	
	
	rotate([-90,0,0]) rotate([0,0,90]) BB_LockStop(Len=50, Extra_H=4);
	
	//*
	difference(){
		translate([0,0,Bottom_Z]) Tube(OD=BP_Body_OD, ID=BP_Body_ID, Len=OAL_Z, myfn=$preview? 36:360);
		BD_Holes();
	} // difference
	/**/
	
	difference(){
		union(){
			translate([0,0,-40]) 
				RailButtonPost(OD=BP_Body_OD, MtrTube_OD=BP_MtrTube_OD, H=5.5*25.4/2);
			translate([0,0,-40-25]) rotate([0,0,30]) 
				CenteringRing(OD=BP_Body_OD-1, ID=BP_MtrTube_OD+IDXtra*3, Thickness=5, nHoles=6);
			translate([0,0,-40+20])  rotate([0,0,30]) 
				CenteringRing(OD=BP_Body_OD-1, ID=BP_MtrTube_OD+IDXtra*3, Thickness=5, nHoles=6);
		} // union
		
		BD_Holes();
	} // difference
	
	difference(){
		G_a=22.5;
		
		union(){
			translate([0,0,Bottom_Z+20]) cylinder(d=BP_Body_OD-1, h=OAL_Z-40, $fn=$preview? 90:360);
			
			// Servo bolt bosses
			rotate([0,G_a,0]) translate([0,ServoMount_Y,24*300/180]) rotate([0,-G_a,0]) 
				 rotate([0,90,90]) hull() ServoMountHolePattern() {
					 translate([0,0,0.9]) rotate([180,0,0]) cylinder(d=10,h=1);
					 translate([0,0,-6]) sphere(d=10);
				 }
		} // union
			
		// Servo mounting bolts
		rotate([0,G_a,0]) translate([0,ServoMount_Y,24*300/180]) rotate([0,-G_a,0]) 
				rotate([0,90,90]) ServoMountHolePattern() translate([0,0,2]) Bolt4Hole();
		
		// Clean up base below centering ring
		translate([0,0,Bottom_Z+15-Overlap]) cylinder(d1=BP_Body_OD, d2=BP_Body_OD-50, h=25);
		difference(){
			translate([-BP_Body_OD/2,-CentralCavity2_Y/2,Bottom_Z-Overlap]) 
				cube([BP_Body_OD,CentralCavity2_Y,OAL_Z+Overlap*2]);
			
			// Servo bolt bosses
			rotate([0,G_a,0]) translate([0,ServoMount_Y,24*300/180]) rotate([0,-G_a,0]) 
				 rotate([0,90,90]) hull() ServoMountHolePattern() {
					 translate([0,0,2]) rotate([180,0,0]) cylinder(d=10,h=1);
					 translate([0,0,-6]) sphere(d=10);
				 }
		} // difference
		
		// Servo
		rotate([0,G_a,0]) translate([0,ServoMount_Y,24*300/180]) rotate([0,90-G_a,0]) 
			rotate([-90,0,0]) Servo_HX5010(BottomMount=false,TopAccess=false,Xtra_w=1.2, Xtra_h=1);
		// Servo wires
		translate([16,ServoMount_Y-8,25]) hull(){
			rotate([90,0,0]) cylinder(d=6, h=18);
			translate([0,0,5]) rotate([90,0,0]) cylinder(d=6, h=18);
		} // hull
		
		
		/*
		translate([0,0,27]) cylinder(d1=CentralCavity2_Y, d2=BP_Body_OD-2, h=8+Overlap);
		hull(){
			translate([-BP_Body_OD/2,-CentralCavity_Y/2,Bottom_Z-Overlap])
				cube([BP_Body_OD,CentralCavity_Y,45]);
			translate([-BP_Body_OD/2,-CentralCavity2_Y/2,Bottom_Z+45+CentralCavity_Y-CentralCavity2_Y])
				cube([BP_Body_OD,CentralCavity2_Y,Overlap]);
		} // hull
		/**/
		BD_Holes();
	} // difference
	
	
} // ForwardBoosterLock

//G_a=22.5;
//ForwardBoosterLock();

//translate([0,0,0]) rotate([-90,0,0]) BB_LockShaft(Len=LockShaftLen);
//rotate([0,G_a,0]) translate([0,11,24*300/180]) rotate([-90,0,0]) 
//rotate([0,0,180/24]) 
//BB_Gear();

module ServoMountHolePattern(){
	Tray_W=30;
	MountFace_X=6;
	MountFace_H=28;
	
	translate([MountFace_X,-Tray_W/2,-MountFace_H+4]) rotate([0,-90,0]) children();
	translate([MountFace_X,Tray_W/2,-MountFace_H+4]) rotate([0,-90,0]) children();
	translate([MountFace_X,-Tray_W/2,-MountFace_H+12]) rotate([0,-90,0]) children();
	translate([MountFace_X,Tray_W/2,-MountFace_H+12]) rotate([0,-90,0]) children();
} // ServoMountHolePattern


module ServoMount(){
	Tray_L=57;
	Tray_W=30;
	Tray_H=8;
	TrayOffset_X=-38+Tray_L/2;
	MountFace_X=6;
	MountFace_H=28;
	
	difference(){
		union(){
			//translate([TrayOffset_X,-Tray_W/2,-Tray_H]) cube([Tray_L,Tray_W,Tray_H]);
			translate([TrayOffset_X,0,-Tray_H]) 
			RoundRect(X=Tray_L, Y=Tray_W, Z=Tray_H, R=8);
			
			hull(){
				translate([MountFace_X-3,-Tray_W/2,-MountFace_H]) cube([3,Tray_W,MountFace_H-2]);
				translate([-20,-Tray_W/2,-Tray_H]) cube([Overlap,Tray_W,Tray_H-2]);
				
				ServoMountHolePattern() cylinder(d=8,h=6);
				
			} // hull
		} // union
		
		Servo_HX5010(BottomMount=false,TopAccess=false,Xtra_w=1.2, Xtra_h=1);
		
		ServoMountHolePattern() translate([0,0,8]) Bolt4HeadHole(lHead=20);
		
		// Wire path
		translate([-TrayOffset_X+1,0,-Tray_H-Overlap]) cylinder(d=6, h=Tray_H+Overlap*2);
	} // difference
} // ServoMount

//ServoMount();
/*
G_a=22.5;
ForwardBoosterLock();
translate([0,0,Overlap])
rotate([0,G_a,0]) translate([0,-8,24*300/180]) rotate([0,-G_a,0]) 
rotate([0,90,90]) ServoMount();
/**/


module UpperFinCan(){
	// Upper Half of Fin Can
	
	rotate([180,0,0]) 
		FinCan3(Tube_OD=BP_Body_OD, Tube_ID=BP_Body_ID, MtrTube_OD=BP_MtrTube_OD, nFins=nFins,
			Post_h=BP_Fin_Post_h, Root_L=BP_Fin_Root_L, Root_W=BP_Fin_Root_W, 
			Chamfer_L=BP_Fin_Chamfer_L, HasTailCone=false); 

} // UpperFinCan

//UpperFinCan();

module LowerFinCan(){
	
	
	for (j=[0:nBoosters-1])
		rotate([0,0,360/nBoosters*j-180/nFins]) 
		translate([0,BP_Body_OD/2-BoosterButtonOA_h,BP_BoosterButton1_z]) 
		rotate([-90,0,0]) BB_ThrustPoint(BodyTube_OD=BP_Body_OD, BoosterBody_OD=BP_MtrTube_OD);

	difference(){
		union(){
			translate([0,0,BP_BoosterButton1_z+BoosterButtonMajor_d/2+1]) 
				CenteringRing(OD=BP_Body_OD-1, ID=BP_MtrTube_OD+IDXtra*2, Thickness=5);
			translate([0,0,BP_BoosterButton1_z-BoosterButtonMajor_d*2.5-5]) 
				CenteringRing(OD=BP_Body_OD-1, ID=BP_MtrTube_OD+IDXtra*2, Thickness=5);
		} // union
		
		translate([0,0,50]) TrapFin2Slots(Tube_OD=BP_Body_OD, nFins=nFins, 	
			Post_h=BP_Fin_Post_h, Root_L=BP_Fin_Root_L, Root_W=BP_Fin_Root_W, Chamfer_L=BP_Fin_Chamfer_L);
	} // difference

	difference(){
		FinCan3(Tube_OD=BP_Body_OD, Tube_ID=BP_Body_ID, MtrTube_OD=BP_MtrTube_OD, nFins=nFins, 
			Post_h=BP_Fin_Post_h, Root_L=BP_Fin_Root_L, Root_W=BP_Fin_Root_W, 
			Chamfer_L=BP_Fin_Chamfer_L, HasTailCone=true); // Lower Half of Fin Can
		
		for (j=[0:nBoosters-1])
			rotate([0,0,360/nBoosters*j-180/nFins]) translate([0,BP_Body_OD/2-BoosterButtonOA_h,
					BP_BoosterButton1_z]) rotate([-90,0,0]) BB_ThrustPoint_Hole();
	} // difference

	translate([0,0,60]) rotate([0,0,-180/nFins]) 
			RailButtonPost(OD=BP_Body_OD, MtrTube_OD=BP_MtrTube_OD, H=5.5*25.4/2);

} // LowerFinCan

// LowerFinCan();


module BP_Fin(){
	
	TrapFin2(Post_h=10, Root_L=BP_Fin_Root_L, Tip_L=BP_Fin_Tip_L, 
			Root_W=BP_Fin_Root_W, Tip_W=BP_Fin_Tip_W, 
			Span=BP_Fin_Span, Chamfer_L=BP_Fin_Chamfer_L, TipOffset=BP_Fin_TipOffset, 
			Bisect=false, Bisect_X=0);
	
	if ($preview==false){
		translate([-BP_Fin_Root_L/2+10,0,0]) cylinder(d=BP_Fin_Root_W*2.5, h=0.9); // Neg
		translate([BP_Fin_Root_L/2-10,0,0]) cylinder(d=BP_Fin_Root_W*2.5, h=0.9); // Pos
	}
} // BP_Fin

//BP_Fin();



























