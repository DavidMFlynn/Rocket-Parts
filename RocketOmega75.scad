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
// ST_TubeEnd(Tube_OD=ROmega_Coupler_OD, Tube_ID=ROmega_Coupler_ID); // print 2
// rotate([180,0,0]) ST_TubeLockLanyard(Skirt_ID=ROmega_Coupler_ID-2-IDXtra);
// ST_TubeLock(Tube_OD=ROmega_Coupler_OD, Skirt_ID=ROmega_Coupler_ID-2, SkirtLen=15);
// ST_SpringMiddle(Tube_ID=ROmega_Coupler_OD);
// ST_SpringGuide(InnerTube_ID=ROmega_Body_ID); // not used
//
//  *** Cable Release Parts ***
//
// rotate([180,0,0]) CR_Housing();
// LockPlate();
// LockingPin();
// BallRetainer();
// LockPlateStop();
// HousingStop(OD=PML54Body_ID, HasSpringGuide=true);
// TopMountS5245Tray();
// ServoWheelB(UsesHS5245MGServo=true);
// LockPlateExtension(Len=12);
// ServoWheel(HasLockingBar=true, HasHoles=false);
// 
//  *** Electronics Bay ***
//
// Omega54EBay();
// AltDoor54(Tube_OD=ROmega_Body_OD, IsLoProfile=false, DoorXtra_X=0, DoorXtra_Y=0);
// Batt_Door54(Tube_OD=ROmega_Body_OD, HasSwitch=true);
// ShockCordMount(OD=ROmega_Coupler_OD, ID=ROmega_MtrTube_OD+IDXtra*2, AnchorRod_OD=12.7); // optional
//
//  *** Fins & Fin Cans ***
//
// FinCan54();
// RocketOmegaFin();
//
// rotate([180,0,0]) InterstageCouplerS(); // for pyro deployment
// InterstagePiston(); // for pyro deployment
//
//  *** Spring Thing Booster ***
// rotate([180,0,0]) STB_Cover(BT_ID=ROmega_Body_ID);
// STB_BallRetainerTop(BT_ID=ROmega_Body_ID, CT_ID=ROmega_Coupler_ID);
// STB_LockDisk(BT_ID=ROmega_Body_ID, CT_ID=ROmega_Coupler_ID);
// STB_BallRetainerBottom(BT_ID=ROmega_Body_ID, CT_ID=ROmega_Coupler_ID);
// SpringSeat(); // customized version of STB_SpringSeat()
//  ** Drill the end of the coupler tube before gluing on the body tube. **
// STB_DrillingJig(BT_ID=PML54Body_ID, CT_OD=ROmega_Coupler_OD); 
//
// rotate([180,0,0]) BoosterFinCan();
// BoosterMotorRetainer();
// RocketOmegaBoosterFin();
//
//  ***** 3 Inch Stager *****
//
// rotate([180,0,0]) Stager_Cup(Tube_OD=Body_OD, ID=Stager_ID, nLocks=3, BoltsOn=true, Collar_h=18, HasElectrical=false, Offset_a=0);
// Stager_Saucer(Tube_OD=Body_OD, nLocks=3, HasElectrical=false);
// Stager_LockRing(Tube_OD=Body_OD, nLocks=3, FlexComp_d=0.0);
// Stager_BallSpacer(Tube_OD=Body_OD);
// Stager_InnerRace(Tube_OD=Body_OD);
// Stager_Mech(Tube_OD=Body_OD, nLocks=3, Skirt_ID=Body_ID, Skirt_Len=30, KeyOffset_a=0, HasRaceway=false, Raceway_a=270);
//
// Stager_CableRedirectTop(Tube_OD=Body_OD, Skirt_ID=Body_ID, InnerTube_OD=PML29Body_OD, HasRaceway=false, Raceway_a=270);
// Booster_Stager_CableRedirect();
//
// rotate([-90,0,0]) Stager_LockRod(Adj=0);
// Stager_CableEndAndStop(Tube_OD=Body_OD, Xtra3=false);
// Stager_Detent(Tube_OD=Body_OD);
// Stager_CableBearing();
//
//  ***** NEW BOOSTER PARTS *****
//
// PD_Booster_PetalHub(OD=BT54Coupler_OD, nPetals=2, nRopes=2, ShockCord_a=-1, HasThreadedCore=true, ST_DSpring_ID=SE_Spring_CS4323_ID(), ST_DSpring_OD=SE_Spring_CS4323_OD(), CouplerTube_ID=0);
// rotate([180,0,0])PD_Petals(OD=BT54Coupler_OD, Len=50, nPetals=2, Wall_t=1.8, AntiClimber_h=0, HasLocks=true, Lock_Span_a=180);
// rotate([0,90,0]) translate([0,0,2])PD_PetalLockCatch(OD=BT54Coupler_OD, ID=BT54Coupler_ID, Wall_t=1.8, Len=27, LockStop=false);
// PD_CatchHolder(OD=BT54Coupler_OD, ID=BT54Coupler_ID, Wall_t=1.8, nPetals=2, HasBasePlate=true);
//
HasGuidePoint=false;
// rotate([180,0,0]) CRBB_LockingPin(LockPin_Len=23, GuidePoint=HasGuidePoint);
// rotate([180,0,0]) CRBB_LockRing(GuidePoint=HasGuidePoint);
// rotate([180,0,0]) CRBB_TopRetainer(LockRing_d=CRBB_LockRingDiameter(), OD=BT54Body_ID, GuidePoint=HasGuidePoint);
// CRBB_OuterBearingRetainer();
// rotate([180,0,0]) CRBB_InnerBearingRetainer(HasServo=true);
// rotate([180,0,0]) CRBB_MagnetBracket();
// rotate([180,0,0]) CRBB_TriggerPost();
// CRBB_CenteringRingMount(Tube_ID=BT54Body_ID, Thickness=5, Skirt_Len=15.5, nBolts=5, HasShockcodeAnchor=true, LockRing_d=CRBB_LockRingDiameter());
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
use<CableReleaseBB.scad>
use<PetalDeploymentLib.scad>
use<Stager2Lib.scad>
use<SpringThing2.scad>
use<FinCan2Lib.scad>
use<Fairing54.scad>
use<NoseCone.scad>
use<FinCan.scad>
use<AltBay.scad>
use<CableRelease.scad>
use<BatteryHolderLib.scad>
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


