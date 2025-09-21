// *********************************************
// Project: 2.6 inch rocket depoyment system
// Filename: Rocket6551.scad
// by David M. Flynn
// Created: 9/18/2025
// Revision: 0.9.2   9/21/2025
// Units: mm
// *********************************************
//  ***** Notes *****
//
//  This is a 2.6 inch diameter rocket, single deploy
//  Uses CableReleaseBBMini, RocketServo and a Blue Raven altimeter.
//  Uses one 4323CS spring and petal deployment system (non-pyro).
//  First built 9/21/2025 w/ LOC 29mm motor tube and 2.6" ??? tube (Estes?)
//
//  ***** History *****
//
// 0.9.2   9/21/2025  Code cleanup and small fixes. Changed fin post to 12mm.
// 0.9.1   9/20/2025  It's comming together, printing and building...
// 0.9.0   9/18/2025  Copied from RocketScooter
//
// *********************************************
//  ***** for STL output *****
//
// NoseCone();
//
// PetalHub(OD=Coupler_OD); // also nosecone base
// rotate([-90,0,0]) PD_PetalSpringHolder2();
// rotate([180,0,0]) PD_Petals2(OD=Coupler_OD, Len=Petal_Len, nPetals=nPetals, Wall_t=1.2, AntiClimber_h=4, HasLocks=true, Lock_Span_a=0);
// FwdSpringEnd(nRopes=6, Skirt_h=25);
// SE_SlidingSpringMiddle(OD=Coupler_OD, Wall_t=1.2, nRopes=6, SliderLen=35, SpLen=35, SpringStop_Z=17.5, UseSmallSpring=true);
//
//  *** CableReleaseBBMini ***
//
//  Custom_CenteringRingMount();
//  CRBBm_ExtensionRod(Len=27, ID=0.190*25.4);
//  rotate([180,0,0]) CRBBm_LockingPin(nBalls=nBalls, LockPin_d=LockPin_d, LockPin_Len=LockPin_Len, GuidePoint=GuidePoint);
//	rotate([180,0,0]) CRBBm_LockRing(nBalls=nBalls, GuidePoint=GuidePoint);
//	rotate([180,0,0]) CRBBm_TopRetainer(nBalls=nBalls, LockRing_d=CRBBm_LockRingDiameter(), Flange_t=TopRetainerFlange_t, OD=0, HasMountingBolts=true, GuidePoint=GuidePoint);
//  CRBBm_OuterBearingRetainer();
//  CRBBm_BlankInnerBearingRetainer(H=8, HasCenterHole=true);
//  rotate([180,0,0]) CRBBm_TriggerPost();
//  rotate([180,0,0]) CRBBm_MagnetBracket();
//
// CRBBm_Activator();
// EBay();
// Tube(OD=Coupler_OD, ID=Coupler_OD-2.4, Len=25, myfn=$preview? 90:180); // spacer
//
// rotate([180,0,0]) MotorTubeTopper();
//
// rotate([180,0,0]) Fincan(LowerHalfOnly=false, UpperHalfOnly=false, Hollow=true, HasSecurityRods=false, HasMotorRetainer=false);
//
// RocketFin(HasSpiralVaseRibs=false, PrinterBrim_H=0.6);
//
// RailButton();
// SnapRing();
//
// *********************************************
//  ***** for Viewing *****
//
// ShowRocket(ShowInternals=false);
// ShowRocket(ShowInternals=true);
// ShowCableRelease();
//
// *********************************************

include<TubesLib.scad>
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

// Also included
//include<CommonStuffSAEmm.scad>

$fn=$preview? 36:90;
IDXtra=0.2;
Overlap=0.05;

Bolt4Inset=4;
LooseFit=0.8; // add to hole ID

Body_OD=LOC65Body_OD;
Body_ID=LOC65Body_ID;
Coupler_OD=LOC65Coupler_OD;
Coupler_ID=Coupler_OD-1.8; // thin wall
BodyTubeLen=18*25.4;

MotorTube_OD=LOC29Body_OD;
MotorTube_ID=LOC29Body_ID;
MotorTubeLen=304;

SecurityRod_BC_d=Body_ID-(Body_ID-MotorTube_OD)/2+4;
echo(SecurityRod_BC_d=SecurityRod_BC_d);

Petal_Len=120; // 80 minimum, 100 or 120 is preferred
nPetals=3;

LockPin_d=16;
LockPin_Len=30;
TopRetainerFlange_t=6;
nBalls=3;
GuidePoint=false;
HasInnerBRServoMount=false;
Spring_OD=SE_Spring_CS4323_OD();
Spring_ID=SE_Spring_CS4323_ID();

NC_Len=155;
NC_Base_L=6;
NC_Tip_R=5;
NC_Wall_t=1.2;

