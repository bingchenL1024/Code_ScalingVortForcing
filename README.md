# Code_ScalingVortForcing

MATLAB analysis and plotting code for the paper:  
**"Scaling of Stochastic Wave Breaking Vorticity Forcing in the Surf Zone"**  
*Bingchen Liu (2024–2025)*

---

## Overview

This repository contains code to analyze and visualize results from a suite of RIPX spectral wave model simulations. The main scientific goal is to derive non-dimensional scaling laws for the statistics of the curl of the wave-breaking radiation-stress forcing (∇×**F**_br), which drives low-frequency vorticity (e.g., rip currents) in the surf zone.

The model ensemble covers:
- **Beach slopes**: β = 0.02, 0.03, 0.04
- **Directional spread**: σ_θ ranging from ~2.5° to 20°
- **24 wave-condition runs per slope** (120 runs total)

Two complementary representations of the forcing are analyzed:
1. **S(ky)** – alongshore wavenumber spectrum of ∇×**F**_br, characterized by its peak amplitude G₀ and peak wavenumber k_y0.
2. **C(x, t)** – space-time cross-correlation function, characterized by a decorrelation time scale τ.

---

## Repository Structure

```
Code_ScalingVortForcing/
├── analysis_code/
│   ├── analysis_directory.m          # Master script: runs all analyses in order
│   ├── Sky/                          # Wavenumber-spectral analysis
│   │   ├── get_rmse_diffWBexpo.m     # Select optimal Weibull fit exponent
│   │   ├── get_Sky_weibul_fits_log_BL_testexp_10loc.m  # Test-exponent Weibull fits
│   │   ├── get_Sky_weibul_fits_log_BL_10loc.m          # Final Weibull fits to S(ky)
│   │   ├── get_weibul_qced_10loc.m   # Quality-control the Weibull fits
│   │   ├── get_nond_spectra_10loc.m  # Compute non-dimensional S(ky)
│   │   ├── get_nond_binmean_spectra_10loc.m  # Bin-mean non-dimensional spectra
│   │   ├── get_SS_ds_10loc.m         # Extract wave/beach parameters at 10 locations
│   │   ├── get_data_qc_G0nond.m      # QC and compute non-dimensional G₀
│   │   ├── get_plotready_G0nond_10loc.m   # Prepare G₀ data for plotting
│   │   └── get_plotready_ky0nond_10loc.m  # Prepare k_y0 data for plotting
│   └── CXT/                          # Space-time correlation analysis
│       ├── get_cxt_ind_good.m        # QC: select valid cross-shore locations
│       ├── get_CXT_qced.m            # Apply 95% significance threshold to C(x,t)
│       ├── get_4panel_cxtatx.m       # Compute C(x,t) along cross-shore transects
│       ├── get_cxt_alongct_nointerp_max_dxwidth.m  # C(x,t) along contours
│       ├── get_cxt_fit_nointerp_max_dxwidth.m      # Fit exponential decay to C(x,t)
│       ├── get_CXT_scaling2fit.m     # Compute time scales and add to fit parameters
│       ├── get_cxt_5loc.m            # Extract fit parameters at 5 key locations
│       ├── get_cxt_fitanalysis_max_dxwidth.m  # Collate and analyse τ fits
│       └── get_cxt_dxwidth_analysis.m         # Sensitivity to spatial window width
└── plot_code/                        # Scripts that generate paper figures (PDFs)
    ├── plot_paperfig2_8panel.m       # Fig. 2: Hs, std(ω), std(∇×F_br), bathymetry
    ├── plot_paperfig3_Sky.m          # Fig. 3: S(ky) spectra
    ├── plot_paperfig_C_T_andfit_5loc.m        # C(T) and exponential fits
    ├── plot_paperfig_Skyvarcompare.m          # S(ky) variance comparison
    ├── plot_paperfig_cxt_andfit.m             # C(x,t) and fits
    ├── plot_paperfig_cxt_c_compare.m          # C(x,t) speed comparison
    ├── plot_paperfig_cxt_dtdx_4panels.m       # C(x,t) 4-panel summary
    ├── plot_paperfig_exampleF_2panel.m        # Example forcing 2-panel
    ├── plot_paperfig_example_forcing.m        # Example ∇×F_br snapshot
    ├── plot_paperfig_fitpara_dim.m            # Dimensional G₀ and k_y0 vs σ_θ
    ├── plot_paperfig_forcing_detail.m         # Forcing detail
    ├── plot_paperfig_one2one_G0_ky0.m        # One-to-one comparison plots
    ├── plot_paperfig_scal_nond.m              # Non-dimensional G₀ and k_y0 scaling
    ├── plot_paperfig_tau_dist.m               # Distribution of τ
    ├── plot_paperfig_tau_nond.m               # Non-dimensional τ scaling
    ├── plot_paperfig_timestack.m              # Time-stack of ∇×F_br
    ├── plot_rmseVSexpo.m                      # RMSE vs Weibull exponent
    └── plot_snap2d_vort_curlF.m              # 2-D snapshots of vorticity and ∇×F_br
```

