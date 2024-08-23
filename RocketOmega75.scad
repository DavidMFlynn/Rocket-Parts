// ***********************************
// Project: 3D Printed Rocket
// Filename: RocketOmega75.scad
// by David M. Flynn
// Created: 8/13/2024
// Revision: 0.9.7  8/13/2024
// Units: mm
// ***********************************
//  ***** Notes *****
//
//  This is a partial design, booster is just too long to look like an Omega, see Rocket75D2
//  3" Upscale of Estes Astron Omega
//  Two Stage Rocket with 75mm Body.
//  J460T-P to J135W-P
//  Uses CableRelease as a spring thing
//
//  ***** Tubes to Cut *****
// Sustainer Upper Tube		BT75_Body	 x 440mm
// Sustainer Lower Tube		BT75_Body	 x 110mm
// Sustainer Coupler		BT75_Coupler x  60mm Make 3
// Sustainer Motor Tube		BT54_Body	 x 274mm
//
// Booster Interstage		BT75_Body    x 183mm
// Booster Coupler 			BT75_Coupler x  46mm
// Booster Motor Tube		BT54_Body	 x 153mm
//
//  ***** History *****
// 0.9.7  8/13/2024   Copied from Omega54 0.9.6
// 0.9.6  2/25/2023   Added Rail Guide to booster fin can.
// 0.9.5  2/24/2023   Ready for first printing and test assembly.
// 0.9.4  2/24/2023   Added SpringThing Parts
// 0.9.3  2/23/2023   Added Nosecone and Cable Release parts to STL list.
// 0.9.2  2/21/2023   Copied from RocketOmega.scad, Simple fin cans
// 0.9.1  11/14/2022  Worked on booster fin can. 
// 0.9.0  10/10/2022  First code.
//
// ***********************************
//  ***** for STL output *****
//
// OmegaNosecone();
// NC_ShockcordRing75(Body_OD=Body_OD, Body_ID=Body_ID, NC_Base_L=NC_Base_L);
//
//  *** SpringThing Parts ***
//
// 
//  *** Electronics Bays ***
//
// EB_LowerElectronics_Bay(Tube_OD=Body_OD, Tube_ID=Body_ID, Len=EBay_Len, nBolts=4, BoltInset=7.5, ShowDoors=false);
// EB_Electronics_Bay(Tube_OD=Body_OD, Tube_ID=Body_ID, Len=EBay_Len, nBolts=4, BoltInset=7.5, ShowDoors=false, HasSecondBattDoor=false, HasFwdIntegratedCoupler=false, HasFwdShockMount=false);
//
//  * Booster E_Bay *
// EB_Electronics_Bay(Tube_OD=Body_OD, Tube_ID=Body_ID, Len=EBay_Len, nBolts=4, BoltInset=7.5, ShowDoors=false, HasSecondBattDoor=false, HasFwdIntegratedCoupler=true, HasFwdShockMount=false);
//
//  *** Doors ***
// rotate([-90,0,0]) EB_AltDoor(Tube_OD=BT98Body_OD);
// rotate([-90,0,0]) EB_BattDoor(Tube_OD=BT98Body_OD, HasSwitch=false, DoubleBatt=false);
// rotate([-90,0,0]) EB_BattDoor(Tube_OD=BT98Body_OD, HasSwitch=true, DoubleBatt=false);
// 
//  *** Fins & Fin Cans ***
//
// FinCan54();
// RocketOmegaFin();
//
//  ***** BOOSTER *****
//
//  *** Ball Lock ***
//
// STB_BallRetainerTop(BallPerimeter_d=BallPerimeter_d, Outer_OD=Body_OD, Body_OD=Body_ID, nLockBalls=nLockBalls, HasIntegratedCouplerTube=true, Body_ID=Body_ID, HasSecondServo=false, UsesBigServo=false, Engagement_Len=20, HasLargeInnerBearing=false);
// R75_BallRetainerTop(Body_OD=Body_OD, Body_ID=Body_ID);
//
// STB_LockDisk(BallPerimeter_d=BallPerimeter_d, nLockBalls=nLockBalls, HasLargeInnerBearing=false);
// STB_BallRetainerBottom(BallPerimeter_d=BallPerimeter_d, Body_OD=Body_ID, nLockBalls=nLockBalls, HasSpringGroove=false, Engagement_Len=20, HasLargeInnerBearing=false);
// R75_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID, HasPD_Ring=true);
// STB_TubeEnd2(BallPerimeter_d=BallPerimeter_d, nLockBalls=nLockBalls, Body_OD=Body_OD, Body_ID=Body_ID, Skirt_Len=20);
//
//
//  *** 3 Inch Stager ***
//
// rotate([180,0,0]) Stager_Cup(Tube_OD=Body_OD, ID=BT54Body_ID, nLocks=nLocks, BoltsOn=true); // a.k.a. Sustainer Motor Retainer
// rotate([-90,0,0]) Stager_LockRod(Adj=0.0);
//
// Stager_Saucer(Tube_OD=Body_OD, nLocks=nLocks); // Bolts on
//
// Stager_LockRing(Tube_OD=Body_OD, nLocks=nLocks, FlexComp_d=0.0); 
// Stager_LockStop(Tube_OD=Body_OD, HasMagnet=true);
// Stager_LockStop(Tube_OD=Body_OD, HasMagnet=false);
//
// Stager_Lanyard();
//
// Stager_Mech(Tube_OD=Body_OD, nLocks=nLocks, Skirt_ID=Body_ID, Skirt_Len=35, nSkirtBolts=4, ShowLocked=true);
//  *** Shock cord attachment and servo space ***
// EB_ExtensionRing(Tube_OD=BT75Body_OD, Tube_ID=BT75Body_ID, Len=21, nBolts=4, BoltInset=7.5)
//
// Stager_InnerRace(Tube_OD=Body_OD);
// Stager_BallSpacer(Tube_OD=Body_OD);
// Stager_ServoPlate(Tube_OD=Body_OD, Skirt_ID=Body_ID);
//
//  *** Petal Deployer ***
//
// R75_PetalHub(Body_OD=Body_OD, Body_ID=Body_ID);
// rotate([180,0,0]) PD_Petals(OD=Coupler_OD, Len=BoosterPetalLen, nPetals=3, Wall_t=1.8, AntiClimber_h=4, HasLocks=false, Lock_Span_a=180);
//
// rotate([180,0,0]) BoosterFinCan(LowerHalfOnly=true, UpperHalfOnly=false);
// BoosterFinCan(LowerHalfOnly=false, UpperHalfOnly=true);
//
// BoosterMotorRetainer();
// RocketOmegaBoosterFin();
//
// ***********************************
//  ***** Routines *****
//
// MtrRMS38_240(HasEyeBolt=false);
//
// ***********************************
//  ***** for Viewing *****
//
// ShowCableRelease();
//
// ShowRocketOmega(ShowInternals=true);
// ShowRocketOmega(ShowInternals=false);
//
// ShowBooster(ShowInternals=true);
// ShowBooster(ShowInternals=false);
//
// ***********************************
include<TubesLib.scad>
use<AT-RMS-Lib.scad>
use<R75Lib.scad>
use<PetalDeploymentLib.scad>
use<ElectronicsBayLib.scad>
use<Stager75BBLib.scad>
use<FinCan2Lib.scad>
use<NoseCone.scad>
use<FinCan.scad>
use<BatteryHolderLib.scad>
use<SpringEndsLib.scad>
use<SpringThingBooster.scad>

