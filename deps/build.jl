using PyCall

function checkpip()
   # Import pip
   try
      pipver = `$(PyCall.python) -m pip --version`
      run(`$(pipver)`)
   catch
       # If it is not found, install it
       println("""I couldn't find `pip`. I will try to download and install it
                  automatically, but if this fails, please install
                  manually, then try to build `AtomicSimulationEnvironment` again.""")
       get_pip = joinpath(dirname(@__FILE__), "get-pip.py")
       download("https://bootstrap.pypa.io/get-pip.py", get_pip)
       run(`$(PyCall.python) $get_pip --user`)
   end
end

function pip(pkgname)
   checkpip()
   pipcmd = `$(PyCall.python) -m pip install --upgrade --user $(pkgname)`
   run(pipcmd)
end


println("Installing Dependencies of `AtomicSimulationEnvironment.jl`: `ase` and `matscipy`")

if Sys.isunix()
   try
      pyimport("ase")
   catch
      println("""`ase` was not found, trying to install via pip. If this fails,
               please file an issue and try to install it manually, following
               the instructions at `https://wiki.fysik.dtu.dk/ase/install.html`""")
      pip("ase")
   end
else
   println("""it looks like this is a windows machine? I don't dare try to
            automatically build the dependencies here -- sorry!
            If installing them by hand turns out non-trivial, please file an
            issue.""")
end
