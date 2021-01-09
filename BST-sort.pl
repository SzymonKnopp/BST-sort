addNode([], Node, NewTree) :- NewTree=[[],Node,[]]. %add node
addNode([L,N,R], Node, NewTree) :- Node<N,  addNode(L,Node,NewL), NewTree=[NewL,N,R]. %go down left branch
addNode([L,N,R], Node, NewTree) :- Node>=N, addNode(R,Node,NewR), NewTree=[L,N,NewR]. %go down right branch

bst([], BST) :- BST=[].
bst([H|T], BST) :- bst(T, Tree), addNode(Tree, H, BST). 

extractMin([[],Min,[]], MinValue, NewBranch) :-         MinValue=Min, NewBranch=[]. %take root
extractMin([[[],Min,[]],N,R], MinValue, NewBranch) :-   MinValue=Min, NewBranch=[[],N,R]. %take from left branch
extractMin([[],Min,R], MinValue, NewBranch) :-          MinValue=Min, NewBranch=R. %take node
extractMin([L,N,R], MinValue, NewBranch) :- extractMin(L, MinValue, NewL), NewBranch=[NewL,N,R]. %go down left branch

extractAscending([], Sorted) :- Sorted=[].
extractAscending(BST, Sorted) :- extractMin(BST, MinValue, NewBST), extractAscending(NewBST, List), Sorted=[MinValue|List].

extractMax([[],Max,[]], MaxValue, NewBranch) :-         MaxValue=Max, NewBranch=[]. %take root
extractMax([L,N,[[],Max,[]]], MaxValue, NewBranch) :-   MaxValue=Max, NewBranch=[L,N,[]]. %take from right branch
extractMax([L,Max,[]], MaxValue, NewBranch) :-          MaxValue=Max, NewBranch=L. %take node
extractMax([L,N,R], MaxValue, NewBranch) :- extractMax(R, MaxValue, NewR), NewBranch=[L,N,NewR]. %go down right branch

extractDescending([], Sorted) :- Sorted=[].
extractDescending(BST, Sorted) :- extractMax(BST, MinValue, NewBST), extractDescending(NewBST, List), Sorted=[MinValue|List].

sortAsc(List, Sorted) :- bst(List, BST), extractAscending(BST, Sorted).
sortDesc(List, Sorted) :- bst(List, BST), extractDescending(BST, Sorted).