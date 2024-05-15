// ***********************************
// Project: 3D Printed Rocket
// Filename: Rocket1379852.scad
// by David M. Flynn
// Created: 5/13/2024
// Revision: 0.9.1  5/14/2024
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  137mm (5.5 inch) Body 5 Fin Booster
//  98mm (4 inch) Body 5 Fin Sustainer
//  Two Stage Rocket.
//
//  Sustainer Motor K270W-P RMS 54/2560
//  Booster motor K1000T-P RMS 75/2560
//
//  ***** History *****
//
// 0.9.1  5/14/2024 Ready to begin printing.
// 0.9.0  5/13/2024 First code, copied some stuff from Rocket13732.scad
//
// ***********************************
//  ***** for STL output *****
//
// *** Nosecode ***
//
// BluntOgiveNoseCone(ID=S_Coupler_OD, OD=S_Body_OD, L=NC_Len, Base_L=NC_Base_L, Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=0, LowerPortion=false);
// NC_ShockcordRingDual(Tube_OD=S_Body_OD, Tube_ID=S_Body_ID, NC_Base_L=NC_Base_L, nRivets=3);
//
CouplerLenXtra=-10;
B_CouplerLenXtra=0;
//
// *** Dual Deploy Electronics Bay ***
//
// SE_SlidingSpringMiddle(OD=S_Coupler_OD, nRopes=6, SliderLen=30, SpLen=40, SpringStop_Z=20);
//
// PD_NC_PetalHub(OD=S_Coupler_OD, nPetals=nPetals, nRopes=6);
// rotate([-90,0,0]) PD_PetalSpringHolder(Coupler_OD=S_Coupler_OD); // print 6
// rotate([180,0,0]) PD_Petals(OD=S_Coupler_OD, Len=ForwardPetalLen, nPetals=nPetals, AntiClimber_h=4);
//
// EB_Electronics_Bay(Tube_OD=S_Body_OD, Tube_ID=S_Body_ID, Len=EBay_Len, nBolts=3, BoltInset=7.5, ShowDoors=false, HasSecondBattDoor=true);
//
// *** Doors ***
//
// rotate([-90,0,0]) AltDoor54(Tube_OD=S_Body_OD, IsLoProfile=false, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowAlt=true);
// 
// rotate([-90,0,0]) Batt_Door(Tube_OD=S_Body_OD, InnerTube_OD=0, HasSwitch=true);
// rotate([-90,0,0]) Batt_Door(Tube_OD=S_Body_OD, InnerTube_OD=0, HasSwitch=false);
//
// *** Ball Lock ***
//
// STB_LockDisk(BallPerimeter_d=S_Body_OD, nLockBalls=S_nLockBalls);
// rotate([180,0,0]) R98C_BallRetainerTop(Body_OD=S_Body_OD, Body_ID=S_Body_ID);
// R98_BallRetainerBottom(Body_OD=S_Body_OD, Body_ID=S_Body_ID);
// rotate([180,0,0]) STB_TubeEnd(BallPerimeter_d=S_Body_OD, nLockBalls=S_nLockBalls, Body_OD=S_Body_OD, Body_ID=S_Body_ID, Skirt_Len=20);
//
// *** petal deployer ***
//
// PD_PetalHub(OD=S_Coupler_OD, nPetals=nPetals, ShockCord_a=PD_ShockCordAngle());
// rotate([-90,0,0]) PD_PetalSpringHolder(OD=S_Coupler_OD);
// rotate([180,0,0]) PD_Petals(OD=S_Coupler_OD, Len=AftPetalLen, nPetals=nPetals, AntiClimber_h=3);
//
// rotate([180,0,0]) SE_SpringEndTypeA(Coupler_OD=S_Coupler_OD, Coupler_ID=S_Coupler_ID, nRopes=6, Spring_OD=SE_Spring_CS4323_OD());
// SE_SlidingSpringMiddle(OD=S_Coupler_OD, nRopes=6, SliderLen=40, SpLen=40, SpringStop_Z=20);
// R98C_MotorTubeTopper();
//
// rotate([180,0,0]) EB_LowerElectronics_Bay(Tube_OD=S_Body_OD, Tube_ID=S_Body_ID, Len=EBay_Len, nBolts=5, BoltInset=7.5, ShowDoors=false);
//
// rotate([180,0,0]) SustainerFinCan();
//
//
// rotate([180,0,0]) SustainerCup(Offset_a=7.5);
// rotate([-90,0,0]) Stager_LockRod(Adj=0);
//
// =============================================
//  *** Booster ***
//
// Stager_Saucer(Tube_OD=S_Body_OD, nLocks=3, HasElectrical=false); // Bolts on
// InterStageTransition();
// Stager_LockRing(Tube_OD=S_Body_OD, nLocks=3, FlexComp_d=0.8); 
// Stager_InnerRace(Tube_OD=S_Body_OD);
// Stager_BallSpacer(Tube_OD=S_Body_OD);
// Stager_CableRedirectTop(Tube_OD=S_Body_OD, Skirt_ID=S_Body_ID, InnerTube_OD=S_MotorTube_OD, HasRaceway=false, Raceway_a=270);
// Stager_CableBearing();
// Booster_Stager_CableRedirect();
// Stager_CableEndAndStop(Tube_OD=S_Body_OD, Xtra3=false);
// Stager_Detent(Tube_OD=S_Body_OD);
//
// Booster_Electronics_Bay(ShowDoors=false);
//
// *** Doors ***
//
// rotate([-90,0,0]) AltDoor54(Tube_OD=B_Body_OD, IsLoProfile=false, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowAlt=true);
// 
// rotate([-90,0,0]) Batt_Door(Tube_OD=B_Body_OD, InnerTube_OD=0, HasSwitch=true);
// rotate([-90,0,0]) Batt_Door(Tube_OD=B_Body_OD, InnerTube_OD=0, HasSwitch=false);
//
// rotate([-90,0,0]) CP_Door(Tube_OD=B_Body_OD, BoltBossInset=3, HasArmingSlot=true);
//
// =======================
//  *** Cable Puller ***
//
// BoltInServoMount();
// ThroughOut();
// rotate([0,90,0]) SpringBody();
// CableRetainer();
// StopAdjuster();
// CageBottom();
/*
	rotate([180,0,0]){ 
		CageTop();
		BellCrankTriggerBearingHolder();}
/**/
// rotate([180,0,0]) TriggerBellCrank();
//
// -------------------------
// *** Ball Lock Unit ***
//
// STB_LockDisk(BallPerimeter_d=BT137BallPerimeter_d, nLockBalls=nBT137Balls, HasLargeInnerBearing=true);
/*
	rotate([180,0,0]) STB_BallRetainerTop(BallPerimeter_d=BT137BallPerimeter_d, Outer_OD=B_Body_OD, Body_OD=B_Body_ID, nLockBalls=nBT137Balls, 
							IntegratedCouplerLenXtra=B_CouplerLenXtra, HasIntegratedCouplerTube=true, Body_ID=B_Body_ID, 
							HasSecondServo=true, UsesBigServo=true, Engagement_Len=25, HasLargeInnerBearing=true);
/**/
// Booster_BallRetainerBottom();
// rotate([180,0,0]) STB_TubeEnd(BallPerimeter_d=BT137BallPerimeter_d, nLockBalls=nBT137Balls, Body_OD=B_Body_OD, Body_ID=B_Body_ID, Skirt_Len=25);
//
// ---------------------------
//
// Booster_PetalHub();
// rotate([-90,0,0]) PD_PetalSpringHolder(OD=B_Coupler_OD);
// rotate([180,0,0]) PD_GridPetals(OD=B_Coupler_OD, Len=150, nPetals=3, Wall_t=1.2, HasLocks=false);
//
// rotate([180,0,0]) SE_SpringEndTypeA(Coupler_OD=B_Coupler_OD, Coupler_ID=B_Coupler_ID, nRopes=6, Spring_OD=SE_Spring_CS11890_OD());

