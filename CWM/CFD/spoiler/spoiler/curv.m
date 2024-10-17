function [z,c]=curv( s,x, n)
% Pre-compute the local curvature radius around the aerofoil
  
  c= zeros(n,1);
  z= zeros(n,1);

  ds= 1./n;
  ds= ds/2.;
  
  for i=1:n

     w= i-1;
     w= w+ 0.5;
     w= w/n;
     
     x0= spline( s,x, w-ds );
     x1= spline( s,x, w );
     x2= spline( s,x, w+ds );
     
     t0= x1-x0;
     t1= x2-x1;
     
     d= sqrt( t1(1)*t1(1)+ t1(2)*t1(2));
     t1= t1/d;
     
     d= sqrt( t0(1)*t0(1)+ t0(2)*t0(2));
     t0= t0/d;
     
     z(i)= w;
     c(i)=2*(t1(2)*t0(1)- t1(1)*t0(2))/ds;
  
  end

end

