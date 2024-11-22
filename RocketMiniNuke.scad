// ***********************************************
// Project: 3D Printed Rocket
// Filename: RocketMiniNuke.scad
// by David M. Flynn
// Created: 11/11/2023 
// Revision: 0.9.0  11/11/2024 
// Units: mm
// ***********************************
//  ***** Notes *****
// A Fallout style Mini Nuke.
// This has turned into an art project.
//
//  ***** History *****
//
// 0.9.0  11/11/2024 First code
//
// ***********************************
//  ***** for STL output *****
//
// rotate([180,0,0]) AftShell();
//
//  *** Motor Pod and Deployment System ***
//
// rotate([180,0,0]) SpringEnd();
// SE_SlidingSpringMiddle(OD=BT98Coupler_OD, nRopes=3, SliderLen=38, SpLen=34, SpringStop_Z=10, UseSmallSpring=true);
// MN_PetalHub();
// rotate([180,0,0]) PD_Petals(OD=BT98Coupler_OD, Len=Petal_Len, nPetals=3, Wall_t=1.8, AntiClimber_h=4, HasLocks=false, Lock_Span_a=0);
//
//  *** 75mm Inline Pod Lock system ***
// MPL_InlineBallRetainer(Tube_OD=BT75Body_OD, Tube_ID=BT75Body_ID, LockBall_d=MPL_LockBall_d, nBalls=MPL_nLockBalls);
// rotate([180,0,0]) MPL_LockRing(OD=BT75Coupler_OD, ID=BT75Coupler_ID, Ball_d=MPL_LockBall_d, nBalls=MPL_nLockBalls);
// rotate([180,0,0]) MPL_InlineLockRing(Tube_ID=BT75Body_ID, LockBall_d=MPL_LockBall_d, nBalls=MPL_nLockBalls);
// MPL_InlineServoRing(Tube_OD=BT75Body_OD, Tube_ID=BT75Body_ID, LockBall_d=MPL_LockBall_d, nBalls=MPL_nLockBalls);
//
//  *** 98mm Inline Pod Lock system ***
// MPL_InlineBallRetainer(Tube_OD=BT98Body_OD, Tube_ID=BT98Body_ID, LockBall_d=MPL_LockBall_d, nBalls=MPL_nLockBalls);
// rotate([180,0,0]) MPL_LockRing(OD=BT98Coupler_OD, ID=BT98Coupler_ID, Ball_d=MPL_LockBall_d, nBalls=MPL_nLockBalls);
// rotate([180,0,0]) MPL_InlineLockRing(Tube_ID=BT98Body_ID, LockBall_d=MPL_LockBall_d, nBalls=MPL_nLockBalls);
// MPL_InlineServoRing(Tube_OD=BT98Body_OD, Tube_ID=BT98Body_ID, LockBall_d=MPL_LockBall_d, nBalls=MPL_nLockBalls);
//
// RingFin();
//
// ThrustRing();
// rotate([180,0,0]) TheButt();
//
// ***********************************
//  ***** Routines *****
//
//
// ***********************************
//  ***** for Viewing *****
//
//
// ***********************************
include<TubesLib.scad>
use<RailGuide.scad>
use<ElectronicsBayLib.scad>
use<SpringThingBooster.scad>
use<PetalDeploymentLib.scad>
use<SpringEndsLib.scad>			echo(SpringEndsLibRev());
use<R75Lib.scad>
use<AT-RMS-Lib.scad>
use<MotorPodLockLib.scad> 		echo(MotorPodLockLibRev());
use<ThreadLib.scad>

//also included
 //include<CommonStuffSAEmm.scad>

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;
Bolt4Inset=4;

IncludeArt=true; // set to false to remove decorations

MPL_LockBall_d=3/8*25.4; // 1/2*25.4;
MPL_nLockBalls=6;

MotorTube_OD=BT54Body_OD;
MotorTube_ID=BT54Body_ID;
Coupler_OD=BT98Coupler_OD;
Coupler_ID=BT98Coupler_ID;

MotorPod_OD=BT98Coupler_OD;
MotorPodBody_OD=BT98Body_OD;
MotorPodBody_ID=BT98Body_ID;

MotorTube_Len=130;
LowerPodCoupler_Len=180;//108;
LowerPodBody_Len=104;
UpperPodBody_Len=215;
Petal_Len=120;


echo(MotorTube_Len=MotorTube_Len);
echo(LowerPodCoupler_Len=LowerPodCoupler_Len);
echo(LowerPodBody_Len=LowerPodBody_Len);
echo(UpperPodBody_Len=UpperPodBody_Len);

Body_OD=250;
Body_Ext=10;
Body_Wall_t=5;
nShellBolts=8;
Pointy=1.6;
AftPointy=1.6;
Base_Z=(-Body_OD/2-Body_Ext/2)*AftPointy; // bottom of shell
MotorStop_Z=Base_Z+25;	// motor pod separation line
ShellBolt_a=22.5;

