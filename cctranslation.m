function ccfi = cctranslation(ccpivot, ccboundary, fi)

% This function translate the template ccboundary with ccpivot to
% a finger position denoted by fi
% ccfi is the result of of transformation
%
% ccfi = cctranslation(ccpivot, ccboundary, fi)
% ccfi : cc space object of finger i
% ccpivot : pivot of template cc space object
% ccboundary : boundary cloud of template cc space object
% fi : position of a certain finger
%

  [row, col] = size(ccboundary);
  diff = fi - ccpivot;
  ccfi = repmat(diff, row, 1) + ccboundary;
