## ResistanceBiomarkerAnalysis

## Quick start

This repository implements Matlab analysis of treatment resistance and
sensitivity biomarkers via drug-induced microtubule bundling and
nuclear androgen receptor localization. See
[DEPENDENCIES.md](DEPENDENCIES.md) for the Image Processing Toolbox
requirement.

## Repository contents

- `ARlocalization.m`, `ARlocalization1.m`, `ARlocalization2.m` --
  androgen receptor nuclear localization analysis.
- `MTbundling.m`, `MTbundling3.m`, `MTbundling5.m`, `MTbundling6.m`,
  `MTbundling7.m`, `bundlingMT4.m`, `batchBundlingMatt.m`,
  `ergBundles.m` -- microtubule bundling analysis.
- `CTC.m`, `detectCTCs.m`, `detectCTCs1.m`, `detectCTCs2.m`,
  `HoughCtc.m`, `CircularHough_Grd.m`, `DrawCircle.m` -- circulating
  tumor cell detection via circular Hough transform (see LICENSE for
  `CircularHough_Grd.m`'s origin).
- `reports/` -- PDF reports and conference posters.
- **License:** see [LICENSE](LICENSE) -- research/educational use.

## About

The Matlab code I wrote for the analysis of treatment resistance and sensitivity biomarkers based on the drug-induced microtubule bundling and nuclear androgen receptor localization for the publications:

Matt Sung, Evi Giannakakou "BRCA1 Regulates Microtubule Dynamics and Taxane-Induced Apoptotic Cell Signaling" (2014) and Maria Thadani-Mulero, Luigi Portella, Shihua Sun, Matt Sung, Alex Matov, Bob Vessella, Eva Corey, David Nanus, Stephen Plymate, Evi Giannakakou "Androgen Receptor Splice Variants Determine Taxane Sensitivity in Prostate Cancer" (2014) 

For detailed information, see: https://www.frontiersin.org/journals/cell-and-developmental-biology/articles/10.3389/fcell.2025.1723251/full 

