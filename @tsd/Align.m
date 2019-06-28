function [R, il] = Align(tsa, varargin)
% R = Restrict(tsa, varargin) restricts tsd to a new timestamp
%  an array
% of timestamps is specified, and the tsd made out of the points in tsa that
% approximated those timestamps is returned
% for these usage call like this
% R = Restrict(tsa, k, 'OptionName', 'OptionValue'), where k may be a
% numerical array, or a ts, tsd object
% The option 'align' specifies the type of approximation to
% produce. possible values are
% 'prev': returns the points that immediately preceded each of the
% timestamps
% 'next': returns the points that immediately followed each of the
% timestamps
% 'closest': returns the points that best approximated the timestamps
% 'equal': returns the points that had the same time as the
% timestamps. If perfect alignment cannot be achieved for all the points,
% it returns an error.

% the current version is an evolution of A. David Redish's code
% copyright (c) 2004, 2019 Francesco P. Battaglia
% This software is released under the GNU GPL
% www.gnu.org/copyleft/gpl.html
% released under the GPL





align_type = 'closest';

while ~isempty(varargin)
    v = varargin{1};
    varargin = varargin(2:end);
    
    if isa(v, 'numeric') || isa(v, 'tsd')
        st = v;
        time_type = 0;
        
        
        
    elseif isa(v, 'char') % read in option
        if ~isempty(varargin)
            ov = varargin{1};
            varargin = varargin(2:end);
        else
            error('must specify value for option');
        end
        
        time_type = 0;
        
        switch(v)
            case 'align'
                if ~isa(ov, 'char')
                    error('value for option align must be string')
                end
                switch(ov)
                    case {'prev', 'next', 'closest', 'equal'} % option will be ignored for int
                        align_type = ov;
                    otherwise
                        error('Unrecognized option value');
                end
            case 'time'
                switch(ov)
                    case 'original'
                        time_type = 0;
                    case 'align'
                        time_type = 1;
                end
                % put more options here
            otherwise
                error('Unrecognized option');
        end
    end
end




if isa(st, 'tsd')
    st = Range(st);
end

if (~isempty(st)) && ~isempty(tsa)
    ix = Restrict_idx_align(Range(tsa), st, align_type);
else
    ix = zeros(0,1);
end


tt = tsa.t(ix);
if time_type == 1
    tt = st;
end


if isa(tsa, 'ts')
    R = ts(tt);
else
    R = tsd(tt, SelectAlongFirstDimension(tsa.data, ix));
end

if nargout == 2
    il = ix;
end
