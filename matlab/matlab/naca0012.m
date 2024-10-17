

function [s,x]= naca0012()
% Function to read coordinates of NACA 0012 aerofoil
% Read data file and prepares data in a form suitable for generating
% a C-grid
% s curvilinear coordinates
% x cartesian coordinates

% read raw data
     f= fopen( "NACA0012.txt","r" );
     n=fscanf( f,"%d" );
     x=fscanf( f,"%e" );
     x=reshape(x,3,400);
     fclose( f );
     
% flip first half of the array upside down
     j=200;
     for i=1:100
        z=x(:,i);
        x(:,i)= x(:,j);
        x(:,j)= z;
        j= j-1;
     end 
     
% shift entries 202 to 400 up by one place
     for i=202:400
        x(:,i-1)= x(:,i);
     end
     m=2*n(1)-1;

% adjust the coordinates of the first (and last point) to have a smooth
% surface near the trailing edge

     x0=x(1:2,2);
     x1=x(1:2,3);
     
     u= (x1(1)-x0(1))/(x1(2)-x0(2));
     u= x0(1) -x0(2)*u;

     x(1,1)= u;
     x(1,m)= u;
     x= x(:,1:m);
     
% compute curvilinear coordinates

     s= zeros(m,1);
     for i=2:m
        dx= x(1,i)- x(1,i-1);
        dy= x(2,i)- x(2,i-1);
        ds= dx*dx+ dy*dy;
        ds= sqrt(ds);
        s(i)= s(i-1)+ ds;
     end
     s= s/s(m);
     
% check output - for debug only
%      f= fopen( "as.read.txt","w" );
%      for i=1:m
%         fprintf( f,"%e %e\n", x(1,i),x(2,i) );
%      end
%      fclose( f );
% 
%      f= fopen( "interpolated.txt","w" );
%      for i=1:1024
%         u= i-1;
%         u=u/1023;
%         z= spline( s,x, u );
%         fprintf( f,"%e %e\n", z(1),z(2) );
%      end
%      fclose( f );

     
  end