//also included
 //include<RailGuide.scad>
 //include<Fins.scad>
 //include<TubesLib.scad>
 //include<BearingLib.scad>
 //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

Scale=BT75Body_OD/41.58; // Body tube diameters
echo(Scale=Scale);

Body_OD=BT75Body_OD;
Body_ID=BT75Body_ID;
Coupler_OD=BT75Coupler_OD;
Coupler_ID=BT75Coupler_ID;
MotorTube_OD=BT54Body_OD;
MotorTube_ID=BT54Body_ID;
Stager_ID=MotorTube_OD;

nLocks=3; // Stager locks

nLockBalls=5; // Ball Lock (STB) units
BallPerimeter_d=Body_OD;

BoosterPetalLen=150;

// Sustainer Fin, Omega style
nFins=4;
Sustainer_Fin_Post_h=Body_OD/2-MotorTube_OD/2-1.2;
Sustainer_Fin_Root_L=72*Scale;
Sustainer_Fin_Root_W=5*Scale;
//echo(Sustainer_Fin_Root_W=Sustainer_Fin_Root_W);
Sustainer_Fin_Tip_W=2*Scale;
Sustainer_Fin_Tip_L=Sustainer_Fin_Root_L*0.75;
Sustainer_Fin_Span=Sustainer_Fin_Root_L*0.75;
Sustainer_Fin_TipOffset=0;
Sustainer_Fin_Chamfer_L=Sustainer_Fin_Root_W*3;

