%% usage: node = ID3 (S, attr_names, label, value)
%%
%%
function node = ID3 (S, F, level, attr_names, attr_values, label, splitter)
  global NextNode Connectivity NodeName NodeValue NodeLabel
  if ! is_function_handle(splitter)
    error("Parameter splitter must be a function handle");
  end

  NextNode = 1;
  Connectivity = [];
  NodeName = {};
  NodeValue = {};
  NodeLabel = {};
  node = ID3_r (S, F, level, attr_names, attr_values, label, '_', splitter);
end;

function node = ID3_r (S, F, level, attr_names, attr_values, label, value, splitter)
  global NextNode Connectivity NodeName NodeValue NodeLabel AttrValues
  %%
  if ! is_function_handle(splitter)
    error("Parameter splitter must be a function handle");
  end

  %%printf("Entering ID3: level = %d\n", level);
  %%WriteS(S, attr_names)

  %% Allocate a root/leaf node
  node = AllocNode();
  if level == 0
    %%printf("Level limit reached, return leaf node.\n");
    NodeName{node} = 'leaf';
    %% attributes is empty, label is most common value (mode).
    NodeLabel(node) = cellmode(S);
    NodeValue(node) = value;    
  %% If all examples have the same label
  elseif all(strcmp(S(:, label), S(1, label)))
    %% return a leaf node
    %%printf("All labels the same, return leaf node.\n");
    NodeName{node} = 'leaf';
    %% If attributes is not empty
    if (columns(S) > 1)
      NodeLabel(node) = S{1, label};
    else %% attributes is empty, label is most common value (mode).
      NodeLabel(node) = cellmode(S);
    end 
    NodeValue(node) = value;
  else
    %% Create root node,
    %%printf("Create a root node: %d\n", node);
    split_attr = splitter(S, attr_names, attr_values);
    split_name = strtrim(attr_names{split_attr});
    NodeName{node} = split_name;
    NodeValue(node) = value;
    %%printf("Split attr is %s\n", split_name);
    values = attr_values{split_attr};
    for idx = 1:columns(values)
      matches = find(strcmp(S(:, split_attr), values(idx)));
      %% if Sv is empty
      if numel(matches) == 0
	%%printf("Sv is empty, return leafnode, v = %s\n", ...
	%%       cellmode(S(:,end)){1});
	leafnode = AllocNode('Leaf', cellmode(S(:,end)), values{idx});
	Connectivity(node, leafnode) = 1;
      else
	%%printf("Recur on Sv, attribute value = %s\n", values{idx});
	Sv = S(matches, [1:split_attr-1,split_attr+1:end]);
	%% N.B. the use of parens on the cell array attr_values, ain't matlab wonderful
	newnode = ID3_r(Sv, ...
			F, ...
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
  %%printf("\n");
end

function node = AllocNode(name = 'UNKNOWN', label = '_', value='_')
  global NextNode  Connectivity NodeName NodeValue NodeLabel AttrValues
  node = NextNode;
  NextNode = NextNode + 1;
  NodeName{node} = name;
  NodeLabel(node) = label;
  NodeValue(node) = value;
end