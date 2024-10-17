function driver()

% rf          spacing on the surface of the aerofoil in units of local
%             curvature radius
% smax        maxmum spacing along the aerofoil surface - normalised

%dy           initial spacing in the wall-normal direction
%eta          expansion ratio in the wall-normal direction
%dinf         max spacing away from the aerofoil

%linf         maximum distance from aerofoil surface
%winf         maximum length of wake section

   rf= 0.2;
   smax=0.02;
   ste= 0.0005;
   dy= 0.001;
   eta= 1.2;
   linf=1;
   dinf=0.1;
   winf=3;
   
% l            chord of the  Gurney flap
% h            height of the Gurney flap
   l= 0.0125;
   h= 0.05;

   [s,x]= naca0012();
   
   [w]=cgrid( s,x, rf,smax,ste, dy,eta,dinf, linf );
   [v0]=spoiler( w, l,h );
   [v1,v2,v3]=wake(v0,eta,dinf, winf);
% plot3D output
   f= fopen( "p3d.x","w" );
   fprintf( f,"%6d\n", 4 );
   fprintf( f,"%6d %6d %6d\n", size(v0,2),size(v0,3), 4 );
   fprintf( f,"%6d %6d %6d\n", size(v1,2),size(v1,3), 4 );
   fprintf( f,"%6d %6d %6d\n", size(v2,2),size(v2,3), 4 );
   fprintf( f,"%6d %6d %6d\n", size(v3,2),size(v3,3), 4 );
   plot3dout( f,v0,dinf,4 );
   plot3dout( f,v1,dinf,4 );
   plot3dout( f,v2,dinf,4 ); 
   plot3dout( f,v3,dinf,4 );
   fclose( f );

%gnuplot output
     gnuplot( "v0.dat",v0 );
     gnuplot( "v1.dat",v1 );
     gnuplot( "v2.dat",v2 );
     gnuplot( "v3.dat",v3 );

end