// Booster Fin, Omega style
Booster_Fin_Post_h=Body_OD/2-MotorTube_OD/2-1.2;
Booster_Fin_Root_L=90*Scale;
Booster_Fin_Root_W=5.7*Scale;
Booster_Fin_Tip_W=2*Scale;
Booster_Fin_Tip_L=Booster_Fin_Root_L*0.75;
Booster_Fin_Span=Booster_Fin_Root_L*0.75;
Booster_Fin_TipOffset=0;
Booster_Fin_Chamfer_L=Booster_Fin_Root_W*3;
//echo(Booster_Fin_Root_L=Booster_Fin_Root_L);
//echo(Booster_Fin_Span=Booster_Fin_Span);


EBay_Len=162;
ScaleBooster_Body_Len=5*25.4*Scale;
echo(ScaleBooster_Body_Len=ScaleBooster_Body_Len);

PBay_Len=5*25.4*Scale;
UpperTube_Len=457-PBay_Len;
LowerTube_Len=110; // Can be adjusted to fit motor tube length
SusFinCan_Len=Sustainer_Fin_Root_L+40;
SustainerFinInset=5;
BoosterFinInset=5;
BoostFinCan_Len=Booster_Fin_Root_L+BoosterFinInset*2;
InterstageTube_Len=300;
Booster_Coupler_Len=46; // STB_SpringSeat=3, Spring=22, STB=22 
Booster_Body_Len=BoostFinCan_Len+InterstageTube_Len;
SustainerMotorTube_Len=SusFinCan_Len+LowerTube_Len+25;
echo(Booster_Body_Len=Booster_Body_Len);
ScaleBody_Len=(14.5+5)*25.4*Scale;
echo(ScaleBody_Len=ScaleBody_Len);
echo(" Including scale payload bay len =",PBay_Len);
Body_Len=PBay_Len+UpperTube_Len+EBay_Len+LowerTube_Len+SusFinCan_Len;
echo(Body_Len=Body_Len);
BoosterMotorTubeLen=BoostFinCan_Len+100;

// Phenolic Body and Coupler Tube Lengths
echo("Upper Body Tube = ",UpperTube_Len+PBay_Len);
echo("Lower Body Tube = ",LowerTube_Len);
echo("Sustainer Motor Tube = ",SustainerMotorTube_Len);
echo("Booster Body = ",InterstageTube_Len);
echo("Booster Coupler = ",InterstageTube_Len-10);
echo("Booster Motor Tube = ",BoosterMotorTubeLen);

NoseconeSep_Z=0; // This much of the nosecone becomes part of the fairing.
NC_Len=170*Scale;
NC_Tip_r=5*Scale;
NC_Base_L=15;
NC_Wall_t=1.8;


module ShowBooster(ShowInternals=true){
	FinCan_Z=0;
	Fin_Z=FinCan_Z+Booster_Fin_Root_L/2+BoosterFinInset;
	Body_Z=FinCan_Z+BoostFinCan_Len+0.1;
	STB_Z=Body_Z+InterstageTube_Len+10;
	Ebay_Z=STB_Z+23.5;
	Stager_Z=Ebay_Z+EBay_Len+0.1+15+57;
	Saucer_Z=Stager_Z+0.1;

	translate([0,0,Saucer_Z]) Stager_Saucer(Tube_OD=Body_OD, nLocks=nLocks);
	translate([0,0,Stager_Z]) 
		Stager_Mech(Tube_OD=Body_OD, nLocks=nLocks, Skirt_ID=Body_ID, Skirt_Len=35, nSkirtBolts=4, ShowLocked=true);
	
	//translate([0,0,Adaptor_Z]) EB_ExtensionRing(Tube_OD=BT75Body_OD, Tube_ID=BT75Body_ID, Len=21, nBolts=4, BoltInset=7.5);
	
	//*
	translate([0,0,Ebay_Z]) 
		EB_Electronics_Bay(Tube_OD=Body_OD, Tube_ID=Body_ID, Len=EBay_Len, nBolts=4, BoltInset=7.5, ShowDoors=false, HasSecondBattDoor=false, HasFwdIntegratedCoupler=true, HasFwdShockMount=false);
	/**/
	
