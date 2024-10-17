function []=plot3dout( f,v,d,l )
% writes plot3D output the single block 2D grid contained in v
    m= size(v,2);
    n= size(v,3);
    for h=1:2
      for k=1:4
         for j=1:n
           for i=1:m
             fprintf( f,"%13.5e ",v(h,i,j) );
           end
           fprintf( f,"\n" );
         end
      end 
    end
    for k=1:l
      w=k-1;
      w=w/(l-1);
      w= w*d;
      for j=1:n
         for i=1:m
            fprintf( f,"%13.5e ",w );
         end
         fprintf( f,"\n" );
      end
    end  
end

   