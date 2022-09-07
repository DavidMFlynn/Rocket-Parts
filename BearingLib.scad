// ************************************************
// Bearing Library
// by David M. Flynn
// Filename: BearingLib.scad
// Created: 2/2/2018
// Revision: 1.2.6 1/10/2019
// **********************************************
// History
 echo("BearingLib 1.2.6");
// 1.2.6 1/10/2019 Fixed BI (ball insertion groove) depth.
// 1.2.5 1/1/2019 Added BI=false to one piece races
// 1.2.4 9/25/2018 Fixed ball elongation math.
// 1.2.3 8/7/2018 Smoother outer race.
// 1.2.2 8/3/2018 Added VOffset.
// 1.2.1 4/22/2018 Added PreLoadAdj to OutsideRace
// 1.2.0 4/7/2018 Added BallSpacer(BallCircle_d=60,Ball_d=9.525,nBalls=12);
// 1.1.0 3/21/2018 Added InsideRaceBoltPattern,OutideRaceBoltPattern
// 1.0.0 2/2/2018 First code.
// **********************************************
// for STL output (examples)
//
// InsideRace(BallCircle_d=60, Race_ID=34, Ball_d=9.525, Race_w=5, nBolts=8, RaceBoltInset=BL_RaceBoltInset, PreLoadAdj=0.00, myFn=360) Bolt4ClearHole();
// InsideRace(BallCircle_d=60, Race_ID=34, Ball_d=9.525, Race_w=5, nBolts=8, RaceBoltInset=BL_RaceBoltInset, PreLoadAdj=0.00, myFn=360) Bolt4HeadHole();
// OutsideRace(BallCircle_d=60, Race_OD=86, Ball_d=9.525, Race_w=7, nBolts=8, RaceBoltInset=BL_RaceBoltInset, PreLoadAdj=0.00, myFn=360) Bolt4ClearHole();
// OutsideRace(BallCircle_d=60, Race_OD=86, Ball_d=9.525, Race_w=5, nBolts=8, RaceBoltInset=BL_RaceBoltInset, PreLoadAdj=0.00, myFn=360) Bolt4Hole();
// OnePieceInnerRace(BallCircle_d=100,	Race_ID=50,	Ball_d=9.525, Race_w=10, PreLoadAdj=0.00, VOffset=0.00, BI=false, myFn=360);
// OnePieceOuterRace(BallCircle_d=60, Race_OD=75, Ball_d=9.525, Race_w=10, PreLoadAdj=0.00, VOffset=0.00, BI=false, myFn=360);
// InsideRaceBoltPattern(Race_ID=50, nBolts=8, RaceBoltInset=BL_RaceBoltInset) Bolt4HeadHole();
// OutideRaceBoltPattern(Race_OD=150, nBolts=8, RaceBoltInset=BL_RaceBoltInset) Bolt4HeadHole();
// BallSpacer(BallCircle_d=60,Ball_d=9.525,nBalls=12);
// TwoPartBallSpacer(BallCircle_d=60,Ball_d=9.525,nBalls=10);
// **********************************************
// Routines
// InsideRaceBoltPattern(Race_ID=50,nBolts=8,RaceBoltInset=BL_RaceBoltInset) children();
// OutideRaceBoltPattern(Race_OD=150,nBolts=8,RaceBoltInset=BL_RaceBoltInset) children();
// BallTrack(BallCircle_d=100, Ball_d=9.525, myFn=360);
// **********************************************

include<CommonStuffSAEmm.scad>

$fn=90;
IDXtra=0.2;
Overlap=0.05;

kEL=1.04; // 4% ball elongation to prevent center of ball contacting race
BL_RaceBoltInset=3.5;

module TwoPartBallSpacer(BallCircle_d=72,Ball_d=7.9375,nBalls=15){ // 9.525
	// nBalls must be even
	Race_w=Ball_d+3.5;
	
	difference(){
		translate([0,0,-Race_w/2])cylinder(d=BallCircle_d+Ball_d*0.4,h=Race_w/2);
		
		cylinder(d=BallCircle_d-Ball_d*0.4,h=Race_w+Overlap*2,center=true);
		for (j=[0:nBalls-1]) rotate([0,0,360/nBalls*j]) translate([BallCircle_d/2,0,0]) sphere(d=Ball_d+IDXtra*2);
			
		for (j=[0:2:nBalls-1]) rotate([0,0,360/nBalls*j+180/nBalls]) translate([BallCircle_d/2+Ball_d*0.2,0,-1.2]) cylinder(d=3+IDXtra*2,h=2);
	} // diff
	
