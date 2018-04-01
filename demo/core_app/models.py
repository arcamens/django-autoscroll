from django.db import models

# Create your models here.
class Quote(models.Model):
    data = models.CharField(null=True,
    blank=False, verbose_name='Data',  max_length=500)

    created = models.DateTimeField(auto_now=True, null=True)



