function [v]=cgrid( s,x, scal,smax,ste,dwall,eta,nmax, dinf )
% Make a C-grid around an aerofoil defined with m points with curvilinear
% coordinates s and cartesian coordinates x.
  

% compute curvature distribution
   nt= 128;
  [z,c,t]= tcurv( s,x, nt );
  

% generate tangential grid distribtion - spacing proportional to curvature
% radius

  w= 0.5;
  m=1;
  while 1 
     if( w < z(1) )
       q= c(1);
     else
       if( w > z(size(z,1)) )
         q= c(size(z,1));
       else
         q= spline( z,c, w );
       end
     end
     q= 1./q;                          
     q= scal*q;
     q= min( smax,q );
     l(m)=w;
     w= w+ q;
     if( w > 1. ) 
         break;
     end
     m= m+1;
  end 

% refine at the trailing edge

  if( ste < smax )
    
      
% generate local distribution at the trailing edge
    w= 1;
    o=1;
    q= ste;
    while 1 
       h(o)=w;
       w= w- q;
       q= q*eta;
       if( w < 0.5 || q > smax ) 
          break;
       end
       o= o+1;
    end 

% overlay the two distributions
    i=1;
    while l(i)<h(o)
      i=i+1;
    end
    m=i;
    for j=o:-1:1
      l(i)= h(j);
      i=i+1;
    end

% pretend the join smoothly
    l(m)=0.5*( l(m-1)+l(m+1) );
    m= i-1;
  else
      
% adjust to cover the whole lower side
    l= 0.5+ 0.5*(l-0.5)/(l(m)-0.5);  
  end
  

% replicate tangential grid distribution on the upper side
  l= [1-l(m:-1:2),l(1:m)];
  m= 2*m-1;
 
% generate wall normal grid distribution
  d= dwall;
  w=0;
  n=0;
  while w<dinf
      d= d*eta;
      d= min( d,nmax );
      n= n+1;
      r(n)= w;
      w= w+ d;
  end
  
  v= zeros(2,m,n);
 
% now generate coordinates for the C-grid
  y=  spline( s,x, 0 );
  g=  spline( z,t, max(l(2),z(1)) );
  for i=1:n
      v(1,1,i)= y(1)+g(1)*r(i);
      v(2,1,i)= y(2)+g(2)*r(i);
  end
  
  for j=2:m-1  
     y=  spline( s,x, l(j) );
     g=  spline( z,t, min(max(l(j),z(1)),z(nt)) );
     for i=1:n
        v(1,j,i)= y(1)+g(1)*r(i);
        v(2,j,i)= y(2)+g(2)*r(i);
     end
  end

  y=  spline( s,x, 1 );
  g=  spline( z,t, min(l(m-1),z(nt)) );
  for i=1:n
     v(1,m,i)= y(1)+g(1)*r(i);
     v(2,m,i)= y(2)+g(2)*r(i);
  end
  
end

