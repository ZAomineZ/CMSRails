<script>
    import CategoryRow from "./CategoryRow.svelte";

    // PROPS
    export let categories_last_4 = []
    export let categories_last_6 = []
</script>

<div class="view-front">
    <div class="row">
        <div class="block-row">
            {#each categories_last_4 as category}
                <CategoryRow category={category}/>
            {/each}
            <div class="block-right"></div>
            <div class="row">
                <div class="block-row">
                    {#each categories_last_6 as category}
                        <CategoryRow category={category}/>
                    {/each}
                </div>
            </div>
        </div>
    </div>
</div>