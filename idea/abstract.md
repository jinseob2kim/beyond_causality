---
output:
  html_document: default
  pdf_document: default
---
# The Epidynamix Framework
## A Field-Based, Dynamical Approach to Real-World Epidemiology

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

## Notation

Throughout this paper, we use the following conventions:

| Symbol | Meaning |
|--------|---------|
| $S_t = (X_t, A_t)$ | System state at time $t$ |
| $\mathcal{S}$ | State space |
| $\lambda(s)$ | Instantaneous hazard at state $s$ |
| $\Phi(s)$ | Risk potential function |
| $\nabla \Phi$ | Gradient (for continuous variables) |
| $\delta_A \Phi(x)$ | Finite difference for binary $A$: $\Phi(x,1) - \Phi(x,0)$ |
| $K(s, s')$ | Transition kernel |
| $\mathcal{I}_a$ | Intervention operator |

**Note on binary treatment:**
When $A \in \{0, 1\}$, expressions like $\partial \Phi / \partial a$ should be understood as the finite difference $\delta_A \Phi$, not a true derivative.

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

### 4.3 Time Treatment

**Simplifying assumption:** In this framework, we treat $\Phi(s)$ as either:

1. **Landmark approach:** Evaluated at a fixed reference time $t^*$
   $$\Phi(s) := \Phi(s; t^*)$$

2. **Stationary assumption:** Time-invariant for a given state
   $$\Phi(s) = \Phi(s) \quad \text{(no explicit } t \text{ dependence)}$$

3. **Cumulative formulation:** Integrated over a horizon $[0, \tau]$
   $$\Phi(s) = -\log \Lambda(s) = -\log \int_0^\tau \lambda(s, u) \, du$$

For the toy examples in this paper, we adopt the **stationary assumption** for simplicity. Extension to fully time-varying fields is discussed in Section 12.

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

**Connection to Cox regression:** In the Cox model, $\log \lambda(s) = \log h_0(t) + \beta' s$.
Since $\Phi = -\log \lambda$, we have $\nabla_x \Phi = -\beta$ (for continuous covariates,
independent of baseline hazard $h_0$). The field framework generalizes this to nonlinear $\Phi(s)$.

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

**For continuous treatment**, a first-order Taylor expansion in $a$ gives:

$$
\Phi(x,1)
\approx
\Phi(x,0)
+
\frac{\partial \Phi(x,a)}{\partial a}\Big|_{a=0}
$$

**For binary treatment** $A \in \{0,1\}$, this reduces to the finite difference
(see Notation section):

$$
\Phi(x,1) - \Phi(x,0) = \delta_A \Phi(x)
$$

Averaging over $X$ yields the ATE:

$$
\text{ATE} = \mathbb{E}_X
\left[\Phi(X,1) - \Phi(X,0)\right]
= \mathbb{E}_X[\delta_A \Phi(X)]
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

### 10.6 Mathematical Formalization: ATE as a Special Case

**Theorem (Informal):** The Average Treatment Effect (ATE) is an
information-preserving summary of the field $\Phi(x, a)$ when effect
heterogeneity is negligible, i.e., $\text{Var}_X[\delta_A \Phi] \approx 0$.

**Proof sketch:**

**For binary treatment** $A \in \{0, 1\}$:

The treatment effect is exactly the finite difference:

$$
\delta_A \Phi(x) = \Phi(x, 1) - \Phi(x, 0)
$$

No Taylor expansion is needed. "Curvature" in this context refers to
**heterogeneity across $x$**, i.e., how much $\delta_A \Phi(x)$ varies with $x$.

**For continuous/dose treatment** $A \in [0, 1]$:

We can write the effect as an integral:

$$
\Phi(x, 1) - \Phi(x, 0) = \int_0^1 \frac{\partial \Phi}{\partial a}(x, a) \, da
$$

Or via second-order Taylor expansion around $a = 0$:

$$
\Phi(x, 1) \approx \Phi(x, 0) + \frac{\partial \Phi}{\partial a}\Big|_{a=0} + \frac{1}{2} \frac{\partial^2 \Phi}{\partial a^2}\Big|_{a=\xi}
$$

where $\xi \in (0, 1)$. The curvature term $\frac{\partial^2 \Phi}{\partial a^2}$
captures dose-response nonlinearity.

**Case 1: Homogeneous effects ($\text{Var}_X[\delta_A \Phi] \approx 0$)**

For binary treatment, $\text{ATE} = \mathbb{E}_X[\delta_A \Phi(X)]$ holds by definition.
The question is whether this average is **informative**.

When $\delta_A \Phi(x) \approx c$ (constant across $x$):

$$
\text{ATE} \approx c
$$

ATE is a complete summary—no information is lost.

For continuous treatment, this additionally requires low dose-response
curvature ($\partial^2 \Phi / \partial a^2 \approx 0$).

**Case 2: Heterogeneous effects ($\text{Var}_X[\delta_A \Phi]$ large)**

ATE remains well-defined:

$$
\text{ATE} = \mathbb{E}_X[\delta_A \Phi(X)]
$$

But it collapses a distribution into a single number, losing information about:
- Where effects are strong vs weak
- Where effects are positive vs negative
- Subpopulation-specific responses

**Case 3: Positivity violation (structural discontinuity)**

When $P(A = 0 \mid X = x) = 0$ for some $x$, the field $\Phi(x, 0)$ is
**undefined or inaccessible** in that region.

Attempting to compute:

$$
\text{ATE} = \mathbb{E}[\Phi(X, 0) - \Phi(X, 1)]
$$

involves integration over regions where $\Phi(x, 0)$ does not exist.
This is not an estimation problem—it is a **domain problem**.

One may redefine the estimand on the overlap region (where positivity holds);
here we treat the full-population ATE as undefined to emphasize the structural constraint.

The IPTW approach attempts to reweight observations to recover this
quantity, but when $P(A = 0 \mid X) \to 0$, the weights $1/P(A \mid X) \to \infty$.

**Conclusion:**

- **ATE is valid** when $\Phi$ is smooth, low-curvature, and well-defined everywhere
- **ATE is approximate** when heterogeneity exists but the field is connected
- **ATE is undefined** when positivity fails (structural disconnection)

MSMs and g-formula inherit these limitations because they ultimately
estimate projections of the field onto the treatment axis.

---

### 10.7 Summary

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

## 12. Relation to Existing Heterogeneity Research

### 12.1 How is this different from CATE?

Conditional Average Treatment Effect (CATE) estimation—via causal forests,
meta-learners, or Bayesian approaches—also acknowledges effect heterogeneity.
One might ask: *what does the Epidynamix framework add?*

| Aspect | CATE / HTE Research | Epidynamix |
|--------|---------------------|------------|
| Core question | "What is the effect for subgroup $X=x$?" | "What is the structure of the risk field?" |
| Output | $\tau(x) = \mathbb{E}[Y(1) - Y(0) \mid X=x]$ | $\Phi(s)$, $\nabla \Phi$, structural boundaries |
| Positivity violation | Estimation problem (trim, extrapolate) | **Information** (map the boundary) |
| Counterfactuals | Required | Not required |
| Goal | Better effect estimation | Different question entirely |

**Key distinction:** CATE still asks "what is the effect?"—just conditional on $X$.
Epidynamix asks "what does the risk landscape look like, and where can we not go?"

### 12.2 Novelty Claim

We do not claim to invent new mathematics. Potential landscapes, dynamical systems,
and information geometry exist in physics and theoretical biology.

Concurrent work by Leizerman (2025) develops a "Unified Causal Field Theory" using
differential geometry and fiber bundles—a more general mathematical formalization
applicable across domains. [Available at: https://osf.io/download/68805ae08cbd2c498f1f63d8/]

Our contribution is **complementary**: applying this geometric lens specifically to clinical RWD, where:
- Positivity violations are common (guidelines, contraindications)
- Treatment effects are entangled with state (confounding by indication)
- The "average effect" question may be structurally unanswerable

This is a **reinterpretation**, not an invention—a new language for an old problem.

---

## 13. Closing Perspective

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

---

## A4. Toy Simulation: Traditional Methods vs Field-Based Approach

### Setup

We simulate a 2D state space with survival outcomes:
- $X_1$: Systolic blood pressure (SBP, 100–200 mmHg)
- $X_2$: Inflammatory marker (CRP, 0–10 mg/L)
- $A$: Binary treatment (antihypertensive)
- $T$: Survival time (exponentially distributed based on hazard)

**Time treatment:** We adopt the **stationary assumption** (Section 4.3),
treating $\Phi(s)$ as time-invariant for simplicity.

**Structural constraint:** If $X_1 > 160$, then $A = 1$ (mandatory treatment per clinical guideline).

**Heterogeneous effect:** Treatment benefit increases with $X_1$.

**Connection to Cox model:** In the Cox framework, $\log \lambda(s) = \log h_0(t) + \beta' s$,
so $\nabla_x \Phi = -\beta$ (independent of $h_0(t)$, for continuous covariates).
Our GAM-based estimation generalizes this to nonlinear $\Phi(s)$.

### Results (N = 3000)

**Traditional Methods (Scalar Summaries):**

| Method | Estimate | Interpretation |
|--------|----------|----------------|
| Cox HR | 0.55 | "Treatment reduces hazard by 45%" |
| IPTW ATE | 0.20 | "Treatment increases 1-year survival by 20%p" |

Both methods produce a single number summarizing "the effect."

**Field-Based Approach:**

| Output | Value | Interpretation |
|--------|-------|----------------|
| $\delta_A \Phi$ range | 0.42 – 1.66 | Effect varies 4-fold across state space |
| Gradient direction | Increasing with $X_1$ | Higher BP → larger treatment benefit |
| Structural boundary | $X_1 > 160$ (gray region) | Comparison impossible; all patients treated |

### Key Message

1. **Traditional methods are not wrong:** Cox and IPTW correctly estimate average effects.

2. **But averages hide structure:** The single number (HR = 0.55) does not reveal that treatment benefit varies 4-fold depending on patient state.

3. **Positivity violation is information:** The region $X_1 > 160$ is shown as a gray "no-comparison zone" in the field visualization. This is not a nuisance—it reflects the clinical guideline that mandates treatment for high-risk patients.

4. **Field-based output is a map, not a number:** Instead of asking "what is the effect?", we ask "where is the effect strong, weak, or undefined?"

See `simulation/fig_field_approach.png` for visualization.
