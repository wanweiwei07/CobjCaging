'''matlab

function [ccpivot, ccbdry] = ccspacebdry(objbdry, indx, targetDepthTagged)
% This function performs CC boundary generation according to
% a given base boundary and a reference index
%
% [ccpivot, ccbdry] = ccspaceboundary(objbdry, indx)
% INPUTS
% objbdry : boundary clouds, each row of this matrix indicate a vertex with [x, y] coordinate
% indx : the reference index to the pivot vertex
% targetDepthTagged: a depth mapt matrix which includes the objbdry
% OUTPUTS
% ccpivot : the cc space boundary pivot in [x, y] form
% ccbdry : the boundary clouds of CC boundary
%
% Author: Weiwei Wan, The University of Tokyo
% Data: 04-06-2012 (last modified)

  [numR, numC] = size(targetDepthTagged);
  tmpboundary = zeros(numR, numC);
  ccpivot = objbdry(indx, :);
  [row, col] = size(objbdry);
  for i = 1:row
    diff = ccpivot-objbdry(i, :);
    pivots = repmat(diff, row, 1);
    ccbdry = pivots + objbdry;
    tmpbdry = (ccbdry(:,2)-1)*numR+ccbdry(:,1);
    tmpboundary(tmpbdry) = 255;
  end
  [etRow, etCol] = find(tmpboundary, 1);
  ccbdry = bwtraceboundary(tmpboundary, [etRow, etCol], 'N', 4);
''''
