%% usage: w = TrainSVMSGD (Xin, Yin, T, xi, C, N)
%%
%%
function w = TrainSVMSGD (Xin, Yin, T, xi, C)
  N = rows(Xin);
  w = zeros(1,columns(Xin));
  prev_w = w;
  updates = 0;
  prev_updates = N;
  error_count = N;
  prev_error_count = N;
  for t = 1:T
    V = randperm(size(Xin,1));
    X = Xin(V,:);
    Y = Yin(V,:);
    for i = 1:rows(X)
      if Y(i) * w * X(i,:)' <= 1
	nabla = [w(1:end-1),0] - C * N * Y(i) * X(i,:);
	w = w - xi(t) * [w(1:end-1),0] + xi(t) * C * N * Y(i) * X(i,:);
	## printf("    \\nabla_%d = [%f, %f, %f] \\\\\n", ...
	##        i, nabla(1), nabla(2), nabla(3));
	updates = updates + 1;
      else
	w(1:end-1) = (1 - xi(t))*w(1:end-1);
      end
    end
    error_count = ErrorCount(w, Xin, Yin);
    %%printf("%d updates, error count = %d\n", updates, error_count);
    if (updates > prev_updates) && (error_count > prev_error_count)
      w = prev_w;
      ## printf("Exiting with %d previous updates\n", prev_updates);
      ## printf("Exiting with %d updates\n", updates);
      ## printf("t = %d, error count = %d\n", t, ErrorCount(w, Xin, Yin));
      break;
    end;
    prev_updates = updates;
    prev_error_count = error_count;
    prev_w = w;
    updates = 0;
  end
end

