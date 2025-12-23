# Beyond Causal Inference?
## A Field-Based Framework for Real-World Epidemiology

> TL;DR
> - Standard causal inference is powerful but strained in RWD
> - Positivity violation is a symptom, not the root problem
> - We propose a field-based, state-space formulation
> - Classical causal estimands arise as projections of the field

---

## 1. Dissatisfaction with Causal Inference
### — The Newtonian Feeling

Modern causal inference asks:

$$
\text{What is } \mathbb{E}[Y(1) - Y(0)] \, ?
$$

This assumes the existence of well-defined potential outcomes:

$$
Y(a) \in \mathcal{Y}, \quad a \in \{0,1\}
$$

and interprets intervention as an external force:

$$
A \;\longrightarrow\; Y
$$

In RWD, however, the system state is high-dimensional and evolving:

$$
S_t = (X_t, A_t), \quad S_{t+1} = \mathcal{F}(S_t)
$$

The force-based abstraction becomes strained.

---

## 2. An Einsteinian Analogy
### — From Force to Field

Instead of modeling effects as forces:

$$
A \mapsto Y
$$

we reinterpret outcomes as trajectories induced by a field defined
over the state space.

Objects do not respond to forces.
They follow paths determined by geometry.

---

## 3. Positivity Is a Symptom, Not the Disease

### 3.1 Positivity / Overlap

Standard causal inference assumes:

$$
0 < P(A = 1 \mid X = x) < 1
$$

for all $x$ with positive density.

In RWD, structural constraints imply:

$$
P(A = 1 \mid X = x) \in \{0,1\}
$$

for non-negligible regions of the state space.

This is not a technical failure.
It is a geometric one.

---

## 4. State-Space and Dynamics

### 4.1 State Definition

We define the system state as:

$$
S_t = (X_t, A_t) \in \mathcal{S}
$$

where treatment is a coordinate, not an external action.

The system evolves according to a transition kernel:

$$
P(S_{t+1} \mid S_t) = K(S_t, S_{t+1})
$$

---

## 5. Risk Field

### 5.1 Local Risk Density

Define a risk (hazard) field over the state space:

$$
\lambda(s) = \lim_{\Delta t \to 0}
\frac{P(T \in [t, t+\Delta t) \mid S_t = s)}{\Delta t}
$$

This is estimable from RWD using standard survival models.

---

### 5.2 Potential Function

We define an information-theoretic potential:

$$
\Phi(s) = -\log \lambda(s)
$$

Regions of:
- high risk → low potential
- low risk → high potential

System trajectories tend to flow toward lower $\Phi(s)$.

---

## 6. Intervention as a Transition Operator

Instead of a do-operator:

$$
\text{do}(A = a)
$$

we define intervention as a state transformation:

$$
\mathcal{I}_a : \mathcal{S} \to \mathcal{S}, \quad
\mathcal{I}_a(s) = (x, a)
$$

Interventions reposition the system within the field.

---

## 7. Where Causal Estimands Come From
### — Projection View

The average treatment effect is:

$$
\text{ATE} = \mathbb{E}[Y(1) - Y(0)]
$$

In the field view, this corresponds to a projection:

$$
\text{ATE}
\;\approx\;
\mathbb{E}_X \left[
\lambda(X, A=1) - \lambda(X, A=0)
\right]
$$

or equivalently,

$$
\text{ATE}
\;\approx\;
\mathbb{E}_X \left[
\Phi(X,0) - \Phi(X,1)
\right]
$$

This is a low-dimensional summary of a high-dimensional field.

---

## 8. Interpretation

- The field $\lambda(s)$ is fundamental
- Causal estimands are coordinate-dependent summaries
- Positivity violations indicate inaccessible regions of $\mathcal{S}$

Causal inference is not false.
It is incomplete.

---

## 9. Closing Analogy

Newtonian mechanics is not wrong.
It is flat-space physics.

Real-world epidemiology may require curvature.
