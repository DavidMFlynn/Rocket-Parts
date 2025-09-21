// *********************************************
// Project: 2 inch rocket depoyment system
// Filename: RocketScooter.scad
// by David M. Flynn
// Created: 9/14/2025
// Revision: 0.9.0   9/14/2025
// Units: mm
// *********************************************
//  ***** Notes *****
//
//  ***** History *****
//
// *********************************************
//  ***** for STL output *****
//
// NoseCone();
//
// NoSpringPetalHub(OD=Coupler_OD);
// rotate([-90,0,0]) PetalNotSpringHolder();
// rotate([180,0,0]) PD_Petals2(OD=Coupler_OD, Len=Petal_Len, nPetals=nPetals, Wall_t=1.2, AntiClimber_h=0, HasLocks=true, Lock_Span_a=0);
// FwdSpringEnd(nRopes=6);
// SE_R38SlidingSmallSpringMiddle(OD=Coupler_OD, Len=30);
// SE_R38SlidingSmallSpringMiddle(OD=Coupler_OD-3, Len=25, nRopes=6); // alt
//
//  *** CableReleaseBB ***
//
//  CRBB_ExtensionRod(Len=16, ID=0.190*25.4);
//  rotate([180,0,0]) LockingPin();
//	rotate([180,0,0]) CRBB_LockRing(nBalls=nBalls, GuidePoint=GuidePoint);
//	rotate([180,0,0]) CRBB_TopRetainer(nBalls=nBalls, LockRing_d=CRBB_LockRingDiameter(), Flange_t=4, OD=Coupler_OD, HasMountingBolts=true, GuidePoint=GuidePoint);
//  CRBB_OuterBearingRetainer();
//  CRBB_BlankInnerBearingRetainer(H=8, HasCenterHole=true);
//  CRBB_CenteringRingMount(Tube_ID=Body_ID, Thickness=4, Skirt_Len=0, Skirt_t=1.2, nBolts=3, nRopes=6, HasShockcodeAnchor=false, LockRing_d=CRBB_LockRingDiameter(),Spring_OD=SE_Spring3670_OD(), Spring_ID=SE_Spring3670_ID()); // min 3.5, 10
//  rotate([180,0,0]) CRBB_TriggerPostSmall();
//  rotate([180,0,0]) CRBB_MagnetBracketSmall();
//
// MotorTubeTopper();
//
// Fincan(LowerHalfOnly=false, UpperHalfOnly=false, Hollow=true);
// SnapRing();
// RocketFin(HasSpiralVaseRibs=false, PrinterBrim_H=0.6);
//
// RailButtonMount();
//
// *********************************************
//  ***** for Viewing *****
//
// ShowCableRelease();
//
// *********************************************

include<TubesLib.scad>
use<SpringEndsLib.scad>
use<PetalDeploymentLib.scad>
use<CableReleaseBB.scad>
use<BatteryHolderLib.scad>
use<ThreadLib.scad>
use<SG90ServoLib.scad>
use<Fins.scad>
use<FinCan2Lib.scad>
use<NoseCone.scad>

// Also included
//include<CommonStuffSAEmm.scad>

$fn=$preview? 36:90;
IDXtra=0.2;
Overlap=0.05;

Body_OD=LOC54Body_OD;
Body_ID=LOC54Body_ID;
Coupler_OD=LOC54Coupler_OD;
Coupler_ID=Coupler_OD-1.8; // thin wall
BodyTubeLen=500;

MotorTube_OD=LOC29Body_OD;
MotorTube_ID=LOC29Body_ID;
MotorTubeLen=304;


Petal_Len=80; // 80 minimum, 100 or 120 is preferred
nPetals=2;

LockPin_d=20;
LockPin_Len=40;
nBalls=3;
GuidePoint=false;
HasInnerBRServoMount=false;
Spring_OD=SE_Spring3670_OD();
Spring_ID=SE_Spring3670_ID();

