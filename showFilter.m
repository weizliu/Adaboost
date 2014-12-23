% SHOWFILTER Displays a rectangular filter.
%   SHOWFILTER( S, F ) plots the rectangular filter F.
%

function SHOWFILTER( s, f )

for rect = 1:size(f,1)
    [y,x]   = ind2sub( s, f(rect,1:4) );
    x(1)    = x(1)+1; x(3)=x(3)+1;
    y(1)    = y(1)+1; y(2)=y(2)+1;
    h       = y(3)-y(1)+1;
    w       = x(2)-x(1)+1;
    if( f(rect,5) == 1 )
        rectangle('Position',[x(1) y(1) w h],'FaceColor',[1.0 1.0 1.0]);
    else
        rectangle('Position',[x(1) y(1) w h],'FaceColor',[0.5 0.5 0.5]);
    end
end
axis([1 s(2)+1 1 s(1)+1]);