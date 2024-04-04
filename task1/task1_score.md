# LAP Challenge Task 1 Score Computation

## Instructions
To compute the score for Task 1 of the LAP Challenge, follow these steps. 

1. **Download HRTFs:**
   - Download the HRTFs dataset from the following [link](https://imperialcollegelondon.box.com/s/utm14xqeti6zp02bk7399j48jp3ggthl)
   - Unzip the downloaded file to extract the contents.

2. **Installation:**
   - Install the LAP Task 1 scoring tool using pip:
     ```
     pip install lap-task1
     ```

3. **Usage:**
   - Run the tool from any directory with the path to the downloaded data as its only argument.
   - Example:
     ```
     lap-task1 ./path/to/downloaded/hrtfs
     ```

4. **Result:**
   - The tool will display progress indicators during execution.
   - Upon completion, it will print the computed score.

## Additional Notes
- Ensure that you have Python and pip installed on your system before running the installation command.
- For any issues or inquiries, please refer to the LAP Challenge organizers.
- Details on how the score is computed are available in the original [paper](https://10.1109/ICASSP49357.2023.10096689)
- The code behind the Python package is [here](https://github.com/jpauwels/lap-task1). 