NC_Len=115;
NC_Base_L=6;
NC_Tip_R=5;
NC_Wall_t=1.2;

//*
// Small fins
nFins=5;
Fin_Post_h=Body_OD/2-MotorTube_OD/2-1.2;
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
TailCone_Len=20;
TailConeExtra_OD=2;



module ShowRocket(ShowInternals=false){
	FinCan_Z=TailCone_Len;
	Fin_Z=FinCan_Z+FinCan_Len/2;
	MotorTube_Z=FinCan_Z-TailCone_Len+12;
	EBay_Z=MotorTube_Z+MotorTubeLen+3+32.4;
	BodyTube_Z=FinCan_Z+FinCan_Len+Overlap*2;
	NoseCone_Z=BodyTube_Z+BodyTubeLen+0.1;
	
	SCR_Z=NoseCone_Z-7.2-9-Petal_Len-30.5-35-35-14;
	
	echo(str("Overall Length = ",(NoseCone_Z+NC_Len)/25.4));

	translate([0,0,NoseCone_Z]){
		rotate([0,0,90]) color("Orange") NoseCone();
		
		if (ShowInternals)
			color("Tan") rotate([180,0,0]) NoSpringPetalHub(OD=Coupler_OD);
			
		if (ShowInternals){
			translate([0,0,-9.5]) rotate([180,0,0]) 
				PD_Petals2(OD=Coupler_OD, Len=Petal_Len, nPetals=nPetals, Wall_t=1.6, AntiClimber_h=0, HasLocks=true);
				
			
			

		}
	}
	
	if (ShowInternals){
		translate([0,0,SCR_Z]) ShowCableRelease();
		translate([0,0,EBay_Z]) EBay();
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

module ShowCableRelease(){

	translate([0,0,LockPin_Len-7.5]) CRBB_ExtensionRod(Len=16, ID=0.190*25.4);

	LockingPin();
	CRBB_LockRing(nBalls=nBalls, GuidePoint=GuidePoint);
	CRBB_TopRetainer(nBalls=nBalls, LockRing_d=CRBB_LockRingDiameter(), Flange_t=4, OD=Coupler_OD, HasMountingBolts=true, GuidePoint=GuidePoint);
	
	translate([0,0,-19.5]){ 
		CRBB_OuterBearingRetainer();
		translate([0,0,-2.5]) CRBB_BlankInnerBearingRetainer(H=8, HasCenterHole=true);
		CRBB_MagnetBracketSmall();
		rotate([0,0,-360/15]) CRBB_TriggerPostSmall();
		}

	translate([0,0,12.7]) 
		CRBB_CenteringRingMount(Tube_ID=Body_ID, Thickness=4, Skirt_Len=0, nBolts=3, HasShockcodeAnchor=false, LockRing_d=CRBB_LockRingDiameter(),Spring_OD=SE_Spring3670_OD(), Spring_ID=SE_Spring3670_ID());

} // ShowCableRelease

// ShowCableRelease();


module NoseCone(){
	
	BluntOgiveNoseCone(ID=Body_OD-4.4, OD=Body_OD, L=NC_Len, Base_L=NC_Base_L, nRivets=0, RivertInset=0, Tip_R=NC_Tip_R, HasThreadedTip=false, Wall_T=NC_Wall_t, Cut_d=0, LowerPortion=false, FillTip=true);

	difference(){
		PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=4) hull(){
			cylinder(d=7, h=NC_Base_L);
			translate([0,3.5,0]) scale([1,0.2,1]) cylinder(d=9, h=NC_Base_L);
		}
		
		PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=4) rotate([180,0,0]) Bolt4Hole();					
	} // difference
} // NoseCone

// NoseCone();

module RailButtonMount(){
	H=10;
	Wedge_a=10;
	
