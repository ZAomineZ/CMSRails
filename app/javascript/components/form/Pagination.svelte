<script>
    export let pages = 1
    export let currentPage = 1
</script>

<nav aria-label="Pagination">
    <ul class="pagination">
        {#if currentPage !== 1}
            <li class="page-item">
                <a class="page-link" data-page={currentPage - 1} href="#" on:click|preventDefault>Previous</a>
            </li>
        {/if}
        {#each Array(pages) as _, i}
            <li class="{currentPage === (i + 1) ? 'page-item active' : 'page-item'}">
                <a href="#" class="page-link" on:click|preventDefault data-page={i + 1}>{i + 1}</a>
            </li>
        {/each}
        {#if currentPage !== pages}
            <li class="page-item">
                <a class="page-link" data-page={currentPage + 1} href="#" on:click|preventDefault>Next</a>
            </li>
        {/if}
    </ul>
</nav>