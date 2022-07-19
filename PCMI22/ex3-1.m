// Define the quaternion algebra:


// p equiv 3 mod 4
p := 67;
B := QuaternionAlgebra< RationalField() | -1, -p >;
_, i, j, k := Explode(Basis(B));

i^2 eq -1;
j^2 eq -p;

RamPrimes := RamifiedPrimes(B); RamPrimes;
D := Discriminant(B); D;

for q in RamPrimes do
  assert D mod q eq 0;
end for;



// p not 3 mod 4:
// need to find a small primes r with r = 3 mod 4
// and r a non-square mod p
p := 41;

r := 3;
while (r mod 4 ne 3) or KroneckerSymbol(-r, p) ne -1 do
  r := NextPrime(r);
end while;

print r;
B<i,j, k> := QuaternionAlgebra< RationalField() | -r, -p >;
Basis(B);

i^2 eq -r;
j^2 eq -p;

// Same check of ramification
RamPrimes := RamifiedPrimes(B); RamPrimes;
D := Discriminant(B); D;

for q in RamPrimes do
  assert D mod q eq 0;
end for;



/// define the element
//  2 + i − 3j + 4k

w := B![2, 1, -3, 4];
// or w := 2 + i - 3*j +4k;

Norm(w), Trace(w), MinimalPolynomial(w);