nFins=4;
// Sustainer Fin
Sustainer_Fin_Post_h=Body_OD/2-MotorTube_OD/2-1.2;
Sustainer_Fin_Root_L=72*Scale;
Sustainer_Fin_Root_W=5*Scale;
//echo(Sustainer_Fin_Root_W=Sustainer_Fin_Root_W);
Sustainer_Fin_Tip_W=2*Scale;
Sustainer_Fin_Tip_L=Sustainer_Fin_Root_L*0.75;
Sustainer_Fin_Span=Sustainer_Fin_Root_L*0.75;
Sustainer_Fin_TipOffset=0;
Sustainer_Fin_Chamfer_L=Sustainer_Fin_Root_W*3;

// Booster Fin
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

BoostFinCan_Len=Booster_Fin_Root_L+40;
InterstageTube_Len=210; // 183 = 60 for P, 220 gives 85 for paradhute
Booster_Coupler_Len=46; // STB_SpringSeat=3, Spring=22, STB=22 
Booster_Body_Len=BoostFinCan_Len+InterstageTube_Len;
SustainerMotorTube_Len=SusFinCan_Len+LowerTube_Len+25;
echo(Booster_Body_Len=Booster_Body_Len);
ScaleBody_Len=(14.5+5)*25.4*Scale;
echo(ScaleBody_Len=ScaleBody_Len);
echo(" Including scale payload bay len =",PBay_Len);
Body_Len=PBay_Len+UpperTube_Len+EBay_Len+LowerTube_Len+SusFinCan_Len;
echo(Body_Len=Body_Len);

// Phenolic Body and Coupler Tube Lengths
echo("Upper Body Tube = ",UpperTube_Len+PBay_Len);
echo("Lower Body Tube = ",LowerTube_Len);
echo("Sustainer Motor Tube = ",SustainerMotorTube_Len);
echo("Booster Body = ",InterstageTube_Len);
echo("Booster Coupler = ",InterstageTube_Len-10);
echo("Booster Motor Tube = ",Booster_Fin_Root_L+30);

