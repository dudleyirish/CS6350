%% usage: latex2b (W, C)
%%
%%
function latex2b (W, C)
  [csrt, cidx] = sort(C, "descend");
  for i=1:rows(C)
    j = cidx(i);
    printf("%d & %.4f & %.4f & %.4f & %.4f & %.4f & %d \\\\\n", ...
	   j, W(1,j), W(2,j), W(3,j), W(4,j), W(5,j), C(j));
  end
end