nFins=4;
FinThickness=8;
FinLength=60;

RingFin_Thickness=5;
RingFin_Len=65;
	FinRoot_L=FinLength+60;
	FinTip_L=FinRoot_L-30;
	FinTip_W=FinThickness;

module ShowRocket(ShowInternals=false){
	Motor_Z=60;
	Fin_Z=45;
	CenterLine_Z=Fin_Z+FinLength+Body_Ext/2+139;
	LockRing_Z=CenterLine_Z-(Body_OD/2+Body_Ext/2)*AftPointy-33+LowerPodCoupler_Len;
	
	Petal_Z=LockRing_Z+Petal_Len+18;
	
	translate([0,0,CenterLine_Z+0.2]) ForwardShell();
	//*
	if (ShowInternals){
		translate([0,0,Petal_Z+10]) rotate([180,0,0]) color("Tan") MN_PetalHub();
		translate([0,0,CenterLine_Z-(Body_OD/2+Body_Ext/2)*AftPointy+25+LowerPodBody_Len+25+UpperPodBody_Len]) SpringEnd();
		}
				
	if (ShowInternals)
		translate([0,0,Petal_Z]) rotate([180,0,0]) 
			color("Tan") PD_Petals(OD=BT75Coupler_OD, Len=Petal_Len, nPetals=3, Wall_t=1.8, AntiClimber_h=4, HasLocks=false, Lock_Span_a=0);
	
	/**/
	
	if (ShowInternals)
		translate([0,0,LockRing_Z]) rotate([0,0,180]) 
			color("Green") MPL_LockRing(OD=Coupler_OD, ID=Coupler_ID, Ball_d=MPL_LockBall_d, nBalls=MPL_nLockBalls);
		
	//*
	if (ShowInternals)
		translate([0,0,LockRing_Z-7]) difference(){ 
			rotate([180,0,-60]) MPL_InlineBallRetainer(Tube_OD=BT75Body_OD, Tube_ID=BT75Body_ID, LockBall_d=MPL_LockBall_d, nBalls=MPL_nLockBalls);
			
			translate([0,0,-30]) cube([100,100,100]);
			}
	/**/	
	//*
	if (ShowInternals)
		translate([0,0,LockRing_Z-7]) 
			rotate([180,0,-60]) MPL_InlineLockRing();
	/**/
	
	//*
	if (ShowInternals)
		translate([0,0,LockRing_Z-7]) 
			rotate([180,0,-60]) MPL_InlineServoRing();
	/**/
	
	translate([0,0,CenterLine_Z]) AftShell();
	
	translate([0,0,CenterLine_Z]){
		ThrustRing();
		TheButt();
		// Motor tube
		if (ShowInternals)
			translate([0,0,-(Body_OD/2+Body_Ext/2)*AftPointy+23]) color("LightBlue") 
				Tube(OD=MotorTube_OD, ID=MotorTube_ID, Len=MotorTube_Len, myfn=90);
				
		// Thrust ring
		if (ShowInternals)
			translate([0,0,-(Body_OD/2+Body_Ext/2)*AftPointy+30]) color("LightBlue") 
				Tube(OD=MotorPodBody_OD, ID=MotorPodBody_ID, Len=10, myfn=90);
				
		// Pod coupler tube
		//*
		if (ShowInternals)
			translate([0,0,-(Body_OD/2+Body_Ext/2)*AftPointy+30]) color("LightBlue") 
				Tube(OD=Coupler_OD, ID=Coupler_ID, Len=LowerPodCoupler_Len, myfn=90);
		/**/
		
		// Lower Pod Body tube
		//*
		if (ShowInternals)
			translate([0,0,-(Body_OD/2+Body_Ext/2)*AftPointy+40+0.2]) color("LightBlue") 
				Tube(OD=MotorPodBody_OD, ID=MotorPodBody_ID, Len=LowerPodBody_Len, myfn=90);
				
		//*
		// Upper Pod Body tube
		if (ShowInternals)
			translate([0,0,-(Body_OD/2+Body_Ext/2)*AftPointy+25+LowerPodBody_Len+25]) color("LightBlue") 
				Tube(OD=MotorPodBody_OD, ID=MotorPodBody_ID, Len=UpperPodBody_Len-0.2, myfn=90);
		/**/
		
	}
	
	translate([0,0,Fin_Z]) rotate([0,0,45]) RingFin();
	
	translate([0,0,Fin_Z]) for (j=[0:nFins-1]) rotate([0,0,360/nFins*j+45]) FlatFin();
	
	if (ShowInternals)
		translate([0,0,Motor_Z]) ATRMS_54_427_Motor(HasEyeBolt=true);
} // ShowRocket

// ShowRocket(true);