	difference(){
		cylinder(d=Body_ID, h=H);
		
		// Remove not wedge part
		translate([0,-Body_ID/2-Overlap,-Overlap]) 
			rotate([0,0,-Wedge_a]) cube([Body_ID/2, Body_ID+1, H+Overlap*2]);
		mirror([1,0,0]) translate([0,-Body_ID/2-Overlap,-Overlap]) 
			rotate([0,0,-Wedge_a]) cube([Body_ID/2, Body_ID+1, H+Overlap*2]);
		translate([-MotorTube_OD/2,-Body_ID/2-Overlap,-Overlap]) cube([MotorTube_OD, MotorTube_OD/2, H+Overlap*2]);
		
		// Motor tube
		translate([0,0,-Overlap]) cylinder(d=MotorTube_OD, h=H+Overlap*2);
		// Rail buttom bolt
		translate([0,Body_ID/2,H/2]) rotate([-90,0,0]) Bolt8Hole();
	} // difference
} // RailButtonMount

// RailButtonMount();

module PetalNotSpringHolder(){
	// No Spring

	difference(){
		PD_PetalSpringHolder2();
		
		translate([0,-19.45,5.95]) cube([20,20,20], center=true);
	} // difference
	
} // PetalNotSpringHolder

// rotate([-90,0,0]) PetalNotSpringHolder();

module NoSpringPetalHub(OD=Coupler_OD){
	// attaches to nose cone, no springs
	
	Al_Tube_d=8;
	Skirt_h=5;
	
	translate([0,0,-Skirt_h])
	difference(){
		union(){
			PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=4) hull(){
				cylinder(d=7, h=Skirt_h);
				translate([0,3.0,0]) scale([1,0.2,1]) cylinder(d=9, h=Skirt_h);
			}
			
			Tube(OD=Coupler_OD, ID=Coupler_OD-3.6, Len=Skirt_h, myfn=$preview? 90:360);
		} // union
		
		PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=4) rotate([180,0,0]) Bolt4ClearHole();					
	} // difference
	
	difference(){
		PD_PetalHub(OD=OD, 
					nPetals=nPetals, 
					HasReplaceableSpringHolder=false,
					HasBolts=true,
					nBolts=4, // Same as nPetals
					ShockCord_a=-1,
					HasNCSkirt=false, 
						Body_OD=BT75Body_OD,
						Body_ID=BT75Body_ID,
						NC_Base=0, 
						SkirtLen=10, 
					CenterHole_d=0, nRopes=0);
					
		// remove center
		translate([0,0,-Overlap]) cylinder(d=28, h=30);
		//translate([0,0,6]) cylinder(d=28, h=30);
		
		// Aluminum Tube
		translate([0,0,Al_Tube_d/2+3]) rotate([0,0,90]) rotate([90,0,0]) cylinder(d=Al_Tube_d, h=Body_OD, center=true);
	} // difference
} // NoSpringPetalHub

// NoSpringPetalHub();

module FwdSpringEnd(nRopes=0){
	CR_t=2;
	Skirt_h=23;
	Rope_d=3;
	OD=Coupler_OD;
	
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
				
				translate([0,0,CR_t]) cylinder(d=Coupler_OD-7-2.8, h=4.5, $fn=$preview? 90:360);
				
				translate([0,0,CR_t+3.5]) cylinder(d1=Coupler_OD-7-2.8, d2=Coupler_ID, h=3.5+Overlap, $fn=$preview? 90:360);
			} // difference
			
			Tube(OD=Spring_OD+4.4, ID=Spring_OD, Len=CR_t+4, myfn=$preview? 90:360);
			
		} // union
		
		translate([0,0,CR_t]) Bolt10Hole();
		
		// Shock cord
		translate([0,12,-Overlap]) cylinder(d=4, h=30);
		
		// Petal Locks
		difference(){
			translate([0,0,-Overlap]) cylinder(d=Coupler_OD+1, h=4.5+Overlap*2, $fn=$preview? 90:360);
			
			// Puller ring
			translate([0,0,-Overlap*2]) cylinder(d=Coupler_OD-3, h=2+Overlap*3, $fn=$preview? 90:360);
			// Petal lock
			translate([0,0,-Overlap*2]) cylinder(d=Coupler_OD-7, h=4.5+Overlap*3, $fn=$preview? 90:360);
			
		} // difference
		
		// Rope holes
		if (nRopes>0) for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j]) 
			translate([0,Spring_OD/2+Rope_d/2+3,-Overlap]) cylinder(d=Rope_d, h=CR_t+Overlap*2);
			
		if ($preview) translate([0,0,-Overlap]) cube([100,100,100]);
	} // difference
	
} // FwdSpringEnd

