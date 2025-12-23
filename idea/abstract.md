# Beyond Causal Inference?
## A Field-Based, Dynamical Framework for Real-World Epidemiology

> **Core message**  
> Causal effects are not forces.  
> They are directional derivatives of a risk potential field.

---

## 1. Motivation: The Newtonian Discomfort

Modern causal inference in epidemiology typically asks:

$$
\text{ATE} = \mathbb{E}[Y(1) - Y(0)]
$$

This formulation assumes:
- well-defined potential outcomes $Y(a)$
- interventions acting as external causes
- counterfactual symmetry between $a=0$ and $a=1$

This works extremely well in randomized controlled trials.

However, in real-world data (RWD), the system is:
- high-dimensional
- time-varying
- policy- and guideline-constrained
- observer-influenced

Yet we still model intervention as a force:

$$
A \;\longrightarrow\; Y
$$

This increasingly resembles a Newtonian abstraction applied outside its natural domain.

---

## 2. An Einsteinian Analogy: From Force to Field

Einstein did not reinterpret gravity by refining the force.
He removed the force.

Objects do not respond to gravity.
They follow geodesics in a curved spacetime.

We propose an analogous shift:

- Causal effects are not primitive forces
- Outcomes arise from motion within a structured field
- Interventions reposition systems inside that field

---

## 3. State Space and Dynamics

### 3.1 State Definition

We define the system state as:

$$
S_t = (X_t, A_t) \in \mathcal{S}
$$

where treatment $A_t$ is a coordinate of the system, not an external action.

The system evolves according to a transition kernel:

$$
P(S_{t+1} \mid S_t) = K(S_t, S_{t+1})
$$

Regions where $K$ assigns zero probability are *structural*, not violations.

---

## 4. Risk Field and Potential Function

### 4.1 Risk (Hazard) Field

Define a local risk field:

$$
\lambda(s)
=
\lim_{\Delta t \to 0}
\frac{P(T \in [t, t+\Delta t) \mid S_t = s)}{\Delta t}
$$

This is estimable using standard survival models.

---

### 4.2 Potential Function

Define a risk potential:

$$
\Phi(s) = -\log \lambda(s)
$$

Interpretation:
- low $\Phi$ → high risk
- high $\Phi$ → relative stability

$\Phi$ is not an outcome.
It is a geometric property of the state space.

---

## 5. Φ as a Lyapunov-like Function

Consider system evolution:

$$
S_{t+1} = \mathcal{F}(S_t)
$$

In many RWD systems, events occur preferentially along trajectories where:

$$
\mathbb{E}[\Phi(S_{t+1}) \mid S_t = s] \le \Phi(s)
$$

Thus, $\Phi$ behaves as a **stochastic Lyapunov-like function**:
- not strictly decreasing
- but directionally aligned with instability and event occurrence

This allows us to:
- define system directionality without average effects
- analyze stability structure before causal contrasts

---

## 6. Intervention as a Transition Operator

Instead of a do-operator:

$$
\text{do}(A=a)
$$

we define intervention as a state transformation:

$$
\mathcal{I}_a : \mathcal{S} \to \mathcal{S}, \quad
\mathcal{I}_a(x,a') = (x,a)
$$

Interventions move the system across the field.
They do not directly generate outcomes.

---

## 7. Vector Field Interpretation of Risk and Protection

### 7.1 Gradient of the Potential

$\Phi$ defines a scalar field.
Its gradient defines a vector field:

$$
\nabla \Phi(s)
=
\left(
\frac{\partial \Phi}{\partial x_1},
\dots,
\frac{\partial \Phi}{\partial x_p},
\frac{\partial \Phi}{\partial a}
\right)
$$

This is the **risk-gradient field**.

---

### 7.2 Directional Effects

An intervention induces a displacement:

$$
\Delta s = (0,\dots,0,\Delta a)
$$

The local change in potential is approximated by:

$$
\Delta \Phi
\approx
\nabla \Phi(s) \cdot \Delta s
$$

Definitions:
- **Risk-increasing effect** if $\Delta \Phi < 0$
- **Protective effect** if $\Delta \Phi > 0$

These are *local, state-dependent* properties.

---

## 8. ATE as a First-Order Taylor Projection

The true object is the field $\Phi(x,a)$.

A first-order Taylor expansion gives:

$$
\Phi(x,1)
\approx
\Phi(x,0)
+
\frac{\partial \Phi(x,a)}{\partial a}\Big|_{a=0}
$$

Therefore:

$$
\Phi(x,0) - \Phi(x,1)
\approx
-
\frac{\partial \Phi}{\partial a}
$$

Averaging over $X$ yields:

$$
\text{ATE}
\;\approx\;
\mathbb{E}_X
\left[
\Phi(X,0) - \Phi(X,1)
\right]
$$

**ATE is a first-order projection of a high-dimensional geometry.**

Nonlinearity, curvature, and heterogeneity are discarded by construction.

---

## 9. Positivity Reinterpreted Geometrically

Standard positivity requires:

$$
0 < P(A=1 \mid X=x) < 1
$$

In the field view:
- positivity violation corresponds to *disconnected regions* of $\mathcal{S}$
- these are geometric constraints, not estimation failures

The causal question itself may not be defined across such regions.

---

## 10. Relation to MSM and g-formula

Marginal structural models and g-formulae can be reinterpreted as:

- attempts to estimate *average flow* along specific field directions
- under assumptions that enforce smooth connectivity of $\mathcal{S}$

When connectivity fails, weights diverge because geometry does.

---

## 11. Toy Interpretation (Conceptual)

- ATE ≈ average projection of $\nabla \Phi$ onto treatment axis
- Zero ATE can arise from opposing local vectors
- Field view preserves this structure instead of averaging it away

---

## 12. Theorem (Informal Statement)

**Proposition (ATE as Projection).**  
Under smoothness and local linearity of $\Phi(x,a)$ in $a$,
the average treatment effect corresponds to the first-order
directional derivative of $\Phi$ along the treatment coordinate,
averaged over the marginal distribution of $X$.

Higher-order geometry is ignored.

---

## 13. Implications

- Counterfactual existence is not required
- Positivity violations become structural information
- Observer feedback can be embedded in $K(s,s')$
- Effects are directional, not scalar

---

## 14. Closing Perspective

Newtonian mechanics is not wrong.
It is flat-space physics.

Causal inference is not false.
It is a low-curvature approximation.

Real-world epidemiology may require a geometric view.