---

## Usage

All analyses are designed to be run in the order specified in `analysis_code/analysis_directory.m`. The recommended workflow is:

### 1. Set up paths
Edit `analysis_directory.m` (and individual scripts) to point to your local copies of the RIPX model output and helper-function directories. The scripts currently assume data and helper functions reside under `/data1/bliu/` and `/data1/nkumar/RIPX/`.

### 2. Run the spectral (Sky) analysis
```matlab
% From analysis_directory.m – Sky section:
expo = 1.4;                                        % Weibull exponent
get_Sky_weibul_fits_log_BL_testexp_10loc           % test exponent choice
get_weibul_qced_10loc                              % QC fits
get_nond_spectra_10loc                             % non-dimensional spectra
get_nond_binmean_spectra_10loc                     % bin-mean spectra

get_Sky_weibul_fits_log_BL_10loc                   % final Weibull fits
get_SS_ds_10loc
get_data_qc_G0nond
get_plotready_G0nond_10loc
get_plotready_ky0nond_10loc
```

### 3. Run the space-time correlation (CXT) analysis
```matlab
% From analysis_directory.m – CXT section:
get_cxt_ind_good
get_CXT_qced
get_4panel_cxtatx
get_cxt_alongct_nointerp_max_dxwidth
get_cxt_fit_nointerp_max_dxwidth
get_CXT_scaling2fit
get_cxt_5loc
get_cxt_fitanalysis_max_dxwidth
get_cxt_dxwidth_analysis
```

### 4. Generate paper figures
Run the desired script from `plot_code/`, e.g.:
```matlab
plot_paperfig_scal_nond      % non-dimensional G₀ and k_y0 scaling figure
plot_paperfig_tau_nond       % non-dimensional τ scaling figure
```
Figures are saved as PDF files to the path specified inside each script (currently `/data1/bliu/vortpaper/`).

---

## Key Variables

| Symbol | Description |
|--------|-------------|
| ∇×**F**_br | Curl of the wave-breaking radiation-stress force (vorticity forcing) |
| S(ky) | Alongshore wavenumber spectrum of ∇×**F**_br |
| G₀ | Peak value of S(ky); controls forcing amplitude |
| k_y0 | Peak alongshore wavenumber of S(ky) |
| τ | Decorrelation time scale from the C(x,t) exponential fit |
| β | Beach slope |
| σ_θ | Directional spread of incident waves at the breakpoint |
| h_b | Water depth at the breakpoint |
| H_sb | Significant wave height at the breakpoint |
| L_sz | Cross-shore surf-zone width |
| Ir_b | Iribarren number at the breakpoint |

---

## Dependencies

- **MATLAB** (R2022a or later recommended)
- [**RIPX model output**](https://github.com/nkumar0101/RIPX) – 120 spectral wave model runs (`qa_qc_RIPX_NK.mat`, `RIPX_bath_guide.mat`, etc.)
- **cmocean** colormap toolbox (for diverging/sequential colormaps in figures)
- Internal helper functions (expected on the MATLAB path):
  - `get_sampled_ripx_spread_index` – maps wave-condition parameters to RIPX run indices
  - `load_RIPX_curlF_Sky` – loads pre-computed S(ky) fields
  - `get_10locs` – returns indices of 10 standard cross-shore locations
  - `interpSky` – truncates and log-interpolates S(ky)
  - `rayleigh_fitAS2` – fits a Weibull distribution in log space
  - `falk_skill`, `wilmot_skill` – skill score functions
  - `get_wavenum` – linear dispersion relation solver
  - `niceplot_nobold`, `niceplot_nobold_nomintick` – figure formatting helpers
  - `bin_mean_taunondVSxnond` – bin-averaging helper for τ plots

---

## Data

The processed `.mat` data files are stored externally (not included in this repository) at `/data1/bliu/data/`. Key intermediate files produced by the analysis scripts include:

| File | Contents |
|------|----------|
| `SS_raw.mat` | RIPX run summary structures (`S(1:120)`) |
| `Sky_withWBfit_10loc_qced_*.mat` | Weibull-fitted S(ky) at 10 cross-shore locations |
| `Sky_nond_10loc_*.mat` | Non-dimensional S(ky) |
| `plotready_G0_nond_10loc_2025.mat` | G₀ data ready for plotting |
| `plotready_ky0_nond_10loc_2025.mat` | k_y0 data ready for plotting |
| `CXT_ALL_norm_and_var_21dx10dt_Bingchen_qced.mat` | QC'd C(x,t) for all 120 runs |
| `cxt_ind_good.mat` | Valid cross-shore indices per run |
| `cxt_alongct_max_dxwidth_fitpara_qced_1mres.mat` | Fit parameters from C(x,t) |
| `cxt_alongct_max_dxwidth_fitpara_withscaling.mat` | Fit parameters plus scaling variables |
| `cxt_fitanalysis_max_dxwidth.mat` | Collated τ analysis results |

---

## Author

**Bingchen Liu**  
Scripps Institution of Oceanography, UC San Diego  
Development period: 2024–2025
