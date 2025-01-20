// *******************************************************
// Project: 3D Printed Rocket
// Filename: Rocket157.scad
// by David M. Flynn
// Created: 1/19/2025
// Revision: 0.9.0  1/19/2025
// Units: mm
// *******************************************************
//  ***** Notes *****
//
// A big fat mailing tube rocket. 
// 75mm single grain motor K750ST-PS
// 
//
//  ***** History *****
//
// 0.9.0  1/19/2025   First code
//
// *******************************************************
//  ***** for STL output *****
//
// BluntOgiveNoseCone(ID=Body_ID, OD=Body_OD, L=Nosecone_Len, Base_L=NoseconeBase_Len, nRivets=nNoseconeRivets, Tip_R=NoseconeTip_R, HasThreadedTip=false, Wall_T=NoseconeWall_t, Cut_d=0, LowerPortion=false); // one piece
//
/*
  NC_ShockcordRingDual(Tube_OD=Body_OD, Tube_ID=Body_ID, NC_ID=0, NC_Base_L=NoseconeBase_Len, 
						nRivets=nNoseconeRivets, nBolts=nEBay_Bolts, Flat=true);
/**/
//
//  *** Ball Lock Unit ***
// rotate([180,0,0]) STB_TubeEnd(Body_ID=Body_ID, nLockBalls=nLockBalls, Body_OD=Body_OD, Engagement_Len=Engagement_Len);
// rotate([180,0,0]) R157_BallRetainerTop(Body_OD=Body_OD+1.2, Body_ID=Body_ID, EBayTube_OD=EBayTube_OD, Engagement_Len=Engagement_Len, nBolts=nEBay_Bolts, Xtra_r=0.3); // fix for Body_OD too small
// STB_LockDisk(Body_ID=Body_ID, nLockBalls=nLockBalls, HasLargeInnerBearing=true, Xtra_r=0.3);
// R157_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID, Engagement_Len=Engagement_Len, HasPD_Ring=false, Xtra_r=0.3);
//
//
//
// *******************************************************
//  ***** for Viewing *****
//
// ShowRocket(ShowInternals=false);
// ShowRocket(ShowInternals=true);
//
// *******************************************************
include<TubesLib.scad>
use<AT-RMS-Lib.scad>
use<RailGuide.scad>
use<NoseCone.scad>
use<Fins.scad>
use<FinCan2Lib.scad>
use<SpringThingBooster.scad>
use<SpringEndsLib.scad>
use<ElectronicsBayLib.scad>
use<PetalDeploymentLib.scad>
use<R157Lib.scad>

//include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 36:90;

CF_Comp=0.995; // CF parts print oversized OD

// a short nose cone
Nosecone_Len=380;
NoseconeBase_Len=15;
NoseconeTip_R=5;
NoseconeWall_t=2.2;

nNoseconeRivets=6;
nEBay_Bolts=6;
EBayBoltInset=7.5;

nLockBalls=6;
Engagement_Len=30;
nPetals=6;
DroguePetal_Len=150;
MainPetal_Len=200;

nFins=5;
Fin_Post_h=20;
Fin_Root_L=300;
Fin_Root_W=15;
Fin_Tip_W=2;
Fin_Tip_L=120;
Fin_Span=140;
Fin_TipOffset=50;
Fin_Chamfer_L=60;
Fin_Inset=10;

Body_OD=ULine157Body_OD;
Body_ID=ULine157Body_ID;
BodyTubeAnnulus=1.30; // for sliders
Coupler_OD=ULine157Body_ID-1.10;
Coupler_ID=Coupler_OD-4.4;
EBayTube_OD=BT75Body_OD;

MotorTube_OD=BT75Body_OD;
MotorTube_ID=BT75Body_ID;

UpperBody_Len=400;
EBay_Len=176;
EBayCR_t=6;
LowerBody_Len=24*25.4;
FinCan_Len=Fin_Root_L+Fin_Inset*2;
MotorTube_Len=20*25.4;
Cone_Len=140;
OgiveBoatTail=true;

MotorRetainer_OD=84.4;
MotorRetainer_Len=35;

echo(UpperBody_Len=UpperBody_Len);
echo(EBay_Len=EBay_Len);
echo(LowerBody_Len=LowerBody_Len);
echo(FinCan_Len=FinCan_Len);


module ShowRocket(ShowInternals=false){
	FinCan_Z=0;
	Fin_Z=FinCan_Z+FinCan_Len/2;
	MotorTube_Z=OgiveBoatTail? FinCan_Z-90-15:FinCan_Z-Cone_Len+15;
	LowerBody_Z=FinCan_Z+FinCan_Len;
	LowerBallLock_Z=LowerBody_Z+LowerBody_Len;
	EBay_Z=LowerBallLock_Z+54.5;
	UpperBallLock_Z=EBay_Z+EBay_Len+54.5;
	UpperBody_Z=UpperBallLock_Z;
	NoseCone_Z=UpperBody_Z+UpperBody_Len+3;
	
