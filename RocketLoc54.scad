// *********************************************
// Project: 2.1 inch rocket depoyment system
// Filename: RocketLoc54.scad
// by David M. Flynn
// Created: 10/17/2025
// Revision: 0.9.1   10/18/2025
// Units: mm
// *********************************************
//  ***** Notes *****
//
//  This is a 2.1 inch diameter rocket, single deploy
//  Uses CableReleaseBBMicro, RocketServo and a MissionControl V3 altimeter.
//  Uses two 3670CS springs and petal deployment system (non-pyro).
//  First built 10/20/2025 w/ LOC 29mm motor tube and 54mm Loc tube
//
//
//  ***** History *****
//
// 0.9.1   10/18/2025 Printing and fixing
// 0.9.0   10/17/2025 Copied from Rocket6551 Rev 0.9.8
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
// PetalHub(OD=Coupler_OD, Skirt_h=5); // also nosecone base
// PetalHub(OD=Coupler_OD, Skirt_h=1); // Used with NC_GPS_Mounting_Plate
// NC_GPS_Mounting_Plate(OD=Coupler_OD, Skirt_h=5, HasAlTube=true);
// rotate([-90,0,0]) PD_PetalSpringHolder();
// rotate([180,0,0]) PD_Petals(OD=Coupler_OD, Len=Petal_Len, nPetals=nPetals, Wall_t=1.2, AntiClimber_h=4, HasLocks=true, Lock_Span_a=30);
// FwdSpringEnd(OD=Coupler_OD, nRopes=6, Skirt_h=25, Spring_H=15, HasServoConnector=false);
// SpringSliderLight();
//
//  *** CableReleaseBBMicro ***
//
//  CRBBm_CenteringRingMount(OD=Coupler_OD);
//  LockingPinCentering(); // used with 5/16" aluminum tubing
//  CRBBm_ExtensionRod(LockPin_d=LockPin_d, Len=26, ID=0.190*25.4, Light=true);
//  CRBBm_LockingPin(nBalls=nBalls, LockPin_d=LockPin_d, LockPin_Len=LockPin_Len, GuidePoint=GuidePoint);
//  rotate([180,0,0]) CRBBm_LockRing(LockPin_d=LockPin_d, nBalls=nBalls, GuidePoint=false);
//	rotate([180,0,0]) CRBBm_TopRetainer(LockPin_d=LockPin_d, nBalls=nBalls, LockRing_d=CRBBm_LockRingDiameter(), Flange_t=TopRetainerFlange_t, OD=0, HasMountingBolts=true, GuidePoint=GuidePoint, Light=true);
//  CRBBm_OuterBearingRetainer(Light=true);
//  rotate([180,0,0]) CRBBm_TriggerPost();
//  rotate([180,0,0]) CRBBm_MagnetBracket();
//  CRBBm_Activator();
//
// EBay(Light=true); // Blue Raven
// EBayMC(HasRS_Mount=true); // Mission Control
//
//  *** for Dual Deploy ***
//
DroguePetal_Len=80; // big enough for DMFR 14" parachute
// EBayMiddleRing();
// AftSpringEnd(OD=Body_ID, nRopes=0, Skirt_h=25);
// rotate([180,0,0]) PD_Petals(OD=Coupler_OD, Len=DroguePetal_Len, nPetals=nPetals, Wall_t=1.2, AntiClimber_h=4, HasLocks=true, Lock_Span_a=30);
// DroguePetalHub(OD=Coupler_OD, Spring_H=0, HasWirePath=false);
//
// rotate([180,0,0]) MotorTubeTopper(OD=Body_ID, ID=MotorTube_OD, MT_ID=MotorTube_ID-3); // alt w/ flange
// MotorNutStop(MT_ID=MotorTube_ID, Hole_d=MotorBolt_d);
//
// rotate([180,0,0]) Fincan(Wall_t=1.1, LowerHalfOnly=false, UpperHalfOnly=false, HasSecurityRods=false, HasMotorRetainer=false);
//
// rotate([0,0,90]) RocketFin(HasSpiralVaseRibs=false, PrinterBrim_H=0.6);
//
// RailButton(OD=11);
// RailButton(OD=11, Flange_h=2, Slot_w=2.8);  // for 1010 Rail
// SnapRing(); // optional, not used for now
//
//  *** Tools ***
//
// PD_PetalHolder(Petal_OD=Body_ID-0.5, Is_Top=false); // bottom half
// PD_PetalHolder(Petal_OD=Body_ID-0.5, Is_Top=true); // top half
// PD_PetalHolderLockLever();
//
// rotate([180,0,0]) DeepSocket(); // for 1/4-20 nuts
// ShortMotorAdaptor(Len=45); // One 29mm grain is 45mm in case length
// ExtensionAlignmentRing();
//
// *********************************************
//  ***** for Viewing *****
//
// ShowRocket(ShowInternals=false);
// ShowRocket(ShowInternals=true);
//
// ShowCableRelease();
//
// *********************************************

