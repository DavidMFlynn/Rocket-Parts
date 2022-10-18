// ***********************************
// Project: 3D Printed Rocket
// Filename: TubesLib.scad
// by David M. Flynn
// Created: 6/13/2022 
// Revision: 0.9.4  10/16/2022
// Units: mm
// ***********************************
//  ***** Notes *****
//
// Standard Tube Sizes
//
//  ***** History *****
//
echo("TubesLib 0.9.4");
// 0.9.4  10/16/2022 Added Blue Tube 2.0 54mm body & coupler. 
// 0.9.3  10/10/2022 Added 6" PML tubing
// 0.9.2  10/3/2022 Added TubeStop()
// 0.9.1  6/24/2022 Moved rivet stuff here.
// 0.9.0  6/13/2022 First code.
//
// ***********************************
//  ***** for STL output *****
//
// Tube(OD=PML54Body_OD, ID=PML54Body_ID, Len=300, myfn=$preview? 36:360);
// CenteringRing(OD=PML98Body_ID, ID=PML54Body_OD, Thickness=5, nHoles=0);
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
PML98Coupler_ID=3.78*25.4;
/*
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

PML54Body_OD=(2.152+0.062*2)*25.4;
PML54Body_ID=2.152*25.4;
PML54Coupler_OD=(2.02+0.062*2)*25.4;
PML54Coupler_ID=2.02*25.4;

//echo(PML54Body_OD=PML54Body_OD);

// Blue Tube 2.0
BT54Mtr_OD=57.20;
BT54Mtr_ID=54.40;
BT54Body_OD=57.20;
BT54Body_ID=54.2;
BT54Coupler_OD=53.60;
BT54Coupler_ID=50.70;

PML38Body_OD=(1.525+0.062*2)*25.4;
PML38Body_ID=1.525*25.4;
PML38Coupler_OD=(1.40+0.062*2)*25.4;
PML38Coupler_ID=1.40*25.4;

module CenteringRing(OD=PML98Body_ID, ID=PML54Body_OD, Thickness=5, nHoles=0){
	difference(){
		cylinder(d=OD, h=Thickness);
		
		translate([0,0,-Overlap]) cylinder(d=ID, h=Thickness+Overlap*2);
		if (nHoles>0) for (j=[0:nHoles-1]) rotate([0,0,360/nHoles*j])
			translate([ID/2+(OD/2-ID/2)/2,0,-Overlap]) cylinder(d=(OD/2-ID/2)/2, h=Thickness+Overlap*2);
	} // difference
} // CenteringRing

//CenteringRing(OD=PML98Body_ID, ID=PML54Body_OD, Thickness=5);

module Tube(OD=PML54Body_OD, ID=PML54Body_ID, Len=300, myfn=$preview? 36:360){
	difference(){
		cylinder(d=OD, h=Len, $fn=myfn);
		translate([0,0,-Overlap]) cylinder(d=ID, h=Len+Overlap*2, $fn=myfn);
	} // difference
} // Tube

//Tube(OD=PML54Body_OD, ID=PML54Body_ID, Len=300, myfn=$preview? 36:360);

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










