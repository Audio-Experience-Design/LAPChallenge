# LAP Challenge

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

## Key Dates
- Task Details Released: March 27, 2024
- Submission Deadline: July 1, 2024
- Awards Ceremony: August 29, 2024, at EUSIPCO 2024 in Lyon, France.

## Participation
For task details, evaluation criteria, and submission guidelines, refer to [Task 1](https://imperialcollegelondon.box.com/s/laq35yleevu0e1c7g0mn1w9e98f2b0ia) and [Task 2](https://imperialcollegelondon.box.com/s/w7b7dmqbuywuu1oktbrhehlgdfghhfm1).

## Awards & Publication
Top solutions will be recognized at EUSIPCO 2024, with potential publication in the IEEE Open Journal of Signal Processing and eligibility for registration and travel reimbursements.

## Join us 
Keep up to date by joining the [Google Group](https://groups.google.com/g/sonicom-lap-challenge).

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