//*
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
FinCan_Len=Fin_Root_L+FinInset_Len*2;
/**/

Vinyl_d=0.3;
TailCone_Len=30;
TailConeExtra_OD=2;

Thread25020_d=0.250*25.4;
CRBBm_Activator_Bolt_a=[22.5,162,253,323];
EBay_Len=84;


module ShowRocket(ShowInternals=false){
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
				PD_Petals2(OD=Coupler_OD, Len=Petal_Len, nPetals=nPetals, Wall_t=1.6, AntiClimber_h=0, HasLocks=true);
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
	translate([0,0,FinCan_Z]) color("Orange") Fincan(LowerHalfOnly=false, UpperHalfOnly=false, Hollow=true);
	
	for (j=[0:nFins-1]) rotate([0,0,360/nFins*j+180/nFins])
		translate([0, Body_OD/2-Fin_Post_h, Fin_Z]) 
			rotate([-90,0,0]) color("Orange") RocketFin(false);
		
} // ShowRocket

// ShowRocket(ShowInternals=false);
// ShowRocket(ShowInternals=true);

module ShowCableRelease(){
//*
	translate([0,0,LockPin_Len-7.5]) CRBBm_ExtensionRod(Len=16, ID=0.190*25.4);

	CRBBm_LockingPin(nBalls=nBalls, LockPin_d=LockPin_d, LockPin_Len=LockPin_Len, GuidePoint=GuidePoint);
	CRBBm_LockRing(nBalls=nBalls, GuidePoint=GuidePoint);
	CRBBm_TopRetainer(nBalls=nBalls, LockRing_d=CRBBm_LockRingDiameter(), Flange_t=TopRetainerFlange_t, OD=0, HasMountingBolts=true, GuidePoint=GuidePoint);
/**/	
	translate([0,0,-19.5]){ 
		CRBBm_OuterBearingRetainer();
		translate([0,0,-2.5]) rotate([0,0,60]) CRBBm_BlankInnerBearingRetainer(H=8, HasCenterHole=true);
		CRBBm_MagnetBracket();
		rotate([0,0,-360/9]) CRBBm_TriggerPost();
		}
//*
	translate([0,0,TopRetainerFlange_t+8.7]) Custom_CenteringRingMount();
/**/
} // ShowCableRelease

// ShowCableRelease();

module NoseCone(){
	
	BluntOgiveNoseCone(ID=Body_OD-4.4, OD=Body_OD+Vinyl_d, L=NC_Len, Base_L=NC_Base_L, nRivets=0, RivertInset=0, Tip_R=NC_Tip_R, HasThreadedTip=false, Wall_T=NC_Wall_t, Cut_d=0, LowerPortion=false, FillTip=true);

	difference(){
		PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=nPetals*2) hull(){
			cylinder(d=7, h=NC_Base_L);
			translate([0,3.5,0]) scale([1,0.2,1]) cylinder(d=9, h=NC_Base_L);
		}
		
		PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=nPetals*2) rotate([180,0,0]) Bolt4Hole();					
	} // difference
} // NoseCone

// NoseCone();

module PetalHub(OD=Coupler_OD){
	// attaches to nose cone
	
	Al_Tube_d=8;
	Skirt_h=5;
	CenterHole_d=5;
	
	translate([0,0,-Skirt_h])
	difference(){
		union(){
			PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=nPetals*2) hull(){
				cylinder(d=7, h=Skirt_h);
				translate([0,3.0,0]) scale([1,0.2,1]) cylinder(d=9, h=Skirt_h);
			}
			
			Tube(OD=Coupler_OD, ID=Coupler_OD-3.6, Len=Skirt_h, myfn=$preview? 90:360);
			
			cylinder(d=CenterHole_d+6, h=Skirt_h+Overlap);
		} // union
		
		PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=nPetals*2) rotate([180,0,0]) Bolt4ClearHole();
		translate([0,0,-Overlap]) cylinder(d=CenterHole_d, h=Skirt_h+Overlap*3);
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
		translate([0,0,-Skirt_h-Overlap]) cylinder(d=CenterHole_d, h=30);
		
		// Aluminum Tube
		//translate([0,0,Al_Tube_d/2+3]) rotate([0,0,90]) rotate([90,0,0]) cylinder(d=Al_Tube_d, h=Body_OD, center=true);
	} // difference
} // PetalHub

// PetalHub();

module FwdSpringEnd(nRopes=0, Skirt_h=25){
	CR_t=2;
	Rope_d=3;
	OD=Coupler_OD;
	Petal_ID=Coupler_OD-3.5; // should fit loose
	PetalLock_ID=Coupler_OD-7.5; // Should not touch at all
	ShockCord_Y=Spring_ID/2-2.2-Rope_d/2-1;
	
