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
   ste= 0.01;
   dy= 0.001;
   eta= 1.2;
   % initial domain size (initial of 5)
   linf=2.5;
   % extended domain size (initial of 0.5 and 3)
   %linf=3;
   dinf=0.25;
   winf=1.5;

   [s,x]= naca0012();
   [v0]=cgrid( s,x, rf,smax,ste, dy,eta,dinf, linf );
   [v1,v2]=wake(v0,eta,dinf, winf);

% plot3D output
   f= fopen( "p3d.x","w" );
   fprintf( f,"%6d\n", 3 );
   fprintf( f,"%6d %6d %6d\n", size(v0,2),size(v0,3), 4 );
   fprintf( f,"%6d %6d %6d\n", size(v1,2),size(v1,3), 4 );
   fprintf( f,"%6d %6d %6d\n", size(v2,2),size(v2,3), 4 );
   plot3dout( f,v0,dinf,4 );
   plot3dout( f,v1,dinf,4 );
   plot3dout( f,v2,dinf,4 );
   fclose( f );
   
%gnuplot output
%    gnuplot( "LINF3/v0.dat",v0 );
%    gnuplot( "LINF3/v1.dat",v1 );
%    gnuplot( "LINF3/v2.dat",v2 );
end
