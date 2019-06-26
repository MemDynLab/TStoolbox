function [varargout] = subsref(A, S)

% overload of operator {} for element for reference. 
% if subscripts are numieric, the correspondign elements of the array are returned, if
% subscript is a string, all the tsd's are returned that contain that
% string in their name 
%   
% copyright (c) 2004 Francesco P. Battaglia
% This software is released under the GNU GPL
% www.gnu.org/copyleft/gpl.html


if length(S) > 1
    error('subsref defined only for one level of subscripting');
end
  
switch S(1).type
    case '{}'
        S(1).subs;
        varargout = {A.C{[S(1).subs{:}]} };
    case '()'
       error ('{} subscripting only')
    case '.'
         error ('{} subscripting only')
end