module SpringEnd(OD=MotorPodBody_OD, Tube_ID=MotorPodBody_ID){
	// Connects shock cord and spring to Pod Tube.
	
	Al_Tube_d=12.7;
	Spring_ID=SE_Spring_CS4323_ID();
	Spring_OD=SE_Spring_CS4323_OD();
	nRopes=3;
	Rope_d=4;
	
	difference(){
		union(){
			Tube(OD=OD, ID=OD-15, Len=Al_Tube_d+3, myfn=$preview? 90:360);
			
			Tube(OD=OD, ID=Spring_ID-Rope_d*2-6, Len=3, myfn=$preview? 90:360);
			translate([0,0,-6]) Tube(OD=Tube_ID, ID=OD-12, Len=6, myfn=$preview? 90:360);
		} // union
		
		for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j+30]) translate([0,Spring_ID/2-Rope_d,0]) cylinder(d=Rope_d, h=10, center=true);
		
		translate([0,0,Al_Tube_d/2+1]) rotate([90,0,0]) cylinder(d=Al_Tube_d+IDXtra, h=OD+1, center=true);
		
		translate([0,0,-6-Overlap]) cylinder(d=SE_Spring_CS11890_OD(), h=6+Overlap, $fn=$preview? 90:360);
	} // difference
	
	translate([0,0,-6]) Tube(OD=Spring_OD+4.4, ID=Spring_OD, Len=7, myfn=$preview? 90:360);

} // SpringEnd

// rotate([180,0,0]) SpringEnd();
// rotate([180,0,0]) SpringEnd(OD=MotorPodBody_OD, Tube_ID=MotorPodBody_ID);

module SpringMiddle(OD=Coupler_OD){
	// Between 2 small springs
	Spring_ID=SE_Spring_CS4323_ID();
	Spring_OD=SE_Spring_CS4323_OD();
	
	OAH=25;
	
	Tube(OD=Spring_ID, ID=Spring_ID-4.4, Len=OAH, myfn=$preview? 90:360);
	Tube(OD=OD, ID=OD-4.4, Len=OAH, myfn=$preview? 90:360);
	
	translate([0,0,OAH/2-2])
	difference(){
		cylinder(d=OD-1, h=4);
		translate([0,0,-Overlap]) cylinder(d=Spring_ID-1, h=4+Overlap*2);
	}
	
} // SpringMiddle

// SpringMiddle();

module SpringMiddle2(OD=Coupler_OD){
	// Connects a large and small spring
	SmallSpring_ID=SE_Spring_CS4323_ID();
	SmallSpring_OD=SE_Spring_CS4323_OD();
	LargeSpring_ID=SE_Spring_CS11890_ID();
	LargeSpring_OD=SE_Spring_CS11890_OD();
	
	Len=23;
	
	difference(){
		union(){
			cylinder(d=LargeSpring_OD, h=3);
			cylinder(d=LargeSpring_ID, h=8);
			cylinder(d=SmallSpring_OD+6, h=Len);
		} // union
		translate([0,0,-Overlap]){
			cylinder(d=SmallSpring_ID, h=Len+Overlap*2);
			cylinder(d=SmallSpring_OD, h=Len-3);
			cylinder(d1=SmallSpring_OD+2, d2=SmallSpring_OD, h=Len-6);
		}
	} // difference
	
} // SpringMiddle2

// SpringMiddle2();
	
module ForwardDome(OD=Body_OD, Extension=Body_Ext/2){

	difference(){
		union(){
			translate([0,0,Extension]) sphere(d=OD, $fn=$preview? 90:360);
			cylinder(d=OD, h=Extension, $fn=$preview? 90:360);
		} // union
		
		mirror([0,0,1]) cylinder(d=OD+3, h=OD/2+1);
	} // difference
} // ForwardDome

// ForwardDome();

module AftDome(OD=Body_OD, Extension=Body_Ext/2){
	
	difference(){
		union(){
			translate([0,0,-Extension]) sphere(d=OD, $fn=$preview? 90:360);
			
			translate([0,0,-Extension]) cylinder(d=OD, h=Extension, $fn=$preview? 90:360);
		} // union
		
		cylinder(d=OD+2, h=OD/2+3);
	
	} // difference
} // AftDome

// AftDome();


module ForwardShell(TopOnly=false, BottomOnly=false){	
	Tip_Z=(Body_OD/2+Body_Ext/2)*Pointy;
	
	nNoseBolts=8;
	NoseBolt_a=38;
	NoseBolt_Z=Tip_Z-54*Pointy;
	NoseBolt_K=83; //71;
	NoseBolt_d=12;
	
	nRow2Bolts=8;
	Row2Bolt_a=59;
	Row2Bolt_Z=Tip_Z-74*Pointy;
	Row2Bolt_K=103.5;
	Row2Bolt_d=13;
	
