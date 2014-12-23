% WEAKCLASSIFIER Rectangle filter based classification of an image patch.
%   C = WEAKCLASSIFIER( FX, P, THETA ) converts a set of filter responses
%   FX to an array of binary decisions ({0,1}) using parity P and threshold
%   THETA.
%
% See also INTEGRALIMAGE, FILTERRESPONSE, ADABOOST.
%

function c = WEAKCLASSIFIER( fx, p, theta )

%FINISH CODE
c = zeros(size(fx));
c(fx*p<p*theta) = 1; %when label is 1 or 0
% c(fx*p >= p*theta) = -1 %uncomment this statement when label is 1 or -1
end
    

