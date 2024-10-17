function [v1,v2,v3]=wake( v,d1,dmax, lmax )
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

% top section of the wake domain
    d= d0;
    v1= zeros( 2,n,m );
    v1(:,1,:)= v(:,1,:);
    for i=2:n
      v1(1,i,:)= v1(1,i-1,:)+d;
      v1(2,i,:)= v1(2,i-1,:);
      d= d*d1;
      d= min(d,dmax);
    end
    
% bottom section of the wake domain
    d= d0;
    v2= zeros( 2,n,m );
    v2(:,1,:)= v(:,size(v,2),:);
    for i=2:n
      v2(1,i,:)= v2(1,i-1,:)+d;
      v2(2,i,:)= v2(2,i-1,:);
      d= d*d1;
      d= min(d,dmax);
    end 
    
    
% spoiler section
    d= d0;
    f= v(2,size(v,2),1)-v(2,1,1);
    g= v(2,size(v,2),1)-v(2,size(v,2),2);

    m= round(abs(f)/abs(g));
    v3= zeros( 2,n,m );
    for i=1:m
      w=i-1;
      w=w/(m-1);
      v3(:,1,i)= w*v(:,size(v,2),1)+ (1-w)*v(:,1,1);
    end
    for i=2:n
      v3(1,i,:)= v3(1,i-1,:)+d;
      v3(2,i,:)= v3(2,i-1,:);
      d= d*d1;
      d= min(d,dmax);
    end
    
% f= fopen( "v1.dat","w" );
% m= size(v1,2);
% n= size(v1,3);
% for j=1:m
%     fprintf( f,"\n" );
%     for i=1:n
%       fprintf( f,"%12.5e %12.5e\n", v1(1,j,i),v1(2,j,i) );
%    end
% end
% for i=1:n
%     fprintf( f,"\n" );
%     for j=1:m
%       fprintf( f,"%12.5e %12.5e\n", v1(1,j,i),v1(2,j,i) );
%    end
% end
% fclose( f );
% f= fopen( "v2.dat","w" );
% m= size(v2,2);
% n= size(v2,3);
% for j=1:m
%     fprintf( f,"\n" );
%     for i=1:n
%       fprintf( f,"%12.5e %12.5e\n", v2(1,j,i),v2(2,j,i) );
%    end
% end
% for i=1:n
%     fprintf( f,"\n" );
%     for j=1:m
%       fprintf( f,"%12.5e %12.5e\n", v2(1,j,i),v2(2,j,i) );
%    end
% end
% fclose( f );
% f= fopen( "v3.dat","w" );
% m= size(v3,2);
% n= size(v3,3);
% for j=1:m
%     fprintf( f,"\n" );
%     for i=1:n
%       fprintf( f,"%12.5e %12.5e\n", v3(1,j,i),v3(2,j,i) );
%    end
% end
% for i=1:n
%     fprintf( f,"\n" );
%     for j=1:m
%       fprintf( f,"%12.5e %12.5e\n", v3(1,j,i),v3(2,j,i) );
%    end
% end
% fclose( f );
    
end