	translate([0,0,STB_Z+0.1]) 
		STB_BallRetainerTop(BallPerimeter_d=BallPerimeter_d, Outer_OD=Body_OD, Body_OD=Body_ID, nLockBalls=nLockBalls, HasIntegratedCouplerTube=true, Body_ID=Body_ID, HasSecondServo=false, UsesBigServo=false, Engagement_Len=20, HasLargeInnerBearing=false);
	
	if (ShowInternals) translate([0,0,STB_Z]) {
		R75_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID, HasPD_Ring=true);
		translate([0,0,-19.1]) rotate([180,0,200]) R75_PetalHub(Body_OD=Body_OD, Body_ID=Body_ID);
		translate([0,0,-28]) rotate([180,0,200]) PD_Petals(OD=Coupler_OD, Len=BoosterPetalLen, nPetals=3, Wall_t=1.8, AntiClimber_h=4, HasLocks=false, Lock_Span_a=180);
		}
	
	if (ShowInternals==false) translate([0,0,STB_Z]) 
		STB_TubeEnd2(BallPerimeter_d=BallPerimeter_d, nLockBalls=nLockBalls, Body_OD=Body_OD, Body_ID=Body_ID, Skirt_Len=20);
	
	if (ShowInternals==false)
		translate([0,0,Body_Z]) color("White") 
			Tube(OD=Body_OD, ID=Body_ID, Len=InterstageTube_Len-0.2, myfn=$preview? 90:360);
	
	translate([0,0,FinCan_Z]) color("White") BoosterFinCan();
	translate([0,0,FinCan_Z]) color("White") BoosterMotorRetainer();
	
	if (ShowInternals) 
			translate([0,0,-23]) color("Tan") 
			Tube(OD=MotorTube_OD, ID=MotorTube_ID, Len=BoosterMotorTubeLen, myfn=$preview? 90:360);
									
	for (j=[0:nFins]) rotate([0,0,360/nFins*j])
		translate([Body_OD/2-Booster_Fin_Post_h, 0, Fin_Z]) 
			rotate([0,90,0]) color("Blue") RocketOmegaBoosterFin();
			
	//if (ShowInternals) translate([0,0,-23]) ATRMS_54_852_Motor(Extended=false, HasEyeBolt=true); // J275W, J460T, J615ST
	if (ShowInternals) translate([0,0,-23]) ATRMS_54_1280_Motor(Extended=false, HasEyeBolt=true); // J800W
	
	
} // ShowBooster

//ShowBooster(ShowInternals=true);
//ShowBooster(ShowInternals=false);

module ShowRocketOmega(ShowInternals=true){
	
	
	InterstageCoupler_Len=InterstageTube_Len;
	
		SusFinCan_Z=BoostFinCan_Len+InterstageCoupler_Len+280+1;
		LowerTube_Z=SusFinCan_Z+SusFinCan_Len;
	
		BH_Z=SusFinCan_Z+SusFinCan_Len+LowerTube_Len;
		EBay_Z=BH_Z;//+76;
		CR_Z=EBay_Z+EBay_Len+20;
		SpringThing_Z=CR_Z+90;
		UpperTube_Z=EBay_Z+EBay_Len;
	
		PBay_Z=UpperTube_Z+UpperTube_Len;
	
	NC_Z=PBay_Z+PBay_Len;
	Spring_Len=22*2+3+15+20;// (82mm)
	ParachuteSleeve_Len=185;
	//echo("Sustainer Upper Tube = ", PBay_Len+UpperTube_Len);
	
	//*
	translate([0,0,NC_Z]){
		color("Black") OmegaNosecone();
		if (ShowInternals)
		translate([0,0,-Coupler_OD*0.8])
			color("Gray") NoseconeBase(OD=Body_ID, L=Coupler_OD*0.8, NC_Base=21);
		}
	if (ShowInternals)
		translate([0,0,NC_Z-Coupler_OD*0.8-ParachuteSleeve_Len])
			Tube(OD=Coupler_OD, ID=Coupler_ID, Len=ParachuteSleeve_Len, myfn=$preview? 90:360);
	
	if (ShowInternals==false){
		translate([0,0,PBay_Z+0.1]) color("Silver") 
			Tube(OD=Body_OD, ID=Body_ID, Len=PBay_Len-0.2, myfn=$preview? 90:360);
	
		translate([0,0,UpperTube_Z+0.1]) color("White") 
			Tube(OD=Body_OD, ID=Body_ID, Len=UpperTube_Len-0.2, myfn=$preview? 90:360);
	}
		
