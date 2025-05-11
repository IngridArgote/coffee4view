# ☕ Coffee4View: Automated Detection of Coffee Fruit Ripeness Stages

Coffee4View is a MATLAB-based image analysis pipeline for detecting, classifying, and counting coffee fruits by maturity stage. It is designed for small-scale image acquisition environments (e.g., 50×50 px images captured in field conditions) and follows a multi-stage algorithm inspired by recent research in agricultural computer vision.

IEEE Latin America Transactions

ID: 9330

Ingrid Lorena Argote Pedrazza
Medellin Education Department - Medelin – Colombia

e-mail:ingridloargote@iesanantoniodeprado.edu.co

Emerson Carlos Pedrino
Computer Science Department - Federal University of São Carlos - São Carlos - SP – Brazil

e-mail:emerson@ufscar.br

Carlos Roberto Valêncio
Computer Science and Statistic Department- São Paulo State University – S. J. Rio Preto - SP - Brazil 

e-mail:carlos.valencio@unesp.br

Mário Luiz Tronco
Mechanical Engineering Department - São Paulo University - São Carlos - SP –Brazil

e-mail:mltronco@sc.usp.br

---

## 📂 Project Structure

```
Coffee4View/
│
├── thresholds/
│   └── generateThresholdsAllClasses.m
│
├── segmentation/
│   ├── segmentAllClasses.m
│   ├── refineWhiteMask.m
│   └── visualizeWhiteMask.m
│
├── edges_and_ellipses/
│   ├── detectEdgesZeroCrossing.m
│   ├── findCurvedArcs.m
│   └── projectEllipsesFromArcs.m
│
├── utils/
│   ├── extractPixels.m
│   ├── appendPixels.m
│   ├── initializePixelStruct.m
│   ├── enhanceContrast.m
│   └── loadChannelThresholds.m
│
├── pipeline/
│   └── runFullPipeline.m
│
└── data/
    ├── Images/
    │   ├── Classification/
    │   └── Device/
    └── thresholds_all_classes.mat
```

---

## 🚀 Pipeline Overview

1. **Threshold Generation**
   - `generateThresholdsAllClasses.m` analyzes image patches by class and extracts Q1/Q3 values per color channel (RGB, HSV, Lab, YCbCr) to determine optimal segmentation thresholds.

2. **Mask Refinement**
   - `refineWhiteMask.m` removes residual background noise from white-dominant areas using morphological operations, improving segmentation quality.

3. **Multiclass Segmentation**
   - `segmentAllClasses.m` combines weighted candidate channels for each class using thresholds and produces a global mask with all fruit regions.

4. **Edge Detection and Ellipse Projection**
   - `detectEdgesZeroCrossing.m`: Applies a Laplacian of Gaussian filter and detects zero-crossings.
   - `findCurvedArcs.m`: Extracts arc segments and identifies inflection points.
   - `projectEllipsesFromArcs.m`: Projects elliptical shapes from arc endpoints and central curvature for fruit estimation.

5. **Full Pipeline Execution**
   - `runFullPipeline.m`: End-to-end execution script including threshold loading, segmentation, edge detection, ellipse fitting, and fruit count output.

---

## 📊 Output

- **Binary masks** for each class
- **Segmented RGB images** with isolated fruit
- **Ellipses projected** on detected arc contours
- **CSV and `.mat` files** with quartile data, thresholds, and segmentation scores

---

## 🧠 Technical Highlights

- **Color space analysis**: Uses a quartile-based method across 12 channels (R, G, B, H, S, V, L, a, b, Y, Cb, Cr) to select optimal segmentation bands.
- **Noise-tolerant masking**: Incorporates contrast enhancement and refined morphological filtering to reject white background noise.
- **Elliptical modeling**: Incorporates geometric arc detection and angle-based filtering (using α angle thresholds) to approximate fruit contours even when not fully closed.

---

---

## 📌 Notes

- This project is currently under academic development and might evolve further with improved arc tracing and dataset generalization.
- Works best with small-sized high-contrast coffee fruit images in controlled background settings.

---