include<TubesLib.scad>
use<AT_RMS_Lib.scad>
use<SpringEndsLib.scad>      echo(SpringEndsLibRev());
use<PetalDeploymentLib.scad> echo(PetalDeploymentLibRev());
use<CableReleaseBBMicro.scad> echo(CableReleaseBBMicroRev());
use<BatteryHolderLib.scad>   echo(BatteryHolderLibRev());
use<ThreadLib.scad>          echo(ThreadLibRev());
use<SG90ServoLib.scad>       echo(SG90ServoLibRev());
use<Fins.scad>               echo(FinsRev());
use<FinCan2Lib.scad>         echo(FinCan2LibRev());
use<NoseCone.scad>           echo(NoseConeRev());
use<RailGuide.scad>          echo(RailGuideRev());
use<AltBay.scad>			 echo(AltBayRev());

// Also included
//include<CommonStuffSAEmm.scad>

$fn=$preview? 36:90;
IDXtra=0.2;
Overlap=0.05;

Bolt4Inset=4;
LooseFit=0.8; // add to hole ID

Body_OD=LOC54Body_OD;
Body_ID=LOC54Body_ID;
Coupler_OD=LOC54Coupler_OD;
Coupler_ID=Coupler_OD-1.8; // thin wall
// BodyTubeLen=18*25.4; // uncut estes tube
// BodyTubeLen=764; // uncut Loc tube

nPetals=3;
Petal_Len=140;

LockPin_d=12; // OD is determined by the bearing OD so making this smaller doesn't change the OD
LockPin_Len=23;
TopRetainerFlange_t=4;
nBalls=3;
GuidePoint=false;

Spring_OD=SE_Spring3670_OD();
Spring_ID=SE_Spring3670_ID();

MotorTube_OD=LOC29Body_OD;
MotorTube_ID=LOC29Body_ID;
MotorBolt_d=6.35;
MotorBoltPitch=25.4/20;

MotorTubeLen=304;
BodyTubeLen=600; // 865 uncut loc tube

NC_Len=155;
NC_Base_L=6;
NC_Tip_R=3;
NC_Wall_t=1.2;

// Small fins
nFins=5;
Fin_Post_h=10;
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

Vinyl_d=0.3;
TailCone_Len=30;
TailConeExtra_OD=2;

Thread1024_d=0.190*25.4;
Thread25020_d=0.250*25.4;
CRBBm_Activator_Bolt_a=[22.5,162,253,323];
EBay_Len=84;


module ShowRocket(ShowInternals=false, IsSustainer=false){
	FinCan_Z=TailCone_Len;
	Fin_Z=FinCan_Z+FinCan_Len/2;
	MotorTube_Z=FinCan_Z-TailCone_Len;
	
	
	BodyTube_Z=FinCan_Z+FinCan_Len+Overlap*2;
	NoseCone_Z=BodyTube_Z+BodyTubeLen+0.1;
	