	difference(){
		for (j=[0:2:nBalls-1]) rotate([0,0,360/nBalls*j-180/nBalls]) translate([BallCircle_d/2+Ball_d*0.2,0,-Overlap]) cylinder(d=3,h=1);
			
		difference(){
			cylinder(d=BallCircle_d+Ball_d*0.4+4,h=Race_w, center=true);
			
			cylinder(d=BallCircle_d+Ball_d*0.4,h=Race_w, center=true);
		} // diff
	} // diff
} // TwoPartBallSpacer

//TwoPartBallSpacer();

module TwoPartBoltedBallSpacer(BallCircle_d=72,Ball_d=7.9375,nBalls=15){ // 9.525
	// nBalls must be even
	Race_w=Ball_d+3.5;
	Race_depth=Ball_d*0.6;
	
	difference(){
		translate([0,0,-Race_w/2])cylinder(d=BallCircle_d+Race_depth,h=Race_w/2);
		
		cylinder(d=BallCircle_d-Race_depth,h=Race_w+Overlap*2,center=true);
		for (j=[0:nBalls-1]) rotate([0,0,360/nBalls*j]) translate([BallCircle_d/2,0,0]) sphere(d=Ball_d+IDXtra*2);
			
		// Bolt holes
		for (j=[0:nBalls-1]) rotate([0,0,360/nBalls*j+180/nBalls]) translate([BallCircle_d/2,0,-Race_w/2]) rotate([180,0,0]) children();
	} // diff
	
	
} // TwoPartBoltedBallSpacer

//TwoPartBoltedBallSpacer() translate([0,0,-10])cylinder(d=2.5,h=10+Overlap);

module BallSpacer(BallCircle_d=60,Ball_d=9.525,nBalls=12){
	Race_w=Ball_d+3.5;
	
	difference(){
		cylinder(d=BallCircle_d+Ball_d*0.4,h=Race_w,center=true);
		
		cylinder(d=BallCircle_d-Ball_d*0.4,h=Race_w+Overlap*2,center=true);
		for (j=[0:nBalls-1]) rotate([0,0,360/nBalls*j]) translate([BallCircle_d/2,0,0]) sphere(d=Ball_d+IDXtra*2);
			
	} // diff
} // BallSpacer

//BallSpacer(BallCircle_d=60,Ball_d=9.525,nBalls=12);

module InsideRaceBoltPattern(Race_ID=50,
	nBolts=8,
	RaceBoltInset=BL_RaceBoltInset){
	
	for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) translate([Race_ID/2+RaceBoltInset,0,0]) children();
			
} // InsideRaceBoltPattern

module BallTrack(BallCircle_d=100, Ball_d=9.525, myFn=360){
	
	
	rotate_extrude(convexity = 10,$fn=myFn)
			translate([BallCircle_d/2, 0, 0]) scale([kEL,1.00]) circle(d = Ball_d);
} // BallTrack

//BallTrack();

module OnePieceInnerRace(BallCircle_d=100,
	Race_ID=50,
	Ball_d=9.525,
	Race_w=10,
	PreLoadAdj=0.00, // positive increases pre-load
	VOffset=0.00,
	BI=false,
	myFn=360){
		
	difference(){
		cylinder(d=BallCircle_d-Ball_d*0.7,h=Race_w,$fn=myFn);
		
		// center hole
		translate([0,0,-Overlap]) cylinder(d=Race_ID,h=Race_w+Overlap*2);
		
		// ball track, add the 4% elongation to the ball circle
		translate([0,0,Race_w/2+VOffset]) BallTrack(BallCircle_d=BallCircle_d+(kEL-1)*Ball_d+PreLoadAdj, Ball_d=Ball_d, myFn=myFn);
			
		// ball insersion groove
		if (BI==true)
			hull(){
				translate([0,BallCircle_d/2+PreLoadAdj+(kEL-1)*Ball_d/2,Race_w/2+VOffset]) sphere(d=Ball_d);
				translate([0,BallCircle_d/2+PreLoadAdj+(kEL-1)*Ball_d/2,Race_w+1]) sphere(d=Ball_d);
			} // hull
	
	} // diff
} // OnePieceInnerRace
	
//OnePieceInnerRace(BallCircle_d=60,Race_ID=44,Ball_d=9.525,Race_w=10,BI=true,myFn=90);
//OnePieceInnerRace(BallCircle_d=60,Race_ID=44,Ball_d=9.525,Race_w=10,myFn=360);