// FwdSpringEnd(nRopes=6);

module LockingPin(){
	Bore_d=0.2*25.4+IDXtra*2;
	
	difference(){
		CRBB_LockingPin(nBalls=nBalls, LockPin_d=LockPin_d, LockPin_Len=LockPin_Len, GuidePoint=GuidePoint, IsThreaded=true, Use1024Thread=true);
		
		
		translate([0,0,-16]) cylinder(d=Bore_d, h=36);
		hull(){
			translate([0,0,14]) sphere(d=Bore_d);
			translate([0,10,24]) sphere(d=Bore_d);
		} // hull
		
		if ($preview) translate([0,0,-16]) cube([20,20,40]);
	} // difference
} // LockingPin

//LockingPin();

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



Bolt4Inset=4;
module CRBB_Activator_BoltBoss(D=8, H=5){
	OD=Coupler_OD;
	ID=Coupler_ID;
	BC_r=ID/2-3.0;
	
	difference(){
		hull(){
			translate([0,BC_r,0]) cylinder(d=D, h=H);
			translate([0,ID/2,0]) scale([1,0.1,1]) cylinder(d=D+2, h=H);
		} // hull
		translate([0,BC_r,H]) children();
	} // difference
	
} // CRBB_Activator_BoltBoss

CRBB_Activator_Bolt_a=[22.5,162,253,323];
/*
for (j=CRBB_Activator_Bolt_a) rotate([0,0,j]) {
translate([0,0,EBay_Len-5]) CRBB_Activator_BoltBoss(D=7, H=5) Bolt4Hole();
translate([0,0,EBay_Len]) CRBB_Activator_BoltBoss(D=7, H=4.5) Bolt4ClearHole();
}
/**/

module CRBB_Activator(){
	Plate_t=6;
	Plate_d=CRBB_BottomBoltCircle_d()+Bolt4Inset*2+6;
	Magnet_d=3/16*25.4;
	Magnet_Z=-3-Magnet_d/2;
	Magnet_a=-360*(2/5);
	Servo_Z=-17.5;
	Servo_Y=CRBB_LockRingBoltCircle_d()/2-1-6.5;
	ServoRot_a=-20;
	ServoPos_a=-15;
	
