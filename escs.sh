##############################################################################
cd ~/projects/
git clone git@bitbucket.org:arcamens/autoscroll.git autoscroll-code
##############################################################################
# push, autoscroll, master.
cd ~/projects/django-autoscroll-code
# clean up all .pyc files. 
find . -name "*.pyc" -exec rm -f {} \;

git status
git add *
git commit -a
git push -u origin master
##############################################################################
# create virtualenv for demo.
cd ~/.virtualenvs/
ls -la
# by default, python3 has executable named python in arch linux.
virtualenv django-autoscroll -p /usr/bin/python
##############################################################################
# activate virtualenv.
cd ~/.virtualenvs/
source django-autoscroll/bin/activate
cd ~/projects/django-autoscroll-code
##############################################################################
# install, autoscroll, dependencies, virtualenv.
cd ~/.virtualenvs/
source django-autoscroll/bin/activate
cd ~/projects/django-autoscroll-code/demo
pip install -r requirements.txt 
##############################################################################
# delete last commit.
cd ~/projects/autoscroll-code
git reset HEAD^ --hard
git push -f
##############################################################################
# create demo project.
cd ~/projects/django-autoscroll-code
mkdir demo
django-admin startproject quotes demo
##############################################################################
# create core_app.
cd ~/projects/django-autoscroll-code/demo/
python manage.py startapp core_app 

##############################################################################
# create templates folder for demo.
cd ~/projects/django-autoscroll-code/demo/core_app
mkdir templates
mkdir templates/core_app

##############################################################################
# run migrations.
cd ~/projects/django-autoscroll-code/demo/
python manage.py makemigrations 
##############################################################################
pip install django==1.11
pip install django-blowdb
##############################################################################
# blowdb and create the user.
python manage.py blowdb
##############################################################################
# run the server.
cd ~/projects/django-autoscroll-code/demo
stdbuf -o 0 python manage.py runserver 0.0.0.0:8000
##############################################################################
# install autosccroll.

cd ~/projects/django-autoscroll-code
python setup.py install
##############################################################################
# create quotes.
cd ~/projects/django-autoscroll-code/demo

tee >(python manage.py shell --settings=quotes.settings)
filename = '/home/tau/projects/django-autoscroll-code/demo/quotes.txt'
fd = open(filename, 'r', errors='replace')
data = fd.read()

from core_app.models import Quote
from re import split
data = split('\n+', data)
data[0]

for ind in data:
    Quote.objects.create(data=ind)

##############################################################################
# deploy on heroku.

wget -qO- https://toolbelt.heroku.com/install.sh | sh
heroku login
echo 'PATH="/usr/local/heroku/bin:$PATH"' >> ~/.bashrc
heroku git:remote -a philosophy-quotes

heroku config:set DISABLE_COLLECTSTATIC=1

git add .
git commit -a
git push heroku master
##############################################################################
# put on pip.

python setup.py sdist register upload
rm -fr dist


