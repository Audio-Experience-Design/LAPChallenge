# LAP Challenge

## Table of Contents
- [LAP Challenge](#lap-challenge)
  - [Table of Contents](#table-of-contents)
  - [About](#about)
  - [Challenge Tasks](#challenge-tasks)
  - [Repository structure](#repository-structure)
  - [Results, Publications, Winners, and Evaluation](#results-Publications-winners-and-evaluation)
  - [Key Dates](#key-dates)
  - [Participation](#participation)
  - [Join us](#join-us)
    - [Task 2: HRTF Dataset](#task-2-hrtf-dataset)
  - [Organizers](#organizers)
    - [Sponsors](#sponsors)
    - [Funding](#funding)

## About
The [LAP Challenge](https://www.sonicom.eu/lap-challenge/) aims at advancing personalized spatial audio technologies. It focuses on enhancing auditory localization and immersion in mixed realities through the personalization of Head-Related Transfer Functions (HRTFs). 

## Challenge Tasks
Participants are encouraged to address one of the following:
- **Task 1:** Normalization of HRTFs for merging several [datasets](https://imperialcollegelondon.box.com/s/utm14xqeti6zp02bk7399j48jp3ggthl).
- **Task 2:** Spatial upsampling to achieve high-resolution HRTFs from minimal directional samples [dataset](https://imperialcollegelondon.box.com/s/qshix6e74q3s86brkxx2sz809o9td3q4).

## Repository structure
- folder **task1**
  - ``task1_validate.m`` demonstrates how to test deviations in terms of localization metrics predicted by an auditory model.
  - ``task1_score.md`` contains the instructions to compute the overall score given the set of collections.
- folder **task2**
  - ``task2_metrics.ipynb`` showcases how to use the [SAM](https://spatial-audio-metrics.readthedocs.io/en/latest/) package to validate and compute the scores for Task 2.
  - ``task2_create_sparse_hrtf.py`` contains a function to create a sparse HRTF from a sofa file with a dense HRTF. It can be used to generate example sparse HRTFs for the challenge at different sparsity levels (number of positions). Requires [sofar](https://sofar.readthedocs.io/en/stable/readme.html) package.

## Results, Publications, Winners, and Evaluation

The results, winners, and evaluation of the submissions for the LAP Challenge have been officially released in the following two publications:

- [Listener Acoustic Personalization Challenge - LAP24: Head-Related Transfer Function Dataset Harmonization](https://ieeexplore.ieee.org/document/11097362)
- [Listener Acoustic Personalization Challenge - LAP24: Head-Related Transfer Function Upsampling](https://ieeexplore.ieee.org/document/11078906)

A draft technical report covering the full results of the challenge is also available here: 

- [Technical Report: SONICOM - IEEE Listener Acoustic Personalisation LAP Challenge 2024](https://doi.org/10.36227/techrxiv.173153187.72930965/v1)

## Key Dates
- <del>Task Details Released: March 27, 2024</del>
- <del>Submission Deadline: July 1, 2024</del>
- <del>Awards Ceremony: August 29, 2024, at EUSIPCO 2024 in Lyon, France<del>.

## Participation
For task details, evaluation criteria, and submission guidelines, refer to [Task 1](https://imperialcollegelondon.box.com/s/laq35yleevu0e1c7g0mn1w9e98f2b0ia) and [Task 2](https://imperialcollegelondon.box.com/s/w7b7dmqbuywuu1oktbrhehlgdfghhfm1).

## Join us 
Keep up to date by joining the [Google Group](https://groups.google.com/g/sonicom-lap-challenge).

### Task 2: HRTF Dataset

The original HRTF datasets, from which the sparse HRTF dataset for Task 2 was derived, are available for download at the following [URL](https://transfer.ic.ac.uk:9090/#/2022_SONICOM-HRTF-DATASET/). 

| Sparse HRTF           | Original HRTF                                      | Original HRTF URL                                                                 |
|-----------------------|----------------------------------------------------|-----------------------------------------------------------------------------------|
| LAPtask2_100_1.sofa    | P0201_FreeFieldCompMinPhase_48kHz.sofa             | [Link](https://transfer.ic.ac.uk:9090/2022_SONICOM-HRTF-DATASET/P0201/HRTF/HRTF/48kHz/P0201_FreeFieldCompMinPhase_48kHz.sofa) |
| LAPtask2_19_1.sofa     | P0202_FreeFieldCompMinPhase_48kHz.sofa             | [Link](https://transfer.ic.ac.uk:9090/2022_SONICOM-HRTF-DATASET/P0202/HRTF/HRTF/48kHz/P0202_FreeFieldCompMinPhase_48kHz.sofa) |
| LAPtask2_5_1.sofa      | P0203_FreeFieldCompMinPhase_48kHz.sofa             | [Link](https://transfer.ic.ac.uk:9090/2022_SONICOM-HRTF-DATASET/P0203/HRTF/HRTF/48kHz/P0203_FreeFieldCompMinPhase_48kHz.sofa) |
| LAPtask2_3_1.sofa      | P0204_FreeFieldCompMinPhase_48kHz.sofa             | [Link](https://transfer.ic.ac.uk:9090/2022_SONICOM-HRTF-DATASET/P0204/HRTF/HRTF/48kHz/P0204_FreeFieldCompMinPhase_48kHz.sofa) |
| LAPtask2_100_2.sofa    | P0205_FreeFieldCompMinPhase_48kHz.sofa             | [Link](https://transfer.ic.ac.uk:9090/2022_SONICOM-HRTF-DATASET/P0205/HRTF/HRTF/48kHz/P0205_FreeFieldCompMinPhase_48kHz.sofa) |
| LAPtask2_19_2.sofa     | P0206_FreeFieldCompMinPhase_48kHz.sofa             | [Link](https://transfer.ic.ac.uk:9090/2022_SONICOM-HRTF-DATASET/P0206/HRTF/HRTF/48kHz/P0206_FreeFieldCompMinPhase_48kHz.sofa) |
| LAPtask2_5_2.sofa      | P0207_FreeFieldCompMinPhase_48kHz.sofa             | [Link](https://transfer.ic.ac.uk:9090/2022_SONICOM-HRTF-DATASET/P0207/HRTF/HRTF/48kHz/P0207_FreeFieldCompMinPhase_48kHz.sofa) |
| LAPtask2_3_2.sofa      | P0208_FreeFieldCompMinPhase_48kHz.sofa             | [Link](https://transfer.ic.ac.uk:9090/2022_SONICOM-HRTF-DATASET/P0208/HRTF/HRTF/48kHz/P0208_FreeFieldCompMinPhase_48kHz.sofa) |
| LAPtask2_100_3.sofa    | P0210_FreeFieldCompMinPhase_48kHz.sofa             | [Link](https://transfer.ic.ac.uk:9090/2022_SONICOM-HRTF-DATASET/P0210/HRTF/HRTF/48kHz/P0210_FreeFieldCompMinPhase_48kHz.sofa) |
| LAPtask2_19_3.sofa     | P0211_FreeFieldCompMinPhase_48kHz.sofa             | [Link](https://transfer.ic.ac.uk:9090/2022_SONICOM-HRTF-DATASET/P0211/HRTF/HRTF/48kHz/P0211_FreeFieldCompMinPhase_48kHz.sofa) |
| LAPtask2_5_3.sofa      | P0212_FreeFieldCompMinPhase_48kHz.sofa             | [Link](https://transfer.ic.ac.uk:9090/2022_SONICOM-HRTF-DATASET/P0212/HRTF/HRTF/48kHz/P0212_FreeFieldCompMinPhase_48kHz.sofa) |
| LAPtask2_3_3.sofa      | P0213_FreeFieldCompMinPhase_48kHz.sofa             | [Link](https://transfer.ic.ac.uk:9090/2022_SONICOM-HRTF-DATASET/P0213/HRTF/HRTF/48kHz/P0213_FreeFieldCompMinPhase_48kHz.sofa) |

## Organizers
Chair: Michele Geronazzo, University of Padova, IT, and Imperial College London, UK\
Co-chair: Lorenzo Picinali, Imperial College London, UK

Chair of the Implementation: Roberto Barumerli, University of Verona, IT\
Chair of the Web Site and Dissemination: Aidan Hogg, Queen Mary University of London, UK

Fabian Brinkmann, Technische Universität Berlin, DE\
Glen McLachlan, University of Antwerp, BE\
Stavros Ntalampiras, University of Milan, IT\
Johan Pauwels, Queen Mary University of London, UK\
Katarina Poole, Imperial College London, UK\
Rapolas Daugintis, Imperial College London, UK

### Sponsors
![IEEE_SPS_logo](https://www.sonicom.eu/wp-content/uploads/2023/10/IEEE-SPS-logo.png)

The Listener Acoustic Personalisation Challenge is sponsored by the IEEE Signal Processing Society.

---

### Funding
![sonicom_logo](https://www.sonicom.eu/wp-content/themes/sonicom/library/images/logo.png)

The SONICOM project has received funding from the European Union’s Horizon 2020 research and innovation programme under grant agreement no.101017743. The sole responsibility for the content of this project lies with the authors. It does not necessarily reflect the opinion of the European Union. The European Commission is not responsible for any use that may be made of the information contained therein.