	module TopMountingBolts(){
		nBolts=5;
		
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j])
			translate([0,CRBB_BottomBoltCircle_d()/2,-8])
				rotate([180,0,0]) Bolt4HeadHole(depth=8,lHead=8);
	} // TopMountingBolts
	
	module MagnetHole(){
		translate([0,0,Magnet_Z]) rotate([0,90,0]) cylinder(d=Magnet_d, h=5, center=true);
	} // MagnetHole
	
	module MagnetPost(){
		H=-Servo_Z-2.5-2;
		W=3.5;
		
		
		rotate([0,0,Magnet_a])
		translate([W,CRBB_LockRingBoltCircle_d()/2-1,0])
		difference(){
			hull(){
				translate([0,-3,-2-H]) cylinder(d=W, h=H);
				translate([0,4,-2-H]) cylinder(d=W, h=H);
			} // hull
			
			MagnetHole();
		} // difference
	} // MagnetPost
	
	MagnetPost();
	
	translate([0,0,Servo_Z+2.5]) Tube(OD=Coupler_OD, ID=Coupler_ID, Len=4.5, myfn=$preview? 90:360);
	
	// Spokes
	Spoke_a=[45,90,135,170,206,245,266,286];
	for (j=Spoke_a) difference(){
		rotate([0,0,j]) hull(){
			translate([0,Plate_d/2-1.2,-Plate_t]) cylinder(d=1.2, h=Plate_t);
			translate([0,Coupler_OD/2-0.6,Servo_Z+2.5]) cylinder(d=1.2, h=4.5);
		} // hull
		
		if (j==206) rotate([0,0,Magnet_a])
			translate([3.5,CRBB_LockRingBoltCircle_d()/2-1,0]) MagnetHole();
	} // difference
	
	
	rotate([0,0,18]) hull(){
		translate([0,Plate_d/2-5.5,-Plate_t]) cylinder(d=1.2, h=Plate_t);
		translate([0,Coupler_OD/2-0.6,Servo_Z+2.5]) cylinder(d=1.2, h=4.5);
	} // hull
	
	ServoStruts_a=[18,28,266,286];
	
	for (j=ServoStruts_a) rotate([0,0,j]) hull(){
		translate([0,Coupler_OD/2-0.6,Servo_Z+2.5]) cylinder(d=1.2, h=4.5);
		translate([0,Coupler_OD/2-8.5,Servo_Z+2.5]) cylinder(d=1.2, h=4.5);
	} // hull
	
	//for (j=CRBB_Activator_Bolt_a) rotate([0,0,j-128]) 
	//	translate([0,0,Servo_Z+2.5]) CRBB_Activator_BoltBoss(D=7, H=4.5) Bolt4ClearHole();

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
		translate([0,0,-Plate_t-Overlap]) cylinder(d=6, h=Plate_t+Overlap*2);
	} // difference
		
	translate([0,0,-18]) rotate([0,0,54]) EBay_TopPlate();
	
	if ($preview){
	rotate([0,0,ServoPos_a]) translate([0,Servo_Y,Servo_Z]) color("Red") rotate([0,0,ServoRot_a]) ServoSG90(TopMount=false, HasGear=true);
	//translate([0,0,Servo_Z+3]) cylinder(d=Body_ID, h=1);
	}
	
	
} // CRBB_Activator

//translate([0,0,81.7]) rotate([0,0,125]) CRBB_Activator();
//translate([0,0,-18]) rotate([0,0,54]) EBay_TopPlate();

EBay_Len=66.5;

module EBay(){
	Raven_Z=30;
	Raven_a=-103;
	RocketServo_Z=33.5;
	RocketServo_a=0;
	Mag_SW_a=0;
	Battery_Z=22.2;
	Battery_X=0;
	Battery_Y=15.3;
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
		
		//*
	// Gussets
	hull(){
		translate([-2,8,0]) cylinder(d=1.2, h=Batt_Z+3);
		translate([-4.5,6,0]) cylinder(d=1.2, h=Batt_Z+3);
	} // hull
	/**/
	
	// Mag_Sw
	translate([18,0,0])
	hull(){
		H=18.5;
		translate([-7,0,0]) cylinder(d=4, h=H);
		translate([7,0,0]) cylinder(d=4, h=H);
	} // hull
	
	// Raven
	rotate([0,0,-13]) translate([7,8,0])
	hull(){
		translate([-9,0,0]) cylinder(d=6, h=7);
		translate([9,0,0]) cylinder(d=6, h=7);
	} // hull
		
	difference(){
		EBay_BasePlate();
		
		// Battery pushing hole and cleanup inside
		rotate([0,0,Battery_a]) translate([Battery_X,Battery_Y,Battery_Z]) rotate([0,0,-90]) {
			translate([0,0,2]) BattHole(Xtra_X=0, Xtra_Y=0, Xtra_Z=4);
			translate([0,0,-Batt_Z/2-4-Overlap]) cylinder(d=5,h=5);}
	} // difference

	rotate([0,0,Mag_SW_a]) translate([18.5,2,28]) rotate([0,0,0]) rotate([90,0,0]) FW_MagSw_Mount(HasMountingEars=false);
	
