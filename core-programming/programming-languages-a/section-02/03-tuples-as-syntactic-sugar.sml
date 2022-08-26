val a_pair = (3+1,4+2);
val a_record = {second=4+2,first=3+1};
val another_pair = {1=3+1,2=4+2};
#1 a_pair + #2 another_pair;
val x = {3="hi", 1=true};
val y = {3="hi", 1=true, 2=3+2};

(* 

- Tuple syntax is just a diff way to write certain records
- (e1,...,en) is another way of writing {1=e1,...,n=en}
- t1*...*tn is another way of writing {1:t1,...,n:tn}

 *)



 (* 
 
    Tuples are just syntactic sugar for records with fields named 1,2,...,n


- Syntactic: can describe the semantics entirely by the corresponding record syntax
- Sugar: They make the language sweeter

- andalso and orelse are also syntactic sugar

  *)