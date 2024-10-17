function []=gnuplot( s,v )
% print gnuplot output to the file s for the grid v
  m=size(v,2);
  n=size(v,3);
% test output
  f= fopen( s,"w" );
  for j=1:m
      fprintf( f,"\n" );
      for i=1:n
        fprintf( f,"%12.5e %12.5e\n", v(1,j,i),v(2,j,i) );
     end
  end
  for i=1:n
      fprintf( f,"\n" );
      for j=1:m
        fprintf( f,"%12.5e %12.5e\n", v(1,j,i),v(2,j,i) );
     end
  end
  fclose( f );
end
