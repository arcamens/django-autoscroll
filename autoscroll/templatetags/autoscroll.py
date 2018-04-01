from django import template
from django.core.urlresolvers import reverse

register = template.Library()

@register.filter
def paginator(div, url):
    data = """<script>
    var count = 1;
    
    function autoScroll() {
        var valX = $(this).scrollTop() + $(this).innerHeight() 
        var valY = $(this)[0].scrollHeight * 60/100.0
    
        if (valX >= valY) {
            count = count + 1;
        
            $('#@div').off('scroll');
        
            $.get({ 
            url: '@url',
            data: {
                    page : count
            }},
    
            function(data) {
                $('#@div').on('scroll', autoScroll);
                $('#@div').append(data);
            });
        }
    }
    
    $('#@div').on('scroll', autoScroll);
    $.get({ 
    url: '@url',
    data: {
            page : count
    }},

    function(data) {
        $('#@div').html(data);
    });

    </script>
    """

    data = data.replace('@div', div)
    data = data.replace('@url', url)
    return data




