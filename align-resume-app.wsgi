#! /usr/bin/python

from app import align_resume_app as application
import sys
import subprocess
sys.path.append("/var/www/html/align-resume-app")

activate_this = str(subprocess.check_output('pipenv --venv'))
with open(activate_this) as file_:
    exec(file_.read(), dict(__file__=activate_this))
