# Beyond Causal Inference?
## A Field-Based Framework for Real-World Epidemiology

> TL;DR
> - Standard causal inference is powerful but structurally strained in RWD
> - Positivity violation is a symptom, not the root problem
> - Deeper fractures involve intervention identity, dynamics, counterfactual existence, and observer dependence
> - We propose a field-based, state-space framework
> - Classical causal estimands emerge as projections of the field, not primitive objects

---

## 1. Dissatisfaction with Causal Inference
### — The Newtonian Feeling

Modern epidemiologic causal inference typically asks:

    "What is the causal effect of intervention A on outcome Y?"

Formally:

    Effect = E[Y(1) - Y(0)]

This framing is highly effective in randomized controlled trials.
However, in real-world data (RWD), it increasingly resembles a
Newtonian force-based intuition:.

```text
(A) Causal inference view (force-based)

A = 0 --------------------> Y(0)
|
| causal effect
v
A = 1 --------------------> Y(1)

Effect = E[Y(1) - Y(0)]
```

Here, intervention A is treated as an external force acting on a system.

In RWD, this intuition becomes strained:

- States are high-dimensional and time-varying
- Interventions arise from system rules, guidelines, and feedback
- Treatment and state co-evolve dynamically

Yet the question remains force-based.

---

## 2. An Einsteinian Analogy
### — From Force to Field

Einstein did not ask:
    "What force causes gravity?"

He asked:
    "Why do objects follow these paths?"

Gravity was reinterpreted as curvature of spacetime.
Objects do not respond to force; they follow geodesics.

We propose an analogous shift in epidemiology:

- Causal effects are not forces
- They are consequences of a risk / transition field
- Interventions move systems within the field rather than directly producing outcomes

---

## 3. Positivity Is a Warning Light, Not the Core Problem

### 3.1 Positivity / Overlap (Standard Form)

For treatment A in {0,1} and covariates X:

    0 < P(A = 1 | X = x) < 1

for all x with positive density.

In RWD, this assumption frequently fails due to:
- clinical guidelines
- contraindications
- policy constraints
- time-varying decision rules

The usual responses include:
- trimming
- weight truncation
- redefining estimands

---

### 3.2 Interpretation

Positivity violation is not the fundamental failure.
It is the earliest visible symptom of a deeper mismatch.

It signals that:

    "This causal question may not exist on this state space."

---

## 4. Deeper Fractures Beyond Positivity

### 4.1 Instability of Intervention Identity

Causal inference assumes:

    "A is a well-defined, repeatable object."

In RWD:
- same drug ≠ same exposure
- same surgery ≠ same procedure
- same policy ≠ same mechanism

Thus:

    A ≠ A

This is not measurement error.
It is conceptual instability.

---

### 4.2 Dynamics and Mutual Construction

Real systems evolve as:

    X_t -> A_t -> X_{t+1} -> A_{t+1} -> ...

Treatment and state recursively define each other.

Marginal structural models attempt adjustment,
but still assume meaningful counterfactual trajectories exist.

That assumption itself becomes questionable.

---

### 4.3 Non-Existence of Counterfactuals

In RWD, some counterfactuals are not unobserved,
but impossible:

- ethically forbidden
- systemically disallowed
- structurally unreachable

This is not missing data.
It is non-existence.

---

### 4.4 Observer Dependence

Risk scores, prediction models, guidelines, and publications
alter future data generation.

The analyst is not external to the system.

    Observation -> system update -> new observations

Observer independence quietly collapses.

---

## 5. A Shift in the Question

From:

    "What is the causal effect of A on Y?"

To:

    "How are risk and transition structured across the state space?"

---

## 6. Field-Based Framework

### 6.1 State Space

Define the system state as:

    S_t = (X_t, A_t)

Treatment is a coordinate of the system,
not an external action.

---

### 6.2 Risk Field

Define a risk field over the state space:

    lambda(s) = instantaneous risk density at state s

This can be estimated via:
- Cox models
- Poisson models
- spline hazards
- neural hazard models

Interpretation differs:
- Not "treatment effect"
- But "local risk geometry"

---

### 6.3 Transition Field

Define a transition kernel:

    P(S_{t+1} = s' | S_t = s) = K(s, s')

This kernel describes system dynamics.
Zero-probability regions are meaningful, not violations.

---

### 6.4 Intervention Reinterpreted

Instead of:

    do(A = a)

We define intervention as:

    A : s -> s'

An operator that moves the system within the field.

---

## 7. Potential Function Phi(s)
### — Information-Geometric Interpretation

Define a potential function over the state space:

    Phi(s) = - log lambda(s)

or more generally:

    Phi(s) = information cost / entropy density at s

Properties:
- High risk regions correspond to low potential
- System trajectories flow toward lower Phi
- Events concentrate where Phi gradients are steep

This mirrors:
- free energy in physics
- surprisal in information theory

---

## 8. Where Classical Causal Estimands Come From
### — Projection, Not Foundation

Classical causal estimands emerge as projections of the field.

The average treatment effect (ATE) corresponds to:

    A contrast between two slices of the field at A = 1 and A = 0,
    averaged over the covariate distribution.

In other words:

- Fix the state distribution
- Compare Phi(s) or lambda(s) across treatment coordinates
- Average the contrast

Thus:

    ATE = coarse projection of a high-dimensional geometry

It is not fundamental.
It is a summary.

---

## 9. Why This Matters

- Positivity violations become structural features, not failures
- Non-existent counterfactuals are no longer required
- Observer feedback is naturally included
- Average effects are optional, not mandatory

Causal inference is not wrong.
It is a special coordinate system.

---

## 10. Closing Analogy

Newton was not wrong.
Einstein changed the coordinate system.

Causal inference is Newtonian.
Real-world epidemiology may require curvature.
