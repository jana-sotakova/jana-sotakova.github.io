//Define the finite field
F := FiniteField(431);

E:= EllipticCurve([F!1, F!0]);




//Compute the j-invariant
jInvariant(E);



// Compute elliptic curves from j-invariant
j := F!234;

E1 := EllipticCurveWithjInvariant(j);

//Check supersingularity
IsSupersingular(E1);

//Find another non-isomorphic curve with the same j-invariant
_, E2 := Explode(QuadraticTwists(E1)); E1, E2;

//Check whether they're isomorphic
IsIsomorphic(E1, E2);



// This is how you base change in general
F2:= FiniteField(431^2);
IsIsomorphic(BaseChange(E1,F2 ), BaseChange(E2, F2));