//
// Rocket_BoosterFin();

// BoosterFinCan(LowerHalfOnly=false, UpperHalfOnly=true);
// rotate([180,0,0]) BoosterFinCan(LowerHalfOnly=true, UpperHalfOnly=false);
//
// ***********************************
//  ***** for Viewing *****
//
// ShowRocket(ShowInternals=false);
// ShowSustainer(ShowInternals=false)
// ShowBooster(ShowInternals=false);
//
// ***********************************

include<TubesLib.scad>
use<AT-RMS-Lib.scad>
use<RailGuide.scad>
use<NoseCone.scad>
use<Fins.scad>
use<FinCan2Lib.scad>
use<Stager2Lib.scad>
use<AltBay.scad>
use<CablePuller.scad>
use<BatteryHolderLib.scad>
use<SpringThingBooster.scad>
use<SpringEndsLib.scad>
use<TransitionLib.scad>
use<PetalDeploymentLib.scad>
use<ElectronicsBayLib.scad>
use<R98Lib.scad>


Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 36:90;



EBay_Len=162;
Alt_DoorXtra_X=6;
Alt_DoorXtra_Y=4;

nFins=5;
nPetals=3;

B_Body_OD=BT137Body_OD;
B_Body_ID=BT137Body_ID;
B_Coupler_OD=BT137Coupler_OD;
B_Coupler_ID=BT137Coupler_ID;
B_MotorTube_OD=BT75Body_OD;
B_MotorTube_ID=BT75Body_ID;


