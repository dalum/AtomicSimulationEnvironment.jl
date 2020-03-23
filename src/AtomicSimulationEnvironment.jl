module AtomicSimulationEnvironment

import AbstractAtoms: atomic_positions, chemical_symbols

using PyCall

function __init__()
    py"""
    import ase
    import ase.io
    import ase.visualize
    """
end

##################################################
# Atoms
##################################################

struct Atoms
    wrapped::PyObject

    Atoms(args...; kwargs...) = new(py"ase.Atoms"(args...; kwargs...))
end

Atoms(x) = Atoms(join(chemical_symbols(x)), positions=atomic_positions(x))

##################################################
# Trajectory
##################################################

struct Trajectory
    wrapped::PyObject

    Trajectory(f) = new(py"ase.io.trajectory.Trajectory"(f))
end

##################################################
# Visualize
##################################################

view(atoms::Atoms) = py"ase.visualize.view"(atoms.wrapped)
view(traj::Trajectory) = py"ase.visualize.view"(traj.wrapped)

end # module