NoseconeSep_Z=0; // This much of the nosecone becomes part of the fairing.
NC_Len=170*Scale;
NC_Tip_r=5*Scale;
NC_Base_L=15;
NC_Wall_t=1.8;

//BodyTubeLen=36*25.4;

module ShowCableRelease(){
	Offset_Y=7;
	Offset_Z=55;
	
	translate([0,3,0]){
	translate([0,-Offset_Y,Offset_Z]) CR_Housing();
	// LockPlate();
	translate([0,-Offset_Y,Offset_Z-7]) LockingPin();
	// BallRetainer();
	// LockPlateStop();
	translate([0,0,Offset_Z+10]) HousingStop(OD=PML54Body_ID);
	translate([0,0,Offset_Z-55]) TopMountS5245Tray();
	// ServoWheelB(UsesHS5245MGServo=true);
	// LockPlateExtension(Len=12);
	// ServoWheel(HasLockingBar=true, HasHoles=false);
	}
} // ShowCableRelease

//ShowCableRelease();

module ShowBooster(ShowInternals=true){
	
	/*
	if (ShowInternals) {
		translate([0,0,Booster_Fin_Root_L+40+InterstageTube_Len-25]) difference(){
			InterstageCouplerS();
			translate([0,0,-Overlap]) cube([50,50,50]);
		}
		translate([0,0,Booster_Fin_Root_L+26]) difference(){ 
			InterstagePiston();
			translate([0,0,-Overlap]) cube([50,50,50]);
		}
	}
	/**/
	
	if (ShowInternals) {
		translate([0,0,ROmegaBooster_Fin_Root_L+40+InterstageTube_Len-25]) difference(){
			InterstageCouplerS();
			translate([0,0,-Overlap]) cube([50,50,50]);
		}
		
		translate([0,0,BoostFinCan_Len-15]){
			translate([0,0,Booster_Coupler_Len-12]) STB_ShowBosterSpringThing(BT_ID=ROmega_Body_ID, CT_ID=ROmega_Coupler_ID);
			difference(){
				color("Blue") 
					Tube(OD=ROmega_Coupler_OD, ID=ROmega_Coupler_ID, Len=Booster_Coupler_Len, myfn=$preview? 90:360);
			
				translate([0,0,Booster_Coupler_Len-12]) for (j=[0:2]) rotate([0,0,120*j+60]) 
					rotate([90,0,0]) cylinder(d=8, h=ROmega_Coupler_OD);
			}}
		
	}
	
	if (ShowInternals==false)
		translate([0,0,BoostFinCan_Len+0.1]) color("White") 
			Tube(OD=Body_OD, ID=Body_ID, Len=InterstageTube_Len-0.2, myfn=$preview? 90:360);
	
	color("White") BoosterFinCan();
	
	if (ShowInternals) 
			color("Tan") Tube(OD=ROmega_BMtrTube_OD, ID=ROmega_BMtrTube_ID, 
									Len=BoostFinCan_Len-15, myfn=$preview? 90:360);
									
	for (j=[0:nFins]) rotate([0,0,360/nFins*j])
		translate([Body_OD/2-Booster_Fin_Post_h, 0, Booster_Fin_Root_L/2+20]) 
			rotate([0,90,0]) color("Blue") RocketOmegaBoosterFin();
			
	if (ShowInternals==false) translate([0,0,-23]) ATRMS_54_852_Motor(Extended=false, HasEyeBolt=true); // J275W, J460T, J615ST
	
	
} // ShowBooster

//ShowBooster(ShowInternals=true);
//ShowBooster(ShowInternals=false);

module ShowRocketOmega(ShowInternals=true){
	
	
	InterstageCoupler_Len=InterstageTube_Len;
	
