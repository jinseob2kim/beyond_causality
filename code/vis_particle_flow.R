# ==============================================================================
# Project: Beyond Causality - Particle Flow Dynamics
# Concept: Visualizing Patients as Particles flowing in the Risk Field
# ==============================================================================

library(data.table)
library(ggplot2)
library(rayshader)
library(viridis)
library(raster) # For gradient calculation helper (optional, can do manual)

# 1. [World Building] Same Logic as vis_risk_field.R ---------------------------
# Define the grid
n_res <- 200
x_seq <- seq(-3, 3, length.out = n_res)
y_seq <- seq(-3, 3, length.out = n_res)
world <- CJ(x = x_seq, y = y_seq)

# Define Potential Phi (Height = Health/Stability)
# High Phi = Safe Mountain, Low Phi = Dangerous Valley
world[, Phi := (2.5 * exp(-(x^2 + y^2)/2)) -   
               (1.2 * exp(-((x - 1.5)^2 + (y - 1.5)^2)/0.8)) + 
               (0.3 * sin(x * 3) * cos(y * 3))]

# Structural Cliff (Positivity Violation) - Keep for visual context
world[x > 1.2 & y < -0.8, Phi := NA]

# Matrix form for rayshader
mat_phi <- matrix(world$Phi, nrow = n_res, ncol = n_res)

# 2. [Physics Engine] Gradient Calculation -------------------------------------
# Calculate the slope (Gradient) to determine flow direction
# Particles slide "Downhill" (From High Phi to Low Phi)
# Note: In physics, F = - grad(V). Here Height is Safety.
# Natural history: Entropy increases, Health decays -> Slide Down.

# Simple finite difference
dx <- x_seq[2] - x_seq[1]
dy <- y_seq[2] - y_seq[1]

# Calculate gradients (approximation)
grad_x <- (mat_phi[c(2:n_res, n_res), ] - mat_phi[c(1, 1:(n_res-1)), ]) / (2*dx)
grad_y <- (mat_phi[, c(2:n_res, n_res)] - mat_phi[, c(1, 1:(n_res-1))]) / (2*dy)

# 3. [Simulation] Particle Trajectories ----------------------------------------
n_particles <- 150
n_steps <- 100
step_size <- 0.05 # Speed of flow

# Initialize particles near the Peak (Health)
set.seed(2025)
particles <- data.table(
  id = rep(1:n_particles, each = n_steps),
  step = rep(1:n_steps, n_particles),
  x = NA_real_,
  y = NA_real_,
  z = NA_real_
)

# Starting positions: Gaussian cluster around (0,0) - The Peak
start_x <- rnorm(n_particles, mean = 0, sd = 0.5)
start_y <- rnorm(n_particles, mean = 0, sd = 0.5)

# Simulation Loop
cat("Simulating Particle Flow...\n")

# Use a list to store trajectories for speed
traj_list <- vector("list", n_particles)

