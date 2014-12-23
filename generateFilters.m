% GENERATEFILTERS Makes a set of rectangular filters.
%   F = GENERATEFILTERS( H, W, FRANGE ) defines a set of rectangular
%   filters located at all possible locations of an (H x W) image of sizes
%   within FRANGE. FRANGE is specified as [MIN_F_H MAX_F_H MIN_F_W
%   MAX_F_W].
%

function f = GENERATEFILTERS( h, w, frange )

% horizontal filters
%
% i.e.
%
%  1 1 1 1 1
%  1 1 1 1 1
%  0 0 0 0 0
%  0 0 0 0 0
%

f = {};
for fh = frange(1):frange(2)
    for fw = frange(3):frange(4)
        [x,y]   = meshgrid( 2:(w-fw+1), 2:(h-fh+1) );
        for dx = 1:(fh-1)
            for idx = 1:length(x(:))
                bx      = [x(idx)-1 x(idx)+fw-1 x(idx)-1 x(idx)+fw-1];
                by      = [y(idx)-1 y(idx)-1 y(idx)+dx-1 y(idx)+dx-1];
                top     = sub2ind([h w],by,bx);
                bot     = sub2ind([h w],[by(1:2)+dx by(3:4)+(fh-dx)],bx);
                f       = [f {[top -1; bot 1]} {[top 1; bot -1]}];
            end
        end
    end
end
                
% vertical filters
%
% i.e.
%
%  1 1 0 0
%  1 1 0 0
%  1 1 0 0
%  1 1 0 0
%
            
%FINISH_CODE
for fh = frange(1):frange(2)
    for fw = frange(3):frange(4)
        [x,y]   = meshgrid( 2:(w-fw+1), 2:(h-fh+1) );
        for dx = 1:(fh-1)
            for idx = 1:length(x(:))
                by      = [x(idx)-1 x(idx)-1 x(idx)+fw-1 x(idx)+fw-1];
                bx      = [y(idx)-1 y(idx)+dx-1 y(idx)-1 y(idx)+dx-1];
                left     = sub2ind([h w],by,bx);
                right     = sub2ind([h w],by,[bx(1)+dx bx(2)+(fh-dx) bx(3)+dx bx(4)+(fh-dx)]);
                f       = [f {[left -1;right 1]} {[left 1; right -1]}];
            end
        end
    end
end

% vertical stripe filter
%
% i.e.
%
% 0 0 1 1 0 0
% 0 0 1 1 0 0
% 0 0 1 1 0 0
% 0 0 1 1 0 0
%


for fh = frange(1):frange(2)
    for fw = frange(3):frange(4)
        [x,y]   = meshgrid( 2:(w-fw+1), 2:(h-fh+1) );
        for dx1 = 2:(ceil(fw/2))+1
            for dx2 = (ceil(fw/2)):(fw-1)
                if( dx2 < dx1 ) continue; end;
                for idx = 1:length(x(:))
                    % left
                    bxl     = [x(idx)-1 x(idx)+dx1-2 x(idx)-1 x(idx)+dx1-2];
                    byl     = [y(idx)-1 y(idx)-1 y(idx)+fh-1 y(idx)+fh-1];
                
                    % middle
                    bxm     = [x(idx)+dx1-2 x(idx)+dx2-1 x(idx)+dx1-2 x(idx)+dx2-1];
                    bym     = [y(idx)-1 y(idx)-1 y(idx)+fh-1 y(idx)+fh-1];
                
                    % right
                    bxr     = [x(idx)+dx2-1 x(idx)+fw-1 x(idx)+dx2-1 x(idx)+fw-1];
                    byr     = [y(idx)-1 y(idx)-1 y(idx)+fh-1 y(idx)+fh-1];
                
                    left    = sub2ind([h w],byl,bxl);
                    middle  = sub2ind([h w],bym,bxm);
                    right   = sub2ind([h w],byr,bxr);
                    
                    f       = [f {[left 1; middle -1; right 1]} {[left -1; middle 1; right -1]}];
                end
            end
        end
    end
end

% horizontal stripe filter
%
% i.e.
%
% 0 0 0 0 0 0
% 0 0 0 0 0 0
% 1 1 1 1 1 1
% 1 1 1 1 1 1
% 0 0 0 0 0 0
% 0 0 0 0 0 0
%

for fh = frange(1):frange(2)
    for fw = frange(3):frange(4)
        [x,y]   = meshgrid( 2:(w-fw+1), 2:(h-fh+1) );
        for dx1 = 2:(ceil(fh/2))+1
            for dx2 = (ceil(fh/2)):(fh-1)
                if( dx2 < dx1 ) continue; end;
                for idx = 1:length(x(:))
                    % top
                    bxt     = [x(idx)-1 x(idx)+fw-1 x(idx)-1 x(idx)+fw-1];
                    byt     = [y(idx)-1 y(idx)-1 y(idx)+dx1-2 y(idx)+dx1-2];
                
                    % middle
                    bxm     = [x(idx)-1 x(idx)+fw-1 x(idx)-1 x(idx)+fw-1];
                    bym     = [y(idx)+dx1-2 y(idx)+dx1-2 y(idx)+dx2-1 y(idx)+dx2-1];
                
                    % bottom
                    bxb     = [x(idx)-1 x(idx)+fw-1 x(idx)-1 x(idx)+fw-1];
                    byb     = [y(idx)+dx2-1 y(idx)+dx2-1 y(idx)+fh-1 y(idx)+fh-1];
                
                    top     = sub2ind([h w],byt,bxt);
                    middle  = sub2ind([h w],bym,bxm);
                    bot     = sub2ind([h w],byb,bxb);
                    
                    f       = [f {[top 1; middle -1; bot 1]} {[top -1; middle 1; bot -1]}];
                end
            end
        end
    end
end
