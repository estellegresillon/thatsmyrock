function infiniteScroll() {
  if ($('#infinite-scrolling').length > 0) {
    const loaderUrl = document.getElementById('loader').getAttribute('src');
    $(window).on('scroll', function() {
      const more_posts_url = $('.pagination .next_page a').attr('href');
      if(more_posts_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60) {
        $('.pagination').html(`<img src="${loaderUrl}" alt="Loading..." title="Loading..." />`);
        $.getScript(more_posts_url);
      }
    });
  }
}

export { infiniteScroll };
