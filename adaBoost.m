% ADABOOST Performs adaboost to train an ensemble classifier.
%   H = ADABOOST( X, Y, F, T ) performs adaboost on the example
%   integral images X, having labels Y, with features F. The final
%   classifier H contains T weak classifiers each classifier specified by a
%   feature, parity, threshold and alpha value.
%
% See also WEAKCLASSIFIER, INTEGRALIMAGE.
%

function H = ADABOOST( x, y, f, T )

% construct output structure
f_t     = cell(1,T);
alpha   = zeros([1 T]);
p       = zeros([1 T]);
theta   = zeros([1 T]);

% initialze weights
% l = sum( y );
% m = length( y ) - l;
% w = y * 1/(2*l) + (~y) * 1/(2*m);

l = sum(abs(y));   %label is -1 or 1
w = abs(y)/l;

% precompute filter responses
fx      = zeros([length(f) length(y)]);
idxs    = zeros(size(fx));
for j = 1:length(f)
    for k = 1:length(y)
        fx(j,k) = filterResponse( x(:,:,k), f{j} );
    end
end
minfx = min(fx,[],2);
maxfx = max(fx,[],2);
delfx = (maxfx-minfx)/20;  % you can make this 20 larger to get a better threshold

% choose T weak classifiers
epsilon = zeros([1 length(f)]);
for t = 1:T
    t %just want to where the code is...
    % normalize weights
     w = w / sum(w);
     d = 1;   
    % compute error and select the weakclassifier with lowest error

    %FINISH CODE
    
    for p_i = -1 : 2 : 1
        for theta_i = min(minfx) : min(delfx) : max(maxfx)   %just for simplicity, but it will cost more memory and time.
            ht = ones(size(fx));
            ht = -ht;
            ht(find(p_i*fx < p_i*theta_i)) = 1;
            e_nowei = abs(ht - ones(length(f),1)*y')/2; %/2:error = 2 when y = 1 or -1
            e_wei = e_nowei*w;
            [e_wei_min index_filter] = min(e_wei);
            recorder(d,:) = [e_wei_min index_filter p_i theta_i]; %Given p and theta, recorde minimal weighted error and corresponding index of filter.
            d = d + 1;
        end
    end
    [e_min e_idx_min] = min(abs(recorder(:,1)));  %recorde the global minimal weighted error and corresponding index of filter 
    f_ = recorder(e_idx_min,2); % index of filter corresponding to the global minimal weighted error
    p_ = recorder(e_idx_min,3); % p corresponding to the global minimal weighted error
    th_ = recorder(e_idx_min,4); % theta corresponding to the global minimal weighted error
    e_ = recorder(e_idx_min,1); % minimal error
   
    
    beta_t      = e_ / (1 - e_);
    if (beta_t == 0) alpha_t = 1.0; else alpha_t = log (1/beta_t); end
    
    % record output
    f_t{t}      = f{f_};
    alpha(t)    = alpha_t;
    p(t)        = p_;
    theta(t)    = th_;
    e(t)        = e_;
    
    
    
    % update weights

    % FINISH CODE
    ht_c = ones(size(y));
    ht_c = -ht_c; 
    ht_c(find(p_*fx(f_,:) < p_*th_)) = 1; %ht_c is results when using the optimal parameters selected by above procedures
    zt = w(find((y - ht_c) == 0))'*ones(length(find((y-ht_c)==0)),1)*exp(-alpha_t) + w(find((y - ht_c) ~= 0))'*ones(length(find((y-ht_c)~=0)),1)*exp(alpha_t);
    fx_r = zeros(size(y));
    for i = 1 : length(y)
        if(y(i) ~= ht_c(i))
           w(i) = 1/zt*w(i)*exp(-alpha_t*y(i)*ht_c(i)); %if judgement is wrong, weights become bigger, if right, weight remain stable(I don't set it decreasing because
        end                                             %I found if applying exp(-alpha_t*y(i)*ht_c(i)) for right samples, the weights will decrease dramatically, which
                                                        %leads to that the final error converges too fast because the weighted error approaches to 0 since weights approaches 
                                                        %to 0, that will result last alpha very large and result only 7~8 classifier are trained even if T > 8)
                                                        %Besides, if the label is 0 or 1, when y(i)=1 and ht_c(i)=1, the weight will decrease, but when y(i)=0,ht_c(i)=0,
                                                        %the weight will remain stable, so I set label as 1 or -1 at the beginning.
    end
   
    
    % debug
    %[t e_]
    %[epsilon_y ;y';wold';w']
    
    % if we're perfect, stop
    if (e_ < 0.00001) break; end
    
%     % remove from feature set
%     if( f_ == 1 )
%         f   = f(2:end);
%         fx  = fx(2:end,:);
%     elseif( f_ == length(f) )
%         f   = f(1:length(f)-1);
%         fx  = fx(1:length(f)-1,:);
%     else
%         f   = [f(1:f_-1) f(f_+1:end)];
%         fx  = [fx(1:f_-1,:); fx(f_+1:end,:)];
%     end
    
    f(f_)=[];
    fx(f_,:)=[];
    minfx(f_)=[];
    maxfx(f_)=[];
    delfx(f_)=[];

    clear epsilon;
end

% compute adaboost threshold
threshold = 0.5 * sum(alpha);

% place into output structure
H.alpha = alpha(1:t);
H.f_t = f_t(1:t);
H.theta = theta(1:t);
H.p = p(1:t);
H.threshold = threshold;
