%% usage: node = ID3 (S, attr_names, label, value)
%%
%%
function node = ID3 (S, Dt, level, attr_names, attr_values, label, splitter)
  global NextNode Connectivity NodeName NodeValue NodeLabel outf;
  if ! is_function_handle(splitter)
    error("Parameter splitter must be a function handle");
  end

  NextNode = 1;
  Connectivity = [];
  NodeName = {};
  NodeValue = [];
  NodeLabel = [];
  node = ID3_r (S, Dt, level, attr_names, attr_values, label, 0, splitter);
end;

function node = ID3_r (S, Dt, level, attr_names, attr_values, label, value, splitter)
  global NextNode Connectivity NodeName NodeValue NodeLabel AttrValues outf
  %%
  if ! is_function_handle(splitter)
    error("Parameter splitter must be a function handle");
  end

  fprintf(outf, "Entering ID3: level = %d\n", level);

  %% Allocate a root/leaf node
  node = AllocNode();
  if level == 0
    fprintf(outf, "Level limit reached, return leaf node. %d\n", ...
	    mode(S(:,end)));
    NodeName{node} = 'leaf';
    %% label is most common value (mode).
    NodeLabel(node) = mode(S(:,end));
    NodeValue(node) = value;    
  %% If all examples have the same label
  elseif all(S(:, label) == S(1, label))
    %% return a leaf node
    fprintf(outf, "All labels the same, return leaf node.\n");
    NodeName{node} = 'leaf';
    %% If attributes is not empty
    if (columns(S) > 1)
      NodeLabel(node) = S(1, label);
    else %% attributes is empty, label is most common value (mode).
      NodeLabel(node) = mode(S(:,end));
    end 
    NodeValue(node) = value;
  elseif columns(S) == 1
    %% Out of columns, create a leaf node with most common value
    fprintf(outf, "Out of columns, return leaf node.\n");
    NodeName{node} = 'leaf';
    NodeLabel(node) = mode(S(:,end));
    NodeValue(node) = value;
  else
    %% Create root node,
    fprintf(outf, "Create a root node: %d\n", node);
    split_attr = splitter(S, Dt, attr_names, attr_values);
    fprintf(outf, "    split_attr = %d\n", split_attr);
    split_name = strtrim(attr_names{split_attr});
    NodeName{node} = split_name;
    NodeValue(node) = value;
    %%fprintf(outf, "Split attr is %s\n", split_name);
    values = attr_values{split_attr};
    if strcmp(values{1}, 'numeric')
      values = [-1, 1];
    elseif strcmp(values{1}, 'yes') %% yes/no
      values = [-1, 1];
    else
      values = 1:columns(values);
    end

    for idx = 1:columns(values)
      matches = find(S(:, split_attr) == values(idx));
      fprintf(outf, "Found %d matches for idx = %d\n", ...
	      rows(matches), idx);

      %% if Sv is empty
      if numel(matches) == 0
	fprintf(outf, "Sv is empty, return leafnode, v = %d\n", ...
	       mode(S(:,end)));
	leafnode = AllocNode('Leaf', mode(S(:,end)), values(idx));
	Connectivity(node, leafnode) = 1;
      else
	fprintf(outf, "Recur on Sv, attribute value = %s\n", values(idx));
	Sv = S(matches, [1:split_attr-1,split_attr+1:end]);
	%% N.B. the use of parens on the cell array attr_values, ain't matlab wonderful
	newnode = ID3_r(Sv, ...
			Dt, ...
			level - 1, ...
			attr_names([1:split_attr-1,split_attr+1:end],:), ...
			attr_values([1:split_attr-1,split_attr+1:end]), ...
			columns(Sv), ...
			values(idx), ...
			splitter);
	Connectivity(node, newnode) = 1;
      end
    end
  end
  fprintf(outf, "Leaving ID3\n");
end

function node = AllocNode(name = 'UNKNOWN', label = '_', value='_')
  global NextNode  Connectivity NodeName NodeValue NodeLabel AttrValues
  node = NextNode;
  NextNode = NextNode + 1;
  NodeName{node} = name;
  NodeLabel(node) = label;
  NodeValue(node) = value;
end