	if (ShowInternals){
		translate([0,0,SpringThing_Z]) color("Gray") cylinder(d=54, h=Spring_Len);
		translate([0,0,CR_Z]) rotate([0,0,120]) ShowCableRelease();
	}
	
	translate([0,0,EBay_Z]) {
		rotate([0,0,180-180/nFins]) color("White") 
			EB_Electronics_Bay(Tube_OD=Body_OD, Tube_ID=Body_ID, Len=EBay_Len, nBolts=4, BoltInset=7.5, ShowDoors=(ShowInternals==false),
				HasSecondBattDoor=false, HasFwdIntegratedCoupler=false, HasFwdShockMount=false);
		
		
		if (ShowInternals) translate([0,0,15-0.3])
			rotate([180,0,0]) ShockCordMount(OD=Coupler_OD, ID=MtrTube_OD, AnchorRod_OD=12.7);
	}
	

	if (ShowInternals==false)
		translate([0,0,LowerTube_Z+0.1]) color("White") 
			Tube(OD=Body_OD, ID=Body_ID, Len=LowerTube_Len-0.2, myfn=$preview? 90:360);
	
	//*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j])
		translate([Body_OD/2-Sustainer_Fin_Post_h, 0, SusFinCan_Z+Sustainer_Fin_Root_L/2+SustainerFinInset]) 
			rotate([0,90,0]) color("Blue") RocketOmegaFin();
	/**/
	
	translate([0,0,SusFinCan_Z]) {
		
		color("White") SustainerFinCan();
		
	//	translate([0,0,-15]) color("Silver")
	//	MotorRetainer(Tube_OD=BMtrTube_OD, Tube_ID=MtrTube_ID, Mtr_OD=38, MtrAC_OD=42);
		
		if (ShowInternals) 
			color("Tan") Tube(OD=MtrTube_OD, ID=MtrTube_ID, 
									Len=SustainerMotorTube_Len, myfn=$preview? 90:360);
		MtrRMS38_240(HasEyeBolt=true);
		}
	
	ShowBooster(ShowInternals=ShowInternals);
} // ShowRocketOmega

//ShowRocketOmega(ShowInternals=true);
//ShowRocketOmega(ShowInternals=false);

module OmegaNosecone(){
	BluntOgiveNoseCone(ID=Coupler_OD, OD=Body_OD, L=NC_Len, 
			Base_L=NC_Base_L, Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=0, LowerPortion=false);
	
} // OmegaNosecone

//OmegaNosecone();

module SustainerFinCan(LowerHalfOnly=false, UpperHalfOnly=false){
	
	Can_Len=Sustainer_Fin_Root_L+SustainerFinInset*2;
	echo(Can_Len=Can_Len);
	RailGuide_Z=50;
					
	
	difference(){
		union(){
			FC2_FinCan(Body_OD=Body_OD, Body_ID=Body_ID, Can_Len=Can_Len,
				MotorTube_OD=MotorTube_OD, RailGuide_h=RailGuide_h,
				nFins=nFins, HasIntegratedCoupler=true, HasMotorSleeve=true, HasAftIntegratedCoupler=false,
				Fin_Root_W=Sustainer_Fin_Root_W, Fin_Root_L=Sustainer_Fin_Root_L, 
				Fin_Post_h=Sustainer_Fin_Post_h, Fin_Chamfer_L=Sustainer_Fin_Chamfer_L,
				Cone_Len=0, ThreadedTC=false, Extra_OD=0, 
				LowerHalfOnly=LowerHalfOnly, UpperHalfOnly=UpperHalfOnly, HasWireHoles=false);
						
		//*
			// Stager cup mounts here
			translate([0,0,-2])
			difference(){
				cylinder(d=Body_OD, h=6, $fn=$preview? 90:360);
				translate([0,0,-Overlap]) cylinder(d=MotorTube_OD+IDXtra*3, h=30+Overlap*2);
			} // difference
		/**/
		} // union
		
		// Igniter wirs
		rotate([0,0,180/nFins+180]) translate([MotorTube_OD/2+6,0,-20]) 
			cylinder(d=5, h=Sustainer_Fin_Root_L+70);
			
		// Booster attachment
		translate([0,0,-20]) rotate([0,0,15]) Stager_CupHoles(Tube_OD=Body_OD, ID=Stager_ID, nLocks=3);
		
	} // difference
	
	
} // SustainerFinCan