	difference(){
		rotate([0,0,Raven_a]) translate([-5,7,Raven_Z]) rotate([0,-90,0]) BlueRavenMount();
		
		rotate([0,0,Mag_SW_a]) translate([18.5,2,28]) rotate([0,0,0]) rotate([90,0,0]) FW_MagSw_BoltPattern() Bolt4Hole();
	} // difference
	
	rotate([0,0,RocketServo_a]) translate([5,-6.2,RocketServo_Z]) rotate([0,180,0]) rotate([90,0,0]) RocketServoHolderRevC(IsDouble=false);
	
	rotate([0,0,Battery_a]) translate([Battery_X,Battery_Y,Battery_Z]) rotate([0,0,-90]) BattPocket();
	
} // EBay

// EBay();

module Fixture_Fins(nFins=3){
	H=5;
	Span=70;
	Tab_h=40;
	Tab_w=7;
	Fin_t=3;
	
	Tube(OD=MotorTube_ID+30, ID=MotorTube_ID, Len=H, myfn=$preview? 90:360);
	Tube(OD=MotorTube_ID+4.4, ID=MotorTube_ID, Len=20, myfn=$preview? 90:360);
	
	for (j=[0:nFins-1]) rotate([0,0,360/nFins*j])
	translate([0,Span,0]){
		translate([0,-Span/2+20,0]) RoundRect(X=30, Y=Span, Z=H, R=5);
		translate([-Tab_w/2-Fin_t/2,-15,0]) 
			hull(){
				cylinder(d=Tab_w, h=Tab_h);
				translate([0,30,0]) cylinder(d=Tab_w, h=Tab_h);
			} // hull
	}
} // Fixture_Fins

// Fixture_Fins();

module Jig_CenteringRingDrilling(){
	H=5;
	Bore_d=3;
	Boss_h=10;
	OD=Coupler_OD;
	Outer_BC_d=MotorTube_OD+(OD-MotorTube_OD)/2;
	Fin_a=15;
	
	difference(){
		union(){
			difference(){
				cylinder(d=OD, h=H);
				translate([-OD/2-Overlap,0,-Overlap]) cube([OD+Overlap*2, OD/2+Overlap*2, H+Overlap*2]);
			} // difference
			
			translate([-Outer_BC_d/2,0,0]) cylinder(d=Bore_d+4.4, h=Boss_h);
			translate([Outer_BC_d/2,0,0]) cylinder(d=Bore_d+4.4, h=Boss_h);
			translate([0,-Outer_BC_d/2,0]) cylinder(d=Bore_d+4.4, h=Boss_h);
			
			// Fins
			rotate([0,0,Fin_a]) hull(){
				translate([-OD/2+1,0,0]) cylinder(d=2, h=H+2);
				translate([-OD/2+5,0,0]) cylinder(d=2, h=H+2);
			} // hull
			rotate([0,0,Fin_a+120]) hull(){
				translate([-OD/2+1,0,0]) cylinder(d=2, h=H+2);
				translate([-OD/2+5,0,0]) cylinder(d=2, h=H+2);
			} // hull
		} // union
		
		translate([0,0,-Overlap]) cylinder(d=MotorTube_OD+IDXtra, h=H+Overlap*2);
		
		
		translate([-Outer_BC_d/2,0,-Overlap]) cylinder(d=Bore_d, h=Boss_h+Overlap*2);
		translate([Outer_BC_d/2,0,-Overlap]) cylinder(d=Bore_d, h=Boss_h+Overlap*2);
	} // difference
	
} // Jig_CenteringRingDrilling

// mirror([1,0,0]) Jig_CenteringRingDrilling();

module EBay_TopPlate(OD=Coupler_OD){
	nOuterBolts=2;
	Outer_BC_d=MotorTube_OD+(OD-MotorTube_OD)/2;
	Boss_t=8;
	Thread1024_d=0.190*25.4;
	Activator_a=178;
	