	difference(){
		union(){
			difference(){
				cylinder(d=OD, h=6, $fn=$preview? 90:360);
				
				translate([0,0,CR_t-Overlap]) cylinder(d1=Coupler_ID-4, d2=Coupler_ID, h=4+Overlap*2, $fn=$preview? 90:360);
			} // difference
			
			// Skirt
			Tube(OD=Coupler_OD, ID=Coupler_ID, Len=Skirt_h, myfn=$preview? 90:360);
			
			difference(){
				cylinder(d=Coupler_OD, h=CR_t+5.5, $fn=$preview? 90:360);
				
				translate([0,0,CR_t]) cylinder(d=PetalLock_ID-2.8, h=4.5, $fn=$preview? 90:360);
				
				translate([0,0,CR_t+3.5]) cylinder(d1=PetalLock_ID-2.8, d2=Coupler_ID, h=3.5+Overlap, $fn=$preview? 90:360);
			} // difference
			
			// Spring
			Tube(OD=Spring_ID, ID=Spring_ID-4.4, Len=CR_t+4, myfn=$preview? 90:360);
			
		} // union
		
		translate([0,0,CR_t]) Bolt10Hole();
		
		// Shock cord
		rotate([0,0,30]) translate([0,ShockCord_Y,-Overlap]) cylinder(d=4, h=30);
		
		// Petal Locks
		difference(){
			translate([0,0,-Overlap]) cylinder(d=Coupler_OD+1, h=4.5+Overlap*2, $fn=$preview? 90:360);
			
			// Puller ring
			translate([0,0,-Overlap*2]) cylinder(d=Petal_ID, h=2+Overlap*3, $fn=$preview? 90:360);
			// Petal lock
			translate([0,0,-Overlap*2]) cylinder(d=PetalLock_ID, h=4.5+Overlap*3, $fn=$preview? 90:360);
			
		} // difference
		
		// Rope holes
		if (nRopes>0) for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j]) 
			translate([0,Spring_OD/2+Rope_d/2+2,-Overlap]) cylinder(d=Rope_d, h=CR_t+Overlap*2);
			
		//if ($preview) translate([0,0,-Overlap]) cube([100,100,100]);
	} // difference
	
} // FwdSpringEnd

// FwdSpringEnd(nRopes=6);

module Custom_CenteringRingMount(){
	ShockCordHole_d=5;
	ShockCord_a=30;
	Thickness=7;
	
	difference(){
		CRBBm_CenteringRingMount(Tube_ID=Body_ID, Thickness=Thickness, Skirt_Len=0, nBolts=3, nRopes=6, HasShockcodeAnchor=false, 
									LockRing_d=CRBBm_LockRingDiameter(), Spring_OD=Spring_OD, Spring_ID=Spring_ID);
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
	
	Magnet_d=3/16*25.4;
	Magnet_Z=-3-Magnet_d/2;
	Magnet_a=180;
	
	Servo_Z=-17.5;
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
			translate([0,CRBBm_BottomBoltCircle_d()/2,-8])
				rotate([180,0,0]) Bolt4HeadHole(depth=8,lHead=8);
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
			translate([0,0,-Plate_t]) cylinder(d=Plate_d, h=Plate_t);
			
			intersection(){
				rotate([0,0,ServoPos_a]) translate([0,Servo_Y,Servo_Z])
					rotate([0,0,ServoRot_a]) ServoSG90TopBlock(Xtra_Len=4, Xtra_Width=-Overlap, Xtra_Height=2, HasWireNotch=false);
					
				translate([0,0,Servo_Z]) cylinder(d=Coupler_OD, h=10);
			} // intersection

		} // union
		rotate([0,0,ServoPos_a]) translate([0,Servo_Y,Servo_Z]) translate([0,0,10]) hull(){
			cylinder(d=9, h=8);
			translate([0,3,0]) cylinder(d=14, h=8);
		} // hull
		
		TopMountingBolts();
		
