% INTEGRALIMAGE Computes an integral image.
%   IIM = INTEGRALIMAGE( IM ) computes an integral image IIM from input
%   grayscale image IM.
%

function iim = integralImage( im )

iim = cumsum( cumsum( im, 1 ), 2 );