S_Body_OD=BT98Body_OD;
S_Body_ID=BT98Body_ID;
S_Coupler_OD=BT98Coupler_OD;
S_Coupler_ID=BT98Coupler_ID;
S_MotorTube_OD=BT54Body_OD;
S_MotorTube_ID=BT54Body_ID;

BT137BallPerimeter_d=B_Body_OD+1;
nBT137Balls=7;

// Booster Fin
B_Fin_Post_h=14;
B_Fin_Root_L=400;
B_Fin_Root_W=18;
B_Fin_Tip_W=5;
B_Fin_Tip_L=140;
B_Fin_Span=240;
B_Fin_TipOffset=75;
B_Fin_Chamfer_L=42;

BoosterFinCanLength=B_Fin_Root_L+20;
B_Cone_Len=65;
BoosterTube_Len=450;
BoosterMotorTube_Len=580;
RailGuide_h=B_Body_OD/2+2;

S_Fin_Scale=S_Body_OD/B_Body_OD;

// Sustainer Fin
S_Fin_Post_h=14;
S_Fin_Root_L=400*S_Fin_Scale;
S_Fin_Root_W=18*S_Fin_Scale;
S_Fin_Tip_W=5*S_Fin_Scale;
S_Fin_Tip_L=140*S_Fin_Scale;
S_Fin_Span=240*S_Fin_Scale;
S_Fin_TipOffset=75*S_Fin_Scale;
S_Fin_Chamfer_L=42*S_Fin_Scale;

SustainerFinCanLength=S_Fin_Root_L+20;
S_TailCone_Len=65;
SustainerMotorTube_Len=620;

NC_Len=350;
NC_Tip_r=6;
NC_Wall_t=1.8;
NC_Base_L=15;

ForwardPetalLen=130;
S_UpperTubeLen=ForwardPetalLen+110;
AftPetalLen=180;
S_LowerTubeLen=AftPetalLen+270;
S_nLockBalls=6;

module ShowRocket(ShowInternals=false){
	Sustainer_Z=1204;
	
	translate([0,0,Sustainer_Z]) ShowSustainer(ShowInternals=ShowInternals);
	ShowBooster(ShowInternals=ShowInternals);
} // ShowRocket

// ShowRocket();
// ShowRocket(ShowInternals=true);

module ShowSustainer(ShowInternals=false){
	
	FinCan_Z=0;
	MotorTube_Z=-25;
	LowerEBay_Z=FinCan_Z+SustainerFinCanLength+0.2;
	LowerTube_Z=LowerEBay_Z+EBay_Len-15+0.2;
	EBay_Z=LowerTube_Z+S_LowerTubeLen+47-15;
	
	UpperTube_Z=EBay_Z+EBay_Len+47-15;
	Nosecone_Z=UpperTube_Z+S_UpperTubeLen+0.4;
	
	//*
	translate([0,0,Nosecone_Z]) color("Orange") 
		BluntOgiveNoseCone(ID=S_Coupler_OD, OD=S_Body_OD, L=NC_Len, Base_L=NC_Base_L, Tip_R=NC_Tip_r, 
							Wall_T=NC_Wall_t, Cut_Z=0, LowerPortion=false);
	translate([0,0,Nosecone_Z-0.2]) NC_ShockcordRingDual(Tube_OD=S_Body_OD, Tube_ID=S_Body_ID, NC_Base_L=NC_Base_L, nRivets=3);

	if (ShowInternals) translate([0,0,Nosecone_Z]){
		translate([0,0,-50]) SE_SlidingSpringMiddle(OD=S_Coupler_OD, nRopes=6, SliderLen=30, SpLen=40, SpringStop_Z=20);
		translate([0,0,-80]) rotate([180,0,0]) PD_NC_PetalHub(OD=S_Coupler_OD, nPetals=nPetals, nRopes=6);
		translate([0,0,-90]) rotate([180,0,0]) PD_Petals(OD=S_Coupler_OD, Len=ForwardPetalLen, nPetals=nPetals, AntiClimber_h=4);
	}

	if (!ShowInternals) translate([0,0,UpperTube_Z])
		color("LightBlue") Tube(OD=S_Body_OD, ID=S_Body_ID, Len=S_UpperTubeLen, myfn=$preview? 36:360);
	
