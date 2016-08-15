'use strict'

angular
  .module 'fuse'
  .factory 'paginationService', PaginationService

  !function Pagination-service
    service =
      get-new: get-new

    return service

    !function get-new (per-page)
      if per-page === undefined
          per-page = 10

        # console.log per-page

      paginator =
        num-of-pages: 1
        page-size: per-page
        current-page: 0

      paginator.prev-page = !->
        if not paginator.is-first-page!
          paginator.current-page -= 1

      paginator.next-page = !->
        if not paginator.is-last-page!
          paginator.current-page += 1

      paginator.is-last-page = ->
        paginator.current-page >= paginator.num-of-pages - 1

      paginator.is-first-page = ->
        paginator.current-page == 0

      return paginator