		// center hole
		//translate([0,0,-Plate_t-Overlap]) cylinder(d=6, h=Plate_t+Overlap*2);
		translate([0,0,-Plate_t-Overlap]){
			Thread_d=Thread25020_d;
			Thread_p=25.4/20;
		
			translate([0,0,-Overlap])
					cylinder(d1=Thread_d+2, d2=Thread_d, h=2);
			if ($preview){
				cylinder(d=Thread_d, h=Plate_t+Overlap*2); 
			}else{
				ExternalThread(Pitch=Thread_p, Dia_Nominal=Thread_d+IDXtra*2, 
						Length=Plate_t+Overlap*2, 
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
// translate([0,0,81.7+22.2]) ShowCableRelease();

module EBay(){
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
	
	rotate([0,0,RocketServo_a]) translate([0,RocketServo_Y,RocketServo_Z]) rotate([0,180,0]) rotate([90,0,0]) RocketServoHolderRevC(IsDouble=false);
	
	rotate([0,0,Battery_a]) translate([Battery_X,Battery_Y,Battery_Z]) rotate([0,0,-90]) BattPocket();
	
} // EBay

// EBay();
//translate([0,0,85]) rotate([0,0,155]) CRBBm_Activator();

module EBay_TopPlate(OD=Coupler_OD){
	nOuterBolts=2;
	Outer_BC_d=SecurityRod_BC_d;
	Boss_t=8;
	Thread1024_d=0.190*25.4;
	Activator_a=178;
	
	Tube(OD=OD, ID=OD-4, Len=Boss_t, myfn=$preview? 90:360);
	
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

module EBay_BasePlate(OD=Coupler_OD, IsLowerPlate=false){
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
			Tube(OD=Coupler_OD, ID=Coupler_ID, Len=Boss_t, myfn=$preview? 90:360);
			
			// Bolt bosses
			if (!IsLowerPlate)
				cylinder(d=Thread25020_d+4.4, h=Boss_t);
			
			if (nOuterBolts>0)
				for (j=[0:nOuterBolts-1]) rotate([0,0,360/nOuterBolts*j])
					translate([0,Outer_BC_d/2,0]) cylinder(d=Thread1024_d+4.4, h=Boss_t);
					
			if (nOuterBolts>0 && IsLowerPlate)
				for (j=[0:nOuterBolts-1]) rotate([0,0,360/nOuterBolts*j+LP_OuterBolt_a])
					translate([0,Outer_BC_d/2,0]) cylinder(d=Thread1024_d+4.4, h=Boss_t);
			
		} // union
		
		// Motor tube hole
		if (IsLowerPlate) translate([0,0,-Overlap]) cylinder(d=33, h=Plate_t+Overlap*2);
			
		// Shock cord
		ShockCord_a=-30;
		rotate([0,0,ShockCord_a]) translate([0,Coupler_ID/2-4,-Overlap]) cylinder(d=6, h=Plate_t+Overlap*2);
		
		if (!IsLowerPlate)
		translate([0,0,-Overlap]){
			Thread_d=Thread25020_d;
			Thread_p=25.4/20;
		
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
							
					rotate([0,0,360/nOuterBolts*j+LP_OuterBolt_a])
						translate([0,Outer_BC_d/2,Plate_t]) Bolt10ClearHole();
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
			Tube(OD=OD, ID=OD-2.4, Len=Len, myfn=$preview? 90:myfn);
			Tube(OD=ID+IDXtra+2.4, ID=ID+IDXtra, Len=Len, myfn=$preview? 90:myfn);
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

// rotate([180,0,0]) MotorTubeTopper();

module Fincan(LowerHalfOnly=false, UpperHalfOnly=false, Hollow=true, HasSecurityRods=false, HasMotorRetainer=false){
	Wall_t=1.0;
	HasMotorSleeve=false;
	AftClosure_OD=HasMotorRetainer? 32.2+IDXtra*2:0;
	TailConeExtra_OD=HasMotorRetainer? HasMotorRetainer:0;
	
	SecurityRodHole_d=0.190*25.4+LooseFit;
	SecurityWrenchHole_d=15;
	SecurityWrenchHole_h=TailCone_Len-5;
	SecurityRodHole_a=17.5;
	
	
	difference(){
		FC2_FinCan(Body_OD=Body_OD+Vinyl_d, Body_ID=Body_ID, Can_Len=FinCan_Len,
				MotorTube_OD=MotorTube_OD, RailGuide_h=1, RailGuideLen=0, // rail button
				nFins=nFins, HasIntegratedCoupler=true, HasMotorSleeve=HasMotorSleeve, HasAftIntegratedCoupler=false,
				Fin_Root_W=Fin_Root_W, Fin_Root_L=Fin_Root_L, Fin_Post_h=Fin_Post_h, Fin_Chamfer_L=Fin_Chamfer_L,
				Cone_Len=TailCone_Len, ThreadedTC=false, Extra_OD=TailConeExtra_OD,
				LowerHalfOnly=LowerHalfOnly, UpperHalfOnly=UpperHalfOnly, HasWireHoles=false, HollowTailcone=Hollow, 
				HollowFinRoots=Hollow, Wall_t=Wall_t, UseTrapFin3=true, AftClosure_OD=AftClosure_OD, AftClosure_Len=15);
		
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
	} // difference
} // Fincan

// Fincan(LowerHalfOnly=false, UpperHalfOnly=false, Hollow=true, HasSecurityRods=false, HasMotorRetainer=false);
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