	translate([0,0,EBay_Z]){
		color("LightGreen") 
		EB_Electronics_Bay(Tube_OD=S_Body_OD, Tube_ID=S_Body_ID, Len=EBay_Len, nBolts=3, BoltInset=7.5, 
							ShowDoors=(ShowInternals==false), HasSecondBattDoor=true);
							
		translate([0,0,-24.2]){
			R98C_BallRetainerTop(Body_OD=S_Body_OD, Body_ID=S_Body_ID);
			if (ShowInternals) 
				R98_BallRetainerBottom(Body_OD=S_Body_OD, Body_ID=S_Body_ID);
			if (!ShowInternals) color("Gray")
				STB_TubeEnd(BallPerimeter_d=S_Body_OD, nLockBalls=S_nLockBalls, Body_OD=S_Body_OD, 
						Body_ID=S_Body_ID, Skirt_Len=20);
		}
		
		translate([0,0,EBay_Len+24.2]) rotate([180,0,0]){
			R98C_BallRetainerTop(Body_OD=S_Body_OD, Body_ID=S_Body_ID);
			if (ShowInternals) 
				R98_BallRetainerBottom(Body_OD=S_Body_OD, Body_ID=S_Body_ID);
			if (!ShowInternals) color("Gray") 
				STB_TubeEnd(BallPerimeter_d=S_Body_OD, nLockBalls=S_nLockBalls, Body_OD=S_Body_OD, 
						Body_ID=S_Body_ID, Skirt_Len=20);
		}
	}
	
	
	if (ShowInternals) translate([0,0,EBay_Z-33]){
		rotate([180,0,0]) PD_PetalHub(OD=S_Coupler_OD, nPetals=nPetals, ShockCord_a=PD_ShockCordAngle());
		translate([0,0,-10])rotate([180,0,0]) PD_Petals(OD=S_Coupler_OD, Len=AftPetalLen, nPetals=nPetals, AntiClimber_h=3);
	}
	
	/**/
	
	if (ShowInternals) translate([0,0,MotorTube_Z+SustainerMotorTube_Len]){
		rotate([0,0,180]) R98C_MotorTubeTopper();
		translate([0,0,20]) SE_SlidingSpringMiddle(OD=S_Coupler_OD, nRopes=6, SliderLen=40, SpLen=40, SpringStop_Z=20);
		translate([0,0,70]) 
			SE_SpringEndTypeA(Coupler_OD=S_Coupler_OD, Coupler_ID=S_Coupler_ID, nRopes=6, Spring_OD=SE_Spring_CS4323_OD());
		translate([0,0,82.5]) color("LightBlue") Tube(OD=S_Coupler_OD, ID=S_Coupler_ID, Len=30, myfn=$preview? 36:360);
	}
	
	if (!ShowInternals) translate([0,0,LowerTube_Z]) 
		color("LightBlue") Tube(OD=S_Body_OD, ID=S_Body_ID, Len=S_LowerTubeLen, myfn=$preview? 36:360);
	
	translate([0,0,LowerEBay_Z]) color("LightGreen") 
		EB_LowerElectronics_Bay(Tube_OD=S_Body_OD, Tube_ID=S_Body_ID, Len=EBay_Len, nBolts=5, BoltInset=7.5, ShowDoors=(!ShowInternals));
		
	
	translate([0,0,FinCan_Z]){
		color("White") SustainerFinCan();
		translate([0,0,-42]) color("LightGray") SustainerCup();
	}
	
	//*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j])
		translate([S_Body_OD/2-S_Fin_Post_h, 0, FinCan_Z+SustainerFinCanLength/2])
			rotate([0,90,0]) color("Orange") Rocket_SustainerFin();
	/**/
	
	if (ShowInternals) translate([0,0,MotorTube_Z])
		color("LightBlue") Tube(OD=S_MotorTube_OD, ID=S_MotorTube_ID, Len=SustainerMotorTube_Len, myfn=$preview? 36:360);

	
	//*
	if (ShowInternals) 
	 translate([0,0,-30]) ATRMS_54_2560_Motor(Extended=true, HasEyeBolt=true);
	 /**/
} // ShowSustainer

// ShowSustainer();
// ShowSustainer(ShowInternals=true);

module ShowBooster(ShowInternals=false){
	FinCan_Z=0;
	BoosterBody_Z=FinCan_Z+BoosterFinCanLength;
	BallLock_Z=BoosterBody_Z+BoosterTube_Len;
	Booster_PetalHub_Z=BallLock_Z-10;
	EBay_Z=BallLock_Z+37.2;
	Interstage_Z=EBay_Z+EBay_Len+10.2;
	Top_Z=Interstage_Z+83;
	
	translate([0,0,Top_Z]) color("Blue") Stager_Saucer(Tube_OD=S_Body_OD, nLocks=3, HasElectrical=false);
	
	translate([0,0,Interstage_Z]) difference(){
		union(){
	
		color("Tan") InterStageTransition();
		
		if (ShowInternals) translate([0,0,10]) {
			Stager_CableRedirectTop(Tube_OD=S_Body_OD, Skirt_ID=S_Body_ID, InnerTube_OD=S_MotorTube_OD, HasRaceway=false, Raceway_a=270);
			Booster_Stager_CableRedirect();
							
		}
		if (ShowInternals) translate([0,0,-25]) color("Blue") Tube(OD=S_Coupler_OD, ID=S_Coupler_ID, Len=35, myfn=$preview? 36:360);
		
		} // union
		
		translate([0,0,-20]) cube([100,100,100]);
	} // Interstage_Z
	