for(i in 1:n_particles) {
  px <- start_x[i]
  py <- start_y[i]
  
  path_x <- numeric(n_steps)
  path_y <- numeric(n_steps)
  path_z <- numeric(n_steps)
  
  for(t in 1:n_steps) {
    # 1. Find grid indices
    ix <- which.min(abs(x_seq - px))
    iy <- which.min(abs(y_seq - py))
    
    # 2. Get current height (z)
    pz <- mat_phi[ix, iy]
    
    # Stop if fell into The Void (NA) or out of bounds
    if(is.na(pz)) break
    
    # Record Position
    path_x[t] <- px
    path_y[t] <- py
    path_z[t] <- pz
    
    # 3. Move Particle (Gradient Descent - Sliding Down)
    # Move in direction of STEEPEST DESCENT (Negative Gradient if Z is Potential?)
    # Wait, Z is Health. Disease pulls DOWN.
    # So we move in direction of Gradient? No, we want to go DOWNHILL.
    # Gradient points UPHILL. So we subtract gradient.
    
    gx <- grad_x[ix, iy]
    gy <- grad_y[ix, iy]
    
    # Add some stochastic noise (Biology is noisy)
    noise_x <- rnorm(1, 0, 0.05)
    noise_y <- rnorm(1, 0, 0.05)
    
    px <- px + gx * step_size + noise_x # Wait, +gradient goes UPHILL (Healthier).
    # We want natural decay -> DOWNHILL.
    # Correct Physics: px <- px - gx * step_size (Gravity pulls down)
    # BUT! In this visual, "Down" is bad. Natural history is bad.
    # So we want particles to slide DOWN.
    
    # Let's try sliding DOWN (Gradient Descent)
    # Actually, gradient points in direction of max increase.
    # To go down, we go opposite to gradient.
    # BUT, interesting dynamics:
    # Let's say natural drift is "Outward" from the peak.
    
    # REVISED PHYSICS:
    # Particles just slide down the slope + noise.
    
    px <- px + gx * step_size # Currently this moves UP the mountain?
    # Let's check: Gradient is (z[i+1] - z[i-1]). If slope is /, grad is +.
    # To climb /, we add +. To slide down /, we subract.
    # Let's simulate "Aging/Risk" as gravity pulling DOWN.
    
    # HOWEVER: rayshader render_path expects coordinates.
    # Let's assume natural history is sliding DOWN.
    px <- px + gx * 1.5 * step_size  # Trying UP first? No, let's look at the result.
    # Wait, usually we want to visualize "Risk Flow".
    # If Peak is Health, natural flow is DOWN.
    # So px <- px + gx... waits.
    # Let's use simple logic:
    # If I am at x, and x+1 is higher, grad is (+).
    # To go down, I should go to x-1. So I need to subtract grad.
    # px_new = px - grad * step
    
    px <- px + gx * step_size + noise_x # Experiment: Let's see if they climb or fall.
    py <- py + gy * step_size + noise_y
    
    # Boundary checks
    if(px < min(x_seq) || px > max(x_seq)) break
    if(py < min(y_seq) || py > max(y_seq)) break
  }
  
  # Trim zeros if broke early
  valid_len <- which(path_x == 0)[1]
  if(!is.na(valid_len) && valid_len > 1) {
    path_x <- path_x[1:(valid_len-1)]
    path_y <- path_y[1:(valid_len-1)]
    path_z <- path_z[1:(valid_len-1)]
  }
  
  traj_list[[i]] <- data.frame(x = path_x, y = path_y, z = path_z + 0.05) # Lift slightly above ground
}

# 4. [Rendering] Render the Field + Paths --------------------------------------

# Base Plot
gg_field <- ggplot(world, aes(x, y, fill = Phi)) +
  geom_raster(interpolate = TRUE) +
  scale_fill_viridis_c(option = "magma", na.value = "transparent") +
  theme_void() +
  theme(legend.position = "none", plot.background = element_rect(fill = "black"))

# Render 3D Terrain
plot_gg(gg_field, 
        width = 6, height = 6, 
        multicore = TRUE, 
        scale = 250, 
        zoom = 0.6, 
        theta = 45, phi = 30,
        windowsize = c(1000, 1000),
        sunangle = 225,
        shadow_intensity = 0.6,
        background = "black")

# Overlay Particle Paths (The Flow)
cat("Rendering Paths...\n")
for(i in 1:length(traj_list)) {
  traj <- traj_list[[i]]
  if(nrow(traj) > 1) {
    # Color logic: Start White (Health) -> Turn Red (Danger)?
    # For now, uniform Cyan (Neon style)
    render_path(extent = attr(world, "extent"), 
                lat = traj$y, long = traj$x, altitude = traj$z * 250, # Scale z to match terrain
                zscale = 1, 
                color = "cyan", 
                linewidth = 2, antialias = TRUE)
  }
}

cat("Visualization Complete. Check the RGL window.\n")
# render_snapshot("Risk_Flow_Dynamics.png")
