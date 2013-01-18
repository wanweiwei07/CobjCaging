function pointlist = DDA(x1,y1,x2,y2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function draws a DDA line and returns every points along the line.
%
% pointlist = DDA(x1, y1, x2, y2)
% INPUTS:
% x1, y1: the position of one end point
% x2, y2: the position of the other end point
% OUTPUTS:
% pointlist: a list of differentially digitalized points constituting a line segment
% NOTE: This is a traditional algorithm in Graphics
%
% Author: Weiwei Wan, The Unviersity of Tokyo
% Data: 04-11-2011 (last modified)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  length =abs(x2-x1);
  if abs(y2-y1)>length
    length=abs(y2-y1);
  end
  dx=(x2-x1)/length;
  dy=(y2-y1)/length;
  x=x1+0.5*sign(dx);
  y=y1+0.5*sign(dy);
  
  tmppointlist = repmat(0, 500, 2);
  lpointlist = 0;
  for i=1:length
    lpointlist = lpointlist + 1;
    tmppointlist(lpointlist,:) = [round(x), round(y)];
    x=x+dx;
    y=y+dy;
  end
  pointlist = tmppointlist(1:lpointlist, :);
