p :=67;

// define a quaternion algebra
B<i,j,k> := QuaternionAlgebra< RationalField() | -1,- p >;


O := MaximalOrder(B); O;

// enumerate the left-ideal classes
ideals := LeftIdealClasses(O);
print "There are ", #ideals, "many ideal classes";

print "For every ideal, we print out the basis, norm and the (basis of) the right order";
for I in ideals do
  print Basis(I), Norm(I), Basis(RightOrder(I));
end for;

MaxOrders := [RightOrder(I) : I in ideals];
#MaxOrders;

for u,v in [1..#MaxOrders] do
  if u lt v and IsIsomorphic(MaxOrders[u], MaxOrders[v]) then
    print "The following orders are isomorphic", Basis(MaxOrders[u]), Basis(MaxOrders[v]);
  end if;
end for;

print "We will use the Gram matrix for <x,y>, which is the matrix of the scalar product";
print "The relation is Norm(x) = 1/2 <x,x> ";
print "So to find whether Norm(x) represents p,";
print "Enough to find x such that <x,x> = 2p";

for O1 in MaxOrders do
  M := GramMatrix(O1);
  // Print out the gram matrix and the quadratic form
  print M, QuadraticForm(M);
  // check that they all have determinant p^2
  print Determinant(M), Factorization(Determinant(M));
end for;

QuadForms := [];

R<a,b,c,d> := PolynomialRing(IntegerRing(), 4);

print "Printing all the quadaratic forms";
for O1 in MaxOrders do
  f := QuadraticForm(GramMatrix(O1));

  f := Evaluate(f, [a, b,c,d]);
  print f;
  QuadForms cat:= [f];

end for;

QuadForms;

print "The first form represents 2p by setting b=1 , d= 2";
print "Printing Evaluate(QuadForms[1], [0,1,0,2]);";
Evaluate(QuadForms[1], [0,1,0,2]);

print "Now reduce the forms mod p";
S :=ChangeRing(R, FiniteField(p));
for i in [2..6] do
  form :=QuadForms[i];
  print S!form;
end for;

// We see that for all but the first one,
// all require a = b = 0 mod p.
print "Mod p, this requires a= b = 0";
print "You can check this by computing Kronecker symbols";
print "Printing
KroneckerSymbol(-34*42, p), KroneckerSymbol(-34*41, p), KroneckerSymbol(-34*63, p);";

KroneckerSymbol(-34*42, p), KroneckerSymbol(-34*41, p), KroneckerSymbol(-34*63, p);


// print all the forms, except for the first one
print "printing the factorization all the forms for 2-6 with a=p*a, b=p*b, check whether they represent 2p";

for i in [2..6] do
f :=QuadForms[i];
g := Evaluate(f, [p*a,p*b,c,d]);
print Factorization(g);
end for;

print "now need to figure out which of factored forms represent 1";
print "From computing the supersingular isogeny graph, we know that there are total 2 curves/ Fp";