	translate([0,0,NoseCone_Z]){
		BluntOgiveNoseCone(ID=Body_ID, OD=Body_OD, L=Nosecone_Len, Base_L=NoseconeBase_Len, 
				nRivets=nNoseconeRivets, Tip_R=NoseconeTip_R, Wall_T=NoseconeWall_t, 
				Cut_d=0, LowerPortion=false);
		
		color("Tan") rotate([0,0,90]) 
			NC_ShockcordRingDual(Tube_OD=Body_OD, Tube_ID=Body_ID, NC_ID=0, NC_Base_L=NoseconeBase_Len, 
				nRivets=nNoseconeRivets, nBolts=6, Flat=true);
	}
	
	if (ShowInternals) translate([0,0,NoseCone_Z-120])
		SE_SlidingBigSpringMiddle(OD=Coupler_OD, SliderLen=80, Extension=0);
		
	if (ShowInternals) translate([0,0,NoseCone_Z-120-50]){
		rotate([180,0,0]) color("Tan")
			PD_NC_PetalHub(OD=Coupler_OD, nPetals=nPetals, nRopes=nPetals, ShockCord_a=-1, 
				HasThreadedCore=false, ST_DSpring_ID=SE_Spring_CS11890_ID(), 
				ST_DSpring_OD=SE_Spring_CS11890_OD(), CouplerTube_ID=Coupler_ID);
			
		translate([0,0,-10]) rotate([180,0,0]) PD_Petals(OD=Coupler_OD, Len=MainPetal_Len, nPetals=nPetals, Wall_t=1.8, 
			AntiClimber_h=5.0, HasLocks=false, Lock_Span_a=0);
	}
	
	if (!ShowInternals) translate([0,0,UpperBody_Z+0.2]) color("LightBlue") 
		Tube(OD=Body_OD, ID=Body_ID, Len=UpperBody_Len-0.4, myfn=90);
	//*	
	translate([0,0,UpperBallLock_Z-Engagement_Len/2]) rotate([180,0,0]) {
		if (!ShowInternals) color("Gray")
			STB_TubeEnd(Body_ID=Body_ID, nLockBalls=nLockBalls, Body_OD=Body_OD, Engagement_Len=Engagement_Len);
		
		color("Green") R157_BallRetainerTop(Body_OD=Body_OD, Body_ID=Body_ID, EBayTube_OD=EBayTube_OD, Engagement_Len=Engagement_Len, nBolts=nEBay_Bolts, Xtra_r=0.3);
		if (ShowInternals)
			color("Green") R157_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID, Engagement_Len=Engagement_Len, Xtra_r=0.3);
			
	}	
	/**/
	
	translate([0,0,EBay_Z]) rotate([0,0,10]) EBay(ShowDoors=!ShowInternals);
	
	//*	
	translate([0,0,LowerBallLock_Z+Engagement_Len/2]){
		if (!ShowInternals) color("Gray")
			STB_TubeEnd(Body_ID=Body_ID, nLockBalls=nLockBalls, Body_OD=Body_OD, Engagement_Len=Engagement_Len);
		
		color("Green") R157_BallRetainerTop(Body_OD=Body_OD, Body_ID=Body_ID, EBayTube_OD=EBayTube_OD, Engagement_Len=Engagement_Len, nBolts=nEBay_Bolts, Xtra_r=0.3);
		if (ShowInternals)
			color("Green") R157_BallRetainerBottom(Body_OD=Body_OD, Body_ID=Body_ID, Engagement_Len=Engagement_Len, Xtra_r=0.3);
			
	}
	
	if (ShowInternals) translate([0,0,LowerBallLock_Z-0.2]){
		rotate([180,0,0]) R157_PetalHub();
		translate([0,0,-10]) rotate([180,0,0])
			PD_Petals(OD=Coupler_OD, Len=DroguePetal_Len, nPetals=nPetals, Wall_t=1.8,
									AntiClimber_h=5.0, HasLocks=false, Lock_Span_a=0);
									
		translate([0,0,-DroguePetal_Len-110]){
			SE_SpringEndTypeA(Coupler_OD=Coupler_OD, Coupler_ID=Coupler_ID, nRopes=6, 
								Spring_OD=SE_Spring_CS11890_OD());
			translate([0,0,12.5]) color("LightBlue") 
				Tube(OD=Coupler_OD, ID=Coupler_ID, Len=75, myfn=90);
		}
		translate([0,0,-DroguePetal_Len-210]){
			SE_SlidingBigSpringMiddle(OD=Coupler_OD, SliderLen=80, Extension=0);
			translate([0,0,-50]) rotate([180,0,0]) SE_SpringEndTypeC(Coupler_OD=Coupler_OD, Coupler_ID=Coupler_ID, nRopes=6, UseSmallSpring=false);
		}
	}
	
	if (ShowInternals) translate([0,0,MotorTube_Z+MotorTube_Len]) color("Orange")
		R157_MotorTubeTopper();
	
	
	if (!ShowInternals) translate([0,0,LowerBody_Z+0.2]) color("LightBlue") 
		Tube(OD=Body_OD, ID=Body_ID, Len=LowerBody_Len-0.4, myfn=90);
	/**/
	//*
	translate([0,0,FinCan_Z]) FinCan();
	
	translate([0,0,MotorTube_Z-MotorRetainer_Len+15]) color("Gray") 
		Tube(OD=MotorRetainer_OD, ID=MotorTube_OD, Len=MotorRetainer_Len, myfn=90);
		
	if (ShowInternals) translate([0,0,MotorTube_Z]) color("LightBlue")
		Tube(OD=MotorTube_OD, ID=MotorTube_ID, Len=MotorTube_Len, myfn=90);
	
	//*
	for (j=[0:nFins]) rotate([0,0,360/nFins*j+180/nFins])
		translate([0, Body_OD/2-Fin_Post_h, Fin_Z]) 
			rotate([-90,0,0]) color("LightGreen") Rocket_Fin();
	/**/
} // ShowRocket

