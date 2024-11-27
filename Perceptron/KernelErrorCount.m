%% usage: e = KernalErrorCount(Xin, Yin, A, b, gamma)
%%
%%
function e = KernelErrorCount (X, Y, A, b, gamma)
  e = 0;
  for i=1:rows(Y)
    a = sum(A .* exp(abs(X - X(i,:)).^2/gamma)) + b;
    a
    printf("Activation = %f\n", a);
    printf("Y(%d) = \n", i);
    printf("%d\n", Y(i));
  end
endfunction