	nRow3Bolts=6;
	Row3Bolt_a=84;
	Row3Bolt_Z=Tip_Z-118*Pointy;
	Row3Bolt_K=121.4;
	Row3Bolt_d=18;
	
	Ring1_Z=Tip_Z-29.5*Pointy;
	Ring2_Z=Tip_Z-33*Pointy;
	Ring3_Z=Tip_Z-47.5*Pointy;
	Ring4_Z=Tip_Z-75*Pointy;
	Ring5_Z=Tip_Z-84*Pointy;
	Ring6_Z=Body_Ext/2;
	
	CutLine_Z=Ring3_Z+1.75;
	//translate([0,0,CutLine_Z]) cylinder(d=Body_OD, h=0.01);
	
	module PanHead(D=12, H=2.8, Slot_w=2){
		difference(){
			hull(){
				cylinder(d=D, h=1);
				translate([0,0,H/2]) rotate_extrude() translate([D/2-H/2,0,0]) circle(d=H);
			} // hull
			rotate([0,0,rands(0,180,1)[0]]) translate([-D/2,-Slot_w/2,1]) cube([D,Slot_w,3]);
		} // difference
	} // PanHead
	
	module NoseBoltLocations(){
		for (j=[0:nNoseBolts-1]) rotate([0,0,360/nNoseBolts*j]) translate([0,0,NoseBolt_Z]) rotate([NoseBolt_a,0,0]) 
		translate([0,0,NoseBolt_K]) children();
	} // NoseBoltLocations
	
	module Row2BoltLocations(){
		for (j=[0:nRow2Bolts-1]) rotate([0,0,360/nRow2Bolts*j]) translate([0,0,Row2Bolt_Z]) rotate([Row2Bolt_a,0,0]) 
		translate([0,0,Row2Bolt_K]) children();
	} // Row2BoltLocations
	
	module Row3BoltLocations(){
		for (j=[0:nRow3Bolts-1]) rotate([0,0,360/nRow3Bolts*j]) translate([0,0,Row3Bolt_Z]) rotate([Row3Bolt_a,0,0]) 
		translate([0,0,Row3Bolt_K]) children();
	} // Row3BoltLocations
	
	difference(){
		union(){
			scale([1,1,Pointy]) ForwardDome(OD=Body_OD, Extension=Body_Ext/2);
			
			// rings
			if (IncludeArt){
				translate([0,0,Ring1_Z]) rotate_extrude($fn=$preview? 90:360) translate([79.5,0,0]) circle(d=3);
				translate([0,0,Ring2_Z]) rotate_extrude($fn=$preview? 90:360) translate([83.5,0,0]) circle(d=3.5);
				translate([0,0,Ring3_Z]) rotate_extrude($fn=$preview? 90:360) translate([96.8,0,0]) circle(d=3.5);
				translate([0,0,Ring4_Z]) rotate_extrude($fn=$preview? 90:360) translate([113.5,0,0]) circle(d=3.5);
				translate([0,0,Ring5_Z]) scale([1,1,2]) rotate_extrude($fn=$preview? 90:360) translate([117,0,0]) circle(d=3.5);
				translate([0,0,Ring6_Z]) scale([1,1,2]) rotate_extrude($fn=$preview? 90:360) translate([Body_OD/2-1,0,0]) circle(d=3.5);
			}
			
			rotate([0,0,45]) RailGuideBoss();
		} // union
		
		rotate([0,0,45]) RailGuideBolts();
		translate([0,0,-50]) cylinder(d=Body_OD+3, h=50);
		
		// Remove inside
		translate([0,0,-Overlap]) scale([1,1,Pointy]) ForwardDome(OD=Body_OD-Body_Wall_t*2, Extension=Body_Ext/2);
		
		// Decorative bolt counter bores
		if (IncludeArt){
			NoseBoltLocations() cylinder(d=NoseBolt_d+1, h=5);
			Row3BoltLocations() cylinder(d=Row3Bolt_d+1, h=5);
		}
		
		if (TopOnly || IncludeArt) rotate([0,0,22.5]) Row2BoltLocations() {
			cylinder(d=Row2Bolt_d+1, h=5);
			if (TopOnly) mirror([0,0,1]) translate([0,0,-Overlap]) cylinder(d=7, h=7);
		}
		
		if (TopOnly)
			translate([0,0,-Overlap]) cylinder(d=Body_OD+5, h=CutLine_Z+Overlap);
		
		if (BottomOnly)
			translate([0,0,CutLine_Z-Overlap]) cylinder(d=Body_OD+5, h=Body_OD);
			
		if ($preview) translate([0,0,-Overlap]) cube([Body_OD/2+1, Body_OD/2+1, (Body_OD/2+Body_Ext/2+1)*Pointy]);
	} // difference
	
