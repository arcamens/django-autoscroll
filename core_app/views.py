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


