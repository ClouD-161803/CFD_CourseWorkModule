function [v1,v2]=wake( v,d1,dmax, lmax )
% Wake grid from C-grid
% v            c-grid
% d0           streamwise lenth of first cell downstream of trailing edge
% d1           growth ratio
% dmax         maximum streamwise grid spacing
% lmax         streamwise extent of the wake region

% first axial spacing matches c-grid

    m= size(v,3);
    d0= abs(v(1,2,m)-v(1,1,m));
    
% compute grid size
    d= d0;
    w= 0;
    n= 1;
    while 1
       w= w+d;
       d= d*d1;
       d= min(d,dmax);
       if( w > lmax )
         break;
       end
       n= n+1;
    end

    d= d0;
    v1= zeros( 2,n,m );
    v1(:,1,:)= v(:,1,:);
    for i=2:n
      v1(1,i,:)= v1(1,i-1,:)+d;
      v1(2,i,:)= v1(2,i-1,:);
      d= d*d1;
      d= min(d,dmax);
    end
    
    d= d0;
    v2= zeros( 2,n,m );
    v2(:,1,:)= v(:,size(v,2),:);
    for i=2:n
      v2(1,i,:)= v2(1,i-1,:)+d;
      v2(2,i,:)= v2(2,i-1,:);
      d= d*d1;
      d= min(d,dmax);
    end 
     
end
