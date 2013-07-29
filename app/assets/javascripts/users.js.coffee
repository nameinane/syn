# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  if $('.pagination').length
    # do not show the pagination element, just scroll
    # TODO: there is a bug where if paged next immediately upon loading the first page,
    #       the pagination will get re-displayed after beign already hidden.
    #       Current (albeit poor) fix is to set .paginate.per_page > 'x' where 'x' is 
    #       enough to avoid immediate "page_next" invocation.
    $('.pagination').hide() 
    $(window).scroll ->
      url = $('.pagination .next_page a').attr('href')
      if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
        $('.pagination').text("Fetching more users...")
        $.getScript(url)
    $(window).scroll()
    