	// Decorative bolts
	if (IncludeArt){
		if (!BottomOnly) NoseBoltLocations() PanHead(D=NoseBolt_d, H=2.8, Slot_w=2);
		if (!TopOnly && !BottomOnly)
			rotate([0,0,22.5]) Row2BoltLocations() PanHead(D=Row2Bolt_d, H=3, Slot_w=2);
		if (!TopOnly) Row3BoltLocations() PanHead(D=Row3Bolt_d, H=3.4, Slot_w=2.5);
	}
	
	// Bolt flange
	if (BottomOnly) difference(){
		union(){
			scale([1,1,Pointy]) ForwardDome(OD=Body_OD-Body_Wall_t*2-IDXtra, Extension=Body_Ext/2);
			
			translate([0,0,CutLine_Z-12]) cylinder(d1=Body_OD-55, d2=Body_OD-62, h=12);
		} // union
		
		translate([0,0,CutLine_Z-12-Overlap*2]) cylinder(d1=Body_OD-56, d2=Body_OD-75, h=10, $fn=$preview? 90:360);
		
		translate([0,0,-Overlap]) scale([1,1,Pointy]) ForwardDome(OD=Body_OD-Body_Wall_t*2-IDXtra-6, Extension=Body_Ext/2);
		
		translate([0,0,CutLine_Z+15]) cylinder(d=Body_OD+5, h=Body_OD);
		translate([0,0,-Overlap]) cylinder(d=Body_OD+5, h=CutLine_Z-12);
		
		rotate([0,0,22.5]) Row2BoltLocations()
			translate([0,0,-20]) {
				if ($preview) {
					cylinder(d=5, h=20);
				}else{
					ExternalThread(Pitch=25.4/20, Dia_Nominal=6.35, Length=20, Step_a=5, TrimEnd=false, TrimRoot=false);
				}
				
			}
			
		if ($preview) translate([0,0,-Overlap]) cube([Body_OD/2+1, Body_OD/2+1, (Body_OD/2+Body_Ext/2+1)*Pointy]);
	}
	
	
	// Skirt
	if (!TopOnly)
	difference(){
		union(){
			translate([0,0,-15]) Tube(OD=Body_OD-Body_Wall_t*2, ID=Body_OD-Body_Wall_t*2-4.4, Len=20, myfn=$preview? 90:360);
			Tube(OD=Body_OD-Body_Wall_t*2+Overlap, ID=Body_OD-Body_Wall_t*2-4.4, Len=5, myfn=$preview? 90:360);
			translate([0,0,5]) TubeStop(InnerTubeID=Body_OD-Body_Wall_t*2-4.4, OuterTubeOD=Body_OD-Body_Wall_t+Overlap, myfn=$preview? 90:360);
		} // union
		
		rotate([0,0,45]) RailGuideBolts();
		
		for (j=[0:nShellBolts-1]) rotate([0,0,360/nShellBolts*j+ShellBolt_a]) translate([0,Body_OD/2,-7.5]) rotate([-90,0,0]) Bolt6Hole();
		
		if ($preview) translate([0,0,-20]) cube([Body_OD/2+1, Body_OD/2+2, Body_OD/2+Body_Ext/2+1]);
	} // difference
	
	
	// Forward dome
	if (!BottomOnly)
	difference(){
		translate([0,0,(Body_OD/2+Body_Ext/2)*Pointy-45]) {
			Tube(OD=MotorPodBody_OD+6, ID=MotorPodBody_OD+IDXtra*2, Len=20, myfn=$preview? 90:360);
			translate([0,0,15]){
				cylinder(d=MotorPodBody_OD+6, h=2);
				cylinder(d1=MotorPodBody_OD+16, d2=60, h=20);
				translate([0,0,19]) cylinder(d1=60, d2=30, h=7);
			}
		}
		if ($preview) translate([0,0,(Body_OD/2+Body_Ext/2)*Pointy-50]) cube([Body_OD/2+2, Body_OD/2+2, Body_OD/2+Body_Ext/2+1]);
	} // difference
} // ForwardShell

// ForwardShell(TopOnle=false, BottomOnly=false);
// ForwardShell(TopOnly=true, BottomOnly=false);
// ForwardShell(TopOnly=false, BottomOnly=true);

module AftShell(){
	Fin_Z=Base_Z;
	FinBox_t=1.8;
	
	Tip_Z=(Body_OD/2+Body_Ext/2)*AftPointy;
	Ring1_Z=-(Tip_Z-47*Pointy);
	Ring2_Z=-(Tip_Z-63*Pointy);

