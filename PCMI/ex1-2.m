//Define the finite field
p := 431;
F := FiniteField(p^2);

E:= EllipticCurve([F!1, F!0]);

//Compute the j-invariant
jInvariant(E);

// Point on an elliptic curve:
P:= E![0,0];
// Check the order of this point
Order(P);


// Compute an isogeny with kernel P:
R<X> := PolynomialRing(F);

// IsogenyFromKernel takes in the kernel polynomial of the isogeny
E2, phi := IsogenyFromKernel(E, X - P[1]);

E2, phi;

// Compute the dual isogeny
DualIsogeny(phi);

// For an isogeny of prime degree, can use the following:

function Isog(P)
  Edom := Curve(P);
  n := Order(P);
//  assert IsPrime(n);
  if n eq 2 then
    return IsogenyFromKernel(Edom, X - P[1]);
  else
  return IsogenyFromKernel(Edom, &*[X - (i*P)[1] : i in [1..(n-1) div 2]]);
  end if;
end function;

//Isog(P);

function IsogenyFromPoint(P)
  Edom := Curve(P);
  n := Order(P);
  return IsogenyFromKernel(Edom, &*[X - (i*P)[1] : i in [1..n div 2]]);
end function;


// Find a random point of order 16:
P := 3^3*Random(E);
while Order(P) ne 16 do
  P := 3^3*Random(E);
end while;


// Find a second basis point for the E[16] torsion.
Q := 3^3*Random(E);
while Order(Q) ne 16 or WeilPairing(P, Q, 16) ne 1 do
  Q := 3^3*Random(E);
end while;
