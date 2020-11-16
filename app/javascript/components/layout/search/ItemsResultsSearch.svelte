<script>
    // PROPS
    export let activeShow = false
    export let valueInputSearch = ''
    export let items = {
        posts: [],
        categories: []
    }
</script>

<div class={activeShow ? 'search-items-results show' : 'search-items-results'}>
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="search-items-results-header">
                    <h4>Search Results</h4>
                    <a href="#" id="close_search_items" on:click|preventDefault>
                        <i class="fas fa-times"></i>
                    </a>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <ul class="search-items-results-list">
                    {#each items.posts as post}
                        <li>
                            <img alt="post img {post.id}"
                                 src={post.img_original.thumb.url ? post.img_original.thumb.url : '/images/default/thumb_image.png'}/>
                            <p>
                                {post.name}
                                <br>
                                (belongs to <span class="search-items-results-search">{post.category_id}</span>)
                                <br>
                                (result for <span class="search-items-results-search">{valueInputSearch}</span>)
                            </p>
                        </li>
                    {/each}
                </ul>
            </div>
            <div class="col-md-6">
                <ul class="search-items-results-list">
                    {#each items.categories as category}
                        <li>
                            <img alt="category img {category.id}"
                                 src={category.avat_cat.icon.url ? category.avat_cat.icon.url : '/images/default/thumb_image.png'}
                                 class="categories">
                            <p class="categories-paragraph">
                                {category.name}
                                <br>
                                (result for <span class="search-items-results-search">{valueInputSearch}</span>)
                            </p>
                        </li>
                    {/each}
                </ul>
            </div>
        </div>
    </div>
</div>