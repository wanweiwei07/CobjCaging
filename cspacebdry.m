function [cpivot, cbdry] = cspacebdry(objbdry, indx)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function performs C boundary generation according to
% a given base boundary and a reference index
%
% [cpivot, cbdry] = cspaceboundary(objbdry, indx)
% INPUTS
% objbdry : boundary clouds, each row of this matrix is a vertex with [x, y] coordinates
% indx : the reference index to a pivot vertex
% OUTPUTS
% cpivot : [x, y] coordinates of the pivot vertex
% cbdry : c space boundary of objbdry
%
% Author: Weiwei Wan, The University of Tokyo
% Data: 03-07-2011
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  cpivot = objbdry(indx, :);
  [row, col] = size(objbdry);
  pivots = repmat(cpivot.*2, row, 1);
  cbdry = pivots - objbdry;