		SusFinCan_Z=BoostFinCan_Len+InterstageCoupler_Len+1;
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
		translate([0,0,-ROmega_Coupler_OD*0.8])
			color("Gray") NoseconeBase(OD=ROmega_Body_ID, L=ROmega_Coupler_OD*0.8, NC_Base=21);
		}
	if (ShowInternals)
		translate([0,0,NC_Z-ROmega_Coupler_OD*0.8-ParachuteSleeve_Len])
			Tube(OD=ROmega_Coupler_OD, ID=ROmega_Coupler_ID, Len=ParachuteSleeve_Len, myfn=$preview? 90:360);
	
	if (ShowInternals==false){
		translate([0,0,PBay_Z+0.1]) color("Silver") 
			Tube(OD=ROmega_Body_OD, ID=ROmega_Body_ID, Len=PBay_Len-0.2, myfn=$preview? 90:360);
	
		translate([0,0,UpperTube_Z+0.1]) color("White") 
			Tube(OD=ROmega_Body_OD, ID=ROmega_Body_ID, Len=UpperTube_Len-0.2, myfn=$preview? 90:360);
	}
		
	if (ShowInternals){
		translate([0,0,SpringThing_Z]) color("Gray") cylinder(d=54, h=Spring_Len);
		translate([0,0,CR_Z]) rotate([0,0,120]) ShowCableRelease();
	}
	
	translate([0,0,EBay_Z]) {
		rotate([0,0,180-180/nFins]) color("White") Omega54EBay(ShowDoors=(ShowInternals==false));
		if (ShowInternals) translate([0,0,15-0.3])
			rotate([180,0,0]) ShockCordMount(OD=ROmega_Coupler_OD, ID=ROmega_MtrTube_OD, AnchorRod_OD=12.7);
	}
	

	if (ShowInternals==false)
		translate([0,0,LowerTube_Z+0.1]) color("White") 
			Tube(OD=ROmega_Body_OD, ID=ROmega_Body_ID, Len=LowerTube_Len-0.2, myfn=$preview? 90:360);
	
	//*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j])
		translate([ROmega_Body_OD/2-ROmega_Fin_Post_h, 0, SusFinCan_Z+ROmega_Fin_Root_L/2+20]) 
			rotate([0,90,0]) color("Blue") RocketOmegaFin();
	/**/
	
	translate([0,0,SusFinCan_Z]) {
		
		color("White") FinCan54();
		
		translate([0,0,-15]) color("Silver")
		MotorRetainer(Tube_OD=ROmega_BMtrTube_OD, Tube_ID=ROmega_BMtrTube_ID, Mtr_OD=38, MtrAC_OD=42);
		
		if (ShowInternals) 
			color("Tan") Tube(OD=ROmega_MtrTube_OD, ID=ROmega_MtrTube_ID, 
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


module Booster_Stager_CableRedirect(){
	Height=20; // make it fit in the top of the EBay
	Tube_d=12.7; // Shock cord mount
	
	Sphere_r=Body_ID/2;
	Sphere_z=5;
	Sphere_t=4;
	Crop_d=PML29Body_OD-IDXtra*2; // ID of CableRedirectTop
	
	difference(){
		union(){
			Stager_CableRedirect(Tube_OD=Body_OD, Skirt_ID=Body_ID, 
				Tube_ID=Coupler_ID, InnerTube_OD=PML29Body_OD, HasRaceway=false, Raceway_a=270, Height=Height);
			
			// The Dome
			difference(){
				translate([0,0,-Sphere_r+Sphere_z]) sphere(r=Sphere_r, $fn=$preview? 90:360);
				
				translate([0,0,-Sphere_r+Sphere_z]) sphere(r=Sphere_r-Sphere_t, $fn=$preview? 90:360);
				translate([0,0,-3]) rotate([180,0,0]) cylinder(r=Sphere_r+1, h=Sphere_r*2);
			
				translate([0,0,-5])
				difference(){
					cylinder(d=Crop_d+40, h=20);
					
					translate([0,0,-Overlap]) cylinder(d=Crop_d+1, h=20+Overlap*2, $fn=$preview? 90:360);
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
			rotate([0,90,0]) cylinder(d=Tube_d, h=Body_OD, center=true);
			
		//translate([0,0,-30]) cube([50,50,50]);
	} // difference
} // Booster_Stager_CableRedirect

//Booster_Stager_CableRedirect();

module Omega54EBay(ShowDoors=false){
	RailGuide_Z=EBay_Len-40;
	BattDoor_Z=EBay_Len/2+12;
	BattDoor_a=0;
	Rail_a=90;
	
	difference(){
		union(){
			Tube(OD=ROmega_Body_OD, ID=ROmega_Body_ID, Len=EBay_Len, myfn=$preview? 90:360);
			translate([0,0,15]) 
				CenteringRing(OD=ROmega_Body_OD-1, ID=ROmega_MtrTube_OD+IDXtra*3, 
								Thickness=5, nHoles=0, Offset=0);
			translate([0,0,EBay_Len-20])
				CenteringRing(OD=ROmega_Body_OD-1, ID=ROmega_MtrTube_OD+IDXtra*3, 
								Thickness=5, nHoles=0, Offset=0);
			// Stringers
			Stringer_X=10;
			difference(){
				for (j=[0:1]) rotate([0,0,90+180*j]) difference(){
					translate([-Stringer_X/2,-ROmega_Body_ID/2-Overlap,15])
						cube([Stringer_X,7,EBay_Len-30]);
					/*
					difference(){
						translate([-2.3,-ROmega_Body_ID/2-Overlap*2,15-Overlap])
							cube([4.6, 6, EBay_Len-30+Overlap*2]);
						cylinder(d=ROmega_MtrTube_OD+IDXtra*3+1.7*2, h=EBay_Len);
					} // difference
					/**/
				} // difference
					
				cylinder(d=ROmega_MtrTube_OD+IDXtra*3, h=EBay_Len);
			} // difference
			
		} // union
		
		//translate([0,0,EBay_Len/2]) cylinder(d=70, h=EBay_Len); // for viewing cut-away
		
		// Sustainer Igniter Wire
		translate([ROmega_Body_ID/2-2.5,0,0]) cylinder(d=5, h=50);
		translate([ROmega_Body_ID/2-2.5,0,49]) rotate([0,-15,0]) cylinder(d=5, h=30);
		
		// Rail Guide Bolts
		translate([0,0,RailGuide_Z]) rotate([0,0,Rail_a]) 
			translate([0,ROmega_Body_OD/2+2,0]) RailGuideBoltPattern(BoltSpace=12.7) Bolt6Hole();
			
		translate([0,0,EBay_Len/2]) rotate([0,0,180])
			Alt_BayFrameHole(Tube_OD=ROmega_Body_OD, DoorXtra_X=0, DoorXtra_Y=0);
			
		translate([0,0,BattDoor_Z]) rotate([0,0,BattDoor_a])
			Batt_BayFrameHole(Tube_OD=ROmega_Body_OD, Door_X=43, HasSwitch=true);
	} // difference
	
			translate([0,0,EBay_Len/2]) rotate([0,0,180])
				Alt_BayDoorFrame(Tube_OD=ROmega_Body_OD, Tube_ID=ROmega_Body_ID, 
						DoorXtra_X=0, DoorXtra_Y=0, ShowDoor=ShowDoors);

		//*
			translate([0,0,BattDoor_Z]) rotate([0,0,BattDoor_a])
				Batt_BayDoorFrame(Tube_OD=ROmega_Body_OD, Tube_ID=ROmega_Body_ID, 
						Door_X=43, HasSwitch=true, ShowDoor=false);
		/**/
	
	//*
	// Rail Guide
	rotate([0,0,Rail_a])
	difference(){
		translate([0,0,RailGuide_Z]) 
			RailGuidePost(OD=ROmega_Body_OD, MtrTube_OD=ROmega_MtrTube_OD+IDXtra*3, 
							H=ROmega_Body_OD/2+2, TubeLen=40, Length = 30, BoltSpace=12.7);
		
		// Rail Guide Bolts
		translate([0,0,RailGuide_Z])
			translate([0,ROmega_Body_OD/2+2,0]) RailGuideBoltPattern(BoltSpace=12.7) Bolt6Hole();
			
		rotate([0,0,90]) translate([0,ROmega_Body_OD/2,RailGuide_Z]) 
			rotate([0,0,120]) cube([ROmega_Body_OD-10,ROmega_Body_OD*2,60],center=true);
		
		rotate([0,0,-150]) translate([0,ROmega_Body_OD/2,RailGuide_Z]) 
			rotate([0,0,120]) cube([ROmega_Body_OD-10,ROmega_Body_OD*2,60],center=true);
	} // difference
	/**/
	
	if (ShowDoors) translate([0,0,BattDoor_Z]) rotate([0,0,BattDoor_a])
		rotate([90,0,0]) Batt_Door54(Tube_OD=PML54Body_OD, HasSwitch=true);
} // Omega54EBay

//Omega54EBay(ShowDoors=false);
//AltDoor54(Tube_OD=ROmega_Body_OD, IsLoProfile=false, DoorXtra_X=0, DoorXtra_Y=0);


module SustainerFinCan(LowerHalfOnly=false, UpperHalfOnly=false){
	TB_Xtra=10;
	Can_Len=Sustainer_Fin_Root_L+TB_Xtra*2;
	echo(Can_Len=Can_Len);
	RailGuide_Z=50;
	

	
				
	MotorRetainerHole_d=63+IDXtra*2;
	// was S_MotorTube_OD+5
	//echo(S_MotorTube_OD+5);
	
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
			//translate([0,0,-5])
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
		
		/*
		// Aluminum retainer
		translate([0,0,-42]){
			cylinder(d=MotorRetainerHole_d, h=33);
			cylinder(d=MotorRetainerHole_d+5, h=10);
		}
		/**/
	} // difference
	
	
} // SustainerFinCan

//SustainerFinCan();
nLocks=3;

module SustainerCup(Offset_a=0){
	nLocks=3;
	
	difference(){
		Stager_Cup(Tube_OD=Body_OD, ID=MotorTube_ID, nLocks=nLocks, BoltsOn=true, Collar_h=29, Offset_a=Offset_a);
		
		ID=Body_OD-6;
		
		
		// Hollow out inside
		translate([0,0,3]) cylinder(d=MotorTube_OD+2, h=50);
		
		/*
		difference(){
			union(){
				cylinder(d1=MotorTube_ID, d2=ID, h=10+Overlap);
				translate([0,0,10]) cylinder(d=ID, h=5);
				translate([0,0,15-Overlap]) cylinder(d2=MotorTube_ID, d1=ID, h=10);
			} // union
			
			for (j=[0:nLocks-1]) rotate([0,0,360/nLocks*j+Offset_a]) translate([0,ID/2,15]) cube([9.5,20,40], center=true);
		} // difference
		/**/
		
		// Igniter wirs
		rotate([0,0,30]) translate([MotorTube_OD/2+6,0,-20]) 
			cylinder(d=5, h=70);
	} // difference
} // SustainerCup

//rotate([180,0,0]) SustainerCup();

//translate([0,0,-35]) rotate([0,0,45]) SustainerCup();
	
	
module RocketOmegaFin(){
	//echo(ROmega_Fin_Post_h=ROmega_Fin_Post_h);
	
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

module BoosterFinCan(){
	TB_Xtra=20; //(Can_Len-ROmegaBooster_Fin_Root_L)/2;
	Can_Len=Booster_Fin_Root_L+TB_Xtra*2; //Booster_Body_Len;
	
	echo(TB_Xtra=TB_Xtra);
	echo(Can_Len=Can_Len);
	RailGuide_Z=40;
	
	FC2_FinCan(Body_OD=Body_OD, Body_ID=Body_ID, Can_Len=Can_Len,
				MotorTube_OD=MotorTube_OD, RailGuide_h=RailGuide_h,
				nFins=nFins, HasIntegratedCoupler=true, HasMotorSleeve=true, HasAftIntegratedCoupler=false,
				Fin_Root_W=Booster_Fin_Root_W, Fin_Root_L=Booster_Fin_Root_L, 
				Fin_Post_h=Booster_Fin_Post_h, Fin_Chamfer_L=Booster_Fin_Chamfer_L,
				Cone_Len=TailConeLen, ThreadedTC=true, Extra_OD=2, LowerHalfOnly=false, UpperHalfOnly=false, HasWireHoles=false);
	
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




































