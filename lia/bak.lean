import .has_atom

namespace lia 


def bval : frm znum → bool 
| ⊤' := tt
| ⊥' := ff
| (A' a) := aval [] a
| (p ∧' q) := bval p && bval q
| (p ∨' q) := bval p || bval q
| (¬' p) := bnot (bval p)
| (∃' p) := ff

 lemma bval_not {p} :
  bval (¬' p) = bnot (bval p) := rfl

 lemma bnot_eq_tt_iff_ne_tt {b : bool} :
  bnot b = tt ↔ ¬ (b = tt) := by simp 

 def bval_eq_tt_iff : 
  ∀ {p : frm znum}, qfree p → (bval p = tt ↔ p.eval [])
| ⊤' h := begin constructor; intro h; trivial end
| ⊥' h := begin constructor; intro h; cases h end
| (A' a) h := begin simp [bval, frm.eval, has_atom.aval] end
| (p ∧' q) h :=   
  begin
    cases h with hp hq,
    simp [bval, frm.eval, bval_eq_tt_iff hp, bval_eq_tt_iff hq]
  end
| (p ∨' q) h := 
  begin
    cases h with hp hq,
    simp [bval, frm.eval, bval_eq_tt_iff hp, bval_eq_tt_iff hq]
  end
| (¬' p) h := 
  by rw [ bval_not, eval_not, bnot_eq_tt_iff_ne_tt, @bval_eq_tt_iff p h ]
| (∃' p) h := by cases h

 end lia 