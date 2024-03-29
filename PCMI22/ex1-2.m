//Define the finite field
p := 431;
F<z> := FiniteField(p^2);

E:= EllipticCurve([F!1, F!0]);

//Compute the j-invariant
jInvariant(E);

// Point on an elliptic curve:
P2:= E![0,0];
// Check the order of this point
Order(P2);


// Compute an isogeny with kernel P:
R<X> := PolynomialRing(F);

// IsogenyFromKernel takes in the kernel polynomial of the isogeny
E2, phi := IsogenyFromKernel(E, X - P2[1]);

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


// This code works for any degree
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
while (8*Q eq E!0) or (WeilPairing(P, Q, 16)^8 eq 1) do
  Q := 3^3*Random(E);
end while;

// We can also check whether P, Q generate the full 16-torsion
// By checking that 8P != 8Q.

//while 8*P eq 8*Q and do
//  Q := 3^3*Random(E);
//end while;


// Figuring out all the subgroups is not trivial (can't see it now).
// generates all points of exact order 16
points := [a*P+b*Q : a,b in [0..15] |  8*(a*P+b*Q) ne E!0] ;

// I don't know how to define a list of isogenies from scratch
// This forces a list of isogenies (Magma universe)
Etemp, phitemp := IsogenyFromPoint(points[1]);
Isog16 := [phitemp];
Prune(~Isog16);

for T in points do
  Etemp, phitemp := IsogenyFromPoint(T);
  if phitemp in Isog16 then
  else
    Isog16 := Isog16 cat [phitemp];
  end if;
end for;

// Check we have all the isogenies
#Isog16 eq 24;
