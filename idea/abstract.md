---
output:
  html_document: default
  pdf_document: default
---
# The Epidynamix Framework
## A Field-Based, Dynamical Approach to Real-World Epidemiology

> **Core message**  
> Causal effects are not forces.  
> They are directional gradients in covariate space and finite differences across treatment regimes.

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

Throughout, we adopt a discrete-treatment convention:

| Symbol | Meaning |
|--------|---------|
| $S_t = X_t$ | System state (covariates) at time $t$ |
| $\mathcal{S}$ | State space for $X$ |
| $\lambda(x,a,t)$ | Instantaneous hazard at $x$ under $a$ at time $t$ |
| $\Phi_a(x)$ | Risk potential under regime $a\in\{0,1\}$ (landmark or cumulative) |
| $\nabla_x \Phi_a$ | Gradient w.r.t. covariates $x$ |
| $\Delta_A \Phi(x)$ | $\Phi_1(x) - \Phi_0(x)$ (finite difference across $a$) |
| $K_a(x_t,x_{t+1})$ | Transition kernel conditional on $a_t$ |
| $\mathcal{I}_a$ | Intervention operator selecting regime/index $a$ |

For binary $a$, we never take derivatives in $a$; we use finite differences $\Delta_A\Phi$.

---

## 3. State Space and Dynamics

### 3.1 State Definition

We model the state as covariates only:

$$
S_t = X_t \in \mathcal{S}.
$$

Treatment acts as a regime index. Covariate dynamics can depend on treatment via

$$
P(X_{t+1}\mid X_t, A_t=a)=K_a(X_t,X_{t+1}).
$$

Regions where $K_a$ assigns zero probability are **structural**, not violations.

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

Define a risk potential either at a landmark time $t^*$ or cumulatively:

$$
\Phi_a(x) = -\log \lambda(x,a,t^*)\quad\text{or}\quad \Phi_a(x) = -\log \int_0^\tau \lambda(x,a,t)\,dt.
$$

Interpretation:
- low $\Phi$ → high risk
- high $\Phi$ → relative stability

$\Phi$ is not an outcome.
It is a **geometric property of the state space**.

---

### 4.3 Time Treatment

RWD hazards are time-varying. We recommend: (1) landmark fields $\Phi_a(x; t^*)$ at clinically meaningful $t^*$; or (2) discrete-time fields $\Phi_{a,t}(x)$ on $t\in\{1,\dots,T\}$; or (3) cumulative $\Phi_a(x)$ over $[0,\tau]$. Toy examples use (1) for simplicity.

---

## 5. $\Phi$ as a Lyapunov-like Function

Consider system evolution:

$$
X_{t+1} = \mathcal{F}(X_t)
$$

For a fixed regime $a$, events occur preferentially along trajectories where:

$$
\mathbb{E}[\Phi_a(X_{t+1}) \mid X_t = x] \le \Phi_a(x)
$$

Thus, $\Phi$ behaves as a **stochastic Lyapunov-like function**:
- not strictly decreasing
- but directionally aligned with instability and event occurrence

---

## 6. Intervention as Regime Selection

Instead of a do-operator:

$$
\text{do}(A=a)
$$

we view intervention as **regime selection**—choosing which potential surface to evaluate:

$$
\mathcal{I}_a: x \mapsto \Phi_a(x)
$$

Intervention selects the regime index $a$, evaluating $\Phi_a(x)$ at the current state.
It does not transform the state itself.

---

## 7. Vector Field Interpretation of Risk and Protection

### 7.1 Gradient of the Potential (Risk Vector Field)

Each $\Phi_a(x)$ defines a scalar field on $\mathcal{S}$. Its spatial gradient defines a **vector field**:

$$
\nabla_x \Phi_a(x) = \left(\tfrac{\partial \Phi_a}{\partial x_1},\ldots,\tfrac{\partial \Phi_a}{\partial x_p}\right).
$$

Across treatment, use the finite difference $\Delta_A\Phi(x)=\Phi_1(x)-\Phi_0(x)$.

This **risk-gradient field** encodes:
- directions of maximal risk increase
- local instability structure of the system

**Connection to Cox regression:** In the Cox model, $\log \lambda(s) = \log h_0(t) + \beta' s$.
Since $\Phi = -\log \lambda$, we have $\nabla_x \Phi = -\beta$ (for continuous covariates,
independent of baseline hazard $h_0$). The field framework generalizes this to nonlinear $\Phi(s)$.

---

### 7.2 Directional Effects as Local Geometry

**For continuous treatment** (e.g., dose), an intervention induces a local displacement:

$$
\Delta s = (0,\ldots,0,\Delta a)
$$

The induced change in potential is approximated by:

$$
\Delta \Phi
\approx
\nabla \Phi(s) \cdot \Delta s
$$

**For discrete (binary) treatment**, use the finite difference directly:

$$
\Delta_A \Phi(x) = \Phi_1(x) - \Phi_0(x)
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

## 8. ATE as a First-Order Projection

The primary objects are the regime-specific fields $\Phi_a(x)$ and their contrast $\Delta_A\Phi(x)$.

**For continuous treatment**, a first-order Taylor expansion in $a$ gives:

$$
\Phi(x,1)
\approx
\Phi(x,0)
+
\frac{\partial \Phi(x,a)}{\partial a}\Big|_{a=0}
$$

