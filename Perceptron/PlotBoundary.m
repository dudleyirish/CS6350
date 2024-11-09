%% usage: PlotBoundary (w, x1, x2)
%%
%%
function PlotBoundary (w)
  if w(1) != 0 && w(2) != 0
    xmin = xlim()(1);
    xmax = xlim()(2);
    ymin = ylim()(1);
    ymax = ylim()(2);
    x1 = xmin;
    x2 = xmax;
    y1 = Y_Intercept(w, x1);
    y2 = Y_Intercept(w, x2);
    if y1 > ymax
      if y2 > ymax
	return;
      end
      y1 = ymax;
      x1 = X_Intercept(w, y1);
    end
    if y1 < ymin
      if y2 < ymin
	return;
      end
      y1 = ymin;
      x1 = X_Intercept(w, y1);
    end
    if y2 > ymax
      if y1 > ymax
	return;
      end
      y2 = ymax;
      x2 = X_Intercept(w, y2);
    end
    if y2 < ymin
      if y1 < ymin
	return;
      end
      y2 = ymin;
      x2 = X_Intercept(w, y2);
    end
    plot([x1,x2], [y1, y2]);
  end
end
