//Modular polynomials

p = 431;
F<z>:= FiniteField(p, 2);
E:= EllipticCurve([F!26, F!379]);
E;
IsSupersingular(E);

j:= jInvariant(E);

R<X, Y>:=PolynomialRing(F, 2);
S<Z>:=PolynomialRing(F);
Phi3 :=R!ClassicalModularPolynomial(3);
f := Evaluate(Phi3, [j, Y]); f; Factorization(f);


N := [f[1] : f in Roots(Evaluate(Phi3, [j, Z]))];
N;

Phi16 := R!ClassicalModularPolynomial(16);
f := Evaluate(Phi16, [j, Z]);
Factorization(f);
Roots(f);




primes := [ell : ell in  [1..11] | IsPrime(ell)];
primes;

for ell in primes do
  Phi := R!ClassicalModularPolynomial(ell);
  print ell, Roots(Evaluate(Phi, [Z,Z]));
end for;
