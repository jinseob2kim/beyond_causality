# ==============================================================================
# Project: Beyond Causality - Field Visualization Prototype
# Concept: Visualizing the 'Risk Potential Field' and 'Structural Cliffs'
# ==============================================================================

library(data.table)
library(magrittr)
library(ggplot2)
library(rayshader)
library(viridis)

# 1. [World Building] 상태 공간(State Space) 생성 ------------------------------
# 해상도를 높여서 지형을 부드럽게 만듭니다.
x_seq <- seq(-3, 3, length.out = 200)
y_seq <- seq(-3, 3, length.out = 200)
world <- CJ(x = x_seq, y = y_seq) # data.table cross join

# 2. [Physics] Risk Potential Field (Phi) 정의 ---------------------------------
# 수식 설명:
# - 중앙의 산봉우리 (Peak): 건강하고 안정적인 상태 (높은 Phi)
# - 주변의 깊은 계곡 (Valley): 질병 및 사망 위험 (낮은 Phi)
# - 약간의 노이즈: 현실 데이터의 불확실성 반영

world[, Phi := (2 * exp(-(x^2 + y^2)/2)) -   # Main Health Peak
               (1 * exp(-((x - 1.5)^2 + (y - 1.5)^2)/1)) + # Local Risk Sink
               (0.5 * sin(x * 2) * cos(y * 2))] # Complex Terrain (Heterogeneity)

# 3. [Structural Constraint] The Cliff (Positivity Violation) ------------------
# 특정 조건(예: 고위험군이면서 특정 치료를 받지 못한 영역)은
# 데이터가 아예 존재할 수 없는 '구조적 공백'으로 처리합니다.
# 이 부분은 3D 렌더링 시 "심연(Abyss)"처럼 뚫려 보일 것입니다.

world[x > 1.0 & y < -0.5, Phi := NA] 

# 4. [Rendering] 2D Base Layer (The Map) ---------------------------------------
# Magma 팔레트: 검은색(위험)에서 밝은 노란색(안전)으로 타오르는 느낌
gg_field <- ggplot(world, aes(x, y, fill = Phi)) +
  geom_raster(interpolate = TRUE) +
  scale_fill_viridis_c(option = "magma", na.value = "transparent") +
  labs(title = "The Risk Potential Field",
       subtitle = "Geometric Interpretation of RWD",
       caption = "Height = Safety (Phi) | Void = Structural Constraint") +
  theme_void() + # 축 제거 (순수한 형상만 남김)
  theme(
    plot.background = element_rect(fill = "black", color = NA),
    legend.position = "none",
    plot.title = element_text(color = "white", size = 20, face = "bold", hjust = 0.5),
    plot.subtitle = element_text(color = "grey80", size = 12, hjust = 0.5),
    plot.caption = element_text(color = "grey60", size = 10, hjust = 0.9)
  )

# 5. [Ascension] 3D Projection (The Field) -------------------------------------
# 2D 플롯을 3차원 객체로 변환합니다.

plot_gg(gg_field, 
        width = 6, height = 6, 
        multicore = TRUE, 
        scale = 250,        # 지형의 높이 과장 (드라마틱한 효과)
        zoom = 0.55,        # 줌 레벨
        theta = 45,         # 회전 각도 (가로)
        phi = 30,           # 회전 각도 (세로)
        windowsize = c(1000, 1000),
        sunangle = 225,     # 빛의 방향 (오후의 햇살)
        shadow_intensity = 0.7, # 그림자 강도
        background = "black" # 우주 같은 검은 배경
)

# 6. [Cinematography] 카메라 무빙 (Optional) -----------------------------------
# 이 코드를 실행하면 마우스로 돌려볼 수 있는 창이 뜹니다.
# 렌더링이 완료된 후 아래 코드로 고화질 스냅샷을 찍을 수 있습니다.

# render_snapshot(filename = "Risk_Field_Paradigm.png", clear = TRUE)

# 만약 회전하는 영상을 만들고 싶다면:
# render_movie(filename = "Risk_Field_Rotation.mp4", type = "oscillate", 
#              frames = 360, phi = 30, theta = 45)
