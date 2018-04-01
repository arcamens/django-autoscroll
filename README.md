# django-autocroll

Simplify implementing automatic scrolling in django.

# Install

~~~
pip install django-autoscroll
~~~

# Usage

The django-scroll app demands you to be using jquery, it does pagination for div elements using jquery requests.
First you have to define a paginator view.

**demo/core_app/views.py**

~~~python


~~~


After that, you create a paginator template that is used to render your objects in the div viewport.

**demo/core_app/templates/core_app/quote-paginator.html**

~~~html

~~~

Then it is time to drop the js code that is responsible for doing paginator.

**demo/core_app/templates/core_app/index.html**

~~~html

~~~

The demo/quotes app is deployed on heroku, you can check it at:


