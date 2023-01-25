// ***********************************
// Project: 3D Printed Rocket
// Filename: TubesLib.scad
// by David M. Flynn
// Created: 6/13/2022 
// Revision: 0.9.9  1/18/2023
// Units: mm
// ***********************************
//  ***** Notes *****
//
// Standard Tube Sizes
//
//  ***** History *****
//
echo("TubesLib 0.9.9");
// 0.9.9  1/18/2023  Added Offset to CenteringRing()
// 0.9.8  12/29/2022 Added ShockCordMount()
// 0.9.7  12/2/2022  Added BT38Body tube
// 0.9.6  11/20/2022 Added ClusterRing
// 0.9.5  11/12/2022 Added Blue Tube 2.0  5.5" body & coupler. 
// 0.9.4  10/16/2022 Added Blue Tube 2.0 54mm body & coupler. 
// 0.9.3  10/10/2022 Added 6" PML tubing
// 0.9.2  10/3/2022 Added TubeStop()
// 0.9.1  6/24/2022 Moved rivet stuff here.
// 0.9.0  6/13/2022 First code.
//
// ***********************************
//  ***** for STL output *****
//
// ShockCordMount(OD=PML98Body_ID, ID=BT54Mtr_OD, AnchorRod_OD=12.7);
// Tube(OD=PML54Body_OD, ID=PML54Body_ID, Len=300, myfn=$preview? 36:360);
// CenteringRing(OD=PML98Body_ID, ID=PML54Body_OD, Thickness=5, nHoles=0, Offset=0);
// ClusterRing(OD=BT137Body_ID, Thickness=5, CenterMotor_OD=BT54Body_OD, ClusterMotor_OD=PML38Body_OD, nClusterMotors=3, Gap=7, Cant_a=2, Cant_Z=300)
//
// BT_RivetFixture(BT_Dia=PML98Body_OD, nRivets=3, Dia=5/32*25.4, Offset=25);
//
// ***********************************
//  ***** Routines *****
//
// Tube(OD=PML54Body_OD, ID=PML54Body_ID, Len=300, myfn=$preview? 36:360);
// TubeStop(InnerTubeID=PML54Coupler_ID, OuterTubeOD=PML54Body_OD, myfn=$preview? 36:360);
// CenteringRing(OD=PML98Body_ID, ID=PML54Body_OD, Thickness=5, nHoles=0);
// LanyardToTube(ID=PML98Coupler_ID); // Attatch a lanyard to the inside of a tube.
// Piston(OD=PML98Coupler_OD, ID=PML98Coupler_ID, Len=75, BP_Thickness=5);
// RivetPattern(BT_Dia=PML98Body_OD, nRivets=3, Dia=5/32*25.4);
//
// ***********************************

Overlap=0.05;
IDXtra=0.2;
$fn=$preview? 24:90;

// 6" Airframe
PML150Body_OD=(6.007+2*0.074)*25.4; // about 155mm
PML150Body_ID=6.007*25.4;
PML150Coupler_OD=6*25.4;
PML150Coupler_ID=5.86*25.4;

// ***** PML Paper Phenolic Tubes *****
// These sizes have not been verified.
PML98Body_OD=(3.9+0.062*2)*25.4;
PML98Body_ID=3.9*25.4;
PML98Coupler_OD=(3.78+0.062*2)*25.4;
PML98Coupler_ID=95.4; //measured LOC/PML, was 3.78*25.4;
//*
echo(PML98Body_OD=PML98Body_OD);
echo(PML98Body_ID=PML98Body_ID);
echo(PML98Coupler_OD=PML98Coupler_OD);
echo(PML98Coupler_ID=PML98Coupler_ID);
/**/


PML75Body_OD=79.6; // 8/4/2022 Adjusted +0.2 to match QT better
PML75Body_ID=3.002*25.4;
PML75Coupler_OD=PML75Body_ID-0.4; // 8/3/2022 Adjusted -0.4 to fit QT
PML75Coupler_ID=PML75Coupler_OD-4.4;
//echo(PML75Body_OD=PML75Body_OD);
//echo(PML75Body_ID=PML75Body_ID);
//echo(PML75Coupler_OD=PML75Coupler_OD);
//echo(PML75Coupler_ID=PML75Coupler_ID);

