# Venue Search Reference

This file is used by the skill to suggest and infer appropriate venues when the user
doesn't specify them. Users never need to read or edit this file.

When inferring venues for a user's field:
1. Pick the 4-6 most prominent venues for their area from the tables below
2. State your choice to the user: "I'll watch X, Y, Z for you — correct me if you'd like others"
3. Save the chosen venues to the user's profile

For venues not listed here, use: `site:[proceedings-url] [keywords]`

For biology-heavy areas that rely heavily on preprints, especially single-cell omics, spatial transcriptomics, and multiomics modeling, also consider bioRxiv as a separate source in addition to venues and arXiv.

Suggested bioRxiv search pattern for those areas:

`site:biorxiv.org (single-cell OR single cell OR spatial transcriptomics OR multiomics OR multimodal) [keywords]`

---

## Machine Learning / AI

| Venue | Search pattern |
|---|---|
| NeurIPS | `site:proceedings.neurips.cc [keywords]` |
| ICML | `site:proceedings.mlr.press [keywords]` |
| ICLR | `site:openreview.net [keywords]` |
| AAAI | `site:ojs.aaai.org [keywords]` |
| JMLR | `site:jmlr.org [keywords]` |

## Computer Vision

| Venue | Search pattern |
|---|---|
| CVPR | `site:openaccess.thecvf.com CVPR [keywords]` |
| ICCV | `site:openaccess.thecvf.com ICCV [keywords]` |
| ECCV | `site:ecva.net [keywords]` |

## NLP

| Venue | Search pattern |
|---|---|
| ACL | `site:aclanthology.org ACL [keywords]` |
| EMNLP | `site:aclanthology.org EMNLP [keywords]` |
| NAACL | `site:aclanthology.org NAACL [keywords]` |

## Biology / Bioinformatics

| Venue | Search pattern |
|---|---|
| Nature | `site:nature.com [keywords]` |
| Science | `site:science.org [keywords]` |
| Cell | `site:cell.com [keywords]` |
| Bioinformatics | `site:academic.oup.com/bioinformatics [keywords]` |
| NeurIPS Comp Bio | `site:proceedings.neurips.cc computational biology [keywords]` |

## Economics / Statistics

| Venue | Search pattern |
|---|---|
| Econometrica | `site:econometricsociety.org [keywords]` |
| AER | `site:aeaweb.org/articles [keywords]` |
| JASA | `site:amstat.tandfonline.com JASA [keywords]` |
| Biometrika | `site:academic.oup.com/biomet [keywords]` |
| Annals of Statistics | `site:projecteuclid.org/aos [keywords]` |
| JRSS-B | `site:academic.oup.com/jrsssb [keywords]` |

---

## Recommended arXiv Categories for Your Five Areas

Use this table first when the user's profile matches these areas. These defaults are more specific than the generic field-level table below.

| Area | Categories |
|---|---|
| Single-cell omics / spatial transcriptomics generative models | q-bio.GN, q-bio.QM, cs.LG, stat.ML |
| Semiparametric statistics | stat.ME, stat.TH, math.ST |
| Optimal transport and statistical inference | stat.TH, stat.ME, math.ST, math.PR, cs.LG |
| Mechanistic interpretability | cs.LG, cs.AI, cs.CL |
| Causal representation learning | cs.LG, stat.ML, cs.AI |

---

## Arxiv Category Codes by Field

| Field | Categories |
|---|---|
| Machine Learning | cs.LG, stat.ML |
| Computer Vision | cs.CV |
| NLP | cs.CL |
| AI (general) | cs.AI |
| Computational Biology | q-bio.GN, q-bio.QM, cs.LG |
| Economics | econ.EM, econ.TH |
| Statistics | stat.ME, stat.TH |
| Mathematical Statistics | math.ST |
| Probability | math.PR |
| Quantum Computing | quant-ph |