// ShowRocket(ShowInternals=false);
// ShowRocket(ShowInternals=true);


module EBay(TopOnly=false, BottomOnly=false, ShowDoors=false){
	TubeStop_Z=EBayBoltInset*2+EBayCR_t+1.9;
	echo(TubeStop_Z=TubeStop_Z);
	R20351D_Doors=$preview? [[],[45],[-45]]:[[0],[90],[-90,-180]]; // Altimeters, Alt_Batts, SW_Batts
	
	EB_Electronics_BayUniversal(Tube_OD=Body_OD, Tube_ID=Body_ID, DoorAngles=R20351D_Doors, Len=EBay_Len, 
									nBolts=nEBay_Bolts, BoltInset=EBayBoltInset, ShowDoors=ShowDoors,
									HasFwdIntegratedCoupler=false, HasFwdShockMount=false,
									HasAftIntegratedCoupler=false, HasAftShockMount=false,
									HasRailGuide=false, RailGuideLen=35,
									HasFwdCenteringRing=false, HasAftCenteringRing=false, InnerTube_OD=BT54Body_OD,
									Bolted=true, ExtraBolts=[45], TopOnly=TopOnly, BottomOnly=BottomOnly);
									
	// Bottom centering ring stop
	if (!TopOnly) translate([0,0,TubeStop_Z]) 
		TubeStop(InnerTubeID=Coupler_ID, OuterTubeOD=Body_OD, myfn=$preview? 36:360);
		
	// Top centering ring stop
	if (!BottomOnly) translate([0,0,EBay_Len-TubeStop_Z]) rotate([180,0,0])
		TubeStop(InnerTubeID=Coupler_ID, OuterTubeOD=Body_OD, myfn=$preview? 36:360);
} // EBay

// EBay();

module FinCan(LowerHalfOnly=false, UpperHalfOnly=false, TailConeOnly=false){
	
	Cutout_d=60;
	Cutout_Depth=35;
	RailGuide_Z=40;
	Ogive_Len=160;
	Cut_Z=Ogive_Len-40;
	
	difference(){
		FC2_FinCan(Body_OD=Body_OD, Body_ID=Body_ID, Can_Len=FinCan_Len,
				MotorTube_OD=MotorTube_OD, RailGuide_h=Body_OD/2+2, RailGuide_z=RailGuide_Z,
				nFins=nFins, HasIntegratedCoupler=true, Coupler_Len=EBayBoltInset*2, nCouplerBolts=nFins*2,
				HasMotorSleeve=true, HasAftIntegratedCoupler=false,
				Fin_Root_W=Fin_Root_W, Fin_Root_L=Fin_Root_L, Fin_Post_h=Fin_Post_h, Fin_Chamfer_L=Fin_Chamfer_L,
				Cone_Len=Cone_Len, ThreadedTC=false, Extra_OD=0, RailGuideLen=40,
				LowerHalfOnly=LowerHalfOnly, UpperHalfOnly=UpperHalfOnly, HasWireHoles=false, 
				HollowTailcone=true, 
				HollowFinRoots=true, Wall_t=2.2, OgiveTailCone=true, Ogive_Len=Ogive_Len, OgiveCut_d=MotorRetainer_OD+1);
					
		// Motor Retainer
		translate([0,0,-Cut_Z-8]){
			cylinder(d=MotorRetainer_OD, h=MotorRetainer_Len);
			cylinder(d=MotorTube_OD+IDXtra*2, h=MotorRetainer_Len+8+Overlap);
		}

		if (TailConeOnly) cylinder(d=Body_OD+6, h=FinCan_Len+30);
		if (LowerHalfOnly) mirror([0,0,1]) cylinder(d=Body_OD+1, h=Cut_Z+1);
	} // difference
	
	
} // FinCan

// FinCan();


module Rocket_Fin(){
	TrapFin3(Post_h=Fin_Post_h, Root_L=Fin_Root_L, Tip_L=Fin_Tip_L,
			Root_W=Fin_Root_W, Tip_W=Fin_Tip_W,
			Span=Fin_Span, Chamfer_L=Fin_Chamfer_L,
					TipOffset=Fin_TipOffset, PrinterBrim_H=0.8, HasSpiralVaseRibs=false);

} // Rocket_Fin

// Rocket_Fin();

