	translate([0,0,EBay_Z]) color("LightGreen") Booster_Electronics_Bay(ShowDoors=(ShowInternals==false));
	
	translate([0,0,BallLock_Z]){
		STB_BallRetainerTop(BallPerimeter_d=BT137BallPerimeter_d, Outer_OD=B_Body_OD, Body_OD=B_Body_ID, nLockBalls=nBT137Balls, 
					IntegratedCouplerLenXtra=B_CouplerLenXtra, HasIntegratedCouplerTube=true, Body_ID=B_Body_ID, 
					HasSecondServo=true, UsesBigServo=true, Engagement_Len=25, HasLargeInnerBearing=true);
		if (ShowInternals) Booster_BallRetainerBottom();
		if (ShowInternals==false) color("Gray")
			STB_TubeEnd(BallPerimeter_d=BT137BallPerimeter_d, nLockBalls=nBT137Balls, Body_OD=B_Body_OD, Body_ID=B_Body_ID, Skirt_Len=25);
	}
	
	if (ShowInternals) translate([0,0,Booster_PetalHub_Z]){
		rotate([180,0,0]) Booster_PetalHub();
		translate([0,0,-6]) rotate([180,0,0]) PD_GridPetals(OD=B_Coupler_OD, Len=150, nPetals=3, Wall_t=1.2, HasLocks=false);
	}
	
	if (ShowInternals) translate([0,0,Booster_PetalHub_Z-220]){
		translate([0,0,-12.5]) 
			SE_SpringEndTypeA(Coupler_OD=B_Coupler_OD, Coupler_ID=B_Coupler_ID, nRopes=6, Spring_OD=SE_Spring_CS11890_OD());
			
		color("LightBlue") Tube(OD=B_Coupler_OD, ID=B_Coupler_ID, Len=50, myfn=$preview? 36:360);
		
		translate([0,0,-70]) SE_SlidingBigSpringMiddle(OD=BT137Coupler_OD, SliderLen=50, Extension=0);
		
		translate([0,0,-12.5-70]) rotate([180,0,0])
			SE_SpringEndTypeA(Coupler_OD=B_Coupler_OD, Coupler_ID=B_Coupler_ID, nRopes=6, Spring_OD=SE_Spring_CS11890_OD());
	}
	
	if (ShowInternals) translate([0,0,BoosterBody_Z+100])
		CenteringRing(OD=B_Body_ID, ID=B_MotorTube_OD, Thickness=6, nHoles=6);
	
	if (ShowInternals==false)
	translate([0,0,BoosterBody_Z]) color("Tan") Tube(OD=B_Body_OD, ID=B_Body_ID, Len=BoosterTube_Len, myfn=$preview? 36:360);
	
	translate([0,0,FinCan_Z]) color("White") BoosterFinCan();
	
	//*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j])
		translate([B_Body_OD/2-B_Fin_Post_h, 0, FinCan_Z+BoosterFinCanLength/2])
			rotate([0,90,0]) color("Orange") Rocket_BoosterFin();
	/**/
	
	if (ShowInternals) translate([0,0,-50])
	color("LightBlue") Tube(OD=B_MotorTube_OD, ID=B_MotorTube_ID, Len=BoosterMotorTube_Len, myfn=$preview? 36:360);
	
	/*
	if (ShowInternals) 
	 translate([0,0,-B_Cone_Len+15]) ATRMS_75_2560_Motor(Extended=false, HasEyeBolt=true);
	 /**/
} // ShowBooster

// ShowBooster();
// ShowBooster(ShowInternals=true);

module SustainerFinCan(){

	difference(){
		union(){
			FC2_FinCan(Body_OD=S_Body_OD, Body_ID=S_Body_ID, Can_Len=SustainerFinCanLength, 
						MotorTube_OD=S_MotorTube_OD, RailGuide_h=RailGuide_h,
						nFins=nFins,
						Fin_Root_W=S_Fin_Root_W, Fin_Root_L=S_Fin_Root_L, 
						Fin_Post_h=S_Fin_Post_h, Fin_Chamfer_L=S_Fin_Chamfer_L,
						Cone_Len=35, ThreadedTC=false, RailGuideLen=35,
						LowerHalfOnly=false, UpperHalfOnly=false, HasWireHoles=false);
						
		//*
			// Stager cup mounts here
			translate([0,0,-10])
			difference(){
				cylinder(d=S_Body_OD, h=11, $fn=$preview? 90:360);
				translate([0,0,-Overlap]) cylinder(d=72, h=30+Overlap*2);
			} // difference
			/**/
		} // union
		
		// Igniter wirs
		rotate([0,0,180/nFins]) translate([S_MotorTube_OD/2+8,0,-40]) 
			cylinder(d=7, h=S_Fin_Root_L+70);
			
		// Booster attachment
		translate([0,0,-28]) Stager_CupHoles(Tube_OD=S_Body_OD, ID=78, nLocks=3);
		
		// Aluminum retainer
		translate([0,0,-42]){
			cylinder(d=S_MotorTube_OD+5, h=33);
			cylinder(d=S_MotorTube_OD+10, h=10);
		}
	} // difference
} // SustainerFinCan

