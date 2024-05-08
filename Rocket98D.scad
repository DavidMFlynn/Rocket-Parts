// ************************************************
// Project: 3D Printed Rocket
// Filename: Rocket98D.scad
// by David M. Flynn
// Created: 10/23/2023 
// Revision: 1.2.0  12/28/2023 
// Units: mm
// ***********************************
//  ***** Notes *****
//
// New drogue deployment system prototype
//
//
//
// ***********************************
//  ***** for STL output *****
//
// *** Nosecode ***
//
// BluntOgiveNoseCone(ID=Body_ID, OD=Body_OD, L=NC_Len, Base_L=NC_Base_L, Tip_R=NC_Tip_r, Wall_T=NC_Wall_t, Cut_Z=0, LowerPortion=false);
// NC_ShockcordRingDual(Tube_OD=Body_OD, Tube_ID=Body_ID, NC_Base_L=NC_Base_L, nRivets=3);
//
// PD_NC_PetalHub(OD=Coupler_OD, nPetals=3, nRopes=6, ShockCord_a=-1, HasThreadedCore=false);
// rotate([-90,0,0]) PD_PetalSpringHolder(OD=Coupler_OD);
// rotate([180,0,0]) PD_Petals(OD=Coupler_OD, Len=110, nPetals=3, Wall_t=1.8, AntiClimber_h=4, HasLocks=false, Lock_Span_a=0);
//
// CRBB_ExtensionRod(Len=100);
// CRBB_LockingPin(LockPin_Len=LockPin_Len, GuidePoint=false);
// rotate([180,0,0]) CRBB_LockRing(GuidePoint=true);
// rotate([180,0,0]) CRBB_TopRetainer(LockRing_d=LockRing_d, GuidePoint=true);
// CRBB_OuterBearingRetainer();
// rotate([180,0,0]) CRBB_InnerBearingRetainer();
// rotate([180,0,0]) CRBB_MagnetBracket();
// rotate([180,0,0]) CRBB_TriggerPost();
//
// rotate([180,0,0]) CRBB_TopRetainerEBayEnd(Body_OD=Body_OD, Body_ID=Body_ID, Coupler_OD=Coupler_OD, HasSpring=false, CT_Len=20, StopRing_Len=45, nBolts=3);
//
// R98C_BallRetainerTop(); // One servo w/ shock cord attachment.
// R98_BallRetainerBottom(); // w/ 3 bolt holes for PetalHub.
//
//
// ***********************************
include<TubesLib.scad>
use<R98Lib.scad>
use<FinCan2Lib.scad> echo(FinCan2LibRev());
use<AT-RMS-Lib.scad>
use<RailGuide.scad>
use<Fins.scad>
use<NoseCone.scad>
use<ElectronicsBayLib.scad>
use<AltBay.scad>
use<BatteryHolderLib.scad>
use<SpringThingBooster.scad> SpringThingBoosterRev();
use<PetalDeploymentLib.scad>
use<SpringThing2.scad>
use<SpringEndsLib.scad>
use<CableReleaseBB.scad> echo(CableReleaseBBRev());

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

LockRing_d=20;
LockPin_Len=23;

CouplerLenXtra=-10;

nFins=5;
//*
// Standard
Fin_Post_h=12;
Fin_Root_L=200;
Fin_Root_W=12;
Fin_Tip_W=3.0;
Fin_Tip_L=70;
Fin_Span=100;
Fin_TipOffset=20;
Fin_Chamfer_L=24;
/**/

Body_OD=BT98Body_OD;
Body_ID=BT98Body_ID;
Coupler_OD=BT98Coupler_OD;
Coupler_ID=BT98Coupler_ID;

// *** 54mm Motor Tube ***
MotorTube_OD=BT54Body_OD;
MotorTube_ID=BT54Body_ID;
MotorCoupler_OD=BT54Coupler_OD;


NC_Len=350;
NC_Tip_r=5;
NC_Wall_t=2.2;
NC_Base_L=15;

ForwardPetalLen=110;
ForwardTubeLen=7*25.4;

EBay_Len=162;
AftPetalLen=150;
MotorTubeLen=19.5*25.4;
BodyTubeLen=19*25.4; // Range 19-22

Alt_DoorXtra_X=6;
Alt_DoorXtra_Y=4;

FinInset_Len=10;
Can_Len=Fin_Root_L+FinInset_Len*2;
Bolt4Inset=4;
nLockBalls=6;
nPetals=3;
ShockCord_a=17;// offset between PD_PetalHub and R65_BallRetainerBottom
TailCone_Len=65;
RailGuide_h=Body_OD/2+2;































