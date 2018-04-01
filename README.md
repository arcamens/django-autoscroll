# django-autocroll

Simplify implementing automatic scrolling in django.

# Install

~~~
pip install django-autoscroll
~~~

# Usage

The django-scroll app demands you to be using jquery, it does pagination for div elements using jquery requests.
It as well demands you to have some framework like bootstrap that allows scrollable div elements.
First you have to define a paginator view.

**demo/core_app/views.py**

~~~python
from django.shortcuts import render
from django.core.paginator import Paginator
from django.core.urlresolvers import reverse
from django.views.generic import View
from . import models

# Create your views here.

class Index(View):
    def get(self, request):
        url    = reverse('core_app:quote-paginator', kwargs={})
        return render(request, 'core_app/index.html', {'url': url})

class QuotePaginator(View):
    def get(self, request):
        quotes = models.Quote.objects.all()
        quotes = quotes.order_by('id')

        # Assume pages are 30 elements long.
        paginator = Paginator(quotes, 30)
        page      = paginator.page(request.GET['page'])

        return render(request, 'core_app/quote-paginator.html', 
        {'quotes': page})

~~~


After that, you create a paginator template that is used to render your objects in the div viewport.

**demo/core_app/templates/core_app/quote-paginator.html**

~~~html

{% for ind in quotes %}
<h3> {{ind.data}} </h3>

{% endfor %}

~~~

Then it is time to drop the js code that is responsible for doing paginator.

**demo/core_app/templates/core_app/index.html**

~~~html
<!DOCTYPE html>
{% load i18n %}
{% load autoscroll %}

<html lang="en">
<head>
<title>quotes</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/paho-mqtt/1.0.1/mqttws31.js" type="text/javascript"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<body>

<div class="container">
<div class="jumbotron">
<h1>Quotes</h1> 

<div class="container">
<div id="quotesViewport" class="pre-scrollable">
</div>
</div>

</div>
</div>


{{'quotesViewport' | paginator:url | safe}}
</body>

</html>

~~~

The models.

**core_app/models.py**

~~~python
from django.db import models

# Create your models here.
class Quote(models.Model):
    data = models.CharField(null=True,
    blank=False, verbose_name='Data',  max_length=500)

    created = models.DateTimeField(auto_now=True, null=True)

~~~

So, the idea consists of defining a view that does the pagination, usually as you would do. After defining the pagination
view it is just a matter of defining a div element that is your viewport then drop it through the paginator template tag
altogether with your paginator view. After that everything should work out of the box.

**Note:** I have tested it on django-1.11.

The demo/quotes app is deployed on heroku, you can check it at:

**Note:** The escs.sh file contains code used for setting up the project.