// SustainerFinCan();
//translate([0,0,-42]) SustainerCup();

module SustainerCup(Offset_a=7.5){
	
	difference(){
		Stager_Cup(Tube_OD=S_Body_OD, ID=78, nLocks=3, BoltsOn=true, Collar_h=29, Offset_a=Offset_a);
		
		ID=94;
		// Hollow out inside
		difference(){
			union(){
				cylinder(d1=78, d2=ID, h=10+Overlap);
				translate([0,0,10]) cylinder(d=ID, h=10);
				translate([0,0,20-Overlap]) cylinder(d2=78, d1=ID, h=10);
			} // union
			
			for (j=[0:1]) rotate([0,0,180*j+Offset_a]) translate([0,ID/2,15]) cube([9.5,20,40], center=true);
		} // difference
	} // difference
} // SustainerCup

//rotate([180,0,0]) SustainerCup();

module Rocket_SustainerFin(){
	TrapFin2(Post_h=S_Fin_Post_h, Root_L=S_Fin_Root_L, Tip_L=S_Fin_Tip_L,
			Root_W=S_Fin_Root_W, Tip_W=S_Fin_Tip_W,
			Span=S_Fin_Span, Chamfer_L=S_Fin_Chamfer_L,
					TipOffset=S_Fin_TipOffset);

	if ($preview==false){
		translate([-S_Fin_Root_L/2+10,0,0]) cylinder(d=S_Fin_Root_W*2.5, h=0.9); // Neg
		translate([S_Fin_Root_L/2-10,0,0]) cylinder(d=S_Fin_Root_W*2.5, h=0.9); // Pos
	}
} // Rocket_SustainerFin

// Rocket_SustainerFin();


module Booster_Stager_CableRedirect(){
	Height=20; // make it fit in the top of the EBay
	Tube_d=12.7; // Shock cord mount
	
	Sphere_r=S_Body_ID/2;
	Sphere_z=10;
	Sphere_t=4;
	Crop_d=57;
	
	difference(){
		union(){
			Stager_CableRedirect(Tube_OD=S_Body_OD, Skirt_ID=S_Body_ID, 
				Tube_ID=S_Coupler_ID, InnerTube_OD=S_MotorTube_OD, HasRaceway=false, Raceway_a=270, Height=Height);
			
			// The Dome
			difference(){
				translate([0,0,-Sphere_r+Sphere_z]) sphere(r=Sphere_r, $fn=$preview? 90:360);
				
				translate([0,0,-Sphere_r+Sphere_z]) sphere(r=Sphere_r-Sphere_t, $fn=$preview? 90:360);
				translate([0,0,-3]) rotate([180,0,0]) cylinder(r=Sphere_r+1, h=Sphere_r*2);
			
				translate([0,0,-6])
				difference(){
					cylinder(d=Crop_d+20, h=5);
					
					translate([0,0,-Overlap]) cylinder(d=Crop_d+1, h=6+Overlap*2, $fn=$preview? 90:360);
				} // difference
				
				translate([0,0,-Overlap])
				difference(){
					cylinder(d=Crop_d+10, h=5);
					
					translate([0,0,-Overlap]) cylinder(d=Crop_d, h=5+Overlap*2, $fn=$preview? 90:360);
				} // difference
			} // difference
			
			translate([0,0,Sphere_z+1]) rotate([90,0,0]) difference(){
				cylinder(d=10, h=5, center=true);
				cylinder(d=5, h=6, center=true);
				}
		} // union
		
		// Shock cord attachment tube hole
		translate([0,0,-Height/2])
			rotate([0,90,0]) cylinder(d=Tube_d, h=S_Body_OD, center=true);
	} // difference
} // Booster_Stager_CableRedirect

//Booster_Stager_CableRedirect();

//Stager_CableRedirect(Tube_OD=S_Body_OD, Skirt_ID=S_Body_ID, Tube_ID=S_Coupler_ID, InnerTube_OD=S_MotorTube_OD, HasRaceway=false, Raceway_a=270, Height=20);

module Booster_BallRetainerBottom(){
	difference(){
		STB_BallRetainerBottom(BallPerimeter_d=BT137BallPerimeter_d, Body_OD=B_Body_ID, nLockBalls=nBT137Balls,
						HasSpringGroove=false, Engagement_Len=25, HasLargeInnerBearing=true);
		
		rotate([0,0,5]) PD_PetalHubBoltPattern(OD=B_Coupler_OD, nPetals=7) Bolt4Hole();
	} // difference
} // Booster_BallRetainerBottom