	FwdSpringEnd_Z=NoseCone_Z-14.5-Petal_Len-4;
	SCR_Z=FwdSpringEnd_Z-50-25;
	EBay_Z=SCR_Z-58-EBay_Len;
	
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
		translate([0,0,EBay_Z]) rotate([0,0,90]) EBayMC();
	}
		
	if (!ShowInternals)
		translate([0,0,BodyTube_Z]) color("LightBlue") 
			Tube(OD=Body_OD, ID=Body_ID, Len=BodyTubeLen-Overlap*2, myfn=$preview? 90:360);
		
	
	
	if (ShowInternals)
		translate([0,0,MotorTube_Z]) {
			color("Blue") Tube(OD=MotorTube_OD, ID=MotorTube_ID, Len=MotorTubeLen-Overlap*2, myfn=$preview? 90:360);
			translate([0,0,MotorTubeLen-18]) MotorTubeTopper(OD=Body_ID, ID=MotorTube_OD, MT_ID=MotorTube_ID);
			//translate([0,0,MotorTubeLen+3]) color("LightGreen") Tube(OD=Coupler_OD, ID=Coupler_OD-2.4, Len=25, myfn=$preview? 90:180); // spacer
		}	
	translate([0,0,FinCan_Z]) color("Orange") Fincan(LowerHalfOnly=false, UpperHalfOnly=false, IsSustainer=IsSustainer);
	
	for (j=[0:nFins-1]) rotate([0,0,360/nFins*j+180/nFins])
		translate([0, Body_OD/2-Fin_Post_h, Fin_Z]) 
			rotate([-90,0,0]) color("Orange") RocketFin(false);
		
} // ShowRocket

// ShowRocket(ShowInternals=false);
// ShowRocket(ShowInternals=true);

module ShowCableRelease(){
//*
	translate([0,0,LockPin_Len-7.5]) CRBBm_ExtensionRod(LockPin_d=LockPin_d, Len=26, ID=0.190*25.4, Light=true);

	CRBBm_LockingPin(nBalls=nBalls, LockPin_d=LockPin_d, LockPin_Len=LockPin_Len, GuidePoint=GuidePoint);
	CRBBm_LockRing(LockPin_d=LockPin_d, nBalls=nBalls, GuidePoint=GuidePoint);
	CRBBm_TopRetainer(LockPin_d=LockPin_d, nBalls=nBalls, LockRing_d=CRBBm_LockRingDiameter(), Flange_t=TopRetainerFlange_t, OD=0, HasMountingBolts=true, GuidePoint=GuidePoint, Light=true);
/**/	
	translate([0,0,-19.5]){ 
		CRBBm_OuterBearingRetainer(Light=true);
		//translate([0,0,-2.5]) rotate([0,0,60]) CRBBm_BlankInnerBearingRetainer(H=8, HasCenterHole=true);
		rotate([0,0,360/9*3]) CRBBm_MagnetBracket();
		rotate([0,0,360/9*2]) CRBBm_TriggerPost();
		}
//*
	translate([0,0,TopRetainerFlange_t+8.7]) CRBBm_CenteringRingMount();
/**/
} // ShowCableRelease

// ShowCableRelease();

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

module NoseCone(){
	nBolts=nPetals;
	
	BluntOgiveNoseCone(ID=Body_OD-4.4, OD=Body_OD*CF_Comp+Vinyl_d, L=NC_Len, Base_L=NC_Base_L, nRivets=0, RivertInset=0, Tip_R=NC_Tip_R, HasThreadedTip=false, Wall_T=NC_Wall_t, Cut_d=0, LowerPortion=false, FillTip=true);

	difference(){
		PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=nBolts) hull(){
			cylinder(d=7, h=NC_Base_L);
			translate([0,3.5,0]) scale([1,0.2,1]) cylinder(d=9, h=NC_Base_L);
		}
		
		PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=nBolts) rotate([180,0,0]) Bolt4Hole();					
	} // difference
} // NoseCone

// NoseCone();

module PetalHub(OD=Coupler_OD, Skirt_h=5, HasWirePath=false){
	// attaches to nose cone
	
	CenterHole_d=5;
	nBolts=nPetals;
	
