<script>
    export let pages = 1
    export let current_page = 1
</script>

<nav aria-label="Pagination">
    <ul class="pagination">
        <li class="page-item">
            <a class="page-link" data-page={current_page - 1} href="#" on:click|preventDefault>Previous</a>
        </li>
        {#each Array(pages) as _, i}
            <li class="page-item active">
                <a href="#" class="page-link" on:click|preventDefault data-page={i + 1}>{i + 1}</a>
            </li>
        {/each}
        <li class="page-item">
            <a class="page-link" data-page={current_page + 1} href="#" on:click|preventDefault>Next</a>
        </li>
    </ul>
</nav>