//Booster_BallRetainerBottom();

module Booster_PetalHub(){
	difference(){
		PD_PetalHub(OD=B_Coupler_OD, 
					nPetals=3, 
					HasBolts=true,
					ShockCord_a=-1,
					HasNCSkirt=false, 
						Body_OD=0,
						Body_ID=0,
						NC_Base=0, 
						SkirtLen=10);
					
		// center hole
		translate([0,0,-Overlap]) cylinder(d=BT54Body_OD+IDXtra*2, h=10);
		
		rotate([0,0,9]) PD_PetalHubBoltPattern(OD=B_Coupler_OD, nPetals=7) translate([0,0,6]) Bolt4HeadHole(lHead=20);
	} // difference
} // Booster_PetalHub

//Booster_PetalHub();
		
module InterStageTransition(){
	Stager_Z=82.85;
	
	//*
	difference(){
		Transition(
				Ratio=3.5, 				// Angle of transition
				OD1=B_Body_OD, 		// Lower Body OD, Must be large end
				OD2=S_Body_OD, 		// Upper Body OD
				C1_OD=B_Body_ID-IDXtra*2, 	// Lower Coupler OD
				C1_ID=S_Body_ID+IDXtra*2, 	// Lower Coupler ID and Center Hole (can be 0, solid)
				C1_Len=15, 				// Lower Coupler Length (can be 0)
				C2_OD=S_Body_ID-IDXtra*2,	// Upper Coupler OD
				C2_ID=S_Body_ID-IDXtra*2-4.4, 	// Upper Coupler ID and Center Hole (can be 0, solid)
				C2_Len=0				// Upper Coupler Length (can be 0)
								);
								
		translate([0,0,Stager_Z]) Stager_ArmDisarmAccess(Tube_OD=S_Body_OD, KeyOffset_a=0, Len=B_Body_OD);
	} // difference
	/**/

	
	translate([0,0,Stager_Z])
	Stager_Mech(Tube_OD=S_Body_OD, nLocks=3, Skirt_ID=S_Body_ID, Skirt_Len=50.85, KeyOffset_a=0, HasRaceway=false, Raceway_a=270);
	

} // InterStageTransition

// InterStageTransition();
/*
translate([0,0,10]) Stager_CableRedirectTop(Tube_OD=S_Body_OD, Skirt_ID=S_Body_ID, InnerTube_OD=S_MotorTube_OD, HasRaceway=false, Raceway_a=270);
translate([0,0,10]) Booster_Stager_CableRedirect();
translate([0,0,-25]) color("Blue") Tube(OD=S_Coupler_OD, ID=S_Coupler_ID, Len=35, myfn=$preview? 36:360);
/**/


module BoosterFinCan(LowerHalfOnly=false, UpperHalfOnly=false){

	difference(){
		FC2_FinCan(Body_OD=B_Body_OD, Body_ID=B_Body_ID, Can_Len=BoosterFinCanLength,
				MotorTube_OD=B_MotorTube_OD, RailGuide_h=RailGuide_h,
				nFins=nFins, HasIntegratedCoupler=true, HasMotorSleeve=true, HasAftIntegratedCoupler=false,
				Fin_Root_W=B_Fin_Root_W, Fin_Root_L=B_Fin_Root_L, Fin_Post_h=B_Fin_Post_h, Fin_Chamfer_L=B_Fin_Chamfer_L,
				Cone_Len=B_Cone_Len, ThreadedTC=false, LowerHalfOnly=LowerHalfOnly, UpperHalfOnly=UpperHalfOnly, HasWireHoles=false);

		// aluminum motor retainer
		if (LowerHalfOnly || (!LowerHalfOnly && !UpperHalfOnly))
		translate([0,0,-B_Cone_Len-Overlap]) {
			cylinder(d=84.5, h=30);
			cylinder(d=100, h=4);
		}
		
	} // difference

} // BoosterFinCan

// BoosterFinCan(LowerHalfOnly=false, UpperHalfOnly=false);

module Booster_Electronics_Bay(ShowDoors=false){
	// Altimeter, Altimeter Battery, Cable Puller, Batt Door w/ Switch x2
	Len=EBay_Len;
	Body_OD=B_Body_OD;
	Body_ID=B_Body_ID;
	InnerTube_OD=BT54Body_OD;
	
	CablePuller_Z=EBay_Len/2;
	BattSwDoor_Z=72;
	TopSkirt_Len=15;
	BottomSkirt_Len=15;
	
	
	CP1_a=0;
	CP2_a=180; // not used
	Alt_a=140;
	Batt1_a=80; // Altimeter Battery
	Batt2_a=280; // Cable puller battery and switch
	Batt3_a=220; // STB battery and switch

