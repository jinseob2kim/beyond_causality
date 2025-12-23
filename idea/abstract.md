# Beyond Causal Inference?
## A Field-Based Framework for Epidemiology with Real-World Data

---

## Abstract

Causal inference has become the dominant framework for analyzing real-world data (RWD) in epidemiology, enabling principled estimation of treatment effects from observational settings. However, repeated structural difficulties—such as positivity violations, unstable interventions, and feedback between analysis and data generation—suggest deeper tensions between standard causal assumptions and the nature of real-world systems.

We argue that these issues are not merely technical failures but symptoms of a force-based causal framing inherited from intervention-centric thinking. Inspired by the transition from Newtonian force models to Einsteinian field-based descriptions in physics, we propose a complementary perspective: describing epidemiologic systems through state-space dynamics and risk fields rather than counterfactual causal effects.

This framework does not replace causal inference but offers a coordinate system better aligned with high-dimensional, time-varying, observer-including real-world data environments.

---

## 1. Introduction

### 1.1 The success and limits of causal inference

Modern epidemiology has been profoundly shaped by causal inference. Methods based on potential outcomes, counterfactual reasoning, and causal diagrams have enabled rigorous estimation of treatment effects from observational data, particularly when randomized controlled trials are infeasible.

In idealized settings, causal questions are framed as:

> What is the causal effect of intervention A on outcome Y?

Formally, this is expressed as a contrast between potential outcomes:

$$
\tau = E[Y(1) - Y(0)]
$$

When supported by randomization or strong identifying assumptions, this estimand is both meaningful and operational.

However, as causal inference has been increasingly applied to real-world data such as electronic health records, claims data, and registries, systematic tensions have emerged.

---

### 1.2 A Newtonian intuition in causal reasoning

At a conceptual level, standard causal framing implicitly treats interventions as external forces acting upon a system.

This intuition is often visualized as follows.

```text
(A) Causal inference view (force-based)

A = 0 --------------------> Y(0)
|
| causal effect
v
A = 1 --------------------> Y(1)

Effect = E[Y(1) - Y(0)]
```


This representation suggests:

- Interventions are well-defined and repeatable objects
- Potential outcomes are simultaneously well-defined
- Effects arise from switching the level of an intervention, analogous to applying a force

While powerful, this framing may be mismatched to systems in which interventions are endogenous, adaptive, and inseparable from system state.

---

## 2. Positivity as a symptom, not the disease

### 2.1 The positivity (overlap) assumption

For a binary treatment A in {0,1} and covariates X, causal identification requires:

$$
0 < P(A = 1 \mid X = x) < 1 \quad \forall x \text{ with } P(X = x) > 0
$$

In real-world data, this condition is frequently violated due to:

- Clinical guidelines and contraindications
- Institutional and policy constraints
- Time-varying disease severity
- Physician and system-level decision rules

The resulting issues—extreme propensity scores, unstable inverse weights, and trimming—are well documented.

---

### 2.2 Why positivity violations persist

We argue that positivity violations are not merely technical nuisances but early warning signals.

They indicate that the causal question being asked may not be well-defined on the observed state space. In many real-world settings, certain counterfactuals are not just unobserved but structurally non-existent.

---

## 3. Deeper fractures beyond positivity

### 3.1 Instability of interventions

Causal inference presumes that intervention A is a stable, well-defined entity.

In practice:

- The same drug differs by dose, timing, sequencing, and co-administration
- The same procedure differs by provider, institution, and context

Formally:

$$
A \neq A
$$

This is not measurement error but ontological instability.

---

### 3.2 Time, feedback, and system dynamics

Real-world systems evolve as:

$$
X_t \rightarrow A_t \rightarrow X_{t+1} \rightarrow A_{t+1} \rightarrow \dots
$$

Treatment decisions both depend on and reshape the state space.

Even advanced causal tools such as marginal structural models retain reliance on well-defined counterfactual trajectories, an assumption that may fail in adaptive systems.

---

### 3.3 Observer inclusion

Risk scores, prediction models, published evidence, and policy recommendations feed back into clinical decision-making.

As a result, the data-generating process evolves as:

$$
S_{t+1} = M(S_t)
$$

The observer is not external to the system but part of its dynamics.

---

## 4. A shift in perspective: from effects to fields

### 4.1 An Einsteinian analogy

Einstein did not ask what force gravity exerted. He asked why objects followed the paths they did.

Gravity became geometry, a property of spacetime itself.

Analogously, instead of asking:

> What is the causal effect of A on Y?

we ask:

> How are risk and transitions organized across the state space?

---

## 5. A field-based epidemiologic framework

### 5.1 State space

Define the system state as:

$$
S_t = (X_t, A_t)
$$

---

### 5.2 Risk field

Define a risk density over the state space:

$$
\lambda(s) \ge 0
$$

This field characterizes how adverse events concentrate across states, without invoking counterfactual contrasts.

---

### 5.3 Transition dynamics

System evolution is governed by a transition kernel:

$$
P(S_{t+1} \mid S_t) = K(S_t)
$$

---

### 5.4 Interventions as operators

Interventions are not forces but state relocation operators:

$$
A : s \mapsto s'
$$

Their impact is evaluated via changes in potential-like quantities:

$$
\Delta \Phi = \Phi(s') - \Phi(s)
$$

rather than contrasts between unrealized counterfactual worlds.

---

## 6. Why this framework aligns with real-world data

- Positivity breakdowns become structural features rather than failures
- Non-existent counterfactuals are no longer required
- Feedback and adaptation are naturally represented
- Geometry and topology of risk replace average effect summaries

This framework complements causal inference by providing a coordinate system better aligned with real-world complexity.

---

## 7. Conclusion

Causal inference remains indispensable, but its force-based intuition may be ill-suited for all settings.

For real-world data, a field-based description of state-space dynamics may provide a more faithful representation of how risk, decisions, and outcomes co-evolve.

Newton was not wrong.  
Einstein changed the coordinate system.


