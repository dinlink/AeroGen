function  vRes = DSS( x, xmin, xmax, Ds )
%Double Smooth Step 
% DSS(x) =              1                if              x < xmin - Ds
%          1 - f((x - (xmin - Ds) )/Ds)  if xmin - Ds <= x < xmin
%                       0                if    xmin   <= x < xmax
%               f((x - xmax )/Ds)        if    xmax   <= x < xmax + Ds
%                       1                if xmax + Ds <= x
%
%where f(x) is a smooth step function
%Ds is the delta of transition for the step

%  Smooth step between 0 and 1
f = @(t) 6 * t.^5 - 15 * t .^4 +10*t .^3;

%  region x < xmin - Ds
part1 = ones(1, length( x( x < (xmin - Ds) ) ));

%  region xmin - Ds <= x < xmin 
t = x( xmin - Ds <= x);
t = t( t < xmin);
part2 = 1 - f((t - (xmin - Ds) )/Ds);

%  region xmin   <= x < xmax
t = x( xmin <= x );
t = t(t < xmax);
part3 = zeros( 1, length(t));

% region xmax   <= x < xmax + Ds
t = x(xmax   <= x);
t = t(t < xmax + Ds);
part4 = f((t - xmax )/Ds) ;

% region xmax + Ds <= x
part5 = ones(1, length( x( (xmax + Ds) <= x) ) );

% Result
vRes = [part1 part2 part3 part4 part5];


end