	Tube(OD=OD, ID=OD-4, Len=Boss_t, myfn=$preview? 90:360);
	
	//for (j=CRBB_Activator_Bolt_a) rotate([0,0,j+Activator_a]) 
	//	CRBB_Activator_BoltBoss(D=7, H=Boss_t) Bolt4Hole();

	difference(){
		if (nOuterBolts>0)
			for (j=[0:nOuterBolts-1]) rotate([0,0,360/nOuterBolts*j])
					translate([0,Outer_BC_d/2,0]) hull(){
						cylinder(d=Thread1024_d+4.4, h=Boss_t);
						translate([0,5,0]) scale([1,0.1,1]) cylinder(d=Thread1024_d+6.4, h=Boss_t);
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
	Outer_BC_d=MotorTube_OD+(OD-MotorTube_OD)/2;
	LP_OuterBolt_a=22.5;
	Nut_a=IsLowerPlate? 180:0;
	
	Thread1024_d=0.190*25.4;
	Thread25020_d=0.250*25.4;
	
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
		}
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
		translate([15,15,-Overlap]) cylinder(d=6, h=Plate_t+Overlap*2);
		
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
			}}
	
		
		if (nOuterBolts>0)
			if (IsLowerPlate){
				for (j=[0:nOuterBolts-1]){
					rotate([0,0,360/nOuterBolts*j+LP_OuterBolt_a]) 
						translate([0,Outer_BC_d/2,-Overlap]) ThreadedHole(Chamfer=true);
						
				
					rotate([0,0,360/nOuterBolts*j]) 
						translate([0,Outer_BC_d/2,-Overlap]) rotate([0,0,Nut_a]) ThreadedHole();
					
				}
					
			}else{
				for (j=[0:nOuterBolts-1]){
					rotate([0,0,360/nOuterBolts*j])
						translate([0,Outer_BC_d/2,-Overlap]) ThreadedHole();
							
					rotate([0,0,360/nOuterBolts*j+LP_OuterBolt_a])
						translate([0,Outer_BC_d/2,Plate_t]) Bolt10ClearHole();
			}}
				

	} // difference
} // EBay_BasePlate

// EBay_BasePlate(IsLowerPlate=true);
// EBay_BasePlate(IsLowerPlate=false);


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


module Fincan(LowerHalfOnly=false, UpperHalfOnly=false, Hollow=true){
	Wall_t=1.0;
	HasMotorSleeve=false;
	AftClosure_OD=31.8;
	
	difference(){
		FC2_FinCan(Body_OD=Body_OD+Vinyl_d, Body_ID=Body_ID, Can_Len=FinCan_Len,
				MotorTube_OD=MotorTube_OD, RailGuide_h=1, RailGuideLen=0, // rail button
				nFins=nFins, HasIntegratedCoupler=true, HasMotorSleeve=HasMotorSleeve, HasAftIntegratedCoupler=false,
				Fin_Root_W=Fin_Root_W, Fin_Root_L=Fin_Root_L, Fin_Post_h=Fin_Post_h, Fin_Chamfer_L=Fin_Chamfer_L,
				Cone_Len=TailCone_Len, ThreadedTC=false, Extra_OD=TailConeExtra_OD,
				LowerHalfOnly=LowerHalfOnly, UpperHalfOnly=UpperHalfOnly, HasWireHoles=false, HollowTailcone=Hollow, 
				HollowFinRoots=Hollow, Wall_t=Wall_t, UseTrapFin3=true, AftClosure_OD=AftClosure_OD, AftClosure_Len=15);
		
		// Snap ring groove
		translate([0,0,-TailCone_Len+3]) cylinder(d=AftClosure_OD+2.5, h=2);
		translate([0,0,-TailCone_Len+5-Overlap]) cylinder(d1=AftClosure_OD+2.5, d2=AftClosure_OD+IDXtra*3, h=3);
		
	} // difference
} // Fincan

// Fincan();
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









