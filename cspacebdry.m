function [cpivot, cbdry] = cspacebdry(objbdry, indx)
% This function performs C boundary generation according to
% a given base boundary and a reference index
%
% [cpivot, cbdry] = cspaceboundary(objbdry, indx)
% objbdry : input boundary clouds, column main Nx2
% indx : the reference index
% cpivot : output c space boundary reference point
% cbdry : output boundary clouds
%
% Author: Weiwei Wan, The University of Tokyo
% 2011-03-07

  cpivot = objbdry(indx, :);
  [row, col] = size(objbdry);
  pivots = repmat(cpivot.*2, row, 1);
  cbdry = pivots - objbdry;