	module ShockCordHole(){
		if (Skirt_h==1){
			cylinder(d=4, h=Skirt_h+20);
		}else{
			rotate([0,0,60]) translate([0,10,-Skirt_h-Overlap]) cylinder(d=CenterHole_d, h=Skirt_h+30);
		}
	} // ShockCordHole
	
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
			PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=nBolts) hull(){
				cylinder(d=7, h=Skirt_h+Overlap);
				translate([0,3.0,0]) scale([1,0.2,1]) cylinder(d=9, h=Skirt_h+Overlap);
			}
			
			if (Skirt_h==1){
			  cylinder(d=OD, h=Skirt_h+Overlap, $fn=180);
			}else{
				if (Skirt_h>0)
					Tube(OD=Coupler_OD, ID=Coupler_OD-3.6, Len=Skirt_h+Overlap, myfn=$preview? 90:360);
			}
			
			rotate([0,0,60]) translate([0,10,0]) cylinder(d=CenterHole_d+6, h=Skirt_h+Overlap);
		} // union
		
		PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=nBolts) rotate([180,0,0]) Bolt4ClearHole(depth=Skirt_h+10);
		
		ShockCordHole();
		
		if (HasWirePath) WireHole();
	} // difference
	
	difference(){
		PD_PetalHub(OD=OD, 
					nPetals=nPetals, 
					HasReplaceableSpringHolder=false,
					HasBolts=true,
					nBolts=nBolts,
					ShockCord_a=-1,
					HasNCSkirt=false, 
						Body_OD=BT75Body_OD,
						Body_ID=BT75Body_ID,
						NC_Base=0, 
						SkirtLen=10, 
					CenterHole_d=0, nRopes=0);
					
		translate([0,0,10]) cylinder(d=7, h=20);
		
		ShockCordHole();
		
		
		if (HasWirePath) WireHole();
			
	} // difference
} // PetalHub

// translate([0,0,1]) PetalHub(OD=Coupler_OD, Skirt_h=1, HasWirePath=false);
// translate([0,0,5]) PetalHub(OD=Coupler_OD, Skirt_h=5);

module DroguePetalHub(OD=Coupler_OD, Spring_H=0, HasWirePath=false){
// needs work
	Skirt_H=15;
	Spring_OD=SE_Spring3670_OD();
	Wall_t=1.2;
	
