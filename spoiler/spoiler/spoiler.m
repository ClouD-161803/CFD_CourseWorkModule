function [ w ] = spoiler( v, l,h )
% Introduce a spoiler of chord l and height h
% v           initial c-grid
% l           spoiler chord
% h           spoiler height

% initialize
   w= v;
     
% Start from the trailing edge and shift the grid along the y axis just
% enough to draw the spoiler
   m= size(w,3);
   i=0;
   while 1
      
      i= i+1;
      x= w(1,i,1);
      x= w(1,1,1)-x;
      
% position outisde spoiler - stop here
      if x > l
        break;
      end
      
      
% determine how much to shift the grid by
      x=x/l;
      x=1-x;
      
      x= x*h;
      
% shift the grid - free stream will be unchanged
      for j=1:m
         f= v(2,i,j)-v(2,i,m);
         f= f/( v(2,i,1)-v(2,i,m));
         w(2,i,j)= w(2,i,j)+ x*f;
      end
      
   end

   
% test output
%  m=size(w,2);
%  n=size(w,3);
%  f= fopen( "spoiler.dat","w" );
%  for j=1:m
%     fprintf( f,"\n" );
%     for i=1:n
%       fprintf( f,"%12.5e %12.5e\n", w(1,j,i),w(2,j,i) );
%     end
%  end
%  for i=1:n
%     fprintf( f,"\n" );
%     for j=1:m
%       fprintf( f,"%12.5e %12.5e\n", w(1,j,i),w(2,j,i) );
%     end
%  end
%  fclose( f );
   
end

