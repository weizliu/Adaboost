% EVALUATECLASSIFIER Evaluates an ensemble classifier.
%   Y = EVALUATECLASSIFIER( H, X ) evaluates the ensemble classifier H on
%   the images X and returns a binary classification vector Y, which has a
%   {0,1} entry for each image.
%

function y = evaluateClassifier( H, x)

% classify each image using weak classifiers
f_t     = H.f_t;
alpha   = H.alpha;
p       = H.p;
theta   = H.theta;
cx  = zeros([length(f_t) size(x,3)]);

for j = 1:length(f_t)
    for k = 1:size(x,3)
        %FINISH CODE
        fx(k) = filterResponse( x(:,:,k), f_t{j} );
        if(p(j)*fx(k)<p(j)*theta(j))
            cx(j,k) = alpha(j);
        else
            cx(j,k) = alpha(j)*(-1);   % label is 1 or -1
         end

    end
end

% compute label for each x
cx  = sum( cx, 1 );
%y   = (cx >= (0.5 * sum( alpha ))); %when label is 1 or 0, uncomment this statement and comment next statement
y = sign(cx); % label is 1 or -1
        