PML54Body_OD=57.9; // actual measured from LOC/PML tube
PML54Body_ID=2.152*25.4;
PML54Coupler_OD=(2.02+0.062*2)*25.4;
PML54Coupler_ID=2.02*25.4;

//echo(PML54Body_OD=PML54Body_OD);

// Blue Tube 2.0
BT137Body_ID=5.385*25.4;
BT137Body_OD=BT137Body_ID+0.077*2*25.4;
BT137Coupler_ID=5.198*25.4;
BT137Coupler_OD=BT137Coupler_ID+0.084*2*25.4;

BT98Body_OD=101.9;
BT98Body_ID=98.9;
BT98Coupler_OD=98.6;
BT98Coupler_ID=95.7;

BT75Body_ID=3.000*25.4;
BT75Body_OD=BT75Body_ID+0.062*2*25.4;
BT75Coupler_ID=2.880*25.4;
BT75Coupler_OD=BT75Coupler_ID+0.062*2*25.4;

BT54Mtr_OD=57.20;
BT54Mtr_ID=54.40;
BT54Body_OD=57.20;
BT54Body_ID=54.2;
BT54Coupler_OD=53.60;
BT54Coupler_ID=50.70;

BT38Body_OD=41.30;
BT38Body_ID=38.50;
BT38Coupler_OD=38.20;

PML38Body_OD=42.2; //(1.525+0.062*2)*25.4; // 42.2 measured
PML38Body_ID=1.525*25.4;
PML38Coupler_OD=(1.40+0.062*2)*25.4;
PML38Coupler_ID=1.40*25.4;
//echo(PML38Body_OD=PML38Body_OD);

module CenteringRing(OD=PML98Body_ID, ID=PML54Body_OD, Thickness=5, nHoles=0, Offset=0){
	difference(){
		cylinder(d=OD, h=Thickness);
		
		translate([0,Offset,-Overlap]) cylinder(d=ID, h=Thickness+Overlap*2);
		if (nHoles>0) for (j=[0:nHoles-1]) rotate([0,0,360/nHoles*j])
			translate([ID/2+(OD/2-ID/2)/2,0,-Overlap]) cylinder(d=(OD/2-ID/2)/2, h=Thickness+Overlap*2);
	} // difference
} // CenteringRing

//CenteringRing(OD=PML98Body_ID, ID=PML54Body_OD, Thickness=5);
//CenteringRing(OD=BT54Body_ID, ID=BT38Coupler_OD+IDXtra*2, Thickness=5, nHoles=0);
//CenteringRing(OD=PML98Coupler_ID, ID=PML54Body_OD+IDXtra*2, Thickness=5, nHoles=5);
//CenteringRing(OD=PML98Coupler_ID, ID=BT38Body_OD+IDXtra*2, Thickness=5, nHoles=5);
//echo(PML98Coupler_ID=PML98Coupler_ID);
//58x95.4

module ClusterRing(OD=BT137Body_ID, Thickness=5,
					CenterMotor_OD=BT54Body_OD, ClusterMotor_OD=PML38Body_OD, nClusterMotors=3,
					Gap=7, Cant_a=0, Cant_Z=300){
	difference(){
		cylinder(d=OD, h=Thickness);
		
		if (CenterMotor_OD>0)
			translate([0,0,-Overlap]) cylinder(d=CenterMotor_OD, h=Thickness+Overlap*2);
		
		for (j=[0:nClusterMotors-1]) rotate([0,0,360/nClusterMotors*j]) 
			translate([0,CenterMotor_OD/2+ClusterMotor_OD/2+Gap,-Cant_Z])
				rotate([Cant_a,0,0]) translate([0,0,-5])
				cylinder(d=ClusterMotor_OD, h=Cant_Z+Thickness+10);
	} // difference
} // ClusterRing

//ClusterRing(OD=BT137Body_ID, Thickness=5, CenterMotor_OD=BT54Body_OD, ClusterMotor_OD=PML38Body_OD, nClusterMotors=3, Gap=7, Cant_a=2, Cant_Z=0);

