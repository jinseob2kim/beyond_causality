# =============================================================================
# Project: Epidynamix
# 기존 방법 vs Field-based 비교 (v2: 명확한 structural boundary)
# =============================================================================

library(data.table)
library(ggplot2)
library(survival)
library(mgcv)
library(patchwork)

set.seed(42)

N <- 3000
BOUNDARY <- 160  # Structural cut

dt <- data.table(
  id = 1:N,
  X1 = runif(N, 100, 200),
  X2 = runif(N, 0, 10)
)

# Treatment: X1 > 160이면 무조건 A=1 (structural)
dt[, ps_true := fifelse(X1 > BOUNDARY, 1.0, plogis(-3 + 0.02 * X1 + 0.15 * X2))]
dt[, A := fifelse(X1 > BOUNDARY, 1L, rbinom(.N, 1, ps_true))]

# 확인
cat("=== Structural Constraint 확인 ===\n")
cat("X1 >", BOUNDARY, "에서 A=0:", sum(dt[X1 > BOUNDARY, A == 0]), "명 (0이어야 함)\n\n")

# Hazard with heterogeneous treatment effect
dt[, log_hazard := -2 + 0.02 * (X1 - 100) + 0.1 * X2 -
     A * (0.3 + 0.015 * pmax(X1 - 120, 0))]
dt[, hazard := exp(log_hazard)]
dt[, Phi_true := -log_hazard]

# Survival time
dt[, time := rexp(.N, rate = hazard)]
dt[, time := pmin(time, 5)]
dt[, event := as.integer(time < 5)]

# =============================================================================
# 기존 방법들
# =============================================================================

cat("=== Cox Model ===\n")
cox_model <- coxph(Surv(time, event) ~ A + X1 + X2, data = dt)
hr <- exp(coef(cox_model)["A"])
cat("HR:", round(hr, 3), "\n\n")

cat("=== IPTW ===\n")
ps_model <- glm(A ~ X1 + X2, data = dt, family = binomial)
dt[, ps_est := predict(ps_model, type = "response")]
dt[, w := fifelse(A == 1, 1/ps_est, 1/(1-ps_est))]
dt[, surv_1yr := as.integer(time > 1)]
ate <- weighted.mean(dt[A==1, surv_1yr], dt[A==1, w]) -
       weighted.mean(dt[A==0, surv_1yr], dt[A==0, w])
cat("ATE:", round(ate, 3), "\n\n")

# =============================================================================
# Field-based: 영역 분리해서 추정
# =============================================================================

cat("=== Field-based ===\n")

dt[, pseudo_hazard := event / pmax(time, 0.1)]
dt[, log_pseudo_hazard := log(pseudo_hazard + 0.01)]

# A=0 추정 (X1 <= 160만)
gam_A0 <- gam(log_pseudo_hazard ~ s(X1, X2, k = 15),
              data = dt[A == 0], method = "REML")

# A=1 추정 (전체)
gam_A1 <- gam(log_pseudo_hazard ~ s(X1, X2, k = 15),
              data = dt[A == 1], method = "REML")

# Grid (X1 <= 160만 유효)
grid <- CJ(X1 = seq(102, 195, by = 3), X2 = seq(0.5, 9.5, by = 0.5))
grid[, valid := X1 <= BOUNDARY]  # 비교 가능 영역

grid[, log_h_A0 := predict(gam_A0, newdata = .SD)]
grid[, log_h_A1 := predict(gam_A1, newdata = .SD)]
grid[, Phi_A0 := -log_h_A0]
grid[, Phi_A1 := -log_h_A1]
grid[, delta_Phi := Phi_A1 - Phi_A0]

# 비교 불가 영역 처리
grid[valid == FALSE, delta_Phi := NA]

cat("Effect range (valid region):",
    round(min(grid[valid == TRUE, delta_Phi], na.rm=T), 2), "~",
    round(max(grid[valid == TRUE, delta_Phi], na.rm=T), 2), "\n\n")

# =============================================================================
# 시각화: 2패널만
# =============================================================================

theme_clean <- theme_minimal(base_size = 13) +
  theme(
    plot.title = element_text(face = "bold", size = 13),
    plot.subtitle = element_text(size = 10, color = "gray30"),
    legend.position = "right",
    panel.grid.minor = element_blank()
  )

# Panel A: Treatment Effect Field (with masked region)
p1 <- ggplot(grid, aes(X1, X2)) +
  # 유효 영역
  geom_tile(data = grid[valid == TRUE], aes(fill = delta_Phi)) +
  scale_fill_gradient2(low = "white", high = "darkgreen",
                       midpoint = median(grid[valid == TRUE, delta_Phi]),
                       na.value = "gray80") +
  # 비교 불가 영역 (회색)
  geom_tile(data = grid[valid == FALSE], fill = "gray80") +
  # 경계선
  geom_vline(xintercept = BOUNDARY, linetype = "solid", color = "red", linewidth = 1) +
  annotate("text", x = BOUNDARY + 2, y = 8.5,
           label = "No comparison\npossible\n(all treated)",
           hjust = 0, size = 3, color = "gray30") +
  labs(
    title = "Treatment Effect Field",
    subtitle = paste0("Cox HR = ", round(hr, 2), " / IPTW ATE = ", round(ate, 2), " (single numbers) vs Field shows structure"),
    x = "SBP (X1)", y = "CRP (X2)",
    fill = expression(delta[A]*Phi)
  ) +
  theme_clean

# Panel B: Effect by X1 (valid region only)
dt_valid <- dt[X1 <= BOUNDARY]
dt_valid[, ITE_est := predict(gam_A1, newdata = dt_valid) - predict(gam_A0, newdata = dt_valid)]

p2 <- ggplot(dt_valid, aes(x = X1, y = -ITE_est)) +  # 부호 맞춤
  geom_point(alpha = 0.2, color = "steelblue", size = 0.8) +
  geom_smooth(method = "loess", color = "red", linewidth = 1, se = FALSE) +
  geom_vline(xintercept = BOUNDARY, linetype = "solid", color = "red", linewidth = 1) +
  annotate("rect", xmin = BOUNDARY, xmax = 200, ymin = -Inf, ymax = Inf,
           fill = "gray80", alpha = 0.8) +
  annotate("text", x = BOUNDARY + 2, y = max(-dt_valid$ITE_est) * 0.8,
           label = "Positivity\nviolation",
           hjust = 0, size = 3.5, color = "gray30") +
  labs(
    title = "Effect Gradient by SBP",
    subtitle = "Treatment benefit increases with blood pressure",
    x = "SBP (X1)", y = expression(delta[A]*Phi ~ "(treatment benefit)")
  ) +
  theme_clean

combined <- p1 / p2 +
  plot_annotation(
    title = "Field-Based Approach: Structure Beyond Average Effects",
    theme = theme(plot.title = element_text(size = 15, face = "bold"))
  )

ggsave("simulation/fig_field_approach.png", combined, width = 10, height = 9, dpi = 300)

cat("=== 결론 ===\n")
cat("1. Cox/IPTW: 숫자 하나 (HR=", round(hr,2), ", ATE=", round(ate,2), ")\n")
cat("2. Field: 효과 범위 + 경계 시각화\n")
cat("3. X1 > 160: 회색 = 비교 불가 (structural)\n\n")
cat("Figure saved: simulation/fig_field_approach.png\n")