	TailCube_X=24;
	TailCube_Y=84;
	TailCube_Z=Ring1_Z+7;

	
	difference(){
		union(){
			scale([1,1,AftPointy]) AftDome(OD=Body_OD, Extension=Body_Ext/2);
			
			if (IncludeArt)
			for (j=[0:nFins-1]) rotate([0,0,360/nFins*j]){ 
				translate([-TailCube_X/2, TailCube_Y, TailCube_Z]) rotate([15,0,0]) cube([2,40,40], center=true);
				translate([TailCube_X/2, TailCube_Y, TailCube_Z]) rotate([15,0,0]) cube([2,40,40], center=true);
				translate([0, TailCube_Y, TailCube_Z]) rotate([15,0,0]) cube([TailCube_X,39,39], center=true);
				
			}
			
			// rings
			if (IncludeArt){
				translate([0,0,Ring1_Z]) rotate_extrude($fn=$preview? 90:360) translate([97,0,0]) circle(d=3);
				translate([0,0,Ring2_Z]) rotate_extrude($fn=$preview? 90:360) translate([107.5,0,0]) circle(d=3.5);
			}
			
			rotate([0,0,45]) RailGuideBoss();
		} // union
		
		// Overlap with Forward Dome
		translate([0,0,-15]) cylinder(d=Body_OD-Body_Wall_t*2+IDXtra*2, h=15+Overlap, $fn=$preview? 90:360);
		translate([0,0,-17]) cylinder(d1=Body_OD-Body_Wall_t*2-1, d2=Body_OD-Body_Wall_t*2+IDXtra*2, h=2+Overlap, $fn=$preview? 90:360);
		
		rotate([0,0,45]) RailGuideBolts();
		cylinder(d=Body_OD+3, h=50);
		
		// Fin sockets
		translate([0,0,Fin_Z]) for (j=[0:nFins-1]) rotate([0,0,360/nFins*j+45]) FlatFinSocket();
		
		
		translate([0,0,Overlap]) scale([1,1,AftPointy]) AftDome(OD=Body_OD-Body_Wall_t*2, Extension=Body_Ext/2);
	
		// cut off base
		//translate([0,0,Base_Z]) cylinder(d=Body_OD, h=10);
		
		// Motor Pod trust ring clearance
		translate([0,0,Base_Z])
			cylinder(d=MotorPodBody_OD+3, h=41, $fn=$preview? 90:360);
			
		// Shell bolts
		for (j=[0:nShellBolts-1]) rotate([0,0,360/nShellBolts*j+ShellBolt_a]) translate([0,Body_OD/2,-7.5]) rotate([-90,0,0]) Bolt6ButtonHeadHole();
		
		if ($preview) translate([0,0,(-Body_OD/2-Body_Ext/2)*Pointy-80-Overlap]) 
			cube([Body_OD/2+1, Body_OD/2+1, (Body_OD/2+Body_Ext/2)*Pointy+100]);
	} // difference
	
	
	difference(){
		union(){
			translate([0,0,Base_Z+41]) Tube(OD=MotorPodBody_OD+IDXtra*2+4.4, ID=MotorPodBody_OD+IDXtra*2, Len=75, myfn=$preview? 90:360);
			translate([0,0,MotorStop_Z]) Tube(OD=MotorPodBody_OD+8, ID=MotorPodBody_OD+3, Len=25, myfn=$preview? 90:360);
			difference(){
				translate([0,0,MotorStop_Z+25-Overlap]) cylinder(d1=MotorPodBody_OD+8, d2=MotorPodBody_OD+IDXtra*2, h=8, $fn=$preview? 90:360);
				translate([0,0,MotorStop_Z+25-Overlap*2]) cylinder(d=MotorPodBody_OD+IDXtra*2, h=8+Overlap*2, $fn=$preview? 90:360);
			} // difference
		} // union
		
		if ($preview) translate([0,0,(-Body_OD/2-Body_Ext/2)*Pointy-80-Overlap]) 
			cube([Body_OD/2+1, Body_OD/2+1, (Body_OD/2+Body_Ext/2)*Pointy+100]);
	}

	difference(){
		intersection(){
			// Fin boxes
			translate([0,0,MotorStop_Z]) for (j=[0:nFins-1]) rotate([0,0,360/nFins*j+45]) 
				translate([-FinThickness/2-FinBox_t,MotorPodBody_OD/2,0]) cube([FinThickness+FinBox_t*2,70,75]);
				
			scale([1,1,AftPointy]) AftDome(OD=Body_OD, Extension=Body_Ext/2);
		} // intersection
			
		// Fin sockets
		translate([0,0,Fin_Z]) for (j=[0:nFins-1]) rotate([0,0,360/nFins*j+45]) FlatFinSocket();
		
		// Remove inside of Pod tube
		translate([0,0,Base_Z])
			cylinder(d=MotorPodBody_OD+3, h=250, $fn=$preview? 90:360);
			
		if ($preview) translate([0,0,(-Body_OD/2-Body_Ext/2)*Pointy-80-Overlap]) 
			cube([Body_OD/2+1, Body_OD/2+1, (Body_OD/2+Body_Ext/2)*Pointy+100]);
	} // difference
} // AftShell

