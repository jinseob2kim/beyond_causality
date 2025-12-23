### Figure 1. Causal Effect vs Field-based Perspective

(A) Causal inference view (force-based)
```text
----------------------------------------

   A = 0  -------------------->  Y(0)
              |
              |  causal effect
              v
   A = 1  -------------------->  Y(1)

Effect = E[Y(1) - Y(0)]


(B) Field-based view (geometry-based)
-------------------------------------

        High risk
          ^
          |        ● s'
          |      ／
          |    ／   ΔΦ
          |  ／
          |● s
          |
          +----------------------> State space

Treatment A is not a force,
but an operator that moves the state
along the field Φ(s).


> Figure 1. Conceptual contrast between causal inference and field-based epidemiology. In causal inference, treatment is modeled as a force producing counterfactual outcomes. In the field-based view, treatment acts as a state-transition operator within a structured risk field
