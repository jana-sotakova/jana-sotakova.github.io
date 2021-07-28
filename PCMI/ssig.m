// In this exercise, we code the SSIG G_ell defined over Fp^2.
// Vertices:= j-invariants of SS elliptic curves /Fp^2
// edges:= There is an edge between j, j' if and only if
//          there is an ell-isogeny between E_j and E_j'



q := 41;
ell := 2;

F<a>:= FiniteField(q^2);
R<X,Y>:=PolynomialRing(F, 2);
Phi :=R!ClassicalModularPolynomial(ell);




// First we find one SS curve over Fp^2
// We will actually find one over Fp

SSjInvariant:= function(q)
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
      S := PolynomialRing(F);
      f := S!HilbertClassPolynomial(-r);
      j := Roots(f)[1][1];
  return F!j;
  end if;
end function;





NumberSS:=function(q)
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
SSIG:= function(q, ell)
  F:= FiniteField(q^2);
  // First get one SS j-invariant
  j :=SSjInvariant(q);
  //  start the graph
  Vertices := [];
  Not_visited := [j];

  Edges := [];
//  Edges := [ {j, a} : a in Neighbor(j, ell, q)];


  // First determine the neighbor function
  Neighbor := function(jj, ell, q)
    // need to fix to return the neighbours with correct multiplicity
    S<Z>:=PolynomialRing(F);
    R<X,Y>:=PolynomialRing(F, 2);
    Phi :=R!ClassicalModularPolynomial(ell);
    N := [F!f[1] : f in Roots(Evaluate(Phi, [jj, Z]))];
    return N;
  end function;


  while #Not_visited ge 1 do
    jnew :=Not_visited[#Not_visited]; //picks the last element
    Prune(~Not_visited);  //removes the last element in the list
    Vertices cat:= [jnew];
    Neighbors := Neighbor(jnew, ell, q);
    print jnew, "neighbors", Neighbors;
    Edges cat:= [ [jnew, a] : a in Neighbors];
    for a in Neighbors do
      if not (a in (Vertices cat Not_visited)) then
        Not_visited cat:=[a];
      end if;
    end for;
  end while;

  // How to actually turn this into the graph?
//
//  return G;

  // Check that we got all the vertices
  count := NumberSS(q);
//  assert #Vertices eq count;

  // Check that we got all the (directed) Edges
//  assert #Edges eq count*(ell+1);

  return Vertices, Edges;
  // BFS on the graph to generate all the vertices and edges

end function;


Vertices, Edges := SSIG(p, ell);
Vertices;
// currently without the correct mutliplicity and directed
Edges;
