To reproduce the evaluation of the submitted harmonized HRTF collection:

**Step 1: Validate Harmonized HRTFs**
- Run task1_submission_validation.m to assess the quality and correctness of the provided harmonized HRTFs using the [barumerli2023](https://www.amtoolbox.org/amt-1.5.0/doc/models/barumerli2023.php) sound localization model.

**Step 2: Evaluate Classification Score**
- Execute task1_submission_evaluation.py to calculate and report the [classification score](https://github.com/jpauwels/lap-task1) for the submitted HRTF collection.