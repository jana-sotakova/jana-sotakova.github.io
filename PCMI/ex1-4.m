// In this exercise, we code the SSIG G_ell defined over Fp^2.
// Vertices:= j-invariants of SS elliptic curves /Fp^2
// edges:= There is an edge between j, j' if and only if
//          there is an ell-isogeny between E_j and E_j'





// First we find one SS curve over Fp^2
// We will actually find one over Fp

function SSjInvariant(q)
  F:= FiniteField(q^2);
  if (q mod 4) eq 3 then
    // We simply return j=1728
    return F!1728;
  else
  // We need to use CM theory to construct a curves
  // as a reduction of a char 0 curve with CM by a suitable order
    r := 3;
    while ( (r mod 4) ne 3) or (KroneckerSymbol(-r, q) eq 1) do
      r := NextPrime(r);
      end while;
      R := PolynomialRing(F);
      f := R!HilbertClassPolynomial(-r);
      j := Roots(f)[1][1];
  return j;
  end if;
end function;





// First determine the neighbor function
function Neighbor(j, ell, q)
  F:= FiniteField(q^2);
  R<X,Y>:=PolynomialRing(F, 2);
  S<Z>:=PolynomialRing(F);
  Phi :=R!ClassicalModularPolynomial(ell);

  N := [f[1] : f in Roots(Evaluate(Phi, [j, Z]))];
  return N;
end function;


function NumberSS(q)
/// determines the number of SS j-invariants in char q
  count := (q-1) div 12;
  if q mod 4 eq 3 then
    count := count + 1;
  elif q mod 3 eq 2 then
    count := count+ 1;
  end if;
  return count;
end function;


/// Finally, we construct the isogeny graph
function SSIG(q, ell)
  F<z>:= FiniteField(q^2);
  // First get one SS j-invariant
  j :=SSjInvariant(q);
  //  start the graph
  Vertices := [];
  Not_visited := [j];

  Edges := [];

  count := NumberSS(q);
  while #Not_visited ge 1 do
    jnew :=Not_visited[#Not_visited]; //picks the last element
    print jnew, Not_visited;
    Prune(~Not_visited);  //removes the last element in the list
//    print "not visited", Not_visited;
    Vertices cat:= [jnew];
//    print "vertices", Vertices;
    Neighbors := Neighbor(jnew, ell, q);
//    print "neighbors", Neighbors;
    Edges cat:= [ [jnew, a] : a in Neighbors];
//    print "edges", Edges;
    for a in Neighbors do
      if not (a in Vertices) and a ne jnew and not (a in Not_visited) then
        Not_visited cat:= [a];
      end if;
    end for;
//    print "not visited", Not_visited;
  end while;

  // How to actually turn this into the graph?
//
//  return G;

  // Check that we got all the vertices
  assert #Vertices eq count;


  return Vertices, Edges;
end function;









// We try out this function
p := 23;
for _ in [1..20] do
  print "Printing out small SS j-invariants", p, SSjInvariant(p);
  assert IsSupersingular(EllipticCurveWithjInvariant(SSjInvariant(p)));
  p :=NextPrime(p);
end for;
