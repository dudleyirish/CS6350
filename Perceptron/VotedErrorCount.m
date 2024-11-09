%% usage: e = VotedErrorCount (w, X, Y)
%%
%% The version that has been commented out is the one using a for loop.
%% The matrix version is over 40 times faster.
function e = VotedErrorCount (W, C, X, Y)
  e = 0;
  ## sum1 = 0;
  ## sum2 = 0;
  for i=1:rows(Y)
    ## tic();
    ## p1 = 0;
    ## for j=1:columns(W)
    ##   p1 = p1 + C(j) * sign(W(:,j)'*X(:,i));
    ##   ## printf("C(%d) = %f, W(:,j)'*X(:,i) = %f, p = %f\n", ...
    ##   ##  	     j, C(j), W(:,j)'*X(:,i), p);
    ## end
    ## t1 = toc();
    ## tic();
    p2 = sum(C.*sign(W'*X(:,i)));
    ## t2 = toc();
    ## sum1 = sum1 + t1;
    ## sum2 = sum2 + t2;
    ## printf("t1=%f: p1 = %f, t2=%f: p2 = %f\n", t1, p1, t2, p2);
    if sign(p2) != Y(i)
      e = e + 1;
    end
  end
  ## printf("sum1 = %f, sum2 = %f\n", sum1, sum2);
end
