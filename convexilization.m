function [brenew, newboundary, newboundaryidx] = convexilization(boundary, step)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function is developed to convexilization boundary
% if boundary is concave and need to be convexilized
% this program return a new boundary with brenew = 1
% else brenew will be set to 0

% [brenew, newboundary] = convexilization(boundary, step)
% INPUTS:
% boundary: boundary clouds, each row of this matrix is a vertex with [x, y] coordinates
% step: this parameter controls the granularity of boundary cloud sampling
% OUTPUTS:
% brenew: whether convexilization is performed
% newboundary: if brenew == 1, newboundary would be non-zero. It is the sampled convex boundary clouds
% newboundaryidx: indices the newboundary clouds in original boundary clouds

% Author: Weiwei Wan, The University of Tokyo
% Data: 04-21-2011
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  lbdry = size(boundary, 1);
  %simplification
  % NOTE, there are many algorithm for simplification
  % The following one is from mathworks website
  % It is based on http://en.wikipedia.org/wiki/Ramer-Douglas-Peucker_algorithm
  [ps,ix] = dpsimplify(boundary, step);
  %decide whether convexilization is necessary
  lix = size(ix, 1);
  i = 2;
  brenew = 0;
  while i < lix
    iprevious = i-1;
    ipresent = i;
    inext = i+1;
    ptprevious = ps(iprevious, :);
    ptpresent = ps(ipresent, :);
    ptnext = ps(inext, :);
    v10 = [ptpresent-ptprevious, 0];
    v21 = [ptnext-ptpresent, 0];
    normx = cross(v10, v21);
    normx3 = normx(:, 3);
    if normx3 > 0
      brenew = 1;
      break;
    end
    i = i+1;
  end
  
  if brenew == 1
    % convexilization is necessary
    cvidxs = convhull(ps(:,1), ps(:,2));
    cvpt = ps(cvidxs, :);
    lcvpt = size(cvidxs, 1);
    tmpnewboundary = repmat(0, 1000, 2);
    tmpnewboundaryidx = repmat(0, 1000, 2);
    lboundary = 0;
    for i = 1:lcvpt-1
      if abs(cvidxs(i+1)-cvidxs(i))<lix-2 &&  abs(cvidxs(i+1)-cvidxs(i))>1
        idxstart = ix(cvidxs(i));
        idxend = ix(cvidxs(i+1));
        x0 = boundary(idxstart, 1);
        y0 = boundary(idxstart, 2);
        x1 = boundary(idxend, 1);
        y1 = boundary(idxend, 2);
        segpointlist = DDA(x0, y0, x1, y1);
        lsgplist = size(segpointlist, 1);
        tmpnewboundary(lboundary+1:lboundary+lsgplist, :) = segpointlist(1:lsgplist, :);
        tmpidx1 = repmat(idxend, lsgplist, 1);
        tmpnewboundaryidx(lboundary+1:lboundary+lsgplist, 1) = tmpidx1(1:lsgplist, :);
        tmpidx2 = repmat(idxstart, lsgplist, 1);
        tmpnewboundaryidx(lboundary+1:lboundary+lsgplist, 2) = tmpidx2(1:lsgplist, :);
        lboundary = lboundary + lsgplist
      else
        idxstart = ix(cvidxs(i));
        idxend = ix(cvidxs(i+1));
        j = idxstart;
        while 1
          lboundary = lboundary+1;
          tmpnewboundaryidx(lboundary, 1) = j;
          tmpnewboundary(lboundary, :) = boundary(j, :);
          if j == idxend
            break;
          end
          j = j-1;
          if j < 1
            j=lbdry;
          end
        end
      end
    end
    tmpnewbdry = tmpnewboundary(1:lboundary, :);
    newboundary = fliplr(tmpnewbdry')';
    tmpnewbdryidx = tmpnewboundaryidx(1:lboundary, :);
    newboundaryidx = fliplr(tmpnewbdryidx')';
    for i = 1:size(newboundary,1)
      plot(newboundary(i,2), newboundary(i,1), 'k', 'LineWidth', 2);
    end
  else
    newboundary = 0;
    newboundaryidx = 0;
  end
