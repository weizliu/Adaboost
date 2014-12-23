% SHOWFILTERS Displays a set of filters.
%   SHOWFILTERS( S, F ) displays the filters F on the patch S.
%

function SHOWFILTERS( s, f )

n   = ceil(sqrt(length(f)));
for idx = 1:length(f)
    subplot(n,n,idx);
    showFilter( s, f{idx} );
end