//SustainerFinCan();	
	
module RocketOmegaFin(){
	//echo(Fin_Post_h=Fin_Post_h);
	
	TrapFin2(Post_h=Sustainer_Fin_Post_h, Root_L=Sustainer_Fin_Root_L, Tip_L=Sustainer_Fin_Tip_L, 
			Root_W=Sustainer_Fin_Root_W, Tip_W=Sustainer_Fin_Tip_W, 
			Span=Sustainer_Fin_Span, Chamfer_L=Sustainer_Fin_Chamfer_L,
					TipOffset=Sustainer_Fin_TipOffset);

	if ($preview==false){
		translate([-Sustainer_Fin_Root_L/2+Sustainer_Fin_Root_W/2,0,0]) cylinder(d=Sustainer_Fin_Root_W*2.5, h=0.9); // Neg
		translate([Sustainer_Fin_Root_L/2-Sustainer_Fin_Root_W/2,0,0]) cylinder(d=Sustainer_Fin_Root_W*2.5, h=0.9); // Pos
	}
} // RocketOmegaFin

// RocketOmegaFin();

module MtrRMS38_240(HasEyeBolt=false){
	color("Red") cylinder(d=38, h=127);
	translate([0,0,-10+Overlap])  color("DarkGray") cylinder(d=42, h=10);
	if (HasEyeBolt){
		translate([0,0,127]) color("Green") {
			cylinder(d=38, h=3);
			cylinder(d=26,h=18);
			cylinder(d=16,h=30);
		}
		color("Silver") translate([0,0,127+30+15])  rotate([90,0,0])
			rotate_extrude() translate([12.7,0,0]) circle(d=6);
	}else{
		translate([0,0,127]) color("Blue") {
			cylinder(d=38, h=3);
			cylinder(d=26,h=18);
		}
	} // if
} // MtrRMS38_240

//MtrRMS38_240();
//MtrRMS38_240(HasEyeBolt=true);


RailGuide_h=Body_OD/2+2;
TailConeLen=35;

module BoosterFinCan(LowerHalfOnly=false, UpperHalfOnly=false){
	Can_Len=Booster_Fin_Root_L+BoosterFinInset*2; //Booster_Body_Len;
	
	echo(Can_Len=Can_Len);
	RailGuide_Z=40;
	
	FC2_FinCan(Body_OD=Body_OD, Body_ID=Body_ID, Can_Len=Can_Len,
				MotorTube_OD=MotorTube_OD, RailGuide_h=RailGuide_h,
				nFins=nFins, HasIntegratedCoupler=true, HasMotorSleeve=true, HasAftIntegratedCoupler=false,
				Fin_Root_W=Booster_Fin_Root_W, Fin_Root_L=Booster_Fin_Root_L, 
				Fin_Post_h=Booster_Fin_Post_h, Fin_Chamfer_L=Booster_Fin_Chamfer_L,
				Cone_Len=TailConeLen, ThreadedTC=true, Extra_OD=2, 
				LowerHalfOnly=LowerHalfOnly, UpperHalfOnly=UpperHalfOnly, HasWireHoles=false);
	
} // BoosterFinCan

//BoosterFinCan();

module BoosterMotorRetainer(){
	FC2_MotorRetainer(Body_OD=Body_OD,
						MotorTube_OD=MotorTube_OD, MotorTube_ID=MotorTube_ID,
						HasWrenchCuts=false, Cone_Len=TailConeLen, ExtraLen=0, Extra_OD=2);
} // BoosterMotorRetainer

// BoosterMotorRetainer();

module RocketOmegaBoosterFin(){
	TrapFin2(Post_h=Booster_Fin_Post_h, Root_L=Booster_Fin_Root_L, Tip_L=Booster_Fin_Tip_L, 
			Root_W=Booster_Fin_Root_W, Tip_W=Booster_Fin_Tip_W, 
			Span=Booster_Fin_Span, Chamfer_L=Booster_Fin_Chamfer_L,
					TipOffset=Booster_Fin_TipOffset);

	if ($preview==false){
		translate([-Booster_Fin_Root_L/2+10,0,0]) cylinder(d=Booster_Fin_Root_W*2.5, h=0.9); // Neg
		translate([Booster_Fin_Root_L/2-10,0,0]) cylinder(d=Booster_Fin_Root_W*2.5, h=0.9); // Pos
	}
} // RocketOmegaBoosterFin

// RocketOmegaBoosterFin();




































