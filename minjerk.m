function [T,P,Pd,Pdd] = minjerk(P1,P2,t,n)

% Given initial position P1=(x1,y1), final position P2=(x2,y2) and movement duration t,
% and the total number of desired sampled points n,
% Returns the path P over time T that satisfies minimum-jerk.
% Also returns derivatives Pd and Pdd. From the paper:
%   Flash T. & Hogan N. (1985) "The coordination of arm
%   movements: an experimentally confirmed mathematical model."
%   Journal of Neuroscience 5(7): 1688-1703.

T = linspace(0,t,n)';
P = zeros(n,2);
Pd = zeros(n,2);
Pdd = zeros(n,2);
P(:,1) = P1(1) + ((P1(1)-P2(1))*(15*((T/t).^4) - (6*(T/t).^5) - (10*(T/t).^3)));
P(:,2) = P1(2) + ((P1(2)-P2(2))*(15*((T/t).^4) - (6*(T/t).^5) - (10*(T/t).^3)));
Pd(:,1) = (P1(1) - P2(1))*(-30*(T.^4/t^5) + 60*(T.^3/t^4) - 30*(T.^2/t^3));
Pd(:,2) = (P1(2) - P2(2))*(-30*(T.^4/t^5) + 60*(T.^3/t^4) - 30*(T.^2/t^3));
Pdd(:,1) = (P1(1) - P2(1))*(-120*(T.^3/t^5) + 180*(T.^2/t^4) - 60*(T/t^3));
Pdd(:,2) = (P1(2) - P2(2))*(-120*(T.^3/t^5) + 180*(T.^2/t^4) - 60*(T/t^3));

end
