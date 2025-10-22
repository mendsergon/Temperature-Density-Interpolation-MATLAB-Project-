## Temperature-Density Interpolation (MATLAB Project)

### Project Summary

This MATLAB script estimates the density of a gas at a target temperature using various **interpolation methods**. It applies **Lagrange interpolation**, **polynomial fitting**, and **cubic spline interpolation** to a set of temperature-density data. The script also demonstrates **extrapolation** and compares results visually.

---

### Core Features

* Interpolates density at 330 K using Lagrange polynomials of degree 1, 3, and 5.
* Uses `polyfit` for polynomial fitting with scaled temperatures to improve numerical stability.
* Applies cubic spline interpolation for smooth density estimation.
* Performs extrapolation at 600 K using the spline method.
* Generates a plot comparing data points, Lagrange, polynomial fit, and spline curves.
* Prints numerical results for all methods in the console.

---

### Key Methods and Algorithms

* **Lagrange Interpolation:** Computes interpolating polynomials for different degrees to evaluate the target temperature.
* **Polynomial Fitting (`polyfit`):** Fits polynomials to scaled data to reduce numerical errors and evaluates at the target.
* **Cubic Spline Interpolation (`spline`):** Provides smooth interpolation across all data points and allows extrapolation.
* **Data Scaling:** Standardizes temperature values for polynomial fitting to avoid ill-conditioned matrices.
* **Visualization:** Plots original data, interpolated points, and spline curve for easy comparison.

---

### Skills Demonstrated

* Application of **numerical interpolation methods** in MATLAB.
* Polynomial fitting and handling of **ill-conditioned problems**.
* Use of cubic spline for smooth interpolation and extrapolation.
* MATLAB plotting and data visualization.
* Comparison of different interpolation techniques for accuracy assessment.

---

### File Overview

| File Name                  | Description                                          |
| -------------------------- | ---------------------------------------------------- |
| **interpolation_script.m** | MATLAB script performing interpolation and plotting. |

---

### How to Run

1. Open MATLAB and place the script in the working folder.
2. Run the script:

```matlab
interpolation_script
```

3. Observe console outputs for interpolated and extrapolated densities.
4. View the generated plot to compare methods visually.

---