	difference(){
		union(){
			PetalHub(OD=OD, Skirt_h=1, HasWirePath=HasWirePath);
			
			// Skirt
			translate([0,0,-Skirt_H])
				Tube(OD=OD, ID=OD-Wall_t*2, Len=Skirt_H+Overlap, myfn=$preview? 90:360);
			
			// Bolt boss
			translate([0,0,-Skirt_H]) cylinder(d=LockPin_d, h=Skirt_H+6);
			
			// Spring
			translate([0,0,-4-Spring_H]) Tube(OD=Spring_OD+2.4, ID=Spring_OD, Len=5+Spring_H, myfn=90);
			translate([0,0,-Spring_H]) Tube(OD=Spring_OD+2.4, ID=Spring_ID, Len=5+Spring_H, myfn=90);
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

// DroguePetalHub(OD=Coupler_OD, Spring_H=0, HasWirePath=false);

module R54_DrogueCoupler(OD=LOC65Body_ID, Coupler_ID=LOC65Coupler_ID, 
			Thread_d=Thread25020_d, Thread_p=Thread25020_Pitch,
			nRopes=0, Skirt_h=25, HasTubeStop=false, Body_OD=LOC65Body_OD, HasWirePath=false, HasStiffCore=false){
// Copy of R65_DrogueCoupler
// This locks onto the bottom of the petals.
// For drogue bay

	CR_t=3;
	Rope_d=3;

	Petal_ID=OD-3.5; // should fit loose
	PetalLock_ID=OD-7.5; // Should not touch at all
	ShockCord_Y=HasStiffCore? Thread_p/2+10:OD/2-10;
	
	Boss_t=4;
	nVentHoles=5;
	VentHole_d=7;
	VentHole_Y=15+VentHole_d/2;
	Wall_t=1.8;
	myFn=floor(OD)*3;
	Len=HasTubeStop? Skirt_h*2+7:Skirt_h*2+4;
	CenterHole_H=HasStiffCore? Len:Boss_t;
	
	nSpokes=(nRopes==0)? nVentHoles:nRopes;
	Spoke_t=1.2;
	Spoke_a=180/nSpokes;
	ShockCord_a=Spoke_a;
	Core_d=max(12,Thread_d+4.4);
	
	difference(){
		union(){
			difference(){
				cylinder(d=OD, h=6, $fn=$preview? 90:myFn);
				
				translate([0,0,CR_t-Overlap]) cylinder(d1=Coupler_ID-4, d2=Coupler_ID, h=4+Overlap*2, $fn=$preview? 90:myFn);
			} // difference
			
			cylinder(d=16, h=Boss_t);
			
			// spokes
			if (HasStiffCore){
				// spokes
				for (j=[0:nSpokes-1]) rotate([0,0,360/nSpokes*j+Spoke_a])
					hull(){
						translate([0,0,CR_t-Overlap]) cylinder(d=Spoke_t, h=Len-CR_t+Overlap);
						translate([0,OD/2-Spoke_t,CR_t-Overlap]) cylinder(d=Spoke_t, h=Len-CR_t+Overlap);
					} // hull
					
				cylinder(d=Core_d, h=Len);
				
				// Shock cord anchor
				rotate([0,0,ShockCord_a])
				hull(){
					translate([0,0,2.5]) rotate([-90,0,0]) cylinder(d=5, h=OD/2-1);
					translate([0,0,Len/2]) rotate([-90,0,0]) cylinder(d=12, h=OD/2-1);
					translate([0,0,Len-2.5]) rotate([-90,0,0]) cylinder(d=5, h=OD/2-1);
				} // hull
			} // if
			
			// Skirt
			Tube(OD=OD, ID=OD-Wall_t*2, Len=Len, myfn=$preview? 90:myFn);
			
			// Tube Stop
			if (HasTubeStop) translate([0,0,Skirt_h]) 
				Tube(OD=Body_OD, ID=OD-Wall_t*2, Len=3, myfn=$preview? 90:myFn);
			
			// Petal Lock ring
			difference(){
				cylinder(d=OD, h=CR_t+5.5, $fn=$preview? 90:myFn);
				
				translate([0,0,CR_t]) cylinder(d=PetalLock_ID-2.8, h=4.5, $fn=$preview? 90:myFn);
				
				translate([0,0,CR_t+3.5]) cylinder(d1=PetalLock_ID-2.8, d2=Coupler_ID, h=3.5+Overlap, $fn=$preview? 90:myFn);
			} // difference
			
		} // union
		
		// Center hole
		translate([0,0,-Overlap]) 
			if ($preview){
				cylinder(d=Thread_d, h=CenterHole_H+Overlap*2); 
			}else{
				ExternalThread(Pitch=Thread_p, Dia_Nominal=Thread_d+IDXtra*2, 
						Length=CenterHole_H+Overlap*2, 
						Step_a=2,TrimEnd=true,TrimRoot=true);
						
				translate([0,0,12]) cylinder(d=Thread_d+IDXtra*2, h=CenterHole_H-24);
			}
		
		// Air Vent Holes
		for (j=[0:nVentHoles-1]) rotate([0,0,360/nVentHoles*j]) 
			translate([0,VentHole_Y,-Overlap]) cylinder(d=VentHole_d, h=CR_t+Overlap*2);
		
		// Shock cord
		if (HasStiffCore){
			rotate([0,0,ShockCord_a+30]) translate([0,ShockCord_Y,-Overlap]) cylinder(d=4, h=CR_t+Overlap*2);
			rotate([0,0,ShockCord_a-30]) translate([0,ShockCord_Y,-Overlap]) cylinder(d=4, h=CR_t+Overlap*2);
		}else{
			rotate([0,0,180/nVentHoles]) translate([0,ShockCord_Y,-Overlap]) cylinder(d=4, h=CR_t+Overlap*2);
		}
		
		if (HasWirePath) rotate([0,0,-Spoke_a*3+15]) translate([0,OD/2-10,-Overlap]) cylinder(d=5, h=30);
		
		// Petal Locks
		difference(){
			translate([0,0,-Overlap]) cylinder(d=OD+1, h=4.5+Overlap*2, $fn=$preview? 90:myFn);
			
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
	
} // R54_DrogueCoupler

/*
R54_DrogueCoupler(OD=Body_ID, Coupler_ID=Coupler_ID, 
			Thread_d=MotorBolt_d, Thread_p=MotorBoltPitch,
			nRopes=0, Skirt_h=25, HasTubeStop=false, Body_OD=Body_OD, HasWirePath=true, HasStiffCore=true);
/**/

module AftSpringEnd(Body_d=Body_OD*CF_Comp+Vinyl_d, OD=Body_ID, nRopes=0, Skirt_h=25, HasTubeStop=false){
// This locks onto the bottom of the petals.
// For drogue bay

	CR_t=2;
	Rope_d=3;
	Petal_ID=Coupler_OD-3.5; // should fit loose
	PetalLock_ID=Coupler_OD-7.5; // Should not touch at all
	ShockCord_Y=Coupler_ID/2-10;
	Boss_t=4;
	nVentHoles=5;
	VentHole_d=7;
	VentHole_Y=15+VentHole_d/2;
	Wall_t=1.8;
	myFn=floor(Body_d)*3;
	
	difference(){
		union(){
			difference(){
				cylinder(d=OD, h=6, $fn=$preview? 90:myFn);
				
				translate([0,0,CR_t-Overlap]) cylinder(d1=Coupler_ID-4, d2=Coupler_ID, h=4+Overlap*2, $fn=$preview? 90:myFn);
			} // difference
			
			cylinder(d=LockPin_d, h=Boss_t);
			
			// Skirt
			Tube(OD=OD, ID=OD-Wall_t*2, Len=Skirt_h*2+3, myfn=$preview? 90:myFn);
			
			// Tube Stop
			if (HasTubeStop)
				translate([0,0,Skirt_h]) 
					Tube(OD=Body_d, ID=Coupler_OD-Wall_t*2, Len=3, myfn=$preview? 90:myFn);
			
			difference(){
				cylinder(d=OD, h=CR_t+5.5, $fn=$preview? 90:myFn);
				
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
			translate([0,0,-Overlap]) cylinder(d=OD+1, h=4.5+Overlap*2, $fn=$preview? 90:myFn);
			
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

// AftSpringEnd(nRopes=0, Skirt_h=25);

module FW_GPS_SW_Hole(){
	// Switch
	translate([5,-1.6-1,-1]) 
		rotate([90,0,0]) cylinder(d=3, h=100);
		
	// Terminal block
	translate([10,0,4]) rotate([0,0,180]) cube([7,10,7]);
} // FW_GPS_SW_Hole

module FW_GPS_Mount(){
	Boss_d=10;
	Boss_Y=1;
	Boss_Z=13.5;
	Post_W=10;
	Post_Y=6;
	GPS_BoltSpace_X=12.7;
	GPS_BoltSpace_Z=25.4;
	
	module Boss(){
		difference(){
			rotate([-90,0,0]) cylinder(d1=7,d2=Boss_d,h=6);
				
			rotate([90,0,0]) Bolt4Hole();
		} // difference
	} // Boss
		
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
	nBolts=nPetals;
	
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
			
		
			PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=nBolts){
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
		
		PD_PetalHubBoltPattern(OD=Coupler_OD, nBolts=nBolts) rotate([180,0,0]) Bolt4ClearHole();
		
		// Aluminum Tube
		if (HasAlTube)
			translate([0,0,Al_Tube_d/2+Skirt_h]) rotate([90,0,0]) cylinder(d=Al_Tube_d, h=Body_OD, center=true);
			
		// Center hole
		translate([0,0,-Overlap]) cylinder(d=CenterHole_d, h=Skirt_h+Al_Tube_d+5);
	} // difference
} // NC_GPS_Mounting_Plate

// translate([0,0,-0.1]) rotate([180,0,0]) 
// NC_GPS_Mounting_Plate(OD=Coupler_OD, Skirt_h=4, HasAlTube=true);

module SpringSliderLight(OD=Coupler_OD, Wall_t=1.2, Len=25){
	
	nSpokes=6;
	SpringStop_Z=15;
	Spring_OD=SE_Spring3670_OD();
	Spring_ID=SE_Spring3670_ID();
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

module FwdSpringEnd(OD=Coupler_OD, nRopes=0, Skirt_h=25, Spring_H=0, HasServoConnector=false){
// This locks onto the bottom of the petals.
	CR_t=2;
	Rope_d=3;
	
	Petal_ID=Coupler_OD-3.5; // should fit loose
	PetalLock_ID=Coupler_OD-7.5; // Should not touch at all
	ShockCord_Y=Spring_ID/2-Rope_d/2-1;
	Boss_t=10;
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
			Tube(OD=Spring_OD+2.4, ID=Spring_OD, Len=Spring_H+CR_t+4, myfn=$preview? 90:myFn);
			Tube(OD=Spring_OD+2.4, ID=Spring_ID, Len=Spring_H+CR_t, myfn=$preview? 90:myFn);
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
		//rotate([0,0,180/nVentHoles]) translate([0,ShockCord_Y,-Overlap]) cylinder(d=4, h=30);
		
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
			translate([0,Spring_OD/2+Rope_d/2+2.4,-Overlap]) cylinder(d=Rope_d, h=CR_t+Overlap*2);
			
		//if ($preview) translate([0,0,-Overlap]) cube([100,100,100]);
	} // difference
	
} // FwdSpringEnd

// FwdSpringEnd(OD=Coupler_OD, nRopes=6, Skirt_h=25, Spring_H=15, HasServoConnector=false);

module LockingPinCentering(){
	Al_Tube_d=5/16*25.4;
	
	difference(){
		union(){
			cylinder(d=LockPin_d, h=2+Overlap);
			translate([0,0,2]) cylinder(d1=LockPin_d, d2=Al_Tube_d+IDXtra+2.4, h=6);
		
		} // union
		
		translate([0,0,2]) cylinder(d=Al_Tube_d+IDXtra, h=6+Overlap);
		translate([0,0,2+Overlap]) Bolt10Hole();
		
	} // difference
} // LockingPinCentering

// LockingPinCentering();

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

module EBayMC(HasRS_Mount=true){
	// Mission Control version
	// Featherweight Mag Switch, Rocket Servo PCBA, 2S LiPo
		
	Mag_SW_a=-90;
	Mag_SW_X=16;
	Mag_SW_Y=-9;
	Mag_SW_Z=18;

	EBayMC_Len=MC_Size_Z()+10;
	Alt_Z=EBayMC_Len/2+2;
	Alt_Y=Body_ID/2-10;
	
	// Rocket servo mounts
	RS_Mount_X=12;
	RS_Mount_Y=1;

	Battery_Z=22.2;
	Battery_X=0;
	Battery_Y=-14.6;
	Battery_a=0;
	BattRotation_a=90;

	// Battery size
	Batt_X=20;
	Batt_Y=12.2;
	Batt_Z=40; // was 43
	
	ShockCord_a=120;

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
			
		} // difference
	} // BattPocket
	
	// Battery Holder
	difference(){
		rotate([0,0,Battery_a]) translate([Battery_X,Battery_Y,Battery_Z]) rotate([0,0,BattRotation_a]) 
			BattPocket();
			
		rotate([0,0,Mag_SW_a]) translate([Mag_SW_X,Mag_SW_Y+2,Mag_SW_Z]) rotate([90,0,0]) 
			translate([0,0,1]) FW_MagSw_BoltPattern() Bolt4Hole();
	} // difference
	
	// Base Plate
	difference(){
		EBay_BasePlate(OD=Coupler_OD, OuterBolt_a=78, ShockCord_a=ShockCord_a);
		
		// Battery pushing hole and cleanup inside
		rotate([0,0,Battery_a]) translate([Battery_X,Battery_Y,Battery_Z]) rotate([0,0,BattRotation_a]) rotate([0,0,-90]) {
			translate([0,0,2]) rotate([0,0,BattRotation_a]) BattHole(Xtra_X=0, Xtra_Y=0, Xtra_Z=4);
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
		translate([RS_Mount_X,RS_Mount_Y,0]) rotate([0,0,90]) RocketServoMountVert(Base_h=1);
		translate([-RS_Mount_X,RS_Mount_Y,0]) rotate([0,0,-90]) RocketServoMountVert(Base_h=1);
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

// EBayMC(HasRS_Mount=true);

module EBay_BasePlate(OD=Coupler_OD, OuterBolt_a=75, ShockCord_a=-30){
	Plate_t=2;
	Boss_t=8;
	nOuterBolts=2;
	Outer_BC_d=OD-10.6; // #10-24 nut diameter
	Nut_a=180;
	
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
			cylinder(d=MotorBolt_d+4.4, h=Boss_t);
			
			if (nOuterBolts>0)
				for (j=[0:nOuterBolts-1]) rotate([0,0,360/nOuterBolts*j+OuterBolt_a])
					translate([0,Outer_BC_d/2,0]) cylinder(d=Thread1024_d+4.4, h=Boss_t);
			
		} // union
					
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
		
		// Shock cord
		rotate([0,0,ShockCord_a]) translate([0,Coupler_ID/2-4,-Overlap]) cylinder(d=6, h=Plate_t+Overlap*2);
		
		if (nOuterBolts>0)
			for (j=[0:nOuterBolts-1])
					rotate([0,0,360/nOuterBolts*j+OuterBolt_a]) 
						translate([0,Outer_BC_d/2,-Overlap]) ThreadedHole(Chamfer=false);

	} // difference
} // EBay_BasePlate

// EBay_BasePlate();

module EBayMiddleRing(OD=Coupler_OD, Len=30){
	// for Dual Deploy
	nSpokes=6;
	Spoke_t=1.2;
	Wall_t=1.8;
	nRivets=3;
	Thread_d=MotorBolt_d;
	Thread_p=MotorBoltPitch;
	nOuterBolts=2;
	Outer_BC_d=OD-10.6; // #10-24 nut diameter
	
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

} // EBayMiddleRing

// EBayMiddleRing();

module ShortMotorAdaptor(Len=45){ // One 29mm grain is 45mm in case length
	// a.k.a. Long Nut
	
	Thread_d=MotorBolt_d;
	Thread_p=MotorBoltPitch;
	Nut_d=7/16*25.4*1.1339;
		
	difference(){
		cylinder(d=Nut_d, h=Len, $fn=6);
		
		// Thread
		translate([0,0,-Overlap])
			if ($preview){
				cylinder(d=Thread_d, h=Len+Overlap*2); 
			}else{
				ExternalThread(Pitch=Thread_p, Dia_Nominal=Thread_d+IDXtra*2, 
						Length=Len+Overlap*2, 
						Step_a=2,TrimEnd=true,TrimRoot=true);
			} // if
			
		translate([0,0,Len-4]) cylinder(d1=Thread_d-2, d2=Nut_d-3, h=4+Overlap);
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
	Nut_d=7/16*25.4*1.1339;
	
	difference(){
		union(){
			rotate([0,0,30]) cylinder(d=Nut_d, h=Len, $fn=6);
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
			translate([0,-1+RS_PCB_t/2,2]) cube([RS_PCB_X-2, 8, 8], center=true);
		} //difference
	
	// post
	difference(){
		translate([0,4,0]) RoundRect(X=RS_PCB_X+1+Wall_t*2, Y=3, Z=51+Base_h, R=0.5);
		translate([0,-1+RS_PCB_t/2,2+45+Base_h+2]) cube([RS_PCB_X-2, 8, 8], center=true);
	} // difference
} // RocketServoMountVert

// RocketServoMountVert(Base_h=0);

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

module Fincan(Wall_t=1.2, LowerHalfOnly=false, UpperHalfOnly=false, HasSecurityRods=false, HasMotorRetainer=false, IsSustainer=false){
	
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
			translate([0,(OD-10.6)/2,-TailCone_Len]){
				cylinder(d=SecurityRodHole_d, h=FinCan_Len+TailCone_Len);
				cylinder(d=SecurityWrenchHole_d, h=SecurityWrenchHole_h);
			}
			translate([0,-(OD-10.6)/2,-TailCone_Len]){
				cylinder(d=SecurityRodHole_d, h=FinCan_Len+TailCone_Len);
				cylinder(d=SecurityWrenchHole_d, h=SecurityWrenchHole_h);
			}
		} // if (HasSecurityRods)
		/**/
	} // difference
} // Fincan

// Fincan(LowerHalfOnly=false, UpperHalfOnly=false, HasSecurityRods=false, HasMotorRetainer=false);
// Fincan(LowerHalfOnly=false, UpperHalfOnly=true);
// Fincan(LowerHalfOnly=true, UpperHalfOnly=false);

module RocketFin(HasSpiralVaseRibs=true, PrinterBrim_H=0.6){
	
	TrapFin3(Post_h=Fin_Post_h, Root_L=Fin_Root_L, Tip_L=Fin_Tip_L, Root_W=Fin_Root_W,
				Tip_W=Fin_Tip_W, Span=Fin_Span, Chamfer_L=Fin_Chamfer_L,
				TipOffset=Fin_TipOffset,
				Bisect=false, Bisect_X=0,
				HasSpar=false, Spar_d=8, Spar_L=100, PrinterBrim_H=PrinterBrim_H, HasSpiralVaseRibs=HasSpiralVaseRibs, TipBase=Fin_TipBase);
				
	
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




