**For binary treatment** $A \in \{0,1\}$, the effect surface is the finite difference
$\Delta_A\Phi(x)=\Phi_1(x)-\Phi_0(x)$.

Averaging over $X$ yields the ATE:

$$
\text{ATE} = \mathbb{E}_X
\left[\Phi(X,1) - \Phi(X,0)\right]
= \mathbb{E}_X[\Delta_A \Phi(X)]
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
information-preserving summary of the field $\Phi_a(x)$ when effect
heterogeneity is negligible, i.e., $\text{Var}_X[\Delta_A \Phi] \approx 0$.

**Proof sketch:**

**For binary treatment** $A \in \{0, 1\}$:

The treatment effect is exactly the finite difference:

$$
\Delta_A \Phi(x) = \Phi_1(x) - \Phi_0(x)
$$

No Taylor expansion is needed. "Curvature" in this context refers to
**heterogeneity across $x$**, i.e., how much $\Delta_A \Phi(x)$ varies with $x$.

**For continuous/dose treatment** $A \in [0, 1]$:

We can write the effect as an integral:

$$
\Phi_1(x) - \Phi_0(x) = \int_0^1 \frac{\partial \Phi_a}{\partial a}(x, a) \, da
$$

Or via second-order Taylor expansion around $a = 0$:

$$
\Phi_1(x) \approx \Phi_0(x) + \frac{\partial \Phi_a}{\partial a}\Big|_{a=0} + \frac{1}{2} \frac{\partial^2 \Phi_a}{\partial a^2}\Big|_{a=\xi}
$$

where $\xi \in (0, 1)$. The curvature term $\frac{\partial^2 \Phi_a}{\partial a^2}$
captures dose-response nonlinearity.

**Case 1: Homogeneous effects ($\text{Var}_X[\Delta_A \Phi] \approx 0$)**

For binary treatment, $\text{ATE} = \mathbb{E}_X[\Delta_A \Phi(X)]$ holds by definition.
The question is whether this average is **informative**.

When $\Delta_A \Phi(x) \approx c$ (constant across $x$):

$$
\text{ATE} \approx c
$$

ATE is a complete summary—no information is lost.

For continuous treatment, this additionally requires low dose-response
curvature ($\partial^2 \Phi_a / \partial a^2 \approx 0$).

**Case 2: Heterogeneous effects ($\text{Var}_X[\Delta_A \Phi]$ large)**

ATE remains well-defined:

$$
\text{ATE} = \mathbb{E}_X[\Delta_A \Phi(X)]
$$

But it collapses a distribution into a single number, losing information about:
- Where effects are strong vs weak
- Where effects are positive vs negative
- Subpopulation-specific responses

**Case 3: Positivity violation (structural discontinuity)**

When $P(A = 0 \mid X = x) = 0$ for some $x$, the field $\Phi_0(x)$ is
**undefined or inaccessible** in that region.

Attempting to compute:

$$
\text{ATE} = \mathbb{E}[\Phi_0(X) - \Phi_1(X)]
$$

involves integration over regions where $\Phi_0(x)$ does not exist.
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

- Potential-outcome notation is optional; identification still relies on exchangeability and positivity on the target domain
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
| Output | $\tau(x) = \mathbb{E}[Y(1) - Y(0) \mid X=x]$ | $\Phi_a(x)$, $\Delta_A\Phi(x)$, boundaries |
| Positivity violation | Estimation problem (trim, extrapolate) | **Information** (map the boundary) |
| Counterfactuals | Required | Optional notation; assumptions still required |
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

## A1. ATE as a Regime Contrast

$$
\text{ATE} = \mathbb{E}_X\big[\Delta_A\Phi(X)\big] = \mathbb{E}_X\big[\Phi_1(X)-\Phi_0(X)\big].
$$

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
treating $\Phi_a(x)$ as time-invariant for simplicity.

**Structural constraint:** If $X_1 > 160$, then $A = 1$ (mandatory treatment per clinical guideline).

**Heterogeneous effect:** Treatment benefit increases with $X_1$.

**Connection to Cox model:** In the Cox framework, $\log \lambda(s) = \log h_0(t) + \beta' s$,
so $\nabla_x \Phi_a = -\beta$ (independent of $h_0(t)$, for continuous covariates).
Our GAM-based estimation generalizes this to nonlinear $\Phi_a(x)$.

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
| $\Delta_A \Phi$ range | 0.42 – 1.66 | Effect varies 4-fold across state space |
| Gradient direction | Increasing with $X_1$ | Higher BP → larger treatment benefit |
| Structural boundary | $X_1 > 160$ (gray region) | Comparison impossible; all patients treated |

### Key Message

1. **Traditional methods are not wrong:** Cox and IPTW correctly estimate average effects.

2. **But averages hide structure:** The single number (HR = 0.55) does not reveal that treatment benefit varies 4-fold depending on patient state.

3. **Positivity violation is information:** The region $X_1 > 160$ is shown as a gray "no-comparison zone" in the field visualization. This is not a nuisance—it reflects the clinical guideline that mandates treatment for high-risk patients.

4. **Field-based output is a map, not a number:** Instead of asking "what is the effect?", we ask "where is the effect strong, weak, or undefined?"

See `simulation/fig_field_approach.png` for visualization.