	/*
	translate([0,0,-12]) Tube(OD=Body_ID-IDXtra*2, ID=Body_ID-IDXtra*2-4.4, Len=12, myfn=$preview? 36:360);
	
	difference(){
		cylinder(d=B_Body_ID+1, h=5);
		
		translate([0,0,-Overlap]) cylinder(d1=Body_ID-IDXtra*2-4.4, d2=Body_ID+1, h=5+Overlap*2);
	} // difference
	/**/
	
	difference(){
		union(){
			Tube(OD=Body_OD, ID=Body_ID, Len=Len, myfn=$preview? 90:360);

			// Bottom centering ring
			translate([0,0,BottomSkirt_Len])
				CenteringRing(OD=B_Body_OD-1, ID=InnerTube_OD+IDXtra*2, Thickness=5, nHoles=4);

			// Top centering ring
			translate([0,0,Len-5-TopSkirt_Len])
				CenteringRing(OD=Body_OD-1, ID=InnerTube_OD+IDXtra*2, Thickness=5, nHoles=4);
		} // union

		// Altimeter
		translate([0,0,CablePuller_Z]) rotate([0,0,Alt_a])
			Alt_BayFrameHole(Tube_OD=Body_OD, DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y);

		// Cable Puller door hole
		translate([0,0,CablePuller_Z]) rotate([0,0,CP1_a])
			CP_BayFrameHole(Tube_OD=Body_OD);
		//translate([0,0,CablePuller_Z]) rotate([0,0,CP2_a])
		//	CP_BayFrameHole(Tube_OD=Body_OD);

		// Battery and Switch door holes
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a])
			Batt_BayFrameHole(Tube_OD=Body_OD, HasSwitch=false);
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt2_a])
			Batt_BayFrameHole(Tube_OD=Body_OD, HasSwitch=true);
		translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt3_a])
			Batt_BayFrameHole(Tube_OD=Body_OD, HasSwitch=true);

	} // difference

	//*
	// Altimeter
	translate([0,0,CablePuller_Z]) rotate([0,0,Alt_a])
		Alt_BayDoorFrame(Tube_OD=Body_OD, Tube_ID=Body_ID,
			DoorXtra_X=Alt_DoorXtra_X, DoorXtra_Y=Alt_DoorXtra_Y, ShowDoor=ShowDoors);
	/**/
	// Cable Pullers
	translate([0,0,CablePuller_Z]) rotate([0,0,CP1_a])
		CP_BayDoorFrame(Tube_OD=Body_OD, ShowDoor=ShowDoors);
	//translate([0,0,CablePuller_Z]) rotate([0,0,CP2_a])
	//	CP_BayDoorFrame(Tube_OD=Body_OD, ShowDoor=ShowDoors);

	// Battery and Switch door2
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt1_a])
		Batt_BayDoorFrame(Tube_OD=Body_OD, HasSwitch=false, ShowDoor=ShowDoors);
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt2_a])
		Batt_BayDoorFrame(Tube_OD=Body_OD, HasSwitch=true, ShowDoor=ShowDoors);
	translate([0,0,BattSwDoor_Z]) rotate([0,0,Batt3_a])
		Batt_BayDoorFrame(Tube_OD=Body_OD, HasSwitch=true, ShowDoor=ShowDoors);

} // Booster_Electronics_Bay

//translate([0,0,EBay_Len]) Booster_Electronics_Bay(ShowDoors=false);

/*
translate([0,0,-37])
STB_BallRetainerTop(BallPerimeter_d=BT137BallPerimeter_d, Outer_OD=B_Body_OD, Body_OD=B_Body_ID, nLockBalls=nBT137Balls, 
					IntegratedCouplerLenXtra=B_CouplerLenXtra, HasIntegratedCouplerTube=true, Body_ID=B_Body_ID, 
					HasSecondServo=true, UsesBigServo=true, Engagement_Len=25, HasLargeInnerBearing=true);

/**/

module Rocket_BoosterFin(){
	TrapFin2(Post_h=B_Fin_Post_h, Root_L=B_Fin_Root_L, Tip_L=B_Fin_Tip_L,
			Root_W=B_Fin_Root_W, Tip_W=B_Fin_Tip_W,
			Span=B_Fin_Span, Chamfer_L=B_Fin_Chamfer_L,
					TipOffset=B_Fin_TipOffset);

	if ($preview==false){
		translate([-B_Fin_Root_L/2+10,0,0]) cylinder(d=B_Fin_Root_W*2.5, h=0.9); // Neg
		translate([B_Fin_Root_L/2-10,0,0]) cylinder(d=B_Fin_Root_W*2.5, h=0.9); // Pos
	}
} // Rocket_BoosterFin

// Rocket_BoosterFin();










