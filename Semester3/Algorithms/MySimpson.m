function [ S ] = MySimpson( f,a,b,n )
% MySimpson calculation of the Simpsons rule for 
%   f: function to be integrated; 
%      f is not assumed vectorized and is called in each x-value seperately
%   a: lower integration boundary
%   b: upper integration boundary
%   n: the EVEN integer number of intervals

if (mod(n,2)~=0 || n<2)
    display('Simpsons method requires an even number of intervals n');
    S=NaN;
    return;
end
x=linspace(a,b,n+1);
w=2*ones(n+1,1);
w(1,1)=1;
w(n+1,1)=1;
w(2:2:n,1)=4;
S=f(x(1));
for i=2:n
    S=S+f(x(i))*w(i,1);
end
S=S+f(x(n+1));
S=S*(b-a)/n/3;
end