// AftShell();
// ThrustRing();
// TheButt();

module ThrustRing(){
	Al_MotorRetainer_d=63;
	Al_MotorRetainer_Len=33;
	StopRing_Len=10;
	
	nButtBolts=6;
	nButtBolt_BC_d=Al_MotorRetainer_d+16;
	
	
	difference(){
		translate([0,0,MotorStop_Z]) cylinder(d=MotorPodBody_OD, h=50, $fn=$preview? 90:360);
		
		// Lightening
		translate([0,0,MotorStop_Z+22]) difference(){
			cylinder(d=MotorPodBody_OD, h=30);
			
			translate([0,0,-Overlap]) cylinder(d=MotorTube_OD+6, h=50, $fn=$preview? 90:360);
		}
		
		// Butt Bolts
		for (j=[0:nButtBolts-1]) rotate([0,0,360/nButtBolts*j]) translate([0,nButtBolt_BC_d/2,MotorStop_Z])
			rotate([180,0,0]) Bolt4Hole();
		
		difference(){
			translate([0,0,MotorStop_Z+12]) cylinder(d=Body_OD+2, h=Body_OD);
			
			translate([0,0,MotorStop_Z-Overlap]) cylinder(d=Coupler_ID, h=100, $fn=$preview? 90:360);
		} // difference
		
		// Motor Pod tube and stop ring
		translate([0,0,MotorStop_Z+6])
			Tube(OD=MotorPodBody_OD+IDXtra*2, ID=Coupler_ID, Len=100, myfn=$preview? 90:360);
		
		
		// Motor retainer
		translate([0,0,Base_Z+5]) cylinder(d=Al_MotorRetainer_d+IDXtra*2, h=Al_MotorRetainer_Len);
		
		// Motor Tube
		translate([0,0,Base_Z]) cylinder(d=MotorTube_OD+IDXtra*2, h=100, $fn=$preview? 90:360);
	
		if ($preview) rotate([0,0,-90]) translate([0,0,Base_Z]) cube([100,100,100]);
	} // difference
} // ThrustRing

// ThrustRing();

module TheButt(){
	Al_MotorRetainer_d=63;
	Al_MotorRetainer_Len=33;
	StopRing_Len=10;
	
	nButtBolts=6;
	nButtBolt_BC_d=Al_MotorRetainer_d+16;
	
	difference(){
		scale([1,1,AftPointy]) AftDome(OD=Body_OD, Extension=Body_Ext/2);
		
		translate([0,0,MotorStop_Z]) cylinder(d=Body_OD, h=100);
		
		// Butt Bolts
		for (j=[0:nButtBolts-1]) rotate([0,0,360/nButtBolts*j]) translate([0,nButtBolt_BC_d/2,MotorStop_Z-10])
			rotate([180,0,0]) Bolt4HeadHole();
			
		difference(){
			translate([0,0,MotorStop_Z-30]) cylinder(d=Body_OD+2, h=Body_OD);
			
			translate([0,0,MotorStop_Z-30-Overlap]) cylinder(d=MotorPodBody_OD+2, h=60, $fn=$preview? 90:360);
		} // difference		
		
		// Motor retainer
		translate([0,0,Base_Z+5]) cylinder(d=Al_MotorRetainer_d+IDXtra*2, h=Al_MotorRetainer_Len);
		
		// Motor Tube
		translate([0,0,Base_Z]) cylinder(d=MotorTube_OD+IDXtra*2, h=100);
	
		if ($preview) rotate([0,0,-90]) translate([0,0,Base_Z]) cube([100,100,100]);
	} // difference

} // TheButt

//translate([0,0,150]) TheButt();

module MN_PetalHub(OD=BT98Coupler_OD){
	Spring_OD=SE_Spring_CS4323_OD();
	Spring_ID=SE_Spring_CS4323_ID();
	nRopes=3;
	Rope_d=4;

	difference(){
		union(){
			PD_PetalHub(OD=OD, 
					nPetals=3, 
					HasBolts=false,
					nBolts=0, // Same as nPetals
					ShockCord_a=-1,
					HasNCSkirt=false, 
						Body_OD=Coupler_OD,
						Body_ID=Coupler_ID,
						NC_Base=0, 
						SkirtLen=10);
						
			// Skirt			
			translate([0,0,-15]) Tube(OD=OD, ID=OD-4.4, Len=15+Overlap, myfn=$preview? 90:360);
		} // union
		
		// center hole
		translate([0,0,-Overlap]) cylinder(d=20, h=10);
		
		// Rope Holes
		for (j=[0:nRopes-1]) rotate([0,0,360/nRopes*j+60]) {
			translate([0,Spring_ID/2-Rope_d,-Overlap]) cylinder(d=Rope_d, h=20);
			translate([0,Spring_ID/2-Rope_d,5]) cylinder(d=Rope_d*2, h=20);
		}
	} // difference

