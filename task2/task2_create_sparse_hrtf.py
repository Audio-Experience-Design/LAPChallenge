""" This script contains a function to create a sparse HRTF from a
    given SOFA file for the LAP challenge Task 2.

    2024-06-19, Rapolas Daugintis
    Version: 1.1
"""
import numpy as np
import sofar as sf

def create_sparse_hrtf(sofa_fn: str, n_positions: int) -> sf.Sofa:
    """Reads a SOFA file and creates a new SOFA file with a reduced
       number of positions for the LAP challenge Task 2.

    Parameters
    ----------
    sofa_fn : str
        Path to the SOFA file to be read.
    n_positions : int
        Number of positions to be retained in the new SOFA file.
        Supported values are 3, 5, 19, and 100.

    Returns
    -------
    sf.Sofa
        The new SOFA object with the reduced number of positions.
        The new SOFA file is also saved in the same directory as
        the input file with number of sparse postions appended
        to the filename.

    Raises
    ------
    ValueError
        If the chosen number of positions is not supported.

    Examples
    --------
    >>> sofa = create_sparse_hrtf('P0001_FreeFieldCompMinPhase_48kHz.sofa', 100)
    """

    # Read the SOFA file and create a copy to be modified
    sofa = sf.read_sofa(sofa_fn)
    sofa_ds = sofa.copy()

    # Select the indexes of the positions to be retained based
    # on the number of positions

    if n_positions == 100:
        # Find the step size based on the number of desired positions
        step_size = int(np.ceil(len(sofa.SourcePosition)/n_positions))
        # Find sorted indexes of the positions based on azimuth and then elevation
        idx = np.lexsort((sofa.SourcePosition[:, 1], sofa.SourcePosition[:, 0]))
        # Select the subset of indexes based on the stepping rate
        # (every 8th in case of SONICOM HRTFs)
        idx = np.sort(idx[::step_size])

    elif n_positions == 19:
        # Positions every 60 deg azi and every 45 deg ele plus the top
        azi_ds = [0] + list(np.repeat(np.arange(0, 360, 60), 3))
        ele_ds = [90] + list(np.tile(np.arange(-45, 90, 45), 6))

    elif n_positions == 5:
        # Select 5 positions within 45 deg from the front
        azi_ds = [315, 0, 0, 0, 45]
        ele_ds = [0, -45, 0, 45, 0]

    elif n_positions == 3:
        # 3 positions: front, left and top
        azi_ds = [0, 90, 0]
        ele_ds = [0, 0, 90]

    else:
        raise ValueError('Chosen number of positions is not supported!')

    if n_positions < 100:
        # Finding the right indexes for 19, 5, and 3 positions
        pos = np.column_stack((azi_ds, ele_ds))
        idx = (sofa.SourcePosition[:, None, 0:2] == pos).all(-1).any(1)


    # Retain only the Source positions and the IRs based on the sparsity level
    sofa_ds.SourcePosition = sofa.SourcePosition[idx, :]
    sofa_ds.Data_IR = sofa.Data_IR[idx, :, :]
    if sofa.Data_Delay.shape[0] > 1:
        sofa_ds.Data_Delay = sofa.Data_Delay[idx, :]
    sofa_ds.MeasurementSourceAudioChannel = sofa.MeasurementSourceAudioChannel[idx]
    sofa_ds.GLOBAL_Comment = sofa.GLOBAL_Comment + \
                            '\nNumber of measurements reduced to ' + \
                            str(n_positions) + ' for the LAP challenge Task 2.'
    sofa_ds_fn = sofa_fn[:-5] + '_' + str(n_positions) + '.sofa'
    sf.write_sofa(sofa_ds_fn, sofa_ds)
    return sofa_ds
