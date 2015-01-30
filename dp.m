function [p,q,D] = dp(data)

[M,N] = size(data);

% costs
D = zeros(M+1, N+1);
D(1,:) = NaN;
D(:,1) = NaN;
D(1,1) = 0;
D(2:(M+1), 2:(N+1)) = data;

% traceback
traceback = zeros(M,N);

for i = 1:M; 
  for j = 1:N;
    [dmax, tb] = min([D(i, j), D(i, j+1), D(i+1, j)]);
    D(i+1,j+1) = D(i+1,j+1)+dmax;
    traceback(i,j) = tb;
  end
end

% Traceback from top left
i = M; 
j = N;
p = i;
q = j;
while i > 1 & j > 1
  tb = traceback(i,j);
  if (tb == 1)
    i = i-1;
    j = j-1;
  elseif (tb == 2)
    i = i-1;
  elseif (tb == 3)
    j = j-1;
  else    
    error;
  end
  p = [i,p];
  q = [j,q];
end

% Strip off the edges of the D matrix before returning
D = D(2:(M+1),2:(N+1));