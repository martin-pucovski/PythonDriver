# Synopsis
Script runs python script in virtual environment.

# Description
This script expects a path to the python project as the first parameter. The project should contain virtual environment folder with name *venv*, in the root of the project. Before running the python script, it activates the virtual environment, runs the script, and then deactivates the environment. It logs any uncaught exception in the python script.