module OnePieceOuterRace(BallCircle_d=60,
	Race_OD=75,
	Ball_d=9.525,
	Race_w=10,
	PreLoadAdj=0.00, // positive increases pre-load
	VOffset=0.00,
	BI=false,
	myFn=360){
	
	difference(){
		cylinder(d=Race_OD,h=Race_w,$fn=myFn);
		
		// center hole
		translate([0,0,-Overlap]) cylinder(d=BallCircle_d+Ball_d*0.7,h=Race_w+Overlap*2,$fn=myFn);
		
		// ball track, subtract the 4% elongation from the ball circle
		translate([0,0,Race_w/2+VOffset]) BallTrack(BallCircle_d=BallCircle_d-(kEL-1)*Ball_d-PreLoadAdj, Ball_d=Ball_d, myFn=myFn);
		
		// ball insersion groove
		if (BI==true)
			hull(){
				translate([0,BallCircle_d/2-PreLoadAdj-(kEL-1)*Ball_d/2,Race_w/2+VOffset]) sphere(d=Ball_d);
				translate([0,BallCircle_d/2-PreLoadAdj-(kEL-1)*Ball_d/2,Race_w+1]) sphere(d=Ball_d);
			} // hull
	} // diff
} // OnePieceOuterRace

//OnePieceOuterRace(BallCircle_d=60,Race_OD=78,BI=true,myFn=90);
//OnePieceOuterRace(BallCircle_d=60,Race_OD=78,myFn=360);

module InsideRace(BallCircle_d=100,
	Race_ID=50,
	Ball_d=9.525,
	Race_w=5,
	nBolts=8,
	RaceBoltInset=BL_RaceBoltInset,
	PreLoadAdj=0.00, // positive increases pre-load
	myFn=360){
	
	difference(){
		cylinder(d=BallCircle_d-Ball_d*0.7,h=Race_w,$fn=myFn);
		
		// center hole
		translate([0,0,-Overlap]) cylinder(d=Race_ID,h=Race_w+Overlap*2);
		
		// ball track, add the 4% elongation to the ball circle
		translate([0,0,Race_w]) BallTrack(BallCircle_d=BallCircle_d+(kEL-1)*Ball_d+PreLoadAdj, Ball_d=Ball_d, myFn=myFn);
		
		// Bolts
		if (nBolts!=0)
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) translate([Race_ID/2+RaceBoltInset,0,0])
			rotate([180,0,0]) children();
			
	} // diff
} // InsideRace

//InsideRace(BallCircle_d=60, Race_ID=34, Ball_d=9.525, Race_w=5, nBolts=8, PreLoadAdj=0.00, myFn=90) Bolt4ClearHole();

module OutideRaceBoltPattern(Race_OD=150,
	nBolts=8,
	RaceBoltInset=BL_RaceBoltInset){
	
	// Bolts
	for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) translate([Race_OD/2-RaceBoltInset,0,0]) children();
		
} // OutsideRace

module OutsideRace(BallCircle_d=60,
	Race_OD=150,
	Ball_d=9.525,
	Race_w=5,
	nBolts=8,
	RaceBoltInset=BL_RaceBoltInset,
	PreLoadAdj=0.00, // positive increases pre-load
	myFn=360){
	
	difference(){
		cylinder(d=Race_OD,h=Race_w);
		
		// center hole
		translate([0,0,-Overlap]) cylinder(d=BallCircle_d+Ball_d*0.7,h=Race_w+Overlap*2,$fn=myFn);
		
		// Bolts
		for (j=[0:nBolts-1]) rotate([0,0,360/nBolts*j]) translate([Race_OD/2-RaceBoltInset,0,0]) 
			 rotate([180,0,0]) children();
		
		// ball track, subtract the 4% elongation from the ball circle
		translate([0,0,Race_w]) BallTrack(BallCircle_d=BallCircle_d-(kEL-1)*Ball_d-PreLoadAdj, Ball_d=Ball_d, myFn=myFn);
		
	} // diff
} // OutsideRace

//OutsideRace(BallCircle_d=60, Race_OD=86, Ball_d=9.525, Race_w=5, nBolts=8, RaceBoltInset=BL_RaceBoltInset, PreLoadAdj=0.00, myFn=90) Bolt4ClearHole();
//translate([0,0,10+Overlap])rotate([180,0,0])OutsideRace(BallCircle_d=60, Race_OD=86, Ball_d=9.525, Race_w=5, nBolts=8, myFn=90) Bolt4ButtonHeadHole();



