p :=67;

// define a quaternion algebra
B<i,j,k> := QuaternionAlgebra< RationalField() | -1,- p >;


O := MaximalOrder(B);
Basis(O);

// discriminant
Discriminant(O);

assert Discriminant(O) eq Discriminant(B);

// define a smaller order:
Ostd := QuaternionOrder([1,i, j,k]);
// compute the discriminant to see that this order is not maximal
Discriminant(Ostd), Factorization(Discriminant(Ostd));

// check whether the order is maximal
IsMaximal(Ostd);


// define another maximal order
O1 := QuaternionOrder([1, i, (1+k)/2, (i+j)/2]);
Basis(O1);
IsMaximal(O1);
IsIsomorphic(O, O1);

// Note that O can be identified with the endomorphism ring of
// E: y^2 = x^3 - x,
//O has basis [ 1, i, 1/2*i + 1/2*k, 1/2 + 1/2*j ]
// whereas O1 can be identified with the endo ring of
// E1 : y^2 = x^3 + x; which is a quartic twist of E,
// so the orders need to be isomorphic
//O1 has basis [ 1, i, 1/2 + 1/2*k, 1/2*i + 1/2*j ]
Basis(O), Basis(O1);
