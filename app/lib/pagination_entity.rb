class PaginationEntity
  def initialize(page, entity)
    @page = page.to_i
    @per_page = 10
    @entity = entity
  end

  def get_data
    page = @page
    offset = @page != 0 && @page != 1 ? (page - 1) : 0
    items = @entity.limit(@per_page).offset(offset)

    {page: @page, items: items, current_page: page}
  end

  def get_pages
    count = @entity.count
    pages = count <= @per_page ? 1 : (count / @per_page).round(half: :up)
    return pages
  end

  def is_possible
    pages = self.get_pages.to_i
    if @page > pages || @page < 1
      return false
    end
    true
  end
end