	translate([0,0,-15]) Tube(OD=Spring_OD+4.4, ID=Spring_OD, Len=16, myfn=$preview? 90:360);
} // MN_PetalHub

// MN_PetalHub();

module FlatFinSocket(){
	hull(){
		// Root
		translate([-FinTip_W/2-IDXtra, MotorPodBody_OD/2+5-IDXtra, -FinLength+80])  
			cube([FinTip_W+IDXtra*2, 10+IDXtra*2, FinRoot_L-55]);
			
		// Tip
		translate([-FinTip_W/2-IDXtra, Body_OD/2-RingFin_Thickness, -FinLength+25]) 
			cube([FinTip_W+IDXtra*2, Overlap, FinTip_L]);
	} // hull
	
} // FlatFinSocket

// FlatFinSocket();

module FlatFin(){
	
	intersection(){
		difference(){
			union(){
				// Root
				translate([-FinTip_W/2, MotorPodBody_OD/2+5, -FinLength+80])  cube([FinTip_W,10,FinRoot_L-55]);
				hull(){
					// Root
					translate([-FinTip_W/2, MotorPodBody_OD/2+15, -FinLength+25])  cube([FinTip_W,Overlap,FinRoot_L]);
					// Tip
					translate([-FinTip_W/2, Body_OD/2-RingFin_Thickness, -FinLength+25]) cube([FinTip_W,Overlap,FinTip_L]);
				} // hull
				
				hull() translate([0,-RingFin_Thickness,0]) OuterFinBoltPattern() rotate([180,0,0]) cylinder(d=10, h=4);
			} // union
			
			OuterFinBoltPattern() Bolt6Hole();
			
		} // difference
	
		translate([0,0,-FinLength]) cylinder(d=Body_OD-RingFin_Thickness*2, h=150, $fn=$preview? 90:360);
	} // intersection
} // FlatFin

// rotate([-90,0,0]) FlatFin();

module OuterFinBoltPattern(){
	FinBolt_a=4;
	
	rotate([0,0,FinBolt_a]) translate([0,Body_OD/2,-10]) rotate([-90,0,0]) children();
	rotate([0,0,-FinBolt_a]) translate([0,Body_OD/2,-10]) rotate([-90,0,0]) children();
	rotate([0,0,FinBolt_a]) translate([0,Body_OD/2,-30]) rotate([-90,0,0]) children();
	rotate([0,0,-FinBolt_a]) translate([0,Body_OD/2,-30]) rotate([-90,0,0]) children();
	
} // OuterFinBoltPattern

//OuterFinBoltPattern() Bolt6Hole();

module RailGuideBoss(){
	Boss_h=22.7;
	
	translate([0,Body_OD/2,0]) hull(){
				translate([0,0,Boss_h/2]) rotate([90,0,0]) cylinder(d=20, h=3);
				translate([0,0,-Boss_h/2]) rotate([90,0,0]) cylinder(d=20, h=3);
			} // hull
} // RailGuideBoss

module RailGuideBolts(){
	RG_Bolt_Spacing=12.7;
	translate([0,Body_OD/2,0]) {
			translate([0,0,RG_Bolt_Spacing/2]) rotate([-90,0,0]) Bolt6Hole();
			translate([0,0,-RG_Bolt_Spacing/2]) rotate([-90,0,0]) Bolt6Hole();
		}
	translate([0,3,0]) RailGuideBoss(); // removes art
} // RailGuideBolts

// RailGuideBolts();

module RingFin(){
	
	difference(){
		union(){
			rotate_extrude($fn=$preview? 90:360) 
				translate([Body_OD/2-RingFin_Thickness/2,0,0]) {
					circle(d=RingFin_Thickness);
					translate([-RingFin_Thickness/2,-RingFin_Len,0]) square([RingFin_Thickness,RingFin_Len]);
				}
				
			// Rail guide boss
			translate([0,0,-25]) RailGuideBoss();
		} // union
		
		// notches
		for (j=[0:nFins-1]) rotate([0,0,360/nFins*(j+0.5)]) translate([0,0,-RingFin_Len]) hull(){
				rotate([0,0,20]) rotate([90,0,0]) RoundRect(X=3, Y=90, Z=Body_OD/2+20, R=3);
				rotate([0,0,-20]) rotate([90,0,0]) RoundRect(X=3, Y=90, Z=Body_OD/2+20, R=3);
			}
		
		for (j=[0:nFins-1]) rotate([0,0,360/nFins*j]) OuterFinBoltPattern() Bolt6ButtonHeadHole();
		
		
		// Rail guide bolts
		translate([0,0,-25]) RailGuideBolts();
	} // difference
} // RingFin

// RingFin();














































