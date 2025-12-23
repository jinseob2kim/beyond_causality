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

Regions where $K$ assigns zero probability are **structural**, not violations.

---

## 4. Risk Field and Potential Function

### 4.1 Risk (Hazard) Field

Define a local risk field:

$$
\lambda(s) = \lim_{\Delta t \to 0}
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
It is a **geometric property of the state space**.

---

## 5. $\Phi$ as a Lyapunov-like Function

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

### 7.1 Gradient of the Potential (Risk Vector Field)

$\Phi$ defines a scalar field on $\mathcal{S}$.  
Its gradient defines a **vector field**:

$$
\nabla \Phi(s) =
\left(
\frac{\partial \Phi}{\partial x_1},
\ldots,
\frac{\partial \Phi}{\partial x_p},
\frac{\partial \Phi}{\partial a}
\right)
$$

This **risk-gradient field** encodes:
- directions of maximal risk increase
- local instability structure of the system

---

### 7.2 Directional Effects as Local Geometry

An intervention induces a local displacement:

$$
\Delta s = (0,\ldots,0,\Delta a)
$$

The induced change in potential is approximated by:

$$
\Delta \Phi
\approx
\nabla \Phi(s) \cdot \Delta s
$$

Definitions:
- **Risk-increasing effect:** $\Delta \Phi < 0$
- **Protective effect:** $\Delta \Phi > 0$

These effects are:
- local
- state-dependent
- directional

They are **not global scalar quantities**.

---

## 8. ATE as a First-Order Taylor Projection

The true object is the field $\Phi(x,a)$.

A first-order Taylor expansion in $a$ gives:

$$
\Phi(x,1)
\approx
\Phi(x,0)
+
\frac{\partial \Phi(x,a)}{\partial a}\Big|_{a=0}
$$

Therefore:

$$
\Phi(x,0) - \Phi(x,1) \approx - \frac{\partial \Phi}{\partial a}
$$

Averaging over $X$ yields:

$$
\text{ATE}
\;\approx\;
\mathbb{E}_X
\left[\Phi(X,0) - \Phi(X,1)\right]
$$

**ATE is a first-order projection of a high-dimensional geometry.**

---

## 9. Positivity Reinterpreted Geometrically

Standard positivity requires:

$$
0 < P(A=1 \mid X=x) < 1
$$

In the field view:
- positivity violations correspond to **disconnected regions** of $\mathcal{S}$
- these are geometric constraints, not estimation failures

---

## 10. Relation to MSM and the g-formula (Field-Based Interpretation)

Marginal structural models (MSMs) and the g-formula are widely used
extensions of causal inference designed to handle time-varying treatment
and confounding in longitudinal real-world data.

From a field-based perspective, these methods can be reinterpreted as
coordinate-dependent projections of an underlying dynamical system,
rather than estimators of primitive causal forces.

---

### 10.1 The g-formula as an Integrated Flow Over State Space

The g-formula can be written as:

$$
\mathbb{E}[Y^{\bar a}] =
\int
\mathbb{E}[Y \mid \bar A=\bar a, \bar X=\bar x]
\;
\prod_t
f(x_t \mid \bar x_{t-1}, \bar a_{t-1})
\;
d\bar x
$$

Conceptually, this corresponds to fixing a treatment regime
$\bar a = (a_1,\dots,a_T)$ and integrating outcome risk over all admissible
state trajectories.

From the field perspective, the g-formula computes the expected
accumulation of local risk along trajectories constrained to follow a
specific path through the state space.

---

### 10.2 MSMs as Average Projections of Field-Induced Flow

Marginal structural models estimate parameters using inverse probability
weights:

$$
w_i =
\prod_t
\frac{1}{P(A_t = a_{it} \mid \bar X_{it}, \bar A_{i,t-1})}
$$

These weights rebalance observed trajectories so that treatment appears
independent of time-varying confounders.

In the field-based view, MSMs estimate the average directional flow of
the system through the risk field, projected onto the treatment axis.

---

### 10.3 Weight Instability as a Geometric Signal

When positivity is violated, inverse probability weights diverge.

Geometrically, this corresponds to disconnected regions of the state
space where admissible trajectories do not exist.

Weight explosion is therefore not merely a numerical instability, but
a signal that the causal projection is being forced across regions with
no valid geometric connection.

---

### 10.4 Structural Zeroes vs Estimation Failures

In real-world data, treatment assignment is often constrained by:

- clinical guidelines
- contraindications
- institutional policies
- ethical rules

In the field-based framework, these constraints correspond to structural
boundaries of the state space where the transition kernel is zero.

Such regions define the geometry of the system and should not be treated
as estimation errors.

---

### 10.5 MSMs and g-formula as Low-Curvature Approximations

When the risk potential is smooth, curvature is low, and the state space
is well connected, MSMs and the g-formula provide accurate first-order
summaries.

When curvature, heterogeneity, or structural constraints dominate,
scalar causal summaries collapse complex geometry into unstable averages.

---

### 10.6 Summary

MSMs and the g-formula are not incorrect.
They are coordinate-dependent summaries of an underlying risk field,
valid only under strong geometric regularity assumptions.

The field-based framework clarifies when these methods work, why they
fail, and what structural information is discarded.



---

## 11. Implications

- Counterfactual existence is not required
- Positivity violations become structural information
- Observer feedback can be embedded in $K(s,s')$
- Effects are directional, not scalar

---

## 12. Closing Perspective

Newtonian mechanics is not wrong.  
It is flat-space physics.

Causal inference is not false.  
It is a low-curvature approximation.

**Real-world epidemiology may require a geometric view.**

---

# Appendix

## A1. ATE as Directional Derivative

$$
\text{ATE}
\approx
\mathbb{E}_S
\left[
\nabla \Phi(S) \cdot \mathbf{e}_A
\right]
$$

where $\mathbf{e}_A$ is the unit vector along the treatment coordinate.

---

## A2. Curvature Effects

Including second-order terms:

$$
\Delta \Phi
\approx
\nabla \Phi \cdot \Delta s
+
\frac{1}{2}
\Delta s^\top
H_\Phi
\Delta s
$$

ATE ignores curvature encoded in $H_\Phi$.

---

## A3. Analogy Table

| Classical | Field-based |
|---------|------------|
| Force | Potential field |
| Effect | Directional derivative |
| ATE | First-order projection |
| Violation | Structural geometry |
