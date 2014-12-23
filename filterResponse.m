% FILTERRESPONSE Computes a rectangle filter response.
%   FX = FILTERRESPONSE( X, F ) applies the rectangle filter F on the
%   integral image X. The rectangle feature F is defined by a set of
%   negative and positive valued rectangles and has the following syntax:
%
%   F = [top_left top_right bottom_left bottom_right sign; ... ]'
%

function fx = FILTERRESPONSE( x, f )

idx  = f(:,1:4);
vals = x(idx(:));
vals = vals(1:4:end) - vals(2:4:end) - vals(3:4:end) + vals(4:4:end);
%vals = vals(1:2)+vals(end-1:end)-vals(3:4)-vals(5:6);
vals = vals .* f(:,5);
fx   = sum( vals );