module ShockCordMount(OD=PML98Body_ID, ID=BT54Mtr_OD, AnchorRod_OD=12.7){
	H=20;
	
	difference(){
		union(){
			cylinder(d=OD, h=5);
			cylinder(d=ID+10, h=H);
			hull(){
				translate([-(AnchorRod_OD+10)/2, -(OD-4)/2,5-Overlap]) 
					cube([AnchorRod_OD+10, OD-4, Overlap]);
				translate([-(AnchorRod_OD+5)/2, -(ID+8)/2, H-2])
					cube([AnchorRod_OD+5, ID+8, Overlap]);
			} // hull
		} // union
		
		translate([0,0,-Overlap]) cylinder(d=ID+IDXtra*2, h=H+Overlap*2);
		translate([0,0,5+AnchorRod_OD/2+IDXtra]) rotate([90,0,0]) 
			cylinder(d=AnchorRod_OD+IDXtra*2, h=OD+2, center=true);
	} // diff
} // ShockCordMount

//ShockCordMount();

//ShockCordMount(OD=PML98Coupler_ID, ID=PML54Body_OD+IDXtra*2, AnchorRod_OD=12.7);

module Tube(OD=PML54Body_OD, ID=PML54Body_ID, Len=300, myfn=$preview? 36:360){
	difference(){
		cylinder(d=OD, h=Len, $fn=myfn);
		translate([0,0,-Overlap]) cylinder(d=ID, h=Len+Overlap*2, $fn=myfn);
	} // difference
} // Tube

//Tube(OD=PML54Body_OD, ID=PML54Body_ID, Len=300, myfn=$preview? 36:360);
//Tube(OD=PML54Body_OD, ID=PML54Body_ID, Len=1.5, myfn=$preview? 36:360); // spacer!

module TubeStop(InnerTubeID=PML54Coupler_ID, OuterTubeOD=PML54Body_OD, myfn=$preview? 36:360){
	
	Base_h=2;
	OAH=Base_h+(OuterTubeOD-InnerTubeID)/2; // force to 45° to remove support matterial. 
	//echo(OAH=OAH);
	
	difference(){
		cylinder(d=OuterTubeOD-1, h=OAH, $fn=myfn);
		
		translate([0,0,-Overlap]) cylinder(d=InnerTubeID, h=OAH+Overlap*2, $fn=myfn);
		translate([0,0,Base_h]) cylinder(d1=InnerTubeID, d2=OuterTubeOD-2, h=OAH-Base_h+Overlap, $fn=myfn);
	} // difference
} // TubeStop

//TubeStop();

module Piston(OD=PML98Coupler_OD, ID=PML98Coupler_ID, Len=75, BP_Thickness=5){
	Tube(OD=OD-IDXtra*2, ID=ID-IDXtra*2, Len=Len, myfn=$preview? 36:360);
	cylinder(d=OD-IDXtra*2, h=BP_Thickness);
} // Piston

//translate([0,0,75+20]) rotate([180,0,0]) Piston();


module RivetPattern(BT_Dia=PML98Body_OD, nRivets=3, Dia=5/32*25.4){
	for (j=[0:nRivets-1]) rotate([0,0,360/nRivets*j])
		translate([BT_Dia/2+Overlap,0,0]) rotate([0,-90,0]) cylinder(d=Dia, h=10);
} // RivetPattern

//RivetPattern(BT_Dia=PML98Body_OD, nRivets=3, Dia=5/32*25.4);

module BT_RivetFixture(BT_Dia=PML98Body_OD, nRivets=3, Dia=5/32*25.4, Offset=25 ){
	difference(){
		cylinder(d=BT_Dia+6, h=Offset+3);
		
		// Body tube
		translate([0,0,3]) cylinder(d=BT_Dia+IDXtra*3,h=Offset+20);
		translate([0,0,-Overlap]) cylinder(d=BT_Dia-3, h=4);
		
		// Rivets
		translate([0,0,3+Offset]) 
			RivetPattern(BT_Dia=BT_Dia+6, nRivets=nRivets, Dia=Dia);
		
	} // difference
} // BT_RivetFixture

// BT_RivetFixture();










